Return-Path: <linux-btrfs+bounces-6685-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD9B93B676
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2024 20:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DA20B22E39
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2024 18:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B598F16A947;
	Wed, 24 Jul 2024 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="qSM8Kaw9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZFmo8dXc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978481684B9
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jul 2024 18:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721844346; cv=none; b=tutIt4+6nlqJaj9nmnj+UitKIJv/d20slorHQ0IUMyJVNnYKsX6HaNJBD3GlDouqF3maUV4oGSE5a1w/aBxCpS2LJFQOz11wyJMU9de4iMYV4Vail6/8K20o3DFb7nGQZhQE78tF5qS7R99b1kxs/44dWjnf3UYIaYWKNeltVnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721844346; c=relaxed/simple;
	bh=iHkVFoVYvk1HZtCYFE8PYB6YluARSb5KUnpsLtDRl9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H00l54Xf1r4Z1+QiUJ9lJJNi3hKjCmdU0UoDBEny91vh0Kz6GSjs7sWUQMK9L107fEOCsy21oYd/V+uWIYkG3OaVlekQXIteamWF3ujf4Lfp4R806iYpbOFTN9kmta/D2iUxaftjpeZKcTob3V8FX+63+pKMhCMtFQCrj43WwLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=qSM8Kaw9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZFmo8dXc; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 82EBB1140197;
	Wed, 24 Jul 2024 14:05:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 24 Jul 2024 14:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1721844342; x=1721930742; bh=7YwkcR0KHt
	eWTWpjYDhxkoI8tbs1s9z5l2XFFGYT36I=; b=qSM8Kaw93IiMw5TOoyCp9ddB+z
	kVVLbpIc+IxA8Kyflr924lpepBh3jYI6ulO6DUJNL9fXVjEeHL2yHEJtoqbz7ZnD
	c8Z7l2uf5YAnbOqWUuYQwrAe5Et16xmxoEl7I2oU4JEIlNG+wniM2FYJg0agIep8
	85uzk2z5hliYV2qSxVbhgnpS/Px2wBLwWiK8/iD6G4bg9THfVMSqOS01se1utLAp
	0ggDsALpOJS6pEbc7Id2lr23X/1tx6BA0KCW5Sj4v4Gub1bqOY0VNZ+OCFrHieSG
	wPHzwj94sK8spNWGirJb7c06LXiMwwk+LOHbdKSzKYXzvXqB5EHdu5UlyMCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721844342; x=1721930742; bh=7YwkcR0KHteWTWpjYDhxkoI8tbs1
	s9z5l2XFFGYT36I=; b=ZFmo8dXcN/drPZm6lbK9yK0YoZghwwPu+sVfemKNBVp5
	DJXi7s1IrHyD5r07L522OQn3w9bj6trED4KuKkLKL7paw7Hi2uzLp0kld/RW/DD7
	DU0443y7gBRQ2u4b2OXapmUoweVOEtZkNAm1U0p8JlYvuksPYJ5SwtrJBuaAqK0m
	C6Qp0k0o/aOTi2li2gmxPSxx3oZOS+xeGvwJ0p2HXxA1oldh+gaUVb3+nqWzBzAJ
	HpwaRj7NWxd2HKiJxlX2cvGnp3TVqRSZUicUTwSZnrTqy2v+WOnrna6gFd1UZMAL
	AT+33QSE2RWB71FTzf1fVU2KqyCceLtGItA+NCnmcQ==
X-ME-Sender: <xms:dkKhZp5VDBYk9ae9bSoCyrDGNmJ4gL5yckde4NLrLXGGSL_9IQ8Spg>
    <xme:dkKhZm6EyrGl52KzEZ2G1J6HgupH3VfaT14cGyQ6TfGgu3eW12ioNaAT7HUR3xDke
    ZK_u_YH0fDGYUsGsMM>
X-ME-Received: <xmr:dkKhZgeP_RZb2nGQrTIOjkSeuxOYJoEZC_Z11Mt4YREgKcHTlLYYchfvPjPmWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedugdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ehtdfhvefghfdtvefghfelhffgueeugedtveduieehieehteelgeehvdefgeefgeenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthho
    pedt
X-ME-Proxy: <xmx:dkKhZiKczckSUFhraNV3tYmd3XhZj8j4LBLWjcmTE932V9c08H7h-w>
    <xmx:dkKhZtLKbU6SddrKb-I5UZACPd3jQLX9qLfSiPXveBxUVq5EklBKOw>
    <xmx:dkKhZryjdp-jG-ueFYPq5XXZK0rD3v3KTtg2dRIhz_UyQZUQA_WWHg>
    <xmx:dkKhZpIwjOi0ngps24pIredIIpxW39B-6NyZUwLqhO9Cfbh5c0lXkw>
    <xmx:dkKhZqF_SBTec5Ay3DzXyhpUt-F1pKbNAKb4JBsyqL_1Qnh2mLxdH6Nf>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jul 2024 14:05:42 -0400 (EDT)
Date: Wed, 24 Jul 2024 11:05:37 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org, Mark Harmstone <maharmstone@meta.com>,
	Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 0/3] btrfs-progs: use libbtrfsutil for subvolume creation
Message-ID: <ZqFCce87fcBxgdc9@devvm12410.ftw0.facebook.com>
References: <20240628145807.1800474-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628145807.1800474-1-maharmstone@fb.com>

On Fri, Jun 28, 2024 at 03:56:46PM +0100, Mark Harmstone wrote:
> From: Mark Harmstone <maharmstone@meta.com>
> 
> These patches are a resending of Omar Sandoval's patch from 2018, which
> appears to have been overlooked [0], split up and rebased against the
> current code.
> 
> We change btrfs subvol create and btrfs subvol snapshot so that they use
> libbtrfsutil rather than calling the ioctl directly.
> 
> [0] https://lore.kernel.org/linux-btrfs/ab09ba595157b7fb6606814730508cae4da48caf.1516991902.git.osandov@fb.com/

The series looks good to me, you can add
Reviewed-by: Boris Burkov <boris@bur.io>
to it.

Two high level questions:
1. I think you put duplicate Signed-off-by: and Co-authored-by: lines on
each patch. Did you mean to put Omar as the Co-authored-by: ?

2. Have you run fstests with this patch applied? We have recently had
some test failures from stdout in create subvol/snapshot changing, so I
would like to avoid that fiasco again.

Thanks,
Boris

> 
> Omar Sandoval (3):
>   btrfs-progs: remove unused qgroup functions
>   btrfs-progs: use libbtrfsutil for btrfs subvolume create
>   btrfs-progs: use libbtrfsutil for btrfs subvolume snapshot
> 
>  cmds/qgroup.c    |  64 -------------
>  cmds/qgroup.h    |   2 -
>  cmds/subvolume.c | 227 ++++++++++++++++++-----------------------------
>  3 files changed, 86 insertions(+), 207 deletions(-)
> 
> -- 
> 2.44.2
> 

