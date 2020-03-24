Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80A071906DB
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Mar 2020 08:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgCXHyb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Mar 2020 03:54:31 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:33857 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgCXHyb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Mar 2020 03:54:31 -0400
Received: by mail-lj1-f170.google.com with SMTP id s13so17556001ljm.1
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Mar 2020 00:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=T2Vp276vr4bomxrMoAx+EhxLAG2ej52ksMnEj9eQBsg=;
        b=nGgLtU7BGp+L6LYiwMhao3TnG2cpUl8CHjs6ICVcLsWHEH85YI7fb8mMk/ROgqHhbu
         lsUBrxQ3e+DArTMU9twysvtmDU5T+Hzjj/IWsFS5fp860xsED1NAVYFhsH/PVaq/nzjH
         NyUwpuwXYZ4W6y0PSQ7qkfFGiEDTs03MOX7LbW4XRhtd2JDARx6XDOsFI7e8wsVOORO3
         +8vZT0/hijbiXFbNL2IBh86ITH1ggpkaWi8m7H3O/PBHmHtQNc7blghAKjgOM2NARtNP
         ps8vuFl+wdvlVMcUelbVgZpeTILz3rH2aMRMmSQeLcJ8YltFKjDl4C9MjAWeBqBrIKS1
         k7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=T2Vp276vr4bomxrMoAx+EhxLAG2ej52ksMnEj9eQBsg=;
        b=ZO/Y8amDNVbF8at+IBMK88Pnqlv9nFmk9RynYp4ZtjDudFDMg+FmQdHLW7AAQgrp8I
         jqURJtBcaAUmkYClcICQE5jl+q3nWgwou/xywEfriK/8mNH0Ru/UAczfde1Ted96Xn2T
         HhjQWOczUvQk3RE/7QK1ukjpxeStNHQU5Y3U79TR+dYsxVqzBiDfuunmLR3ssSp0kqm2
         qILc8eSl4mP/+4t+4QehGOhcOxSsD8it2flxT4F5iukTqsgF+ZgAzt6tRX7+XdPJoDXP
         GbOA+5VpQqihYwn7GdfLaOqjRval/trkdUTG0o9nn3wXf6MWqqtwcANrZRX6VLoBUOVt
         oKuA==
X-Gm-Message-State: ANhLgQ0T8BKFzX3mC0gJkQzzhkufHQm8IYZP1F8lVKcTUCOA6tg5yAkW
        R+FEoRHCN5XSKxrk4jy6Isg93/eJWP1R3MUWmJuEf0Pd
X-Google-Smtp-Source: ADFU+vvXSIzQrZBirmPkzGfjmCtPPV0Zz5Jq4k7A6+GBr7y6SItqgP9mRdf5TokLXoApGTAAMtscOtygt6P2LiD3AHQ=
X-Received: by 2002:a2e:93c9:: with SMTP id p9mr15649471ljh.136.1585036468369;
 Tue, 24 Mar 2020 00:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAPuGWB8Aqvr6po0-nJskh_5W3rUv1+y2P2U-pYMAJ_wwKnLjkA@mail.gmail.com>
 <CAJCQCtTGo_phSJ+rw4Y6nqsDrcmQdLDMX4osQ=4kZe5yZc21Ug@mail.gmail.com> <CAPuGWB-XyYya263K2gWriv5sGVLQbbzpKD3R01GkxiwNw-LdTA@mail.gmail.com>
In-Reply-To: <CAPuGWB-XyYya263K2gWriv5sGVLQbbzpKD3R01GkxiwNw-LdTA@mail.gmail.com>
From:   Carsten Behling <carsten.behling@googlemail.com>
Date:   Tue, 24 Mar 2020 08:54:18 +0100
Message-ID: <CAPuGWB_D-waGWv4YNsF9N0dbnA+2ztJvMjmxs9PK5qG_PUFU7Q@mail.gmail.com>
Subject: Fwd: How do damaged root trees happen and how to protect against
 power cut?
To:     linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

---------- Forwarded message ---------
Von: Carsten Behling <carsten.behling@googlemail.com>
Date: Di., 24. M=C3=A4rz 2020 um 08:51 Uhr
Subject: Re: How do damaged root trees happen and how to protect
against power cut?
To: Chris Murphy <lists@colorremedies.com>


Carsten Behling <carsten.behling@googlemail.com>

Mo., 23. M=C3=A4rz, 16:58 (vor 15 Stunden)
an Chris
> Seed device?
>
> Create a Btrfs file system, use space_cache v2,
> compress-force=3Dzstd:16, and write the root image. Resize the file
> system to minimum. Set the seed flag. That's the base image. Part of
> the provisioning will be to 'btrfs device add' a 2nd partition, and
> remount read-write. This means two Btrfs file systems exist, each with
> their own UUID. You can reference the read-only seed by its UUID; and
> you can reference the read-write volume by its own UUID. On-disk
> metadata for this read-write volume points to both the read-only seed
> devid1, and the writable 2nd device devid2.
>
> Make sure write cache on the physical media is disabled.

Are this the correct steps in detail:

1. Partition SD card with:
- (write Bootloader ...)
- first partition boot (FAT32 (0x0b), 50MB)
- second partition (Linux Native (0x83), minimum possible size to fit rootf=
s)
- third partition (Linux Native (0x83), rest
- (write boot files (kernel ...))

2. Create seed device on development host:

# mkfs.btrfs --rootdir ~/rootfs --shrink /dev/sda2 # sda is my SD card devi=
ce
# btrfstune -S 1 /dev/sda2
# dd if=3D/dev/zero of=3D/dev/sda3 bs=3D1024
# mount /dev/sda2 /mnt
# btrfs device add /dev/sda3 /mnt
# hdparm -W 0 /dev/sda3 # disable write cache

3. Mount on embedded device

- Kernel command line option: "root=3D/dev/mmcblk0p2 ro rootwait"
- Later, 'systemd-remount-fs.service' remounts seed device 'rw' by
appliying mmount options from fstab:
...
# 'defaults' includes 'rw', 'ROOT' is /dev/mmcblk0p2 (seed device)
LABEL=3DROOT       /                    btrfs
defaults,noatime,nodiratime,space_cache=3Dv2,compress-force=3Dzstd:16
 1  1
...

Is this correct?

Regards
Carsten
