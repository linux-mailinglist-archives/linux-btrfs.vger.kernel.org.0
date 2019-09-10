Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60D7CAE306
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 06:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388496AbfIJE14 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Sep 2019 00:27:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:46065 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729717AbfIJE14 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Sep 2019 00:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568089669;
        bh=3TZhgug2kK3LGYaHp38jSBRQP0qNlOoQsXrqV+YyQWw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=eYZfkeKBG/nYw47NlUJ6EtebXAH0EUtdZoZKOUIiFeGg0hUs4+dRcANGKZCqmejr3
         k0XqwmYZQd06aUuKPNmd3z7jQeBAVJxSuwjJkTY6u3Y/Blp9lBZj0feR+cpd+ygcLn
         aKk1CrIgo2IYhpvWTfHcql+ZVIOhziCUgzv5LEDQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.138] ([34.92.239.241]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0M1SLt-1iRHdF1LUv-00tRjc; Tue, 10
 Sep 2019 06:27:49 +0200
Subject: Re: [PATCH v2 3/6] btrfs-progs: check/common: Make
 repair_imode_common() to handle inodes in subvolume trees
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20190905075800.1633-1-wqu@suse.com>
 <20190905075800.1633-4-wqu@suse.com>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <e86d8e52-d708-cd28-7ae1-ae9e328d8cd1@gmx.com>
Date:   Tue, 10 Sep 2019 12:27:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:69.0)
 Gecko/20100101 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190905075800.1633-4-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N5xrF5xxkb2uBkKOPkNat6wGME6L599rMJ25OIUwX2WjhekMLdF
 XNnAJtbqTPQvZrmnqSwqjhDymPh0UA17wX7bmwqe9lddYefisK0Ph+AVjU9JGDniofCHFkJ
 tFK+ZCsut+HGIufU9mb6qgiQNxRFZ5vbg/sDYtc/iYE04K3TM4k1xCIzBRjvxQUfga484e6
 tvo3CGkN2E/Sn3I4lDFzw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qpLgfGXjWgM=:9lSB1H5oAj1qxJFB8epJpx
 KIBGmnu1gtntpTyfBeKLPP3SdvLVkUxAE1Ak3gffTyomFuAwhGKFCbJJqSbSeueuvOOEVviYY
 fbbJ3kBIVnN1UWMxtgIbpcMpwYJIJfCDg6z44iTm5Sixs5MhcJ88QXk3W7j+nd84su4ompltD
 vKBLCqoVaQl/e/FztOgfAM7UkwEEuGBO+qb1E4pSUnWe8ANLk2ccadt0MZN97ZhxQ3SSTUxQs
 27SCk8qDRMzdyjYRXzUAqwudNPooroncsmyh0Wr/CKq5g+rG73iYhOCa2v7a0iiS/b04yHn7i
 QSBFgBJ4QdlXpVMBwDka/LZxS9yfmwtvfOSBt46GlsGshOlLU7aoS7ov1YJGE3Z1G8lEzW5oT
 PNGjs6qLvUpC1E6H7Bqx1Q2RpfwZnrOkCoBC6HOO/2BArtWDGX51+maOau84s8L90afKfPjct
 n82PkwNysrkGdVgPAEWbDVR2rzzblkZUZLZPh49y78RlyxI3NNlopNB1o04o6Ro0W8vbpv+qg
 z3T5zTnX7Pn2hezv8IfqJ8wh4oSaJg7kne+Y+HbfAdpO3EUxLpgK4WedZfSlMfHuO6H1agPb6
 imiaHYxzBi63E0Onwjv7euSzxJ6QEcdL6dsXYFFrVJGOjeb+/kC9ZnjmaI9N38Wee2o7iZcHK
 QuQ/+KkSgfOI0fUx4ndzkNeTrO/cwJnIN4iD18PvZBvGfMm80m+A5e9MzzTuiScr2ZQ9dYzxb
 uLXKQiytN/RbZ1JV7sNTUG6zrExB59lDhMsawmG9p7HJheZLro+xMfy3CP0ENrc6IQ2+5xgA8
 +pMEV7s48n01YfvyslZBGrtZha+Qv/705qHCwJVz/q8wBZYDbM2ivDFVNh4SmoOqUMRHNqzbo
 eHj22VRovewAhdPRPMHuOYEWkax6MIt0HbfxBiBzSPZUOtKHzrB+EUOAKLXqJ8r4lEvv5Lbn3
 aEsLoD58elX/KR/kwE4vzBO8YbYNjk2yYhYPIm1WR3HvkkdCnQUwWJ3A6FCm0tXM/z0tSwzd/
 bF03tJky/09dcjD5DSr9zvzLU6ZHOMmdyz55+Mvt/FelvMGU4o9VLLd0z3EXOH6d4ItbAfVFm
 QeVWN2rUfxEALe9Mjl6hsHqqz5bCQ7Q/zTfDLrlPr0a91JDx1STM+i+6VAsOcYlS8CdNosOLQ
 elXTGPytkuZPIhCTdHAaS23IFhTp0SBw/Rwjag2FffQ+ymLs7lIBlfWs3Q6O4m6fJMyoSKE6X
 HHeMLC6z6E1WSPpOm
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/9/5 3:57 PM, Qu Wenruo wrote:
> Before this patch, repair_imode_common() can only handle two types of
> inodes:
> - Free space cache inodes
> - ROOT DIR inodes
>
> For inodes in subvolume trees, the core complexity is how to determine t=
he
> correct imode, thus it was not implemented.
>
> However there are more reports of incorrect imode in subvolume trees, we
> need to support such fix.
>
> So this patch adds a new function, detect_imode(), to detect imode for
> inodes in subvolume trees.
>
> That function will determine imode by:
> - Search for INODE_REF
>    If we have INODE_REF, we will then try to find DIR_ITEM/DIR_INDEX.
>    As long as one valid DIR_ITEM or DIR_INDEX can be found, we convert
>    the BTRFS_FT_* to imode, then call it a day.
>    This should be the most accurate way.
>
> - Search for DIR_INDEX/DIR_ITEM
>    If above search fails, we falls back to locate the DIR_INDEX/DIR_ITEM
>    just after the INODE_ITEM.
>    If any can be found, it's definitely a directory.
>
> - Search for EXTENT_DATA
>    If EXTENT_DATA can be found, it's either REG or LNK.
>    For this case, we default to REG, as user can inspect the file to
>    determine if it's a file or just a path.
>
> - Use rdev to detect BLK/CHR
>    If all above fails, but INODE_ITEM has non-zero rdev, then it's eithe=
r
>    a BLK or CHR file. Then we default to BLK.
>
> - Fail out if none of above methods succeeded
>    No educated guess to make things worse.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   check/mode-common.c | 130 +++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 117 insertions(+), 13 deletions(-)
>
> diff --git a/check/mode-common.c b/check/mode-common.c
> index c0ddc50a1dd0..abea2ceda4c4 100644
> --- a/check/mode-common.c
> +++ b/check/mode-common.c
> @@ -935,6 +935,113 @@ out:
>   	return ret;
>   }
>
> +static int detect_imode(struct btrfs_root *root, struct btrfs_path *pat=
h,
> +			u32 *imode_ret)
> +{
> +	struct btrfs_key key;
> +	struct btrfs_inode_item iitem;
> +	const u32 priv =3D 0700;
> +	bool found =3D false;
> +	u64 ino;
> +	u32 imode;
> +	int ret =3D 0;
> +
> +	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
> +	ino =3D key.objectid;
> +	read_extent_buffer(path->nodes[0], &iitem,
> +			btrfs_item_ptr_offset(path->nodes[0], path->slots[0]),
> +			sizeof(iitem));
> +	/* root inode */
> +	if (ino =3D=3D BTRFS_FIRST_FREE_OBJECTID) {
> +		imode =3D S_IFDIR;
> +		found =3D true;
> +		goto out;
> +	}
> +
> +	while (1) {
> +		struct btrfs_inode_ref *iref;
> +		struct extent_buffer *leaf;
> +		unsigned long cur;
> +		unsigned long end;
> +		char namebuf[BTRFS_NAME_LEN] =3D {0};
> +		u64 index;
> +		u32 namelen;
> +		int slot;
> +
> +		ret =3D btrfs_next_item(root, path);
> +		if (ret > 0) {
> +			/* falls back to rdev check */
> +			ret =3D 0;
> +			goto out;
> +		}
> +		if (ret < 0)
> +			goto out;
> +		leaf =3D path->nodes[0];
> +		slot =3D path->slots[0];
> +		btrfs_item_key_to_cpu(leaf, &key, slot);
> +		if (key.objectid !=3D ino)
> +			goto out;
> +
> +		/*
> +		 * We ignore some types to make life easier:
> +		 * - XATTR
> +		 *   Both REG and DIR can have xattr, so not useful
> +		 */
> +		switch (key.type) {
> +		case BTRFS_INODE_REF_KEY:
> +			/* The most accurate way to determine filetype */
> +			cur =3D btrfs_item_ptr_offset(leaf, slot);
> +			end =3D cur + btrfs_item_size_nr(leaf, slot);
> +			while (cur < end) {
> +				iref =3D (struct btrfs_inode_ref *)cur;
> +				namelen =3D min_t(u32, end - cur - sizeof(&iref),
> +					btrfs_inode_ref_name_len(leaf, iref));
> +				index =3D btrfs_inode_ref_index(leaf, iref);
> +				read_extent_buffer(leaf, namebuf,
> +					(unsigned long)(iref + 1), namelen);
> +				ret =3D find_file_type(root, ino, key.offset,
> +						index, namebuf, namelen,
> +						&imode);
> +				if (ret =3D=3D 0) {
> +					found =3D true;
> +					goto out;
> +				}
> +				cur +=3D sizeof(*iref) + namelen;
> +			}
> +			break;
> +		case BTRFS_DIR_ITEM_KEY:
> +		case BTRFS_DIR_INDEX_KEY:
> +			imode =3D S_IFDIR;
> +			goto out;
> +		case BTRFS_EXTENT_DATA_KEY:
> +			/*
> +			 * Both REG and LINK could have EXTENT_DATA.
> +			 * We just fall back to REG as user can inspect the
> +			 * content.
> +			 */
> +			imode =3D S_IFREG;
> +			goto out;
> +		}
> +	}
> +
> +out:
> +	/*
> +	 * Both CHR and BLK uses rdev, no way to distinguish them, so fall bac=
k
> +	 * to BLK. But either way it doesn't really matter, as CHR/BLK on btrf=
s
> +	 * should be pretty rare, and no real data will be lost.
> +	 */
> +	if (!found && btrfs_stack_inode_rdev(&iitem) !=3D 0) {
> +		imode =3D S_IFBLK;
> +		found =3D true;
> +	}
> +
> +	if (found)
> +		*imode_ret =3D (imode | priv);

Should set @ret to 0 here=EF=BC=9F
In above fallback path, @ret may be negative.

=2D-
Su
> +	else
> +		ret =3D -ENOENT;
> +	return ret;
> +}
> +
>   /*
>    * Reset the inode mode of the inode specified by @path.
>    *
> @@ -951,22 +1058,19 @@ int repair_imode_common(struct btrfs_root *root, =
struct btrfs_path *path)
>   	u32 imode;
>   	int ret;
>
> -	if (root->root_key.objectid !=3D BTRFS_ROOT_TREE_OBJECTID) {
> -		error(
> -		"repair inode mode outside of root tree is not supported yet");
> -		return -ENOTTY;
> -	}
>   	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
>   	ASSERT(key.type =3D=3D BTRFS_INODE_ITEM_KEY);
> -	if (key.objectid !=3D BTRFS_ROOT_TREE_DIR_OBJECTID &&
> -	    !is_fstree(key.objectid)) {
> -		error("unsupported ino %llu", key.objectid);
> -		return -ENOTTY;
> +	if (root->objectid =3D=3D BTRFS_ROOT_TREE_OBJECTID) {
> +		/* In root tree we only have two possible imode */
> +		if (key.objectid =3D=3D BTRFS_ROOT_TREE_OBJECTID)
> +			imode =3D S_IFDIR | 0755;
> +		else
> +			imode =3D S_IFREG | 0600;
> +	} else {
> +		ret =3D detect_imode(root, path, &imode);
> +		if (ret < 0)
> +			return ret;
>   	}
> -	if (key.objectid =3D=3D BTRFS_ROOT_TREE_DIR_OBJECTID)
> -		imode =3D 040755;
> -	else
> -		imode =3D 0100600;
>
>   	trans =3D btrfs_start_transaction(root, 1);
>   	if (IS_ERR(trans)) {
>

