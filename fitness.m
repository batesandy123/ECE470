function [ fit ] = fitness( variables, manual_year )
%fitness Summary of this function goes here
%   Detailed explanation goes here

last_train_year = 2015;
first_train_year = 2010;
year = randi(last_train_year + 1 - first_train_year) + first_train_year;

training_file;
winners_file;
nargin
if nargin < 2
    training_file = 'our_data/training/' + string(year) + '_data.csv'
else
    
end

team_stats = csvread(training_file, 2, 1);
team_scores = variables * team_stats;

winners = csvread('our_data/winners/' + string(year) + '_bracket.csv', 7, 0);

our_results = [];

still_in = [1:64];
our_results = [our_results; still_in];

for k = 1:6
    
    bounds = (64/(2^k));
    one = still_in(1:2:end);
    two = still_in(2:2:end);
    for j = 1:bounds

        if(team_scores(one(j)) > team_scores(two(j)))
           two(j) = 0;
        else
           one(j) = 0;
        end
    end
    still_in = sort([one two]);
    still_in = still_in((end-bounds+1):end);
    %To make the lists the same size
    still_in(64) = 0;
    our_results = [our_results; still_in];
end

total = 0;
%fprintf("Done");
for k = 2:7
    matches = intersect(our_results(k,:), winners(k,:));
    matches_corr = length(matches) - 1;
    percent = matches_corr/(2^(7-k));
    total = total + (percent*(64/(2^(k-1)))^(k-1));
    
    %k
    %percent
    %total
end
fit = 1289/total
end