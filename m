Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F75BE3B59
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 20:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440151AbfJXSwu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Oct 2019 14:52:50 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40888 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406463AbfJXSwu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Oct 2019 14:52:50 -0400
Received: by mail-ed1-f68.google.com with SMTP id p59so11050467edp.7
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2019 11:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Acf1/z/sNUtrm+54Ee/H/wJL4+97NHaIMKGKbWoaoKo=;
        b=WIZY2ahdR14adNvl1PvAkpFatU3wKTW/O89WgwyuJtuR5wNmxvc8t8HRAvbMgB7EJG
         AVPHCkv2p434MOcYsnCngH1lipYt70/mZ4qMXjWbY8DkKnn2BRBPaCECxxov5BO2t/gh
         DQ7UFEgeIegpoqyhWQ3aFajTgYcJua+vXvvvVrXUtj080fe56Cc7L/Te480KertO+Yun
         g16i8moYGM5EhnBA09vyhKEYNrYXXhMH6K5OtzFxkwtEJN6UuLGYms4wbyvvmGGDINiq
         yayPmFY9Z1Hw8F3AmDzxHdEVXxZ6fIEnwMesphfvEtV7BBGArmi/dzfbr9anPhkKRGpN
         zUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Acf1/z/sNUtrm+54Ee/H/wJL4+97NHaIMKGKbWoaoKo=;
        b=uTnVv0628Iko00sABG0iSRoHWUj7FZYc7D3LNtHgfsXn73hl7IC6cqqMCMvUr0IRvV
         Dhz7GNEQv2/OzIMBmW1sTEcJnhcTOqc52vhOe9GWi1RWB/yhzOLA3GleOLWROAZYlA5F
         qB6nsCb6hj2TI4a7X86V5wzIGl0FW5UZNIeX9AJY1v8Kye8JjpwcklJTAfsP1XaDtSqR
         tlKURAb0q1K4iT3r+X69dzdwbyuVw1zudAkQPgkTY5+72jkHkSg1XTr8bIoXGC8pjiL+
         q+3NlZy1ZYQEk7tIEnLMhtQkI6KNYxDZZVNcIPvT0Qtt/YvS5Glj0V2uW0sXlZO8srQG
         ojXw==
X-Gm-Message-State: APjAAAUlrpd4uAKg51CiK9ygHpNM2M9SMNf9I4H7yU76hsIHct43i1Qq
        +JgCMJc5bW8jRiWUnf/XOBo=
X-Google-Smtp-Source: APXvYqy9Zo5x3s40sd7UQFw1NeDzBWgCatIAqNlb/8d9KVFnpXzG86/vxxj13o3F3B50Fm7CMb0fmQ==
X-Received: by 2002:a17:906:55d1:: with SMTP id z17mr39253690ejp.300.1571943167454;
        Thu, 24 Oct 2019 11:52:47 -0700 (PDT)
Received: from ?IPv6:2a01:c22:b027:cc00:e811:3e4e:4af1:29fb? ([2a01:c22:b027:cc00:e811:3e4e:4af1:29fb])
        by smtp.googlemail.com with ESMTPSA id u12sm63403edy.87.2019.10.24.11.52.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 11:52:46 -0700 (PDT)
From:   Tobias Reinhard <trtracer@gmail.com>
Subject: Re: Effect of punching holes
To:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <2b75abb1-4dd8-1da4-77be-7557ff53ec75@gmail.com>
 <67354156-286a-f80e-ebc3-99c32e356fac@gmx.com>
 <d3658060-83ee-c9c2-52b2-95d60d1ac0ca@gmail.com>
