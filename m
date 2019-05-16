Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E78320394
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2019 12:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfEPKhH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 May 2019 06:37:07 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44364 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfEPKhG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 May 2019 06:37:06 -0400
Received: by mail-oi1-f193.google.com with SMTP id z65so2094076oia.11
        for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2019 03:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=vO313sZ580rS4IbYJkHfx9Q/5lOadgD7X3klaJZAY7w=;
        b=SZTDBM/KZTMMTUJLMjKt0jqy7MQe+YxERwppZmjEr5C01+BSnSgja3Q0yxmpQ9F+3Q
         mwknygti4QQjCsTDw8++SQnEPIdL5MZ2gaFr6jZrNl1SIEYwMy1pybaIvuXIV/XtQXox
         GhfSqKzB0gfmTHK7ggK3eyvnTv12S48plFjRHEnZ2rSGUNZ6n4xgY67cXdsxNCSO0oxY
         0DWFL9j60xCI7kgRZrWA7XEoO3TB+Kh1AxKWmNH4Y2slfBpTx3sb31oxIvHrNvS0nyLI
         kAnYDCRqedY7Ypl+wZl6HWDzgTryGkJw8Dg8hAhzQT1HCiJOdr6mnOK7HGljy7/udOtM
         rViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vO313sZ580rS4IbYJkHfx9Q/5lOadgD7X3klaJZAY7w=;
        b=cos1BLuhfupcUoj0uxLQ5Q7ClzVgdT6Hh/qS8ABK4fCjkZdes08kbkWnuZbjaDSRzn
         pMdqU5hAgOmZZXgNhRVFTvOVLCttu4IBfOEX2Foyzcj2iljSLvZc633+xI/yzaVfmtNf
         E9M31NPadlK7BUC5hsCq24EfJlXqNljyIzg8p506CwJGUSZB+To2Ot3bpNaKTJgsjCw0
         CO7X7UxvN5iOBh8g9icVhGZlLMCvzNdauzE0jhdzBZl0HmLYuPqVknGvw59YQSkBWM8N
         mi3JpJdhzzCzFql/v3vwBs7kzlwoqHMjQkYRP1hUbS8ZHjgHJyXuFqc/4GCO/VW2Rm/i
         SSTg==
X-Gm-Message-State: APjAAAWobC8S5fNunhsE+4VDoZJhD/2RzOZAQhCPvCVZG5FV9oAjtjqc
        vLMmkiEQDpBBo0/AGILn62eQhIX6VolGyP8VUSb1TmFGfR8=
X-Google-Smtp-Source: APXvYqzQYSZ48dopdi3/ttYACZrldykKTUgQadWFNzpgOUHzZx339HKBV8uMKUjV5cNLmuS2jp28163lPvpUhT232iM=
X-Received: by 2002:aca:6009:: with SMTP id u9mr4395165oib.41.1558003025647;
 Thu, 16 May 2019 03:37:05 -0700 (PDT)
MIME-Version: 1.0
From:   Lee Fleming <leeflemingster@gmail.com>
Date:   Thu, 16 May 2019 11:36:54 +0100
Message-ID: <CAKS=YrP=z2+rP5AtFKkf7epi+Dr2Arfsaq3pZ9cR3iKif3gV5g@mail.gmail.com>
Subject: Unbootable root btrfs
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

After seeking advice on reddit I've been advised to post this problem
here. See https://www.reddit.com/r/btrfs/comments/bp0awe/broken_btrfs_filesystem_following_a_reboot/

I have a root btrfs filesystem on top of mdadm raid10 and lvm. The
raid and lvm appear to be ok but the btrfs partition will not mount.

I have booted a live recovery and tried to mount/repair the
filesystem. This is the result.

    % mount /dev/mapper/vg-root /mnt/gentoo
    mount: /mnt/gentoo: wrong fs type, bad option, bad superblock on
/dev/mapper/vg-root,
    missing codepage or helper program, or other error.

Trying to mount with recovery gives the same result:

    % mount -o ro,recovery  /dev/mapper/vg-root /mnt/gentoo

    mount: /mnt/gentoo: wrong fs type, bad option, bad superblock on
/dev/mapper/vg-root,
    missing codepage or helper program, or other error.

