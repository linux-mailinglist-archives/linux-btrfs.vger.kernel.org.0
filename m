Return-Path: <linux-btrfs+bounces-7942-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F35B974F40
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 12:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3A82882D4
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 10:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AA41822F8;
	Wed, 11 Sep 2024 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWkgre+3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8585153820
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726049269; cv=none; b=g9uGracHxcuM1zGkv9AYK0suFEX8V5i1AgujSsuTdlbE2fGuKPh8Lh2AAB79IB2RqEYdgomfBYqNI2FYAfVHLQqj7k5rG7Tmrsv9rnd+o4nXU2bVe5kU9di8jLEXrbTADdCv4tIqpGkLoI+B/MyGB8HA0Atvm07hVtzHSzE/OPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726049269; c=relaxed/simple;
	bh=FVzmJsrY4Cd8sh75bS9RCebr0Z10c5f5a7mcfdNjM6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RRd/ehizXHJN8+wZl8pfig8gc0DDe4Pn28VQ+udpSWVdt0Vqm9PEzVXCntjxqFEYqKzeOeBAY/uHao7P6G7wQ05TluDkCfac/V5AthjKKYiteeh6eBSGr2wd0yrMtaKUlfF4KbTnO8E4Brs2dN3oBMYvoejrg+ykjI3K620uKfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWkgre+3; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a4df9dc885so60989485a.0
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 03:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726049267; x=1726654067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7Gb1P9l8o9G5KkaxSE8ENGow09ZNAk06A9eTgbSgVM=;
        b=XWkgre+3O+cB6MenLAfUG2BMUxL6qjvFb61TkvbdHtieL1BxQoFzJLlYBlMyjFP8Nb
         A9ggmahFWvmfUeHt1llNU0ZA3WgrpSjyGblNpizVz5fb54xSIQdP6WaWo6/86JYXHYsZ
         6qcRzfhA1JoB0NwCrlva84mY+Ea9ZksfzTVgTJa9cj1wyOdWTjxhz/aP0j1iD2NBbKX5
         F2f2MdprLCtOs57HGZwfV3hvXRZdK2mV8oPd8r6nT/NECQPx41b8PKJT+bwSGbXsY+hc
         U9xIR3lQ7fyLl3ZT8j1CGOuVStsK4EVJD4QlxW+wAVcI/R+q6uGscSJpplZ3ZL/DIlvn
         kFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726049267; x=1726654067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u7Gb1P9l8o9G5KkaxSE8ENGow09ZNAk06A9eTgbSgVM=;
        b=NWkyWG6N0L/KgG5TpN7B7Uh3jdti7ovBWOB+YIuD23iEIugFh4WvLNdfSpWYpbPp3+
         dpZaZNK6Ma6YKBGg4nenW294Aa0PPdXCFChODKBjvQsX1MJUG4OBH9fjycOhWDlnh40o
         NXakzqJ2AgOiHxbJRD4/ZX7JPRJ/IBXiVNLp7g0mYBGdgZhq4I40O5Gfzql1Rx1gCDrO
         wTIdnhnR8uQ6sWVIf2suqVvVRfimcGcEefPuPDmWOo1DbxspdJhXepS+Y7AHpIkJ7H65
         gon8dlqOwvdHuoqlNxOd9D9uXlue74wYO78y3Jc0VTnujev6z7baAswxpmygoXdKrQBj
         y7zg==
X-Forwarded-Encrypted: i=1; AJvYcCWdNJjTbVFg0tP7PUIqCUIfKjUWxPOZ81C1Xh0icJ+DMKXVzKbcfyiLICN0R7CKR1x3tAPIjrv+Zd3Dxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YynxnI8QkKFhjCSnuY2kX36pDsFjIz/yy6mCS0QQt1SbZM/Svrp
	68MD4lS8ChkJb+VTVUgw9yscLQorHy732dloJCayDKRGi1SbKoWgVTlmbYl7S4+C1Kb8BHnh2fS
	NuHeh1Qksf2rRZlkAMGPMsXhHENg=
