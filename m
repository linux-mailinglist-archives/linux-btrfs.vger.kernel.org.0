Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C243F5391
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 01:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbhHWXP7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 19:15:59 -0400
Received: from mout.gmx.net ([212.227.15.19]:33699 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233165AbhHWXP4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 19:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629760510;
        bh=KBs6RtpqQdsF2qo3WjobXHB6IQVnNhr6jsB3iatrIqU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=WHhT2nJV4I75pwYVPsK4QhX7lov9bk2Hx/+Bv5buSlRAz69tr9a59l5qoAwbccrjJ
         0w95X18n6M2cm+7jl37LVuuGg//0b1+JrmWwhBNx4LQDxyRnT9fQcQKu0uqH6F4ffA
         R0cyJu2XkR6jORsSsHEtTnyGGNfH6evRVcQ1Ukm0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MUXpK-1mR8pR0odc-00QUkh; Tue, 24
 Aug 2021 01:15:09 +0200
Subject: Re: [PATCH v2 3/4] btrfs: introduce btrfs_subpage_bitmap_info
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210817093852.48126-1-wqu@suse.com>
 <20210817093852.48126-4-wqu@suse.com> <20210823164130.GF5047@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <252f4d9d-d0f0-54a2-0d1b-6a7ef2f38a5f@gmx.com>
Date:   Tue, 24 Aug 2021 07:15:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210823164130.GF5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5XEbsrxfoz5lFlLx4AaLGQudoL//3ALriMqcP5lAvzXwy4Z/VPE
 4b3BanOtFG+jniCF/+j3ZeIOb3c6WqC763X17E+vj9p5Iaw2CbLEHVx8xr3nhzn9Ij0L+W/
 +olLrVnrot5+kgda4afWKmhlG+kVOGsrx6Y8YiBsxqMK8ETsNlVC0EKtbWdkqQ6RwE+EpZb
 S/ainEFmwTrTGCwIAwz0A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7tNj81tHzhY=:yFm6jhTlG1Tb2h6Tn0KBxH
 MiHcT62o7qlDYq3cifbuWrIUKRNa1QsVPRzxdcYSdStIl7UCcJPepjyGPy6Z85FmHlbN6tsM9
 6h5EZLdizptA0F7wwguxe3Szkafe/jmKBI8MhGipUKnWBRc8fQozjVW13ujdaxj8zRm13ESAc
 WqqvRKXox+AAOkC74B9BVBiCXHk8nn7zTVUpRQ9vFu3O60i4hULSBZCRIj/K4Fh+jUBrQ2T6U
 2wN6P0wJc26ScFhXELYaUhxyV1mI/sZbgCU8jhqAqxYYpA0zeUnNQ2wi75VAK4rB/QLDBCVH0
 JyyGO++RPZLsVeSNOP1oMJq0t3sFdmf3XszjJpQYYJj42Aj6PbqwWAw3mj7vBRjfZBZ+GgglH
 RwnFnHbJOVf6Y0uvXX1p24SrMI/XqKtxYDkgMTtBFCB0GOi1sOy7deGoJUmOEJ8bEzS1fNzEX
 8S8/+hYOEP+7Ekd4Bi+YdET+D6Uh8/lrINniBoTbEQz96KZDlCmPSOp2oQCA4PxDhR5UbDmNY
 NVrwX9BYF6V/s/UhhSw7X0sgIynYiwckCTBExkuFyb8CW6K2sngmyOEfEpI04BQgHTgjMfVjX
 MjBzbxY0mye5nI6pDULQKXl6maTMcj7IJQYxoX9KodwLNiKgisi3+2gPQ3veZRHdUkA97Ly0C
 N42Z/wWl+/lsthr6d2rH3EpBpcbTwYUrKWjjYImGlUGX2dgH9lFmaFyETHey1fIa4qdioywPD
 CEliHBRh1F8/VPm+qYJY4tckp6muR1gZ4HJn2UaZbi7tB25o/yyR9VNjnAK4pLZ0y0WNi0Clj
 NM0CotyfYTiW19+xHWwKjpMxO6MIQ6DkG505tqiQ4hyBKJ/YbpBmSOA2Pu+88shG3RrYd+yxu
 c35m9YrVx8Q8ICnUIfhISrAE3XJS6P4bdiGdzE9lMrdFUGDHIfsiOuALsLdmALqetopu86Gp1
 nb2YGLsAj15YUeiy8mWtQKV/klr/LTfBLz4kbfr4L+tWqP95XQpa0GZa1DWFD2Z9ezpsPZ336
 ai1EL5YDO3YnVOT5zfZREFD/4HSzgghm35Drw9YtR2xbMqze0BirM2ew/qwqL9HTXiG/y9VnL
 mou3cfiBDrOfhkh2hGIR5N20vu0okQ+kkr/uSo3OvnKtKa6Oregs4OXCg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/24 =E4=B8=8A=E5=8D=8812:41, David Sterba wrote:
> On Tue, Aug 17, 2021 at 05:38:51PM +0800, Qu Wenruo wrote:
>> Currently we use fixed size u16 bitmap for subpage bitmap.
>> This is fine for 4K sectorsize with 64K page size.
>>
>> But for 4K sectorsize and larger page size, the bitmap is too small,
>> while for smaller page size like 16K, u16 bitmaps waste too much space.
>>
>> Here we introduce a new helper structure, btrfs_subpage_bitmap_info, to
>> record the proper bitmap size, and where each bitmap should start at.
>>
>> By this, we can later compact all subpage bitmaps into one u32 bitmap.
>>
>> This patch is the first step towards such compact bitmap.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/ctree.h   |  1 +
>>   fs/btrfs/disk-io.c | 12 +++++++++---
>>   fs/btrfs/subpage.c | 35 +++++++++++++++++++++++++++++++++++
>>   fs/btrfs/subpage.h | 36 ++++++++++++++++++++++++++++++++++++
>>   4 files changed, 81 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index f07c82fafa04..a5297748d719 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -899,6 +899,7 @@ struct btrfs_fs_info {
>>   	struct btrfs_workqueue *scrub_workers;
>>   	struct btrfs_workqueue *scrub_wr_completion_workers;
>>   	struct btrfs_workqueue *scrub_parity_workers;
>> +	struct btrfs_subpage_info *subpage_info;
>>
>>   	struct btrfs_discard_ctl discard_ctl;
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 2f9515dccce0..3355708919d0 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -1644,6 +1644,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_=
info)
>>   	btrfs_extent_buffer_leak_debug_check(fs_info);
>>   	kfree(fs_info->super_copy);
>>   	kfree(fs_info->super_for_commit);
>> +	kfree(fs_info->subpage_info);
>>   	kvfree(fs_info);
>>   }
>>
>> @@ -3392,12 +3393,12 @@ int __cold open_ctree(struct super_block *sb, s=
truct btrfs_fs_devices *fs_device
>>   		goto fail_alloc;
>>   	}
>>
>> -	if (sectorsize !=3D PAGE_SIZE) {
>> +	if (sectorsize < PAGE_SIZE) {
>> +		struct btrfs_subpage_info *subpage_info;
>> +
>>   		btrfs_warn(fs_info,
>>   		"read-write for sector size %u with page size %lu is experimental",
>>   			   sectorsize, PAGE_SIZE);
>> -	}
>> -	if (sectorsize !=3D PAGE_SIZE) {
>>   		if (btrfs_super_incompat_flags(fs_info->super_copy) &
>>   			BTRFS_FEATURE_INCOMPAT_RAID56) {
>>   			btrfs_err(fs_info,
>> @@ -3406,6 +3407,11 @@ int __cold open_ctree(struct super_block *sb, st=
ruct btrfs_fs_devices *fs_device
>>   			err =3D -EINVAL;
>>   			goto fail_alloc;
>>   		}
>> +		subpage_info =3D kzalloc(sizeof(*subpage_info), GFP_NOFS);
>> +		if (!subpage_info)
>> +			goto fail_alloc;
>> +		btrfs_init_subpage_info(subpage_info, sectorsize);
>> +		fs_info->subpage_info =3D subpage_info;
>>   	}
>>
>>   	ret =3D btrfs_init_workqueues(fs_info, fs_devices);
>> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
>> index ae6c68370a95..c4fb2ce52207 100644
>> --- a/fs/btrfs/subpage.c
>> +++ b/fs/btrfs/subpage.c
>> @@ -63,6 +63,41 @@
>>    *   This means a slightly higher tree locking latency.
>>    */
>>
>> +void btrfs_init_subpage_info(struct btrfs_subpage_info *subpage_info,
>> +			     u32 sectorsize)
>> +{
>> +	unsigned int cur =3D 0;
>> +	unsigned int nr_bits;
>> +
>> +	/*
>> +	 * Just in case we have super large PAGE_SIZE that unsigned int is no=
t
>> +	 * enough to contain the number of sectors for the minimal sectorsize=
.
>> +	 */
>> +	BUILD_BUG_ON(UINT_MAX * SZ_4K < PAGE_SIZE);
>
> Do you seriously expect such hardware to exist? We know there are arches
> with 256K page and that's perhaps the maximum we should care about now
> but UINT_MAX * 4K is 16TiB, 2^44. CPUs are barely capable of addressing
> 2^40 physical address space, making assertions about page size orders of
> magnitude larger than that is insane.
>
My original idea is to use U8 for those members to save some bytes, for
that case, the BUILD_BUG_ON() would make sense.

But finally I moved to use unsigned int, now the BUILD_BUG_ON() makes no
sense and can be removed.

Thanks,
Qu
