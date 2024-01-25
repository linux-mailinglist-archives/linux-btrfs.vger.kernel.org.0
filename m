Return-Path: <linux-btrfs+bounces-1810-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4518283CEAC
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 22:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7837A1C237ED
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 21:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4913C13A274;
	Thu, 25 Jan 2024 21:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="UQoJhyJQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EMBYf6Ma"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F194B1386DA
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 21:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706218297; cv=none; b=qLWuos5FjcIVhnEkDuyrea+roBwWc1VeJsnY3eXvGvv2DCJsPCoxxFDwvmPg02ctxiy4MK5v4wTkzBt8l4jFNnLZqGCzTjKj73C6IS/cbQx0XdjRCAM1p3ihJe6TnwahgsFOddjcjW60DBJvLN5Jljj7OBBrT58a/e5kVqTBlhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706218297; c=relaxed/simple;
	bh=vQGiJIvHRXOQUelYjUnBL21VWZ2w2m1t+iThIiH/q5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBea5Na+xzJKhLA/ByxxEqhE9M94Zcr4zaXvPLqp9Psr7jBIND5lPBM5wp9etVCN2evvxAwblCLRGLUaItAYz1FAfg4fRfEqaiEqQG6dcQ82E3C/2gCIa+bGLRuPvfodKHIKngt4Js1XW1nQwvEou6hjcsnYGSbNw5vCvDUNo08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=UQoJhyJQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EMBYf6Ma; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id D79BF5C00FC;
	Thu, 25 Jan 2024 16:31:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 25 Jan 2024 16:31:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1706218293; x=1706304693; bh=QeU8mCC8iP
	BpgQIak+DzwymuZ+IQIeHi8aTfmnKq7Ag=; b=UQoJhyJQaky/LJpxy4uqQqI2KF
	Wd1ZegJ61xwhjOmwPrTjlN7oreFkhxlvstFiA8O17oYSsCgxwkMl3rOQaYVNzonl
	Js1GsJMMOQqgikR815uFU5ii8ijC3p/CAg28tmw+J1S9fjH5yMwiLetBtT34XJxy
	7/7oyyS4rp1+ojENDvfkNq9UVttCeFAF0Dt8FXX+PTj2GKWkDzY3A9JJ/PMjUxuH
	8OSWglaVfKzTYflM77ZhwNggN/8DkCvoHklhyEkKF7bOrt6GGGjs56McV8OZ6B+I
	wJbcII5Q0tYOs0qGi5sKtwDcY0yayZHNoujVhp28faDxoKRwWbJEVUm42fdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706218293; x=1706304693; bh=QeU8mCC8iPBpgQIak+DzwymuZ+IQ
	IeHi8aTfmnKq7Ag=; b=EMBYf6MaqmaN4ThFdrwzAlwe7o8iL8Sefnn+zNmwGhDL
	hFmDNQOA0QcyYevbedzjTNNiMzst1WzQh/djsd2+Pg1kERprDAzWt3tSlcETk6kH
	Cp/xDQwJiH0b7GPw/aTYyH0yX4MjdnQOFw/N+WQAZ4Zz3ZlyvLXMLcZAfLjQOJYz
	DownWU0yq3BQrQ0yG2wHR8r59b3+Qz2csY9CKKhH0ZbWXjoKzjKgbjhs1P1KhzO7
	osAQxEK5+LTk8k8bYZdtTbC3fWQ0DmilS2fUFbXeb2r9jFRQdV+RO/gxW5RG+zqB
	37/Z0YDHOJj7+dWPaE80u633AgyCKiZmvcdGPwXgdw==
X-ME-Sender: <xms:NdOyZc-ntIyJriBb30xvKQ1rx7UdXtm8BZ-WyMKd1Ma9ZQ8dyD4Npw>
    <xme:NdOyZUuJebQ0yV0rL7gp9l-Opt64DRXzXBk8gP3xhAQRYpKH_eE04W4j_K9vmW7Lb
    4G5JNaEsVTXk4vfQ4g>
X-ME-Received: <xmr:NdOyZSAvnZtH8XranrZWfAQjR8qFdYDSpu_tdUmBe15Z8aFwTPkvaBL-Y_8ONQ03PRktrqWGeM-Qnwy9LRGmgPqiMvc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelhedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvve
    eiieeiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:NdOyZcc8p_CUWLqzY2BJr2BSlIj5_4TV5QFWhcXXOFu_cyxJs01e7A>
    <xmx:NdOyZRNvh40QAbE2Y_KcBiS2IiUg0OepY61WD1KUv6U_pzWsQDzHdg>
    <xmx:NdOyZWn531BlSFy3jXTui3Jn_GF5kDoGpVdyfI_5op-cCXnksYIz_w>
    <xmx:NdOyZTUQdYcH176nSmmmTibMHEh2J2v5yz3hZGYwx4vdw6_WOeM9BQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jan 2024 16:31:33 -0500 (EST)
Date: Thu, 25 Jan 2024 13:32:31 -0800
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] btrfs: some fixes around unused block deletion
Message-ID: <20240125213231.GA1851005@zen.localdomain>
References: <cover.1706177914.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1706177914.git.fdmanana@suse.com>

On Thu, Jan 25, 2024 at 10:26:23AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> These fix a couple issues regarding block group deletion, either deleting
> an unused block group when it shouldn't be deleted due to outstanding
> reservations relying on the block group, or unused block groups never
> getting deleted since they were created due to pessimistic space
> reservation and ended up never being used. More details on the change
> logs of each patch.
> 
> Filipe Manana (5):
>   btrfs: add and use helper to check if block group is used
>   btrfs: do not delete unused block group if it may be used soon
>   btrfs: add new unused block groups to the list of unused block groups
>   btrfs: document what the spinlock unused_bgs_lock protects
>   btrfs: add comment about list_is_singular() use at btrfs_delete_unused_bgs()
> 
>  fs/btrfs/block-group.c | 87 +++++++++++++++++++++++++++++++++++++++++-
>  fs/btrfs/block-group.h |  7 ++++
>  fs/btrfs/fs.h          |  3 ++
>  3 files changed, 95 insertions(+), 2 deletions(-)
> 
> -- 
> 2.40.1
> 

Reviewed-by: Boris Burkov <boris@bur.io>

