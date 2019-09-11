Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1B21AF3B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 02:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfIKAkS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Sep 2019 20:40:18 -0400
Received: from mout.gmx.net ([212.227.15.18]:41287 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfIKAkS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Sep 2019 20:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568162390;
        bh=ueWY/0GXjhAj6PoNWiqBdARrO41jkWaS0Ecq5YIFylk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=VAOD22RDycr06t4lO4cFIhuCxQ0lOo4ySamMw1UGmS855Yvbiy7viTo1M+3iUwhBM
         4dH3jMvZbLQJUySc3fwTR+aBXeCNdirfKtrkOROR3GF52emzgA8P6TNF13vnDCrM8d
         nCWZYY0ZH+7M6hl9D/4sunw2W/tTLKYp+TwUfkFs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0Mg3Vt-1hnB7Q3c7Z-00NNFC; Wed, 11
 Sep 2019 02:39:50 +0200
Subject: Re: [PATCH v2 3/6] btrfs-progs: check/common: Make
 repair_imode_common() to handle inodes in subvolume trees
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190905075800.1633-1-wqu@suse.com>
 <20190905075800.1633-4-wqu@suse.com>
 <d78eb326-5441-94ab-f5ee-01f5526a97e5@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
Message-ID: <9ab43823-0649-f277-5b19-224aa66f781e@gmx.com>
Date:   Wed, 11 Sep 2019 08:39:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <d78eb326-5441-94ab-f5ee-01f5526a97e5@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DSTT5Z0Y5wJtEcIqOhxdfr3u8KrVZcPLJMGUCflst9cPkh8c+fz
 EwSTYbZIfhcMtIk7IE46QfCIO1sYxzExKriZ0bd0rY9MFlG2DnQ5MHOa4Qny4M1ua9wfA2k
 uGAtFEmsCDduPOBafW1enkwiLuxqBsYbp7QLnrYTfwcYukRzdIidCdLa+2VWz8vvZx3G5F9
 RqrzLHD1pjNP2JhEQaqHA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nLnRnVDCvMc=:krnJbeL5PGhbswfXDAwkpA
 cKHvRttZKVfchOL4krsPDHS/zE/zDqAAMfXmZX4jGlK89EvagQgNAWOuoEFJEMHHV7/+ICnSE
 Oc/CUFem1PC5499qbGo90n0Gqv0fmSqqVHgjHR5A4AZzKv0xRk1/w/11tMv8M+QgaqcWys/yO
 C7lIpSZTZevMXqY+kbndIbtLvpmoCwL1vhNlc9OeSsBtPLvNfMt9JA/pd/3hZJUzXV0YgEywG
 e72lynkwYtY1uaTjPTWfu+WKzLllnZ3/qLxku4ako43zf8SCraV2HJcLTqGLXLz1TQwkBC3aB
 5OUEdc7KJQOASTUzDxPyXlM0aw1Ug8KY2o4anXaK6xaT5sDQ0wRlcMdXsfOixA5KBGTLkYh2d
 BnfTw5aAblIAiLLYEJkiLnfW5hCRso1fyJ2YDEFBt3BpYrOZ6SrsE/aKujAlhvJcv/th9mtJa
 T6QeUFcIbt6XUMLywcTvVeeaocJi7Eo7l/ivS+TzYRE35XeTmnEDi4opjFfku/OiogVkT9n4C
 pFXRRfyCuXWkzNt7aeaAhxcuUD6P2766R8pJjRpXxhUs5d4zfa0CNGoM6f2eYql8C5ZTxV51m
 f3p2XCymo2X+6Rwxolp8KYycRAsJkaoRYW5wUvs5+6y7PG9W3xq5e8cRx5UrsvbhYSfGiVg4k
 2Dzbu+huYP0iaAWbHEQoonry5z8qbTCipW+p0YGIPVPzjdERfr6KE3f/bwG4YUkNezYjA9mAW
 7tpp4MY69TdiLMhZPCBCUOgmlyR9L0JQjKgBeQO/TfD3FRNzTj5tA8N57mSaI3Kmu6HgY/lsg
 0pBnrNeeUWGbZ09z1LZ/Vz8oTyZPX3CDUsG6t6vGRHBLC/92dZjg+FKUzRxmUsZWWmojzkKAm
 XEUaHHGlPTC0QXfRNj/5XKtmELtUECDm0g3gEX9RdxnhhB9YY24+uWAxqgmI7oZkAYfruNvjF
 XLTPgjEX3r01jYdpjrXLLF7nAvdBYAuVlbFUy2s8LlwZNiiE1URCeAmpZ+Y4+fUjrNnllDULL
 9j5HX3DQdF/hKuv+XZn1x3Phri3IS644OBHScF6vgOlA1FyAXTwU5K2hTsNoTBejdyrmbFmbe
 Z9M/BllG+fpfOgrec/3/mGxqvJk7h9N96xkfMDz/7K7Z8/w5t1wKfa79DfKe+Yf2eqmReVIf9
 3V+mq75FhRLvpQiOlHv/B4a2ye6BaUKppmXtfQ9RNafz6Py9LhAXFHf3tA3xeYYXZbxWyuGgr
 q+2M++4DMjRQPIZNDk5nlxTU4+CIhJvW2etSVlmPeU4eqUgfycyIhEPkZgf0=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[...]
>> - Search for DIR_INDEX/DIR_ITEM
>>   If above search fails, we falls back to locate the DIR_INDEX/DIR_ITEM
>>   just after the INODE_ITEM.
>>   If any can be found, it's definitely a directory.
>
> This needs an explicit satement that it will only work for non-empty fil=
es and directories

Indeed.

>>
>> - Search for EXTENT_DATA
>>   If EXTENT_DATA can be found, it's either REG or LNK.
>>   For this case, we default to REG, as user can inspect the file to
>>   determine if it's a file or just a path.
>>
>> - Use rdev to detect BLK/CHR
>>   If all above fails, but INODE_ITEM has non-zero rdev, then it's eithe=
r
>>   a BLK or CHR file. Then we default to BLK.
>>
>> - Fail out if none of above methods succeeded
>>   No educated guess to make things worse.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  check/mode-common.c | 130 +++++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 117 insertions(+), 13 deletions(-)
>>
>> diff --git a/check/mode-common.c b/check/mode-common.c
>> index c0ddc50a1dd0..abea2ceda4c4 100644
>> --- a/check/mode-common.c
>> +++ b/check/mode-common.c
>> @@ -935,6 +935,113 @@ out:
>>  	return ret;
>>  }
>>
>> +static int detect_imode(struct btrfs_root *root, struct btrfs_path *pa=
th,
>> +			u32 *imode_ret)
>> +{
>> +	struct btrfs_key key;
>> +	struct btrfs_inode_item iitem;
>> +	const u32 priv =3D 0700;
>> +	bool found =3D false;
>> +	u64 ino;
>> +	u32 imode;
>> +	int ret =3D 0;
>> +
>> +	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
>> +	ino =3D key.objectid;
>> +	read_extent_buffer(path->nodes[0], &iitem,
>> +			btrfs_item_ptr_offset(path->nodes[0], path->slots[0]),
>> +			sizeof(iitem));
>> +	/* root inode */
>> +	if (ino =3D=3D BTRFS_FIRST_FREE_OBJECTID) {
>> +		imode =3D S_IFDIR;
>> +		found =3D true;
>> +		goto out;
>> +	}
>> +
>> +	while (1) {
>> +		struct btrfs_inode_ref *iref;
>> +		struct extent_buffer *leaf;
>> +		unsigned long cur;
>> +		unsigned long end;
>> +		char namebuf[BTRFS_NAME_LEN] =3D {0};
>> +		u64 index;
>> +		u32 namelen;
>> +		int slot;
>> +
>> +		ret =3D btrfs_next_item(root, path);
>> +		if (ret > 0) {
>> +			/* falls back to rdev check */
>> +			ret =3D 0;
>> +			goto out;
>> +		}
>
> In my testing if an inode is the last one in the leaf and it doesn't hav=
e
> an INODE_REF item then it won't be repaired. But e.g. it can have perfec=
tly
> valid DIR_ITEM/DIR_INDEX entries which describe this inode as being a fi=
le. E.g.
>
> 	item 2 key (256 DIR_ITEM 388586943) itemoff 16076 itemsize 35
> 		location key (260 INODE_ITEM 0) type FILE
> 		transid 7 data_len 0 name_len 5
> 		name: file3
>
> 	.....
> 	item 15 key (260 INODE_ITEM 0) itemoff 15184 itemsize 160
> 		generation 7 transid 7 size 0 nbytes 0
> 		block group 0 mode 26772225102 links 1 uid 0 gid 0 rdev 0
> 		sequence 1 flags 0x0(none)
> 		atime 1568127261.284993602 (2019-09-10 14:54:21)
> 		ctime 1568127261.284993602 (2019-09-10 14:54:21)
> 		mtime 1568127261.284993602 (2019-09-10 14:54:21)
> 		otime 1568127261.284993602 (2019-09-10 14:54:21)
>
> I have intentionally deleted INODE_REF too see what's happening. Is this=
 intended?

Yes, completely intended.

For this case, you need to iterate through the whole tree to locate the
DIR_INDEX to fix, which is not really possible with current code base,
which only search based on the INODE, not the DIR_INDEX/DIR_ITEM from
its parent dir.

Furthermore, didn't you mention that if we don't have confident about
the imode, then we should fail out instead of using REG as default?

>
>
>> +		if (ret < 0)
>> +			goto out;
>> +		leaf =3D path->nodes[0];
>> +		slot =3D path->slots[0];
>> +		btrfs_item_key_to_cpu(leaf, &key, slot);
>> +		if (key.objectid !=3D ino)
>> +			goto out;
>> +
>> +		/*
>> +		 * We ignore some types to make life easier:
>> +		 * - XATTR
>> +		 *   Both REG and DIR can have xattr, so not useful
>> +		 */
>> +		switch (key.type) {
>> +		case BTRFS_INODE_REF_KEY:
>> +			/* The most accurate way to determine filetype */
>> +			cur =3D btrfs_item_ptr_offset(leaf, slot);
>> +			end =3D cur + btrfs_item_size_nr(leaf, slot);
>> +			while (cur < end) {
>> +				iref =3D (struct btrfs_inode_ref *)cur;
>> +				namelen =3D min_t(u32, end - cur - sizeof(&iref),
>> +					btrfs_inode_ref_name_len(leaf, iref));
>> +				index =3D btrfs_inode_ref_index(leaf, iref);
>> +				read_extent_buffer(leaf, namebuf,
>> +					(unsigned long)(iref + 1), namelen);
>> +				ret =3D find_file_type(root, ino, key.offset,
>> +						index, namebuf, namelen,
>> +						&imode);
>> +				if (ret =3D=3D 0) {
>> +					found =3D true;
>> +					goto out;
>> +				}
>> +				cur +=3D sizeof(*iref) + namelen;
>> +			}
>> +			break;
>> +		case BTRFS_DIR_ITEM_KEY:
>> +		case BTRFS_DIR_INDEX_KEY:
>> +			imode =3D S_IFDIR;
>
> You should set found here.

Yep, also found that and fixed in next version.

Thanks,
Qu

> Otherwise this function returns ENOENT in those 2 branches.
> BTW in relation to out private conversation I found this while trying to=
 create test
> cases which will trigger all branches. The fact it found bugs proves we =
should strive
> for as much testing coverage as possible.
>
>> +			goto out;
>> +		case BTRFS_EXTENT_DATA_KEY:
>> +			/*
>> +			 * Both REG and LINK could have EXTENT_DATA.
>> +			 * We just fall back to REG as user can inspect the
>> +			 * content.
>> +			 */
>> +			imode =3D S_IFREG;
> ditto
>
>> +			goto out;
>> +		}
>> +	}
>> +
>> +out:
>> +	/*
>> +	 * Both CHR and BLK uses rdev, no way to distinguish them, so fall ba=
ck
>> +	 * to BLK. But either way it doesn't really matter, as CHR/BLK on btr=
fs
>> +	 * should be pretty rare, and no real data will be lost.
>> +	 */
>> +	if (!found && btrfs_stack_inode_rdev(&iitem) !=3D 0) {
>> +		imode =3D S_IFBLK;
>> +		found =3D true;
>> +	}
>> +
>> +	if (found)
>> +		*imode_ret =3D (imode | priv);
>> +	else
>> +		ret =3D -ENOENT;
>> +	return ret;
>> +}
>> +
>>  /*
>>   * Reset the inode mode of the inode specified by @path.
>
> <snip>
>