X-Google-Smtp-Source: AGHT+IHiFzS/QFmmIHfgOSduKTrmpvcd+Z8ODZ5bmWjQ0K+p26wqIN9RHD3pNvfFQFlnA4UIK5H/VPhD61UZjLBPewA=
X-Received: by 2002:a05:620a:298a:b0:7a9:a917:266f with SMTP id
 af79cd13be357-7a9bf961ec3mr1096397085a.3.1726049266594; Wed, 11 Sep 2024
 03:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAYHqBbrrgmh6UmW3ANbysJX9qG9Pbg3ZwnKsV=5mOpv_qix_Q@mail.gmail.com>
 <89131a4f-5362-4002-9a55-d1a24428ef05@gmx.com> <CAAYHqBZ+-3GbDmQFGxMcYs3HpO-DUQA4pCG0xqWMZW+sbw-KJg@mail.gmail.com>
 <331b4034-7a6c-4fa8-a10d-6fa87b801d21@gmx.com> <CAAYHqBaEEq8_AWKtMv9RtH4ZNtTEheCjAZzBstkrECt775UzJA@mail.gmail.com>
 <72315446-3ad4-40d1-8cff-1ec25ae207bd@gmx.com> <CAAYHqBYKQVNOyNbVBw=Xg2K2rXK0KTT7XDx3Ayn=SbNHtf53Lw@mail.gmail.com>
 <d0a1012f-7485-4e34-9f6a-b03a1164f53f@suse.com> <CAAYHqBbcDEuHQgG_iim84otLk-h9TioqNeT1BdiRSvEuwDJaZQ@mail.gmail.com>
 <12a91072-9289-479a-8a15-4c4f0894ead1@gmx.com> <CAAYHqBbfXj64BuY5kESx+8NJReqz-dzKeXHwf=vHKqYhKVwB3w@mail.gmail.com>
 <d96b8a47-3361-4226-b98a-67386bd6e7f4@suse.com> <CAAYHqBbcQwLqn4SBnKbimgttUbNxMRnH0AhwYKXJTJu1G=C9ZQ@mail.gmail.com>
 <d8619d5c-2780-41b2-bb48-4d208530f74b@gmx.com>
In-Reply-To: <d8619d5c-2780-41b2-bb48-4d208530f74b@gmx.com>
From: Neil Parton <njparton@gmail.com>
Date: Wed, 11 Sep 2024 11:07:35 +0100
Message-ID: <CAAYHqBaYW_6ooNnsmV4xa0_6oONdQw6rDswUk-jcEZipO1CNHg@mail.gmail.com>
Subject: Re: Tree corruption
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

SMART looks ok on all 4 drives

btrfs-map-logical -l 313163116052480 /dev/sdc
parent transid verify failed on 332196885348352 wanted 12747065 found 12747=
069
parent transid verify failed on 332196885348352 wanted 12747065 found 12747=
069
parent transid verify failed on 332196885348352 wanted 12747065 found 12747=
069
ERROR: failed to read block groups: Input/output error
ERROR: open ctree failed

/dev/sdc is the drive that originally started giving tree and leaf
errors 2 days ago so definitely looking to replace that with the new
drive tomorrow once the scrub has completed.

However the above map command for sda returns nothing, but for sdb and sdd:

btrfs-map-logical -l 313163116052480 /dev/sdb
parent transid verify failed on 332196960649216 wanted 12747071 found 12747=
073
parent transid verify failed on 332196960649216 wanted 12747071 found 12747=
073
parent transid verify failed on 332196960649216 wanted 12747071 found 12747=
073
ERROR: failed to read block groups: Input/output error
ERROR: open ctree failed

