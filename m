Return-Path: <linux-btrfs+bounces-3635-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0478488D073
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 23:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2715D1C3E977
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 22:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA4913DDA3;
	Tue, 26 Mar 2024 22:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f6al+4eq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E29D13DBAA
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 22:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711490859; cv=none; b=urWXGExU1BitG6b2S8Q7vlaz2OCFEHyaLCtM33Vd/LS901gxx51PZCialJWjMYyG5ONJmq7Ad/fVz47Qg0G5SywijKKWC+/dfepAajkoKVZRUYUmQO0F+gEIcaOR9iQUx0pMQzqKf20hdGwnVnDi8ZO+vtomNB19T5HSyyj8T1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711490859; c=relaxed/simple;
	bh=xArILC4rOX8YxQrbd21eUTHjzzvd5CK+W2YrHSBtHwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dhVS+p+7DPLYQBUyF3o68Y9LNwYnP7CuFRbJn2q1WE1VtxQU7DNVAyBjEFKZ1YHqSy3bKfgwnuc/GteQ26jntXL3CF2h923Wi9q/QgUmLcwyudXY8mMUzCsAeOJSS7s05LrnGrd66aLdqxX1P3dx59cPmnvMOL3jtzJjnFuxStg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f6al+4eq; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d28051376eso110441741fa.0
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 15:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1711490853; x=1712095653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XDWllbo2hZtdfHMIKhTK1LMbMgropri42y2uN8MKba4=;
        b=f6al+4equaHBGHXD8ZnsLJzu6burJ5G/+8j3Dk1910HgDmcGXzW6FkUURD2jBX7oqj
         0DjWae4fuS42wNyjSNiY/jHNQ9ycc3ORtQVRFOGViILDEGZu+18c64Wipaw2XRMkKK0r
         EoDHGlp7LcvrTaljs6Nngvf44ZJjI1NBxiC/fmWbG5IYJAlRy2gaqxYjuOQGKa1ISrVm
         PQdWfytIKzW6bNOXV2C4yAgQVZaS8y9OBhIhb3ylBR2bhE0K9sk7q79qHnIN9jscCNEa
         ctkRNczuRyZm4WPXvEDyvHiDRbDn2A0iTsWwovR0y5eB/Fiosib6tERwvkLXiwiqic0m
         7JVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711490853; x=1712095653;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XDWllbo2hZtdfHMIKhTK1LMbMgropri42y2uN8MKba4=;
        b=NVrwBe2AYCiGC+4/Uy63pu3Xj6L91WK8mKstGTdUYYs7lBC8zPCnSRMRpwMXkydFbG
         423RjiaKlw/Q9VrzL5NVXY0KnhekMY1aZ0qJFqgCLHqc/aFQs+67KU72Q8HE/XhV4i73
         waaGoKn9MZqj6blz/tVy6+0STEEtt7VYYClJIBxYIo3zftQfFnyUSoaRjznCqnYuk/US
         KDG+SmZvmWcbl7ZVtNGlg/t5DruPCZtyIhKuPaD5jxYsot2+Xtyd0A+UdUDnoZLTBH19
         ss+PiPRZ11yoz5Of9JP4hSDDjvgVlo/V4m4xJUObliUSlAetbI3aD7iJGTpFkifz3XPp
         GORQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6KPYEQ6g9J4xJ5DKOn/seQjR343dfjq8heXUmS02M+LD4FKAEdDsFivmJBH8ygCcWRkKCb4jFiN5fgwiRdZTR+mTDCWg3/T9Dbek=
X-Gm-Message-State: AOJu0Ywtd8CBQA1t/13iSavF7JLVfBHvyA+wjbnAYdYagylE6gM6sbFu
	omsIQnD8Ka9PlaVfGdUpxAY3l8LIU7Ig56L5FQcaPR8tMkMfeOztsK5+0xjrAFI=
X-Google-Smtp-Source: AGHT+IGz7RdAUes8+6gtxYd+PukYwfWfgqHZXmz+B0C9ciJfCAy6Jb9VWiJQkvZQaeTjgIvv/s86IQ==
X-Received: by 2002:a05:651c:4c8:b0:2d6:c9e8:cadb with SMTP id e8-20020a05651c04c800b002d6c9e8cadbmr917245lji.46.1711490853236;
        Tue, 26 Mar 2024 15:07:33 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id se7-20020a17090b518700b00299101c1341sm98190pjb.18.2024.03.26.15.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 15:07:32 -0700 (PDT)
Message-ID: <783373ae-12d1-4925-ae6f-413815a3cbd5@suse.com>
Date: Wed, 27 Mar 2024 08:37:28 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] btrfs: fix qgroup prealloc rsv leak in subvolume
 operations
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1711488980.git.boris@bur.io>
 <c39e9aea5fa5e22c42fcea3d810d78cb499312ff.1711488980.git.boris@bur.io>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <c39e9aea5fa5e22c42fcea3d810d78cb499312ff.1711488980.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/27 08:09, Boris Burkov 写道:
