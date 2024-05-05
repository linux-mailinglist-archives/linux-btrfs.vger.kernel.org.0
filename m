Return-Path: <linux-btrfs+bounces-4746-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2518BBF2D
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 May 2024 05:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AE331C20D0D
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 May 2024 03:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DE41860;
	Sun,  5 May 2024 03:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUHXlLWe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189AD17CD
	for <linux-btrfs@vger.kernel.org>; Sun,  5 May 2024 03:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714881333; cv=none; b=Zk1JBHj/YxCrzkwR06//bROUJkkVTEMhufUVvFzlnLk3j//miGw25RW+6o3sre+3ZVsLDVWNDgRKoWOdZD5zNfZOMY2OP5mEw9FbgEFNNhBJ5Wm3x80Ch7zXZl5thFT9hHhblkyBdFtEispA9xQdAF6Di7tPRXpNytH9P5M405c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714881333; c=relaxed/simple;
	bh=JaXwEA09zycgmDB0wWvsPe3RtdD5ybtnQsgDcKKB0Ks=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=Hc2tRHiYhDnr1ZW9z3SKtgDii92A9M7LV8FenfGJhst/wPoIca1zWXuZ9DNJsigAFMw2xTcq0L5B4iN+ILi3GzASWfHdtkCJl3LwtDOWyIWc2AppO3C58J8ElADEoYr4MWZya8EVQ2eXk6Xqwu8jxPIdLgo16l89w17XwNK0ouA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUHXlLWe; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-23f0d7d2ce6so394338fac.2
        for <linux-btrfs@vger.kernel.org>; Sat, 04 May 2024 20:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714881331; x=1715486131; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=l8NAvUQ4DPpmb1UUFW5JDh8kuGyMn7LqgynOJtpk7+o=;
        b=GUHXlLWeHMskmCbGkSeZfbGbORi8cp850MTI0Y5An3FD2lqlaEcZlJpluDHGwalyxk
         +t4h7Hj0H54TqI65irUfKm4OFgiAkWl0rDQ2It2Tmc0Cryf3UfsEd4kdgdnQ87gm2G/5
         XF2S5sl+3yMz06TNxfsxSlz2y71MZZSg46+wuDAY+w7GvFHHlqvbtF4IAZ9kkRuQqcD8
         ehhAm2Jg/q0/U3q8Aq1JyKlckHfMHK87IduXDW27HQ9cyMad+uV4+kM1bYpA82oac99p
         yQnE8+Ys/Xuzs3t3g0hmSOs8miCU79Vy8yu5bpGV87CVwR5XmqCoW+lcxa4jsqpcPhhz
         /9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714881331; x=1715486131;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8NAvUQ4DPpmb1UUFW5JDh8kuGyMn7LqgynOJtpk7+o=;
        b=JYvO2i+mpNDLowAEKL+LPI8/b1sFaTEDriXlMVn9RO2ySuatwVCiSoVw6ji8o2OTlp
         LjlbspAM3OpCNOQQdn/JI1OnnvEg+2VWY5LCZQ1TlbIwvHqsqXDor+9zd/g3TEErxjr3
         H2iu/IJfRxDYXsNvhzxIZLz28uu1Gj6ft55nouxnuquFDZYVMmPHWsqSJRGIvNa7D4J8
         zV5WCKvQ5igKq4p+nQ84tt+ZFd2TTKxAGmuv+veA7EaOjPvLh3FQtoVClmM6rXsLspqa
         h2TNvzvG1Vn3VzJO7Ytj8PXsUIQudzxAa9QD0xyHsY3nuJen1vXs934bHZjRiOwQrflO
         FGEQ==
X-Gm-Message-State: AOJu0YzlndXiNmskmevSUz3aOcxzvbqKIbzUIgIQgYe7C2pXM4ZNcHYU
	+MEszBp9qSithv3sWiNsplzEqcVbCXwLq8EXGP5EMUrgGF/MKR5qWQ5/hw==
