Return-Path: <linux-btrfs+bounces-7955-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D31C9761C5
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 08:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 319911C22859
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 06:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661EB18C357;
	Thu, 12 Sep 2024 06:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uus6jXfd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1CE18BC2E
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 06:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726123453; cv=none; b=nUPOvhI43egFLEp5gHUmGDJ8U89pWY+vQ+3VbOCqPOW/NzAlkcitfdNbhMLtKDHfZOm1j33eSUV5FYFS3f1z6VrViXvIJ0ANAQURSnsiME5JbNCZN/xgP/G8C4hVYuPa7LnY7kOGY4Dtg6wqTTod34TLk9e9kOptLDplP3sol0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726123453; c=relaxed/simple;
	bh=JK4Fbf5uFg/BAAvwRpytZjrIReWGkpqpMCH/I3HBsTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nHt5Llb2BUaIe7hnJ4iapUWc8R2tBXFEKqhvWDNH7u8evtaUD6RW8AdJ6B21v3oSL+eH3R9whB3Rjx5dyXh5EY5rwBWgaB/L8ezWTVwFvgUDNLuoZOTMGsZVX9sA60WIgKYpgHoLCrLzaQWrHm7cUg5GoPsRo6QMAGaQRFMIDr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uus6jXfd; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a99c99acf7so60466485a.1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 23:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726123450; x=1726728250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dA8rlls/45CN0KeUSqzOWSgMgB4tz3mLzAjktAFBzSk=;
        b=Uus6jXfd2vtbvfLDKLCnd0C91COLDer/nJKYNFPQ3L85ttmKoGb7/5u+F9YHJgZw6T
         KkP6x1J5ZfN3TFgD55vu1Xr1QMY+rsGy7GYh0yiH3akzHPO1es08KtyFCsLp2DzSGDmw
         OcDAoeKDMVqqUN6xAj6f+84QC50f/KwNp8ubv39KZDdIeb2VSieGntueMtjlm7Fr+iiu
         ZycO4Yn+NcyaTEv4cQ0tJxLuBeIq5zOHyN9cq4V9y4VjyR/9acu6NLw1Z3d2OTqnIaZ4
         s2n1b6ZC+CUt+bsFjktl40mdRE01k7yYH/9GWGAClhwLrq5hGpXlgv+70GX7V6TjOkZG
         mDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726123450; x=1726728250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dA8rlls/45CN0KeUSqzOWSgMgB4tz3mLzAjktAFBzSk=;
        b=QCXvtMvomHviKG9a97jTMPqnrNkrrmZ3JH8bJ69zDdXoflgVfawnZN/B89DL1xsHDR
         bz3fjcIDV3TVF1kZ/mGUMyUyLF67MzTdr2c+VDu3pTdLZnl/nRABfpawtsPEFDJiMHSZ
         4Vd9gN8FoP8Qy2SC8yA3lk+1rSSditdAgaUeDHNmcq6Hld+Kua/PhXRCe1KRMRjLmniX
         TXDuGM02lOqH8CtwlrB46VWeP80eorQis7G01UqZgvjoCHzuVguVaB3nYDyBEA62bVi4
         AlFPPjzT/zdsWIz1aljTzHb7jLzzdIdGAO6KVpqD3xSaqfjSvjRftMWlK3n+bPPQcP2m
         BGZg==
X-Forwarded-Encrypted: i=1; AJvYcCUSAtzjyN+L3AXkH2wYHFyjzmze5U4ouQ3O8mjLEKyPd1Zctfg1bNVXS/i+MyaXM23nb8I0rXUk34VuWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YylOFltu0f1KvFqyFNvUzb8xlj9L21AkIF237PMwqwf+xyrh/+d
	IhrQfEecThsafPV1zY5uPLmwlYd3GbZ7RLKf3mQrJd0y4+soLCYfj/4Gb/lJ454A29SWiAgW+Ad
	34B10+JISdgkum3aGqEawAT3OIPg=
X-Google-Smtp-Source: AGHT+IEwcwyA4BLBbbAwxn72X6lKvD/qy9YlbASr0tuOGqnRvRcoxcEK+xkZPNZvXPBtEPisgBIlie+obg/jiPvTBlo=
X-Received: by 2002:a05:620a:4105:b0:7a9:783e:3fb1 with SMTP id
 af79cd13be357-7a9e5f024bcmr259175285a.23.1726123450200; Wed, 11 Sep 2024
 23:44:10 -0700 (PDT)
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
 <d8619d5c-2780-41b2-bb48-4d208530f74b@gmx.com> <CAAYHqBaYW_6ooNnsmV4xa0_6oONdQw6rDswUk-jcEZipO1CNHg@mail.gmail.com>
 <30da9047-87a2-4d1f-b132-3153c74279d5@gmx.com>
