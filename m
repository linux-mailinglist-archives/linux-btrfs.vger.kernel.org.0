Return-Path: <linux-btrfs+bounces-22234-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6A8xNo+vqGmfwQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22234-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 23:17:51 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E0470208698
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 23:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A2942306476C
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2026 22:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048E61C68F;
	Wed,  4 Mar 2026 22:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="iU0dixDt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sfvZo+rZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7896424DD15
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Mar 2026 22:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772662051; cv=none; b=fHOGAW1LXbVCEML6JbLlNaq1kw0k/apQRGyWNtLlZBHu8SXJ/yxt//R69gYjHA9X3tvbG3rpolD0qzaRx3RogPifKniig/p6lorYFk9XaOHz/JYTW3hEFW4kj8Zy6ijD02pz1m11f+NsDOC6r7BVFs7eRme0gp0T2TavgKcYLXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772662051; c=relaxed/simple;
	bh=FHWhVOXtcykDSKeewWU0wGjXrRC1enlGAQy9AnRsMdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fE4qFjKP7HPw5dD5vtFW+kV/Ns/X72LsNr0icm7F4ZM8MNBYjG3tDKrVPG/7ZMG+/MTg6jDJWpmNPby+R+iJuL65Bc3k1WmZi0hNQ5QHlekb5hwnT2Afwqocebo5Yd/jN8RXA0/xcU9/ouOPMFdSeh8m05tj6EIYZ8TOPziowZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=iU0dixDt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sfvZo+rZ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 8669A1D0011D;
	Wed,  4 Mar 2026 17:07:28 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 04 Mar 2026 17:07:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772662048; x=1772748448; bh=iCgz1SJcGD
	D8D53cQJB1Gp8nicuI11ua3/y+wE+K6g0=; b=iU0dixDtYCsc0CxH4Fu+AC86O5
	eSVPjZKvkZF1ikcY/oOONJWRlJ9nmXaAOa5OXrwKQx7b1kElx5O+/tDFoA4vm+Rw
	m1kCcr2BjVccg0kKnHDEUJfBxTiVds+M83cbSdm/iZ8n+Uvmy2IZtKBaQV/hJzGD
	SwwHd3/DvicdQdzE5sGDZUlpL33/TL9CcsWUfByvDwk7HGtVdOnWaGHaH8GTY13+
	F4zt6+vj3HlzFnyF6n4TmQZdDfWGortjCBnQS/Ew8Xm+CZKKiLEB+4o4HKc115Sl
	yuXbRTt7fPLMv1Y8MdMgy6+Pgvk0q4lbgQ0q4Rs4Miwx7QQKa++VqXcanhZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772662048; x=1772748448; bh=iCgz1SJcGDD8D53cQJB1Gp8nicuI11ua3/y
	+wE+K6g0=; b=sfvZo+rZ0wx8XBMKkS+bjq5mWLPXW1Ta1iF/isOZlgcSrD3t/f1
	CwoAfybMRoYg14/mhX6lklSRCEl7evS3CHHPHgvOqKi3OLZ9hzARcXkoP83+r0xo
	bq+WXj99zbJuiJt4nIvQ32yYnAdO7GpcqoMygqZGCbfjiAkY8GuyxYyOMhA3PDT8
	Eham8rrateQmLIhV0ikS3n4KLgYW1bWbEl4OOUuB+nbmdsBPnLJmr48SSYy++0VS
	6woxbLzIoMBCXeqsDkC4/pgOcmUAUhfbXFjHHyQqaXp7VBQyOsA4j/Tu3UCNzJT9
	CoY22Uikz6/PB7KtnDZz5Ah2gOrSg+RRtfg==
X-ME-Sender: <xms:H62oaak1crqi_KpSmg0IkjYD0Hu3dslZb3QHw-7ndoAVFb9mCsPRlQ>
    <xme:H62oaX1ONt3-SXTfCjvFXrn5ucCG5Uj1U1gL_LmfFdL6c4GlJNDHMzOMbL2fyhW_y
    OaiYboM9BM2RdN37_lTQKNmscP7D3kqxPU0wDfa32hv6w2EpRcFdA>
