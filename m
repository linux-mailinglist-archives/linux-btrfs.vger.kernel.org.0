Return-Path: <linux-btrfs+bounces-18505-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD36FC2741F
	for <lists+linux-btrfs@lfdr.de>; Sat, 01 Nov 2025 01:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F35A1B21A28
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Nov 2025 00:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7B586334;
	Sat,  1 Nov 2025 00:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="qTHo3roE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HeV/YC4d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA9E6F305
	for <linux-btrfs@vger.kernel.org>; Sat,  1 Nov 2025 00:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761955971; cv=none; b=uPioojXCiSj0peCKFn/ol3XDlif0rPGcsB0VF+rZ0k/P8hIvTN67SxoCTcOWxP1iyzL/emjNdcI7FuFYs7bKjH1i0lN98fyA7osGwI32nqD19o8ytEFyH8GDLB3GtNqA37E6Y1jOgo058sJJooYhO3sC8qOXltzskVTAlKR9rPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761955971; c=relaxed/simple;
	bh=Jf+vWHMvcpUhytEjZD8odLavk0l1/rt3VLVEvuQ0/AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6anPNfUFqQEMhq8DF4UmjW/xkjfSOZyr2cafutGQ+BylG5k/ra2uOuaQAPpibSwVF37ukEPchapZAfBOFcduwwaj0lMUpaqLt0hJlOD0dGrHeeHmKJp/Lfd5yOiYTIPMoG/2CqlK0YsBZJabzJ5ckgO3e4dfvQ2q7brHr3KMb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=qTHo3roE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HeV/YC4d; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 717ADEC011C;
	Fri, 31 Oct 2025 20:12:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 31 Oct 2025 20:12:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761955968; x=1762042368; bh=EXwHZlO8S3
	eNLhrYcRfMjJsGnN219WkQ3ZjqXToFI5Y=; b=qTHo3roE02pGzjF8yHS02cGC+p
	oB33MbtIGx+gcIwoI5rKuv8Yl8PleVnn1f36706smYiPRcy0aUkkRbziQdiWAkOR
	S09mJy/PLZkGyj+S82z9GHwSu0Lo2xhib5g00cpCCEWgydMUiMwNGEcKvx4Py1wi
	r8BzpwFqsv5ii6a6y3l3/0Qp9J7GwZvQji1Gus8ECpl2olkIXLxzubYRjXKB8M/D
	6uarcLvVuXe0KuRSxHGMg3i3n7HrMetldoeyYbR+M0+8d2LeXkv1rTm4vRq84BXS
	Ws4CV2EItzZCLBBY3Fd5wIvBi9je1xtBdPGQJBpHBN/TQXhPLJC6tzBPDiow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761955968; x=1762042368; bh=EXwHZlO8S3eNLhrYcRfMjJsGnN219WkQ3Zj
	qXToFI5Y=; b=HeV/YC4dh1uJohlrPgktb0wIMw19uWi+Un4t/h5+bNxqeFcCCOm
	zHL9Bdifi0XfG8+u37kjVJgjaSjVUdRuo5pbxh0yiwXBCPoEoNm8FsgzWDaBbFKc
	GRkcYo7Z29Ke8dhtNePMR7qZBABpkzsV7oT7lwUfVZXiyvKaBacPL83yRSoDiIh5
	nUP6tZ3giklSVg0qKl04n94ZA2OIGZJcncB6w3LqduXH+GsCCOV9ff14OpVFgx6v
	uIuakr2/Jkl1HLn/6lZ8F26n8TwLpmjQs0naPBCfrMmRA1NxASS19hqZbZ0sBTyh
	YFPy2lwMtdyg+oYXba8YibhmYsCs7LrpDlg==
X-ME-Sender: <xms:f1AFae_siqv-CtQtulE1QS5DdceJmJ-rL8lKaUd9ub9a7OXfnPq0jw>
    <xme:f1AFaUs77WF96AkqFQe0qqPqZT6uVC1xVAZ5dt96oL1Rq_jmXjImIGU1kSU_hr-Z1
    OXn0CDEPX6C9VJgv0c7BcTc6rs-B__yJ6heeiZPSJYEs8MGikDZlw>
