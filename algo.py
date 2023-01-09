import numpy as np
import pandas as pd
from sklearn.metrics.pairwise import cosine_similarity

def get_recommendations(user_id, df, num_recommendations):
    # Get the user's ratings for books
    user_ratings = df[df['user_id'] == user_id]
    
    # Get the books the user has not rated
    unrated_books = df[~df['book_id'].isin(user_ratings['book_id'])]
    
    # Create a pivot table of the user's ratings
    pivot = user_ratings.pivot_table(index='book_id', columns='user_id', values='rating')
    
    # Get the cosine similarity between the pivot table and itself
    similarity = cosine_similarity(pivot, pivot)
    
    # Map the similarity to the unrated books
    similarity_map = pd.DataFrame(similarity, index=pivot.index, columns=pivot.index)
    
    # Get the top N most similar books to the pivot
    top_n = similarity_map[unrated_books['book_id']].sort_values(user_id, ascending=False).head(num_recommendations)
    
    # Get the top N most similar books' titles
    top_n_titles = pd.merge(top_n, books, on='book_id')['title']
    
    return top_n_titles
