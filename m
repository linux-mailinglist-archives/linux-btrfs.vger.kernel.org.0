Return-Path: <linux-btrfs+bounces-15009-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D70AAEA6B9
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 21:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD6D1638FC
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 19:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578E92F3C31;
	Thu, 26 Jun 2025 19:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="W2iJsRyZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex1.tik.uni-stuttgart.de (mxex1.tik.uni-stuttgart.de [129.69.192.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B896D2F2730
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 19:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966545; cv=none; b=WSfYEsmBf0h4WoxJ9csfQhBtwR/Wd7LsV/q3yJhmek6NFbR8dVGhSIvfiVvchr/Ljq7FTJCsTVdrFlFPEoEAAkjV9uZxWWfYDS4KeLxAwbvlELfbd6fSZ0ep455HNwwHridBA4yzbtFgtvHocS+vZyx07/qYZEo+LXI3sy9PrB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966545; c=relaxed/simple;
	bh=gzwm5M3U4cDafEi7dB3kabF0dB4zN9n0gCmT1efscsU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCOGbJdCv0t4c+39DJpHgadZtNojYQjGH7Fadkgp3+X1dylP4OgHBIEr79Nomus8xZ1y2VhCmGFuk6Cfs7lgSpqcJ6zMOKX7q1+ZZQCQJGSNDtx7fJW6OjZlYzIlE7szkDRANi4zrrBJJ1oKcDBlR8CIj9k6gBJIhp8V2v3YJbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=W2iJsRyZ; arc=none smtp.client-ip=129.69.192.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTP id 4BBE360D0C
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 21:35:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:in-reply-to:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date; s=dkim; i=
	@rus.uni-stuttgart.de; t=1750966537; x=1752705338; bh=gzwm5M3U4c
	DafEi7dB3kabF0dB4zN9n0gCmT1efscsU=; b=W2iJsRyZImTdd1yFO42vKgHqzo
	zSgSyev4vA1AqjGEgtm7DN2tBE3Bo9AqjVqiD3XavYHvRJ/jGF8I5e5j5TE0rPuk
	iuB4aywTG7BggJTbT0ga1nqGljTU1l74q27jMqVKGDOnD/oxrAuWdTZHUrcf1Krw
	Wp5rNQcthtTJlxwyOD9/SCw1TjiN3it0BXUAjQbHiSIEF1Xo3Rp5r9ndmuGFUzs4
	shwyrJUEdaR3JlyKk0WaQdq0e/gY6uBMI/p/TAiKK2ZrSntEI1Whk9EHnKghpYr6
	oOUCyOfQJmxHQon+eDON7EOCdl7tT2Mk8YJkDIz9+AXiBxva0vrfo9MDoerQ==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex1.tik.uni-stuttgart.de
Received: from mxex1.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex1.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id ODCmPjV-ibKe for <linux-btrfs@vger.kernel.org>;
 Thu, 26 Jun 2025 21:35:37 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Thu, 26 Jun 2025 21:35:37 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: Re: using snapshot for backup: best practise?
Message-ID: <20250626193537.GA653726@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20250626114345.GA615977@tik.uni-stuttgart.de>
 <f36e47c9-f135-473c-b1f1-2fedaef8aa10@cobb.uk.net>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f36e47c9-f135-473c-b1f1-2fedaef8aa10@cobb.uk.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailer: smtpsend-20240729

On Thu 2025-06-26 (13:41), Graham Cobb wrote:

> I do various sorts of backups but the main one built around snapshots
> uses btrbk. It doesn't solve the problem you mention below but it does
> reduce the problem to listing each subvolume once in the config file

btrbk does some sort of snapshot rotation?

For this I have already a perfect solution:

https://fex.belwue.de/linuxtools/snaprotate.html

But snapshots are not a backup.


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<f36e47c9-f135-473c-b1f1-2fedaef8aa10@cobb.uk.net>