In-Reply-To: <30da9047-87a2-4d1f-b132-3153c74279d5@gmx.com>
From: Neil Parton <njparton@gmail.com>
Date: Thu, 12 Sep 2024 07:43:59 +0100
Message-ID: <CAAYHqBa2hD7UparX2mHo4jmt96Kpmb6TbYXiZpWdiE53ikzE2w@mail.gmail.com>
Subject: Re: Tree corruption
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I left a scrub running overnight and woke up this morning to find that
the scrub is still running but the fs has become ro again.

I have a new hdd waiting to be swapped in for sdc, how can I run a
btrfs replace if the filesystem won't stay in rw?  dmesg output below

[    2.551970] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b352286
devid 14 transid 12746924 /dev/sda scanned by btrfs (142)
[    2.552100] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b352286
devid 12 transid 12746924 /dev/sdc scanned by btrfs (142)
[    2.552225] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b352286
devid 15 transid 12746924 /dev/sdb scanned by btrfs (142)
[    2.552343] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b352286
devid 13 transid 12746924 /dev/sdd scanned by btrfs (142)
[    6.064021] BTRFS info (device sdc): first mount of filesystem
75c9efec-6867-4c02-be5c-8d106b352286
[    6.064047] BTRFS info (device sdc): using crc32c (crc32c-intel)
checksum algorithm
[    6.064064] BTRFS info (device sdc): use zstd compression, level 3
[    6.064079] BTRFS info (device sdc): enabling auto defrag
[    6.064092] BTRFS info (device sdc): using free space tree
[   76.647420] BTRFS error (device sdc): level verify failed on
logical 313163105075200 mirror 2 wanted 0 found 1
[   76.660155] BTRFS info (device sdc): read error corrected: ino 0
off 313163105075200 (dev /dev/sdc sector 1145047360)
[   76.660353] BTRFS info (device sdc): read error corrected: ino 0
off 313163105079296 (dev /dev/sdc sector 1145047368)
[   76.660553] BTRFS info (device sdc): read error corrected: ino 0
off 313163105083392 (dev /dev/sdc sector 1145047376)
[   76.660719] BTRFS info (device sdc): read error corrected: ino 0
off 313163105087488 (dev /dev/sdc sector 1145047384)
[  153.697518] BTRFS info (device sdc): scrub: started on devid 12
[  153.875912] BTRFS info (device sdc): scrub: started on devid 14
[  153.876949] BTRFS info (device sdc): scrub: started on devid 15
[  153.943291] BTRFS info (device sdc): scrub: started on devid 13
[  260.968635] BTRFS error (device sdc): parent transid verify failed
on logical 313163116052480 mirror 2 wanted 12746898 found 12746888
[  261.047602] BTRFS info (device sdc): read error corrected: ino 0
off 313163116052480 (dev /dev/sdc sector 1145068800)
[  261.047893] BTRFS info (device sdc): read error corrected: ino 0
off 313163116056576 (dev /dev/sdc sector 1145068808)
[  261.051132] BTRFS info (device sdc): read error corrected: ino 0
off 313163116060672 (dev /dev/sdc sector 1145068816)
[  261.051398] BTRFS info (device sdc): read error corrected: ino 0
off 313163116064768 (dev /dev/sdc sector 1145068824)
[ 2803.367836] BTRFS warning (device sdc): tree block 313163165237248
mirror 2 has bad generation, has 12746888 want 12746900
[ 2803.470703] BTRFS error (device sdc): fixed up error at logical
313163165204480 on dev /dev/sdc physical 586324377600
[ 2803.470787] BTRFS error (device sdc): fixed up error at logical
313163165204480 on dev /dev/sdc physical 586324377600
[ 2803.470847] BTRFS error (device sdc): fixed up error at logical
313163165204480 on dev /dev/sdc physical 586324377600
[ 2803.470904] BTRFS error (device sdc): fixed up error at logical
313163165204480 on dev /dev/sdc physical 586324377600
[40675.013231] BTRFS critical (device sdc): corrupt leaf:
block=3D334871673176064 slot=3D24 extent bytenr=3D333252139892736 len=3D368=
64
invalid data ref objectid value 65241
[40675.013337] BTRFS error (device sdc): read time tree block
corruption detected on logical 334871673176064 mirror 1
[40675.165371] BTRFS critical (device sdc): corrupt leaf:
block=3D334871673176064 slot=3D24 extent bytenr=3D333252139892736 len=3D368=
64
invalid data ref objectid value 65241
[40675.165477] BTRFS error (device sdc): read time tree block
corruption detected on logical 334871673176064 mirror 2
[40675.303196] BTRFS critical (device sdc): corrupt leaf:
block=3D334871673176064 slot=3D24 extent bytenr=3D333252139892736 len=3D368=
64
invalid data ref objectid value 65241
[40675.303301] BTRFS error (device sdc): read time tree block
corruption detected on logical 334871673176064 mirror 3
[40675.304132] BTRFS info (device sdc): scrub: not finished on devid
12 with status: -5
[49340.321632] BTRFS critical (device sdc): corrupt leaf:
block=3D334871673176064 slot=3D24 extent bytenr=3D333252139892736 len=3D368=
64
invalid data ref objectid value 65241
[49340.321780] BTRFS error (device sdc): read time tree block
corruption detected on logical 334871673176064 mirror 1
[49340.424554] BTRFS critical (device sdc): corrupt leaf:
block=3D334871673176064 slot=3D24 extent bytenr=3D333252139892736 len=3D368=
64
invalid data ref objectid value 65241
[49340.424698] BTRFS error (device sdc): read time tree block
corruption detected on logical 334871673176064 mirror 2
[49340.498068] BTRFS critical (device sdc): corrupt leaf:
block=3D334871673176064 slot=3D24 extent bytenr=3D333252139892736 len=3D368=
64
invalid data ref objectid value 65241
[49340.498213] BTRFS error (device sdc): read time tree block
corruption detected on logical 334871673176064 mirror 3
[49340.505620] BTRFS info (device sdc): scrub: not finished on devid
15 with status: -5
[65972.755968] BTRFS critical (device sdc): corrupt leaf:
block=3D334871673176064 slot=3D24 extent bytenr=3D333252139892736 len=3D368=
64
invalid data ref objectid value 65241
[65972.756043] BTRFS error (device sdc): read time tree block
corruption detected on logical 334871673176064 mirror 2
[65972.765683] BTRFS critical (device sdc): corrupt leaf:
block=3D334871673176064 slot=3D24 extent bytenr=3D333252139892736 len=3D368=
64
invalid data ref objectid value 65241
[65972.765759] BTRFS error (device sdc): read time tree block
corruption detected on logical 334871673176064 mirror 1
[65972.802812] BTRFS critical (device sdc): corrupt leaf:
block=3D334871673176064 slot=3D24 extent bytenr=3D333252139892736 len=3D368=
64
invalid data ref objectid value 65241
[65972.802887] BTRFS error (device sdc): read time tree block
corruption detected on logical 334871673176064 mirror 3
[65972.802977] BTRFS error (device sdc): failed to run delayed ref for
logical 333252141424640 num_bytes 49152 type 178 action 1 ref_mod 1:
-5
[65972.803040] BTRFS error (device sdc: state A): Transaction aborted (erro=
r -5)
[65972.803073] BTRFS: error (device sdc: state A) in
btrfs_run_delayed_refs:2168: errno=3D-5 IO failure
[65972.803110] BTRFS info (device sdc: state EA): forced readonly

