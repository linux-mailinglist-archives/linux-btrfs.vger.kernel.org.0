Return-Path: <linux-btrfs+bounces-10373-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 134B29F2027
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2024 18:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6B11670BF
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2024 17:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219491A0721;
	Sat, 14 Dec 2024 17:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/VXBJAB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8321D19FA7C
	for <linux-btrfs@vger.kernel.org>; Sat, 14 Dec 2024 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734197967; cv=none; b=TPrw6wqhQTbYoXopTfYEzpicTrPYibtcRcFHaLeHzhZ3YTFsFI2QdLhPi2rWES4iL4b44wQaenr+zSs804o42mBhHbs7Mq58P9HPtD29KouUKwwlwYJBxwKmWvfgBl40ooL8x3LlVr/DXYs6/B6Isg2QIQffKQouy3yiOGH6Quw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734197967; c=relaxed/simple;
	bh=TJKeZagYzVD4Enw/FTgYml+z9qC3qCR/veV2vYCOY/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lzJegPSHUognBe4F5WNZCE2C1plo63JpzC9GU21m1yyeflCM05/diN8NCHSgAMOnHNAKVLXWrJZzjgr6YX7Lx7DCyQmg/0gLZrvGcg5pjt+99jG6j2edWvlmMQJjCbAG2D0i7iwR95PqbF1mBezXzlCsJ343spuWm28tFEtWg/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/VXBJAB; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7fc99fc2b16so1896781a12.3
        for <linux-btrfs@vger.kernel.org>; Sat, 14 Dec 2024 09:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734197965; x=1734802765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+l5yn5aZa4c0GSH4nkKPVc4daZyqWY3rprOLvCPMuhE=;
        b=f/VXBJABrbneIit6Iuolbc+vepnECTpvyHHZNOBIIx7D9F+htJPdq1Zx1E10wyvXCL
         Cr2upLm59dLC3S/v+6H82jtGatcTmNXcWpFFeSQSr7EToAOjKuCXv2Apa4iantEzDwe0
         3AR+a4IjcMm4Cg1fuxcZnBvTiKuJiUV2mMaTf4IAH75noEyb+65Ew/9LdpPPUZdgTad6
         rv5S7Je+jNNc7GNJDmEW9dI5R/B72dC3CKwykbBpXjNI1/ok8n7x0G4V7Gs1oRxgj585
         8/pJafJRSFyDDwAze2IUG/Q/6Uyl9XChU37dWGhejco85TpVBwXbDPOM/3DLmUw/1En7
         gYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734197965; x=1734802765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+l5yn5aZa4c0GSH4nkKPVc4daZyqWY3rprOLvCPMuhE=;
        b=gnj6TuwBdmuNrrlvp9Q0fyPVJXgj2VFRr/2Bve08vlICAQK7ldLBp2EQYXIT6MtO9V
         rkkgFfhSEV5RKweBpihBFdNwcUt7rf2X0Rxg2NjZSgQG+pJP+5bojwIugv1//TlTSAAc
         x00bx90VUFZv25W+r70NBbzahczVXUfHWlNO+l2z1dJtH6W7REw9++9m+yDygNG35jzm
         79hDWXU1Ox+n4v9odEUphyqdtjHcI08iEy/jIozQ70sklLmP/fZICIrMt+KNj8kI+GKW
         Ebc7KhfAIAcNOCMLQFyUqoKk7OVnQbop2pSoPnrjiZQ5Owz3ZVNkcE3u7nG8kod+y1ex
         N2zw==
X-Gm-Message-State: AOJu0YxIrRozu6EiDFq/RUbhQmge1s0sfpRrZMsvCXpRbCTM/5uXVlC0
	Fjl6s5I/LI8wanRVTShw/12lN2cXfzPhjEWzdxTSHyDsJYHIVS1DY8UTQdGvUdBKBgN74oTwely
	KE1m1vu7EJt2zGFaoWYl6Me9ptRWd/M8CXFc=
X-Gm-Gg: ASbGnct3Amc03Ynb6OW32uQHBDuitK5avB+ayzQs+W6TCoy3SiesF2kLYQv891iQIVQ
	0bzCcKW54MjYZl03FVwXn7rCHSvAcfK49ncYU1g2Hzu0XH2HWi4OuNrbN51eelAbG9GU=
X-Google-Smtp-Source: AGHT+IEvpg8bBVZsO1aaSPtsEYZauYBB6FYFuEHRoAwecy8t+MMjYLVxfB2V6Baxo/OSlO8O1sxyVQoi4VaBrqLNqUA=
X-Received: by 2002:a17:90b:2807:b0:2ee:6263:cc0c with SMTP id
 98e67ed59e1d1-2f2901b7d57mr10804907a91.37.1734197964695; Sat, 14 Dec 2024
 09:39:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJhrHS2b5fv7wmchdqkCy-jEWZ7hD_3YUgCO_oUCNaf9ossq6w@mail.gmail.com>
 <56d3885e-5651-4fd4-af6d-89897f8bd240@gmx.com>
