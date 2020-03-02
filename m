Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 850961753D2
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 07:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgCBGf1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 01:35:27 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:42665 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgCBGf1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Mar 2020 01:35:27 -0500
Received: by mail-wr1-f44.google.com with SMTP id z11so2229078wro.9
        for <linux-btrfs@vger.kernel.org>; Sun, 01 Mar 2020 22:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CTBlPYOLCNDSEsztdYj9fhuS74+syUHBTb4qV7+toFw=;
        b=hZ5OWMzDC9IauOHYQtmaSvjOA+azM7t7C7ugUV+kbhPXSxhCqTtEK6EpJbnXTOjJIS
         fXQFkf1FOs9DyAjBax1dfGdXFpTwzogWBRcTV+PetQJXZnLxhTc7fhS/X/R0/16n/ASx
         Zm/52tKgl2NMgeN2Z1SUaDSK3nAWtk0BbYpx+5XOoBpKCEEH6m/l8hsSs0B9FRxiXnWI
         MaVZviO1gMK+ZuK71aIXyd0xYxj6Zy5VjCjtTvkR4B6sWYzKPfvHZ/h0Z4EPfBHcT249
         2FD24UD3h9qb+KT2UH4wOA+/jP4kSrPJPyP26HPxzZgeVs05t0nkLVuagFd2onmw/mJ5
         tZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CTBlPYOLCNDSEsztdYj9fhuS74+syUHBTb4qV7+toFw=;
        b=t+Tq6LBJ6cYfEGZ350UEjonRiktmVa8zCU3fy6A3Xtt0F+jFDHPCZubc9NC7P1gRZP
         mRUQ1/TZrkRAjgD2cE/buP1WcSDsZVaBiKYwurc5KPw5ruYVSfltYs6vGalJx16bt3ja
         /lhkpAWHMrdIR64r6tJvHu2XDDCYj8zTmnwWnNEceMUnZM+Zz/VWNZJqrmVbaoUMXGBB
         zNb1N022lDqvWGO2WGEH/5kyaVmSvyFn53MJTXqXH7pr4O7tYt3WcISytKSQogwd/0ki
         Bs1tkFV8OW1+UtuLUZs5ut8jKqW73aW4u0lqWL0HCg2yr4LneqwPrIOLpP4h6ZkMpLeK
         dGWg==
X-Gm-Message-State: APjAAAWXu2FY1Lp78ciEtefjqgWKrkIEXmUyW+9pbmg5lVsf0iBP5nvw
        C6bsne3bIQqVikOKEIwLXjNnd8MLPYcRZWC8485KD2Zy
X-Google-Smtp-Source: APXvYqz1xKeP87D40UPKIdExyndY/0QDHGVEY2f1S8TqoeGGbzA3nq5aBukychfUPwq6armxVUmj8vJRGfRFoNxBf6Y=
X-Received: by 2002:a5d:6881:: with SMTP id h1mr20011727wru.236.1583130923112;
 Sun, 01 Mar 2020 22:35:23 -0800 (PST)
MIME-Version: 1.0
References: <CADq=pg=g47zrfKiqGFUHOJg8=+bdSGQeawihKcVcp_BahzPT+Q@mail.gmail.com>
 <587446db-5168-d91d-c1fa-c7bef48959d9@gmx.com> <CADq=pgn3-4S3ErK0G+ajf-5M=8CSaE6iow25ASaBxCygedy=7g@mail.gmail.com>
 <2ffbf268-437c-b90e-21f3-7ea44aa9e7e6@gmx.com> <CADq=pgkuxOf7h=25Qice9q5Q-RiFXQiDzx0ZuEUCs4uN++3sxw@mail.gmail.com>