On Wed, 11 Sept 2024 at 11:31, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> =E5=9C=A8 2024/9/11 19:37, Neil Parton =E5=86=99=E9=81=93:
> > SMART looks ok on all 4 drives
> >
> > btrfs-map-logical -l 313163116052480 /dev/sdc
> > parent transid verify failed on 332196885348352 wanted 12747065 found 1=
2747069
> > parent transid verify failed on 332196885348352 wanted 12747065 found 1=
2747069
> > parent transid verify failed on 332196885348352 wanted 12747065 found 1=
2747069
> > ERROR: failed to read block groups: Input/output error
> > ERROR: open ctree failed
> >
> > /dev/sdc is the drive that originally started giving tree and leaf
> > errors 2 days ago so definitely looking to replace that with the new
> > drive tomorrow once the scrub has completed.
> >
> > However the above map command for sda returns nothing, but for sdb and =
sdd:
> >
> > btrfs-map-logical -l 313163116052480 /dev/sdb
> > parent transid verify failed on 332196960649216 wanted 12747071 found 1=
2747073
> > parent transid verify failed on 332196960649216 wanted 12747071 found 1=
2747073
> > parent transid verify failed on 332196960649216 wanted 12747071 found 1=
2747073
> > ERROR: failed to read block groups: Input/output error
> > ERROR: open ctree failed
> >
> > btrfs-map-logical -l 313163116052480 /dev/sdd
> > parent transid verify failed on 332197012652032 wanted 12747073 found 1=
2747075
> > parent transid verify failed on 332197012652032 wanted 12747073 found 1=
2747075
> > parent transid verify failed on 332197012652032 wanted 12747073 found 1=
2747075
> > ERROR: failed to read block groups: Input/output error
> > ERROR: open ctree failed
> >
> > I'm guessing this is due to raid1c3 on the metadata?
>
> Is the fs mounted? Or it means the fs is fully corrupted.
>
> I'm not aware of any way to do the same chunk mapping with a mounted fs.
>
> But since you're sure the problem is from sdc, then it should be fine.
>
> Thanks,
> Qu
>
> >
> > On Wed, 11 Sept 2024 at 10:46, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
> >>
> >>
> >>
> >> =E5=9C=A8 2024/9/11 19:08, Neil Parton =E5=86=99=E9=81=93:
> >>> OK I have a new drive on the way which I was going to use to copy dat=
a
> >>> on to, but will now replace /dev/sdc to be on the safe side.  SMART
> >>> looks ok but don't want to go through this again!
> >>>
> >>> Maybe it was a bit flip?
> >>
> >> Nope, bitflip should not lead to a single mirror corruption, but all
> >> mirrors corrupted.
> >>
> >> This looks more like that specific disk (mirror 2 of that logical
> >> bytenr) is not fully following the FLUSH command.
> >>
> >> Thus some writes doesn't really reach disk but it still reports the
> >> FLUSH is finished.
> >>
> >> Furthermore only two tree blocks are affected, which may just mean the
> >> disk is only dropping part of the writes.
> >> Or you should have at least 4 tree blocks (root, subvolume(s), extent,
> >> free space trees) affected.
> >>
> >> This behavior will eventually leads to transid mismatch on a power los=
s.
> >> It's the other mirror(s) saving the day.
> >>
> >> And before replacing the disk, please really making sure that
> >> "btrfs-map-logical" is really reporting the mirror 2 is sdc, or you ca=
n
> >> still keep a bad disk in the array.
> >>
> >>
> >> Just keep running RAID1* for metadata, that's really a good practice.
> >>
> >> Thanks,
> >> Qu
> >>>
> >>> On Wed, 11 Sept 2024 at 10:32, Qu Wenruo <wqu@suse.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> =E5=9C=A8 2024/9/11 18:59, Neil Parton =E5=86=99=E9=81=93:
> >>>>> dmesg | grep BTRFS
> >>>>> [    2.551970] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b352=
286
> >>>>> devid 14 transid 12746924 /dev/sda scanned by btrfs (142)
> >>>>> [    2.552100] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b352=
286
> >>>>> devid 12 transid 12746924 /dev/sdc scanned by btrfs (142)
> >>>>> [    2.552225] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b352=
286
> >>>>> devid 15 transid 12746924 /dev/sdb scanned by btrfs (142)
> >>>>> [    2.552343] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b352=
286
> >>>>> devid 13 transid 12746924 /dev/sdd scanned by btrfs (142)
> >>>>> [    6.064021] BTRFS info (device sdc): first mount of filesystem
> >>>>> 75c9efec-6867-4c02-be5c-8d106b352286
> >>>>> [    6.064047] BTRFS info (device sdc): using crc32c (crc32c-intel)
> >>>>> checksum algorithm
> >>>>> [    6.064064] BTRFS info (device sdc): use zstd compression, level=
 3
