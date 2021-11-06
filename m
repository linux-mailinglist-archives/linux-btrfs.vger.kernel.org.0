Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234EA446BA0
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Nov 2021 01:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbhKFAkf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 20:40:35 -0400
Received: from mout.gmx.net ([212.227.15.19]:33285 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232983AbhKFAke (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Nov 2021 20:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636159069;
        bh=SYgdAwMWP5zHyKiN1HSYsZ7lB0yHLTXII02F6JUS8UQ=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=eyzfa5PzeEJd+kCpweeGUb0EpKxX1cTpuAgPVXc9qRvpobxeFKREEF/er/fYgjpWH
         xS/yLY0ezdeh/0Rn4ScoR8NkchZ0K5iaQ+chULWz2dyHgVronJr1/hXwPeRfIHO8l0
         07p35VCPygad7tkUmzRmQrhQj6KXI6sUITYvSRg0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYeMj-1nED673mJn-00VfaW; Sat, 06
 Nov 2021 01:37:49 +0100
Message-ID: <12fb0839-eef0-ce6d-db1c-ae747414cde2@gmx.com>
Date:   Sat, 6 Nov 2021 08:37:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 10/20] btrfs-progs: check: abstract out the used marking
 helpers
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1636143924.git.josef@toxicpanda.com>
 <c82b4edc2e8619a4359ae3933e821e66db80beb3.1636143924.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <c82b4edc2e8619a4359ae3933e821e66db80beb3.1636143924.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nAheD8y8ojwXlOcMVtrWY6bJJRKmGIt9A/fAcNb8MUUP7kCqJVs
 ooWyaD/2OPS6ReGv6V2IjkC5ycrg4JYiKCwdv9qZTogLgvfpWys7vIGaNo8hnj2fQJ6q6EM
 84szhqWQTVVvgTHKFFhdKX+BWw32yq8ZBEBcjDLepxQI8JCL5GYvWb1Z041EQkDkefP+Cfq
 XHRNp9QeBkewYTRxi/u5g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DOtkRrMq8dw=:WNecp8aOSO53ErKh2kYK/f
 Z33uJlaUDl6+btrrUbxwZJei4BOsAMN5kmIhWJLXxt83hZBiNBUzStalXvuIav6Nqxx07mu/E
 Niy/GTtGKK60DyXqwCVAVKpIqUqzDbbF3iABtdTjcT9qsvioLJ1kLlsCPWvzntRRPvQQki9J8
 kZj10uE++CaOIwRfHnIrKCEqju9kaQwXNp3ZkYVjRmIAYSEJkhDQWiJmgkbJLK1J2gEkcI2Dk
 x9JV5JAd0WAXB7krCEEdqn7MLCxJi53RflwwhU6SbPujH4aGoM1872n7mDHlBsGKnF28/FbNi
 Zh/KxquGUTeK44lcr1Yo5ENujYR2TCc4ZSFrcM0UOHtLkdNqhaHCVUTWn3+BMJHFhNrv3tXNF
 sZgjA+4c0AW0B+ha15l9RZcxyV+0zyDnPwhoI53x6Sh4VQF+SKWPLiEjkWrietj4WQwP9Rth5
 5BsliLT27zF6UPyQuGkz6WQWToINeJSBTT8/pHUC/nFeqXUKXtZYeMgvtuUhYgHS11uIj2N2s
 PmhCLI9d8IMbszscArSKQgsqziHQaf3LOkqwymW5LL/fPYo23SDNI8iTYJUzM+YN7GFg1JJdE
 /9niN1f2zqRBvO5jcd33BmJ7S0MyN1K24NwHeJ7kAJhFKNmBVqyYF9pt38Gv+ZGWhcP97DdRH
 gDs9vMDmsQOUQdLVwr6T9ozbaGLCiOAbDxpCYsStgRgzJgmd/TnqKYLt9PnSdmuJOrZYCWdVA
 BwYTquZkRzKSWJybIEfZ3GOea9MP5/o5cOfZPEu3/UDLbmg+kVsZU/tNboC7exHgLZc3brXV+
 OKHGSeycfTmQk01cjWTHdWK0XwjexNgp+5PqGGXCDIRKKW3eTFmEGmJkgunIlmhd7CKEpJc96
 knIS/zGPC2dTt2GnpXk5kSXeGHl/AQQgpDDUemqU+ghBQAo0lg+i7GvJhExIBoqBmc6dWY1vf
 XCxoVKVWekxaVhT9AmFechm7SHUneZ/vAiSqAjhdnyO4qL4pwgCgCSWM7BmWBa3rNahVRG5KG
 OSg3BIE+8pTHDN8W3btGUkGaSracvckZwy+CPRNus+ojpsnZo5ox2nSL7Hyt0G4jdZhv3iwey
 SEJawtA+MkaC30=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/6 04:28, Josef Bacik wrote:
> We will walk all referenced tree blocks during check in order to avoid
> writing over any referenced blocks during fsck.  However in the future
> we're going to need to do this for things like fixing block group
> accounting with extent tree v2.  This is because extent tree v2 will not
> refer to all of the allocated blocks in the extent tree.  Refactor the
> code some to allow us to send down an arbitrary extent_io_tree so we can
> use this helper for any case where we need to figure out where all the
> used space is on an extent tree v2 file system.

I guess in that case @tree parameter will be an per-block-group io-tree
then?

Then the refactor may be more suitable for the extent-tree-v2 patchset.

>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   check/mode-common.c | 57 ++++++++++++++++++++-------------------------
>   1 file changed, 25 insertions(+), 32 deletions(-)
>
> diff --git a/check/mode-common.c b/check/mode-common.c
> index 0c3bd38b..a4a09714 100644
> --- a/check/mode-common.c
> +++ b/check/mode-common.c
> @@ -599,23 +599,21 @@ void reset_cached_block_groups()
>   	}
>   }
>
> -static int traverse_tree_blocks(struct extent_buffer *eb, int tree_root=
, int pin)
> +static int traverse_tree_blocks(struct btrfs_fs_info *fs_info,

fs_info can be extracted from eb->fs_info directly.

Thanks,
Qu

> +				struct extent_io_tree *tree,
> +				struct extent_buffer *eb, int tree_root)
>   {
>   	struct extent_buffer *tmp;
>   	struct btrfs_root_item *ri;
>   	struct btrfs_key key;
> -	struct extent_io_tree *tree;
>   	u64 bytenr;
>   	int level =3D btrfs_header_level(eb);
>   	int nritems;
>   	int ret;
>   	int i;
>   	u64 end =3D eb->start + eb->len;
> +	bool pin =3D tree =3D=3D &fs_info->pinned_extents;
>
> -	if (pin)
> -		tree =3D &gfs_info->pinned_extents;
> -	else
> -		tree =3D gfs_info->excluded_extents;
>   	/*
>   	 * If we have pinned/excluded this block before, don't do it again.
>   	 * This can not only avoid forever loop with broken filesystem
> @@ -625,7 +623,7 @@ static int traverse_tree_blocks(struct extent_buffer=
 *eb, int tree_root, int pin
>   		return 0;
>
>   	if (pin)
> -		btrfs_pin_extent(gfs_info, eb->start, eb->len);
> +		btrfs_pin_extent(fs_info, eb->start, eb->len);
>   	else
>   		set_extent_dirty(tree, eb->start, end - 1);
>
> @@ -654,12 +652,12 @@ static int traverse_tree_blocks(struct extent_buff=
er *eb, int tree_root, int pin
>   			 * in, but for now this doesn't actually use the root so
>   			 * just pass in extent_root.
>   			 */
> -			tmp =3D read_tree_block(gfs_info, bytenr, 0);
> +			tmp =3D read_tree_block(fs_info, bytenr, 0);
>   			if (!extent_buffer_uptodate(tmp)) {
>   				fprintf(stderr, "Error reading root block\n");
>   				return -EIO;
>   			}
> -			ret =3D traverse_tree_blocks(tmp, 0, pin);
> +			ret =3D traverse_tree_blocks(fs_info, tree, tmp, 0);
>   			free_extent_buffer(tmp);
>   			if (ret)
>   				return ret;
> @@ -669,20 +667,21 @@ static int traverse_tree_blocks(struct extent_buff=
er *eb, int tree_root, int pin
>   			/* If we aren't the tree root don't read the block */
>   			if (level =3D=3D 1 && !tree_root) {
>   				if (pin)
> -					btrfs_pin_extent(gfs_info, bytenr,
> -							 gfs_info->nodesize);
> +					btrfs_pin_extent(fs_info, bytenr,
> +							 fs_info->nodesize);
>   				else
>   					set_extent_dirty(tree, bytenr,
> -							 gfs_info->nodesize);
> +							 fs_info->nodesize);
>   				continue;
>   			}
>
> -			tmp =3D read_tree_block(gfs_info, bytenr, 0);
> +			tmp =3D read_tree_block(fs_info, bytenr, 0);
>   			if (!extent_buffer_uptodate(tmp)) {
>   				fprintf(stderr, "Error reading tree block\n");
>   				return -EIO;
>   			}
> -			ret =3D traverse_tree_blocks(tmp, tree_root, pin);
> +			ret =3D traverse_tree_blocks(fs_info, tree, tmp,
> +						   tree_root);
>   			free_extent_buffer(tmp);
>   			if (ret)
>   				return ret;
> @@ -692,30 +691,27 @@ static int traverse_tree_blocks(struct extent_buff=
er *eb, int tree_root, int pin
>   	return 0;
>   }
>
> -static int pin_down_tree_blocks(struct extent_buffer *eb, int tree_root=
)
> -{
> -	return traverse_tree_blocks(eb, tree_root, 1);
> -}
> -
> -int pin_metadata_blocks(void)
> +int btrfs_mark_used_tree_blocks(struct btrfs_fs_info *fs_info,
> +				struct extent_io_tree *tree)
>   {
>   	int ret;
>
> -	ret =3D pin_down_tree_blocks(gfs_info->chunk_root->node, 0);
> -	if (ret)
> -		return ret;
> -
> -	return pin_down_tree_blocks(gfs_info->tree_root->node, 1);
> +	ret =3D traverse_tree_blocks(fs_info, tree,
> +				   fs_info->chunk_root->node, 0);
> +	if (!ret)
> +		ret =3D traverse_tree_blocks(fs_info, tree,
> +					   fs_info->tree_root->node, 1);
> +	return ret;
>   }
>
> -static int exclude_tree_blocks(struct extent_buffer *eb, int tree_root)
> +int pin_metadata_blocks(void)
>   {
> -	return traverse_tree_blocks(eb, tree_root, 0);
> +	return btrfs_mark_used_tree_blocks(gfs_info,
> +					   &gfs_info->pinned_extents);
>   }
>
>   int exclude_metadata_blocks(void)
>   {
> -	int ret;
>   	struct extent_io_tree *excluded_extents;
>
>   	excluded_extents =3D malloc(sizeof(*excluded_extents));
> @@ -724,10 +720,7 @@ int exclude_metadata_blocks(void)
>   	extent_io_tree_init(excluded_extents);
>   	gfs_info->excluded_extents =3D excluded_extents;
>
> -	ret =3D exclude_tree_blocks(gfs_info->chunk_root->node, 0);
> -	if (ret)
> -		return ret;
> -	return exclude_tree_blocks(gfs_info->tree_root->node, 1);
> +	return btrfs_mark_used_tree_blocks(gfs_info, excluded_extents);
>   }
>
>   void cleanup_excluded_extents(void)
>
