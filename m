Return-Path: <linux-btrfs+bounces-4254-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B639E8A4918
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 09:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F9A4B23E39
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 07:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BDB286AD;
	Mon, 15 Apr 2024 07:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="aUlfS3jX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NDS7hlDD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from flow1-smtp.messagingengine.com (flow1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0F123754;
	Mon, 15 Apr 2024 07:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713166413; cv=none; b=g9aoifCB5IRC2XDZ0c2cnFEAH7hiylDAbbSF3cN9b+9wCc81ztydiOBpPI/PIL0owQzfvuHbnrlV2MWWMkN8NME38rS2t84HdcAc1PvrXBxuxftfi+IbpBXeuWpNdIEnRadxbe9kmxiZtDR9/yKqw+4JgXbtPSfl6yTjTWvp2QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713166413; c=relaxed/simple;
	bh=HFJ4vvEzbNqRr809u1FK3Rn0pDUpQ5BHXzm67FweeC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAtjjWRQHiB1L7I1rdC+RZsQHdjvYyk/5sg4Ct5dh1AVmThi6EGnf7l7xzhRr6Nfo3nSo58hsMWxvE8dsX495Ou0UfDqHQhdwlROgh2G1HCN5JxqT7DAO9b8AaVnuc+vpXL/FKD9E48N1ZO/tCGJqmMaxXvO3HjEqq/F3onGgxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=aUlfS3jX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NDS7hlDD; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailflow.nyi.internal (Postfix) with ESMTP id 79CA9200281;
	Mon, 15 Apr 2024 03:33:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 15 Apr 2024 03:33:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1713166409;
	 x=1713173609; bh=zYaCb18rpM3siz4kg0tVUybMP3zre6Na/S02x87GIZw=; b=
	aUlfS3jXxHteh27LQC7faHfDYW58H+GwdHLiE2BEyeJRAhfCe/fJtnwU8kGZAPOz
	q31Te52fiZ0GO45wjLb165B/6g6pmP2LFuUkXBMcnQQ1yiUO6beKRcwZhZYCUxX0
	W2aShuCbPOIkMXKbkdPhlWlNX06bh5u6CUQQYAnDTYSVXiVRub2V9vmEWZCaYjVP
	Vv71wZkY3hWTXtNBux9gHaOTgItl54HXUwudac5Aas++CCHRhKx3uPIoZc2b9lG5
	x70uIi9i4iOItJmt2G+lRnt7+2gCtbZH4kY2KB8NzgiOuLYXNYOmu23zXQCm/wC0
	gSfgiG7wqU5XVNnxuZblpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1713166409; x=
	1713173609; bh=zYaCb18rpM3siz4kg0tVUybMP3zre6Na/S02x87GIZw=; b=N
	DS7hlDD1oo5DX2A3TP3ubreqBie2GnHP+B95uwV087hqwvTfud+q41nhzqm6NEWB
	fqMiO/qCvO5Ci5w9TZr4dboK0a9N3F7PnL6WEhAbaskuD+Ww1sW9+8kA9+XidF7d
	DCLZlPDHZMITedhP2BjrgnbRHr6N5eeI1SQuipckLnBexQJjwjIhTmULkpdjic3R
	gcyZ+2HH97EjkGHGD8DOO1T65Zw3Az3z7dBvZ+uhWH0/h1V62uK6K+mepnGotpi4
	1ZLjBkiN0zIJYPzsqJcznMtJJ/JwJeJLUYikOup2e6qt2ftvOWr3WQ1bF7N/RrSY
	I5bKJehUq3yTQ/1paDmaQ==
X-ME-Sender: <xms:SNgcZsqbRyeWANBDPD2jcuatT4oFRrQivl_cpsHaRLC3srV97r4Njw>
    <xme:SNgcZirtoiHooXMaCbQAAIxXVry-ycMB-9yL3EwBwLM-ndm7Mjhsbn4YmT1hRntI1
    F8Dw5v9tBezhA>
X-ME-Received: <xmr:SNgcZhMPi7kzWfDrZWm8wOg-IvDiHD5zKVSZEk1WGurkzDLrFRjFfCYEXT94oa7qvcfocJZ8aGwop0ghGMsWA52K07QOAbgSrs8_gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejuddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegve
    evtefgveejffffveeluefhjeefgeeuveeftedujedufeduteejtddtheeuffenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:SdgcZj7pJ5QDiXCAeIrihnXK-SkLqOI5nHIEu7fQo5C0ictAXGDsjA>
    <xmx:SdgcZr7H9_XwOWfD1YcAVvx_XOoSbFrhmUJowJu9ha8lFxRHg6x5ag>
    <xmx:SdgcZjhcA8CX4zGnYoJ1nPykgRswlcm4he_8yXebGP3Y9hD5kyZuTA>
    <xmx:SdgcZl4lhszvV_i-nFsej8HTe4k3vXgTqJDIx3o13C3-aA5clUYQlw>
    <xmx:SdgcZltlBSMZgdniTgLFrbr4163cdzb-qdaIKbzdZc960rIwu6uQfGHs>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Apr 2024 03:33:28 -0400 (EDT)
Date: Mon, 15 Apr 2024 09:33:27 +0200
From: Greg KH <greg@kroah.com>
To: Holger =?iso-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>
Cc: Naohiro Aota <Naohiro.Aota@wdc.com>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Hiroshi Takekawa <sian@big.or.jp>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: btrfs: sanity tests fails on 6.8.3
Message-ID: <2024041508-refocus-cycling-09e8@gregkh>
References: <20240415.125625.2060132070860882181.sian@big.or.jp>
 <bd8492f4-a12e-48ae-8ea6-a9d4596a6f72@leemhuis.info>
 <igqfzsnyclopilimyy27ualcf2g5g44x3ru5v3tkjpb3ukgabs@2yuc57sxoxvv>
 <3b2d9a1c-37d2-47f4-b0b4-a9d6c34d2c7d@applied-asynchrony.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b2d9a1c-37d2-47f4-b0b4-a9d6c34d2c7d@applied-asynchrony.com>

On Mon, Apr 15, 2024 at 09:25:58AM +0200, Holger Hoffstätte wrote:
> On 2024-04-15 07:24, Naohiro Aota wrote:
> > On Mon, Apr 15, 2024 at 07:11:15AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> > > [adding the authors of the two commits mentioned as well as the Btrfs
> > > maintainers and the regressions & stable list to the list of recipients]
> > > 
> > > On 15.04.24 05:56, Hiroshi Takekawa wrote:
> > > > 
> > > > Module loading fails with CONFIG_BTRFS_FS_RUN_SANITY_TESTS enabled on
> > > > 6.8.3-6.8.6.
> > > > 
> > > > Bisected:
> > > > Reverting these commits, then module loading succeeds.
> > > > 70f49f7b9aa3dfa70e7a2e3163ab4cae7c9a457a
> > > 
> > > FWIW, that is a linux-stable commit-id for 41044b41ad2c8c ("btrfs: add
> > > helper to get fs_info from struct inode pointer") [v6.9-rc1, v6.8.3
> > > (70f49f7b9aa3df)]
> > > 
> > > > 86211eea8ae1676cc819d2b4fdc8d995394be07d
> > 
> > It looks like the stable tree lacks this commit, which is necessary for the
> > commit above.
> > 
> > b2136cc288fc ("btrfs: tests: allocate dummy fs_info and root in test_find_delalloc()")
> > 
> 
> This was previously reported during the last stable cycle, and the missing
> patch is already queued up. You can see the queue here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-6.8

Thanks for confirming this, the next 6.8 release should resolve this
issue.

greg k-h

