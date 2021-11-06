Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F62446B7F
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Nov 2021 01:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhKFARP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 20:17:15 -0400
Received: from mout.gmx.net ([212.227.17.21]:35841 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230262AbhKFARO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Nov 2021 20:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636157670;
        bh=/dqvdXQOBx/aIgGzCrECF/vKvmZpRLtmvXMxoK6HdH8=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=O06gMe0I05lR/eZlybCMoTy053yoH/YFhJclYZ4J2kIZWvsy0PS52ZDR+CzwAPVld
         N3N4Dh5gWkMb0AWxIdPojjETDLRTRicczyCzfuT80OTizAXYWZal+8F8ve1DuOJ353
         0l/XQGIXNab0ssN1LNojtPLeppkHEFk1dCOvLM7g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MPGVx-1n5v0C0idx-00PbsU; Sat, 06
 Nov 2021 01:14:29 +0100
Message-ID: <f486aa43-17a7-6c02-1a34-223079d8e96b@gmx.com>
Date:   Sat, 6 Nov 2021 08:14:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 01/20] btrfs-progs: simplify btrfs_make_block_group
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1636143924.git.josef@toxicpanda.com>
 <c34d973b32d46595546ac9f7b80984a0fb21f74c.1636143924.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <c34d973b32d46595546ac9f7b80984a0fb21f74c.1636143924.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EyySr4Ml75jez5iZe88iwylOr8wlcK5pSIwa71IaDM0CbeY3y1o
 /XbBUKGiCTkpAiK/b3C2NqInDdyc5uicso44ZYw71+3UnlHiIqCsdPjrK9FZW3ux6mWcKYA
 mC0MuurP1rQ+De0lDPpRFgCAbqsTG+SpaqitXpfXewoaw35OOoLsKU6WK4XWHXSPpFTwqAO
 nQbW7NKnLzZbQQkdJV7wA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yhmJPil418I=:3qCvVfn1KdKbUfxWYutLXP
 8nuD2jQhSpXMtXX1MHOHOCKvrHBbMPseEiUb4VRw6OsYT5E1zfrp+pJDRRHL5JmYqcyLhjhKx
 RA895cj3eAAJhv2VVz8f8l8r859RI+3w1TAhc09/iJtA8JPx+kedj5dkDFKOPmzqfBrtLNxdR
 71eNZjzRRwvSjolqvkLcbKoXDJY6GU36fWy6M7qNbOSz+Q9Qyi6nu7CsUrJ5nKXtWEo+gUQet
 UJ5QQSsXUYEnQdTaK2SodW21faXVqh9M1j0uyLoExCfoCY7UeyVoZKhVVRoHm03Bkq7nvP+c2
 hXaNTbIgAZvDvB+xKFLQFanEvHTKF4KZbPy3jGOEioJzW9DYw7lv55g5zLFCyZGiEOCPYq0tg
 ldiQD3Zy3wJAgkGlKwZU5cigzECy5mdPUOsRB30bpp7Op/weQNAEQbjk2Jkw5zzABXxJiUBit
 tFY8eXwO5OtRE3u6xnZZbkicydF5Dti/der1Pb5WOyyS5dx9D43IKXsI0QAATBITvXM9c3Msw
 zODIUj3y+Ov8jHMjt4/7vIe3kkLZvFoURdvClpsu0OegZsERY+toGcSb0jNVhvdC4lTrKBysW
 gup71gWxSAV7blYTP73ijfW+cOuYKLeTnvaAZk0rEQyxuhhN71FSCcbWnF+Lefm0m9trsEtaI
 td//8RNPa23GP8tRPUqxruEjcOhn7I7Y7mPzkMPRAZi+giAKSDJoLnFwr4Xql5ePDVCTSLH2i
 nOahI80mgd58nsBz/kQA1f+GCo1iVrieoJm7TY/XvcwDI1b6P0CHNqQqg1e0W3F7tvukJ2G51
 dARrQmx9yHC+/mbuUwo2Srxgu8025q0NkmTirZLvK8Ndr2WSgeLSgTJK/kh8URwtOi8CeoEfY
 7KetO1+VcewQzYL7s1Mtenv0zrys61BZVScrmfCl1E3kg4hAowbsBKYrCymYeYEYcukwJ+1x1
 3rEkk46FECa/pwAUZU5peCtV/7yvPquyKFiPeSw11K+s8vRjrHV3VBpfieP46+J/VlD2KV/pn
 AjKgeCLuWstzaaeH1h1Rgk6gmcx70l9HWmnpNhRQBQiRsq2itkDRFDrMw32AISqEsabb96M7Q
 w2bZ/iceDZnrDI=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/6 04:28, Josef Bacik wrote:
> This is doing the same work as insert_block_group_item, rework it to
> call the helper instead.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   kernel-shared/extent-tree.c | 43 ++++++++++++++-----------------------
>   1 file changed, 16 insertions(+), 27 deletions(-)
>
> diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
> index 8e0614e0..a918e5aa 100644
> --- a/kernel-shared/extent-tree.c
> +++ b/kernel-shared/extent-tree.c
> @@ -2791,33 +2791,6 @@ btrfs_add_block_group(struct btrfs_fs_info *fs_in=
fo, u64 bytes_used, u64 type,
>   	return cache;
>   }
>
> -int btrfs_make_block_group(struct btrfs_trans_handle *trans,
> -			   struct btrfs_fs_info *fs_info, u64 bytes_used,
> -			   u64 type, u64 chunk_offset, u64 size)
> -{
> -	int ret;
> -	struct btrfs_root *extent_root =3D fs_info->extent_root;
> -	struct btrfs_block_group *cache;
> -	struct btrfs_block_group_item bgi;
> -	struct btrfs_key key;
> -
> -	cache =3D btrfs_add_block_group(fs_info, bytes_used, type, chunk_offse=
t,
> -				      size);
> -	btrfs_set_stack_block_group_used(&bgi, cache->used);
> -	btrfs_set_stack_block_group_flags(&bgi, cache->flags);
> -	btrfs_set_stack_block_group_chunk_objectid(&bgi,
> -			BTRFS_FIRST_CHUNK_TREE_OBJECTID);
> -	key.objectid =3D cache->start;
> -	key.type =3D BTRFS_BLOCK_GROUP_ITEM_KEY;
> -	key.offset =3D cache->length;
> -	ret =3D btrfs_insert_item(trans, extent_root, &key, &bgi, sizeof(bgi))=
;
> -	BUG_ON(ret);
> -
> -	add_block_group_free_space(trans, cache);
> -
> -	return 0;
> -}
> -
>   static int insert_block_group_item(struct btrfs_trans_handle *trans,
>   				   struct btrfs_block_group *block_group)
>   {
> @@ -2838,6 +2811,22 @@ static int insert_block_group_item(struct btrfs_t=
rans_handle *trans,
>   	return btrfs_insert_item(trans, root, &key, &bgi, sizeof(bgi));
>   }
>
> +int btrfs_make_block_group(struct btrfs_trans_handle *trans,
> +			   struct btrfs_fs_info *fs_info, u64 bytes_used,
> +			   u64 type, u64 chunk_offset, u64 size)
> +{
> +	struct btrfs_block_group *cache;
> +	int ret;
> +
> +	cache =3D btrfs_add_block_group(fs_info, bytes_used, type, chunk_offse=
t,
> +				      size);
> +	ret =3D insert_block_group_item(trans, cache);
> +	if (ret)
> +		return ret;
> +	add_block_group_free_space(trans, cache);
> +	return 0;
> +}
> +
>   /*
>    * This is for converter use only.
>    *
>
