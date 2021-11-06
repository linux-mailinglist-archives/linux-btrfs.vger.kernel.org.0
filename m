Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFD4446B86
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Nov 2021 01:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhKFAVT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 20:21:19 -0400
Received: from mout.gmx.net ([212.227.17.21]:55945 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231939AbhKFAVN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Nov 2021 20:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636157906;
        bh=onRf7YpH5lN9Trj2NJseJy5qczXaD1KFt9yosTksVQk=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=KSzoNyvGFBQdObEcxfM1F8PJMyNJPYnuptoZINKZYPueLr9s8tMgzgWl59iCaqwjF
         Yk9QRhD3gKq0XEqBs5zgUxPuRER+8yt/zQYaVmvcPSjfJPqjQG6kI0ieqO2Gq5KYqi
         mdtSw8dTSVfrtOCojwXwRAW3/grwh5K6rDUIjyDY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQMyf-1n4ozY3SjJ-00MML3; Sat, 06
 Nov 2021 01:18:26 +0100
Message-ID: <54a290b6-425e-0486-2f94-ce0d25ec6ce9@gmx.com>
Date:   Sat, 6 Nov 2021 08:18:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 04/20] btrfs-progs: add a helper for setting up a root
 node
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1636143924.git.josef@toxicpanda.com>
 <2719756fd27dd1d4ee0c06f15a40238d26c2e69d.1636143924.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <2719756fd27dd1d4ee0c06f15a40238d26c2e69d.1636143924.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lHFiwBiZOV4nrSXsXgGo+hq/fiZIdXlQLGyzl/ermU5RvD6kGCg
 X4MHPnDNEKDUvAN2Mmepb8t5F9A2QZPgQXqufqWfMjBX0aVrXBMdeEWN1wuuElPrHJh0aW9
 30Qhhv0aSGx43D8HAPvpIzH6/MFqG65FQIVeu5jFlJlL8VOx0sz8ubep6kmbVTHigauNte7
 zHJj46BGB/rjiHaZ9H+gw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VJwNvZVlUpI=:k5i69uiiyrpXP5BVAFMW0j
 2haq56CfqQHUIKxAMXtRLLKo8deazkbE37a21KPdhn+TAZl7JSIiBsZtAHa52objgIPK99wkz
 7Wt1o9SaWjIrQzrdhRmtGjgZWrRy3GzNrbFjmvWOKdKY5zEzScFyptHtKMCiGxbXwxXMl0OpH
 glf4+OspRE+mPe2QOOX+iR1ssFxu76aFoRX1ub3GU5mnGZoMO4EtiGUNtacTK1mtH63FaBA6g
 wlYdAjmXpxeENqj1B2/gR+vxTGH5oAMuop7jGZ2ZgZcNXWpKuO+I3oGed952fdhB4xkFiE00N
 394sPn8DMJ70JPFws3s5kCl/AS/VpmBc9oAuUBKYeMUK9NNl1o0T4d7Y0gCX3Np/jBiBSkYig
 ZYuOL2Hm2Bqadc8P91mgRYt2kVer41supxMyW36oFbuxeJzhvWRe8I3spUezUF0+KGY7bU8zd
 CRas1TC6/rHqSIxRNAM0onTofpCDKhSL0F5/QS2Pzu0CQvRhJxKC7yQHtl+ocbnGOi2QsrNsu
 rg8FffvIVOGjN3puNyVwvOKYXkyxeBI3Bq5BM6QYMRM+AB+Nj3SB32Mzk3IE2pySxhh/FMM8e
 +guez8HYXp4Y648zDxsws7HsaC+IcoxaSgd2d0Be/7N3+4Se6VrCLc+n1N3cAN0I1d7CLhUP3
 FRdssk2XXXnpbOtGMrWHV5NsCyNQwlW7dDmQ3no8StHS06dDe/sZem8UUYJr9JtLHPvC/RB1R
 YDLY2+UWMFSP/eDD4IJEUYl9AN9ddt1tzg+eNfUSK9s16mpzPYMBXB2r8Lm1yRdUntH3Zw9Kx
 UDaCEYD+2UAIrVimNKKFopVdhmCUHlXWX1EEtNy9uQ+xoTdtPERsQeZ+5XeZpKqkQ5PpDMjPi
 aEHyhRTsCFNVrxfR4N/upNoKsG4wZ5TjZENSuEPYSVVB/rce0jOGt9OM+i87EstBVLVAf+8f/
 qw1SYw6rnB5x0lcUuGRIPCDP/ID8DEFGRgcNU+Adgp9u3p+goNK+5XoHw98HiVe9wg4Np9Ofe
 jxht+krf6Bq6oFwFu7ERi2y6ql0LT0EUge0V1nHnVU4zPSPHvhloAu7GI/FnZPy3OxzlE6RvM
 5yQwLLdhlhUhxk=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/6 04:28, Josef Bacik wrote:
