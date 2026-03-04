Return-Path: <linux-btrfs+bounces-22235-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FAZICmuqGmfwQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22235-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 23:11:53 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E9F208580
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 23:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3079230263F7
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2026 22:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A4137C90D;
	Wed,  4 Mar 2026 22:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="e9JyDRxc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t0qpJCni"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3248F219FC
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Mar 2026 22:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772662267; cv=none; b=k0VLweHRxNdeak/UacSqoVenbkISdxfMRhN/VL1jyJ78K2oEHGU+GcDQYqhidj0oEd56Q6ljGk2dl8h0qiphfQm/1J3VPRNAxd/xQODNGhy+9+GglwyOd4aJW4fSVn5pXB7pvhDMN/5UJUKsPsdlCSIfEFSK/+ajdeVySKlDimw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772662267; c=relaxed/simple;
	bh=amFBrGGkeFa6moI+WHngjBB4RbAqxW1V604llmNACpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avp/8M9sgLm/wEHN/rgBeXad0ZRMNDCuChnQqGtpi6eb1SosZG1GZM/lhq1fsSU4AoF8SzG9juDbOYe4NKDqypxKEw6NMfpQ7XtxouitVGAKdAqdS4wxF1GE5kd+tqTwG0ssm1IP3AVSpWanP965B44YT5yjBWap0qfrET2btkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=e9JyDRxc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t0qpJCni; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 9F7BF1D0018A;
	Wed,  4 Mar 2026 17:11:05 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 04 Mar 2026 17:11:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772662265; x=1772748665; bh=K40Kal2F8i
	3ey6YPgNvJd5Fa+Rz+6ebGPj2TrYk3/EQ=; b=e9JyDRxcmBzqriQ2PYZisY6E3J
	NsricW8e6CXxxHLpZikOiKO3I2i2FkHi2T2KfGXRcDDUAEtfuMYUEjsPIKDppSjK
	E2vKrjWRCwPE3omxceCH6yMOUTia+CKZcRGH07soQzWpzbUJTd4HHv1PhzKioDem
	7VPE2ul9jhOW/Iaqp4fcDnlfx9hy6bNGiPi2iJF2u12TFidtKJkkkhOXBYP3ZKFG
	EyP7VL3U3dJcEF3RkMg0luwO3DSaaFST/zVEcrU/B36gkDd+bpIdXM62GwLzVKeJ
	fsrNPLk2qGvLFSHHFTnBuE+7rSO7k125n5eIMDfp43i2be2isvi4YCOPg65Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772662265; x=1772748665; bh=K40Kal2F8i3ey6YPgNvJd5Fa+Rz+6ebGPj2
	TrYk3/EQ=; b=t0qpJCnir5NaWDDlWHv3cv7hfaPlmsPiWUm2eoL3UhCgRSV44s2
	f4d4BL9g3khdtK6UH+PEKTcMoqOVd+ZhfHynLM1OMcp85qKzv3C6NGZJrwWN3pOK
	LdVbIK52SBTNpilEa9KaBShqw2APvNhrPUB+aXG0aF57i0C21E/2JilV2Nh7LpCx
	c/L64xhJX4yK9sRWFCvIb/7K5SVr1PL4DxfsyeO3FnxpBwtJRIQdXnuwsiRLGM6N
	u4G/c1jP3mEoqUCxRLHtEpp10BXcu35Mmy5gxgxFYIXXzGzGD+qNMafgE0yeyaib
	GXx1KW3PB4nv+kevHK98/ra0Y30Qh3Cp48A==
X-ME-Sender: <xms:-a2oaWqUB7MNcikRaZKticcJVQRtozOT8CT2StzpA1MGSVhqPi3kwQ>
    <xme:-a2oaaoM3Z8qhy0PtMv4FcENeH4pVUWjy_vFFJRIEa-pwWPGhYCF-8QClgBVqTGor
    w3VG0tMVb8T9IQlaHypKkeDqmsxSi_J4_4SjduLOM-NZG8BSbIbmg>