btrfs-map-logical -l 313163116052480 /dev/sdd
parent transid verify failed on 332197012652032 wanted 12747073 found 12747=
075
parent transid verify failed on 332197012652032 wanted 12747073 found 12747=
075
parent transid verify failed on 332197012652032 wanted 12747073 found 12747=
075
ERROR: failed to read block groups: Input/output error
ERROR: open ctree failed

I'm guessing this is due to raid1c3 on the metadata?

On Wed, 11 Sept 2024 at 10:46, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> =E5=9C=A8 2024/9/11 19:08, Neil Parton =E5=86=99=E9=81=93:
> > OK I have a new drive on the way which I was going to use to copy data
> > on to, but will now replace /dev/sdc to be on the safe side.  SMART
> > looks ok but don't want to go through this again!
> >
> > Maybe it was a bit flip?
>
> Nope, bitflip should not lead to a single mirror corruption, but all
> mirrors corrupted.
>
> This looks more like that specific disk (mirror 2 of that logical
> bytenr) is not fully following the FLUSH command.
>
> Thus some writes doesn't really reach disk but it still reports the
> FLUSH is finished.
>
> Furthermore only two tree blocks are affected, which may just mean the
> disk is only dropping part of the writes.
> Or you should have at least 4 tree blocks (root, subvolume(s), extent,
> free space trees) affected.
>
> This behavior will eventually leads to transid mismatch on a power loss.
> It's the other mirror(s) saving the day.
>
> And before replacing the disk, please really making sure that
> "btrfs-map-logical" is really reporting the mirror 2 is sdc, or you can
> still keep a bad disk in the array.
>
>
> Just keep running RAID1* for metadata, that's really a good practice.
>
> Thanks,
> Qu
> >
> > On Wed, 11 Sept 2024 at 10:32, Qu Wenruo <wqu@suse.com> wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2024/9/11 18:59, Neil Parton =E5=86=99=E9=81=93:
> >>> dmesg | grep BTRFS
> >>> [    2.551970] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b35228=
6
> >>> devid 14 transid 12746924 /dev/sda scanned by btrfs (142)
> >>> [    2.552100] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b35228=
6
> >>> devid 12 transid 12746924 /dev/sdc scanned by btrfs (142)
> >>> [    2.552225] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b35228=
6
> >>> devid 15 transid 12746924 /dev/sdb scanned by btrfs (142)
> >>> [    2.552343] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b35228=
6
> >>> devid 13 transid 12746924 /dev/sdd scanned by btrfs (142)
> >>> [    6.064021] BTRFS info (device sdc): first mount of filesystem
> >>> 75c9efec-6867-4c02-be5c-8d106b352286
> >>> [    6.064047] BTRFS info (device sdc): using crc32c (crc32c-intel)
> >>> checksum algorithm
> >>> [    6.064064] BTRFS info (device sdc): use zstd compression, level 3
> >>> [    6.064079] BTRFS info (device sdc): enabling auto defrag
> >>> [    6.064092] BTRFS info (device sdc): using free space tree
> >>> [   76.647420] BTRFS error (device sdc): level verify failed on
> >>> logical 313163105075200 mirror 2 wanted 0 found 1
> >>> [   76.660155] BTRFS info (device sdc): read error corrected: ino 0
> >>> off 313163105075200 (dev /dev/sdc sector 1145047360)
> >>> [   76.660353] BTRFS info (device sdc): read error corrected: ino 0
> >>> off 313163105079296 (dev /dev/sdc sector 1145047368)
> >>> [   76.660553] BTRFS info (device sdc): read error corrected: ino 0
> >>> off 313163105083392 (dev /dev/sdc sector 1145047376)
> >>> [   76.660719] BTRFS info (device sdc): read error corrected: ino 0
> >>> off 313163105087488 (dev /dev/sdc sector 1145047384)
> >>> [  153.697518] BTRFS info (device sdc): scrub: started on devid 12
> >>> [  153.875912] BTRFS info (device sdc): scrub: started on devid 14
> >>> [  153.876949] BTRFS info (device sdc): scrub: started on devid 15
> >>> [  153.943291] BTRFS info (device sdc): scrub: started on devid 13
> >>> [  260.968635] BTRFS error (device sdc): parent transid verify failed
> >>> on logical 313163116052480 mirror 2 wanted 12746898 found 12746888
> >>> [  261.047602] BTRFS info (device sdc): read error corrected: ino 0
> >>> off 313163116052480 (dev /dev/sdc sector 1145068800)
> >>> [  261.047893] BTRFS info (device sdc): read error corrected: ino 0
> >>> off 313163116056576 (dev /dev/sdc sector 1145068808)
> >>> [  261.051132] BTRFS info (device sdc): read error corrected: ino 0
> >>> off 313163116060672 (dev /dev/sdc sector 1145068816)
> >>> [  261.051398] BTRFS info (device sdc): read error corrected: ino 0
> >>> off 313163116064768 (dev /dev/sdc sector 1145068824)
> >>
> >> All happen on mirror 2.
> >>
> >> You can locate the device by:
> >>
> >> # btrfs-map-logical -l 313163116052480 /dev/sdc
> >>
> >> Which gives the device path.
> >>
> >> I would recommend to check the device's smart log and cables just in c=
ase.
> >>
> >> Thanks,
> >> Qu
> >>>
> >>> On Wed, 11 Sept 2024 at 10:10, Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
> >>>>
> >>>>
> >>>>
> >>>> =E5=9C=A8 2024/9/11 18:31, Neil Parton =E5=86=99=E9=81=93:
> >>>>> Many thanks Qu, I appear to be back up and running but I also had t=
o
> >>>>> run 'btrfs rescue zero-log' to get rid of a superblock error.
> >>>>> super-recover said the superblock was fine.
> >>>>
> >>>> This is not expected. I believe btrfs-rescue should check log trees
> >>>> before doing the operation.
> >>>>
> >>>>>
> >>>>> On reboot and remount (as normal) I have a couple of residual trans=
id
> >>>>> errors and I'm currently running a full scrub to try and clean thin=
gs
> >>>>> up.
> >>>>
> >>>> Transid is also not expected, if the transid error persists, it's a =
huge
> >>>> problem.
> >>>>
> >>>> Does the transid only shows on certain mirrors?
> >>>>
> >>>> Anyway a full dmesg from the first transid mismsatch will help a lot=
 to