> We use this pattern in a few places, and will use it more with different
> roots in the future.  Extract out this helper to read the root nodes.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   kernel-shared/disk-io.c | 58 +++++++++++++++++++++--------------------
>   1 file changed, 30 insertions(+), 28 deletions(-)
>
> diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
> index 3b3c4523..1f940221 100644
> --- a/kernel-shared/disk-io.c
> +++ b/kernel-shared/disk-io.c
> @@ -578,12 +578,23 @@ void btrfs_setup_root(struct btrfs_root *root, str=
uct btrfs_fs_info *fs_info,
>   	root->root_key.objectid =3D objectid;
>   }
>
> +static int read_root_node(struct btrfs_fs_info *fs_info,
> +			  struct btrfs_root *root, u64 bytenr, u64 gen)

Can we add "int level" to bring proper level check for this function and
read_tree_block()?

Thanks,
Qu

> +{
> +	root->node =3D read_tree_block(fs_info, bytenr, gen); > +	if (!extent_=
buffer_uptodate(root->node)) {
> +		free_extent_buffer(root->node);
> +		root->node =3D NULL;
> +		return -EIO;
> +	}
> +	return 0;
> +}
> +
>   static int find_and_setup_root(struct btrfs_root *tree_root,
>   			       struct btrfs_fs_info *fs_info,
>   			       u64 objectid, struct btrfs_root *root)
>   {
>   	int ret;
> -	u64 generation;
>
>   	btrfs_setup_root(root, fs_info, objectid);
>   	ret =3D btrfs_find_last_root(tree_root, objectid,
> @@ -591,13 +602,9 @@ static int find_and_setup_root(struct btrfs_root *t=
ree_root,
>   	if (ret)
>   		return ret;
>
> -	generation =3D btrfs_root_generation(&root->root_item);
> -	root->node =3D read_tree_block(fs_info,
> -			btrfs_root_bytenr(&root->root_item), generation);
> -	if (!extent_buffer_uptodate(root->node))
> -		return -EIO;
> -
> -	return 0;
> +	return read_root_node(fs_info, root,
> +			      btrfs_root_bytenr(&root->root_item),
> +			      btrfs_root_generation(&root->root_item));
>   }
>
>   static int find_and_setup_log_root(struct btrfs_root *tree_root,
> @@ -606,6 +613,7 @@ static int find_and_setup_log_root(struct btrfs_root=
 *tree_root,
>   {
>   	u64 blocknr =3D btrfs_super_log_root(disk_super);
>   	struct btrfs_root *log_root =3D malloc(sizeof(struct btrfs_root));
> +	int ret;
>
>   	if (!log_root)
>   		return -ENOMEM;
> @@ -615,20 +623,15 @@ static int find_and_setup_log_root(struct btrfs_ro=
ot *tree_root,
>   		return 0;
>   	}
>
> -	btrfs_setup_root(log_root, fs_info,
> -			 BTRFS_TREE_LOG_OBJECTID);
> -
> -	log_root->node =3D read_tree_block(fs_info, blocknr,
> -				     btrfs_super_generation(disk_super) + 1);
> -
> -	fs_info->log_root_tree =3D log_root;
> -
> -	if (!extent_buffer_uptodate(log_root->node)) {
> -		free_extent_buffer(log_root->node);
> +	btrfs_setup_root(log_root, fs_info, BTRFS_TREE_LOG_OBJECTID);
> +	ret =3D read_root_node(fs_info, log_root, blocknr,
> +			     btrfs_super_generation(disk_super) + 1);
> +	if (ret) {
>   		free(log_root);
>   		fs_info->log_root_tree =3D NULL;
> -		return -EIO;
> +		return ret;
>   	}
> +	fs_info->log_root_tree =3D log_root;
>
>   	return 0;
>   }
> @@ -704,9 +707,9 @@ out:
>   		return ERR_PTR(ret);
>   	}
>   	generation =3D btrfs_root_generation(&root->root_item);
> -	root->node =3D read_tree_block(fs_info,
> -			btrfs_root_bytenr(&root->root_item), generation);
> -	if (!extent_buffer_uptodate(root->node)) {
> +	ret =3D read_root_node(fs_info, root,
> +			     btrfs_root_bytenr(&root->root_item), generation);
> +	if (ret) {
>   		free(root);
>   		return ERR_PTR(-EIO);
>   	}
> @@ -970,8 +973,8 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_i=
nfo, u64 root_tree_bytenr,
>   		generation =3D btrfs_backup_tree_root_gen(backup);
>   	}
>
> -	root->node =3D read_tree_block(fs_info, root_tree_bytenr, generation);
> -	if (!extent_buffer_uptodate(root->node)) {
> +	ret =3D read_root_node(fs_info, root, root_tree_bytenr, generation);
> +	if (ret) {
>   		fprintf(stderr, "Couldn't read tree root\n");
>   		return -EIO;
>   	}
> @@ -1179,10 +1182,9 @@ int btrfs_setup_chunk_tree_and_device_map(struct =
btrfs_fs_info *fs_info,
>   	else
>   		generation =3D 0;
>
> -	fs_info->chunk_root->node =3D read_tree_block(fs_info,
> -						    chunk_root_bytenr,
> -						    generation);
> -	if (!extent_buffer_uptodate(fs_info->chunk_root->node)) {
> +	ret =3D read_root_node(fs_info, fs_info->chunk_root, chunk_root_bytenr=
,
> +			     generation);
> +	if (ret) {
>   		if (fs_info->ignore_chunk_tree_error) {
>   			warning("cannot read chunk root, continue anyway");
>   			fs_info->chunk_root =3D NULL;
>
