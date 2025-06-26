Return-Path: <linux-btrfs+bounces-14991-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C83AE9CC2
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 13:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B5B188C694
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 11:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA33E27584C;
	Thu, 26 Jun 2025 11:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="Vfsfa6L7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex1.tik.uni-stuttgart.de (mxex1.tik.uni-stuttgart.de [129.69.192.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C9017BA5
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 11:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750938233; cv=none; b=r1I1HQmxOGAVutZYWBB33O8SlBlXgAVVAmFX+4A1I3p9lEBBmdqB5X7uGp5P/qov5OmcwKwqHa/5OUswca8YJyNPuPhdYeT++IvEZXZus7F4qbxqLIo/Qn1XypSSZ6wRJ0XMDPIDGcPM8YSSEclIbdr20brjuohejmgmmdGlmTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750938233; c=relaxed/simple;
	bh=vDCotqTakoAEJkmBk6F26eU4yb+m8YjHb8NjpKDH6fU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kQX7O4xoyDSHYOzC2DoZfiqdt8ANDq9Wx7M0E9ZlP8cw1ghvayp+d7LRUCtGhn0kZXztMxFdx7Y4ZF7OoqoY3DNtA1OmYFf8IsOpz/rc6u18zwkcNKNG7CE4o5/qZtFcvm4VJB4WckI2tPjAJKL3rfC3G1MaJzl+qFxbNu38/W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=Vfsfa6L7; arc=none smtp.client-ip=129.69.192.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTP id 48CB360BC4
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 13:43:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:content-disposition:content-type
	:content-type:mime-version:message-id:subject:subject:from:from
	:date:date; s=dkim; i=@rus.uni-stuttgart.de; t=1750938225; x=
	1752677026; bh=vDCotqTakoAEJkmBk6F26eU4yb+m8YjHb8NjpKDH6fU=; b=V
	fsfa6L7ed+Vcc8iWmrH2z/fdqED2agb9+OIFd/xKZ6/k1vLOdxiDinblMKPars3o
	8ep97W55W/wFHoxJbyuI6AZQZQLWL8wFu2kWhGxR3VmziCTmfYvjgWZzfpZ34ajc
	CDXgcvZdaTfei1js72XHG/PXAxrYqb++T2ha6O1v1QDdYAOnTCpsm6KnzUXf9hMl
	oqK/VkN02b5sfB8ed2td/DDK3opT+66nGG8iSCBPrPbDwVPCCL5jZTRxJyBEDfuN
	u2YXl4xRxiVzmXiUk+GJzsZrdI4xDOIQBGKRYAArCCwvCcXJaRiGilVBPScbVIj+
	IPY96cTkcYLKc1wGvlhWA==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex1.tik.uni-stuttgart.de
Received: from mxex1.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex1.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id 5w67eyDNGiHH for <linux-btrfs@vger.kernel.org>;
 Thu, 26 Jun 2025 13:43:45 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Thu, 26 Jun 2025 13:43:45 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: using snapshot for backup: best practise?
Message-ID: <20250626114345.GA615977@tik.uni-stuttgart.de>
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


I am using fsfreeze when running a backup to ensure a consistent filesystem.

While the backup is running writes to the filesystem are suspended and the
whole system is unresponsive, e.g. logins are not possible.
On certain errors the unfreeze will not happen and the system is locked
forever.

Using snapshots seems a better idea for backups :-)

But snapshots do not include subvolumes.

For example the / filesystem has the subvolumes:
/home
/home/tux/test
/var/spool

When I run the command:

btrfs subvolume snapshot / /.snapshot/_

the snapshot will contain only the root subvolume.

I have to manually add:

rmdir /.snapshot/_/home
btrfs subvolume snapshot /home /.snapshot/_/home
rmdir /.snapshot/_/home/tux/test
btrfs subvolume snapshot /home/tux/test /.snapshot/_/home/tux/test
rmdir /.snapshot/_/var/spool
btrfs subvolume snapshot /var/spool /.snapshot/_/var/spool

Then run the backup on /.snapshot/_ und afterwards:

btrfs subvolume del /.snapshot/_/var/spool
btrfs subvolume del /.snapshot/_/home/tux/test
btrfs subvolume del /.snapshot/_/home
btrfs subvolume del /.snapshot/_

But this will work only for this special example!
And I have hundreds of systems to backup with different filesystem layout!

Is there a best practise "Using snapshots for making backup"?
I need automatic detecting, creating and removing of nested snapshots.

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<20250626114345.GA615977@tik.uni-stuttgart.de>

