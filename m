Return-Path: <linux-btrfs+bounces-18503-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE25C27401
	for <lists+linux-btrfs@lfdr.de>; Sat, 01 Nov 2025 01:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C67251B21F61
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Nov 2025 00:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8D13B1AB;
	Sat,  1 Nov 2025 00:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="xcwPRW7c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vAO1muLu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDED7261E
	for <linux-btrfs@vger.kernel.org>; Sat,  1 Nov 2025 00:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761955751; cv=none; b=fn0FCJ4SdqvV/u9BWQpVUF9+mqrbvYalJE7k6nGKzWcGo2UwbJuK62ffnMk3V+wFGQZf2leZjgk2qllWtCEkPhpIfqsbazTsVQ+hBNKTr3EFtbdPcwCj+LVlEGOdjPXQ+q0N6qRTRVZDbyRb8P3mSKDWYkABf1RfwFObJ3CizsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761955751; c=relaxed/simple;
	bh=8DufflpMu6RL98CN54k9FegLAaRKtOF+2lvjsdCe++M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utCd8h2h5ecvRI0B6QqF2u4u6vQ+956yX7SdouUqRuZFrsmpDRUYm6CA2w6g6naSzc17m6UiaVjsX+AyTFfhfYFslPsXMSd2n2rpw3L1wjFVsAPHAg1h0n4PIDUFOth3l/tTbL8nsgiGU1S64sw4ds1GXuTlfhbGolyy7l79Xng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=xcwPRW7c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vAO1muLu; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 55AD1EC01F3;
	Fri, 31 Oct 2025 20:09:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 31 Oct 2025 20:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761955748; x=1762042148; bh=torVZbBKop
	lZlFvk6Se8Zwv3/N+R17kaklfgckxn+SQ=; b=xcwPRW7c2uJV0OI9mdgCu+dw8/
	JoPm1UNazq7rYZif/oT9HMDQLzJaB51wkDCJZOMDMQt4BUSDXFzmxho3g0SjppSB
	EKxO9jLbNm2XkxxcST5JsCGv22Ee/A8JwFlfhqnXKhNkJCs1ihunwY38SHO+iFJT
	1MxNxVqrxc6kVidmEBgTTl5gKtCvpokuIppDkv2IXaizyTYvT27GwwepzMu44DmF
	J3BAJZRDcfDbDfNI33hvRT/eS626lToL/glLH3AIHiOETk7LLb3iekSy0fSX/ZJu
	iT099ClGMeoUJ6GULJkFmBNZzBO4q7oUF9alhLXRo1U2gCBmfJxc+GFdZj/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761955748; x=1762042148; bh=torVZbBKoplZlFvk6Se8Zwv3/N+R17kaklf
	gckxn+SQ=; b=vAO1muLujmy0ALxzQz77u2K0w2Ao0+sbjlL2PapOyf4FVuSGedM
	oUr+x6zjaOPg5ri0Vuiv97JbsDWyH6JXT4w9KQak1ggTbpY/2LMgnqNb3vgm827E
	ggC1YUQ77Vyuu4xx2Oa14sWPwk9001fPeCixLJCPPF/EFGwf9zHh1S2c7RICGNJ2
	ZpL8QpboXlfqLQ7wz2bsnEM9/ZsADoHC8hHbW9Zr8gPCCza0YI78PTqMuxgCcyQk
	m9c9w5Tl0RjKs3TLOp6xTcB52jezd1FaifHiJer98O6ctY924K1p3KhLhhA7fXYa
	nmC85ZjVckfsRed2iMtKnj3WAY7bl+rrJBA==
X-ME-Sender: <xms:pE8FaXGDgZgdDI6FstZPWSCiaKxk4gcLDA8KB748RnM8NiodwYdzCg>
    <xme:pE8FaaUc_E3InocLbLIlWAeYSD1JUBsOdcpsC-6IJUwkWwNqTalJhJx6G7zi9Bigj
    e0ug5obJBMHVOTtYD05J3it3sktMERPuz6rnARP7a_KYKX6wFFi3rM>