In-Reply-To: <56d3885e-5651-4fd4-af6d-89897f8bd240@gmx.com>
From: Ben Millwood <thebenmachine@gmail.com>
Date: Sat, 14 Dec 2024 17:39:13 +0000
Message-ID: <CAJhrHS1xgfrp=Wpk18xCBGUEi2tYxaqCxrMQG5UEGSUbR4G-_w@mail.gmail.com>
Subject: Re: dev extent physical offset [...] on devid 1 doesn't have
 corresponding chunk
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 14 Dec 2024 at 02:51, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> Both kernel and btrfs-progs should go with metadata COW with transaction
> protection, so even something went wrong (power loss or Ctrl-C) we
> should only see the previous transaction, thus everything should be fine.

Thanks for the reassurance, that is what I'd hoped would be true :)

> =E5=9C=A8 2024/12/14 12:47, Ben Millwood =E5=86=99=E9=81=93:
> > While I'm waiting for the lowmem check to progress, are there any
> > other useful recovery / diagnosis steps I could try?
>
> If you do not want to waste too long time on btrfs check, please dump
> the device tree and chunk tree:
>
> # btrfs ins dump-tree -t chunk <device>
> # btrfs ins dump-tree -t dev <device>
>
> That's all the info we need to cross-check the result.
>
> Although `btrfs check --readonly --mode=3Dlowmem` would be the best, as i=
t
> will save me a lot of time to either manually verify the output or craft
> a script to do that.

Well, the check is still going:

root@vigilance:~# btrfs check --progress --mode lowmem /dev/masterchef-vg/b=
trfs
Opening filesystem to check...
Checking filesystem on /dev/masterchef-vg/btrfs
UUID: a0ed3709-1490-4f2d-96b5-bb1fb22f0b45
[1/7] checking root items                      (0:46:43 elapsed,
68928137 items checked)
[2/7] checking extents                         (14:31:49 elapsed,
239591 items checked)

I'll let it continue. In the meantime I'll e-mail you the trees you
asked for off-thread: they don't obviously look like they contain
private information, but I'd like to minimise the exposure anyway.
(Feel free to send them to other btrfs devs.)

