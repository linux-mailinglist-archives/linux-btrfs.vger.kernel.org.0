Return-Path: <linux-btrfs+bounces-18318-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F76C0830F
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 23:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CF094F7A9B
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 21:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3E330499B;
	Fri, 24 Oct 2025 21:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dDnV5gxM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JUUg11im";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dDnV5gxM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JUUg11im"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD963043CA
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 21:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761341370; cv=none; b=UT1Zz28x33bpVaTpd/3s5LZs00ZKTWn8CUkgGqzbTHhzAv9emGXXV73A2mzZ5xCQfU9ZsfQzFqglWwIUWgATb20fVmsnr4Auejyi9b9OUxEccHeKhzCjs6OOkVhIA6HjiD+PZtYgbryWwAdH0RfvusRF5jB781sjQr5wGqY0YmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761341370; c=relaxed/simple;
	bh=jA/317FvLSz6Zuqe5saUSIcMq7LFhAEZKetWsWTUc6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7w4XWcqA6jf4yLUNnnVhe8/1B9Bg7XACOuVD/h4P+qZdR17K62rqs4MdcHiyC+ftOMw0Xr5g+OmE4CPZoOpFP47zkeux8FaqDVHXqmMlGby+nq5Rn1o7Q8uFNZIjeLazAE0zxVB2Q25xqq4dHil3zI9O9rusn6bnpwFr1FdF6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dDnV5gxM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JUUg11im; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dDnV5gxM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JUUg11im; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3F6DD211EA;
	Fri, 24 Oct 2025 21:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761341366;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HxGMwtupwS55szZ7ieVpxS4PkXaegDIVz4cEJbVEacY=;
	b=dDnV5gxMRxztsLkJ7f40gbciP22UraM09AxIbTROTIlbZQmAnzVBqTs4zpAytpnIHtE3kx
	vhKwHEqAYX8Hjr9jCOORmcDUH//jnXZC79DVuOS3qF5/T97sW/kk5dQX5MqlcBgxHmpqJi
	sb1tRsxAWqBtic8FXsoF+uO72LfqUNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761341366;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HxGMwtupwS55szZ7ieVpxS4PkXaegDIVz4cEJbVEacY=;
	b=JUUg11imwQy3l2js6mdrtlMr9cNGnjwWPJbuDT5LlpBRbwXJIemWVFHyozBOSN2GpZRF37
	tEQYO7de+Eiga3Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761341366;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HxGMwtupwS55szZ7ieVpxS4PkXaegDIVz4cEJbVEacY=;
	b=dDnV5gxMRxztsLkJ7f40gbciP22UraM09AxIbTROTIlbZQmAnzVBqTs4zpAytpnIHtE3kx
	vhKwHEqAYX8Hjr9jCOORmcDUH//jnXZC79DVuOS3qF5/T97sW/kk5dQX5MqlcBgxHmpqJi
	sb1tRsxAWqBtic8FXsoF+uO72LfqUNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761341366;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HxGMwtupwS55szZ7ieVpxS4PkXaegDIVz4cEJbVEacY=;
	b=JUUg11imwQy3l2js6mdrtlMr9cNGnjwWPJbuDT5LlpBRbwXJIemWVFHyozBOSN2GpZRF37
	tEQYO7de+Eiga3Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 147F4132C2;
	Fri, 24 Oct 2025 21:29:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lGXIBLbv+2i0UQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 24 Oct 2025 21:29:26 +0000
Date: Fri, 24 Oct 2025 23:29:20 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: Re: [PATCH 3/8] btrfs-progs: start tracking extent encryption
 context info
Message-ID: <20251024212920.GE20913@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251015121157.1348124-1-neelx@suse.com>
 <20251015121157.1348124-4-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015121157.1348124-4-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.981];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Wed, Oct 15, 2025 at 02:11:51PM +0200, Daniel Vacek wrote:
