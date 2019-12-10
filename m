Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E55DD118B5A
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2019 15:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfLJOnC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 09:43:02 -0500
Received: from mout.gmx.net ([212.227.15.18]:45151 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbfLJOnC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 09:43:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575988975;
        bh=WYukfoCHegLBV9mpOXKlkPkrd/q4BY5C5JMJFTudtOI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ZmAhBC+oTotx5tB5uZIIl90z/ZSStPknyJ4E4D/e+I5hHxYKjkj8TXLXQwtXnd/8f
         ZDM1sm7rPTOca56gIL3xeMJ23AfYK7IOyXJ1xb6r1bwEi+wNZl0RwTS8bBoiNHF67/
         QUaPTXNd9aX1s2g/khzuhQueMypcGe576zHPkm4A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.174] ([34.92.249.81]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1ML9yS-1iMbbo0Yug-00IACE; Tue, 10
 Dec 2019 15:42:55 +0100
Subject: Re: [PATCH 2/4] btrfs: tree-checker: Refactor inode key check into
 seperate function
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191209105435.36041-1-wqu@suse.com>
 <20191209105435.36041-2-wqu@suse.com>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <82d40759-edd1-b4f3-c38f-a98add7d5089@gmx.com>
Date:   Tue, 10 Dec 2019 22:42:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:72.0)
 Gecko/20100101 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20191209105435.36041-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hnTuV2Dc86r2khwI7PiA48Xsu3OpaOSlzfo2dcCMhf83lOUN07j
 GoPVqP9fEQxrXQxLgz6TzETITSqod5QmY98rUxoFAu+UYpljvZKntpylOjcu19LjTbq9Baz
 zmRrG6FLDvgEg7Ws0UouOLVqd2H5ib/ZZcEL+KbkHfFLGv8KPwmjX7KZgiVD89S83CU6M3c
 hPiUowI4LZkEvfiP23Raw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2VOXh0La6yg=:RWpG4YLP4kxF7GuX3B8N0O
 JukbnQfUKIen+Pcd/OgZZMPY8Ed6UGucbYnxMVUJG8AZCloTPLZPp6l4AqkUK/DcGv0Zmjd2g
 oewg3j1EHuYDVkZU/1EX8dbqWP8xT7pNwOTo+FXC9HpjxBSTstvDG2XiqVHQHvcZ2OiQP/oqd
 j8HkvjfkC5ztMf0sdQ1cwWwRGFx8OGTay6Xf/wBqP/r5UfL3OyVH9XLvBSAnhyXXYpYkJAJeJ
 LBDEVC5IybI411hLyCceotJ/QIACdauq6V1qfRSWyaQP0fKiOHBafuovYn/5hLI9vJ1d3/rv/
 gFUMVB+y/2wHbpUwiole3H4gq/mqsLO3BCN+0yXTrDeB0/3AKCgN9Y3wwWpzALljMATtzdDiT
 mzBNt7hFuU4GfpumVdzPZcG/iKtsPDR+Pvwr0pF8a6o620MugHRgP+ynLnnsX4B51Bt/c+jj9
 jMCAR0Cw2PIvagtxHCbAmcoH6Yq0FKTjyxAly1IoIUK/w+j2mT63bsKZSA5+wJb0SQnZK8wO5
 kpxI9N1aQmLlU51M+Q3DcIkr7GwTX2m82ttaJY1uV8hDXXrnKOTe4LtFFYLhpTLQrpdbHUHZB
 84zmfKTqNida+RVoC3MRyHWkR1/HkogdI4XjQn/48TdLP0CaiiR4zmoJhFprzI2gtuWHzoHRd
 1Ty11MIlbBK9bjyT3uzGsxXQdZ+ebu2QDTh4r2kuEiPhXNNuBoXA+mH9cG7gEOsRTS7oxentl
 vJAKuphfPwkGw0eLAxECOaV6nTkXkJ5EWkyeEwRZ5jeuCv8qVFctlu44mA52QJ4ZWSHWEaGD/
 7Y6adSBZn7BsU1qyVmGX+GAJPUcbI5CRkqQ+p5a6OmWYlPUqTDk0l6rPC8vVQnEBYVZpxYmHz
 kpKVfWHKhT6nHIY8BvEqKCgpgkuZjpZ2PheaHH9ka0rzXlzS/AWVF3nJ4XI3KtXoKBD+nZTfS
 inuKA1tacZzrsLFZxYLuLzHGTQiwEwtsnp6XViLSrKjdTa03vMKNEMuPlkRR/C9hQJypbj1CN
 A/djHXbi3m1tuDhwddwGwcPaKM+SFxalOosbFQAdTiIxskFsh8VcDwSWmxkpvky/eFQQxPtyl
 g92Sdr32lkbcp1xK408MB+z4VJDnpphbcHBCAIT/7dQHxmdpwOHvGupSqVBiDevLddHJrsXFi
 Cy+Ayfn+tuaZjY4wSyHRrmuPQjcGHK0EOgn81xq3uPuf7BwRUKB0DI8o2zMxsJTL9Yp0yLM8f
 JMkgF7fJFsSeCOy6R5rePJkRCXhMVt5fmT7fdFqQ/3qOyxsvhM8LCnhcm8hE=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/12/9 6:54 PM, Qu Wenruo wrote:
