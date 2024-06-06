Return-Path: <linux-btrfs+bounces-5507-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1639A8FF523
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 21:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58464B229A1
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 19:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2584F1F2;
	Thu,  6 Jun 2024 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="hGlWeTOf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TPO10sQL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80034376E1
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2024 19:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717700799; cv=none; b=K5NrqtQRm8qveNWpkDJnawuuO6wdN3mkPJQx954HWqNnhKGcAHzjS6DCXcWEByPxbww7OidhlJUb427xJwQxphqVXXUm/OjmPgqG5DNUSAzzysgsYTuTH7ayPa6iwOpXWOOnEY2HB1h5EZjwCD5pLDjkP8su3LDF9Cp+geRA/E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717700799; c=relaxed/simple;
	bh=xrpWa24KiIq6A8tEJdE4O9vMCuIJhRmc366SkACpRc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClBoZCGNRNTHmUg1BxmZGbADPQwUCeCS+I4P419U/8HirVQPDXCaup2a6TJCj39U71OogWLUu5BpPLepsC2otPDNPiFMyZ8Aq34rkcMYS0e3qzGSHB9eUo6t8S+k/G9NIwTbtuXVNHn+ToUrNkO95IAOL6hcsf4jbYUudHcr2H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=hGlWeTOf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TPO10sQL; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7B4AB114014F;
	Thu,  6 Jun 2024 15:06:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 06 Jun 2024 15:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1717700796; x=1717787196; bh=hDi6aX8/FH
	W/yfiXWhgmroW5RXBKLCiZnIbg8PV/VJQ=; b=hGlWeTOfk9dNzkoZBLJxRtw7Tb
	+U2SfDLXklinq5ETgmKG/BmAjmnZDg63JMwKHp6xvsh/AKNljYHAyyFhmQ84h/cN
	r5jBxa1aS7D5DO65HkeFbyoyX86jt3hqQZ8TSZosx66P04AnM/b1py2K+LKS3rwE
	xfv8osvUgJw3fHdtCWALyutgWEBrPld9cZMJHU4829L6yOPfBXlOhtFvJgzynfXC
	eyrZkCYU903khfQpCGFUZD9zSgM/COQRfD+4HWcNSM1F+ucf7WXMTkmFLmjsGRcM
	JdWqhRLPUljPTch5t59u4SbPGzGGr6C0Wnmu6+aJFxrzYnKjpfma4568Vrfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717700796; x=1717787196; bh=hDi6aX8/FHW/yfiXWhgmroW5RXBK
	LCiZnIbg8PV/VJQ=; b=TPO10sQLNw7n++3WvL83F9OFEqaPaI1zgs2CF9HUE+KJ
	Gc0cXrfvSkkP0bo+xYxbFQzynvG+EGYxhuOtfMsBDZKK+IGxHk5cgiic9+68FH6p
	vJMaw5/HvoUOPcf85vCaPYb7Dnb7CBg79AghVt9pgefVY6jpn7jxk2K72ou+H2vY
	mYLVgP75udEULSnsrnwedXR1+RM3HCWx0weA3Z+kyknXoE0hqxaatZnV43aOCrmS
	QFwW9PdKQIh900dKRc9DGp0cfpe3+Nu002cWRXDnTY1tj0yGPI20DT4bp0JsdfUt
	ULYyx3Zd6woDV+v3oAEIBqqT25ZMVgNvhCf76u6nJw==
X-ME-Sender: <xms:vAhiZp0th-gWIyHCiw69mkG71xO6owMIPgBvlEH5ZsDlG8yzJr8ALA>
    <xme:vAhiZgGWO-_PYLT1pR17yYcv76LierCuSWuHC-lgoFV0Qn0O7t1r41I61kmXYjaYM
    Uzi6f964VaK5wsnjkM>
