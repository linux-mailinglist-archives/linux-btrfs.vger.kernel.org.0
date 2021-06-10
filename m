Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C5F3A25A7
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jun 2021 09:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFJHnk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Jun 2021 03:43:40 -0400
Received: from mout.gmx.net ([212.227.17.20]:54741 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229845AbhFJHnj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Jun 2021 03:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623310899;
        bh=6cF0LhgNvUNqyY06FwkUD0oCouRdBfut+l6d4FV9osk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=i2fmUS3F3ZWvkzDVrLyoxO2BxAdynyu3v7TU9R89sQ99jxpqUqCyqf+t2sX1NQl/y
         rU940Y2xjyRREh+rWrZJrG/dUWGbSO74VATkT+ol7NvwTQoMJcAqJGJvV5lQDzCv+x
         1tGgPKLJ2SnbVgNBeHi1ujmPwNLek/m0O+gnRxbo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8GQy-1lDUiw3IFU-014FPx; Thu, 10
 Jun 2021 09:41:39 +0200
Subject: Re: [PATCH v2 2/3] btrfs: zoned: fix compressed writes
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1621351444.git.johannes.thumshirn@wdc.com>
 <1220142568f5b5f0d06fbc3ee28a08060afc0a53.1621351444.git.johannes.thumshirn@wdc.com>
 <9464ea87-6d50-9015-a6f5-c7b3d61458ca@gmx.com>
 <DM6PR04MB70813C91EEB7952FC3EF917EE7359@DM6PR04MB7081.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <2ceddf4f-f2b9-fe7c-0201-46835cc27c45@gmx.com>
Date:   Thu, 10 Jun 2021 15:41:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB70813C91EEB7952FC3EF917EE7359@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0WH4MTYBLptr+RCJh7e90G5NVod8SP42nxgMaLCvwGxP9d1/ohQ
 Cq1rl7ALFmn5E7A35BxLBj71RDzIfoG31RLHW1fttZP/b5uSwiCtFsc0GBzMTcQnn0I00FJ
 UPRcM0tQNL5/tprAkUVy1Uo1EwRDbYx91YgR3eLkJjmVZu7Fxgv2e9RbLKSxkDgJWotHFez
 /FI/4qIrq0xdiSx8TTqmQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:amp7SQe3DV8=:TA2ShugVPqcyKWBB5IN4Ec
 KQhX5IsIAlz5msyyXclzludVBSl7juqWWLY00qeXZTufm8At0+g70u9d2LsA6xP9r75JoXZUn
 T6MtKIrWTYwqUBy4PrIq1NTm84bFddfbmVO9KEOiT1v6EmoKwwQfjqsWVytIlHPSIDldUhuT2
 iV4K7htmRd/I2HS7E+q0qcncdfvklRbYLBkEnOG1yYdWXM5tgmqyiSPPqZu+jmNejZlqS5f/F
 m8J2WQ1w2BQuHnMv7XfRfMa2cvGSAuNR0d/e/8Mo9zNQQ7pyr48zGH1FG8t6eJQl4Nfa1uqxR
 PxIHn2rURHM+t9BEiMRz8XvVVp99+ArZ1ita8GrbGG7qt4zNJIOaVjRUITZtcXZf1OnqSlE9W
 701WMF/38/sTA2h2BURdzyX8eGgk6qw0N56wb5GmvMn28rV88uYiTF3cABfyqqbv4cU2gMtdC
 aGxjo1c+md4FlaDf2uI5F7LtUTS7MZeNdILOs3GjK1QdHkQi4GNyZVi13/0aUmc11Cl2l+BsT
 9kiDaBKNXgJ+GLA5d1nu9JNQUqrcf7HXiaMJgEQnACRKxd9Eoyoq+s2X4vNFWJOSOvrE/zlXf
 5OLsK0mFV+ijTLEiYEYwGzPnWOkRn6bnqxqqZQpItBPHx6sblnpKnvMwmgxqZAurZ7rqN5SkD
 BvnQWtAWxeQwYOIb4ZMlsf3I6cFeOE2PQekmVF8OiLKz1Kxl5Kvm9mxNFW8XF3fegeokzt8dD
 c/eiBZ5FItsW663sFJzyoWkXQZ8yLj4Kl/unVo4+STfC6s3h9KrMmNV3uXCJwvd/e3CUm2Pyn
 iO3h5oBPkZiGn6amWYnFhtTHBi7N1/65OdTfN2q4TiiYWqXTyOOwWyPmG4AV9k3fIn0B4TF/r
 zl2xvwaewmpjL0CxR3AVim6wiCNMPlmeYW9e/di8wYQKE7EQ8DOn+SKu3zQGmNTcsdtanXHRo
 /Rdpd9dfaZfGoCTmdmRRE4CA7Y84KUHMql0B6Q6SvVx6CNzTWI2PiMvsqf8kmJtt8G/dpkG+d
 YCW0nZr2iWO9JYityQZYuLWY14A3d7qoHUwNarAp1vplzEemEVlCDQ7ZLzgL0hcWsZnS8vtuw
 bv2+rBRRazAvz49gCPc1iL6LF6njPEKykY4HDqiFcNXa+0Q8MrEacLUNA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/10 =E4=B8=8B=E5=8D=883:36, Damien Le Moal wrote:
> On 2021/06/10 16:28, Qu Wenruo wrote:
>>
>>
>> On 2021/5/18 =E4=B8=8B=E5=8D=8811:40, Johannes Thumshirn wrote:
>>> When multiple processes write data to the same block group on a compre=
ssed
>>> zoned filesystem, the underlying device could report I/O errors and da=
ta
>>> corruption is possible.
>>>
>>> This happens because on a zoned file system, compressed data writes wh=
ere
>>> sent to the device via a REQ_OP_WRITE instead of a REQ_OP_ZONE_APPEND
>>> operation. But with REQ_OP_WRITE and parallel submission it cannot be
>>> guaranteed that the data is always submitted aligned to the underlying
>>> zone's write pointer.
>>>
>>> The change to using REQ_OP_ZONE_APPEND instead of REQ_OP_WRITE on a zo=
ned
>>> filesystem is non intrusive on a regular file system or when submittin=
g to
>>> a conventional zone on a zoned filesystem, as it is guarded by
>>> btrfs_use_zone_append.
>>>
>>> Reported-by: David Sterba <dsterba@suse.com>
>>> Fixes: 9d294a685fbc ("btrfs: zoned: enable to mount ZONED incompat fla=
g")
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>
>> Now working on compression support for subpage, just noticed some
>> strange code behavior, I'm not sure if it's designed or just a typo.
>>
>> So please correct me if possible.
>>
>> [...]
>>>
>>>    	bio =3D btrfs_bio_alloc(first_byte);
>>> -	bio->bi_opf =3D REQ_OP_WRITE | write_flags;
>>> +	bio->bi_opf =3D bio_op | write_flags;
>>>    	bio->bi_private =3D cb;
>>>    	bio->bi_end_io =3D end_compressed_bio_write;
>>>
>>> +	if (use_append) {
>>> +		struct extent_map *em;
>>> +		struct map_lookup *map;
>>> +		struct block_device *bdev;
>>> +
>>> +		em =3D btrfs_get_chunk_map(fs_info, disk_start, PAGE_SIZE);
>>> +		if (IS_ERR(em)) {
>>> +			kfree(cb);
>>> +			bio_put(bio);
>>> +			return BLK_STS_NOTSUPP;
>>> +		}
>>> +
>>> +		map =3D em->map_lookup;
>>> +		/* We only support single profile for now */
>>> +		ASSERT(map->num_stripes =3D=3D 1);
>>> +		bdev =3D map->stripes[0].dev->bdev;
>
> This variable seems rather useless...

No need to bother that, that has already been removed by later refactor.

>
>>> +
>>> +		bio_set_dev(bio, bdev);
>>> +		free_extent_map(em);
>>> +	}
>>> +
>>
>> Here for the newly created bio, we will try to call bio_set_dev() for
>> it. (although later patch refactor this part a little)
>>
>> So far so good.
>>
>>>    	if (blkcg_css) {
>>>    		bio->bi_opf |=3D REQ_CGROUP_PUNT;
>>>    		kthread_associate_blkcg(blkcg_css);
>>> @@ -432,6 +458,7 @@ blk_status_t btrfs_submit_compressed_write(struct =
btrfs_inode *inode, u64 start,
>>>    	bytes_left =3D compressed_len;
>>>    	for (pg_index =3D 0; pg_index < cb->nr_pages; pg_index++) {
>>>    		int submit =3D 0;
>>> +		int len;
>>>
>>>    		page =3D compressed_pages[pg_index];
>>>    		page->mapping =3D inode->vfs_inode.i_mapping;
>>> @@ -439,9 +466,13 @@ blk_status_t btrfs_submit_compressed_write(struct=
 btrfs_inode *inode, u64 start,
>>>    			submit =3D btrfs_bio_fits_in_stripe(page, PAGE_SIZE, bio,
>>>    							  0);
>>>
>>> +		if (pg_index =3D=3D 0 && use_append)
>>> +			len =3D bio_add_zone_append_page(bio, page, PAGE_SIZE, 0);
>>> +		else
>>> +			len =3D bio_add_page(bio, page, PAGE_SIZE, 0);
>>> +
>>>    		page->mapping =3D NULL;
>>> -		if (submit || bio_add_page(bio, page, PAGE_SIZE, 0) <
>>> -		    PAGE_SIZE) {
>>> +		if (submit || len < PAGE_SIZE) {
>>>    			/*
>>>    			 * inc the count before we submit the bio so
>>>    			 * we know the end IO handler won't happen before
>>> @@ -465,11 +496,15 @@ blk_status_t btrfs_submit_compressed_write(struc=
t btrfs_inode *inode, u64 start,
>>>    			}
>>>
>>>    			bio =3D btrfs_bio_alloc(first_byte);
>>> -			bio->bi_opf =3D REQ_OP_WRITE | write_flags;
>>> +			bio->bi_opf =3D bio_op | write_flags;
>>
>> But here, for the newly allocated bio, we didn't call bio_set_dev() at =
all.
>>
>> Shouldn't all zoned write bio need that bio_set_dev() call?
>
> Yep, bio->bi_bdev must be set before bio_add_zone_append_page() is calle=
d.
> Otherwise, there will be a crash (first line of bio_add_zone_append_page=
() gets
> the request queue from bio->bi_bdev). I wonder why we do not see NULL po=
inter
> oops here... Johannes ?

That's because it's really really rare/hard to have a compressed extent
just lies at the stripe boundary.

For most cases, the data we provide for compression tests is either:
- Too compressible
   Thus the whole range can be compressed into just one sector, thus
   it will never cross stripe boundary.

- Not compressible at all
   We fall back to regular buffered write, which will do their proper
   stripe boundary check correctly.

Thus it's really near impossible to hit it in various tests.

Thanks,
Qu

>
>>
>> I guess since most compressed extents are pretty small, it's really har=
d
>> to hit a case where we need to split the bio due to stripe boundary,
>> thus very hard to hit anything wrong.
>>
>> Anyway, since I'm working on compression code to make compressed write
>> to follow the same boundary check in extent_io.c, I can definitely
>> refactor the bio allocation code to add the zoned needed calls.
>>
>> Thanks,
>> Qu
>>
>>>    			bio->bi_private =3D cb;
>>>    			bio->bi_end_io =3D end_compressed_bio_write;
>>>    			if (blkcg_css)
>>>    				bio->bi_opf |=3D REQ_CGROUP_PUNT;
>>> +			/*
>>> +			 * Use bio_add_page() to ensure the bio has at least one
>>> +			 * page.
>>> +			 */
>>>    			bio_add_page(bio, page, PAGE_SIZE, 0);
>>>    		}
>>>    		if (bytes_left < PAGE_SIZE) {
>>>
>>
>
>
