Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B592E18BE
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Dec 2020 07:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgLWGFp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Dec 2020 01:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbgLWGFp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Dec 2020 01:05:45 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87448C0613D3
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Dec 2020 22:05:04 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id a12so37521386lfl.6
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Dec 2020 22:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8cejpEpIV0aoY0KdGXzaW14bXhw61axCsNNTuEQJzCA=;
        b=qw6g0VnpRW+tYC2hNqJv5bmBhWpQHMfBxaLg7pOWUIfNO57i3rVGaDbFUgeG46xFDt
         qNOLIxNJ8JJdJKXVYObnzWT188+QOzZH+y+/DrCSKB+xxn1tePFW0hMATJ8ZwwGmmMJX
         hOk3WGLi8dZy/s0XKKRwgePLupgZhJ2ydMIgL0aCXXx26h0DNkoSSrpsVUsyDaFEJOcd
         byEfCc3H4w/lAM3L1PRzWZvmd9u3fwLe0cJ260h4IAVOJ3/Y+29vD0RzeVKXLiJxTXpp
         aUw+5DppsgOnL2FohKMCm7rcpj9PNSE16yF+YhHKv58U1PY5zMueBNCRTGzYGBrZv1WI
         xahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8cejpEpIV0aoY0KdGXzaW14bXhw61axCsNNTuEQJzCA=;
        b=GNzhOi0HJ6FaiY8G60TgW+T4zYQeIodwwUosn3nqqJJElrCjfizfCwxZglSokKdGwi
         tNxZIweOMqcI7sAvsLgWJQXgKqB4OSOdGobM1C4idueIz9uqpa7LzL+He/813unPftHd
         O91+z3gyq+Uhbrxu4nxR+Pi+aSZh8h67EJfY2TOIfRCcD0pElnZbzsliP35YZD9Wuu2j
         KPF7aBxOpjDfg5Sk7sqS6614zAAd4VKZizZqz/bHRSqiTIw9rwlaPrOpp/CGYGoDPchk
         D+sZrlrIp5dNg3JLi639GHy0YzKBkd9APOw3p4lW1ykExtGJ/8Ye3K26B8aFmpCCLL9R
         pI9Q==
X-Gm-Message-State: AOAM533EZdaSFx5dSrT7SvPKMtPPr353+uxyetEK6PodMmcAz/2Zmgal
        OY02iJCAl/9YaYsiHMaSJmRHByP9i8Y=
X-Google-Smtp-Source: ABdhPJxYgcbF7BvL2uyQSwefeQ2twTyYPVUGuZ9V200odjip2jb/mbCL8IleCveCGvbV1/myU/iExQ==
X-Received: by 2002:ac2:5f58:: with SMTP id 24mr10783764lfz.302.1608703502800;
        Tue, 22 Dec 2020 22:05:02 -0800 (PST)
Received: from ?IPv6:2a00:1370:812d:ecb3:590f:aaab:50ba:573b? ([2a00:1370:812d:ecb3:590f:aaab:50ba:573b])
        by smtp.gmail.com with ESMTPSA id m14sm2999795lfq.183.2020.12.22.22.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Dec 2020 22:05:02 -0800 (PST)
Subject: Re: cp --reflink of inline extent results in two DATA_EXTENT entries
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtQZJ8Jo8rX0BL51k5DmC1GEs21CyvmEOhoYDoY=g6XwCw@mail.gmail.com>
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
Message-ID: <e7a7ddd7-1de7-3453-6398-3a5acc7f5e18@gmail.com>
Date:   Wed, 23 Dec 2020 09:05:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQZJ8Jo8rX0BL51k5DmC1GEs21CyvmEOhoYDoY=g6XwCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

23.12.2020 06:48, Chris Murphy пишет:
> Hi,
> 
> kernel is 5.10.2
> 
> cp --reflink hi hi2
> 
> This results in two EXTENT_DATA items with different offsets,
> therefore I think the data is duplicated in the leaf? Correct? Is it
> expected?
> 

I'd say yes. Inline data is contained in EXTEND_DATA item and
EXTENT_DATA item cannot be shared by two different inodes (it is keyed
by inode number).

Even when cloning regular extent you will have two independent
EXTENT_DATA items pointing to the same physical extent.

