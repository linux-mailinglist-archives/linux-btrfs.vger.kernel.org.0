Return-Path: <linux-btrfs+bounces-5166-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0898CB11D
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 17:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384EE1C218A3
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 15:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C2E142E7E;
	Tue, 21 May 2024 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="As7V72mG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/4RAMog3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="As7V72mG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/4RAMog3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2AA1FDD
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716304713; cv=none; b=Do8TBKwkj/eS4kfGihqutk8ScCXhZrc9Qw7gS15gspJIqgEqCpx4HGZfmJHvdEg1n8V4caSg7rT1kkeMjjgmyVIu3Luszk6g5VHKKTm6EbZm17YvnllzTnJTJvl27KTuq9z7q5EVuoIxYyYF8wx7bS36RZqG8m881UB5iZZVBg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716304713; c=relaxed/simple;
	bh=7pQFKiBBfJMGCugr8eMZnv9MwcrLKUUZOmH5BgsnQtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edhYjcn+mlqKfoyTQxd5WP/DM0TPiz6jKsa7ncRdwzLlYbI1o7ehJ3Zz8RO0AI8Jn9SDRfgHIOb28TfJvwpdCAFk3HNFqp9vVIjmtsDEQs+p/LXpadFalu/WIuUBm3mjEIOblaWgyNYNOvKfTmQRDOlOv93rOkvlv9VIJYuA3l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=As7V72mG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/4RAMog3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=As7V72mG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/4RAMog3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3EB975C267;
	Tue, 21 May 2024 15:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716304706;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dma/xus879AVNxdYu0cfJk2jAXgGXzTSsXXYhiZ1jr8=;
	b=As7V72mG3uhfJojLxihV2tkJ7RJpF0QJbMBB5shkr4tYcOK2k9mR9NLxnDQUXST3NwZ/Uf
	ppMwDYqnbcmbkJ60lOJ9p9sj3v8PXTv2tg/XLrybvlntLl+uYC5i+rJEHAnBJMavdo8FQn
	Lp8IpgXZf9QkQfmEF+4Pf7fPIC3Df+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716304706;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dma/xus879AVNxdYu0cfJk2jAXgGXzTSsXXYhiZ1jr8=;
	b=/4RAMog3MW6wxjkgVVgNGHEPhMQze+d9R/4FMkn1Kghreis/bDEXwoedJXqixZO4ibyiHf
	gb2EVtXSP2F81FCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=As7V72mG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/4RAMog3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716304706;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dma/xus879AVNxdYu0cfJk2jAXgGXzTSsXXYhiZ1jr8=;
	b=As7V72mG3uhfJojLxihV2tkJ7RJpF0QJbMBB5shkr4tYcOK2k9mR9NLxnDQUXST3NwZ/Uf
	ppMwDYqnbcmbkJ60lOJ9p9sj3v8PXTv2tg/XLrybvlntLl+uYC5i+rJEHAnBJMavdo8FQn
	Lp8IpgXZf9QkQfmEF+4Pf7fPIC3Df+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716304706;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dma/xus879AVNxdYu0cfJk2jAXgGXzTSsXXYhiZ1jr8=;
	b=/4RAMog3MW6wxjkgVVgNGHEPhMQze+d9R/4FMkn1Kghreis/bDEXwoedJXqixZO4ibyiHf
	gb2EVtXSP2F81FCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A86013685;
	Tue, 21 May 2024 15:18:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y+JKBkK7TGbjSQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 21 May 2024 15:18:26 +0000
Date: Tue, 21 May 2024 17:18:20 +0200
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 6/6] btrfs: rename and optimize return variable in
 btrfs_find_orphan_roots
Message-ID: <20240521151820.GP17126@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1715783315.git.anand.jain@oracle.com>
 <7b9f87e3ca3368648e9df1d124161a6d4b8e1e9a.1715783315.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b9f87e3ca3368648e9df1d124161a6d4b8e1e9a.1715783315.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3EB975C267
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
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]

On Thu, May 16, 2024 at 07:12:15PM +0800, Anand Jain wrote:
> The variable err is the actual return value of this function, and the
> variable ret is a helper variable for err, which actually is not
> needed and can be handled just by err, which is renamed to ret.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v3: drop ret2 as there is no need for it.
> v2: n/a
>  fs/btrfs/root-tree.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> index 33962671a96c..c11b0bccf513 100644
> --- a/fs/btrfs/root-tree.c
> +++ b/fs/btrfs/root-tree.c
> @@ -220,8 +220,7 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
>  	struct btrfs_path *path;
>  	struct btrfs_key key;
>  	struct btrfs_root *root;
> -	int err = 0;
> -	int ret;
> +	int ret = 0;
>  
>  	path = btrfs_alloc_path();
>  	if (!path)
> @@ -235,18 +234,19 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
>  		u64 root_objectid;
>  
>  		ret = btrfs_search_slot(NULL, tree_root, &key, path, 0, 0);
> -		if (ret < 0) {
> -			err = ret;
> +		if (ret < 0)
>  			break;
> -		}
> +		ret = 0;

Should this be handled when ret > 0? This would be unexpected and
probably means a corruption but simply overwriting the value does not
seem right.

>  
>  		leaf = path->nodes[0];
>  		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
>  			ret = btrfs_next_leaf(tree_root, path);
>  			if (ret < 0)
> -				err = ret;
> -			if (ret != 0)
>  				break;
> +			if (ret > 0) {
> +				ret = 0;
> +				break;
> +			}
>  			leaf = path->nodes[0];
>  		}
>  
> @@ -261,26 +261,26 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
>  		key.offset++;
>  
>  		root = btrfs_get_fs_root(fs_info, root_objectid, false);
> -		err = PTR_ERR_OR_ZERO(root);
> -		if (err && err != -ENOENT) {
> +		ret = PTR_ERR_OR_ZERO(root);
> +		if (ret && ret != -ENOENT) {
>  			break;
> -		} else if (err == -ENOENT) {
> +		} else if (ret == -ENOENT) {
>  			struct btrfs_trans_handle *trans;
>  
>  			btrfs_release_path(path);
>  
>  			trans = btrfs_join_transaction(tree_root);
>  			if (IS_ERR(trans)) {
> -				err = PTR_ERR(trans);
> -				btrfs_handle_fs_error(fs_info, err,
> +				ret = PTR_ERR(trans);
> +				btrfs_handle_fs_error(fs_info, ret,
>  					    "Failed to start trans to delete orphan item");
>  				break;
>  			}
> -			err = btrfs_del_orphan_item(trans, tree_root,
> +			ret = btrfs_del_orphan_item(trans, tree_root,
>  						    root_objectid);
>  			btrfs_end_transaction(trans);
> -			if (err) {
> -				btrfs_handle_fs_error(fs_info, err,
> +			if (ret) {
> +				btrfs_handle_fs_error(fs_info, ret,
>  					    "Failed to delete root orphan item");
>  				break;
>  			}
> @@ -311,7 +311,7 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
>  	}
>  
>  	btrfs_free_path(path);
> -	return err;
> +	return ret;
>  }
>  
>  /* drop the root item for 'key' from the tree root */
> -- 
> 2.38.1
> 

