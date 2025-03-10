Return-Path: <linux-btrfs+bounces-12155-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE366A5A418
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 20:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEF4D174B72
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 19:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9051DDA31;
	Mon, 10 Mar 2025 19:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zU76sN/l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EzqxHBWM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zU76sN/l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EzqxHBWM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79BE1D90C8
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 19:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636315; cv=none; b=ereJZgaM+rGXrPfQQ8/Cufc6X1cxl0TKk7YnDv34luPkuPRv4IVzBzzlul5hemjVfKYSfmoBxCRZrSRL1avJYW3K0E8ladlaTHTJR5JNn/Y+ZW5X3EyQ3RUFTnsTz3jRIsiZvK/fnDfoicVO9mvpEljOeqwGGNB8WvwVcIAOQKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636315; c=relaxed/simple;
	bh=X++XNym9y251kHo8ISsAx9+Ar76fz/JQwRWv5ZbmXWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvTZN18NdgPAL6WpXURnJWPXJ7ODqfM0iZTe2EvPDSA7h0qwwcx+mDYyMNOn9dYMH4l6rTF9d5GhcoeZ++plwgJZM74anFzPc8w2vDVr3LIfXvl4rWgQpJEi+298LN2eA9Ekjlkq6a409NywHycKlROvXi8sV0uFQ6T9nuaztW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zU76sN/l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EzqxHBWM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zU76sN/l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EzqxHBWM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1C4961F387;
	Mon, 10 Mar 2025 19:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741636312;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0o3BNJD5l/e2Fj9P+S6shkMKliyy2iLPudeeAvFjnFU=;
	b=zU76sN/lLaU4E/WQg5tkvhrjmfUCbHaNwqmD/O75dBFuLOk8PaMrttCgnRwHl6PL9z2/Xj
	YkUPGGZU1s8AkeJreCx/GIG3XjLxyEvTFusGs5J3lrEAZSEpU++/VpJjpTxFBRBZIdDhfp
	k6qu6VlIvDA6nyiklck1Mu2F8FgLUmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741636312;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0o3BNJD5l/e2Fj9P+S6shkMKliyy2iLPudeeAvFjnFU=;
	b=EzqxHBWMGGymemYUceQVZztgwLeGry6ZVqW1eQGikqVCxQ7xEwXcrIlEWaA5oscbI6GDIO
	PMwA4IWtwEpWtaBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741636312;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0o3BNJD5l/e2Fj9P+S6shkMKliyy2iLPudeeAvFjnFU=;
	b=zU76sN/lLaU4E/WQg5tkvhrjmfUCbHaNwqmD/O75dBFuLOk8PaMrttCgnRwHl6PL9z2/Xj
	YkUPGGZU1s8AkeJreCx/GIG3XjLxyEvTFusGs5J3lrEAZSEpU++/VpJjpTxFBRBZIdDhfp
	k6qu6VlIvDA6nyiklck1Mu2F8FgLUmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741636312;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0o3BNJD5l/e2Fj9P+S6shkMKliyy2iLPudeeAvFjnFU=;
	b=EzqxHBWMGGymemYUceQVZztgwLeGry6ZVqW1eQGikqVCxQ7xEwXcrIlEWaA5oscbI6GDIO
	PMwA4IWtwEpWtaBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 002FF1399F;
	Mon, 10 Mar 2025 19:51:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HSJcO9dCz2fTGgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 10 Mar 2025 19:51:51 +0000
Date: Mon, 10 Mar 2025 20:51:50 +0100
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: remove unnecessary 'found_key' local variable
 in btrfs_search_forward()
Message-ID: <20250310195150.GD32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250309075820.30999-1-sunk67188@gmail.com>
 <20250309075820.30999-3-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309075820.30999-3-sunk67188@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Sun, Mar 09, 2025 at 03:58:00PM +0800, Sun YangKai wrote:
> The 'found_key' variable was only used to temporarily store a key value

In the changelog text it's ok to use quoting but not in the subject, due
to the special characters.

> before copying it to 'min_key' at the end of the function when returning
> success (ret=0).
> 
> This commit optimizes the code by:
> 1. Eliminating the intermediate 'found_key' variable
> 2. Directly populating 'min_key' at the exact loop exit points where
>    ret=0 is set
> 3. Removing the final memcpy operation in the return path
> 
> This change improves code clarity by:
> - Removing redundant variable usage
> - Simplifying the success path logic
> - Reducing memory operations
> 
> The found key value is now stored directly into the destination 'min_key'
> structure at the point of discovery, maintaining identical functionality
> while:
> - Eliminating an unnecessary memory copy
> - Reducing code complexity

I think the text is overexplaining, you can keep it to the point what
the cleanup does and that it does not change the logic but does not need
to mention general statements.

> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> ---
>  fs/btrfs/ctree.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 3dc5a35dd19b..1dc59dc3b708 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -4608,7 +4608,6 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
>  			 u64 min_trans)
>  {
>  	struct extent_buffer *cur;
> -	struct btrfs_key found_key;
>  	int slot;
>  	int sret;
>  	u32 nritems;
> @@ -4644,7 +4643,8 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
>  				goto find_next_key;
>  			ret = 0;
>  			path->slots[level] = slot;
> -			btrfs_item_key_to_cpu(cur, &found_key, slot);
> +			/* save our key for returning back */

If you're moving a comment please also fix it so it conforms to the
preferred style, it's a sentence, so capital first letter and ended by a
period. For old code like that's it's a rare opportunity to do it so it
ought to be done.

> +			btrfs_item_key_to_cpu(cur, min_key, slot);
>  			goto out;
>  		}
>  		if (sret && slot > 0)
> @@ -4679,11 +4679,11 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
>  				goto out;
>  			}
>  		}
> -		/* save our key for returning back */
> -		btrfs_node_key_to_cpu(cur, &found_key, slot);
>  		path->slots[level] = slot;
>  		if (level == path->lowest_level) {
>  			ret = 0;
> +			/* save our key for returning back */
> +			btrfs_node_key_to_cpu(cur, min_key, slot);
>  			goto out;
>  		}
>  		cur = btrfs_read_node_slot(cur, slot);
> @@ -4702,7 +4702,6 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
>  	path->keep_locks = keep_locks;
>  	if (ret == 0) {
>  		btrfs_unlock_up_safe(path, path->lowest_level + 1);
> -		memcpy(min_key, &found_key, sizeof(found_key));
>  	}

Single statement 'if' should not enclose the statements in { }

>  	return ret;
>  }
> -- 
> 2.48.1
> 

