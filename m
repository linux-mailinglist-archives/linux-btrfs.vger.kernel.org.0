Return-Path: <linux-btrfs+bounces-19038-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97356C61F1A
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 01:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F240E4E3610
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 00:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3334410785;
	Mon, 17 Nov 2025 00:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OO20dCa3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AFE36B
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 00:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763337831; cv=none; b=shb5d0i1fuKPGrVEISoqW9yYpmdqVa7qRFjrjQsEb4glT1VJzdM6Uyb4mxC4SXZV9iPppqFtjwCauYeA/SyAG9iE2AmL7RevhDJLzSbHq25pFQIQwnjgV2prCGi22MSf23TZ64tSSU53aB0p+Q/ImOf6oUK+ftaPoE5jEPjs/Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763337831; c=relaxed/simple;
	bh=II6xiCrLkyCvquYfzU0Jdud1w+AFYptSuXsdI9nMEUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=clQgdIWOY4YDSDHeuHQzN3G0Y9mV9SHM/KfedC84KgkY01JV38PlyVyI1jgdTIaniB2Nj3THBKObdtyOcH1P2QiT5xq9X9nweph5VPqrj/Z7WX6nxvTP64pxxGNkvl6Q22bOgzE8XNwOzR6e1vQwdiAMFphpPHlAKuOQZdU9r4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OO20dCa3; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b2dcdde698so197825885a.3
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Nov 2025 16:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763337828; x=1763942628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKQe0Cj4XrR7JkN2igIS1dxFx3u1xg6vzV7zA4UHGd0=;
        b=OO20dCa3r6XL+fUMUISr3X3fok8R2LM293kD1SbeB3lJSZ7nLKGhPGWpgFknFdXjJE
         M+iLFiULRi+aPSnlxBFkE9AW8d/KFYIHCvDOUJcadHm2yEEEIuApN67VWGbDgdsU7+hh
         LMmdSwO7xBakpsnCNLoZd24fyL5SxBkdcI9tCaPBX20J21djoFmBhIsPQjqAAcml4+FB
         k8gTkrjUiBmQHNOYuG5fhdw/csuxkWkILwz+xMaHD1g2HfjXaK3/OWiaZx8pJtShIELD
         z656f8bx+0QY6JxJj2UUbkgJj8jijiLzX3Fibl4cj1feSsCI3xf7LdRX0ccRuYu4dBfW
         oFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763337828; x=1763942628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VKQe0Cj4XrR7JkN2igIS1dxFx3u1xg6vzV7zA4UHGd0=;
        b=BmIKHrBsI179CmuG4oNJT2yKnVdGvxErurASBC5ZBQYigBO1mGsH7FbCA4hClksi4P
         D0NsGsfLClzahXq/HKtwbLZmpVPG27Yp+pBFXzq8N9A9j7vomJWOemiQdojg4rGAff6C
         RyWHNE0YXlh+vPoaYDjNNLXpahQBWHRoFz8/Tifc613ZOwd5faHTZB+QQlbj+uZIEzfK
         M+1W64ReqW7DD0iWPMWnJ2+bZ8vV9SDTDGxkwnZHGmW0Jke17Jn5TFfkiCBD0AUZL026
         EQxqdWw2aBU+4Gxg57/Pvy7laV7TS2DKPsbc67W6bBdKXm2BWEn/TL24tV/LHSN11c6R
         wv6w==
X-Gm-Message-State: AOJu0Yw7PiLpzfdZxlE26rpeTxd56511tJ4+aFZsFoVSkN6ESunHzvei
	O6QVPuTaizbjXX4k7Tutuut2tRIN7gIab1ZUBG8xUbdhbc5OgJJMV4/OsjqM+hKugOrJttQP3RU
	rZtnzJZ1pM+I/7JXakkysNSKJWUmCurw=