> >>>>> [    6.064079] BTRFS info (device sdc): enabling auto defrag
> >>>>> [    6.064092] BTRFS info (device sdc): using free space tree
> >>>>> [   76.647420] BTRFS error (device sdc): level verify failed on
> >>>>> logical 313163105075200 mirror 2 wanted 0 found 1
> >>>>> [   76.660155] BTRFS info (device sdc): read error corrected: ino 0
> >>>>> off 313163105075200 (dev /dev/sdc sector 1145047360)
> >>>>> [   76.660353] BTRFS info (device sdc): read error corrected: ino 0
> >>>>> off 313163105079296 (dev /dev/sdc sector 1145047368)
> >>>>> [   76.660553] BTRFS info (device sdc): read error corrected: ino 0
> >>>>> off 313163105083392 (dev /dev/sdc sector 1145047376)
> >>>>> [   76.660719] BTRFS info (device sdc): read error corrected: ino 0
> >>>>> off 313163105087488 (dev /dev/sdc sector 1145047384)
> >>>>> [  153.697518] BTRFS info (device sdc): scrub: started on devid 12
> >>>>> [  153.875912] BTRFS info (device sdc): scrub: started on devid 14
> >>>>> [  153.876949] BTRFS info (device sdc): scrub: started on devid 15
> >>>>> [  153.943291] BTRFS info (device sdc): scrub: started on devid 13
> >>>>> [  260.968635] BTRFS error (device sdc): parent transid verify fail=
ed
> >>>>> on logical 313163116052480 mirror 2 wanted 12746898 found 12746888
> >>>>> [  261.047602] BTRFS info (device sdc): read error corrected: ino 0
> >>>>> off 313163116052480 (dev /dev/sdc sector 1145068800)
> >>>>> [  261.047893] BTRFS info (device sdc): read error corrected: ino 0
> >>>>> off 313163116056576 (dev /dev/sdc sector 1145068808)
> >>>>> [  261.051132] BTRFS info (device sdc): read error corrected: ino 0
> >>>>> off 313163116060672 (dev /dev/sdc sector 1145068816)
> >>>>> [  261.051398] BTRFS info (device sdc): read error corrected: ino 0
> >>>>> off 313163116064768 (dev /dev/sdc sector 1145068824)
> >>>>
> >>>> All happen on mirror 2.
> >>>>
> >>>> You can locate the device by:
> >>>>
> >>>> # btrfs-map-logical -l 313163116052480 /dev/sdc
> >>>>
> >>>> Which gives the device path.
> >>>>
> >>>> I would recommend to check the device's smart log and cables just in=
 case.
