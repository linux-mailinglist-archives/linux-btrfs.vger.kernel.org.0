Return-Path: <linux-btrfs+bounces-18892-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E03C525F2
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 14:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CA474F2153
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 12:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4A1335081;
	Wed, 12 Nov 2025 12:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6HGL7ih"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2A8335573
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Nov 2025 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762952285; cv=none; b=fB0ovFzSMH0BXEXl8PPvaojKH5XF7OJt9SETrwiBOtBNNDhRIT1UK9iFLYvM7Vw1rm9K4VXd+8wpkRqJGSbCM1GZHQrAOxk2L9xF84Xkc8+2lhbYN8ALL/LD6PU5+HrZs0k49wolmWTgRwdBydeNh88J1n0PliweVPNWQSZ6jBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762952285; c=relaxed/simple;
	bh=OJqb7hcCVCATS+NwaBtUqvxCSldXlk6yXwKUdVzR5fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9z5QxEZzObeNLW5DWsdKem0/YW17t7ySrP/Uw957Yi/V4P28AKu7wUQdrnNmVa9Jka2/vZ71xsLsvjfsmLHItNYMEe/9XjyPJK3WRktnEORInaQzuH2C4KTMpKlrqUdBsQxtmKgePY49r0T3vBxZNpiOuTotikby4B7JseFjII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6HGL7ih; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8b25dd7ab33so52774985a.1
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Nov 2025 04:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762952281; x=1763557081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHpvngHljn1F0LuTtU7l2ayO8AhP1d867pfBL0HEAZM=;
        b=i6HGL7ihwK6AUQbEJmO5xhhWzpYBXDSa2B3cz0ThZOXSubzAYFX/3d0a0f6v6gg7+/
         FqmVC1J/wv/VCa5hbpkNbPeyUXswj2sF2VWMTjbv3oP1teq+iPOL29tJV3ePctbF86Ro
         lZc6PynBzrVaL8apud3twwdbtjlyZxqWqOnPxPQzm/K/oz+vpWrcKoxHcGV8SZ/dIlsg
         9vEmVTTSZTnxYBP0W7b6xfXx33g8F/speWIBgDqkn5tYZZHRRf/LKFftpPvlOsAbmW7H
         IpvzNiKdCcyrkO+ulEFhaPts8pM9q/YfOCcuVC6Kr34/Fegg2pGkI6cPchN/yKnd38vZ
         1/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762952281; x=1763557081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jHpvngHljn1F0LuTtU7l2ayO8AhP1d867pfBL0HEAZM=;
        b=d80IbGZeMlMmf1QuWom3dvedyshpjZNuCSYE9/anByqo3CG3HiF3wrwsSdjMCC1szk
         yN2yVtWVKTfBInKC2HMy7LI/W+LxDo42W03KMMSV1oOkz7K0kVkWFgijzH7sgKXURdvv
         tSo+jqOPphrc1EyjyLURHhVaB/4gZxCmEJvTvM2yGybyrMBmH1qyVu8Wh3za4iv6CBov
         cN27qFvY80Ne6pEK5XK5LolvYWw6DRscKdeDhSms9VXZs25A7KOVZjzZ2GQwLhDPJ2au
         CHw6FhRsWWK9QbNkqT3W+jgoU06SjHcgj8qSkClIRe1OssE9SsWRLI0nThIKc6bs2p1K
         GHSg==
X-Gm-Message-State: AOJu0YzWrK+pCAZMyaTBIVw7QsSjit4YcfWG40joww2fXx8fl95yGlm2
	DywfzmYBvyg4YDyUcG0fNmXiIhafIj/kKZCox1FG9lJydTGFD98NkC0PV578i6uXQbV6ET8mCio
	djEoU/Pnb3frRFZCB7ZKj2RemUWw3RE+xlKUvzr8=