X-Gm-Gg: ASbGncuJT5prH5dqtEAMQbuGEiIimqwO4UJGp4DmW/BhTxubWSvi8ZO9ZPfOqxzYyct
	xp1PCNp0GH7Hn6YnoGTE6319VRTM7RDaEgFyb10szx/5UW9X7oaPKTj0GdhewjEnEtQOgZ8e5mU
	wmh/mjn52z48heN+hi2bf1XSeVvG9JNoeQsymkGVdxdxl8kbRguWW4M7CBBeEdeUwU5C20d4Ntb
	dpL1biQoh+3Z4omJUjPtdiISu9H8vasD3AWPphFj91a4NZK4VCfn8FzTWznsfJObMnVIb211TcY
	gzr9zptuIk3ioTmzbIxO0OH896PmLiKyq+55
X-Google-Smtp-Source: AGHT+IF3ziWOxvImU9SwEYcOygorpuM3RSwgetVfq8IlfWJnuzclVHVKJyEvuQLOSHWLrmiGVKcNyqvVgvzVugJWBSc=
X-Received: by 2002:a05:620a:1a1c:b0:892:9838:b16a with SMTP id
 af79cd13be357-8b2c31c927emr1481291785a.59.1763337828271; Sun, 16 Nov 2025
 16:03:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOsCCbPNqUkFqn2W_GprROor+ExuturJxWz-kVL_W5QvqAENSg@mail.gmail.com>
 <cd684028-5a7c-47bc-8095-02917fe46d6b@app.fastmail.com> <CAOsCCbOH_PRiExWLKPymdrCeNYCtfLgZ6khuGty-_m94MpOuMA@mail.gmail.com>
 <1330fe29-78a9-4628-b295-e3dcf2de15a9@app.fastmail.com> <CAOsCCbOeNGTS+MK4ZMDkg+PfVC0D9DR7iRXr+Hy6qK9sHgYjJg@mail.gmail.com>
 <CAOsCCbPRE-kXtBXHLxu179q63_HoRby0a4fZukziMUxjzYRhuQ@mail.gmail.com>
 <dab1f9d3-6b21-4df9-8217-faf1aff7ba0a@app.fastmail.com> <CAOsCCbMUnjo982rkUdjAsG6Q28AChMNQLQf7g1LDK1DNsgLUBg@mail.gmail.com>
 <1386ac4f-0154-4a3b-bc6f-d29e5296d71a@app.fastmail.com>
In-Reply-To: <1386ac4f-0154-4a3b-bc6f-d29e5296d71a@app.fastmail.com>
From: =?UTF-8?Q?Tobiasz_Karo=C5=84?= <unfa00@gmail.com>
Date: Mon, 17 Nov 2025 01:03:36 +0100
X-Gm-Features: AWmQ_bllAsG1Vs_DjC-tKGKh-SdmnYjOUiLSFIBUP0_r6jQLfsHtgAIZJSSb4bY
Message-ID: <CAOsCCbNh-3GaW1bGTjBG-CjzpmjZMhbmt-fi9_vEUa8gqe8n2g@mail.gmail.com>
Subject: Re: Damaged filesystem - request for support
To: Chris Murphy <lists@colorremedies.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>, Qu WenRuo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Nicholas, Chris - thank you for your input

I have let the 20 TB Toshiba run more tests, I have used a while loop
with a 30s pause to keep the bay from sleeping. Eitehr it or something
else (I was writing 2 different streams of backups to the drive at the
time as well) had apparently prevented the disk from being lost by the
system, *despite* the UAS device resetting!

Here's my sneaky write loop (4K as that's the physical block size on
the drive, and I believe the Btrfs filesystem I created on it also
adapted that):
while [[ true ]]; do dd if=3D/dev/urandom bs=3D4K count=3D1 of=3Dkeepalive.=
dd;
sleep 30s; done

While this, a Proxmox VE backup and a network remote borg backup were
being written to the drive I have by mistake run this:

smartctl -t long -C /dev/sdc