>         item 9 key (257 EXTENT_DATA 0) itemoff 15673 itemsize 53
>                 generation 435179 type 0 (inline)
>                 inline extent data size 32 ram_bytes 174 compression 3 (zstd)
> 
> ...
>         item 13 key (258 EXTENT_DATA 0) itemoff 15364 itemsize 53
>                 generation 435179 type 0 (inline)
>                 inline extent data size 32 ram_bytes 174 compression 3 (zstd)
> 
> 
> The entire file tree containing only these two files follows:
> 
> 
> file tree key (394 ROOT_ITEM 0)
> leaf 26442252288 items 14 free space 15014 generation 435212 owner 394
> leaf 26442252288 flags 0x1(WRITTEN) backref revision 1
>         item 0 key (256 INODE_ITEM 0) itemoff 16123 itemsize 160
>                 generation 435123 transid 435212 size 10 nbytes 0
>                 block group 0 mode 40755 links 1 uid 1000 gid 1000
> rdev 0
>                 sequence 5267 flags 0x0(none)
>                 atime 1608689569.708325037 (2020-12-22 19:12:49)
>                 ctime 1608694856.721370147 (2020-12-22 20:40:56)
>                 mtime 1608694856.721370147 (2020-12-22 20:40:56)
>                 otime 1608689569.708325037 (2020-12-22 19:12:49)
>         item 1 key (256 INODE_REF 256) itemoff 16111 itemsize 12
>                 index 0 namelen 2 name: ..
>         item 2 key (256 DIR_ITEM 432062026) itemoff 16079 itemsize 32
>                 location key (257 INODE_ITEM 0) type FILE
>                 transid 435124 data_len 0 name_len 2
>                 name: hi
>         item 3 key (256 DIR_ITEM 4216900732) itemoff 16046 itemsize 33
>                 location key (258 INODE_ITEM 0) type FILE
>                 transid 435196 data_len 0 name_len 3
>                 name: hi2
>         item 4 key (256 DIR_INDEX 2) itemoff 16014 itemsize 32
>                 location key (257 INODE_ITEM 0) type FILE
>                 transid 435124 data_len 0 name_len 2
>                 name: hi
>         item 5 key (256 DIR_INDEX 4) itemoff 15981 itemsize 33
>                 location key (258 INODE_ITEM 0) type FILE
>                 transid 435196 data_len 0 name_len 3
>                 name: hi2
>         item 6 key (257 INODE_ITEM 0) itemoff 15821 itemsize 160
>                 generation 435124 transid 435212 size 174 nbytes 174
>                 block group 0 mode 100644 links 1 uid 1000 gid 1000
> rdev 0
>                 sequence 19 flags 0x0(none)
>                 atime 1608689574.394444809 (2020-12-22 19:12:54)
>                 ctime 1608694856.721370147 (2020-12-22 20:40:56)
>                 mtime 1608692923.231038818 (2020-12-22 20:08:43)
>                 otime 1608689574.394444809 (2020-12-22 19:12:54)
>         item 7 key (257 INODE_REF 256) itemoff 15809 itemsize 12
>                 index 2 namelen 2 name: hi
>         item 8 key (257 XATTR_ITEM 3817753667) itemoff 15726 itemsize 83
>                 location key (0 UNKNOWN.0 0) type XATTR
>                 transid 435124 data_len 37 name_len 16
>                 name: security.selinux
>                 data unconfined_u:object_r:unlabeled_t:s0
>         item 9 key (257 EXTENT_DATA 0) itemoff 15673 itemsize 53
>                 generation 435179 type 0 (inline)
>                 inline extent data size 32 ram_bytes 174 compression 3 (zstd)
>         item 10 key (258 INODE_ITEM 0) itemoff 15513 itemsize 160
>                 generation 435196 transid 435196 size 174 nbytes 174
>                 block group 0 mode 100644 links 1 uid 1000 gid 1000 rdev 0
>                 sequence 34 flags 0x0(none)
>                 atime 1608693921.97510335 (2020-12-22 20:25:21)
>                 ctime 1608693921.97510335 (2020-12-22 20:25:21)
>                 mtime 1608693921.97510335 (2020-12-22 20:25:21)
>                 otime 1608693921.97510335 (2020-12-22 20:25:21)
>         item 11 key (258 INODE_REF 256) itemoff 15500 itemsize 13
>                 index 4 namelen 3 name: hi2
>         item 12 key (258 XATTR_ITEM 3817753667) itemoff 15417 itemsize 83
>                 location key (0 UNKNOWN.0 0) type XATTR
>                 transid 435196 data_len 37 name_len 16
>                 name: security.selinux
>                 data unconfined_u:object_r:unlabeled_t:s0
>         item 13 key (258 EXTENT_DATA 0) itemoff 15364 itemsize 53
>                 generation 435179 type 0 (inline)
>                 inline extent data size 32 ram_bytes 174 compression 3 (zstd)
> total bytes 31005392896
> bytes used 20153282560
> 
> 
> 

