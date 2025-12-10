Return-Path: <linux-btrfs+bounces-19629-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52025CB3B44
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 18:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69E4D3037883
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 17:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4572FD1D3;
	Wed, 10 Dec 2025 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="KDyXSODp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex2.tik.uni-stuttgart.de (mxex2.tik.uni-stuttgart.de [129.69.192.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9E428467C
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 17:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765389504; cv=none; b=M6PDWDa88KWcN07YO2bdeIi2yGSx1Qzwi94EBwG1O/pcpl1TGhvKbZzw7SOBmZ0SeUBg0fLoVkG35SHyyJdTHJf0Rzh9XkkPcrswh6NwYEbCUsYkMXrdz3yfSmYtkIOC3PnRQW11kNBfMLTnEOIvik9EhpMa7Nf1Zv/NGKPnL1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765389504; c=relaxed/simple;
	bh=xCD9wmyD99lCoWgZtoLI6WV5w7WqL2q+uGStyR/Z1cI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VfIYI/KwLco/4DkwDAOg00/w0DJO0hvREXw2LEPZggtn5nVbMnVcQYIRnkET5f2ihibYrZPBVPys1pNLDWEZfXvXmHuYKyztHxtf06zJ0fqmaMUI23uMAnqf6965TRdiBHmsY2/22xylM+1uLBQ1D5+1uEvMY68k0i5nRalJP04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=KDyXSODp; arc=none smtp.client-ip=129.69.192.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTP id 7326D60DF1
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 18:52:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:content-disposition:content-type
	:content-type:mime-version:message-id:subject:subject:from:from
	:date:date; s=dkim; i=@rus.uni-stuttgart.de; t=1765389142; x=
	1767127943; bh=xCD9wmyD99lCoWgZtoLI6WV5w7WqL2q+uGStyR/Z1cI=; b=K
	DyXSODpfpiq6yd7XOgUECtwcN4pw4rNFgUV1Y2cWvP1m5kYcQKL3xIRiKCGGqLei
	+ziCq/jZhTHjI5zPgkSY1ggQX5MxSM4VD3HnyXRSy0nuw6O6mPLUcIlGrZcAgwYK
	TI4IH9+6WubOsai359Z5yOpHRvQ9p6eRyqKVliLu8SIdfuIWp5SWAvVG3+fIfcfa
	GRqWp2DgO96z580TnV7R+UVBMjucX4ftLrhxpdOqTTF0J/adHXfurdpQ4RqYixpo
	1bOM5k8W/rmA37gHFXBjJHKp9hiG1bHR5a2ThN0/FW0xlLnQSwyMMEW2ddUM5AlE
	bmp1zS8KBOzSBFy0lLpfg==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex2.tik.uni-stuttgart.de
Received: from mxex2.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex2.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id fhCm8MCz2UgI for <linux-btrfs@vger.kernel.org>;
 Wed, 10 Dec 2025 18:52:22 +0100 (CET)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Wed, 10 Dec 2025 18:52:22 +0100
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: command to list all devices of all filesystems?
Message-ID: <20251210175222.GA590927@tik.uni-stuttgart.de>
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


I have a RAID1 filesystem:

root@mux22:~# btrfs filesystem show /dev/sda4
Label: 'M22'  uuid: 9329698e-bbb0-4047-bcef-863e584f314b
        Total devices 2 FS bytes used 144.00KiB
        devid    1 size 64.00GiB used 2.01GiB path /dev/sda4
        devid    2 size 64.00GiB used 2.01GiB path /dev/sdb4

But lsblk, df and mount shows me only the first device:

root@mux22:~# lsblk -o NAME,UUID,MOUNTPOINT /dev/sda /dev/sdb
NAME   UUID                                 MOUNTPOIN
sda
|-sda1
|-sda2 774F-1CB7
|-sda3 fb1524a1-54a6-4688-ba16-6d1678d71b64
|-sda4 9329698e-bbb0-4047-bcef-863e584f314b /mnt/tmp
|-sda5 46c63421-65a7-4c49-8dcb-ea485182437d
`-sda6
sdb
|-sdb1
|-sdb2 08C5-01F2
|-sdb3 82a88cda-9315-41d0-ab45-b656cb19f715
|-sdb4 9329698e-bbb0-4047-bcef-863e584f314b
|-sdb5 483b9508-11d0-4b94-b525-618c9e3336ef
`-sdb6 2d368a60-27c4-44ad-9b88-42268f1f65cb

root@mux22:~# df /mnt/tmp
Filesystem     1K-blocks  Used Available Use% Mounted on
/dev/sda4       67108864  5776  66051072   1% /mnt/tmp

root@mux22:~# mount | grep /mnt
/dev/sda4 on /mnt/mnt type btrfs (rw,relatime,ssd,discard=async,space_cache=v2,subvolid=5,subvol=/)

Id there a command which lists all devices of all mounted filesystems?


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<20251210175222.GA590927@tik.uni-stuttgart.de>

