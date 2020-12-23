Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C862E17D9
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Dec 2020 04:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgLWDtZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Dec 2020 22:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgLWDtY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Dec 2020 22:49:24 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BD8C0613D3
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Dec 2020 19:48:44 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id n16so628126wmc.0
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Dec 2020 19:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=rOEgaMNj41djjqtwYp1jRZaUM3VAdlrmlIfLlSxLFp8=;
        b=n2sOskuOs5CwOd7YYkNPGo+m/AEXSjiErzZIpZa6QiA5OU9lS5J/6lz3aVlzcesCKB
         zZQdMWYtJux4TMGgBOFazpFKn9oNd0aogoXRLAVuxlp+0QuuvjrHN18Rg2fUhRfaytAp
         8UYpFqL/jTYXa0nRJJu3YogNWvfi+RPbWCC0vMtZIhrjx0iEQ5CLPEP0rbIqLTluIKsZ
         adWjfxkNwuIHWe5qY9vGd0/1Qk6/0eHKrKEdNuKvkSf5JEfryx9jKudrsiP8TnxPAwVX
         nt6d+X16u6xKn4NSDhKf88WINBcACx/prgRgkH7Jc9SvoIt9HywUHtPP+RfY5rc9fdVH
         GmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rOEgaMNj41djjqtwYp1jRZaUM3VAdlrmlIfLlSxLFp8=;
        b=VXAY2YDPQokJaVV6ekhRVpPqthHFobNImJLstnGMfBavvnjyaYx446MTbyG+nxZ2+G
         yBe4YPBPJIwX7OcSAieconiyCzAeb8ZY2jbZKPYxGwfxwsBUzFyWfGm1AmLcEVgeOItq
         +Q06t3mbvE3EJKHAXXU6ZdGr0+U4e1KyVKUFUNe114sjH9NxX9bhoGbnklncy5ilBQ3L
         2DfTRqeU3jLezhkC8V3Xx5ySwgIO7kZ+Mo1o0XJ/uOMtO13SSQSgtTLoI+IDF0OAldhT
         cBEw4Ec80h3qyNPhb/aHxoZKXvm6McnHHQK6egPPKzKtq+PQs3q9yig+UudLPHzl2y7b
         cPgw==
X-Gm-Message-State: AOAM533C4EOSvPmUF53couAO3m+mGhGu6rinPnARBcquoJW4fhrdJLsN
        Qd5/jrhR47prLDyx5coi4Y9ePPkPz9qcLZM1JriX2hH92/mcjc5g
X-Google-Smtp-Source: ABdhPJwE/ch4wnqjY/yOTSE8Bfiy6sXlOL49kxkjJqVChWOuV6XxAkA0oyIpkjyY5KZuD3MzGbLG0hkBARGd0ffypZI=
X-Received: by 2002:a1c:9692:: with SMTP id y140mr18450555wmd.128.1608695322764;
 Tue, 22 Dec 2020 19:48:42 -0800 (PST)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 22 Dec 2020 20:48:26 -0700
Message-ID: <CAJCQCtQZJ8Jo8rX0BL51k5DmC1GEs21CyvmEOhoYDoY=g6XwCw@mail.gmail.com>
Subject: cp --reflink of inline extent results in two DATA_EXTENT entries
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

kernel is 5.10.2

cp --reflink hi hi2

This results in two EXTENT_DATA items with different offsets,
therefore I think the data is duplicated in the leaf? Correct? Is it
expected?

        item 9 key (257 EXTENT_DATA 0) itemoff 15673 itemsize 53
                generation 435179 type 0 (inline)
                inline extent data size 32 ram_bytes 174 compression 3 (zstd)

...
        item 13 key (258 EXTENT_DATA 0) itemoff 15364 itemsize 53
                generation 435179 type 0 (inline)
                inline extent data size 32 ram_bytes 174 compression 3 (zstd)


The entire file tree containing only these two files follows:


