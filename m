Return-Path: <linux-btrfs+bounces-21124-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDtFCPQfeWkQvgEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21124-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 21:28:36 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 342E29A5C4
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 21:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E7AD3017519
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 20:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C201136EAA7;
	Tue, 27 Jan 2026 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="mH6eBR76";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SSfeOuPw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C93132F747
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 20:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769545712; cv=none; b=bqCaWKAICb9222ykFCIsdAzN6BhjMjC5SQ/Nnld4uv9qIc2gYcwmsjPeSWgXACdfbgrclB6J8+HSq4GO2KRrL0XDnrsn21LhnLemEhh12o3f5dSeGESjToBLrxl/e9EoYJLjVc6JF0xyowsKXytZ1wSvD72t9wrZkgn7nlwGn9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769545712; c=relaxed/simple;
	bh=oADJe8HUjAJHiQPoSGtH656pHkAfjDVNXEZTnzwoUqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDJ70jfd4CZYlF9l+PLQPBLTj+rAdycjmYW5InPNza+bFkatrzA4Z/lYmAA1OAdxjln+pFojcwFMIn/maOsMnxE3nTORItM2uv6AnQZotBN/UNvkHjJYkOxRgy7XvXvJ9jacuU9zl91/Ymci/L2lTT+dLs9c02hEcWcI+2KnDgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=mH6eBR76; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SSfeOuPw; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D7F95EC00D2;
	Tue, 27 Jan 2026 15:28:29 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 27 Jan 2026 15:28:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1769545709; x=1769632109; bh=AgTI2F0vln
	7bCToEYBy4pbIHzVMUy+BfTKi64tpdI00=; b=mH6eBR76C2epJ1Ott+3ppoQlnh
	ECEcfcE9lZAlcPLN79b5Px/FUr+dQBzpmKErtMcP2ko3BmHmNhWLwScMtW1AE92h
	+HqN3GfH2HhHv8Hkpsn1J6mA0riSNPIGfRgipCv+96ybkiI0ebCh2ufwTqZN1Zg3
	VKCxUdo9Zd9t9f02MnHeIfZVZbnJPem5P9Xr2yfGDfF+jBr/wZ7VxVr27qENFZWP
	w5vJbeGm5Xjg4PEVh9GVcw6q/aK8BKyn60chP84DvwzMQBc4GXl60cB3cYTIyLW8
	k2bBGZOY+i2cXMEG0YdTMpSMzybIGA3L/dqKYmQ2LUwwdB+1fUSuJE27eLdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769545709; x=1769632109; bh=AgTI2F0vln7bCToEYBy4pbIHzVMUy+BfTKi
	64tpdI00=; b=SSfeOuPwWScdya2lCnRhEivtO9SlpvQvlkpH5XbDIyfGeLvttCo
	WIYS4XGA/s6QypL5zCXUjf5cc745QkTlmdKT9UbKSv2Tw5xyf/reQ/wSp9O0gAIY
	2SVS+n/aCB8bWLHW05P5lIaLdChswaP04qod3y1YxNWVOoiuLk0B56fvpfTwoLx3
	aXM4y8Aqq9XOt9g5Yo1rLS4Zqclm5KGVfLguKJDaviqf9Yf9EBtZgAlBy02a8p93
	00Ie7wyNLksIeyTCJ9fsK6PFPw9Ytzo/IXDWvPtc+5UGz0HQc4RhQFGy4mromNWJ
	XZnjw30qzpHR1sJX4QnQUHTJEo84J/+Tn8g==
X-ME-Sender: <xms:7R95aaDPk4n5KzQbwGfH6fNUWBjQoNRflrjwOgUH4PFrofcONarSSg>
    <xme:7R95aajGjGA2m_UTQJH8jRtJqVIzddeJZd2xywz3GRAuxce1rRmSByCcvvUH-4VoG
    nAb4scTBQOSea4net9JULHU6zysh6akZbQasRUZc7mblH0jSTiZ1bQ>