X-ME-Received: <xmr:H62oaWSvKPBKWEUdysUS5wo5hTH_9nUGBp4z4JXvZYQqTo5jKM5v_caW0leURTSht9Ij1nL78SpZD4LXAItSPLLCuGY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieegieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeeite
    ffhedtieetfeeffeelhedtheevheeviefftdethffggfeikeeuiefggedvjeenucffohhm
    rghinhepsghipghithgvrhdrsghinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifqhhusehsuhhsvgdrtghomhdprh
    gtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:H62oaZvO8F6Y4-4JLaWj0CuuY6sz5Hq1_p6BQGQoNz4wx00cPq99Hw>
    <xmx:H62oaba30ZCvTRJRVo46BstETtvWx1UAqOHlS-VqmbB-RrXsUs4PJA>
    <xmx:H62oaeunuOFZKEGGFduSwBYOIpt5wlZIXSDAHxsgQbGVZFCuyQ6-UQ>
    <xmx:H62oadFTtXQ7gbjJL0-868RAnVFfJk3yKn4RF66wE0l_KeMzP-gW5w>
    <xmx:IK2oaVSjidYbkmQ5UDzBHabhShOzAHri_hL4b3tS5EDP9D5MvFGOV3Ju>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 17:07:27 -0500 (EST)
Date: Wed, 4 Mar 2026 14:08:09 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5] btrfs: extract inlined creation into a dedicated
 delalloc helper
