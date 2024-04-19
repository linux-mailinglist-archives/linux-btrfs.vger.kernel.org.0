Return-Path: <linux-btrfs+bounces-4434-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2DE8AB445
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 19:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1314A1F22015
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 17:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6D6139D05;
	Fri, 19 Apr 2024 17:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AfTpwCsr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WBcUOWZ3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AfTpwCsr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WBcUOWZ3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C6C1386D5
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713547207; cv=none; b=atXqdHOt7uvrRvL5qGfNP4LQWnJmQYg0JHRUEt7TOwmAc39vEzqSz1HWmoEs+e06BPirnt/eG3hs6fs9tff7MvSpHqIEgomA7fL2HY/nz1rsVbXl4JazwXVPX+Zbq9zjhsaXhfz3iTVJfD0inmftHz7slopA8SS38xKY07g7zfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713547207; c=relaxed/simple;
	bh=PvYWz4veF8TpqecT3VF8WvScJjtIXA3Mzbh0FJ/jyw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7px0Lv4Shr7lcVVcPYJJBTIe/ASWeB4spRRknS8Nkn3Y6vXluL5YCPOtzVq8pJGAjLIuhyaYyFUrE1qGx060riVnPforXF5GlhuwOySMhuLYYa5EokWIzht+N4JnqUoH+ZRJLF4ZLWRU9bSvfMrPGs+sMcebmFkB2piBxdt6ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AfTpwCsr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WBcUOWZ3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AfTpwCsr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WBcUOWZ3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 37758379BD;
	Fri, 19 Apr 2024 17:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713547203;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oq8XqxwFPcQM/CL9zXJjO3PeEKmb9xjBrao5d4LVoJk=;
	b=AfTpwCsr9uCz40yV8ZJ0nbUNqmSAH3DU6pYPbZ2I+RoS9yQ20J3ZKXfa0YImoBsYFEQOdk
	ZQD+JOJrFgNN26QhTjJCVjf1Yg6u0WMtiqT5JAOkR1miNGpblFI2B2HNI5MOzZxQ0ytC03
	Y/djNxb19Ls9hLj/XI753qEv+Ncp8Ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713547203;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oq8XqxwFPcQM/CL9zXJjO3PeEKmb9xjBrao5d4LVoJk=;
	b=WBcUOWZ3o+6neYcYFCXevwrGrfea8MWU5t8DnXIjOjvJH2VjV38u8iKXQ4yh+l49c4BYTq
	1v/Oj9HXhyVMcVDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AfTpwCsr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WBcUOWZ3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713547203;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oq8XqxwFPcQM/CL9zXJjO3PeEKmb9xjBrao5d4LVoJk=;
	b=AfTpwCsr9uCz40yV8ZJ0nbUNqmSAH3DU6pYPbZ2I+RoS9yQ20J3ZKXfa0YImoBsYFEQOdk
	ZQD+JOJrFgNN26QhTjJCVjf1Yg6u0WMtiqT5JAOkR1miNGpblFI2B2HNI5MOzZxQ0ytC03
	Y/djNxb19Ls9hLj/XI753qEv+Ncp8Ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713547203;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oq8XqxwFPcQM/CL9zXJjO3PeEKmb9xjBrao5d4LVoJk=;
	b=WBcUOWZ3o+6neYcYFCXevwrGrfea8MWU5t8DnXIjOjvJH2VjV38u8iKXQ4yh+l49c4BYTq
	1v/Oj9HXhyVMcVDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 176F813687;
	Fri, 19 Apr 2024 17:20:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HIWNBcOnImZZJAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 19 Apr 2024 17:20:03 +0000
Date: Fri, 19 Apr 2024 19:12:32 +0200
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 06/11] btrfs: btrfs_recover_relocation rename ret to
 ret2 and err to ret
Message-ID: <20240419171232.GZ3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1713370756.git.anand.jain@oracle.com>
 <a98d6d4d3ac16aaf0e464dfeb9551b4c141a13f0.1713370757.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a98d6d4d3ac16aaf0e464dfeb9551b4c141a13f0.1713370757.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 37758379BD
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]

On Thu, Apr 18, 2024 at 03:08:38PM +0800, Anand Jain wrote:
> Fix the code style for the return variable. First, rename ret to ret2,
> compile it, and then rename err to ret. This method of changing helped
> confirm that there are no instances of the old ret not renamed to ret2.

There's only one place where the ret2 would make sense.

> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2: no change from v1
> 
>  fs/btrfs/relocation.c | 64 +++++++++++++++++++++----------------------
>  1 file changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index bd573a0ec270..0b802d0c5a65 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4222,8 +4222,8 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
>  	struct extent_buffer *leaf;
>  	struct reloc_control *rc = NULL;
>  	struct btrfs_trans_handle *trans;
> -	int ret;
> -	int err = 0;
> +	int ret2;
> +	int ret = 0;
>  
>  	path = btrfs_alloc_path();
>  	if (!path)
> @@ -4235,13 +4235,13 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
>  	key.offset = (u64)-1;
>  
>  	while (1) {
> -		ret = btrfs_search_slot(NULL, fs_info->tree_root, &key,
> +		ret2 = btrfs_search_slot(NULL, fs_info->tree_root, &key,
>  					path, 0, 0);
> -		if (ret < 0) {
> -			err = ret;
> +		if (ret2 < 0) {
> +			ret = ret2;

If you do just ret = ret2 then it's not needed, ret is always reset and
then is some check and 'goto out'. Using ret2 should be only for cases
where the previous value must be preserved.

>  			goto out;
>  		}
> -		if (ret > 0) {
> +		if (ret2 > 0) {
>  			if (path->slots[0] == 0)
>  				break;
>  			path->slots[0]--;
> @@ -4256,7 +4256,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
>  
>  		reloc_root = btrfs_read_tree_root(fs_info->tree_root, &key);
>  		if (IS_ERR(reloc_root)) {
> -			err = PTR_ERR(reloc_root);
> +			ret = PTR_ERR(reloc_root);
>  			goto out;
>  		}
>  
> @@ -4267,14 +4267,14 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
>  			fs_root = btrfs_get_fs_root(fs_info,
>  					reloc_root->root_key.offset, false);
>  			if (IS_ERR(fs_root)) {
> -				ret = PTR_ERR(fs_root);
> -				if (ret != -ENOENT) {
> -					err = ret;
> +				ret2 = PTR_ERR(fs_root);
> +				if (ret2 != -ENOENT) {
> +					ret = ret2;

Same.

>  					goto out;
>  				}
> -				ret = mark_garbage_root(reloc_root);
> -				if (ret < 0) {
> -					err = ret;
> +				ret2 = mark_garbage_root(reloc_root);
> +				if (ret2 < 0) {
> +					ret = ret2;

And here.

>  					goto out;
>  				}
>  			} else {
> @@ -4294,13 +4294,13 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
>  
>  	rc = alloc_reloc_control(fs_info);
>  	if (!rc) {
> -		err = -ENOMEM;
> +		ret = -ENOMEM;
>  		goto out;
>  	}
>  
> -	ret = reloc_chunk_start(fs_info);
> -	if (ret < 0) {
> -		err = ret;
> +	ret2 = reloc_chunk_start(fs_info);
> +	if (ret2 < 0) {
> +		ret = ret2;
>  		goto out_end;
>  	}
>  
> @@ -4310,7 +4310,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
>  
>  	trans = btrfs_join_transaction(rc->extent_root);
>  	if (IS_ERR(trans)) {
> -		err = PTR_ERR(trans);
> +		ret = PTR_ERR(trans);
>  		goto out_unset;
>  	}
>  
> @@ -4330,15 +4330,15 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
>  		fs_root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
>  					    false);
>  		if (IS_ERR(fs_root)) {
> -			err = PTR_ERR(fs_root);
> +			ret = PTR_ERR(fs_root);
>  			list_add_tail(&reloc_root->root_list, &reloc_roots);
>  			btrfs_end_transaction(trans);
>  			goto out_unset;
>  		}
>  
> -		err = __add_reloc_root(reloc_root);
> -		ASSERT(err != -EEXIST);
> -		if (err) {
> +		ret = __add_reloc_root(reloc_root);
> +		ASSERT(ret != -EEXIST);
> +		if (ret) {
>  			list_add_tail(&reloc_root->root_list, &reloc_roots);
>  			btrfs_put_root(fs_root);
>  			btrfs_end_transaction(trans);
> @@ -4348,8 +4348,8 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
>  		btrfs_put_root(fs_root);
>  	}
>  
> -	err = btrfs_commit_transaction(trans);
> -	if (err)
> +	ret = btrfs_commit_transaction(trans);
> +	if (ret)
>  		goto out_unset;
>  
>  	merge_reloc_roots(rc);
> @@ -4358,14 +4358,14 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
>  
>  	trans = btrfs_join_transaction(rc->extent_root);
>  	if (IS_ERR(trans)) {
> -		err = PTR_ERR(trans);
> +		ret = PTR_ERR(trans);
>  		goto out_clean;
>  	}
> -	err = btrfs_commit_transaction(trans);
> +	ret = btrfs_commit_transaction(trans);
>  out_clean:
> -	ret = clean_dirty_subvols(rc);
> -	if (ret < 0 && !err)
> -		err = ret;
> +	ret2 = clean_dirty_subvols(rc);
> +	if (ret2 < 0 && !ret)
> +		ret = ret2;

This is probably the only place where it makes sense but only because
the original code does not directly handle btrfs_commit_transaction()
and calls clean_dirty_subvols(), so the two values have to be checked.

Changing the logic here should be a separate patch so ret2 can stay
otherwise the whole function can use single ret for everything as far as
I can see.

