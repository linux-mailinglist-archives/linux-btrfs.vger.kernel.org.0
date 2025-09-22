Return-Path: <linux-btrfs+bounces-17039-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97004B8F438
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 09:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6073D168DB5
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 07:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8812F0694;
	Mon, 22 Sep 2025 07:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="JIaO2Aw3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex2.tik.uni-stuttgart.de (mxex2.tik.uni-stuttgart.de [129.69.192.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B954617332C
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758525529; cv=none; b=kiPXnXfKpCleL1OBKkl0yMyNyb5m+Xxq079XTyqUQQL3cYZravB1GkycL6UYbmWNToRzwifbaTtFPDYH9To+T2NpJoqmaswMYpUYOF8U9LWACzp3KxenwwfAjZyiO3ekrqxpHbAUZLCiHFeyc/lyRYa0rr93iPXits8EBFju7z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758525529; c=relaxed/simple;
	bh=zCugTk1Y1O4+GMayqy2j7J2QvvmiTwAmVOGpZ3tFIrc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qehdkEImUfn/eALKB9ugQePzNdxdHNS+f9W8aQfzOaxvamA0FjsUIscfSQgkkepm6c3eoSL3fM5Z1y+bAtBRrK8sSq1G4yqNMTynvSIHdpXhJ1DOSpJMOWlS5qQx6oleU66JlV4QI4tlhbu/biNtf36kzhKnDlYcOghcV7vg3u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=JIaO2Aw3; arc=none smtp.client-ip=129.69.192.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTP id 6A59960FD2
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 09:09:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:content-disposition:content-type
	:content-type:mime-version:message-id:subject:subject:from:from
	:date:date; s=dkim; i=@rus.uni-stuttgart.de; t=1758524996; x=
	1760263797; bh=zCugTk1Y1O4+GMayqy2j7J2QvvmiTwAmVOGpZ3tFIrc=; b=J
	IaO2Aw30hWIHtZaCVy+mAdqblMSPBd+RE7vsUkafbsB2301K32wizV/WSoxIjgTA
	0glxUjT+p5eVsqY8t0rVLLQzCMsGk9hLGr1c14GjGbjOD8gsJOSf2/HC60y/7Upg
	jnF1Y5OWrbvtz8gELkVlal1ydnx5fbP2n2g8rMGhqU09Vq3Stwd5hLkZQ5UduQBQ
	F7A5U2EXqTNP1Ltqdm7AEAlFmPmPS5w3TnIrDz4n920lnueuOxzFoHN7qTjHIsHq
	IvVogkBLM2A4LW2GS1/RpodFYKVI+yIJfX8EqPt6z+mHtHOpgb0CZnq6OBvVgOQe
	c6qm2QIo4nc2Vq0mXew/A==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex2.tik.uni-stuttgart.de
Received: from mxex2.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex2.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id 9YsLdfgoZHaA for <linux-btrfs@vger.kernel.org>;
 Mon, 22 Sep 2025 09:09:56 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Mon, 22 Sep 2025 09:09:56 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: btrfs RAID5 or btrfs on md RAID5?
Message-ID: <20250922070956.GA2624931@tik.uni-stuttgart.de>
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


I have 4 x 4 TB SAS SSD (from a deactivated Netapp system) which I want to
recycle in my workstation PC (Ubuntu 24 with kernel 6.14).

Is btrfs RAID5 ready for production usage or shall I use non-RAID btrfs on
top of a md RAID5?

What is the current status?

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<20250922070956.GA2624931@tik.uni-stuttgart.de>

