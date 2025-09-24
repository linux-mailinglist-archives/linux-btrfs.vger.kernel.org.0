Return-Path: <linux-btrfs+bounces-17140-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C7DB9B817
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Sep 2025 20:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B1616A3F6
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Sep 2025 18:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1CB3064A0;
	Wed, 24 Sep 2025 18:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="FBpMbgL9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZmllJi21"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62148313D72
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Sep 2025 18:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758739003; cv=none; b=K71WZXoT496jYlMXr2zlS2mUigRA65HHdcma8eQE7A7lEv4jh5AwMVeeLeYPNF+QnCmw2o8/O26fqOIJfw9eEigO26T7yjqwwkJe1OL4h1LqvRt2LhafaLhUcEQxpZXbsjVMTTOG0FMl6ZYEWeNO6xawMRWvrvEIHjMB3WIs7MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758739003; c=relaxed/simple;
	bh=YrDI2r8m7ZWP57FpGrcjZRxgE0BR4BPXm/aILfsFatI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaTdNo2kvm5RDyqGHNTmC97y4hVQanmdFE9kMjXOHOjNKD09qOPkDdwm1q9mqX5wxUIxPGEghck2JEPyImY8ZVg/VOUEXRpQ6DhO+v6/OrtrqNLoqeH8otoT4MHP5C5J0A0CyP/Ko8qvwuQlGdHYiPImmoKIIkRXHxCvFhuFHqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=FBpMbgL9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZmllJi21; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 53FB11D0008B;
	Wed, 24 Sep 2025 14:36:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 24 Sep 2025 14:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1758738999; x=1758825399; bh=qrHJ4M1YxO
	LXajMwharjJqoaOQPer32yKYKXkCTgt/s=; b=FBpMbgL9jN/MXP4wfpEwJEIGUs
	RF/7dolEClqc8lseamIDZu8x+fpiPMsbPe25hLFDaTAR8PJNVKl/wZkTFBaqdB93
	DejgzbFY1NDFiTzcGRHXtmcJ+zrHl7WEtJUOygTilrQJzmy9r/moDt9LdJZt/ikZ
	CMZ+48bf5U33ucE+OZqGRXuMfwAzF0FE/NVRdepPGezv9xMMPzoiIxBB3d1Vk7sE
	18SGF1Sw69+CmVThJ6uAJweQl30nPQWIM3rhrG/8lRzmxwyxaFE0ZPW/J+XY3xYJ
	HyMmfLH47l9+rsXA6y0494l5eTQle3T0PGTklEJ1DrSXrQanUBydTnF8QY2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758738999; x=1758825399; bh=qrHJ4M1YxOLXajMwharjJqoaOQPer32yKYK
	XkCTgt/s=; b=ZmllJi210BJnmvhw5n77Z9AaWHBkaqT1bVxdh6q93TIZFc/I/Xh
	T+7wJ8wm6keJZErnIJH47Y2hbzmzaWQ9E9kWzGM0diZKxCvaM0XD8kJPYuqMUY6Y
	ZbXnmLgQY0cUB3BRPlVWS8Sd8XsV7M2nphCiVaiFnu1yrRgeGNChb9iKj4dQLhAs
	kt3ulFU6WoYC662GzG5jxi7CBqZGSUMBp3VB7VaWKeOEiMaKedE0lCT2o5mWsQQV
	NvNjiyy1HZzuVlO9xCNFuuub1gy8K2Pe4rhZ32EvxcVb7wJsDSKOy6F8M5G5WdKV
	xrE80GjZTebM0EPAfAiFrlDehZfla95vRPg==
X-ME-Sender: <xms:NjrUaFw1pNVY4cq1onmcJZK42LftvCJ7uFwX-5G5inpSRponvJ2uzQ>
    <xme:NjrUaLT_PlBx_44SX3e4PGupp2E1z63iS-gCdIVpPgQ8ANa1TVVFqet9CltvSR6g9
    VBhZAKonu3BkDyVwl9GU2tZz6bm5aRgVZlPtJ0p8pgm2QLjy_5Ciw>
X-ME-Received: <xmr:NjrUaM-Nx8rym9J0vcbTa7tNO_mZusoCYYMEwmFzX4NoO0H2NuWkcAMeJLECarSj5Z_jC_6BdLuJlMG0vRz5m57IBy4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiie
    dugfeugfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepfhgumhgrnhgrnhgrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:NjrUaCqkDQU8BCi4ozkV7iPXnmMq0eq45872EKuREyfcEJGn4Bangw>
    <xmx:NjrUaJkfyxTzIHEFZtGkUlvMgiXDqbR23qJ2i1YNsbQGRa3n4z4Maw>
    <xmx:NjrUaJLVg8V4DlJgAPyc-biz4kfLAlGIHY8MOUT0-yECILoeb00dBw>
    <xmx:NjrUaOzNL-ViY5dQVB3l3phBe_aRj1eifkvc4DGZCMVfJd5mX6tm5w>
    <xmx:NzrUaAmhpjZgv1E-luAfOl7XdWAhnd_DOk48U_TH0raymxfi5SvqyJzW>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 14:36:38 -0400 (EDT)
Date: Wed, 24 Sep 2025 11:36:37 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: relocation bug fix and a cleanup
Message-ID: <20250924183637.GA3027411@zen.localdomain>
References: <cover.1758732655.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1758732655.git.fdmanana@suse.com>

On Wed, Sep 24, 2025 at 05:54:54PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Details in the change logs.

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Filipe Manana (2):
>   btrfs: fix clearing of BTRFS_FS_RELOC_RUNNING if relocation already running
>   btrfs: use single return value variable in btrfs_relocate_block_group()
> 
>  fs/btrfs/relocation.c | 51 +++++++++++++++++++------------------------
>  1 file changed, 22 insertions(+), 29 deletions(-)
> 
> -- 
> 2.47.2
> 

