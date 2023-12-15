Return-Path: <linux-btrfs+bounces-984-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F0C815116
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 21:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B45A286899
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 20:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B61DDB9;
	Fri, 15 Dec 2023 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.com header.i=@yandex.com header.b="JoUbZeno"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167D0846D
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Dec 2023 20:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.com
Received: from mail-nwsmtp-mxback-production-main-254.iva.yp-c.yandex.net (mail-nwsmtp-mxback-production-main-254.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:9a8c:0:640:9a2c:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTP id 4253861624;
	Fri, 15 Dec 2023 23:31:15 +0300 (MSK)
Received: from mail.yandex.com (2a02:6b8:c0c:1606:0:640:506f:0 [2a02:6b8:c0c:1606:0:640:506f:0])
	by mail-nwsmtp-mxback-production-main-254.iva.yp-c.yandex.net (mxback/Yandex) with HTTP id 9VsEpk2X6Ko0-9eEkHxK7;
	Fri, 15 Dec 2023 23:31:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.com; s=mail;
	t=1702672274; bh=IWhkCJf09cv3grxs4bm4f+nnhBFReXH00pkVWaERXrU=;
	h=References:Date:Message-Id:Cc:Subject:To:From:In-Reply-To;
	b=JoUbZenoBWvUW8yHYgkoZ9//teNZIN+EboqgmO+9yegsCKdPRrOZctb5vQjlC+ykX
	 8naWMhDsnjhE7P2x280BZyv3hfnsn3hfZgwOmoPdRjLHJTcSnQ6vWYascZKQZOh1ml
	 pDfk4Oy1oapBuSEDFITxQgZqPqe6Z3byGe1tLcfs=
Authentication-Results: mail-nwsmtp-mxback-production-main-254.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.com
Received: by 5onccsrv2hdogkey.iva.yp-c.yandex.net with HTTP;
	Fri, 15 Dec 2023 23:31:14 +0300
From: Grigori Efimovitch <etlp6@yandex.com>
Envelope-From: etlp6@yandex.com
To: Chris Murphy <lists@colorremedies.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
In-Reply-To: <4bfd7275-f4ac-4c22-8528-40c43e86a71a@app.fastmail.com>
References: <2320801702653223@yjd3yivcrkgrkrlg.iva.yp-c.yandex.net> <4bfd7275-f4ac-4c22-8528-40c43e86a71a@app.fastmail.com>
Subject: Re:Can't mount clone of btrfs partition at the same time as the original.
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Fri, 15 Dec 2023 15:31:14 -0500
Message-Id: <1964151702672274@5onccsrv2hdogkey.iva.yp-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain


On Fri, Dec 15, 2023, at 10:13 AM, Grigori Efimovitch wrote:

>Hi,
> 
> 1 - I do that all the time with ext4 to clone my boot partition:
>
>Like Remi, I'm having a hard time following all the extra information, but don't see how this clone was created in the first place.
>

Sorry, I'll do it again.

The clone is created every week or so from a live dvd where the original is sda and the soon-to-be backup is sdb:
"pv < /dev/sda > /dev/sdb" OR "dd if=/dev/sda of=/dev/sdb bs=1M status=progress" depending on what's available on the live dvd.

My point 1 (with rsync) was only there to demonstrate it was doable on ext4 and I was just wondering if it were on btrfs as well.  After some tries, it's doable on the same disk or partition.
From your replies, I take for granted it's not doable on 2 identically partitioned hard drives with the same UUIDs.

>Btrfs makes prolific use of UUIDs. The file system UUID has several synonyms: the volume UUID, the fsid, and also the one blkid reports as "UUID=" is found in the super block, and in every leaf and node.
>

I did notice that.  Hence the impossibility to mount both at the same time.

>You shouldn't clone a Btrfs using dd or ddrescue, except as a data recovery technique, in which the original and copy are not ever used at the same time.
>

Point taken.  Thanks.

>If your use case requires using an original and a copy at the same time, you need to change the UUID for one of the file systems by using btrfstune -M flag, which uses metadata_uuid file system feature to >change the UUID quickly (without requiring all of the metadata to be read and rewritten with the new UUID). This is probably what you want to use since you already have this file system created.
>
>In the future, I suggest using the Btrfs seed sprout feature to clone Btrfs file systems.
>https://btrfs.readthedocs.io/en/latest/Seeding-device.html
>
>There are multiple use cases possible with the seed feature, so just be aware there's more than one way to use it. The way you'd use it: make the original a seed (read-only), mount it, add a second device, remount the file system read-write (this is potentially the confusing part), and then remove the seed device (also potentially confusing). The removal of the seed causes replication to start from the seed (1st device) to the sprout (2nd device). The resulting sprout is data wise byte for byte identical. But it is not a block copy like dd. It uses the > balance code path to replicate at the block group level. In effect you will get a balanced file system as the resulting sprout, with one other difference: the UUID will be unique.
>
>Strictly speaking this is a derivative file system. It starts as a clone with the intent of modifying it for a different use case than the original file system. The use case isn't to keep the two file systems identical all the time or else you'd probably use raid1.
>
>Note that all the subvolumes and snapshots have their UUIDs preserved so any workflow that depends on replication of snapshots using btrfs send/receive is also preserved. You can thereby create unlimited derivative file system copies that are valid source and destination for send/receive operations, however your workflow was setup for the original file system.

This reading will receive all my attention.  Thanks for pointing it to me.  My purpose is to make a backup, the fastest way possible.  Sdb has one usage only.  To be restored to sda if sda ever came corrupted or damaged.  History proved it happens.  I wasn't lucky with snapshots.  Most of the time, the system is unbootable or corrupted.  Worked once in 2 months.  All other situations were problematic.  So let's rely on something I've been using for 25 years, an exact clone copy maximum 1 week old.

