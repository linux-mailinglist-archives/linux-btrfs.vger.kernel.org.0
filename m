Return-Path: <linux-btrfs+bounces-7939-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F48974EC8
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 11:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1201C2239F
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 09:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10E2155398;
	Wed, 11 Sep 2024 09:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UM75FlUU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2893E155346
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 09:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047508; cv=none; b=Wf5tjqepOIukGEPThj0mGqAks9KrZUKE3WeAGT/c6hNruvopNqhiCaxge6mNg/X1qfqnMnC4xtDTFm5nCKKB9iuojZA1tafp5znN6kQ8FRA8DSx5VKP0dVd2mNJMh+EFibSKtfz6a5b448sT+JF0ifVICdTb7mzum7aJ9lwccHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047508; c=relaxed/simple;
	bh=V+Jj53OZmWLadywOO10RtfyEoXojXvJ/VohcPcvv6ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IIh/G9ZgrLzn0LRgYq2xLx8xduHvUPF8fYHbwS0vwdReypQDPX8s8MjXodeeS+9e9B+l7OrCXfcaeX76APpbZ3rfYdExZFiJm/Q+Sjr3SU4ybfgi8oV3dxMi05QXuNdjeTxyqcgXqe0KZAUyW7yfX1tpnDq0tkSDsKvF9rPwUzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UM75FlUU; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a9ac0092d9so352865085a.1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 02:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726047506; x=1726652306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnpfHhSzSC4COx5tr5Uvj97nbCLGoncoJuK1ZatXsws=;
        b=UM75FlUUfA530aSxSvVxd/lt/qyVgLKsgWpqh1OAth239omLNoSVaiNVPunssQY6Y5
         Z0SvRIp3vUMq+vrUGVsPMCYZ4RKGllmPiI86Vzfy1ShYfZbasQP/74xor368CjgM8Fl6
         9wZghvvFoyHIbWdYV2sVmBQSmaO8yp6oor7TsmMIz1nh34NOmp374SGzA3GgkKCCmXW5
         8Ena83Afrb9X89MxPJgSMtK2b6YlAJsFgtik87PsTPz/11LpqMgYmSyVCK6kvIS4qDAD
         0gfEiGqLU2Sg2rE7geitBEZ5OR+xw6n3I6brF3af80Bsdvw8EL1QNYh8jYbxPdNdrRfy
         pMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726047506; x=1726652306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnpfHhSzSC4COx5tr5Uvj97nbCLGoncoJuK1ZatXsws=;
        b=GUi0UGF/4xzizx/0+Nd6/5yHFjCzUr0g1WW3GynXeWAVRv1TzRorqMaHv4cCgsR9wE
         AvUYUh+uxCkUj9wQGXCWPyDgqj5VwXnCqrQhX0cFGxRVuOCm6Ze8gva3o3WD0hCmHkqv
         ubt77BJNcCSPMn/u1iwRlvK9otTVpYaecAQZTwGJChW5I24JpLUMs5eIm8muWpoo5rKp
         k2FxFkTOgXW9XPczutp8G6w1W1+JQhPyXnE7HDM9zIXNhZQzrITfF+wJmrq7JM7Yj7OM
         IazQ2gUdV9Ooi6ZjsB8ChraI6rkG50E+UCrbSawDbAMfZU+hqZbFhwuR6Qb85PNXld0n
         V2uw==
X-Forwarded-Encrypted: i=1; AJvYcCVzSescPcfyzTwFM+J26kNd2r2Re0yqkvbtTpKRgNQWYROP+N/uBhCe+khWBYQJKPntiQJqyIGgBirtRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxX26LVcpQ+G/CPnITs3z7B5scL+d6zJZRDk8NtR44hhMVdo/d
	we53W5wmdjm0AV2nWphq2regyMy7Ql8Xq/VnfVkJwKxY+8MAv2MBGpJ2NnO3tEtpnht3N3Rvhi9
	fqNL3UkBKDGGQE3QyXCFhABL7Q7w=
X-Google-Smtp-Source: AGHT+IHDPDDeo8vGG3zlO8wSJO9RkIyCUGj86F1sPRMrU2wXGIs17xTVB2IyC4qGDFg1fYMzMIasvy04InIwxd9ixrU=
X-Received: by 2002:a05:620a:25a:b0:7a9:bfcb:6d7e with SMTP id
 af79cd13be357-7a9bfcb6e8cmr599251285a.66.1726047505982; Wed, 11 Sep 2024
 02:38:25 -0700 (PDT)
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
 <d96b8a47-3361-4226-b98a-67386bd6e7f4@suse.com>
In-Reply-To: <d96b8a47-3361-4226-b98a-67386bd6e7f4@suse.com>
From: Neil Parton <njparton@gmail.com>
Date: Wed, 11 Sep 2024 10:38:15 +0100
Message-ID: <CAAYHqBbcQwLqn4SBnKbimgttUbNxMRnH0AhwYKXJTJu1G=C9ZQ@mail.gmail.com>
Subject: Re: Tree corruption
To: Qu Wenruo <wqu@suse.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

OK I have a new drive on the way which I was going to use to copy data
on to, but will now replace /dev/sdc to be on the safe side.  SMART
looks ok but don't want to go through this again!

Maybe it was a bit flip?

