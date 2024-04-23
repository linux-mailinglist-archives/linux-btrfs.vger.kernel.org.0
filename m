Return-Path: <linux-btrfs+bounces-4489-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D478AE423
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 13:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25567B24136
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 11:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF06B7D3E3;
	Tue, 23 Apr 2024 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MF9pynD+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aXvRC83p";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sUNnuF5Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BdIVxqHM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F58E8004B
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Apr 2024 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872021; cv=none; b=Zjb77kumzrePxRS7OAdmsLN+lOto62U+9RePA1uOfX83TEeI70cKTZKxHZvZiGzkq1/MEMtHrWSDm6rlC3tCQPQ5m47kotuvRqpT/+pJWHAfks5obsu/5UtN4kXQn7XBeFPeVQ/LPxQgr74ZM94gzyGVlzsEyTz6SkDGY/9YN4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872021; c=relaxed/simple;
	bh=QoagDf6rwXrXoWCKJNGspWts3Rs6miufs6BAxz0x9vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUBYOTMbIVnaTzNqV01tqo0JssvIU76Gto9qCtAWWoVYpBP1+Mv4gm+HeCM1ZjKExxiH5js3AOS+yCiHJRhLy0JYz7hUhS5A791J8RW7B3/Zt6AlB6M5Q8st2VaZWG5kF5XOKbtOts5FDfGe8k4BLrLQm/KDst97Z/cr/nSgFY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MF9pynD+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aXvRC83p; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sUNnuF5Z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BdIVxqHM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 224865FDE4;
	Tue, 23 Apr 2024 11:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713872015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2RDzzjHOlmRMNOyr4Yk5ld2I1hjh7uIs3YECahSqer0=;
	b=MF9pynD+pCO2jg3aZ2lgidRvScyLI1GdmmP3E/wqONxuy4eZdrIjSEuJE/mShqAMDDlorq
	yxYEXaRFZpC05JgEXrvyQs7c4q+qb/JGq5SjZi0LjcAD38T/9gz0+GS2W7q5BiqXFSSQMY
	vN+0DrISBSWvORoUT9TCIKGCfgXzEsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713872015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2RDzzjHOlmRMNOyr4Yk5ld2I1hjh7uIs3YECahSqer0=;
	b=aXvRC83pT3cylXRt1316wtPBcjnwQsrHr0XV2QmtVWkUdlYVcI3FT+hgcbYsaR5HsdkDg6
	NppNIf/td2aprdDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713872014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2RDzzjHOlmRMNOyr4Yk5ld2I1hjh7uIs3YECahSqer0=;
	b=sUNnuF5Z/uesRfO6twaWWoXhdhWvr/5TFUQtardgujzEcfRS/w47KxVe53oGCN7Vg9pdc8
	n+JXRvyjRIM6y4mQRPZtf5VjCQjVBn66oIweap4XVt4wZEouUKAt7RaxYrKciOepSAiBxm
	9nLSzAkOdCkt3znTVkYNXXGbLMH3SQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713872014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2RDzzjHOlmRMNOyr4Yk5ld2I1hjh7uIs3YECahSqer0=;
	b=BdIVxqHM0SHJDxKQ0/tUf88rCn8cxWW7la9CZuCtMRFhAP52k+ZB53PnUYYdw8dCMMJWVN
	oXaq+oYVS5dClTBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1515913929;
	Tue, 23 Apr 2024 11:33:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iE03BI6cJ2ZYQwAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Tue, 23 Apr 2024 11:33:34 +0000
Date: Tue, 23 Apr 2024 06:33:25 -0500
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 07/17] btrfs: push extent lock into run_delalloc_nocow
Message-ID: <2dqiyvawsd6g3zxtfhgcmyv7i257l2hhgrd2zcpl3yumugbcnz@twvnaux5ahe6>
References: <cover.1713363472.git.josef@toxicpanda.com>
 <60f8e6362e50086d796d8cdd44031d9496398b08.1713363472.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60f8e6362e50086d796d8cdd44031d9496398b08.1713363472.git.josef@toxicpanda.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,toxicpanda.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On 10:35 17/04, Josef Bacik wrote:
> run_delalloc_nocow is a bit special as it walks through the file extents
> for the inode and determines what it can nocow and what it can't.  This
> is the more complicated area for extent locking, so start with this
> function.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>


> ---
>  fs/btrfs/inode.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 2083005f2828..f14b3cecce47 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1977,6 +1977,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>  	 */
>  	ASSERT(!btrfs_is_zoned(fs_info) || btrfs_is_data_reloc_root(root));
>  
> +	lock_extent(&inode->io_tree, start, end, NULL);
> +
>  	path = btrfs_alloc_path();
>  	if (!path) {
>  		ret = -ENOMEM;
> @@ -2249,11 +2251,6 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
>  	const bool zoned = btrfs_is_zoned(inode->root->fs_info);
>  	int ret;
>  
> -	/*
> -	 * We're unlocked by the different fill functions below.
> -	 */
> -	lock_extent(&inode->io_tree, start, end, NULL);
> -

So, you are adding this hunk in the previous patch and (re)moving it here.
Do you think it would be better to merge this with the previous patch?

>  	/*
>  	 * The range must cover part of the @locked_page, or a return of 1
>  	 * can confuse the caller.
> @@ -2266,6 +2263,11 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
>  		goto out;
>  	}
>  
> +	/*
> +	 * We're unlocked by the different fill functions below.
> +	 */
> +	lock_extent(&inode->io_tree, start, end, NULL);
> +
>  	if (btrfs_inode_can_compress(inode) &&
>  	    inode_need_compress(inode, start, end) &&
>  	    run_delalloc_compressed(inode, locked_page, start, end, wbc))
> -- 
> 2.43.0
> 
> 

-- 
Goldwyn

