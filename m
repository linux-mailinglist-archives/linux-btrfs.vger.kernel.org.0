Return-Path: <linux-btrfs+bounces-21079-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A19J1DCd2nKkgEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21079-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 20:36:48 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAC08CA3E
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 20:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93B3C302159F
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 19:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E429D279DB4;
	Mon, 26 Jan 2026 19:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="KHa1GOqr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zM8IXqpZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589B02517AA
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 19:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769456200; cv=none; b=VFv/08doXSqyCk7AD1/+7mICs7EL5bdLRp7MZ/ofsXODIa/Be4M2KraY2teqrfPJ03xo1gSsLDJq6ckhtiA1f6HqlXLLLpUFpkI9XuKbZl0eUlCvRAvONNIe4OXQr0kBEfz7d+8PcI7Z4KnZibM3ppqSjIKKvTTZFP+r0GSZ7SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769456200; c=relaxed/simple;
	bh=MHCIUhKV/9o3W7gPukLrZCyKS5s4cTvBDTtGFQOUW+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftKA+RRDDHK7++Qa9wefTkkY3PCgBz4dgcoAhA1QxZCjDciOkgiL4hfNwu41Avi6bkt3Ldvt5zJNKUZT/+f6Q2TnKtuZ3RQnLIma/FV8SifSb3/rVBTomAL2J7RtrxKEILy3hCgijlhsSfzrSm9O/t90gJ1WyY82jmgqlDyeIzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=KHa1GOqr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zM8IXqpZ; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 7A9BC1D00149;
	Mon, 26 Jan 2026 14:36:36 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 26 Jan 2026 14:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1769456196; x=1769542596; bh=Yzxp05SXEg
	vXcuGNc1wl2Nh6vj+0Ait6IceRv9vumR4=; b=KHa1GOqrb7ZYNlNAg/cW9tMz2w
	CKBKaG9UPW4WNnA07StbQuHZwE40zsgWz6gGTL4ylhHoKs/b52xWKrMCNiO9E4uf
	y3ZBBLNK4S21whi/0aG6sj/ZzyKcZBKzaOvhXvOHTIUVH/vdRCPQFIldVzDI1crQ
	p2XYwL7E7oI1ZapZweBHFgsBdK4MTfANLUAo4L/qZPTsiKRuZTOQh6BgOQRGq5hb
	w06ca2kONs91qqBQrebmcEEfT9nvqICCXNgv5JgFUbLTNpaPqOmyKn2KoHBiMkTx
	9sFYfreHwWMHo1bfmJUe6Ine7qYmd0ei9HE//LWpRrMR8CwGWslz+kGKWGNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769456196; x=1769542596; bh=Yzxp05SXEgvXcuGNc1wl2Nh6vj+0Ait6Ice
	Rv9vumR4=; b=zM8IXqpZRVjmadwA0sAdhiUDd4bjrjNlSp7N5QBkrdZ+vhq0zkB
	jaExGg8lhUj1B/8kRnJNMiJwn+E9N0TS2Nbza+yEeypNGofbplc3LUVpK+bMTJrn
	9d8F2R0V/gvQRSLkYWu6uauzTcJBpwf1VrIdafoZrFR343kZQgBh9ANf4Nbwmm/a
	2urKk8ox/BJluZ9m320bO0xli0X5xwVc6HF4ilL860ElY3mAZEn6RTFYOcJKWT3T
	ub5zP6e6tGhbbuNSqYVMccNyYjOUZi7pgQQKQ2vEzIitvNLSU+FGO0gXUQdI3Igx
	KlgRKXPP9DI+Z0+k9c0b1RqHB+1JlCBcXJQ==
X-ME-Sender: <xms:RMJ3aWRByuNnIGxpJOaacZWYn2qyeO-g1hwIqtDiTQCVDKHw-Tkp0Q>
    <xme:RMJ3aRxPoYwBIG-IB4b5tPRbbd35FB_ZixEhSFar6tJ6isRzeU5-ntPVRDgW4p4ij
    b_sx6hRtG75NhIbNy3zz_gSM2sFiJ2tbkpUIwvk71nCX-jnJzC9Q_U>
X-ME-Received: <xmr:RMJ3aRfN2jdbWoK9qzbfA6kpnkietTHdFqQMk-7WmPPipk5zMGiIYjA_TW6qnIpM-VVkXNnz_KF35oFZ-Xjp8bFsx00>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheekhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeeite
    ffhedtieetfeeffeelhedtheevheeviefftdethffggfeikeeuiefggedvjeenucffohhm
    rghinhepsghipghithgvrhdrsghinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifqhhusehsuhhsvgdrtghomhdprh
    gtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:RMJ3adJFeoegHNu-6h0Ly2HmsylJVLT9gDW9FgMKA_5qgf2soNpleg>
    <xmx:RMJ3aSHkKO3Mv7G2VBPhtVx8pDBlraMyOQ9PZOPnN1NCkrWriIBhYw>
    <xmx:RMJ3aXqzYkHkbyT70wh-s3YXeeI-e8MmVCk4fqRwooanEu9Pcs-lSA>
    <xmx:RMJ3abS5UqDt5SB5YLwToXf4bHdqTk3cT_dKy25qXzGJXx60WYoYvA>
    <xmx:RMJ3aScPL-lCnBcRP-Xg0A6K3FzLV8x8D32MlEx77wlJ47BYlkvIkBMu>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 14:36:35 -0500 (EST)