I have expected a catastrophic result, and immediatelly tried to back
of, hitting Ctrl+C two times over a couple seconds. At first it seemed
like it's the drive is gonna get lost, and I'll have Btrfs errors in
dmesg - but that was not the case!
There have been a few grueling pauses, but in that time the backup
processes of pve and a remote borg instance (from my desktop ot the
home server) did not crash. The drive and filesystem seemed to have
recovered gracefully with no errors reported in dmesg. Outside of this
half a minute of no response from the HDD, and a suddenly stopped
stream of data from my desktop system I have not noticed any
indication of a possible problem. The backup processes have carried on
without issue after a pause. It is strange. I am still not convinced I
can really trust the enclosure, so I am only using it to work with
non-critical data (if you can treat backups as non-critical...).

Here's the dmesg log of that mistakenly started captive test, and the
aftermath (or lack thereof!):

[Sun Nov 16 18:19:00 2025] sd 2:0:0:0: [sdc] tag#11
uas_eh_abort_handler 0 uas-tag 7 inflight: CMD OUT
[Sun Nov 16 18:19:00 2025] sd 2:0:0:0: [sdc] tag#11 CDB: Write(16) 8a
00 00 00 00 00 97 88 94 80 00 00 04 00 00 00
[Sun Nov 16 18:19:00 2025] sd 2:0:0:0: [sdc] tag#10
uas_eh_abort_handler 0 uas-tag 4 inflight: CMD OUT
[Sun Nov 16 18:19:00 2025] sd 2:0:0:0: [sdc] tag#10 CDB: Write(16) 8a
00 00 00 00 00 97 88 90 80 00 00 04 00 00 00
[Sun Nov 16 18:19:00 2025] sd 2:0:0:0: [sdc] tag#9
uas_eh_abort_handler 0 uas-tag 3 inflight: CMD OUT
[Sun Nov 16 18:19:00 2025] sd 2:0:0:0: [sdc] tag#9 CDB: Write(16) 8a
00 00 00 00 00 97 88 8c 80 00 00 04 00 00 00
[Sun Nov 16 18:19:00 2025] sd 2:0:0:0: [sdc] tag#8
uas_eh_abort_handler 0 uas-tag 2 inflight: CMD OUT
[Sun Nov 16 18:19:00 2025] sd 2:0:0:0: [sdc] tag#8 CDB: Write(16) 8a
00 00 00 00 00 97 88 88 80 00 00 04 00 00 00
[Sun Nov 16 18:19:00 2025] sd 2:0:0:0: [sdc] tag#7
uas_eh_abort_handler 0 uas-tag 8 inflight: CMD OUT
[Sun Nov 16 18:19:00 2025] sd 2:0:0:0: [sdc] tag#7 CDB: Write(16) 8a
00 00 00 00 00 97 60 5e c8 00 00 04 00 00 00
[Sun Nov 16 18:19:00 2025] sd 2:0:0:0: [sdc] tag#6
uas_eh_abort_handler 0 uas-tag 6 inflight: CMD OUT
[Sun Nov 16 18:19:00 2025] sd 2:0:0:0: [sdc] tag#6 CDB: Write(16) 8a
00 00 00 00 00 97 60 5a c8 00 00 04 00 00 00
[Sun Nov 16 18:19:00 2025] sd 2:0:0:0: [sdc] tag#5
uas_eh_abort_handler 0 uas-tag 5 inflight: CMD OUT
[Sun Nov 16 18:19:00 2025] sd 2:0:0:0: [sdc] tag#5 CDB: Write(16) 8a
00 00 00 00 00 97 60 56 c8 00 00 04 00 00 00
[Sun Nov 16 18:19:15 2025] sd 2:0:0:0: [sdc] tag#13
uas_eh_abort_handler 0 uas-tag 9 inflight: CMD IN
[Sun Nov 16 18:19:15 2025] sd 2:0:0:0: [sdc] tag#13 CDB: Read(16) 88
00 00 00 00 00 7c 44 8d a0 00 00 00 20 00 00
[Sun Nov 16 18:19:17 2025] sd 2:0:0:0: [sdc] tag#14
uas_eh_abort_handler 0 uas-tag 10 inflight: CMD IN
[Sun Nov 16 18:19:17 2025] sd 2:0:0:0: [sdc] tag#14 CDB: Read(16) 88
00 00 00 00 00 7c 44 8b 20 00 00 00 20 00 00
[Sun Nov 16 18:19:30 2025] sd 2:0:0:0: [sdc] tag#4
uas_eh_abort_handler 0 uas-tag 1 inflight: CMD
[Sun Nov 16 18:19:30 2025] sd 2:0:0:0: [sdc] tag#4 CDB: ATA command
pass through(16) 85 06 0c 00 d4 00 00 00 82 00 4f 00 c2 00 b0 00
[Sun Nov 16 18:19:30 2025] scsi host2: uas_eh_device_reset_handler start
[Sun Nov 16 18:19:30 2025] usb 4-1.2: reset SuperSpeed USB device
number 7 using xhci_hcd
[Sun Nov 16 18:19:30 2025] scsi host2: uas_eh_device_reset_handler success

