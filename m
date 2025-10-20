Return-Path: <linux-btrfs+bounces-18051-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1771BF125A
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 14:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E60813A34C7
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 12:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEB227462;
	Mon, 20 Oct 2025 12:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="YtHOAoLz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex1.tik.uni-stuttgart.de (mxex1.tik.uni-stuttgart.de [129.69.192.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEF424DCF9
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962883; cv=none; b=e7/Jd0p9gB3WAcDbdKS/tiygdpcG5lC5VNDrWMbU8UHBwQsEQh6f/ISO0qhtvuJPYVWItgD/kmEvokuFHUoJs+ycRIyBbGDuczivL369FX1O6ZYukpKqwZCT0YHTpct226QxYvsOw6XBxc13cjHmZYdIRWBYzMJ12UEHCs4I2D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962883; c=relaxed/simple;
	bh=3O1Y2/AqEOeFAG8m+oghfR/4iDTHWMGMJkpaO/ARvjc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hNaOYjEZZ5lJL/kphwMrEwXL6ddh8G7pGRtrD/TxOOzjQ42A4ba8qNkpWD/o+ZOJ3kxQ2/2W2i0MmSGmp0Q94b8dLepMUAEM4Xi7ASYYZjmRYCIYOe2xR3XrC81nG2WAxowWjYZfp2oxbHVjpDoysJcOZ3ChlNleMO0fzGc24B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=YtHOAoLz; arc=none smtp.client-ip=129.69.192.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTP id D7E5960A45
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 14:21:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:content-disposition:content-type
	:content-type:mime-version:message-id:subject:subject:from:from
	:date:date; s=dkim; i=@rus.uni-stuttgart.de; t=1760962875; x=
	1762701676; bh=3O1Y2/AqEOeFAG8m+oghfR/4iDTHWMGMJkpaO/ARvjc=; b=Y
	tHOAoLzSwqBNq8Rbx+hgU4QXQd7C+8iY3/Ezt9OuyBp4dPEy8mXoOm74oWHgW+Xy
	wl0b/h1BKxyBumhmttD8jKzXBZyqgRQKRzMZaRPalVdh7rlLz1aHxWiUiMKGgkyO
	SFJMAusTiNmUzWxA6HfloBUPyBJRLlJdJWIlcezsRR9lRqzGA+XGyItG6gBiU8ac
	GfpJq51jRBrg0jfo+IFjTnUdFiHxNHiR7z5Yu4JoCfAL348mUws4CExVI1tOegL8
	kPJ1FDvP07RS5lk788gWfj1QI6M8Y+eWXmuLHvD4DWC8CwcI+I7v44RcGqbQ1QmC
	1LV9z7kKvNOvUpZq5OhBQ==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex1.tik.uni-stuttgart.de
Received: from mxex1.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex1.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id BLFaiExf5Tcn for <linux-btrfs@vger.kernel.org>;
 Mon, 20 Oct 2025 14:21:15 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Mon, 20 Oct 2025 14:21:15 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: RAID1 vs RAID10
Message-ID: <20251020122115.GA1461277@tik.uni-stuttgart.de>
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


I have just discovered, that RAID1 is possible with more than 2 devices:

https://btrfs.readthedocs.io/en/latest/mkfs.btrfs.html#profiles

What is the difference to RAID10?

I have 4 x 3.8 TB SSD and want one filesystem.



-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<20251020122115.GA1461277@tik.uni-stuttgart.de>

