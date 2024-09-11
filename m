Return-Path: <linux-btrfs+bounces-7938-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DCE974EA5
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 11:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C85284876
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 09:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD5718452B;
	Wed, 11 Sep 2024 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2hutQQt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B97078C9D
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 09:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047246; cv=none; b=NfJwd0BuHgOWDJHXwmWtfW6UG6V5s85jneyZc5jLUnSx6U4C89meEUe1aAr7e6X5kA+iQWUzTc1U9Jd/kzmTI4ZS830muTegmOkwNWDRdkKL/Pqggo4CkEQJMrAHcH5RyttWfCmPiNmg7mnLJhlU7oBcdeUbi21/E+sAZHHYuSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047246; c=relaxed/simple;
	bh=HBUZuMYkuPJATPLhU1Hd3XPCCohX4TjbJ6NUhNRwJbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rHWVS0pJ233Jyol4ji4Ojw1g/jBm4pLgmXMzi3/UFTJ+pN4uUrRxMYn4whZUfqIn64UNmaG02wMK2Vu7uJssneURRYC9HXZ1lyjj+mA/D47DiINpcRNEaREsvMYU5b+1r+UxAGsMQMDO74iEpC5SJQtNHWw01QutK8+33/TDnDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2hutQQt; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a99de9beb2so300797985a.3
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 02:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726047244; x=1726652044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tS/jlApwiFrjUTmUtr3z9ZLLZ61RWbGkn2uJ2iUizmE=;
        b=S2hutQQtXgjx/6qiNeXC2VQhfMdhQcOM0j16m9Sw5MwkYAdvw2hzs5KJ0rVxg7VeNu
         /F3++ZJQb+RmbldwczmVJEE38an0O1DIuTn/JEOtox6x1zmmjttk6Dktrm+m0IwlTgzF
         CIiMvb3CFFNZuoaHrGssa37PjQsEi8XtzIQiNTwf9Tsz1h7ew+QM7rrawQCFWQJ3HEYf
         h9H+E6iNFTsFiyC8hdJ7eGD5dFKyxlQN6kSWRuBbEUkypTzubuHI6D5g8ZfHIuMyErzj
         xXp6XYXq0Q7IXpXDlYU9ssiTAjyC2Py7DEDE7gYqNIkcGSFCQyyBdrWwrYwdS0+CN7et
         61ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726047244; x=1726652044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tS/jlApwiFrjUTmUtr3z9ZLLZ61RWbGkn2uJ2iUizmE=;
        b=BPaIrFG4W583BzVokJCGkAnk1bgGvJivhk197w6PRC6t8rCqmI1bH1MVnWoW33SBGN
         naFzysKKTYFF3iDTUoOeVXbhdtbMBJJZB1JvR3MUJae5ZAtB3Ehqpt8k2ZLDuyEzUeJf
         wId8YavlD4gsYBcj2jkVOyI6I7zOAA2yJDbuow6SzUa7DZZtudqDSy4vPCnLbJ0wxqMh
         sj4q+9fv/0/rdxPSl9QZ9zmRgWeZvN/uhhjlK9trpcoQTx8qdZWvIlG+EVcIOVc11gg+
         kUIOojNGU8EmlAu4qaziZnroCwPTuciHysxL95Bp19xFR96uXwgj0FeoPLchCyGIzqqo
         xEJw==
X-Forwarded-Encrypted: i=1; AJvYcCU0/XHhMnUSOStNi0mzi7S2m1byUeK82eSRiRLylwYm3mom8AC3zLde6cr5i3lhm3W03J0yKL+koyMS6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqo0oOFKn4c41umsWYoeeIocGD1KD4BemKXrqlIRCBm2JbHd+9
	ljjAJ87e01Do0gRpwTE+Jvn+J4P0QUkklaEfSJ2esKOMicaSKMfzmhDW7leTk+6yIgjsvSeP7jL
	n7oN+RHK9GWh84B8wo2N7az6jdEdSTB1y
