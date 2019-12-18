Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02618123CFA
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 03:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfLRCOf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 21:14:35 -0500
Received: from mout.gmx.net ([212.227.15.18]:54501 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfLRCOf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 21:14:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576635273;
        bh=Tig8y/dLi1rFoFK9VQLADO3ljnAz4eHrIciHQgm6Xhs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=MWARuNDph9rO3LghSonrISPFjbzUxNvjJajwuV9xpBcMSbsLGlWhKG4LG8RhTTa+I
         L4fZd8B3EmhW0auaJj2QGK7jlC5M03l+9qDFdlCq3dUhaTL5/F3T9xG7RWv3lOEVSQ
         Z5THiFYfI/KFo3acQ+83BiFSKzGT/JxpEVhVijjc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.178] ([34.92.249.81]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MMGRA-1iRWJU13sk-00JILL; Wed, 18
 Dec 2019 03:09:11 +0100
Subject: Re: [PATCH 2/6] btrfs-progs: check/original: Do extra verification on
 file extent item
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191218011942.9830-1-wqu@suse.com>
 <20191218011942.9830-3-wqu@suse.com>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <be25f8ed-996a-5fc5-6bad-348441868761@gmx.com>
Date:   Wed, 18 Dec 2019 10:09:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191218011942.9830-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LanPJVesU/xiJcyWRMZtk80daEWgfrCjRmh9ILqkKkcQ5q9uq0g
 C3dCixVAiR+BxtogbhmjRSiU5khmV2aLK/0HpNfhJ4VdyLjLlNYUzSp+Vu1XFfjtExNb7Om
 qG7LBC9IoWLWB32kPJQE7mn69Uyx+tIWHNgBrH4mC297ZzKZKb6sD9j6XrtJGq6A8DDx70D
 fT75NcrGH1ssK+rgwQZOA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:a352Dgsi2Hg=:q3qdKyXZYzcw96u4aK63EK
 dnXY8GfZhpl9zTw4U1cfrBQB27gURJX3HBtkieRqhAJVbVzCBGU/DVmai9kHSO82HrZ8Da1Mo
 58sD09it51usfwgMrzI3ls7Tt9gCIlC0NRdd1NaYB7mMJGHaknRX6nCgswgqyKrjEHPL3S0dG
 NpwYhwgL1Ul7/29iG8bXmFmijo/xFUQ6NVsWIH7fA6SR0/iDc+hmvFiPvsDkU6oENtpjVPZj4
 OK993fiiaM6Iv9Cre9gdnEE4vG/9X4qSojdXR5FWELXsPFkLzfYr0VU12Wd0vo4UvEhPmrEWC
 zywU2YsrCM9jVZOtj2TeiEZjbGPAq46ZVZpQ51WNg03CwFMP/aPXr2zCF+eTRCY7xrSMwBFwo
 qv82MSckj/pWfr/wGUFO78VceP5HULWFZeVqRVv1DG7AxOeROCKw9Daafv/v8o6VVhcf0spJz
 t3/pYHCP5IZ5c9Al2WvCXFXqc3gvGMSUdP/nN55n66kcESus+69xe4kiNJX07zkHaMShNO7Xd
 ozSkA5u8UXFI6KBj/cupYjyEiaaR3LdlkC0rGyPd3wrpyzDB4yu7dFgPYQrRkQTLL9iEX/Ugs
 2HvostAQHE/tg0yBq5eibYXBfR2go5iGXcOcjAf0Qu3DXmEKtzw5Oum0EkLakIZOMVWfqq/1J
 FUWUtef++sEJ1eSwgqS5UKXq9FEVuqQ6sXiS7ZVV9ie0q4uzsTjrV64OgKxK4Mfl3GGB/I98g
 0AMYi3e5p2vMk7BX6uY4kJv7/XSnWAAWuD/bSn2H6O2uKfkeYrh2kKmT6bkuimtEsrde5ilGL
 vvG/n3KrovvgulFSTd2Pv/p6MeOiM2kcQVbtyb5+IeC/akilJYtCmumQwpxS8ann1Vwes55yR
 LrfLtmRri6bv6IBOWOBGsc4i8+ofX82CYb0bc57wSZITioSRWyVkaGgr11KcIwe+9Ty7MZ81q
 mdPuQuf8w6S5y+usRaZ6s8zTM+O+6xlh13JXY1c9zbtFFt4ZAaqONPUBR1oswuEAExW9uT2R0
 XNx68Z9HL7bYzzmEvLHrvlwHYCSItRwFrKxt0jd3S0xy7L+rPw5dxtxuCDJMKBqkMlV5m5ruO
 xH2ELcB/bytpRf8tzKejCEXzLjEmHW5FZEcUpC8hwh7PFclxUSSJC9xdK3dwuO6ebuvjmgRay
 eg/p9OcKNGk/oQLBBnulfjSZjMNReuikwxhvprUF6ohiFEmoVZ54wDezAE+q3pzmjpjQuCVMd
 ek2RZqH8rOROYIdthk+u8PUKt3EU2nKmqPqi5AnSuvzAh/ahMCZnbLzmiw04=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019/12/18 9:19 AM, Qu Wenruo wrote:
> [BUG]
> For certain fuzzed image, `btrfs check` will fail with the following
> call trace:
>    Checking filesystem on issue_213.raw
>    UUID: 99e50868-0bda-4d89-b0e4-7e8560312ef9
>    [1/7] checking root items
>    [2/7] checking extents
>    Program received signal SIGABRT, Aborted.
>    0x00007ffff7c88f25 in raise () from /usr/lib/libc.so.6
>    (gdb) bt
>    #0  0x00007ffff7c88f25 in raise () from /usr/lib/libc.so.6
>    #1  0x00007ffff7c72897 in abort () from /usr/lib/libc.so.6
>    #2  0x00005555555abc3e in run_next_block (...) at check/main.c:6398
>    #3  0x00005555555b0f36 in deal_root_from_list (...) at check/main.c:8=
408
>    #4  0x00005555555b1a3d in check_chunks_and_extents (fs_info=3D0x55555=
56a1e30) at check/main.c:8690
>    #5  0x00005555555b1e3e in do_check_chunks_and_extents (fs_info=3D0x55=
55556a1e30) a
>    #6  0x00005555555b5710 in cmd_check (cmd=3D0x555555696920 <cmd_struct=
_check>, argc
>    #7  0x0000555555568dc7 in cmd_execute (cmd=3D0x555555696920 <cmd_stru=
ct_check>, ar
>    #8  0x0000555555569713 in main (argc=3D2, argv=3D0x7fffffffde70) at b=
trfs.c:386
>
> [CAUSE]
> This fuzzed images has a corrupted EXTENT_DATA item in data reloc tree:
>          item 1 key (256 EXTENT_DATA 256) itemoff 16111 itemsize 12
>                  generation 0 type 2 (prealloc)
>                  prealloc data disk byte 16777216 nr 0
>                  prealloc data offset 0 nr 0
>
> There are several problems with the item:
> - Bad item size
>    12 is too small.
> - Bad key offset
>    offset of EXTENT_DATA type key represents file offset, which should
>    always be aligned to sector size (4K in this particular case).
>
> [FIX]
> Do extra item size and key offset check for original mode, and remove
> the abort() call in run_next_block().
>
> And to show off how robust lowmem mode is, lowmem can handle it without
> any hiccup.
>
> With this fix, original mode can detect the problem properly:
>    Checking filesystem on issue_213.raw
>    UUID: 99e50868-0bda-4d89-b0e4-7e8560312ef9
>    [1/7] checking root items
>    [2/7] checking extents
>    ERROR: invalid file extent item size, have 12 expect (21, 16283]
>    ERROR: errors found in extent allocation tree or chunk allocation
>    [3/7] checking free space cache
>    [4/7] checking fs roots
>    root 18446744073709551607 root dir 256 error
>    root 18446744073709551607 inode 256 errors 62, no orphan item, odd fi=
le extent, bad file extent
>    ERROR: errors found in fs roots
>    found 131072 bytes used, error(s) found
>    total csum bytes: 0
>    total tree bytes: 131072
>    total fs tree bytes: 32768
>    total extent tree bytes: 16384
>    btree space waste bytes: 124774
>    file data blocks allocated: 0
>     referenced 0
>
> Issue: #213
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Almost fine. Two nitpicks below.
I guess that they could be fixed when merging.

