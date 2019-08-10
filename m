Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D222C8875A
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Aug 2019 02:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfHJAbF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Aug 2019 20:31:05 -0400
Received: from mout.gmx.net ([212.227.15.19]:33063 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfHJAbF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 9 Aug 2019 20:31:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565397058;
        bh=eZBYf9q4IgaFH7REMN2IOMRMdW518DE1/axo6x4NaiE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=YMZcuzPEabTRH7L6Z90/QN8LyI3xtmAMaozM0cWsSvesYrdTJ8rDh6rrZjX80Ylj2
         DHlxSdcIby7YeCbXkxKRl896KL62wbM2SiKPcz+ol7Bvb+DrCe7PvjBuZqv9kvdvij
         gXM9pVOselIjG3ECzGBLmxFlM0IoXIxZuDdBL9u4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MQvCv-1hhjLK1kF5-00NyBH; Sat, 10
 Aug 2019 02:30:58 +0200
Subject: Re: [PATCH 1/3] btrfs-progs: check/lowmem: Check and repair root
 generation
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190809065320.22702-1-wqu@suse.com>
 <20190809065320.22702-2-wqu@suse.com>
 <4e94c953-2ecb-8941-1b1c-d1a2dd6a080e@suse.com>
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
Message-ID: <f7d26a1d-1f16-64c1-1f08-dc4494c27b8c@gmx.com>
Date:   Sat, 10 Aug 2019 08:30:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4e94c953-2ecb-8941-1b1c-d1a2dd6a080e@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UyxmszQ3kQXCjEjnkUo4ZnHaNuEYBeOAeqIZzB3I8x1WSDyZ5IL
 kxEnjc+6W4CBF9HFWQdNIFMmT0W9yqq4BBWfbC1trdoHQaUHhHcTjj9U1SvN9LzZ2ewTJ2q
 ZWNw2p9rOh5tzSIgmRkdqCvgaRBMrMKgloaRa7ZRwjuBQAvp2jto9RtFaZSl/1z1swmYuE8
 tIQhDthTHS4AURu68e0/g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xzUFTMsiics=:7k0YAnNb996NWZhY6qFtnV
 2wfCvZhJr+o5FbSg2UbsJ6cvaCyuTWrQR3CH7ntZFW2wvAd2wt9MlemB81etMHhyR/ZkTy1bB
 ZBAZ8KDbzeawDXisyrOwPyBNiTcwS/F104LV2JC8aQ/Dxy9a+T1tKEWxBFwtNSFW2MzWThy0o
 IcxOcYV/5WXQqEsM+5R/2/G2D4kJfFc0hP3EC+oxz4xDy0L7g+5wERkZU39MKL/sIJhM/+MwF
 Eixi1z7fpBWlJkl2wLjGQw/V6AQG0oBi8RTnWg4LNWGBiwasXqayf/jt9DFK9mz+0vbtAYYlc
 dyQ+5+u0xgChrg2FEnyZv+WQcon1MCM1jcDo8sGjloCAghtKDh/jN0ANTy9nGu8SECFCD85Qg
 V7i74Y/SVwKhaCaosRLLYXe0O7yk3VD7zi71sYe/1uLSTY+7Ic2tVkfx3MlNpmZewaSp3lQFp
 +FbTQ5k/0J+LDosvMuSdAS9EKV87q0U8XxphpOwczrfIOcxg9LlQxKM9zgxzFvlynvb4BHGH5
 AJl6wfGHHV8CWFhPGgD8DmtKqIf7tcBwaz5k33cY6wkhJ4esaq6D1AKDSPnmH+haP++Ai46XV
 JWjwPzysi0wja00qS4Fj38MCGSy3ynvKhd9hNq6T0gnyD0wj/dBixOL+VdCfRAxv3bcLuZpg4
 LiM/eu1rqOFO7V4w+sdMj7Kisgp5rH14w4ReN3xad01lEHQH9zLIb/lHQ55lVqxZ/4/DQIKef
 m68uQ2uWbAv4d+o22eq19gx4qhE7qEqs7TfdIZ8Y5mzn1dVOuzgibLDb6fKE5zkPX1RgRKoSU
 zadqSoxGwxQNATVRpBlQnSYhlG6OvVKxKEmgKa3cATKLqGGazi9oQh8gWmRJimWSBG0MwNL6c
 mOJegeri9DOwYQFoft9Pf7Qc6S1AAP9QzPGBOZ07tB56fdQLwVepisCj1Q0BQDvwxh8EFt0uc
 BuQwOP6xhHL4bYWZg8cAi7NCPadJyQn/l+yQrK8su0xE+FdAW2wM5OLf0voIP50ldQNZsmW+g
 j8qxjKL8c4JM7d9FBp/5LKVmMwvRIUxS2EsCrHKqscfH+6X4W0Mwv/83gEYC6bgYjfPbzrh6L
 5pj63SaOJdO+QvwaYBuFztSnkfs1/VZE4K8zM5OIimIS+MpM9pNlig61OfQqxO8Vg9Ftvlk/S
 KJj6I=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/8/10 =E4=B8=8A=E5=8D=8812:10, Nikolay Borisov wrote:
>
>
> On 9.08.19 =D0=B3. 9:53 =D1=87., Qu Wenruo wrote:
>> Since kernel is going to reject any root item which is newer than super
>> block generation, we need to provide a way to fix such problem in
>> btrfs-check.
>>
>> This patch addes the ability to report and repair root generation in
>> lowmem mode.
>>
>> This is done by cowing the root node, so we will update the root
>> generation along with the root node generation at commit transaction
>> time.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  check/mode-common.c | 29 +++++++++++++++++++++++++++++
>>  check/mode-common.h |  1 +
>>  check/mode-lowmem.c | 16 ++++++++++++++++
>>  check/mode-lowmem.h |  1 +
>>  4 files changed, 47 insertions(+)
>>
>> diff --git a/check/mode-common.c b/check/mode-common.c
>> index d5f6c8ef97b1..a5b86a0ac32a 100644
>> --- a/check/mode-common.c
>> +++ b/check/mode-common.c
>> @@ -924,3 +924,32 @@ int check_repair_free_space_inode(struct btrfs_fs_=
info *fs_info,
>>  	}
>>  	return ret;
>>  }
>> +
>> +int repair_root_generation(struct btrfs_root *root)
>> +{
>> +	struct btrfs_trans_handle *trans;
>> +	struct btrfs_path path;
>> +	struct btrfs_key key;
>> +	int ret;
>> +
>> +	trans =3D btrfs_start_transaction(root, 1);
>> +	if (IS_ERR(trans))
>> +		return PTR_ERR(trans);
>> +
>> +	key.objectid =3D 0;
>> +	key.type =3D 0;
>> +	key.offset =3D 0;
>> +	btrfs_init_path(&path);
>> +
>> +	/* Here we only CoW the tree root to update the geneartion */
>> +	path.lowest_level =3D btrfs_header_level(root->node);
>> +	root->node->flags |=3D EXTENT_BAD_TRANSID;
>
> Why do you set EXTENT_BAD_TRANSID? This flag is currently used only in
> read_tree_block to link blocks which have failed ordinary validation to
> the recow_ebs list, and this only happens in case we have a single copy
> for this eb. This list is then processed in the main check logic.

Because we have extra transid check in
btrfs_search_slot()/btrfs_cow_block().

EXTENT_BAD_TRANSID is to suppress such warning.

>
> So repair_root_generation could possibly be as simple as just linking
> root->node to the fs_info->recow_ebs and leave the rest to the existing
> logic?

It doesn't change the root generation.

>
>> +
>> +	ret =3D btrfs_search_slot(trans, root, &key, &path, 0, 1);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	btrfs_release_path(&path);
>> +	ret =3D btrfs_commit_transaction(trans, root);
>> +	return ret;
>> +}
>> diff --git a/check/mode-common.h b/check/mode-common.h
>> index 4c169c6e3b29..4a3abeb02c81 100644
>> --- a/check/mode-common.h
>> +++ b/check/mode-common.h
>> @@ -155,4 +155,5 @@ static inline bool is_valid_imode(u32 imode)
>>  	return true;
>>  }
>>
>> +int repair_root_generation(struct btrfs_root *root);
>>  #endif
>> diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
>> index a2be0e6d7034..bf3b57f5ad2d 100644
>> --- a/check/mode-lowmem.c
>> +++ b/check/mode-lowmem.c
>> @@ -4957,6 +4957,7 @@ static int check_btrfs_root(struct btrfs_root *ro=
ot, int check_all)
>>  	struct btrfs_path path;
>>  	struct node_refs nrefs;
>>  	struct btrfs_root_item *root_item =3D &root->root_item;
>> +	u64 super_generation =3D btrfs_super_generation(root->fs_info->super_=
copy);
>>  	int ret;
>>  	int level;
>>  	int err =3D 0;
>> @@ -4978,6 +4979,21 @@ static int check_btrfs_root(struct btrfs_root *r=
oot, int check_all)
>>  	level =3D btrfs_header_level(root->node);
>>  	btrfs_init_path(&path);
>>
>> +	if (btrfs_root_generation(root_item) > super_generation + 1) {
>> +		error(
>> +	"invalid root generation for root %llu, have %llu expect (0, %llu)",
>> +		      root->root_key.objectid, btrfs_root_generation(root_item),
>> +		      super_generation + 1);
>> +		err |=3D INVALID_GENERATION;
>> +		if (repair) {
>> +			ret =3D repair_root_generation(root);
>> +			if (!ret) {
>> +				err &=3D ~INVALID_GENERATION;
>> +				printf("Reset generation for root %llu\n",
>> +					root->root_key.objectid);
>> +			}
>> +		}
>> +	}
>>  	if (btrfs_root_refs(root_item) > 0 ||
>>  	    btrfs_disk_key_objectid(&root_item->drop_progress) =3D=3D 0) {
>>  		path.nodes[level] =3D root->node;
>> diff --git a/check/mode-lowmem.h b/check/mode-lowmem.h
>> index d2983fd12eb4..0361fb3382b1 100644
>> --- a/check/mode-lowmem.h
>> +++ b/check/mode-lowmem.h
>> @@ -47,6 +47,7 @@
>>  #define INODE_FLAGS_ERROR	(1<<23) /* Invalid inode flags */
>>  #define DIR_ITEM_HASH_MISMATCH	(1<<24) /* Dir item hash mismatch */
>>  #define INODE_MODE_ERROR	(1<<25) /* Bad inode mode */
>> +#define INVALID_GENERATION	(1<<26)	/* Generation is too new */
>>
>>  /*
>>   * Error bit for low memory mode check.
>>
