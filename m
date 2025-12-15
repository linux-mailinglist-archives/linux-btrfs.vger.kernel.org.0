Return-Path: <linux-btrfs+bounces-19758-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C37CCBF7B6
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 20:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E52F93011418
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 19:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DED3313E0F;
	Mon, 15 Dec 2025 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ztG3Q+5f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5rJgyfjb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ztG3Q+5f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5rJgyfjb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D69130DD22
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765825674; cv=none; b=epais4kpR29gStRvaLQC2n1k6vXpPtRj0hdpnGdhQGQstYe83/G5FacZNMYPADJkVGpFf3Bv+Q8e1uQeRAa7ZH5gdNG9pKbh3Gxlpbd/aD+tt1lzzjmU72LoyCmsdeYq/Wm8AedPK+qWRksy4NnPiTH9ogTA0vDgQX1S3RvzBN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765825674; c=relaxed/simple;
	bh=hOA1vlo9vtX2Ey3k327Q5Nv/9hSIpU3I2fyvC3gE1d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJA3QqqmWqVhplywJqHGLMO4EzoKoVkN1+ipCyUMfoRC/f8OxHRnf5S2XpTYUe3o8bOsMIJM+YYOj3OsSJHr+40x2E4P6DTDAH5sFN+CL2LCeDLui5amjSita7LETYFu2RPsJ/FiMBnsUM3+OINuofK+ytC/6CLwpPzwdovOH7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ztG3Q+5f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5rJgyfjb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ztG3Q+5f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5rJgyfjb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4E651336F9;
	Mon, 15 Dec 2025 19:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765825671;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3qy4qI2kvAG9/3l2cWWA6svrgM0RUrA7tJiuhD7+Cq0=;
	b=ztG3Q+5fQ8Rfd3jcB85bSw+bTnnWLsmgzn/xEkhgTn7+Rya5G0DoBOePEEZRLKgnl5s+U8
	QlEy4w2170ZkmsTrtFt9q/qU0KGlNVdIyps+HgfDjPFDwYeTwlxuXlNQCVL+e59sCNECEA
	F3ZxaBn2UqVBkSWLZ3SsstSujlEplik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765825671;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3qy4qI2kvAG9/3l2cWWA6svrgM0RUrA7tJiuhD7+Cq0=;
	b=5rJgyfjbm4pOsLVNStKdqMc2DggpPB1+d3PE+ZQ9win530i/B968G28AEDbrrIQPV1uD/L
	A++C7tz4e9MKdrBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765825671;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3qy4qI2kvAG9/3l2cWWA6svrgM0RUrA7tJiuhD7+Cq0=;
	b=ztG3Q+5fQ8Rfd3jcB85bSw+bTnnWLsmgzn/xEkhgTn7+Rya5G0DoBOePEEZRLKgnl5s+U8
	QlEy4w2170ZkmsTrtFt9q/qU0KGlNVdIyps+HgfDjPFDwYeTwlxuXlNQCVL+e59sCNECEA
	F3ZxaBn2UqVBkSWLZ3SsstSujlEplik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765825671;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3qy4qI2kvAG9/3l2cWWA6svrgM0RUrA7tJiuhD7+Cq0=;
	b=5rJgyfjbm4pOsLVNStKdqMc2DggpPB1+d3PE+ZQ9win530i/B968G28AEDbrrIQPV1uD/L
	A++C7tz4e9MKdrBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F6583EA63;
	Mon, 15 Dec 2025 19:07:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l+F5B4dcQGkiGwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 15 Dec 2025 19:07:51 +0000
Date: Mon, 15 Dec 2025 20:07:49 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: add an ASSERT() to catch ordered extents with
 incorrect csums
Message-ID: <20251215190749.GH3195@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b9ce1fd6cf3ef17a4d4b24a71d51792c6979fe68.1765744373.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9ce1fd6cf3ef17a4d4b24a71d51792c6979fe68.1765744373.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -3.93
X-Spam-Level: 
X-Spamd-Result: default: False [-3.93 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.13)[-0.630];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]

On Mon, Dec 15, 2025 at 07:03:17AM +1030, Qu Wenruo wrote:
> Inspired by recent bug fix like 18de34daa7c6 ("btrfs: truncate ordered
> extent when skipping writeback past i_size"), and the patch "btrfs: fix
> beyond-EOF write handling", if we can catch ordered extents with
> incorrect checksums, the above bugs will be caught much easier.
> 
> Introduce the following extra checks for an ordered extent at
> btrfs_finish_one_ordered(), before inserting an file extent item:
> 
> - Skip data reloc inodes first
>   A data reloc inode represents a block group during relocation, which
>   can have ranges that have csum but some without.
>   So we can not easily check them.
> 
> - NODATACOW OEs, NODATASUM inodes must have no csums
>   NODATACOW implies NODATASUM, and it's pretty obvious that NODATASUM
>   inode should not have ordered extents with csums.
> 
> - Compressed file extents must have csum covering the on-disk range
>   Even if a compressed file extents is truncated, the csum is calculated
>   using the on-disk extent, thus the csum must still cover the on-disk
>   length.
> 
> - Truncated regular file extents must have csum for the truncated length
> 
> - The remaining regular file extents must have csum for the whole length
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v3:
> - Fix a compiler warning when CONFIG_BTRFS_ASSERT is not selected
>   By hiding the oe_csum_bytes() and the main part of assert_oe_csums()
>   behind that config.
> 
> v2:
> - Updated to check all possible combinations
>   Previously version can only detect the OEs in patch "btrfs: fix
>   beyond-EOF write handling" where the OE has no csum at all, but can
>   not detect OEs that has partial csums.
> ---
>  fs/btrfs/inode.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 461725c8ccd7..28227d43b082 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3090,6 +3090,72 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
>  					   update_inode_bytes, oe->qgroup_rsv);
>  }
>  
> +#ifdef CONFIG_BTRFS_ASSERT
> +static u64 oe_csum_bytes(struct btrfs_ordered_extent *oe)

For function names please use 'ordered extent' so it's more descriptive,
'oe' is ok for variables. Or eventually 'ordered' as this is common
elsewhere.

> +{
> +	struct btrfs_ordered_sum *sum;
> +	u64 ret = 0;
> +
> +	list_for_each_entry(sum, &oe->list, list)
> +		ret += sum->len;
> +	return ret;
> +}
> +#endif

