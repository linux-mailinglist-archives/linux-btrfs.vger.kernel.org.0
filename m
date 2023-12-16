Return-Path: <linux-btrfs+bounces-994-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E776815C96
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Dec 2023 00:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 584DFB22D0E
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Dec 2023 23:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE2A374D7;
	Sat, 16 Dec 2023 23:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.com header.i=@yandex.com header.b="hFcOBavM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DAD3529E
	for <linux-btrfs@vger.kernel.org>; Sat, 16 Dec 2023 23:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.com
Received: from mail-nwsmtp-mxback-production-main-57.iva.yp-c.yandex.net (mail-nwsmtp-mxback-production-main-57.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:16a0:0:640:1498:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTP id 32E73613DF;
	Sun, 17 Dec 2023 02:39:09 +0300 (MSK)
Received: from mail.yandex.com (2a02:6b8:c0c:9915:0:640:7a25:0 [2a02:6b8:c0c:9915:0:640:7a25:0])
	by mail-nwsmtp-mxback-production-main-57.iva.yp-c.yandex.net (mxback/Yandex) with HTTP id kcwBxB4M7iE0-hjdwO8Jf;
	Sun, 17 Dec 2023 02:39:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.com; s=mail;
	t=1702769948; bh=UcLqWOpnAMWZupXtGX8DHFN/qn2oBQck4mS9R1G4ITI=;
	h=References:Date:Message-Id:Cc:Subject:To:From:In-Reply-To;
	b=hFcOBavM5XDV5SHTALsAwNmbtutHkYY6iWPMmXdEss/GYdgiF80Yc0xWRLzdOqzB9
	 q/a8YqQg7SUXh0V09gWsmUQwiiOBnHUOIOPqWEUFmWJnZDpMUgvKoTaq+3s/Zw+Kad
	 6fOrRAUW6SHoBRfiGehl8u/POXh1BHZ5PF7DBZ98=
Authentication-Results: mail-nwsmtp-mxback-production-main-57.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.com
Received: by tlzfnq74f336m6wy.iva.yp-c.yandex.net with HTTP;
	Sun, 17 Dec 2023 02:39:08 +0300
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
Date: Sat, 16 Dec 2023 18:39:08 -0500
Message-Id: <2599271702769948@tlzfnq74f336m6wy.iva.yp-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

On Fri, Dec 15, 2023, at 10:13 AM, Grigori Efimovitch wrote:

>You shouldn't clone a Btrfs using dd or ddrescue, except as a data recovery technique, in which the original and copy are not ever used at the same time.
>
>If your use case requires using an original and a copy at the same time, you need to change the UUID for one of the file systems by using btrfstune -M flag, which uses metadata_uuid file system feature to change the UUID quickly (without requiring all of the metadata to be read and rewritten with the new UUID). This is probably what you want to use since you already have this file system created.
>
>In the future, I suggest using the Btrfs seed sprout feature to clone Btrfs file systems.
>https://btrfs.readthedocs.io/en/latest/Seeding-device.html

I've got got results with partclone.  I haven't studied the internals but I tested it and it did what it was supposed to do in 33% of the time dd would have taken.

Script follows, and commented out, the log of activities.  Any recommendation against using it?

cat /usr/local/sbin/clone-fedora.sh 
#!/bin/bash
mkdir /mnt/sdd2
mkdir /mnt/sda2
mount /dev/sdd2 /mnt/sdd2
mount /dev/sda2 /mnt/sda2
rsync -aAXv --delete --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} /mnt/sda2/ /mnt/sdd2/
sync
umount /mnt/sda2
umount /mnt/sdd2

cryptsetup luksOpen /dev/sdd3 cryptdest
cryptsetup luksOpen /dev/sda3 cryptsource

partclone.btrfs -b -s /dev/mapper/cryptsource -o /dev/mapper/cryptdest

sync

cryptsetup luksClose cryptsource
cryptsetup luksClose cryptdest

# sending incremental file list
# deleting vmlinuz-6.6.4-100.fc38.x86_64
# deleting symvers-6.6.4-100.fc38.x86_64.xz
# deleting initramfs-6.6.4-100.fc38.x86_64.img
# deleting config-6.6.4-100.fc38.x86_64
# deleting System.map-6.6.4-100.fc38.x86_64
# deleting .vmlinuz-6.6.4-100.fc38.x86_64.hmac
# ./
# deleting loader/entries/c9b852c1fd8c44b8aaa12d3e5c7a3992-6.6.4-100.fc38.x86_64.conf
# grub2/
# grub2/grubenv
# loader/entries/
#
# sent 12,112 bytes  received 356 bytes  24,936.00 bytes/sec
# total size is 268,426,865  speedup is 21,529.26
# Enter passphrase for /dev/sdd3: 
# Enter passphrase for /dev/sda3: 
# Partclone v0.3.25 http://partclone.org
# Starting to back up device (/dev/mapper/cryptsource) to device (/dev/mapper/cryptdest)
# Calculating bitmap... Please wait... done!
# File system:  BTRFS
# Device size:  499.0 GB = 30457472 Blocks
# Space in use: 165.1 GB = 10078402 Blocks
# Free Space:   333.9 GB = 20379070 Blocks
# Block size:   16384 Byte
# Elapsed: 00:23:14, Remaining: 00:00:00, Completed: 100.00%, Rate:   8.08GB/min, 
# Current block:   30436705, Total block:   30457472, Complete: 100.00%           
# Total Time: 00:23:14, Ave. Rate:   8.08GB/min, 100.00% completed!
# Syncing... OK!
# Partclone successfully cloned the device (/dev/mapper/crypsource) to the device (/dev/mapper/cryptdest)
# Cloned successfully.