Also - it seems I have managed to get a complete long test (offline,
not a captive one!) thanks to the while-dd-sleep trick. It is clear to
me that it was necessary to use that. I wonder if I should keep that

root@pve:/mnt# smartctl -l xselftest /dev/sdc
smartctl 7.3 2022-02-28 r5338 [x86_64-linux-6.8.12-16-pve] (local build)
Copyright (C) 2002-22, Bruce Allen, Christian Franke, www.smartmontools.org

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART Extended Self-test Log Version: 1 (1 sectors)
Num  Test_Description    Status                  Remaining
LifeTime(hours)  LBA_of_first_error
# 1  Extended captive    Interrupted (host reset)      90%       145       =
  -
# 2  Extended offline    Completed without error       00%       118       =
  -
# 3  Short captive       Interrupted (host reset)      40%        43       =
  -
# 4  Extended captive    Interrupted (host reset)      90%        42       =
  -
# 5  Extended offline    Aborted by host               90%        42       =
  -
# 6  Extended captive    Interrupted (host reset)      90%        42       =
  -
# 7  Extended captive    Interrupted (host reset)      90%        42       =
  -
# 8  Extended offline    Aborted by host               90%        42       =
  -
# 9  Extended offline    Aborted by host               90%         1       =
  -

So at least it seems like the 20 TB Toshiba spindle has passed the
initial burn-in.

I should do a btrfs scrub though to make sure the backups that were
paused did not in fact get corrupted right then and there.

I'll report any further findings should anything interesting come up
from this still.
- unfa

