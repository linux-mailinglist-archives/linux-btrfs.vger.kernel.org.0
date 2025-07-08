Return-Path: <linux-btrfs+bounces-15339-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F3FAFD78B
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 21:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D9D586858
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 19:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0832023B62B;
	Tue,  8 Jul 2025 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="vl7+Rej6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UPp1/7wg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DBE238D54
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 19:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752004224; cv=none; b=tkgKKXbC14hxUM3qglWzCADyNaEw0Y/hiJdxuUGobyxUDnpMYhGGt2bcgh0k2pkLK6rTskSegCMTGmdEgxTFrbV/d/wRorfXGpxFwXLei+YzX1zq2OmPHJnFc0BqQIUYqjFLrdj/LeTXclWQkmf7QYqlKTDUzA13F6t9yy2b6iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752004224; c=relaxed/simple;
	bh=2UztvTslP0ehI1rmuNABz+fWMKuRHZfKiTl8tPHvHy4=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fblh5Wyl4wcFkGteIGfvz1bn3ngjt8Q/wrnrvwnS/3uW6tfsS1/DIaiY3GaAkMUFSi01k+DgSyuvBs6HJQhWjc76w73SK50MRA04NxgVLI3XmveJJDp6orFob06ni3yYOxuEe5hUe7K688jAsDi5KjOtpt/MMzyz3RE2RQhzEX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=vl7+Rej6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UPp1/7wg; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5293F1D00232;
	Tue,  8 Jul 2025 15:50:21 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-04.internal (MEProxy); Tue, 08 Jul 2025 15:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1752004221; x=1752090621; bh=m3TjWZiHSn04RYL9gDFGg
	4y+bCHK5O43/Pv6L0Hyylg=; b=vl7+Rej6y91A3k5Ki7yYvxzFG46wCRQ/mlp73
	/31+3oBucjTnBYEQQn+SS3KKID6FG+8nj88PLSeNm626+523LsQXJGAN/fD8BCvm
	rXHeUb86erDndv69fa1m7pD9s6FphK1wSGIHPwOSsSGtAz5jyZdB8EhLNbkXIcNg
	Mc5jUco9DYRe1m8pj6IVlAvtmpTJ6vlEishMncvUr4f0yfu5FVR9/PKUbZ0T+yc/
	7zdX5W4cr/wUI8Th/XZaaruIahzW/5in8bG2eVWF1js4A3dDg5SurE9G7K2e9xLa
	/J+XeAQdQ+BF33MSyciRi6upfIcsYLm0+gcLHu94okrpkI05A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1752004221; x=1752090621; bh=m
	3TjWZiHSn04RYL9gDFGg4y+bCHK5O43/Pv6L0Hyylg=; b=UPp1/7wg+2Z3/3kAC
	o+SF4Myn/o247uLDZSCE4yLv7jlELoIHTQYJoRgXSbOAOb+Jew8OSbeOBH3QfvMl
	Xw0u9dHX+vjjnLRblxEh0qaCyzhtDgpjEtiwmLZ01IT2GbzTqbPcPGLCuWvkJrK6
	l7+sj9wFrZitboK8kw8KyGYKuhG62h1WrcrRLuHBOwdBijkkjhSbaieVfq58G53g
	qYu6+UjP5S2Du/NE0RWV3+2591pmwQmTJsc4+NN+d1ovggEHaFiEx6JGWPM1MPyg
	8jYYEHcdKO1D/y8iksW9YiN8L+dhdZ3/0CPugFTIBv9U5Wt+4fe2Ulucji4zucPw
	jFj7A==