Message-ID: <20260304220809.GA1470643@zen.localdomain>
References: <c47f725a3f9677216b031a6ae4530647e5b471f5.1772601410.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c47f725a3f9677216b031a6ae4530647e5b471f5.1772601410.git.wqu@suse.com>
X-Rspamd-Queue-Id: E0470208698
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22234-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[bur.io];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bur.io:dkim,bur.io:email,zen.localdomain:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,messagingengine.com:dkim]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 03:48:44PM +1030, Qu Wenruo wrote:
> Currently we call cow_file_range_inline() in different situations, from
> regular cow_file_range() to compress_file_range().
> 
> This is because inline extent creation has different conditions based on
> whether it's a compressed one or not.
> 
> But on the other hand, inline extent creation shouldn't be so
> distributed, we can just have a dedicated branch in
> btrfs_run_delalloc_range().
> 
> It will become more obvious for compressed inline cases, it makes no
> sense to go through all the complex async extent mechanism just to
> inline a single block.
> 
> So here we introduce a dedicated run_delalloc_inline() helper, and
> remove all inline related handling from cow_file_range() and
> compress_file_range().
> 
> There is a special update to inode_need_compress(), that a new
> @check_inline parameter is introduced.
> This is to allow inline specific checks to be done inside
> run_delalloc_inline(), which allows single block compression, but
> other call sites should always reject single block compression.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
> Changelog:
> v5:
> - Fix a bug if there is not enougn metadata space
>   If the metadata space is not enough to insert the inlined extent, the
>   old code will fallback to regular COW/NOCOW path, but the new code
>   will treat it as successfully insert.
> 
> - Add comments about the return value of __cow_file_range_inline()
>   Which follows the new run_delalloc_inline().
> 
> - Cleanup compressed bio structure early
>   So that we do not need extra cleanup later.
> 
> v4:
> - Reorder with the patch "btrfs: do compressed bio size roundup and zeroing in one go"
>   That patch is a pure cleanup, should not depend on this intrusive
>   patch.
> 
> - Remove the comment of ret > 0 case of cow_file_range()
>   As that function can no longer create inlined extent.
> 
> v3:
> - Fix a grammar error in the commit message
> 
> v2:
> - Fix a bug exposed in btrfs/344
>   Where the inode_need_compress() check allows single block to be
>   compressed.
>   Update inode_need_compress() to accept a new @check_inline parameter,
>   so that only inode_need_compress() in run_delalloc_inline() will allow
>   single block to be compressed, meanwhile all other call sites will
>   reject single block compression.
> 
> - Fix a leak of extent_state
> ---
>  fs/btrfs/inode.c | 220 +++++++++++++++++++++++------------------------
>  1 file changed, 110 insertions(+), 110 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 89ab33c5b940..c1abeb72069c 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -74,7 +74,6 @@
>  #include "delayed-inode.h"
>  
>  #define COW_FILE_RANGE_KEEP_LOCKED	(1UL << 0)
> -#define COW_FILE_RANGE_NO_INLINE	(1UL << 1)
>  
>  struct btrfs_iget_args {
>  	u64 ino;
> @@ -622,6 +621,10 @@ static bool can_cow_file_range_inline(struct btrfs_inode *inode,
>   *
>   * If being used directly, you must have already checked we're allowed to cow
>   * the range by getting true from can_cow_file_range_inline().
> + *
> + * Return 0 if the inlined extent is created successfully.
> + * Return <0 for critical error, and should be considered as an writeback error.
> + * Return >0 if can not create an inlined extent (mostly due to lack of meta space).
>   */
>  static noinline int __cow_file_range_inline(struct btrfs_inode *inode,
>  					    u64 size, size_t compressed_size,
> @@ -703,55 +706,6 @@ static noinline int __cow_file_range_inline(struct btrfs_inode *inode,
>  	return ret;
>  }
>  
> -static noinline int cow_file_range_inline(struct btrfs_inode *inode,
> -					  struct folio *locked_folio,
> -					  u64 offset, u64 end,
> -					  size_t compressed_size,
> -					  int compress_type,
> -					  struct folio *compressed_folio,
> -					  bool update_i_size)
> -{
> -	struct extent_state *cached = NULL;
> -	unsigned long clear_flags = EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
> -		EXTENT_DEFRAG | EXTENT_DO_ACCOUNTING | EXTENT_LOCKED;
> -	u64 size = min_t(u64, i_size_read(&inode->vfs_inode), end + 1);
> -	int ret;
> -
> -	if (!can_cow_file_range_inline(inode, offset, size, compressed_size))
> -		return 1;
> -
> -	btrfs_lock_extent(&inode->io_tree, offset, end, &cached);
> -	ret = __cow_file_range_inline(inode, size, compressed_size,
> -				      compress_type, compressed_folio,
> -				      update_i_size);
> -	if (ret > 0) {
> -		btrfs_unlock_extent(&inode->io_tree, offset, end, &cached);
> -		return ret;
> -	}
> -
> -	/*
> -	 * In the successful case (ret == 0 here), cow_file_range will return 1.
> -	 *
> -	 * Quite a bit further up the callstack in extent_writepage(), ret == 1
> -	 * is treated as a short circuited success and does not unlock the folio,
> -	 * so we must do it here.
> -	 *
> -	 * In the failure case, the locked_folio does get unlocked by
> -	 * btrfs_folio_end_all_writers, which asserts that it is still locked
> -	 * at that point, so we must *not* unlock it here.
> -	 *
> -	 * The other two callsites in compress_file_range do not have a
> -	 * locked_folio, so they are not relevant to this logic.
> -	 */
> -	if (ret == 0)
> -		locked_folio = NULL;
> -
> -	extent_clear_unlock_delalloc(inode, offset, end, locked_folio, &cached,
> -				     clear_flags, PAGE_UNLOCK |
> -				     PAGE_START_WRITEBACK | PAGE_END_WRITEBACK);
> -	return ret;
> -}
> -
>  struct async_extent {
>  	u64 start;
>  	u64 ram_size;
> @@ -797,7 +751,7 @@ static int add_async_extent(struct async_chunk *cow, u64 start, u64 ram_size,
>   * options, defragmentation, properties or heuristics.
>   */
>  static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
> -				      u64 end)
> +				      u64 end, bool check_inline)
>  {
>  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>  
> @@ -812,8 +766,9 @@ static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
>  	 * and will always fallback to regular write later.
>  	 */
>  	if (end + 1 - start <= fs_info->sectorsize &&
> -	    (start > 0 || end + 1 < inode->disk_i_size))
> +	    (!check_inline || (start > 0 || end + 1 < inode->disk_i_size)))
>  		return 0;
> +
>  	/* Defrag ioctl takes precedence over mount options and properties. */
>  	if (inode->defrag_compress == BTRFS_DEFRAG_DONT_COMPRESS)
>  		return 0;
> @@ -928,7 +883,6 @@ static void compress_file_range(struct btrfs_work *work)
>  		container_of(work, struct async_chunk, work);
>  	struct btrfs_inode *inode = async_chunk->inode;
>  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> -	struct address_space *mapping = inode->vfs_inode.i_mapping;
>  	struct compressed_bio *cb = NULL;
>  	u64 blocksize = fs_info->sectorsize;
>  	u64 start = async_chunk->start;
> @@ -1000,7 +954,7 @@ static void compress_file_range(struct btrfs_work *work)
>  	 * been flagged as NOCOMPRESS.  This flag can change at any time if we
>  	 * discover bad compression ratios.
>  	 */
> -	if (!inode_need_compress(inode, start, end))
> +	if (!inode_need_compress(inode, start, end, false))
>  		goto cleanup_and_bail_uncompressed;
>  
>  	if (0 < inode->defrag_compress && inode->defrag_compress < BTRFS_NR_COMPRESS_TYPES) {
> @@ -1021,35 +975,6 @@ static void compress_file_range(struct btrfs_work *work)
>  	total_compressed = cb->bbio.bio.bi_iter.bi_size;
>  	total_in = cur_len;
>  
> -	/*
> -	 * Try to create an inline extent.
> -	 *
> -	 * If we didn't compress the entire range, try to create an uncompressed
> -	 * inline extent, else a compressed one.
> -	 *
> -	 * Check cow_file_range() for why we don't even try to create inline
> -	 * extent for the subpage case.
> -	 */
> -	if (total_in < actual_end)
> -		ret = cow_file_range_inline(inode, NULL, start, end, 0,
> -					    BTRFS_COMPRESS_NONE, NULL, false);
> -	else
> -		ret = cow_file_range_inline(inode, NULL, start, end, total_compressed,
> -					    compress_type,
> -					    bio_first_folio_all(&cb->bbio.bio), false);
> -	if (ret <= 0) {
> -		cleanup_compressed_bio(cb);
> -		if (ret < 0)
> -			mapping_set_error(mapping, -EIO);
> -		return;
> -	}
> -	/*
> -	 * If a single block at file offset 0 cannot be inlined, fall back to
> -	 * regular writes without marking the file incompressible.
> -	 */
> -	if (start == 0 && end <= blocksize)
> -		goto cleanup_and_bail_uncompressed;
> -
>  	/*
>  	 * We aren't doing an inline extent. Round the compressed size up to a
>  	 * block size boundary so the allocator does sane things.
> @@ -1427,11 +1352,6 @@ static int cow_one_range(struct btrfs_inode *inode, struct folio *locked_folio,
>   *
>   * When this function fails, it unlocks all folios except @locked_folio.
>   *
> - * When this function successfully creates an inline extent, it returns 1 and
> - * unlocks all folios including locked_folio and starts I/O on them.
> - * (In reality inline extents are limited to a single block, so locked_folio is
> - * the only folio handled anyway).
> - *
>   * When this function succeed and creates a normal extent, the folio locking
>   * status depends on the passed in flags:
>   *
> @@ -1475,25 +1395,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>  	ASSERT(num_bytes <= btrfs_super_total_bytes(fs_info->super_copy));
>  
>  	inode_should_defrag(inode, start, end, num_bytes, SZ_64K);
> -
> -	if (!(flags & COW_FILE_RANGE_NO_INLINE)) {
> -		/* lets try to make an inline extent */
> -		ret = cow_file_range_inline(inode, locked_folio, start, end, 0,
> -					    BTRFS_COMPRESS_NONE, NULL, false);
> -		if (ret <= 0) {
> -			/*
> -			 * We succeeded, return 1 so the caller knows we're done
> -			 * with this page and already handled the IO.
> -			 *
> -			 * If there was an error then cow_file_range_inline() has
> -			 * already done the cleanup.
> -			 */
> -			if (ret == 0)
> -				ret = 1;
> -			goto done;
> -		}
> -	}
> -
>  	alloc_hint = btrfs_get_extent_allocation_hint(inode, start, num_bytes);
>  
>  	/*
> @@ -1571,7 +1472,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>  	}
>  	extent_clear_unlock_delalloc(inode, orig_start, end, locked_folio, &cached,
>  				     EXTENT_LOCKED | EXTENT_DELALLOC, page_ops);
> -done:
>  	if (done_offset)
>  		*done_offset = end;
>  	return ret;
> @@ -1874,7 +1774,7 @@ static int fallback_to_cow(struct btrfs_inode *inode,
>  	 * a locked folio, which can race with writeback.
>  	 */
>  	ret = cow_file_range(inode, locked_folio, start, end, NULL,
> -			     COW_FILE_RANGE_NO_INLINE | COW_FILE_RANGE_KEEP_LOCKED);
> +			     COW_FILE_RANGE_KEEP_LOCKED);
>  	ASSERT(ret != 1);
>  	return ret;
>  }
> @@ -2425,6 +2325,91 @@ static bool should_nocow(struct btrfs_inode *inode, u64 start, u64 end)
>  	return false;
>  }
>  
> +/*
> + * Return 0 if an inlined extent is created successfully.
> + * Return <0 if critical error happened.
> + * Return >0 if an inline extent can not be created.
> + */
> +static int run_delalloc_inline(struct btrfs_inode *inode, struct folio *locked_folio)
> +{
> +	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> +	struct compressed_bio *cb = NULL;
> +	struct extent_state *cached = NULL;
> +	const u64 i_size = i_size_read(&inode->vfs_inode);
> +	const u32 blocksize = fs_info->sectorsize;
> +	int compress_type = fs_info->compress_type;
> +	int compress_level = fs_info->compress_level;
> +	u32 compressed_size = 0;
> +	int ret;
> +
> +	ASSERT(folio_pos(locked_folio) == 0);
> +
> +	if (btrfs_inode_can_compress(inode) &&
> +	    inode_need_compress(inode, 0, blocksize, true)) {
> +		if (inode->defrag_compress > 0 &&
> +		    inode->defrag_compress < BTRFS_NR_COMPRESS_TYPES) {
> +			compress_type = inode->defrag_compress;
> +			compress_level = inode->defrag_compress_level;
> +		} else if (inode->prop_compress) {
> +			compress_type = inode->prop_compress;
> +		}
> +		cb = btrfs_compress_bio(inode, 0, blocksize, compress_type, compress_level, 0);
> +		if (IS_ERR(cb)) {
> +			cb = NULL;
> +			/* Just fall back to non-compressed case. */
> +		} else {
> +			compressed_size = cb->bbio.bio.bi_iter.bi_size;
> +		}
> +	}
> +	if (!can_cow_file_range_inline(inode, 0, i_size, compressed_size)) {
> +		if (cb)
> +			cleanup_compressed_bio(cb);
> +		return 1;
> +	}
> +
> +	btrfs_lock_extent(&inode->io_tree, 0, blocksize - 1, &cached);
> +	if (cb) {
> +		ret = __cow_file_range_inline(inode, i_size, compressed_size, compress_type,
> +					      bio_first_folio_all(&cb->bbio.bio), false);
> +		cleanup_compressed_bio(cb);
> +		cb = NULL;
> +	} else {
> +		ret = __cow_file_range_inline(inode, i_size, 0, BTRFS_COMPRESS_NONE,
> +					      NULL, false);
> +	}
> +	/*
> +	 * We failed to insert inline extent due to lack of meta space.
> +	 * Just unlock the extent io range and fallback to regular COW/NOCOW path.
> +	 */
> +	if (ret > 0) {
> +		btrfs_unlock_extent(&inode->io_tree, 0, blocksize - 1, &cached);
> +		return ret;
> +	}
> +
> +	/*
> +	 * In the successful case (ret == 0 here), btrfs_run_delalloc_range()
> +	 * will return 1.
> +	 *
> +	 * Quite a bit further up the callstack in extent_writepage(), ret == 1
> +	 * is treated as a short circuited success and does not unlock the folio,
> +	 * so we must do it here.
> +	 *
> +	 * For failure case, the @locked_folio does get unlocked by
> +	 * btrfs_folio_end_lock_bitmap(), so we must *not* unlock it here.
> +	 *
> +	 * So if ret == 0, we let extent_clear_unlock_delalloc() to unlock the
> +	 * folio by passing NULL as @locked_folio.
> +	 * Otherwise pass @locked_folio as usual.
> +	 */
> +	if (ret == 0)
> +		locked_folio = NULL;
> +	extent_clear_unlock_delalloc(inode, 0, blocksize - 1, locked_folio, &cached,
> +				     EXTENT_DELALLOC | EXTENT_DELALLOC_NEW | EXTENT_DEFRAG |
> +				     EXTENT_DO_ACCOUNTING | EXTENT_LOCKED,
> +				     PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK);
> +	return ret;
> +}
> +
>  /*
>   * Function to process delayed allocation (create CoW) for ranges which are
>   * being touched for the first time.
> @@ -2441,11 +2426,26 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct folio *locked_fol
>  	ASSERT(!(end <= folio_pos(locked_folio) ||
>  		 start >= folio_next_pos(locked_folio)));
>  
> +	if (start == 0 && end + 1 <= inode->root->fs_info->sectorsize &&
> +	    end + 1 >= inode->disk_i_size) {
> +		int ret;
> +
> +		ret = run_delalloc_inline(inode, locked_folio);
> +		if (ret < 0)
> +			return ret;
> +		if (ret == 0)
> +			return 1;
> +		/*
> +		 * Continue regular handling if we can not create an
> +		 * inlined extent.
> +		 */
> +	}
> +
>  	if (should_nocow(inode, start, end))
>  		return run_delalloc_nocow(inode, locked_folio, start, end);
>  
>  	if (btrfs_inode_can_compress(inode) &&
> -	    inode_need_compress(inode, start, end) &&
> +	    inode_need_compress(inode, start, end, false) &&
>  	    run_delalloc_compressed(inode, locked_folio, start, end, wbc))
>  		return 1;
>  
> -- 
> 2.53.0
> 

