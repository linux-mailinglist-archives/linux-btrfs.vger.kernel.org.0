Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9D188A43
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Aug 2019 11:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfHJJY1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Aug 2019 05:24:27 -0400
Received: from mout.gmx.net ([212.227.15.19]:60565 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbfHJJY1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Aug 2019 05:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565429060;
        bh=Kya5KmW161R0ka+T/hgWRA0WuFKKnVLo51WIUTsPTIA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Q8Gr2+WSTtxcbc9sHHjPsfcOoMa6V+rsipWxEL5cHDSnZqyjATiMGvw0f12i287nK
         E6T8Xi5jANX728GRQyAVD0rMsTFk195Yt58MeOabHntHrEUSBmVRDFGhyqBAG4aWK+
         +8SHsGwulx05ntl/9kgDxAe/EWkIC9bthZUo8LcA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M6Ue3-1hyrWM3Nij-006z1i; Sat, 10
 Aug 2019 11:24:20 +0200
Subject: Re: [PATCH 1/3] btrfs-progs: check/lowmem: Check and repair root
 generation
To:     Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20190809065320.22702-1-wqu@suse.com>
 <20190809065320.22702-2-wqu@suse.com>
 <4e94c953-2ecb-8941-1b1c-d1a2dd6a080e@suse.com>
 <f7d26a1d-1f16-64c1-1f08-dc4494c27b8c@gmx.com>
 <d5d32957-5328-9886-c491-c57c2dcc1846@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <e396da5b-8ae7-fc1d-5381-d0b3138bdfba@gmx.com>
Date:   Sat, 10 Aug 2019 17:24:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d5d32957-5328-9886-c491-c57c2dcc1846@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rM8EFpcCVipeYQNk4LP7wnz6mCmlst7uCISp1rWwCPZzw4v849T
 jRhH7tPNgxOfEiuguviCpuzQrBvhxbabJG66KI81AY0zDXgsyr4AHQI+vmnN3TKTaEylF1P
 jOwwWpQdCX5fKfoLV0pJh+fbmAdDJA+OvvvpsA5IATR+ZjYvB9QXNryVlvVbisQGe1teThu
 xXB09fbX7nvzvenuPSz/Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:90RxC3IggeQ=:HR478KAxJLBwLfGsCydxex
 VZ1gTl/teihcPHscjfaqegm8gHC0P0G/at5YyeaO2jtp3O2mHRIMLjIYMtmzhXCcEwZocmc+G
 uQl1ubdvSx+Z8HmXvILG1HpTPAh0M1w+YaGtWzjFSaXPXsS/FtTY23AoOGgSKlKfHUVlUnmdG
 fRBRLcbqWXfR6EeJXUrGbJA/I4gnNP5PTakgOGoR9hTLo43rIKVJDF5zRMaT0+G2sv1/cebJS
 PsU9du4aYAZRgemsu7YtieLWVPxY7ZgZOX84pumTCcNwltm7z/f++yNNDleMPXELjrzPceb7L
 0ZHbf0MZi82ydIZvDkZUiXF1cNCvY0pU3I2vbVoRB56wti78TIayTOgykRDBCHsOTvIGTApa5
 teu3KVCc1EvotfwS/z+tHN/Uvz0ct1XBuNuft9HhV6ulpXAtNKNSrfv//6EyReM9sXTz9vHhe
 FIm5gldYOn9i9G20X+5BVfirhBCMhTWjyBw9odf7aV15Ba6xa8ZpnuriA/wdCGgHCYIBrzeaC
 qqXlTtp04AUCHz/oIX017InGJRTHe9KqI9y/IrRE8V/q0zGozrXUG2MQzpTGtbE0bCpmmrabY
 GiPyDz+lpfnJagF4WzexRcH8NRLaTxFRaWVWKklrC01yhuK9EsOO1E7loAFtMlj/VcWCqcSii
 2MyZZ5lvp4vp8ZSsqsrv880MGsM432nFyIH3UdN7DnP2QOvs9/oUt+VbRM/Hkom3Cq35MMae9
 41LkrXs3j2+i4/9NIZGcDqhHtIUvJDSVM3eelaJjBrCQdovldjTHfFfrO06EAWVgbvk6cSwhO
 zZ41T7X3PQ4wt76I/9Gf1UlKRCwFLixQHDGYcYUZK7JCa5JJGZNusT7ybD+LI9QTmqX9x5Hs5
 CgqWW2SpS++WDaf4XuXKh87PP0Yngf+DqZN2iBgBZXeGe//c4YzPT2TLcVwX1yR5yJvFVGxC4
 K/p2D6IJV6tg6q730PGSWe3bEG01tH5WJJgWCedtLhXVNqyaEhw45V3+3lL3pium/ISndnGuJ
 q8LB3KES2HKIEN1YPMMJsTqEJuyRy948dFycoeAxPLeeNSaF1Dc//reX//FBPseRKdtZJDBp+
 ooodY53k3NqBQps3PiuHMjIdJlZrrUOFL5tyhVS0pkZ1dhnClvzjtq+zsIWX6f+WZuBwzXHLV
 3ro3I=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


[...]
>>
>> Because we have extra transid check in
>> btrfs_search_slot()/btrfs_cow_block().
>>
>> EXTENT_BAD_TRANSID is to suppress such warning.
>
> nod
>
>>
>>>
>>> So repair_root_generation could possibly be as simple as just linking
>>> root->node to the fs_info->recow_ebs and leave the rest to the existin=
g
>>> logic?
>>
>> It doesn't change the root generation.
>
> recow_extent_buffer seems to be doing exactly the same thing
> repair_root_generation does - findw the root item and commits the
> transaction. What am I missing?

The way it gets the root is not correct.

Using header owner is not good enough for locating the tree owning the
tree blocks.

Cases like log trees and shared tree blocks (especially for cases like
original tree got deleted) are the main corner cases where the old
behavior can't handle.

Thanks,
Qu

>
>>
>>>
>>>> +
>>>> +	ret =3D btrfs_search_slot(trans, root, &key, &path, 0, 1);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	btrfs_release_path(&path);
>>>> +	ret =3D btrfs_commit_transaction(trans, root);
>>>> +	return ret;
>>>> +}
>>>> diff --git a/check/mode-common.h b/check/mode-common.h
>>>> index 4c169c6e3b29..4a3abeb02c81 100644
>>>> --- a/check/mode-common.h
>>>> +++ b/check/mode-common.h
>>>> @@ -155,4 +155,5 @@ static inline bool is_valid_imode(u32 imode)
>>>>  	return true;
>>>>  }
>>>>
>>>> +int repair_root_generation(struct btrfs_root *root);
>>>>  #endif
>>>> diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
>>>> index a2be0e6d7034..bf3b57f5ad2d 100644
>>>> --- a/check/mode-lowmem.c
>>>> +++ b/check/mode-lowmem.c
>>>> @@ -4957,6 +4957,7 @@ static int check_btrfs_root(struct btrfs_root *=
root, int check_all)
>>>>  	struct btrfs_path path;
>>>>  	struct node_refs nrefs;
>>>>  	struct btrfs_root_item *root_item =3D &root->root_item;
>>>> +	u64 super_generation =3D btrfs_super_generation(root->fs_info->supe=
r_copy);
>>>>  	int ret;
>>>>  	int level;
>>>>  	int err =3D 0;
>>>> @@ -4978,6 +4979,21 @@ static int check_btrfs_root(struct btrfs_root =
*root, int check_all)
>>>>  	level =3D btrfs_header_level(root->node);
>>>>  	btrfs_init_path(&path);
>>>>
>>>> +	if (btrfs_root_generation(root_item) > super_generation + 1) {
>>>> +		error(
>>>> +	"invalid root generation for root %llu, have %llu expect (0, %llu)"=
,
>>>> +		      root->root_key.objectid, btrfs_root_generation(root_item),
>>>> +		      super_generation + 1);
>>>> +		err |=3D INVALID_GENERATION;
>>>> +		if (repair) {
>>>> +			ret =3D repair_root_generation(root);
>>>> +			if (!ret) {
>>>> +				err &=3D ~INVALID_GENERATION;
>>>> +				printf("Reset generation for root %llu\n",
>>>> +					root->root_key.objectid);
>>>> +			}
>>>> +		}
>>>> +	}
>>>>  	if (btrfs_root_refs(root_item) > 0 ||
>>>>  	    btrfs_disk_key_objectid(&root_item->drop_progress) =3D=3D 0) {
>>>>  		path.nodes[level] =3D root->node;
>>>> diff --git a/check/mode-lowmem.h b/check/mode-lowmem.h
>>>> index d2983fd12eb4..0361fb3382b1 100644
>>>> --- a/check/mode-lowmem.h
>>>> +++ b/check/mode-lowmem.h
>>>> @@ -47,6 +47,7 @@
>>>>  #define INODE_FLAGS_ERROR	(1<<23) /* Invalid inode flags */
>>>>  #define DIR_ITEM_HASH_MISMATCH	(1<<24) /* Dir item hash mismatch */
>>>>  #define INODE_MODE_ERROR	(1<<25) /* Bad inode mode */
>>>> +#define INVALID_GENERATION	(1<<26)	/* Generation is too new */
>>>>
>>>>  /*
>>>>   * Error bit for low memory mode check.
>>>>
>>