X-ME-Received: <xmr:-a2oaY0WgPcCALQUpdRPDf3TK3Cbt1_pmTipt7LZy9CSWo1k6TQXyB3-LY2VG6olqXflLUqUTppJAc_9E6Oc4PUxp6I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieegieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhephedthfevgffhtdevgffhlefhgfeuueegtdevudeihe
    eiheetleeghedvfeegfeegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfhgumhgrnhgrnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    gsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:-a2oaRCRoq0K2SvgCe8i2gqkSXz-xGxLnIcWJoQbPZ3tXyTEB4I3Lg>
    <xmx:-a2oaYehEoHmx-FGcHlSFMt94BHVI-giW9v6wG0qBBAZEu7lV76tAw>
    <xmx:-a2oaej7GUpNB1s6FLg7vNWgBSk67EmcENEskiFV0J0Oe1H3RIImjA>
    <xmx:-a2oaYpk1yrYmHk8WIYbHp1OSd6I-nGqwRM4EiuvYJjGI8vJ6RLymA>
    <xmx:-a2oaafeI4RwnrynU1HYSpK3ZsBo3wh01vciui7q85llfjg64YXu86mO>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 17:11:04 -0500 (EST)
Date: Wed, 4 Mar 2026 14:11:46 -0800
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: log new dentries when logging parent dir of a
 conflicting inode
Message-ID: <20260304221146.GB1470643@zen.localdomain>
References: <9a367f025abf4ea19c96aead75d206e129b2c56e.1772558089.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a367f025abf4ea19c96aead75d206e129b2c56e.1772558089.git.fdmanana@suse.com>
X-Rspamd-Queue-Id: A1E9F208580
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-22235-lists,linux-btrfs=lfdr.de];
	DMARC_NA(0.00)[bur.io];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,zen.localdomain:mid,bur.io:dkim,bur.io:email]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 05:19:48PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we log the parent directory of a conflicting inode, we are not logging
> the new dentries of the directory, so when we finish we have the parent
> directory's inode marked as logged but we did not log its new dentries.
> As a consequence if the parent directory is explicitly fsynced later and
> it does not have any new changes since we logged it, the fsync is a no-op
> and after a power failure the new dentries are missing.
> 
> Example scenario:
> 
>  $ mkdir foo
> 
>  $ sync
> 
>  $rmdir foo
> 
>  $ mkdir dir1
>  $ mkdir dir2
> 
>  # A file with the same name and parent as the directory we just deleted
>  # and was persisted in a past transaction. So the deleted directory's
>  # inode is a conflicting inode of this new file's inode.
>  $ touch foo
> 
>  $ ln foo dir2/link
> 
>  # The fsync on dir2 will log the parent directory (".") because the
>  # conflicting inode (deleted directory) does not exists anymore, but it
>  # it does not log its new dentries (dir1).
>  $ xfs_io -c "fsync" dir2
> 
>  # This fsync on the parent directory is no-op, since the previous fsync
>  # logged it (but without logging its new dentries).
>  $ xfs_io -c "fsync" .
> 
>  <power failure>
> 
>  # After log replay dir1 is missing.
> 
> Fix this by ensuring we log new dir dentries whenever we log the parent
> directory of a no longer existing conflicting inode.
> 
> A test case for fstests will follow soon.
> 
> Reported-by: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/182055fa-e9ce-4089-9f5f-4b8a23e8dd91@gmail.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/tree-log.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index e011786cbd94..af8de67d1304 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -6246,6 +6246,7 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
>  				  struct btrfs_root *root,
>  				  struct btrfs_log_ctx *ctx)
>  {
> +	const bool orig_log_new_dentries = ctx->log_new_dentries;
>  	int ret = 0;
>  
>  	/*
> @@ -6307,7 +6308,11 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
>  			 * dir index key range logged for the directory. So we
>  			 * must make sure the deletion is recorded.
>  			 */
> +			ctx->log_new_dentries = false;
>  			ret = btrfs_log_inode(trans, inode, LOG_INODE_ALL, ctx);
> +			if (!ret && ctx->log_new_dentries)
> +				ret = log_new_dir_dentries(trans, inode, ctx);
> +
>  			btrfs_add_delayed_iput(inode);
>  			if (ret)
>  				break;
> @@ -6342,6 +6347,7 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
>  			break;
>  	}
>  
> +	ctx->log_new_dentries = orig_log_new_dentries;
>  	ctx->logging_conflict_inodes = false;
>  	if (ret)
>  		free_conflicting_inodes(ctx);
> -- 
> 2.47.2
> 

