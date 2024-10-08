Return-Path: <linux-btrfs+bounces-8647-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9559954BB
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 18:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CF66B238F7
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 16:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1952D1E0DF4;
	Tue,  8 Oct 2024 16:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RN6kTTCZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R9nu5N3E";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1NVBZwO3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hicZazAL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97BD46434
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2024 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728405850; cv=none; b=l9iHrsNFhP/LZySt4k6xc7iXDNw5KFsiHByX9uNiNmx3WQbage/XRsxXwjjmf25asgb9zCtlgm3IMXT1IXyVqoIPjcqeXkwGOF1OR65kFMqhpJqsDhxgHaOjkaIF4ZgX3hM+n2pmwX3SZNCg8QlIhUk6MBKNRoIwud2X6h0rF08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728405850; c=relaxed/simple;
	bh=ZoJwVIilP8uuG5nK1EiTjcLjGoAmV1lOOKJjNyYpLTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hP/Cnhf4PRcURLOmyy3rrvm0YiMDrVP2w+WFIe+MpbKwkDHNtGS6l/3e442CPqsekC+iwVl8zbkdk+OgDFILVFR0M46yWh20jcNUkOYMHXZISP3Ayvmonx7WMEqbhgRYZ+psnA0fRlkjtg9/8cw+ZjQCyMpewLBD3eu0EJdxauY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RN6kTTCZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R9nu5N3E; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1NVBZwO3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hicZazAL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A5D221FDFB;
	Tue,  8 Oct 2024 16:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728405847;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r3iGCIZjmFT8KVAXgbDtqyPIDwMb7RsKVX9OUt4AnKc=;
	b=RN6kTTCZkh9vSRsCCEU/30EvIXMaqj3Qi713VJf8D/oim9okQShnV65CPqRfPkNqQOmMn7
	6v4+n9GM/hAbb2anXPhnp8sCTAJcVYRgIIBaiKbC5cAWdY7wgNs454p/SQmQAixpJjtkeo
	whGfQnig1Wlz77c6y/TYXUbkNGyrE4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728405847;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r3iGCIZjmFT8KVAXgbDtqyPIDwMb7RsKVX9OUt4AnKc=;
	b=R9nu5N3EWoJ1Jg+rdT+Q2yeh5U5ZZZp8hOaG1Ii6cTG8PQ8fszj1YYZ1NN+r2LLwAaMwHm
	1aVcwxM7DfV1VTCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1NVBZwO3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hicZazAL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728405845;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r3iGCIZjmFT8KVAXgbDtqyPIDwMb7RsKVX9OUt4AnKc=;
	b=1NVBZwO38N6Id/t7fqp/RRxEC73rpANwe61SOLGzjrYQ2nxCzER8+0l2iNgni0ogDhT0Ec
	N+fXAQu8bVAzBu4IlgGFaFgrojMtxWSfIDe4w5KcgsjbigGw/UzC/HoiP74638b1lTfyir
	uEkQttTzmmRst1yXh6YkM3GzA3gBEfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728405845;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r3iGCIZjmFT8KVAXgbDtqyPIDwMb7RsKVX9OUt4AnKc=;
	b=hicZazALPM7uZHjbXqMmpxggxoNGNnsoDw7WlKfECuVEaHzvfm67FCcS5I2GdEeL9RDum1
	nTudQHjd0pEOI1Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85CD7137CF;
	Tue,  8 Oct 2024 16:44:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id atIoIFVhBWfsTQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 08 Oct 2024 16:44:05 +0000
Date: Tue, 8 Oct 2024 18:43:56 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove btrfs_set_range_writeback()
Message-ID: <20241008164356.GC1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <2c53f7555d45d6697e836fa2bb7dce137ab04c99.1728175215.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c53f7555d45d6697e836fa2bb7dce137ab04c99.1728175215.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: A5D221FDFB
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

I have more comments on the grammar than on the code, sorry.

On Sun, Oct 06, 2024 at 11:10:22AM +1030, Qu Wenruo wrote:
> The function btrfs_set_range_writeback() is originally a callback for
                                           was

> metadata and data, to mark a range with writeback flag.
> 
> Then it was converted into a common function call for both metadata and
> data.
> 
> >From the very beginning, the function is only called on a full page,
                                         'had been' because of the other past tense, idk

> later converted to handle range inside a page.
> 
> But it never needs to handle multiple pages, and since commit
               needed

> 8189197425e7 ("btrfs: refactor __extent_writepage_io() to do
> sector-by-sector submission") the function is only called on a
                                             has been

> sector-by-sector basis.
> 
> This makes the function unnecessary, and can be converted to a simple
> btrfs_folio_set_writeback() call instead.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/btrfs_inode.h |  1 -
>  fs/btrfs/extent_io.c   |  2 +-
>  fs/btrfs/inode.c       | 22 ----------------------
>  3 files changed, 1 insertion(+), 24 deletions(-)
> 
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index e152fde888fc..c514bab532fa 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -577,7 +577,6 @@ void btrfs_merge_delalloc_extent(struct btrfs_inode *inode, struct extent_state
>  				 struct extent_state *other);
>  void btrfs_split_delalloc_extent(struct btrfs_inode *inode,
>  				 struct extent_state *orig, u64 split);
> -void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u64 end);
>  void btrfs_evict_inode(struct inode *inode);
>  struct inode *btrfs_alloc_inode(struct super_block *sb);
>  void btrfs_destroy_inode(struct inode *inode);
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 9fbc83c76b94..d87dcafab537 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1359,7 +1359,7 @@ static int submit_one_sector(struct btrfs_inode *inode,
>  	 * a folio for a range already written to disk.
>  	 */
>  	btrfs_folio_clear_dirty(fs_info, folio, filepos, sectorsize);
> -	btrfs_set_range_writeback(inode, filepos, filepos + sectorsize - 1);
> +	btrfs_folio_set_writeback(fs_info, folio, filepos, sectorsize);
>  	/*
>  	 * Above call should set the whole folio with writeback flag, even
>  	 * just for a single subpage sector.
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 103ec917ca9d..21e51924742a 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8939,28 +8939,6 @@ static int btrfs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
>  	return finish_open_simple(file, ret);
>  }
>  
> -void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u64 end)
> -{
> -	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> -	unsigned long index = start >> PAGE_SHIFT;
> -	unsigned long end_index = end >> PAGE_SHIFT;
> -	struct folio *folio;
> -	u32 len;
> -
> -	ASSERT(end + 1 - start <= U32_MAX);
> -	len = end + 1 - start;
> -	while (index <= end_index) {
> -		folio = __filemap_get_folio(inode->vfs_inode.i_mapping, index, 0, 0);
> -		ASSERT(!IS_ERR(folio)); /* folios should be in the extent_io_tree */
> -
> -		/* This is for data, which doesn't yet support larger folio. */
> -		ASSERT(folio_order(folio) == 0);
> -		btrfs_folio_set_writeback(fs_info, folio, start, len);

So the new code is just btrfs_folio_set_writeback(), with the removed
comment and assertion, what's the status regarding large folios?

I assume that this now implicitly supports them, we don't necessarily
need the assertion as I think we have more places where this would be
detected.

