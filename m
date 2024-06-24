Return-Path: <linux-btrfs+bounces-5944-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 484A7915696
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 20:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56201F21508
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 18:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AB21A01A9;
	Mon, 24 Jun 2024 18:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="pavmVeQU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m5UPA2R6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409E21B950
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719254496; cv=none; b=h52JdJ0PZ2Hz6zC+shPyb4JRjBCOCYtrjAKL2znXCugiGbXwPlsTpG6EYr76gRnse1vbi+9qsTWlwXMTUerOwEq8KnU1zihDdu/aRPGwL9jq+WVuQopCyqxfFADZGfisI7z4CxmnLdl2mPW0vRgraKJRQ1ifKAsDpz7asF+uxHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719254496; c=relaxed/simple;
	bh=1Q9Qr/UklzReMUd9zPNYl3e5CGG9PrYRJD81pbnErok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilLFRIGoP96aUbAuJ96x+kY8KnEs8izUylp1sjgZ5DxD1H72933HRiTM3+lx5vZGgCh3Yz8hi920UH1kuNy6q6x4FyHlzDlompXWmpR5QCsccce0LsM05w1mvl744yTkOn/zt8ODyKRVEhvHFGY0v88gn5E0DDdxMFB7ETtWaF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=pavmVeQU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m5UPA2R6; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8823D1140173;
	Mon, 24 Jun 2024 14:41:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 24 Jun 2024 14:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1719254493; x=1719340893; bh=Ye3xWks/IR
	3gqOoShGD38bBmmzr8gslmBfQ/YiBe18E=; b=pavmVeQUr2AEgyXxqNJCPiBexe
	05iBpk62+e1xNERpHmaRimBE+WpiLGOMTjSCXdC4D4ZGX8DlVEk6Ckn0ezGpyBMD
	2cyfO2L8IMGoXdtzbiTs5lac3Qi4K+4F0F74H2wS/qvYtNzdudrP2nWJJB9I2xwj
	f5GtxryZv3cR3l9HNnV80lL15Fn8yEHu/bh+hKzqsLU8P0g9oVoLTkNeWIjjBR/A
	4LXeSpmgrbgbPNu6S/H7AhZgfgN6qUgNYJPxasx+AygGXqcUvr2oiJVgQfiy6Ok5
	HMgesA50GcZva5sDdbw41zgMoy9jLyBgL5Ftr5c9mdRlqdAfPa8zg+N8RuQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719254493; x=1719340893; bh=Ye3xWks/IR3gqOoShGD38bBmmzr8
	gslmBfQ/YiBe18E=; b=m5UPA2R64DhXsu4e+rxMQfkxPTZJcATg0O7MMwPZjqFv
	1MHpaI8/wHe5i2hXcLVy8vUEuoFURxNBMVmLqGgdvF7e4VwniASQbLA6alUJt9Ry
	e86b8YavqH8EKwDe1WJciTsAlokD24qF1qt+JdkSQOVigcR4+4/98mjkFxCEa31i
	zt+JSSrrQJxaZVdGWPkwGrLsuBCrKkyagokdd0+rEh6FvXpCL+zYphie3LxKeuXT
	8tg1rKS0wz6gCMYSvSbniEl7UxOPfUm0OamicNFYHC7ncXhJa84Rs3gxI1be5lZB
	fUuSkoqqH8kI9vBfYABWLLaWPt1ud0EnogA9ZeQTHQ==
X-ME-Sender: <xms:3b15Zu5nzj9mg8EG2MECbkZtlZckOIf0jkmADiJZKLzAvDzsvj7TNA>
    <xme:3b15Zn4woBdkqP2A8MZy_SVzi7sDmgLXJKNXEm9uWgd8FDiHPVSa5ld4jWSXuR-8R
    iJisOj_I55CNA6s0gw>
