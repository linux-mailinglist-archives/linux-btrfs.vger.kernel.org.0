Return-Path: <linux-btrfs+bounces-19335-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA42C84F5F
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 13:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 652EE4E636E
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 12:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C35731B839;
	Tue, 25 Nov 2025 12:26:15 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D82B286417
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764073575; cv=none; b=ayLCJ+z7rQFXli1bq1WZOAh1jUYlIvjVZMyLmg3UH7CqxuucG4f4nLB8R2lDgReF4H6Czv3eb8/kasXR/ew6ZAbdcgaimqqPP4d3OCWYirb52Hd+gCAEl8CoXS7gzs06CPLcPQ8PC2DqnbW4l7rmpB56ZwmD/A0uG8w3pt8t0Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764073575; c=relaxed/simple;
	bh=l8Czf/zS3DpLijsSg91j08q28JbDG0dA42GF5Hj9h4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVR7UhF/bXN1rHotmJqDcb5V9dDBtv85Q84JELo/z7g4aB/NkyuRMAPNNLqkcB9f2syTb4Uj2d99c8tLrlhsUUM0dwJthWXpeLoF4UoNcR4TD+AaF8xurGHgZmEsfOl/QfG9zPEhmU6I0M2PZDsh3UiCTk2LyzwmBzqAaxKmlRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DD3AF5BD82;
	Tue, 25 Nov 2025 12:26:11 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB4B63EA63;
	Tue, 25 Nov 2025 12:26:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Beb4LGOgJWkGbAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 25 Nov 2025 12:26:11 +0000
Date: Tue, 25 Nov 2025 13:26:06 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: introduce BTRFS_PATH_AUTO_RELEASE() helper
Message-ID: <20251125122606.GU13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1764058736.git.wqu@suse.com>
 <f1be8250618a68c9abf1be7f3af416ccfad3784b.1764058736.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1be8250618a68c9abf1be7f3af416ccfad3784b.1764058736.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: DD3AF5BD82
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]

On Tue, Nov 25, 2025 at 06:49:57PM +1030, Qu Wenruo wrote:
> There are already several bugs with on-stack btrfs_path involved, even
> it is already a little safer than btrfs_path pointers (only leaks the
> extent buffers, not the btrfs_path structure itself)
> 
> - Patch "btrfs: make sure extent and csum paths are always released in
>   scrub_raid56_parity_stripe()"
>   Which is going into v6.19 release cycle.
> 
> - Patch "btrfs: fix a potential path leak in print_datA_reloc_error()"
>   The previous patch in the series.
> 
> Thus there is a real need to apply auto release for those on-stack paths.
> 
> This patch introduces a new macro, BTRFS_PATH_AUTO_RELEASE(), which
> defines one on-stack btrfs_path structure, initialize it all to 0, then
> call btrfs_release_path() on it when exiting the scope.

Ok this makes sense. Similar to the path freeing, there should be almost
no code following the expected place of freeing/releasing. If the path
is locked then delaying the cleanup holds the locks. There are relese
calls that will act as an unlock so they should stay, one example below.

Otherwise the hint for auto freeing/releasing is "right before return".

> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -217,7 +217,7 @@ static void print_data_reloc_error(const struct btrfs_inode *inode, u64 file_off
>  				   int mirror_num)
>  {
>  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> -	struct btrfs_path path = { 0 };
> +	BTRFS_PATH_AUTO_RELEASE(path);
>  	struct btrfs_key found_key = { 0 };
>  	struct extent_buffer *eb;
>  	struct btrfs_extent_item *ei;
> @@ -255,7 +255,6 @@ static void print_data_reloc_error(const struct btrfs_inode *inode, u64 file_off
>  	if (ret < 0) {
>  		btrfs_err_rl(fs_info, "failed to lookup extent item for logical %llu: %d",
>  			     logical, ret);
> -		btrfs_release_path(&path);
>  		return;
>  	}
>  	eb = path.nodes[0];
> @@ -285,13 +284,10 @@ static void print_data_reloc_error(const struct btrfs_inode *inode, u64 file_off
>  				(ref_level ? "node" : "leaf"),
>  				ref_level, ref_root);
>  		}
> -		btrfs_release_path(&path);
>  	} else {
>  		struct btrfs_backref_walk_ctx ctx = { 0 };
>  		struct data_reloc_warn reloc_warn = { 0 };
>  
> -		btrfs_release_path(&path);

The path should be released here because there's iterate_extent_inodes()
which can potentially take long due to the iteration.

> -
>  		ctx.bytenr = found_key.objectid;
>  		ctx.extent_item_pos = logical - found_key.objectid;
>  		ctx.fs_info = fs_info;

