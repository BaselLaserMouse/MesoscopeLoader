function toolbox_setup()
    % TOOLBOX_SETUP download and setup dependencies, and configure the path
    %
    % toolbox_setup()
    %
    % This function will create a third-party folder and download there
    % the toolbox dependencies. It will also configure your Matlab path.

    % add toolbox examples and source directories to the path
    toolbox_folder = fileparts(mfilename('fullpath'));
    addpath(genpath(fullfile(toolbox_folder, 'src')));

    % create a folder for third-party packages
    thirdparty_folder = fullfile(toolbox_folder, 'thirdparty');
    if ~isdir(thirdparty_folder)
        mkdir(thirdparty_folder);
    end

    % check that GIT is available
    [cmd_result, ~] = system('git --help');
    if cmd_result ~= 0
        error('GIT is required, please install it and rerun this function.');
    end

    % retrieve core data structures
    gitget('https://github.com/DylanMuir/TIFFStack', thirdparty_folder);
    gitget('https://github.com/DylanMuir/MappedTensor', thirdparty_folder);
    gitget('https://github.com/DylanMuir/TensorStack', thirdparty_folder);
    gitget('https://bitbucket.org/lasermouse/TensorView', thirdparty_folder);

    % retrieve misc. dependencies
    uipick_folder = fullfile(thirdparty_folder, 'uipickfiles');
    matget(['http://www.mathworks.com/matlabcentral/mlc-downloads/', ...
            'downloads/submissions/10867/versions/14/download/zip'], ...
           uipick_folder);
end

function repo_folder = gitget(repo, thirdparty_folder)
    % clone or pull a git repository, depending if it exists

    [~, repo_name] = fileparts(repo);
    repo_folder = fullfile(thirdparty_folder, repo_name);

    % clone if repo doesn't exist
    if ~isdir(repo_folder)
        fprintf('### Installing %s ###\n', repo_name);
        cmd_str = sprintf('git clone %s %s', repo, repo_folder);
        system(cmd_str, '-echo');

    % pull (= update) otherwise
    else
        fprintf('### Updating %s ###\n', repo_name);
        wd = cd(repo_folder);
        system('git pull', '-echo');
        cd(wd);
    end

    % add repo to the path
    addpath(repo_folder);
end

function matget(url, folder)
    % retrieve and unzip an online archive, if necessary
    [~, toolname] = fileparts(folder);
    if ~isdir(folder)
        fprintf('### Installing %s ###\n', toolname);
        unzip(url, folder);
    else
        fprintf('### %s already installed ###\n', toolname);
    end
    addpath(folder)
end