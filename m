Return-Path: <linux-btrfs+bounces-18926-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3B8C54CC0
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 00:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8291E346B4D
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 23:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0324D2F39A4;
	Wed, 12 Nov 2025 23:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoLhNUAz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2992F12C1
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Nov 2025 23:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762989752; cv=none; b=QjBrdrbVVx/EkjqqP5Mc+IQowwc0pw+AA03yYK2Y6P75MASA/SKz6CNiXMSuRjDpsaYwzX6kiADCikmKWP1TCD34XWHhK0rqiqlNHoERE85o16TtZL7CBTtFAk3jO4n/wYCmF3nYz8Jn9Mw3HmXEgJK022Q0SjMwZhKZZedTj4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762989752; c=relaxed/simple;
	bh=Q+7jIX1MoAFSy/3BtqRUdBaWGpKTvURmCCK8F0PfZqs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hZ6U6SYSsjsBB8i7/b15OA07kh8TXxnPlT85RjjwtjadNUczljweyAkamwoOco7KTqCoj2GmdbhoQc4jjTsXlWP9VKUYuoZoyTvHlpWEmUJgwPqizVPIAY1hGYcPh9bkxqqD1BQCXlqVT7SZLfKVUtpES2CgKEt/cqFHgpM8/jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LoLhNUAz; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b272a4ca78so31763985a.1
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Nov 2025 15:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762989749; x=1763594549; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MoMjMpM41nJfPUh++3NuL6sTy9Om5FKpIeGInBLQstc=;
        b=LoLhNUAz10IX6P2GVEBEZWZMNoJLAYwny+lEUjL/H8ApdyWBnG0aasshwa3YxLl/Ql
         WZwTNh8GsifZjB9+/zj3Gw7XgSjwSZsnsUSesjgG75B2+rR5OftBiMjBWZuxrmRU/c/W
         Zj5hE2PY6cOdEhN7UHcv2RIWwaobAf5HBI5ZM8jm0XQEbpT0TewNMf8UJzx5jIexWXTw
         xkJ0WmkemQ6eDX8XmR2+NHwF7PzXvvxpXAjfkGDIhej+3wS9+e0ZJ+WrKHMmmxS6o2L3
         JSuwySg6Qi11Trz/H4Z5hMT3cBQSISRRkxXjGSGqK0jgv9DYhNlvqHIp0uTn4peDLTe1
         hevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762989749; x=1763594549;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MoMjMpM41nJfPUh++3NuL6sTy9Om5FKpIeGInBLQstc=;
        b=UA3JtXkdkWRTtNDnijQmJ2K1//RGWVRsLRPeu0USuZmEQIXho3NjZvx+nC3mpGAW7C
         Gjzcqe2JahzawTJJUG9i2HDFtR9jA7w03dUnM2Gd8E0EXdw8LA7RiB/lfiwU5kjL9/4G
         TVBMKBWpr55vRxOKkjANWcmfRnvsu2N2ZQTcwdEO0W3q+KmZDz1hUjmIPgdmAvmb24YW
         InMwQu0OVFTm3ZkiYxhM7uAApttm/k2UA4FTifrfERQ6u7enxTZb+OYBgaU2ICfa8njo
         nIpb24yZFwJzfC8QQBBCel1O5FUCZyZjJRHUDUBgxbGKYQfe5GieoM7WvSGQVsxvFmq8
         NBWQ==
X-Gm-Message-State: AOJu0YwWx+f2GwAX2MgkUjOyl4DzT2rFryr9ZXV64+j8TFg8WD3jOpcB
	MtmCINBmPuQrRtxbKjI/WUL3NPoTzdY90ya4LmcUh+K9zdJ+Q4kX58M1FP0DEnIq
X-Gm-Gg: ASbGncvIBk6eG0T45OGj2bRF0MC88RUfHCl0CQiML1wbkh1/SofYSHwY3a5+JC741x8
	icfw9gc/3A+HkAJPkWfZ37MuHEUr4ulYDvXEevOhKPaCxNXKhvTBsd1iL8ilBidK2czreAHWDGO
	oZmz6An4odzYBWF7oUu/NsAGAAVIirI/5lv4D0vdhjqSLsaqvqVylNzxD9W/1jRRtQlZhHfPVti
	LkF/XkaoxNXil5MnK4L/4X4H6sGb1d/pHH/74uV0aL7e9wZu8IhEIKo4qPxjOAhpJnLw3IVD1qU
	nkSEOnbaV13j9hNh5Q8SG4xMvWftDJHH9+9ZdAr/f8pxXihzgGzLCy1VTgtCR0WLHMN8rlHAWsq
	G56wQT7pbiQclRXQt9EjycPzOX6lBzLcA0nJ99PMvRbZhxnuX8xGfQ1epXutcMVze52ayTzFy2S
	5chKwSnO6Vhz2WFOB0AGpsUU+IqPRwxDmfiA==
