Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F7C661E0C
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jan 2023 05:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbjAIE4u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Jan 2023 23:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbjAIE4s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 Jan 2023 23:56:48 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811278FFB
        for <linux-btrfs@vger.kernel.org>; Sun,  8 Jan 2023 20:56:46 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s5so10841217edc.12
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Jan 2023 20:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=leblancnet-us.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6/LZHDUGmezlNN8DVXAvHRs7aoelti5gHDv6y62oj3E=;
        b=us9T5GQA2iSsgD1l9Tq1b5fznTkJqy9AeUi6yg7LMiiIzaBdRVnUKv6zsbv06BzMBT
         Y2uoS1ujvqV34KOVXdmQTj5BaPFOl3kGRcF5Qj7Rt0YzjAe7+fnFqs8YxWGK/aAodG+m
         A2bX5qB5tdpRW4dGhLf6BcOw0JNkZnpl5QfmO6DnEI0LBjb9SQGRpUaCyOA9vQzOYcN2
         lqds9aZ6kOf26qv/2UgqNG9pIbrzYRVzsGv0cFw70h62Xp82tQIXyPqZMNKlyeAY2UjT
         bia4Ox0JIvzQMFy0QDQXcJLZz7B+KED0fO5Ys9fnGHoYDkN44K9BD+2R42xhwPOkPxGU
         IV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6/LZHDUGmezlNN8DVXAvHRs7aoelti5gHDv6y62oj3E=;
        b=DlIpvVTJ9Uv9wn4kPdPRVA9Ka/CFeNP/ZDgD78snjsL2gNc5m2BtNkFiAOjhB5VWDd
         68+kjSSQBBFootZbyEr9O58/z0I3RfXEIhU+gEDgldqwFvcaaLsr7DpC5AA0ac1tRyTG
         zHa/puhBq8atCi5rlqtl0xXVwWvkVr6SbVKlUYUkIkZJ/9IL5fpOnwpT/WSm9xQ6rp1y
         hSjg65h/w/53HQi+Fvd6kEjx/MlJiLc5L5TS4Xbt5KeADBZ3daITwpTyX4j+37lbrHyS
         BeP9BYmVVqZZsKpSoljNwqfqJtEH/j/SMtPLHkISuynIB7H1eGFEwBlEyT5MFOcURCAm
         W3vA==
X-Gm-Message-State: AFqh2kp4D5y7S8fx5+btAhmj10q8XDOeCtJVz+TvJ0+ZQEsPWIpcJ4tK
        uZXQV6seTNMOX3/DiWjnTapSz+OshPleMgGi/TPt5Q==
X-Google-Smtp-Source: AMrXdXtdIwg5oBzPmgDjIDQtj5+UMqHZl9V1iq3ukgKLqzVZ9tMq3KgLwaOIm9Dppfib8a6q7IC+pEokDItA9p7ATUw=
X-Received: by 2002:a05:6402:50d:b0:46a:a12a:4dcd with SMTP id
 m13-20020a056402050d00b0046aa12a4dcdmr7652783edv.338.1673240204960; Sun, 08
 Jan 2023 20:56:44 -0800 (PST)
MIME-Version: 1.0
References: <CAANLjFobOKhui5j1VsRkNSTF9SjRADtBennjoZE1jEPnU=iVaw@mail.gmail.com>
 <CAANLjFraYrdzZLv0ZcW=1sfnKSnbbb08qEpVHiAQHZQ181epjg@mail.gmail.com>
 <4f134378-4298-bc28-c17a-8415ffdc19e9@gmx.com> <50ecc4dc-fbf1-8fca-5484-27de33a2ed85@gmx.com>
 <0de3f1eb-4131-774b-74bc-ab2cfdd022de@inwind.it> <b09e0dfc-a911-5eea-8a35-f829ab618b2d@gmx.com>
 <CAANLjFroTEUcOLjfRs-4FWdSf_rgnSHpP8TkU8fo--SYrfjKCg@mail.gmail.com>
 <3a220ba2-67a6-c3b8-6b07-cf70c1c80fc2@gmx.com> <CAANLjFr9OPyvoGfg7dfU314=ba01Ar=GuiXZmef+skCXEC+OzQ@mail.gmail.com>
 <CAANLjFoSoYa3ZXHsG7fML0_RXh4t8yQQ3qVzpBMJqpeM3hKSgg@mail.gmail.com> <42964604-a215-f856-2aeb-cf5664d84745@gmx.com>
