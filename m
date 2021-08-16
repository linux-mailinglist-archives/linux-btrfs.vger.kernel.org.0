Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F1B3ED1B5
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Aug 2021 12:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbhHPKM5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 06:12:57 -0400
Received: from mout.gmx.net ([212.227.17.22]:48519 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235691AbhHPKMy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 06:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629108739;
        bh=0ROUoagnyE+z3lteRtvwRol3lihPt79D6+awrpvqcyA=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=UD7QMLezzApTb9b9szAwGts+mj7sI+3BqYOHBx5R4IlYLHmI5Jwe7wURbzCndG9OM
         ScLAd+04dFYT5J6oeyOjQEHLFbFHnDJGOawjfLTWhj7VQhskXF6RtUNxQicUg8CZux
         T6oAHV5OvCK5TTxPPSJmC3I9S74qtb+1jD03E240=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MacSY-1mm9Gb0tmE-00c6bB; Mon, 16
 Aug 2021 12:12:19 +0200
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210816060036.57788-1-wqu@suse.com>
 <20210816060036.57788-2-wqu@suse.com>
 <35622671-e0e3-6600-cfbc-1e48da29b806@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 1/2] btrfs: introduce btrfs_subpage_bitmap_info
Message-ID: <8ac274cc-18ab-55eb-f098-fa359841cfc8@gmx.com>
Date:   Mon, 16 Aug 2021 18:12:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <35622671-e0e3-6600-cfbc-1e48da29b806@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eAKxifAzM1j2G5mndbfCbts6UcvcNbC7HJjNnRsfScC1V0pN4wt
 jDcx55zobjUVxroOABmPA8aovVxxLKkDf/dZA7AtnSMV1JMf2OQWl2Z98k3w0mOGAl3nqHH
 EdJ12MkED30TYqYQxQJQmeuobZoEOB0XW40Cbfo65O2nNPhAYhSASXVUIwJ9bqNeW9NxOow
 1TbPmF9y5NVIWRymuzdFQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:m4tGoQWch2w=:aFUlNes4w5FU/OlN922c8g
 oIfuf1OGDVoWUxb3iwbqlF3Qg3IyuA4YuXrYUwkRcYGl9STgVa1ptAZPoCPmi66q1aPe4KC4O
 U+eyhYQSuIRl9CUAOV2teGAnHAGREXuc0FrW9Um2ggdAADsc2+vr1t0Ihsps2PhFXGwyVzsRr
 TDLDFRX4n0/j0Br+pzlThFmR7P6+AvY/Sf0pzd6tRSyq/h+/LWSzIwBHjVYCtgqFJ9uEv/k+r
 KIhAo1Lzh8N6OlN8M1Fh5IsPYlamuKLYknBmJcEqMVyS05Q3bDKDZrFQ59YnxhGw6X58xURjE
 fT0IdeiLMS4nTOlsLLHNO0jh0+92rDU6MheApQsuxLaYKMux7rp86o9lczrTTA2zI6Htpq0fX
 Ay+/O2QKI0kl+E+Cjg/y1dWrXzkX4qd7tHcsvyN4LEH5QTr/35zTaoierP14O8aofhpEGLNTA
 83N1ZR+mBD30OxgTB9Zjx8rnr1+YZmxlCasFI7eXrpvizA8wDRN6omqxAlG0BMYMHGaUplxjk
 4uRrkf1/nlqe9cU6X5bhw+XwQm6JN5hP1Hty6p80YpKlVpVSX3pgl//OH8Dc7gIOBapMT92NF
 z7loX62GK9rpV9n0dJKfwTgqhLgrit9eXAMoKIIeYmcMjFi3aLxgPksUG2BSZLVteEnKUAeiH
 l+AgADdWvv6bJotjWBDepd3tA/zQ1/KuyhmF0bNA7L8IIjuwbqSly9bZ/5I+CpZGqrUsvtc42
 gal7rH4cnB0KPXSDypRbYmOb2BEpI1v1JjKR172CJaCImiBPsSUDWh7FuO+Axh3NfJr7CdEhS
 xyiRlI8i5IWROjP2PHZRwIcavsDcx4caN165QRNdmkQ0v1Zhtwsl8CLof6VKNNSN3r12wm3/j
 AlTC4A0gq3UkD/2qssrRj4E1FHccopkJlegcSw1Ul4xs7CIj0R2kVzM5u6S9pIjGvi80e1JcS
 uzgv99aXOgRSupUkjUi981/jt55U31N0XSyvFt/FlX6eufMOzJSsODpcwnDQc0S1RCTrAM03C
 6sZmPgHIsxLuILwDxIGjIhhxzTuTRjHH/ta7tC/cKivR+UIw7epdeaQ3uiWkel6XCvvM0/K0p
 FzJvNWacUpOcNv6/t71gBCgYTOpY7rH31lbR+8Rquf+uAhSjEuwzqQB8w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/16 =E4=B8=8B=E5=8D=885:28, Nikolay Borisov wrote:
>
>
[...]
>>
>>   	if (sectorsize !=3D PAGE_SIZE) {
>> +		struct btrfs_subpage_info *subpage_info;
>> +
>> +		ASSERT(sectorsize < PAGE_SIZE);
>
> nit: Simply make the check sectorsize < PAGE_SIZE and that renders the
> assert redundant.

I guess that's the way to go.

Since I don't believe we will support multi-page sectorsize anyway, we
don't need to bother sectorsize > PAGE_SIZE forever.
Thus we can forget the sectorsize > PAGE_SIZE case.

[...]
>> +
>> +	subpage_info->total_nr_bits =3D cur;
>
> So those values are really consts, however due to them being allocated
> on the heap you can't simply define them as const and initialize them.
> What a bummer...

Yeah, that's the limit of C.

>
>
> On the other hand the namings are a bit generic, those are really
> offsets into subpage->bitmaps. As such I'd prefer something along the
> lines of
> writeback_bitmap_offset
> ordered_bitmap_offset etc.

The *_bitmap_offset seems a little long, especially in the 2nd patch
we're already introducing too many new lines just to handle the *_start
naming.

Especially all these members are used with thing like
fs_info->subpage_info->uptodate_start.

What about the name "uptodate_offset"?

>
> Also I believe a graphical representation is in order i.e
>
>
> [u][u][u][u][e][e][e][e][e]
> ^			  ^
> |-uptodate_start	  |- error_start etc

That looks awesome.

>
> Since it's a bit unexpected to have multiple, logically independent
> bitmaps be tracked in the same physical location.

That's also I'm concerning of.

I haven't seen other code sides doing the same behavior.
IOmap just waste all the memory by going full u32 bitmap even for case
like 16K page size and 4K sectorsize, exactly I want to avoid.

Thanks,
Qu

>> +}
>> +
>>   int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
>>   			 struct page *page, enum btrfs_subpage_type type)
>>   {
>> diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
>> index 9aa40d795ba9..ea90ba42c97b 100644
>> --- a/fs/btrfs/subpage.h
>> +++ b/fs/btrfs/subpage.h
>> @@ -11,6 +11,32 @@
>>    */
>>   #define BTRFS_SUBPAGE_BITMAP_SIZE	16
>>
>> +/*
>> + * Extra info for subpapge bitmap.
>> + *
>> + * For subpage we integrate all uptodate/error/dirty/writeback/ordered
>> + * bitmaps into one larger bitmap.
>> + * This structure records the basic info.
>> + */
>> +struct btrfs_subpage_info {
>> +	/* Number of bits for each bitmap*/
>> +	unsigned int bitmap_nr_bits;
>> +
>> +	/* Total number of bits for the whole bitmap */
>> +	unsigned int total_nr_bits;
>> +
>> +	/*
>> +	 * *_start indicates where the bitmap starts, the length
>> +	 * is always @bitmap_size, which is calculated from
>> +	 * PAGE_SIZE / sectorsize.
>> +	 */
>> +	unsigned int uptodate_start;
>> +	unsigned int error_start;
>> +	unsigned int dirty_start;
>> +	unsigned int writeback_start;
>> +	unsigned int ordered_start;
>> +};
>> +
>>   /*
>>    * Structure to trace status of each sector inside a page, attached t=
o
>>    * page::private for both data and metadata inodes.
>> @@ -53,6 +79,8 @@ enum btrfs_subpage_type {
>>   	BTRFS_SUBPAGE_DATA,
>>   };
>>
>> +void btrfs_init_subpage_info(struct btrfs_subpage_info *subpage_info,
>> +			     u32 sectorsize);
>>   int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
>>   			 struct page *page, enum btrfs_subpage_type type);
>>   void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info,
>>