> From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> 
> This recapitulates the kernel change named 'btrfs: start tracking extent
> encryption context info".
> 
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> ---
>  kernel-shared/accessors.h       | 43 ++++++++++++++++++++++
>  kernel-shared/tree-checker.c    | 65 +++++++++++++++++++++++++++------
>  kernel-shared/uapi/btrfs_tree.h | 23 +++++++++++-
>  3 files changed, 118 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel-shared/accessors.h b/kernel-shared/accessors.h
> index cb96f3e2..5d90be76 100644
> --- a/kernel-shared/accessors.h
> +++ b/kernel-shared/accessors.h
> @@ -935,6 +935,9 @@ BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_generation, struct btrfs_super_block,
>  BTRFS_SETGET_STACK_FUNCS(super_nr_global_roots, struct btrfs_super_block,
>  			 nr_global_roots, 64);
>  
> +/* struct btrfs_file_extent_encryption_info */
> +BTRFS_SETGET_FUNCS(encryption_info_size, struct btrfs_encryption_info, size, 32);
> +
>  /* struct btrfs_file_extent_item */
>  BTRFS_SETGET_STACK_FUNCS(stack_file_extent_type, struct btrfs_file_extent_item,
>  			 type, 8);
> @@ -973,6 +976,46 @@ BTRFS_SETGET_FUNCS(file_extent_encryption, struct btrfs_file_extent_item,
>  BTRFS_SETGET_FUNCS(file_extent_other_encoding, struct btrfs_file_extent_item,
>  		   other_encoding, 16);
>  
> +static inline struct btrfs_encryption_info *btrfs_file_extent_encryption_info(
> +					const struct btrfs_file_extent_item *ei)
> +{
> +	unsigned long offset = (unsigned long)ei;
> +
> +	offset += offsetof(struct btrfs_file_extent_item, encryption_info);
> +	return (struct btrfs_encryption_info *)offset;
> +}
> +
> +static inline unsigned long btrfs_file_extent_encryption_ctx_offset(
> +					const struct btrfs_file_extent_item *ei)
> +{
> +	unsigned long offset = (unsigned long)ei;
> +
> +	offset += offsetof(struct btrfs_file_extent_item, encryption_info);
> +	return offset + offsetof(struct btrfs_encryption_info, context);
> +}
> +
> +static inline u32 btrfs_file_extent_encryption_ctx_size(
> +					const struct extent_buffer *eb,
> +					const struct btrfs_file_extent_item *ei)
> +{
> +	return btrfs_encryption_info_size(eb, btrfs_file_extent_encryption_info(ei));
> +}
> +
> +static inline void btrfs_set_file_extent_encryption_ctx_size(
> +					struct extent_buffer *eb,
> +					struct btrfs_file_extent_item *ei,
> +					u32 val)
> +{
> +	btrfs_set_encryption_info_size(eb, btrfs_file_extent_encryption_info(ei), val);
> +}
> +
> +static inline u32 btrfs_file_extent_encryption_info_size(
> +					const struct extent_buffer *eb,
> +					const struct btrfs_file_extent_item *ei)
> +{
> +	return btrfs_encryption_info_size(eb, btrfs_file_extent_encryption_info(ei));
> +}
> +
>  /* btrfs_qgroup_status_item */
>  BTRFS_SETGET_FUNCS(qgroup_status_generation, struct btrfs_qgroup_status_item,
>  		   generation, 64);
> diff --git a/kernel-shared/tree-checker.c b/kernel-shared/tree-checker.c
> index ccc1f1ea..93073979 100644
> --- a/kernel-shared/tree-checker.c
> +++ b/kernel-shared/tree-checker.c
> @@ -242,6 +242,8 @@ static int check_extent_data_item(struct extent_buffer *leaf,
>  	u32 sectorsize = fs_info->sectorsize;
>  	u32 item_size = btrfs_item_size(leaf, slot);
>  	u64 extent_end;
> +	u8 policy;
> +	u8 fe_type;
>  
>  	if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
>  		file_extent_err(leaf, slot,
> @@ -272,12 +274,12 @@ static int check_extent_data_item(struct extent_buffer *leaf,
>  				SZ_4K);
>  		return -EUCLEAN;
>  	}
> -	if (unlikely(btrfs_file_extent_type(leaf, fi) >=
> -		     BTRFS_NR_FILE_EXTENT_TYPES)) {
> +
> +	fe_type = btrfs_file_extent_type(leaf, fi);
> +	if (unlikely(fe_type >= BTRFS_NR_FILE_EXTENT_TYPES)) {
>  		file_extent_err(leaf, slot,
>  		"invalid type for file extent, have %u expect range [0, %u]",
> -			btrfs_file_extent_type(leaf, fi),
> -			BTRFS_NR_FILE_EXTENT_TYPES - 1);
> +			fe_type, BTRFS_NR_FILE_EXTENT_TYPES - 1);
>  		return -EUCLEAN;
>  	}
>  
> @@ -293,10 +295,11 @@ static int check_extent_data_item(struct extent_buffer *leaf,
>  			BTRFS_NR_COMPRESS_TYPES - 1);
>  		return -EUCLEAN;
>  	}
> -	if (unlikely(btrfs_file_extent_encryption(leaf, fi))) {
> +	policy = btrfs_file_extent_encryption(leaf, fi);
> +	if (unlikely(policy >= BTRFS_NR_ENCRYPTION_TYPES)) {
>  		file_extent_err(leaf, slot,
> -			"invalid encryption for file extent, have %u expect 0",
> -			btrfs_file_extent_encryption(leaf, fi));
> +			"invalid encryption for file extent, have %u expect range [0, %u]",
> +			policy, BTRFS_NR_ENCRYPTION_TYPES - 1);
>  		return -EUCLEAN;
>  	}
>  	if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_INLINE) {
> @@ -325,12 +328,50 @@ static int check_extent_data_item(struct extent_buffer *leaf,
>  		return 0;
>  	}
>  
> -	/* Regular or preallocated extent has fixed item size */
> -	if (unlikely(item_size != sizeof(*fi))) {
> -		file_extent_err(leaf, slot,
> +	if (policy == BTRFS_ENCRYPTION_FSCRYPT) {
> +		size_t fe_size = sizeof(*fi) + sizeof(struct btrfs_encryption_info);
> +		u32 ctxsize;
> +
> +		if (unlikely(item_size < fe_size)) {
> +			file_extent_err(leaf, slot,
> +	"invalid item size for encrypted file extent, have %u expect = %zu + size of u32",
> +					item_size, sizeof(*fi));
> +			return -EUCLEAN;
> +		}
> +
> +		ctxsize = btrfs_file_extent_encryption_info_size(leaf, fi);
> +		if (unlikely(item_size != (fe_size + ctxsize))) {
> +			file_extent_err(leaf, slot,
> +	"invalid item size for encrypted file extent, have %u expect = %zu + context of size %u",
> +					item_size, fe_size, ctxsize);
> +			return -EUCLEAN;
> +		}
> +
> +		if (unlikely(ctxsize > BTRFS_MAX_EXTENT_CTX_SIZE)) {
> +			file_extent_err(leaf, slot,
> +	"invalid file extent context size, have %u expect a maximum of %u",
> +					ctxsize, BTRFS_MAX_EXTENT_CTX_SIZE);
> +			return -EUCLEAN;
> +		}
> +
> +		/*
> +		 * Only regular and prealloc extents should have an encryption
> +		 * context.
> +		 */
> +		if (unlikely(fe_type != BTRFS_FILE_EXTENT_REG &&
> +			     fe_type != BTRFS_FILE_EXTENT_PREALLOC)) {
> +			file_extent_err(leaf, slot,
> +		"invalid type for encrypted file extent, have %u",
> +					btrfs_file_extent_type(leaf, fi));
> +			return -EUCLEAN;
> +		}
> +	} else {
> +		if (unlikely(item_size != sizeof(*fi))) {
> +			file_extent_err(leaf, slot,
>  	"invalid item size for reg/prealloc file extent, have %u expect %zu",
> -			item_size, sizeof(*fi));
> -		return -EUCLEAN;
> +					item_size, sizeof(*fi));
> +			return -EUCLEAN;
> +		}
>  	}
>  	if (unlikely(CHECK_FE_ALIGNED(leaf, slot, fi, ram_bytes, sectorsize) ||
>  		     CHECK_FE_ALIGNED(leaf, slot, fi, disk_bytenr, sectorsize) ||
> diff --git a/kernel-shared/uapi/btrfs_tree.h b/kernel-shared/uapi/btrfs_tree.h
> index 7f3dffe6..4b4f45aa 100644
> --- a/kernel-shared/uapi/btrfs_tree.h
> +++ b/kernel-shared/uapi/btrfs_tree.h
> @@ -1066,6 +1066,24 @@ enum {
>  	BTRFS_NR_FILE_EXTENT_TYPES = 3,
>  };
>  
> +/*
> + * Currently just the FSCRYPT_SET_CONTEXT_MAX_SIZE, which is larger than the
> + * current extent context size from fscrypt, so this should give us plenty of
> + * breathing room for expansion later.
> + */
> +#define BTRFS_MAX_EXTENT_CTX_SIZE 40
> +
> +enum {
> +	BTRFS_ENCRYPTION_NONE,
> +	BTRFS_ENCRYPTION_FSCRYPT,
> +	BTRFS_NR_ENCRYPTION_TYPES,
> +};
> +
> +struct btrfs_encryption_info {
> +	__le32 size;
> +	__u8 context[0];
> +};
> +
>  struct btrfs_file_extent_item {
>  	/*
>  	 * transaction id that created this extent
> @@ -1115,7 +1133,10 @@ struct btrfs_file_extent_item {
>  	 * always reflects the size uncompressed and without encoding.
>  	 */
>  	__le64 num_bytes;
> -
> +	/*
> +	 * the encryption info, if any
> +	 */
> +	struct btrfs_encryption_info encryption_info[0];

Looking at this again, adding variable length data will make it hard to
add more items to the file extent. We could not decide the version just
by the size, as done in other structures.

