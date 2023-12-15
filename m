Return-Path: <linux-btrfs+bounces-983-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB308150F3
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 21:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6D4286531
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 20:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E5A45BE8;
	Fri, 15 Dec 2023 20:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.com header.i=@yandex.com header.b="Ot3wW0mK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794DC45975
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Dec 2023 20:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.com
Received: from mail-nwsmtp-mxback-production-main-254.iva.yp-c.yandex.net (mail-nwsmtp-mxback-production-main-254.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:9a8c:0:640:9a2c:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTP id EFD7F61385;
	Fri, 15 Dec 2023 23:14:47 +0300 (MSK)
Received: from mail.yandex.com (2a02:6b8:c0c:488c:0:640:251f:0 [2a02:6b8:c0c:488c:0:640:251f:0])
	by mail-nwsmtp-mxback-production-main-254.iva.yp-c.yandex.net (mxback/Yandex) with HTTP id fEsZwj2XG8c0-jLk4lC5C;
	Fri, 15 Dec 2023 23:14:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.com; s=mail;
	t=1702671287; bh=JZQtX04uddNp97P9jVh4BCXcTH25XZuBBNAcjTxrPXY=;
	h=References:Date:Message-Id:Cc:Subject:To:From:In-Reply-To;
	b=Ot3wW0mKlwCSXJeaKzSPzwzvraezpwHh9doy7gXP+GoN6M7Tmjd2z1HtCU3yEJJ6s
	 g11CyQJbb8p2YnYuo8K80LgCwS6pbSAOKrJGq9SLY+p3wFwQM0CS7c/VSStQZnjoLz
	 sn9Ig3zd7o8zU/YIFK0+cF53EUUVRITtWRKTWIIU=
Authentication-Results: mail-nwsmtp-mxback-production-main-254.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.com
Received: by ybzyx5bgt3byggqr.iva.yp-c.yandex.net with HTTP;
	Fri, 15 Dec 2023 23:14:47 +0300
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
Date: Fri, 15 Dec 2023 15:14:47 -0500
Message-Id: <1933241702671287@ybzyx5bgt3byggqr.iva.yp-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

On Fri, Dec 15, 2023, at 10:13 AM, Grigori Efimovitch wrote:

>First, I think there were safeguards added to kernel within the past few
>years, but last time I checked, it was not safe, (as in, probably
>immediately disastrous) to mount a btrfs filesystem while an exact clone
>of the raw disk even existed.  I would suggest taking care that this is
>never the case.

Point taken.  Thanks.

>I'm confused about the process here.  First, you copy files from your
>boot directory to a mount point on sdb.  Presumably, /boot resides on
>sda.  Then you make a raw copy of the entire sda disk to sdb?  (That
>will completely overwrite anything you might have copied over in step 1.
>
>But then, from your description, I have to ask, are you trying to copy

Sorry. Hard to explain. 1 and 2 were 2 separate cases.  Point 1 was there only to demonstrate I used to do that with rsync on ext3-4 filesystems.  So it's doable.
Point 2 is the way I clone sda to sdb. And no, the system isn't mounted. Of course not.  And the purpose is to overwrite everything.  Sdb will become my backup.

> 5 - I cannot change the disk uuid because the external hard drive sdb is the backup, has to be a clone and grub expects those very uuids to be bootable. Hence I tried to change the label to circumvent the mounting error but to no avail.
>
>
>My suggestion would be to change the UUID of sdb3, manually fix the
>/mnt/desk/root/boot/grub/grub.cfg file, then exclude that file from your
>rsync.  (Alternatively, you can script a very simple search and replace
>that will swap out the UUID inside that file to run at the end of your
>backup rsync.)

That's what I was expecting as an answer.  No big deal.  I already have a script doing just that I use when I cannot use dd / pv e.g. when I have to resize or realign partitions:  I recreate partitions with the new sizes on sdb and rsync the data from sda to sdb.  Done that on xfs and ext4.  Last operation, I restore the UUIDs (for grub, fstab, etc)

