Return-Path: <linux-btrfs+bounces-6719-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E4993D551
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 16:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20EFA1C206A5
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 14:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7C618EB1;
	Fri, 26 Jul 2024 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="YYtdia6I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904F84405
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722005360; cv=none; b=Bgr0bCHb3BwlFNrIEoBwlj4IQUELoz8+ctMVmj1HvbQobZw8NmnF+iYDEBkNv6Nj51YHckoaStqbfMQJFAYJmzQ8WucxvHUfzn8EQ2zp1tj3T0e26tySXA9RoKz39BHvl3lfOmT4P8hH4nLMeGK32rs6szp7E0gdx3qFtBtoZF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722005360; c=relaxed/simple;
	bh=UExDKkL2g4j2lB6UbSX5ZXlr7fZzVABp848yjLGouK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDLlbFO8uqXJC91KgUz+t9/0fh24aqeMstO4KBJ+AtJpcwkWgorUdrVA8xq0ABvy3o4kvgI//vzqbkK0o6DphmSvt9dBRdU0/+AUpnrmTzssbdcWSLMU0wtJG0QASIzoGAYmQO8ulzBTlXNKk92X9rNxb8aNMPQZWat39Va7hG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=YYtdia6I; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b798e07246so5265206d6.2
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 07:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722005357; x=1722610157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rpJFdeELZsInZFQ6w+X01Yp88MRXEvVhPlnWo0razdA=;
        b=YYtdia6IQZbHiECgNkmWJhzl6hRhxxvK9NYER9pmZxP+wuSKoNq0s5MvGeHaKrjGhM
         CdA04+4kSWxZG6Y0nLdlj17K0MzXmEhu2sTlGflGYYr644WS3Ch+z7hDJrFWjI5EuC5S
         NYd9uxU66qIcO3yu0X/ILYVYJT9HDOamdwJtcUQX3KCBCr3m0Ke7sF/ZI3ByVlj9bxNS
         AkCElcx4jRjtfQZ4k7Tu6/YewRJQPkkemN+HLGzWuFe/aCWUotbqU5bpBWyiiS5ALPW0
         6tNpD9kVVlOzyuiBVEibDGzG2cO7pfc+mbwFIUr3zA9ptZZZKHl4al+8CNRRh+RyEuW3
         PoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722005357; x=1722610157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpJFdeELZsInZFQ6w+X01Yp88MRXEvVhPlnWo0razdA=;
        b=IuM8cA0wwS/tTERK46sf4Gm2AG2up8uF6JDjrK3KytE9KngXmx8bItSBYjhrRMHOAE
         1JokwyurMNKDkUW1hW0rQXNCvAWyJS3KpIlYQ1L3WZcD08kackrOd+7nugmykky2uPBI
         M83Ai6inS0vmezcNP+DbtmnaOm5bg8sfuwNPQ1//V+KP/SNTP034LcDWY79mmU8s9S6Q
         zstvyZTjsXT/jOLevWOX11VDfSq3L2ZemlozIKwG85A613uPTTxqBKNk5ohg85k7ZhDF
         Mjlna1ktC3JSMYvuLUL6MILNjdYgv42tOymaVnZ1nyfwrDcnjmV1u6rCwRIgD+JjRKPz
         IlHA==
X-Gm-Message-State: AOJu0YyTrR3eyNYdtsOInxFx9jFoL1+n8cxRmLUO4qfUaPHIGq3iJNWQ
	bnxKYOuWzSq4rioyiDou8bRTUyaEyZZyXYnySoA4sxbcRSQ41BGB7eLYl0kgyp7QI979CG6Mle0
	M
X-Google-Smtp-Source: AGHT+IFwVPVdZv1zJ7DLuV8+/8dGUZ48bFJQysZGI+fzQpCS/hVDu7Y/euA5SViCD3bCC5nVrjbmyQ==
X-Received: by 2002:ad4:5bc8:0:b0:6b7:a042:6866 with SMTP id 6a1803df08f44-6bb55afa69fmr30406d6.36.1722005357234;
        Fri, 26 Jul 2024 07:49:17 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fa97575sm17130996d6.102.2024.07.26.07.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 07:49:16 -0700 (PDT)
