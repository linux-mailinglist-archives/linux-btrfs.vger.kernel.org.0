Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 104A689704
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2019 07:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfHLF6F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Aug 2019 01:58:05 -0400
Received: from mout.gmx.net ([212.227.17.21]:49335 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfHLF6F (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Aug 2019 01:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565589458;
        bh=vJvDVXlA3+zppmlYohEBvxnesIdjmjfvvH3c4qcsi84=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=jLMhaD7cGPK0WCqT4m2x9QuF2i3wuE9ykB4G0YXKh6xAfS6xui06HVjuncaNLdEpb
         dpjLUIg3FtdIJhlkUMrdwPwmSvptkwsfWO29SJByFatyhorlsMJzqQ4wDsndMf/xf9
         /HcBiViu2fKu6R3oQOMF4sig3tMqtojct4N+sFfE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1po0-1hzFCD0XIe-002GXG; Mon, 12
 Aug 2019 07:57:38 +0200
Subject: Re: [PATCH 1/3] btrfs-progs: check/lowmem: Check and repair root
 generation
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20190809065320.22702-1-wqu@suse.com>
 <20190809065320.22702-2-wqu@suse.com>
 <4e94c953-2ecb-8941-1b1c-d1a2dd6a080e@suse.com>
 <f7d26a1d-1f16-64c1-1f08-dc4494c27b8c@gmx.com>
 <d5d32957-5328-9886-c491-c57c2dcc1846@suse.com>
 <e396da5b-8ae7-fc1d-5381-d0b3138bdfba@gmx.com>
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
Message-ID: <105ec15f-e1ec-82c0-0e34-6681be1d4fde@gmx.com>
Date:   Mon, 12 Aug 2019 13:57:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e396da5b-8ae7-fc1d-5381-d0b3138bdfba@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:baGql3eqJ77QIZ7HV3L5uJoMK1LpBzk4VLpSElpadL1ARotgavX
 B3pqZctu4LTkNWOit77eNpKcwIXPUaOGE8/1Q8+yhT3f6TRHzPP0cU2+Mp+GlueJxm/l/k2
 g+KfTLby0jQieayq9zYvdT/ITTJHAlGrpQNh+EeC20uS3f2b7lOWykGdn1/Y4QKbu7QRNsW
 IedJECppdVYdQlAufW3aw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NmVNAmz75FM=:gGs4T2tLV8uNCwbXgrlgmx
 b7tpcODALQC+oLcxCB5swuin+28r34bn4Nk1WBlvdnvB2zX1oovcWxJwjnnDvD4YukQCd4tyC
 wC5OR70+YrHYyXv2MWJ3zJBLEZzEu70Db4NEs9/Qx8w7RycDNVtA6UbO8IMgbNr4ZFG2KOjF5
 2vFj0VACEXFwWC+p37gwAeT7Fqa6BOB6uug9okyCrYGgNXTSSG4ZFa0JJ3BFeeWOzV/+6somR
 nxSAwhZsk13fEk5yX3LZuexmZqXp8nBKcFaps5qkhrAEnRRJtfXK5kY1+QBBq2LsxPrUBZaO2
 WtW9zKGbH5Go+ihdwzpXHoxjOpHTOFiu3KZyRp61M1Y6pt8HKGAo4oSfzKeOS+vPQILh56grw
 VACDk8m/dobM66eTjMkAXfiex7CUGALmE9TD0EU4fOrD72sRwF272oTBcwf6ztrDATdWc+Z5/
 p2l36njTI9Y7fQoXNgH83qaF3rY3SR/XoiOH0jdheffzYURQS/1hTIqEceoDRAOQcMrtAdOs7
 hqIfN9ECQefLUzhobZAHjORu0ZwGdTMds/Wvvz0JFTq+Ga/AOGJjKQf7lAae/k4i5qiyR40I0
 81cGx8jAaJSN/BfK21vNbgvVubaTq1FIuZSgBvBk7PilgpKAPC/8dg0zemJ/WpWvtteugvhJY
 yyiDkuqcY0M64I9CDpaZOxoCIsXfynFcIWJ9agbTkFVNMC3/JzKM+PGKOffrk1rU4/6GUB7qr
 ZNhNWYP+NKER/gtek/XPj/UvXXlVZ+gOrQur0cBva0KMFNgRNTpqms3k8bjuEG4t9IO8TYSEK
 NTEkmFn1AzCNQt3uv1T2KNUdyskvLlAs7h/8lrvE2pUIDL1qoudOq+cIk6LXrfgLQcuCgu0Q7
 QbuS58oHtj+GQAd2iz3LpfVTvNHU58c/X0KTqaQM5tvmkS2107ggpmVaOr1PKbFn7CNxsB/Lg
 lmHZROQqrjtEEn3BKLxdATOEit3folQx9EvLoXL4EX1DsUOe1c2c/AsKfdE5HKZNc+QWSZxBv
 6hoq8/Jx1WU7wfevRX+HrO7K8OpGPVjAPwrnslLOJGJdJiXVrRHAKyyy9swuQMuV+4oEFt4JV
 CiWLpAZDD5aajYaQ7Ob74sOIld0RKoJPyHGYQccCz8qIuHEsDJi0IZGmSLkZg0LADO0wRzUMX
 qcEh4=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/8/10 =E4=B8=8B=E5=8D=885:24, Qu Wenruo wrote:
>
> [...]
>>>
>>> Because we have extra transid check in
>>> btrfs_search_slot()/btrfs_cow_block().
>>>
>>> EXTENT_BAD_TRANSID is to suppress such warning.
>>
>> nod
>>
>>>
>>>>
>>>> So repair_root_generation could possibly be as simple as just linking
>>>> root->node to the fs_info->recow_ebs and leave the rest to the existi=
ng
>>>> logic?
>>>
>>> It doesn't change the root generation.
>>
>> recow_extent_buffer seems to be doing exactly the same thing
>> repair_root_generation does - findw the root item and commits the
>> transaction. What am I missing?
>
> The way it gets the root is not correct.
>
> Using header owner is not good enough for locating the tree owning the
> tree blocks.
>
> Cases like log trees and shared tree blocks (especially for cases like
> original tree got deleted) are the main corner cases where the old
> behavior can't handle.

My bad, in fact log tree won't exist in repair mode, and since it's the
tree root node, it won't be shared with other trees, so the existing
facility is completely fine with the use case.

Thanks for pointing this out!
Qu

>
> Thanks,
> Qu
>
>>
>>>
>>>>
>>>>> +
>>>>> +	ret =3D btrfs_search_slot(trans, root, &key, &path, 0, 1);
>>>>> +	if (ret < 0)
>>>>> +		return ret;
>>>>> +
>>>>> +	btrfs_release_path(&path);
>>>>> +	ret =3D btrfs_commit_transaction(trans, root);
>>>>> +	return ret;
>>>>> +}
>>>>> diff --git a/check/mode-common.h b/check/mode-common.h
>>>>> index 4c169c6e3b29..4a3abeb02c81 100644
>>>>> --- a/check/mode-common.h
>>>>> +++ b/check/mode-common.h
>>>>> @@ -155,4 +155,5 @@ static inline bool is_valid_imode(u32 imode)
>>>>>  	return true;
>>>>>  }
>>>>>
>>>>> +int repair_root_generation(struct btrfs_root *root);
>>>>>  #endif
>>>>> diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
>>>>> index a2be0e6d7034..bf3b57f5ad2d 100644
>>>>> --- a/check/mode-lowmem.c
>>>>> +++ b/check/mode-lowmem.c
>>>>> @@ -4957,6 +4957,7 @@ static int check_btrfs_root(struct btrfs_root =
*root, int check_all)
>>>>>  	struct btrfs_path path;
>>>>>  	struct node_refs nrefs;
>>>>>  	struct btrfs_root_item *root_item =3D &root->root_item;
>>>>> +	u64 super_generation =3D btrfs_super_generation(root->fs_info->sup=
er_copy);
>>>>>  	int ret;
>>>>>  	int level;
>>>>>  	int err =3D 0;
>>>>> @@ -4978,6 +4979,21 @@ static int check_btrfs_root(struct btrfs_root=
 *root, int check_all)
