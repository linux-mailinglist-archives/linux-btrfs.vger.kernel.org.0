Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B104C2F8C14
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Jan 2021 08:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbhAPHkg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Jan 2021 02:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbhAPHkf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Jan 2021 02:40:35 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5DBC061757
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jan 2021 23:39:55 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id a12so16632410lfl.6
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jan 2021 23:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XoiM4ecB1QgvcdLUV/9jgk42vnfgyH+qg88CbsAfZIE=;
        b=imwsieIIQAQ+PJ/ilxOEQa03RmFPGVX5W5/JnnNRxM5Pcv70YGhTLGhKyua56zT8Pn
         +WmLgk1yjy2NRNfT3jwJ6y/mzRYc379OkNhq+HarGCfd9LreL8H3ocpErH0b/HJOz+eQ
         UfKQ2YszvXbjbSWqnW97bHWgnHhUOloULPi9nyyopAa/jajUV+6Y67VLWvv1haCxWvRm
         xI6+1ur5NsVH3igyk3u+0pGYkNcu3vgmcPVVaviWI6U7WhhhaYwN4uIO4sg3tn/7B0hw
         X/SCjDvZ7TrSdjFxulRfHZPXwmXPDY4YgKFx9U7Po5r9+X4qXnzYlCP64Y1loIJyDOR9
         KsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XoiM4ecB1QgvcdLUV/9jgk42vnfgyH+qg88CbsAfZIE=;
        b=iMTYYd4VltIfbO1MD+bm+0CE8UshJy6sS8Gxd6reE+dYVBgDNEIeG3KXLvgA6oyUMl
         DHXoLUEkts7SAvM2ECJEIT292jxDbEAnr9gWoAoNVTyia3LMgHJL0k8bU7zHbkQpo7Ts
         DRtPCFWYEZ+9bI/qaRlrwyjXkxsH4xPxSasV4Inym4p83xOE8okWlil0hGYZzsyul+7O
         jcNb7vJO+fJMb56PeoQqhm4oEWN5vqS2hXXzCQOBGnoyMnZWHYebPREjvUyuKU6Py+vG
         nhagz5Vjf9KJCRVl6YnRE00P3S5jpVs2gCjNz0Vyb37q12Xbzcg2UB6i2WGZCP32YuKk
         1eTg==
X-Gm-Message-State: AOAM5302bgNKvkUANZTieS0dFL4YT/uysP8HCoRvx7NdTkdSiR8q2QOm
        ax39T/L2Ec3RRV0XQ98+y4w+iVPN0ZRFgg==
X-Google-Smtp-Source: ABdhPJz8zwYdIW5XYhcFXlDYAhPDjycZiifLRJC/7GGZB6fexn4ApTpGojsE0GwlOdKlFgcW0GCqoA==
X-Received: by 2002:a05:6512:2103:: with SMTP id q3mr6997185lfr.404.1610782793355;
        Fri, 15 Jan 2021 23:39:53 -0800 (PST)
Received: from ?IPv6:2a00:1370:812d:ecb3:590f:aaab:50ba:573b? ([2a00:1370:812d:ecb3:590f:aaab:50ba:573b])
        by smtp.gmail.com with ESMTPSA id 187sm1181568lfo.16.2021.01.15.23.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 23:39:52 -0800 (PST)
Subject: Re: Why do we need these mount options?
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>, dsterba@suse.cz,
        waxhead <waxhead@dirtcellar.net>, linux-btrfs@vger.kernel.org
