Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2881E3A25D9
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jun 2021 09:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhFJHxu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Jun 2021 03:53:50 -0400
Received: from mout.gmx.net ([212.227.15.15]:35467 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229770AbhFJHxq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Jun 2021 03:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623311505;
        bh=o1gAaBcw7IOkzRZW0cQpXWa+MoCBoUrKSeFVXU1DkOc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=jea7/+wjmh791YgxC5N0ygZS5Q3rfgpl7jkGl+IG6jnrRke28EEeeUNBE5A1evEM3
         KzKKDESfTPpJSW/s/5vjB87ljVawurwhZGxJnnvcPnScd/4pdUwY2+sPn7yAjRNWkC
         gV/QqSkUtTAN8aJuUuP4F0KUaC5FWQccv8+Qo7z8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MZCb5-1lmYfR4BQP-00VAVO; Thu, 10
 Jun 2021 09:51:45 +0200
Subject: Re: [PATCH v2 2/3] btrfs: zoned: fix compressed writes
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1621351444.git.johannes.thumshirn@wdc.com>
 <1220142568f5b5f0d06fbc3ee28a08060afc0a53.1621351444.git.johannes.thumshirn@wdc.com>
 <9464ea87-6d50-9015-a6f5-c7b3d61458ca@gmx.com>
 <DM6PR04MB70813C91EEB7952FC3EF917EE7359@DM6PR04MB7081.namprd04.prod.outlook.com>
 <2ceddf4f-f2b9-fe7c-0201-46835cc27c45@gmx.com>
 <DM6PR04MB7081051CDED378C54A364E68E7359@DM6PR04MB7081.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <43f860a0-39fb-5d52-41f6-2b01ada054ae@gmx.com>
Date:   Thu, 10 Jun 2021 15:51:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB7081051CDED378C54A364E68E7359@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m77IoyPlbFdo7135Mwy7rkc9FaRUHRgco6eYmn4pS9bRopGDEqx
 ZxcX8RoZx2Z3z/GJ4nGZmfJGvS50/OPrFDfCT3yPds79ecVgdCZ7dyDbBYtacKWoRXpgAY9
 7KIBRDP2lDyu0tin/K8jPyOzQhVPaBnVqzQ/OwZwZRjx8HbY11lJPxAR0DEhCUUd06RcXWw
 oLWx5h2QZNqfwaKL2/KbA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:onZBoy1VvMU=:l2dbDTislctmQ4ujgboL2p
 7iG3Wl9Hdb0umaoxOP89IcMBBIjPHwjfWbMWnXLjwSnb8e1ZwTMZMIkIJ0vx9AMyL2Iv8hL4S
 AQKGfzjpvX+kyTpnwUzdAmUtdpDPFXQA9EIqd85KD4WRq6Uod6xqeV7RzAzdGqi9GtpFXBrUJ
 hRHdZAcWI6yiHa5p+pqGRb6bYBrsqbiqeTv67vGE0sIphUXdAznCrOvSpVpb+ddE0Df3vND6P
 ew6cwh/IS6YULs1TB8fEPbNSP2PEtzZZ7VkpnXamD1YdMw6hqB4DoKmJeywCKGLL82UfiLfmr
 Hri0LvTjUXAT28twcw4gymIapysMlfJ7kD/7W/qA1SNb824EfqNbXjUjAalbLkGGWIjMuTOQk
 5BkEAKoa/HL13mPcK1q1D07XdKs5uFbBhWZHn27mnVanAKUbfz6nMn+PI6t2vKofOilnnsZgr
 uZaQF18WG3rQWP1b5giLmdSw+A8ti01v+nond4eiXrjaFzPEEqq1hNC9equiM1x6nSCFDOQal
 Q0ZsITHxPrfC8ejTJbm3BCP7zwfLqDewe1XQZTII7O5/XdaZOO0Ek7iKRMTiUYgzaeEmYDXYn
 jCMh6/zIv2yITu87Tmn9t7S+soajGkb4MGKgyjPmsRVSFmiBbS0YsRzZrm3CC3GAu/2VcQYlS
 URd6JFdJWVbcFiA4/7h7o3yFdMzJIJw5uLRw5nbajtT2ik4VH37U9/6azBgLRc6ui2WAclJKX
 kXgQ1QsKSCyOXqaI0OITwuduvMy8I/fGxglKN9Xj1pu3AYA8oSfHXCT86UY4PTIMBtkS4dPlO
 49exbYwhouEjPvMxg0RFyRkuiWK4ksi60sHoc+1YHTnOF1bu/BGBJusOFtMtgoHOL7H4u02B9
 A69TfEGMyiGJ8TZoFhDJCmcfxxSJmRbTZ30is5ucB2FKEqEjl+SfA8+s7ZTJpBiLoO0cD/LTo
 hB62Y3jW8Yp+QcBgzLSZjwbI7niOwpgbzubAXX4+pWgSuCQU2JDG7zjMXHl8veqw5MKykow+7
 zuvi+Q8PqXqxC6GbSksUOQVJr53fXIp12U0My6QbCqn8rAprlL1Rw07wXdqszNurOh3y+8fYb
 ZVGFs+JKeTeLrTIabjC9/5/MFTHt78nlTZniuAIdRQv0BM+2+bPSR/lDQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/10 =E4=B8=8B=E5=8D=883:45, Damien Le Moal wrote:
> On 2021/06/10 16:41, Qu Wenruo wrote:
>>
>>
>> On 2021/6/10 =E4=B8=8B=E5=8D=883:36, Damien Le Moal wrote:
>>> On 2021/06/10 16:28, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2021/5/18 =E4=B8=8B=E5=8D=8811:40, Johannes Thumshirn wrote:
>>>>> When multiple processes write data to the same block group on a comp=
ressed
>>>>> zoned filesystem, the underlying device could report I/O errors and =
data
>>>>> corruption is possible.
>>>>>
>>>>> This happens because on a zoned file system, compressed data writes =
where
>>>>> sent to the device via a REQ_OP_WRITE instead of a REQ_OP_ZONE_APPEN=
D
>>>>> operation. But with REQ_OP_WRITE and parallel submission it cannot b=
e
>>>>> guaranteed that the data is always submitted aligned to the underlyi=
ng
>>>>> zone's write pointer.
>>>>>
>>>>> The change to using REQ_OP_ZONE_APPEND instead of REQ_OP_WRITE on a =
zoned
>>>>> filesystem is non intrusive on a regular file system or when submitt=
ing to
>>>>> a conventional zone on a zoned filesystem, as it is guarded by
>>>>> btrfs_use_zone_append.
>>>>>
>>>>> Reported-by: David Sterba <dsterba@suse.com>
>>>>> Fixes: 9d294a685fbc ("btrfs: zoned: enable to mount ZONED incompat f=
lag")
>>>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>>>
>>>> Now working on compression support for subpage, just noticed some
>>>> strange code behavior, I'm not sure if it's designed or just a typo.
>>>>
>>>> So please correct me if possible.
>>>>
>>>> [...]
>>>>>
>>>>>     	bio =3D btrfs_bio_alloc(first_byte);
>>>>> -	bio->bi_opf =3D REQ_OP_WRITE | write_flags;
>>>>> +	bio->bi_opf =3D bio_op | write_flags;
>>>>>     	bio->bi_private =3D cb;
>>>>>     	bio->bi_end_io =3D end_compressed_bio_write;
>>>>>
>>>>> +	if (use_append) {
>>>>> +		struct extent_map *em;
>>>>> +		struct map_lookup *map;
>>>>> +		struct block_device *bdev;
>>>>> +
>>>>> +		em =3D btrfs_get_chunk_map(fs_info, disk_start, PAGE_SIZE);
>>>>> +		if (IS_ERR(em)) {
>>>>> +			kfree(cb);
>>>>> +			bio_put(bio);
>>>>> +			return BLK_STS_NOTSUPP;
>>>>> +		}
>>>>> +
>>>>> +		map =3D em->map_lookup;
>>>>> +		/* We only support single profile for now */
>>>>> +		ASSERT(map->num_stripes =3D=3D 1);
>>>>> +		bdev =3D map->stripes[0].dev->bdev;
>>>
>>> This variable seems rather useless...
>>
>> No need to bother that, that has already been removed by later refactor=
.
>>
>>>
>>>>> +
>>>>> +		bio_set_dev(bio, bdev);
>>>>> +		free_extent_map(em);
>>>>> +	}
>>>>> +
>>>>
>>>> Here for the newly created bio, we will try to call bio_set_dev() for
>>>> it. (although later patch refactor this part a little)
>>>>
>>>> So far so good.
>>>>
>>>>>     	if (blkcg_css) {
>>>>>     		bio->bi_opf |=3D REQ_CGROUP_PUNT;
>>>>>     		kthread_associate_blkcg(blkcg_css);
>>>>> @@ -432,6 +458,7 @@ blk_status_t btrfs_submit_compressed_write(struc=
t btrfs_inode *inode, u64 start,
>>>>>     	bytes_left =3D compressed_len;
>>>>>     	for (pg_index =3D 0; pg_index < cb->nr_pages; pg_index++) {
>>>>>     		int submit =3D 0;
>>>>> +		int len;
>>>>>
>>>>>     		page =3D compressed_pages[pg_index];
>>>>>     		page->mapping =3D inode->vfs_inode.i_mapping;
>>>>> @@ -439,9 +466,13 @@ blk_status_t btrfs_submit_compressed_write(stru=
ct btrfs_inode *inode, u64 start,
>>>>>     			submit =3D btrfs_bio_fits_in_stripe(page, PAGE_SIZE, bio,
>>>>>     							  0);
>>>>>
>>>>> +		if (pg_index =3D=3D 0 && use_append)
>>>>> +			len =3D bio_add_zone_append_page(bio, page, PAGE_SIZE, 0);
>>>>> +		else
>>>>> +			len =3D bio_add_page(bio, page, PAGE_SIZE, 0);
>>>>> +
>>>>>     		page->mapping =3D NULL;
>>>>> -		if (submit || bio_add_page(bio, page, PAGE_SIZE, 0) <
>>>>> -		    PAGE_SIZE) {
>>>>> +		if (submit || len < PAGE_SIZE) {
>>>>>     			/*
>>>>>     			 * inc the count before we submit the bio so
>>>>>     			 * we know the end IO handler won't happen before
>>>>> @@ -465,11 +496,15 @@ blk_status_t btrfs_submit_compressed_write(str=
uct btrfs_inode *inode, u64 start,
>>>>>     			}
>>>>>
>>>>>     			bio =3D btrfs_bio_alloc(first_byte);
>>>>> -			bio->bi_opf =3D REQ_OP_WRITE | write_flags;
>>>>> +			bio->bi_opf =3D bio_op | write_flags;
>>>>
>>>> But here, for the newly allocated bio, we didn't call bio_set_dev() a=
t all.
>>>>
>>>> Shouldn't all zoned write bio need that bio_set_dev() call?
>>>
>>> Yep, bio->bi_bdev must be set before bio_add_zone_append_page() is cal=
led.
>>> Otherwise, there will be a crash (first line of bio_add_zone_append_pa=
ge() gets
>>> the request queue from bio->bi_bdev). I wonder why we do not see NULL =
pointer
>>> oops here... Johannes ?
>>
>> That's because it's really really rare/hard to have a compressed extent
>> just lies at the stripe boundary.
>>
>> For most cases, the data we provide for compression tests is either:
>> - Too compressible
>>     Thus the whole range can be compressed into just one sector, thus
>>     it will never cross stripe boundary.
>>
>> - Not compressible at all
>>     We fall back to regular buffered write, which will do their proper
>>     stripe boundary check correctly.
>>
>> Thus it's really near impossible to hit it in various tests.
>
> But this is a data write, isn't it ? So in the zoned case, it means a zo=
ne
> append write. And adding a page for even a single sector using
> bio_add_zone_append_page() will oops if the bio bdev is not set, regardl=
ess of
> the bio size... Am I misunderstanding something here about this IO path =
?

The bio can only be allocated when we have a write range crossing device
stripe boundary.
Which is already a rare case for compressed write.


And the initial bio always has the correct setup, thus we have to hit
the corner case to get into this situation.


Finally I find that since zoned support doesn't support multi-device
profile yet, there is no limitation for stripe length, thus we won't get
into this branch at all.

So my bad, false alert...

Thanks,
Qu

>
>>
>> Thanks,
>> Qu
>>
>>>
>>>>
>>>> I guess since most compressed extents are pretty small, it's really h=
ard
>>>> to hit a case where we need to split the bio due to stripe boundary,
>>>> thus very hard to hit anything wrong.
>>>>
>>>> Anyway, since I'm working on compression code to make compressed writ=
e
>>>> to follow the same boundary check in extent_io.c, I can definitely
>>>> refactor the bio allocation code to add the zoned needed calls.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>     			bio->bi_private =3D cb;
>>>>>     			bio->bi_end_io =3D end_compressed_bio_write;
>>>>>     			if (blkcg_css)
>>>>>     				bio->bi_opf |=3D REQ_CGROUP_PUNT;
>>>>> +			/*
>>>>> +			 * Use bio_add_page() to ensure the bio has at least one
>>>>> +			 * page.
>>>>> +			 */
>>>>>     			bio_add_page(bio, page, PAGE_SIZE, 0);
>>>>>     		}
>>>>>     		if (bytes_left < PAGE_SIZE) {
>>>>>
>>>>
>>>
>>>
>>
>
>
