Return-Path: <linux-btrfs+bounces-9149-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1689AF04A
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 20:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF2371C21C55
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 18:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5750215021;
	Thu, 24 Oct 2024 18:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="iFhdIqdC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CRdALOrP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C82F170A27
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 18:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796287; cv=none; b=S3SrBvtXSl1isedk6aDIKM70Oxm2T7+CXJaTtKOhLEtnm1Mcwv7OBPAmzDNoVG+2NC+z4vWOBrjXjlbEfj0nCCH3y30u6Q4Ol/vPoAvhurAuVnT56ajJoGBHQCgnlJiXFusFSvkgZYH/ZTDtr7ZMBLmxYdsynEd9LUNhD6YIZSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796287; c=relaxed/simple;
	bh=Q5u88WyNFVEYMT3w/Z1PtdTjP6C0+xPV62qx3Kn3QB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFchw5ndnfSUsWjdpLeUMu3swPY1mAt89L4HieyzJT90j+ZhFOX3D8gu2QKX45jxhn0faOHbWa6Jt83nU4M3yTNtUFqHgmmj5rWt4huGUlzDwmUsHdGeUd2dy4xkxL5AJefzYOnLbvzfZkT1RmxmuqzdbFYWjK0mb32lRMfMG8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=iFhdIqdC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CRdALOrP; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 63D99114017E;
	Thu, 24 Oct 2024 14:58:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 24 Oct 2024 14:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1729796284; x=1729882684; bh=OQvMQ+ZqBX
	cUk29qDCg8hybKE9cMgov1mTXaIV1zvoU=; b=iFhdIqdC28NuM/78J25wvT9rOp
	dLG7c+ylD55P0QtDFiHfnHzkVnpgEUQOUEkWxUNR9paVQ7YwxX48Qy8SzhQk5PqS
	ELvHpO0xejSHW0/I+U2RGCNtggeDYxs1xDJjQP1+nOS4wAZ2hvYonJ9FDN+3utDB
	Pc4Wv0xiQ0Cpzg+gDtSLfhRkFV7w8bEMI6jeIkHt50heXPadjCjBi+x927CWOKbS
	3N5hiqqhPsmW3m8duvL8VkIpSsbIQuSOEvewkw+2T4m+jEa8cczAB47bHA7jgI9k
	piYNhQymAQ43lwl2wkcS1FMNY2v5Rxl714xK2IpzTEkIRz7qamN9P3NrMBSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729796284; x=1729882684; bh=OQvMQ+ZqBXcUk29qDCg8hybKE9cM
	gov1mTXaIV1zvoU=; b=CRdALOrPGGS3z9A61GDDpGxBOgBkkmAzZ80obDap1VyR
	b5AdbWldIKvhWB0ao3gUmxwZKQ8wIsIzgCKo77l1h2ZUU0kaWZYRetw1b69TWNzF
	72KH3Gvrpo6ohD76KJ24Z2Jqg7pjPcRC8XlRHJ6EMgjXAPokQ1uDnCX7wzHHBdwD
	GAtB2C8xLeOz271hRk02T9IAHfvWlay8dODrSdL2E4BfpzuCysNS3AHsZ9TizM8I
	oCcvBBqHehuwsm/4ChrXohmM0kWW9ZQoORfsmW5FEnm5Md8iqWJjmA4wpUqByxYB
	QBu8irFdF92z3QpMPHIhYUighC90NIUXfp+o4g6XxQ==
X-ME-Sender: <xms:vJgaZ1RYgdL1hxL_1uFYfLpRP1ClYRCCsGeWA-2Yq5LzBtYsygjieA>
    <xme:vJgaZ-wv1GPFRD5hY0eqGpfmepmjrGqHqghOm2KEyaMg8f97o92hSUxan3T3WP4hm
    E0CcsKoGssB1tPDeIY>
