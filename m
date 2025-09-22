Return-Path: <linux-btrfs+bounces-17044-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0434AB8F8B4
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 10:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1C042A06C8
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 08:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F8E30C351;
	Mon, 22 Sep 2025 08:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="DCfqSkEr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex1.tik.uni-stuttgart.de (mxex1.tik.uni-stuttgart.de [129.69.192.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A1930C34C
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 08:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529741; cv=none; b=Mjl6qx09iitDMpSBQqBvyoodGAXz3tuNRYSBmAv2lmwXOJdqVoLRcA79Wj0bbzqZZ1APmb7g6VK9cqlWB85cD2MR8pKJ+l9zyTsMbMdM+0q2qQpUzn6KHcGdZBL1R0pzFkjqqR+M+rlB9QOkVxGzrBizWnIYYIhR97pD2dQLNp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529741; c=relaxed/simple;
	bh=7abNpAP6GuSyK9BKwk2mwIoPaKFBmuiAw5KXyNpBhYw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWEOdkGhb4jd7R8T8kgNuMkUrRAIK/BuQx3t9NRHO+BbtLPe+OwccSqpsJzo2ozNGyuMX8fcB8h0XDnC9u2Hhip/XBnd4Yi4NeQhAQb0RhCclfMymhSrT1CsQtdDj+x/fO5XZLPg6s4klSpY3mREWPS79fDmUXuk3kIUvRBtfis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=DCfqSkEr; arc=none smtp.client-ip=129.69.192.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTP id 71B1E6104A
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 10:28:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:in-reply-to:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date; s=dkim; i=
	@rus.uni-stuttgart.de; t=1758529734; x=1760268535; bh=7abNpAP6Gu
	SyK9BKwk2mwIoPaKFBmuiAw5KXyNpBhYw=; b=DCfqSkErnqTNfnuiFST7hXfl7P
	F3Z58SFk/OQMr+/buHMzyBoEmE9j/fPjrzw+OSOJaHKIrxwc12bZUHbYqaXpyx8e
	cLe4yQIoqHttg+5hYgpzT1WbmtJTCGqbdVeeLRjjbZxznNwqjbO7xAx7ObXWoJzg
	Byaw4oXOMxHlLHRMEHmR8u80z8KQJ+aZ30+hM9g/kiYoP0bT7F3XnaWy13MkN2DO
	KxrbiueRRm3pl5nX/mCUVQD+cGrQ3IYOKekd6HKQrHY+nYy2Zpvgz6SJ2BbNc5a6
	sWrxFaI+PS4H9n3ur4K5WvDJuK97mVS1j6Y95as+cv47y5goSYnt+60gwYjA==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex1.tik.uni-stuttgart.de
Received: from mxex1.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex1.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id yC87vp5C2xwP for <linux-btrfs@vger.kernel.org>;
 Mon, 22 Sep 2025 10:28:54 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Mon, 22 Sep 2025 10:28:54 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs RAID5 or btrfs on md RAID5?
Message-ID: <20250922082854.GD2624931@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20250922070956.GA2624931@tik.uni-stuttgart.de>
 <d3a5e463-d00e-4428-ad7b-35f87f9a6550@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3a5e463-d00e-4428-ad7b-35f87f9a6550@gmx.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailer: smtpsend-20240729

On Mon 2025-09-22 (17:11), Qu Wenruo wrote:

> > Is btrfs RAID5 ready for production usage or shall I use non-RAID btrfs on
> > top of a md RAID5?
> 
> Neither is perfect.

We live in a non-perfect world :-}


> Btrfs RAID56 has no journal to protect against write hole.

What does this mean? 
What is a write hole and want is the danger with it?


> So you either run RAID5 for data only

This is a mkfs.btrfs option?
Shall I use "mkfs.btrfs -m dup" or "mkfs.btrfs -m raid1"?


> and ran full scrub after every unexpected power loss (slow, and no
> further writes until scrub is done, which is further maintanance burden).

Ubuntu has (like most Linux distributions) systemd.
How can I detect a previous power loss and force full scrub on booting?


> Or just don't use RAID5 at all.

You suggest btrfs RAID0?
As I wrote: I have 4 x 4 TB SAS SSD (enterprise hardware, very reliable).

Another disk layout option for me could be:

64 GB / filesystem RAID1
32 GB swap RAID1
3.9 TB /home
3.9 TB /data
3.9 TB /VM
3.9 TB /backup

In case of a SSD damage failure I have to recover from (external) backup.

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<d3a5e463-d00e-4428-ad7b-35f87f9a6550@gmx.com>

