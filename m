Return-Path: <linux-btrfs+bounces-3991-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FB789A78E
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Apr 2024 01:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 186F2B22E8A
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 23:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C0B3838A;
	Fri,  5 Apr 2024 23:16:56 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from serval.cherry.relay.mailchannels.net (serval.cherry.relay.mailchannels.net [23.83.223.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C3B37700
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 23:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712359016; cv=pass; b=H9fI72ecH++WDT14RqOclxIkLTXxfxGlRbYFYppLmh4puCX8NHNxCccUcSOEXw6HJijqF7uGtP0dalegfzvP5MkmdleWoggnVl8g2lBoWNOgAuBNIoVkFcO2rAjslfM54lzgl7n8oqXLwY7Re+U7ZpCER2ISoT9Z49BschVVsPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712359016; c=relaxed/simple;
	bh=jDuVH4YcYREDClLmWJGhMc40jIuTGMSJLcaiQZoW5rw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fhtXl1m8jQBNWKhX+JV/nV5+a5A/vmzgzmOoacTuiR9QBR2tDwRX4VpaWWX6JgEJ38OMAg24OeXjz9/UrH/0DyI1PqsKompHHGk4YvnQvLG0+3aGO6gaZ6MYgHBZ8QiQ47JuYf/Ix4koI2SgkpPM0nMurNSew94t1DqTZ41xNes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.223.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9B9042C2E0E;
	Fri,  5 Apr 2024 22:41:07 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id CE7E42C2EE8;
	Fri,  5 Apr 2024 22:41:06 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1712356867; a=rsa-sha256;
	cv=none;
	b=BESpnhSbhzZ7VkeSHQ6pPDX+auMlhVGPzlQOPSyiadJBXRXmabjt5O0jijcO8l4oEyXMIE
	kzab+psX5AjxaOryWL7lnDSFe3mbY7/AptmRnb5sLkgUZXqG6jNrOcMoW0rjab/d4bedSh
	bIM51YMM5vm2phguL1gD+Dp3YvkffVepTXdEvsryCYeXULXGbFRlVyJDpLmKpzc5K1KWSq
	haoI3O1JwvWJYpDLy5ZT1W+TZIqn82Ls2mxAXyAU77k2zCb8Zlm6CQRtoflriwNDzshNcX
	98AqfqWAW2fvAgurIB3BZ4IkmoxuTU8FIrk0NRsUNVm0yZzUrZNzbfLxOJ5N2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1712356867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDuVH4YcYREDClLmWJGhMc40jIuTGMSJLcaiQZoW5rw=;
	b=Lfmg0NjxJFB2BydfjWLkh60CxWA2C2ApJD75SkZPwf6gToS17TsRId+wRObyrfTj4sFvtV
	qg8xAkm/gwju5xqor2UqusWZt5R6uJPOjGCyvHFKWlXSzTIlqJx2n/TdfM5fxDybIQ2ZDB
	gAQkafT/fAAFvva3naFelZQmLX4qwCkLtQ+sncWxxQKP2TKitze4xrwfIXR9bbE9h+UmD+
	zi4yLYV4P6AeYKQsI52GVxWJFwpGvdWKccBQ7KyaC8ydfVEb1tsRO+WIjHd6DSm1pnf31F
	4oAkJumidWHizJiF1jmT9QR8qmg6FcA8yZds7/AbW6j9jtd10nHtkl1W6KeOYg==
ARC-Authentication-Results: i=1;
	rspamd-687b9dd446-9778w;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Daffy-Befitting: 4fa4d1de272ab27f_1712356867491_2189981210
X-MC-Loop-Signature: 1712356867491:2310122726
X-MC-Ingress-Time: 1712356867491
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.118.210.220 (trex/6.9.2);
	Fri, 05 Apr 2024 22:41:07 +0000
Received: from p5b0eda68.dip0.t-ipconnect.de ([91.14.218.104]:38668 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rssF5-0004Ow-2N;
	Fri, 05 Apr 2024 22:41:05 +0000
Message-ID: <0c9f96442083fe6e5ad387adbc496ff2f3370270.camel@scientia.org>
Subject: Re: exactly shrinking btrfs on a device?
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Roman Mamedov <rm@romanrm.net>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Date: Sat, 06 Apr 2024 00:41:00 +0200
In-Reply-To: <20240406033700.2c2404c1@nvm>
References: <896a5d36071a30605c38779dd03103b6429ebcae.camel@scientia.org>
	 <20240406033700.2c2404c1@nvm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1+b1 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

On Sat, 2024-04-06 at 03:37 +0500, Roman Mamedov wrote:
> Shrink it with a large headroom left to spare, e.g. by 50-100 GB more
> than
> necessary (or say by 10%, if it is small). Then shrink the outer
> container.
> Then grow the FS using the "max" keyword, to occupy the entire new
> size of the
> container.

Yeah... sure that works... but it's not so suited if one wants to set
some exact size.


