Return-Path: <linux-btrfs+bounces-5860-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3886E91149E
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2024 23:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6EC1F27BA2
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2024 21:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE927D086;
	Thu, 20 Jun 2024 21:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="MOrPfZse";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t7nH4+7f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52937B3FE
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2024 21:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718918939; cv=none; b=TE35KrqI4LHhSaz6OIkv+dqGP8gUuG1c/XLE9FDTFD8mxJsFgCBXna9RYwaPkJ4VpghbQmkdQ+D8vov3xGSTEOLAh77njJhGMapf9NToJ5hHgfSwjVlehp8ZGV/ErYfNrUEE91RcDenr2qYyXOa145Mm/00LzpdTE2SjavuPmgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718918939; c=relaxed/simple;
	bh=gncAxbv1Y6azzqqMkOdVQyxUR7mZ7ZEHlUKoi1lMgTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RL9g4rXQsi816nVz6FMLuizet2zkyt9QPufCCJkljpmMnSc85sdSOah9Ur6FpDEP437pkwG7dVNVtG6olJ/BOF00X5obPs8o3z0aCWTp3BerQsygcZEDaTSuoGEgNgmvF0BtHt267jmzpAFN9iehm/c167ikrcAmzGt2wap+Qws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=MOrPfZse; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t7nH4+7f; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id A23621C00111;
	Thu, 20 Jun 2024 17:28:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 20 Jun 2024 17:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1718918936; x=1719005336; bh=BZohooJRDq
	u9lXcf/yZd0pFL1ZZz3GxNCm0DgKJkkCc=; b=MOrPfZse9R6rKFm8Y0p8/vQofO
	Pr75nL3W0YYkp5eZ37reuhU2Ocq5rw6kXhFsnlvZrGpQABbrQgKVEVfXcLDmuNEe
	jSyWVV4tKblThAz0OkA7rrsDrOFWRtGwfgm4fOvYP42KsJdaeQxbQFyoncaZTxRo
	oMAXz6GsvvD8+J3P42Rq8kXPHtSSNmBNgjpQQhoFOA20EyNK7KLnaafn628IfYOq
	6nD+xylmQgXiSpbuGMtIQNCvelJlrRgdAe+tDQS79esLD+pkdnIWKCI1y/79bixe
	pFst0xC0krsrhqNKxKSyaouOTPufwlkRdev+ikP8X7or3Dl3JXZjdXvpB/Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1718918936; x=1719005336; bh=BZohooJRDqu9lXcf/yZd0pFL1ZZz
	3GxNCm0DgKJkkCc=; b=t7nH4+7fP2xv1zP4bzYcE2l6HQQVxm5DmTBxXdBsnpTr
	o2AGhuis9tR3hHyKXuCOlXmZ60cLopQ2Z5Ke7XRHNtybl6nJioCHFJlIUvPRrC5d
	AnEbKxdRmLgdEvjcZM+46WwQ+7vFsTHNReh5CnEdq6/6kytYwArcP+Fh4yEWir/z
	unazkIfcOjOXRVOITyMpcZNNcb1En0suUassxQywDRW0a3fW8wVZdiRb/+i2b9Pp
	qGyw5+G+2LQlSoQOME7zg2i2fiVVMZ9d9Ztzxd+nu/+DQCUCHyCt81QGvH1e/fiI
	SUjYPiyomaVHle5j4hMF+07PB1/rW6Bsen0/XLQevw==
X-ME-Sender: <xms:GJ90ZvLxbeZvHthAuPrEelT4GFLDaw8DUlJ0T_TGq-73jjzbUvAbuQ>
    <xme:GJ90ZjKMPRNLvb43NlGPMJirprz7aK6DU6lp6sIYa3L2g02BhUgLzeb_5qAly2E6h
    9ebsgzfkDkorBknE0Q>
