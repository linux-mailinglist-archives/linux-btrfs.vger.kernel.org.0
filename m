Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3491B446B87
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Nov 2021 01:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhKFAXT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 20:23:19 -0400
Received: from mout.gmx.net ([212.227.17.22]:41203 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231816AbhKFAXS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Nov 2021 20:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636158034;
        bh=Jzhc6rxIk09W6YhAgRQfIpgQ5/l2KdpewHVsvIPtwTs=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=Ig+wcQWmmfFAlztsz7FwBTwxgKRWRFyIQUpcNCrvaqdGf5+6V2ycQgYBvzmiU9m1G
         XVTEcOFKKM62+AgSeWOktvrw8REoYDUSheZobue6WkQbLbfY4z20pXLQ9EX5d1cuyo
         TME36PiEctH6QJKOp0X3B0EZDOdJ+eBddqSBDWKY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNsw4-1n7I092UWm-00OIGj; Sat, 06
 Nov 2021 01:20:34 +0100
Message-ID: <8d9aa124-3887-3495-0c22-075972d4fe30@gmx.com>
Date:   Sat, 6 Nov 2021 08:20:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 05/20] btrfs-progs: btrfs-shared: stop passing root to
 csum related functions
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1636143924.git.josef@toxicpanda.com>
 <3eb2d14594f36893b7bd4ea28b38b00548f4aca3.1636143924.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <3eb2d14594f36893b7bd4ea28b38b00548f4aca3.1636143924.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VuzlxLr8MEubj8thb8/njFLUTuXA50tRch0rFydmz5GgfvFI2ms
 0tCX0Cb/Q7naCMp3aYLq6r9Q10/f7onfrC/1YNPm1ynGNTY5wIgax3CKuLgQRreDLdP1qIK
 IuCX6lLVh8x874P9uSNzd5ti2CgexL9wc78oYI6QNMVbJ4ok+xl8wf8mqz0cTyoGPb9wUC5
 /gKHJghkAMMqpIjQORthw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GH7eQSqzuu4=:ycpOWBagPQOpeD1/dbfP8W
 8GuoaJ+fsHwXj1Jj4AUto5erblsttb6ulmQKEHmX6j+V21KYoGRymNxffcwzlb4Lr7VemR54O
 OepTG/N1LjdgpDRPfSAQgBfK+vRfeqnes//ZGXOEOFDwaXeI1Qq/ZLT64swu8cpmbB+Ww034J
 nGe//0CzaaPbKnmSD95NlQfc3Qb5k49g54wVYu5SIXRajrSNqxWTaavlHZfxQFtNJKG55MdSf
 QDNb4vUQfl6nQAN64jnFp5AV5K4/mbhY5dJ8XKeyUE1pGTuV1Zol0fOOvIpgMEAXgUTmk50DF
 hTd9/nAU9ULuBce6suoQ4Tp3jP/AegvZUMMyt/hnyEE4uj8C9cHsTRrbV2wTqib5P38od242C
 56l7NV4A0+e9VUuWJjddr2bcNhi3787B6SNES4/YfUExSCqDTXLTXdWUwfbOAjpae0KuoJclB
 VSEdbSCppz0/gQK5rUpMFWkGPHE7lR8S9MCtHc9klyHlcYkNuVDtTItwpr7jjkJj+71d0rlu4
 xDiNKWoOwyRHJGIaYDJoJIJ+ubWkFgtDo93liQ4j2YjGafk2GYl/1E5vm/LafpUgE/eIIWmpK
 yHfDxzWxoo4ZmN3aKX+/rYwBHLofRQ0GdHp6k2/nrQBKrU83KM3l1stcJFG224S+OylLxGKci
 cE7jMPmWDLsT8wD4NUttVF6M6yiXca5l4RlK57li67FSvfAJimGyJvyiIL5VYf1qZHs6Xgo/r
 iaO0cDQMzMLhwi0d/vrKtHKJX66r+2ZvsKsCozxC9jksj66cQRn1DchqlgXwxvz28WFMlQ5WF
 fUCoFGpJZvZfPHzSAYMWZstRZ843MUvNu8JN+eGYkaVIhpXdmKylWm2QpYrz5JyY9JJn64Z1G
 GYYFs8NNmhm2Jvo+v3+mwYJo1mEGy5EisYBmRm9vp0KDFXHKDS260E+LZHcaHO1GpYO5mBlZ4
 4aso6OJF1+gPeLEuduOfiRB6qigQldkg5qzsjbxiHJqVAC/AUh1vl65XrSvWhytLCX4vxBt5f
 AXIJSQpG4OaJvIj+JIxQ0r9gmudV7ihS5X+SeW5DThN2Z1a8pre4/DuoA9Y2cqWM9Q7yjxWXZ
 mq2fYAQ7Wh2oqY=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/6 04:28, Josef Bacik wrote:
> We are going to need to start looking up the csum root based on the
> bytenr with extent tree v2.  To that end stop passing the root to the
> csum related functions so that can be done in the helper functions
> themselves.
>
> There's an unrelated deletion of a function prototype that no longer
> exists, if desired I can break that out from this patch.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Yeah, any global available tree should not be in the parameter list, as
that would only provide a chance for caller to pass wrong root in.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   check/main.c              | 4 ++--
>   convert/main.c            | 1 -
>   kernel-shared/ctree.h     | 6 +-----
>   kernel-shared/file-item.c | 4 ++--
>   mkfs/rootdir.c            | 2 +-
>   5 files changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/check/main.c b/check/main.c
> index 235a9bab..08810c5f 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -9484,8 +9484,8 @@ static int populate_csum(struct btrfs_trans_handle=
 *trans,
>   				       &sectorsize, 0);
>   		if (ret)
>   			break;
> -		ret =3D btrfs_csum_file_block(trans, csum_root, start + len,
> -					    start + offset, buf, sectorsize);
> +		ret =3D btrfs_csum_file_block(trans, start + len, start + offset,
> +					    buf, sectorsize);
>   		if (ret)
>   			break;
>   		offset +=3D sectorsize;
> diff --git a/convert/main.c b/convert/main.c
> index 223eebad..7f33d4e1 100644
> --- a/convert/main.c
> +++ b/convert/main.c
> @@ -187,7 +187,6 @@ static int csum_disk_extent(struct btrfs_trans_handl=
e *trans,
>   		if (ret)
>   			break;
>   		ret =3D btrfs_csum_file_block(trans,
> -					    root->fs_info->csum_root,
>   					    disk_bytenr + num_bytes,
>   					    disk_bytenr + offset,
>   					    buffer, blocksize);
> diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
> index 3c0743cc..73904255 100644
> --- a/kernel-shared/ctree.h
> +++ b/kernel-shared/ctree.h
> @@ -2847,12 +2847,8 @@ int btrfs_insert_file_extent(struct btrfs_trans_h=
andle *trans,
>   int btrfs_insert_inline_extent(struct btrfs_trans_handle *trans,
>   				struct btrfs_root *root, u64 objectid,
>   				u64 offset, const char *buffer, size_t size);
> -int btrfs_csum_file_block(struct btrfs_trans_handle *trans,
> -			  struct btrfs_root *root, u64 alloc_end,
> +int btrfs_csum_file_block(struct btrfs_trans_handle *trans, u64 alloc_e=
nd,
>   			  u64 bytenr, char *data, size_t len);
> -int btrfs_csum_truncate(struct btrfs_trans_handle *trans,
> -			struct btrfs_root *root, struct btrfs_path *path,
> -			u64 isize);
>
>   /* uuid-tree.c, interface for mounted mounted filesystem */
>   int btrfs_lookup_uuid_subvol_item(int fd, const u8 *uuid, u64 *subvol_=
id);
> diff --git a/kernel-shared/file-item.c b/kernel-shared/file-item.c
> index c910e27e..5bf6aab4 100644
> --- a/kernel-shared/file-item.c
> +++ b/kernel-shared/file-item.c
> @@ -183,9 +183,9 @@ fail:
>   }
>
>   int btrfs_csum_file_block(struct btrfs_trans_handle *trans,
> -			  struct btrfs_root *root, u64 alloc_end,
> -			  u64 bytenr, char *data, size_t len)
> +			  u64 alloc_end, u64 bytenr, char *data, size_t len)
>   {
> +	struct btrfs_root *root =3D trans->fs_info->csum_root;
>   	int ret =3D 0;
>   	struct btrfs_key file_key;
>   	struct btrfs_key found_key;
> diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
> index 16ff257a..92be32ea 100644
> --- a/mkfs/rootdir.c
> +++ b/mkfs/rootdir.c
> @@ -403,7 +403,7 @@ again:
>   		 * we're doing the csum before we record the extent, but
>   		 * that's ok
>   		 */
> -		ret =3D btrfs_csum_file_block(trans, root->fs_info->csum_root,
> +		ret =3D btrfs_csum_file_block(trans,
>   				first_block + bytes_read + sectorsize,
>   				first_block + bytes_read,
>   				eb->data, sectorsize);
>
