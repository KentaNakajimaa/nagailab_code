function [data,reaction] = under_sampling(data,reaction)
    label = unique(reaction);
    reaction_low = find(reaction == label(1));
    reaction_high = find(reaction == label(2));
    
    small_reaction = (length(reaction_low)<=length(reaction_high))*length(reaction_low) + (length(reaction_low)>length(reaction_high))*length(reaction_high);
    large_reaction = (length(reaction_low)>=length(reaction_high))*length(reaction_low) + (length(reaction_low)<length(reaction_high))*length(reaction_high);
    rand_reaction = randperm(large_reaction);
    rand_reaction = rand_reaction(1:small_reaction);
    if length(reaction_low) == large_reaction
        reaction_low = reaction_low(rand_reaction);
    else
        reaction_high = reaction_high(rand_reaction);
    end
    reaction = reaction(cat(1,reaction_high, reaction_low));
    data = data(cat(1,reaction_high, reaction_low),:);
    
end