X-Gm-Gg: ASbGncsMcV6D5MTESylxyNqwXiI9BNG6pSMN4m2JAFMO3TzuZket0a23FYy4LoxBqmq
	vjFhNgnqU29GrxL5QO9Lu+86LCzBgz1YN3T1uxYUdAziVhwmNTEiHUsYhK8T1jN8QiBfo3vwXxC
	+y/TC1wy/h10fY1EgFx0IIjse1Vrdi/uyQJpG4MvjjKtDBh1I/wB65L6KfYnp98SjC/zWrzgmK4
	uDuvjJNYD+v3mAicgbDl4JcEbbWhhYjzGL0b5SRgkszXD6LNv3vi/lYVgabbAteMTq7UWBg+ZMj
	ubaBZ8sGTwdakPM=
X-Google-Smtp-Source: AGHT+IE1EVgZhoIYHtRirlghHM2lSvbmmIJfPd5T90b8YluCqiZzVBxdoI32umMwv0MIKWZYIEsxSdNa99M0NgzZEF4=
X-Received: by 2002:a05:620a:2913:b0:89e:cd17:1f4c with SMTP id
 af79cd13be357-8b29b84c2a5mr347840385a.79.1762952281348; Wed, 12 Nov 2025
 04:58:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOsCCbPNqUkFqn2W_GprROor+ExuturJxWz-kVL_W5QvqAENSg@mail.gmail.com>
 <cd684028-5a7c-47bc-8095-02917fe46d6b@app.fastmail.com> <CAOsCCbOH_PRiExWLKPymdrCeNYCtfLgZ6khuGty-_m94MpOuMA@mail.gmail.com>
 <1330fe29-78a9-4628-b295-e3dcf2de15a9@app.fastmail.com> <CAOsCCbOeNGTS+MK4ZMDkg+PfVC0D9DR7iRXr+Hy6qK9sHgYjJg@mail.gmail.com>
 <CAOsCCbPRE-kXtBXHLxu179q63_HoRby0a4fZukziMUxjzYRhuQ@mail.gmail.com> <dab1f9d3-6b21-4df9-8217-faf1aff7ba0a@app.fastmail.com>
In-Reply-To: <dab1f9d3-6b21-4df9-8217-faf1aff7ba0a@app.fastmail.com>
From: =?UTF-8?Q?Tobiasz_Karo=C5=84?= <unfa00@gmail.com>
Date: Wed, 12 Nov 2025 13:57:50 +0100
X-Gm-Features: AWmQ_bkpziNcRgnWjFyg2Wp_BI4TR2UkpUjiGZpYxc2bcmh0V6cnmbc3R8nnIZo
Message-ID: <CAOsCCbMUnjo982rkUdjAsG6Q28AChMNQLQf7g1LDK1DNsgLUBg@mail.gmail.com>
Subject: Re: Damaged filesystem - request for support
To: Chris Murphy <lists@colorremedies.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>, Qu WenRuo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have been trying various things, also with other drives.
I purchased a 20 TB Toshiba drive and I am currently attempting to do
a burn-in before using it for backup.

I see issues with the USB exclosure, where it resets ev en with jsut
this one drive in it (so one bay is empty). Dmesg says:

[Wed Nov 12 11:09:31 2025] sd 2:0:0:0: [sdc] tag#19
uas_eh_abort_handler 0 uas-tag 1 inflight: CMD
[Wed Nov 12 11:09:31 2025] sd 2:0:0:0: [sdc] tag#19 CDB: ATA command
pass through(16) 85 06 0c 00 d4 00 00 00 82 00 4f 00 c2 00 b0 00
[Wed Nov 12 11:09:31 2025] scsi host2: uas_eh_device_reset_handler start
[Wed Nov 12 11:09:31 2025] usb 4-1.2: reset SuperSpeed USB device
number 7 using xhci_hcd
[Wed Nov 12 11:09:31 2025] scsi host2: uas_eh_device_reset_handler success