X-ME-Received: <xmr:GJ90Znv1oQ5FqatY1Oeeh94FqvkLE8W8FBU7hxGuilM7bordoRNaeFaVmACHFPXyO6K1e7g8q42u1l6-gQnRhiYLxF4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefvddgudeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:GJ90ZoZzyflg4sV6tuD52VIwfA2z_cckn1KajDPFwVlntknEvLnsjQ>
    <xmx:GJ90ZmZYXEjfcm6iEAfLyI-waO7OBl3Ch9EwMul_QW4tY9KSEK0MYw>
    <xmx:GJ90ZsDjqzmFh8fMRkJgjHQGK4xvBgJZ7yxAB2Lpf2VhFpP8NIjubg>
    <xmx:GJ90ZkYKbOT0foBbMWFBU00foblWbOeQHlv2mCNBB3hmuGGloK_elA>
    <xmx:GJ90ZlnMV4zOSxS31dHOQyYNKA0cw7VB8deOcBXOf6DzO56LNy7j3P6Y>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jun 2024 17:28:55 -0400 (EDT)
Date: Thu, 20 Jun 2024 14:28:33 -0700
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/5] btrfs: qgroup: warn about inconsistent qgroups when
 relation update fails
Message-ID: <20240620212833.GB3251296@zen.localdomain>
References: <cover.1718816796.git.dsterba@suse.com>
 <913ab94d58070b19dee7aa6760a111c31be473a1.1718816796.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <913ab94d58070b19dee7aa6760a111c31be473a1.1718816796.git.dsterba@suse.com>

On Wed, Jun 19, 2024 at 07:09:20PM +0200, David Sterba wrote:
> Calling btrfs_handle_fs_error() after btrfs_run_qgroups() fails to
> update the qgroup status is probably not necessary, this would turn the
> filesystem to read-only. For the same reason aborting the transaction is
> also not a good option.
> 
> The state is left inconsistent and can be fixed by rescan, printing a
> warning should be sufficient. Return code reflects the status of
> adding/deleting the relation and if the transaction was ended properly.

A few thoughts/questions about this:

1. Why do we even need to btrfs_run_qgroups() here? Won't we btrfs_run_qgroups
in the transaction that actually commits the qgroup relation items? I'm
guessing some qgroup lookup sees the not-committed items in a way users
care about? Are we expecting such high-scale `qgroup assign` that we
can't just commit this txn and make it simpler?

2. Is this really failing in cases where adding the relation items
succeeds and then it all gets committed successfully? i.e., do you have
a reproducer for this case?

3. If this is a realistic scenario, I'm worried about the squotas case,
which doesn't have any rescan capability to fallback on. However, I
don't see why my (1) above doesn't just save us anyway. If we commit the
relation item, then we also commit the status/info items. And the txn
commit run_qgroups is not allowed to fail.

4. Let's say that 1. is not strictly essential, and the txn commit is
going to fix us. In that case, is it really accurate to say we are
inconsistent any more than just during a transaction before we run
qgroups? I suppose compared to the case where this succeeded, we are. I
just have a weird feeling we are stretching the meaning of inconsistent.
Though not in an egregious way or anything, as we are reporting a
non-fatal error?

Sorry for the slightly rambling review..

Thanks,
Boris

> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/ioctl.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 31c4aea8b93a..f893a6b711c6 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3877,8 +3877,9 @@ static long btrfs_ioctl_qgroup_assign(struct file *file, void __user *arg)
>  	err = btrfs_run_qgroups(trans);
>  	mutex_unlock(&fs_info->qgroup_ioctl_lock);
>  	if (err < 0)
> -		btrfs_handle_fs_error(fs_info, err,
> -				      "failed to update qgroup status and info");
> +		btrfs_warn(fs_info,
> +			   "qgroup status update failed after %s relation, marked as inconsistent",
> +			   sa->assign ? "adding" : "deleting");
>  	err = btrfs_end_transaction(trans);
>  	if (err && !ret)
>  		ret = err;
> -- 
> 2.45.0
> 

