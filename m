Return-Path: <linux-btrfs+bounces-19034-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AE1C60799
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Nov 2025 15:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA29D4E7442
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Nov 2025 14:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1141F12F8;
	Sat, 15 Nov 2025 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnhItb3D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B70A17993
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Nov 2025 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763218361; cv=none; b=eqNRD6SjBbiV+r84h+23wRXjXcFa+aLZ9LKU1lJB2blS4St/YSK/VuJrbJjTI+3CqyenqkC/6+1kDlA6Ljf6z2PZPxhOGB6ttnk9CqQ9CLWgaX+acdJA/m2zqlexfUtxFp0eXA/x6Kdp+F2JnF9oqQzEczJQ2b7SRx7lPIF4RBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763218361; c=relaxed/simple;
	bh=8r4N4n9aRziI41WP0wk+oGpaaogcVqK5YOPxskipzVo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=c9fX4fdxXeGkExTSe0B3gApSyxDVOc3KJLpaH6bU2f8nMxvI6YFFVIOrsGlVEZa314IvYZkaNZbzbM5k1aP6VXXUch5fKXphemZrZ6zABPWGQ35fuVbaPC9ExxzHT7LiNEosKV2qrc7+nIQYKoPr1H8xvoAUtlk4FTffWgzjp+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnhItb3D; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-3436b2dbfb9so434051a91.0
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Nov 2025 06:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763218359; x=1763823159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q5RrOOPNY9FX27uyJQ6WdzE31hn3C7FE3w3wZPJnoYU=;
        b=PnhItb3DNYJ1yRxKGG5XGyb1B3bhsqF/yCf2lImij2ubt97bogaVh5I3epy7FokPSg
         Bi81OoiBCabfVfj0R9vUR7vMNrANYsHtWY2+HLMRZHb8w924FiMKKUI3TNOmU4e4MJU0
         wt0aHTCzMXwZ2KDJAMUGZbV/3MJAGnU+xiY36MUYurFSQJVRmoQyaIvsIM0FN0w74zO3
         klFGQ/ueqzLJSJHCTlIH8U42bIrJuRATAb2YFeGHRejmH1cUVQ2JoP63FSdJwWJpKI6W
         pB1VVo/K/sID9iStQeR1OHd9pw2LrUmvGaL3t7MQt5Z1OS/uMF/fG/ZMQ4ZyNH57ZU9O
         Eqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763218359; x=1763823159;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q5RrOOPNY9FX27uyJQ6WdzE31hn3C7FE3w3wZPJnoYU=;
        b=h9AKGxQ0lZvonmzloYaADssFkl+sgENFVnz5OR1+Ypsy+qbRPUl48z0UcLLvuTaQiZ
         muh9s/BpK5WA9pOKCay3/ISJOuIFPFolXfbnZltzdpv1Ka2mzCHmDL5b1PeMGroopOhz
         xtQG4CAbm1RWF+okfRKSKmkBf7CIV1X5ovUMe5qlnkwAi4sDxSsSLOR6sjSOjO2b1BN2
         CH4e1tUa5xB1zdEaHc16MUbIop8N5hwfrzwwT6lZJHqSB0QW2Mh924fqoux/9S5D7D1e
         Be//2oLalmwlkHPlN0pYR7DRcVu7qwO5vok/WqJhwE53MG08WXh7Cwdi+Ww0HBdBk4Dw
         eMDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXUxmdnnaiHMQGtvgh00Fb5uNGfGG+72nSW1ExjXcMK+Fb6c1sfHmOhjOHnP+Rz94UEN45aQl1YwnO3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ2rsztS+7Fj/gjrEvJE8ZwUgPuKnKqrtXzgBf5q6yHPAyLUrS
	ejQoFX6R0YiW4rz0VKwJpzcaL25uJgBMt1bT33LPdqJRVIzh/MxgYLMrRyQG22IPEV8=
X-Gm-Gg: ASbGncu+LHE+0N4w0jGUBtq2Qo7SSnBX72CK21U7LnF5nhNnT5M2VnxhyFpcw0uTU7U
	xyjWY0ik2Kis40WpkfRSACno6VfmS7NO9DXyL/Qsit4nDUvVQhEctCtT6K0bqini1PqlFGNvPso
	SYMPSkZ8AfuwlTEFnYTL38wrX+cL61Vg3R5B0SG1s2BiSv/5LXdBq3S3hI0q5g7d8++r1IQhyEc
	53uSFHmHpCrSIafmInERvaPtDaBCfFrmdbtV7YBRpGHyVDnurO+vlEAhV7KFqiHa6dIf4G1nN2E
	Vsvlgan1IqYv4a8/8zJthnIF1POAecURCMuZv2kugbiJMZU+9P9fgWS9BFnXLR7CUIPesrjsqof
	zH3aFB1CqaEmeYVsZ4eNw8cui5CJcALdTa1PmozBVqFudQF3CHyffgSDJZbAAbjDa9lHEo4SiXe
	TeSCye6ZdbNW3BUn9sZxBupOH9
