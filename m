Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 392D915D4CB
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 10:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgBNJeI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 04:34:08 -0500
Received: from mout.gmx.net ([212.227.15.19]:41267 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729073AbgBNJeI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 04:34:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581672841;
        bh=X+TN+AtOr4NjVBWy1hqVGUg6onn0KWwkACJ9R8oY1hw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=M1eT6xXExtHxc5vLdEUZyHjwcs3RCvkkioN2tOO0h/uJo+iyKSfb+wQaewt0LWGP5
         G1DHXNpN9SJzmLA59ezCsBwRi8DB9aiv1+BujEyWwoXG7NHqf1A8XVjQ6IXnx0atoM
         2UcOp4Zh97rz2C2M6LoJli//Iphak4kFn+cN7YIE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MSKuA-1ivpHU1Qng-00SbDs; Fri, 14
 Feb 2020 10:34:00 +0100
Subject: Re: [PATCH v2 1/3] btrfs: backref: Introduce the skeleton of
 btrfs_backref_iterator
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200214081354.56605-1-wqu@suse.com>
 <20200214081354.56605-2-wqu@suse.com>
 <689800fa-ae4a-e2fc-b699-92e969d0e389@suse.com>
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
Message-ID: <1f17ed5b-978e-8a45-813d-3fdce61a8e9c@gmx.com>
Date:   Fri, 14 Feb 2020 17:33:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <689800fa-ae4a-e2fc-b699-92e969d0e389@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wD6xMnXu4OKEExZxD4rJVO9FA8DWlC3PXc1scgFEgr1yuM9bRkM
 eUAynEmxVZhHTbLIjgTu+qjv7OACT/yjSFtjkhibtvpDK6mEzqrNSGmRdcqbC0PCq4sXCzc
 F0qWUJKr/mSYHGvpBIRbp0ppQQgcpAQxqsvZHFyVdxM/uJKjpEJT/Q64f6nQumCvo2zTQqb
 ZThSQdPXBM7zTyy0keT0Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:K3py9KdZb4I=:ZI4c8L8eTsZcHTPjKPq8QZ
 6FoPirlA7q0bg/vYLRwL13vBKCTE1cD8wxU0YsxONnqnhv03EgFaPwoRkxggi71lc0Bs32i7p
 LLkE2H/nGJueAbctCS93pbFf1w9VnUFrtK1abk0VkLopDgBEux9GUWEtIoScYA1tnxCt3BK1i
 gKZ25eecgJ6ndLEmNDmk6QZQYXOTfNduKdIK7wxGao4MgQRVGln44c2HG85TVGupGGIOlVWN8
 OlJwQuib6mmbNPG0WB+ENNCnG7vE1pnPUBdk28ofAtUOb+jv1rhiajuKY0jSNcudjuOAdeU22
 fZ7BHp8aOafst9yCIwA3rhrA6P7UOgMkZCCy76V8XI4W2p6jyWw84f6khog/8v/tPfTfCSCq4
 /LUJGxZoEZ56k8Ib9EaOIkIk3VaJ9ngHNrNWwhZgw3cqXErf7alfwFHogPu6UAsxt5oT4Pvvp
 bKnEJwtSGUuWbcUJMnGjfec5Do8Q4bYa0fWY/lxwZalty5XBwygH4X9rXIulfWBQ0HWSTy2i2
 oPRBeaatKkjgw1z2fkZHjpuxYDXgtVEOkwRGCdIQjaqL45mKZWbIpeL5N8lAq2A2YidyL2ymY
 Dl5vXlzD+01GaZR7ZWC3dCtyZwhASsNY7JmNvFwflBAddceBEVjaACaGIoQ6VK0/kwDVpdfQw
 UI/L7LZkgIhp0fzyVFWDn+zO1Sc2h5EOjLh8Qzd3AmmrwTRfyHhAztM6UFJkX1NVin9RDyeK0
 2MDXUBLSdGH/wBsEBmVF0XvIGHwMq0jXMjqvSf4fF/a2RhplrjvrJbKw1lm0vPO4vWwO8b0L3
 nNH+SUee19hsFUFXX8SIeV0dBPfBXs2+GWgBrYIA4/oZ3j9wCOgOcMPgVgxxUgpRb6EDctaB6
 Z1oSk+kjUDOjPUtYH+ucfys08yyXwlqu7y2VA8InUF/GbxN7wUeXnik7r9p3RywWYJHMBNlZG
 syuzBbT1ncVscgCN0Ci4TFKwL7UkHz1XQrUY3hw8fUX+N0sh1gO1i4LD4UxGTBd6pQ9czg7e7
 09Ua5cxwHtD+C0SSs2WPpnOjWdXNQK+Wb/LWok0rhF8b7fF/XZv5kXY3Hhqq9/ECaEVL6i/0J
 4Ii8AOo4J/S9UEeNTyNcoNq3zwRnEee5wiZl1qJqsijvNRC5KXzcrNlobRMTDfIE1+M3szONR
 MpFUxUsVZ/dINroyGaVBuah1+EeS7U2NdQGda8YDDVM/o3DPwdDGIkSLRIJTBZGAZ+dqDKtg0
 +RGua6FSLarjBBPmW
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/2/14 =E4=B8=8B=E5=8D=885:19, Nikolay Borisov wrote:
>
>
> On 14.02.20 =D0=B3. 10:13 =D1=87., Qu Wenruo wrote:
>> Due to the complex nature of btrfs extent tree, when we want to iterate
>> all backrefs of one extent, it involves quite a lot of works, like
>> search the EXTENT_ITEM/METADATA_ITEM, iteration through inline and keye=
d
>> backrefs.
>>
>> Normally this would result pretty complex code, something like:
>>   btrfs_search_slot()
>>   /* Ensure we are at EXTENT_ITEM/METADATA_ITEM */
>>   while (1) {	/* Loop for extent tree items */
>> 	while (ptr < end) { /* Loop for inlined items */
>> 		/* REAL WORK HERE */
>> 	}
>>   next:
>>   	ret =3D btrfs_next_item()
>> 	/* Ensure we're still at keyed item for specified bytenr */
>>   }
>>
>> The idea of btrfs_backref_iterator is to avoid such complex and hard to
>> read code structure, but something like the following:
>>
>>   iterator =3D btrfs_backref_iterator_alloc();
>>   ret =3D btrfs_backref_iterator_start(iterator, bytenr);
>>   if (ret < 0)
>> 	goto out;
>>   for (; ; ret =3D btrfs_backref_iterator_next(iterator)) {
>> 	/* REAL WORK HERE */
>>   }
>>   out:
>>   btrfs_backref_iterator_free(iterator);
>>
>> This patch is just the skeleton + btrfs_backref_iterator_start() code.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/backref.c | 58 +++++++++++++++++++++++++++++++++++
>>  fs/btrfs/backref.h | 76 ++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 134 insertions(+)
>>
>> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
>> index e5d85311d5d5..73c4829609c9 100644
>> --- a/fs/btrfs/backref.c
>> +++ b/fs/btrfs/backref.c
>> @@ -2252,3 +2252,61 @@ void free_ipath(struct inode_fs_paths *ipath)
>>  	kvfree(ipath->fspath);
>>  	kfree(ipath);
>>  }
>> +
>> +int btrfs_backref_iterator_start(struct btrfs_backref_iterator *iterat=
or,
>> +				 u64 bytenr)
>> +{
>> +	struct btrfs_fs_info *fs_info =3D iterator->fs_info;
>> +	struct btrfs_path *path =3D iterator->path;
>> +	struct btrfs_extent_item *ei;
>> +	struct btrfs_key key;
>> +	int ret;
>> +
>> +	key.objectid =3D bytenr;
>> +	key.type =3D BTRFS_METADATA_ITEM_KEY;
>> +	key.offset =3D (u64)-1;
>> +
>> +	ret =3D btrfs_search_slot(NULL, fs_info->extent_root, &key, path, 0, =
0);
>> +	if (ret < 0)
>> +		return ret;
>> +	if (ret =3D=3D 0) {
>> +		ret =3D -EUCLEAN;
>> +		goto release;
>> +	}
>> +	if (path->slots[0] =3D=3D 0) {
>> +		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
>> +		ret =3D -EUCLEAN;
>> +		goto release;
>> +	}
>> +	path->slots[0]--;
>> +
>> +	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
>> +	if (!(key.type =3D=3D BTRFS_EXTENT_ITEM_KEY ||
>> +	      key.type =3D=3D BTRFS_METADATA_ITEM_KEY) || key.objectid !=3D b=
ytenr) {
>> +		ret =3D -ENOENT;
>> +		goto release;
>> +	}
>> +	memcpy(&iterator->cur_key, &key, sizeof(key));
>> +	iterator->end_ptr =3D btrfs_item_end_nr(path->nodes[0], path->slots[0=
]);
>> +	iterator->item_ptr =3D btrfs_item_ptr_offset(path->nodes[0],
>> +						   path->slots[0]);
>> +	ei =3D btrfs_item_ptr(path->nodes[0], path->slots[0],
>> +			    struct btrfs_extent_item);
>> +
>> +	/* Only support iteration on tree backref yet */
>> +	if (btrfs_extent_flags(path->nodes[0], ei) & BTRFS_EXTENT_FLAG_DATA) =
{
>> +		ret =3D -ENOTTY;
>> +		goto release;
>> +	}
>
> Isn't this implied bye the fact you are searching for METADATA ITEMS to
> begin with ? Considering this shouldn't detecting EXTENT_FLAG_DATA in
> the backrefs of a METADATA_EXTENT be considered a corruption?

For non skinny-metadata fs, we can hit with EXTENT_ITEM.
So it's still possible to hit a corruption undetected by tree-checker.

But you're right, we shouldn't really hit a data extent here, as
previous loops have excluded all data extents.

But I'm just the guy who want to be extra cautious.

Thanks,
Qu

>
>> +	iterator->cur_ptr =3D iterator->item_ptr + sizeof(*ei);
>> +	return 0;
>> +release:
>> +	iterator->end_ptr =3D 0;
>> +	iterator->cur_ptr =3D 0;
>> +	iterator->item_ptr =3D 0;
>> +	iterator->cur_key.objectid =3D 0;
>> +	iterator->cur_key.type =3D 0;
>> +	iterator->cur_key.offset =3D 0;
>> +	btrfs_release_path(path);
>> +	return ret;
>> +}
>> diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
>> index 777f61dc081e..b53301f2147f 100644
>> --- a/fs/btrfs/backref.h
>> +++ b/fs/btrfs/backref.h
>> @@ -74,4 +74,80 @@ struct prelim_ref {
>>  	u64 wanted_disk_byte;
>>  };
>>
>> +/*
>> + * Helper structure to help iterate backrefs of one extent.
>> + *
>> + * Now it only supports iteration for tree block in commit root.
>> + */
>> +struct btrfs_backref_iterator {
>> +	u64 bytenr;
>> +	struct btrfs_path *path;
>> +	struct btrfs_fs_info *fs_info;
>> +	struct btrfs_key cur_key;
>> +	unsigned long item_ptr;
>> +	unsigned long cur_ptr;
>> +	unsigned long end_ptr;
>> +};
>> +
>> +static inline struct btrfs_backref_iterator *
>> +btrfs_backref_iterator_alloc(struct btrfs_fs_info *fs_info, gfp_t gfp_=
flag)
>> +{
>> +	struct btrfs_backref_iterator *ret;
>> +
>> +	ret =3D kzalloc(sizeof(*ret), gfp_flag);
>> +	if (!ret)
>> +		return NULL;
>> +
>> +	ret->path =3D btrfs_alloc_path();
>> +	if (!ret) {
>> +		kfree(ret);
>> +		return NULL;
>> +	}
>> +
>> +	/* Current backref iterator only supports iteration in commit root */
>> +	ret->path->search_commit_root =3D 1;
>> +	ret->path->skip_locking =3D 1;
>> +	ret->path->reada =3D READA_FORWARD;
>> +	ret->fs_info =3D fs_info;
>> +
>> +	return ret;
>> +}
>> +
>> +static inline void btrfs_backref_iterator_free(
>> +		struct btrfs_backref_iterator *iterator)
>> +{
>> +	if (!iterator)
>> +		return;
>> +	btrfs_free_path(iterator->path);
>> +	kfree(iterator);
>> +}
>> +
>> +static inline struct extent_buffer *
>> +btrfs_backref_get_eb(struct btrfs_backref_iterator *iterator)
>> +{
>> +	if (!iterator)
>> +		return NULL;
>> +	return iterator->path->nodes[0];
>> +}
>> +
>> +/*
>> + * For metadata with EXTENT_ITEM key (non-skinny) case, the first inli=
ne data
>> + * is btrfs_tree_block_info, without a btrfs_extent_inline_ref header.
>> + *
>> + * This helper is here to determine if that's the case.
>> + */
>> +static inline bool btrfs_backref_has_tree_block_info(
>> +		struct btrfs_backref_iterator *iterator)
>> +{
>> +	if (iterator->cur_key.type =3D=3D BTRFS_EXTENT_ITEM_KEY &&
>> +	    iterator->cur_ptr - iterator->item_ptr =3D=3D
>> +	    sizeof(struct btrfs_extent_item))
>> +		return true;
>> +	return false;
>> +}
>> +
>> +int btrfs_backref_iterator_start(struct btrfs_backref_iterator *iterat=
or,
>> +				 u64 bytenr);
>> +int btrfs_backref_iterator_next(struct btrfs_backref_iterator *iterato=
r);
>> +
>>  #endif
>>
