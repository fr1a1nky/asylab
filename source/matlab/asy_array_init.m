function array = asy_array_init(C)
    array = '{';
    for index = 1:numel(C)
        if index > 1
            array = [array ', '];
        end
        array = [array C{index}];
    end
    array = [array '}'];
end