Return-Path: <linux-btrfs+bounces-2880-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0531C86BA34
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 22:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E0EFB24135
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 21:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF9072918;
	Wed, 28 Feb 2024 21:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=urbackup.org header.i=@urbackup.org header.b="RCb5X567";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="YCp+vEAN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from a4-15.smtp-out.eu-west-1.amazonses.com (a4-15.smtp-out.eu-west-1.amazonses.com [54.240.4.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90D57290D
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Feb 2024 21:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.4.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709157036; cv=none; b=YmtBrTTsFGKDxa+mxECrqum1T+Da1p1tPpKBoSBdCyjH01lYVgUtw3ej8Iv3MEFc2EclAH3BVynm/NxTKswCIz0dwosuLdL3NABWXw+MpxP1WYcbC9cpi9PgBSDbdhYU884Ct8b8FcMSdFfKdyYEyFpVU9DDR5FbdTNYNg09mTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709157036; c=relaxed/simple;
	bh=2P4MM5EZpETdGXnEPqi/6i2jAFfJ6kJCsbWOaSAUlxs=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=tsZhUC7uelC50VD/aIuCS0nkpkhl/0S2xNIBiudUI38bX96nsHbShKPyf94Q9VnCpfoHdAOrtBINguqo7umG4rVyVxOt5CY8YX66LBXRqbMLiqA0SSkAvHVwrZWNljh86FvjyY8KNByns+V2ahhS2yp6N1Yh6U2+I/0dUCrRg+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=urbackup.org; spf=pass smtp.mailfrom=bounce.urbackup.org; dkim=pass (1024-bit key) header.d=urbackup.org header.i=@urbackup.org header.b=RCb5X567; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=YCp+vEAN; arc=none smtp.client-ip=54.240.4.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=urbackup.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.urbackup.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=pqvuhxtqt36lwjpmqkszlz7wxaih4qwj; d=urbackup.org; t=1709157033;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:Content-Transfer-Encoding;
	bh=2P4MM5EZpETdGXnEPqi/6i2jAFfJ6kJCsbWOaSAUlxs=;
	b=RCb5X5670HQC2aNCV/3LigSbQii5oSMbrxYYKQP+GlZ90BNyijj+jmVbahG2BbV7
	+WsAX1TLlisnsFEl4ssXwof2PR+N+J9qzXpnFKzLG+NRbZHYxveztGrO5O+H4bW1TgY
	qCW3hGC1fs8+Yak6t7dn/HTl5Nke4vdCdQVMbPCI=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1709157033;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=2P4MM5EZpETdGXnEPqi/6i2jAFfJ6kJCsbWOaSAUlxs=;
	b=YCp+vEANCoe88FFLonh3FgbiVtpnwSYLs5Av7zvMj0PFfFO/jKHufVoOgOdEE3Js
	1m3G/m2CasS5BbbeU1utfdgiSUdDLNcYWOaa7WVduVyxxG+5FtnIapr47AI72jQt8il
	InEmLh4prrE7Unp3xV3wLwXJHI8AGSXpXgIdSoyc=
Message-ID: <0102018df1b2a3a2-9359bfe7-9155-4af6-a0d1-7cee1faf77e4-000000@eu-west-1.amazonses.com>
Date: Wed, 28 Feb 2024 21:50:32 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From: Martin Raiber <martin@urbackup.org>
Subject: Zero sized file that should have 512KB size with 6.6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
X-SES-Outgoing: 2024.02.28-54.240.4.15

Hi,

when upgrading to kernel 6.6 I have a zero sized file after a few days 
of running. I'm pretty sure the app has written 512KB into this file 
(using normal write()). Yet stat etc. return zero. But fiemap has some 
extents!

The machine is not power cycled or restarted between the writing and the 
zero size issue.

Kernel 6.6.17 mounted with 
rw,noatime,compress=lzo,ssd,discard=async,nospace_cache,skip_balance,metadata_ratio=8,subvolid=5,subvol=/
Running with ECC RAM (but data=single on one device).

$ filefrag -v ./73c0138c00
Filesystem type is: 9123683e
File size of ./73c0138c00 is 0 (0 blocks of 4096 bytes)
  ext:     logical_offset:        physical_offset: length: expected: flags:
    0:       32..      63:  229943374.. 229943405:     32: 32: encoded,eof
    1:       64..      95:  231710261.. 231710292:     32: 229943406: 
encoded,eof
    2:       96..     127:  231741406.. 231741437:     32: 231710293: 
last,encoded,eof
./73c0138c00: 3 extents found

$ stat ./73c0138c00
   File: ./73c0138c00
   Size: 0               Blocks: 768        IO Block: 4096 regular empty 
file
Device: 34h/52d Inode: 424931256   Links: 1
Access: (0750/-rwxr-x---)  Uid: (    0/    root)   Gid: (    0/ root)
Access: 2024-02-28 10:52:08.421899782 +0100
Modify: 2024-02-28 10:52:10.809908158 +0100
Change: 2024-02-28 10:52:10.809908158 +0100
  Birth: 2024-02-28 10:52:08.421899782 +0100

* Nothing in dmesg
* Btrfs scrub has no errors
* Rebooting does not fix size
* Btrfs check has no errors

Let me know if there is anything else I can provide. Will leave this 
as-is till the end of this week.

Regards,
Martin Raiber


