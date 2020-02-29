Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9074F1747BE
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Feb 2020 16:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgB2PsD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Feb 2020 10:48:03 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:43014 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgB2PsD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Feb 2020 10:48:03 -0500
Received: by mail-ot1-f50.google.com with SMTP id j5so4624603otn.10
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Feb 2020 07:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MHRtmj/SrkxXriNQu7qORkzvHaAKhF/u4jKtFQ7YH4I=;
        b=amcFkcFRc/yDSh/IVJjeEvzkkLIS8qWW0OsQzHr9cB4UrAsptfeaZznnQMNzPwP3Gc
         EtY5gFbY5QNz3y21SNfAH2684hzJXwA01LdAZ7da0AKBBlKZFIGYWSx0VlX3FcLjFZmf
         9l0M/SltMSLyuCuMlP78g8X9Y/WZC53Wje5uw5LwVnnRPmmNPuStE6RU+lnNGH0c2YER
         497k7+GzcJbY7Du+AGc0D+GKYFL61joGv/+Dm6OLTMFWlNskHTwb1iGpN8t5F6nCZzuR
         23RwPNRMCJYJUYMa31h8jC/aPRul3rTWO1PGvPO1Kjl5F3NReKcaLIBI5jZ8Ud12n6VG
         wBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MHRtmj/SrkxXriNQu7qORkzvHaAKhF/u4jKtFQ7YH4I=;
        b=ROM37wP4v70i08v+5wPAqCV3MtW9Fec2bdU7wrorPlrpyrTFzxriFD31gj61j0Avrw
         gFH6g7IPwt6jbJ1Y/h5DfRIFNa8j6PN8gyJmYXLvcVadMzxzzYRQhULFCnUnDbapaCDh
         jz7cisc1GJJn3VjM0az+4Af3YbuAKS+4hyQbLvdcSQ1GcIFTPuFrMUGnCr1L/8nTP5Ww
         Qr0iaH0b4UVuZI9X/AwXzsBmD2bpgehtC8BMyEG0JrsgBNtSD+XLPlzjTF0srVNwBcNN
         WWwSdWslj6C94Wsvmq/0GWr2pam0UAGCQIdQ4MXc0uX/Er3MJto+xWyFxbH3D0KofvUA
         7NJA==
X-Gm-Message-State: APjAAAUPpsxY8tlMsYpb020JGFkKm/s6O7g8xr+Cic6qmur1RdxA+hfZ
        j4YNUV6m8h90ajFBjN87EuSfOI5AblFtzTYi86g=
X-Google-Smtp-Source: APXvYqwIt+SiKUP0rsbCO6fWX6EqjDfQ42BKhZPlhEWPJ9bzUbwWRXN3EPkNmGXV4zywaLNPyp3uNu9uFDMtCqLwNXg=
X-Received: by 2002:a9d:7f11:: with SMTP id j17mr7717620otq.281.1582991280924;
 Sat, 29 Feb 2020 07:48:00 -0800 (PST)
MIME-Version: 1.0
References: <CADq=pg=g47zrfKiqGFUHOJg8=+bdSGQeawihKcVcp_BahzPT+Q@mail.gmail.com>
 <587446db-5168-d91d-c1fa-c7bef48959d9@gmx.com> <CADq=pgn3-4S3ErK0G+ajf-5M=8CSaE6iow25ASaBxCygedy=7g@mail.gmail.com>
 <2ffbf268-437c-b90e-21f3-7ea44aa9e7e6@gmx.com>
In-Reply-To: <2ffbf268-437c-b90e-21f3-7ea44aa9e7e6@gmx.com>
From:   4e868df3 <4e868df3@gmail.com>
Date:   Sat, 29 Feb 2020 08:47:24 -0700
Message-ID: <CADq=pgkuxOf7h=25Qice9q5Q-RiFXQiDzx0ZuEUCs4uN++3sxw@mail.gmail.com>
Subject: Re: corrupt leaf
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It came up with some kind of `840 abort`. Then I reran btrfs check and
tried again.