X-ME-Received: <xmr:pE8FaWxmeWhTZld-Zyd89gKr7ULLmWPeaUtTLfRbi7a2MI1Dkwc30WxcKvzU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedtkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekud
    egjedutddvuddvleekgeeuuddvvdffgeehfeduuefhhfehgfehkeevvddtleenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:pE8FaQPtH8nBPfxHmDTW2UZmVk169Xklhd3zz3e1I28T7082h4iAzw>
    <xmx:pE8Faf4ZE1Q2mAFqrXVPPjCfef3P_TDOlTONJ2Igh3VE5eTKatNkeg>
    <xmx:pE8FaZMwPM3u4hdspcEvi1nyWIa0XPFqBC3vNzD_U-BTQsjWUP8HOA>
    <xmx:pE8FaVlzXZOf-JL3zvh43RFl60fAT8C7m-KHTUKmO-IJ7vCmTCgBJQ>
    <xmx:pE8FafaAfLTEoofyVP75YbZ6HqqjWbjpPvcQC-YBn9IsVCNOKgTqc6RL>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 20:09:07 -0400 (EDT)
Date: Fri, 31 Oct 2025 17:09:05 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 12/16] btrfs: replace identity remaps with actual
 remaps when doing relocations
Message-ID: <aQVPoWsIvwLXWePB@devvm12410.ftw0.facebook.com>
References: <20251024181227.32228-1-mark@harmstone.com>
 <20251024181227.32228-13-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024181227.32228-13-mark@harmstone.com>

On Fri, Oct 24, 2025 at 07:12:13PM +0100, Mark Harmstone wrote:
> Add a function do_remap_tree_reloc(), which does the actual work of
> doing a relocation using the remap tree.
> 
> In a loop we call do_remap_tree_reloc_trans(), which searches for the
> first identity remap for the block group. We call btrfs_reserve_extent()
> to find space elsewhere for it, and read the data into memory and write
> it to the new location. We then carve out the identity remap and replace
> it with an actual remap, which points to the new location in which to
> look.
> 
> Once the last identity remap has been removed we call
> last_identity_remap_gone(), which, as with deletions, removes the
> chunk's stripes and device extents.
> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>

