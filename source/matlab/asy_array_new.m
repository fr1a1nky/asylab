function array = asy_array_new(type, C)
    array = ['new ' type '[] {'];
    for index = 1:numel(C)
        if index > 1
            array = [array ', '];
        end
        if iscell(C)
            array = [array C{index}];
        else
            array = [array sprintf('%g', C(index))];
        end
    end
    array = [array '}'];
end