> Create subvol, create snapshot and delete subvol all use
> btrfs_subvolume_reserve_metadata to reserve metadata for the changes
> done to the parent subvolume's fs tree, which cannot be mediated in the
> normal way via start_transaction. When quota groups (squota or qgroups)
> are enabled, this reserves qgroup metadata of type PREALLOC. Once the
> operation is associated to a transaction, we convert PREALLOC to
> PERTRANS, which gets cleared in bulk at the end of the transaction.
> 
> However, the error paths of these three operations were not implementing
> this lifecycle correctly. They unconditionally converted the PREALLOC to
> PERTRANS in a generic cleanup step regardless of errors or whether the
> operation was fully associated to a transaction or not. This resulted in
> error paths occasionally converting this rsv to PERTRANS without calling
> record_root_in_trans successfully, which meant that unless that root got
> recorded in the transaction by some other thread, the end of the
> transaction would not free that root's PERTRANS, leaking it. Ultimately,
> this resulted in hitting a WARN in CONFIG_BTRFS_DEBUG builds at unmount
> for the leaked reservation.
> 
> The fix is to ensure that every qgroup PREALLOC reservation observes the
> following properties:
> 1. any failure before record_root_in_trans is called successfully
>     results in freeing the PREALLOC reservation.
> 2. after record_root_in_trans, we convert to PERTRANS, and now the
>     transaction owns freeing the reservation.
> 
> This patch enforces those properties on the three operations. Without
> it, generic/269 with squotas enabled at MKFS time would fail in ~5-10
> runs on my system. With this patch, it ran successfully 1000 times in a
> row.
> 
> Fixes: e85fde5162bf ("btrfs: qgroup: fix qgroup meta rsv leak for subvolume operations")