In-Reply-To: <CADq=pgkuxOf7h=25Qice9q5Q-RiFXQiDzx0ZuEUCs4uN++3sxw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 1 Mar 2020 23:35:07 -0700
Message-ID: <CAJCQCtR5t0-5q_R5Zn3fq39dFUj5uO0JYw3g-mfQ4mwuwLYEEw@mail.gmail.com>
Subject: Re: corrupt leaf
To:     4e868df3 <4e868df3@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 29, 2020 at 8:48 AM 4e868df3 <4e868df3@gmail.com> wrote:
>
> It came up with some kind of `840 abort`. Then I reran btrfs check and
> tried again.
>
> $ btrfs check --init-csum-tree /dev/mapper/luks0
> Creating a new CRC tree
> WARNING:
>
>         Do not use --repair unless you are advised to do so by a developer
>         or an experienced user, and then only after having accepted that no
>         fsck can successfully repair all types of filesystem corruption. Eg.
>         some software or hardware bugs can fatally damage a volume.
>         The operation will start in 10 seconds.
>         Use Ctrl-C to stop it.
> 10 9 8 7 6 5 4 3 2 1
> Starting repair.
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/luks0
> UUID: 8c1dea88-fa40-4e6e-a1a1-214ea6bcdb00
> Reinitialize checksum tree
> Unable to find block group for 0
> Unable to find block group for 0
> Unable to find block group for 0
> ctree.c:2272: split_leaf: BUG_ON `1` triggered, value 1
> btrfs(+0x71e09)[0x564eef35ee09]
> btrfs(btrfs_search_slot+0xfb1)[0x564eef360431]
> btrfs(btrfs_csum_file_block+0x442)[0x564eef37c412]
> btrfs(+0x35bde)[0x564eef322bde]
> btrfs(+0x47ce4)[0x564eef334ce4]
> btrfs(main+0x94)[0x564eef3020c4]
> /usr/lib/libc.so.6(__libc_start_main+0xf3)[0x7ff12a43e023]
> btrfs(_start+0x2e)[0x564eef30235e]
> [1]    840 abort      sudo btrfs check --init-csum-tree /dev/mapper/luks0
>
> $ btrfs check /dev/mapper/luks0
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/luks0
> UUID: 8c1dea88-fa40-4e6e-a1a1-214ea6bcdb00
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> there are no extents for csum range 68757573632-68757704704
> Right section didn't have a record
> there are no extents for csum range 68754427904-68757704704
> csum exists for 68750639104-68757704704 but there is no extent record
> there are no extents for csum range 68760719360-68761223168
> Right section didn't have a record
> there are no extents for csum range 68757819392-68761223168
> csum exists for 68757819392-68761223168 but there is no extent record
> there are no extents for csum range 68761362432-68761378816
> Right section didn't have a record
> there are no extents for csum range 68761178112-68836831232
> csum exists for 68761178112-68836831232 but there is no extent record
> there are no extents for csum range 1168638763008-1168638803968
> csum exists for 1168638763008-1168645861376 but there is no extent
> record
> ERROR: errors found in csum tree
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 3165125918720 bytes used, error(s) found
> total csum bytes: 3085473228
> total tree bytes: 4791877632
> total fs tree bytes: 1177714688
> total extent tree bytes: 94617600
> btree space waste bytes: 492319296
> file data blocks allocated: 3160334041088
>  referenced 3157401378816
>
> $ btrfs check --init-csum-tree /dev/mapper/luks0
> Creating a new CRC tree
> WARNING:
>
>         Do not use --repair unless you are advised to do so by a developer
>         or an experienced user, and then only after having accepted that no
>         fsck can successfully repair all types of filesystem corruption. Eg.
>         some software or hardware bugs can fatally damage a volume.
>         The operation will start in 10 seconds.
>         Use Ctrl-C to stop it.
> 10 9 8 7 6 5 4 3 2 1
> Starting repair.
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/luks0
> UUID: 8c1dea88-fa40-4e6e-a1a1-214ea6bcdb00
> Reinitialize checksum tree
> Unable to find block group for 0
> Unable to find block group for 0
> Unable to find block group for 0
> ctree.c:2272: split_leaf: BUG_ON `1` triggered, value 1
> btrfs(+0x71e09)[0x559260a6de09]
> btrfs(btrfs_search_slot+0xfb1)[0x559260a6f431]
> btrfs(btrfs_csum_file_block+0x442)[0x559260a8b412]
> btrfs(+0x35bde)[0x559260a31bde]
> btrfs(+0x47ce4)[0x559260a43ce4]
> btrfs(main+0x94)[0x559260a110c4]
> /usr/lib/libc.so.6(__libc_start_main+0xf3)[0x7f212eb1f023]
> btrfs(_start+0x2e)[0x559260a1135e]
> [1]    848 abort      sudo btrfs check --init-csum-tree /dev/mapper/luks0


A crash is a bug, but at least it didn't make the problem worse. I'm
not sure if 5.4.1 can do any better, but it's the current version.



-- 
Chris Murphy