> ---
>   check/main.c | 34 ++++++++++++++++++++++++++++++++--
>   1 file changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/check/main.c b/check/main.c
> index 08dc9e66..91752dce 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -6268,7 +6268,10 @@ static int run_next_block(struct btrfs_root *root=
,
>   		btree_space_waste +=3D btrfs_leaf_free_space(buf);
>   		for (i =3D 0; i < nritems; i++) {
>   			struct btrfs_file_extent_item *fi;
> +			unsigned long inline_offset;
>
> +			inline_offset =3D offsetof(struct btrfs_file_extent_item,
> +						 disk_bytenr);
>   			btrfs_item_key_to_cpu(buf, &key, i);
>   			/*
>   			 * Check key type against the leaf owner.
> @@ -6384,18 +6387,45 @@ static int run_next_block(struct btrfs_root *roo=
t,
>   			}
>   			if (key.type !=3D BTRFS_EXTENT_DATA_KEY)
>   				continue;
> +			/* Check itemsize before we continue*/

One more space at the tail.
> +			if (btrfs_item_size_nr(buf, i) < inline_offset) {
> +				ret =3D -EUCLEAN;
> +				error(
> +		"invalid file extent item size, have %u expect (%lu, %lu]",

should it be "[%llu, %lu)"?

Thanks.
> +					btrfs_item_size_nr(buf, i),
> +					inline_offset,
> +					BTRFS_LEAF_DATA_SIZE(fs_info));
> +				continue;
> +			}
>   			fi =3D btrfs_item_ptr(buf, i,
>   					    struct btrfs_file_extent_item);
>   			if (btrfs_file_extent_type(buf, fi) =3D=3D
>   			    BTRFS_FILE_EXTENT_INLINE)
>   				continue;
> +
> +			/* Prealloc/regular extent must have fixed item size */
> +			if (btrfs_item_size_nr(buf, i) !=3D
> +			    sizeof(struct btrfs_file_extent_item)) {
> +				ret =3D -EUCLEAN;
> +				error(
> +			"invalid file extent item size, have %u expect %zu",
> +					btrfs_item_size_nr(buf, i),
> +					sizeof(struct btrfs_file_extent_item));
> +				continue;
> +			}
> +			/* key.offset (file offset) must be aligned */
> +			if (!IS_ALIGNED(key.offset, fs_info->sectorsize)) {
> +				ret =3D -EUCLEAN;
> +				error(
> +			"invalid file offset, have %llu expect aligned to %u",
> +					key.offset, fs_info->sectorsize);
> +				continue;
> +			}
>   			if (btrfs_file_extent_disk_bytenr(buf, fi) =3D=3D 0)
>   				continue;
>
>   			data_bytes_allocated +=3D
>   				btrfs_file_extent_disk_num_bytes(buf, fi);
> -			if (data_bytes_allocated < root->fs_info->sectorsize)
> -				abort();
>
>   			data_bytes_referenced +=3D
>   				btrfs_file_extent_num_bytes(buf, fi);
>