X-Google-Smtp-Source: AGHT+IGSURuAvO7rvSKYpj+bzWkS9OB9ZHLzjxFApLd1Am6EG1701mxH4X+ho0NS1QYuZAa7h6Wpz8QDNE10fnq1vGI=
X-Received: by 2002:a05:620a:3f85:b0:7a9:ba0d:8e7c with SMTP id
 af79cd13be357-7a9ba0d94b7mr1503519585a.8.1726047243881; Wed, 11 Sep 2024
 02:34:03 -0700 (PDT)
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
 <CAAYHqBZHJ4wXUN7HwbO_tHqaoRJAkCG=Ypqf-P0OaLn5AXmtyA@mail.gmail.com>
In-Reply-To: <CAAYHqBZHJ4wXUN7HwbO_tHqaoRJAkCG=Ypqf-P0OaLn5AXmtyA@mail.gmail.com>
From: Neil Parton <njparton@gmail.com>
Date: Wed, 11 Sep 2024 10:33:53 +0100
Message-ID: <CAAYHqBbKiauOC3yTJwtHEg97NptqdPMkJ4c-1-rOaWFEQwaofQ@mail.gmail.com>
Subject: Re: Tree corruption
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

dmesg | grep error
[    6.028077] platform regulatory.0: Direct firmware load for
regulatory.db failed with error -2
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
[ 2803.470703] BTRFS error (device sdc): fixed up error at logical
313163165204480 on dev /dev/sdc physical 586324377600
[ 2803.470787] BTRFS error (device sdc): fixed up error at logical
313163165204480 on dev /dev/sdc physical 586324377600
[ 2803.470847] BTRFS error (device sdc): fixed up error at logical
313163165204480 on dev /dev/sdc physical 586324377600
[ 2803.470904] BTRFS error (device sdc): fixed up error at logical
313163165204480 on dev /dev/sdc physical 586324377600

