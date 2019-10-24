Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F916E3BC7
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 21:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406494AbfJXTES (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Oct 2019 15:04:18 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:42482 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406423AbfJXTER (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Oct 2019 15:04:17 -0400
Received: by mail-il1-f195.google.com with SMTP id o16so15348722ilq.9
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2019 12:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1ZwYrEdD8OV5YdwSEL/EHnTtk2FXEAjhN0FsAWyevCk=;
        b=TQobsM1Bb8il+5o/ggYniTbDQgsNlQ3vwPiyZTUvfRKvsrrLzCpznDfHZJ7kJgX/WD
         l6xkNwRkPUc4s9gayg1CNqehXeXWqy6ADgcYDbJ6L4YUqIN3fpk/weJXQaJ5Tqq+T/hQ
         eQuoeIWxKbvGuY/MKEpg+FwKkaXFh6MvF0UYfMiygOgmIOXItzZteFIb4O6Nfhkw0+DG
         gpM9fxq6DTHzNJjndydcFL5G3qd4E2GqGBrNNL6nmvWsqcIh5wXJJGpKZ4EQOMNV2f5t
         KDjXdaS91ok4otcTFSaeafK/7cxEMjDxyxIQ0PtpEt8YFEXPfBd7aXZFz3rGjTyS9fVV
         PygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1ZwYrEdD8OV5YdwSEL/EHnTtk2FXEAjhN0FsAWyevCk=;
        b=peBB3Dm0SfMj2khP9P3volTyk8VzT1jAGamXugRWFnkSU+I4DPmcIbYuhpHhTGfFHL
         J1QgYdktv1Ou5D25Reki51rvpGLzi46CrpiZp9awc5gnQWLHtz3I34l01MKHHGQjJG6X
         sOCKfA+c95XXmhBfNEF4JuRGo3yrVZ6S89SX6FSA46RQE8GOGGBhifx744JwWmj+5y5r
         2hWhTMVX5B3wInloODDPHWWY42/VvLfnZmomcKlkAd8R4r6F1/+y/cxBpJ6RNVUZZpmw
         MdzM8SsZnOPAkH4DNBBH+RYdwdT2JuIJqjMWLiEu9ID0LwQ0e09CQFgOjsPD4iTt5Jwa
         OvDw==
X-Gm-Message-State: APjAAAVE3WnrYzcjA3ohq3kDrgqECThWrDgYUiLrhAWM9oxMF2DRZJK4
        tgBGLuhn+YrFOHXLywGgN4A=
X-Google-Smtp-Source: APXvYqzpUwEw2vfK19ZLlhg+LfjJde65ezKikbDuJJnyZvnKJXSRkanMDGUaOyvC34zR8hwXaHH5/A==
X-Received: by 2002:a92:461d:: with SMTP id t29mr18341663ila.100.1571943856710;
        Thu, 24 Oct 2019 12:04:16 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id r9sm7571913ioc.48.2019.10.24.12.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 12:04:16 -0700 (PDT)
Subject: Re: Effect of punching holes
To:     Tobias Reinhard <trtracer@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <2b75abb1-4dd8-1da4-77be-7557ff53ec75@gmail.com>
 <67354156-286a-f80e-ebc3-99c32e356fac@gmx.com>
 <d3658060-83ee-c9c2-52b2-95d60d1ac0ca@gmail.com>
 <f082e863-de9e-2dcc-0b9a-e4ff91cb3701@gmail.com>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <5996737b-ce7e-4e9c-a85e-ab611621a2e6@gmail.com>
Date:   Thu, 24 Oct 2019 15:04:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <f082e863-de9e-2dcc-0b9a-e4ff91cb3701@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-10-24 14:52, Tobias Reinhard wrote:
> Am Di., 22. Okt. 2019 um 15:04 Uhr schrieb Austin S. Hemmelgarn 
> <ahferroin7@gmail.com <mailto:ahferroin7@gmail.com>>:
> 
>     On 2019-10-22 06:01, Qu Wenruo wrote:
>      >
>      >
>      > On 2019/10/22 下午5:47, Tobias Reinhard wrote:
>      >> Hi,
>      >>
>      >>
>      >> I noticed that if you punch a hole in the middle of a file the
>     available
>      >> filesystem space seems not to increase.
>      >>
>      >> Kernel is 5.2.11
>      >>
>      >> To reproduce:
>      >>
>      >> ->mkfs.btrfs /dev/loop1 -f
>      >>
>      >> btrfs-progs v4.15.1
>      >> See http://btrfs.wiki.kernel.org for more information.
>      >>
>      >> Detected a SSD, turning off metadata duplication.  Mkfs with -m
>     dup if
>      >> you want to force metadata duplication.
>      >> Label:              (null)
>      >> UUID: 415e925a-588a-4b8f-bdc7-c30a4a0f5587
>      >> Node size:          16384
>      >> Sector size:        4096
>      >> Filesystem size:    1.00GiB
>      >> Block group profiles:
>      >>    Data:             single            8.00MiB
>      >>    Metadata:         single            8.00MiB
>      >>    System:           single            4.00MiB
>      >> SSD detected:       yes
>      >> Incompat features:  extref, skinny-metadata
>      >> Number of devices:  1
>      >> Devices:
>      >>     ID        SIZE  PATH
>      >>      1     1.00GiB  /dev/loop1
>      >>
>      >> ->mount /dev/loop1 /srv/btrtest2
>      >>
>      >> ->for i in $(seq 1 20); do dd if=/dev/urandom of=test$i bs=16M
>     count=4 ;
>      >> sync ; fallocate -p -o 4096 -l 67100672 test$i && sync ; done
>      >>
>      >> this failed from the 16th file on because of no space left
>      >
>      > Btrfs doesn't free the space until all space of a data extent get
>     freed.
>      >
>      > In your case, your hole punch is [4k, 64M-4K), thus the 64M
>     extent still
>      > has 4K being used.
>      > So the data extent won't be freed until you free the last 4K.
>      >
>      >>
>      >> ->df -T .
>      >> Filesystem     Type  1K-blocks   Used Available Use% Mounted on
>      >> /dev/loop1     btrfs   1048576 935856      2272 100% /srv/btrtest2
>      >>
>      >> ->btrfs fi du .
>      >>       Total   Exclusive  Set shared  Filename
>      >>     8.00KiB     8.00KiB           -  ./test1
>      >>     8.00KiB     8.00KiB           -  ./test2
>      >>     8.00KiB     8.00KiB           -  ./test3
>      >>     8.00KiB     8.00KiB           -  ./test4
>      >>     8.00KiB     8.00KiB           -  ./test5
>      >>     8.00KiB     8.00KiB           -  ./test6
>      >>     8.00KiB     8.00KiB           -  ./test7
>      >>     8.00KiB     8.00KiB           -  ./test8
>      >>     8.00KiB     8.00KiB           -  ./test9
>      >>     8.00KiB     8.00KiB           -  ./test10
>      >>     8.00KiB     8.00KiB           -  ./test11
>      >>     8.00KiB     8.00KiB           -  ./test12
>      >>     8.00KiB     8.00KiB           -  ./test13
>      >>     8.00KiB     8.00KiB           -  ./test14
>      >>     8.00KiB     8.00KiB           -  ./test15
>      >>     4.00KiB     4.00KiB           -  ./test16
>      >>     4.00KiB     4.00KiB           -  ./test17
>      >>     4.00KiB     4.00KiB           -  ./test18
>      >>     4.00KiB     4.00KiB           -  ./test19
>      >>     4.00KiB     4.00KiB           -  ./test20
>      >>   140.00KiB   140.00KiB       0.00B  .
>      >>
>      >> When doing this on XFS or EXT4 it works as expected:
>      >>
>      >> Filesystem     Type 1K-blocks  Used Available Use% Mounted on
>      >> /dev/loop1     ext4    999320  2764    927744   1% /srv/btrtest
>      >> /dev/loop2     xfs    1038336 40456    997880   4% /srv/xfstest
>      >>
>      >> How to i reclaim the space on BTRFS? Defrag does not seem to help.
>      >
>      > Rewrite the remaining 4K.
>      >
>      > Then the new write 4K will be cowed into a new 4K extent, the old
>     large
>      > 64M extent gets fully freed and free space.
> 
>     Expanding on this a bit, defrag isn't working here because it doesn't,
>     by default, touch extents larger than 32M in size.  You should be able
>     to make it work by using the `-t` option with a size larger than 64M.
> 
>     Alternatively, use `cp --reflink=never --sparse=always` to copy the
>     file
>     and then rename the copy over the original.  This will use more space,
>     but is likely to be significantly faster than a defrag.
> 
> (sorry - for first bad formated post)
> 
> Hi,
> 
> I can't get the defrag way to work.
> 
> What is the right command to do it?
> 
> ->df -hT .
> Filesystem     Type   Size  Used Avail Use% Mounted on
> /dev/loop1     btrfs  1,0G  868M   49M  95% /srv/btrtest2
> 
> ->btrfs fi du .
>       Total   Exclusive  Set shared  Filename
>       0.00B       0.00B           -  ./runtest.sh
>     8.00KiB     8.00KiB           -  ./test1
>     8.00KiB     8.00KiB           -  ./test2
>     8.00KiB     8.00KiB           -  ./test3
>     8.00KiB     8.00KiB           -  ./test4
>     8.00KiB     8.00KiB           -  ./test5
>     8.00KiB     8.00KiB           -  ./test6
>     8.00KiB     8.00KiB           -  ./test7
>     8.00KiB     8.00KiB           -  ./test8
>     8.00KiB     8.00KiB           -  ./test9
>     8.00KiB     8.00KiB           -  ./test10
>     8.00KiB     8.00KiB           -  ./test11
>     8.00KiB     8.00KiB           -  ./test12
>     8.00KiB     8.00KiB           -  ./test13
>     8.00KiB     8.00KiB           -  ./test14
>     8.00KiB     8.00KiB           -  ./test15
>   120.00KiB   120.00KiB       0.00B  .
> -> btrfs fi de -t 128M *
> -> sync
> -> df -hT .
> Filesystem     Type   Size  Used Avail Use% Mounted on
> /dev/loop1     btrfs  1,0G  868M   49M  95% /srv/btrtest2

That's odd, what you used _should_ do it.  For some reason, it's not 
trying to rewrite things at all.  In cases like this, you can force it 
to rewrite the data by telling it to compress the file using a different 
algorithm than whatever you have specified via mount options (or just 
compress it at all if you don't have compression enabled for the mount) 
and then re-defraging it with the original compression type.
