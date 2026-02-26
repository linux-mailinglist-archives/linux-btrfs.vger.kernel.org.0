Return-Path: <linux-btrfs+bounces-22033-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAJfB5XBoGlPmQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22033-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 22:56:37 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7921B01A4
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 22:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EDC9C3012BF7
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 21:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EB746AEE9;
	Thu, 26 Feb 2026 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="qrkjXBtI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NSPAGp1b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF9B46AEEC
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772142988; cv=none; b=E54016WPLlxC0qDpsGqoEC+UhSmU0vi9E4ynr3GaxMbH69azt8tc+SDfDClZdZzavYmVqg6hlK5doY8Oz1r+Z/VQKssMFEiogeGccfGdjugp1L3S7JC+vZcmEImVt3eq+JYk6bJvYWT4Vt8Yr/k2meg6P6tYyauc0ppcWcoPkj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772142988; c=relaxed/simple;
	bh=+SrI1otzB7hjSKhkftGbKrNe4wBMKlq7ryIXsN0Izus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWRjFHc7iYgF6XNv8cSTuQLYkwewbnQjCizgo+kHoBON9utlrzoMWYgG+mcycfFef07ATUyIol8+/6aJNwAJHQ70x9NislCrtONJrerb3VK7r4ZmxbOLLbeTlBPqFE+42VmiVX9XtaROuzksPy/vZgGd4XWwX/7Q6C2fAXELk+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=qrkjXBtI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NSPAGp1b; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 56B301400206;
	Thu, 26 Feb 2026 16:56:26 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 26 Feb 2026 16:56:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772142986;
	 x=1772229386; bh=pgeiKx5RTeio+qAwVl+bCimtIqVS5YyyClOHKldbjt8=; b=
	qrkjXBtI7NwQpKOXOqx1pBKq0ZKNos28eBrUDB2TiDsCuHwKrpndsVEb/GGzp911
	8xLt/NV03OCN4KS73h/CezXV5Jd9rlQlKw1knIbTz5KLK9+2U9aqrGzDINq1/+xO
	KGQLJloDIEwxF2WWu9uglp3h6z/2vUBq3BdMkgvIkDfzfcv/AOk0g2ahmcmvk/pv
	BEGzcaX1wl7xGnuOMInlYAxHZA2CfyWejSwlUYr6FicxeCBxbdaA/k+fvU0DNf72
	V+Qv0JtsW69GZ+r1HhJQ8kJxE2NukAE+yGe6t4GUyIUEsyL1e6pTNty0/PI+UDcH
	q2QCeIYeb8Nkyrn053bIQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772142986; x=
	1772229386; bh=pgeiKx5RTeio+qAwVl+bCimtIqVS5YyyClOHKldbjt8=; b=N
	SPAGp1bJVZFrhaCWam/uoh8/GhnhYYgq+gVqmgMvRs68BVPqC5mzf9dmZVvqUMhJ
	1bPYRRHHyeC/GQ2gKqz6mM3dlt82rCZ8mdy5KfnW7zIsZsAw6NYriFNI5s6zl9WE
	DQVADwLNg+5lWyKvdKJ6N0ycX2jZUBvf/a2xt9K4C49njDCAsSJ0D6vT/bHgosqu
	/IV9s5RVkrSZou4kK6Mop7kvzCI1rT6KDptrF87Y3wjwifmo3CzJg+gkMk5G6xxU
	gUSwkHCCfzEwBMhUmUZyJA/QOCnR2c6HWhb3TvuqaM2oWWD85vkV0gLAeKL8ycpS
	1JlIre2Fj/f4XA865S2qg==
X-ME-Sender: <xms:isGgaTPRv7L0qNaZvHqOnzbjV1a4_abt50mq_EsChiBg_o6w3PSnUg>
    <xme:isGgaT-EN1-C_I5sUhiohzO502fQ64cYbPNom3eqvm6iFehssnU5xwMSBRNvXNaYC
    N5XEgG1oEMG7BwiD-fURy8AYaI9k6aMxRewvv04y0EcNaN6R8O32dQ>
