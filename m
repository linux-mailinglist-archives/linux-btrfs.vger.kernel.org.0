Return-Path: <linux-btrfs+bounces-14416-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 720E9ACCC44
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 19:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C107116FB04
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 17:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002CA1C861B;
	Tue,  3 Jun 2025 17:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="LHrr1d7B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oe0Fbeyx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D191C84CB
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748972083; cv=none; b=RfE8yZrtqpcHp4mguJv+RvdEQGA2xSxcY7wwQZ1Nlhw0IqwhsBTtOO6grFf+NTvcaufd8Wnr45GrZGleDWaauopWhsgbAHJfRgkYuoRNuuC242EAgIR6Dgh4FI8eTRjRokfiFyRmREmRokI58cqRLXyAPLpMmYOB7oZppmcA4xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748972083; c=relaxed/simple;
	bh=4hhMFhvjzzzo+6ElxoJujpV9BWp0SGail5R9GZRYv60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkQNuuyJYNgZQ4pPncEOW+BCMq2ltXYkBxqtV9xWY3/8Uccd7k/sM+m6DlbwBoQ72phQBb66tsQX9tR29nhB6H1h6M/OnM7KloMmuq48At+EfE2bYI+wVAVkdZ1A4nY0O+/XHxZ8UIgYaHNXgGf+WqHKD4Budh/HlEHjHNdhIh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=LHrr1d7B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oe0Fbeyx; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 1E338138034E;
	Tue,  3 Jun 2025 13:34:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 03 Jun 2025 13:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1748972080; x=1749058480; bh=0CmEvQW0OK
	uk7Sv97RoI8DAqGrfAFgbrcd3xrKoVoAw=; b=LHrr1d7BRicc6Tn8t87jx43odl
	YACQlaWzRQdSepL7FAPNJ1bP3q4WmGzqV6p2baLKA8j/pTCFRMujIC2Zp4YlC0AK
	5rxZa6dBk4zEv2Gcs1XTBpDkTPmvcx1VMYvlPPCvPV5oJsNtulBApDpjHDz34Lnr
	yrQz8wYidye9SpwbyRsM6C2TQCXOW/U80U3Ukr6N29f2nIhrM9BzZu3YNaK13uhJ
	MA4k+m8WE1Ey82esv5gssy6FZVaTIb9qubPpS01iNl1vMWDFShn6U35MAVBv7JB1
	PPs+5KoqxunS+cUu2yNKzquYlzhZQkTfzg0xHcVYavds1erdfkAVkXWrwKBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748972080; x=1749058480; bh=0CmEvQW0OKuk7Sv97RoI8DAqGrfAFgbrcd3
	xrKoVoAw=; b=oe0Fbeyx6hfYPkrqAcSKNHSFVAL1BEO3la8ZZur30RRxfuy9XM8
	O5dEG38YI6MgT8A2vy0feOp7EDENnstaaJQd0x3/UngBjc7qB4pGWDpAsztDm+rJ
	F6yRHfdCGLKRbo+1L4pxspT1wYZ2fn34rYWE++oVdyNtUPRaghrXY2IQjJxt2AOA
	6qEJ7tcns8PvfegeNnFsHytS4xf/tJYMGSqfa93/YrThShViA4tTQOkVyzGXu+w2
	okgzyEF35nq442TIrJkIeZyCA/9aOacyq3gkYnwFnqMK3RoIbmk94eb4oSGJtNr0
	G2cyCj8JrmCjqLGSwfn5K6Pc9nA4/4hNslA==
X-ME-Sender: <xms:LzI_aEVCfn6DH6XuuqN0rWOT15bmEuNcUVfvC_m6SawJ3ZFhTl8GEw>
    <xme:LzI_aIlR3oDLHgrajHOBXjrg0DuWF5C_KPwhEUAQJUqElLFoawUQLe7HnmeL-exA3
    Cx4V64oqpCsWfniOtU>
X-ME-Received: <xmr:LzI_aIYllovpW8w2tU-u-1XQiPeDEPvjJi4a-Uk_3GVLIAG-mfrvJwGuD27ys6TxOYcx5ytEYVoJzxJNRa7hbrSOk-Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceo
    sghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvdekffejleelhfevhe
    dvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhgumhgrnhgr
    nhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LzI_aDXKD2UVHfRMng4aC5tZiPLwI0q3Yw7OXTjqCaTM90_rrd-qCQ>
    <xmx:LzI_aOl6hNLl7Zq3hdJIWnl17owtJaGT6NPfBsz2_KCHgDzpmvTn3w>
    <xmx:LzI_aIdHiIYGjpwzSVrTnCHXxgXb0sUsun3fZ0O8xEkFV70-AOYKzA>
    <xmx:LzI_aAFQWy13kQqpq21PXNRBL2EYrSaCmspLIq7MkplATgZhvo87ag>
    <xmx:MDI_aKzNPXV5UBoBQzigBI2zjbj8BBhkUafm831f_TeAHf6ESF0xV3Eo>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 13:34:39 -0400 (EDT)
Date: Tue, 3 Jun 2025 10:34:37 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/14] btrfs: directory logging bug fix and several
 updates
Message-ID: <20250603173437.GB2599675@zen.localdomain>
References: <cover.1748789125.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748789125.git.fdmanana@suse.com>

On Mon, Jun 02, 2025 at 11:32:53AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> These fix a race between renames and directory logging and several cleanups
> and small optimizations. Details in the change logs.

These all LGTM, thanks!
Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Filipe Manana (14):
>   btrfs: fix a race between renames and directory logging
>   btrfs: assert we join log transaction at btrfs_del_inode_ref_in_log()
>   btrfs: free path sooner at __btrfs_unlink_inode()
>   btrfs: use btrfs_del_item() at del_logged_dentry()
>   btrfs: assert we join log transaction at btrfs_del_dir_entries_in_log()
>   btrfs: allocate path earlier at btrfs_del_dir_entries_in_log()
>   btrfs: allocate path earlier at btrfs_log_new_name()
>   btrfs: allocate scratch eb earlier at btrfs_log_new_name()
>   btrfs: pass NULL index to btrfs_del_inode_ref() where not needed
>   btrfs: switch del_all argument of replay_dir_deletes() from int to bool
>   btrfs: make btrfs_delete_delayed_insertion_item() return a boolean
>   btrfs: add details to error messages at btrfs_delete_delayed_dir_index()
>   btrfs: make btrfs_should_delete_dir_index() return a bool instead
>   btrfs: make btrfs_readdir_delayed_dir_index() return a bool instead
> 
>  fs/btrfs/delayed-inode.c |  42 +++++++-------
>  fs/btrfs/delayed-inode.h |   7 +--
>  fs/btrfs/inode.c         | 119 ++++++++++++++++++++++++++-------------
>  fs/btrfs/tree-log.c      |  72 ++++++++++++-----------
>  4 files changed, 144 insertions(+), 96 deletions(-)
> 
> -- 
> 2.47.2
> 

