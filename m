Return-Path: <linux-btrfs+bounces-7935-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 799C0974E80
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 11:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC360B25818
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 09:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806DF17838C;
	Wed, 11 Sep 2024 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMdUJEiL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4DA17C228
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047011; cv=none; b=JlJtgUNR0TnnmEUv1A5IALr7c/c5Y0pDWIQnf/oW9Ndzl3/gcRug4YtwgZvoYVQ9t/Kb5NMGcwdcY/S5MxFv0TwZAF5miU5BwY1jZV3ZLiObm0/AHAyyO/6DaCJvYGi/KtrumyjAsJc4k4lbdCrIdXN423Ck+UZmDh5eb9uHg+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047011; c=relaxed/simple;
	bh=BiAhLZVlekEavwrDhuEhNXJkF2nqP5q9PLMXkJYZZJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lgIA3/OUjsTYeZY0CTTdvcdE+b3dvg6m3MNmkcIfrUfklD+cx5IuIhlYLGn9FHO/oB+8QkWp1BijbpCLdxwpKGRuWOCXPF4gyAjLSvn0gQFb4zeKucu/kbsXM9gCvTmPYxJkwl4HVRGSng/3JJxvTxTE9sWQp9toE5eQlLjWi7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMdUJEiL; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a99fdf2e1aso415919885a.2
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 02:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726047009; x=1726651809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5oRzGotL4mPRUx9F0HLuY4cGzgfQMuJT1ps2+G2pA0=;
        b=XMdUJEiLJ6ot3GKn7aWlc1Db5YoR/JEpjQYv/0fcUMmcsoiGSizkwGIs4h9Y91HPt0
         JYYgaw/8M60DEFCYnotRhCzLWsuuLYe64xNj/TJnD9kOxPMq/6dsRYRwVi1nDL06FPxT
         ljxT24t3NaS+azEoy2FLKVZd+ZHYmInJn+WeVPpEHCapDPss7yHZduAHO8G2iZ76jBiW
         VAhqtLP6CJ8U9nVpfEYdtPqmP9fc5IszzKGjNMzIronCbAnqBpV4f3F7gveLoehr06At
         pCJz7Q1xMpoAmc9zCG8hQikYmLUEhx8XOH3HQfs6v9iLIun0Tjl0wJgnC0Ij6q5GCXir
         0RtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726047009; x=1726651809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5oRzGotL4mPRUx9F0HLuY4cGzgfQMuJT1ps2+G2pA0=;
        b=J6LLZDEV7tM+RhV7gOBfN61CQbZy/Ljesp8oaDkvNQcePM3Og5noUpdn3lTZAzL+Yk
         GO5eUMOGl3cwajEmuLMU2ipOZQHGxs8TqBto+f26MenatTDXzO8qTxr30pA77pI7W8uP
         1jc/4MvK5qDWGObbn31gJQWyzwvk8d/J2pFc1+WSXSMRB9fsrKAfdTBg3R9rpkk7Rbxj
         j8WPGOVqFQvtq7gyeak1nxrTqGRSW0d8oFE/NKf3nvSYd8TGFpFyN+bCUlRNlNB4yXi4
         KGKDb72PDAWh+ZmI+GlvkXM9GzUEDZ8z20vpAAIHknuKh6QCARzVd3jpz2ffgf/ZruW6
         1vOA==
X-Forwarded-Encrypted: i=1; AJvYcCVYD0ivr1Z6VWUgXj6S+fQJSuNQ5tto5/vmb9xmXff/U/ZECIxgCL2HjCa1H7kA37PEQvzC4byb/ThflA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJNj/lXzEB+QxzNDvCpehNLWoYXDRbK+iE+vCeiDpIxLi5odZT
	ApXQOcz6FIo8phH1ee7vkqJiHsooxGjIk5SbgvuVFnO3zMnr4NnssPJc+PMdhyP+4b0Q0hLqd8M
	h5gdMMq6THJKtN+P1nRrvtJH5Wsc=
X-Google-Smtp-Source: AGHT+IE+BkVzC2f/Bj+Co5tDzv1IWOHRj2ue667Y4uWJIWQvGDNhDCBENVU71vfMxmZ6eRMrxeeTXhiZ32HIxtqbMuU=
X-Received: by 2002:a05:620a:2596:b0:79f:67b:4fdc with SMTP id
 af79cd13be357-7a99732852amr2557537385a.2.1726047008898; Wed, 11 Sep 2024
 02:30:08 -0700 (PDT)
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
 <12a91072-9289-479a-8a15-4c4f0894ead1@gmx.com>
In-Reply-To: <12a91072-9289-479a-8a15-4c4f0894ead1@gmx.com>
From: Neil Parton <njparton@gmail.com>
Date: Wed, 11 Sep 2024 10:29:58 +0100
Message-ID: <CAAYHqBbfXj64BuY5kESx+8NJReqz-dzKeXHwf=vHKqYhKVwB3w@mail.gmail.com>
Subject: Re: Tree corruption
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

dmesg | grep BTRFS
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

