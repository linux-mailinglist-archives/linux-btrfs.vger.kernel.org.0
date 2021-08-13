Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2FFA3EB389
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Aug 2021 11:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239809AbhHMJuy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Aug 2021 05:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239370AbhHMJux (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Aug 2021 05:50:53 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A81C061756
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Aug 2021 02:50:27 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id a20so11252563plm.0
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Aug 2021 02:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=npju6duDfWR4M7/ATX/hEM2A8DrkxTY++6U/e3Gx3Bk=;
        b=N/RgqMn/rUUpmRH/O949tscnLkTB+vVexbvPfUDisteEt3vvPBU/uBZXcNDhZ6ln1B
         oPORzLoEB0TV4SrGomNfroZ6UyQJ5uCAGo9y4AniKQyv97oZPfRHAOZt1Hhx5nALl7Qg
         Nph9QBmxra344bi236GaUGrJNH9if8QlZZZzfIDqFAGumch3CCCf9Qi68+ppjGTO+lfS
         xUCtWFRs4lMngcF18SZ6+s2B85mltCi0eAqySiYsSujswlLPkF2LmY462xGF8n7p2tP1
         JraaXUsDMk/81V/4BFJAnOxBrE0Vg9Wr8Moit97e87Xdkn8dnehSe0Y9XlSQHOWZJreZ
         sOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=npju6duDfWR4M7/ATX/hEM2A8DrkxTY++6U/e3Gx3Bk=;
        b=WXmKRn1f6Ko1mMY8m8Zuhd2dU1ycyo2wSbBp4PYUJn9B33uBxc4zvM8G8f2jl4klUH
         skO6/QrAV/6ER0e0mcWZuis1FoZcOtuSc8kIG0FDJ+9Qm5X4577Vl9pjQ3BwgwBsatdH
         zwdMBCLbnJDEOa4YumR0iWYJIf6VDSjC+C07HpC1T6qcxFCr7h4rZi8MtTpR/2mMzm06
         zqY8lewbR+v9uROqyxXJjxjZP3DvCQK9Rs3gBX4Fn1xyiV4bXwHjDbL6wU3bjEGhHNf9
         KNdVUvXV/pWJeEW6sVTYlCxCI8ByOKICWt8uAuOWWlRinlAnt3cp2jv3OljoBXN55lBl
         ni7Q==
X-Gm-Message-State: AOAM531/1hi9Wk7ZTxcQ36Dc00MdDNkGc/5zvIAmFuPfQXoG/zLlxu+j
        81Xq8uPjxbIB+iqRPbfBcKbyEl+wxw/ESEimCtNIPenD5zw=
X-Google-Smtp-Source: ABdhPJyaipSzy5QV4Z98iRM0VGAdSn8aE4s+iyym9ziKHQKaZqxlAmYQXYn+icmqZz0hqNFX/c9hjrhfYOWuAD3isDo=
X-Received: by 2002:a17:903:22c7:b029:12c:4621:a2fd with SMTP id
 y7-20020a17090322c7b029012c4621a2fdmr1464350plg.61.1628848226425; Fri, 13 Aug
 2021 02:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <2729231.WZja5ltl65@ananda>
In-Reply-To: <2729231.WZja5ltl65@ananda>
From:   =?UTF-8?Q?Sebastian_D=C3=B6ring?= <moralapostel@gmail.com>
Date:   Fri, 13 Aug 2021 11:50:00 +0200
Message-ID: <CADkZQamczB9yqw_Eump8uJJ11ez_kmr2V=HU8S_vnO1Q-Ux9KA@mail.gmail.com>
Subject: Re: Corruption errors on Samsung 980 Pro
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

>It is BTRFS single profile on LVM on LUKS. Mount options are:

...

>I thought that a Samsung 980 Pro can easily handle "discard=async" so I
used it.

LUKS doesn't do discard unless you explicitly enable and force it. Have you?

Am Fr., 16. Juli 2021 um 17:10 Uhr schrieb Martin Steigerwald
<martin@lichtvoll.de>:
>
> Hello.
>
> I migrated to a different laptop and this one has a 2TB Samsung 980 Pro drive
> (not a 2TB Samsung 870 Evo Plus which previously had problems).
>
> I thought this time I would be fine, but I just got:
>
> [63168.287911] BTRFS warning (device dm-3): csum failed root 1372 ino 2295743 off 2718461952 csum 0x48be03222606a29d expected csum 0x0100000026004000 mirror 1
> [63168.287925] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
> [63168.346552] BTRFS warning (device dm-3): csum failed root 1372 ino 2295743 off 2718461952 csum 0x48be03222606a29d expected csum 0x0100000026004000 mirror 1
> [63168.346567] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
> [63168.346685] BTRFS warning (device dm-3): csum failed root 1372 ino 2295743 off 2718461952 csum 0x48be03222606a29d expected csum 0x0100000026004000 mirror 1
> [63168.346708] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 3, gen 0
> [63168.346859] BTRFS warning (device dm-3): csum failed root 1372 ino 2295743 off 2718461952 csum 0x48be03222606a29d expected csum 0x0100000026004000 mirror 1
> [63168.346873] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
> [63299.490367] BTRFS warning (device dm-3): csum failed root 1372 ino 2295743 off 2718461952 csum 0x48be03222606a29d expected csum 0x0100000026004000 mirror 1
> [63299.490384] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 5, gen 0
> [63299.572849] BTRFS warning (device dm-3): csum failed root 1372 ino 2295743 off 2718461952 csum 0x48be03222606a29d expected csum 0x0100000026004000 mirror 1
> [63299.572866] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 6, gen 0
> [63299.573151] BTRFS warning (device dm-3): csum failed root 1372 ino 2295743 off 2718461952 csum 0x48be03222606a29d expected csum 0x0100000026004000 mirror 1
> [63299.573168] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 7, gen 0
> [63299.573286] BTRFS warning (device dm-3): csum failed root 1372 ino 2295743 off 2718461952 csum 0x48be03222606a29d expected csum 0x0100000026004000 mirror 1
> [63299.573295] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 8, gen 0
> [63588.902631] BTRFS warning (device dm-3): csum failed root 1372 ino 4895964 off 34850111488 csum 0x21941ce6e9739bd6 expected csum 0xc113140701000000 mirror 1
> [63588.902647] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 13, gen 0
> [63588.949614] BTRFS warning (device dm-3): csum failed root 1372 ino 4895964 off 34850111488 csum 0x21941ce6e9739bd6 expected csum 0xc113140701000000 mirror 1
> [63588.949628] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 14, gen 0
> [63588.949849] BTRFS warning (device dm-3): csum failed root 1372 ino 4895964 off 34850111488 csum 0x21941ce6e9739bd6 expected csum 0xc113140701000000 mirror 1
> [63588.949855] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 15, gen 0
> [63588.950087] BTRFS warning (device dm-3): csum failed root 1372 ino 4895964 off 34850111488 csum 0x21941ce6e9739bd6 expected csum 0xc113140701000000 mirror 1
> [63588.950099] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 16, gen 0
>
> during a backup.
>
> According to rsync this is related (why does BTRFS does not report the
> affected file?)
>
> Create a snapshot of '/home' in '/zeit/home/backup-2021-07-16-16:40:13'
> rsync: [sender] read errors mapping "/zeit/home/backup-2021-07-16-16:40:13/martin/.local/share/akonadi/search_db/email/postlist.glass": Input/output error (5)
> rsync: [sender] read errors mapping "/zeit/home/backup-2021-07-16-16:40:13/martin/.local/share/akonadi/search_db/email/postlist.glass": Input/output error (5)
> ERROR: martin/.local/share/akonadi/search_db/email/postlist.glass failed verification -- update discarded.
> rsync: [sender] read errors mapping "/zeit/home/backup-2021-07-16-16:40:13/martin/.local/share/baloo/index": Input/output error (5)
> rsync: [sender] read errors mapping "/zeit/home/backup-2021-07-16-16:40:13/martin/.local/share/baloo/index": Input/output error (5)
> ERROR: martin/.local/share/baloo/index failed verification -- update discarded.
>
> Both are frequently written to files (both Baloo and Akonadi have very crazy
> I/O patterns that, I would not have thought so, can even satisfy an NVMe SSD).
>
> I thought that a Samsung 980 Pro can easily handle "discard=async" so I
> used it.
>
> This is on a ThinkPad T14 Gen1 with AMD Ryzen 7 PRO 4750U and 32 GiB of RAM.
>
> It is BTRFS single profile on LVM on LUKS. Mount options are:
>
> rw,relatime,lazytime,compress=zstd:3,ssd,space_cache=v2,subvolid=1054,subvol=/home
>
> Smartctl has no errors.
>
> I only use a few (less than 10) subvolumes.
>
> I do not have any other errors in kernel log, so I bet this may not be
> "discard=async" related. Any idea?
>
> Could it have to do with a sudden switching off the laptop (there had
> been quite some reasons cause at least with a AMD model of this laptop
> in combination with an USB-C dock by Lenovo there are quite some stability
> issues)? I would have hoped that the Samsung 980 Pro would still be
> equipped to complete the outstanding write operation, but maybe it has
> no capacitor for this.
>
> I am really surprised by the what I experienced about the reliability of
> SSDs I recently bought. I did not see a failure within a month with any
> of the older SSDs. I hope this does not point at a severe worsening of
> the quality. Probably I have to fit another SSD in there and use BTRFS
> RAID 1 again to protect at least part of the data from errors like this.
>
> Any idea about this? I bet you may not have any, as there is not block
> I/O related errors in the log, but if you have, by all means share your
> thoughts. Thank you.
>
> Both files can be recreated. So I bet I will just remove them.
>
> Best,
> --
> Martin
>
>
