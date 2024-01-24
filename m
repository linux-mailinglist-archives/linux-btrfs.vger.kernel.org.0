Return-Path: <linux-btrfs+bounces-1739-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3CB83B290
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 20:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D221C22845
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 19:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820D5133402;
	Wed, 24 Jan 2024 19:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="MUkoEm1T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m2mWa6YQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B7E12AACC
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 19:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706125955; cv=none; b=hODyp86ekXj0zlgNPI4H3NY6+nA+iG/oZdbLnIDClubicNCgbfKXVCDNbZnNiwh7idU4gth7uunkeyGMVRy4B7/DpBzWgUDgO8db1RuiMKgb5EkUQeDNd63UXuimWcSqGgKkq4jzCDk1rjJGlXZUtteX5vZ3w1E0nfoHKSnEjRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706125955; c=relaxed/simple;
	bh=XAPNVKtoTXZ6if8vHQ+KJl2nRxz/yXhwn1jds7fakj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPDuFyiPQiOhQOF04CDjz5RXUUvi4gNK7clsGya0Fy5Nw57wOQxblLJd5H+LqV1qAJq9gSmiF8oKReHyzduGu25yskjLzyfVq2HNUHPYuBboeEQGVpfZcejGJWE7A1e7hYT0qKWK+tylhFgW4i4ntrnCoSjKO8rI+FeMd4ricGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=MUkoEm1T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m2mWa6YQ; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 1119E5C012D;
	Wed, 24 Jan 2024 14:52:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 24 Jan 2024 14:52:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1706125953; x=1706212353; bh=81KK0SShQq
	YKzrVPEJNT87pZtNejjrZZ5pll0ggDP9M=; b=MUkoEm1TNGc7t/klo2Pk9q2xze
	1L8rh6PPcVgrbP/2i9SPLChHsorYoiyOAZxPNa3thL68Zyl5D7PxVLtdagMilonr
	tYG5cLn7+UgiIgjWZCU08K4yxEPKiwewyE6hrnuXwJrZj+aw/6+cS0RjOgFdYjrU
	eQhMCuDZ/KFpHUhF7R8ptm66XCfomo1j61G5XYFKXd0a7j3zUh7ecCdfdUGNdD7x
	iVsjlznW5jVWvqjLEjQzNtJal+An3tzdOWj+nNxu4llkqkTz1hTWPMcCvwpq3YVx
	0csSYIUvFqj3KbMtVqch0JJn/3VAAdUSDC6mIyHm2S53PgQGdqQu/MGAP3Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706125953; x=1706212353; bh=81KK0SShQqYKzrVPEJNT87pZtNej
	jrZZ5pll0ggDP9M=; b=m2mWa6YQrmU8JgTsNRM5Q3n2k4a87epmX3D1jGEgmv33
	5T3m+xQt6W4kU9NPR6nYBtJ+AkUS8mykcbj04gzmDnl+YeWhXPNd6ojw/mp3CG6o
	mzfN+rIh2RY4UH4poHc9c8c/Nct1uSdMtCFtBfambPJZRSMwzDcDT98Ne92zTFGA
	2FqKxg1mauONFLPM4m4AcH3nh+XAYiIY5+k8FjlhCQr3uOMpL7nKNZEm4X0riGAq
	uSpxpKn7Za8Lv0A3THX0TTDswHc67EkNXRQPswL89tNXYXf8Vq4TBXHpdKdbSG/5
	GBYViZp0Z2/KZNlgr0DkWfFJZmY6dmepRKggJpOhQw==
X-ME-Sender: <xms:gGqxZedzqHTMEdTfO3KLTAhMd6GxNue4tLronhIR2xR5-r4GSzpvGA>
    <xme:gGqxZYP_xHbnQuKgV7PzwvzGdpa8BpWgteHyRiv3UeoFPM4bBwJzyGMAG8tT0vmva
    FKMjnzaZSQwfrECHOE>
X-ME-Received: <xmr:gGqxZfjUlK1I8urwBjysyn8acidgsNpzybbsXkHKa3z8qFPHJBlnuDBaZUKQzpbIZTCXgf3DKBSbbEp3kl4ReUNZPF8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeluddguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:gGqxZb_pOEkMclPHk3RtVzw40rAXlfaFbkHlObHCS5eYTzClOYqmbA>
    <xmx:gGqxZavklKnmAha-rKeiC_gWuODJhIJ1DsGCnTS8e2IY2qsKy9bzyg>
    <xmx:gGqxZSGbYZJj5_VcyQIiYVvy0viUMhPxDgqYXg63q6q5nz5NR9A_Lg>
    <xmx:gWqxZT68uVTVUptqqyfJvMJdplAFnDK0ilX6qAKfYOBIx4q-kynefA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jan 2024 14:52:32 -0500 (EST)
Date: Wed, 24 Jan 2024 11:53:34 -0800
From: Boris Burkov <boris@bur.io>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: Re: [PATCH v5 11/52] btrfs: disable verity on encrypted inodes
Message-ID: <20240124195334.GD1789919@zen.localdomain>
References: <cover.1706116485.git.josef@toxicpanda.com>
 <f4f34a604fa16b8b91a4db0c6f3bca3beca22ab3.1706116485.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4f34a604fa16b8b91a4db0c6f3bca3beca22ab3.1706116485.git.josef@toxicpanda.com>

On Wed, Jan 24, 2024 at 12:18:33PM -0500, Josef Bacik wrote:
> From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> 
> Right now there isn't a way to encrypt things that aren't either
> filenames in directories or data on blocks on disk with extent
> encryption, so for now, disable verity usage with encryption on btrfs.
> 
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/verity.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
> index 66e2270b0dae..352b2644b4af 100644
> --- a/fs/btrfs/verity.c
> +++ b/fs/btrfs/verity.c
> @@ -588,6 +588,9 @@ static int btrfs_begin_enable_verity(struct file *filp)
>  
>  	ASSERT(inode_is_locked(file_inode(filp)));
>  
> +	if (IS_ENCRYPTED(&inode->vfs_inode))
> +		return -EOPNOTSUPP;
> +
>  	if (test_bit(BTRFS_INODE_VERITY_IN_PROGRESS, &inode->runtime_flags))
>  		return -EBUSY;
>  
> -- 
> 2.43.0
> 