X-Google-Smtp-Source: AGHT+IHb5uGkXSYsp2lrk/zJYUAJ93C5W5MSGp31fVhIWpq5HeOUZ6LkON4+SwuIndo9sVihS8eY2g==
X-Received: by 2002:a05:620a:40d1:b0:8b2:1568:82d1 with SMTP id af79cd13be357-8b29b74e1aamr652332485a.10.1762989749357;
        Wed, 12 Nov 2025 15:22:29 -0800 (PST)
Received: from localhost (69-171-146-205.rdns.distributel.net. [69.171.146.205])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-8b2aeeaf9d9sm17208185a.16.2025.11.12.15.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 15:22:28 -0800 (PST)
From: Nicholas D Steeves <nsteeves@gmail.com>
To: Tobiasz =?utf-8?Q?Karo=C5=84?= <unfa00@gmail.com>,
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Damaged filesystem - request for support
In-Reply-To: <CAOsCCbMUnjo982rkUdjAsG6Q28AChMNQLQf7g1LDK1DNsgLUBg@mail.gmail.com>
References: <CAOsCCbPNqUkFqn2W_GprROor+ExuturJxWz-kVL_W5QvqAENSg@mail.gmail.com>
 <cd684028-5a7c-47bc-8095-02917fe46d6b@app.fastmail.com>
 <CAOsCCbOH_PRiExWLKPymdrCeNYCtfLgZ6khuGty-_m94MpOuMA@mail.gmail.com>
 <1330fe29-78a9-4628-b295-e3dcf2de15a9@app.fastmail.com>
 <CAOsCCbOeNGTS+MK4ZMDkg+PfVC0D9DR7iRXr+Hy6qK9sHgYjJg@mail.gmail.com>
 <CAOsCCbPRE-kXtBXHLxu179q63_HoRby0a4fZukziMUxjzYRhuQ@mail.gmail.com>
 <dab1f9d3-6b21-4df9-8217-faf1aff7ba0a@app.fastmail.com>
 <CAOsCCbMUnjo982rkUdjAsG6Q28AChMNQLQf7g1LDK1DNsgLUBg@mail.gmail.com>
Date: Wed, 12 Nov 2025 18:21:56 -0500
Message-ID: <87y0oahm5n.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Tobiasz,

Tobiasz Karo=C5=84 <unfa00@gmail.com> writes:

> [Wed Nov 12 11:11:01 2025] sd 2:0:0:0: [sdc] tag#5
> uas_eh_abort_handler 0 uas-tag 1 inflight: CMD
> [Wed Nov 12 11:11:01 2025] sd 2:0:0:0: [sdc] tag#5 CDB: ATA command
> pass through(16) 85 06 0c 00 d4 00 00 00 82 00 4f 00 c2 00 b0 00
> [Wed Nov 12 11:11:01 2025] scsi host2: uas_eh_device_reset_handler start
> [Wed Nov 12 11:11:01 2025] usb 4-1.2: reset SuperSpeed USB device
> number 7 using xhci_hcd
> [Wed Nov 12 11:11:01 2025] scsi host2: uas_eh_device_reset_handler success
>
> That happens after a minute wheenver I do:
> smartctl -l long -C /dev/sdc
>
> So it seems I can't do a long, captive HDD test through this enclosure.
> This is the self-test log for the drive:

USB attached disks, even directly attached (like WD Passport*) without a
SATA2USB bridge are unfortunately often...special...this way.  The way
to run a long SMART test on them (if the controller isn't uselessly
buggy) is to use a "while true" loop to do something like dd a block
from /dev/urandom to /mnt/point/delete_me, sleep for a period shorter
than then the enclosure's sleep timeout (IIRC there are bad controllers
that will always sleep even if you tell them not to), sync, allow to
iterate, and interrupt the loop after you've allowed the long test to
complete, plus an hour, plus checked the self-test log (checking the log
will abort a running test!).  I've also, 3=C3=97 now, run into disks that
marked blocks for reallocation, in firmware, during their first write ->
read_verify-write cycle, wrote to the manufacturer (three different
manufacturers), and was told that was normal--oh brave new world.

> root@pve:/mnt# smartctl -l xselftest /dev/sdc
> smartctl 7.3 2022-02-28 r5338 [x86_64-linux-6.8.12-16-pve] (local build)
> Copyright (C) 2002-22, Bruce Allen, Christian Franke, www.smartmontools.o=
rg
>
> =3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
> SMART Extended Self-test Log Version: 1 (1 sectors)
> Num  Test_Description    Status                  Remaining
> LifeTime(hours)  LBA_of_first_error
> # 1  Extended captive    Interrupted (host reset)      90%        42     =
    -
> # 2  Extended captive    Interrupted (host reset)      90%        42     =
    -
