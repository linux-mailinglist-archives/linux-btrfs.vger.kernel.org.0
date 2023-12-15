Return-Path: <linux-btrfs+bounces-978-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 025E6814B7E
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 16:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0422817C0
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 15:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6DC3E48B;
	Fri, 15 Dec 2023 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.com header.i=@yandex.com header.b="khPZ3/+2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C71C3C47B
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Dec 2023 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.com
Received: from mail-nwsmtp-mxback-production-main-46.iva.yp-c.yandex.net (mail-nwsmtp-mxback-production-main-46.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:b595:0:640:3f94:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTP id BBFBA60917
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Dec 2023 18:13:43 +0300 (MSK)
Received: from mail.yandex.com (2a02:6b8:c0c:b92:0:640:326:0 [2a02:6b8:c0c:b92:0:640:326:0])
	by mail-nwsmtp-mxback-production-main-46.iva.yp-c.yandex.net (mxback/Yandex) with HTTP id bDnQ3W2Ot0U0-nx8qfpH5;
	Fri, 15 Dec 2023 18:13:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.com; s=mail;
	t=1702653223; bh=GpKbBRRnI9bzZilo3y5fxJv2tY0SffOCBOwnQ3JE5JE=;
	h=Message-Id:Date:Subject:To:From;
	b=khPZ3/+2uQi/hlFd786oksNE7JA6QxJC4ED+t0nv93RZb+dcRc+vVxd4/Tg1zyoNE
	 oTquhLp7bwWf/uZf6DTUs93ykHmBijsNRvQ0NjjApWTtTuZE6Xs8SBy8Nz9AejvZjk
	 OG4xhr5F35bH8iMHSca8Tw/7qAbM7d80bwiEHsMI=
Authentication-Results: mail-nwsmtp-mxback-production-main-46.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.com
Received: by yjd3yivcrkgrkrlg.iva.yp-c.yandex.net with HTTP;
	Fri, 15 Dec 2023 18:13:43 +0300
From: Grigori Efimovitch <etlp6@yandex.com>
Envelope-From: etlp6@yandex.com
To: linux-btrfs@vger.kernel.org
Subject: Can't mount clone of btrfs partition at the same time as the original.
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Fri, 15 Dec 2023 10:13:43 -0500
Message-Id: <2320801702653223@yjd3yivcrkgrkrlg.iva.yp-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain


Hi,
 
1 - I do that all the time with ext4 to clone my boot partition:
 
sudo mount /dev/sdb2 /mnt
sudo rsync -aAXv --delete /boot/ /mnt
sudo sync
sudo umount /mnt
 
2 - System is standard bios boot Fedora 38 with sda2 as boot partition and sda3 as luks encrypted data/program partition.
I usually clone it to external hard drive sdb by issuing sudo sh -c 'pv < /dev/sda > dev/sdb && halt'.
However it's a 500GB HD with only 50GB of data and it takes an hour.
 
3 - So I thought I could use rsync or btrsync to speed up the process like that:
 
sudo mkdir /mnt/dest
sudo cryptsetup luksOpen /dev/sdb3 cryptdest
 
# Change label
sudo btrfs filesystem label /dev/mapper/cryptdest backup
 
sudo mount -L backup /mnt/dest
 
sudo rsync -aAXv --delete /mnt/source/root /mnt/dest/root
sudo rsync -aAXv --delete /mnt/source/home /mnt/dest/home
 
# Or use btrsync instead of rsync
# sudo btrsync /mnt/source/root /mnt/dest/root 
# sudo btrsync /mnt/source/home /mnt/dest/home
 
sync
 
sudo umount /mnt/dest
sudo cryptsetup luksClose cryptdest
 
4 - Or being btrfs, a problem occurs when issuing 'sudo mount -L backup /mnt/dest':
sudo mount -L backup /mnt/dest
mount: /mnt/dest: mount(2) system call failed: File exists.
       dmesg(1) may have more information after failed mount system call.
 
dmesg:
[ 4572.883417] BTRFS warning: duplicate device /dev/dm-1 devid 1 generation 39341 scanned by (udev-worker) (155148)
[ 4572.885466] BTRFS warning: duplicate device /dev/mapper/cryptdest devid 1 generation 39341 scanned by (udev-worker) (155148)
 
5 - I cannot change the disk uuid because the external hard drive sdb is the backup, has to be a clone and grub expects those very uuids to be bootable.  Hence I tried to change the label to circumvent the mounting error but to no avail.
 
Is there a solution other to rsync the data to an intermediary non btrfs media, and then rsync again to the sdb external hard drive?
 
Thanks!

