Return-Path: <linux-btrfs+bounces-10370-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D22139F1C10
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2024 03:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E599716280F
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2024 02:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B138A1773A;
	Sat, 14 Dec 2024 02:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjJQZVJC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC871C36
	for <linux-btrfs@vger.kernel.org>; Sat, 14 Dec 2024 02:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734142649; cv=none; b=IOhWKu1f/yAal0/rMjNuoBOKkN1MwuYECvNREq88s5s7gIUXnwK2K7SXA/wDFBZVRHjSafgUt/n0cKT1Et8vv+ElSAHwAQVViDFggZnyNrVdBCcoATTCOsSv7rTiI+nRlVc403TsIXBL+0TzkWp4dMlTRifnM+kscftFfpZWp6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734142649; c=relaxed/simple;
	bh=V22PEQk3WtAPwJsDne0CVPwkN67lV6i92F4+du6pouY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=bHC4x01qvVin86fbYZ8R3nQ8jJUj//S2iPetf4mILAb6TqimfLA/DRq7MUurOSEYDabivVIwyUwMhqZyawFGqUJP///v2fma6AnVjvmc00EniyKA6odixki9P+OqkhLP+pdH2/XnEOQ1glhHVYUJoL6QCKRsm5G0k/oMes/vAZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjJQZVJC; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ef89dbd8eeso1560469a91.0
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 18:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734142647; x=1734747447; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dv5IDNxnf17pbmW5KiHN1lMf6+syFR8TVGe9SbMBHEI=;
        b=hjJQZVJCxRDNUJafzQjCln8206i96pjVNHCbSlidrMDiive3CEd6fhE5RCoukZlFIn
         93Y1gY9umnXxFUWzIPYz8vX7Ux0/COvjXGEFCxrrBEa1UwWdFcCmAPZS6j1DJx5iKbME
         pv/GRCcms3b9MpJtKzrFawBnEIVg3KHS6zyEXI6U92BBt8Kv+rlLECENHFNU7HhK7/8p
         D0/AVRkGn4z7wbCh9DGFB6+rgtidRc7pVrm9TwDdFIshjEJGZE6zEXee39oBKUBQ0X+w
         VnDWZTXk7RyYHZICT2NCCDua3SVVqbVQOo1wYuPu3hf/b1sd/IlxiJ37P/94+KBc9LwB
         KBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734142647; x=1734747447;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dv5IDNxnf17pbmW5KiHN1lMf6+syFR8TVGe9SbMBHEI=;
        b=jLeOlEUMiiywnUSaCuH7oeGaCG6Drm1E2lbXk7XlLMCfAA+fplShLxxzPAERbvnpkl
         Z5+Bz20ddxyrFyP30LRNeTkeuCaeJd3A1Oq0gDnDMRZ4AEHz/qfLyYphpyLOJ2oUMH/n
         db8O+RlKHogA0+wKb84WlQIPn2bXZjM/mCZO3YQ7ihrj6F3qcV8HyZe8UcgkGbNWu+Bt
         jde+5PvzXC1QkkcHYk9pHpinbs5c93jO5YKGSmrPsi31gf5m7SxGTFTrybrx+gHI9W7X
         v6Dyb5Oo7Z7l7GyrfqnYrWXyUu/dL9xzKw/Ry4nFeEZ9DzGf5D0+8onjKWcKKSxjEXzN
         VHHA==
X-Gm-Message-State: AOJu0YwPezIRyIlmHy9JFaK6kWd2UE1Xl+jVTy7sVtntM/QdUjI2GwgK
	D6l8cwkAuvoFuIPcTYMvoQvLymA1d8WCBtpGIUgB55/3akH2w98w4l/fY6EXdJ8h90C3wYBs6jr
	FF3/0qNdw2+lO9unkrUKp3y5Tx7DX12W9V6A=
X-Gm-Gg: ASbGnct9LVZdQa4ehM1kzCcCI00v3jhu11opRuA5GBDCogIp/0tLENM2o+4kOpIz1Bf
	qEfUROwNoyOFIbyfs910dAH+4bqSs3vqzjwePj7xL2mGrYh9E5gdAG1TInVHV0kGgqOjO
X-Google-Smtp-Source: AGHT+IEkLn81MMrRqVZXUvf8+Ck68Rlbj+hj/KUc/IlV348XmZARDrxaMb1TRaKHn33IuH1ELhLUKuDdhGj64v87En0=
X-Received: by 2002:a17:90b:1d51:b0:2ef:114d:7bf8 with SMTP id
 98e67ed59e1d1-2f28fa50ff0mr6775325a91.6.1734142647093; Fri, 13 Dec 2024
 18:17:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ben Millwood <thebenmachine@gmail.com>
Date: Sat, 14 Dec 2024 02:17:15 +0000
Message-ID: <CAJhrHS2b5fv7wmchdqkCy-jEWZ7hD_3YUgCO_oUCNaf9ossq6w@mail.gmail.com>
Subject: dev extent physical offset [...] on devid 1 doesn't have
 corresponding chunk
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi folks,

