Return-Path: <linux-btrfs+bounces-8035-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB51979899
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Sep 2024 21:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73B21B22162
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Sep 2024 19:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8391CA68D;
	Sun, 15 Sep 2024 19:54:04 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from shin.romanrm.net (shin.romanrm.net [146.185.199.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862501C6F55
	for <linux-btrfs@vger.kernel.org>; Sun, 15 Sep 2024 19:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.185.199.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726430043; cv=none; b=tOeix14phQVpKd3VZ7BwRsSpe0i5brSD9G6y7/UFwVFHJigp/kecWdkZpIeN3DvPohfNxb33WHzsLS6lpkg4hg++HfRY97x7ctNpf4zk3drZpieGWDW9zkwoHNpVMwutJ8En1YMsh1c6jeAK6IN8x7j6NbMJHRrM+Y13loe0XNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726430043; c=relaxed/simple;
	bh=0myeq2s3Slpr0M4FHiS77+CRWtJdTu4ekcTCnLm3Fqg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=KHGAolBuQqwV9I2V5hRnDSGzx7Xq3UpGzLe1N9Y9EVYtAEVJftd13TKNyESI1a/2Q4wOqsz+d+yUEYshI6lQjr7T/utQla1kOtJV5j7Tg6tMJ19qX0n5FgS2JMHhfSFrng2X02Fb7FNI66QQgTmWWgsgFlmiZYUxPEjhnsc6kN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=146.185.199.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (umi.39.romanrm.net [IPv6:fd39:a9b3:4fb1:1ccb:7900:fcd:12a3:6181])
	by shin.romanrm.net (Postfix) with SMTP id 599BF3F624
	for <linux-btrfs@vger.kernel.org>; Sun, 15 Sep 2024 19:45:28 +0000 (UTC)
Date: Mon, 16 Sep 2024 00:45:27 +0500
From: Roman Mamedov <rm@romanrm.net>
To: linux-btrfs@vger.kernel.org
Subject: Btrfs keeps getting corrupted
Message-ID: <20240916004527.0464200f@nvm>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello,

I have a Btrfs filesystem that keeps getting corrupted for some reason.

The setup is a 4-disk external enclosure connected via USB3. It is powered-on
and off as needed.

In it there's one 12TB Seagate Exos HDD, that admittedly has a low number of 
reallocated sectors, but there are no IO errors at any time during the
operartion (so those do not seem to be hit and there are no new ones).

On the HDD there's a LUKS partition, and inside LUKS there's a Btrfs
filesystem.

The workflow is power-on, luks-open, mount, rsync, unmount, luks-close,
power-off.

On the previous attempt to use this, the FS was starting to go read-only on
accessing some recently-copied files, and there were "transid verify failed"
errors in dmesg. I wrote that off as perhaps not syncing, unmounting and
closing everything off correctly before power-off.

Modified my scripts to do a "sync" before every step in the power-off
sequence. Reformatted from scratch, copied all data again, and turned it off.

Next time, a few weeks later, I try to do another rsync, and this time it
doesn't even mount:

[248942.223437] BTRFS: device label sea12.k4e devid 1 transid 725 /dev/dm-26 scanned by (udev-worker) (5328)
[248942.267427] BTRFS info (device dm-26): first mount of filesystem 4071aeab-ccab-4b36-901f-38fd38e4ef41
[248942.267441] BTRFS info (device dm-26): using crc32c (crc32c-intel) checksum algorithm
[248942.267446] BTRFS info (device dm-26): use zstd compression, level 3
[248942.267448] BTRFS info (device dm-26): using free space tree
[248942.358145] BTRFS error (device dm-26): level verify failed on logical 1053650288640 mirror 1 wanted 3 found 0
[248942.388148] BTRFS error (device dm-26): level verify failed on logical 1053650288640 mirror 2 wanted 3 found 0
[248942.396897] BTRFS error (device dm-26: state C): failed to load root csum
[248942.408461] BTRFS error (device dm-26: state C): open_ctree failed

btrfsck:

Opening filesystem to check...
parent transid verify failed on 1053650288640 wanted 723 found 110
parent transid verify failed on 1053650288640 wanted 723 found 110
parent transid verify failed on 1053650288640 wanted 723 found 110
Ignoring transid failure
ERROR: root [7 0] level 0 does not match 3

ERROR: could not setup csum tree
ERROR: cannot open file system

===

Such a high disparity in transid mismatch, flush is not working somewhere? But
I specifically do "sync" even multiple times now, before unmounting and after.

How can I figure out what is to blame here, is it the enclosure, is it USB,
LUKS, Btrfs, or some fundamental bug involving a combination of these?

Or maybe the drive is faulty in some mysterious way and storing/returning old
data instead of IO errors or sector reallocation.

-- 
With respect,
Roman

