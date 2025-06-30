Return-Path: <linux-btrfs+bounces-15121-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E85DAEE524
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 19:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01B73B3982
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 17:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E38828DEEE;
	Mon, 30 Jun 2025 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rg3mkczG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mN1+BR1R";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rg3mkczG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mN1+BR1R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC8A2571C7
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751302889; cv=none; b=dWgrq45SQ7J1q7v2BPm0Lls5kRuwhyOWopKq5kedcJ7kMkXM3vMN1gV03eVx32ZpC+UBR0XZ5ZRbNETgmYDqPCtn/AEfjIu1d2y53BkvCzVBZmbyoyhP4ssgjrqKMQtub49pTK8zIrMXleIjHllKf7CQXqBtJmKaCh/dAo4qKwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751302889; c=relaxed/simple;
	bh=EzAJfZfqmnJTqkDf4//3vhVNMEmMht9eX/n4yQZBjuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmtOQbtiwZ7tUJDOUPcLK7e46u2JxSmFfPzdwQHeGl058/WIqdxsD8CsFo8bOrGNd4/7mDth9wJ+Kt0S+9uTd4AgB6dn8JseVgxpguF25M2+pSTH5crSLkC5imNz8KbLA+tMIaLd1F4gHrTRmi2r9ENIMCgBvhntsqRz3nisUE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rg3mkczG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mN1+BR1R; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rg3mkczG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mN1+BR1R; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 45CB01F76B;
	Mon, 30 Jun 2025 17:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751302886;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UM13EOaR1GAAnE46Xx3QHAAVKNsemQAyB6FQts1edOU=;
	b=rg3mkczGihXtEoz8JzQBeIcxQYURz1XQoSMSSJGDaN+Y0xOFX9uA2QZbVKSjYwt1bxw+vh
	rfp1IB0rqXWTkK0nR6Ks+fXoAxySBLAOkYROeWTazaY+IO/HDQZPCJ2r7g4bBTpPqmpTb7
	1lR98XZJDubBHII3zytDbWWZVSm6sLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751302886;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UM13EOaR1GAAnE46Xx3QHAAVKNsemQAyB6FQts1edOU=;
	b=mN1+BR1RZx8BNlZLKtBMl50sGcUokuyh9VGZa+L4e35XQtiU1KNu2oj2ZAjGd5H519P/tH
	Z5GPvXnuIAHyXcCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751302886;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UM13EOaR1GAAnE46Xx3QHAAVKNsemQAyB6FQts1edOU=;
	b=rg3mkczGihXtEoz8JzQBeIcxQYURz1XQoSMSSJGDaN+Y0xOFX9uA2QZbVKSjYwt1bxw+vh
	rfp1IB0rqXWTkK0nR6Ks+fXoAxySBLAOkYROeWTazaY+IO/HDQZPCJ2r7g4bBTpPqmpTb7
	1lR98XZJDubBHII3zytDbWWZVSm6sLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751302886;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UM13EOaR1GAAnE46Xx3QHAAVKNsemQAyB6FQts1edOU=;
	b=mN1+BR1RZx8BNlZLKtBMl50sGcUokuyh9VGZa+L4e35XQtiU1KNu2oj2ZAjGd5H519P/tH
	Z5GPvXnuIAHyXcCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 270DB13983;
	Mon, 30 Jun 2025 17:01:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BNlTCebCYmhNIgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 30 Jun 2025 17:01:26 +0000
Date: Mon, 30 Jun 2025 19:01:16 +0200
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: zoned: do not remove unwritten non-data block
 group
Message-ID: <20250630170116.GN31241@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1751273376.git.naohiro.aota@wdc.com>
 <b3d5079b7ac23898b5af224b6ce577dbd6ab2f5c.1751273376.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3d5079b7ac23898b5af224b6ce577dbd6ab2f5c.1751273376.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -3.96
X-Spamd-Result: default: False [-3.96 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.16)[-0.783];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 

On Mon, Jun 30, 2025 at 06:23:30PM +0900, Naohiro Aota wrote:
> There are some reports of "unable to find chunk map for logical 2147483648
> length 16384" error message appears in the dmesg. This means some IOs are
> occurring after a block group is removed.
> 
> When a metadata tree node is cleaned on the zoned setup, we keep that
> node still dirty and write it out not to create a write hole. However,
> this can make a block group's used bytes == 0 while there is dirty
> region left.
> 
> Such unused block group is moved into the unused_bg list and processed
> for the removal. When the removal succeeds, the block group is removed
> from the transaction->dirty_bgs list, so the unused dirty nodes in the
> block group are not sent at the transaction commit time. It will be
> written at some later time e.g, sync or umount, and causes the "unable
> to find chunk map" errors.
> 
> This can happen relatively easier on SMR whose zone size is 256MB. However,
> calling do_zone_finish() on such block group returns -EAGAIN and keep that
> block group intact, which is why the issue is hidden until now.
> 
> Fixes: afba2bc036b0 ("btrfs: zoned: implement active zone tracking")
> CC: stable@vger.kernel.org # 6.1+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/block-group.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 00e567a4cd16..d9afaddeeab0 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -34,6 +34,14 @@ int btrfs_should_fragment_free_space(const struct btrfs_block_group *block_group
>  }
>  #endif
>  
> +static inline bool has_unwritten_metadata(struct btrfs_block_group *block_group)
> +{
> +	return btrfs_is_zoned(block_group->fs_info) &&
> +		(block_group->flags & (BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_SYSTEM)) &&
> +		block_group->start + block_group->alloc_offset >
> +			block_group->meta_write_pointer;

Could you please untangle the condition, like split it to a sequence of
ifs, where the first one would be if (!zoned) which makes it easy to
skip the rest if one is not considering the zoned mode.

> +
>  /*
>   * Return target flags in extended format or 0 if restripe for this chunk_type
>   * is not in progress
> @@ -1244,6 +1252,12 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
>  		goto out;
>  
>  	spin_lock(&block_group->lock);
> +	/*
> +	 * Hitting this WARN means we removed a block group with an unwritten
> +	 * region. It will cause "unable to find chunk map for logical" errors.
> +	 */
> +	WARN_ON(has_unwritten_metadata(block_group));

Please add a message to the warning, we have too many plain WARN_ONs and
it takes some extra steps to identify the problem.

