Return-Path: <linux-btrfs+bounces-6716-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC8D93D0D0
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 12:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95F352829E5
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 10:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0A9179949;
	Fri, 26 Jul 2024 10:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Flbfkbvz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29A3178395
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721988227; cv=none; b=DSfeJHsBc3MAaBhpfkCLXyoGtWh3Rqy+/1j0ptk2xU9swCtvLakU6WxEO98IT/qrxGuTuBVbygbcUlFWvG4Fi8bp8jW1xA6lhEKPm98E8LO2MU3SlLuESub9SZvVrewVKJ43AawRMod9f7HNBMoLYRyB3LXsfksYt/EgsvtPDsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721988227; c=relaxed/simple;
	bh=TEWMkxDdkT816MEsCPW0CUXPxxpZR5M9pW07dfQV1kw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=E5//tMaobFLNxmY1LSmCDDT/DocoevWPSDiEO2yf7QaSdCtrVKOJ+610yXqTSnzREx2E3N51ghTcgcrl+MQ6d0VmbWDKLRdAv3PzyAk4I5dbBUNuneiUBN7VoDxwI6ttUA44e4KaOu9jUD+4hzyVj05WimHf2hYBjuz2D09t6O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Flbfkbvz; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso14056101fa.2
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 03:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721988223; x=1722593023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l0vdJTtjiyTK3zH6i+n22gfNVvmNCq3yAEftFnoYQDU=;
        b=FlbfkbvzEPSQZsqR2h9ukkLaFWeyATJzeXyVUy/dqivbEmgSRuQ3jNRz0hbEid1N7N
         j2Fg0MJHLsj1Z4yKwuAOFg+2cft52mv+loY1LdIdUU3/u6q5rFlkkFDuUAfolvhLUHIM
         NsfUhr+sfeU280bDeT6F264ZLvJ6S3Sjq1Ria/O+AvO5aY4N2qlFw7zvdmbTrr/yR0WD
         xudAc5j+TbM+CpNZCSGWGb7HmMsD3mxpBgphwfHnENO1boPvFyl1PN4a815IZgWOUi6t
         wrOwJpTqDdiii1/V5FZ0umrHWrDAVUSWEGlOtQGDV1NKe2VYcI9Q/zDD9a+c0QD8fQf2
         6scg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721988223; x=1722593023;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l0vdJTtjiyTK3zH6i+n22gfNVvmNCq3yAEftFnoYQDU=;
        b=mnknf0IafbTNq+dN0oQDuJ7HdmuATYKHXOfQEWHDsoScVGMn2iRvchz8CsmgHmnuvE
         VCW9D6k789NE179TctM+gE8bWiQ+wxYMIFEHfZ3VqpFPTX/gcU7LJGa5jVwo7nmfUxW2
         3SItPUVo6ihDZmfn1wio3xQDxlDjf3l6d9PaR1fyYffjHhTc8kBwo382gnqBMHWYqKEv
         nZ6DS+HCF4oV0j9SazslZxH7d+jz+W+pwWdj97C2RpT4Ve6/sc/Hpj0HK7JcuhxcAHfb
         Qhvdj8n/MCR4huN1wIZaASBz1JcCfGKJSVdOdZQ1yn0GwBXaOT09t4jqkDccOQ6mb/Jp
         m2bw==
X-Gm-Message-State: AOJu0YxW/sfXC3xnGo8LOCbV6cmkqaY2T0/PceURViZwCmj7iIlGPzWl
	0BvpAizOhIpsUz3PBdXTf0wlM6MIbrGwK1beVLLM6gFrxVBhUwU2g/go2irD5J2emzZDA7qApKI
	t
X-Google-Smtp-Source: AGHT+IGpJrfOIWjWr7HDFeJcB+mqV3DvnB7dxO0EIv18x9CbsFpoTKbYfqie+Np/VaQY6uhUHFQb7w==
X-Received: by 2002:a05:651c:210c:b0:2ef:2cbc:9072 with SMTP id 38308e7fff4ca-2f03dbf271fmr39620441fa.49.1721988222269;
        Fri, 26 Jul 2024 03:03:42 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28ca15b6sm2993169a91.33.2024.07.26.03.03.40
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 03:03:41 -0700 (PDT)
Message-ID: <3ed3afa9-2141-493e-8a38-af9d3a8cd035@suse.com>
Date: Fri, 26 Jul 2024 19:33:37 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] btrfs-progs: introduce btrfs_rebuild_uuid_tree() for
 mkfs and btrfs-convert
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <cover.1721987605.git.wqu@suse.com>
 <8e33931a4d078d1e1aa620aa5fe717f35146ef31.1721987605.git.wqu@suse.com>
