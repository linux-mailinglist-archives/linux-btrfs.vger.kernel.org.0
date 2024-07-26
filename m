Return-Path: <linux-btrfs+bounces-6724-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58DE93D634
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 17:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C740283481
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 15:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC2217967C;
	Fri, 26 Jul 2024 15:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wHP2vo54";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rrokm2+f";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oEQQXnJw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rrokm2+f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C410410A1C
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722008124; cv=none; b=uqIvCLLH3LqNcTTGGGTueNsIKp9O8Km6VqF0jEOdW+kLdEE8fGIomiwZIz/Qc1CRt8CMdpI76u50VJpTS06lzffypksJzuq6lHA8us9+Y4jhAV4hq7St0UvHFPa4CLce+4/iwgVYtG4iy+52aTu88gZ1HtkRXqLv1vbDfcBbARw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722008124; c=relaxed/simple;
	bh=Vv6eF7HVtb34v8QM/8/lNJPyL3jS6VaLL1ZXhLqwJPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDmA21Xxyl3hJv9cZtVMQQix9D6QAXcqDLGK/s9W1RKef6guI2V/OxWye3ntaXN1W3i4Kb6CkXcRoCoLz9x0f2+AeKq2IJkeG3kq6cj3ZBylDhCrcUpgS0oRWcmz7g94hx/ljixz1xEaMi9ux2Z2nZunZZLYAKvGmF0j36fLmu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wHP2vo54; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rrokm2+f; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oEQQXnJw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rrokm2+f; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F366A21BCE;
	Fri, 26 Jul 2024 15:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722008121;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xst7mS91OHm5lPs4eWmljqXsC8tvFcbITerHs0lCML4=;
	b=wHP2vo54s54sos4iaB0MmZrQwUF2Lr0PZxsKSL2uHhvsfmC2x61pCQBj51SI59CFQwUliE
	QsdoVBHm0reRsPbekxPs8nLgocWgqLWWGF1E+iM2wi3wcOYSVjrbglKmJHm6K8f+rUWhaX
	bUhsDvkHLBicnv+jf53zulVxKaIl0Ho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722008121;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xst7mS91OHm5lPs4eWmljqXsC8tvFcbITerHs0lCML4=;
	b=Rrokm2+fa+W8/DWI40zvpspNeSE9PYcgNeawsUK/9zEAhzX3hY0cfM0SZSR8sJJBbr63G0
	S2VUrFME/s6c2rCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722008120;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xst7mS91OHm5lPs4eWmljqXsC8tvFcbITerHs0lCML4=;
	b=oEQQXnJwvgml252ltI66CGxmroVUSMm93tCWW/Z85vQ9mUvowFg/NMAkUw7DbHAbEZ+191
	cPywcLaa1WhT+pGhT7pos46XwLuhE9WdRVcF4qAbhxt8WsftR56kWk9MTxRVf/h7LiMgUk
	QOmK6ctHWI3+hs87m7MGQw8QDqqPlIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722008121;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xst7mS91OHm5lPs4eWmljqXsC8tvFcbITerHs0lCML4=;
	b=Rrokm2+fa+W8/DWI40zvpspNeSE9PYcgNeawsUK/9zEAhzX3hY0cfM0SZSR8sJJBbr63G0
	S2VUrFME/s6c2rCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA8281396E;
	Fri, 26 Jul 2024 15:35:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2f0rMDjCo2YsMgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 26 Jul 2024 15:35:20 +0000
Date: Fri, 26 Jul 2024 17:35:15 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs-progs: introduce btrfs_rebuild_uuid_tree() for
 mkfs and btrfs-convert
Message-ID: <20240726153515.GI17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1721987605.git.wqu@suse.com>
 <8e33931a4d078d1e1aa620aa5fe717f35146ef31.1721987605.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e33931a4d078d1e1aa620aa5fe717f35146ef31.1721987605.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Fri, Jul 26, 2024 at 07:29:55PM +0930, Qu Wenruo wrote:
> Currently mkfs uses its own create_uuid_tree(), but that function is
> only handling FS_TREE.
> 
> This means for btrfs-convert, we do not generate the uuid tree, nor
> add the UUID of the image subvolume.
> 
> This can be a problem if we're going to support multiple subvolumes
> during mkfs time.
> 
> To address this inconvenience, this patch introduces a new helper,
> btrfs_rebuild_uuid_tree(), which will:
> 
> - Create a new uuid tree if there is not one
> 
> - Empty the existing uuid tree
> 
> - Iterate through all subvolumes
>   * If the subvolume has no valid UUID, regenerate one
>   * Add the uuid entry for the subvolume UUID
>   * If the subvolume has received UUID, also add it to UUID tree
> 
> By this, this new helper can handle all the uuid tree generation needs for:
> 
> - Current mkfs
>   Only one uuid entry for FS_TREE
> 
> - Current btrfs-convert
>   Only FS_TREE and the image subvolume
> 
> - Future multi-subvolume mkfs
>   As we do the scan for all subvolumes.
> 
> - Future "btrfs rescue rebuild-uuid-tree"
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  common/root-tree-utils.c | 265 +++++++++++++++++++++++++++++++++++++++
>  common/root-tree-utils.h |   1 +
>  convert/main.c           |   5 +
>  mkfs/main.c              |  37 +-----
>  4 files changed, 274 insertions(+), 34 deletions(-)
> 
> diff --git a/common/root-tree-utils.c b/common/root-tree-utils.c
> index 6a57c51a8a74..13f89dbd5293 100644
> --- a/common/root-tree-utils.c
> +++ b/common/root-tree-utils.c
> @@ -15,9 +15,11 @@
>   */
>  
>  #include <time.h>
> +#include <uuid/uuid.h>
>  #include "common/root-tree-utils.h"
>  #include "common/messages.h"
>  #include "kernel-shared/disk-io.h"
> +#include "kernel-shared/uuid-tree.h"
>  
>  int btrfs_make_root_dir(struct btrfs_trans_handle *trans,
>  			struct btrfs_root *root, u64 objectid)
> @@ -212,3 +214,266 @@ abort:
>  	btrfs_abort_transaction(trans, ret);
>  	return ret;
>  }
> +
> +static int empty_tree(struct btrfs_root *root)

Please rename this, it's confusing as empty can be a noun and verb so
it's not clear if it's a meant as a predicate or action.