On Wed, 11 Sept 2024 at 10:32, Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2024/9/11 18:59, Neil Parton =E5=86=99=E9=81=93:
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
>
> All happen on mirror 2.
>
> You can locate the device by:
>
> # btrfs-map-logical -l 313163116052480 /dev/sdc
>
> Which gives the device path.
>
> I would recommend to check the device's smart log and cables just in case=
.
>
> Thanks,
> Qu
> >
> > On Wed, 11 Sept 2024 at 10:10, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
> >>
> >>
> >>
> >> =E5=9C=A8 2024/9/11 18:31, Neil Parton =E5=86=99=E9=81=93:
> >>> Many thanks Qu, I appear to be back up and running but I also had to
> >>> run 'btrfs rescue zero-log' to get rid of a superblock error.
> >>> super-recover said the superblock was fine.
> >>
> >> This is not expected. I believe btrfs-rescue should check log trees
> >> before doing the operation.
> >>
> >>>
> >>> On reboot and remount (as normal) I have a couple of residual transid
> >>> errors and I'm currently running a full scrub to try and clean things
> >>> up.
> >>
> >> Transid is also not expected, if the transid error persists, it's a hu=
ge
> >> problem.
> >>
> >> Does the transid only shows on certain mirrors?
> >>
> >> Anyway a full dmesg from the first transid mismsatch will help a lot t=
o
> >> find out what's really going wrong.
> >>
> >> I hope it's really just the bad log trees.
> >>
> >> Thanks,
> >> Qu
> >>>
> >>> Hopefully though I'm back up and running, this is the longest the FS
> >>> has been mounted in 48 hours without it reverting to ro!
> >>>
> >>> Can't thank you enough for your help. I hope I'm not premature in
> >>> thanking you / will report back with any more errors.
> >>>
> >>> Regards
> >>>
> >>> Neil
> >>>
> >>> On Wed, 11 Sept 2024 at 09:55, Qu Wenruo <wqu@suse.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> =E5=9C=A8 2024/9/11 17:43, Neil Parton =E5=86=99=E9=81=93:
> >>>>> Is it safe to run 'btrfs rescue clear-ino-cache' on all 4 drives in
> >>>>> the array?
> >>>>
> >>>> Run it on any device of the fs.
> >>>>
> >>>> Most "btrfs rescue" sub-commands applies to a fs, not a device.
> >>>>
> >>>> And you must run the command with the fs unmounted.
> >>>>
> >>>>>    Reason I ask is when this first occurred it was one
> >>>>> particular drive reporting errors and now after switching out cable=
s
> >>>>> and to a different hard drive controller it's a different drive
> >>>>> reporting errors.
> >>>>>
> >>>>> It's also worth noting that this array was originally created on a
> >>>>> Debian system some 6-8 years ago and I've gradually upgraded the
> >>>>> drives over time to increase capacity, I'm up to drive ID 16 now to
> >>>>> give you an idea.  Does that mean there are other gremlins potentia=
lly
> >>>>> lurking behind the scenes?
> >>>>
> >>>> Nope, this is really limited to that inode_cache mount option.
> >>>> I guess you mounted it once with inode_cache, but kernel never clean=
s
> >>>> that up, and until that feature is fully deprecated, and newer
> >>>> tree-checker consider it invalid, and trigger the problem.
> >>>>
> >>>> Thanks,
> >>>> Qu
> >>>>
> >>>>>
> >>>>> On Wed, 11 Sept 2024 at 09:04, Qu Wenruo <quwenruo.btrfs@gmx.com> w=
rote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> =E5=9C=A8 2024/9/11 17:24, Neil Parton =E5=86=99=E9=81=93:
> >>>>>>> btrfs check --readonly /dev/sda gives the following, I will run a
> >>>>>>> lowmem command next and report back once finished (takes a while)
> >>>>>>>
> >>>>>>> Opening filesystem to check...
> >>>>>>> Checking filesystem on /dev/sda
> >>>>>>> UUID: 75c9efec-6867-4c02-be5c-8d106b352286
> >>>>>>> [1/7] checking root items
> >>>>>>> [2/7] checking extents
> >>>>>>> [3/7] checking free space tree
> >>>>>>> [4/7] checking fs roots
> >>>>>>> [5/7] checking only csums items (without verifying data)
> >>>>>>> [6/7] checking root refs
> >>>>>>> [7/7] checking quota groups skipped (not enabled on this FS)
> >>>>>>> found 24251238731776 bytes used, no error found
> >>>>>>> total csum bytes: 23630850888
> >>>>>>> total tree bytes: 25387204608
> >>>>>>> total fs tree bytes: 586088448
> >>>>>>> total extent tree bytes: 446742528
> >>>>>>> btree space waste bytes: 751229234
> >>>>>>> file data blocks allocated: 132265579855872
> >>>>>>>      referenced 23958365622272
> >>>>>>>
> >>>>>>> When the error first occurred I didn't manage to capture what was=
 in
> >>>>>>> dmesg, but far more info seemed to be printed to the screen when =
I
> >>>>>>> check on subsequent tries, I have some photos of these messages b=
ut no
> >>>>>>> text output, but can try again with some mount commands after the
> >>>>>>> check has completed.
> >>>>>>>
> >>>>>>> dump as requested:
> >>>>>>>
> >>>>>> [...]
> >>>>>>>                     refs 1 gen 12567531 flags DATA
> >>>>>>>                     (178 0x674d52ffce820576) extent data backref =
root 2543
> >>>>>>> objectid 18446744073709551604 offset 0 count 1
> >>>>>>
> >>>>>> This is the cause of the tree-checker.
> >>>>>>
> >>>>>> The objectid is -12, used to be the FREE_INO_OBJECTID for inode ca=
che.
> >>>>>>
> >>>>>> Unfortunately that feature is no longer supported, thus being reje=
cted.
> >>>>>>
> >>>>>> I'm very surprised that someone has even used that feature.
> >>>>>>
> >>>>>> For now, it can be cleared by the following command:
> >>>>>>
> >>>>>>      # btrfs rescue clear-ino-cache /dev/sda
> >>>>>>
> >>>>>> Then kernel will no longer rejects it anymore.
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Qu
> >>>>>