X-Google-Smtp-Source: AGHT+IFquVGTG1bygNuW9/blkJ0EHsOG06f6itUFG2h/95hh7HZE8pK3FgnvcldsKBgVjQFzGWcJ0A==
X-Received: by 2002:a05:6870:d1ce:b0:239:77fc:b762 with SMTP id b14-20020a056870d1ce00b0023977fcb762mr8587452oac.45.1714881330876;
        Sat, 04 May 2024 20:55:30 -0700 (PDT)
Received: from smtpclient.apple ([2404:c804:b5f:1f00:5ccb:21cb:8c32:74f6])
        by smtp.gmail.com with ESMTPSA id z6-20020a633306000000b0061f2dc31b96sm2754068pgz.47.2024.05.04.20.55.29
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2024 20:55:30 -0700 (PDT)
From: O'Brien Dave <odaiwai@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: BTRFS w/ quotas hangs on read-write mount using all available RAM
 - rev2
Message-Id: <57CAA156-27B5-453F-8A83-1C8812E49B98@gmail.com>
Date: Sun, 5 May 2024 11:55:17 +0800
To: linux-btrfs@vger.kernel.org
X-Mailer: Apple Mail (2.3774.500.171.1.1)

Dear BTRFS team,=20

I=E2=80=99ve had a weird hanging situation as described by the previous =
email in this chain: =
https://lore.kernel.org/linux-btrfs/133101d8dbce$c666a030$5333e090$@admira=
lbulli.de/
The situation:
I have /home as 2x6TB hdd in BTRFS Raid0/data, RAID1/MData. I make a =
daily snapshot by cronjob overnight, so there's about 1000 snapshots on =
it. (/ is on a separated ssd)

To see where all the space was going, I enabled quotas: `btrfs quota =
enable /home`, and it started doing its thing. When it was nearly =
complete, I deleted one of the subvols with `btrfs subvol delete =
/home/BACKUP....` (one of the earlier backups, about 117MB exclusive, =
according to the qgroup), and realised it would take a while to =
complete, so I left it alone.

Later that same day, there was a power outage, and when I restarted the =
box, everything came up as normal, but a `btrfs-cleaner` process started =
that eventually took all of memory (32GB) and then eventually made the =
machine non-responsive. I tried to disable the quotas with `btrfs quota =
disable /home` while this was happening, but the command didn't return.

I rebooted in single user with `/home` unmounted, set up 128GB of swap =
using a USB 3.0 flashdrive, then ran `btrfs check -p -Q /home`. It took =
75 hours to run, and used a max of about 80GB of RAM+Swap, and reported =
no errors.  I tried to mount the drive as normal again, and once more =
`btrfs-cleaner` spins up, takes all memory and makes everything =
unresponsive, with constant `OOM` killings of all processes, until =
eventually the system crashed. It didn't use the swap much, which might =
be relevant.  All through this, `btrfs-orphan-cleanup-progress` reports =
that there is one orphan to be deleted, corresponding to the snapshot I =
deleted, and it doesn't go away.

`btrfs qgroup show /home` shows the deleted subvol as <stale>.

I can mount the volume read-only and with `ro,rescue-all` with no drama, =
and nothing dramatic appears in the system logs, but mounting as =
`default` causes the eventual crash of the machine as described above.

I cannot run `btrfs quota disable /home` as the command doesn't return, =
and the system eventually locks up when mounted RW.

My current kernel is 6.8.7-fc200, which should all of the optimisations =
discussed in previous emails in this thread. The filesystem is about 3 =
years old (2021/04) but I don=E2=80=99t remember which kernel was =
running then, but it should have been at least 5.8 according to =
https://en.wikipedia.org/wiki/Fedora_Linux_release_history.

Is there a way to disable the quotas with device unmounted (I don=E2=80=99=
t really need that info, and I can always rescan later.) I made a start =
at patching the `disable-quota` command into btrfs-progs, but it reports =
an open transaction, when run.

Any advice on how to proceed?  (Apart from backup everything, of course)

thanks and regards,
dave=

