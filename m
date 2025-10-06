Return-Path: <linux-btrfs+bounces-17469-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFCFBBEE4F
	for <lists+linux-btrfs@lfdr.de>; Mon, 06 Oct 2025 20:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 586CB3A8093
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Oct 2025 18:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5736427FB05;
	Mon,  6 Oct 2025 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A5etU3aB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/iq9w/BV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MKnRXTUm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9OSifYpg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B4E38FA6
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Oct 2025 18:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759774478; cv=none; b=T+tX/Itadt088bXBn3cMnh805ZXa8O1qmTrGlmkAIyQHrbXC5SSxjIipuTbLfEp9RTi6o3tleGSev1fsHJMqg0s6TW6rnC6NbkFVwGqdDgOr2bIwiTVkgJjP3qHtVd0qUST52QAUbvggBiF65iHiBjBtD7T2NysuefS/y8l0bEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759774478; c=relaxed/simple;
	bh=6wJHu98xIUGA87nURzVwl1YhAiuANwDUtdKb+SvJSsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+beiYmP/zvEZQ99OuVTOLSafLJZuiE7jZzz8zDoam0VydioEjlovCvqgaaOTOq7U/HC1VbAOnuhO2wTjueeyV2ntF9kt8NrI5KJ+alg0k0WhE7vjaBdGrrDvkgiobwOckDE6tM/S4F1icCQjv/lF+6qoqC/TmDvxXInJBTiLWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A5etU3aB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/iq9w/BV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MKnRXTUm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9OSifYpg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 10879336E1;
	Mon,  6 Oct 2025 18:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759774475;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eET8J8kpKMYQ9K9QfcVr5KJcD8P7+LmihguJvFeoyk4=;
	b=A5etU3aB8o/DRAX/lOtRqX0sINMHI4OgLMCCDL6G7S+VCt8MIPJykRWdej+t3pF1x9DkW8
	yxEswVt2akn1BZ/XbTnuhwUNR/7+JGDidAJTDrFMVZcfgTMy7X5T27s1opQxkMbPnLEer5
	IoTV+zPgR61wWPKZ6JSEdtrR1QWUmYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759774475;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eET8J8kpKMYQ9K9QfcVr5KJcD8P7+LmihguJvFeoyk4=;
	b=/iq9w/BVJdUSZkuEwEJA3vcBzqsoEU+DK+prpf7rIssuy9gsDwaMt3yJ/mEl0MKqIqzDs6
	Q6f5VPa1JpkC9yBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759774474;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eET8J8kpKMYQ9K9QfcVr5KJcD8P7+LmihguJvFeoyk4=;
	b=MKnRXTUmIOL9ym0Rz3XaAmqHmWcUbG7x1fAfH31lSzEazHN0W/HMEiB4hiZI+GgrONqiU0
	J2s9eL8F5zJW/r79HpC3pXfyUt3ebhByKuuYTy+cJ8cs7GN6NqVDcicDnjXnvy3ApU99Ae
	eqIjXgzrOu//QRtBSs/ZY8qDneHQBpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759774474;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eET8J8kpKMYQ9K9QfcVr5KJcD8P7+LmihguJvFeoyk4=;
	b=9OSifYpgJ/FfMKG9U+lkoNOGTlXPfkPaMEDAzP8ER4neYu9+6z2vJFBhttD0GmdM0Hscib
	FYUGvBEur8XVSACA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E227C13700;
	Mon,  6 Oct 2025 18:14:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id m5IGNwkH5GhyWwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 06 Oct 2025 18:14:33 +0000
Date: Mon, 6 Oct 2025 20:14:32 +0200
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions
Message-ID: <20251006181432.GC4412@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251004143114.21847-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251004143114.21847-1-sunk67188@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid,suse.cz:replyto]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Sat, Oct 04, 2025 at 10:31:09PM +0800, Sun YangKai wrote:
> Trivial pattern for the auto freeing with goto -> return conversions.
> No other function cleanup.

You could have copied the changelog from previous version, the above is
too terse.
> 
> ---

The --- is a delimiter of the changelog so anything below that untill
the diff starts will be dropped.

> 
> Changelog:
> v1 -> v2:
> * Add goto -> return conversions
> 
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>

In this case your signed off that I added manually to the committed
version.

Below are a few fixups I did in the final version, a few cases to unify
the returns.

> @@ -315,14 +284,13 @@ int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info)
>  	if (ret) {
>  		if (ret > 0)
>  			ret = 0;
> -		goto out;
> +		return ret;
>  	}

The ifs can be untangled to two:

	if (ret < 0)
		return ret;
	if (ret > 0)
		return 0;

>  
>  	while (1) {
> -		if (btrfs_fs_closing(fs_info)) {
> -			ret = -EINTR;
> -			goto out;
> -		}
> +		if (btrfs_fs_closing(fs_info))
> +			return -EINTR;
> +
>  		cond_resched();
>  		leaf = path->nodes[0];
>  		slot = path->slots[0];

> --- a/fs/btrfs/verity.c
> +++ b/fs/btrfs/verity.c
> @@ -217,7 +212,7 @@ static int write_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
>  			   const char *src, u64 len)
>  {
>  	struct btrfs_trans_handle *trans;
> -	struct btrfs_path *path;
> +	BTRFS_PATH_AUTO_FREE(path);
>  	struct btrfs_root *root = inode->root;
>  	struct extent_buffer *leaf;
>  	struct btrfs_key key;

One break -> return conversion in the while() loop from after
btrfs_start_transaction() failure.

> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2034,12 +2024,10 @@ static int btrfs_rm_dev_item(struct btrfs_trans_handle *trans,
>  	if (ret) {
>  		if (ret > 0)
>  			ret = -ENOENT;
> -		goto out;
> +		return ret;
>  	}
>  
>  	ret = btrfs_del_item(trans, root, path);
> -out:
> -	btrfs_free_path(path);
>  	return ret;

Here the btrfs_del_item() can be put to return, it was done in another
part of this patch too.

>  }

> @@ -3048,23 +3029,20 @@ static int btrfs_free_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
>  
>  	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
>  	if (ret < 0)
> -		goto out;
> -	else if (unlikely(ret > 0)) { /* Logic error or corruption */
> +		return ret;
> +	if (unlikely(ret > 0)) { /* Logic error or corruption */

Minor style fixup to move the comment to a separate line, you can still
find that but it's from old code and this is a good time to update it.

>  		btrfs_err(fs_info, "failed to lookup chunk %llu when freeing",
>  			  chunk_offset);
>  		btrfs_abort_transaction(trans, -ENOENT);
> -		ret = -EUCLEAN;
> -		goto out;
> +		return -EUCLEAN;
>  	}

Otherwise OK. You don't need to fix and resend the patch. I'm not sure
if there are more places to convert. If you find some please send them.
Thanks.

