Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A15FADB22
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Sep 2019 16:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfIIOYj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Sep 2019 10:24:39 -0400
Received: from mout.gmx.net ([212.227.15.19]:51385 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbfIIOYi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Sep 2019 10:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568039050;
        bh=dVy2kfEqUpL5ckdfMQIEXdorOySlyreBGpCpl4mt0z4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=lIopYqHudjbKxiVifZINmqX978SJ1JVw0c4HmbR98n5VJO1ybhhkH6kjYTLoR6G/U
         pPN3QW0d2cE7XBUQ7SH6OtsUWnb11quXwDo+m+zPudFE6ueQ1j1RHd5KQlDZ4qzvSB
         zol1LlJlqUYMRpEsx6qm1SIwYBFVms85rnpfgDqQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MK17F-1i6Vm02lM5-001Ur3; Mon, 09
 Sep 2019 16:24:10 +0200
Subject: Re: [PATCH v2 2/6] btrfs-progs: check/common: Introduce a function to
 find imode using INODE_REF
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190905075800.1633-1-wqu@suse.com>
 <20190905075800.1633-3-wqu@suse.com>
 <4e7099d2-5b4c-1fa3-ffdf-2b3332ed0b88@suse.com>
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
Message-ID: <37228196-3617-e253-6ad1-125e72e6628c@gmx.com>
Date:   Mon, 9 Sep 2019 22:24:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <4e7099d2-5b4c-1fa3-ffdf-2b3332ed0b88@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VG+p3IMMRpng82EL6Hoi9hDubKevAOrqaURaTUFqL4RrcHkIi1u
 uc0qzgPoYFxF02QEhOKSfqliuRAktV3J7qeboovA6IUFdRXKVCXFgJXc9UYDaT34HVzFWGe
 rXtIjOnPHQtA9wE9dhsHEBZITGsrxsaFjniWpP478lPpy97DxKR75RbPrTTaaqoGzMdowaW
 UuZ2wwku0Fvli7ZHa47ig==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iLDn5D1LpFU=:HvKCXHVM+QFEqWiSVMVKot
 2WO4pd6HM0m0p8bI9gzKQaWPhL7P3H40GGkBxU19g6laY1bIQ6WHjlJui5KpkG32AbhjcYZv2
 Lccef8pURRa2w8yUHKZ/MHdirHmmnjmnV3uyAEj5ZKE3CVaEaeZPy8q0p7hvNgObCnRGvt4El
 WAhCrP/xIeZnj6g4iDtqXhZN4okveZ2zhnZ5nwAWXNQeziE9C7EoxOe27eTX7myEV/pesEyer
 Ilw6sRDabGTv1oxBjcRCXm+3y0em5BNsCLI5F7w5JWunTbtvNOm7pPOefr+JUzknqlzUiDISc
 wLJ6SkhlqX6nH9F6iFN6h+yTn0Zf/0LS05YS9aCnF26e8Diu491JSshy24cBxr7HNTOFtyYbQ
 +HQwZPrI1vEiJp0iCElHSlqM9MGOz5X7yf3nzu8awFLMb4OTlNxD4BidN3IsLG0nOzxQvKIRL
 henwQsB9Ef9LnErYAtIDIOZr2gzyln8oN1nC4dvI07qn6A7UUPpVRCk4inFAocpjUxBB5ozoe
 x/AW4behiTof6U4xfXOQ4BlFPe5rPvf4mJmAHhXpD8Q+XS18UqWhpZ40ggSTGuGK9A7fTiUtY
 0D/q1BM/xoguZ8QMjKQqK8MX4gDIzGv+EbKpxUJ/Tnn+YkWtjwCvWtEj5/ZQ0oAG5Sthy39tZ
 0D8izjvcLKJtb8Q6/NynD+W5FBReCfLZK7U6p2qwVGZ3ZhQNa05guHYzTdhTF4O17s2nyRpFd
 kHhsRxTcINuQ3ShLTVzk1XTFRRMDJBZSowVdIyud2Ky5B4z9ih+A2yBXVE2M+PFJMagidOUFq
 24lgo22/gCd+YOjWGvyAhTEQJY2yT9RXQaWqLtANOp4Y6vZSNrZzUL9wSg+GM6HOALZEfCioQ
 9UJqAHA5PkP4Tzq44jGsY2KWnaI8HrsiCC1Aede346XMbJxunwQ2aEaD3H70n+g5TPgDi5Z9P
 zJL5KYTMEgzcidx6s9Qv4o1EH4E+WIwDZpRlIyISurHQF2SY+l5eCsoWYDAzhlWwr7RffHVuF
 SJ/YljDz5nDAbhFc5eU0jO+9JLA4MYCItK7VMoZ80bmLN6TsV7v4azmndYH2ZSS34uqNCOrtv
 qKTh/8JEAYMyetutwheWSIg71Z8t3+VBquvkc3HHaCwv20S8/8QszS1FbXN+es4+zx44jNtVE
 a9Zf0wWe13/vT9qomvMFNiYcEnmfaclEIOXdXiMS02N4zr+4JIA/EBGNe95C6Dn1ljsN6Ot95
 o5nsErotc7s4zh+Rr
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/9/9 =E4=B8=8B=E5=8D=889:25, Nikolay Borisov wrote:
>
>
> On 5.09.19 =D0=B3. 10:57 =D1=87., Qu Wenruo wrote:
>> Introduce a function, find_file_type(), to find filetype using
>> INODE_REF.
>>
>> This function will:
>> - Search DIR_INDEX first
>>   DIR_INDEX is easier since there is only one item in it.
>>
>> - Valid the DIR_INDEX item
>>   If the DIR_INDEX is valid, use the filetype and call it a day.
>>
>> - Search DIR_ITEM then
>>
>> - Valide the DIR_ITEM
>>   If valid, call it a day. Or return -ENOENT;
>>
>> This would be used as the primary method to determine the imode in late=
r
>> imode repair code.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  check/mode-common.c | 99 +++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 99 insertions(+)
>>
>> diff --git a/check/mode-common.c b/check/mode-common.c
>> index 195b6efaa7aa..c0ddc50a1dd0 100644
>> --- a/check/mode-common.c
>> +++ b/check/mode-common.c
>> @@ -16,6 +16,7 @@
>>
>>  #include <time.h>
>>  #include "ctree.h"
>> +#include "hash.h"
>>  #include "common/internal.h"
>>  #include "common/messages.h"
>>  #include "transaction.h"
>> @@ -836,6 +837,104 @@ int reset_imode(struct btrfs_trans_handle *trans,=
 struct btrfs_root *root,
>>  	return ret;
>>  }
>>
>> +static int find_file_type(struct btrfs_root *root, u64 ino, u64 dirid,
>> +			  u64 index, const char *name, u32 name_len,
>> +			  u32 *imode_ret)
>> +{
>> +	struct btrfs_path path;
>> +	struct btrfs_key location;
>> +	struct btrfs_key key;
>> +	struct btrfs_dir_item *di;
>> +	char namebuf[BTRFS_NAME_LEN] =3D {0};
>> +	unsigned long cur;
>> +	unsigned long end;
>> +	bool found =3D false;
>> +	u8 filetype;
>> +	u32 len;
>> +	int ret;
>> +
>> +	btrfs_init_path(&path);
>> +
>> +	/* Search DIR_INDEX first */
>> +	key.objectid =3D dirid;
>> +	key.offset =3D index;
>> +	key.type =3D BTRFS_DIR_INDEX_KEY;
>> +
>> +	ret =3D btrfs_search_slot(NULL, root, &key, &path, 0, 0);
>> +	if (ret > 0)
>> +		ret =3D -ENOENT;
>
> Even if it returns 1 meaning there is no DIR_INDEX item perhaps it still
> makes sense to go to dir_item: label to search for DIR_ITEM, what if the
> corruption has affected just the DIR_INDEX item?

I didn't get the point.

The next line is just going to do dir_item search, just as you mentioned.
>
>> +	if (ret < 0)
>> +		goto dir_item;
> nit: Use elseif to make it more explicit it is a single construct.

Not sure such usage is recommened, but I see a lot of usage like:
	ret =3D btrfs_search_slot();
	if (ret > 0)
		ret =3D -ENOENT;
	if (ret < 0)
		goto error;

So I just followed this practice.

>
>> +	di =3D btrfs_item_ptr(path.nodes[0], path.slots[0],
>> +			       struct btrfs_dir_item);
>> +	btrfs_dir_item_key_to_cpu(path.nodes[0], di, &location);
>> +
>> +	/* Various basic check */
>> +	if (location.objectid !=3D ino || location.type !=3D BTRFS_INODE_ITEM=
_KEY ||
>> +	    location.offset !=3D 0)
>> +		goto dir_item;
>> +	filetype =3D btrfs_dir_type(path.nodes[0], di);
>> +	if (filetype >=3D BTRFS_FT_MAX || filetype =3D=3D BTRFS_FT_UNKNOWN)
>> +		goto dir_item;
>> +	len =3D min_t(u32, btrfs_item_size_nr(path.nodes[0], path.slots[0]) -
>> +			 sizeof(*di), BTRFS_NAME_LEN);
>> +	len =3D min_t(u32, len, btrfs_dir_name_len(path.nodes[0], di));
>> +	read_extent_buffer(path.nodes[0], namebuf, (unsigned long)(di + 1), l=
en);
>> +	if (name_len !=3D len || memcmp(namebuf, name, len))
>> +		goto dir_item;
>> +
>> +	/* Got a correct filetype */
>> +	found =3D true;
>> +	*imode_ret =3D btrfs_type_to_imode(filetype);
>> +	ret =3D 0;
>> +	goto out;
>> +
>> +dir_item:
>
> This function is needlessly structured in an awkward way. E.g. there is
> no dependence between "searching by DIR INDEX item" and "searching by
> DIR_ITEM". I think the best way is to have 3 function:
>
> Top level find_file_type which will call find_file_type_by_dir_index if
> the reeturn value is negative -> call 2nd function
> find_file_type_by_dir_item. This will result in 3 fairly short and easy
> to read/parse functions.

I'm OK with that, which is also my original plan, but it's just too easy
to put them altogether into one function, thus I forgot that plan.

>
>> +	btrfs_release_path(&path);
>> +	key.objectid =3D dirid;
>> +	key.offset =3D btrfs_name_hash(name, name_len);
>> +
>> +	ret =3D btrfs_search_slot(NULL, root, &key, &path, 0, 0);
>> +	if (ret > 0)
>> +		ret =3D -ENOENT;
>> +	if (ret < 0) {
>> +		btrfs_release_path(&path);
>> +		return ret;
>> +	}
>
> ditto about the else if construct
>
>> +	cur =3D btrfs_item_ptr_offset(path.nodes[0], path.slots[0]);
>> +	end =3D cur + btrfs_item_size_nr(path.nodes[0], path.slots[0]);
>> +	while (cur < end) {
>
> Just checking : this is needed in case we have items whose names create
> a crc32 collision in the DIR_ITEM offset?

Yep.
For DIR_ITEM we can have collision while for DIR_INDEX it won't cause
collision.

>
>> +		di =3D (struct btrfs_dir_item *)cur;
>> +		btrfs_dir_item_key_to_cpu(path.nodes[0], di, &location);
>> +		/* Various basic check */
>> +		if (location.objectid !=3D ino ||
>> +		    location.type !=3D BTRFS_INODE_ITEM_KEY ||
>> +		    location.offset !=3D 0)
>> +			goto next;> +		filetype =3D btrfs_dir_type(path.nodes[0], di);
>> +		if (filetype >=3D BTRFS_FT_MAX || filetype =3D=3D BTRFS_FT_UNKNOWN)
>> +			goto next;
>> +		len =3D min_t(u32, BTRFS_NAME_LEN,
>> +			    btrfs_item_size_nr(path.nodes[0], path.slots[0]) -
>> +			    sizeof(*di));
>> +		len =3D min_t(u32, len, btrfs_dir_name_len(path.nodes[0], di));
>> +		read_extent_buffer(path.nodes[0], namebuf,
>> +				   (unsigned long)(di + 1), len);
>> +		if (name_len !=3D len || memcmp(namebuf, name, len))
>> +			goto next;
>> +		*imode_ret =3D btrfs_type_to_imode(filetype);
>> +		found =3D true;
>> +		goto out;
>> +next:
>> +		cur +=3D btrfs_dir_name_len(path.nodes[0], di) + sizeof(*di);
>
> If this line is moved right after assigning to 'di' instead of having a
> 'next' label you can simply use the 'continue' keyword

Right, saving a tag is never a bad idea.

Thanks,
Qu
>
>> +	}
>> +out:
>> +	btrfs_release_path(&path);
>> +	if (!found && !ret)
>> +		ret =3D -ENOENT;
>> +	return ret;
>> +}
>> +
>>  /*
>>   * Reset the inode mode of the inode specified by @path.
>>   *
>>
