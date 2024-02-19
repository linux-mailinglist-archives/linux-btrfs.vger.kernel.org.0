Return-Path: <linux-btrfs+bounces-2479-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31214859AD7
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 03:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB001C20D83
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 02:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8104D23BD;
	Mon, 19 Feb 2024 02:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAKNOIZM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FE31FC8
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 02:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708311316; cv=none; b=MwmIkxQAtWgqpZMQZuAmWucMGKq/f6FhbzEQN/c7+ryKJVbFm8IEmnAAlt+jir0qtl+DCuJeaqXINT83ULebPMbTDkNLu60g+Wc/8QRF2I8QuxWcOF3KbMsDSbiHHPBV/7UqhktUdDZsU2+vk0RCjJGvw8wRs3NgGCiLCZshyV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708311316; c=relaxed/simple;
	bh=np+fSNY4Fyv6gOC1+bva0G1kgQohdVEMr/yi3OVovns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=mJcFWwkYYSGJhXTae7c7GT3F/Jkrlxktlw3SdxfWB6orc0C9nMUI2eBwkCGZRmxnApoARAUT3YLXm9I7hvt9M+D3sn2F0wr5UGPunWuKSVCegtC7e/nU4Y/WrG/3IJOuUqGxCJQlAu/iQ0htJeWdehOboQTcN6PIRKvGatAcJWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAKNOIZM; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d21a68dd3bso31890151fa.1
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Feb 2024 18:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708311312; x=1708916112; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8G/VkrBvxQ2tJzygfFaOFz6a9Cz/of2dMWzbtP7HjQs=;
        b=OAKNOIZMFwFkbIkC/222Z155bDAy3MsY4V6pOGUusKNOp4AasRfy2kpMA/yOaQxnKw
         n5BTlzGeHAEXeMWoFZUa1BNJBgJZjmjETAa0A642D32MsuNUxZ5jz9xJtjt3XzcrT8tg
         pg8BgB+0TdhBjsq3EoKM+nyTrAIHGNQvfU/AhhCSbkTNkSAKnn560pKjBMmlY1rOcESx
         p6DGZlibM9IMJ3sYFsrCZz/rUfRAW4cP8XsRa+OWlK+VFSExNWWP60zLomrD94EDh0x3
         9eu16LAiE5ud2j7JTtbTs+GPaRDLDawruBzKxI4Hb8sX5OWMPJIuNn2ContmWAeJT1+c
         hk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708311312; x=1708916112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8G/VkrBvxQ2tJzygfFaOFz6a9Cz/of2dMWzbtP7HjQs=;
        b=KJWge9EYBm69MhfHD0TmV5ViBhqhZGAeQ33aos28+bkzzGVxTVOQnKXzf+bEO/NMf8
         nIp7JBzspoDr8+Dts+Ya00Ns4Z5BA/fib1sK2vgZ8n6k18xMMzECCpP56bQr0ftXYkNX
         KNc14U51aAQW1CYLq/24zYIdNas3LGcgzvYglnRLTPG1mqXNif+riZD1U57elscVnBav
         ZrcBMO05nX6uoAVRoU1CIq8vQnLuiI0HOUBit+wMV3pbfPR7ZH3YyT0BP3uMh9EkHLOr
         OGgGxLEPk7uxB1xNIe5Q7ZnSB1l6M2Horv4/sUYdl1eJpG0Rt9Gx+MGdfwSFN4/Q+4gK
         BpIQ==
X-Gm-Message-State: AOJu0YwN0tAkhyOSCQajbfYQqIXB38CnnABmJgAW6JuEpJaDBb/04N3l
	0kmJH5Hh9g29GXrMgPqjiJeS4StGInPsc8U0B1sw91hkFroUKnzKWoScEE3xf4hEfYn5558lCrY
	FLVK2Sfpp3JVzUs3xlfGHdPrAK/XHZD9/
X-Google-Smtp-Source: AGHT+IHUF2YCnChkwnr1nmDyYbvXOUdfSaPzU24D8tqGFqrvpaIvfuhFsW82UF4QF8SDPXBY0ujIOz0PdrdjIBuXsp8=
X-Received: by 2002:a2e:9a85:0:b0:2d2:2b78:70eb with SMTP id
 p5-20020a2e9a85000000b002d22b7870ebmr2471214lji.21.1708311312288; Sun, 18 Feb
 2024 18:55:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOCpoWd1jzP6Y=nOpz_LHHSNnqGg8O=itW-OcQb6D2x7vRUfSw@mail.gmail.com>