X-Google-Smtp-Source: AGHT+IG8TOo7saRYg2QTYnW6iQQd7ciV+YVIiLyjkCnn/EO5IlaWZv2mQFGcM1wOuE11mcXoQrArpw==
X-Received: by 2002:a17:902:db05:b0:295:2cab:dbc2 with SMTP id d9443c01a7336-2986a72c7fdmr42888575ad.6.1763218359349;
        Sat, 15 Nov 2025 06:52:39 -0800 (PST)
Received: from [192.168.1.13] ([104.28.237.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b10b4sm89055325ad.70.2025.11.15.06.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Nov 2025 06:52:39 -0800 (PST)
Message-ID: <18c7ae32-7cfb-427a-be9a-44fa97577359@gmail.com>
Date: Sat, 15 Nov 2025 22:52:31 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sun Yangkai <sunk67188@gmail.com>
Subject: Re: [PATCH v6 10/16] btrfs: handle setting up relocation of block
 group with remap-tree
To: mark@harmstone.com
Cc: boris@bur.io, linux-btrfs@vger.kernel.org
References: <20251114184745.9304-11-mark@harmstone.com>
Content-Language: en-US
In-Reply-To: <20251114184745.9304-11-mark@harmstone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

While reading the thread, I noticed the logic that builds the identity_remap
entries was a bit hard to follow.
I took the liberty of rewriting the function so that the two high-level cases
are immediately visible inside a single if/else. The result has no behavioral
change, and (at least to me) makes it obvious where the head/tail gaps are handled.
The modified code is shown below; feel free to pick it up if you find it useful.
Please let me know if I missed anything.

> 
> +static int create_remap_tree_entries(struct btrfs_trans_handle *trans,
> +				     struct btrfs_path *path,
> +				     struct btrfs_block_group *bg)
> +{
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	struct btrfs_free_space_info *fsi;
> +	struct btrfs_key key, found_key;
> +	struct extent_buffer *leaf;
> +	struct btrfs_root *space_root;
> +	u32 extent_count;
> +	struct space_run *space_runs = NULL;
> +	unsigned int num_space_runs = 0;
> +	struct btrfs_key *entries = NULL;
> +	unsigned int max_entries, num_entries;
> +	int ret;
> +
> +	mutex_lock(&bg->free_space_lock);
> +
> +	if (test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &bg->runtime_flags)) {
> +		mutex_unlock(&bg->free_space_lock);
> +
> +		ret = btrfs_add_block_group_free_space(trans, bg);
> +		if (ret)
> +			return ret;
> +
> +		mutex_lock(&bg->free_space_lock);
> +	}
> +
> +	fsi = btrfs_search_free_space_info(trans, bg, path, 0);
> +	if (IS_ERR(fsi)) {
> +		mutex_unlock(&bg->free_space_lock);
> +		return PTR_ERR(fsi);
> +	}
> +
> +	extent_count = btrfs_free_space_extent_count(path->nodes[0], fsi);
> +
> +	btrfs_release_path(path);
> +
> +	space_runs = kmalloc(sizeof(*space_runs) * extent_count, GFP_NOFS);
> +	if (!space_runs) {
> +		mutex_unlock(&bg->free_space_lock);
> +		return -ENOMEM;
> +	}
> +
> +	key.objectid = bg->start;
> +	key.type = 0;
> +	key.offset = 0;
> +
> +	space_root = btrfs_free_space_root(bg);
> +
> +	ret = btrfs_search_slot(trans, space_root, &key, path, 0, 0);
> +	if (ret < 0) {
> +		mutex_unlock(&bg->free_space_lock);
> +		goto out;
> +	}
> +
> +	ret = 0;
> +
> +	while (true) {
> +		leaf = path->nodes[0];
> +
> +		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
> +
> +		if (found_key.objectid >= bg->start + bg->length)
> +			break;
> +
> +		if (found_key.type == BTRFS_FREE_SPACE_EXTENT_KEY) {
> +			if (num_space_runs != 0 &&
> +			    space_runs[num_space_runs - 1].end == found_key.objectid) {
> +				space_runs[num_space_runs - 1].end =
> +					found_key.objectid + found_key.offset;
> +			} else {
> +				BUG_ON(num_space_runs >= extent_count);
> +
> +				space_runs[num_space_runs].start = found_key.objectid;
> +				space_runs[num_space_runs].end =
> +					found_key.objectid + found_key.offset;
> +
> +				num_space_runs++;
> +			}
> +		} else if (found_key.type == BTRFS_FREE_SPACE_BITMAP_KEY) {
> +			void *bitmap;
> +			unsigned long offset;
> +			u32 data_size;
> +
> +			offset = btrfs_item_ptr_offset(leaf, path->slots[0]);
> +			data_size = btrfs_item_size(leaf, path->slots[0]);
> +
> +			if (data_size != 0) {
> +				bitmap = kmalloc(data_size, GFP_NOFS);
> +				if (!bitmap) {
> +					mutex_unlock(&bg->free_space_lock);
> +					ret = -ENOMEM;
> +					goto out;
> +				}
> +
> +				read_extent_buffer(leaf, bitmap, offset,
> +						   data_size);
> +
> +				parse_bitmap(fs_info->sectorsize, bitmap,
> +					     data_size * BITS_PER_BYTE,
> +					     found_key.objectid, space_runs,
> +					     &num_space_runs);
> +
> +				BUG_ON(num_space_runs > extent_count);
> +
> +				kfree(bitmap);
> +			}
> +		}
> +
> +		path->slots[0]++;
> +
> +		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
> +			ret = btrfs_next_leaf(space_root, path);
> +			if (ret != 0) {
> +				if (ret == 1)
> +					ret = 0;
> +				break;
> +			}
> +			leaf = path->nodes[0];
> +		}
> +	}
> +
> +	btrfs_release_path(path);
> +
> +	mutex_unlock(&bg->free_space_lock);
> +
> +	max_entries = extent_count + 2;
> +	entries = kmalloc(sizeof(*entries) * max_entries, GFP_NOFS);
> +	if (!entries) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	num_entries = 0;
> +
> +	if (num_space_runs > 0 && space_runs[0].start > bg->start) {
> +		entries[num_entries].objectid = bg->start;
> +		entries[num_entries].type = BTRFS_IDENTITY_REMAP_KEY;
> +		entries[num_entries].offset = space_runs[0].start - bg->start;
> +		num_entries++;
> +	}
> +
> +	for (unsigned int i = 1; i < num_space_runs; i++) {
> +		entries[num_entries].objectid = space_runs[i - 1].end;
> +		entries[num_entries].type = BTRFS_IDENTITY_REMAP_KEY;
> +		entries[num_entries].offset =
> +			space_runs[i].start - space_runs[i - 1].end;
> +		num_entries++;
> +	}
> +
> +	if (num_space_runs == 0) {
> +		entries[num_entries].objectid = bg->start;
> +		entries[num_entries].type = BTRFS_IDENTITY_REMAP_KEY;
> +		entries[num_entries].offset = bg->length;
> +		num_entries++;
> +	} else if (space_runs[num_space_runs - 1].end < bg->start + bg->length) {
> +		entries[num_entries].objectid = space_runs[num_space_runs - 1].end;
> +		entries[num_entries].type = BTRFS_IDENTITY_REMAP_KEY;
> +		entries[num_entries].offset =
> +			bg->start + bg->length - space_runs[num_space_runs - 1].end;
> +		num_entries++;
> +	}
> +
> +	if (num_entries == 0)
> +		goto out;
> +
> +	bg->identity_remap_count = num_entries;
> +
> +	ret = add_remap_tree_entries(trans, path, entries, num_entries);

We can group the empty and non-empty space_runs cases into an if/else to make
the two main flows obvious and reduce scattered conditions:

 	num_entries = 0;

 	if (num_space_runs == 0) {
 		entries[num_entries].objectid = bg->start;
 		entries[num_entries].type = BTRFS_IDENTITY_REMAP_KEY;
 		entries[num_entries].offset = bg->length;
 		num_entries++;
 	} else {
 		if (space_runs[0].start > bg->start) {
 			entries[num_entries].objectid = bg->start;
 			entries[num_entries].type = BTRFS_IDENTITY_REMAP_KEY;
 			entries[num_entries].offset = space_runs[0].start - bg->start;
 			num_entries++;
 		}
 		for (unsigned int i = 1; i < num_space_runs; i++) {
 			entries[num_entries].objectid = space_runs[i - 1].end;
 			entries[num_entries].type = BTRFS_IDENTITY_REMAP_KEY;
 			entries[num_entries].offset =
 				space_runs[i].start - space_runs[i - 1].end;
 			num_entries++;
 		}
 		if (space_runs[num_space_runs - 1].end < bg->start + bg->length) {
 			entries[num_entries].objectid = space_runs[num_space_runs - 1].end;
 			entries[num_entries].type = BTRFS_IDENTITY_REMAP_KEY;
 			entries[num_entries].offset =
 				bg->start + bg->length - space_runs[num_space_runs - 1].end;
 			num_entries++;
 		}
 		if (num_entries == 0)
 			goto out;
 	}

	// I'm not sure if it's necessary but we can free space_runs earlier
	// since we're also doing allocation in add_remap_tree_entries().
	// kfree(space_runs);
	// space_runs = NULL;

 	bg->identity_remap_count = num_entries;

 	ret = add_remap_tree_entries(trans, path, entries, num_entries);


> +
> +out:
> +	kfree(entries);
> +	kfree(space_runs);
> +
> +	return ret;
> +}

Regards,
Sun Yangkai

