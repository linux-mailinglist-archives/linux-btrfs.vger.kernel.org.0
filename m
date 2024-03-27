Return-Path: <linux-btrfs+bounces-3667-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF3288EC68
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 18:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED23F29F8EF
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 17:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0BC14E2C9;
	Wed, 27 Mar 2024 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Otr2a2Gq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bePMxTCm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF80B14D718
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Mar 2024 17:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559957; cv=none; b=RXnCVlnnb9WFYba4afVmISPXdOo4eXX7U7h1sEWpljVM0HcjBiUAFwj8u5xyGnv2ApGNgxzE5mUI4yX4XrdMKBdZnCS5bit119kHp2skj6KtRzgCeYngeVVYVVhES2WemsEsjtxZJal7wonLwQigQafpFPdrPa+qDfaasuK8KZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559957; c=relaxed/simple;
	bh=GM9Kjupa4oL2XTz5E9pZCqIV6VaagDadZM59Au4GqrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qX/BuuL/h2mmwDMsyvM2MXffqHvqoV+vXmeOarTTA7p3iogv3IVegPs4XzVWerhvYPpL4IBGenG4ubKhwZxdqmgsx0Uu860cpOVcFMoXE8nyxO7WlJP3vH2n9dpmVIzg68jfQg4UBtlluLlEA8VmJ83k83UwfiJcoSUjI4X9pJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Otr2a2Gq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bePMxTCm; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id B33223200258;
	Wed, 27 Mar 2024 13:19:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 27 Mar 2024 13:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1711559954;
	 x=1711646354; bh=3d6oilyd9ml9OfgiADgs0/agyOcrhaZ0Rc4NSqEUi24=; b=
	Otr2a2GqUQpX1OpPCocpnn9jlaC6mAaP2p6SFjMg01tMxfdpAm1TEUqg6PBNhX+F
	c0z1sC8UJPLi2PtvBan4rj7R+tW99MnO4/1Nr7xpR5U6OEfZQgRXkUQmudA2tvIF
	7JmapNwKQKDpVOK1GRZIoh9iIqu+67r9C8MdXe9rLWxTgLFjQQQUsosw9pziGcyU
	cxKKZbyQlTQC84/FXoB1wUm6DFLPeifSIfE5w9odDVXewroz/sQEtRQNudtnZ8kb
	RrGHzU5cWiTETb6OhyI+p6yJ1JR2GWBiZsMRgAmUuAFYD4pvGKvL7vnSVkH4rZmI
	mNBU2BzGlJABqyQxwVEdRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711559954; x=
	1711646354; bh=3d6oilyd9ml9OfgiADgs0/agyOcrhaZ0Rc4NSqEUi24=; b=b
	ePMxTCm5Dh4I9KsjWSx3sRD3nCmqhlyx3hd8fXLwuyM65CavCZCDW93g/utiJV7L
	hP2/Vn4Aki6b0bmNlRBHf5Cy7HvFOus0Rgqg/nrLVHVBzJr1pRAwaJSyqV+FKGrc
	FVpuKbiTCzHscb2szPb2UljF9TiY+6Ou0jYi1ptMvEGigtZOqrpGktCKBows0SZx
	ZzFBSxLu0zi4KV0Q+pSVCy2gg5nO3fIftSvKd3wjHxhwmKAYHn0OpeF6yo3RZVhc
	2zYSuwf9G+t6Vs8hm1vxpcne1zhhYpniGAFr2rMahSU42HM9dG0trMf73EPkc3Ib
	PSzuQZlo74gRg85PK/TvA==
X-ME-Sender: <xms:EVUEZpP6cRrLU_l2vf-bReWt4IOx8Kk-J9Md41XcaOChr7W5JT5A5A>
    <xme:EVUEZr_eIWvRD-RQbHDN4q5PTKkE6mCnULpMSKr2sHR3f7QP8oMLq75cce_7URqLC
    g7K2YDvAtfWKHZ8XAw>
X-ME-Received: <xmr:EVUEZoTJ__zE3Dk0XD43DcUCYic6ev8gT9-Zgx2zG6Y-zKmAQtgB08O6UugA9YsC1MjN0Piv5mqL8LKH_YZnzkMBoTc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduiedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epudelhfdthfetuddvtefhfedtiedtteehvddtkedvledtvdevgedtuedutdeitdeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:ElUEZlvRiApCGb_cNi-nqr2QrivPrltalRXBMn880jp8cJp0YauH7g>
    <xmx:ElUEZheqgI75vV4fFy5w4aA0BHxHtxbZP0gBGquuco0CrGQYqnXz-Q>
    <xmx:ElUEZh2ys4WHcdOmNzEHv8ZcKxYZBZ-nxeUl5N1Fv068hMIhW363bA>
    <xmx:ElUEZt914iperBW-3CEutwUULP3nExqsWvo9o36docetxQrJBLZ7oA>
    <xmx:ElUEZipDWOPDLiWKDnTgHAe931RjUinr9nCHcDwVgLB58Esm47IpXw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 13:19:13 -0400 (EDT)
Date: Wed, 27 Mar 2024 10:21:20 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/7] btrfs: record delayed inode root in transaction
Message-ID: <20240327172120.GB2470028@zen.localdomain>
References: <cover.1711488980.git.boris@bur.io>
 <cadc31b0278e4e362f71f7c57ebccb0c94af693b.1711488980.git.boris@bur.io>
 <b88f00db-117e-43b6-ada6-4790c5030417@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b88f00db-117e-43b6-ada6-4790c5030417@suse.com>

On Wed, Mar 27, 2024 at 08:38:53AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/3/27 08:09, Boris Burkov 写道:
> > When running delayed inode updates, we do not record the inode's root in
> > the transaction, but we do allocate PREALLOC and thus converted PERTRANS
> > space for it. To be sure we free that PERTRANS meta rsv, we must ensure
> > that we record the root in the transaction.
> > 
> > Fixes: 4f5427ccce5d ("btrfs: delayed-inode: Use new qgroup meta rsv for delayed inode and item")
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> Just curious, do you have a case that hits this particular bug only?

I tested all of these fixes just by running generic/269 and generic/475
in a loop and driving the meta rsv failures down to 0. I *believe* all
of them are necessary to get to fully 0.

> 
> Thanks,
> Qu
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >   fs/btrfs/delayed-inode.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> > index dd6f566a383f..121ab890bd05 100644
> > --- a/fs/btrfs/delayed-inode.c
> > +++ b/fs/btrfs/delayed-inode.c
> > @@ -1133,6 +1133,9 @@ __btrfs_commit_inode_delayed_items(struct btrfs_trans_handle *trans,
> >   	if (ret)
> >   		return ret;
> > +	ret = btrfs_record_root_in_trans(trans, node->root);
> > +	if (ret)
> > +		return ret;
> >   	ret = btrfs_update_delayed_inode(trans, node->root, path, node);
> >   	return ret;
> >   }