I encountered this error recently, and I can't find it anywhere on
Google except in the patches that first added the check, so I come to
you for guidance.

This is one of my removable USB drives, formatted btrfs and primarily
for the purpose of receiving snapshots from my laptop's root drive.
I'm running:

$ mount /dev/masterchef-vg/btrfs /mnt/masterchef/btrfs -o compress
mount: /mnt/masterchef/btrfs: mount(2) system call failed: Structure
needs cleaning.
       dmesg(1) may have more information after failed mount system call.

Here's what dmesg says:

[13570.361767] BTRFS info (device dm-4): first mount of filesystem
a0ed3709-1490-4f2d-96b5-bb1fb22f0b45
[13570.361779] BTRFS info (device dm-4): using crc32c (crc32c-intel)
checksum algorithm
[13570.361783] BTRFS info (device dm-4): use zlib compression, level 3
[13570.361785] BTRFS info (device dm-4): disk space caching is enabled
[13570.374442] BTRFS error (device dm-4): dev extent physical offset
1997265698816 on devid 1 doesn't have corresponding chunk
[13570.374448] BTRFS error (device dm-4): failed to verify dev extents
against chunks: -117
[13570.375329] BTRFS error (device dm-4): open_ctree failed

This issue emerged around the time I was trying to mount this
filesystem from my Raspberry Pi for the first time, but now occurs on
both my own laptop and my rpi.

Here's my laptop's details:

$ uname -a
Linux noether 6.6.63 #1-NixOS SMP PREEMPT_DYNAMIC Fri Nov 22 14:38:37
UTC 2024 x86_64 GNU/Linux

$ btrfs --version
btrfs-progs v6.11
-EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED CRYPTO=builtin

$ btrfs fi show
Label: 'noether-root'  uuid: b7ad9a05-8f7b-44af-8952-a7f717e897e0
    Total devices 1 FS bytes used 319.96GiB
    devid    1 size 390.62GiB used 390.62GiB path /dev/mapper/noether-lv

Label: 'masterchef-btrfs'  uuid: a0ed3709-1490-4f2d-96b5-bb1fb22f0b45
    Total devices 1 FS bytes used 1.62TiB
    devid    1 size 1.82TiB used 1.82TiB path /dev/mapper/masterchef--vg-btrfs

and the rpi:

$ uname -a
Linux vigilance 6.6.62+rpt-rpi-2712 #1 SMP PREEMPT Debian
1:6.6.62-1+rpt1 (2024-11-25) aarch64 GNU/Linux

$ btrfs --version
btrfs-progs v6.2

(btrfs fi show is the same for masterchef-btrfs)

In terms of possible events that could have caused this:
1. I had some issues with the raspberry pi not being able to supply
enough power for 2 external disks, and for this and related reasons
it's possible the disk got disconnected without being unmounted
properly / the pi was uncleanly shut down a few times (though, I
expect I usually didn't actually write to the disk any of these
times...)
2. When I try to mount on the raspberry pi, I see this in dmesg:

[ 5658.798634] BTRFS info (device dm-2): first mount of filesystem
a0ed3709-1490-4f2d-96b5-bb1fb22f0b45
[ 5658.798653] BTRFS info (device dm-2): using crc32c (crc32c-generic)
checksum algorithm
[ 5658.798663] BTRFS info (device dm-2): use zlib compression, level 3
[ 5658.798666] BTRFS info (device dm-2): disk space caching is enabled
[ 5658.798669] BTRFS warning (device dm-2): v1 space cache is not
supported for page size 16384 with sectorsize 4096
[ 5658.798706] BTRFS error (device dm-2): open_ctree failed

so I went and looked up what the "v1 space cache" was, and ran this:

$ btrfs check --clear-space-cache v1 <device>

and then read some more -- oh, nowadays it's a btrfs rescue command
instead, so I ctrl-C'd the above and ran:

$ btrfs rescue clear-space-cache v1 <device>

which appeared to complete successfully.

(I suppose despite seeing this message on the pi, I must have run
these commands on my laptop, since my pi's btrfs-progs doesn't have
the rescue clear-space-cache command.)

Anyway, maybe ctrl-C-ing the btrfs check --clear-space-cache was wrong?

It's noticeable that the dmesg output, at least on the raspberry pi,
still mentions the v1 space cache message when trying to mount, unless
I pass the nospace_cache mount option, in which case I get the "failed
to verify dev extents" message. (I think I get the latter message in
either case on my laptop with the newer kernel + btrfs-progs).

A natural thing to do at this stage would be to run btrfs check, but
the non-lowmem version is always OOM-killed (on either device) while
checking extents, and the lowmem version has so far not had time to
complete (and I'm not convinced it will in a reasonable duration). I
could try to borrow a machine with more RAM, though I have no idea
whether I need 20% more RAM or 20x more. (The pi is 8G, the laptop is
16G, the btrfs partition I'm checking is ~2T.)

While I'm waiting for the lowmem check to progress, are there any
other useful recovery / diagnosis steps I could try? smartctl appears
not to work with this disk, so I can't easily say whether the disk is
or is not healthy.