Date: Mon, 26 Jan 2026 11:36:13 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/9] btrfs: introduce btrfs_compress_bio() helper
Message-ID: <20260126193613.GC1066493@zen.localdomain>
References: <cover.1769397502.git.wqu@suse.com>
 <1e5609990460c9f56671336343b7a48a9da12f16.1769397502.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e5609990460c9f56671336343b7a48a9da12f16.1769397502.git.wqu@suse.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21079-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[bur.io];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 5AAC08CA3E
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 01:54:11PM +1030, Qu Wenruo wrote:
> The helper will allocate a new compressed_bio, do the compression, and
> return it to the caller.
> 
> This greatly simplifies the compression path, as we no longer need to
> allocate a folio array thus no extra error path, furthermore the
> compressed bio structure can be utilized for submission with very minor
> modifications (like rounding up the bi_size and populate the bi_sector).
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/compression.c | 63 ++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/compression.h | 13 +++++++++
>  2 files changed, 76 insertions(+)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 4323d4172c7b..56f8a3f31fbd 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -1064,6 +1064,69 @@ int btrfs_compress_folios(unsigned int type, int level, struct btrfs_inode *inod
>  	return ret;
>  }
>  
> +/*
> + * Given an address space and start and length, compress the page cache
> + * contents into @cb.
> + *
> + * @type_level is encoded algorithm and level, where level 0 means whatever
> + * default the algorithm chooses and is opaque here;
> + * - compression algo are 0-3
> + * - the level are bits 4-7
> + *
> + * @cb->bbio.bio.bi_iter.bi_size will indicate the compressed data size.
> + * The bi_size may not be sectorsize aligned, thus the caller still need
> + * to do the round up before submission.
> + */

I think it would be helpful to extend this documentation to include teh
fact that it allocates the compressed folios as a side effect and that
the caller is responsible for freeing them with the bio folio loop.

> +struct compressed_bio *btrfs_compress_bio(struct btrfs_inode *inode,
> +					  u64 start, u32 len, unsigned int type,
> +					  int level, blk_opf_t write_flags)
> +{
> +	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> +	struct list_head *workspace;
> +	struct compressed_bio *cb;
> +	int ret;
> +
> +	cb = alloc_compressed_bio(inode, start, REQ_OP_WRITE | write_flags,
> +				  end_bbio_compressed_write);
> +	cb->start = start;
> +	cb->len = len;
> +	cb->writeback = true;
> +	cb->compress_type = type;
> +
> +	level = btrfs_compress_set_level(type, level);
> +	workspace = get_workspace(fs_info, type, level);
> +	switch (type) {
> +	case BTRFS_COMPRESS_ZLIB:
> +		ret = zlib_compress_bio(workspace, cb);
> +		break;
> +	case BTRFS_COMPRESS_LZO:
> +		ret = lzo_compress_bio(workspace, cb);
> +		break;
> +	case BTRFS_COMPRESS_ZSTD:
> +		ret = zstd_compress_bio(workspace, cb);
> +		break;
> +	case BTRFS_COMPRESS_NONE:
> +	default:
> +		/*
> +		 * This can happen when compression races with remount setting
> +		 * it to 'no compress', while caller doesn't call
> +		 * inode_need_compress() to check if we really need to
> +		 * compress.
> +		 *
> +		 * Not a big deal, just need to inform caller that we
> +		 * haven't allocated any pages yet.
> +		 */
> +		ret = -E2BIG;
> +	}
> +
> +	put_workspace(fs_info, type, workspace);
> +	if (ret < 0) {
> +		cleanup_compressed_bio(cb);
> +		return ERR_PTR(ret);
> +	}
> +	return cb;
> +}
> +
>  static int btrfs_decompress_bio(struct compressed_bio *cb)
>  {
>  	struct btrfs_fs_info *fs_info = cb_to_fs_info(cb);
> diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
> index eee4190efa02..49cf0f5421e6 100644
> --- a/fs/btrfs/compression.h
> +++ b/fs/btrfs/compression.h
> @@ -146,6 +146,19 @@ int btrfs_compress_heuristic(struct btrfs_inode *inode, u64 start, u64 end);
>  
>  int btrfs_compress_filemap_get_folio(struct address_space *mapping, u64 start,
>  				     struct folio **in_folio_ret);
> +struct compressed_bio *btrfs_compress_bio(struct btrfs_inode *inode,
> +					  u64 start, u32 len, unsigned int type,
> +					  int level, blk_opf_t write_flags);
> +
> +static inline void cleanup_compressed_bio(struct compressed_bio *cb)
> +{
> +	struct bio *bio = &cb->bbio.bio;
> +	struct folio_iter fi;
> +

Isn't it possible to have an error half way through preparing the
compressed folios and to have a number of folios on the bio which were
allocated with btrfs_alloc_compr_folio so should be freed with
btrfs_free_compr_folio to keep the compressed pool management
accurate? Otherwise, I think we end up leaking the pool and not getting
to use it ever again?

Or is the caller responsible for that even if we return an error? If so,
why do we want to do an unconditional folio_put() here? Is there another
get that I am missing?

> +	bio_for_each_folio_all(fi, bio)
> +		folio_put(fi.folio);
> +	bio_put(bio);
> +}
>  
>  int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
>  			 u64 start, struct folio **folios, unsigned long *out_folios,
> -- 
> 2.52.0
> 

