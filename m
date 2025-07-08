Return-Path: <linux-btrfs+bounces-15305-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F55CAFC11D
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 05:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26D981AA6E06
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 03:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9485B176ADB;
	Tue,  8 Jul 2025 03:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="P1dQK4JF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WECQ0uA9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3D7F9E8
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 03:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751943726; cv=none; b=APlV1NxSRrO/5yj9DywPTQHHsyLPaCAlGv9hEqquAm7gWugqUjGHKEeLzSrDI4eadNlMkwSQ8khAQVuWxEKBenzj8r3FMCMZqbr3J2H4LaJIJsC0xryLajfL9E+MXm6godTaT4QZWKY1w7jSPcYpeezkcE4AsXLrLhVM5MjiUDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751943726; c=relaxed/simple;
	bh=3NWWjnEcqwJztSfxsz23Ut1FL2OK+GiJEl7omiBjLuo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qZL6xLKmAYV6Fi51q+joodI2nukpkFlU0o66S15Jk/QwIoTIZHaKds3u7aKajmp8zzuABQiWuNqWT+o0bUhR4ePTc8cpq8OpMxxT+wgsh9ALLSNpGv4C5KZNs6yozTHfvlLFglEUGBmIhDNyHi0GjUt25rQvmAz90IvtuT+QSA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=P1dQK4JF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WECQ0uA9; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D50F314001B9;
	Mon,  7 Jul 2025 23:02:02 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-04.internal (MEProxy); Mon, 07 Jul 2025 23:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751943722; x=1752030122; bh=OmqwGtr42P
	g1zpH13Zf+8izRqAL83rpo3flgPgwoPCQ=; b=P1dQK4JFbYnDuasSM0xHUoJnZs
	xa+w1/RqoB3HTZbr9/lyuH9SiRibbCG9A9m1MabhXBIYUzFBtJhbiysWELadkDf2
	bV4kwnhRqxOdpDclCO6GuMTDHZypmhJiYGgmlqkiAkpVzaHEwqgDbbsndt6y4poA
	Ghxxrmvf+tKUq60cY0Q7o4ThiCYwM52gxfmyo407JCL/LNVk6PHgqmwxSxr+mb4G
	v0RLTaU6ZoDaFOQLXyukp9H+FtoWtfxHTQ0LEtQasHxjzCTNygQn6nrauTJuF03f
	r4E8WJTy72yjTXEWjIjwjzfsVrFSGfGDCattp8G586M64wLHXixuyfX1altw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751943722; x=
	1752030122; bh=OmqwGtr42Pg1zpH13Zf+8izRqAL83rpo3flgPgwoPCQ=; b=W
	ECQ0uA9kmkzUSZlLjzDFccZ5+mqXGn2KxWtZt82TH6bXxKBs2J1H2ZYMjsY+j4YB
	vkIgDnPPsqPuv95KP5EEYEFfKskjL3JI83EaEA0LwgWelBCD53cKVgLIs1ZrzeR7
	/DzGduwKLNx8AGa4Egx7EaCIEDz2RUQcDzzygnqU3A3bzr3kFaRI0KLjRw90YfX0
	yEBI9VSQyJO4VWka4U+yC3R+rDpZfTY3+RGVU2Eli1rUQAt5fy38xO/h9bvc5uq5
	+CC+sOeCl/MnOKn+G42LscsQa5HdYrVTh2TVg2Vr18tcgupWs9+ZdjN+jxmu8VwT
	EtfsQs5orReBBXnnePaMg==
X-ME-Sender: <xms:KopsaFiUDjvTU38UmLu_m1lMDgRdykfjmxaI1DS-PHyiIuIo2ZCBJg>
    <xme:KopsaKBVkpfkKDbx2H8CbsjapLJQCGj8W9WeXAhn9g-T9uUHJ3lyk1Y3v5Jd6w-fb
    DBi8NYYKu94Idm6ztM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeffeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhrihhs
    ucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomheqne
    cuggftrfgrthhtvghrnhephfeuvdekteduhefgtefhvedtfeeigfffheevhfevuefffedv
    tdegiefflefflefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepughnrghimhestggrtg
    hhhihoshdrohhrghdprhgtphhtthhopehpthhrudeffeejsegtrggthhihohhsrdhorhhg
    pdhrtghpthhtohepqhhufigvnhhruhhordgsthhrfhhssehgmhigrdgtohhmpdhrtghpth
    htohepuggrvhgvsehjihhkohhsrdgtiidprhgtphhtthhopehgrhgvghhkhheslhhinhhu
    gihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdgsthhrfhhsse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KopsaL9w4gw9unIArrKO7OgB1Ofat8a87wTFJPZGOfENzbXSSIMEmw>
    <xmx:KopsaIdqP-ZKI4wV4tCilpOtPl-mHIKJdeYSdAsCBGmRn142fJddzw>
    <xmx:KopsaFLEWdgAjtF889r9YVXflnfh-LtUjNYucbvuwSLGpJn7l5nQZA>
    <xmx:KopsaIi5OurVYN1ECvlns8r2kZGZ89q1nKC-E3ldUOQVFu2zJ3yQ6g>
    <xmx:KopsaC9E1Zi7fDfcS9bBUI-BDmPTOgHaZ_iGRCWB7_TcQT17zQmH80Y7>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5027D18C0066; Mon,  7 Jul 2025 23:02:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T9aa883bbd62e96c2
Date: Mon, 07 Jul 2025 23:01:42 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Peter Jung" <ptr1337@cachyos.org>, "Qu Wenruo" <quwenruo.btrfs@gmx.com>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>, dave@jikos.cz,
 "Greg KH" <gregkh@linuxfoundation.org>
Cc: dnaim@cachyos.org
Message-Id: <d0863ae6-5c0f-46ff-8cea-b5b3d1c43005@app.fastmail.com>
In-Reply-To: <f6d53293-3d55-4ccd-a213-c877dc22935a@cachyos.org>
References: <fce139db-4458-4788-bb97-c29acf6cb1df@cachyos.org>
 <a6f03aff-c9fc-4e7f-b1fb-42d6a4cd770a@gmx.com>
 <f6d53293-3d55-4ccd-a213-c877dc22935a@cachyos.org>
Subject: Re: Increased reports since 6.15.3 of corruption within the log tree
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Jul 7, 2025, at 7:12 AM, Peter Jung wrote:

> Thanks for your answer - but how it would work saving the logs in the 
> emergency shell, specially if the root partitions can not be mounted?

You can mount a USB stick or even the EFI system partition to `/sysroot` and then copy the logs there.

Also for Qu et al, we have a couple reports in Fedora of log tree replay issues with 6.15 series too. I've requested dmesg, but at least one of the users already followed advice to zero the log tree. Hopefully we get one to report dmesg soon.

-- 
Chris Murphy

