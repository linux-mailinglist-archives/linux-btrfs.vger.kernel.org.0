Return-Path: <linux-btrfs+bounces-14823-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA96AE1EF0
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 17:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFE3B3B0A11
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 15:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAF28F5B;
	Fri, 20 Jun 2025 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JFYvbRA8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BedXlpCU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JFYvbRA8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BedXlpCU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F1C28B3E2
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Jun 2025 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750433817; cv=none; b=BHeiJpx5H1FRmsmyVL1NYi/lB2GIiZZDj7TyotQrjaesgSqMjvXUtO4HQ/TOIjr+vYpLZyytw/Z+KDmqIYQRkQ4oZK92Bjc8N8DwLu3i3H0Lcgru25eeLgn3iTFT95zU9mmHMwpe+bq5Sf6DqmM1nJbaDFrM6PgAsRexC6UQXVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750433817; c=relaxed/simple;
	bh=7NEa4BYsKYCcvl1DlO743OZmgvuXye08dr2UIKbJEMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9sa0+AURfbIgVkqXpqlX9A0rRH9zGkuZJbPxT+86eZMKpIhRMCO2uiN9N1Me9TtwO20Qz16Kz9Ev1OE0Y/ZpPYptpccpAX2S2ZNRXV0+oSRgHbKWb21CJ/cIm/YDejbNlpCV6t+iLNkpwaUvHrg5crwAuC6PODOHwqD6G3ON1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JFYvbRA8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BedXlpCU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JFYvbRA8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BedXlpCU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6AB801F38D;
	Fri, 20 Jun 2025 15:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750433813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l/xgxR3SAcu51jPICHgCEHvN5aGIIfacAwd1NWbThb4=;
	b=JFYvbRA8BogX767m/0tS+q9o4OuGadj0qGnxOv2X78t+M8FpZlNjQ5Fpe1mvBSF5e4yYnL
	jo5WFJlwls9yaVUG6Nt+zVRqvreajb5RfGHhmqC85Zv1b54kKJ5FH5dtiJs2qQ0ivOSS/f
	sGIfLTOFkNG53+LwWbC7vFcxJto/BKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750433813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l/xgxR3SAcu51jPICHgCEHvN5aGIIfacAwd1NWbThb4=;
	b=BedXlpCULrXRQFfwF6VnzUq0mOmOAnUDyikE9rrD9GVTr+Egfu1Gs/MkSbzpx4UuIsAIJ2
	ONoOXZAJ3S4aWYDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750433813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l/xgxR3SAcu51jPICHgCEHvN5aGIIfacAwd1NWbThb4=;
	b=JFYvbRA8BogX767m/0tS+q9o4OuGadj0qGnxOv2X78t+M8FpZlNjQ5Fpe1mvBSF5e4yYnL
	jo5WFJlwls9yaVUG6Nt+zVRqvreajb5RfGHhmqC85Zv1b54kKJ5FH5dtiJs2qQ0ivOSS/f
	sGIfLTOFkNG53+LwWbC7vFcxJto/BKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750433813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l/xgxR3SAcu51jPICHgCEHvN5aGIIfacAwd1NWbThb4=;
	b=BedXlpCULrXRQFfwF6VnzUq0mOmOAnUDyikE9rrD9GVTr+Egfu1Gs/MkSbzpx4UuIsAIJ2
	ONoOXZAJ3S4aWYDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5642C13736;
	Fri, 20 Jun 2025 15:36:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LmaMFBWAVWj/YQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Jun 2025 15:36:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 98831A08DD; Fri, 20 Jun 2025 17:36:52 +0200 (CEST)
Date: Fri, 20 Jun 2025 17:36:52 +0200
From: Jan Kara <jack@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Subject: Re: [PATCH RFC 5/6] fs: introduce a shutdown_bdev super block
 operation
Message-ID: <wmvb4bnsz5bafoyu5mp33csjk4bcs63jemzi2cuqjzfy3rwogw@4t6fizv5ypna>
References: <cover.1750397889.git.wqu@suse.com>
 <ef624790b57b76be25720e4a8021d7f5f03166cb.1750397889.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef624790b57b76be25720e4a8021d7f5f03166cb.1750397889.git.wqu@suse.com>
X-Spamd-Result: default: False [-7.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -7.80

On Fri 20-06-25 15:17:28, Qu Wenruo wrote:
> Currently we already have the super_operations::shutdown() callback,
> which is called when the block device of a filesystem is marked dead.
> 
> However this is mostly for single(ish) block device filesystems.
> 
> For multi-device filesystems, they may afford a missing device, thus may
> continue work without fully shutdown the filesystem.
> 
> So add a new super_operation::shutdown_bdev() callback, for mutli-device
> filesystems like btrfs and bcachefs.
> 
> For now the only user is fs_holder_ops::mark_dead(), which will call
> shutdown_bdev() if supported.
> If not supported then fallback to the original shutdown() callback.
> 
> Btrfs is going to add the usage of shutdown_bdev() soon.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Thanks for the patch. I think that we could actually add 'bdev' that
triggered shutdown among arguments ->shutdown takes instead of introducing
a new handler.

								Honza

> ---
>  fs/super.c         |  4 +++-
>  include/linux/fs.h | 10 ++++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 21799e213fd7..8242a03bd5ce 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1461,7 +1461,9 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
>  		sync_filesystem(sb);
>  	shrink_dcache_sb(sb);
>  	evict_inodes(sb);
> -	if (sb->s_op->shutdown)
> +	if (sb->s_op->shutdown_bdev)
> +		sb->s_op->shutdown_bdev(sb, bdev);
> +	else if (sb->s_op->shutdown)
>  		sb->s_op->shutdown(sb);
>  
>  	super_unlock_shared(sb);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 96c7925a6551..4f6b4b3cbe22 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2363,7 +2363,17 @@ struct super_operations {
>  				  struct shrink_control *);
>  	long (*free_cached_objects)(struct super_block *,
>  				    struct shrink_control *);
> +	/*
> +	 * For single-device filesystems. Called when the only block device is
> +	 * marked dead.
> +	 */
>  	void (*shutdown)(struct super_block *sb);
> +
> +	/*
> +	 * For multi-device filesystems. Called when any of its block device is
> +	 * marked dead.
> +	 */
> +	void (*shutdown_bdev)(struct super_block *sb, struct block_device *bdev);
>  };
>  
>  /*
> -- 
> 2.49.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