On Wed, 11 Sept 2024 at 10:32, Neil Parton <njparton@gmail.com> wrote:
>
> btrfs scrub status /mnt/btrfs_raid
> UUID:             75c9efec-6867-4c02-be5c-8d106b352286
> Scrub started:    Wed Sep 11 09:44:33 2024
> Status:           running
> Duration:         0:46:06
> Time left:        24:24:30
> ETA:              Thu Sep 12 10:55:11 2024
> Total to scrub:   44.13TiB
> Bytes scrubbed:   1.35TiB  (3.05%)
> Rate:             510.55MiB/s
> Error summary:    verify=3D4
>   Corrected:      4
>   Uncorrectable:  0
>   Unverified:     0
>
> On Wed, 11 Sept 2024 at 10:29, Neil Parton <njparton@gmail.com> wrote:
> >
> > dmesg | grep BTRFS
> > [    2.551970] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b352286
> > devid 14 transid 12746924 /dev/sda scanned by btrfs (142)
> > [    2.552100] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b352286
> > devid 12 transid 12746924 /dev/sdc scanned by btrfs (142)
> > [    2.552225] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b352286
> > devid 15 transid 12746924 /dev/sdb scanned by btrfs (142)
> > [    2.552343] BTRFS: device fsid 75c9efec-6867-4c02-be5c-8d106b352286
> > devid 13 transid 12746924 /dev/sdd scanned by btrfs (142)
> > [    6.064021] BTRFS info (device sdc): first mount of filesystem
> > 75c9efec-6867-4c02-be5c-8d106b352286
> > [    6.064047] BTRFS info (device sdc): using crc32c (crc32c-intel)
> > checksum algorithm
> > [    6.064064] BTRFS info (device sdc): use zstd compression, level 3
> > [    6.064079] BTRFS info (device sdc): enabling auto defrag
> > [    6.064092] BTRFS info (device sdc): using free space tree
> > [   76.647420] BTRFS error (device sdc): level verify failed on
> > logical 313163105075200 mirror 2 wanted 0 found 1
> > [   76.660155] BTRFS info (device sdc): read error corrected: ino 0
> > off 313163105075200 (dev /dev/sdc sector 1145047360)
> > [   76.660353] BTRFS info (device sdc): read error corrected: ino 0
> > off 313163105079296 (dev /dev/sdc sector 1145047368)
> > [   76.660553] BTRFS info (device sdc): read error corrected: ino 0
> > off 313163105083392 (dev /dev/sdc sector 1145047376)
> > [   76.660719] BTRFS info (device sdc): read error corrected: ino 0
> > off 313163105087488 (dev /dev/sdc sector 1145047384)
> > [  153.697518] BTRFS info (device sdc): scrub: started on devid 12
> > [  153.875912] BTRFS info (device sdc): scrub: started on devid 14
> > [  153.876949] BTRFS info (device sdc): scrub: started on devid 15
> > [  153.943291] BTRFS info (device sdc): scrub: started on devid 13
> > [  260.968635] BTRFS error (device sdc): parent transid verify failed
> > on logical 313163116052480 mirror 2 wanted 12746898 found 12746888
> > [  261.047602] BTRFS info (device sdc): read error corrected: ino 0
> > off 313163116052480 (dev /dev/sdc sector 1145068800)
> > [  261.047893] BTRFS info (device sdc): read error corrected: ino 0
> > off 313163116056576 (dev /dev/sdc sector 1145068808)
> > [  261.051132] BTRFS info (device sdc): read error corrected: ino 0
> > off 313163116060672 (dev /dev/sdc sector 1145068816)
> > [  261.051398] BTRFS info (device sdc): read error corrected: ino 0
> > off 313163116064768 (dev /dev/sdc sector 1145068824)
> >
> > On Wed, 11 Sept 2024 at 10:10, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
> > >
> > >
> > >
> > > =E5=9C=A8 2024/9/11 18:31, Neil Parton =E5=86=99=E9=81=93:
> > > > Many thanks Qu, I appear to be back up and running but I also had t=
o
> > > > run 'btrfs rescue zero-log' to get rid of a superblock error.
> > > > super-recover said the superblock was fine.
> > >
> > > This is not expected. I believe btrfs-rescue should check log trees
> > > before doing the operation.
> > >
> > > >
> > > > On reboot and remount (as normal) I have a couple of residual trans=
id
> > > > errors and I'm currently running a full scrub to try and clean thin=
gs
> > > > up.
> > >
> > > Transid is also not expected, if the transid error persists, it's a h=
uge
> > > problem.
> > >
> > > Does the transid only shows on certain mirrors?
> > >
> > > Anyway a full dmesg from the first transid mismsatch will help a lot =
to
> > > find out what's really going wrong.
> > >
> > > I hope it's really just the bad log trees.
> > >
> > > Thanks,
> > > Qu
> > > >
> > > > Hopefully though I'm back up and running, this is the longest the F=
S
> > > > has been mounted in 48 hours without it reverting to ro!
> > > >
> > > > Can't thank you enough for your help. I hope I'm not premature in
> > > > thanking you / will report back with any more errors.
> > > >
> > > > Regards
> > > >
> > > > Neil
> > > >
> > > > On Wed, 11 Sept 2024 at 09:55, Qu Wenruo <wqu@suse.com> wrote:
> > > >>
> > > >>
> > > >>
> > > >> =E5=9C=A8 2024/9/11 17:43, Neil Parton =E5=86=99=E9=81=93:
> > > >>> Is it safe to run 'btrfs rescue clear-ino-cache' on all 4 drives =
in
> > > >>> the array?
> > > >>
> > > >> Run it on any device of the fs.
> > > >>
> > > >> Most "btrfs rescue" sub-commands applies to a fs, not a device.
> > > >>
> > > >> And you must run the command with the fs unmounted.
> > > >>
> > > >>>   Reason I ask is when this first occurred it was one
> > > >>> particular drive reporting errors and now after switching out cab=
les
> > > >>> and to a different hard drive controller it's a different drive
> > > >>> reporting errors.
> > > >>>
> > > >>> It's also worth noting that this array was originally created on =
a
> > > >>> Debian system some 6-8 years ago and I've gradually upgraded the
> > > >>> drives over time to increase capacity, I'm up to drive ID 16 now =
to
> > > >>> give you an idea.  Does that mean there are other gremlins potent=
ially
> > > >>> lurking behind the scenes?
> > > >>
> > > >> Nope, this is really limited to that inode_cache mount option.
> > > >> I guess you mounted it once with inode_cache, but kernel never cle=
ans
> > > >> that up, and until that feature is fully deprecated, and newer
> > > >> tree-checker consider it invalid, and trigger the problem.
> > > >>
> > > >> Thanks,
> > > >> Qu
> > > >>
> > > >>>
> > > >>> On Wed, 11 Sept 2024 at 09:04, Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
> > > >>>>
> > > >>>>
> > > >>>>
> > > >>>> =E5=9C=A8 2024/9/11 17:24, Neil Parton =E5=86=99=E9=81=93:
> > > >>>>> btrfs check --readonly /dev/sda gives the following, I will run=
 a
