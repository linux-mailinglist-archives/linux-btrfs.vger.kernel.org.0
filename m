Return-Path: <linux-btrfs+bounces-2292-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1D984FF44
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 22:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4307028D238
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 21:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C6F210FA;
	Fri,  9 Feb 2024 21:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="X048DnKi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bWkf+NUy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC9E107AA
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Feb 2024 21:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707515565; cv=none; b=CYrSafn0nrC6fvm9lQTtYiWuv80hV/eA86hXrVYK93aMcbDxboQfEtNeCJT8NOen+drsOuYCkvCEgDu1p88SiqRUsZXkuR3buac25MCz5hf5zAkEux5SuTcbaZFgZECKLuUHgmIaI5iHTEf2zgTn3aAlMt3+vmnJuzLkFBkPSCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707515565; c=relaxed/simple;
	bh=QiNtaBeR0BqONQV5Tn7jwnj6w3m2v5imwNMHnr1ANe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4k8BmacAwrSiRcW076QEr36ElykKQc1ldfKu9AvbMxqVJllaKI889Ly9XKNqpZphqC4OHGHtUxj8qbl1EVXWSmlr9Smjm6plysuXfEdmp2uhuKRXx8mq8oNviQqJmlq9tZrUspd/pK8Cp4APKYgTuKK/XnZtZEowbnss9GAhYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=X048DnKi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bWkf+NUy; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 78B4332009FA;
	Fri,  9 Feb 2024 16:52:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 09 Feb 2024 16:52:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707515561; x=1707601961; bh=qVdE0jrzXz
	Eq5dHlcPWfUmiao5WNmugFG/BQDjbjuOk=; b=X048DnKi101IMLixI77cbOf4fU
	NqPgcMRNc1EKzhouIiJGfsQKhhI23IuHm6Q9b93XR/LAZ2vATxGSb5iSW+e3AOtN
	2LiOqgZrh1dqAVqMmp9FySVazzVd+TgCsSvPJJKhnvg0JfjjBQ+rLElFf0FPYk/7
	MiTp4fMzqojSpXgPZKz2Qhqme4nv6ydJsIdyTmUayT22tJ6btp5/KUcMLk3MrXyK
	/2H+dhMjdre0aqWSn92HoVHtAFr3aGFVyrGQAQQDwxrb0eZNAj0YiVjTqNoN+hRl
	s7ATjWx2Kdb7mz6VHEi81w/UK+CiuritNFZwrQ2JpI4e7Iy9YesXZqRlYV+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707515561; x=1707601961; bh=qVdE0jrzXzEq5dHlcPWfUmiao5WN
	mugFG/BQDjbjuOk=; b=bWkf+NUy70oLXtyKhGMz6fCwpEdHGe8FAAMcA+VPCHIj
	gQWqkkoiFdysIPY/C8qKZ1nSPrPlLpvsqpXNltHt5tvCyD6cqTBK7S837i7XYs1L
	SYKeInaAMrRbrTgfdBhIOCES1aQyP0AT/x7PbDktZoC9q4YAmD5e5sqDZSuQo33y
	K8ikKQzx1329gfzBhpdI05Ig1psoqDAG5LtG1yL3pWKk49YcBeHGlMhm+hlzaCdR
	4odhODilRYNwkbdkXogqa1R6hxTYoAB1FSbM5+I+8Zp4Ofsi7iSa+pPLx/MxhG0n
	ic1YKw9CnK/9DT3eTfX8A5ySY1dbORx6WPTXkRUJoQ==
X-ME-Sender: <xms:qJ7GZdSfk9ez-UxM5TLBwR0vfD5KHg8qrvsIm1JK2Qo9YWhUZuuXWw>
    <xme:qJ7GZWyh2eJo0g_mDiu9WOgDQ_sHOTz-NLbcLnQbv6xEHYeRs_OkeUs1tmR_SCQSB
    T9mfP2GmeDjgGsofoY>
X-ME-Received: <xmr:qJ7GZS0boYyPgTtEkAjhYtbi3drEfSrelHO5cHw21W7mV6-p7tr9353IEEsSVp2x5Kvmu4ps8h4-4psWDryRCFbGoM0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigdduhedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvve
    eiieeiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:qJ7GZVBsYvdjoyU8AiaAtxkNI3Wh6l4Yb6YOimra4jJGfNRtBfmMKg>
    <xmx:qJ7GZWjCOzjb_qjjr_sazoH5dMT33aHXrAPXyfhi97UAs_1fCElCZA>
    <xmx:qJ7GZZrS4YqpAcY2HyGyfx_VdvT7JiUyNaifEDxtHmItr5Ql2G4ahA>
    <xmx:qZ7GZeKQczlAo9xFOkWl_f1S5I7f9Lwcul2pgDEKCMjDiFznouu3bQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Feb 2024 16:52:40 -0500 (EST)
Date: Fri, 9 Feb 2024 13:54:24 -0800
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/9] btrfs: cleanups and minor performance change to
 setting/clearing delalloc
Message-ID: <20240209215424.GA149185@zen.localdomain>
References: <cover.1707491248.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707491248.git.fdmanana@suse.com>

On Fri, Feb 09, 2024 at 06:00:42PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Some cleanups and a minor performance improvement around setting and
> clearing delalloc ranges. More details in the changelogs.

These all LGTM.

If you want to hunt more wins to claim for the inode lock improvement,
you can also try running fsperf.

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Filipe Manana (9):
>   btrfs: stop passing root argument to btrfs_add_delalloc_inodes()
>   btrfs: stop passing root argument to __btrfs_del_delalloc_inode()
>   btrfs: assert root delalloc lock is held at __btrfs_del_delalloc_inode()
>   btrfs: rename btrfs_add_delalloc_inodes() to singular form
>   btrfs: reduce inode lock critical section when setting and clearing delalloc
>   btrfs: add lockdep assertion to remaining delalloc callbacks
>   btrfs: use assertion instead of BUG_ON when adding/removing to delalloc list
>   btrfs: remove do_list variable at btrfs_set_delalloc_extent()
>   btrfs: remove do_list variable at btrfs_clear_delalloc_extent()
> 
>  fs/btrfs/btrfs_inode.h |  3 +-
>  fs/btrfs/disk-io.c     |  2 +-
>  fs/btrfs/inode.c       | 93 ++++++++++++++++++++++++++----------------
>  3 files changed, 60 insertions(+), 38 deletions(-)
> 
> -- 
> 2.40.1
> 