>>>>>  	level =3D btrfs_header_level(root->node);
>>>>>  	btrfs_init_path(&path);
>>>>>
>>>>> +	if (btrfs_root_generation(root_item) > super_generation + 1) {
>>>>> +		error(
>>>>> +	"invalid root generation for root %llu, have %llu expect (0, %llu)=
",
>>>>> +		      root->root_key.objectid, btrfs_root_generation(root_item),
>>>>> +		      super_generation + 1);
>>>>> +		err |=3D INVALID_GENERATION;
>>>>> +		if (repair) {
>>>>> +			ret =3D repair_root_generation(root);
>>>>> +			if (!ret) {
>>>>> +				err &=3D ~INVALID_GENERATION;
>>>>> +				printf("Reset generation for root %llu\n",
>>>>> +					root->root_key.objectid);
>>>>> +			}
>>>>> +		}
>>>>> +	}
>>>>>  	if (btrfs_root_refs(root_item) > 0 ||
>>>>>  	    btrfs_disk_key_objectid(&root_item->drop_progress) =3D=3D 0) {
>>>>>  		path.nodes[level] =3D root->node;
>>>>> diff --git a/check/mode-lowmem.h b/check/mode-lowmem.h
>>>>> index d2983fd12eb4..0361fb3382b1 100644
>>>>> --- a/check/mode-lowmem.h
>>>>> +++ b/check/mode-lowmem.h
>>>>> @@ -47,6 +47,7 @@
>>>>>  #define INODE_FLAGS_ERROR	(1<<23) /* Invalid inode flags */
>>>>>  #define DIR_ITEM_HASH_MISMATCH	(1<<24) /* Dir item hash mismatch */
>>>>>  #define INODE_MODE_ERROR	(1<<25) /* Bad inode mode */
>>>>> +#define INVALID_GENERATION	(1<<26)	/* Generation is too new */
>>>>>
>>>>>  /*
>>>>>   * Error bit for low memory mode check.
>>>>>
>>>
