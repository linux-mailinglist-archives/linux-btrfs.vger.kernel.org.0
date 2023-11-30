Return-Path: <linux-btrfs+bounces-463-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D137FFF72
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 00:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F8E72817DE
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 23:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FAF5953A;
	Thu, 30 Nov 2023 23:29:22 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0F4BC
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Nov 2023 15:29:17 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6D04C21B7A;
	Thu, 30 Nov 2023 23:29:15 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 35381138E5;
	Thu, 30 Nov 2023 23:29:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id LCtwDMsaaWVfbwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 30 Nov 2023 23:29:15 +0000
Date: Fri, 1 Dec 2023 00:22:01 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: migrate extent_buffer::pages[] to folio
Message-ID: <20231130232201.GX18929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b87c95b697347980b008d8140ceec49590af4f5d.1701037103.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b87c95b697347980b008d8140ceec49590af4f5d.1701037103.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Bar: ++++++++++++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [12.29 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 DMARC_NA(1.20)[suse.cz];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 BAYES_SPAM(5.10)[100.00%];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWO(0.00)[2];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 12.29
X-Rspamd-Queue-Id: 6D04C21B7A

On Mon, Nov 27, 2023 at 08:48:45AM +1030, Qu Wenruo wrote:
> For now extent_buffer::pages[] are still only accept single page
> pointer, thus we can migrate to folios pretty easily.
> 
> As for single page, page and folio are 1:1 mapped.
> 
> This patch would just do the conversion from struct page to struct
> folio, providing the first step to higher order folio in the future.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Some existing infrastructure like get_eb_page_index() can be used to
> help the conversion to higher order folio.
> 
> Initially I tried to keep using page pointers for compound pages,
> but since they are using the same page pointer, it's pretty easy to get
> confused on whether the page is single or compound, and lead to various
> VM BUGs.
> 
> Migrating to folio would address the problem much easier.
> 
> Unfortunately this patch is just migrating extent_buffer::pages[] type
> to folio, we still have a lot of things worthy cleanup, but it should
> provide the last preparation needed for higher order folio integration.
> ---
>  fs/btrfs/accessors.c             |  18 ++---
>  fs/btrfs/accessors.h             |   4 +-
>  fs/btrfs/ctree.c                 |   2 +-
>  fs/btrfs/disk-io.c               |  18 ++---
>  fs/btrfs/extent_io.c             | 134 +++++++++++++++++--------------
>  fs/btrfs/extent_io.h             |   2 +-
>  fs/btrfs/tests/extent-io-tests.c |   6 +-
>  7 files changed, 98 insertions(+), 86 deletions(-)
> 
> diff --git a/fs/btrfs/accessors.c b/fs/btrfs/accessors.c
> index 206cf1612c1d..ecc204728475 100644
> --- a/fs/btrfs/accessors.c
> +++ b/fs/btrfs/accessors.c
> @@ -27,7 +27,7 @@ static bool check_setget_bounds(const struct extent_buffer *eb,
>  void btrfs_init_map_token(struct btrfs_map_token *token, struct extent_buffer *eb)
>  {
>  	token->eb = eb;
> -	token->kaddr = page_address(eb->pages[0]);
> +	token->kaddr = folio_address(eb->folios[0]);
>  	token->offset = 0;
>  }
>  
> @@ -74,13 +74,13 @@ u##bits btrfs_get_token_##bits(struct btrfs_map_token *token,		\
>  	    member_offset + size <= token->offset + PAGE_SIZE) {	\
>  		return get_unaligned_le##bits(token->kaddr + oip);	\
>  	}								\
> -	token->kaddr = page_address(token->eb->pages[idx]);		\
> +	token->kaddr = folio_address(token->eb->folios[idx]);		\
>  	token->offset = idx << PAGE_SHIFT;				\
>  	if (INLINE_EXTENT_BUFFER_PAGES == 1 || oip + size <= PAGE_SIZE ) \
>  		return get_unaligned_le##bits(token->kaddr + oip);	\
>  									\
>  	memcpy(lebytes, token->kaddr + oip, part);			\
> -	token->kaddr = page_address(token->eb->pages[idx + 1]);		\
> +	token->kaddr = folio_address(token->eb->folios[idx + 1]);	\
>  	token->offset = (idx + 1) << PAGE_SHIFT;			\
>  	memcpy(lebytes + part, token->kaddr, size - part);		\
>  	return get_unaligned_le##bits(lebytes);				\
> @@ -91,7 +91,7 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
>  	const unsigned long member_offset = (unsigned long)ptr + off;	\
>  	const unsigned long oip = get_eb_offset_in_page(eb, member_offset); \
>  	const unsigned long idx = get_eb_page_index(member_offset);	\
> -	char *kaddr = page_address(eb->pages[idx]);			\
> +	char *kaddr = folio_address(eb->folios[idx]);			\
>  	const int size = sizeof(u##bits);				\
>  	const int part = PAGE_SIZE - oip;				\
>  	u8 lebytes[sizeof(u##bits)];					\
> @@ -101,7 +101,7 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
>  		return get_unaligned_le##bits(kaddr + oip);		\
>  									\
>  	memcpy(lebytes, kaddr + oip, part);				\
> -	kaddr = page_address(eb->pages[idx + 1]);			\
> +	kaddr = folio_address(eb->folios[idx + 1]);			\
>  	memcpy(lebytes + part, kaddr, size - part);			\
>  	return get_unaligned_le##bits(lebytes);				\
>  }									\
> @@ -125,7 +125,7 @@ void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
>  		put_unaligned_le##bits(val, token->kaddr + oip);	\
>  		return;							\
>  	}								\
> -	token->kaddr = page_address(token->eb->pages[idx]);		\
> +	token->kaddr = folio_address(token->eb->folios[idx]);		\
>  	token->offset = idx << PAGE_SHIFT;				\
>  	if (INLINE_EXTENT_BUFFER_PAGES == 1 || oip + size <= PAGE_SIZE) { \
>  		put_unaligned_le##bits(val, token->kaddr + oip);	\
> @@ -133,7 +133,7 @@ void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
>  	}								\
>  	put_unaligned_le##bits(val, lebytes);				\
>  	memcpy(token->kaddr + oip, lebytes, part);			\
> -	token->kaddr = page_address(token->eb->pages[idx + 1]);		\
> +	token->kaddr = folio_address(token->eb->folios[idx + 1]);	\
>  	token->offset = (idx + 1) << PAGE_SHIFT;			\
>  	memcpy(token->kaddr, lebytes + part, size - part);		\
>  }									\
> @@ -143,7 +143,7 @@ void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
>  	const unsigned long member_offset = (unsigned long)ptr + off;	\
>  	const unsigned long oip = get_eb_offset_in_page(eb, member_offset); \
>  	const unsigned long idx = get_eb_page_index(member_offset);	\
> -	char *kaddr = page_address(eb->pages[idx]);			\
> +	char *kaddr = folio_address(eb->folios[idx]);			\
>  	const int size = sizeof(u##bits);				\
>  	const int part = PAGE_SIZE - oip;				\
>  	u8 lebytes[sizeof(u##bits)];					\
> @@ -156,7 +156,7 @@ void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
>  									\
>  	put_unaligned_le##bits(val, lebytes);				\
>  	memcpy(kaddr + oip, lebytes, part);				\
> -	kaddr = page_address(eb->pages[idx + 1]);			\
> +	kaddr = folio_address(eb->folios[idx + 1]);			\
>  	memcpy(kaddr, lebytes + part, size - part);			\
>  }
>  
> diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
> index aa0844535644..ed7aa32972ad 100644
> --- a/fs/btrfs/accessors.h
> +++ b/fs/btrfs/accessors.h
> @@ -90,14 +90,14 @@ static inline void btrfs_set_token_##name(struct btrfs_map_token *token,\
>  #define BTRFS_SETGET_HEADER_FUNCS(name, type, member, bits)		\
>  static inline u##bits btrfs_##name(const struct extent_buffer *eb)	\
>  {									\
> -	const type *p = page_address(eb->pages[0]) +			\
> +	const type *p = folio_address(eb->folios[0]) +			\
>  			offset_in_page(eb->start);			\
>  	return get_unaligned_le##bits(&p->member);			\
>  }									\
>  static inline void btrfs_set_##name(const struct extent_buffer *eb,	\
>  				    u##bits val)			\
>  {									\
> -	type *p = page_address(eb->pages[0]) + offset_in_page(eb->start); \
> +	type *p = folio_address(eb->folios[0]) + offset_in_page(eb->start); \
>  	put_unaligned_le##bits(val, &p->member);			\
>  }
>  
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 137c4eb24c28..e6c535cf3749 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -832,7 +832,7 @@ int btrfs_bin_search(struct extent_buffer *eb, int first_slot,
>  
>  		if (oip + key_size <= PAGE_SIZE) {
>  			const unsigned long idx = get_eb_page_index(offset);
> -			char *kaddr = page_address(eb->pages[idx]);
> +			char *kaddr = folio_address(eb->folios[idx]);
>  
>  			oip = get_eb_offset_in_page(eb, offset);
>  			tmp = (struct btrfs_disk_key *)(kaddr + oip);
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 7fc78171a262..df9d860efc20 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -90,14 +90,13 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
>  		return;
>  	}
>  
> -	kaddr = page_address(buf->pages[0]) + offset_in_page(buf->start);
> +	kaddr = folio_address(buf->folios[0]) + offset_in_page(buf->start);
>  	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
>  			    first_page_part - BTRFS_CSUM_SIZE);
>  
> -	for (i = 1; i < num_pages && INLINE_EXTENT_BUFFER_PAGES > 1; i++) {
> -		kaddr = page_address(buf->pages[i]);
> -		crypto_shash_update(shash, kaddr, PAGE_SIZE);
> -	}
> +	for (i = 1; i < num_pages && INLINE_EXTENT_BUFFER_PAGES > 1; i++)
> +		crypto_shash_update(shash, folio_address(buf->folios[i]),
> +				    PAGE_SIZE);
>  	crypto_shash_final(shash, result);
>  }
>  
> @@ -180,7 +179,7 @@ static int btrfs_repair_eb_io_failure(const struct extent_buffer *eb,
>  		return -EROFS;
>  
>  	for (i = 0; i < num_pages; i++) {
> -		struct page *p = eb->pages[i];
> +		struct page *p = folio_page(eb->folios[i], 0);
>  		u64 start = max_t(u64, eb->start, page_offset(p));
>  		u64 end = min_t(u64, eb->start + eb->len, page_offset(p) + PAGE_SIZE);
>  		u32 len = end - start;
> @@ -268,8 +267,9 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
>  
>  	if (WARN_ON_ONCE(found_start != eb->start))
>  		return BLK_STS_IOERR;
> -	if (WARN_ON(!btrfs_page_test_uptodate(fs_info, eb->pages[0], eb->start,
> -					      eb->len)))
> +	if (WARN_ON(!btrfs_page_test_uptodate(fs_info,
> +					folio_page(eb->folios[0], 0), eb->start,
> +					eb->len)))
>  		return BLK_STS_IOERR;
>  
>  	ASSERT(memcmp_extent_buffer(eb, fs_info->fs_devices->metadata_uuid,
> @@ -378,7 +378,7 @@ int btrfs_validate_extent_buffer(struct extent_buffer *eb,
>  	}
>  
>  	csum_tree_block(eb, result);
> -	header_csum = page_address(eb->pages[0]) +
> +	header_csum = folio_address(eb->folios[0]) +
>  		get_eb_offset_in_page(eb, offsetof(struct btrfs_header, csum));
>  
>  	if (memcmp(result, header_csum, csum_size) != 0) {
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index fcd7b4674d08..96e15cbdc660 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -715,6 +715,21 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array)
>  	return alloc_page_array(nr_pages, page_array, 0);
>  }
>  
> +static int alloc_eb_folio_array(unsigned int nr_pages,
> +				struct folio **folio_array,
> +				gfp_t extra_gfp)
> +{
> +	struct page *page_array[INLINE_EXTENT_BUFFER_PAGES];
> +	int ret;
> +
> +	ret = alloc_page_array(nr_pages, page_array, extra_gfp);

alloc_page_array() got removed in v4 of "btrfs: refactor
alloc_extent_buffer() to allocate-then-attach metho", please refresh the
patch, thanks.

> +	if (ret < 0)
> +		return ret;
> +	for (int i = 0; i < nr_pages; i++)
> +		folio_array[i] = page_folio(page_array[i]);
> +	return 0;
> +}