> Inode key check is not as easy as several lines, and it will be called
> in more than one location (INODE_ITEM check and
> DIR_ITEM/DIR_INDEX/XATTR_ITEM location key check).
>
> So here refactor such check into check_inode_key().
>
> And add extra checks for XATTR_ITEM.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/tree-checker.c | 77 +++++++++++++++++++++++++++++++----------
>   1 file changed, 59 insertions(+), 18 deletions(-)
>
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 6cb49c75c5e1..68dad9ec38dd 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -359,6 +359,60 @@ static int check_csum_item(struct extent_buffer *le=
af, struct btrfs_key *key,
>   	return 0;
>   }
>
> +/* Inode item error output has the same format as dir_item_err() */
> +#define inode_item_err(eb, slot, fmt, ...)			\
> +	dir_item_err(eb, slot, fmt, __VA_ARGS__)
> +
> +static int check_inode_key(struct extent_buffer *leaf, struct btrfs_key=
 *key,
> +			   int slot)

The function name is confusing to me. It checks xattr which is not
inode related obviously.

I saw the 4th patch. How about introduction of new function
check_location_key(), then calls check_root_key() , check_inode_key()
and checks xatrr case inside?

Others in the patchset seem fine to me.


Thanks
> +{
> +	struct btrfs_key item_key;
> +	bool is_inode_item;
> +
> +	btrfs_item_key_to_cpu(leaf, &item_key, slot);
> +	is_inode_item =3D (item_key.type =3D=3D BTRFS_INODE_ITEM_KEY);
> +
> +	/* For XATTR_ITEM, location key should be all 0 */
> +	if (item_key.type =3D=3D BTRFS_XATTR_ITEM_KEY) {
> +		if (key->type !=3D 0 || key->objectid !=3D 0 || key->offset !=3D 0)
> +			return -EUCLEAN;
> +		return 0;
> +	}
> +
> +	if ((key->objectid < BTRFS_FIRST_FREE_OBJECTID ||
> +	     key->objectid > BTRFS_LAST_FREE_OBJECTID) &&
> +	    key->objectid !=3D BTRFS_ROOT_TREE_DIR_OBJECTID &&
> +	    key->objectid !=3D BTRFS_FREE_INO_OBJECTID) {
> +		if (is_inode_item)
> +			generic_err(leaf, slot,
> +	"invalid key objectid: has %llu expect %llu or [%llu, %llu] or %llu",
> +				key->objectid, BTRFS_ROOT_TREE_DIR_OBJECTID,
> +				BTRFS_FIRST_FREE_OBJECTID,
> +				BTRFS_LAST_FREE_OBJECTID,
> +				BTRFS_FREE_INO_OBJECTID);
> +		else
> +			dir_item_err(leaf, slot,
> +"invalid location key objectid: has %llu expect %llu or [%llu, %llu] or=
 %llu",
> +				key->objectid, BTRFS_ROOT_TREE_DIR_OBJECTID,
> +				BTRFS_FIRST_FREE_OBJECTID,
> +				BTRFS_LAST_FREE_OBJECTID,
> +				BTRFS_FREE_INO_OBJECTID);
> +		return -EUCLEAN;
> +	}
> +	if (key->offset !=3D 0) {
> +		if (is_inode_item)
> +			inode_item_err(leaf, slot,
> +				       "invalid key offset: has %llu expect 0",
> +				       key->offset);
> +		else
> +			dir_item_err(leaf, slot,
> +				"invalid location key offset:has %llu expect 0",
> +				key->offset);
> +		return -EUCLEAN;
> +	}
> +	return 0;
> +}
> +
>   static int check_dir_item(struct extent_buffer *leaf,
>   			  struct btrfs_key *key, struct btrfs_key *prev_key,
>   			  int slot)
> @@ -798,25 +852,12 @@ static int check_inode_item(struct extent_buffer *=
leaf,
>   	u64 super_gen =3D btrfs_super_generation(fs_info->super_copy);
>   	u32 valid_mask =3D (S_IFMT | S_ISUID | S_ISGID | S_ISVTX | 0777);
>   	u32 mode;
> +	int ret;
> +
> +	ret =3D check_inode_key(leaf, key, slot);
> +	if (ret < 0)
> +		return ret;
>
> -	if ((key->objectid < BTRFS_FIRST_FREE_OBJECTID ||
> -	     key->objectid > BTRFS_LAST_FREE_OBJECTID) &&
> -	    key->objectid !=3D BTRFS_ROOT_TREE_DIR_OBJECTID &&
> -	    key->objectid !=3D BTRFS_FREE_INO_OBJECTID) {
> -		generic_err(leaf, slot,
> -	"invalid key objectid: has %llu expect %llu or [%llu, %llu] or %llu",
> -			    key->objectid, BTRFS_ROOT_TREE_DIR_OBJECTID,
> -			    BTRFS_FIRST_FREE_OBJECTID,
> -			    BTRFS_LAST_FREE_OBJECTID,
> -			    BTRFS_FREE_INO_OBJECTID);
> -		return -EUCLEAN;
> -	}
> -	if (key->offset !=3D 0) {
> -		inode_item_err(leaf, slot,
> -			"invalid key offset: has %llu expect 0",
> -			key->offset);
> -		return -EUCLEAN;
> -	}
>   	iitem =3D btrfs_item_ptr(leaf, slot, struct btrfs_inode_item);
>
>   	/* Here we use super block generation + 1 to handle log tree */
>
