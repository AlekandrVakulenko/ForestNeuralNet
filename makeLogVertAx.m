function stop = makeLogVertAx(state, whichAx)
stop = false; % The function has to return a value.
% Only do this once, following the 1st iteration
if state.Iteration == 1
    % Get handles to "Training Progress" figures:
    hF  = findall(0,'type','figure','Tag','NNET_CNN_TRAININGPLOT_FIGURE');
    % Assume the latest figure (first result) is the one we want, and get its axes:
    hAx = findall(hF(1),'type','Axes');
    % Remove all irrelevant entries (identified by having an empty "Tag", R2018a)
    hAx = hAx(~cellfun(@isempty,{hAx.Tag}));
    set(hAx(whichAx),'YScale','log');
end

% Output functions to call during training, specified as the comma-separated pair consisting of 'OutputFcn' and a function handle or cell array of function handles. trainNetwork calls the specified functions once before the start of training, after each iteration, and once after training has finished. trainNetwork passes a structure containing information in the following fields:
% 
% Field -	Description:
% 
% Epoch -	Current epoch number
% Iteration -	Current iteration number
% TimeSinceStart -	Time in seconds since the start of training
% TrainingLoss -	Current mini-batch loss
% ValidationLoss -	Loss on the validation data
% BaseLearnRate -	Current base learning rate
% TrainingAccuracy -	Accuracy on the current mini-batch (classification networks)
% TrainingRMSE -	RMSE on the current mini-batch (regression networks)
% ValidationAccuracy -	Accuracy on the validation data (classification networks)
% ValidationRMSE -	RMSE on the validation data (regression networks)
% State -	Current training state, with a possible value of "start", "iteration", or "done"
% 
% If a field is not calculated or relevant for a certain call to the output functions, then that field contains an empty array.
% 
% You can use output functions to display or plot progress information, or to stop training. To stop training early, make your output function return true. If any output function returns true, then training finishes and trainNetwork returns the latest network. For an example showing how to use output functions, see Customize Output During Deep Learning Network Training.
% 
% Data Types: function_handle | cell
% 
