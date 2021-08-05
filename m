Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2143E0E83
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Aug 2021 08:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbhHEGmi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Aug 2021 02:42:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:53949 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231418AbhHEGmh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Aug 2021 02:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628145741;
        bh=POLVgSC3rQNYmaZBukljMZlC71Zb7v8lL7uEbgLHPjk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Pp2+kZUoAV60IS+/BukiHXa0KebOYKB+PSjI+BvgGl2hoWRXnREV42T6zOKwXJLja
         uYcLzRk9r9Q7mMTlJ1lqfyN4+drCZMVLXU0W1j0ETmvtx0R5ZDUWttox31jk2Fzjc2
         7DOdUp8q3+qD/l2/r3WL0WAHk+YrTf2TsHoEXw5k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBlxM-1mJGK03ky4-00CASs; Thu, 05
 Aug 2021 08:42:21 +0200
Subject: Re: [PATCH 4/7] btrfs: root-tree: Use btrfs_find_item in
 btrfs_find_orphan_roots
To:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, nborisov@suse.com
References: <20210804184854.10696-1-mpdesouza@suse.com>
 <20210804184854.10696-5-mpdesouza@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <7f622d63-57de-5f85-ac92-ea624b83b183@gmx.com>
Date:   Thu, 5 Aug 2021 14:42:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804184854.10696-5-mpdesouza@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zT8hpvMRV+rxLqeTbtkspbvp8vT+A+i7/exxS7AMtmYMfqmOhDz
 SQFkmV6GdLXPEjvDtcnWrvbLKd2qjVzhM98AdAWmHlp0BmHSvTklGtJmSHLl06pZ1E6uOue
 kR7FqEsa/rNUkvjVj6Wq/mBUKEa8eOoOWaz0UbLEhf64DdOtNYQ2OujU1H6dVJZD7Ofu7LM
 cLjMqsk3SyXbeJtA7JlQg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Uami59HuNZU=:3c16yO2FiG9ZvVuu1h4XyW
 RuwsOMY/rP+iXNBjKPkKoqy3X2yS43VKOyFWyAJY0ihwWf543eLyDRW4VqGRlbQ5C7eG6S+Q6
 zKlbUsWAUyqGOCAm8hzlzWk7a5yXC+eGWHAf9hrYq/2LCPF7yh0duY9uK1PSeM3aOwSdgs9iE
 jjNLPnNfGJDh4WFg3HPSTsA2riqpI82g3CDG/BNAtDdbzXVB9a7G5KC4jDPQyO690ABWoHvX5
 AJ5LxWr8w06aAuow7UdSdGw6NjBpYqbslso/2mbXFBkdRZkWwiB+1D57I1SnAcqvDPerRivsx
 P9LCwZjC8AJlTB/9JYafTRgf3BfG0iCVeYck7WAXHU0Hj8DMG6kTpBj2Ub+rX2uIq4wdKMRlU
 IPR62BHCG1oZG9GF/e17B9XawVMOPCQfVCKrx8hAvevH59mkcYuyO0yty2XNx/2C8KyJ0LvFr
 u2hJ5wuHBOmH0qRxxSnZdM9oB+958QrXKxtdlkTxOYkJn7KMSC6Zz2xV+UIBn65JiQjBTFeZo
 VruEjbvp7vmYE9z4t12v851N4HSvLLYQS2VEO0ymgLaPRCJE6SREwWClgUfXpI/kg4aLYKFAo
 /Hj8PCwALDG5nqic++u7UuWR+09fmXP1Y3GqgdJ+pL9/STnfBLJq9zsjK59cIzFQaFX3S25Hz
 WK0uiWXPxUov7WiHQiL3EXIEKuYsPsiTX7hVf1b/h4xmon5tx3myYWdWuKbnN91ByB17JFM54
 KDrbevqZm+rborx+UI4V15GOqW2BOAIm6Vpu661fsSGhqQoHFtmqO4QwjnS4EwaFbp5lap6+S
 GJ58lWF5Rp472XBolNnIW2LnRf2EI0RB0MztbghzVP4COG11dI79BThOkrmVYqyrEQmpXr4Tx
 aqIICmRG7Yc0l/A2m+1MYlmdtQRpp/3b9aoiDByyTnoGSPua+jmoP+0rJot8v3B84eOE1H/hV
 f/Nwxnh8Jt+iFXunf/OY48tywAF7yoql5kSMrwwCp4w5ZrW+uBdg9R9t3pE4j+QVoLyXsYWck
 9e44JHQSnXwQTEA4dCbi1HdaZhs2AmU1Cq3ThehfYbPAvwOVej8D8FGPl5kh5mylNLsU5o8/G
 +5Y2Q2edzwDpwxCNaSec+3/wIQMoz6Q37NF3pAQ8HI5ONCIb+yLYqwjfA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/5 =E4=B8=8A=E5=8D=882:48, Marcos Paulo de Souza wrote:
> Prefer btrfs_find_item instead of btrfs_search_slot, since it calls
> btrfs_next_leaf if needed and checks if the item found has the same
> objectid and type passed in the search key.

This is fine, but IMHO btrfs_find_item() would be preferred to be
utilized when we know exactly the search key.

For orphan iteration, I guess we would really prefer something like
"btrfs_iterate_key_range()" or things like that?

Yeah, using btrfs_find_item() here is no harm, but it's also not that
typical to me.

Or you're going to introduce specific helper for this usage later?
Then I prefer to modify this call site when the iteration interface is
introduced.

Thanks,
Qu
>
> No functional changes.
>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>   fs/btrfs/root-tree.c | 32 ++++++++------------------------
>   1 file changed, 8 insertions(+), 24 deletions(-)
>
> diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> index 702dc5441f03..4bb0ad192a2f 100644
> --- a/fs/btrfs/root-tree.c
> +++ b/fs/btrfs/root-tree.c
> @@ -207,10 +207,10 @@ int btrfs_insert_root(struct btrfs_trans_handle *t=
rans, struct btrfs_root *root,
>   int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
>   {
>   	struct btrfs_root *tree_root =3D fs_info->tree_root;
> -	struct extent_buffer *leaf;
>   	struct btrfs_path *path;
>   	struct btrfs_key key;
>   	struct btrfs_root *root;
> +	u64 offset =3D 0;
>   	int err =3D 0;
>   	int ret;
>
> @@ -218,38 +218,22 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *=
fs_info)
>   	if (!path)
>   		return -ENOMEM;
>
> -	key.objectid =3D BTRFS_ORPHAN_OBJECTID;
> -	key.type =3D BTRFS_ORPHAN_ITEM_KEY;
> -	key.offset =3D 0;
> -
>   	while (1) {
>   		u64 root_objectid;
>
> -		ret =3D btrfs_search_slot(NULL, tree_root, &key, path, 0, 0);
> +		ret =3D btrfs_find_item(tree_root, path, BTRFS_ORPHAN_OBJECTID,
> +				BTRFS_ORPHAN_ITEM_KEY, offset, &key);
> +
> +		btrfs_release_path(path);
>   		if (ret < 0) {
>   			err =3D ret;
>   			break;
> -		}
> -
> -		leaf =3D path->nodes[0];
> -		if (path->slots[0] >=3D btrfs_header_nritems(leaf)) {
> -			ret =3D btrfs_next_leaf(tree_root, path);
> -			if (ret < 0)
> -				err =3D ret;
> -			if (ret !=3D 0)
> -				break;
> -			leaf =3D path->nodes[0];
> -		}
> -
> -		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
> -		btrfs_release_path(path);
> -
> -		if (key.objectid !=3D BTRFS_ORPHAN_OBJECTID ||
> -		    key.type !=3D BTRFS_ORPHAN_ITEM_KEY)
> +		} else if (ret > 0) {
>   			break;
> +		}
>
>   		root_objectid =3D key.offset;
> -		key.offset++;
> +		offset++;
>
>   		root =3D btrfs_get_fs_root(fs_info, root_objectid, false);
>   		err =3D PTR_ERR_OR_ZERO(root);
>
