Return-Path: <linux-btrfs+bounces-7177-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF35950F2F
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 23:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6561B22888
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 21:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1576B1A76C7;
	Tue, 13 Aug 2024 21:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UN1TUlBz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FUbpc1Zn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UN1TUlBz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FUbpc1Zn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397ED17CC
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Aug 2024 21:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723584886; cv=none; b=FDzUHSljPCwxWnfzVeNu38IySkw2OA45cDVYv9l/UJidq3Fz+z+0AzP1610rM47Avl26YisNd9hnM6QOS5RFKhBXJirBnCXS5c7ry/Pm4l5KR7w3MKTA/+yQPcZZYPBFqbpdL2YiIyz9kbCS7AjteG+gdHmMJGYJwhmHoI3477M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723584886; c=relaxed/simple;
	bh=wcSo9OrL9zLfvNilGOlzdc9MKzgxC/g0bOJUvcItFb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMd0efcTG/6F6w7k9blyjxR2q7dY1jtpzsL66xd21WXHX7KEPNNXy8RayqR/vFEhgF38128BrcRB8Sr7eaEUjnwTIC4TkOD+4h/3MkJ+vHbFnhOQXgMRDloka/9oAR2ctus3DBEtq0Y/JjYUT19HChgy8fz++umDmiK8FYXuydo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UN1TUlBz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FUbpc1Zn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UN1TUlBz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FUbpc1Zn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3240822346;
	Tue, 13 Aug 2024 21:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723584881;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cqyuAfGGp5TDLq1OvOaAoMsu1FxMaU6ZLJvSagwv/yo=;
	b=UN1TUlBzmA+SDeL8Xyv51/D8qhr5whOY/X1f5AF2oCi7wM89MUTslbw7lRP97PutNx1ArS
	wp6lygDjGANw2nhD9AhziWSz5QAms3e8D1Bl9rKhSzKxWUWD0unXZtMZT/L0s8v0wnDVrH
	M2O90L43Nni7YQ3QA7IDL0iTIF94IfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723584881;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cqyuAfGGp5TDLq1OvOaAoMsu1FxMaU6ZLJvSagwv/yo=;
	b=FUbpc1Znw6ykGYmdqlweE2FatFKpBbTzaJ6MZVst15ohy4cH7HTkBV3k9a6ql08w+afnNG
	ZvXbg5dCpmEmeUCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UN1TUlBz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FUbpc1Zn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723584881;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cqyuAfGGp5TDLq1OvOaAoMsu1FxMaU6ZLJvSagwv/yo=;
	b=UN1TUlBzmA+SDeL8Xyv51/D8qhr5whOY/X1f5AF2oCi7wM89MUTslbw7lRP97PutNx1ArS
	wp6lygDjGANw2nhD9AhziWSz5QAms3e8D1Bl9rKhSzKxWUWD0unXZtMZT/L0s8v0wnDVrH
	M2O90L43Nni7YQ3QA7IDL0iTIF94IfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723584881;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cqyuAfGGp5TDLq1OvOaAoMsu1FxMaU6ZLJvSagwv/yo=;
	b=FUbpc1Znw6ykGYmdqlweE2FatFKpBbTzaJ6MZVst15ohy4cH7HTkBV3k9a6ql08w+afnNG
	ZvXbg5dCpmEmeUCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11EC2136A2;
	Tue, 13 Aug 2024 21:34:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sF0kBHHRu2ajGQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 13 Aug 2024 21:34:41 +0000
Date: Tue, 13 Aug 2024 23:34:39 +0200
From: David Sterba <dsterba@suse.cz>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] btrfs: use __free to automatically free btrfs_path
 on exit
Message-ID: <20240813213439.GT25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1723245033.git.loemra.dev@gmail.com>
 <d7b68e60fac6c4d73214854f08cf755f781edf00.1723245033.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7b68e60fac6c4d73214854f08cf755f781edf00.1723245033.git.loemra.dev@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.21
X-Rspamd-Queue-Id: 3240822346
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO

