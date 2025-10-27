Return-Path: <linux-btrfs+bounces-18370-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EA5C106D2
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 20:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7299E34F470
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 19:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05FD3328E8;
	Mon, 27 Oct 2025 18:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=friedels.name header.i=@friedels.name header.b="ss5PhQtE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sm-r-004-dus.org-dns.com (sm-r-004-dus.org-dns.com [89.107.70.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D119209F43
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Oct 2025 18:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.107.70.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591562; cv=none; b=u6BaGezndcP+MEZfCWqRRbk82Ch3un8yVyYqDbYVWNIgmCYndC23nr04evSZEcFCshIt1lZMcFULzCtwHoOiZUKTVYFMXYcYCU3A7hJ+ayEiv912RqPtvYyL4fDmJ8eZodsaraKzqZc4dPb/fRZ1wA9p7+TsFfc1UDl1kzbPNok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591562; c=relaxed/simple;
	bh=lGiXNVHJU7WaMEYbi9yBngM7mE0d1tQ2FXIfg1sjVFE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=kYqR8oewxzOvQLf4VshDFYAHrkb8iZmT3VIWR6GIXBXhX2RgR/S7CKib6T5sgG6gQ0ORhi5BztrIDnImKFUYEFKkhQPN8HSHixkghwMOVRFznjirvqFms4st0i+VI7P15y0n8iGujEcDJN9YQI58bepHD4fSUis4RKgDFGb+UOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=friedels.name; spf=pass smtp.mailfrom=friedels.name; dkim=pass (1024-bit key) header.d=friedels.name header.i=@friedels.name header.b=ss5PhQtE; arc=none smtp.client-ip=89.107.70.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=friedels.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=friedels.name
Received: from smarthost-dus.org-dns.com (localhost [127.0.0.1])
	by smarthost-dus.org-dns.com (Postfix) with ESMTP id 2145BA2DE2
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Oct 2025 19:59:16 +0100 (CET)
Received: by smarthost-dus.org-dns.com (Postfix, from userid 1001)
	id 11445A2DDA; Mon, 27 Oct 2025 19:59:16 +0100 (CET)
Received: from ha01s030.org-dns.com (ha01s030.org-dns.com [62.108.32.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by smarthost-dus.org-dns.com (Postfix) with ESMTPS id BBD07A2E04
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Oct 2025 19:59:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=friedels.name;
	s=default; t=1761570100;
	bh=jSwJbWGqx6qSuxOfvH5wjVcIPWwvbilCgywzFEVXxxw=; h=To:From:Subject;
	b=ss5PhQtEukPTbq9Dq4i/KAYigESTYHcpoqz6H9EH3ib6+RyP5BjgHyq/8jwXJc7zT
	 2Fp3UGFpzivYqMyfNf62CggqH7Cf0HL+vZI63j0vTMv8TEgdiW999ev0xWZLuRVbJN
	 ALRgDFDjaM36vvWALACefVT9ey1nMmsxKAnhsfS4=
Authentication-Results: ha01s030.org-dns.com;
        spf=pass (sender IP is 88.65.226.178) smtp.mailfrom=hendrik@friedels.name smtp.helo=[192.168.177.137]
Received-SPF: pass (ha01s030.org-dns.com: connection is authenticated)
Message-ID: <cfc7539c-a0c5-45d2-a781-89c2e0cb2c62@friedels.name>
Date: Mon, 27 Oct 2025 14:00:52 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: linux-btrfs@vger.kernel.org
From: Hendrik Friedel <hendrik@friedels.name>
Subject: Corrupt Filesystem (Mirror) despite previously successful scrub
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <176157010076.2627584.7637850149995337288@ha01s030.org-dns.com>
X-PPP-Vhost: friedels.name
X-POWERED-BY: wint.global - AV:CLEAN SPAM:OK

Hello,

I have a corrupt filesystem - and a Backup.
So, I am only here to learn, not to recover :-)

The history:
- a raid 1/mirror of data and metadata. 12TB identical WD Drives
- some issues with bad sata cables, causing related dmesg messages
    https://pastebin.com/Z0T3fhcv
-UDMA_CRC_Error_Count: 1237 on one device. It remained stable since I 
replaced the cables, also during one successful scrub run. Also I run now
   for host in /sys/class/scsi_host/host*/link_power_management_policy; 
do echo max_performance > "$host"; done
   during boot - not sure whether this or the cables did the trick.

Now today, I wanted to reduce redundancy to single, as I need the one 
drive for other purpose.

The balance failed:
https://pastebin.com/UA8vGm8g
http://cwillu.com:8080/84.60.242.132/1

btrfs check (without --repair) gives me
https://pastebin.com/PG3Uz4SK

Now, I would like to understand:
- where did I go wrong.
     - I was thinking that the raid1 should prevent me getting into this 
situation (I know, it does not prevent other reasons for data loss and 
thus I have a backup)
     - I thought that after spotting the sata-cable issues, fixing those 
and running a scrub, I would be safe
- could btrfs repair fix it (no need to do)?
- I would now like to
     - keep one of the drives in my drawer (as I now have lost redundancy).
     - kill the Filesystem from the other drive. Do some torture test 
(smart long selftest, badblocks)
     - create the filesystem (single) restore redundancy by copying data 
over (not from the drawer drive, but from a different filesystem
     - running torture test of the other drive and use that for other 
purpose (as originally intended for totally different reasons)
     Does that sound like a plan?

Thanks and best regards,

Hendrik






