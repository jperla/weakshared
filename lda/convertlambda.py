#!/usr/bin/env python
import sys
from itertools import izip

if __name__ == '__main__':
    vocabfile = sys.argv[1]
    lambdafile = sys.argv[2]
    output = sys.argv[3]
    num_words = 20

    print '%s words per topic' % num_words

    top_words = list()
    for topic in open(lambdafile):
        topic = topic.strip('\r\n')
        topic_proportions = topic.split(",")
        
        # Kept sorted
        top_proportions = list()
        top_ids = list()
        ids = 0
        
        for p in topic_proportions:
           
            # Handlees the empty string
            if len(p) == 0:
                continue
            proportion = float(p)
            if (len(top_ids) < num_words or top_proportions[num_words - 1] < proportion):
                r = 0
                while (r < len(top_ids) and top_proportions[r] > proportion):
                    r += 1
                top_ids.insert(r, ids)
                top_proportions.insert(r, proportion)

                if (len(top_ids) > num_words):
                    top_ids.pop()
                    top_proportions.pop()
            ids += 1
        print top_proportions
        top_words.append(top_ids)

    # Read the dictionary
    words = list()
    for w in open(vocabfile):
        words.append(w)

    outfile = open(output, 'w')
    
    topic_num = 0
    for t in top_words:
        outfile.write("Topic: " + str(topic_num) + "\n")
        for word_id in t:
            outfile.write("\t" + words[word_id])
        topic_num = topic_num + 1
    outfile.close()
