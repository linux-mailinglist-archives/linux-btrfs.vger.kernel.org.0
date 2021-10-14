Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8153C42CF6C
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 02:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhJNALJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 20:11:09 -0400
Received: from mout.gmx.net ([212.227.17.20]:56557 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229745AbhJNALJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 20:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634170142;
        bh=rALBxNkROwXzfWgDrR6aI8k6xPOybWE2WjPqk3Ne0jY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=aDM/01/xylXcFvOry0E0W5pRcbBU+S2QZyHMv5XIf404S96axmcYFQ+FA7FOlbael
         Mt4CVMaPrmzGW4JOp550QQlypRVK29/wrgYhYIkG2w8O9GIfVENzSTavywgHvn7Re9
         W7GxgTcPt4qyhies9UGhC1jXX150R84+fyTVIhF8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MplXp-1n6WUS3mXN-00qBkz; Thu, 14
 Oct 2021 02:09:02 +0200
Message-ID: <456cad21-30a2-7c7c-0f17-a76361305f42@gmx.com>
Date:   Thu, 14 Oct 2021 08:08:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v3 20/26] btrfs: make extent_write_locked_range() to be
 subpage compatible
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
References: <20210927072208.21634-1-wqu@suse.com>
 <20210927072208.21634-21-wqu@suse.com>
 <YWbyPmlCPtvOvMOZ@localhost.localdomain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YWbyPmlCPtvOvMOZ@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mz/0MWl+EkXo+NXUkKmrn7Pfrc11CfXEaeY2OAtHwR6wz4uk61h
 1eAuGzC20HTHlT5NdRvvAk69kbCcpN9bF+k5HEprTNBKealk3WVnENM2ucEmEliWCXOKdIB
 +80MtHx1M+TXKhSKsWWkV66YItYYbs0dmZXv9aoc38j/xZEFg/saXRgInqUgRbtYkPPbaaN
 n6XhlHyM8ZRXZKIQf9vDA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:W4hjMGAcyCY=:hkU+vmnfKJskYKajHDjHYH
 FFw5OCBqDHFPMI4QW0+uy6BRZqV5Sbieolhxvvkz3ScRC0ksNyhdITjEY/W8mbSQieBBXgyvC
 35veP/1/PdRZVPt454a9ZOsui6myvqGibuQh+VDEXpieyqrtcVyT6vXUOT/Pvq98iNjW4JFzs
 Uo2y58TBebItCCq9a4b15fSA5+ltGRUKqi2x0IBmXvS+pvPSvRm4rxghmEQhMg1QDxz/SorsU
 fMoeCbzuS+kfrdsQc5pMHq9v/pHK35QIfpF2kujqBHEdyXKc9WlzgNd+TsYCHS5+j8i0/kiy7
 RfeXabGE7TiEYsUi2GbiNRZMRdvjTAOwFrOla2IzDBMQ+aumgPrbKDFxxPrMKImBaJnOsdVng
 gwtw9NPS4YuBq70tvlpaBTE+enTqRqPAn5iq7QnTfpzC1ZCvseTQKMtpjZIb83Hf0/Rz7mqZy
 8YK5YD8L/CU7MPwwuHc0osOkhd4fX6tXQLJcF0GjpKknOlJ2d0G6BJoi26FVJOfrNsdgCsQxY
 8k/yXv4PnwsOAHLkWizNFoN1uTQlVQZ8FRI5RVNeNU7WgXQNxgSXUcxqqdHhSbaGhQwuJHzmw
 Varc9/oBFkx4zKdKBWyDxsApsL7WatLS1M9W/nGFj5zjF5qScRWe+lt9S8VkgRYLna550oSvb
 j0GdRFm1XRcshfm5+br7FfUzx8t1tTqdTF1fiawGZAsOyPuf8JJTl6RZo3xxCQkbsSITKfvts
 ZVCWaccaB4Evzmmpd2i9eiZU7mD9kQym9vDt2trkBVHcfpps+4siw7VsihYz+x7StP0T0XZz2
 kOFL9fPp/SdR4n/1dmGyKQLs9NDU5oNYQdp7lVoui5fekzOC7cqEFmJOiCQxC4xMkQ6LF2Ao1
 1yGONdrYZ4BPYCDFPZCKmGT76glRoMEvBOPTaIG8fcorC/8WEQ3GCTPVas2ks9JGxdY9h/vNm
 VimvafzKCsubeO/37JKRzu1l3BzQPYO/ufht4SMR9sRZHbbRLC5cjLBVn6qoKIvrcKFuVebgX
 eKEdFC7h/f7hmu5yTyJS4vd2tqj4D8BQ1io7cNIZcPu+UYUVtcPg0niuoZ7Xn6tum2ug4Kau/
 47zQeJrVutuUs8=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/13 22:50, Josef Bacik wrote:
> On Mon, Sep 27, 2021 at 03:22:02PM +0800, Qu Wenruo wrote:
>> There are two sites are not subpage compatible yet for
>> extent_write_locked_range():
>>
>> - How @nr_pages are calculated
>>    For subpage we can have the following range with 64K page size:
>>
>>    0   32K  64K   96K 128K
>>    |   |////|/////|   |
>>
>>    In that case, although 96K - 32K =3D=3D 64K, thus it looks like one =
page
>>    is enough, but the range spans across two pages, not one.
>>
>>    Fix it by doing proper round_up() and round_down() to calculate
>>    @nr_pages.
>>
>>    Also add some extra ASSERT()s to ensure the range passed in is alrea=
dy
>>    aligned.
>>
>> - How the page end is calculated
>>    Currently we just use cur + PAGE_SIZE - 1 to calculate the page end.
>>
>>    Which can't handle above range layout, and will trigger ASSERT() in
>>    btrfs_writepage_endio_finish_ordered(), as the range is no longer
>>    covered by the page range.
>>
>>    Fix it by take page end into consideration.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/extent_io.c | 17 +++++++++++++----
>>   1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 825917f1b623..f05d8896d1ad 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -5087,15 +5087,14 @@ int extent_write_locked_range(struct inode *ino=
de, u64 start, u64 end)
>>   	struct address_space *mapping =3D inode->i_mapping;
>>   	struct page *page;
>>   	u64 cur =3D start;
>> -	unsigned long nr_pages =3D (end - start + PAGE_SIZE) >>
>> -		PAGE_SHIFT;
>> +	unsigned long nr_pages;
>> +	const u32 sectorsize =3D btrfs_sb(inode->i_sb)->sectorsize;
>>   	struct extent_page_data epd =3D {
>>   		.bio_ctrl =3D { 0 },
>>   		.extent_locked =3D 1,
>>   		.sync_io =3D 1,
>>   	};
>>   	struct writeback_control wbc_writepages =3D {
>> -		.nr_to_write	=3D nr_pages * 2,
>>   		.sync_mode	=3D WB_SYNC_ALL,
>>   		.range_start	=3D start,
>>   		.range_end	=3D end + 1,
>> @@ -5104,14 +5103,24 @@ int extent_write_locked_range(struct inode *ino=
de, u64 start, u64 end)
>>   		.no_cgroup_owner =3D 1,
>>   	};
>>
>> +	ASSERT(IS_ALIGNED(start, sectorsize) &&
>> +	       IS_ALIGNED(end + 1, sectorsize));
>> +	nr_pages =3D (round_up(end, PAGE_SIZE) - round_down(start, PAGE_SIZE)=
) >>
>> +		   PAGE_SHIFT;
>> +	wbc_writepages.nr_to_write =3D nr_pages * 2;
>> +
>>   	wbc_attach_fdatawrite_inode(&wbc_writepages, inode);
>>   	while (cur <=3D end) {
>> +		u64 cur_end =3D min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1,
>> +				  end);
>> +
>>   		page =3D find_get_page(mapping, cur >> PAGE_SHIFT);
>>   		/*
>>   		 * All pages in the range are locked since
>>   		 * btrfs_run_delalloc_range(), thus there is no way to clear
>>   		 * the page dirty flag.
>>   		 */
>> +		ASSERT(PageLocked(page));
>
> We're tripping this ASSERT() with compression turned on, sorry I didn't =
notice
> this but we've been panicing consistently since this was merged, so I've=
 lost a
> weeks worth of xfstests runs.  You can easily reproduce running
>
> ./check generic/029
>
> with
>
> MOUNT_OPTIONS=3D"-o compress"

Confirmed, but this also means, some pages are no longer locked for
compression.

This doesn't sound correct to me, will do more investigation to find out
why.

Thanks,
Qu
>
> Thanks,
>
> Josef
>
