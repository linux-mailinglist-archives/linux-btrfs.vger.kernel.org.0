Return-Path: <linux-btrfs+bounces-19338-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BC7C85942
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 15:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38A554EC901
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 14:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BA621B9F6;
	Tue, 25 Nov 2025 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m30ACg84";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R7LaFD8k";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m30ACg84";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R7LaFD8k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5532513AD05
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764082312; cv=none; b=mGvmNqcyqTL6RZ5i6Gc59FXwMou4sBRJoPlFY6o3LKi5mkvlIQ9CjcLUC1XbPWmHVHUjbOBKRL2CJ3WhLxVMOfMSqunviS8Kmpxr9Z+znrxdqPJP253n3NOihBUVWycO//0xesG6wpBZJW82nr9OdCsDZku4mv61WxEZjWO9mI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764082312; c=relaxed/simple;
	bh=9MkYxgO0KZC2eFoCDj5FZFoP8NCkNy+MTKWaIsvfGuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYkizXoTKKD/cQsP8UAT7OEEaUesgFNscRzNn6+/xCvt93v6nhstOj1on+AL2+Ckg/dlJBTdxD8CiIZhVsnFNLpFPezkXk2e9WIVQLyCeeE35HbRJgLQWlL2iaJHQ8Ug+6b2SDEbY74/XYshpWdsLHDP810qHZgjEyw/gsQ6zYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m30ACg84; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R7LaFD8k; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m30ACg84; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R7LaFD8k; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 38A912286E;
	Tue, 25 Nov 2025 14:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764082308;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IWm64IO1GQ3AoOtWF4uoCsh4wvcuAzL3i8Tito51JYI=;
	b=m30ACg840EKS6NI4mzVVVuacQaQb2KX3xXKs1cAlHla+0osB+ZSHUdSpRkZyhll1HEb/IO
	W7DVAzJkiKyRTdtPmK+Kz7rU5I5dAJYAfU1hJh+boGeajhFCmMIxfdQ/YuYJG66s65mK8/
	gmDJzuhvEm0vNKYjf2C2/KL44JoA8a8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764082308;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IWm64IO1GQ3AoOtWF4uoCsh4wvcuAzL3i8Tito51JYI=;
	b=R7LaFD8kQOqoVBnvUaB4FOKJ5l2D1Mrr7GfR6kPUJYSIsdHOQ4oKyNv0h3ZXnZhF07LEMW
	NywIjqFesBB6LRAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=m30ACg84;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=R7LaFD8k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764082308;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IWm64IO1GQ3AoOtWF4uoCsh4wvcuAzL3i8Tito51JYI=;
	b=m30ACg840EKS6NI4mzVVVuacQaQb2KX3xXKs1cAlHla+0osB+ZSHUdSpRkZyhll1HEb/IO
	W7DVAzJkiKyRTdtPmK+Kz7rU5I5dAJYAfU1hJh+boGeajhFCmMIxfdQ/YuYJG66s65mK8/
	gmDJzuhvEm0vNKYjf2C2/KL44JoA8a8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764082308;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IWm64IO1GQ3AoOtWF4uoCsh4wvcuAzL3i8Tito51JYI=;
	b=R7LaFD8kQOqoVBnvUaB4FOKJ5l2D1Mrr7GfR6kPUJYSIsdHOQ4oKyNv0h3ZXnZhF07LEMW
	NywIjqFesBB6LRAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 115CB3EA63;
	Tue, 25 Nov 2025 14:51:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C5sQBITCJWl3fAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 25 Nov 2025 14:51:48 +0000
Date: Tue, 25 Nov 2025 15:51:42 +0100
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: introduce BTRFS_PATH_AUTO_RELEASE() helper
Message-ID: <20251125145142.GV13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1764058736.git.wqu@suse.com>
 <f1be8250618a68c9abf1be7f3af416ccfad3784b.1764058736.git.wqu@suse.com>
 <20251125122606.GU13846@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125122606.GU13846@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.79 / 50.00];
	REPLYTO_EQ_TO_ADDR(5.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 38A912286E
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: 0.79

On Tue, Nov 25, 2025 at 01:26:06PM +0100, David Sterba wrote:
> On Tue, Nov 25, 2025 at 06:49:57PM +1030, Qu Wenruo wrote:
> > There are already several bugs with on-stack btrfs_path involved, even
> > it is already a little safer than btrfs_path pointers (only leaks the
> > extent buffers, not the btrfs_path structure itself)
> > 
> > - Patch "btrfs: make sure extent and csum paths are always released in
> >   scrub_raid56_parity_stripe()"
> >   Which is going into v6.19 release cycle.
> > 
> > - Patch "btrfs: fix a potential path leak in print_datA_reloc_error()"
> >   The previous patch in the series.
> > 
> > Thus there is a real need to apply auto release for those on-stack paths.
> > 
> > This patch introduces a new macro, BTRFS_PATH_AUTO_RELEASE(), which
> > defines one on-stack btrfs_path structure, initialize it all to 0, then
> > call btrfs_release_path() on it when exiting the scope.
> 
> Ok this makes sense. Similar to the path freeing, there should be almost
> no code following the expected place of freeing/releasing. If the path
> is locked then delaying the cleanup holds the locks. There are relese
> calls that will act as an unlock so they should stay, one example below.

One example where a path release (either direct or from inside path
free) is crucial is e110f8911ddb ("btrfs: fix lockdep splat and
potential deadlock after failure running delayed items"). So removing
them from the middle of code should be careful.

> Otherwise the hint for auto freeing/releasing is "right before return".

With the above let me refine that a bit: use auto path
release/free before the 'return' when there's no code that depends on
the path and related extent buffers, or the remainging code is lighweight.

> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -217,7 +217,7 @@ static void print_data_reloc_error(const struct btrfs_inode *inode, u64 file_off
> >  				   int mirror_num)
> >  {
> >  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> > -	struct btrfs_path path = { 0 };
> > +	BTRFS_PATH_AUTO_RELEASE(path);
> >  	struct btrfs_key found_key = { 0 };
> >  	struct extent_buffer *eb;
> >  	struct btrfs_extent_item *ei;
> > @@ -255,7 +255,6 @@ static void print_data_reloc_error(const struct btrfs_inode *inode, u64 file_off
> >  	if (ret < 0) {
> >  		btrfs_err_rl(fs_info, "failed to lookup extent item for logical %llu: %d",
> >  			     logical, ret);
> > -		btrfs_release_path(&path);
> >  		return;
> >  	}
> >  	eb = path.nodes[0];
> > @@ -285,13 +284,10 @@ static void print_data_reloc_error(const struct btrfs_inode *inode, u64 file_off
> >  				(ref_level ? "node" : "leaf"),
> >  				ref_level, ref_root);
> >  		}
> > -		btrfs_release_path(&path);
> >  	} else {
> >  		struct btrfs_backref_walk_ctx ctx = { 0 };
> >  		struct data_reloc_warn reloc_warn = { 0 };
> >  
> > -		btrfs_release_path(&path);
> 
> The path should be released here because there's iterate_extent_inodes()
> which can potentially take long due to the iteration.

It would be good to add a comment why the release is there, especially
when the function is using the auto release so it's not considered a
mistake.

In many other cases no comment is needed as the general rule is to free
the path right after it's not needed.