X-ME-Received: <xmr:vJgaZ63HVvHko9e3aCt0POO7rKQyyfbsVf1ORco4bAz-OIFthUqlKr8LS3ci0rboLwA8NvX4vuBibVhyOFM8y0k4ISs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcuuehurhhkohhv
    uceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvdekffejleelhf
    evhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhgumhgr
    nhgrnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgsthhrfhhsse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:vJgaZ9Detxejg-LbK_DbOPYAroBvTI8GOCtCd72K7zelKctF2uak9w>
    <xmx:vJgaZ-iCfE9WNb6odG--Nv4hvyidtRGGC6fp3RFVz9GT8qolHsj39A>
    <xmx:vJgaZxrJZhTIdLU9lQL7Y0ocFOu5XcXjroyGKREP32O_OUSSHpunfg>
    <xmx:vJgaZ5iNBmtte_Spg1W52F7nU04fi1NxXUazLvRnmUn0Q018z7OFtQ>
    <xmx:vJgaZxsFrlSHI9GjryMxLmmV4jyHvpqgGQCdCcbESGuSYbaNOt-DJbYH>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 14:58:03 -0400 (EDT)
Date: Thu, 24 Oct 2024 11:57:26 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/18] btrfs: convert delayed head refs to xarray and
 cleanups
Message-ID: <20241024185726.GB315088@zen.localdomain>
References: <cover.1729784712.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729784712.git.fdmanana@suse.com>

On Thu, Oct 24, 2024 at 05:24:08PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This converts the rb-tree that tracks delayed ref heads into an xarray,
> reducing memory used by delayed ref heads and making it more efficient
> to add/remove/find delayed ref heads. The rest are mostly cleanups and
> refactorings, removing some dead code, deduplicating code, move code
> around, etc. More details in the changelogs.

The cleanup patches all look perfectly reasonable to me, and the risks
(new tracked variable, new allocation) with the xarray patches seem well
considered.

Thanks for making this improvement, I think xarray is a good fit for
delayed refs.

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Filipe Manana (18):
>   btrfs: remove BUG_ON() at btrfs_destroy_delayed_refs()
>   btrfs: move btrfs_destroy_delayed_refs() to delayed-ref.c
>   btrfs: remove fs_info parameter from btrfs_destroy_delayed_refs()
>   btrfs: remove fs_info parameter from btrfs_cleanup_one_transaction()
>   btrfs: remove duplicated code to drop delayed ref during transaction abort
>   btrfs: use helper to find first ref head at btrfs_destroy_delayed_refs()
>   btrfs: remove num_entries atomic counter from delayed ref root
>   btrfs: change return type of btrfs_delayed_ref_lock() to boolean
>   btrfs: simplify obtaining a delayed ref head
>   btrfs: move delayed ref head unselection to delayed-ref.c
>   btrfs: pass fs_info to functions that search for delayed ref heads
>   btrfs: pass fs_info to btrfs_cleanup_ref_head_accounting
>   btrfs: assert delayed refs lock is held at find_ref_head()
>   btrfs: assert delayed refs lock is held at find_first_ref_head()
>   btrfs: assert delayed refs lock is held at add_delayed_ref_head()
>   btrfs: add comments regarding locking to struct btrfs_delayed_ref_root
>   btrfs: track delayed ref heads in an xarray
>   btrfs: remove no longer used delayed ref head search functionality
> 
>  fs/btrfs/backref.c     |   3 +-
>  fs/btrfs/delayed-ref.c | 319 +++++++++++++++++++++++++----------------
>  fs/btrfs/delayed-ref.h |  61 +++++---
>  fs/btrfs/disk-io.c     |  79 +---------
>  fs/btrfs/disk-io.h     |   3 +-
>  fs/btrfs/extent-tree.c |  69 ++-------
>  fs/btrfs/transaction.c |   8 +-
>  7 files changed, 256 insertions(+), 286 deletions(-)
> 
> -- 
> 2.43.0
> 