> >>>>
> >>>> Thanks,
> >>>> Qu
> >>>>>
> >>>>> On Wed, 11 Sept 2024 at 10:10, Qu Wenruo <quwenruo.btrfs@gmx.com> w=
rote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> =E5=9C=A8 2024/9/11 18:31, Neil Parton =E5=86=99=E9=81=93:
> >>>>>>> Many thanks Qu, I appear to be back up and running but I also had=
 to
> >>>>>>> run 'btrfs rescue zero-log' to get rid of a superblock error.
> >>>>>>> super-recover said the superblock was fine.
> >>>>>>
> >>>>>> This is not expected. I believe btrfs-rescue should check log tree=
s
> >>>>>> before doing the operation.
> >>>>>>
> >>>>>>>
> >>>>>>> On reboot and remount (as normal) I have a couple of residual tra=
nsid
> >>>>>>> errors and I'm currently running a full scrub to try and clean th=
ings
> >>>>>>> up.
> >>>>>>
> >>>>>> Transid is also not expected, if the transid error persists, it's =
a huge
> >>>>>> problem.
> >>>>>>
> >>>>>> Does the transid only shows on certain mirrors?
> >>>>>>
> >>>>>> Anyway a full dmesg from the first transid mismsatch will help a l=
ot to
> >>>>>> find out what's really going wrong.
> >>>>>>
> >>>>>> I hope it's really just the bad log trees.
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Qu
> >>>>>>>
> >>>>>>> Hopefully though I'm back up and running, this is the longest the=
 FS