On Thu, Nov 13, 2025 at 2:28=E2=80=AFAM Chris Murphy <lists@colorremedies.c=
om> wrote:
>
>
>
> On Wed, Nov 12, 2025, at 7:57 AM, Tobiasz Karo=C5=84 wrote:
> > I have been trying various things, also with other drives.
> > I purchased a 20 TB Toshiba drive and I am currently attempting to do
> > a burn-in before using it for backup.
> >
> > I see issues with the USB exclosure, where it resets ev en with jsut
> > this one drive in it (so one bay is empty). Dmesg says:
> >
> > [Wed Nov 12 11:09:31 2025] sd 2:0:0:0: [sdc] tag#19
> > uas_eh_abort_handler 0 uas-tag 1 inflight: CMD
> > [Wed Nov 12 11:09:31 2025] sd 2:0:0:0: [sdc] tag#19 CDB: ATA command
> > pass through(16) 85 06 0c 00 d4 00 00 00 82 00 4f 00 c2 00 b0 00
> > [Wed Nov 12 11:09:31 2025] scsi host2: uas_eh_device_reset_handler star=
t
> > [Wed Nov 12 11:09:31 2025] usb 4-1.2: reset SuperSpeed USB device
> > number 7 using xhci_hcd
> > [Wed Nov 12 11:09:31 2025] scsi host2: uas_eh_device_reset_handler succ=
ess
> >
> > [Wed Nov 12 11:11:01 2025] sd 2:0:0:0: [sdc] tag#5
> > uas_eh_abort_handler 0 uas-tag 1 inflight: CMD
> > [Wed Nov 12 11:11:01 2025] sd 2:0:0:0: [sdc] tag#5 CDB: ATA command
> > pass through(16) 85 06 0c 00 d4 00 00 00 82 00 4f 00 c2 00 b0 00
> > [Wed Nov 12 11:11:01 2025] scsi host2: uas_eh_device_reset_handler star=
t
> > [Wed Nov 12 11:11:01 2025] usb 4-1.2: reset SuperSpeed USB device
> > number 7 using xhci_hcd
> > [Wed Nov 12 11:11:01 2025] scsi host2: uas_eh_device_reset_handler succ=
ess
> >
> > That happens after a minute wheenver I do:
> > smartctl -l long -C /dev/sdc
> >
> > So it seems I can't do a long, captive HDD test through this enclosure.
>
>        -C, --captive
>               [ATA] Runs self-tests in captive mode.  This has no effect =
with '-t offline' or if the '-t' option is not used.
>
>               WARNING: Tests run in captive mode may busy out the drive f=
or the length of the test.  Only run captive tests on drives without any mo=
unted partitions!
>
>
> Maybe use -t long and omit -C
>
>
> >
> > I have tested blacklisting the uas driver, but the enclosure would
> > just not show up (should I load an alternative driver for it?)
>
> usb_storage
>
>
> > lsusb says this about the 2-bay disk enclosure:
> > Bus 004 Device 007: ID 174c:55aa ASMedia Technology Inc. ASM1051E SATA
> > 6Gb/s bridge, ASM1053E SATA 6Gb/s bridge, ASM1153 SATA 3Gb/s bridge,
> > ASM1153E SATA 6Gb/s bridge
> >
> > I wonder if there's something that can be done about this enclosure in
> > terms of patching the driver or something?
> > Should I contact a different mailing list?
>
> linux-usb@vger.kernel.org
>
> http://www.linux-usb.org
>
Thank you, I will see if and how I can report this problem there.

>
> > About write cache disabling, I was unable to do it persistently with
> > hdparm, but I found that there's a way to disable write caching
> > persistently with smartclt. It's also possible to disable write cache
> > reordering, which I suppose could be more dangerous fro Btrfs.
>
> I'm not sure about that. Btrfs has no optimizations for write order based=
 on device topology whereas the drive firmware knows things about that topo=
logy and can acceptably do out of order writes for performance reasons that=
 are quite safe.

That's most intriguing. I was told in the past (2015?) that btrfs's
filesystem integrity depends on the order of write operations being
preserved. This is why using bcache in writeback mode was not
recommended, as in case of a power failure, the filesystem might fail
to recover. And in my case after about 1 year that has happened. My
system crashed and after rebooting, the btrfs filesystem that I had on
top of bcache in writeback mode, has suffered a collapse and has not
become mountable again. I did loose some recently written files.
I've updated Arch Linux wiki to add a precaution against using bcache
writeback with btrfs after that...
https://wiki.archlinux.org/title/Talk:Bcache#btrfs_on_bcache
I have checked and someone has said that "issues with btrfs+bcache
were fixed 10 years ago". Time flies!
But does that mean the initial assumption about the dangers of btrfs
cached write reordering is wrong?
Or maybe that was a general problem with btrfs's atomic updates, but
is no longer the case?
>
> Granted, the code for these settings is not available fo us to inspect.
>
>
> >
> > Same with short self-test. I wonder if I can use this disk in the
> > enclosure at all if this keeps happening...
>
> I just wouldn't use the captive test.
>
>
>
> --
> Chris Murphy



--=20
- Tobiasz 'unfa' Karo=C5=84

www.youtube.com/unfa000

