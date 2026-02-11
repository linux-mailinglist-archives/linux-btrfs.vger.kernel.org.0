Return-Path: <linux-btrfs+bounces-21631-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CI/TKwq/jGmisgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21631-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 18:40:26 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D56126AD0
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 18:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6FF2B30093A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 17:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D82C34E741;
	Wed, 11 Feb 2026 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="YE+XEIJG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hTNPYenU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFE72877E5
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Feb 2026 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770831611; cv=none; b=GxFxkqsHmKDPI9cDipPEdR+F91vOmoNV+nWqP9SabDmWXMYEBQQrEnLd8R+ibWAGEzXsSIpeauW1NGAbMznXT0y+7gxbXpbHIgHG6W7qGQyUPeLsJL7bLK3A7mXEcLa/kn95FrL7J8uOZUcde1xfkSp3sbvDCig76TvxYNdEBbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770831611; c=relaxed/simple;
	bh=X2BwH1TlKj76WlnK0u07XOf7dHMFjNHTRHXD5P/jHzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzT4SWb76LGEWgIUEEI+rpPEr0aZMvjA7BASWjBoehwsgOSFo3d0pp+t0Sa1ayIR2KG5XieNcDwh6sj7z+P+kfcbFJ/IBbsz5KEMlk8hJkPbu58eMJ7P2xjjEmV0wuA9rxURxEDPGXumcljhq3EhjkjUMVP3vxncGSBjC1w8YoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=YE+XEIJG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hTNPYenU; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id B8EE81D00168;
	Wed, 11 Feb 2026 12:40:09 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 11 Feb 2026 12:40:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1770831609; x=1770918009; bh=X9h2/HuZqL
	of5/BU3qMJJEn/IykgMQRH5r+8HnvM+w8=; b=YE+XEIJG8H4FAZ/FgdRgbCbEiV
	5PLHKQ1oqawRNukQxzcmc0s5hS4tlQtx20GotTGxvtRL375/fp+5bEhnjQD+/YQe
	p8cLXk3gWbSUX4dVwSMuVTaJW9v+n6JyMlmfONFk96GaQLW7xGGNkWGG6qWwGrZl
	6Ov69vsLietg7uaTioqlD1kNUXiXrAiWJj2NQe1qOl96D8ZgA8Rfa6XKNzA3SvKC
	4N38YTxoTRRrT3aMVhNUVsDvbSZfqHYjTZqzAwcBQ1Dols5yonqRRbulHR57Xi8S
	j35dlafUQZdAtJugaN0pjqXWKuTk/aSommp6jk0C6hwUjYaS8RC/MZ3KV3IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770831609; x=1770918009; bh=X9h2/HuZqLof5/BU3qMJJEn/IykgMQRH5r+
	8HnvM+w8=; b=hTNPYenUo425xH5PFO3mN4SavFnfEkidmj3XSDn55JKfMyKPC6D
	vdhUV/8EzlTiFswWgkrXESxyGfM/i2bRdCUM0SLwT2mMi0/TEZ/HTkqsjtfA/FLX
	T/M4ugpQpuqwxj0QprFOK9N8by7H/1M8k7DQoE6gr/vBTi0ZLcFSiQeOtn01wTQi
	ykTJ6iaqhiUTAk9pNNbne2lNLQVVVCDx3ZDWnLlyADVF1ouKGa6/86zDQs+aw9gg
	EPZEHZ4ofAa5rwb6Qg8X9yrhjvSL9rB9myygXho03SrYIWzsuKDBFNNoRbTUhlZx
	piQjJmJZtgPePFjliVbREIMZMlW4r6CoI4w==
X-ME-Sender: <xms:-b6MaWd0EPGPXw-fbc2xT0p39Fra5o3aGWazRUxmUiP1M8UZS8y5hQ>
    <xme:-b6MaWO5HeZ3qE7ZD2nYXmuGZ3cc75L3O5bgQCgMsh5bPEa7Hfum6po-dPFeQtqEi
    CUnPBi_ljW9duSrwtcq81-CAdqSTjji3t7Rk52e-xKofqMze772Lg>