$ btrfs check --init-csum-tree /dev/mapper/luks0
Creating a new CRC tree
WARNING:

        Do not use --repair unless you are advised to do so by a developer
        or an experienced user, and then only after having accepted that no
        fsck can successfully repair all types of filesystem corruption. Eg.
        some software or hardware bugs can fatally damage a volume.
        The operation will start in 10 seconds.
        Use Ctrl-C to stop it.
10 9 8 7 6 5 4 3 2 1
Starting repair.
Opening filesystem to check...
Checking filesystem on /dev/mapper/luks0
UUID: 8c1dea88-fa40-4e6e-a1a1-214ea6bcdb00
Reinitialize checksum tree
Unable to find block group for 0
Unable to find block group for 0
Unable to find block group for 0
ctree.c:2272: split_leaf: BUG_ON `1` triggered, value 1
btrfs(+0x71e09)[0x564eef35ee09]
btrfs(btrfs_search_slot+0xfb1)[0x564eef360431]
btrfs(btrfs_csum_file_block+0x442)[0x564eef37c412]
btrfs(+0x35bde)[0x564eef322bde]
btrfs(+0x47ce4)[0x564eef334ce4]
btrfs(main+0x94)[0x564eef3020c4]
/usr/lib/libc.so.6(__libc_start_main+0xf3)[0x7ff12a43e023]
btrfs(_start+0x2e)[0x564eef30235e]
[1]    840 abort      sudo btrfs check --init-csum-tree /dev/mapper/luks0

$ btrfs check /dev/mapper/luks0
Opening filesystem to check...
Checking filesystem on /dev/mapper/luks0
UUID: 8c1dea88-fa40-4e6e-a1a1-214ea6bcdb00
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
there are no extents for csum range 68757573632-68757704704
Right section didn't have a record
there are no extents for csum range 68754427904-68757704704
csum exists for 68750639104-68757704704 but there is no extent record
there are no extents for csum range 68760719360-68761223168
Right section didn't have a record
there are no extents for csum range 68757819392-68761223168
csum exists for 68757819392-68761223168 but there is no extent record
there are no extents for csum range 68761362432-68761378816
Right section didn't have a record
there are no extents for csum range 68761178112-68836831232
csum exists for 68761178112-68836831232 but there is no extent record
there are no extents for csum range 1168638763008-1168638803968
csum exists for 1168638763008-1168645861376 but there is no extent
record
ERROR: errors found in csum tree
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 3165125918720 bytes used, error(s) found
total csum bytes: 3085473228
total tree bytes: 4791877632
total fs tree bytes: 1177714688
total extent tree bytes: 94617600
btree space waste bytes: 492319296
file data blocks allocated: 3160334041088
 referenced 3157401378816

$ btrfs check --init-csum-tree /dev/mapper/luks0
Creating a new CRC tree
WARNING:

        Do not use --repair unless you are advised to do so by a developer
        or an experienced user, and then only after having accepted that no
        fsck can successfully repair all types of filesystem corruption. Eg.
        some software or hardware bugs can fatally damage a volume.
        The operation will start in 10 seconds.
        Use Ctrl-C to stop it.
10 9 8 7 6 5 4 3 2 1
Starting repair.
Opening filesystem to check...
Checking filesystem on /dev/mapper/luks0
UUID: 8c1dea88-fa40-4e6e-a1a1-214ea6bcdb00
Reinitialize checksum tree
Unable to find block group for 0
Unable to find block group for 0
Unable to find block group for 0
ctree.c:2272: split_leaf: BUG_ON `1` triggered, value 1
btrfs(+0x71e09)[0x559260a6de09]
btrfs(btrfs_search_slot+0xfb1)[0x559260a6f431]
btrfs(btrfs_csum_file_block+0x442)[0x559260a8b412]
btrfs(+0x35bde)[0x559260a31bde]
btrfs(+0x47ce4)[0x559260a43ce4]
btrfs(main+0x94)[0x559260a110c4]
/usr/lib/libc.so.6(__libc_start_main+0xf3)[0x7f212eb1f023]
btrfs(_start+0x2e)[0x559260a1135e]
[1]    848 abort      sudo btrfs check --init-csum-tree /dev/mapper/luks0
