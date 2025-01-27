Return-Path: <linux-btrfs+bounces-11091-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B485AA2002A
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2025 22:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1186F165670
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2025 21:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EFE1D89F8;
	Mon, 27 Jan 2025 21:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d4BdmcbR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ECDEqBBR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d4BdmcbR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ECDEqBBR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B8C1DA4E
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2025 21:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738015031; cv=none; b=YDRSDoM/RG+KW0EzIywGPjEM0+JjpfMTPy/5jzUmdZgfPAhozRUGjRx6if5pdzlmvQjuoEnwGpR4N8fRlFKRfDakg1J3PR5Jj+Web/dZQMSxaYVOaeiQhrTkYGJPtJGe9bCnzLlWv0yuWD2ukjUzxbbHvRMKxhCIs27DWcaWcgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738015031; c=relaxed/simple;
	bh=/IuSxFjOVQzYdIhLduAjTi3BWgTZeXHgYFN6Sl9JFTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faIwPRC5NnJLh8ma/r8Avb5zsbWJA6L79M6U5iqRze/b9JPsbrWZ5Sl29CsPyD0/oP51h8QKi/s5nCx4fdS2AJ7K0fPCMDTiNs0fZqtRSWe2k2UkiEGfvWqZkqROGhc5Bvj2YHgFis3KcpDw6Wkk7JxTzmzW2+7IH/TRZCdwbKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d4BdmcbR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ECDEqBBR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d4BdmcbR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ECDEqBBR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 099F7210F4;
	Mon, 27 Jan 2025 21:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738015027;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=43MTekZNGgzN/VtLHqpb5fWY2K+ic2K3NbvDS66a/2I=;
	b=d4BdmcbRx3X/0yT/77jHsb6tC2wEKOpGBXSqawHl7mCTTx8595m6N74N1mXcjp4myZi1j4
	3aB4gclZPgLWAMSDB+6/z3srWZsEpzcFGNZWfp70MLw88qXMsiFt1rJ3haUDlL6+dWpc7A
	8rObBgJRjUk/557MOcVWRaLJL8wujdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738015027;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=43MTekZNGgzN/VtLHqpb5fWY2K+ic2K3NbvDS66a/2I=;
	b=ECDEqBBRRmJtM6pljk+QqsQNOw1BHfUsqSedku3LTkUTGvATCqAo7iH0zGe0Hk0y2ceEwu
	JofSdaC9YoX2jVAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738015027;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=43MTekZNGgzN/VtLHqpb5fWY2K+ic2K3NbvDS66a/2I=;
	b=d4BdmcbRx3X/0yT/77jHsb6tC2wEKOpGBXSqawHl7mCTTx8595m6N74N1mXcjp4myZi1j4
	3aB4gclZPgLWAMSDB+6/z3srWZsEpzcFGNZWfp70MLw88qXMsiFt1rJ3haUDlL6+dWpc7A
	8rObBgJRjUk/557MOcVWRaLJL8wujdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738015027;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=43MTekZNGgzN/VtLHqpb5fWY2K+ic2K3NbvDS66a/2I=;
	b=ECDEqBBRRmJtM6pljk+QqsQNOw1BHfUsqSedku3LTkUTGvATCqAo7iH0zGe0Hk0y2ceEwu
	JofSdaC9YoX2jVAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBD7D137C0;
	Mon, 27 Jan 2025 21:57:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0oRtNTIBmGckPwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 27 Jan 2025 21:57:06 +0000
Date: Mon, 27 Jan 2025 22:57:05 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: export per-inode stable writes flag
Message-ID: <20250127215705.GU5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <31652cd455fd5814440672e8bed8f1361d53f459.1737692275.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31652cd455fd5814440672e8bed8f1361d53f459.1737692275.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Jan 24, 2025 at 02:49:28PM +1030, Qu Wenruo wrote:
> The address space flag AS_STABLE_WRITES determine if FGP_STABLE for will
> wait for the folio to finish its writeback.
> 
> For btrfs, due to the default data checksum behavior, if we modify the
> folio while it's still under writeback, it will cause data checksum
> mismatch.
> Thus for quite some call sites we manually call folio_wait_writeback()
> to prevent such problem from happneing.
> 
> Currently there is only one call site inside btrfs really utilize
> FGP_STABLE, and in that case we also manually call folio_wait_writeback()
> to do the wait.
> 
> But it's better to properly export the stable writes flag to a per-inode
> basis.

