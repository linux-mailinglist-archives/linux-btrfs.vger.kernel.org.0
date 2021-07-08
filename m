Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1FA3BF5FA
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jul 2021 09:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhGHHJL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 03:09:11 -0400
Received: from mout.gmx.net ([212.227.15.18]:51933 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229766AbhGHHJL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 8 Jul 2021 03:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625727974;
        bh=sSiTJDAiFRvVEmQjsQnE5kdXw9xHTNlBlwyPcqSqDgo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fkLeCb8IvQL2LK4TONz5QBdxvkm8TWMeIzn/la/WJ7aT1yPE46ovL9HIEnZdLJIpT
         eamRR26vUFusQE0Oku8Oogp5Jvt7itK6pLlDaSHtod2HFUX5TimSkZoX37vHgLOidj
         R/Hsvk2xF65RzxRFkbODLnDV3BVHTAIKT5N/AAJo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N95iH-1l4jNS2ZhH-0165qo; Thu, 08
 Jul 2021 09:06:14 +0200
Subject: Re: [PATCH v6 01/15] btrfs: grab correct extent map for subpage
 compressed extent read
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20210705020110.89358-1-wqu@suse.com>
 <20210705020110.89358-2-wqu@suse.com>
 <3d654aac-a0c5-fb2d-24d7-4508c8080e03@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <6bc6b208-c376-85dd-910d-03d5b7478efe@gmx.com>
Date:   Thu, 8 Jul 2021 15:06:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3d654aac-a0c5-fb2d-24d7-4508c8080e03@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0lUwroUQk1Y8fNHYi/i9X2sZGCUTSWOcg2uHgXdzdYO83fJDbjn
 fabh6fOyG9jaDq/ApJgdcEt2lN7FAEpQZjKXGzGMjvGiHugTMxQe3BrOjb+Exx73zJT2gbw
 lWHp7q3VusSDV7u3MjWQFwGBNsJgyMlBmAmYM1VC68EOlfqYgB46QDB24EEmDt/NnmYoZJO
 0r+LWYzL8VlComEPgu0Dw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OQYxRU6K8f8=:i4xRgzdM8eFoHKBT4IftLD
 PvTxx9t7Rx1jvEiSErcZk+nWaY/uhCwGdLoVBNWyjGdnHhBPolWwK992+mum2niLYI5q+oeSX
 9JG85OcfpdjizpSFQ83QocT76ZsmxKLOpG4DI9DBr/tQFLC3A7c+HCik/Gv3ynfXF2j1uTLX3
 HTw0s3Z55PMjiXNxvJe4VkY9D1YCL4bv/fst05/gZTjkoBgbo/rEwUELIxBgdLLcU1i7ZN+iw
 f0BEamVxheF5HXLJbhMb/QgTJAJ7VjVbSrqsbyHOTA//DYnX5dvPwRVy7f+ojx0JJbFJMSKJq
 JyUK9YR+ekCs7CijiPIvBxM5u1mKgkkndq6mia1rFTrFVJC7SulEeT7ls0ZeatFSHFXZjSCR6
 ef+Dx28e+KWjBYZVlYZACMqjWcyEzB6Jn1kxEt/4VW3VY5U/VDaWq0rSGCLWS8P7dp2IS43hU
 XnK82Pa/DWVbVcUGMEXnidC4aGDO1uA+aB5TTYJBJ/7KfbUMo7qTZA0esSd99lEuZTmpedk+5
 L0haWZPpVNXfSve/jWbendV90NwP0+LLbhO4nzmk43+BzxOIsM2q4rOpIEkrDZ5u+mrz95VNG
 Vnwbrfd2Q+b4BGYtrFVozzBMvfBEj20PqKm5D3B5X2chBHA5RdnEhonurybagnXyo/qpjQRXm
 ewdiswYUE0w88fQda/OH5gXvqAJB+KqO7qMdBsMjc7daDNHL1QVvzaJaCrbrFywDm8K8w6CSH
 cMk+JyTYNnX+4n/Ii/7wftEerWKeJ3zPiMnXMK0hVNY30RBrd0m5hbqANL+W2HEEn3NHfVvY9
 llep8ZgrhzCt/7FEyRajExkJ9WaM1ul6cg8j/YabJ0R+lrC2acjBcc8QQzafveF2GM4Ns4Bbs
 P2fWrzHspREzmnv3xjVBxds/kmIvSHWD9ZmC8l3sBtk+osjx7PYE/zq71gkBzzIHZlA0K/xwK
 pnnjTt1NTjjD1yITPd1f6+cJ7nAonQwk2Cm2afUZwZic95tYcAHH1t6XXKja5ixjHKF1kZ9ux
 1wlD7UZnZLmPVIt9UPDjjSy/wdowTbivFzRqq7qNlf5WIQBIcIDsaYlM4NFRA5ZM3uwi9QYtk
 MwvtdBu5JEswDPNATXkCKp/0d4gMFSURfzrvAMr24SvOzbZVgzGvhWZFQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/8 =E4=B8=8B=E5=8D=882:50, Anand Jain wrote:
> On 5/7/21 10:00 am, Qu Wenruo wrote:
>> [BUG]
>> When subpage compressed read write support is enabled, btrfs/038 always
>> fail with EIO.
>>
>> A simplified script can easily trigger the problem:
>>
>> =C2=A0=C2=A0 mkfs.btrfs -f -s 4k $dev
>> =C2=A0=C2=A0 mount $dev $mnt -o compress=3Dlzo
>>
>> =C2=A0=C2=A0 xfs_io -f -c "truncate 118811" $mnt/foo
>> =C2=A0=C2=A0 xfs_io -c "pwrite -S 0x0d -b 39987 92267 39987" $mnt/foo >=
 /dev/null
>>
>> =C2=A0=C2=A0 sync
>> =C2=A0=C2=A0 btrfs subvolume snapshot -r $mnt $mnt/mysnap1
>>
>> =C2=A0=C2=A0 xfs_io -c "pwrite -S 0x3e -b 80000 200000 80000" $mnt/foo =
> /dev/null
>> =C2=A0=C2=A0 sync
>>
>> =C2=A0=C2=A0 xfs_io -c "pwrite -S 0xdc -b 10000 250000 10000" $mnt/foo =
> /dev/null
>> =C2=A0=C2=A0 xfs_io -c "pwrite -S 0xff -b 10000 300000 10000" $mnt/foo =
> /dev/null
>>
>> =C2=A0=C2=A0 sync
>> =C2=A0=C2=A0 btrfs subvolume snapshot -r $mnt $mnt/mysnap2
>>
>> =C2=A0=C2=A0 cat $mnt/mysnap2/foo
>> =C2=A0=C2=A0 # Above cat will fail due to EIO
>>
>> [CAUSE]
>> The problem is in btrfs_submit_compressed_read().
>>
>> When it tries to grab the extent map of the read range, it uses the
>> following call:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0em =3D lookup_extent_mapping(em_tree,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page_offset(bio_=
first_page_all(bio)),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_info->sectorsize);
>>
>> The problem is in the page_offset(bio_first_page_all(bio)) part.
>>
>> The offending inode has the following file extent layout
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 10 key (257 EXTEN=
T_DATA 131072) itemoff 15639 itemsize 53
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 generation 8 type 1 (regular)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent data disk byte 13680640 nr 4096
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent data offset 0 nr 4096 ram 4096
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent compression 0 (none)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 11 key (257 EXTEN=
T_DATA 135168) itemoff 15586 itemsize 53
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 generation 8 type 1 (regular)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent data disk byte 0 nr 0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 12 key (257 EXTEN=
T_DATA 196608) itemoff 15533 itemsize 53
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 generation 8 type 1 (regular)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent data disk byte 13676544 nr 4096
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent data offset 0 nr 53248 ram 86016
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent compression 2 (lzo)
>>
>
>
>
>> And the bio passed in has the following parameters:
>>
>> page_offset(bio_first_page_all(bio))=C2=A0=C2=A0=C2=A0 =3D 131072
>> bio_first_bvec_all(bio)->bv_offset=C2=A0=C2=A0=C2=A0 =3D 65536
>>
>> If we use page_offset(bio_first_page_all(bio) without adding bv_offset,
>> we will get an extent map for file offset 131072, not 196608.
>>
>> This means we read uncompressed data from disk, and later decompression
>> will definitely fail.
>>
>
>
>> [FIX]
>> Take bv_offset into consideration when trying to grab an extent map.
>>
>> And add an ASSERT() to ensure we're really getting a compressed extent.
>>
>> Thankfully this won't affect anything but subpage, thus we wonly need t=
o
>> ensure this patch get merged before we enabled basic subpage support.
>>
>
> Is it possible to simplify the test case?

I guess it's possible to simplify the test case further, but to me it
doesn't make much sense.

We don't make test case for regression which is not in upstream.

And the existing test case is good enough to catch it anyway.

Furthermore, there is another bug just exposed and fixed locally, that
in btrfS_do_readpage() we never reset @this_bio_flag, causing any later
read being treated as compressed read.

There will be more small fixes for read path in next update.

> Why is this not an issue in
> the case of the non-subpage filesystem?

Because for non-subpage case, bv_offset is always 0, as one page
represents one sector.

Thanks,
Qu
>
> Thanks, Anand
>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 fs/btrfs/compression.c | 9 ++++++---
>> =C2=A0 1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
>> index 9a023ae0f98b..19da933c5f1c 100644
>> --- a/fs/btrfs/compression.c
>> +++ b/fs/btrfs/compression.c
>> @@ -673,6 +673,7 @@ blk_status_t btrfs_submit_compressed_read(struct
>> inode *inode, struct bio *bio,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct page *page;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct bio *comp_bio;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 cur_disk_byte =3D bio->bi_iter.bi_se=
ctor << 9;
>> +=C2=A0=C2=A0=C2=A0 u64 file_offset;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 em_len;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 em_start;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct extent_map *em;
>> @@ -682,15 +683,17 @@ blk_status_t btrfs_submit_compressed_read(struct
>> inode *inode, struct bio *bio,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 em_tree =3D &BTRFS_I(inode)->extent_tree=
;
>> +=C2=A0=C2=A0=C2=A0 file_offset =3D bio_first_bvec_all(bio)->bv_offset =
+
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 page_offset(bio_first_page_all(bio));
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* we need the actual starting offset of=
 this extent in the file */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 read_lock(&em_tree->lock);
>> -=C2=A0=C2=A0=C2=A0 em =3D lookup_extent_mapping(em_tree,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page_offset(bio_first_page_all(bio=
)),
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_info->sectorsize);
>> +=C2=A0=C2=A0=C2=A0 em =3D lookup_extent_mapping(em_tree, file_offset,
>> fs_info->sectorsize);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 read_unlock(&em_tree->lock);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!em)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return BLK_STS_I=
OERR;
>> +=C2=A0=C2=A0=C2=A0 ASSERT(em->compress_type !=3D BTRFS_COMPRESS_NONE);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compressed_len =3D em->block_len;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cb =3D kmalloc(compressed_bio_size(fs_in=
fo, compressed_len),
>> GFP_NOFS);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cb)
>>
>