Thanks for pinning down the bug, and it looks fine to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   fs/btrfs/inode.c     | 13 ++++++++++++-
>   fs/btrfs/ioctl.c     | 37 ++++++++++++++++++++++++++++---------
>   fs/btrfs/root-tree.c | 10 ----------
>   fs/btrfs/root-tree.h |  2 --
>   4 files changed, 40 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 09f0a20b5ce8..2587a2e25e44 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4503,6 +4503,7 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
>   	struct btrfs_trans_handle *trans;
>   	struct btrfs_block_rsv block_rsv;
>   	u64 root_flags;
> +	u64 qgroup_reserved = 0;
>   	int ret;
>   
>   	down_write(&fs_info->subvol_sem);
> @@ -4547,12 +4548,20 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
>   	ret = btrfs_subvolume_reserve_metadata(root, &block_rsv, 5, true);
>   	if (ret)
>   		goto out_undead;
> +	qgroup_reserved = block_rsv.qgroup_rsv_reserved;
>   
>   	trans = btrfs_start_transaction(root, 0);
>   	if (IS_ERR(trans)) {
>   		ret = PTR_ERR(trans);
>   		goto out_release;
>   	}
> +	ret = btrfs_record_root_in_trans(trans, root);
> +	if (ret) {
> +		btrfs_abort_transaction(trans, ret);
> +		goto out_end_trans;
> +	}
> +	btrfs_qgroup_convert_reserved_meta(root, qgroup_reserved);
> +	qgroup_reserved = 0;
>   	trans->block_rsv = &block_rsv;
>   	trans->bytes_reserved = block_rsv.size;
>   
> @@ -4611,7 +4620,9 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
>   	ret = btrfs_end_transaction(trans);
>   	inode->i_flags |= S_DEAD;
>   out_release:
> -	btrfs_subvolume_release_metadata(root, &block_rsv);
> +	btrfs_block_rsv_release(fs_info, &block_rsv, (u64)-1, NULL);
> +	if (qgroup_reserved)
> +		btrfs_qgroup_free_meta_prealloc(root, qgroup_reserved);
>   out_undead:
>   	if (ret) {
>   		spin_lock(&dest->root_item_lock);
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index e3a72292eda9..888dc92c6c75 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -613,6 +613,7 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
>   	int ret;
>   	dev_t anon_dev;
>   	u64 objectid;
> +	u64 qgroup_reserved = 0;
>   
>   	root_item = kzalloc(sizeof(*root_item), GFP_KERNEL);
>   	if (!root_item)
> @@ -650,13 +651,18 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
>   					       trans_num_items, false);
>   	if (ret)
>   		goto out_new_inode_args;
> +	qgroup_reserved = block_rsv.qgroup_rsv_reserved;
>   
>   	trans = btrfs_start_transaction(root, 0);
>   	if (IS_ERR(trans)) {
>   		ret = PTR_ERR(trans);
> -		btrfs_subvolume_release_metadata(root, &block_rsv);
> -		goto out_new_inode_args;
> +		goto out_release_rsv;
>   	}
> +	ret = btrfs_record_root_in_trans(trans, BTRFS_I(dir)->root);
> +	if (ret)
> +		goto out;
> +	btrfs_qgroup_convert_reserved_meta(root, qgroup_reserved);
> +	qgroup_reserved = 0;
>   	trans->block_rsv = &block_rsv;
>   	trans->bytes_reserved = block_rsv.size;
>   	/* Tree log can't currently deal with an inode which is a new root. */
> @@ -767,9 +773,11 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
>   out:
>   	trans->block_rsv = NULL;
>   	trans->bytes_reserved = 0;
> -	btrfs_subvolume_release_metadata(root, &block_rsv);
> -
>   	btrfs_end_transaction(trans);
> +out_release_rsv:
> +	btrfs_block_rsv_release(fs_info, &block_rsv, (u64)-1, NULL);
> +	if (qgroup_reserved)
> +		btrfs_qgroup_free_meta_prealloc(root, qgroup_reserved);
>   out_new_inode_args:
>   	btrfs_new_inode_args_destroy(&new_inode_args);
>   out_inode:
> @@ -791,6 +799,8 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
>   	struct btrfs_pending_snapshot *pending_snapshot;
>   	unsigned int trans_num_items;
>   	struct btrfs_trans_handle *trans;
> +	struct btrfs_block_rsv *block_rsv;
> +	u64 qgroup_reserved = 0;
>   	int ret;
>   
>   	/* We do not support snapshotting right now. */
> @@ -827,19 +837,19 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
>   		goto free_pending;
>   	}
>   
> -	btrfs_init_block_rsv(&pending_snapshot->block_rsv,
> -			     BTRFS_BLOCK_RSV_TEMP);
> +	block_rsv = &pending_snapshot->block_rsv;
> +	btrfs_init_block_rsv(block_rsv, BTRFS_BLOCK_RSV_TEMP);
>   	/*
>   	 * 1 to add dir item
>   	 * 1 to add dir index
>   	 * 1 to update parent inode item
>   	 */
>   	trans_num_items = create_subvol_num_items(inherit) + 3;
> -	ret = btrfs_subvolume_reserve_metadata(BTRFS_I(dir)->root,
> -					       &pending_snapshot->block_rsv,
> +	ret = btrfs_subvolume_reserve_metadata(BTRFS_I(dir)->root, block_rsv,
>   					       trans_num_items, false);
>   	if (ret)
>   		goto free_pending;
> +	qgroup_reserved = block_rsv->qgroup_rsv_reserved;
>   
>   	pending_snapshot->dentry = dentry;
>   	pending_snapshot->root = root;
> @@ -852,6 +862,13 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
>   		ret = PTR_ERR(trans);
>   		goto fail;
>   	}
> +	ret = btrfs_record_root_in_trans(trans, BTRFS_I(dir)->root);
> +	if (ret) {
> +		btrfs_end_transaction(trans);
> +		goto fail;
> +	}
> +	btrfs_qgroup_convert_reserved_meta(root, qgroup_reserved);
> +	qgroup_reserved = 0;
>   
>   	trans->pending_snapshot = pending_snapshot;
>   
> @@ -881,7 +898,9 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
>   	if (ret && pending_snapshot->snap)
>   		pending_snapshot->snap->anon_dev = 0;
>   	btrfs_put_root(pending_snapshot->snap);
> -	btrfs_subvolume_release_metadata(root, &pending_snapshot->block_rsv);
> +	btrfs_block_rsv_release(fs_info, block_rsv, (u64)-1, NULL);
> +	if (qgroup_reserved)
> +		btrfs_qgroup_free_meta_prealloc(root, qgroup_reserved);
>   free_pending:
>   	if (pending_snapshot->anon_dev)
>   		free_anon_bdev(pending_snapshot->anon_dev);
> diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> index 4bb538a372ce..7007f9e0c972 100644
> --- a/fs/btrfs/root-tree.c
> +++ b/fs/btrfs/root-tree.c
> @@ -548,13 +548,3 @@ int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
>   	}
>   	return ret;
>   }
> -
> -void btrfs_subvolume_release_metadata(struct btrfs_root *root,
> -				      struct btrfs_block_rsv *rsv)
> -{
> -	struct btrfs_fs_info *fs_info = root->fs_info;
> -	u64 qgroup_to_release;
> -
> -	btrfs_block_rsv_release(fs_info, rsv, (u64)-1, &qgroup_to_release);
> -	btrfs_qgroup_convert_reserved_meta(root, qgroup_to_release);
> -}
> diff --git a/fs/btrfs/root-tree.h b/fs/btrfs/root-tree.h
> index 6f929cf3bd49..8f5739e732b9 100644
> --- a/fs/btrfs/root-tree.h
> +++ b/fs/btrfs/root-tree.h
> @@ -18,8 +18,6 @@ struct btrfs_trans_handle;
>   int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
>   				     struct btrfs_block_rsv *rsv,
>   				     int nitems, bool use_global_rsv);
> -void btrfs_subvolume_release_metadata(struct btrfs_root *root,
> -				      struct btrfs_block_rsv *rsv);
>   int btrfs_add_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
>   		       u64 ref_id, u64 dirid, u64 sequence,
>   		       const struct fscrypt_str *name);