On Wed, 11 Sept 2024 at 10:10, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> =E5=9C=A8 2024/9/11 18:31, Neil Parton =E5=86=99=E9=81=93:
> > Many thanks Qu, I appear to be back up and running but I also had to
> > run 'btrfs rescue zero-log' to get rid of a superblock error.
> > super-recover said the superblock was fine.
>
> This is not expected. I believe btrfs-rescue should check log trees
> before doing the operation.
>
> >
> > On reboot and remount (as normal) I have a couple of residual transid
> > errors and I'm currently running a full scrub to try and clean things
> > up.
>
> Transid is also not expected, if the transid error persists, it's a huge
> problem.
>
> Does the transid only shows on certain mirrors?
>
> Anyway a full dmesg from the first transid mismsatch will help a lot to
> find out what's really going wrong.
>
> I hope it's really just the bad log trees.
>
> Thanks,
> Qu
> >
> > Hopefully though I'm back up and running, this is the longest the FS
> > has been mounted in 48 hours without it reverting to ro!
> >
> > Can't thank you enough for your help. I hope I'm not premature in
> > thanking you / will report back with any more errors.
> >
> > Regards
> >
> > Neil
> >
> > On Wed, 11 Sept 2024 at 09:55, Qu Wenruo <wqu@suse.com> wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2024/9/11 17:43, Neil Parton =E5=86=99=E9=81=93:
> >>> Is it safe to run 'btrfs rescue clear-ino-cache' on all 4 drives in
> >>> the array?
> >>
> >> Run it on any device of the fs.
> >>
> >> Most "btrfs rescue" sub-commands applies to a fs, not a device.
> >>
> >> And you must run the command with the fs unmounted.
> >>
> >>>   Reason I ask is when this first occurred it was one
> >>> particular drive reporting errors and now after switching out cables
> >>> and to a different hard drive controller it's a different drive
> >>> reporting errors.
> >>>
> >>> It's also worth noting that this array was originally created on a
> >>> Debian system some 6-8 years ago and I've gradually upgraded the
> >>> drives over time to increase capacity, I'm up to drive ID 16 now to
> >>> give you an idea.  Does that mean there are other gremlins potentiall=
y
> >>> lurking behind the scenes?
> >>
> >> Nope, this is really limited to that inode_cache mount option.
> >> I guess you mounted it once with inode_cache, but kernel never cleans
> >> that up, and until that feature is fully deprecated, and newer
> >> tree-checker consider it invalid, and trigger the problem.
> >>
> >> Thanks,
> >> Qu
> >>
> >>>
> >>> On Wed, 11 Sept 2024 at 09:04, Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
> >>>>
> >>>>
> >>>>
> >>>> =E5=9C=A8 2024/9/11 17:24, Neil Parton =E5=86=99=E9=81=93:
> >>>>> btrfs check --readonly /dev/sda gives the following, I will run a
> >>>>> lowmem command next and report back once finished (takes a while)
> >>>>>
> >>>>> Opening filesystem to check...
> >>>>> Checking filesystem on /dev/sda
> >>>>> UUID: 75c9efec-6867-4c02-be5c-8d106b352286
> >>>>> [1/7] checking root items
> >>>>> [2/7] checking extents
> >>>>> [3/7] checking free space tree
> >>>>> [4/7] checking fs roots
> >>>>> [5/7] checking only csums items (without verifying data)
> >>>>> [6/7] checking root refs
> >>>>> [7/7] checking quota groups skipped (not enabled on this FS)
> >>>>> found 24251238731776 bytes used, no error found
> >>>>> total csum bytes: 23630850888
> >>>>> total tree bytes: 25387204608
> >>>>> total fs tree bytes: 586088448
> >>>>> total extent tree bytes: 446742528
> >>>>> btree space waste bytes: 751229234
> >>>>> file data blocks allocated: 132265579855872
> >>>>>     referenced 23958365622272
> >>>>>
> >>>>> When the error first occurred I didn't manage to capture what was i=
n
> >>>>> dmesg, but far more info seemed to be printed to the screen when I
> >>>>> check on subsequent tries, I have some photos of these messages but=
 no
> >>>>> text output, but can try again with some mount commands after the
> >>>>> check has completed.
> >>>>>
> >>>>> dump as requested:
> >>>>>
> >>>> [...]
> >>>>>                    refs 1 gen 12567531 flags DATA
> >>>>>                    (178 0x674d52ffce820576) extent data backref roo=
t 2543
> >>>>> objectid 18446744073709551604 offset 0 count 1
> >>>>
> >>>> This is the cause of the tree-checker.
> >>>>
> >>>> The objectid is -12, used to be the FREE_INO_OBJECTID for inode cach=
e.
> >>>>
> >>>> Unfortunately that feature is no longer supported, thus being reject=
ed.
> >>>>
> >>>> I'm very surprised that someone has even used that feature.
> >>>>
> >>>> For now, it can be cleared by the following command:
> >>>>
> >>>>     # btrfs rescue clear-ino-cache /dev/sda
> >>>>
> >>>> Then kernel will no longer rejects it anymore.
> >>>>
> >>>> Thanks,
> >>>> Qu
> >>>