On Fri, Aug 09, 2024 at 04:11:49PM -0700, Leo Martins wrote:
> Introduces the __free attribute to xattr.c. Marks the path variable in
> the btrfs_getxattr(), btrfs_setxattr(), and btrfs_listxattr() functions
> with the __free(btrfs_free_path) attribute. When a variable is marked
> with the __free attribute, the kernel will automatically call the
> specified function (in this case, btrfs_free_path()) on the variable
> when it goes out of scope. This ensures that the memory allocated for
> the variable is properly released, preventing potential memory leaks. By
> using the __free attribute, we can simplify the code and reduce the risk
> of memory-related bugs.
> 
> Test Plan:
> Built and booted the kernel with patch applied
> Ran btrfs/fstests to make sure that no regressions were introduced
> 
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> ---
>  fs/btrfs/xattr.c | 28 ++++++++--------------------
>  1 file changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
> index 738c7bb8ea7c..a8d5db02202b 100644
> --- a/fs/btrfs/xattr.c
> +++ b/fs/btrfs/xattr.c
> @@ -29,9 +29,8 @@ int btrfs_getxattr(const struct inode *inode, const char *name,
>  {
>  	struct btrfs_dir_item *di;
>  	struct btrfs_root *root = BTRFS_I(inode)->root;
> -	struct btrfs_path *path;
> +	struct btrfs_path *path __free(btrfs_free_path) = NULL;
>  	struct extent_buffer *leaf;
> -	int ret = 0;
>  	unsigned long data_ptr;
>  
>  	path = btrfs_alloc_path();
> @@ -42,24 +41,20 @@ int btrfs_getxattr(const struct inode *inode, const char *name,
>  	di = btrfs_lookup_xattr(NULL, root, path, btrfs_ino(BTRFS_I(inode)),
>  			name, strlen(name), 0);
>  	if (!di) {
> -		ret = -ENODATA;
> -		goto out;
> +		return -ENODATA;
>  	} else if (IS_ERR(di)) {
> -		ret = PTR_ERR(di);
> -		goto out;
> +		return PTR_ERR(di);
>  	}
>  
>  	leaf = path->nodes[0];
>  	/* if size is 0, that means we want the size of the attr */
>  	if (!size) {
> -		ret = btrfs_dir_data_len(leaf, di);
> -		goto out;
> +		return btrfs_dir_data_len(leaf, di);
>  	}
>  
>  	/* now get the data out of our dir_item */
>  	if (btrfs_dir_data_len(leaf, di) > size) {
> -		ret = -ERANGE;
> -		goto out;
> +		return -ERANGE;
>  	}
>  
>  	/*
> @@ -73,11 +68,7 @@ int btrfs_getxattr(const struct inode *inode, const char *name,
>  				   btrfs_dir_name_len(leaf, di));
>  	read_extent_buffer(leaf, buffer, data_ptr,
>  			   btrfs_dir_data_len(leaf, di));
> -	ret = btrfs_dir_data_len(leaf, di);
> -
> -out:
> -	btrfs_free_path(path);
> -	return ret;
> +	return btrfs_dir_data_len(leaf, di);
>  }
>  
>  int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
> @@ -86,7 +77,7 @@ int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
>  	struct btrfs_dir_item *di = NULL;
>  	struct btrfs_root *root = BTRFS_I(inode)->root;
>  	struct btrfs_fs_info *fs_info = root->fs_info;
> -	struct btrfs_path *path;
> +	struct btrfs_path *path __free(btrfs_free_path) = NULL;
>  	size_t name_len = strlen(name);
>  	int ret = 0;
>  
> @@ -214,7 +205,6 @@ int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
>  		 */
>  	}
>  out:
> -	btrfs_free_path(path);

I replied to the cover letter, this is the example where removing the
explicit free is delayed after the code below

>  	if (!ret) {
>  		set_bit(BTRFS_INODE_COPY_EVERYTHING,
>  			&BTRFS_I(inode)->runtime_flags);

which in full is

218         if (!ret) {
219                 set_bit(BTRFS_INODE_COPY_EVERYTHING,
220                         &BTRFS_I(inode)->runtime_flags);
221                 clear_bit(BTRFS_INODE_NO_XATTRS, &BTRFS_I(inode)->runtime_flags);
222         }
223	    return ret;

so path is locked when the calls set_bit and clear_bit are done. Not
critical in this case but an example where resource is not released as
soon as possible.