Content-Language: en-US
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
In-Reply-To: <8e33931a4d078d1e1aa620aa5fe717f35146ef31.1721987605.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/7/26 19:29, Qu Wenruo 写道:
[...]
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

One typo, "emptry" -> "empty"

Fixed in my github repo.

Thanks for the awesome CI codespell check!
Qu

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
> +	UASSERT(fs_info->uuid_root);
> +	ret = empty_tree(fs_info->uuid_root);
> +	if (ret < 0) {
> +		errno = -ret;
> +		error("failed to clear the existing uuid tree: %m");
> +		return ret;
> +	}
> +	ret = rescan_uuid_tree(fs_info);
> +	if (ret < 0) {
> +		errno = -ret;
> +		error("failed to rescan the uuid tree: %m");
> +		return ret;
> +	}
> +	return 0;
> +}
> diff --git a/common/root-tree-utils.h b/common/root-tree-utils.h
> index 0c4ece24c7cc..3cb508022e0c 100644
> --- a/common/root-tree-utils.h
> +++ b/common/root-tree-utils.h
> @@ -26,5 +26,6 @@ int btrfs_link_subvolume(struct btrfs_trans_handle *trans,
>   			 struct btrfs_root *parent_root,
>   			 u64 parent_dir, const char *name,
>   			 int namelen, struct btrfs_root *subvol);
> +int btrfs_rebuild_uuid_tree(struct btrfs_fs_info *fs_info);
>   
>   #endif
> diff --git a/convert/main.c b/convert/main.c
> index 078ef64e41ca..aa253781ee99 100644
> --- a/convert/main.c
> +++ b/convert/main.c
> @@ -1339,6 +1339,11 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
>   		goto fail;
>   	}
>   
> +	ret = btrfs_rebuild_uuid_tree(image_root->fs_info);
> +	if (ret < 0) {
> +		errno = -ret;
> +		goto fail;
> +	}
>   	memset(root->fs_info->super_copy->label, 0, BTRFS_LABEL_SIZE);
>   	if (convert_flags & CONVERT_FLAG_COPY_LABEL) {
>   		strncpy_null(root->fs_info->super_copy->label, cctx.label, BTRFS_LABEL_SIZE);
> diff --git a/mkfs/main.c b/mkfs/main.c
> index b95f1c3372a3..00ccac14a41a 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -736,35 +736,6 @@ static void update_chunk_allocation(struct btrfs_fs_info *fs_info,
>   	}
>   }
>   
> -static int create_uuid_tree(struct btrfs_trans_handle *trans)
> -{
> -	struct btrfs_fs_info *fs_info = trans->fs_info;
> -	struct btrfs_root *root;
> -	struct btrfs_key key = {
> -		.objectid = BTRFS_UUID_TREE_OBJECTID,
> -		.type = BTRFS_ROOT_ITEM_KEY,
> -	};
> -	int ret = 0;
> -
> -	UASSERT(fs_info->uuid_root == NULL);
> -	root = btrfs_create_tree(trans, &key);
> -	if (IS_ERR(root)) {
> -		ret = PTR_ERR(root);
> -		goto out;
> -	}
> -
> -	add_root_to_dirty_list(root);
> -	fs_info->uuid_root = root;
> -	ret = btrfs_uuid_tree_add(trans, fs_info->fs_root->root_item.uuid,
> -				  BTRFS_UUID_KEY_SUBVOL,
> -				  fs_info->fs_root->root_key.objectid);
> -	if (ret < 0)
> -		btrfs_abort_transaction(trans, ret);
> -
> -out:
> -	return ret;
> -}
> -
>   static int create_global_root(struct btrfs_trans_handle *trans, u64 objectid,
>   			      int root_id)
>   {
> @@ -1822,17 +1793,15 @@ raid_groups:
>   		goto out;
>   	}
>   
> -	ret = create_uuid_tree(trans);
> -	if (ret)
> -		warning(
> -	"unable to create uuid tree, will be created after mount: %d", ret);
> -
>   	ret = btrfs_commit_transaction(trans, root);
>   	if (ret) {
>   		errno = -ret;
>   		error_msg(ERROR_MSG_START_TRANS, "%m");
>   		goto out;
>   	}
> +	ret = btrfs_rebuild_uuid_tree(fs_info);
> +	if (ret < 0)
> +		goto out;
>   
>   	ret = cleanup_temp_chunks(fs_info, &allocation, data_profile,
>   				  metadata_profile, metadata_profile);

