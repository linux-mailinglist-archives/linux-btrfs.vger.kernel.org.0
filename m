Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31A940410E
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Sep 2021 00:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbhIHWhW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Sep 2021 18:37:22 -0400
Received: from mout.gmx.net ([212.227.17.20]:37247 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229997AbhIHWhW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Sep 2021 18:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631140565;
        bh=gL07eQyYezpnTlrdlrrmdchsgFri+AcHDiRhzStt2XY=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=SK4ay6dyG3UOMRrZpnvDtY4pKPjK6rrvVoS8Z65eiaRzwywfOOBlGJVgp4PzP5DyS
         tMmamRgeacDTYdTqF37x/TuaQRRhoDBO45FYz8bghRYizowknM0pLMMfa4djyq9Mp9
         ChsEz1t0J6Xt7yFeeYtJsq6+Da6bc+UsMkDSnz6g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MA7KU-1mDbWo1CbC-00BeEM; Thu, 09
 Sep 2021 00:36:04 +0200
To:     Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20210803055348.170042-1-wqu@suse.com> <YTjstM7duaGeAgwK@zen>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: don't call end_extent_writepage() in
 __extent_writepage() when IO failed
Message-ID: <ab98bc8b-851f-0cca-594a-8638359e07c0@gmx.com>
Date:   Thu, 9 Sep 2021 06:36:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTjstM7duaGeAgwK@zen>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MeB/lZ58G76Q7wIj4qx++c9ETCxwXm7FxeILVzuK/7fu23wqvD+
 aNFb50eGKtB5Bf4cMxZN6AwdyAJjQ1hC0OvFptDjNtMKNlzQrXqvc0FTTRB3UmkUbJDDlJC
 bz16UTj83ughXA4ugikmq2CdvlwWbJAQM9SBf9nZBkvTmvGsMGy6VbJyinlEGiMAZhkIfjW
 JUzWYPTpe6z5/cpfxHhZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:B+/kvYV/co0=:+Qb3vE7yr9RoT/DUS0K833
 /Mof9hVHwX6fGI+xDRt/l8/RlEdDSSyX2ZYsTraUbb01Yp/jboyrn1iZh9M9lHAJNcE4r1Oao
 eeXYQah5GvIA6f3TF3Oy8JgiPZPQn+rzDN3uI9EaWTQ2XxQE7PQ/+KNhuNRQGLXQs/CIvbJfe
 nE3Oa4gd6HT2ccLu8nfUd0R9D8pTa262M9BW71oJpMOt7IFNzURji9mj3Oppxh/M1znoBZH3t
 VXOBzIrtwYEiKGD5+tYZKVwVMlwroi4p/7DC7qvV18kmI7dL679ysrydtY4DAp7b3SHtQm80A
 77EAxWaFKiZSlE9a9ownniDWfqY0ULz1qQbxM9d0SW6Ym0iXy+uK974UYIytKJtqeWLLOyjJy
 HbgmNAU3JJ2h7oMmqrg3iOyu2UhbwbXNKd0hdeHQWkVn7hQ8dkKKKXEvWfnKUgsJUsqSfp4UP
 TWH51Pn/o7ZF3/bpWUwNo3fw89/27FGIybe14l6x53LiSOplysCizloDAbyuZPNwngW3mIxBZ
 RmtFQuZ7EcoFONlDoDC6OxoRfNTqflOa5AHdKvQwuBUMor4epqcUc10KmAL2xN+H1I1vMsRAk
 7CiGNRtpQR/WtAgi16HUdpcjp+A0nffvY5Pi7mS8B2eQHpBE+8qotJU9QpFveAm4sqKYZqZVY
 bVFs+lr6ttrAZMzqwB+SMUCTg/2NZAJCEcx85rcdLWF90uXoQDr3Wxqkyk8tVQ7TOcuS2njj5
 ztXI4LT2nC8TnaTlBt3mUIDF3Sk6VYC99TpsRV13TEQZEo/o9/B1FckH9yL6pfRnCyROgq6mY
 fO/7Z37gYJcwehqV56CsG5Zxk03/bfr22NugXNWve9S3t1LN1j5OPizdGgdLBX5Be7GvUU0l5
 U1pOAOnPTR3jK+QmvVntNc25HC1oaX5f61Qu+MKV5hWuHMDh/kTs7c2MvVjpKfQW52Jw93vft
 hOu6sEnKH7tDzo5iWb6OoAD1L+Erp22hwP5OqXJVKYUhbJlVXx2fBqVN4ooMDQXKULqd9YWEL
 jJrVEABUUHo/ZtmerXA/UcCbzSW60dSIyTzNdmf2WMAVpfTRUfLEk1gwLCG7v7ngrzwWGgL0s
 E4e3U+JhrZqVac=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/9 =E4=B8=8A=E5=8D=881:03, Boris Burkov wrote:
> On Tue, Aug 03, 2021 at 01:53:48PM +0800, Qu Wenruo wrote:
>> [BUG]
>> When running generic/475 with 64K page size and 4K sectorsize (aka
>> subpage), it can trigger the following BUG_ON() inside
>> btrfs_csum_one_bio(), the possibility is around 1/20 ~ 1/5:
>>
>> 	bio_for_each_segment(bvec, bio, iter) {
>> 		if (!contig)
>> 			offset =3D page_offset(bvec.bv_page) + bvec.bv_offset;
>>
>> 		if (!ordered) {
>> 			ordered =3D btrfs_lookup_ordered_extent(inode, offset);
>> 			BUG_ON(!ordered); /* Logic error */ <<<<
>> 		}
>>
>> 		nr_sectors =3D BTRFS_BYTES_TO_BLKS(fs_info,
>>
>> [CAUSE]
>> Test case generic/475 uses dm-errors to emulate IO failure.
>>
>> Here if we have a page cache which has the following delalloc range:
>>
>> 	0		32K		64K
>> 	|/////|		|////|		|
>> 	\- [0, 4K)	\- [32K, 36K)
>>
>> And then __extent_writepage() can go through the following race:
>>
>> 	T1 (writeback)		|	T2 (endio)
>> --------------------------------+----------------------------------
>> __extent_writepage()		|
>> |- writepage_delalloc()		|
>> |  |- run_delalloc_range()	|
>> |  |  Add OE for [0, 4K)	|
>> |  |- run_delalloc_range()	|
>> |     Add OE for [32K, 36K)	|
>> |				|
>> |- __extent_writepage_io()	|
>> |  |- submit_extent_page()	|
>> |  |  |- Assemble the bio for	|
>> |  |     range [0, 4K)		|
>> |  |- submit_extent_page()	|
>> |  |  |- Submit the bio for	|
>> |  |  |  range [0, 4K)		|
>> |  |  |				| end_bio_extent_writepage()
>> |  |  |				| |- error =3D -EIO;
>> |  |  |				| |- end_extent_writepage( error=3D-EIO);
>> |  |  |				|    |- writepage_endio_finish_ordered()
>> |  |  |				|    |  Remove OE for range [0, 4K)
>> |  |  |				|    |- btrfs_page_set_error()
>> |  |- submit_extent_page()	|
>> |     |- Assemble the bio for	|
>> |        range [32K, 36K)	|
>> |- if (PageError(page))		|
>> |- end_extent_writepage()	|
>>     |- endio_finish_ordered()	|
>>        Remove OE [32K, 36K)	|
>> 				|
>> Submit bio for [32K, 36K)	|
>> |- btrfs_csum_one_bio()		|
>>     |- BUG_ON(!ordered_extent)	|
>>        OE [32K, 36K) is already  |
>>        removed.			|
>>
>> This can only happen for subpage case, as for regular sectorsize, we
>> never submit current page, thus IO error will never mark the current
>> page Error.
>>
>> [FIX]
>> Just remove the end_extent_writepage() call and the if (PageError())
>> check.
>>
>> As mentioned, the end_extent_writepage() never really get executed for
>> regular sectorsize, and could cause above BUG_ON() for subpage.
>
> I was a little surprised to see this assertion, because it begs the
> question: "why was this call added in the first place?"
>
> As best as I can tell, it was introduced by Filipe in
> "Btrfs: fix hang on error (such as ENOSPC) when writing extent pages"
>
> That looks like a reasonably niche case that might not be covered by
> xfstests, so I was wondering if you had already convinced yourself that
> it no longer applies.

Not that niche, since the commit message provides a reproducer.

>
> I'll try to see if I can reproduce his issue with this patch, or if the
> code has changed by enough that it no longer reproduces.

There are a lot of more code change since 2014, one of the core change
is 524272607e88 ("btrfs: Handle delalloc error correctly to avoid
ordered extent hang"), which adds proper error handling in
run_delalloc_range().

Feel free to add if you find more commits enhancing the error handling pat=
h.

But for now, from the original reproducer and the existing ENOSPC test
groups, I don't think there is anything extra you need to worry.

Thanks,
Qu

>
>>
>> This also means, inside __extent_writepage() we should not bother any I=
O
>> failure, but only focus on the error hit during bio assembly and
>> submission.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/extent_io.c | 14 +++++++++-----
>>   1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index e665779c046d..a1a6ac787faf 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -4111,8 +4111,8 @@ static int __extent_writepage(struct page *page, =
struct writeback_control *wbc,
>>   	 * Here we used to have a check for PageError() and then set @ret an=
d
>>   	 * call end_extent_writepage().
>>   	 *
>> -	 * But in fact setting @ret here will cause different error paths
>> -	 * between subpage and regular sectorsize.
>> +	 * But in fact setting @ret and call end_extent_writepage() here will
>> +	 * cause different error paths between subpage and regular sectorsize=
.
>>   	 *
>>   	 * For regular page size, we never submit current page, but only add
>>   	 * current page to current bio.
>> @@ -4124,7 +4124,12 @@ static int __extent_writepage(struct page *page,=
 struct writeback_control *wbc,
>>   	 * thus can get PageError() set by submitted bio of the same page,
>>   	 * while our @ret is still 0.
>>   	 *
>> -	 * So here we unify the behavior and don't set @ret.
>> +	 * The same is also for end_extent_writepage(), which can finish
>> +	 * ordered extent before submitting the real bio, causing
>> +	 * BUG_ON() in btrfs_csum_one_bio().
>> +	 *
>> +	 * So here we unify the behavior and don't set @ret nor call
>> +	 * end_extent_writepage().
>>   	 * Error can still be properly passed to higher layer as page will
>>   	 * be set error, here we just don't handle the IO failure.
>>   	 *
>> @@ -4138,8 +4143,7 @@ static int __extent_writepage(struct page *page, =
struct writeback_control *wbc,
>>   	 * Currently the full page based __extent_writepage_io() is not
>>   	 * capable of that.
>>   	 */
>> -	if (PageError(page))
>> -		end_extent_writepage(page, ret, start, page_end);
>> +
>>   	unlock_page(page);
>>   	ASSERT(ret <=3D 0);
>>   	return ret;
>> --
>> 2.32.0
>>
