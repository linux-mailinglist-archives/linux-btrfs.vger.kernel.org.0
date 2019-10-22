Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6858FE0475
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 15:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731716AbfJVNE1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 09:04:27 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:36348 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729696AbfJVNE1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 09:04:27 -0400
Received: by mail-il1-f194.google.com with SMTP id s75so5567242ilc.3
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2019 06:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NRNgXpehzPGhrLhy43Sb36raWC96QLiskziDpOvrwFQ=;
        b=XFuR6rfapEN08nvspCWt20l3JdSxk9pyh3N7w9CHdD9gjda1jKKaUxzwYidJZR9Tpo
         GZKcFc9PerTRKRdkd/EzZlKrSUrTUGU4vuHICmXCWMUOAjCdzQKWSSgBrahY/2m9KO+S
         TBvsdwpvpuIjJCd35E7X9pKvaYe2bmw3zrO/Ra0Z2l47MRwaBSgOAO3mEZmapiuEcMe3
         wdxQj6gwg40G4ZYHRQTs3wvpooyldrmFJ9oPYLs95OK8I0aEPyZOSPmY8NVyr0enGg9Z
         pwIhd9nBO44bToZCMqMD9qD5l/lCQZo+twy+EWfOY27unB4uwCosExtGZfi0fukoiO4b
         czQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NRNgXpehzPGhrLhy43Sb36raWC96QLiskziDpOvrwFQ=;
        b=LaWrabIIzb1+JJF/lj8sjs8XsvcFNAHY5jx6+tb/G/OOkuVzPH0wlbJlp2JJeHYtFT
         VJ7oACiVjaDaDsBDPETGOevbRhsqoUeaOJg4eO7vms+gLcIy718Wv6Hl3DDMDUTSjxPi
         W9x9tuJ2gsbrbu7T71vx+P0jue8hT265LKq26JBJw4wFd1VdE8S8hAqh2vKII+pybd7Q
         GTBzPmXX/S1VjdBH6QZwfj88o9zJAGjSksHQmV4GNxDhv7qRLNetR08+GPVAcGRoTU1P
         si8cX6rqIbM+Io8hLr2YZOnearfP7BIXEoLYqI98QLd7pm1xkq84XT2tNQgqPgtW4R8b
         cFew==
X-Gm-Message-State: APjAAAWMVizi8VzTQqk+AdwKlgeec1iwH6mNfsaq1RJ7XDNMZLhjB2R7
        Mof+le6eRWZAyDYUqqP7PWE=
X-Google-Smtp-Source: APXvYqzLx3GiU/fkeTrDfht1qI7hw1dSE2WdiIbnNJbzhtsZIdctWhre8sej4c6OpipezlhLrVbS8Q==
X-Received: by 2002:a92:1696:: with SMTP id 22mr2385280ilw.243.1571749464080;
        Tue, 22 Oct 2019 06:04:24 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id o189sm279187iof.42.2019.10.22.06.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2019 06:04:23 -0700 (PDT)
Subject: Re: Effect of punching holes
To:     Tobias Reinhard <trtracer@gmail.com>, linux-btrfs@vger.kernel.org
References: <2b75abb1-4dd8-1da4-77be-7557ff53ec75@gmail.com>
 <67354156-286a-f80e-ebc3-99c32e356fac@gmx.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <d3658060-83ee-c9c2-52b2-95d60d1ac0ca@gmail.com>
