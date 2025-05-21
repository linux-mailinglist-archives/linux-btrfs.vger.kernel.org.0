Return-Path: <linux-btrfs+bounces-14142-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1190EABE864
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 02:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 130941BC2CCE
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 00:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DE42905;
	Wed, 21 May 2025 00:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="NklhGQVf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c8GRLlXs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB11910F1
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 00:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747785850; cv=none; b=OlVYF0seU1VvmT8SosOyFOJ+Te4ldZ1IucpAjdrUWUbNTGy5DqKOtGELs3bS9G8618wLF44ASTvCAPviIdX1qf2c7G6QKtiWHHI1nDsGMCcM6DoSQYYxbtvVtuOXT0fvWORuudVC+WcPVP3QjPWRIE7Hpn+9p1sQ8VZIp6156Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747785850; c=relaxed/simple;
	bh=Xu/FeMXRYP/Oq8krDaLuqFTXmzOwvY47/413mY6Z+Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLbWdGAShy+7Y/UQCTv1x/bIaQ2WW5004os696yQ/3/H+VzGNlnA68eXoX0nqbZ9J1tSU500o1K0CREvmFHMMoAADbKMaGTjSDSQ4FoM8RHVYvlkt6dZy373HZiP7G3N8xqVZbmhDXgkLck8XaFz0vkMWg90wRR0dfQIMOR1MG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=NklhGQVf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c8GRLlXs; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C382125400F5;
	Tue, 20 May 2025 20:04:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 20 May 2025 20:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1747785844; x=1747872244; bh=GZyQEDupNn
	lN1zzDjeo+J/NUogJxRtrjdwD9fUjwwdI=; b=NklhGQVfS8phy2aAXqC9GhMxvY
	bh5YmZbsEpLID94qBv0iUiB2vgxlKpU/TaOsMIREQTUvZllAGagFPDwaw7dJaWoz
	WYxXBspiATVi0S3ktjPmlCWmeoFVKo4J5IUFCpm85deX0fd1S/rIKJfMKrnK47Q7
	0nE1N4I5fjCDmBv+QEKwPRD4Z2mD6kgFN6xWXYUCPeSJ8TxGnrE979Udtb0lMZsm
	StYMDiFIo2ZvEAq7Ffc3Uya6TxvhMNqspFM9e8vVO88pp81TrOyr4LPnLpk7nnpG
	/XgHno6nY29Plk4G6DWJSa4ug3uHyl6+kl5/uy4PG/ldE8FohW0l318K3uzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747785844; x=1747872244; bh=GZyQEDupNnlN1zzDjeo+J/NUogJxRtrjdwD
	9fUjwwdI=; b=c8GRLlXsfSUPYDef3qqIyrsYrKXECdYXU0D00DBCokISQA2sC80
	m70L7xn6rrdhu5nh1sfUdDOtWL+BVHxSpckJpx6YWcqtpAIIKfZDG9gxIe3lrRXn
	OMKJdDkFEOJHrPiUs/UnOXGy3ofYdO/2sCf8k/AGFrQMK8gveVtbOanLdjhc/NFQ
	rvTaBzru/u7bWpjkj6o/aJAVECO7N/9EVdawBxJgtoFavxMvaTbaLt/Ris9JoL2g
	/9jQd55VJ9E9/DA1Ckswks7z4Uwh381Zw43TAViB7/NtQgVAWmX/sm7Fm2xTKYL7
	qeapUVdAHCZaQLxfh1auyeORcBeL9NsFcVA==
X-ME-Sender: <xms:cxgtaIgs2HngEdnNsq50y6FYkhtX2xysY45x9e3WaWMVMgDq_NJahA>
    <xme:cxgtaBBCY16eNoXyMjlv-1mJg8tsN-MrorGvd4wVu867eWviMXCWpe_h4SGPQL5tM
    HTIcdPKu8oGjSJ1yYM>
X-ME-Received: <xmr:cxgtaAHZvRvWQXLUGeli74cxIluVosi-8WiCga-K8HO9Iv8n_He6M5_8pj0QdyB7i1lD0gMMMhBCfjJtTbC3t0UBtNc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduieduucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhgg
    tggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorh
    hishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjedu
    hfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghp
    thhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrhhgrrhhmshhtoh
    hnvgesfhgsrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:dBgtaJS3m5AB6OS2_BFNf_YMwqTrbvTz0KqIuwOWM8jlvlpSOifHIg>
    <xmx:dBgtaFzm70lFJWljSoJD89MSSfadf3-Ib5riqDjjzLC9qxE1bgT0PA>
    <xmx:dBgtaH5Z0qmGcnC8a2oJUrotG6AOMjguioKFDGYYfu8hMkrXiGfVYg>
    <xmx:dBgtaCzgvIGmkgE34go382XOk-1TX_N2SAFG8kB196ZLY2UxaxD21Q>
    <xmx:dBgtaBGofWxj9u8whgoFobTpcIum7yo7_kRPg3aUl-9MYefLvjzkTHMB>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 20:04:03 -0400 (EDT)
