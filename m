Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 661E8161121
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 12:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgBQL35 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 06:29:57 -0500
Received: from mout.gmx.net ([212.227.15.19]:38885 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728926AbgBQL34 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 06:29:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581938990;
        bh=h0kzELxuH2CQbFn+62LHDHuj4+MbKdIzBbDifYfopbc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=iS+2t3asZYkBXBX++3ZsuKRNVEGBZEZ+nomrRoPFX6Z0BKOQgKptGk5nKQ7fZLA8w
         WqnxXREObU9ay2jvl+SoYO4AX6FqLMncz8KLwH8Lvp1wXAc/kAGKKznfGsMZw3845c
         oEbEVywJIaGuv8wHEujVkEJxNkhYbanzMrBwFdqI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MXXyP-1ixkv41LPb-00Ywnu; Mon, 17
 Feb 2020 12:29:50 +0100
Subject: Re: [PATCH v3 2/3] btrfs: backref: Implement
 btrfs_backref_iterator_next()
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200217063111.65941-1-wqu@suse.com>
 <20200217063111.65941-3-wqu@suse.com>
 <e5e5ba05-2f9f-d8be-63bb-9bcd3e0c090e@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <2cee1b97-b6a3-bffd-8cb0-cb7d903497ca@gmx.com>
Date:   Mon, 17 Feb 2020 19:29:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <e5e5ba05-2f9f-d8be-63bb-9bcd3e0c090e@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:en2syb0ScueBX1CfYpm/HYcj7J3/u7ameP7oR6PJAgmYC+JfBRm
 aTGwJMYDXeuEAbC97E1SXwJ7axqNMt4HCuiPEDgKseEIg5DexAlj3dgk3HKO8WQzP20Fb5F
 7NzC7YqJtxlO3ZpEFA1KwrfBAcIQexzJN9ljhDgjE36m/G8XnPz6lQfCkvyaiYG5cRsEDDk
 208BYpwV+6DCB05PHOVxQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yq4/bqQZeh0=:cX4XUer+vVIiUUIq7aY5vZ
 1Lj958j94lKxHdvk4Rlgf4hw+mPJ4kI+qucbT86O8zQbgadfnw27IzC6ojO9Nr+kMHDQdcT9T
 1IIkusevFGuy20jnZVly7czrF/maPhS/XJfDPn2Nam4SjRtyB87rbXFF9VRRNdbz1PKWiYw0B
 KL50CxCLpDowfCz2T/iPIXHrueqPsJcIu/YeUiRU2XLtsHKG7bXJOOtrMTV3abwwtbtO6iXB3
 CgUgGkOXSyT7jE0YxYi0uX9C5/30L8qAL2+sy0G1Q7geAMOmYUu7nMe8TUoEAWDo2Azhopvpr
 4FV9wjF1z2XX1a5+yFnCbVYMU9YH7BngKKKd3BZ/tGIQTRqSZw6Ioly2+XwtXNj6c0cy7ezLL
 ztu/z9BpDdEtCb/Cduk4Wpo1qkS9vjc7/FHB1SMqQkcoAPSDBddKy2Xm9ibKfubAa2iju14mr
 OtrbjecJ8uu0+XPBFzBgUHCJfk18ZcPJsB4GTBXLGr6gYtyKe81AQs6PEIm8FahofFP0MUZF/
 yS2jv3G0S3xi1PRgBbNjhydwP1eTBlatYAyeCk0GhCzr1vl+aNc1UjiBHVM21jf39PXl0QUSz
 ApfKP7j/y7rPPRyPdpsQCnLUeZVaYpDKUhMeuAiQt9+LsQ/jW90MRIb/0+VQQWaFC+T2L/4Fn
 fFC/xDCGiQC0gInY8vtCrDANJ9MrZdyQJNgI4AYUYF55bvBKVrSfgpDYwP4DCr7C/umBtdF/Z
 8vQPOhDVU9HcSIMEFziqNqLbtWlkhsjVOmJp/zQIKKfxg8c1tJt3PYTnALE1OqCTHVi5w8Lrz
 drFWKKfTzF8ypZQhStAqE2k0Sq8snkteu7c+MD7sDC/PZX4j+pHMV31NS9c/s+zT0PirHk86d
 ST54BPrsbPpmxe3FtfdZzjrit25OPlX5SzUdGQ7J20zXPublDlTIgfcCaLdHyi4fKjVi6goAa
 xrTaNFQ2cO822deufqKqyvm3PoTLc4wZ2XCjdzVAI3HVsLjY+KEXajpNQ9tW73RvLCFaA+xrk
 QPUfpDc6uI5YqS4nHkWk62feFwH4vzEL5nbwIwfZbAcrsR0bkcVuUPB4H+iwsYOkNDm/kSec0
 0Tv6VnVtfZBy8jrDT8dRbHL9bwxW8H6ZeWcU3WWETfMrsFMw+i8dR6bgbYokoBo5YiwlZGarX
 Q/phnRqfPbJhZM6KfI/Xy8ULqPy5sjE4r2HbAXp8kO1pmgxaZ7QRPRMN+NpriJK5TDX0RXUTe
 xJrwGDyJSXDYqDMlF
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/2/17 =E4=B8=8B=E5=8D=886:47, Nikolay Borisov wrote:
>
>
> On 17.02.20 =D0=B3. 8:31 =D1=87., Qu Wenruo wrote:
>> This function will go next inline/keyed backref for
>> btrfs_backref_iterator infrastructure.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/backref.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
>>  fs/btrfs/backref.h | 34 +++++++++++++++++++++++++++++++++
>>  2 files changed, 81 insertions(+)
>>
>> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
>> index 8bd5e067831c..fb0abe344851 100644
>> --- a/fs/btrfs/backref.c
>> +++ b/fs/btrfs/backref.c
>> @@ -2310,3 +2310,50 @@ int btrfs_backref_iterator_start(struct btrfs_ba=
ckref_iterator *iterator,
>>  	btrfs_backref_iterator_release(iterator);
>>  	return ret;
>>  }
>> +
>> +int btrfs_backref_iterator_next(struct btrfs_backref_iterator *iterato=
r)
>
> Document the return values: 0 in case there are more backerfs for the
> given bytenr or 1 in case there are'nt. And a negative value in case of
> error.
>
>> +{
>> +	struct extent_buffer *eb =3D btrfs_backref_get_eb(iterator);
>> +	struct btrfs_path *path =3D iterator->path;
>> +	struct btrfs_extent_inline_ref *iref;
>> +	int ret;
>> +	u32 size;
>> +
>> +	if (btrfs_backref_iterator_is_inline_ref(iterator)) {
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
>
> This if could be rewritten as:
> if (btrfs_backref_iterator_is_inline_ref(iterator) && iterator->cur_ptr
> < iterator->end_ptr)
>
> what this achieves is:
>
> 1. Clarity that this whole branch is executed only if we are within the
> inline refs limits
> 2. It also optimises that function since in the current version, after
> the last inline backref has been processed iterator->cur_ptr =3D=3D
> iterator->end_ptr. On the next call to btrfs_backref_iterator_next you
> will execute (needlessly)
>
> (struct btrfs_extent_inline_ref *) (iterator->cur_ptr);
> type =3D btrfs_extent_inline_ref_type(eb, iref);
> size =3D btrfs_extent_inline_ref_size(type);
> iterator->cur_ptr +=3D size;
> only to fail "if (iterator->cur_ptr < iterator->end_ptr)" check and
> continue processing keyed items.
>
> As a matter of fact you will be reading past the metadata_item  since
> cur_ptr will be at the end of them and any deferences will read from the
> next item this might not cause a crash but it's still wrong.

This shouldn't happen, as we must ensure the cur_ptr < item_end for caller=
s.

For the _next() call, the check after increased cur_ptr check it's OK.

But it's a problem for _start() call, as we may have a case where an
EXTENT_ITEM/METADATA_ITEM has no inlined ref.

I'll fix this in next version.

Thanks,
Qu

>
>
>> +	/* We're at keyed items, there is no inline item, just go next item *=
/
>> +	ret =3D btrfs_next_item(iterator->fs_info->extent_root, iterator->pat=
h);
>> +	if (ret > 0 || ret < 0)
>> +		return ret;
>
> nit: if (ret !=3D 0) return ret;
>
> <snip>
>