> >>>> find out what's really going wrong.
> >>>>
> >>>> I hope it's really just the bad log trees.
> >>>>
> >>>> Thanks,
> >>>> Qu
> >>>>>
> >>>>> Hopefully though I'm back up and running, this is the longest the F=
S
> >>>>> has been mounted in 48 hours without it reverting to ro!
> >>>>>
> >>>>> Can't thank you enough for your help. I hope I'm not premature in
> >>>>> thanking you / will report back with any more errors.
> >>>>>
> >>>>> Regards
> >>>>>
> >>>>> Neil
> >>>>>
> >>>>> On Wed, 11 Sept 2024 at 09:55, Qu Wenruo <wqu@suse.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> =E5=9C=A8 2024/9/11 17:43, Neil Parton =E5=86=99=E9=81=93:
> >>>>>>> Is it safe to run 'btrfs rescue clear-ino-cache' on all 4 drives =
in
> >>>>>>> the array?
> >>>>>>
> >>>>>> Run it on any device of the fs.
> >>>>>>
> >>>>>> Most "btrfs rescue" sub-commands applies to a fs, not a device.
> >>>>>>
> >>>>>> And you must run the command with the fs unmounted.
> >>>>>>
> >>>>>>>     Reason I ask is when this first occurred it was one
> >>>>>>> particular drive reporting errors and now after switching out cab=
les
> >>>>>>> and to a different hard drive controller it's a different drive
> >>>>>>> reporting errors.
> >>>>>>>
> >>>>>>> It's also worth noting that this array was originally created on =
a
> >>>>>>> Debian system some 6-8 years ago and I've gradually upgraded the
> >>>>>>> drives over time to increase capacity, I'm up to drive ID 16 now =
to
> >>>>>>> give you an idea.  Does that mean there are other gremlins potent=
ially
> >>>>>>> lurking behind the scenes?
> >>>>>>
> >>>>>> Nope, this is really limited to that inode_cache mount option.
> >>>>>> I guess you mounted it once with inode_cache, but kernel never cle=
ans
> >>>>>> that up, and until that feature is fully deprecated, and newer
> >>>>>> tree-checker consider it invalid, and trigger the problem.
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Qu
> >>>>>>
> >>>>>>>
> >>>>>>> On Wed, 11 Sept 2024 at 09:04, Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> =E5=9C=A8 2024/9/11 17:24, Neil Parton =E5=86=99=E9=81=93:
> >>>>>>>>> btrfs check --readonly /dev/sda gives the following, I will run=
 a