Want to be as clear as possible on the reservation fragmentation
stuff, but otherwise LGTM.

Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/relocation.c | 317 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 317 insertions(+)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index d31817379078..ebbc619be682 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4640,6 +4640,61 @@ static int create_remap_tree_entries(struct btrfs_trans_handle *trans,
>  	return ret;
>  }
>  
> +static int find_next_identity_remap(struct btrfs_trans_handle *trans,
> +				    struct btrfs_path *path, u64 bg_end,
> +				    u64 last_start, u64 *start,
> +				    u64 *length)
> +{
> +	int ret;
> +	struct btrfs_key key, found_key;
> +	struct btrfs_root *remap_root = trans->fs_info->remap_root;
> +	struct extent_buffer *leaf;
> +
> +	key.objectid = last_start;
> +	key.type = BTRFS_IDENTITY_REMAP_KEY;
> +	key.offset = 0;
> +
> +	ret = btrfs_search_slot(trans, remap_root, &key, path, 0, 0);
> +	if (ret < 0)
> +		goto out;
> +
> +	leaf = path->nodes[0];
> +	while (true) {
> +		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
> +			ret = btrfs_next_leaf(remap_root, path);
> +
> +			if (ret != 0) {
> +				if (ret == 1)
> +					ret = -ENOENT;
> +				goto out;
> +			}
> +
> +			leaf = path->nodes[0];
> +		}
> +
> +		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
> +
> +		if (found_key.objectid >= bg_end) {
> +			ret = -ENOENT;
> +			goto out;
> +		}
> +
> +		if (found_key.type == BTRFS_IDENTITY_REMAP_KEY) {
> +			*start = found_key.objectid;
> +			*length = found_key.offset;
> +			ret = 0;
> +			goto out;
> +		}
> +
> +		path->slots[0]++;
> +	}
> +
> +out:
> +	btrfs_release_path(path);
> +
> +	return ret;
> +}
> +
>  static int remove_chunk_stripes(struct btrfs_trans_handle *trans,
>  				struct btrfs_chunk_map *chunk,
>  				struct btrfs_path *path)
> @@ -4753,6 +4808,96 @@ static void adjust_identity_remap_count(struct btrfs_trans_handle *trans,
>  		btrfs_mark_bg_fully_remapped(bg, trans);
>  }
>  
> +static int add_remap_entry(struct btrfs_trans_handle *trans,
> +			   struct btrfs_path *path,
> +			   struct btrfs_block_group *src_bg, u64 old_addr,
> +			   u64 new_addr, u64 length)
> +{
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	struct btrfs_key key, new_key;
> +	int ret;
> +	int identity_count_delta = 0;
> +
> +	key.objectid = old_addr;
> +	key.type = (u8)-1;
> +	key.offset = (u64)-1;
> +
> +	ret = btrfs_search_slot(trans, fs_info->remap_root, &key, path, -1, 1);
> +	if (ret < 0)
> +		goto end;
> +
> +	if (path->slots[0] == 0) {
> +		ret = -ENOENT;
> +		goto end;
> +	}
> +
> +	path->slots[0]--;
> +
> +	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
> +
> +	if (key.type != BTRFS_IDENTITY_REMAP_KEY ||
> +	    key.objectid > old_addr ||
> +	    key.objectid + key.offset <= old_addr) {
> +		ret = -ENOENT;
> +		goto end;
> +	}
> +
> +	/* Shorten or delete identity mapping entry. */
> +
> +	if (key.objectid == old_addr) {
> +		ret = btrfs_del_item(trans, fs_info->remap_root, path);
> +		if (ret)
> +			goto end;
> +
> +		identity_count_delta--;
> +	} else {
> +		new_key.objectid = key.objectid;
> +		new_key.type = BTRFS_IDENTITY_REMAP_KEY;
> +		new_key.offset = old_addr - key.objectid;
> +
> +		btrfs_set_item_key_safe(trans, path, &new_key);
> +	}
> +
> +	btrfs_release_path(path);
> +
> +	/* Create new remap entry. */
> +
> +	ret = add_remap_item(trans, path, new_addr, length, old_addr);
> +	if (ret)
> +		goto end;
> +
> +	/* Add entry for remainder of identity mapping, if necessary. */
> +
> +	if (key.objectid + key.offset != old_addr + length) {
> +		new_key.objectid = old_addr + length;
> +		new_key.type = BTRFS_IDENTITY_REMAP_KEY;
> +		new_key.offset = key.objectid + key.offset - old_addr - length;
> +
> +		ret = btrfs_insert_empty_item(trans, fs_info->remap_root,
> +					      path, &new_key, 0);
> +		if (ret)
> +			goto end;
> +
> +		btrfs_release_path(path);
> +
> +		identity_count_delta++;
> +	}
> +
> +	/* Add backref. */
> +
> +	ret = add_remap_backref_item(trans, path, new_addr, length, old_addr);
> +	if (ret)
> +		goto end;
> +
> +	if (identity_count_delta != 0)
> +		adjust_identity_remap_count(trans, src_bg, identity_count_delta);
> +
> +end:
> +	btrfs_release_path(path);
> +
> +	return ret;
> +}
> +
>  static int mark_chunk_remapped(struct btrfs_trans_handle *trans,
>  			       struct btrfs_path *path, uint64_t start)
>  {
> @@ -4802,6 +4947,169 @@ static int mark_chunk_remapped(struct btrfs_trans_handle *trans,
>  	return ret;
>  }
>  
> +static int do_remap_tree_reloc_trans(struct btrfs_fs_info *fs_info,
> +				     struct btrfs_block_group *src_bg,
> +				     struct btrfs_path *path, u64 *last_start)
> +{
> +	struct btrfs_trans_handle *trans;
> +	struct btrfs_root *extent_root;
> +	struct btrfs_key ins;
> +	struct btrfs_block_group *dest_bg = NULL;
> +	u64 start, remap_length, length, new_addr, min_size;
> +	int ret;
> +	bool no_more = false;
> +	bool is_data = src_bg->flags & BTRFS_BLOCK_GROUP_DATA;
> +	bool made_reservation = false, bg_needs_free_space;
> +	struct btrfs_space_info *sinfo = src_bg->space_info;
> +
> +	extent_root = btrfs_extent_root(fs_info, src_bg->start);
> +
> +	trans = btrfs_start_transaction(extent_root, 0);
> +	if (IS_ERR(trans))
> +		return PTR_ERR(trans);
> +
> +	mutex_lock(&fs_info->remap_mutex);
> +
> +	ret = find_next_identity_remap(trans, path, src_bg->start + src_bg->length,
> +				       *last_start, &start, &remap_length);
> +	if (ret == -ENOENT) {
> +		no_more = true;
> +		goto next;
> +	} else if (ret) {
> +		mutex_unlock(&fs_info->remap_mutex);
> +		btrfs_end_transaction(trans);
> +		return ret;
> +	}
> +
> +	/* Try to reserve enough space for block. */
> +
> +	spin_lock(&sinfo->lock);
> +	btrfs_space_info_update_bytes_may_use(sinfo, remap_length);
> +	spin_unlock(&sinfo->lock);
> +
> +	if (is_data)
> +		min_size = fs_info->sectorsize;
> +	else
> +		min_size = fs_info->nodesize;

As Qu mentioned, I think it makes sense to not change too much at once
and not add the extra fragmentation factor baked in with remap tree.
This isn't a format change so we can change it later if we have data
about lots of failing relocations to support that.

On the other hand, we are going contiguous non-free at a time rather
than extent at a time, so maybe this is actually quite necessary.

Let's document / highlight that if it's the reasoning.

> +
> +	ret = btrfs_reserve_extent(fs_info->fs_root, remap_length,
> +				   remap_length, min_size,
> +				   0, 0, &ins, is_data, false);
> +	if (ret) {
> +		spin_lock(&sinfo->lock);
> +		btrfs_space_info_update_bytes_may_use(sinfo, -remap_length);
> +		spin_unlock(&sinfo->lock);
> +
> +		mutex_unlock(&fs_info->remap_mutex);
> +		btrfs_end_transaction(trans);
> +		return ret;
> +	}
> +
> +	made_reservation = true;
> +
> +	new_addr = ins.objectid;
> +	length = ins.offset;
> +
> +	if (!is_data && !IS_ALIGNED(length, fs_info->nodesize)) {
> +		u64 new_length = ALIGN_DOWN(length, fs_info->nodesize);
> +
> +		btrfs_free_reserved_extent(fs_info, new_addr + new_length,
> +					   length - new_length, 0);
> +
> +		length = new_length;
> +	}
> +
> +	dest_bg = btrfs_lookup_block_group(fs_info, new_addr);
> +
> +	mutex_lock(&dest_bg->free_space_lock);
> +	bg_needs_free_space = test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE,
> +				       &dest_bg->runtime_flags);
> +	mutex_unlock(&dest_bg->free_space_lock);
> +
> +	if (bg_needs_free_space) {
> +		ret = btrfs_add_block_group_free_space(trans, dest_bg);
> +		if (ret)
> +			goto fail;
> +	}
> +
> +	ret = do_copy(fs_info, start, new_addr, length);
> +	if (ret)
> +		goto fail;
> +
> +	ret = btrfs_remove_from_free_space_tree(trans, new_addr, length);
> +	if (ret)
> +		goto fail;
> +
> +	ret = add_remap_entry(trans, path, src_bg, start, new_addr, length);
> +	if (ret) {
> +		btrfs_add_to_free_space_tree(trans, new_addr, length);
> +		goto fail;
> +	}
> +
> +	adjust_block_group_remap_bytes(trans, dest_bg, length);
> +	btrfs_free_reserved_bytes(dest_bg, length, 0);
> +
> +	spin_lock(&sinfo->lock);
> +	sinfo->bytes_readonly += length;
> +	spin_unlock(&sinfo->lock);
> +
> +next:
> +	if (dest_bg)
> +		btrfs_put_block_group(dest_bg);
> +
> +	if (made_reservation)
> +		btrfs_dec_block_group_reservations(fs_info, new_addr);
> +
> +	mutex_unlock(&fs_info->remap_mutex);
> +
> +	if (src_bg->identity_remap_count == 0)
> +		btrfs_mark_bg_fully_remapped(src_bg, trans);
> +
> +	ret = btrfs_end_transaction(trans);
> +	if (ret)
> +		return ret;
> +
> +	if (no_more)
> +		return 1;
> +
> +	*last_start = start;
> +
> +	return 0;
> +
> +fail:
> +	if (dest_bg)
> +		btrfs_put_block_group(dest_bg);
> +
> +	btrfs_free_reserved_extent(fs_info, new_addr, length, 0);
> +
> +	mutex_unlock(&fs_info->remap_mutex);
> +	btrfs_end_transaction(trans);
> +
> +	return ret;
> +}
> +
> +static int do_remap_tree_reloc(struct btrfs_fs_info *fs_info,
> +			       struct btrfs_path *path,
> +			       struct btrfs_block_group *bg)
> +{
> +	u64 last_start;
> +	int ret;
> +
> +	last_start = bg->start;
> +
> +	while (true) {
> +		ret = do_remap_tree_reloc_trans(fs_info, bg, path,
> +						&last_start);
> +		if (ret) {
> +			if (ret == 1)
> +				ret = 0;
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>  int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
>  			  u64 *length)
>  {
> @@ -5046,6 +5354,15 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
>  		}
>  
>  		ret = start_block_group_remapping(fs_info, path, bg);
> +		if (ret)
> +			goto out;
> +
> +		ret = do_remap_tree_reloc(fs_info, path, rc->block_group);
> +		if (ret)
> +			goto out;
> +
> +		btrfs_delete_unused_bgs(fs_info);
> +
>  		goto out;
>  	}
>  
> -- 
> 2.49.1
> 

