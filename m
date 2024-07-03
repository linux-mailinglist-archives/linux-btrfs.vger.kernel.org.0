Return-Path: <linux-btrfs+bounces-6176-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 625659266DF
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 19:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8590A1C209F8
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 17:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AE71849C3;
	Wed,  3 Jul 2024 17:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="EvtnFM+e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C5A17995
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Jul 2024 17:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026843; cv=none; b=h9j2NXFhDWvczV5R1+NO2nHrK+KL6uKeXRdTnuKYd0ch/8Ris6DDH4g9OFsgE7W+Z2gg+Otwv1hy4iCFJFXznghfceZhKaJ4HXKdfh4N0Lsm9uWpfk9iZnJ+FdGZ2/ut+JMgDxgJZ05MtyXeTCQd1hneUh4wqRTEGQPQ4Nl4aZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026843; c=relaxed/simple;
	bh=X2PXzp/mQvd+tGz6M25cP5EoUNLxKyQqrV2dgrWNdbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flFvGxNcSbcntXJzXLDlm88abQkjB3fLs4p+zWWuJjuvEpBw7vxNmGnBEpM0KMvyHTzg5MYHZm+i7D9eB8D8RmF8GKZUVa8W5dllQoUHaUNLrBbRIL5gKQPZ8GP/j2XIP7+u61jgjXrB/kyOfIUca/o6ndAt3oXme5JiVPkijRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=EvtnFM+e; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e039be89de9so2085331276.2
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Jul 2024 10:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1720026841; x=1720631641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9XYGbHRjAXsj09Xc50vMeMZlvBkQqSKZtZbuX+15CBU=;
        b=EvtnFM+eslMbD5vemU1kAzXHKfd5ub3YjHRO7lGWT8TSmqpwwUGneDrCSea7dMpwwq
         yxZdM9dJJY9jVpvqzBcjIbobXQSg+fur3fA4hUX5Ij3V2uDQX6l2Hcra66zppINKlC6W
         GcEXIjpeHryJVli41kLEdf7zLuP7+/6ckvmFSInOy9FsZqMqkVUIH1xNaIHjsqimZ2pQ
         rElSexaRAgCRRZCm9UCHFIt1o8oawwBZabZ3/6oqALQhjRfKVWflCIpBSJobVKcR+eo8
         AhV78y5EOZGhjBuipBuCbsMYgz1D77/JFwm+7WFWE13P6E8HRNRs1JFgeRY9BDbsQdtK
         v6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720026841; x=1720631641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XYGbHRjAXsj09Xc50vMeMZlvBkQqSKZtZbuX+15CBU=;
        b=Ohs5C7sCHH5MFTPcctq9HxJWWcHEjRYPgRBGedNp70LvuedpJuXEQgMX02CT7FJzcm
         gIRtjH63F4JKYrUkeMsJ6pVvR4A3VricudIUyqBEAKVm0zLHnwnoDmKBGZVvEoHt3kT8
         mW1gy9P/wc5pAdLc6v+WQ7Xm+Bmyl+tOL7v6bT69z+TavKnYOLBUzJQG/s7WmUD+uvP8
         5mLu6sGjJ46PNfkI9+5tB+cglMb8OZhcuufstfTQPNbxz0tgQN9fiIpNeWEN8oeME2Mh
         3oynQgdMgyT8RGN5ZZpdXacRnnf5Uydln3sqMsBRyiXMclgA++JN/Y75D9QZPayxP4Ue
         rezg==
X-Gm-Message-State: AOJu0Yz9ZP+fkS3I9BYxDLoSpT1Y/KclQNP6ZJ2R9xS+VeodYncu2Okk
	T1OLDCHpp3WEfNOdhZYJhCtuMGPDoTZo8Y4gMC5KKl0rH5+IeKL8KSCb5Aqxa+8Fhxcitvlbk6y
	g
X-Google-Smtp-Source: AGHT+IEMb16yRU+p6310czBAEplZHglcLAPMGqDGUdeVDYW81hli+UZTFK7O9Su164u+JkKwCTEmSA==
X-Received: by 2002:a05:6902:1007:b0:e03:b0aa:99a6 with SMTP id 3f1490d57ef6-e03b0aaa4f1mr2232257276.41.1720026840774;
        Wed, 03 Jul 2024 10:14:00 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4465140aef3sm52042991cf.36.2024.07.03.10.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 10:14:00 -0700 (PDT)
Date: Wed, 3 Jul 2024 13:13:59 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org, Mark Harmstone <maharmstone@meta.com>
Subject: Re: [PATCH] btrfs-progs: add rudimentary log checking
Message-ID: <20240703171359.GA736953@perftesting>
References: <20240703162925.493914-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703162925.493914-1-maharmstone@fb.com>