On Sat, 14 Dec 2024 at 02:51, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> =E5=9C=A8 2024/12/14 12:47, Ben Millwood =E5=86=99=E9=81=93:
> > Hi folks,
> >
> > I encountered this error recently, and I can't find it anywhere on
> > Google except in the patches that first added the check, so I come to
> > you for guidance.
> >
> > This is one of my removable USB drives, formatted btrfs and primarily
> > for the purpose of receiving snapshots from my laptop's root drive.
> > I'm running:
> >
> > $ mount /dev/masterchef-vg/btrfs /mnt/masterchef/btrfs -o compress
> > mount: /mnt/masterchef/btrfs: mount(2) system call failed: Structure
> > needs cleaning.
> >         dmesg(1) may have more information after failed mount system ca=
ll.
> >
> > Here's what dmesg says:
> >
> > [13570.361767] BTRFS info (device dm-4): first mount of filesystem
> > a0ed3709-1490-4f2d-96b5-bb1fb22f0b45
> > [13570.361779] BTRFS info (device dm-4): using crc32c (crc32c-intel)
> > checksum algorithm
> > [13570.361783] BTRFS info (device dm-4): use zlib compression, level 3
> > [13570.361785] BTRFS info (device dm-4): disk space caching is enabled
> > [13570.374442] BTRFS error (device dm-4): dev extent physical offset
> > 1997265698816 on devid 1 doesn't have corresponding chunk
> > [13570.374448] BTRFS error (device dm-4): failed to verify dev extents
> > against chunks: -117
> > [13570.375329] BTRFS error (device dm-4): open_ctree failed
>
> The problem is exactly what it said, there is an dev-extent but no chunk
> item for it.
>
> I'm wondering if there a chunk without its dev extent.
>
> >
> > This issue emerged around the time I was trying to mount this
> > filesystem from my Raspberry Pi for the first time, but now occurs on
> > both my own laptop and my rpi.
> >
> > Here's my laptop's details:
> >
> > $ uname -a
> > Linux noether 6.6.63 #1-NixOS SMP PREEMPT_DYNAMIC Fri Nov 22 14:38:37
> > UTC 2024 x86_64 GNU/Linux
> >
> > $ btrfs --version
> > btrfs-progs v6.11
> > -EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED CRYPTO=
=3Dbuiltin
> >
> > $ btrfs fi show
> > Label: 'noether-root'  uuid: b7ad9a05-8f7b-44af-8952-a7f717e897e0
> >      Total devices 1 FS bytes used 319.96GiB
> >      devid    1 size 390.62GiB used 390.62GiB path /dev/mapper/noether-=
lv
> >
> > Label: 'masterchef-btrfs'  uuid: a0ed3709-1490-4f2d-96b5-bb1fb22f0b45
> >      Total devices 1 FS bytes used 1.62TiB
> >      devid    1 size 1.82TiB used 1.82TiB path /dev/mapper/masterchef--=
vg-btrfs
> >
> > and the rpi:
> >
> > $ uname -a
> > Linux vigilance 6.6.62+rpt-rpi-2712 #1 SMP PREEMPT Debian
> > 1:6.6.62-1+rpt1 (2024-11-25) aarch64 GNU/Linux
> >
> > $ btrfs --version
> > btrfs-progs v6.2
> >
> > (btrfs fi show is the same for masterchef-btrfs)
> >
> > In terms of possible events that could have caused this:
> > 1. I had some issues with the raspberry pi not being able to supply
> > enough power for 2 external disks, and for this and related reasons
> > it's possible the disk got disconnected without being unmounted
> > properly / the pi was uncleanly shut down a few times (though, I
> > expect I usually didn't actually write to the disk any of these
> > times...)
> > 2. When I try to mount on the raspberry pi, I see this in dmesg:
> >
> > [ 5658.798634] BTRFS info (device dm-2): first mount of filesystem
> > a0ed3709-1490-4f2d-96b5-bb1fb22f0b45
> > [ 5658.798653] BTRFS info (device dm-2): using crc32c (crc32c-generic)
> > checksum algorithm
> > [ 5658.798663] BTRFS info (device dm-2): use zlib compression, level 3
> > [ 5658.798666] BTRFS info (device dm-2): disk space caching is enabled
> > [ 5658.798669] BTRFS warning (device dm-2): v1 space cache is not
> > supported for page size 16384 with sectorsize 4096
> > [ 5658.798706] BTRFS error (device dm-2): open_ctree failed
> >
> > so I went and looked up what the "v1 space cache" was, and ran this:
> >
> > $ btrfs check --clear-space-cache v1 <device>
> >
> > and then read some more -- oh, nowadays it's a btrfs rescue command
> > instead, so I ctrl-C'd the above and ran:
> >
> > $ btrfs rescue clear-space-cache v1 <device>
> >
> > which appeared to complete successfully.
> >
> > (I suppose despite seeing this message on the pi, I must have run
> > these commands on my laptop, since my pi's btrfs-progs doesn't have
> > the rescue clear-space-cache command.)
> >
> > Anyway, maybe ctrl-C-ing the btrfs check --clear-space-cache was wrong?
>
> It should not, if so then it's a bug in the code.
>
> Both kernel and btrfs-progs should go with metadata COW with transaction
> protection, so even something went wrong (power loss or Ctrl-C) we
> should only see the previous transaction, thus everything should be fine.
>
> >
> > It's noticeable that the dmesg output, at least on the raspberry pi,
> > still mentions the v1 space cache message when trying to mount, unless
> > I pass the nospace_cache mount option, in which case I get the "failed
> > to verify dev extents" message. (I think I get the latter message in
> > either case on my laptop with the newer kernel + btrfs-progs).
> >
> > A natural thing to do at this stage would be to run btrfs check, but
> > the non-lowmem version is always OOM-killed (on either device) while
> > checking extents, and the lowmem version has so far not had time to
> > complete (and I'm not convinced it will in a reasonable duration). I
> > could try to borrow a machine with more RAM, though I have no idea
> > whether I need 20% more RAM or 20x more. (The pi is 8G, the laptop is
> > 16G, the btrfs partition I'm checking is ~2T.)
>
> Then I'd say 32G may be enough, but lowmem should always work.
>
> >
> > While I'm waiting for the lowmem check to progress, are there any
> > other useful recovery / diagnosis steps I could try?
>
> If you do not want to waste too long time on btrfs check, please dump
> the device tree and chunk tree:
>
> # btrfs ins dump-tree -t chunk <device>
> # btrfs ins dump-tree -t dev <device>
>
> That's all the info we need to cross-check the result.
>
> Although `btrfs check --readonly --mode=3Dlowmem` would be the best, as i=
t
> will save me a lot of time to either manually verify the output or craft
> a script to do that.
>
> My current assumption is a bitflip at runtime, but no proof yet.
>
> Thanks,
> Qu
>
> > smartctl appears
> > not to work with this disk, so I can't easily say whether the disk is
> > or is not healthy.
> >
>