X-ME-Received: <xmr:vAhiZp4ccINJF5QdTQ_h2N0Xvoho6JaDSD99_SpMBL9Da4jp7a7nY8Zza4-Rk6iLvd-cFZ3pFCDxdJ0aX_XKToMoDqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesth
    dtredttddtvdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghu
    rhdrihhoqeenucggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvd
    evieeiiedugfeugfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:vAhiZm2P_VrurHpOVpw5LEEqDCe316AViEep-81VV0Ty4CKOJ3WUow>
    <xmx:vAhiZsHDkYfoVe35_LcozpNyVMwPbzASk3llrTxSgUk1YnpRzG6nBg>
    <xmx:vAhiZn9bwgPrKbmNwB7IBG9FB776_kFk76pMSqDn14QbVGahzeOLzw>
    <xmx:vAhiZpmgpiVkGlyZD1aHDxUnQiMMYXhM4wG8_MjTaoKK7qQicW5cBw>
    <xmx:vAhiZhQoD-npBC8QgB9MV7TawnfX86QIETLCeldOmVrvbEeQmptY9Amf>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 15:06:35 -0400 (EDT)
Date: Thu, 6 Jun 2024 12:06:33 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove pointless code when creating and deleting
 a subvolume
Message-ID: <20240606190633.GA11027@zen.localdomain>
References: <292b2e90e9a64cd3156b0545f6e62b253ea17b9e.1717662443.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <292b2e90e9a64cd3156b0545f6e62b253ea17b9e.1717662443.git.fdmanana@suse.com>

On Thu, Jun 06, 2024 at 09:30:07AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When creating and deleting a subvolume, after starting a transaction we
> are explicitly calling btrfs_record_root_in_trans() for the root which we
> passed to btrfs_start_transaction(). This is pointless because at
> transaction.c:start_transaction() we end up doing that call, regardless
> of whether we actually start a new transaction or join an existing one,
> and if we were not it would mean the root item of that root would not
> be updated in the root tree when committing the transaction, leading to
> problems easy to spot with fstests for example.
> 
> Remove these redundant calls. They were introduced with commit
> 74e97958121a ("btrfs: qgroup: fix qgroup prealloc rsv leak in subvolume
> operations").

Re-reading it now, I agree that start_transaction will ensure what we need,
and if it fails we go to paths that result in freeing the reserved space
here in the subvolume code.

With that said, I spent like two weeks on this battling generic/269 so
there might be something subtle that I'm forgetting and didn't explain
well enough in the patch. Reading it now, I do think it's most likely
that the fixes to the release path were sufficient to fix the bug.

Just to be safe, can you run generic/269 with squotas turned on via mkfs
~10 times? It usually reproduced for me in 5-10 runs, so if it's not too
much bother, maybe 20 to be really safe.

Thanks,
Boris

> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/inode.c | 5 -----
>  fs/btrfs/ioctl.c | 3 ---
>  2 files changed, 8 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 0610b9fa6fae..ddf96c4cc858 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4552,11 +4552,6 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
>  		ret = PTR_ERR(trans);
>  		goto out_release;
>  	}
> -	ret = btrfs_record_root_in_trans(trans, root);
> -	if (ret) {
> -		btrfs_abort_transaction(trans, ret);
> -		goto out_end_trans;
> -	}
>  	btrfs_qgroup_convert_reserved_meta(root, qgroup_reserved);
>  	qgroup_reserved = 0;
>  	trans->block_rsv = &block_rsv;
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 5e3cb0210869..d00d49338ecb 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -658,9 +658,6 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
>  		ret = PTR_ERR(trans);
>  		goto out_release_rsv;
>  	}
> -	ret = btrfs_record_root_in_trans(trans, BTRFS_I(dir)->root);
> -	if (ret)
> -		goto out;
>  	btrfs_qgroup_convert_reserved_meta(root, qgroup_reserved);
>  	qgroup_reserved = 0;
>  	trans->block_rsv = &block_rsv;
> -- 
> 2.43.0
> 