> > > >>>>> lowmem command next and report back once finished (takes a whil=
e)
> > > >>>>>
> > > >>>>> Opening filesystem to check...
> > > >>>>> Checking filesystem on /dev/sda
> > > >>>>> UUID: 75c9efec-6867-4c02-be5c-8d106b352286
> > > >>>>> [1/7] checking root items
> > > >>>>> [2/7] checking extents
> > > >>>>> [3/7] checking free space tree
> > > >>>>> [4/7] checking fs roots
> > > >>>>> [5/7] checking only csums items (without verifying data)
> > > >>>>> [6/7] checking root refs
> > > >>>>> [7/7] checking quota groups skipped (not enabled on this FS)
> > > >>>>> found 24251238731776 bytes used, no error found
> > > >>>>> total csum bytes: 23630850888
> > > >>>>> total tree bytes: 25387204608
> > > >>>>> total fs tree bytes: 586088448
> > > >>>>> total extent tree bytes: 446742528
> > > >>>>> btree space waste bytes: 751229234
> > > >>>>> file data blocks allocated: 132265579855872
> > > >>>>>     referenced 23958365622272
> > > >>>>>
> > > >>>>> When the error first occurred I didn't manage to capture what w=
as in
> > > >>>>> dmesg, but far more info seemed to be printed to the screen whe=
n I
> > > >>>>> check on subsequent tries, I have some photos of these messages=
 but no
> > > >>>>> text output, but can try again with some mount commands after t=
he
> > > >>>>> check has completed.
> > > >>>>>
> > > >>>>> dump as requested:
> > > >>>>>
> > > >>>> [...]
> > > >>>>>                    refs 1 gen 12567531 flags DATA
> > > >>>>>                    (178 0x674d52ffce820576) extent data backref=
 root 2543
> > > >>>>> objectid 18446744073709551604 offset 0 count 1
> > > >>>>
> > > >>>> This is the cause of the tree-checker.
> > > >>>>
> > > >>>> The objectid is -12, used to be the FREE_INO_OBJECTID for inode =
cache.
> > > >>>>
> > > >>>> Unfortunately that feature is no longer supported, thus being re=
jected.
> > > >>>>
> > > >>>> I'm very surprised that someone has even used that feature.
> > > >>>>
> > > >>>> For now, it can be cleared by the following command:
> > > >>>>
> > > >>>>     # btrfs rescue clear-ino-cache /dev/sda
> > > >>>>
> > > >>>> Then kernel will no longer rejects it anymore.
> > > >>>>
> > > >>>> Thanks,
> > > >>>> Qu
> > > >>>

