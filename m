Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED67C9CE8F
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 13:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbfHZLuO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 07:50:14 -0400
Received: from mout.gmx.net ([212.227.15.18]:55301 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbfHZLuO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 07:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566820208;
        bh=R7eBfN0YbE1NsCg6f8HrM0KMLbGgk0nY9IPBFDiYjU8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=TTYaN+1ABs9VuNlzOPSp7HhsM7+ob0FOO7hihKmYp4agMHKQwYpkmG9p0PzLH75mg
         yvGrrWA5yFaNDvqEr1eF4xrrHMRkVk5VreRdVUUQMWibb2Q+UNJdeq3YLCWNUz5Ygh
         kZpot5nw4SCd/bfecr8D65VTu1ERv0B5VgVpPacQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MLOMM-1i1fHJ0ufq-000ZnF; Mon, 26
 Aug 2019 13:50:08 +0200
Subject: Re: [PATCH 2/2] btrfs: tree-checker: Add check for INODE_REF
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190826074039.28517-1-wqu@suse.com>
 <20190826074039.28517-3-wqu@suse.com>
 <4c9195c9-5fc1-8524-e7d8-78ad1e942df7@suse.com>
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
Message-ID: <a9cb291b-7efe-e1a0-bf9f-a503fdc4001a@gmx.com>
Date:   Mon, 26 Aug 2019 19:50:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4c9195c9-5fc1-8524-e7d8-78ad1e942df7@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I1M0RZ+g7S84Z+cLF7RyK94VAGS/p7l8vlmlEre9aEPuosjNKKZ
 /IIMOgdqVhP/i8zAkQ/l/PHfEA1s02n4ZUf5NfEEaxwJsaJr9V/kD4UB+Frmm6JTg5tjGm3
 I2mVWgwMObWM+/w7/ZzJes6WRUFGODpGcvl+CKrzoYFgYMF4WpNHy0Z2TGYcetE3i+2viv4
 mgeCVouNx5rICNOdvK6PQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:18iyiLNqvvI=:XURkbGp8DDpHgLAalpdC7/
 wnmSsWM6uf9qmakXOjORPKZy/K/jUOv2IkrsBXB22HXFhS2yZD3Fm4LQlgtWAlF9CPFYecYXi
 U8DJtKW2WgtB07mcLTRNtPQE+YqNTwuG0Msm53KmD+JWMAJ4zMHZxQVbW1kw73BxD3CRhswHx
 nxmMjJFSbp8VmyHLbC6vagyPyFefAWrSYsoEp+mITaHJQr+Unt+kM0TZs6X5uj3JaU5q8KM+j
 B/ZZiPPSwvONJLw1sgrjk4sGRejb/LjOXqQ+T3o/lmiiJOCg5rnliXlyb24MYKOOVJZydXijb
 fzXrUhO1v+pCpJBZ6TurzA4ciK5NulsnGbjWN0LOGafYhZ0DzOduoz6UA8sPD8qD4MegPcZ5t
 Do2gzcMPQ5IkYb5QlV00NT1K/TsXaPos08Tq7CVmxIf6NUDM7rjEdAQu89r+UZioLBP5p+sZG
 hQFav8WOjT9pZKU7jqmNVnenxG9M80VrSXpD+PmWHJi4EI8E6PBE8QrECX15oLWfvsYRouJ0d
 G69vmxr6M05EwXxfbtrOiSUr6ETpavC7N+T1wARiUKUCPW2j/ZGcvpiFwZRgCRQjdaSQ0TFh4
 BGBmWpxQACK3+JX6chymrpaUwc5i10icHDG3phQTJYsUapfzvt9Y4pRua4yaivYc/XENoXUOd
 Xqq/5mJrINSIiqPq0JNVma6hrlD1Mq+jaQc7sroagQQX8srh5J73vvzvdh+lUaDznv5jZmziO
 ixOezI1Wy3hN+ZoOZuSK7Xz3hDNzStFh9B2HYUxw20AHO5V9YOW4UIbE4ebZ/sMOyw03Z2TCb
 7aynlJ2hHQGV5bFipf9j04k3pNX2siOJYGcWryrpe1m5+vMGp6UsLKtTWHPtRBUrDt2ZXSPKo
 Qj3Gbc7gx1ZWL75GxlqJzfCrSsPnz8pxF3xdoA011UFlW/umehc/xLo1Iur4Qzmnw5B0x46hp
 kc7dvu3gLcXH6E9l2p/m+VmQl0rMyLFS9mmHZDygSXGS1ZbPhRjPWDMerkAb0CKAxgRA0OoOI
 hhYQ7zBRqZzPK9zlHGLOcOAqlnGG3KoNdYs4A9FUvbjwmAJLVL/0eUU8SEbH/AtzRCiXjl6wB
 FK3sWL3rsB/yuQE1Jsop6bWoEyZ9r28KeRSOFj1+gusmPGc+hKG9NkkPhzWPg7/r9wJrCe+RK
 TPypX/A3H7U7UBBM4p+nyqhJFk89x/pQtjqSXo8R5NGUxXQg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/8/26 =E4=B8=8B=E5=8D=887:45, Nikolay Borisov wrote:
>
>
> On 26.08.19 =D0=B3. 10:40 =D1=87., Qu Wenruo wrote:
>> For INODE_REF we will check:
>> - Objectid (ino) against previous key
>>   To detect missing INODE_ITEM.
>>
>> - No overflow/padding in the data payload
>>   Much like DIR_ITEM, but with less members to check.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/tree-checker.c | 53 +++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 53 insertions(+)
>>
>> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
>> index 636ce1b4566e..3ce447eb591c 100644
>> --- a/fs/btrfs/tree-checker.c
>> +++ b/fs/btrfs/tree-checker.c
>> @@ -842,6 +842,56 @@ static int check_inode_item(struct extent_buffer *=
leaf,
>>  	return 0;
>>  }
>>
>> +#define inode_ref_err(fs_info, eb, slot, fmt, ...)		\
>> +	inode_item_err(fs_info, eb, slot, fmt, __VA_ARGS__)
>
> This define doesn't bring anything, just opencode the call to
> inode_item_err directly.

I could argue we that in an inode ref context, using a inode_item_err()
doesn't look right.

And since it's doesn't do any hurt, I prefer to make the error message
parse to match the context.

Thanks,
Qu
>
>> +static int check_inode_ref(struct extent_buffer *leaf,
>> +			   struct btrfs_key *key, struct btrfs_key *prev_key,
>> +			   int slot)
>> +{
>> +	struct btrfs_inode_ref *iref;
>> +	unsigned long ptr;
>> +	unsigned long end;
>> +
>> +	/* namelen can't be 0, so item_size =3D=3D sizeof() is also invalid *=
/
>> +	if (btrfs_item_size_nr(leaf, slot) <=3D sizeof(*iref)) {
>> +		inode_ref_err(fs_info, leaf, slot,
>> +		"invalid item size, have %u expect (%zu, %u)",
>> +			btrfs_item_size_nr(leaf, slot),
>> +			sizeof(*iref), BTRFS_LEAF_DATA_SIZE(leaf->fs_info));
>> +		return -EUCLEAN;
>> +	}
>> +
>> +	ptr =3D btrfs_item_ptr_offset(leaf, slot);
>> +	end =3D ptr + btrfs_item_size_nr(leaf, slot);
>> +	while (ptr < end) {
>> +		u16 namelen;
>> +
>> +		if (ptr + sizeof(iref) > end) {
>> +			inode_ref_err(fs_info, leaf, slot,
>> +		"inode ref overflow, ptr %lu end %lu inode_ref_size %zu",
>> +				ptr, end, sizeof(iref));
>> +			return -EUCLEAN;
>> +		}
>> +
>> +		iref =3D (struct btrfs_inode_ref *)ptr;
>> +		namelen =3D btrfs_inode_ref_name_len(leaf, iref);
>> +		if (ptr + sizeof(*iref) + namelen > end) {
>> +			inode_ref_err(fs_info, leaf, slot,
>> +		"inode ref overflow, ptr %lu end %lu namelen %u",
>> +				ptr, end, namelen);
>> +			return -EUCLEAN;
>> +		}
>> +
>> +		/*
>> +		 * NOTE: In theory we should record all found index number
>> +		 * to find any duplicated index. But that will be too time
>> +		 * consuming for inodes with too many hard links.
>> +		 */
>> +		ptr +=3D sizeof(*iref) + namelen;
>> +	}
>> +	return 0;
>> +}
>> +
>>  /*
>>   * Common point to switch the item-specific validation.
>>   */
>> @@ -864,6 +914,9 @@ static int check_leaf_item(struct extent_buffer *le=
af,
>>  	case BTRFS_XATTR_ITEM_KEY:
>>  		ret =3D check_dir_item(leaf, key, prev_key, slot);
>>  		break;
>> +	case BTRFS_INODE_REF_KEY:
>> +		ret =3D check_inode_ref(leaf, key, prev_key, slot);
>> +		break;
>>  	case BTRFS_BLOCK_GROUP_ITEM_KEY:
>>  		ret =3D check_block_group_item(leaf, key, slot);
>>  		break;
>>