> >>>>>>>>> lowmem command next and report back once finished (takes a whil=
e)
> >>>>>>>>>
> >>>>>>>>> Opening filesystem to check...
> >>>>>>>>> Checking filesystem on /dev/sda
> >>>>>>>>> UUID: 75c9efec-6867-4c02-be5c-8d106b352286
> >>>>>>>>> [1/7] checking root items
> >>>>>>>>> [2/7] checking extents
> >>>>>>>>> [3/7] checking free space tree
> >>>>>>>>> [4/7] checking fs roots
> >>>>>>>>> [5/7] checking only csums items (without verifying data)
> >>>>>>>>> [6/7] checking root refs
> >>>>>>>>> [7/7] checking quota groups skipped (not enabled on this FS)
> >>>>>>>>> found 24251238731776 bytes used, no error found
> >>>>>>>>> total csum bytes: 23630850888
> >>>>>>>>> total tree bytes: 25387204608
> >>>>>>>>> total fs tree bytes: 586088448
> >>>>>>>>> total extent tree bytes: 446742528
> >>>>>>>>> btree space waste bytes: 751229234
> >>>>>>>>> file data blocks allocated: 132265579855872
> >>>>>>>>>       referenced 23958365622272
> >>>>>>>>>
> >>>>>>>>> When the error first occurred I didn't manage to capture what w=
as in
> >>>>>>>>> dmesg, but far more info seemed to be printed to the screen whe=
n I
> >>>>>>>>> check on subsequent tries, I have some photos of these messages=
 but no
> >>>>>>>>> text output, but can try again with some mount commands after t=
he
> >>>>>>>>> check has completed.
> >>>>>>>>>
> >>>>>>>>> dump as requested:
> >>>>>>>>>
> >>>>>>>> [...]
> >>>>>>>>>                      refs 1 gen 12567531 flags DATA
> >>>>>>>>>                      (178 0x674d52ffce820576) extent data backr=
ef root 2543
> >>>>>>>>> objectid 18446744073709551604 offset 0 count 1
> >>>>>>>>
> >>>>>>>> This is the cause of the tree-checker.
> >>>>>>>>
> >>>>>>>> The objectid is -12, used to be the FREE_INO_OBJECTID for inode =
cache.
> >>>>>>>>
> >>>>>>>> Unfortunately that feature is no longer supported, thus being re=
jected.
> >>>>>>>>
> >>>>>>>> I'm very surprised that someone has even used that feature.
> >>>>>>>>
> >>>>>>>> For now, it can be cleared by the following command:
> >>>>>>>>
> >>>>>>>>       # btrfs rescue clear-ino-cache /dev/sda
> >>>>>>>>
> >>>>>>>> Then kernel will no longer rejects it anymore.
> >>>>>>>>
> >>>>>>>> Thanks,
> >>>>>>>> Qu
> >>>>>>>
> >