X-ME-Received: <xmr:-b6MaVLXw6QjM3fLvVvyEAXNsaE9t9RhoW6YwDQmuRFD1ElQbiIIvinep60NS_JpblByQdAxDTg17E4z4AwBm-GZdBc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdefudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhephedthfevgffhtdevgffhlefhgfeuueegtdevudeihe
    eiheetleeghedvfeegfeegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfhgumhgrnhgrnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    gsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:-b6MafGiSN5zvZvXb2ozXoByKhamien7XaPE0GZ-VcZvcVLR9kdA5A>
    <xmx:-b6MaVRkRAWYbj1-sNab7fXveIvgfxKZ6zjI9TbfuG5xP10WPKlJqw>
    <xmx:-b6MaTEbSqMBZIy8yB-TNJEidwEbN_LuR-CHh-puUPjo1SB9TjT3kA>
    <xmx:-b6MaZ9MvIWQdhK3t6aXMXorPW9odHoCJc3a5AX7UsCwNML90rkPtQ>
    <xmx:-b6MaTx1D6G3FDfIduvcEM-B7QButVc2Kl0ff8Yw0ADxmdSbi9Idvc9h>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 12:40:09 -0500 (EST)
Date: Wed, 11 Feb 2026 09:39:19 -0800
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 3/3] btrfs: check for NULL root after calls to
 btrfs_csum_root()
Message-ID: <20260211173919.GB1458991@zen.localdomain>
References: <cover.1770724034.git.fdmanana@suse.com>
 <54f2a569d1dda9eeb17b4839f6055631e13fab22.1770724034.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54f2a569d1dda9eeb17b4839f6055631e13fab22.1770724034.git.fdmanana@suse.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21631-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[bur.io];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bur.io:dkim,suse.com:email,meta.com:email,messagingengine.com:dkim]
X-Rspamd-Queue-Id: D2D56126AD0
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 11:57:50AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> btrfs_csum_root() can return a NULL pointer in case the root we are
> looking for is not in the rb tree that tracks roots. So add checks to
> every caller that is missing such check to log a message and return
> an error.

Similar question on if you think this one needs a Fixes.