X-ME-Sender: <xms:fXZtaDio27bw7uUD3npep-ES0sy3smLUmeR_6sV_OKhaimLdwIcBrQ>
    <xme:fXZtaAAMPyAvojnjKjrt7HCNlCnrAULHlEc7MCQdpfMxtgH_Gr24Fhb3PgVcbBCJ3
    blUUG2CcxcrlmO9eBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefheehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhrhhishcu
    ofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeetfeduheekheegkefhvdeghfejvdevuefhtdfgjefgveeiveei
    vdefvdfhvedvgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmpdhnsggprhgtphht
    thhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprhgrnhhshhhurdhtrg
    hnfigrrhesphhrohhtohhnrdhmvgdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fXZtaHmL4wmuGQk0CbyXWAWImkBG9CE-QtcHII5cM0JurtMpJzy0hQ>
    <xmx:fXZtaDyWgxBBr9KSz0V4Jg1g-V2eIWR-wO0Hghbmnh0JvsWrGjY7Tg>
    <xmx:fXZtaPnK6GVIEdOqsUXR144Gbf-pRKXssC077zjt4NcDRfhkZpoNTw>
    <xmx:fXZtaMfUmnExm4IurIZvdcxQTPErPiwIs1ktalEmlIP7IJW6ORTS4g>
    <xmx:fXZtaIX59RL01z3Rmqr1Hc_u237fiWGc88EMlR0b_m2nU9lfk18ZNFNw>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F3D0818C0066; Tue,  8 Jul 2025 15:50:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T0f06dcb0030a71c2
Date: Tue, 08 Jul 2025 15:50:00 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Pranshu Tanwar" <pranshu.tanwar@proton.me>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <da43965b-d22c-405e-bac6-206b36e968be@app.fastmail.com>
In-Reply-To: 
 <aNH6WIV_zJGBEaJfeLnCw0RqDLyn8O8OMUPMm-S34So8BWqu8xJP4iW8rfm3vGu6dDr8ibw2vt9EOaOfHIUgn5NxNQsuleebWRsBiyGOpYE=@proton.me>
References: 
 <CAPYq2E23F7VdgtwCydEVa9wdomEVbQUsQPgfyLVh5ac=KLBEdw@mail.gmail.com>
 <CAPYq2E2BSbW=8mYOO2NxJtcXPgPZ75nzH8C014-2ncyFb64L2A@mail.gmail.com>
 <1332fd28-ca5c-43d0-b815-c8da74c0a7b0@app.fastmail.com>
 <aNH6WIV_zJGBEaJfeLnCw0RqDLyn8O8OMUPMm-S34So8BWqu8xJP4iW8rfm3vGu6dDr8ibw2vt9EOaOfHIUgn5NxNQsuleebWRsBiyGOpYE=@proton.me>
Subject: Re: [help needed] parent verity error on HDD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Jul 8, 2025, at 12:05 PM, Pranshu Tanwar wrote:
>> Copy files out with -o ro,rescue=all and reformat. The problem is probably the result of a drive firmware bug. Keep backups!
> It did not mount, I got the files with btrfs restore to work in a 
> snapshot of a shared snapshot to then restore the files. I am now 
> working on rebuilding the drive with safer mount options for both 
> drives.
>
> These are the options I came up with:
>
> /etc/udisks2/mount_options.conf
> ---
> [defaults]
> btrfs_allow=compress,compress-force,datacow,nodatacow,datasum,nodatasum,autodefrag,noautodefrag,degraded,device,discard,nodiscard,subvol,subvolid,space_cache,commit,noatime,flushoncommit,noflushoncommit,barrier,nobarrier
> btrfs_defaults=commit=1,noatime,compress=zstd,flushoncommit,barrier

I don't know how udisks2/mount_options.conf affects anything. It should have no effect on the root file system. Anyway, you really want to use either upstream default mount options or your distribution's default mount options. You will run into trouble much faster otherwise.

>
> /etc/udev/rules.d/99-disable-write-cache.rules
> ---
> ACTION=="add", SUBSYSTEM=="block", KERNEL=="sd[a-z]", 
> ENV{ID_USB_DRIVER}=="usb-storage", RUN+="/sbin/hdparm -W0 /dev/%k"
>
> But turning write caching off in hdparm is painfully slow, so for now 
> I've commented it out, relying solely on flushoncommit and commit=1

I don't think you'll be happy with the performance of commit=1 , it's too frequent. If there's a firmware bug resulting in flush or FUA transiently being ignored, then decreasing the commit interval just makes it more likely you'll run into a problem.

In my opinion the solution is frequent backups. Btrfs snapshots and send-receive make this quite cheap to do often. But any backup solution that you understand and have tested restore is the one you should use.

Best to reply to the list so responses are archived and everyone can chime in if they want.


-- 
Chris Murphy

