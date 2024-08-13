Return-Path: <linux-btrfs+bounces-7178-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB171950FA3
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 00:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3AC28147B
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 22:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B741AB501;
	Tue, 13 Aug 2024 22:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jERmpuR7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="t2lSk3An";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jERmpuR7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="t2lSk3An"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C77856766
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Aug 2024 22:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723587719; cv=none; b=k4pUCdC+wn2WiCoB1IwbKe0LnLZQQKwAX+Uwa3BNh9pskkLwRBBgnLENw2/5vAqjEfEZM6ju3Q76/jzmkQcOOaBI0VK1ddVgsS0OuMfMtraqaPNZf7oOe7x7TZibdNxvcY42u/Lk6qnAJplVwmt0HAIxMRNCAROFfptsoNHONjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723587719; c=relaxed/simple;
	bh=EwsFGMx0voNSvx7QqJ7BEOQZqP5rLt24HulCrF7G0D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HM0boWtMFUOL0CFpR9LMa7SHyfpWLkO1VMcdOCU4vShVOcLsUupvw0ZA08PC+qC+bbtE1IcFGX/9FhJUzi/b74Ze0RXEXZDSK/N6El4003OsO6mHB/RmPzjhFQYbiMYQrvphPj8uJ0fSAGGgjQcKdN70yOqaAyRrCGOb8KgHNCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jERmpuR7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=t2lSk3An; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jERmpuR7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=t2lSk3An; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 346CA1F7BD;
	Tue, 13 Aug 2024 22:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723587715;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8rI5ulRadfPBa1q9upbM2EKmjrkw9SqEQQy+yHQmRp8=;
	b=jERmpuR7hxfd0BRPHrGxUvYgmB2DpCFacEf04QleH4K7QwKZOwICgorhRpCmhh1CZcxsrZ
	OAelEUkTozQxGk7BWX/BjlW7nRH3NMn97RxzwHSsfNJemNzfYrnUCxssd5LKDAADyK1lYH
	MhYUlcm7lVu+sY7/Cu3SE8czxJqM27c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723587715;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8rI5ulRadfPBa1q9upbM2EKmjrkw9SqEQQy+yHQmRp8=;
	b=t2lSk3AnVcpxJdyPaFXBhqpWrsYE3SF0q4w57PeGFGYQDcZXEAiWr//H1WP+zxlZke+4pk
	Jz3i/VVrqEjuuLCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723587715;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8rI5ulRadfPBa1q9upbM2EKmjrkw9SqEQQy+yHQmRp8=;
	b=jERmpuR7hxfd0BRPHrGxUvYgmB2DpCFacEf04QleH4K7QwKZOwICgorhRpCmhh1CZcxsrZ
	OAelEUkTozQxGk7BWX/BjlW7nRH3NMn97RxzwHSsfNJemNzfYrnUCxssd5LKDAADyK1lYH
	MhYUlcm7lVu+sY7/Cu3SE8czxJqM27c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723587715;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8rI5ulRadfPBa1q9upbM2EKmjrkw9SqEQQy+yHQmRp8=;
	b=t2lSk3AnVcpxJdyPaFXBhqpWrsYE3SF0q4w57PeGFGYQDcZXEAiWr//H1WP+zxlZke+4pk
	Jz3i/VVrqEjuuLCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13924136A2;
	Tue, 13 Aug 2024 22:21:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wp1ABIPcu2bpJAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 13 Aug 2024 22:21:55 +0000
Date: Wed, 14 Aug 2024 00:21:53 +0200
From: David Sterba <dsterba@suse.cz>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs: remove conditional path allocation from
 read_locked_inode, add path allocation to iget
Message-ID: <20240813222153.GU25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1723580508.git.loemra.dev@gmail.com>
 <32dea3edada81f7901f7f7e39f4e3729888dea46.1723580508.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32dea3edada81f7901f7f7e39f4e3729888dea46.1723580508.git.loemra.dev@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Aug 13, 2024 at 01:27:33PM -0700, Leo Martins wrote:
> Move the path allocation from inside btrfs_read_locked_inode to
> btrfs_iget. This makes the code easier to reason about as it is clear
> where the allocation occurs and who is in charge of freeing the path.
> I have investigated all of the callers of btrfs_iget_path to make sure 
> that it is never called with a null path with the expectation
> of a path allocation. All of the null calls seem to come from btrfs_iget
> so it makes sense to do the allocation within btrfs_iget.

This looks like a good cleanup. The path argument was added to fix some
problem in the past, 4222ea7100c0e3 ("Btrfs: fix deadlock on tree root
leaf when finding free extent") but doing the allocation in the caller
makes things more clear.

> ---
>  fs/btrfs/inode.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 07858d63378f..b89b4b1bd3da 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3790,10 +3790,9 @@ static int btrfs_init_file_extent_tree(struct btrfs_inode *inode)
>   * read an inode from the btree into the in-memory inode
>   */
>  static int btrfs_read_locked_inode(struct inode *inode,
> -				   struct btrfs_path *in_path)
> +				   struct btrfs_path *path)
>  {
>  	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
> -	struct btrfs_path *path = in_path;
>  	struct extent_buffer *leaf;
>  	struct btrfs_inode_item *inode_item;
>  	struct btrfs_root *root = BTRFS_I(inode)->root;
> @@ -3813,18 +3812,10 @@ static int btrfs_read_locked_inode(struct inode *inode,
>  	if (!ret)
>  		filled = true;

You can add an ASSERT(path)

>  
> -	if (!path) {
> -		path = btrfs_alloc_path();
> -		if (!path)
> -			return -ENOMEM;
> -	}
> -
>  	btrfs_get_inode_key(BTRFS_I(inode), &location);
>  
>  	ret = btrfs_lookup_inode(NULL, root, path, &location, 0);
>  	if (ret) {
> -		if (path != in_path)
> -			btrfs_free_path(path);
>  		return ret;
>  	}
>  
> @@ -3960,8 +3951,6 @@ static int btrfs_read_locked_inode(struct inode *inode,
>  				  btrfs_ino(BTRFS_I(inode)),
>  				  btrfs_root_id(root), ret);
>  	}
> -	if (path != in_path)
> -		btrfs_free_path(path);
>  
>  	if (!maybe_acls)
>  		cache_no_acl(inode);
> @@ -5631,7 +5620,15 @@ struct inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
>  
>  struct inode *btrfs_iget(u64 ino, struct btrfs_root *root)
>  {
> -	return btrfs_iget_path(ino, root, NULL);
> +	struct btrfs_path *path = btrfs_alloc_path();
> +
> +	if (!path)
> +		return ERR_PTR(-ENOMEM);
> +
> +	struct inode *inode = btrfs_iget_path(ino, root, path);

In kernel the declaration block should be contiguous, ie. not mixed with
statements like that. Also, we don't do allocatios (and other
non-trivial assignments that require error handling) in the declaration
block. This may different in other parts of kernel, in btrfs it's the
preferred way.

