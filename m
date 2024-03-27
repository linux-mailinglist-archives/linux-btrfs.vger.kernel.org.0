Return-Path: <linux-btrfs+bounces-3669-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE9B88EC90
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 18:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E0F1F31C07
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 17:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5078214D2B7;
	Wed, 27 Mar 2024 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="DepJfeXC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m50FrM+s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA48F137929
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Mar 2024 17:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711560277; cv=none; b=pFokzsLuJ+aemAhnXF4HMlGEJoDOKI1+dtzRJHGgoewca0kFjy0fTbFvj7ymb0uMqPRbfrAAltkPLRK2jhaLFjIa1J/L3T1d1rWfQdW1elcZBPg24fdMKyk95OewDhW2xOzYplQHLS5kncEqUJJO+DzIaf1+kGUymLJZKmp0c+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711560277; c=relaxed/simple;
	bh=t17r0vREiELZCkory1PUyWE9ToCwROWn/XFv90Gx3Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjsFlj8y2vCuarauheagCqX0a6u4yd1W7Xn+M7k2lZYcHBHQ19Cd+O2aW/8phY8nmdCENle7UKBN91wYufSHwEn+TF71KPByWWd6wUQQxK2KY+/l8Katxw98QnFAinJ1gW6FB6LVKDGBi0CiHIXpsqlwlZgdaIQEzjh0W/WSQpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=DepJfeXC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m50FrM+s; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 7DE2B3200906;
	Wed, 27 Mar 2024 13:24:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 27 Mar 2024 13:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1711560274;
	 x=1711646674; bh=Zrb8jsma23GFnT0xJl7QM+WPIQE1cT+9KW63Hgc9b2g=; b=
	DepJfeXCk7H34XFxtNZSV2yZIUo5zftHTaAOXYCYaUQorSCh+8KIoy5sIVTkPx8B
	x9ydNbeQQsOS++XRy+H6/PvsfPcdFwU5Ay2nXOHrCoXGpiGi4lPs2IOywmuBJHuZ
	KoXf4mvzR/AJ2r0OY6NvsS1cLi2Bhn70V48+1a/T2nEEFvmNdjOw5a61HiACk9k7
	vEv1C9duZB5Yoxh0G4cH/ZgGevqbF2Otzppcq00xRbHRW9erU2ldzuUVRPqqz8Vy
	ny0RVPtPxpEUfgn2Yd/nJynRllMb0KBPUNhB+Qd/2g2GzhqrfkQKN2aCofbmTiut
	rweyCU5TtAlP5Pjzno4Z/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711560274; x=
	1711646674; bh=Zrb8jsma23GFnT0xJl7QM+WPIQE1cT+9KW63Hgc9b2g=; b=m
	50FrM+sLjvQfN4r6xqMy7rqa2CPUU5fJjwtuWAkTXRNDCKFNzdMTqMDdviShOz76
	7wWaKBCq/M5IPvjmhjnG8oU4e6DMUhmKmzvPbOMKNS/HTRa845q6QJSfl/ONABOV
	Khh/rQgF1zvo+GmcaOrRp3dYGhXbrIYYaAx8USgEznUgnIddsFFvqXr1PlOvE3ub
	gOAfagpku7McwobnsD+aY9jipblvlsdDvKGv8wLrAoZhYbpBrYdXFtMnP32uX0XQ
	PdUF1ts3ni8LyYxwcvgL8www1nHC6+dLgZwtxsQXvRabj7XE/50YBcLlDhxouBqz
	xQm2lMFUfE7VeHLHmhfkQ==
X-ME-Sender: <xms:UVYEZg2u7igDHMj_vFULRQwPV60E2CNyqPMxdQngn9N81W4nsbkavw>
    <xme:UVYEZrHl8d94uTHfyzuGK8eqyGe3L4iV9JUlZ2kNDmga8E5HDTugolCQr_Dg39wPh
    X6twYADCPiDo1nFn4U>
X-ME-Received: <xmr:UVYEZo4q6OKlxyx9m46grn4dQHJhQcZMRiSdH9J541T-GUEcVzTmtpoZn-R-x5k4gQUEp77UQ6a2FW68QsmustPskHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduiedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epudelhfdthfetuddvtefhfedtiedtteehvddtkedvledtvdevgedtuedutdeitdeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:UVYEZp0e4dbI3nWmnvGK6-BWTLiSWecPbEYfVEJHQ0IBU9YGXm0b8A>
    <xmx:UVYEZjHbWlqz0Dk6J8hY_bctG6QAH1_zPI8f80H88fdOA6ubUm2GlA>
    <xmx:UVYEZi_2rylXSk64AT7IHlECnhMGy4GJ2Vta6UqKwsXeYeJUrPXG-A>
    <xmx:UVYEZomdC__8dpCX-znVdcWrrg-WPPzzRNISrqVWCPYlNhMJtQezwQ>
    <xmx:UlYEZoS9ue34xfSo8cEMiy2FxAOGlPuadQH43S0YCHKglgkqGSxL6g>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 13:24:33 -0400 (EDT)
Date: Wed, 27 Mar 2024 10:26:40 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 6/7] btrfs: btrfs_clear_delalloc_extent frees rsv
Message-ID: <20240327172640.GD2470028@zen.localdomain>
References: <cover.1711488980.git.boris@bur.io>
 <ce7db2df5f2f7617ac37f7c715a69e476acc7f1d.1711488980.git.boris@bur.io>
 <586364af-9082-4b9f-b1fe-3ed75797d87d@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <586364af-9082-4b9f-b1fe-3ed75797d87d@suse.com>

On Wed, Mar 27, 2024 at 08:56:20AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/3/27 08:09, Boris Burkov 写道:
> > Currently, this callsite only converts the reservation. We are marking
> > it not delalloc, so I don't think it makes sense to keep the rsv around.
> > This is a path where we are not sure to join a transaction, so it leads
> > to incorrect free-ing during umount.
> > 
> > Helps with the pass rate of generic/269 and generic/475
> 
> I guess the problem of all these ENOSPC/hutdown test cases is their
> reproducibility.

Yeah, it is definitely annoying to have to run generic/269 and
generic/475 hundreds of times to hit various different flavors of bugs
and try to drive it to 0. :/ It's hard to be sure that you are actually
successful and which fixes are definitely 100% necessary.

> 
> Unlike regular fsstress which can be very reproducible with its seed, it's
> pretty hard to reproduce a situation where you hit a certain qgroup leak.
> 
> Maybe the qgroup rsv leak detection is a little too strict for aborted
> transactions?

I agree for aborted transactions. It feels like a cheat just to beat the
warning. There are many failure paths that don't end in an aborted
transaction that we probably do actually care about, though.

> 
> Anyway, the patch itself looks fine.

Thanks for all the review on this series, btw!

> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> Thanks,
> Qu
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >   fs/btrfs/inode.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 2587a2e25e44..273adbb6b812 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -2533,7 +2533,7 @@ void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
> >   		 */
> >   		if (bits & EXTENT_CLEAR_META_RESV &&
> >   		    root != fs_info->tree_root)
> > -			btrfs_delalloc_release_metadata(inode, len, false);
> > +			btrfs_delalloc_release_metadata(inode, len, true);
> >   		/* For sanity tests. */
> >   		if (btrfs_is_testing(fs_info))