X-ME-Received: <xmr:isGgaf7e0Cuhss4Rx_NSEf5UUj0TW9v0QC1jfUlnDHZ1PhUo013wuSga7qNvTHN_LrZsVChe5ORSsEagmo2pYagpPPo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeejvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhephe
    fhudehgfekhedufedvtefgteelueeigfefhfefgeejkeefhefhgfekjefhvdehnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohep
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhgumhgrnhgrnhgrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:isGgaS1vSU409YcSO0MYlWlrhvQ1A78L3zYcMKhXEqxMeEKLOfJRZg>
    <xmx:isGgaeBBabzmOrAptIRHDFJaNZgkMbljmIDUqmVOmhRxmXU3cjGhCg>
    <xmx:isGgac03GGIzFwkGGefgmbXOqQ_JAP0wfj0XGriW3jO-1gfjBcFCZg>
    <xmx:isGgaQujApmJjRKZAaoIV86j-XAC8TuvbfJgbdgCxqvTqt-1l02vBA>
    <xmx:isGgaVByDwrcL1Wzd4gB6xlj7V-9VrzQRVF3zpCC9KYzP1JqCSZHwhv_>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 16:56:25 -0500 (EST)
Date: Thu, 26 Feb 2026 13:57:18 -0800
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] btrfs: fix exploits that allow malicious users to
 turn fs into RO mode
Message-ID: <20260226215718.GB3111707@zen.localdomain>
References: <cover.1772105193.git.fdmanana@suse.com>
 <20260226191009.GB2996252@zen.localdomain>
 <CAL3q7H5QVSU6nPt3H27keGWNpjJNG9nzQphjSQZmK8uU9KXt1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H5QVSU6nPt3H27keGWNpjJNG9nzQphjSQZmK8uU9KXt1g@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22033-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[bur.io];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim,bur.io:email,bur.io:dkim,zen.localdomain:mid]
X-Rspamd-Queue-Id: 7F7921B01A4
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 09:18:06PM +0000, Filipe Manana wrote:
> On Thu, Feb 26, 2026 at 7:09 PM Boris Burkov <boris@bur.io> wrote:
> >
> > On Thu, Feb 26, 2026 at 02:33:57PM +0000, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > We have a couple scenarios that regular users can exploit to trigger a
> > > transaction abort and turn a filesystem into RO mode, causing some
> > > disruption. The first 2 patches fix these, the remainder are just a few
> > > trivial and cleanups.
> >
> > Bug fixes and cleanups look good. No need to abort in these cases as you
> > have shown.
> > Reviewed-by: Boris Burkov <boris@bur.io>
> >
> > But on the topic of security, or malicious users:
> >
> > How is this sort of attack conceptually different from simply filling
> > up the filesystem with fallocates then doing random metadata operations
> > until we ENOSPC and go readonly?
> 
> What makes you think that users causing an ENOSPC that triggers a
> transaction abort isn't an issue?
> 
> If we know of any intentional way to trigger that, we should definitely fix it.
> Even some weeks ago I fixed such a case reported by a user when
> running bonnie++:
> 
> https://lore.kernel.org/linux-btrfs/SA1PR18MB56922F690C5EC2D85371408B998FA@SA1PR18MB5692.namprd18.prod.outlook.com/
> 
> We often see users reporting that sort of issue, but we don't know the
> workloads, how to reproduce and the state of their fs most of the
> time.
> 
> >
> > What about if the attacker also exploits the behavior of the extent
> > allocator to try to produce fragmentation driven metadata ENOSPCs
> > aborts?
> 
> Do you know of a way to do that?
> If you do, we should fix it.
> 
> No matter what a user does, especially a non-privileged user, it
> should not trigger transaction aborts in an easy way (or anything else
> bad, like memory leaks, use-after-frees, NULL pointer derefs, etc).

Fair enough, I like this stance.

Looks like I had too low of an opinion of our intended ENOSPC
guarantees :)

> 
> Thanks.
> 
> >
> > Thanks,
> > Boris
> >
> > >
> > > Filipe Manana (5):
> > >   btrfs: fix transaction abort on file creation due to name hash collision
> > >   btrfs: fix transaction abort when snapshotting received subvolumes
> > >   btrfs: stop checking for -EEXIST return value from btrfs_uuid_tree_add()
> > >   btrfs: remove duplicated uuid tree existence check in btrfs_uuid_tree_add()
> > >   btrfs: remove pointless error check in btrfs_check_dir_item_collision()
> > >
> > >  fs/btrfs/dir-item.c    |  4 +---
> > >  fs/btrfs/inode.c       | 19 +++++++++++++++++++
> > >  fs/btrfs/ioctl.c       |  2 +-
> > >  fs/btrfs/transaction.c | 18 +++++++++++++++++-
> > >  fs/btrfs/uuid-tree.c   |  5 +----
> > >  5 files changed, 39 insertions(+), 9 deletions(-)
> > >
> > > --
> > > 2.47.2
> > >