I think 'export' is a bit confusing here, exporing for who?

> 
> This involves:
> 
> - Update the mapping's stable write flag when setting/clearing NODATASUM
>   inode flag using ioctl
>   This only works for empty files, so it should be fine.
> 
> - Update the mapping's stable write flag when reading an inode from disk
> 
> - Remove the explicitly folio_wait_writeback() for FGP_BEGINWRITE call
>   site
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Remove the superblock SB_I_STABLE_WRITES flag
>   Since we're setting the proper flag for each inode, there is no need
>   to bother the superblock flag anymore.
> ---
>  fs/btrfs/btrfs_inode.h | 8 ++++++++
>  fs/btrfs/file.c        | 1 -
>  fs/btrfs/inode.c       | 2 ++
>  fs/btrfs/ioctl.c       | 8 ++++++--
>  4 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index b2fa33911c28..b090a435675a 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -516,6 +516,14 @@ static inline void btrfs_assert_inode_locked(struct btrfs_inode *inode)
>  	lockdep_assert_held(&inode->vfs_inode.i_rwsem);
>  }
>  
> +static inline void btrfs_update_address_space_flags(struct btrfs_inode *inode)

I suggest to rename it to btrfs_update_inode_mapping_flags(), namely to
mention 'mapping' in the name because this is more common.

> +{
> +	if (inode->flags & BTRFS_INODE_NODATASUM)
> +		mapping_clear_stable_writes(inode->vfs_inode.i_mapping);
> +	else
> +		mapping_set_stable_writes(inode->vfs_inode.i_mapping);
> +}
> +
>  /* Array of bytes with variable length, hexadecimal format 0x1234 */
>  #define CSUM_FMT				"0x%*phN"
>  #define CSUM_FMT_VALUE(size, bytes)		size, bytes
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index bb821fb89fc1..68b14ee1f85c 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -875,7 +875,6 @@ static noinline int prepare_one_folio(struct inode *inode, struct folio **folio_
>  			ret = PTR_ERR(folio);
>  		return ret;
>  	}
> -	folio_wait_writeback(folio);
>  	/* Only support page sized folio yet. */
>  	ASSERT(folio_order(folio) == 0);
>  	ret = set_folio_extent_mapped(folio);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 5b3fdba10245..c4769c438859 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3948,6 +3948,7 @@ static int btrfs_read_locked_inode(struct inode *inode, struct btrfs_path *path)
>  
>  	btrfs_inode_split_flags(btrfs_inode_flags(leaf, inode_item),
>  				&BTRFS_I(inode)->flags, &BTRFS_I(inode)->ro_flags);
> +	btrfs_update_address_space_flags(BTRFS_I(inode));
>  
>  cache_index:
>  	/*
> @@ -6363,6 +6364,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
>  		if (btrfs_test_opt(fs_info, NODATACOW))
>  			BTRFS_I(inode)->flags |= BTRFS_INODE_NODATACOW |
>  				BTRFS_INODE_NODATASUM;
> +		btrfs_update_address_space_flags(BTRFS_I(inode));
>  	}
>  
>  	ret = btrfs_insert_inode_locked(inode);
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 69c0444369b7..c70e4d2d9b27 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -325,9 +325,11 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
>  			 * Otherwise we want the flag to reflect the real COW
>  			 * status of the file and will not set it.
>  			 */
> -			if (inode->i_size == 0)
> +			if (inode->i_size == 0) {
>  				binode_flags |= BTRFS_INODE_NODATACOW |
>  						BTRFS_INODE_NODATASUM;
> +				btrfs_update_address_space_flags(binode);

Does this really work? Here the NODATASUM bit is set on a local variable
that is not synced to 'binode' yet.

> +			}
>  		} else {
>  			binode_flags |= BTRFS_INODE_NODATACOW;
>  		}
> @@ -336,9 +338,11 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
>  		 * Revert back under same assumptions as above
>  		 */
>  		if (S_ISREG(inode->i_mode)) {
> -			if (inode->i_size == 0)
> +			if (inode->i_size == 0) {
>  				binode_flags &= ~(BTRFS_INODE_NODATACOW |
>  						  BTRFS_INODE_NODATASUM);
> +				btrfs_update_address_space_flags(binode);

Same here.

The mapping flag update should be done somewhere in the update_flags:
label.

> +			}
>  		} else {
>  			binode_flags &= ~BTRFS_INODE_NODATACOW;
>  		}
> -- 
> 2.48.1
> 