X-ME-Received: <xmr:f1AFaRqXtLyasHJPebN-HPWW2NgDfz14iiV-Wt27s7105-hoHS78yFnNwnAo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedtledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:f1AFaRn7d5hFT7Ahi6M_WkXmDIu_fLzZC0wpAmFo1akug0sN0NkA5A>
    <xmx:f1AFaVzdgMlOxBI3aCN1CPbcdPByTCRBr2ndxWNMpaB5CTdHTmze-w>
    <xmx:f1AFaZnTJglSIz9DTfGsJufg2A7OfjJXnGjNkqhothrcrzXw2oirpA>
    <xmx:f1AFaedARGLc9ZwlpDq0xg6kP_rX0mg1dvEKJG1MLEdBWQtS6qXNFw>
    <xmx:gFAFaYQtT1cgq1b13vLRKx_YAllR-fNN4Z1b7wFMMxJlr1EAAYII9cZl>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 20:12:47 -0400 (EDT)
Date: Fri, 31 Oct 2025 17:12:44 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 13/16] btrfs: add do_remap param to
 btrfs_discard_extent()
Message-ID: <aQVQfG3ieugJYzOx@devvm12410.ftw0.facebook.com>
References: <20251024181227.32228-1-mark@harmstone.com>
 <20251024181227.32228-14-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024181227.32228-14-mark@harmstone.com>

On Fri, Oct 24, 2025 at 07:12:14PM +0100, Mark Harmstone wrote:
> btrfs_discard_extent() can be called either when an extent is removed
> or from walking the free-space tree. With a remapped block group these
> two things are no longer equivalent: the extent's addresses are
> remapped, while the free-space tree exclusively uses underlying
> addresses.
> 
> Add a do_remap parameter to btrfs_discard_extent() and
> btrfs_map_discard(), saying whether or not the address needs to be run
> through the remap tree first.
> 

Reviewed-by: Boris Burkov <boris@bur.io>

> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> ---
>  fs/btrfs/extent-tree.c      | 11 +++++++----
>  fs/btrfs/extent-tree.h      |  2 +-
>  fs/btrfs/free-space-cache.c |  2 +-
>  fs/btrfs/inode.c            |  2 +-
>  fs/btrfs/volumes.c          | 24 ++++++++++++++++++++++--
>  fs/btrfs/volumes.h          |  2 +-
>  6 files changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 10dc6f8d2f71..82dc88915b7e 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1380,7 +1380,7 @@ static int do_discard_extent(struct btrfs_discard_stripe *stripe, u64 *bytes)
>  }
>  
>  int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
> -			 u64 num_bytes, u64 *actual_bytes)
> +			 u64 num_bytes, u64 *actual_bytes, bool do_remap)
>  {
>  	int ret = 0;
>  	u64 discarded_bytes = 0;
> @@ -1398,7 +1398,8 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
>  		int i;
>  
>  		num_bytes = end - cur;
> -		stripes = btrfs_map_discard(fs_info, cur, &num_bytes, &num_stripes);
> +		stripes = btrfs_map_discard(fs_info, cur, &num_bytes,
> +					    &num_stripes, do_remap);
>  		if (IS_ERR(stripes)) {
>  			ret = PTR_ERR(stripes);
>  			if (ret == -EOPNOTSUPP)
> @@ -2914,7 +2915,8 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
>  
>  		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
>  			ret = btrfs_discard_extent(fs_info, start,
> -						   end + 1 - start, NULL);
> +						   end + 1 - start, NULL,
> +						   true);
>  
>  		next_state = btrfs_next_extent_state(unpin, cached_state);
>  		btrfs_clear_extent_dirty(unpin, start, end, &cached_state);
> @@ -2972,7 +2974,8 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
>  		ret = -EROFS;
>  		if (!TRANS_ABORTED(trans))
>  			ret = btrfs_discard_extent(fs_info, block_group->start,
> -						   block_group->length, NULL);
> +						   block_group->length, NULL,
> +						   true);
>  
>  		/*
>  		 * Not strictly necessary to lock, as the block_group should be
> diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
> index 6b67a4e528da..721b03d682b4 100644
> --- a/fs/btrfs/extent-tree.h
> +++ b/fs/btrfs/extent-tree.h
> @@ -162,7 +162,7 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
>  			struct extent_buffer *parent);
>  void btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info, u64 start, u64 end);
>  int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
> -			 u64 num_bytes, u64 *actual_bytes);
> +			 u64 num_bytes, u64 *actual_bytes, bool do_remap);
>  int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range);
>  int btrfs_handle_fully_remapped_bgs(struct btrfs_trans_handle *trans);
>  
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index ec9a97d75d10..91670d0af179 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -3675,7 +3675,7 @@ static int do_trimming(struct btrfs_block_group *block_group,
>  	spin_unlock(&block_group->lock);
>  	spin_unlock(&space_info->lock);
>  
> -	ret = btrfs_discard_extent(fs_info, start, bytes, &trimmed);
> +	ret = btrfs_discard_extent(fs_info, start, bytes, &trimmed, false);
>  	if (!ret) {
>  		*total_trimmed += trimmed;
>  		trim_state = BTRFS_TRIM_STATE_TRIMMED;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 79732756b87f..b31f6f1d53b0 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3305,7 +3305,7 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
>  				btrfs_discard_extent(fs_info,
>  						ordered_extent->disk_bytenr,
>  						ordered_extent->disk_num_bytes,
> -						NULL);
> +						NULL, true);
>  			btrfs_free_reserved_extent(fs_info,
>  					ordered_extent->disk_bytenr,
>  					ordered_extent->disk_num_bytes, true);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index cda94c6f5239..76c521485542 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3472,7 +3472,8 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset,
>  	 * filesystem's point of view.
>  	 */
>  	if (btrfs_is_zoned(fs_info)) {
> -		ret = btrfs_discard_extent(fs_info, chunk_offset, length, NULL);
> +		ret = btrfs_discard_extent(fs_info, chunk_offset, length, NULL,
> +					   true);
>  		if (ret)
>  			btrfs_info(fs_info,
>  				"failed to reset zone %llu after relocation",
> @@ -6112,7 +6113,7 @@ void btrfs_put_bioc(struct btrfs_io_context *bioc)
>   */
>  struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
>  					       u64 logical, u64 *length_ret,
> -					       u32 *num_stripes)
> +					       u32 *num_stripes, bool do_remap)
>  {
>  	struct btrfs_chunk_map *map;
>  	struct btrfs_discard_stripe *stripes;
> @@ -6136,6 +6137,25 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
>  	if (IS_ERR(map))
>  		return ERR_CAST(map);
>  
> +	if (do_remap && map->type & BTRFS_BLOCK_GROUP_REMAPPED) {
> +		u64 new_logical = logical;
> +
> +		ret = btrfs_translate_remap(fs_info, &new_logical, &length);
> +		if (ret)
> +			goto out_free_map;
> +
> +		if (new_logical != logical) {
> +			btrfs_free_chunk_map(map);
> +
> +			map = btrfs_get_chunk_map(fs_info, new_logical,
> +						  length);
> +			if (IS_ERR(map))
> +				return ERR_CAST(map);
> +
> +			logical = new_logical;
> +		}
> +	}
> +
>  	/* we don't discard raid56 yet */
>  	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
>  		ret = -EOPNOTSUPP;
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 0c64cae59f1c..ce8751c1b06a 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -732,7 +732,7 @@ int btrfs_map_repair_block(struct btrfs_fs_info *fs_info,
>  			   u32 length, int mirror_num);
>  struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
>  					       u64 logical, u64 *length_ret,
> -					       u32 *num_stripes);
> +					       u32 *num_stripes, bool do_remap);
>  int btrfs_read_sys_array(struct btrfs_fs_info *fs_info);
>  int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info);
>  struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
> -- 
> 2.49.1
> 