[Wed Nov 12 11:11:01 2025] sd 2:0:0:0: [sdc] tag#5
uas_eh_abort_handler 0 uas-tag 1 inflight: CMD
[Wed Nov 12 11:11:01 2025] sd 2:0:0:0: [sdc] tag#5 CDB: ATA command
pass through(16) 85 06 0c 00 d4 00 00 00 82 00 4f 00 c2 00 b0 00
[Wed Nov 12 11:11:01 2025] scsi host2: uas_eh_device_reset_handler start
[Wed Nov 12 11:11:01 2025] usb 4-1.2: reset SuperSpeed USB device
number 7 using xhci_hcd
[Wed Nov 12 11:11:01 2025] scsi host2: uas_eh_device_reset_handler success

That happens after a minute wheenver I do:
smartctl -l long -C /dev/sdc

So it seems I can't do a long, captive HDD test through this enclosure.
This is the self-test log for the drive:

root@pve:/mnt# smartctl -l xselftest /dev/sdc
smartctl 7.3 2022-02-28 r5338 [x86_64-linux-6.8.12-16-pve] (local build)
Copyright (C) 2002-22, Bruce Allen, Christian Franke, www.smartmontools.org

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART Extended Self-test Log Version: 1 (1 sectors)
Num  Test_Description    Status                  Remaining
LifeTime(hours)  LBA_of_first_error
# 1  Extended captive    Interrupted (host reset)      90%        42       =
  -
# 2  Extended captive    Interrupted (host reset)      90%        42       =
  -
# 3  Extended offline    Aborted by host               90%        42       =
  -
# 4  Extended offline    Aborted by host               90%         1       =
  -

I have tested blacklisting the uas driver, but the enclosure would
just not show up (should I load an alternative driver for it?)
lsusb says this about the 2-bay disk enclosure:
Bus 004 Device 007: ID 174c:55aa ASMedia Technology Inc. ASM1051E SATA
6Gb/s bridge, ASM1053E SATA 6Gb/s bridge, ASM1153 SATA 3Gb/s bridge,
ASM1153E SATA 6Gb/s bridge

I wonder if there's something that can be done about this enclosure in
terms of patching the driver or something?
Should I contact a different mailing list?
This is by no means Btrfs-specific at this point.

About write cache disabling, I was unable to do it persistently with
hdparm, but I found that there's a way to disable write caching
persistently with smartclt. It's also possible to disable write cache
reordering, which I suppose could be more dangerous fro Btrfs. I have
once used bcache with Btrfs in writeback mode and after a particular
system crash the FS has gone bad. (I've even written a song about
it..)
smartctl -s wcreorder=3Doff,p /dev/sdc

I have attempted to disable autosuspend for all xhci controlers using Power=
Top:

  Good          Enable SATA link power management for host0
  Good          Enable Audio codec power management
  Bad           Autosuspend for USB device xHCI Host Controller [usb1]
  Good          Autosuspend for USB device USB2.0 Hub
[VIA Labs, Inc.         ]
  Good          Autosuspend for USB device USB2.0 Hub [1-1]
  Good          Autosuspend for USB device USB2.1 Hub [Generic]
  Bad           Autosuspend for USB device xHCI Host Controller [usb3]
  Good          Autosuspend for USB device USB3.0 Hub
[VIA Labs, Inc.         ]
  Bad           Autosuspend for USB device xHCI Host Controller [usb2]
  Good          Autosuspend for USB device USB3.2 Hub [Generic]
  Bad           Autosuspend for USB device xHCI Host Controller [usb4]

But another attempt at long self-test aborts after a few seconds and
resets the USB controller:

[Wed Nov 12 11:20:55 2025] sd 2:0:0:0: [sdc] tag#15
uas_eh_abort_handler 0 uas-tag 1 inflight: CMD
[Wed Nov 12 11:20:55 2025] sd 2:0:0:0: [sdc] tag#15 CDB: ATA command
pass through(16) 85 06 0c 00 d4 00 00 00 82 00 4f 00 c2 00 b0 00
[Wed Nov 12 11:21:13 2025] sd 2:0:0:0: [sdc] tag#12
uas_eh_abort_handler 0 uas-tag 2 inflight: CMD IN
[Wed Nov 12 11:21:13 2025] sd 2:0:0:0: [sdc] tag#12 CDB: ATA command
pass through(16) 85 08 0e 00 00 00 01 00 00 00 00 00 00 00 ec 00
[Wed Nov 12 11:21:13 2025] scsi host2: uas_eh_device_reset_handler start
[Wed Nov 12 11:21:13 2025] usb 4-1.2: reset SuperSpeed USB device
number 7 using xhci_hcd
[Wed Nov 12 11:21:13 2025] scsi host2: uas_eh_device_reset_handler success