> >>>>>>> has been mounted in 48 hours without it reverting to ro!
> >>>>>>>
> >>>>>>> Can't thank you enough for your help. I hope I'm not premature in
> >>>>>>> thanking you / will report back with any more errors.
> >>>>>>>
> >>>>>>> Regards
> >>>>>>>
> >>>>>>> Neil
> >>>>>>>
> >>>>>>> On Wed, 11 Sept 2024 at 09:55, Qu Wenruo <wqu@suse.com> wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> =E5=9C=A8 2024/9/11 17:43, Neil Parton =E5=86=99=E9=81=93:
> >>>>>>>>> Is it safe to run 'btrfs rescue clear-ino-cache' on all 4 drive=
s in
> >>>>>>>>> the array?
> >>>>>>>>
> >>>>>>>> Run it on any device of the fs.
> >>>>>>>>
> >>>>>>>> Most "btrfs rescue" sub-commands applies to a fs, not a device.
> >>>>>>>>
> >>>>>>>> And you must run the command with the fs unmounted.
> >>>>>>>>
> >>>>>>>>>      Reason I ask is when this first occurred it was one
> >>>>>>>>> particular drive reporting errors and now after switching out c=
ables
> >>>>>>>>> and to a different hard drive controller it's a different drive
> >>>>>>>>> reporting errors.
> >>>>>>>>>
> >>>>>>>>> It's also worth noting that this array was originally created o=
n a
> >>>>>>>>> Debian system some 6-8 years ago and I've gradually upgraded th=
e
> >>>>>>>>> drives over time to increase capacity, I'm up to drive ID 16 no=
w to
> >>>>>>>>> give you an idea.  Does that mean there are other gremlins pote=
ntially
> >>>>>>>>> lurking behind the scenes?
> >>>>>>>>
> >>>>>>>> Nope, this is really limited to that inode_cache mount option.
> >>>>>>>> I guess you mounted it once with inode_cache, but kernel never c=
leans
> >>>>>>>> that up, and until that feature is fully deprecated, and newer
> >>>>>>>> tree-checker consider it invalid, and trigger the problem.
> >>>>>>>>
> >>>>>>>> Thanks,
> >>>>>>>> Qu
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>> On Wed, 11 Sept 2024 at 09:04, Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> =E5=9C=A8 2024/9/11 17:24, Neil Parton =E5=86=99=E9=81=93:
> >>>>>>>>>>> btrfs check --readonly /dev/sda gives the following, I will r=
un a
> >>>>>>>>>>> lowmem command next and report back once finished (takes a wh=
ile)
> >>>>>>>>>>>
> >>>>>>>>>>> Opening filesystem to check...
> >>>>>>>>>>> Checking filesystem on /dev/sda
> >>>>>>>>>>> UUID: 75c9efec-6867-4c02-be5c-8d106b352286
> >>>>>>>>>>> [1/7] checking root items
> >>>>>>>>>>> [2/7] checking extents
> >>>>>>>>>>> [3/7] checking free space tree
> >>>>>>>>>>> [4/7] checking fs roots
> >>>>>>>>>>> [5/7] checking only csums items (without verifying data)
> >>>>>>>>>>> [6/7] checking root refs
> >>>>>>>>>>> [7/7] checking quota groups skipped (not enabled on this FS)
> >>>>>>>>>>> found 24251238731776 bytes used, no error found
> >>>>>>>>>>> total csum bytes: 23630850888
> >>>>>>>>>>> total tree bytes: 25387204608
> >>>>>>>>>>> total fs tree bytes: 586088448
> >>>>>>>>>>> total extent tree bytes: 446742528
> >>>>>>>>>>> btree space waste bytes: 751229234
> >>>>>>>>>>> file data blocks allocated: 132265579855872
> >>>>>>>>>>>        referenced 23958365622272
> >>>>>>>>>>>
> >>>>>>>>>>> When the error first occurred I didn't manage to capture what=
 was in
> >>>>>>>>>>> dmesg, but far more info seemed to be printed to the screen w=
hen I
> >>>>>>>>>>> check on subsequent tries, I have some photos of these messag=
es but no
> >>>>>>>>>>> text output, but can try again with some mount commands after=
 the
> >>>>>>>>>>> check has completed.
> >>>>>>>>>>>
> >>>>>>>>>>> dump as requested:
> >>>>>>>>>>>
> >>>>>>>>>> [...]
> >>>>>>>>>>>                       refs 1 gen 12567531 flags DATA
> >>>>>>>>>>>                       (178 0x674d52ffce820576) extent data ba=
ckref root 2543
> >>>>>>>>>>> objectid 18446744073709551604 offset 0 count 1
> >>>>>>>>>>
> >>>>>>>>>> This is the cause of the tree-checker.
> >>>>>>>>>>
> >>>>>>>>>> The objectid is -12, used to be the FREE_INO_OBJECTID for inod=
e cache.
> >>>>>>>>>>
> >>>>>>>>>> Unfortunately that feature is no longer supported, thus being =
rejected.
> >>>>>>>>>>
> >>>>>>>>>> I'm very surprised that someone has even used that feature.
> >>>>>>>>>>
> >>>>>>>>>> For now, it can be cleared by the following command:
> >>>>>>>>>>
> >>>>>>>>>>        # btrfs rescue clear-ino-cache /dev/sda
> >>>>>>>>>>
> >>>>>>>>>> Then kernel will no longer rejects it anymore.
> >>>>>>>>>>
> >>>>>>>>>> Thanks,
> >>>>>>>>>> Qu
> >>>>>>>>>
> >>>
> >

