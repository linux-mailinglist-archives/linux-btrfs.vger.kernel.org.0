Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05C6AA7DE1
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 10:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfIDIbD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 04:31:03 -0400
Received: from mout.gmx.net ([212.227.15.18]:34861 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfIDIbD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Sep 2019 04:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567585855;
        bh=KkbQg17Z+CgA+DYwsvOCjRnMWfmOMynoxIErP1StTnc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=lEk1E4D4z+0EIxUS5UFz+/waXYdDKYIGTCEuNI6w7soAIaEQHsxHyAKm16B0VmmaP
         wBim+IEujJz1Fd0x3tsao+a5fx8XYnERup/c4t4gZkCKstEp4Q0x3ttFLf8u8RiHL6
         EXQUyQZBlKZmEd52QlYS/HPP/hetGbY+CCjDlhuA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LnPSg-1ifIfI34Va-00hhPS; Wed, 04
 Sep 2019 10:30:55 +0200
Subject: Re: [PATCH 1/4] btrfs-progs: check/common: Make repair_imode_common()
 to handle inodes in subvolume trees
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190903082407.13927-1-wqu@suse.com>
 <20190903082407.13927-2-wqu@suse.com>
 <7cfbd72b-d8e9-695b-0576-d9dda1010228@suse.com>
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
Message-ID: <2bd09938-f462-6e2f-1dbd-a326e0c6f159@gmx.com>
Date:   Wed, 4 Sep 2019 16:30:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7cfbd72b-d8e9-695b-0576-d9dda1010228@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SeQyWIj3D6keomTZmjBSXLwmkFub6C9YDnfG63P1jCZ/+xZVMFX
 QRaj5OIGAu6vxQlB6eSJjHEJD9z5UjyzuqW9puyWXKJHaY9Ygrj7aZoRI41mr+AvUN1DfGv
 lliIoswy1Cpt5QQNDcKn4a5k6qrJCAoRtsO3ACzogKOLkO4ywOrGZlFVGdBfoXdFtnW+ZQ2
 39RFISH1eif/PzsXA7Jtw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/axUH1ekx2M=:Fwd6kOf97wmDb5P5Ku9FPC
 a9NcNSylG6+iVkT6ZgTdtO7bpipwiITT4eVYryNZx14n9fNHDBdMwr7pOUmkO0zndetHm3HE5
 xYM0nNAA7/eCC/7yRCRZLOLyO4EeQdDXTgm0ul+wyPPdLj/l2UNwY8Jl22wQ0rJx2CIwyvUIN
 +meCEG5rmY23UFXUdfi7Au0EYm2w4kuLBPLLTLW1Y1K9UX3eeXF97ssb+7H2rJQU8sMd9zc3E
 2LCTqiSrdmVenXadgZjWTva/FIH7VO5Xbdw2/2dlwmAEUgWClPxI2cvqe+9WuiPpJ78Ojy1zK
 t+I90QEPyldj3439PJJ/bodoWMTnw/6WyIIYKyTDq8Xha9eJKKHosXk2JNzMX379GJyxp8FGc
 n6p40HGyLUcnZHYhGD0nVEvCBLDtBhACC357/g8tbWIcfl6dEXIdeZSFKHir/9aD9+WIU7/CD
 TiAjXImo9jjV+47onoLJjfjwla4XTplg5PdnbljpHGo6ILcNZEVls6WHR8obVnuHd8GnCCdsg
 9J8C6a8SvMdi1vH1wuk7ePXH2haCl2iXhidadQglo2AUSWk2dEtEH+TqzWN50TYGU0GjaSJ8A
 qCQC3hjlCTPGmasp/yPGHEoFySTsOWGmgICuyQtGEFD80OAgyGhK5M+9oQ00CJCjzDnT942mt
 ZwliORCCW5ZvXFmUMvuHi0BMgCLD3O182HzZI23X3Yg9CEtuI8j96GMHNH2GuZLI8ViCBo0+z
 bSlwcpSvb4lHzEmuqBQzbe4NsDVzq3+FjnMtv1j/LxXX1Xjbvjm3LCHwYVAp0eYasN4j2EKyA
 rQk8kJm3o7GKST0YVf/4kpNZk1qXjILaH6a7ET6TkXf0t+OrEsZMgc0bXCv8MIk/g9OTxOpCl
 /gA4QhIN0K5pDEtcgWor8Rdj+B9BRhIuz28AXHF5zmsk/yZ1J+jtPrSKK0M9KJZ1hU+ZacqoQ
 zJebHD8SWhVvTCiDma919VBFLKM1eofonWnAyV2mpvvp+r7MkH3lJR2gwtDgOdhSaB6HM+Jlu
 mEc/gkvey9AT0QG5MpIMkeSj8HUjzkJGF6rzoMG7W9BzlhueP311oNPX/tP3mOLv6u99hPs1k
 Uj2OzGiuDCjo0sLegSovDtC40AYAYOlusbsFe2b9xFTjbyh8//8cMEtLbWUJa3vQEQor0w8Ig
 I5ScNrUlQcZs9G6o7eNN8cVGHilvv8thTHPN+220ywGkGg0UUiutfNUDULVDle3sCmovqpRvq
 hCrTvfJ/ZvMavRrB8
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/9/4 =E4=B8=8B=E5=8D=883:37, Nikolay Borisov wrote:
>
>
> On 3.09.19 =D0=B3. 11:24 =D1=87., Qu Wenruo wrote:
>> Before this patch, repair_imode_common() can only handle two types of
>> inodes:
>> - Free space cache inodes
>> - ROOT DIR inodes
>>
>> For inodes in subvolume trees, the problem is how to determine the
>> correct imode, thus it was not implemented.
>>
>> However there are more reports of incorrect imode in subvolume trees, w=
e
>> need to support such fix.
>>
>> So this patch adds a new function, detect_imode(), to detect (or call i=
t
>> educated guess) imode for inodes in subvolume trees.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  check/mode-common.c | 96 +++++++++++++++++++++++++++++++++++++++------
>>  1 file changed, 83 insertions(+), 13 deletions(-)
>>
>> diff --git a/check/mode-common.c b/check/mode-common.c
>> index 195b6efaa7aa..807d7daf98a6 100644
>> --- a/check/mode-common.c
>> +++ b/check/mode-common.c
>> @@ -836,6 +836,80 @@ int reset_imode(struct btrfs_trans_handle *trans, =
struct btrfs_root *root,
>>  	return ret;
>>  }
>>
>> +static int detect_imode(struct btrfs_root *root, struct btrfs_path *pa=
th,
>> +			u32 *imode_ret)
>> +{
>> +	struct btrfs_key key;
>> +	struct btrfs_inode_item *iitem;
>> +	const u32 priv =3D 0700;
>> +	u64 ino;
>> +	u32 imode =3D S_IFREG;
>> +	int ret =3D 0;
>> +
>> +	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
>> +	ino =3D key.objectid;
>> +	iitem =3D btrfs_item_ptr(path->nodes[0], path->slots[0],
>> +			       struct btrfs_inode_item);
>> +
>> +	/*
>> +	 * Both CHR and BLK uses rdev, no way to distinguish them, so fall ba=
ck
>> +	 * to BLK.
>> +	 */
>> +	if (btrfs_inode_rdev(path->nodes[0], iitem) !=3D 0) {
>> +		imode =3D S_IFBLK;
>> +		goto out;
>> +	}
>> +
>> +	/* root inode */
>> +	if (ino =3D=3D BTRFS_FIRST_FREE_OBJECTID) {
>> +		imode =3D S_IFDIR;
>> +		goto out;
>> +	}
>> +
>> +	while (1) {
>> +		ret =3D btrfs_next_item(root, path);
>> +		if (ret > 0) {
>> +			/* No determining result found, falls back to REG */
>> +			ret =3D 0;
>> +			goto out;
>> +		}
>> +		if (ret < 0)
>> +			goto out;
>> +		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
>> +		if (key.objectid !=3D ino)
>> +			goto out;
>> +
>> +		/*
>> +		 * We ignore some types to make life easier:
>> +		 * - INODE_REF
>> +		 *   We need to do a full tree search, which can fail for
>> +		 *   corrupted fs, but not worthy compared to other easier
>> +		 *   to determine types.
>> +		 * - XATTR
>> +		 *   Both REG and DIR can have xattr, so not useful
>> +		 */
>> +		switch (key.type) {
>> +		case BTRFS_DIR_ITEM_KEY:
>> +		case BTRFS_DIR_INDEX_KEY:
>> +			imode =3D S_IFDIR;
>> +			goto out;
>> +		case BTRFS_EXTENT_DATA_KEY:
>> +			/*
>> +			 * Both REG and LINK could have EXTENT_DATA.
>> +			 * We just fall back to REG as user can inspect the
>> +			 * content.
>> +			 */
>> +			imode =3D S_IFREG;
>> +			goto out;
>> +		}
>> +	}
>> +
>> +out:
>> +	/* Set default value even when something wrong happened */
>> +	*imode_ret =3D (imode | priv);
>> +	return ret;
>> +}
>> +
>>  /*
>>   * Reset the inode mode of the inode specified by @path.
>>   *
>> @@ -852,22 +926,18 @@ int repair_imode_common(struct btrfs_root *root, =
struct btrfs_path *path)
>>  	u32 imode;
>>  	int ret;
>>
>> -	if (root->root_key.objectid !=3D BTRFS_ROOT_TREE_OBJECTID) {
>> -		error(
>> -		"repair inode mode outside of root tree is not supported yet");
>> -		return -ENOTTY;
>> -	}
>>  	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
>>  	ASSERT(key.type =3D=3D BTRFS_INODE_ITEM_KEY);
>> -	if (key.objectid !=3D BTRFS_ROOT_TREE_DIR_OBJECTID &&
>> -	    !is_fstree(key.objectid)) {
>> -		error("unsupported ino %llu", key.objectid);
>> -		return -ENOTTY;
>> +	if (root->objectid =3D=3D BTRFS_ROOT_TREE_OBJECTID) {
>> +		/* In root tree we only have two possible imode */
>> +		if (key.objectid =3D=3D BTRFS_ROOT_TREE_OBJECTID)
>> +			imode =3D S_IFDIR | 0755;
>> +		else
>> +			imode =3D S_IFREG | 0600;
>> +	} else {
>> +		detect_imode(root, path, &imode);
>> +		/* Ignore error returned, just use the default value returned */
>
> Is this safe enough though?

It depends. But I'd say if we failed in detect_imode(), then it doesn't
matter whatever the type we're putting here.

> What if due to an error a directory is
> corrected to be file?

If a failure happens, it means btrfs-progs fails to read the next leaf.
Then it really doesn't make much sense whatever the type is.

But I get your point, indeed we should error out without trying out to
fix the inode.

I'll change this behavior in next version.

Thanks,
Qu

> Let's not forget the context we are oprating here
> - a broken fs so it's possible (if not likely) that any of the search
> functions inside detect_imode could return negative error value. OTOH
> I'd expect the transaction commit to fail if that's the case e.g. faulty
> device.
>
>>  	}
>> -	if (key.objectid =3D=3D BTRFS_ROOT_TREE_DIR_OBJECTID)
>> -		imode =3D 040755;
>> -	else
>> -		imode =3D 0100600;
>>
>>  	trans =3D btrfs_start_transaction(root, 1);
>>  	if (IS_ERR(trans)) {
>>
