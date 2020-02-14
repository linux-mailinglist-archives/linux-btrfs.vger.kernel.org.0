Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEB815D4D6
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 10:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgBNJfr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 04:35:47 -0500
Received: from mout.gmx.net ([212.227.15.18]:43487 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728513AbgBNJfq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 04:35:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581672940;
        bh=uwIkdjRwuSbYg0f+qTJRXdEKJPIlvB3m+fquz2k3fJo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=KwzfKYVsSC3AQnm9bu5SOIyiAjAEjVpfWTrYoxf9eKWPVUuF1qg1Yul/mmZ+0nOLW
         jbCr5+PuMPHTa//i93w0zEY+Y0XmXaiS9dIcvL9c9P5fF8UoV9k7fVWw+pTy/sWJaS
         dws/Sc6QNM57CgAQ9OtP+/l+4YdklOJLTKkTMTL0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N3siA-1jSy9T2GNU-00zliv; Fri, 14
 Feb 2020 10:35:40 +0100
Subject: Re: [PATCH v2 2/3] btrfs: backref: Implement
 btrfs_backref_iterator_next()
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200214081354.56605-1-wqu@suse.com>
 <20200214081354.56605-3-wqu@suse.com>
 <4c5cae62-d74e-7ce4-2ed8-4cfc91f19059@suse.com>
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
Message-ID: <950d7c55-0e18-e710-4d2e-224b7bf054f2@gmx.com>
Date:   Fri, 14 Feb 2020 17:35:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <4c5cae62-d74e-7ce4-2ed8-4cfc91f19059@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vOJTGRsIQFuusOpwkNozf2WFEcUM763LEH0KiZONrCUoQmkolSF
 KKYU0RGjRDu1JmDKSfa68QKNwTVZWqEV3DAzX0HWmLmcy46HjXZpGMYh7YxxTHtDGDbj9sn
 g9AcPjh2x35dKkN4pslwgY0Dno0F9FnQ8QiiSc/eEYhk/6htMaoTV5oK/JP4ITAhxP9zL5J
 REAsQaEGU+erTeBM66zUA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:L0RP45vtQ7k=:0QFPtxoV+Qocc8X2Csonf5
 mP99zdobMZxOVq/scuU421X6suDbiX/xrk0ocdEvzF4NA7HtMGHg8b2wdAVLUyaA7tH9zxNPz
 l62UUG/UtZojoEvxREUAb0s7Y9ZPysJTRLSPkhQuPhoE0OXY41QQThTagY4aRihqe/HhGKa0v
 mHQB2mIEaz1Mua4TqOIKJexM7B+ZtQDNML6ZAQwJognwHmgrIF12tt3YP/C8SC+J1X29HvzR4
 ct6RWrKpyil2zkBeKyr9CgJH3nFOlD8V9EFEnO8JowfrpJRYQhRbTEd5sAqLahaxsLwQSgC5u
 Jlet2Qszq5AOZij8CL/oEC/b5CVgc+dPo4Ba2l/n/uG2EvmLYKCn0E8SxCtpYgZy+BGI++MDl
 skpK6i41suCkdKVMBeYX9fHOH1SkGiz2DKg0M3tJm45LwWnAcxnWxlzloaJD5zApQIT62zc8p
 Oi2KWEO8PANrGfB2Wr8uBdIdouZaHk3RXGAdZP0h8Gr7Pqr8i36K+dF8SxFlAFfUkQUZsyEaJ
 Bk2mGkM2T59y52g/SjMnuEO1AqFwl6Ql0oyl0uBRyOV+iz6VBV+ZLGgV5FdyHx7eBByiTRtI4
 kg9Qm2BbhDFkVL1qLsMDHutBzl08NbNipZWgt30NvToiA7IqShkenpRryT4UiE28JxtuE+IuK
 gRPet4w5Gowdd7feU37VRqguP5z0f3XwImpffP9fzkl31LbHXOmlRsVC/pKp3oHi3sRxYJLRF
 JwE/hF02+Uj3rDzez7fKlJDnwXspYCcvlmJ8dr0OIu71X813jpHtd+Cws1c/6+sWAxWK7JG+7
 aumtD/UvH4uHt+IA7G0RWCYoqoVG7zgYDp2BGX7Kpjo3An9hY/hwY1UDvXCdAWt1Iiiad9Hyj
 WJT4mS5zzEJarC+T+RC/++8eJ2ws+E4Wcqio03FK4xwyw1S3a6AwwdqLqeLLP/F3yzjQuBfKv
 FeUJ44Q+YUE84VPjVRLI0U+iApBvhnPzCI/kWwFYgAy1oIIU+4qN+9W+nlSw8nf6gUwNYWcYC
 FFMTcX2uH7c5RK20LP+2NRtbH3n4jsLzaNFlt85fdyd1Iezz/ilttwofvq7GrueY3uf/5Huqz
 vlHXmmd42PIRbPT75PDRbR4yKfpNW6uysfHFmcpMiNLnoQwRFdQuPkhkqXGN8tQ/w8qSYD5lw
 ph0Q7YnBLtZ6G+YjoSRxlOB8WkFELjq5UtjM7rZ389abIhBgHjVmO0W8pwbXAhlCWb5iXWhFm
 HWak2Bxe6qbgA1z/i
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/2/14 =E4=B8=8B=E5=8D=885:25, Nikolay Borisov wrote:
>
>
> On 14.02.20 =D0=B3. 10:13 =D1=87., Qu Wenruo wrote:
>> This function will go next inline/keyed backref for
>> btrfs_backref_iterator infrastructure.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/backref.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>>
>> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
>> index 73c4829609c9..c5f87439f31c 100644
>> --- a/fs/btrfs/backref.c
>> +++ b/fs/btrfs/backref.c
>> @@ -2310,3 +2310,51 @@ int btrfs_backref_iterator_start(struct btrfs_ba=
ckref_iterator *iterator,
>>  	btrfs_release_path(path);
>>  	return ret;
>>  }
>> +
>> +int btrfs_backref_iterator_next(struct btrfs_backref_iterator *iterato=
r)
>> +{
>
> make it a bool function.

Even when we could hit error in this case?

In the next patch, you would see we handle end of backrefs and error
different.
Thus I don't think it's a good idea to make it bool.

Thanks,
Qu
>
>> +	struct extent_buffer *eb =3D btrfs_backref_get_eb(iterator);
>> +	struct btrfs_path *path =3D iterator->path;
>> +	struct btrfs_extent_inline_ref *iref;
>> +	int ret;
>> +	u32 size;
>> +
>> +	if (iterator->cur_key.type =3D=3D BTRFS_EXTENT_ITEM_KEY ||
>> +	    iterator->cur_key.type =3D=3D BTRFS_METADATA_ITEM_KEY) {
>> +		/* We're still inside the inline refs */
>> +		if (btrfs_backref_has_tree_block_info(iterator)) {
>> +			/* First tree block info */
>> +			size =3D sizeof(struct btrfs_tree_block_info);
>> +		} else {
>> +			/* Use inline ref type to determine the size */
>> +			int type;
>> +
>> +			iref =3D (struct btrfs_extent_inline_ref *)
>> +				(iterator->cur_ptr);
>> +			type =3D btrfs_extent_inline_ref_type(eb, iref);
>> +
>> +			size =3D btrfs_extent_inline_ref_size(type);
>> +		}
>> +		iterator->cur_ptr +=3D size;
>> +		if (iterator->cur_ptr < iterator->end_ptr)
>> +			return 0;
>> +
>> +		/* All inline items iterated, fall through */
>> +	}
>> +	/* We're at keyed items, there is no inline item, just go next item *=
/
>> +	ret =3D btrfs_next_item(iterator->fs_info->extent_root, iterator->pat=
h);
>> +	if (ret > 0 || ret < 0)
>> +		return ret;
>> +
>> +	btrfs_item_key_to_cpu(path->nodes[0], &iterator->cur_key,
>> +			      path->slots[0]);
>> +	if (iterator->cur_key.objectid !=3D iterator->bytenr ||
>> +	    (iterator->cur_key.type !=3D BTRFS_TREE_BLOCK_REF_KEY &&
>> +	     iterator->cur_key.type !=3D BTRFS_SHARED_BLOCK_REF_KEY))
>> +		return 1;
>> +	iterator->item_ptr =3D btrfs_item_ptr_offset(path->nodes[0],
>> +						   path->slots[0]);
>> +	iterator->cur_ptr =3D iterator->item_ptr;
>> +	iterator->end_ptr =3D btrfs_item_end_nr(path->nodes[0], path->slots[0=
]);
>> +	return 0;
>> +}
>>