In-Reply-To: <CAOCpoWd1jzP6Y=nOpz_LHHSNnqGg8O=itW-OcQb6D2x7vRUfSw@mail.gmail.com>
From: Patrick Plenefisch <simonpatp@gmail.com>
Date: Sun, 18 Feb 2024 21:55:11 -0500
Message-ID: <CAOCpoWcgZ3ZZi3LhZ7kR-zg+q8Th7n1DCvECdfCsYJ7ckQFL=w@mail.gmail.com>
Subject: Re: error while submitting device barriers: BTRFS read-only on newer kernels
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

After talking with some folks on irc, I tried a few things, including
confirming that the 6.6 kernel exhibits the same behaviors.

They recommended I bump this message again for more help

Thanks,
Patrick

On Sun, Feb 11, 2024 at 10:15=E2=80=AFPM Patrick Plenefisch <simonpatp@gmai=
l.com> wrote:
>
> This is a very weird error I'm getting. I have a system that I'm
> migrating from Debian 11 (5.10 kernel) to Debian 12 (6.1 kernel). As a
> part of this process, I'm dual booting both systems, with a LVM pool
> that contains three relevant LV's with three BTRFS partitions. Two of
> these BTRFS partitions (single) are working just fine. The other one
> (also single) only works on 5.10 kernels. Whenever I boot it on 6.1
> kernels, I can mount it just fine until I (presumably) read a file and
> trigger an `atime` write. Then the BTRFS partition is locked ro until
> a reboot with this in dmesg:
>
> BTRFS info (device dm-75): first mount of filesystem
> 00d78dac-3576-435d-b575-61c3d951ff66
> BTRFS info (device dm-75): using crc32c (crc32c-intel) checksum algorithm
> BTRFS info (device dm-75): disk space caching is enabled
> BTRFS info: devid 1 device path /dev/mapper/lvm-brokenDisk changed to
> /dev/dm-75 scanned by (udev-worker) (11442)
> BTRFS info: devid 1 device path /dev/dm-75 changed to
> /dev/mapper/lvm-brokenDisk scanned by (udev-worker) (11442)
> BTRFS error (device dm-75): bdev /dev/mapper/lvm-brokenDisk errs: wr
> 0, rd 0, flush 1, corrupt 0, gen 0
> BTRFS warning (device dm-75): chunk 13631488 missing 1 devices, max
> tolerance is 0 for writable mount
> BTRFS: error (device dm-75) in write_all_supers:4379: errno=3D-5 IO
> failure (errors while submitting device barriers.)
> BTRFS info (device dm-75: state E): forced readonly
> BTRFS warning (device dm-75: state E): Skipping commit of aborted transac=
tion.
> BTRFS: error (device dm-75: state EA) in cleanup_transaction:1992:
> errno=3D-5 IO failure
>
> My thought was that maybe I created it with a new broken format, like
> space_cache_=3Dv2, but nope, all variants work in the other working
> btrfs partitions on 6.1:
>
> /dev/mapper/lvm-newWorking on /media/Foo type btrfs
> (rw,noatime,ssd,discard=3Dasync,space_cache=3Dv2,subvolid=3D258,subvol=3D=
/@foo)
> /dev/mapper/lvm-oldWorking on /media/Bar type btrfs
> (rw,nosuid,nodev,relatime,discard=3Dasync,space_cache,subvolid=3D5,subvol=
=3D/,uhelper=3Dudisks2)
> /dev/mapper/lvm-brokenDisk on /media/Grr type btrfs
> (rw,nosuid,nodev,relatime,discard=3Dasync,space_cache,subvolid=3D5,subvol=
=3D/,uhelper=3Dudisks2)
>
> The only thing I can seem to find online is posts warning that you
> should backup your data. But that clearly isn't the case here, because
> none of the devices in the lvm pool are giving smart warnings or
> reallocation counts. Further, reading is fine, I can read the whole
> disk. Finally, I can just reboot back to the 5.10 kernel and it just
> works again. 6.5bpo kernel also exhibits 6.1 behavior
>
> What is going on here?
>
>
> % uname -a
> Linux pollux 6.5.0-0.deb12.4-amd64 #1 SMP PREEMPT_DYNAMIC Debian
> 6.5.10-1~bpo12+1 (2023-11-23) x86_64 GNU/Linux
> % btrfs --version
> btrfs-progs v6.2
> % btrfs fi show /media/Grr
> Label: 'BrokenDisk'  uuid: 00d78dac-3576-435d-b575-61c3d951ff66
>         Total devices 1 FS bytes used 1.90TiB
>         devid    1 size 2.00TiB used 1.92TiB path /dev/mapper/lvm-brokenD=
isk
>
> % btrfs fi df /media/Grr
> Data, single: total=3D1.91TiB, used=3D1.89TiB
> System, DUP: total=3D8.00MiB, used=3D240.00KiB
> Metadata, DUP: total=3D6.00GiB, used=3D4.88GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D16.00KiB
>
> Patrick