> 
> Reported-by: Chris Mason <clm@meta.com>
> Link: https://lore.kernel.org/linux-btrfs/20260208161657.3972997-1-clm@meta.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/disk-io.c     |  4 ++++
>  fs/btrfs/extent-tree.c | 20 ++++++++++++++++++--
>  fs/btrfs/file-item.c   |  7 +++++++
>  fs/btrfs/inode.c       | 18 ++++++++++++++++--
>  fs/btrfs/raid56.c      | 12 ++++++++++--
>  fs/btrfs/relocation.c  |  8 ++++++++
>  fs/btrfs/tree-log.c    | 21 +++++++++++++++++++++
>  7 files changed, 84 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 4b1e67f176a3..99ce7c1ca53a 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1626,6 +1626,10 @@ static int backup_super_roots(struct btrfs_fs_info *info)
>  			btrfs_err(info, "missing extent root for extent at bytenr 0");
>  			return -EUCLEAN;
>  		}
> +		if (unlikely(!csum_root)) {
> +			btrfs_err(info, "missing csum root for extent at bytenr 0");
> +			return -EUCLEAN;
> +		}
>  
>  		btrfs_set_backup_extent_root(root_backup,
>  					     extent_root->node->start);
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 331263c206af..d1bfbad5adc6 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1974,8 +1974,15 @@ static int cleanup_ref_head(struct btrfs_trans_handle *trans,
>  			struct btrfs_root *csum_root;
>  
>  			csum_root = btrfs_csum_root(fs_info, head->bytenr);
> -			ret = btrfs_del_csums(trans, csum_root, head->bytenr,
> -					      head->num_bytes);
> +			if (unlikely(!csum_root)) {
> +				btrfs_err(fs_info,
> +					  "missing csum root for extent at bytenr %llu",
> +					  head->bytenr);
> +				ret = -EUCLEAN;
> +			} else {
> +				ret = btrfs_del_csums(trans, csum_root, head->bytenr,
> +						      head->num_bytes);
> +			}

nit: I sort of prefer early-exit/goto-cleanup as a general pattern rather
than nesting the work behind conditions, but I assume you did it on purpose
since it's the only early exit that cleans up?

I think it's nice that it makes all the code look predictable and the
same when checking the root.

>  		}
>  	}
>  
> @@ -3147,6 +3154,15 @@ static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
>  		struct btrfs_root *csum_root;
>  
>  		csum_root = btrfs_csum_root(trans->fs_info, bytenr);
> +		if (unlikely(!csum_root)) {
> +			ret = -EUCLEAN;
> +			btrfs_abort_transaction(trans, ret);
> +			btrfs_err(trans->fs_info,
> +				  "missing csum root for extent at bytenr %llu",
> +				  bytenr);
> +			return ret;
> +		}
> +
>  		ret = btrfs_del_csums(trans, csum_root, bytenr, num_bytes);
>  		if (unlikely(ret)) {
>  			btrfs_abort_transaction(trans, ret);
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 7bd715442f3e..f585ddfa8440 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -308,6 +308,13 @@ static int search_csum_tree(struct btrfs_fs_info *fs_info,
>  	/* Current item doesn't contain the desired range, search again */
>  	btrfs_release_path(path);
>  	csum_root = btrfs_csum_root(fs_info, disk_bytenr);
> +	if (unlikely(!csum_root)) {
> +		btrfs_err(fs_info,
> +			  "missing csum root for extent at bytenr %llu",
> +			  disk_bytenr);
> +		return -EUCLEAN;
> +	}
> +
>  	item = btrfs_lookup_csum(NULL, csum_root, path, disk_bytenr, 0);
>  	if (IS_ERR(item)) {
>  		ret = PTR_ERR(item);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 826809977df5..1cbaaf7a7230 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2013,6 +2013,13 @@ static int can_nocow_file_extent(struct btrfs_path *path,
>  	 */
>  
>  	csum_root = btrfs_csum_root(root->fs_info, io_start);
> +	if (unlikely(!csum_root)) {
> +		btrfs_err(root->fs_info,
> +			  "missing csum root for extent at bytenr %llu", io_start);
> +		ret = -EUCLEAN;
> +		goto out;
> +	}
> +
>  	ret = btrfs_lookup_csums_list(csum_root, io_start,
>  				      io_start + args->file_extent.num_bytes - 1,
>  				      NULL, nowait);
> @@ -2750,10 +2757,17 @@ static int add_pending_csums(struct btrfs_trans_handle *trans,
>  	int ret;
>  
>  	list_for_each_entry(sum, list, list) {
> -		trans->adding_csums = true;
> -		if (!csum_root)
> +		if (!csum_root) {
>  			csum_root = btrfs_csum_root(trans->fs_info,
>  						    sum->logical);
> +			if (unlikely(!csum_root)) {
> +				btrfs_err(trans->fs_info,
> +				  "missing csum root for extent at bytenr %llu",
> +					  sum->logical);
> +				return -EUCLEAN;
> +			}
> +		}
> +		trans->adding_csums = true;
>  		ret = btrfs_csum_file_blocks(trans, csum_root, sum);
>  		trans->adding_csums = false;
>  		if (ret)
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index baadaaa189c0..230dd93dad6e 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -2295,8 +2295,7 @@ void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
>  static void fill_data_csums(struct btrfs_raid_bio *rbio)
>  {
>  	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
> -	struct btrfs_root *csum_root = btrfs_csum_root(fs_info,
> -						       rbio->bioc->full_stripe_logical);
> +	struct btrfs_root *csum_root;
>  	const u64 start = rbio->bioc->full_stripe_logical;
>  	const u32 len = (rbio->nr_data * rbio->stripe_nsectors) <<
>  			fs_info->sectorsize_bits;
> @@ -2329,6 +2328,15 @@ static void fill_data_csums(struct btrfs_raid_bio *rbio)
>  		goto error;
>  	}
>  
> +	csum_root = btrfs_csum_root(fs_info, rbio->bioc->full_stripe_logical);
> +	if (unlikely(!csum_root)) {
> +		btrfs_err(fs_info,
> +			  "missing csum root for extent at bytenr %llu",
> +			  rbio->bioc->full_stripe_logical);
> +		ret = -EUCLEAN;
> +		goto error;
> +	}
> +
>  	ret = btrfs_lookup_csums_bitmap(csum_root, NULL, start, start + len - 1,
>  					rbio->csum_buf, rbio->csum_bitmap);
>  	if (ret < 0)
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 3906e457d2ef..8a8a66112d42 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -5641,6 +5641,14 @@ int btrfs_reloc_clone_csums(struct btrfs_ordered_extent *ordered)
>  	LIST_HEAD(list);
>  	int ret;
>  
> +	if (unlikely(!csum_root)) {
> +		btrfs_mark_ordered_extent_error(ordered);
> +		btrfs_err(fs_info,
> +			  "missing csum root for extent at bytenr %llu",
> +			  disk_bytenr);
> +		return -EUCLEAN;
> +	}
> +
>  	ret = btrfs_lookup_csums_list(csum_root, disk_bytenr,
>  				      disk_bytenr + ordered->num_bytes - 1,
>  				      &list, false);
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index e2806ca410f6..e9655095ba4c 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -984,6 +984,13 @@ static noinline int replay_one_extent(struct walk_control *wc)
>  
>  		sums = list_first_entry(&ordered_sums, struct btrfs_ordered_sum, list);
>  		csum_root = btrfs_csum_root(fs_info, sums->logical);
> +		if (unlikely(!csum_root)) {
> +			btrfs_err(fs_info,
> +				  "missing csum root for extent at bytenr %llu",
> +				  sums->logical);
> +			ret = -EUCLEAN;
> +		}
> +
>  		if (!ret) {
>  			ret = btrfs_del_csums(trans, csum_root, sums->logical,
>  					      sums->len);
> @@ -4890,6 +4897,13 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
>  		}
>  
>  		csum_root = btrfs_csum_root(trans->fs_info, disk_bytenr);
> +		if (unlikely(!csum_root)) {
> +			btrfs_err(trans->fs_info,
> +				  "missing csum root for extent at bytenr %llu",
> +				  disk_bytenr);
> +			return -EUCLEAN;
> +		}
> +
>  		disk_bytenr += extent_offset;
>  		ret = btrfs_lookup_csums_list(csum_root, disk_bytenr,
>  					      disk_bytenr + extent_num_bytes - 1,
> @@ -5086,6 +5100,13 @@ static int log_extent_csums(struct btrfs_trans_handle *trans,
>  	/* block start is already adjusted for the file extent offset. */
>  	block_start = btrfs_extent_map_block_start(em);
>  	csum_root = btrfs_csum_root(trans->fs_info, block_start);
> +	if (unlikely(!csum_root)) {
> +		btrfs_err(trans->fs_info,
> +			  "missing csum root for extent at bytenr %llu",
> +			  block_start);
> +		return -EUCLEAN;
> +	}
> +
>  	ret = btrfs_lookup_csums_list(csum_root, block_start + csum_offset,
>  				      block_start + csum_offset + csum_len - 1,
>  				      &ordered_sums, false);
> -- 
> 2.47.2
> 