Same with short self-test. I wonder if I can use this disk in the
enclosure at all if this keeps happening...

I'll use f3 to stress the disk and see if this will reset the USB
controller as well...

f3write . && f3read .

So far 300 GB written and read no problem.
I started a borg repository there and I am doing a backup as test...


On Sat, Oct 25, 2025 at 7:06=E2=80=AFPM Chris Murphy <lists@colorremedies.c=
om> wrote:
>
>
>
> On Sat, Oct 25, 2025, at 4:58 AM, Tobiasz Karo=C5=84 wrote:
> > Here's scrub status:
> >
> >
> > UUID:             a11787a5-de1d-421c-ac2e-b669f948b1f0
> > Scrub started:    Fri Oct 24 11:21:29 2025
> > Status:           finished
> > Duration:         15:49:35
> > Total to scrub:   9.09TiB
> > Rate:             167.21MiB/s
> > Error summary:    csum=3D1068
> >  Corrected:      172
> >  Uncorrectable:  896
> >  Unverified:     0
> >
> > I assume this means I can continue to use the filesystem, accepting
> > that a number of files will be inaccessible and result in i/o errors
> > when accessed?
>
> Qu, does `btrfs check` verify both copies of metadata when available? Or =
only one copy? Does btrfs check ignore csum mismatches?
>
> From first post, this file system is:
>
> #  btrfs fi df /mnt/backup/
> Data, single: total=3D9.07TiB, used=3D9.07TiB
> System, RAID1: total=3D32.00MiB, used=3D1.19MiB
> Metadata, RAID1: total=3D11.03GiB, used=3D9.91GiB
>
> Since btrfs check says the fs is clean, but then scrub finds and corrects=
 172 errors, that must mean those csum mismatches for some of the metadata =
that btrfs check did not detect? It's a little confusing what state the fil=
e system is in now because the results don't explicitly tell us. We have to=
 infer it.
>
> Tobiasz, I think you need to run the btrfs check again (normal mode only =
is ok I think)  to be sure the metadata is OK. It's a little tedious but th=
at is pretty important as you point out.
>
> Note that the scrub is actually performed by btrfs kernel code and all me=
ssages about the scrub will be in dmesg. All of those 1068 csum mismatches =
will produces at least one message each. What is affected, whether a fixup =
was attempted, and whether the fixup worked. Metadata csum mismatch error l=
ooks different from data csum mismatch error. The data error will show path=
 to the file affected. So the dmesg will leak file names.
>
>
> > Since the data is replacable (assuming I don't need to go back to an
> > older backup, which I don't currently have a need for), I can destroy
> > this filesystem and start anew with a clean borg backup.
>
> I'm not super familiar with borg, but I expect that it has an option to v=
erify all data blocks on both sides. It probably takes quite a bit longer s=
ince both sides have to read and compare data. Btrfs never hands over corru=
pt data in normal operation, instead it returns EIO for any blocks that fai=
l checksum verification. The handling in case of EIO is up to the applicati=
on. What I'd like to think happens is borg will see EIO, know the target fi=
le is bad (or missing some blocks) and will replace it with a good copy fro=
m the source.
>
>
> > I am not sure what would be better.
> > I don't want the FS to constantly remount in ro mode due to i/o errors.
>
> Right. Which is why the first order of business is to make sure the IO er=
rors aren't happening anymore. Either new kernel has fixed that problem, or=
 disabling uas will fix it, or using a USB hub will fix it (I would borrow =
a hub before buying one for testing purposes if it comes to that).
>
> --
> Chris Murphy



--
- Tobiasz 'unfa' Karo=C5=84

www.youtube.com/unfa000

