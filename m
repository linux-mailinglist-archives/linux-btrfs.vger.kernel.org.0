Return-Path: <linux-btrfs+bounces-20072-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F761CED911
	for <lists+linux-btrfs@lfdr.de>; Fri, 02 Jan 2026 00:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAC33300528A
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jan 2026 23:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646942459E5;
	Thu,  1 Jan 2026 23:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="JCTFeD0M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex2.tik.uni-stuttgart.de (mxex2.tik.uni-stuttgart.de [129.69.192.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFB81DC198
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Jan 2026 23:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767311604; cv=none; b=odXNjspPTCr6PcavKh8sbqK5Tsra+nsLi+EGTo8ql7oZerhjqPA8sBAyszjjcSvOqWfNvLFuR6nP1ZfTSDcj6yjzldKom2DcSz0hK+TQJNB2bBEW2h8k6Qf4TF2jGWmugdPPBEXk2PC8PVk9JMzZL4TC1QCO52L/wyYxRTc6LKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767311604; c=relaxed/simple;
	bh=FxcxWsfjQ914vC4/EORXAug+KBERdSkPkNGgdNqfsRw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fPRsW3spyVB1bDRr4acamcMHFUrFP1373NCX/VGJsh/NywSLPI1NeyPDMGMAA2ZZ1MXpzLHDXW5iHnfgeX2soXr9QdDFs293AxXI10bA8SSh9xhLRTX0NSv2zd0Ts+n+akoSrn1oNxNr73R4o/L3Km53IjENAlyQ3xg0YXcarIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=JCTFeD0M; arc=none smtp.client-ip=129.69.192.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTP id 3D30460C27
	for <linux-btrfs@vger.kernel.org>; Fri, 02 Jan 2026 00:46:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:content-disposition:content-type
	:content-type:mime-version:message-id:subject:subject:from:from
	:date:date; s=dkim; i=@rus.uni-stuttgart.de; t=1767311185; x=
	1769049986; bh=FxcxWsfjQ914vC4/EORXAug+KBERdSkPkNGgdNqfsRw=; b=J
	CTFeD0Mcn0iiCPzzMZggZDbmq2SvQHUQiqkg1T4Nkxsi6mw/4Zzi1XAtt+yquDyr
	NOEgnhluWjKd722j+rL4bV9REOsLbXTsAxlZ3EmpGopxb48OxVIJC9XZdDosdeqh
	kZ12oh4MbIyFUx5vkGnLObX8mALcG8JGvLV2DKd2eiRA85dFGxOAJxpoNu8O77jb
	xkIEguq3ZN/f/yCrx8cNRbLtM7hJZPjLBJ3qVqCV1VmDd6HLa7/JEqnf9BLDzwwQ
	ZVgCTf6SFcCYlxS/KkDlScv0/ih/lWZr7kD8hrQkHEUkNvXPy1hjCPhuNa8WwZG3
	WXBmbufz5WiiSJdp2+d7A==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex2.tik.uni-stuttgart.de
Received: from mxex2.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex2.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id F8lPViOptnEg for <linux-btrfs@vger.kernel.org>;
 Fri,  2 Jan 2026 00:46:25 +0100 (CET)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Fri, 2 Jan 2026 00:46:24 +0100
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: backup best practise?
Message-ID: <20260101234624.GA1955478@tik.uni-stuttgart.de>
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

What is the best practise for backup of a local btrfs file system?

In my case, I have 2 disks: disk one contains a /home btrfs filesystem,
disk two contins a /backup btrfs filesystem.
So far I use:
rsync -a --delete /home /backup

The drawback of this methode is: In /home there are also *big* VMs which
will be copied every time even if they have changed only a few bytes,
because rsync works file based.

Using RAID1 is not a backup. When I inadvertently delete a file it has
gone on the mirror side, too.

I have snapshots of /home, but they will not help me if disk one has a
hardware failure.


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<20260101234624.GA1955478@tik.uni-stuttgart.de>