X-ME-Received: <xmr:7R95abN7lJ0vJqiXqRh7-ukEZ2DECWO8hhV68Z62S8MrPvyKSJL9wyTNOqEUKIQR-r9ZHDIkJ2zL4d8GBOzpJaSoSfM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduiedugeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeeite
    ffhedtieetfeeffeelhedtheevheeviefftdethffggfeikeeuiefggedvjeenucffohhm
    rghinhepsghipghithgvrhdrsghinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifqhhusehsuhhsvgdrtghomhdprh
    gtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7R95aT7GOery1ELlmbHQ2ygSSyDDgBdvWdib4Ljbse0RyycAYVvNXg>
    <xmx:7R95aR2aoxGddo0kC7TUglcqcs_HeLbaA5uZ5PqAdTWKmRKsZMsdwQ>
    <xmx:7R95acaXclUYsbsIQ9ck9YNi3Sln6581wG478o73VhIjFKUoG6PCHA>
    <xmx:7R95aRA2Q9Dp4T7_Y2iK759J4fgXgrc8aW8W9cjcvAs72mvlw15xxw>
    <xmx:7R95aUM0M1ejfsY3n2sJA74fYg4le-20MmKWIZx247x5ZVgi5TmDtGRa>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jan 2026 15:28:29 -0500 (EST)
Date: Tue, 27 Jan 2026 12:28:05 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 8/9] btrfs: get rid of compressed_folios[] usage for
 encoded writes
Message-ID: <20260127202805.GA3504710@zen.localdomain>
References: <cover.1769482298.git.wqu@suse.com>
 <9781beb3fa2948d125d16393d755c60096b855e8.1769482298.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9781beb3fa2948d125d16393d755c60096b855e8.1769482298.git.wqu@suse.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21124-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[bur.io];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 342E29A5C4
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 01:40:41PM +1030, Qu Wenruo wrote:
> Currently only encoded writes utilized btrfs_submit_compressed_write(),
> which utilized compressed_bio::compressed_folios[] array.
> 
> Change the only call site to call the new helper,
> btrfs_alloc_compressed_write(), to allocate a compressed bio, then queue
> needed folios into that bio, and finally call
> btrfs_submit_compressed_write() to submit the compreseed bio.
> 
> This change has one hidden benefit, previously we use
> btrfs_alloc_folio_array() for the folios of
> btrfs_submit_compressed_read(), which doesn't utilize the compression
> page pool for bs == ps cases.
> 
> Now we call btrfs_alloc_compr_folio() which will benefit from page pool.
> 
> The other obvious benefit is that we no longer need to allocate an array
> to hold all those folios, thus one less error path.

This review is from claude using Chris's review prompts with some light
editing / checking by me.

> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/compression.c | 53 +++++++++++++++++----------------------
>  fs/btrfs/compression.h |  6 ++---
>  fs/btrfs/inode.c       | 56 +++++++++++++++++++++++-------------------
>  3 files changed, 56 insertions(+), 59 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index c018b3c4554e..205f6828c1e6 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -304,25 +304,6 @@ static void end_bbio_compressed_write(struct btrfs_bio *bbio)
>  	bio_put(&cb->bbio.bio);
>  }
>  
> -static void btrfs_add_compressed_bio_folios(struct compressed_bio *cb)
> -{
> -	struct bio *bio = &cb->bbio.bio;
> -	u32 offset = 0;
> -	unsigned int findex = 0;
> -
> -	while (offset < cb->compressed_len) {
> -		struct folio *folio = cb->compressed_folios[findex];
> -		u32 len = min_t(u32, cb->compressed_len - offset, folio_size(folio));
> -		int ret;
> -
> -		/* Maximum compressed extent is smaller than bio size limit. */
> -		ret = bio_add_folio(bio, folio, len, 0);
> -		ASSERT(ret);
> -		offset += len;
> -		findex++;
> -	}
> -}
> -
>  /*
>   * worker function to build and submit bios for previously compressed pages.
>   * The corresponding pages in the inode should be marked for writeback
> @@ -333,34 +314,44 @@ static void btrfs_add_compressed_bio_folios(struct compressed_bio *cb)
>   * the end io hooks.
>   */
>  void btrfs_submit_compressed_write(struct btrfs_ordered_extent *ordered,
> -				   struct folio **compressed_folios,
> -				   unsigned int nr_folios,
> -				   blk_opf_t write_flags,
> -				   bool writeback)
> +				   struct compressed_bio *cb)
>  {
>  	struct btrfs_inode *inode = ordered->inode;
>  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> -	struct compressed_bio *cb;
>  
>  	ASSERT(IS_ALIGNED(ordered->file_offset, fs_info->sectorsize));
>  	ASSERT(IS_ALIGNED(ordered->num_bytes, fs_info->sectorsize));
> +	ASSERT(cb->writeback);
>  
> -	cb = alloc_compressed_bio(inode, ordered->file_offset,
> -				  REQ_OP_WRITE | write_flags,
> -				  end_bbio_compressed_write);
>  	cb->start = ordered->file_offset;
>  	cb->len = ordered->num_bytes;
> -	cb->compressed_folios = compressed_folios;
>  	cb->compressed_len = ordered->disk_num_bytes;
> -	cb->writeback = writeback;
> -	cb->nr_folios = nr_folios;
>  	cb->bbio.bio.bi_iter.bi_sector = ordered->disk_bytenr >> SECTOR_SHIFT;
>  	cb->bbio.ordered = ordered;
> -	btrfs_add_compressed_bio_folios(cb);
>  
>  	btrfs_submit_bbio(&cb->bbio, 0);
>  }
>  
> +/*
> + * Allocate a compressed write bio for @inode file offset @start length @len.
> + *
> + * The caller still needs to properly queue all folios and populate involved
> + * members.
> + */
> +struct compressed_bio *btrfs_alloc_compressed_write(struct btrfs_inode *inode,
> +						    u64 start, u64 len)
> +{
> +	struct compressed_bio *cb;
> +
> +	cb = alloc_compressed_bio(inode, start, REQ_OP_WRITE,
> +				  end_bbio_compressed_write);
> +	cb->start = start;
> +	cb->len = len;
> +	cb->writeback = true;
> +
> +	return cb;
> +}
> +
>  /*
>   * Add extra pages in the same compressed file extent so that we don't need to
>   * re-read the same extent again and again.
> diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
> index 7dc48e556313..2d3a28b26997 100644
> --- a/fs/btrfs/compression.h
> +++ b/fs/btrfs/compression.h
> @@ -96,10 +96,10 @@ int btrfs_decompress(int type, const u8 *data_in, struct folio *dest_folio,
>  int btrfs_decompress_buf2page(const char *buf, u32 buf_len,
>  			      struct compressed_bio *cb, u32 decompressed);
>  
> +struct compressed_bio *btrfs_alloc_compressed_write(struct btrfs_inode *inode,
> +						    u64 start, u64 len);
>  void btrfs_submit_compressed_write(struct btrfs_ordered_extent *ordered,
> -				   struct folio **compressed_folios,
> -				   unsigned int nr_folios, blk_opf_t write_flags,
> -				   bool writeback);
> +				   struct compressed_bio *cb);
>  void btrfs_submit_compressed_read(struct btrfs_bio *bbio);
>  
>  int btrfs_compress_str2level(unsigned int type, const char *str, int *level_ret);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index d010621b64d5..f1df43f2e69a 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9804,12 +9804,13 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
>  	struct extent_state *cached_state = NULL;
>  	struct btrfs_ordered_extent *ordered;
>  	struct btrfs_file_extent file_extent;
> +	struct compressed_bio *cb = NULL;
>  	int compression;
>  	size_t orig_count;
> +	const u32 min_folio_size = btrfs_min_folio_size(fs_info);
>  	u64 start, end;
>  	u64 num_bytes, ram_bytes, disk_num_bytes;
> -	unsigned long nr_folios, i;
> -	struct folio **folios;
> +	unsigned long nr_folios;
>  	struct btrfs_key ins;
>  	bool extent_reserved = false;
>  	struct extent_map *em;
> @@ -9899,38 +9900,45 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
>  	 */
>  	disk_num_bytes = ALIGN(orig_count, fs_info->sectorsize);
>  	nr_folios = DIV_ROUND_UP(disk_num_bytes, PAGE_SIZE);
> -	folios = kvcalloc(nr_folios, sizeof(struct folio *), GFP_KERNEL_ACCOUNT);
> -	if (!folios)
> -		return -ENOMEM;
> -	for (i = 0; i < nr_folios; i++) {
> -		size_t bytes = min_t(size_t, PAGE_SIZE, iov_iter_count(from));
> +
> +	cb = btrfs_alloc_compressed_write(inode, start, num_bytes);
> +	for (int i = 0; i < nr_folios; i++) {
> +		struct folio *folio;
> +		size_t bytes = min(min_folio_size, iov_iter_count(from));
>  		char *kaddr;
>  
> -		folios[i] = folio_alloc(GFP_KERNEL_ACCOUNT, 0);
> -		if (!folios[i]) {
> +		folio = btrfs_alloc_compr_folio(fs_info);
> +		if (!folio) {
>  			ret = -ENOMEM;
> -			goto out_folios;
> +			goto out_cb;
>  		}
> -		kaddr = kmap_local_folio(folios[i], 0);
> +		kaddr = kmap_local_folio(folio, 0);
>  		if (copy_from_iter(kaddr, bytes, from) != bytes) {
>  			kunmap_local(kaddr);
> +			folio_put(folio);
>  			ret = -EFAULT;
> -			goto out_folios;
> +			goto out_cb;
> +		}
> +		if (bytes < min_folio_size)
> +			folio_zero_range(folio, bytes, min_folio_size - bytes);
> +		ret = bio_add_folio(&cb->bbio.bio, folio, folio_size(folio), 0);
> +		if (!unlikely(ret)) {

Should this be unlikely(!ret) instead of !unlikely(ret)?

While !unlikely(ret) evaluates to the same boolean result as !ret, the
branch prediction hint is inverted.

> +			folio_put(folio);
> +			ret = -EINVAL;
> +			goto out_cb;
>  		}
> -		if (bytes < PAGE_SIZE)
> -			memset(kaddr + bytes, 0, PAGE_SIZE - bytes);
> -		kunmap_local(kaddr);

Is there a missing kunmap_local(kaddr) here? The original code called
kunmap_local() after the memset:

    if (bytes < PAGE_SIZE)
        memset(kaddr + bytes, 0, PAGE_SIZE - bytes);
    kunmap_local(kaddr);

But the new code appears to have lost the corresponding kunmap_local().

>  	}
> +	ASSERT(cb->bbio.bio.bi_iter.bi_size == disk_num_bytes);
>  
>  	for (;;) {
>  		ret = btrfs_wait_ordered_range(inode, start, num_bytes);
>  		if (ret)
> -			goto out_folios;
> +			goto out_cb;
>  		ret = invalidate_inode_pages2_range(inode->vfs_inode.i_mapping,
>  						    start >> PAGE_SHIFT,
>  						    end >> PAGE_SHIFT);
>  		if (ret)
> -			goto out_folios;
> +			goto out_cb;
>  		btrfs_lock_extent(io_tree, start, end, &cached_state);
>  		ordered = btrfs_lookup_ordered_range(inode, start, num_bytes);
>  		if (!ordered &&
> @@ -9962,7 +9970,8 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
>  	    encoded->unencoded_offset == 0 &&
>  	    can_cow_file_range_inline(inode, start, encoded->len, orig_count)) {
>  		ret = __cow_file_range_inline(inode, encoded->len,
> -					      orig_count, compression, folios[0],
> +					      orig_count, compression,
> +					      bio_first_folio_all(&cb->bbio.bio),
>  					      true);
>  		if (ret <= 0) {
>  			if (ret == 0)
> @@ -10007,7 +10016,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
>  
>  	btrfs_delalloc_release_extents(inode, num_bytes);
>  
> -	btrfs_submit_compressed_write(ordered, folios, nr_folios, 0, false);
> +	btrfs_submit_compressed_write(ordered, cb);
>  	ret = orig_count;
>  	goto out;
>  
> @@ -10029,12 +10038,9 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
>  		btrfs_free_reserved_data_space_noquota(inode, disk_num_bytes);
>  out_unlock:
>  	btrfs_unlock_extent(io_tree, start, end, &cached_state);
> -out_folios:
> -	for (i = 0; i < nr_folios; i++) {
> -		if (folios[i])
> -			folio_put(folios[i]);
> -	}
> -	kvfree(folios);
> +out_cb:
> +	if (cb)
> +		cleanup_compressed_bio(cb);
>  out:
>  	if (ret >= 0)
>  		iocb->ki_pos += encoded->len;
> -- 
> 2.52.0
> 