Date: Tue, 20 May 2025 17:04:23 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [RFC PATCH 10/10] btrfs: replace identity maps with actual
 remaps when doing relocations
Message-ID: <20250521000423.GA204755@zen.localdomain>
References: <20250515163641.3449017-1-maharmstone@fb.com>
 <20250515163641.3449017-11-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515163641.3449017-11-maharmstone@fb.com>

On Thu, May 15, 2025 at 05:36:38PM +0100, Mark Harmstone wrote:
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

I think this is a good candidate for unit testing. Just hammer a bunch
of cases adding/removing/merging remaps.

> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
>  fs/btrfs/relocation.c | 522 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 522 insertions(+)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 7da95b82c798..bcf04d4c5af1 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4660,6 +4660,60 @@ static int mark_bg_remapped(struct btrfs_trans_handle *trans,
>  	return ret;
>  }
>  

Thinking out loud: I wonder if you do end up re-modeling the
transactions s.t. we do one transaction per loop or something, then
maybe you can use btrfs_for_each_slot.

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
> @@ -4779,6 +4833,288 @@ static int adjust_identity_remap_count(struct btrfs_trans_handle *trans,
>  	return ret;
>  }
>  
> +static int merge_remap_entries(struct btrfs_trans_handle *trans,
> +			       struct btrfs_path *path,
> +			       struct btrfs_block_group *src_bg, u64 old_addr,
> +			       u64 new_addr, u64 length)
> +{
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	struct btrfs_remap *remap_ptr;
> +	struct extent_buffer *leaf;
> +	struct btrfs_key key, new_key;
> +	u64 last_addr, old_length;
> +	int ret;
> +
> +	leaf = path->nodes[0];
> +	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
> +
> +	remap_ptr = btrfs_item_ptr(leaf, path->slots[0],
> +				   struct btrfs_remap);
> +
> +	last_addr = btrfs_remap_address(leaf, remap_ptr);
> +	old_length = key.offset;
> +
> +	if (last_addr + old_length != new_addr)
> +		return 0;
> +
> +	/* Merge entries. */
> +
> +	new_key.objectid = key.objectid;
> +	new_key.type = BTRFS_REMAP_KEY;
> +	new_key.offset = old_length + length;
> +
> +	btrfs_set_item_key_safe(trans, path, &new_key);
> +
> +	btrfs_release_path(path);
> +
> +	/* Merge backref too. */
> +
> +	key.objectid = new_addr - old_length;
> +	key.type = BTRFS_REMAP_BACKREF_KEY;
> +	key.offset = old_length;
> +
> +	ret = btrfs_search_slot(trans, fs_info->remap_root, &key, path, 0, 1);
> +	if (ret < 0) {
> +		return ret;
> +	} else if (ret == 1) {
> +		btrfs_release_path(path);
> +		return -ENOENT;
> +	}
> +
> +	new_key.objectid = new_addr - old_length;
> +	new_key.type = BTRFS_REMAP_BACKREF_KEY;
> +	new_key.offset = old_length + length;
> +
> +	btrfs_set_item_key_safe(trans, path, &new_key);
> +
> +	btrfs_release_path(path);
> +
> +	/* Fix the following identity map. */
> +
> +	key.objectid = old_addr;
> +	key.type = BTRFS_IDENTITY_REMAP_KEY;
> +	key.offset = 0;
> +
> +	ret = btrfs_search_slot(trans, fs_info->remap_root, &key, path, 0, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
> +
> +	if (key.objectid != old_addr || key.type != BTRFS_IDENTITY_REMAP_KEY)
> +		return -ENOENT;
> +
> +	if (key.offset == length) {
> +		ret = btrfs_del_item(trans, fs_info->remap_root, path);
> +		if (ret)
> +			return ret;
> +
> +		btrfs_release_path(path);
> +
> +		ret = adjust_identity_remap_count(trans, path, src_bg, -1);
> +		if (ret)
> +			return ret;
> +
> +		return 1;
> +	}
> +
> +	new_key.objectid = old_addr + length;
> +	new_key.type = BTRFS_IDENTITY_REMAP_KEY;
> +	new_key.offset = key.offset - length;
> +
> +	btrfs_set_item_key_safe(trans, path, &new_key);
> +
> +	btrfs_release_path(path);
> +
> +	return 1;
> +}
> +
> +static int add_new_remap_entry(struct btrfs_trans_handle *trans,
> +			       struct btrfs_path *path,
> +			       struct btrfs_block_group *src_bg, u64 old_addr,
> +			       u64 new_addr, u64 length)
> +{
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	struct btrfs_key key, new_key;
> +	struct btrfs_remap remap;
> +	int ret;
> +	int identity_count_delta = 0;
> +
> +	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
> +
> +	/* Shorten or delete identity mapping entry. */
> +
> +	if (key.objectid == old_addr) {
> +		ret = btrfs_del_item(trans, fs_info->remap_root, path);
> +		if (ret)
> +			return ret;
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
> +	new_key.objectid = old_addr;
> +	new_key.type = BTRFS_REMAP_KEY;
> +	new_key.offset = length;
> +
> +	ret = btrfs_insert_empty_item(trans, fs_info->remap_root,
> +		path, &new_key, sizeof(struct btrfs_remap));
> +	if (ret)
> +		return ret;
> +
> +	btrfs_set_stack_remap_address(&remap, new_addr);
> +
> +	write_extent_buffer(path->nodes[0], &remap,
> +		btrfs_item_ptr_offset(path->nodes[0], path->slots[0]),
> +		sizeof(struct btrfs_remap));
> +
> +	btrfs_release_path(path);
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
> +			return ret;
> +
> +		btrfs_release_path(path);
> +
> +		identity_count_delta++;
> +	}
> +
> +	/* Add backref. */
> +
> +	new_key.objectid = new_addr;
> +	new_key.type = BTRFS_REMAP_BACKREF_KEY;
> +	new_key.offset = length;
> +
> +	ret = btrfs_insert_empty_item(trans, fs_info->remap_root, path,
> +				      &new_key, sizeof(struct btrfs_remap));
> +	if (ret)
> +		return ret;
> +
> +	btrfs_set_stack_remap_address(&remap, old_addr);
> +
> +	write_extent_buffer(path->nodes[0], &remap,
> +		btrfs_item_ptr_offset(path->nodes[0], path->slots[0]),
> +		sizeof(struct btrfs_remap));
> +
> +	btrfs_release_path(path);
> +
> +	if (identity_count_delta == 0)
> +		return 0;
> +
> +	ret = adjust_identity_remap_count(trans, path, src_bg,
> +					  identity_count_delta);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int add_remap_entry(struct btrfs_trans_handle *trans,
> +			   struct btrfs_path *path,
> +			   struct btrfs_block_group *src_bg, u64 old_addr,
> +			   u64 new_addr, u64 length)
> +{
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	struct btrfs_key key;
> +	struct extent_buffer *leaf;
> +	int ret;
> +
> +	key.objectid = old_addr;
> +	key.type = BTRFS_IDENTITY_REMAP_KEY;
> +	key.offset = 0;
> +

Can this lookup code be shared at all with the remapping logic in the
previous patch? It seems fundamentally both are finding a remap entry for
a given logical address. Or is it impossible since this one needs cow?

Maybe some kind of prev_item helper that's either remap tree specific or
for this use case of going back exactly one item instead of obeying a
min_objectid?

> +	ret = btrfs_search_slot(trans, fs_info->remap_root, &key, path, 0, 1);
> +	if (ret < 0)
> +		goto end;
> +
> +	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
> +
> +	if (key.objectid >= old_addr) {
> +		if (path->slots[0] == 0) {
> +			ret = btrfs_prev_leaf(trans, fs_info->remap_root, path,
> +					      0, 1);
> +			if (ret < 0)
> +				goto end;
> +		} else {
> +			path->slots[0]--;
> +		}
> +	}
> +
> +	while (true) {
> +		leaf = path->nodes[0];
> +		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
> +			ret = btrfs_next_leaf(fs_info->remap_root, path);
> +			if (ret < 0)
> +				goto end;
> +			else if (ret == 1)
> +				break;
> +			leaf = path->nodes[0];
> +		}
> +
> +		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
> +
> +		if (key.objectid >= old_addr + length) {
> +			ret = -ENOENT;
> +			goto end;
> +		}
> +
> +		if (key.type != BTRFS_REMAP_KEY &&
> +		    key.type != BTRFS_IDENTITY_REMAP_KEY) {
> +			path->slots[0]++;
> +			continue;
> +		}
> +
> +		if (key.type == BTRFS_REMAP_KEY &&
> +		    key.objectid + key.offset == old_addr) {
> +			ret = merge_remap_entries(trans, path, src_bg, old_addr,
> +						  new_addr, length);
> +			if (ret < 0) {
> +				goto end;
> +			} else if (ret == 0) {
> +				path->slots[0]++;
> +				continue;
> +			}
> +			break;
> +		}
> +
> +		if (key.objectid <= old_addr &&
> +		    key.type == BTRFS_IDENTITY_REMAP_KEY &&
> +		    key.objectid + key.offset > old_addr) {
> +			ret = add_new_remap_entry(trans, path, src_bg,
> +						  old_addr, new_addr, length);
> +			if (ret)
> +				goto end;
> +			break;
> +		}
> +
> +		path->slots[0]++;
> +	}
> +
> +	ret = 0;
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
> @@ -4828,6 +5164,188 @@ static int mark_chunk_remapped(struct btrfs_trans_handle *trans,
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
> +	struct btrfs_chunk_map *chunk;
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

Why isn't this partly leaked if btrfs_reserve_extent returns a smaller extent than
remap_length?

> +	spin_unlock(&sinfo->lock);
> +
> +	if (is_data)
> +		min_size = fs_info->sectorsize;
> +	else
> +		min_size = fs_info->nodesize;
> +
> +	ret = btrfs_reserve_extent(fs_info->fs_root, remap_length,
> +				   remap_length, min_size,
> +				   0, 0, &ins, is_data, false);

^ i.e., this will reduce bytes_may_use by the amount it actually
reserved, and I don't see anywhere where we make up the difference. Then
it looks like we will remap the extent we can, find the next free range
and come back to this function and that remaining range to bytes_may_use
a second time.

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
> +	if (!is_data && length % fs_info->nodesize) {
> +		u64 new_length = length - (length % fs_info->nodesize);

Why not use the IS_ALIGNED / ALIGN_DOWN macros? Nodesize is a power of
two, so I think it should be quicker. Probably doesn't matter, but it
does seem to be the predominant pattern in the code base. Also avoids
ever worrying about dividing by zero.

> +
> +		btrfs_free_reserved_extent(fs_info, new_addr + new_length,
> +					   length - new_length, 0);
> +
> +		length = new_length;
> +	}
> +
> +	ret = add_to_free_space_tree(trans, start, length);

Can you explain this? Intuitively, to me, the old remapped address is
not a logical range we can allocate from, so it should not be in the
free space tree. Is this a hack to get the bytes back into the
accounting and allocations are blocked by the remapped block group being
remapped / read-only?

> +	if (ret)
> +		goto fail;
> +
> +	dest_bg = btrfs_lookup_block_group(fs_info, new_addr);
> +
> +	mutex_lock(&dest_bg->free_space_lock);
> +	bg_needs_free_space = test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE,
> +				       &dest_bg->runtime_flags);
> +	mutex_unlock(&dest_bg->free_space_lock);
> +
> +	if (bg_needs_free_space) {
> +		ret = add_block_group_free_space(trans, dest_bg);
> +		if (ret)
> +			goto fail;
> +	}
> +
> +	ret = remove_from_free_space_tree(trans, new_addr, length);
> +	if (ret)
> +		goto fail;

I think you have also discussed this recently with Josef, but it seems
a little sketchy. I suppose it depends if the remap tree ends up getting
delayed refs and going in the extent tree? I think this is currently
only called from alloc_reserved_extent.

> +
> +	ret = do_copy(fs_info, start, new_addr, length);
> +	if (ret)
> +		goto fail;
> +
> +	ret = add_remap_entry(trans, path, src_bg, start, new_addr, length);
> +	if (ret)
> +		goto fail;
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
> +	if (src_bg->used == 0 && src_bg->remap_bytes == 0) {
> +		chunk = btrfs_find_chunk_map(fs_info, src_bg->start, 1);
> +		if (!chunk) {
> +			mutex_unlock(&fs_info->remap_mutex);
> +			btrfs_end_transaction(trans);
> +			return -ENOENT;
> +		}
> +
> +		ret = last_identity_remap_gone(trans, chunk, src_bg, path);
> +		if (ret) {
> +			btrfs_free_chunk_map(chunk);
> +			mutex_unlock(&fs_info->remap_mutex);
> +			btrfs_end_transaction(trans);
> +			return ret;
> +		}
> +
> +		btrfs_free_chunk_map(chunk);
> +	}
> +
> +	mutex_unlock(&fs_info->remap_mutex);
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
> @@ -5073,6 +5591,10 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
>  		}
>  
>  		err = start_block_group_remapping(fs_info, path, bg);
> +		if (err)
> +			goto out;
> +
> +		err = do_remap_tree_reloc(fs_info, path, rc->block_group);
>  
>  		goto out;
>  	}
> -- 
> 2.49.0
> 

