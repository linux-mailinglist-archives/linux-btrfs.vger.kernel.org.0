Return-Path: <linux-btrfs+bounces-77-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AE27E8C91
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Nov 2023 21:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F982813C7
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Nov 2023 20:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0B71D6BC;
	Sat, 11 Nov 2023 20:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="dKN9nCbk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0F91D69C
	for <linux-btrfs@vger.kernel.org>; Sat, 11 Nov 2023 20:22:55 +0000 (UTC)
X-Greylist: delayed 1047 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 11 Nov 2023 12:22:53 PST
Received: from l2mail1.panix.com (l2mail1.panix.com [166.84.1.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109EF2D61
	for <linux-btrfs@vger.kernel.org>; Sat, 11 Nov 2023 12:22:53 -0800 (PST)
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	by l2mail1.panix.com (Postfix) with ESMTPS id 4SSRWV4hhyzDVy
	for <linux-btrfs@vger.kernel.org>; Sat, 11 Nov 2023 15:05:26 -0500 (EST)
Received: from panix1.panix.com (panix1.panix.com [166.84.1.1])
	by mailbackend.panix.com (Postfix) with ESMTP id 4SSRWT1F42zl3j
	for <linux-btrfs@vger.kernel.org>; Sat, 11 Nov 2023 15:05:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1699733125; bh=UwCpG/TH8BGqXRLBH14W17I+EWvg6epE6BtS9X/nNV4=;
	h=Date:From:To:Subject;
	b=dKN9nCbkBZrSFtfCp9ksrHnnLcbxiooHZEcQzFVIzSdazRQINWQOyKHFCvUyuWCGf
	 33mJV5OJcI9CLIeI5B2/CNYYwRSSHYuaYmMsc/XJKk1CPaugHRXaXOB8bF466Tx0ug
	 mvwOvNnUyjn4rceAqssRBeMID6vKQE2Vg3OcxqqY=
Received: by panix1.panix.com (Postfix, from userid 20712)
	id 4SSRWT13lFzcbc; Sat, 11 Nov 2023 15:05:25 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by panix1.panix.com (Postfix) with ESMTP id 4SSRWT12mVzcbC
	for <linux-btrfs@vger.kernel.org>; Sat, 11 Nov 2023 15:05:25 -0500 (EST)
Date: Sat, 11 Nov 2023 15:05:25 -0500
From: Jude DaShiell <jdashiel@panix.com>
To: linux-btrfs@vger.kernel.org
Subject: btrfs needs what repair?
Message-ID: <3eacdf8a-6b9a-d334-2a78-976b4df39bcd@panix.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On the machine I have I find the following coming up in dmesg:
[    0.000000] Command line: initrd=\intel-ucode.img initrd=\initramfs-linux.img root=PARTUUID=d164d039-f328-4d72-bc91-8bc8a0e555b5 zswap.enabled=0 rootflags=subvol=@ rw rootfstype=btrfs
[    0.034035] Kernel command line: initrd=\intel-ucode.img initrd=\initramfs-linux.img root=PARTUUID=d164d039-f328-4d72-bc91-8bc8a0e555b5 zswap.enabled=0 rootflags=subvol=@ rw rootfstype=btrfs
[    0.918034] Btrfs loaded, zoned=yes, fsverity=yes
[    0.990847] BTRFS: device fsid cd04fcd0-1d7d-4229-b922-d0a948dc7bef devid 1 transid 16113 /dev/sda2 scanned by (udev-worker) (235)
[    1.643419] BTRFS info (device sda2): using crc32c (crc32c-intel) checksum algorithm
[    1.643439] BTRFS info (device sda2): using free space tree
[    1.647025] BTRFS info (device sda2): bdev /dev/sda2 errs: wr 0, rd 0, flush 0, corrupt 16, gen 0
[    1.648812] BTRFS info (device sda2): enabling ssd optimizations
[    1.648813] BTRFS info (device sda2): auto enabling async discard

-- 
Jude <jdashiel at panix dot com>
"There are four boxes to be used in defense of liberty:
soap, ballot, jury, and ammo.
Please use in that order."
Ed Howdershelt 1940.