And a btrfs check gives the following:

    % btrfs check --repair /dev/mapper/vg-root
    enabling repair mode
    bytenr mismatch, want=898031484928, have=898006728704

    ERROR: cannot open file system

    % dmesg | grep -i btrfs [ 5.562419] Btrfs loaded, crc32c=crc32c-generic
    [ 14.381989] BTRFS: device fsid
1fb019f1-a8cc-46ef-8122-ac6b1bedd522 devid 1 transid 51979 /dev/dm-1
    [ 14.382647] BTRFS info (device dm-1): disk space caching is enabled
    [ 14.382652] BTRFS info (device dm-1): has skinny extents
    [ 15.777186] BTRFS error (device dm-1): bad tree block start 0 898031337472
    [ 15.777334] BTRFS error (device dm-1): bad tree block start 0 898031353856
    [ 15.777486] BTRFS error (device dm-1): bad tree block start 0 898031370240
    [ 15.864239] BTRFS error (device dm-1): bad tree block start
898006728704 898031484928
    [ 15.871367] BTRFS error (device dm-1): bad tree block start
898003812352 898031484928
    [ 15.871382] BTRFS error (device dm-1): failed to read block groups: -5
    [ 15.892051] BTRFS error (device dm-1): open_ctree failed
    [ 16.016182] BTRFS info (device dm-1): disk space caching is enabled
    [ 16.016186] BTRFS info (device dm-1): has skinny extents
    [ 17.319016] BTRFS error (device dm-1): bad tree block start 0 898031337472
    [ 17.319157] BTRFS error (device dm-1): bad tree block start 0 898031353856
    [ 17.319303] BTRFS error (device dm-1): bad tree block start 0 898031370240
    [ 17.422706] BTRFS error (device dm-1): bad tree block start
898006728704 898031484928
    [ 17.429831] BTRFS error (device dm-1): bad tree block start
898003812352 898031484928
    [ 17.429845] BTRFS error (device dm-1): failed to read block groups: -5
    [ 17.450035] BTRFS error (device dm-1): open_ctree failed % uname
-r 4.14.70-std531-amd64

    % wipefs /dev/mapper/vg-root
    DEVICE OFFSET TYPE UUID LABEL
    vg-root 0x10040 btrfs 1fb019f1-a8cc-46ef-8122-ac6b1bedd522

I was asked to try with a more recent kernel. I booted archiso which
showed similar results.

    # uname -r
    5.0.10-arch1-1-ARCH

    # mount /dev/mapper/vg-root /mnt/funtoo
    [ 208.724214] BTRFS error (device dm-1): bad tree block start,
want 898031337472 have 0
    [ 208.724343] BTRFS error (device dm-1): bad tree block start,
want 898031353856 have 0
    [ 208.724556] BTRFS error (device dm-1): bad tree block start,
want 898031370240 have 0
    [ 208.805279] BTRFS error (device dm-1): bad tree block start,
want 898031484928 have 898006728704
    [ 208.812412] BTRFS error (device dm-1): bad tree block strat,
want 898031484928 have 898003812352
    [ 208.812451] BTRFS error (device dm-1): failed to read block groups: -5
    [ 208.840576] BTRFS error (device dm-1): open_ctree failed
    mount: /mnt/funtoo: wrong fs type, bad option, bad superblock on
/dev/mapper/vg-root, missing codepage or helper program, or other
error.
    32

    # dmesg|grep -i btrfs [ 23.028283] Btrfs loaded, crc32c=crc32c-intel
    [ 23.061402] BTRFS: device fsid
1fb019f1-a8cc-46ef-8122-ac6b1bedd522 devid 1 transid 51979 /dev/dm-1
    [ 207.437375] BTRFS info (device dm-1): disk space caching is enabled
    [ 207.437379] BTRFS info (device dm-1): has skinny extents
    [ 208.724214] BTRFS error (device dm-1): bad tree block start,
want 898031337472 have 0
    [ 208.724343] BTRFS error (device dm-1): bad tree block start,
want 898031353856 have 0
    [ 208.724556] BTRFS error (device dm-1): bad tree block start,
want 898031370240 have 0
    [ 208.805279] BTRFS error (device dm-1): bad tree block start,
want 898031484928 have 898006728704
    [ 208.812412] BTRFS error (device dm-1): bad tree block start,
want 898031484928 have 898003812352
    [ 208.812451] BTRFS error (device dm-1): failed to read block groups: -5
    [ 208.840576] BTRFS error (device dm-1): open_ctree failed

Any idea if this can be fixed?

Cheers
Lee