X-ME-Received: <xmr:3b15ZtcxTuq4oXZ43hC6w-Y-VqFIPsvhYhNad1Mp8u5MPCAFmm-xQdAvKd6ueIAtD3O-ABSgut_176K2WB41tw0ggqU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeguddgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:3b15ZrLOKa3y2OAHuyl0ntkaAuLKNaJdP4TubRtkK6Ld3-I_A0BAVA>
    <xmx:3b15ZiKy3G5QB6A94JQELtkIRG0GWNml9dKPLdtrC5CBl-j6i2Pb4A>
    <xmx:3b15ZswAQbBzPvN_HEg8jIX4F_19W5GA05LkM2U9_WyXkR_CUcCYqg>
    <xmx:3b15ZmIwEom7WC6LEo5QoubaY_90ChiXBfiM0T73vPGuYZNsbk5jCw>
    <xmx:3b15ZpUhy_YmSGvHxf_uM__qtv-JGUviQDSK99asJ3gndZCHHoJ14cAG>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Jun 2024 14:41:32 -0400 (EDT)
Date: Mon, 24 Jun 2024 11:41:05 -0700
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/11] Inode type conversion
Message-ID: <20240624184105.GA1405248@zen.localdomain>
References: <cover.1719246104.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719246104.git.dsterba@suse.com>

On Mon, Jun 24, 2024 at 06:22:56PM +0200, David Sterba wrote:
> A small batch converting inode to btrfs_inode for internal functions and
> data structures.

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> David Sterba (11):
>   btrfs: pass a btrfs_inode to btrfs_readdir_put_delayed_items()
>   btrfs: pass a btrfs_inode to btrfs_readdir_get_delayed_items()
>   btrfs: pass a btrfs_inode to is_data_inode()
>   btrfs: switch btrfs_block_group::inode to struct btrfs_inode
>   btrfs: pass a btrfs_inode to btrfs_ioctl_send()
>   btrfs: switch btrfs_pending_snapshot::dir to btrfs_inode
>   btrfs: switch btrfs_ordered_extent::inode to struct btrfs_inode
>   btrfs: pass a btrfs_inode to btrfs_compress_heuristic()
>   btrfs: pass a btrfs_inode to btrfs_set_prop()
>   btrfs: pass a btrfs_inode to btrfs_load_inode_props()
>   btrfs: pass a btrfs_inode to btrfs_inode_inherit_props()
> 
>  fs/btrfs/bio.c              |  2 +-
>  fs/btrfs/block-group.c      |  4 ++--
>  fs/btrfs/block-group.h      |  2 +-
>  fs/btrfs/btrfs_inode.h      |  4 ++--
>  fs/btrfs/compression.c      |  6 +++---
>  fs/btrfs/compression.h      |  2 +-
>  fs/btrfs/delayed-inode.c    | 12 +++++------
>  fs/btrfs/delayed-inode.h    |  4 ++--
>  fs/btrfs/extent_io.c        |  2 +-
>  fs/btrfs/free-space-cache.c |  4 ++--
>  fs/btrfs/inode.c            | 18 ++++++++--------
>  fs/btrfs/ioctl.c            | 16 +++++++-------
>  fs/btrfs/ordered-data.c     | 22 +++++++++----------
>  fs/btrfs/ordered-data.h     |  2 +-
>  fs/btrfs/props.c            | 43 ++++++++++++++++++-------------------
>  fs/btrfs/props.h            |  8 +++----
>  fs/btrfs/relocation.c       |  2 +-
>  fs/btrfs/send.c             |  4 ++--
>  fs/btrfs/send.h             |  4 ++--
>  fs/btrfs/subpage.c          |  4 ++--
>  fs/btrfs/transaction.c      |  2 +-
>  fs/btrfs/transaction.h      |  2 +-
>  fs/btrfs/xattr.c            |  2 +-
>  fs/btrfs/zoned.c            |  8 +++----
>  24 files changed, 89 insertions(+), 90 deletions(-)
> 
> -- 
> 2.45.0
> 

