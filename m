Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEE140A248
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 03:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbhINBER (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 21:04:17 -0400
Received: from mout.gmx.net ([212.227.15.19]:39213 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236397AbhINBEK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 21:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631581372;
        bh=Dio5Kg+yH0m/9Af7ccqlFqsypyUPdHqH30z/Jgn6AMQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=luD3rOLhoWUV+AGWgNyvD+V/8sljR28dgksQ/8mBGUCUzbuGMqNQFs+k2kBm+0/HO
         MXCHZi/4OM7aSP/TmAj8YpCX56TUU5IOa4kLv+p7YR88MOt60KpYKO7FAdt2ONF15X
         2JF1X2zeARJ5Q35CyBBNQjusaWSDeCIA1gjZpZ9A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M8ygO-1mJsZJ1Mmc-00645G; Tue, 14
 Sep 2021 03:02:51 +0200
Subject: Re: [PATCH 4/8] btrfs-progs: Remove root argument from
 btrfs_truncate_item
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210913131729.37897-1-nborisov@suse.com>
 <20210913131729.37897-5-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <dd4e6c86-e5fe-adf4-326d-3d9500cd7187@gmx.com>
Date:   Tue, 14 Sep 2021 09:02:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210913131729.37897-5-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I3l8qfT1jMTZ8hKsUvJ7mwdreIJLwzdeUSfxx74tokzEazeQ9p6
 Mb7/V2J0GbnIaHeiQlxaTAw9KuUChvhNGvAGs9uv/AdRQHQIsY7fxk3wrlxOXPx6gNqwCNO
 rH4j8KvHZ/KMCMEwaREKyqpMAyYPePUiivkRuDAaezdCrhNENR6EjXsd15nkxpgnCF6mj1D
 VdR18qhzG9S6SBzdExlvA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+APSZSFTrNk=:Slm+umP5jd6ElOJgYWdBT6
 Kji1odm27SS3phif2U0TfnK+OyYhlCvAY7/1aY88XT+vpZYvreDIaOKCczuoOOkCdkMxwzjcz
 luMwAgJnDUDdhWwClAh9BRnqOprqRrcVrOx40uLf/XGC6oL0qSyRYSWNBiUvDg6tK9SekGrDb
 YhA5LXRRaUm//eNMZeGoi8xPqr+hEU3rXHaI15MiYdRXnylGxWVokcWPMh3nW8vVbSY0fdUyM
 wTXgAXBcvq6AP65nJivFr+AaK8gTlr0ccajUBAABghQ/+UWRa3de2pjCT/aewUBJ75tQZPtLO
 UEKaIIgQOEDY+TZzgZU2oQK9Wfqb9PBpPl4rr6q4xiG6vZ9DiJAQSOYOV0HViseIgJzWz91lh
 lrlwZ2LoUPrQF0Ju+X6UEYFaij8/XMYke0zsSeJ3u1Wk6g56+LTAoY7c0y7NN36h7bu+GNEP2
 TMTD0ongCNO/Izu1cjyHPWVSwqaSShn1Hs+vFV3BqAndg0uD6T7WemslQf7n59cgrawZdiBXT
 pxtmpcRMYePJ8fP+JI887hi4tDnbqbHZeXCkSgF6y92RClNCWCSiKqgUPJrYzS834wb1fOcih
 YX9iiZ9fz1Khi0695nJZsOafLhGYK18cpvfg1ldUJ0YaJ2nVr+nuiA93yQo6uY5KDz7f+JITU
 0rMPJ7CEBjNvL4RtVdUicm7DdWzNmp8RUc+/7zKCdDC7qkUmOp9j7NT/b8hy137koeDOUqEud
 IDeO6Py1fQlofnWsEnCBAn9JtKdoWpXB2khTneYnqD3nsRgEtvwCnKzNw1oAxXNFcRoujUfqA
 lM+zht+2EzLTsL8v9vYFlXp1pE4qa3AsY189bHNdu6Rjqujkopfb6Aj7PmZHiKmqsL/xLLO+G
 F19u82HDWp0jTMxVISpc3/jdH5//UYQKquLnchP6nR2ru2ZJDKvNlzwpObZh04XWl5Kz8LJvh
 K0SaFGJKsTweNR14l+nwjcvwezfzCkjg+vdh8qDjLek6nb6D7X5Rm/3ACZ6U40r6yOA71x3UX
 13ykjmg5CLEvrK4F4mo8ntjPQmN54iK9xLDdd/LB6umAbUllpktZ9nirpr0xnCRMGEAh+02JF
 CyPFB0/wy0bIWw=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/13 =E4=B8=8B=E5=8D=889:17, Nikolay Borisov wrote:
> This function lies in the kernel-shared directory and is supposed to be
> close to 1:1 copy with its kernel counterpart, yet it takes one extra
> argument - root. But this is now unused to simply remove it.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   kernel-shared/ctree.c       | 3 +--
>   kernel-shared/ctree.h       | 3 +--
>   kernel-shared/dir-item.c    | 2 +-
>   kernel-shared/extent-tree.c | 2 +-
>   kernel-shared/file-item.c   | 4 ++--
>   kernel-shared/inode-item.c  | 4 ++--
>   6 files changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
> index 77766c2a7931..78f94c6cd42f 100644
> --- a/kernel-shared/ctree.c
> +++ b/kernel-shared/ctree.c
> @@ -2545,8 +2545,7 @@ int btrfs_split_item(struct btrfs_trans_handle *tr=
ans,
>   	return ret;
>   }
>
> -int btrfs_truncate_item(struct btrfs_root *root, struct btrfs_path *pat=
h,
> -			u32 new_size, int from_end)
> +int btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from=
_end)
>   {
>   	int ret =3D 0;
>   	int slot;
> diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
> index a17bf50e29b4..91a85796a678 100644
> --- a/kernel-shared/ctree.h
> +++ b/kernel-shared/ctree.h
> @@ -2670,8 +2670,7 @@ int btrfs_create_root(struct btrfs_trans_handle *t=
rans,
>   		      struct btrfs_fs_info *fs_info, u64 objectid);
>   int btrfs_extend_item(struct btrfs_root *root, struct btrfs_path *path=
,
>   		u32 data_size);
> -int btrfs_truncate_item(struct btrfs_root *root, struct btrfs_path *pat=
h,
> -			u32 new_size, int from_end);
> +int btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from=
_end);
>   int btrfs_split_item(struct btrfs_trans_handle *trans,
>   		     struct btrfs_root *root,
>   		     struct btrfs_path *path,
> diff --git a/kernel-shared/dir-item.c b/kernel-shared/dir-item.c
> index 7dc606c132b5..590b79a929d3 100644
> --- a/kernel-shared/dir-item.c
> +++ b/kernel-shared/dir-item.c
> @@ -284,7 +284,7 @@ int btrfs_delete_one_dir_name(struct btrfs_trans_han=
dle *trans,
>   		start =3D btrfs_item_ptr_offset(leaf, path->slots[0]);
>   		memmove_extent_buffer(leaf, ptr, ptr + sub_item_len,
>   			item_len - (ptr + sub_item_len - start));
> -		btrfs_truncate_item(root, path, item_len - sub_item_len, 1);
> +		btrfs_truncate_item(path, item_len - sub_item_len, 1);
>   	}
>   	return ret;
>   }
> diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
> index 056a9256b9a4..a8e0c1e60e2e 100644
> --- a/kernel-shared/extent-tree.c
> +++ b/kernel-shared/extent-tree.c
> @@ -1166,7 +1166,7 @@ static int update_inline_extent_backref(struct btr=
fs_trans_handle *trans,
>   			memmove_extent_buffer(leaf, ptr, ptr + size,
>   					      end - ptr - size);
>   		item_size -=3D size;
> -		ret =3D btrfs_truncate_item(root, path, item_size, 1);
> +		ret =3D btrfs_truncate_item(path, item_size, 1);
>   		BUG_ON(ret);
>   	}
>   	btrfs_mark_buffer_dirty(leaf);
> diff --git a/kernel-shared/file-item.c b/kernel-shared/file-item.c
> index 7e16b747e36c..c910e27e5a5d 100644
> --- a/kernel-shared/file-item.c
> +++ b/kernel-shared/file-item.c
> @@ -362,7 +362,7 @@ static noinline int truncate_one_csum(struct btrfs_r=
oot *root,
>   		 */
>   		u32 new_size =3D (bytenr - key->offset) / blocksize;
>   		new_size *=3D csum_size;
> -		ret =3D btrfs_truncate_item(root, path, new_size, 1);
> +		ret =3D btrfs_truncate_item(path, new_size, 1);
>   		BUG_ON(ret);
>   	} else if (key->offset >=3D bytenr && csum_end > end_byte &&
>   		   end_byte > key->offset) {
> @@ -375,7 +375,7 @@ static noinline int truncate_one_csum(struct btrfs_r=
oot *root,
>   		u32 new_size =3D (csum_end - end_byte) / blocksize;
>   		new_size *=3D csum_size;
>
> -		ret =3D btrfs_truncate_item(root, path, new_size, 0);
> +		ret =3D btrfs_truncate_item(path, new_size, 0);
>   		BUG_ON(ret);
>
>   		key->offset =3D end_byte;
> diff --git a/kernel-shared/inode-item.c b/kernel-shared/inode-item.c
> index 4e009746de0e..67173eb141d8 100644
> --- a/kernel-shared/inode-item.c
> +++ b/kernel-shared/inode-item.c
> @@ -311,7 +311,7 @@ int btrfs_del_inode_extref(struct btrfs_trans_handle=
 *trans,
>   	memmove_extent_buffer(leaf, ptr, ptr + del_len,
>   			      item_size - (ptr + del_len - item_start));
>
> -	btrfs_truncate_item(root, path, item_size - del_len, 1);
> +	btrfs_truncate_item(path, item_size - del_len, 1);
>
>   out:
>   	btrfs_free_path(path);
> @@ -432,7 +432,7 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *t=
rans,
>   	item_start =3D btrfs_item_ptr_offset(leaf, path->slots[0]);
>   	memmove_extent_buffer(leaf, ptr, ptr + sub_item_len,
>   			      item_size - (ptr + sub_item_len - item_start));
> -	btrfs_truncate_item(root, path, item_size - sub_item_len, 1);
> +	btrfs_truncate_item(path, item_size - sub_item_len, 1);
>   	btrfs_mark_buffer_dirty(path->nodes[0]);
>   out:
>   	btrfs_free_path(path);
>
