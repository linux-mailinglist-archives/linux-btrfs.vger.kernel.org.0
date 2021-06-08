Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE8939EBC8
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jun 2021 04:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhFHCEe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Jun 2021 22:04:34 -0400
Received: from mout.gmx.net ([212.227.15.19]:42681 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230209AbhFHCEd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Jun 2021 22:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623117758;
        bh=ImQKMmj4nOE/jSsKUU5vVFdNBQhBTH6lmk8yCH6aJDI=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=OQzDE5W8q/2GsCwFYssMBUntYFAzri7lSAoJnpOyGHqasnYjeqTKUqiI+HyaV23k7
         dcGiKGx93TvGFCy0EjkAHlot9PqBaN7ggYfFeeC1pUIFrUMDCQSnDrVVNorGs73duU
         wBqRcTGOcsC2fvH9GFxjwj9lkE2GOhiDmSrS+l2A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M7sHo-1llV7f3Oz4-00515g; Tue, 08
 Jun 2021 04:02:38 +0200
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210605001428.26072-1-wqu@suse.com>
 <20210607170830.GF31483@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: fix embarrassing bugs in find_next_dirty_byte()
Message-ID: <347fa13d-6a8e-9e4f-a06e-b7133fc446c7@gmx.com>
Date:   Tue, 8 Jun 2021 10:02:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210607170830.GF31483@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vn2KkimcAJcFBCAglECAKREKG+CGATvILbDEWCmq9c4GzfJl5se
 R2CKLxzMkV4nPuI83fPGqh3+bXFEA83il0VpRL6b3hYJ8bA4f4yCssHe9jbia/HOBtUaLX4
 eyX1xcX9zwLfob3RtyD0VoH8WYwVANq13Mrjnpa+sO20uGDpyXsS/cHdyuKtxHpt0Nresav
 JKyVSDatb1C/royArJUxw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/b+Z4RS9hxs=:eU3CeiiN7wcfbk19JNzFpC
 FzfyJRrSHc7XvtaIfzlzngOawfe393KM9T+Vzigli9U7uTFLKWSYIrnMokPLzwqDrmvfMyC/z
 rHM4CX9W+cWr6H9L+SsQ8VX4GaX/PHqNM5FKEuFAcj8brfIFHSIoiTG4dropC/k1R6aO0ROYc
 Rfhr/L73eOsG1oX17SgMceUefaEB2G6Ub/aKvoEEa7A7boOdcuvDhIYXZyr5l1rzcIWeCfSJk
 NSYhRV7k7Dw3lISo4OnxnplNCzJ+pVVZCJiAbr9esyNkAejiL04b/qyaDarl+LeX5jTGESpSd
 /CDZIXr8cV9WCSgSFe91VV+QBRr2nhMtd7nJWrHxker0+TmaiD5ypBZwhsvGcBbLc/7N8999l
 PjCPrYUC32+6i9yXFwgxVGdiEweKQWH5WCR0pHaH3WRuPSUolvVex7E2p4WBLGhmFXUuhxFB5
 +nXuUNtp4xhno3CqFdYz7DqEXONCGtWB8jV0hkmhwIn3xcKAHo6/ix5FtrcHx7j+j9nkC/pYp
 RTZ0eg/p/a77knpLBVCeHcCXKRQeq4gv5gfrLldlC9h7mbFj1Av8o3fkuNSTwBk31KXqAA6h4
 dlQXdrJopsXsN90QOFyR5QiEy53tMIgFHVMH48L+kPuPtmHIDi/gFTf04vMclDpxzRpNChptR
 NT7s4uZn5ygVLAZW0JTac80YHzncGC1B0+W7/7zcSgZuKb91UbCveGJduri0KqvhQ36OHyzfz
 yJ4plhmATyBGn8lauNkwecN935OCeu54J5f2VKEFP0Zi9/Npaf46tn5q9MebX6HswBQfRpytB
 MkrS2ayOlElyL+H3Zef9BkGOg2yUS2O/OtgVIhmE/ts+mf7GFddpoMUHULjWIrNSADS1IbWUU
 F//NNJWVax0JRzoPgY7L4NJhDwkvE96FVYuUsXaggjGFJF+WSZxYDJOESvRv26kG97OBWbFAc
 04ZP00Wfcvcx8YxGuI9LBefqS1xlTDS9HbBwGY3cbe/iWQY5tVFZhiYaPk0Rxetgy+rnX+zSd
 FjQ/GynbPs9SXoAZF7d9V9VHmnwMKV6MDbypWMl/na0lVGgrZYY9VeVuQDwqoQZiaGpnZG0yO
 VGtCsPUGsTQC8kyevPYfcKqW1xGd/wfZVVRFZna6hChXuDWXUitPqayLw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/8 =E4=B8=8A=E5=8D=881:08, David Sterba wrote:
> On Sat, Jun 05, 2021 at 08:14:28AM +0800, Qu Wenruo wrote:
>> There are several bugs in find_next_dirty_byte():
>>
>> - Wrong right shift
>>    int nbits =3D (orig_start - page_offset(page)) >> fs_info->sectorsiz=
e;
>>
>>    This makes nbits to be always 0, thus find_next_dirty_byte() doesn't
>>    really check any range, but bit by bit check.
>>
>>    This mask all other bugs in the same function.
>>
>> - Wrong @first_bit_zero calculation
>>    The real @first_bit_zero we want should be after @first_bit_set.
>>
>> All these bit dancing with tons of ASSERT() is really a waste of time.
>> The only reason I didn't go bitmap operations is they require unsigned
>> long.
>>
>> But considering how many bugs there are just in this small function,
>> bitmap_next_set_region() should be the correct way to go.
>>
>> Fix all these mess by using unsigned long for the local bitmap, and cal=
l
>> bitmap_next_set_region() to end all these stupid bugs.
>>
>> Thankfully, this bug can be easily verify by any short fsstress/fsx run=
.
>>
>> Please fold this fix into "btrfs: make __extent_writepage_io() only sub=
mit dirty range for subpage".
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/extent_io.c | 38 +++++++++-----------------------------
>>   1 file changed, 9 insertions(+), 29 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index d6a12f7e36d9..77b59ca93419 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -3877,11 +3877,12 @@ static void find_next_dirty_byte(struct btrfs_f=
s_info *fs_info,
>>   {
>>   	struct btrfs_subpage *subpage =3D (struct btrfs_subpage *)page->priv=
ate;
>>   	u64 orig_start =3D *start;
>> -	u16 dirty_bitmap;
>> +	/* Declare as unsigned long so we can use bitmap ops */
>> +	unsigned long dirty_bitmap;
>>   	unsigned long flags;
>> -	int nbits =3D (orig_start - page_offset(page)) >> fs_info->sectorsize=
;
>> -	int first_bit_set;
>> -	int first_bit_zero;
>> +	int nbits =3D (orig_start - page_offset(page)) >> fs_info->sectorsize=
_bits;
>> +	int range_start_bit =3D nbits;
>> +	int range_end_bit;
>>
>>   	/*
>>   	 * For regular sector size =3D=3D page size case, since one page onl=
y
>> @@ -3898,31 +3899,10 @@ static void find_next_dirty_byte(struct btrfs_f=
s_info *fs_info,
>>   	dirty_bitmap =3D subpage->dirty_bitmap;
>>   	spin_unlock_irqrestore(&subpage->lock, flags);
>>
>> -	/* Set bits lower than @nbits with 0 */
>> -	dirty_bitmap &=3D ~((1 << nbits) - 1);
>> -
>> -	first_bit_set =3D ffs(dirty_bitmap);
>> -	/* No dirty range found */
>> -	if (first_bit_set =3D=3D 0) {
>> -		*start =3D page_offset(page) + PAGE_SIZE;
>> -		return;
>> -	}
>> -
>> -	ASSERT(first_bit_set > 0 && first_bit_set <=3D BTRFS_SUBPAGE_BITMAP_S=
IZE);
>> -	*start =3D page_offset(page) + (first_bit_set - 1) * fs_info->sectors=
ize;
>> -
>> -	/* Set all bits lower than @nbits to 1 for ffz() */
>> -	dirty_bitmap |=3D ((1 << nbits) - 1);
>> -
>> -	first_bit_zero =3D ffz(dirty_bitmap);
>> -	if (first_bit_zero =3D=3D 0 || first_bit_zero > BTRFS_SUBPAGE_BITMAP_=
SIZE) {
>> -		*end =3D page_offset(page) + PAGE_SIZE;
>> -		return;
>> -	}
>> -	ASSERT(first_bit_zero > 0 &&
>> -	       first_bit_zero <=3D BTRFS_SUBPAGE_BITMAP_SIZE);
>> -	*end =3D page_offset(page) + first_bit_zero * fs_info->sectorsize;
>> -	ASSERT(*end > *start);
>> +	bitmap_next_set_region(&dirty_bitmap, &range_start_bit, &range_end_bi=
t,
>> +			       BTRFS_SUBPAGE_BITMAP_SIZE);
>> +	*start =3D page_offset(page) + range_start_bit * fs_info->sectorsize;
>> +	*end =3D page_offset(page) + range_end_bit * fs_info->sectorsize;
>
> Makes sense. We want the u16 for the storage but the more complex
> calculations could be done using the bitmap helpers, and converted back
> eventually.
>
Talking about bitmap, I think it's also a good time to consider the
future expansion.

- Extra sectorsize/page size support
   We want to support things like 16K page size, in that case we
   only needs 4 bits for each bitmap.

- Better support for nodesize >=3D page size case
   If we can ensure all of our metadata are nodesize aligned,
   we can fall back to existing metadata handler.
   This reduces memory usage, and can support 16K page size better.

   But the cost is, if chunk is not properly aligned, we will reject
   certain extent buffer read.

My current plan is to make btrfs_subpage bitmaps to be fitted into one
longer bitmap.
And in btrfs_info, introduce some structure to record which bit range
are for each subpage bitmap, the range will be calculated at mount time
using both sectorsize and page size.

E.g. For 4K sectorsize, 16K page size, uptodate bitmap will be at bits
range [0, 4), error bitmap will be at bits [4, 8).

Then we can make all subpage bitmap operations using real bitmap operators=
.

Those are all ideas though, as I'm still working on compression support
for now.

Any feedback will help.

Thanks,
Qu
