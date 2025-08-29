Return-Path: <linux-btrfs+bounces-16532-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBB6B3C5B7
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Aug 2025 01:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FF207A6B7E
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Aug 2025 23:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA1B26AAAB;
	Fri, 29 Aug 2025 23:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=strugglers.net header.i=@strugglers.net header.b="oioCbYlE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.bitfolk.com (use.bitfolk.com [85.119.80.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D773481B1
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Aug 2025 23:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.119.80.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756511331; cv=none; b=FKydVXNqNRn0JBbZCqHEQb1OwB/iByXk+nrpOe4h2fdpHMo56bKGoFR/AIJlL935mpnOqNnU0Um9SU/MZkfahSBuU22D856b1vD56ym4pS1d3BlYs8E6VFCjta96zItZuLeq2W15jSlmmEfs7mifuhWK9OfgJ+jT5cfkIncqhcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756511331; c=relaxed/simple;
	bh=3a+eS9h6umqc5ALjDOUVBAEv0EL3jaqt08YKBno9ISA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgc3Zb51kcpSgP/IKh2ygDIoASzm6HLURkB6kriw1EY17LIcEskaQpY1irqmhjwYSfTWgL1bmgPB6xQo06xUqjUkQ4Za+2soFk+F55OyXWlZSiUmHuBX/ojG+D6TRVp1gkuxvEnq/8hBuaTNFaM7cxzs6x2wcZ5aoYUWeM8nRws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strugglers.net; spf=pass smtp.mailfrom=strugglers.net; dkim=pass (2048-bit key) header.d=strugglers.net header.i=@strugglers.net header.b=oioCbYlE; arc=none smtp.client-ip=85.119.80.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strugglers.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strugglers.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=strugglers.net; s=alpha; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description:Resent-To;
	bh=u43LSDWUSXFasm4CV5kiU6xnY8rHnRgDGzE46vg1OGY=; b=oioCbYlEXTR8np2adNzC1NyksV
	hig6Z8IytIoeIVa+Lg2JchK2nsIKEIu0HI4GIWo1EDkU0o0BaihfAUR8KSadqVS9S+HvUW3mTh7b3
	pJsVfxTosRYz9AQs+CSh9kVE0IKY3wCnA9s0zF+UoDdoje/a2Ipq0pIx6SsWH3aAiOx33iEIR6uI+
	hdJe+3DxjKCrrkSNn9XuexswkpuYeotUJOpCc/6qTyLD8+XySraVmIFKq5CXzihrl6KaB1Gq0SH5C
	0/8F0y3gtJaWcU4Tdaktrv3ru5OWhncKZDlE95hm9WdkeDsuGuLA3LsePseJ9nkhMASQoyqkEt8Js
	ONBDOWsA==;
Received: from andy by mail.bitfolk.com with local (Exim 4.94.2)
	(envelope-from <andy@strugglers.net>)
	id 1us8pp-00060i-9m; Fri, 29 Aug 2025 23:48:45 +0000
Date: Fri, 29 Aug 2025 23:48:45 +0000
From: Andy Smith <andy@strugglers.net>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: Mysterious disappearing corruption and how to diagnose
Message-ID: <aLI8XeLxrWhwhcZK@mail.bitfolk.com>
References: <aLIRfvDUohR/2mnv@mail.bitfolk.com>
 <a48ac216-38f1-4a69-970e-f2ddee2ae8f2@suse.com>
 <aLIm5djb6Ee4T1ot@mail.bitfolk.com>
 <635a25a0-c8cb-4a48-bf8b-c81dac1c1260@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <635a25a0-c8cb-4a48-bf8b-c81dac1c1260@gmx.com>
OpenPGP: id=BF15490B; url=http://strugglers.net/~andy/pubkey.asc
X-URL: http://strugglers.net/wiki/User:Andy
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: andy@strugglers.net
X-SA-Exim-Scanned: No (on mail.bitfolk.com); SAEximRunCond expanded to false

Hi Qu,

On Sat, Aug 30, 2025 at 08:28:25AM +0930, Qu Wenruo wrote:
> 在 2025/8/30 07:47, Andy Smith 写道:
> > Okay. Yes it is still supported by Debian so they are still publishing
> > updates for the related LTS kernel but I am relying here on fixes going
> > in to LTS kernel in the first place.
> 
> In v6.4 we reworked the scrub code (and of course introduced some
> regression), but overall it should make the error reporting more consistent.
> 
> I didn't remember the old behavior, but the newer behavior will still report
> errors on recoverable errors.
> 
> I know you have ran scrub and it should have fixed all the missing writes,
> but mind to use some liveUSB or newer LTS kernel (6.12 recommended) and
> re-run the scrub to see if any error reported?

I do a bit of travelling the next few days and I will not like to change
kernels on this non-server-grade system with no out-of-band management
while I am not close by. So, I will leave things with sdh outside of the
filesystem for now.

When I return I will upgrade the kernel, scrub and if clean put sdh back
into the filesystem then scrub again. The Debian bookworm-backports
repository has a linux-image-amd64 package at version 6.12.38-1~bpo12+1.

When I go to put sdh back in to the filesystem, I can do so with a
"replace" because sdh > sdg. Unless you think it would be better in some
way to do a "remove" and then an "add" this time?

Thanks,
Andy