References: <208dba68-b47e-101d-c893-8173df8fbbbf@dirtcellar.net>
 <20210114163729.GY6430@twin.jikos.cz> <20210115035448.GD31381@hungrycats.org>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Autocrypt: addr=arvidjaar@gmail.com; prefer-encrypt=mutual; keydata=
 mQGiBDxiRwwRBAC3CN9wdwpVEqUGmSoqF8tWVIT4P/bLCSZLkinSZ2drsblKpdG7x+guxwts
 +LgI8qjf/q5Lah1TwOqzDvjHYJ1wbBauxZ03nDzSLUhD4Ms1IsqlIwyTLumQs4vcQdvLxjFs
 G70aDglgUSBogtaIEsiYZXl4X0j3L9fVstuz4/wXtwCg1cN/yv/eBC0tkcM1nsJXQrC5Ay8D
 /1aA5qPticLBpmEBxqkf0EMHuzyrFlqVw1tUjZ+Ep2LMlem8malPvfdZKEZ71W1a/XbRn8FE
 SOp0tUa5GwdoDXgEp1CJUn+WLurR0KPDf01E4j/PHHAoABgrqcOTcIVoNpv2gNiBySVsNGzF
 XTeY/Yd6vQclkqjBYONGN3r9R8bWA/0Y1j4XK61qjowRk3Iy8sBggM3PmmNRUJYgroerpcAr
 2byz6wTsb3U7OzUZ1Llgisk5Qum0RN77m3I37FXlIhCmSEY7KZVzGNW3blugLHcfw/HuCB7R
 1w5qiLWKK6eCQHL+BZwiU8hX3dtTq9d7WhRW5nsVPEaPqudQfMSi/Ux1kbQmQW5kcmV5IEJv
 cnplbmtvdiA8YXJ2aWRqYWFyQGdtYWlsLmNvbT6IYAQTEQIAIAUCSXs6NQIbAwYLCQgHAwIE
 FQIIAwQWAgMBAh4BAheAAAoJEEeizLraXfeMLOYAnj4ovpka+mXNzImeYCd5LqW5to8FAJ4v
 P4IW+Ic7eYXxCLM7/zm9YMUVbrQmQW5kcmVpIEJvcnplbmtvdiA8YXJ2aWRqYWFyQGdtYWls
 LmNvbT6IZQQTEQIAJQIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AFAliWAiQCGQEACgkQ
 R6LMutpd94wFGwCeNuQnMDxve/Fo3EvYIkAOn+zE21cAnRCQTXd1hTgcRHfpArEd/Rcb5+Sc
 uQENBDxiRyQQBACQtME33UHfFOCApLki4kLFrIw15A5asua10jm5It+hxzI9jDR9/bNEKDTK
 SciHnM7aRUggLwTt+6CXkMy8an+tVqGL/MvDc4/RKKlZxj39xP7wVXdt8y1ciY4ZqqZf3tmm
 SN9DlLcZJIOT82DaJZuvr7UJ7rLzBFbAUh4yRKaNnwADBwQAjNvMr/KBcGsV/UvxZSm/mdpv
 UPtcw9qmbxCrqFQoB6TmoZ7F6wp/rL3TkQ5UElPRgsG12+Dk9GgRhnnxTHCFgN1qTiZNX4YI
 FpNrd0au3W/Xko79L0c4/49ten5OrFI/psx53fhYvLYfkJnc62h8hiNeM6kqYa/x0BEddu92
 ZG6IRgQYEQIABgUCPGJHJAAKCRBHosy62l33jMhdAJ48P7WDvKLQQ5MKnn2D/TI337uA/gCg
 n5mnvm4SBctbhaSBgckRmgSxfwQ=
Message-ID: <94a65b16-3a23-6862-9de6-169620302308@gmail.com>
Date:   Sat, 16 Jan 2021 10:39:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210115035448.GD31381@hungrycats.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

15.01.2021 06:54, Zygo Blaxell пишет:
> 
> On the other hand, I'm in favor of deprecating the whole discard option
> and going with fstrim instead.  discard in its current form tends to
> increase write wear rather than decrease it, especially on metadata-heavy
> workloads.  discard is roughly equivalent to running fstrim thousands
> of times a day, which is clearly bad for many (most?  all?) SSDs.
> 

My (probably naive) understanding so far was that trim on SSD marks
areas as "unused" which means SSD need to copy less residual data from
erase block when reusing it. Assuming TRIM unit is (significantly)
smaller than erase block.

I would appreciate if you elaborate how trim results in more write on SSD?

Or do you mean more writes from btrfs while performing discard?
