Return-Path: <linux-btrfs+bounces-7791-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33262969F0A
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 15:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3597286529
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 13:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501B51B12D6;
	Tue,  3 Sep 2024 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="KMP0nvc1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex2.tik.uni-stuttgart.de (mxex2.tik.uni-stuttgart.de [129.69.192.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EECC1A726D
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 13:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370186; cv=none; b=sArP0ZmirZfrZmv0Bm5ZA/1XMOTvisrL0lUjZXMxMLc9Ka69s2shqoiFhniH+KnGOMwMajir4T0A3VozOe8q1pzzBw98zLXaCNFQ6XHe8arCcYYRzVsDyx7Y0/wBP0QwOi44dDq8FfvWNZdAlVF56e/qpCyTfyUD3PdE3wxtllE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370186; c=relaxed/simple;
	bh=lLxXJewrUCstaiIp4HkhjunMgJYsrTz1H88VvpQB2S0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IVXxpBosWoPQzAd7PxoT5BUYIJG6hM4nSieXjuZKT9PDiyZEMbzM3APs6uPHc7SkexHa8fxOhvwgMrhp6jQjLUW4FpLh/T47jzLYar0Nmw8RvX0h/gbz8jUVHLjq4ebQOo7N5WvwwqASgd8Pjzac35xGGHIFQTurs6K5WwzYAVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=KMP0nvc1; arc=none smtp.client-ip=129.69.192.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTP id 22A10609E4
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 15:23:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:content-disposition:content-type
	:content-type:mime-version:message-id:subject:subject:from:from
	:date:date; s=dkim; i=@rus.uni-stuttgart.de; t=1725369797; x=
	1727108598; bh=lLxXJewrUCstaiIp4HkhjunMgJYsrTz1H88VvpQB2S0=; b=K
	MP0nvc11aTMAgrIuOjTLjG7NU3/2BKtOMyInTqxB7xRmYb64dQiwW6hTOmP2JMwb
	pTth20+02S+zLUDoaAv5FOP6T/cIM9RuMMKPAmQfxPAmBBYe7huLScQlBF7SBiCz
	+mASLmNMEx9I64FMTZgnAjjoZ6sAHP8nf2uRHFMZ5eXP4hnGa665ctXEKhMi6Kwz
	Rur0grOfQ6gFb86mNX7Z5chwtWpJHebCAMMPyfRCI9+2N+oCjpzK1KzImWTACZoT
	wud2/H78qt48mRfrgH52IfMuy2dMT7uOkA1Dev3Dc86/+F2CbchlAuefa082IIoj
	ITYEqpVoGOyPM35duGw8g==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex2.tik.uni-stuttgart.de
Received: from mxex2.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex2.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id SpUuk2xF2S3m for <linux-btrfs@vger.kernel.org>;
 Tue,  3 Sep 2024 15:23:17 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Tue, 3 Sep 2024 15:23:16 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: how to delete a (hidden) snapshot from timeshift?
Message-ID: <20240903132316.GA20488@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailer: smtpsend-20240729


I have upgraded Mint 21 to Mint 22 with "mintupgrade" (Ubuntu 22 based).
This calls timeshift and creates a btrfs snapshot which I wanted to delete
afterwards:

root@mux21:~# btrfs subvolume list /
ID 256 gen 102469 top level 5 path @
ID 257 gen 102467 top level 5 path @home
ID 367 gen 102260 top level 256 path local/home
ID 667 gen 102466 top level 256 path tmp
ID 682 gen 102445 top level 5 path timeshift-btrfs/snapshots/2024-09-03_13-00-02/@

root@mux21:~# btrfs subvolume del timeshift-btrfs/snapshots/2024-09-03_13-00-02/@
ERROR: Could not statfs: No such file or directory

root@mux21:~# btrfs subvolume del -i 682 timeshift-btrfs/snapshots/2024-09-03_13-00-02/@
ERROR: Could not open: No such file or directory


I have had to mount the / filesystem directly (no subvol) to remove this
timeshift snapshot:

root@mux21:~# lshd
Device    Size Type      Label           Mountpoint
sda        30G ATA:GPT   "VBOX_HARDDISK"  
 sda1       0G vfat                      /boot/efi
 sda2       0G BIOS boot                  
 sda3      29G btrfs                     /

root@mux21:~# mount /dev/sda3 /mnt/tmp

root@mux21:~# l /mnt/tmp/
dRWX - 2024-06-21 11:45 /mnt/tmp/@
dRWX - 2024-03-07 13:00 /mnt/tmp/@home
dRWX - 2024-09-03 13:00 /mnt/tmp/timeshift-btrfs

root@mux21:~# btrfs subvolume list /mnt/tmp
ID 256 gen 102473 top level 5 path @
ID 257 gen 102471 top level 5 path @home
ID 367 gen 102260 top level 256 path @/local/home
ID 667 gen 102471 top level 256 path @/tmp
ID 682 gen 102445 top level 5 path timeshift-btrfs/snapshots/2024-09-03_13-00-02/@
ID 684 gen 102470 top level 257 path @home/.snapshot/2024-09-03_1500.hourly

root@mux21:~# btrfs subvolume del /mnt/tmp/timeshift-btrfs/snapshots/2024-09-03_13-00-02/@
Delete subvolume 682 (no-commit): '/mnt/tmp/timeshift-btrfs/snapshots/2024-09-03_13-00-02/@'


Is there an easier way to remove hidden snapshots/subvolumes?

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<20240903132316.GA20488@tik.uni-stuttgart.de>