Date: Fri, 26 Jul 2024 10:49:16 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs-progs: introduce btrfs_rebuild_uuid_tree() for
 mkfs and btrfs-convert
Message-ID: <20240726144916.GB3432726@perftesting>
References: <cover.1721987605.git.wqu@suse.com>
 <8e33931a4d078d1e1aa620aa5fe717f35146ef31.1721987605.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e33931a4d078d1e1aa620aa5fe717f35146ef31.1721987605.git.wqu@suse.com>

On Fri, Jul 26, 2024 at 07:29:55PM +0930, Qu Wenruo wrote:
> Currently mkfs uses its own create_uuid_tree(), but that function is
> only handling FS_TREE.
> 
> This means for btrfs-convert, we do not generate the uuid tree, nor
> add the UUID of the image subvolume.
> 
> This can be a problem if we're going to support multiple subvolumes
> during mkfs time.
> 
> To address this inconvenience, this patch introduces a new helper,
> btrfs_rebuild_uuid_tree(), which will:
> 
> - Create a new uuid tree if there is not one
> 
> - Empty the existing uuid tree
> 
> - Iterate through all subvolumes
>   * If the subvolume has no valid UUID, regenerate one
>   * Add the uuid entry for the subvolume UUID
>   * If the subvolume has received UUID, also add it to UUID tree
> 
> By this, this new helper can handle all the uuid tree generation needs for:
> 
> - Current mkfs
>   Only one uuid entry for FS_TREE
> 
> - Current btrfs-convert
>   Only FS_TREE and the image subvolume
> 
> - Future multi-subvolume mkfs
>   As we do the scan for all subvolumes.
> 
> - Future "btrfs rescue rebuild-uuid-tree"
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  common/root-tree-utils.c | 265 +++++++++++++++++++++++++++++++++++++++
>  common/root-tree-utils.h |   1 +
>  convert/main.c           |   5 +
>  mkfs/main.c              |  37 +-----
>  4 files changed, 274 insertions(+), 34 deletions(-)
> 
> diff --git a/common/root-tree-utils.c b/common/root-tree-utils.c
> index 6a57c51a8a74..13f89dbd5293 100644
> --- a/common/root-tree-utils.c
> +++ b/common/root-tree-utils.c
> @@ -15,9 +15,11 @@
>   */
>  
>  #include <time.h>
> +#include <uuid/uuid.h>
>  #include "common/root-tree-utils.h"
>  #include "common/messages.h"
>  #include "kernel-shared/disk-io.h"
> +#include "kernel-shared/uuid-tree.h"
>  
>  int btrfs_make_root_dir(struct btrfs_trans_handle *trans,
>  			struct btrfs_root *root, u64 objectid)
> @@ -212,3 +214,266 @@ abort:
>  	btrfs_abort_transaction(trans, ret);
>  	return ret;
>  }
> +
> +static int empty_tree(struct btrfs_root *root)
> +{
> +	struct btrfs_trans_handle *trans;
> +	struct btrfs_path path = { 0 };
> +	struct btrfs_key key = { 0 };
> +	int ret;
> +
> +	trans = btrfs_start_transaction(root, 1);
> +	if (IS_ERR(trans)) {
> +		ret = PTR_ERR(trans);
> +		errno = -ret;
> +		error_msg(ERROR_MSG_START_TRANS, "emptry tree: %m");
> +		return ret;
> +	}
> +	while (true) {
> +		int nr_items;
> +
> +		ret = btrfs_search_slot(trans, root, &key, &path, -1, 1);
> +		if (ret < 0) {
> +			errno = -ret;
> +			error("failed to locate the first key of root %lld: %m",
> +				root->root_key.objectid);
> +			btrfs_abort_transaction(trans, ret);
> +			return ret;
> +		}
> +		UASSERT(ret > 0);
> +		nr_items = btrfs_header_nritems(path.nodes[0]);
> +		/* The tree is empty. */
> +		if (nr_items == 0) {
> +			btrfs_release_path(&path);
> +			break;
> +		}
> +		ret = btrfs_del_items(trans, root, &path, 0, nr_items);
> +		btrfs_release_path(&path);
> +		if (ret < 0) {
> +			errno = -ret;
> +			error("failed to empty the first leaf of root %lld: %m",
> +				root->root_key.objectid);
> +			btrfs_abort_transaction(trans, ret);
> +			return ret;
> +		}
> +	}
> +	ret = btrfs_commit_transaction(trans, root);
> +	if (ret < 0) {
> +		errno = -ret;
> +		error_msg(ERROR_MSG_COMMIT_TRANS, "empty tree: %m");
> +	}
> +	return ret;
> +}
> +
> +static int rescan_subvol_uuid(struct btrfs_trans_handle *trans,
> +			      struct btrfs_key *subvol_key)
> +{
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	struct btrfs_root *subvol;
> +	int ret;
> +
> +	UASSERT(is_fstree(subvol_key->objectid));
> +
> +	/*
> +	 * Read out the subvolume root and updates root::root_item.
> +	 * This is to avoid de-sync between in-memory and on-disk root_items.
> +	 */
> +	subvol = btrfs_read_fs_root(fs_info, subvol_key);
> +	if (IS_ERR(subvol)) {
> +		ret = PTR_ERR(subvol);
> +		error("failed to read subvolume %llu: %m",
> +			subvol_key->objectid);
> +		btrfs_abort_transaction(trans, ret);
> +		return ret;
> +	}
> +	/* The uuid is not set, regenerate one. */
> +	if (uuid_is_null(subvol->root_item.uuid)) {
> +		uuid_generate(subvol->root_item.uuid);
> +		ret = btrfs_update_root(trans, fs_info->tree_root, &subvol->root_key,
> +					&subvol->root_item);
> +		if (ret < 0) {
> +			error("failed to update subvolume %llu: %m",
> +			      subvol_key->objectid);
> +			btrfs_abort_transaction(trans, ret);
> +			return ret;
> +		}
> +	}
> +	ret = btrfs_uuid_tree_add(trans, subvol->root_item.uuid,
> +				  BTRFS_UUID_KEY_SUBVOL,
> +				  subvol->root_key.objectid);
> +	if (ret < 0) {
> +		errno = -ret;
> +		error("failed to add uuid for subvolume %llu: %m",
> +		      subvol_key->objectid);
> +		btrfs_abort_transaction(trans, ret);
> +		return ret;
> +	}
> +	if (!uuid_is_null(subvol->root_item.received_uuid)) {
> +		ret = btrfs_uuid_tree_add(trans, subvol->root_item.uuid,
> +					  BTRFS_UUID_KEY_RECEIVED_SUBVOL,
> +					  subvol->root_key.objectid);
> +		if (ret < 0) {
> +			errno = -ret;
> +			error("failed to add received_uuid for subvol %llu: %m",
> +			      subvol->root_key.objectid);
> +			btrfs_abort_transaction(trans, ret);
> +			return ret;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int rescan_uuid_tree(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_root *tree_root = fs_info->tree_root;
> +	struct btrfs_root *uuid_root = fs_info->uuid_root;
> +	struct btrfs_trans_handle *trans;
> +	struct btrfs_path path = { 0 };
> +	struct btrfs_key key = { 0 };
> +	int ret;
> +
> +	UASSERT(uuid_root);
> +	trans = btrfs_start_transaction(uuid_root, 1);
> +	if (IS_ERR(trans)) {
> +		ret = PTR_ERR(trans);
> +		errno = -ret;
> +		error_msg(ERROR_MSG_START_TRANS, "rescan uuid tree: %m");
> +		return ret;
> +	}
> +	key.objectid = BTRFS_LAST_FREE_OBJECTID;
> +	key.type = BTRFS_ROOT_ITEM_KEY;
> +	key.offset = (u64)-1;
> +	/* Iterate through all subvolumes except fs tree. */
> +	while (true) {
> +		struct btrfs_key found_key;
> +		struct extent_buffer *leaf;
> +		int slot;
> +
> +		/* No more subvolume. */
> +		if (key.objectid < BTRFS_FIRST_FREE_OBJECTID) {
> +			ret = 0;
> +			break;
> +		}
> +		ret = btrfs_search_slot(NULL, tree_root, &key, &path, 0, 0);
> +		if (ret < 0) {
> +			errno = -ret;
> +			error_msg(ERROR_MSG_READ, "iterate subvolumes: %m");
> +			btrfs_abort_transaction(trans, ret);
> +			return ret;
> +		}
> +		if (ret > 0) {
> +			ret = btrfs_previous_item(tree_root, &path,
> +						  BTRFS_FIRST_FREE_OBJECTID,
> +						  BTRFS_ROOT_ITEM_KEY);
> +			if (ret < 0) {
> +				errno = -ret;
> +				btrfs_release_path(&path);
> +				error_msg(ERROR_MSG_READ, "iterate subvolumes: %m");
> +				btrfs_abort_transaction(trans, ret);
> +				return ret;
> +			}
> +			/* No more subvolume. */
> +			if (ret > 0) {
> +				ret = 0;
> +				btrfs_release_path(&path);
> +				break;
> +			}
> +		}
> +		leaf = path.nodes[0];
> +		slot = path.slots[0];
> +		btrfs_item_key_to_cpu(leaf, &found_key, slot);
> +		btrfs_release_path(&path);
> +		key.objectid = found_key.objectid - 1;
> +
> +		ret = rescan_subvol_uuid(trans, &found_key);
> +		if (ret < 0) {
> +			errno = -ret;
> +			error("failed to rescan the uuid of subvolume %llu: %m",
> +			      found_key.objectid);
> +			btrfs_abort_transaction(trans, ret);
> +			return ret;
> +		}
> +	}
> +
> +	/* Update fs tree uuid. */
> +	key.objectid = BTRFS_FS_TREE_OBJECTID;
> +	key.type = BTRFS_ROOT_ITEM_KEY;
> +	key.offset = 0;
> +	ret = rescan_subvol_uuid(trans, &key);
> +	if (ret < 0) {
> +		errno = -ret;
> +		error("failed to rescan the uuid of subvolume %llu: %m",
> +		      key.objectid);
> +		btrfs_abort_transaction(trans, ret);
> +		return ret;
> +	}
> +	ret = btrfs_commit_transaction(trans, uuid_root);
> +	if (ret < 0) {
> +		errno = -ret;
> +		error_msg(ERROR_MSG_COMMIT_TRANS, "rescan uuid tree: %m");
> +	}
> +	return ret;
> +}
> +
> +/*
> + * Rebuild the whole uuid tree.
> + *
> + * If no uuid tree is present, create a new one.
> + * If there is an existing uuid tree, all items would be deleted first.
> + *
> + * For all existing subvolumes (except fs tree), any uninitialized uuid
> + * (all zero) be generated using a random uuid, and inserted into the new tree.
> + * And if a subvolume has its UUID initialized, it would not be touched and
> + * be added to the new uuid tree.
> + */
> +int btrfs_rebuild_uuid_tree(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_root *uuid_root;
> +	struct btrfs_key key;
> +	int ret;
> +
> +	if (!fs_info->uuid_root) {
> +		struct btrfs_trans_handle *trans;
> +
> +		trans = btrfs_start_transaction(fs_info->tree_root, 1);
> +		if (IS_ERR(trans)) {
> +			ret = PTR_ERR(trans);
> +			errno = -ret;
> +			error_msg(ERROR_MSG_START_TRANS, "create uuid tree: %m");
> +			return ret;
> +		}
> +		key.objectid = BTRFS_UUID_TREE_OBJECTID;
> +		key.type = BTRFS_ROOT_ITEM_KEY;
> +		key.offset = 0;
> +		uuid_root = btrfs_create_tree(trans, &key);
> +		if (IS_ERR(uuid_root)) {
> +			ret = PTR_ERR(uuid_root);
> +			errno = -ret;
> +			error("failed to create uuid root: %m");
> +			btrfs_abort_transaction(trans, ret);
> +			return ret;
> +		}
> +		add_root_to_dirty_list(uuid_root);
> +		fs_info->uuid_root = uuid_root;
> +		ret = btrfs_commit_transaction(trans, fs_info->tree_root);
> +		if (ret < 0) {
> +			errno = -ret;
> +			error_msg(ERROR_MSG_COMMIT_TRANS, "create uuid tree: %m");
> +			return ret;
> +		}
> +	}

This can just be

} else {
	ret = empty_tree();
}

ret = rescan_uuid_tree(fs_info).

Thanks,

Josef

