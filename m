Return-Path: <linux-btrfs+bounces-18889-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D666C50E26
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 08:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4F33B5337
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 07:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D108E28506F;
	Wed, 12 Nov 2025 07:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vwjQHj6E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I83A1g0T";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ncUHmCk7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0dIhHmFK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D25F25DAEA
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Nov 2025 07:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762931370; cv=none; b=YUPB30STTPVXFMJEUPmE7c3pCiXoP65W2ge9J4LfMBe9ReGXoPOjDl9plpqzq62kYv3SXn6YGKygCbwwqIA4IpmKm8EvnloMCCmP3Gx+DJM1IvtWxYqZdWQOkDLQIRIl3ZzVp+yyZMyUL6OC2LKOAhREyIxTv10xdtfHyb0Z5pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762931370; c=relaxed/simple;
	bh=RwHYCuEfOGGeWoMDG5+HxZ0VnugWErxdmeR2KxfivJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azKNhb7a0ad4RTE43rNa2jRLavadR+xCdczxBxFhFSe+gIcyzECQDGjfw/Tk5r8nLXS2J1EuAC3ZeGoSFekm3e5bVbW/7LiabvWrdk9wJ+TDveyiWNU4eviAdw236PsnsbU6kLU/qjqZaR2/66DR376fljb/x1N4+ZaJT9TKEM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vwjQHj6E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I83A1g0T; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ncUHmCk7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0dIhHmFK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E9EF4211CB;
	Wed, 12 Nov 2025 07:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762931367;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y3BnCUZ/iGTtz8uGsSFqCU3bGO4RGikXYprvH/wcPxY=;
	b=vwjQHj6Ee4TJXfyiuJEuwRBTAP0LIsw6Pgp2T4l1QU9OQb9E/TMZapl7i5Pr4jDwZGCFex
	jF3A4LYQFEhvu4eIOE9BEVx6v/1CGYWOeAE0Kczind6GGyf5/CY+A+aCrRE6JEtW+DMmyI
	V5i9c/VKIPzpR3XstnNQvLSZqBQRHy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762931367;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y3BnCUZ/iGTtz8uGsSFqCU3bGO4RGikXYprvH/wcPxY=;
	b=I83A1g0TWGrcknl6nobgJ9QhKS4NwHd5k/aD91JBCFgMhFMy7GWtI3sDdOPc/A0XgW2wts
	C5ILojhuNU5vZlDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762931366;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y3BnCUZ/iGTtz8uGsSFqCU3bGO4RGikXYprvH/wcPxY=;
	b=ncUHmCk7vwPD1iOOnRN19ORmWHeMU+RgCOhd1HnnKqPlCIi24AsJCPb84sfvwnErbqyP2G
	D/LXNfZxs5Q1lVBPsE321zKcv7JHsXCJ6GvdXS437Oz74+xR5Oh0oX4kCIrR/vjIDCb6YC
	HpJ5ewZzvdNRRxlal+ANO8krFSkYoNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762931366;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y3BnCUZ/iGTtz8uGsSFqCU3bGO4RGikXYprvH/wcPxY=;
	b=0dIhHmFKOTOQlQYfLJSX0nYZhBTZzrRw9oehqRNmWDf/6Ybhs9WHZeAEDyFlv2NZg8ZAce
	GE2KPF7BROaSHFAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA19914DC5;
	Wed, 12 Nov 2025 07:09:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tW36NKYyFGk6dQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 12 Nov 2025 07:09:26 +0000
Date: Wed, 12 Nov 2025 08:09:25 +0100
From: David Sterba <dsterba@suse.cz>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: take delayed_node mutex when releasing item
Message-ID: <20251112070925.GD13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <58b8b78ff75d5aff478859f9fe51e0ff14e35fba.1762906462.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58b8b78ff75d5aff478859f9fe51e0ff14e35fba.1762906462.git.loemra.dev@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Tue, Nov 11, 2025 at 04:22:57PM -0800, Leo Martins wrote:
> The error path in btrfs_delete_delayed_dir_index does not take
> the delayed_node mutex when releasing delayed item.
> btrfs_release_delayed_item -> __btrfs_remove_delayed_item which
> has lockdep_assert_held(&delayed_node->mutex)
> 
> Fix this by taking the mutex when releasing.
> 
> Fixes: 933c22a7512c ("btrfs: delayed-inode: Kill the BUG_ON() in btrfs_delete_delayed_dir_index()")
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> ---
>  fs/btrfs/delayed-inode.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index e77a597580c5..30dd067e2db3 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -1662,7 +1662,9 @@ int btrfs_delete_delayed_dir_index(struct btrfs_trans_handle *trans,
>  		btrfs_err(trans->fs_info,
>  "metadata reservation failed for delayed dir item deletion, index: %llu, root: %llu, inode: %llu, error: %d",
>  			  index, btrfs_root_id(node->root), node->inode_id, ret);
> +		mutex_lock(&node->mutex);
>  		btrfs_release_delayed_item(item);
> +		mutex_unlock(&node->mutex);

I don't think it's needed, the item has been just allocated but not yet
added to the rbtree (__btrfs_add_delayed_item() a few lines below).

In btrfs_release_delayed_item() there's a check if the item is in the
rbtree, if not then nothing is done. Otherwise the lockdep assertion is
checked, and the locking would be needed.