Date:   Tue, 22 Oct 2019 09:04:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <67354156-286a-f80e-ebc3-99c32e356fac@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-10-22 06:01, Qu Wenruo wrote:
> 
> 
> On 2019/10/22 下午5:47, Tobias Reinhard wrote:
>> Hi,
>>
>>
>> I noticed that if you punch a hole in the middle of a file the available
>> filesystem space seems not to increase.
>>
>> Kernel is 5.2.11
>>
>> To reproduce:
>>
>> ->mkfs.btrfs /dev/loop1 -f
>>
>> btrfs-progs v4.15.1
>> See http://btrfs.wiki.kernel.org for more information.
>>
>> Detected a SSD, turning off metadata duplication.  Mkfs with -m dup if
>> you want to force metadata duplication.
>> Label:              (null)
>> UUID:               415e925a-588a-4b8f-bdc7-c30a4a0f5587
>> Node size:          16384
>> Sector size:        4096
>> Filesystem size:    1.00GiB
>> Block group profiles:
>>    Data:             single            8.00MiB
>>    Metadata:         single            8.00MiB
>>    System:           single            4.00MiB
>> SSD detected:       yes
>> Incompat features:  extref, skinny-metadata
>> Number of devices:  1
>> Devices:
>>     ID        SIZE  PATH
>>      1     1.00GiB  /dev/loop1
>>
>> ->mount /dev/loop1 /srv/btrtest2
>>
>> ->for i in $(seq 1 20); do dd if=/dev/urandom of=test$i bs=16M count=4 ;
>> sync ; fallocate -p -o 4096 -l 67100672 test$i && sync ; done
>>
>> this failed from the 16th file on because of no space left
> 
> Btrfs doesn't free the space until all space of a data extent get freed.
> 
> In your case, your hole punch is [4k, 64M-4K), thus the 64M extent still
> has 4K being used.
> So the data extent won't be freed until you free the last 4K.
> 
>>
>> ->df -T .
>> Filesystem     Type  1K-blocks   Used Available Use% Mounted on
>> /dev/loop1     btrfs   1048576 935856      2272 100% /srv/btrtest2
>>
>> ->btrfs fi du .
>>       Total   Exclusive  Set shared  Filename
>>     8.00KiB     8.00KiB           -  ./test1
>>     8.00KiB     8.00KiB           -  ./test2
>>     8.00KiB     8.00KiB           -  ./test3
>>     8.00KiB     8.00KiB           -  ./test4
>>     8.00KiB     8.00KiB           -  ./test5
>>     8.00KiB     8.00KiB           -  ./test6
>>     8.00KiB     8.00KiB           -  ./test7
>>     8.00KiB     8.00KiB           -  ./test8
>>     8.00KiB     8.00KiB           -  ./test9
>>     8.00KiB     8.00KiB           -  ./test10
>>     8.00KiB     8.00KiB           -  ./test11
>>     8.00KiB     8.00KiB           -  ./test12
>>     8.00KiB     8.00KiB           -  ./test13
>>     8.00KiB     8.00KiB           -  ./test14
>>     8.00KiB     8.00KiB           -  ./test15
>>     4.00KiB     4.00KiB           -  ./test16
>>     4.00KiB     4.00KiB           -  ./test17
>>     4.00KiB     4.00KiB           -  ./test18
>>     4.00KiB     4.00KiB           -  ./test19
>>     4.00KiB     4.00KiB           -  ./test20
>>   140.00KiB   140.00KiB       0.00B  .
>>
>> When doing this on XFS or EXT4 it works as expected:
>>
>> Filesystem     Type 1K-blocks  Used Available Use% Mounted on
>> /dev/loop1     ext4    999320  2764    927744   1% /srv/btrtest
>> /dev/loop2     xfs    1038336 40456    997880   4% /srv/xfstest
>>
>> How to i reclaim the space on BTRFS? Defrag does not seem to help.
> 
> Rewrite the remaining 4K.
> 
> Then the new write 4K will be cowed into a new 4K extent, the old large
> 64M extent gets fully freed and free space.

Expanding on this a bit, defrag isn't working here because it doesn't, 
by default, touch extents larger than 32M in size.  You should be able 
to make it work by using the `-t` option with a size larger than 64M.

Alternatively, use `cp --reflink=never --sparse=always` to copy the file 
and then rename the copy over the original.  This will use more space, 
but is likely to be significantly faster than a defrag.