Message-ID: <f082e863-de9e-2dcc-0b9a-e4ff91cb3701@gmail.com>
Date:   Thu, 24 Oct 2019 20:52:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d3658060-83ee-c9c2-52b2-95d60d1ac0ca@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am Di., 22. Okt. 2019 um 15:04 Uhr schrieb Austin S. Hemmelgarn 
<ahferroin7@gmail.com <mailto:ahferroin7@gmail.com>>:

    On 2019-10-22 06:01, Qu Wenruo wrote:
     >
     >
     > On 2019/10/22 下午5:47, Tobias Reinhard wrote:
     >> Hi,
     >>
     >>
     >> I noticed that if you punch a hole in the middle of a file the
    available
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
     >> Detected a SSD, turning off metadata duplication.  Mkfs with -m
    dup if
     >> you want to force metadata duplication.
     >> Label:              (null)
     >> UUID: 415e925a-588a-4b8f-bdc7-c30a4a0f5587
     >> Node size:          16384
     >> Sector size:        4096
     >> Filesystem size:    1.00GiB
     >> Block group profiles:
     >>    Data:             single            8.00MiB
     >>    Metadata:         single            8.00MiB
     >>    System:           single            4.00MiB
     >> SSD detected:       yes
     >> Incompat features:  extref, skinny-metadata
     >> Number of devices:  1
     >> Devices:
     >>     ID        SIZE  PATH
     >>      1     1.00GiB  /dev/loop1
     >>
     >> ->mount /dev/loop1 /srv/btrtest2
     >>
     >> ->for i in $(seq 1 20); do dd if=/dev/urandom of=test$i bs=16M
    count=4 ;
     >> sync ; fallocate -p -o 4096 -l 67100672 test$i && sync ; done
     >>
     >> this failed from the 16th file on because of no space left
     >
     > Btrfs doesn't free the space until all space of a data extent get
    freed.
     >
     > In your case, your hole punch is [4k, 64M-4K), thus the 64M
    extent still
     > has 4K being used.
     > So the data extent won't be freed until you free the last 4K.
     >
     >>
     >> ->df -T .
     >> Filesystem     Type  1K-blocks   Used Available Use% Mounted on
     >> /dev/loop1     btrfs   1048576 935856      2272 100% /srv/btrtest2
     >>
     >> ->btrfs fi du .
     >>       Total   Exclusive  Set shared  Filename
     >>     8.00KiB     8.00KiB           -  ./test1
     >>     8.00KiB     8.00KiB           -  ./test2
     >>     8.00KiB     8.00KiB           -  ./test3
     >>     8.00KiB     8.00KiB           -  ./test4
     >>     8.00KiB     8.00KiB           -  ./test5
     >>     8.00KiB     8.00KiB           -  ./test6
     >>     8.00KiB     8.00KiB           -  ./test7
     >>     8.00KiB     8.00KiB           -  ./test8
     >>     8.00KiB     8.00KiB           -  ./test9
     >>     8.00KiB     8.00KiB           -  ./test10
     >>     8.00KiB     8.00KiB           -  ./test11
     >>     8.00KiB     8.00KiB           -  ./test12
     >>     8.00KiB     8.00KiB           -  ./test13
     >>     8.00KiB     8.00KiB           -  ./test14
     >>     8.00KiB     8.00KiB           -  ./test15
     >>     4.00KiB     4.00KiB           -  ./test16
     >>     4.00KiB     4.00KiB           -  ./test17
     >>     4.00KiB     4.00KiB           -  ./test18
     >>     4.00KiB     4.00KiB           -  ./test19
     >>     4.00KiB     4.00KiB           -  ./test20
     >>   140.00KiB   140.00KiB       0.00B  .
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
     > Then the new write 4K will be cowed into a new 4K extent, the old
    large
     > 64M extent gets fully freed and free space.

    Expanding on this a bit, defrag isn't working here because it doesn't,
    by default, touch extents larger than 32M in size.  You should be able
    to make it work by using the `-t` option with a size larger than 64M.

    Alternatively, use `cp --reflink=never --sparse=always` to copy the
    file
    and then rename the copy over the original.  This will use more space,
    but is likely to be significantly faster than a defrag.

(sorry - for first bad formated post)

Hi,

I can't get the defrag way to work.

What is the right command to do it?

->df -hT .
Filesystem     Type   Size  Used Avail Use% Mounted on
/dev/loop1     btrfs  1,0G  868M   49M  95% /srv/btrtest2

->btrfs fi du .
      Total   Exclusive  Set shared  Filename
      0.00B       0.00B           -  ./runtest.sh
    8.00KiB     8.00KiB           -  ./test1
    8.00KiB     8.00KiB           -  ./test2
    8.00KiB     8.00KiB           -  ./test3
    8.00KiB     8.00KiB           -  ./test4
    8.00KiB     8.00KiB           -  ./test5
    8.00KiB     8.00KiB           -  ./test6
    8.00KiB     8.00KiB           -  ./test7
    8.00KiB     8.00KiB           -  ./test8
    8.00KiB     8.00KiB           -  ./test9
    8.00KiB     8.00KiB           -  ./test10
    8.00KiB     8.00KiB           -  ./test11
    8.00KiB     8.00KiB           -  ./test12
    8.00KiB     8.00KiB           -  ./test13
    8.00KiB     8.00KiB           -  ./test14
    8.00KiB     8.00KiB           -  ./test15
  120.00KiB   120.00KiB       0.00B  .
-> btrfs fi de -t 128M *
-> sync
-> df -hT .
Filesystem     Type   Size  Used Avail Use% Mounted on
/dev/loop1     btrfs  1,0G  868M   49M  95% /srv/btrtest2

Tobias