file tree key (394 ROOT_ITEM 0)
leaf 26442252288 items 14 free space 15014 generation 435212 owner 394
leaf 26442252288 flags 0x1(WRITTEN) backref revision 1
        item 0 key (256 INODE_ITEM 0) itemoff 16123 itemsize 160
                generation 435123 transid 435212 size 10 nbytes 0
                block group 0 mode 40755 links 1 uid 1000 gid 1000
rdev 0
                sequence 5267 flags 0x0(none)
                atime 1608689569.708325037 (2020-12-22 19:12:49)
                ctime 1608694856.721370147 (2020-12-22 20:40:56)
                mtime 1608694856.721370147 (2020-12-22 20:40:56)
                otime 1608689569.708325037 (2020-12-22 19:12:49)
        item 1 key (256 INODE_REF 256) itemoff 16111 itemsize 12
                index 0 namelen 2 name: ..
        item 2 key (256 DIR_ITEM 432062026) itemoff 16079 itemsize 32
                location key (257 INODE_ITEM 0) type FILE
                transid 435124 data_len 0 name_len 2
                name: hi
        item 3 key (256 DIR_ITEM 4216900732) itemoff 16046 itemsize 33
                location key (258 INODE_ITEM 0) type FILE
                transid 435196 data_len 0 name_len 3
                name: hi2
        item 4 key (256 DIR_INDEX 2) itemoff 16014 itemsize 32
                location key (257 INODE_ITEM 0) type FILE
                transid 435124 data_len 0 name_len 2
                name: hi
        item 5 key (256 DIR_INDEX 4) itemoff 15981 itemsize 33
                location key (258 INODE_ITEM 0) type FILE
                transid 435196 data_len 0 name_len 3
                name: hi2
        item 6 key (257 INODE_ITEM 0) itemoff 15821 itemsize 160
                generation 435124 transid 435212 size 174 nbytes 174
                block group 0 mode 100644 links 1 uid 1000 gid 1000
rdev 0
                sequence 19 flags 0x0(none)
                atime 1608689574.394444809 (2020-12-22 19:12:54)
                ctime 1608694856.721370147 (2020-12-22 20:40:56)
                mtime 1608692923.231038818 (2020-12-22 20:08:43)
                otime 1608689574.394444809 (2020-12-22 19:12:54)
        item 7 key (257 INODE_REF 256) itemoff 15809 itemsize 12
                index 2 namelen 2 name: hi
        item 8 key (257 XATTR_ITEM 3817753667) itemoff 15726 itemsize 83
                location key (0 UNKNOWN.0 0) type XATTR
                transid 435124 data_len 37 name_len 16
                name: security.selinux
                data unconfined_u:object_r:unlabeled_t:s0
        item 9 key (257 EXTENT_DATA 0) itemoff 15673 itemsize 53
                generation 435179 type 0 (inline)
                inline extent data size 32 ram_bytes 174 compression 3 (zstd)
        item 10 key (258 INODE_ITEM 0) itemoff 15513 itemsize 160
                generation 435196 transid 435196 size 174 nbytes 174
                block group 0 mode 100644 links 1 uid 1000 gid 1000 rdev 0
                sequence 34 flags 0x0(none)
                atime 1608693921.97510335 (2020-12-22 20:25:21)
                ctime 1608693921.97510335 (2020-12-22 20:25:21)
                mtime 1608693921.97510335 (2020-12-22 20:25:21)
                otime 1608693921.97510335 (2020-12-22 20:25:21)
        item 11 key (258 INODE_REF 256) itemoff 15500 itemsize 13
                index 4 namelen 3 name: hi2
        item 12 key (258 XATTR_ITEM 3817753667) itemoff 15417 itemsize 83
                location key (0 UNKNOWN.0 0) type XATTR
                transid 435196 data_len 37 name_len 16
                name: security.selinux
                data unconfined_u:object_r:unlabeled_t:s0
        item 13 key (258 EXTENT_DATA 0) itemoff 15364 itemsize 53
                generation 435179 type 0 (inline)
                inline extent data size 32 ram_bytes 174 compression 3 (zstd)
total bytes 31005392896
bytes used 20153282560



-- 
Chris Murphy