In-Reply-To: <42964604-a215-f856-2aeb-cf5664d84745@gmx.com>
From:   Robert LeBlanc <robert@leblancnet.us>
Date:   Sun, 8 Jan 2023 21:56:32 -0700
Message-ID: <CAANLjFpVVhWUtY5Zf8qkZLN3OdAsvEcEKSWmxCdyE1=PraQDVQ@mail.gmail.com>
Subject: Re: File system can't mount
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Antonio Muci <a.mux@inwind.it>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 7, 2023 at 2:37 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> OK, this part needs some update to properly handle it.
>
> I can craft a dirty fix for it, but meanwhile would you try "btrfs check
> --repair --mode=lowmem" to see if lowmem mode can handle the case?
> (Though it can be very slow).
>
> If lowmem mode doesn't work either, I can work on a quick dirty fix first.

I booted into 5.18 and copied/send/receive all of the data into a new
file system. Along the whole process I ran into some send/receives
that wouldn't work, but pulling a backup from Sep and then running an
`rsync` worked for all but two files (at least the only two that
failed to transfer) and those were inconsequential and can be
regenerated easily. The HDD file system didn't have any issues with
the transfers. I booted back into 6.0.12 and tried to mount, still no
luck, then I ran the lowmem option and it then allowed me to mount it.
I don't have any use for the old file system any longer and unless you
want to examine it some more, I'll blow it away and restore my RAID-1
protection. Thank you for all your help.

This was the error when trying to mount before the fix.
```
[Sun Jan  8 18:49:20 2023] BTRFS critical (device dm-5): corrupt leaf:
block=12461820608512 slot=31 extent bytenr=12462950973440 len=16384
previous extent [12462950961152 169 0] overlaps current extent
[12462950973440 169 0]
[Sun Jan  8 18:49:20 2023] BTRFS error (device dm-5): read time tree
block corruption detected on logical 12461820608512 mirror 2
[Sun Jan  8 18:49:20 2023] BTRFS critical (device dm-5): corrupt leaf:
block=12461820608512 slot=31 extent bytenr=12462950973440 len=16384
previous extent [12462950961152 169 0] overlaps current extent
[12462950973440 169 0]
[Sun Jan  8 18:49:20 2023] BTRFS error (device dm-5): read time tree
block corruption detected on logical 12461820608512 mirror 1
[Sun Jan  8 18:49:20 2023] BTRFS error (device dm-5): failed to read
block groups: -5
[Sun Jan  8 18:49:20 2023] BTRFS error (device dm-5): open_ctree failed
```

```
# ./btrfs check --repair --mode=lowmem /dev/mapper/1EV13X7B
enabling repair mode
WARNING:

       Do not use --repair unless you are advised to do so by a developer
       or an experienced user, and then only after having accepted that no
       fsck can successfully repair all types of filesystem corruption. Eg.
       some software or hardware bugs can fatally damage a volume.
       The operation will start in 10 seconds.
       Use Ctrl-C to stop it.
10 9 8 7 6 5 4 3 2 1
Starting repair.
WARNING: low-memory mode repair support is only partial
Opening filesystem to check...
Checking filesystem on /dev/mapper/1EV13X7B
UUID: 7b01dd5a-cfa3-4918-a714-03ca7682fbdc
[1/7] checking root items
Fixed 0 roots.
[2/7] checking extents
ERROR: bad metadata [12462950961152, 12462950977536) crossing stripe boundary
WARNING: tree block [12462950961152, 12462950977536) is not nodesize
aligned, may cause problem for 64K page system
checksum verify failed on 12462950961152 wanted 0x9086f407 found 0x7f307978
checksum verify failed on 12462950961152 wanted 0x9086f407 found 0x7f307978
checksum verify failed on 12462950961152 wanted 0x9086f407 found 0x7f307978
bad tree block 12462950961152, bytenr mismatch, want=12462950961152,
have=6006926515333486485
ERROR: extent [12462950961152 16384] lost referencer (owner: 7, level: 0)
Created new chunk [47535755362304 1073741824]
Delete backref in extent [12462950961152 16384]
ERROR: extent[12493662797824, 24576] referencer count mismatch (root:
17592186057694, owner: 193642, offset: 0) wanted: 1, have: 0
Delete backref in extent [12493662797824 24576]
ERROR: extent[12462950957056 16384] backref lost (owner: 7, level: 0) root 7
Added an extent item [12462950957056 16384]
Added one tree block ref start 12462950957056 root 7
ERROR: file extent[193642 0] root 13278 owner 13278 backref lost
Add one extent data backref [12493662797824 24576]
No device size related problem found
[3/7] checking free space cache
cache and super generation don't match, space cache will be invalidated
[4/7] checking fs roots
ERROR: root 13278 EXTENT_DATA[193642 0] csum missing, have: 0, expected: 24576
ERROR: errors found in fs roots
found 13920475688960 bytes used, error(s) found
total csum bytes: 13555499384
total tree bytes: 17208098816
total fs tree bytes: 1914175488
total extent tree bytes: 562282496
btree space waste bytes: 1431667108
file data blocks allocated: 28319698092032
referenced 19612555300864
```

----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