> # 3  Extended offline    Aborted by host               90%        42     =
    -
> # 4  Extended offline    Aborted by host               90%         1     =
    -
>
> I have tested blacklisting the uas driver, but the enclosure would
> just not show up (should I load an alternative driver for it?)
> lsusb says this about the 2-bay disk enclosure:
> Bus 004 Device 007: ID 174c:55aa ASMedia Technology Inc. ASM1051E SATA
> 6Gb/s bridge, ASM1053E SATA 6Gb/s bridge, ASM1153 SATA 3Gb/s bridge,
> ASM1153E SATA 6Gb/s bridge
>
> I wonder if there's something that can be done about this enclosure in
> terms of patching the driver or something?
> Should I contact a different mailing list?
> This is by no means Btrfs-specific at this point.

I don't have experience with this chipset, and someone[s] in the
following thread maintain[s] that it works fine in UASP mode in 2022 (it
is documented in various places that it was not fine in 2015).
https://forums.raspberrypi.com/viewtopic.php?t=3D339591&start=3D25

> About write cache disabling, I was unable to do it persistently with
> hdparm, but I found that there's a way to disable write caching
> persistently with smartclt. It's also possible to disable write cache
> reordering, which I suppose could be more dangerous fro Btrfs. I have
> once used bcache with Btrfs in writeback mode and after a particular
> system crash the FS has gone bad. (I've even written a song about
> it..)
> smartctl -s wcreorder=3Doff,p /dev/sdc
>
> I have attempted to disable autosuspend for all xhci controlers using Pow=
erTop:

Have you tried adding "usbcore.autosuspend=3D-1" to your kernel arguments?
(ie: /etc/default/grub, then run `update-grub`).

>   Good          Enable SATA link power management for host0
>   Good          Enable Audio codec power management
>   Bad           Autosuspend for USB device xHCI Host Controller [usb1]
>   Good          Autosuspend for USB device USB2.0 Hub
> [VIA Labs, Inc.         ]
>   Good          Autosuspend for USB device USB2.0 Hub [1-1]
>   Good          Autosuspend for USB device USB2.1 Hub [Generic]
>   Bad           Autosuspend for USB device xHCI Host Controller [usb3]
>   Good          Autosuspend for USB device USB3.0 Hub
> [VIA Labs, Inc.         ]
>   Bad           Autosuspend for USB device xHCI Host Controller [usb2]
>   Good          Autosuspend for USB device USB3.2 Hub [Generic]
>   Bad           Autosuspend for USB device xHCI Host Controller [usb4]

How is VIA's xHCI support for UASP?  Missing usb-host quirks could
hypothetically be needed, and USB device manufacturers sometimes assume
Intel to such an extent that there have been cases where the hardware
(I'm thinking of a handful of audio interfaces) didn't work at all on
AMD motherboards of that era.  I assume this class of issue can be
mitigated in-kernel.

Cheers,
Nicholas

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEE4qYmHjkArtfNxmcIWogwR199EGEFAmkVFq0THG5zdGVldmVz
QGdtYWlsLmNvbQAKCRBaiDBHX30QYa7iD/4kqLjpH+A1hu7bfnQFpCk+skyihJYL
f31dTwFCtVyfxlpmVepnnplfLYGKxVtb+Kl985oTGo100BrouCeWsxs7wY3irglL
rEhvsNYHYYuJmtctV8OWUAmRlg/TiF873kSV4Ed+qyaJY7jAoIvxKRcjHwEH93dO
CtnHLvRXneuIBkBQSpFoWdHcKqnzl0CEf7t7/VcDkN848pGbBTNrgUkb8q3k5SsF
3LrO4/zbMFFXS4dUwvK6neh4tkP64P9t89WHUe0SyLL2JmCgN5gT15/7KJHcis1v
5Jb4N30Bsyq2evOHBgReFxEVRfLANJ38SHGcLxFPj6kmAnOvwCm+fSJrqASuIBnx
VwMw5Ahv07X5cJ4+rOHYIUeavbsbK1CGEdfZzjjwdO/vXUjebw32OUuNJju/C8kp
ig1O+YW0m4hs7N6A5VC/9LZvMbbw9u8gSBwBMzHOflghbHcsktac/LAwaJTOla9H
n02MWEStalU5NlAq0SXtBt8fMqEd0yw5lcataa3Hfgg9Kv1RduBV6R+hPEqVs+Ry
7d/7NDo97vJwzJ8t8N4qLvdqp2m823SRq7I4sq5rEx8i0U/0Yd/uy2ecyxDaUwoV
F1VLCkGAXCcCcdsUxsj5Ap+cjo6KVMmPeeuUuhq9uyu9yIOnJ/XrWJYmITJJk1IV
3ycK+5cvhOXmSg==
=iBok
-----END PGP SIGNATURE-----
--=-=-=--

