Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB67D183EA9
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 02:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgCMB2F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Mar 2020 21:28:05 -0400
Received: from mout.gmx.net ([212.227.15.18]:51777 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbgCMB2F (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Mar 2020 21:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584062876;
        bh=D0d/Mhv7D0tOHNKZNfN3TxJsAozQbusE8RyPrhm0yt4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=dYJ8NOlK9aJdOMTlHQnEZdWCiWH9azA2YFU0gmgQzDE5C8PYTk3izjPMGamAa4Bfk
         Y4VkUKlwoKFobfcoMA7Y4R0xpkSTg+reiNckKAxmBAUVbVIcA54dtk8VhpXZUn+8LO
         0McqQp7QRDIKt4QZPiGsGxnB4ewGJKHTXF1IBlo8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MZTmO-1ir2OT0BLq-00WSJ0; Fri, 13
 Mar 2020 02:27:56 +0100
Subject: Re: [PATCH] btrfs: relocation: Use btrfs_find_all_leaves() to locate
 parent tree leaves of a data extent
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200310081415.49080-1-wqu@suse.com>
 <20200312204832.GK12659@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <475fc59c-3c71-60ca-4f87-a33319e53233@gmx.com>
Date:   Fri, 13 Mar 2020 09:27:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312204832.GK12659@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0vyZlu9eGxT2rMQZqsTdpdWsXM21bSpRO"
X-Provags-ID: V03:K1:sZMTN4B4MLZuTwCuzhCTcsQ42pUdBa2KGjEcPxIU2KN4ac69oaA
 F6wPWjSL4shtdvguePNC6ILaBfpuT4eD+V/UfdCWNJdLEIflvhLj8SUbxGHPRE4jUChO6Xd
 S6mJhWMxjYthAO7F7QbQSqZuSbkK2Uj26+WAgzi9qm6O36Lx3/M6ZpL6XnwXEaeaa5iJigC
 36Z7GKyLzpouiwaj6F2CA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ga94HiBBZOI=:saokYRqFRf0ipegeCycPDh
 pcHUcWtL4wHMi6c7p8lNp/RkVgZ5v0UPCOPLLcoR7XEptsuXWdT89aDZ0G2b+kJfLKa7aCLNZ
 J1PX7gX1qQNC56n0gJ9iEAobLrp5RGl+IfLd62jZI04XF0HYO2Ohe55TOnGCuSQwo8O6LVXJp
 cbmWuCZYMyeXDsUljUXy/uPYMPbQzOQ8ZEiZGMWaeDJZpuvzNMwsMhP3pnbbA/val/JRmrv1Y
 Lu/VhO3xcA67fvIBf95hOqyJuUnT1WujSPi3Bpfth5CFGQ9jVD8NzHns/mw45RhQ+vgsSyoJ1
 tguCMXeUnSW7Sje6PFkyStTAvGRnvVxswJA0KPZfeVOxG6gIT2r7S/q3NklYXxzW7lJCKfwWT
 IQdWQLSXqHnQMUHrXT9NlusDNJV3sQHu0XqhR+oMC5AWMfQQVKeeMoo2/ZiTTEm1N1/gMOC2M
 M0Qu61aqEBwVvVzMTrdpOKksoFjOfIM8OrOTiBXifM/sHvz8HF8neOZ6uU7vyEUbksr/fdAQp
 TJTfWj1jimZhd5HB6m3Lf3NVkB9VefbPu84XuGOkmipC5efJRgz6XiWFif/AhxF/kO9jm9MIZ
 72Czy2Vf019MIwAJXbGfhZyjfSiWmS0m/d1cuv2w2IeDKgvtrg+7yuLmH42CaJ9wYPlO/2yda
 M7KYvCGsyW7/W5auNIffwmiJQPAGuqaWa0CSHMida2OWnag3SBRUP+R0yeKu5JnEaJJ8kkK9A
 T1llwAnwncQEAB9pLOhKVH2hCYuMpOi4MPdNCmArXjngEGdBF8pgF7omjrJfKp6rbt7U9JZs1
 ck1GS2z6xu9bdsD0w4MJDoz0lL/BIPpTyXKYLk1tc7DhsROBqitOzm/BIAfxEatl64OGF+MM0
 1Vw7YIJOV62an+JFA1h1Zfih5VajLrOi4CvkLNVEo0uAJ53GnnGQ/4s0V3ikM+H0bWg27u0N9
 blyDKdjl3MoGJBSYcpOC1aKDeA+aIvoPc6hFbmxRj+DGHdRhu/NXdkGx+K0uZ24CC3GLIbmUz
 AKK/Gq7stA49NjDW1X7yaInEQNZUeu2eicDZcx4RWVg5yU65aJnw5N51asZBsrw3n10p5IHn9
 y4a0bGk/XAkxqZUl5Etevpyh10QqoUxOep6sjE1WeZ2uMkVxV6xH+HrylUZ73CEneYdTXrdyk
 HNekyyK8xN5mOtAk+wAobVyWd6XNSDPAffF4qfYi4aMZ61DVNEB4st6RoMEnqfHFeALiiw9nH
 kDOuYT92D+HeapGR1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0vyZlu9eGxT2rMQZqsTdpdWsXM21bSpRO
Content-Type: multipart/mixed; boundary="cdTzE4GFbxItUSgIGfFteHgO6fMVo1fPI"

--cdTzE4GFbxItUSgIGfFteHgO6fMVo1fPI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/13 =E4=B8=8A=E5=8D=884:48, David Sterba wrote:
> On Tue, Mar 10, 2020 at 04:14:15PM +0800, Qu Wenruo wrote:
>> In relocation, we need to locate all parent tree leaves referring one
>> data extent, thus we have a complex mechanism to iterate throught exte=
nt
>> tree and subvolume trees to locate related leaves.
>>
>> However this is already done in backref.c, we have
>> btrfs_find_all_leaves(), which can return a ulist containing all leave=
s
>> referring to that data extent.
>>
>> Use btrfs_find_all_leaves() to replace find_data_references().
>       ^^^^^^^^^^J^^^^^^^^^^
>=20
> The function is called btrfs_find_all_leafs, which is wrong spelling of=

> leaves, I was tempted to rename it in the same patch but unfortunately
> ther's one more untouched caller so it's for another one.

Mind me to send the spelling fix?

>=20
>> There is a special handling for v1 space cache data extents, where we
>> need to delete the v1 space cache data extents, to avoid those data
>> extents to hang the data relocation.
>>
>> In this patch, the special handling is done by re-iterating the root
>> tree leaf.
>> Although it's a little less efficient than the old handling, consideri=
ng
>> we can reuse a lot of code, it should be acceptable.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> This patch is originally in my backref cache branch, but since it's
>> pretty independent from other backref cache code, and straightforward =
to
>> test/review, it's sent for more comprehensive test/review/merge.
>> ---
>>  fs/btrfs/backref.c    |   8 +-
>>  fs/btrfs/backref.h    |   4 +
>>  fs/btrfs/relocation.c | 314 ++++++++---------------------------------=
-
>>  3 files changed, 62 insertions(+), 264 deletions(-)
>>
>> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
>> index 327e4480957b..f2728fb3ee8f 100644
>> --- a/fs/btrfs/backref.c
>> +++ b/fs/btrfs/backref.c
>> @@ -1409,10 +1409,10 @@ static void free_leaf_list(struct ulist *block=
s)
>>   *
>>   * returns 0 on success, <0 on error
>>   */
>> -static int btrfs_find_all_leafs(struct btrfs_trans_handle *trans,
>> -				struct btrfs_fs_info *fs_info, u64 bytenr,
>> -				u64 time_seq, struct ulist **leafs,
>> -				const u64 *extent_item_pos, bool ignore_offset)
>> +int btrfs_find_all_leafs(struct btrfs_trans_handle *trans,
>> +			 struct btrfs_fs_info *fs_info, u64 bytenr,
>> +			 u64 time_seq, struct ulist **leafs,
>> +			 const u64 *extent_item_pos, bool ignore_offset)
>>  {
>>  	int ret;
>> =20
>> diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
>> index 777f61dc081e..723d6da99114 100644
>> --- a/fs/btrfs/backref.h
>> +++ b/fs/btrfs/backref.h
>> @@ -40,6 +40,10 @@ int iterate_inodes_from_logical(u64 logical, struct=
 btrfs_fs_info *fs_info,
>> =20
>>  int paths_from_inode(u64 inum, struct inode_fs_paths *ipath);
>> =20
>> +int btrfs_find_all_leafs(struct btrfs_trans_handle *trans,
>> +			 struct btrfs_fs_info *fs_info, u64 bytenr,
>> +			 u64 time_seq, struct ulist **leafs,
>> +			 const u64 *extent_item_pos, bool ignore_offset);
>>  int btrfs_find_all_roots(struct btrfs_trans_handle *trans,
>>  			 struct btrfs_fs_info *fs_info, u64 bytenr,
>>  			 u64 time_seq, struct ulist **roots, bool ignore_offset);
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index 02afe294ee2d..319d50c7ada5 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -23,6 +23,7 @@
>>  #include "print-tree.h"
>>  #include "delalloc-space.h"
>>  #include "block-group.h"
>> +#include "backref.h"
>> =20
>>  /*
>>   * Relocation overview
>> @@ -3620,31 +3621,6 @@ static int __add_tree_block(struct reloc_contro=
l *rc,
>>  	return ret;
>>  }
>> =20
>> -/*
>> - * helper to check if the block use full backrefs for pointers in it
>> - */
>> -static int block_use_full_backref(struct reloc_control *rc,
>> -				  struct extent_buffer *eb)
>> -{
>> -	u64 flags;
>> -	int ret;
>> -
>> -	if (btrfs_header_flag(eb, BTRFS_HEADER_FLAG_RELOC) ||
>> -	    btrfs_header_backref_rev(eb) < BTRFS_MIXED_BACKREF_REV)
>> -		return 1;
>> -
>> -	ret =3D btrfs_lookup_extent_info(NULL, rc->extent_root->fs_info,
>> -				       eb->start, btrfs_header_level(eb), 1,
>> -				       NULL, &flags);
>> -	BUG_ON(ret);
>> -
>> -	if (flags & BTRFS_BLOCK_FLAG_FULL_BACKREF)
>> -		ret =3D 1;
>> -	else
>> -		ret =3D 0;
>> -	return ret;
>> -}
>> -
>>  static int delete_block_group_cache(struct btrfs_fs_info *fs_info,
>>  				    struct btrfs_block_group *block_group,
>>  				    struct inode *inode,
>> @@ -3688,174 +3664,42 @@ static int delete_block_group_cache(struct bt=
rfs_fs_info *fs_info,
>>  }
>> =20
>>  /*
>> - * helper to add tree blocks for backref of type BTRFS_EXTENT_DATA_RE=
F_KEY
>> - * this function scans fs tree to find blocks reference the data exte=
nt
>> + * Helper function to locate the free space cache EXTENT_DATA in root=
 tree leaf
>> + * and delete the cache inode, to avoid free space cache data extent =
blocking
>> + * data relocation.
>>   */
>> -static int find_data_references(struct reloc_control *rc,
>> -				struct btrfs_key *extent_key,
>> -				struct extent_buffer *leaf,
>> -				struct btrfs_extent_data_ref *ref,
>> -				struct rb_root *blocks)
>> +static int delete_v1_space_cache(struct btrfs_fs_info *fs_info,
>> +				 struct extent_buffer *leaf,
>=20
> The fs_info seems to be redundant, so I've replaced it with
> leaf->fs_info here

Oh, right. Always forgot that eb::fs_info member.

Thanks,
Qu
>=20
>> +	ret =3D delete_block_group_cache(fs_info, block_group, NULL,
>> +					space_cache_ino);
>> +	return ret;
>>  }


--cdTzE4GFbxItUSgIGfFteHgO6fMVo1fPI--

--0vyZlu9eGxT2rMQZqsTdpdWsXM21bSpRO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5q4ZcACgkQwj2R86El
/qg+XQf/a9C/mnKeRHlGnbnmWBZs6sEAE1kqqAUVIn9y5WAs5+QETRLPr45Uyobp
DSDdHOVCfTQ7Sxwg4TlnTPL7qnbw8+rtNOqbg3L7n+qxmhTEIbb7a5oH320ByVkR
ZxEPstB14QPfAMrr9CecwXLOSXSvILDj8HAC0vOR6bD+XUw+nz8dEZLdHANvlMWE
tqGZgzaylXXft9XmAN9B33p8XLd1Iqr4gFHh1hbaTFKPyC1E5AfjjL6d+u0mMBZf
J8pgxRnsPXIR+tJAAfukn6xurlxfynB8DLJXHGzkjK3gY2HEKP5HhIZvSypkj7Ua
+W6+7D+a1jCWLIBkKmfHGJSB9KqDow==
=Y9A4
-----END PGP SIGNATURE-----

--0vyZlu9eGxT2rMQZqsTdpdWsXM21bSpRO--
