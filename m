Return-Path: <linux-btrfs+bounces-1738-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BED3583B28F
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 20:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADCF51C22493
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 19:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C9213340F;
	Wed, 24 Jan 2024 19:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="y/UKX7C6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u84GDVJb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E7912AACC
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 19:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706125925; cv=none; b=SFFEgq4XN1FbtETAXM6vHvwy29Zf89fy6+aCsyNidCzF8jhDVr326IksjF6ERIX6CWV99KEooWyvq3Yyq9sKD1IGQBFAFnFd+/SsBczS/zcHDBoUvzp3ejTktBR4wkk3YU4CxiEQUKaTc/CfHFvyRNwt8jSfwtJ8/9C/5EEF06g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706125925; c=relaxed/simple;
	bh=fz5g1JnjBmnIlyhLi+/l917E4rNyvqWQJottwGnHxtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxzFALJdAZV8Qdshlqckt5Bq0whZkApoqX3Mz0+hRusQY0ZI0iUjUWKjwSo81d2aNHSXbCRhX3mRvRGEyW0PlPdC0YDq/bYW84NuWwwgyeU5bg3olm+aZnI7asGmhX30zM3ykwN/hIpsXKxee5/PadSV5pXyw0LluGBn/MVK54o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=y/UKX7C6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u84GDVJb; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 1C4365C0098;
	Wed, 24 Jan 2024 14:52:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 24 Jan 2024 14:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1706125923; x=1706212323; bh=Fh+pyKoyA2
	4RTxPU0yGJLTCiuZ+oyU0Ae/bGcmOXARs=; b=y/UKX7C65yagI1kCMhm020ObNQ
	+rgMfFehzw5rEC1B3FCp/9oZxgJB1PKQSV7icgr5oEBWKNUSMAUY+acw+FOCb08z
	Wv3AYQJCncmZ8LfuIVjkh8Pnk5ap6z21aCQdD9Yc7Vz6ybv+pmDTE3yiU614s14m
	Er/js+6D8+EYnCDo10cuLqA9YnfLbBJi878UXUrtYtxEwQXk8XtJWSZeK2uhwBam
	LextpcyMD6tVkAQXTd9AarWUwFhIfSmLDm+HsGkPxsz16CMRzH3kAVAYPL9hlGSn
	HNMqwDCwaW9G4uvaLz4tHs6n5X6wc9UhG5+GH0d3XddGHDgujWaNjVX4XNDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706125923; x=1706212323; bh=Fh+pyKoyA24RTxPU0yGJLTCiuZ+o
	yU0Ae/bGcmOXARs=; b=u84GDVJbyyt8eh9egjP4FoG9i17Fawe/eUhR+XUmG4aw
	MAmgHDjgGtcpvQnt5RKuqD0FvcwxxEGVWmIwmEbylQXY1/RZcQpVB+/65i5mv0Qb
	AkRrwxPr5rw0gJb0x3gBBxG9KjjmcsanoE6I46NIIgJZ2/7ohF5ccNcw5S6xU4ov
	DXSQGvg3uhgRPZ901yKZJSEWhWjtYMXUHKR5vSr8zNKAvMcKxnHo95INRejVJMEX
	N7ZEUjkPwVcYXfqQISZvx1Z9cJBbckNZm/ahzqIGmz/m2A/jB3o0jA7SfEIxUbqm
	qqak1S3s+IVYyiE05N/WMzYXD4eD8q+dq2mrRJR5sg==
X-ME-Sender: <xms:YmqxZX5Tj1xqeLK-KpZN0v-dtAxUFr2EaciqiITpu674AimIwhe4eQ>
    <xme:YmqxZc7cJ7K_mWn74YvzoqZLfTU4rMB2qYFmB9S777u7aa5rRZZj81saeMIq-UohT
    WlM0cnxpzqgEIOp4Do>
X-ME-Received: <xmr:YmqxZedvotSJp2yQR3MHuH5EHFdGXFuow1u4P13z3lrO1fOE_cEntyFzJYaQVwrBulaSD-pCTJlce7QBeV7uW1SQRy0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeluddguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:YmqxZYKbijlUg9oBCUcf-gCpf-mD5jNo088Th9apoKA3eTP42vSOtQ>
    <xmx:YmqxZbLG1lvFCUrqugggYkGcW85DtXrIFv4keAc_zHtOXLzR8S5p9g>
    <xmx:YmqxZRwi9Rm5hGOBYvVeWvylX6lhrqG8zq4BrgGa4sSqOyYLHKy8NA>
    <xmx:Y2qxZT0vfdAeu_I7PTmSeaEXviJSR_95S6aSiRs63_TBGHS-ErOkKQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jan 2024 14:52:02 -0500 (EST)
Date: Wed, 24 Jan 2024 11:53:03 -0800
From: Boris Burkov <boris@bur.io>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	Omar Sandoval <osandov@osandov.com>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: Re: [PATCH v5 10/52] btrfs: disable various operations on encrypted
 inodes
Message-ID: <20240124195303.GC1789919@zen.localdomain>
References: <cover.1706116485.git.josef@toxicpanda.com>
 <0d1c1c34c9a9e2999a1cb5c76ed72ddcb866595e.1706116485.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d1c1c34c9a9e2999a1cb5c76ed72ddcb866595e.1706116485.git.josef@toxicpanda.com>

On Wed, Jan 24, 2024 at 12:18:32PM -0500, Josef Bacik wrote:
> From: Omar Sandoval <osandov@osandov.com>
> 
> Initially, only normal data extents will be encrypted. This change
> forbids various other bits:
> - allows reflinking only if both inodes have the same encryption status
> - disable inline data on encrypted inodes
> 
> Signed-off-by: Omar Sandoval <osandov@osandov.com>
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/inode.c   | 3 ++-
>  fs/btrfs/reflink.c | 7 +++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index bedd8703bfa6..c6122c20ad3a 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -639,7 +639,8 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 size,
>  	 * compressed) data fits in a leaf and the configured maximum inline
>  	 * size.
>  	 */
> -	if (size < i_size_read(&inode->vfs_inode) ||
> +	if (IS_ENCRYPTED(&inode->vfs_inode) ||
> +	    size < i_size_read(&inode->vfs_inode) ||
>  	    size > fs_info->sectorsize ||
>  	    data_len > BTRFS_MAX_INLINE_DATA_SIZE(fs_info) ||
>  	    data_len > fs_info->max_inline)
> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> index e38cb40e150c..c61e54983faf 100644
> --- a/fs/btrfs/reflink.c
> +++ b/fs/btrfs/reflink.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
>  #include <linux/blkdev.h>
> +#include <linux/fscrypt.h>
>  #include <linux/iversion.h>
>  #include "ctree.h"
>  #include "fs.h"
> @@ -809,6 +810,12 @@ static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
>  		ASSERT(inode_in->i_sb == inode_out->i_sb);
>  	}
>  
> +	/*
> +	 * Can only reflink encrypted files if both files are encrypted.
> +	 */
> +	if (IS_ENCRYPTED(inode_in) != IS_ENCRYPTED(inode_out))
> +		return -EINVAL;
> +
>  	/* Don't make the dst file partly checksummed */
>  	if ((BTRFS_I(inode_in)->flags & BTRFS_INODE_NODATASUM) !=
>  	    (BTRFS_I(inode_out)->flags & BTRFS_INODE_NODATASUM)) {
> -- 
> 2.43.0
> 

