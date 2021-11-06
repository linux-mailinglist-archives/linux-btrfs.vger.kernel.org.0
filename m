Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9855446B98
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Nov 2021 01:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbhKFAdG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 20:33:06 -0400
Received: from mout.gmx.net ([212.227.15.19]:50447 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231879AbhKFAdF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Nov 2021 20:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636158619;
        bh=2II5R27lMeLXMP62eHlYvROr0wafC1qZ7YWvWbB834k=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=lJafl9awJxkh8TecPr8DxKWk8Ql+UUMBXawEvxbzcuba2hmGbYYLeppDXb0bl0Fg4
         l7nubEbDuEW8dlcae7vMjrKaCihiFiP4vl/DXA8RTuw5cZvfXi5ay1XCmKwfkB6YsA
         M/GjwN61OaCtCXb8X6Mv/FuYGZHCNz+SNWKDmuzI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MdNcA-1m9omQ3wZs-00ZRDT; Sat, 06
 Nov 2021 01:30:19 +0100
Message-ID: <c0d35a12-c30e-fc04-24a1-82c8f41d090b@gmx.com>
Date:   Sat, 6 Nov 2021 08:30:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 09/20] btrfs-progs: common: move
 btrfs_fix_block_accounting to repair.c
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1636143924.git.josef@toxicpanda.com>
 <4b362a542b82036c83ec299e9c5ad5216d908484.1636143924.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <4b362a542b82036c83ec299e9c5ad5216d908484.1636143924.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dn0U4jVNcUT+AkYJpsIXgw+WQKdPs3esu3dfyLo41tauYpmIZW9
 9M9sDv+LGiiGl3ry1iLer75YQYMVR93epHmmEYcsspCNB+zBGoZUjjaY07LMqyQKxzSzqkH
 2jkUhjHqlcjtCbuzHzBW53ZiRh6WTwXAAfdIg+0bUfTJbbc3S2MSSEhy4jMPCk0hmQf2/dG
 hGT0gQAcz8DkEFkizEQ8A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:G2EKl0GvC1A=:LvSOi+LxfkRx7zLrPSO0Xl
 A7RMYAvE01SULH6FgU+yGBA2Vm1a5kpY1EG4ujT4EoZdBZ8UxzwM1Lv3qvya4QFYkXaphcvS8
 e5IQt+AlXIHKU4cSjbCU44rYrU8yHfMyBvhtb2vjD4fzFJ68b8ul+zLnM+MnXM9zfslnPGSR1
 VuOIxZuon/DtP0A4WRLSWyGeu41HmPUXeW5XuXatrf5GPzQnuGu74t5/TxrtUAYgrTdINvP0k
 9W17pdnNxVxEz7WaF7uKX3EEV8+WD9wb10cz1fqLzkjB+KDp2P/p61Uemyt4ifggsvB+Xu/kF
 Umaqw46MYW2w41uvzSwXE2IPkYd9Idt2VO6m3uIzc6Ess7uGz+MKXH5HpHl5mrFDYCkYwHjRi
 NJs0oDzXdE0U+3DJGkmbu+g6aZPCOIXJM6sM3K8wzliL8Nml8tY2iQQ0un7qrb+mXaqcpe87r
 aAAi+EKO9bBI/+yhQfD3vdZt1FiZ+PpLU6Vx+i4RRHyUiX9TU+INyean1tpeq5edILGFcRy0C
 vwYimYXT5w0JKTYn3RfOQIYmJY5AuZkStPTuYivAvm4Z+S8rxHiT7bneUtWKeDbJK/fga6U9+
 LTfFk6EOriz6JCn3cgSMKdkpv34jJ4MquarZ/AeuikMxK5+uHfpGJsLFvxRjPcSMTe+yPTamd
 UyKd4vHIl5B3EGjwjD7EFY2niCuvCczuxQ4JAkwq7v9o+bAzeVz0ti8a5ifWBPLX1QR+L+EnJ
 osQbKtZwOp/gNp/Ha3bz6k6ZYt+y1dhmmjq/zUPQPaLDPIeboGiH6tfntIOtZTs19w1AO5QSh
 DwzSgQ0k0b9plpgYT8lH3pBQueITiXxwioBn4+WBJOmn2eBzcw5MKoco82m/aRYOVwFPCahB8
 xcd/208NkLBOKRmqKO994vEE9HXb7nwnYVEt/Xg0PlarrlGBuWXN2t48mMDd20iEru3oss8mK
 sJ905hrrkiJySSWwH2gIWvvlxMcQuQ6NtW5cHYb3AEs143K7VPIjwDuoYMKDx+c5m6T26s9nT
 854EAbzzPgJMIx3kUk4zT4LztqFokKIpI8t3rbj01k/PzU9L5xydu03XcitXG+nndVR0o7M4G
 6P+dhBbBKlIAx4=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/6 04:28, Josef Bacik wrote:
> We have this helper sitting in extent-tree.c, but it's a repair
> function.  I'm going to need to make changes to this for extent-tree-v2
> and would rather this live outside of the code we need to share with the
> kernel.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

A quick grep shows convert/main.c is also using this function.

But I didn't see convert/main.c including repair.h nor its .o.d shows
the header.

Is there anything missing or did I miss something?

Thanks,
Qu

> ---
>   common/repair.c             | 75 +++++++++++++++++++++++++++++++++++++
>   common/repair.h             |  1 +
>   kernel-shared/extent-tree.c | 74 ------------------------------------
>   3 files changed, 76 insertions(+), 74 deletions(-)
>
> diff --git a/common/repair.c b/common/repair.c
> index 6eed7cec..a5ba43e2 100644
> --- a/common/repair.c
> +++ b/common/repair.c
> @@ -17,6 +17,7 @@
>    */
>
>   #include "kernel-shared/ctree.h"
> +#include "kernel-shared/transaction.h"
>   #include "common/extent-cache.h"
>   #include "common/utils.h"
>   #include "common/repair.h"
> @@ -50,3 +51,77 @@ int btrfs_add_corrupt_extent_record(struct btrfs_fs_i=
nfo *info,
>   	return ret;
>   }
>
> +/*
> + * Fixup block accounting. The initial block accounting created by
> + * make_block_groups isn't accuracy in this case.
> + */
> +int btrfs_fix_block_accounting(struct btrfs_trans_handle *trans)
> +{
> +	int ret =3D 0;
> +	int slot;
> +	u64 start =3D 0;
> +	u64 bytes_used =3D 0;
> +	struct btrfs_path path;
> +	struct btrfs_key key;
> +	struct extent_buffer *leaf;
> +	struct btrfs_block_group *cache;
> +	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> +	struct btrfs_root *root =3D fs_info->extent_root;
> +
> +	ret =3D btrfs_run_delayed_refs(trans, -1);
> +	if (ret)
> +		return ret;
> +
> +	while(1) {
> +		cache =3D btrfs_lookup_first_block_group(fs_info, start);
> +		if (!cache)
> +			break;
> +
> +		start =3D cache->start + cache->length;
> +		cache->used =3D 0;
> +		cache->space_info->bytes_used =3D 0;
> +		if (list_empty(&cache->dirty_list))
> +			list_add_tail(&cache->dirty_list, &trans->dirty_bgs);
> +	}
> +
> +	btrfs_init_path(&path);
> +	key.offset =3D 0;
> +	key.objectid =3D 0;
> +	key.type =3D BTRFS_EXTENT_ITEM_KEY;
> +	ret =3D btrfs_search_slot(trans, root->fs_info->extent_root,
> +				&key, &path, 0, 0);
> +	if (ret < 0)
> +		return ret;
> +	while(1) {
> +		leaf =3D path.nodes[0];
> +		slot =3D path.slots[0];
> +		if (slot >=3D btrfs_header_nritems(leaf)) {
> +			ret =3D btrfs_next_leaf(root, &path);
> +			if (ret < 0)
> +				return ret;
> +			if (ret > 0)
> +				break;
> +			leaf =3D path.nodes[0];
> +			slot =3D path.slots[0];
> +		}
> +		btrfs_item_key_to_cpu(leaf, &key, slot);
> +		if (key.type =3D=3D BTRFS_EXTENT_ITEM_KEY) {
> +			bytes_used +=3D key.offset;
> +			ret =3D btrfs_update_block_group(trans,
> +				  key.objectid, key.offset, 1, 0);
> +			BUG_ON(ret);
> +		} else if (key.type =3D=3D BTRFS_METADATA_ITEM_KEY) {
> +			bytes_used +=3D fs_info->nodesize;
> +			ret =3D btrfs_update_block_group(trans,
> +				  key.objectid, fs_info->nodesize, 1, 0);
> +			if (ret)
> +				goto out;
> +		}
> +		path.slots[0]++;
> +	}
> +	btrfs_set_super_bytes_used(root->fs_info->super_copy, bytes_used);
> +	ret =3D 0;
> +out:
> +	btrfs_release_path(&path);
> +	return ret;
> +}
> diff --git a/common/repair.h b/common/repair.h
> index d1794610..4e1fa3e7 100644
> --- a/common/repair.h
> +++ b/common/repair.h
> @@ -32,5 +32,6 @@ struct btrfs_corrupt_block {
>   int btrfs_add_corrupt_extent_record(struct btrfs_fs_info *info,
>   				    struct btrfs_key *first_key,
>   				    u64 start, u64 len, int level);
> +int btrfs_fix_block_accounting(struct btrfs_trans_handle *trans);
>
>   #endif
> diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
> index a918e5aa..402904d1 100644
> --- a/kernel-shared/extent-tree.c
> +++ b/kernel-shared/extent-tree.c
> @@ -3247,80 +3247,6 @@ int btrfs_remove_block_group(struct btrfs_trans_h=
andle *trans,
>   	return ret;
>   }
>
> -/*
> - * Fixup block accounting. The initial block accounting created by
> - * make_block_groups isn't accuracy in this case.
> - */
> -int btrfs_fix_block_accounting(struct btrfs_trans_handle *trans)
> -{
> -	int ret =3D 0;
> -	int slot;
> -	u64 start =3D 0;
> -	u64 bytes_used =3D 0;
> -	struct btrfs_path path;
> -	struct btrfs_key key;
> -	struct extent_buffer *leaf;
> -	struct btrfs_block_group *cache;
> -	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> -	struct btrfs_root *root =3D fs_info->extent_root;
> -
> -	ret =3D btrfs_run_delayed_refs(trans, -1);
> -	if (ret)
> -		return ret;
> -
> -	while(1) {
> -		cache =3D btrfs_lookup_first_block_group(fs_info, start);
> -		if (!cache)
> -			break;
> -
> -		start =3D cache->start + cache->length;
> -		cache->used =3D 0;
> -		cache->space_info->bytes_used =3D 0;
> -		if (list_empty(&cache->dirty_list))
> -			list_add_tail(&cache->dirty_list, &trans->dirty_bgs);
> -	}
> -
> -	btrfs_init_path(&path);
> -	key.offset =3D 0;
> -	key.objectid =3D 0;
> -	key.type =3D BTRFS_EXTENT_ITEM_KEY;
> -	ret =3D btrfs_search_slot(trans, root->fs_info->extent_root,
> -				&key, &path, 0, 0);
> -	if (ret < 0)
> -		return ret;
> -	while(1) {
> -		leaf =3D path.nodes[0];
> -		slot =3D path.slots[0];
> -		if (slot >=3D btrfs_header_nritems(leaf)) {
> -			ret =3D btrfs_next_leaf(root, &path);
> -			if (ret < 0)
> -				return ret;
> -			if (ret > 0)
> -				break;
> -			leaf =3D path.nodes[0];
> -			slot =3D path.slots[0];
> -		}
> -		btrfs_item_key_to_cpu(leaf, &key, slot);
> -		if (key.type =3D=3D BTRFS_EXTENT_ITEM_KEY) {
> -			bytes_used +=3D key.offset;
> -			ret =3D btrfs_update_block_group(trans,
> -				  key.objectid, key.offset, 1, 0);
> -			BUG_ON(ret);
> -		} else if (key.type =3D=3D BTRFS_METADATA_ITEM_KEY) {
> -			bytes_used +=3D fs_info->nodesize;
> -			ret =3D btrfs_update_block_group(trans,
> -				  key.objectid, fs_info->nodesize, 1, 0);
> -			if (ret)
> -				goto out;
> -		}
> -		path.slots[0]++;
> -	}
> -	btrfs_set_super_bytes_used(root->fs_info->super_copy, bytes_used);
> -	ret =3D 0;
> -out:
> -	btrfs_release_path(&path);
> -	return ret;
> -}
>
>   static void __get_extent_size(struct btrfs_root *root, struct btrfs_pa=
th *path,
>   			      u64 *start, u64 *len)
>
