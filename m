Return-Path: <linux-btrfs+bounces-19364-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C384FC8A52C
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Nov 2025 15:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1D16F354B6A
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Nov 2025 14:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AA63009C0;
	Wed, 26 Nov 2025 14:27:59 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C002FDC52
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Nov 2025 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764167279; cv=none; b=JytDbu72uVTje2XbIeYU45hvgzf9JrpMcflACh45lo3xYy0qQmH2ruo4a1MiVXaKXDWxpnD/OthICiM1q4wchBGAkxdkAu0wpJCq7SG1QTdvkBnBdRJL29SuiU09o7pbuG53wv3fM+JIHXCr7/8t/SvlEINok3wfsHACXykN7R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764167279; c=relaxed/simple;
	bh=Kt6ljMmNxui5mAAjCzwzklEB3Ze+J4X9XdfLDmcelVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoPfxMryojcv9z621TQlYKye7D9kC9Qw+Md3+LDLLmhGRmyalYEq5xBlUNB31of3MK3f8KfNb71vkFqfPjlUbySS+hjmJVwxtfaNsQLw2NlUYy6h4z5WATYnWVl78GRSPEqWsj136vYY4Z12aRD/n4nB4VmvquKFuylFlZTrj8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9BE5D33697;
	Wed, 26 Nov 2025 14:27:55 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 813C03EA63;
	Wed, 26 Nov 2025 14:27:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HC1dH2sOJ2mzPgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 26 Nov 2025 14:27:55 +0000
Date: Wed, 26 Nov 2025 15:27:50 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: introduce BTRFS_PATH_AUTO_RELEASE() helper
Message-ID: <20251126142750.GC13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1764106678.git.wqu@suse.com>
 <8922862996ef5e57e694de08dca430b372585728.1764106678.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8922862996ef5e57e694de08dca430b372585728.1764106678.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 9BE5D33697
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed, Nov 26, 2025 at 08:20:21AM +1030, Qu Wenruo wrote:
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
> 
> This will applies to all 3 on-stack path usages:
> 
> - defrag_get_extent() in defrag.c
> 
> - print_data_reloc_error() in inode.c
>   There is a special case where we want to release the path early before
>   the time consuming iterate_extent_inodes() call, thus that manual
>   early release is kept as is, with an extra comment added.
> 
> - scrub_radi56_parity_stripe() in scrub.c
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ctree.h  |  9 +++++++++
>  fs/btrfs/defrag.c |  5 +----
>  fs/btrfs/inode.c  |  8 +++++---
>  fs/btrfs/scrub.c  | 18 ++++++------------
>  4 files changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 692370fc07b2..d5bd01c4e414 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -85,6 +85,14 @@ struct btrfs_path {
>  #define BTRFS_PATH_AUTO_FREE(path_name)					\
>  	struct btrfs_path *path_name __free(btrfs_free_path) = NULL
>  
> +/*
> + * This defines an on-stack path that will be auto released exiting the scope.
> + *
> + * This one is compatible with any existing manual btrfs_release_path() calls.
> + */
> +#define BTRFS_PATH_AUTO_RELEASE(path_name)					\
> +	struct btrfs_path path_name __free(btrfs_release_path) = { 0 }

For the on-stack path it makes sense though it's a bit confusing because
BTRFS_PATH_AUTO_FREE defines a pointer. It's way more common to get a
path from a parameter and then call btrfs_release_path() on the pointer,
so it's not possible to use the AUTO_RELEASE pattern anyway.