On Wed, Jul 03, 2024 at 05:28:32PM +0100, Mark Harmstone wrote:
> From: Mark Harmstone <maharmstone@meta.com>
> 
> Currently the transaction log is more or less ignored by btrfs check,
> meaning that it's possible for a FS with a corrupt log to pass btrfs
> check, but be immediately corrupted by the kernel when it's mounted.
> 
> This patch adds a check that if there's an inode in the log, any pending
> non-compressed writes also have corresponding csum entries.
> 
> Signed-off-by: Mark Harmstone <maharmstone@meta.com>
> ---
>  check/main.c | 293 ++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 281 insertions(+), 12 deletions(-)
> 
> diff --git a/check/main.c b/check/main.c
> index 83c721d3..6f3fab35 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -9787,6 +9787,263 @@ static int zero_log_tree(struct btrfs_root *root)
>  	return ret;
>  }
>  
> +static int check_log_csum(struct btrfs_root *root, u64 addr, u64 length)
> +{
> +	struct btrfs_path path = { 0 };
> +	struct btrfs_key key;
> +	struct extent_buffer *leaf;
> +	u16 csum_size = gfs_info->csum_size;
> +	u16 num_entries;
> +	u64 data_len;
> +	int ret;
> +
> +	key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
> +	key.type = BTRFS_EXTENT_CSUM_KEY;
> +	key.offset = addr;
> +
> +	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret > 0 && path.slots[0])
> +		path.slots[0]--;
> +
> +	ret = 0;
> +
> +	while (1) {
> +		leaf = path.nodes[0];
> +		if (path.slots[0] >= btrfs_header_nritems(leaf)) {
> +			ret = btrfs_next_leaf(root, &path);
> +			if (ret) {
> +				if (ret > 0)
> +					ret = 0;
> +
> +				break;
> +			}
> +			leaf = path.nodes[0];
> +		}
> +
> +		btrfs_item_key_to_cpu(leaf, &key, path.slots[0]);
> +
> +		if (key.objectid > BTRFS_EXTENT_CSUM_OBJECTID)
> +			break;
> +
> +		if (key.objectid == BTRFS_EXTENT_CSUM_OBJECTID &&
> +		    key.type == BTRFS_EXTENT_CSUM_KEY) {
> +			if (key.offset >= addr + length)
> +				break;
> +

You can turn this into

if (key.objectid != BTRFS_EXTENT_CSUM_OBJECTID ||
    key.type != BTRFS_EXTENT_CSUM_KEY)
	goto next;

if (key.offset >= addr + length)
	break;

and put a next at path.slots[0]++;

and then you don't have to indent the bits below.

> +			num_entries = btrfs_item_size(leaf, path.slots[0]) / csum_size;
> +			data_len = num_entries * gfs_info->sectorsize;
> +
> +			if (addr >= key.offset && addr + length <= key.offset + data_len) {
> +				u64 end = min(addr + length, key.offset + data_len);
> +
> +				length = addr + length - end;
> +				addr = end;
> +
> +				if (length == 0)
> +					break;
> +			}
> +		}
> +
> +		path.slots[0]++;
> +	}
> +
> +	btrfs_release_path(&path);
> +
> +	if (ret >= 0)
> +		ret = length == 0 ? 1 : 0;
> +
> +	return ret;
> +}
> +
> +static int check_log_root(struct btrfs_root *root, struct cache_tree *root_cache,
> +			  struct walk_control *wc)
> +{
> +	struct btrfs_path path = { 0 };
> +	struct btrfs_key key;
> +	struct extent_buffer *leaf;
> +	int ret, err = 0;
> +	u64 last_csum_inode = 0;
> +
> +	key.objectid = BTRFS_FIRST_FREE_OBJECTID;
> +	key.type = BTRFS_INODE_ITEM_KEY;
> +	key.offset = 0;
> +	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
> +	if (ret < 0)
> +		return 1;
> +
> +	while (1) {
> +		leaf = path.nodes[0];
> +		if (path.slots[0] >= btrfs_header_nritems(leaf)) {
> +			ret = btrfs_next_leaf(root, &path);
> +			if (ret) {
> +				if (ret < 0)
> +					err = 1;
> +
> +				break;
> +			}
> +			leaf = path.nodes[0];
> +		}
> +		btrfs_item_key_to_cpu(leaf, &key, path.slots[0]);
> +
> +		if (key.objectid == BTRFS_EXTENT_CSUM_OBJECTID)
> +			break;
> +
> +		if (key.type == BTRFS_INODE_ITEM_KEY) {
> +			struct btrfs_inode_item *item;
> +
> +			item = btrfs_item_ptr(leaf, path.slots[0],
> +					      struct btrfs_inode_item);
> +
> +			if (!(btrfs_inode_flags(leaf, item) & BTRFS_INODE_NODATASUM))
> +				last_csum_inode = key.objectid;
> +		} else if (key.type == BTRFS_EXTENT_DATA_KEY &&
> +			   key.objectid == last_csum_inode) {
> +			struct btrfs_file_extent_item *fi;
> +			u64 addr, length;
> +
> +			fi = btrfs_item_ptr(leaf, path.slots[0],
> +					    struct btrfs_file_extent_item);
> +
> +			if (btrfs_file_extent_type(leaf, fi) != BTRFS_FILE_EXTENT_REG)
> +				goto next;
> +
> +			if (btrfs_file_extent_compression(leaf, fi) != 0)
> +				goto next;

Compressed file extents should definitely have a csum associated with them.

> +
> +			addr = btrfs_file_extent_disk_bytenr(leaf, fi) +
> +				btrfs_file_extent_offset(leaf, fi);
> +			length = btrfs_file_extent_disk_num_bytes(leaf, fi);
> +
> +			ret = check_log_csum(root, addr, length);
> +			if (ret < 0) {
> +				err = 1;
> +				break;
> +			}
> +
> +			if (!ret) {
> +				error("csum missing in log (root %llu, inode %llu, "
> +				      "offset %llu, address 0x%llx, length %llu)",
> +				      root->objectid, last_csum_inode, key.offset,
> +				      addr, length);
> +				err = 1;
> +			}
> +		}
> +
> +next:
> +		path.slots[0]++;
> +	}
> +
> +	btrfs_release_path(&path);
> +
> +	return err;
> +}
> +
> +static int check_log(struct cache_tree *root_cache)
> +{
> +	struct btrfs_path path = { 0 };
> +	struct walk_control wc;
> +
> +	memset(&wc, 0, sizeof(wc));

You can just do

struct walk_contro wc = { 0 };

as well.

> +	cache_tree_init(&wc.shared);
> +
> +	struct btrfs_key key;
> +	struct extent_buffer *leaf;
> +	struct btrfs_root *log_root = gfs_info->log_root_tree;
> +	int ret;
> +	int err = 0;

We tend to prefer the declarations first, then code, so move this above please.

> +
> +	key.objectid = BTRFS_TREE_LOG_OBJECTID;
> +	key.type = BTRFS_ROOT_ITEM_KEY;
> +	key.offset = 0;
> +	ret = btrfs_search_slot(NULL, log_root, &key, &path, 0, 0);
> +	if (ret < 0) {
> +		err = 1;
> +		goto out;
> +	}
> +
> +	while (1) {
> +		leaf = path.nodes[0];
> +		if (path.slots[0] >= btrfs_header_nritems(leaf)) {
> +			ret = btrfs_next_leaf(log_root, &path);
> +			if (ret) {
> +				if (ret < 0)
> +					err = 1;
> +				break;
> +			}
> +			leaf = path.nodes[0];
> +		}
> +		btrfs_item_key_to_cpu(leaf, &key, path.slots[0]);
> +
> +		if (key.objectid > BTRFS_TREE_LOG_OBJECTID ||
> +		    key.type > BTRFS_ROOT_ITEM_KEY)
> +			break;
> +
> +		if (key.objectid == BTRFS_TREE_LOG_OBJECTID &&
> +		    key.type == BTRFS_ROOT_ITEM_KEY &&
> +		    fs_root_objectid(key.offset)) {
> +			struct btrfs_root tmp_root;
> +			struct extent_buffer *l;
> +			struct btrfs_tree_parent_check check = { 0 };
> +
> +			memset(&tmp_root, 0, sizeof(tmp_root));
> +
> +			btrfs_setup_root(&tmp_root, gfs_info, key.offset);
> +
> +			l = path.nodes[0];
> +			read_extent_buffer(l, &tmp_root.root_item,
> +					btrfs_item_ptr_offset(l, path.slots[0]),
> +					sizeof(tmp_root.root_item));
> +
> +			tmp_root.root_key.objectid = key.offset;
> +			tmp_root.root_key.type = BTRFS_ROOT_ITEM_KEY;
> +			tmp_root.root_key.offset = 0;
> +
> +			check.owner_root = btrfs_root_id(&tmp_root);
> +			check.transid = btrfs_root_generation(&tmp_root.root_item);
> +			check.level = btrfs_root_level(&tmp_root.root_item);
> +
> +			tmp_root.node = read_tree_block(gfs_info,
> +							btrfs_root_bytenr(&tmp_root.root_item),
> +							&check);
> +			if (IS_ERR(tmp_root.node)) {
> +				tmp_root.node = NULL;
> +				err = 1;
> +				goto next;
> +			}
> +
> +			if (btrfs_header_level(tmp_root.node) != btrfs_root_level(&tmp_root.root_item)) {
> +				error("root [%llu %llu] level %d does not match %d",
> +					tmp_root.root_key.objectid,
> +					tmp_root.root_key.offset,
> +					btrfs_header_level(tmp_root.node),
> +					btrfs_root_level(&tmp_root.root_item));
> +				err = 1;
> +				goto next;
> +			}

Turn the above into a helper.  Thanks,

Josef

