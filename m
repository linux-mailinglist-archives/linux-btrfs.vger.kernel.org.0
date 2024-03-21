Return-Path: <linux-btrfs+bounces-3501-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 758698860DC
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 20:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FBE62851D0
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 19:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9747B1339AB;
	Thu, 21 Mar 2024 19:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="DFM5Vg2K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qzye/aDi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CD45CB5
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Mar 2024 19:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711048006; cv=none; b=ZG1g7Y8ETPObL4rLRJCBksTnJFQqYIZgSv2v+I9ZGDI50bq3HYxs/iFO2sDLdhZC0NJ0J6aEMQ/0sdXRjNlSu3p9rKjlY/ksoZpqJED/8aurqHZGulh0fooEcLblLMXzP2LDIbK2Nr6Y6FkbXoW0lvFs7VFxjFHn+zq+zE6g2hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711048006; c=relaxed/simple;
	bh=Nvhz4gFkVP4gxKaKZdpdgnq9DiRYq/wKKEzAyrCOKKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BddP9W4uF9kLFIJwefUWb5GXMOu1vP/MkvS3rfJ+GbIHQv9yPGUr2z3rtZOoSZ+u+P1U/yDJ9Wj6Tw0ZVnOc6LhqqJm5yfUlzFYKmDoDhdYGkYJevKhkRl807R1ExptJaizePKsoktFXK+0SlTadxsoJj5Hg/iHReSJCfZ38SmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=DFM5Vg2K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qzye/aDi; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 3B6FD5C0087;
	Thu, 21 Mar 2024 15:06:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 21 Mar 2024 15:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1711048002; x=1711134402; bh=SwH7nYsGfl
	6lP5supB1dNCsFYBWiwHwI6HnQWevsly8=; b=DFM5Vg2KCuv9P0En2J9XKxHHGH
	toSALEMihDzK7vWHmx6dS8pH98Xc+hfI8AiHy05hae3veBkMCWim+vys8jIbwNso
	ErdN3c8cMlAkjP+clj9dytfnQKFmN9NIDtWQFrpYtkdXJYaoS5Z+P6iWtc1vBE2S
	FJ41541Awm+zjzuSlPvGxc77C3uwmCEZxXcvbyqFAE9nojyZOoPpkabBuCMKFuSQ
	nzJ7V1vd88QigBXeTbUbNnheDt8ior76QiGsuDHmNvdKQBXe4dMaQbMryTqZcc6g
	1KufSkPlTD3+wCbJELH4Xj3eKf9WHBCyy9Kfxi0D51534mUt2y01nlWmvayw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711048002; x=1711134402; bh=SwH7nYsGfl6lP5supB1dNCsFYBWi
	wHwI6HnQWevsly8=; b=Qzye/aDifPag5jrk8Ryy96tMMWrBR1atHHCeE4E8RRDr
	a/68amjbIKDAxv6ltiXfPScF8buAk1GfJXYeIXTNEyzQfprZ1ZI4i7cz2M2ZC/b7
	x+ASj3t8KmxUTRNb71r3eiaTd/gMhOsIBgms08e7I8grHGXE7vab5i3qaITBL6Nz
	sy5RUNA5ZPJJDhsEWG58MdeEXrMqpUdldOqfJ1uPGn51YO7Tc8fK8/RB31guMO7Q
	IgiHfLfjVCxXOWKhM3oiah7pmPXVMvzdpk7e9w2c6XERNe5dWKmkxbP3ohu8+1D6
	/OxblWUvJ8LakJ5whOkWpdqRg0QX4kUGpj99hB4kCw==
X-ME-Sender: <xms:QoX8ZSEdcd0ugPUPTlFluIz5ZE1pLrmsnBlxZT5oFup45ImNozhcrg>
    <xme:QoX8ZTUpt6kVSHSECUQdWM7kjby2d4osol4nsYYzrkiqAuHd-ug1pduclK1sH8iPq
    U2I9E12QshM-2X_yfg>
X-ME-Received: <xmr:QoX8ZcKBPry0x2nSQ1t-27GM3CsjZkYTAZks5HLvEnmqb35huuVqFvngz8Vtac-aNBJxB2NAAIPxL4gZ1FOIUMzwoHU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleejgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepke
    dvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:QoX8ZcH37G7plAzD7GCwgcjw1KAyyDqUTyoLLqKRvYhltDeo1nWPtQ>
    <xmx:QoX8ZYWnrCGsXUCqP5kODOMksSm3SyWJb79pUBxEV7D_wcSzuOkC1g>
    <xmx:QoX8ZfNth7rbOnyTl_e7MfJ-RjXkzPR0MBt3cc50vDZn7U0bRcdDEg>
    <xmx:QoX8Zf2zE6Ekvj3cMlcZ1UCNYEXd3lPy_VLbHUJjX-r1SjT8HHfahQ>
    <xmx:QoX8ZVhAUSFH6xlyN0DSTofSya7WXI625FcNEA1rl3eBjP4ASd7Ddg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 15:06:41 -0400 (EDT)
Date: Thu, 21 Mar 2024 12:08:57 -0700
From: Boris Burkov <boris@bur.io>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: reflink: disable cross-subvolume clone/dedupe
 for simple quota
Message-ID: <20240321190857.GA107915@zen.localdomain>
References: <74730c411b0fd87484c8d894878c5cd8bac1d434.1710992258.git.wqu@suse.com>
 <20240321185135.GB3186943@perftesting>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321185135.GB3186943@perftesting>

On Thu, Mar 21, 2024 at 02:51:35PM -0400, Josef Bacik wrote:
> On Thu, Mar 21, 2024 at 02:09:38PM +1030, Qu Wenruo wrote:
> > Unlike the full qgroup, simple quota no longer makes backref walk to
> > properly make accurate accounting for each subvolume.
> > 
> > Instead it goes a much faster and much simpler way, anything modified by
> > the subvolume would be accounted to that subvolume.
> > 
> > Although it brings some small accuracy problem, mostly related to shared
> > extents between different subvolumes, the reduced overhead is more than
> > good enough.
> > 
> > Considering there are only 2 ways to share extents between subvolumes:
> > 
> > - Snapshotting
> > - Cross-subvolume clone/dedupe
> > 
> > And since snapshotting is the core functionality of btrfs, we will never
> > disable that.
> > 
> > But on the other hand, cross-subvolume snapshotting is not so critical,
> > and disabling that for simple quota would improve the accuracy of it,
> > I'd say it's worthy to do that.
> > 
> 
> We did this on purpose, and absolutely want to leave this functionality in
> place.  Boris made sure to document this behavior explicitly, because we are
> absolutely taking advantage of this internally by having the package management
> subvolume managed under a different quota, and then reflinking those packages
> into their containers volume.  This is the price of squotas, you aren't getting
> full tracking, but you're getting limits and speed.  Thanks,
> 
> Josef

For a little extra context, if we hadn't wanted to support reflinking,
then squotas would have been yet simplER, and wouldn't have needed the
new inline owner refs. For better or worse, we decided it was in fact
quite important, so we added the owner refs. Now that we did the hard
work and committed to the incompat change, I certainly think it makes
sense to leave the support.

Boris

