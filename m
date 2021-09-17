Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E859D40F78D
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Sep 2021 14:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244059AbhIQMes (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Sep 2021 08:34:48 -0400
Received: from mout.gmx.net ([212.227.15.18]:60203 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244052AbhIQMes (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Sep 2021 08:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631882003;
        bh=1ZCDkYFceUviM0AsPnfMqWqj//x8Uha/MUfJZkySRPk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=kYKA+vCXBTCoYYmoaiIKyP/eo6tkzrx5N+EtzOgll2aHg8PSTznusVWxeuOR79RwL
         L+sfPzan/ngS2yIkylid4SOgP6+64g9RKhGh17inGAbqqld4VaUjBf2SrOZ16aw4jM
         LXVO/geuRUHrP6k3PhzEsE7G5J4d9B3jhl/gKlxE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N8ofE-1mvRYa2Beg-015pUV; Fri, 17
 Sep 2021 14:33:23 +0200
Message-ID: <cdeeab90-2734-577c-f9eb-204605a32fbc@gmx.com>
Date:   Fri, 17 Sep 2021 20:33:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v3 2/3] btrfs: remove btrfs_bio_alloc() helper
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
References: <20210915071718.59418-1-wqu@suse.com>
 <20210915071718.59418-3-wqu@suse.com>
 <a4380e7b-b728-fd85-b6c1-175a53f6a1ce@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <a4380e7b-b728-fd85-b6c1-175a53f6a1ce@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PZJ2GRiiHcUPFyOrV73KOEzsPR/d0Mk2YAcgAUbHg6C4DsXdV3w
 AIs2S1egC6qnKGkKmNgGuaJ2nFuF8QdL6QbVMPOxFCkxMnuS8hzooHotqX38RObk+8SxtdE
 gR/l/NcRUGUs8UZQy7OMZ8w9hcJHEzBVgCnamz3FWLi2EVmwJC9BwqjK9s6PALkyj96gQoh
 v36ijVxqoyP7X/xPYBWwA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GXc3r9XzgaE=:UoDApORwC5bmNhQMTrtp86
 Efwtr1JDIIMTQlU13cDMfGMcDFcBcukgPhlGJwEy9/VtBMpFyTRrB2haYwLRm0pqw4JCyCCwp
 e5NK8A3n0ibhpsPmlGabRbTYR67sBkWJMyQe70IIK+43IPWyrAP+OXLmmCT+N0Pr51TKzNCal
 5VzRin1Oi5RJfq6TXfS7iqoAqgW1Ob81A/trcGaM8sMvU5+W1gzJUr01ucCSU/9si783A0eAD
 R48oXnN+bKYrBURRCvVxQwm6sXRn7Kja7KHcg4ncrAeNyRQTLEqQdI4LziaSms2equWihjGDs
 T4s+14H70VDXmR68fuzBoxugI8IJlqNYczk2VerY8tnnyQHXQKtUvwVXr5v6NxHVF2IKf47X/
 8t2U0Yvdz0uuXqz/Izaaoyz/3G1wNLMoHORNf3AEdhLWaQoTfWYw6z3sqQIeWONUrvwyh0fnN
 4x8QLDGK+h8uHkcyI/hVwN+eAHzFTU4lUovVrQqVWo1KUvfMWWHKuKApKCb7Khy2yX7h/P1FD
 OKUcdszBU0sEr4sYhTpSvL1RrrXoFBny+y4nKe/p/w/yl4QPQU+6DPut8s7mge7qOTz43twbp
 rnwgoEt/mQEmg2ruKmhHuictredFkkb1eAAh7yTzYs3CAanot2MKoZ1iqr3X713hm5sOISpC6
 rtRiQuW/HADDI6En7rOYFYeXaSw2ME6r5Dkpi+JhZ4Wq5CyxzqXZ4D9PGV6muBwGoNWH7lL5P
 aiL8AUdjlv6gxEDiC9X5EoeShPw8pNIbnRdzoSPTd+zjqV1nGMBkWLHI9ryYa5lteFjpGJRr8
 g0cwJoWcoKR2XFiD2vBlQT4Le/t4rt6tj4a/MMCvXyscBmR4w0cdf5scKLk2VZjG6Jz0Aa5s0
 O3Pc0BClZaf8AMfJQ53U89ToBpHDsE0RrIMtfbVwWujr+XNwWJYxYIAwlxfqHhyrjmhVKNfhp
 2DAnOm4mvDvQwe4SdNXRRTk2ouxlb16fyjIwAsuJmtJBaX8MruI0UlzLfMEiZ4gQC8Zoivu7/
 iNiYlaPwNwvcOdJ4Cf7QsUW6Ig+LLn4xG+8lgB4bcPZj/Pa0eymHfNu99+SeiLGDz4SDg8LpV
 AYVl/4WM3Vq0UQ=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/17 20:27, Nikolay Borisov wrote:
>
>
> On 15.09.21 =D0=B3. 10:17, Qu Wenruo wrote:
>> The helper btrfs_bio_alloc() is almost the same as btrfs_io_bio_alloc()=
,
>> except it's allocating using BIO_MAX_VECS as @nr_iovecs, and initialize
>> bio->bi_iter.bi_sector.
>>
>> However the naming itself is not using "btrfs_io_bio" to indicate its
>> parameter is "strcut btrfs_io_bio" and can be easily confused with
>> "struct btrfs_bio".
>>
>> Considering assigned bio->bi_iter.bi_sector is such a simple work and
>> there are already tons of call sites doing that manually, there is no
>> need to do that in a helper.
>>
>> Remove btrfs_bio_alloc() helper, and enhance btrfs_io_bio_alloc()
>> function to provide a fail-safe value for its @nr_iovecs.
>>
>> And then replace all btrfs_bio_alloc() callers with
>> btrfs_io_bio_alloc().
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/compression.c | 12 ++++++++----
>>   fs/btrfs/extent_io.c   | 33 +++++++++++++++------------------
>>   fs/btrfs/extent_io.h   |  1 -
>>   3 files changed, 23 insertions(+), 23 deletions(-)
>>
>> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
>> index 7869ad12bc6e..2475dc0b1c22 100644
>> --- a/fs/btrfs/compression.c
>> +++ b/fs/btrfs/compression.c
>> @@ -418,7 +418,8 @@ blk_status_t btrfs_submit_compressed_write(struct b=
trfs_inode *inode, u64 start,
>>   	cb->orig_bio =3D NULL;
>>   	cb->nr_pages =3D nr_pages;
>>
>> -	bio =3D btrfs_bio_alloc(first_byte);
>> +	bio =3D btrfs_io_bio_alloc(0);
>> +	bio->bi_iter.bi_sector =3D first_byte >> SECTOR_SHIFT;
>>   	bio->bi_opf =3D bio_op | write_flags;
>>   	bio->bi_private =3D cb;
>>   	bio->bi_end_io =3D end_compressed_bio_write;
>> @@ -490,7 +491,8 @@ blk_status_t btrfs_submit_compressed_write(struct b=
trfs_inode *inode, u64 start,
>>   				bio_endio(bio);
>>   			}
>>
>> -			bio =3D btrfs_bio_alloc(first_byte);
>> +			bio =3D btrfs_io_bio_alloc(0);
>> +			bio->bi_iter.bi_sector =3D first_byte >> SECTOR_SHIFT;
>>   			bio->bi_opf =3D bio_op | write_flags;
>>   			bio->bi_private =3D cb;
>>   			bio->bi_end_io =3D end_compressed_bio_write;
>> @@ -748,7 +750,8 @@ blk_status_t btrfs_submit_compressed_read(struct in=
ode *inode, struct bio *bio,
>>   	/* include any pages we added in add_ra-bio_pages */
>>   	cb->len =3D bio->bi_iter.bi_size;
>>
>> -	comp_bio =3D btrfs_bio_alloc(cur_disk_byte);
>> +	comp_bio =3D btrfs_io_bio_alloc(0);
>> +	comp_bio->bi_iter.bi_sector =3D cur_disk_byte >> SECTOR_SHIFT;
>>   	comp_bio->bi_opf =3D REQ_OP_READ;
>>   	comp_bio->bi_private =3D cb;
>>   	comp_bio->bi_end_io =3D end_compressed_bio_read;
>> @@ -806,7 +809,8 @@ blk_status_t btrfs_submit_compressed_read(struct in=
ode *inode, struct bio *bio,
>>   				bio_endio(comp_bio);
>>   			}
>>
>> -			comp_bio =3D btrfs_bio_alloc(cur_disk_byte);
>> +			comp_bio =3D btrfs_io_bio_alloc(0);
>> +			comp_bio->bi_iter.bi_sector =3D cur_disk_byte >> SECTOR_SHIFT;
>>   			comp_bio->bi_opf =3D REQ_OP_READ;
>>   			comp_bio->bi_private =3D cb;
>>   			comp_bio->bi_end_io =3D end_compressed_bio_read;
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 1aed03ef5f49..d3fcf7e8dc48 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -3121,16 +3121,22 @@ static inline void btrfs_io_bio_init
> After reading through the whole patch I agree with the naming, though
> yeah it's a bit long, but we've been using this wordy naming. For
> identifiers it's fine to use lbio and it's now clear from the context
> that it's about the btrfs-specific features.(struct btrfs_io_bio *btrfs_=
bio)
>>   }
>>
>>   /*
>> - * The following helpers allocate a bio. As it's backed by a bioset, i=
t'll
>> - * never fail.  We're returning a bio right now but you can call btrfs=
_io_bio
>> - * for the appropriate container_of magic
>> + * Allocate a btrfs_io_bio, with @nr_iovecs as maximum iovecs.
>> + *
>> + * If @nr_iovecs is 0, it will use BIO_MAX_VECS as @nr_iovces instead.
>> + * This behavior is to provide a fail-safe default value.
>> + *
>> + * This helper uses bioset to allocate the bio, thus it's backed by me=
mpool,
>> + * and should not fail from process contexts.
>>    */
>> -struct bio *btrfs_bio_alloc(u64 first_byte)
>> +struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs)
>>   {
>>   	struct bio *bio;
>>
>> -	bio =3D bio_alloc_bioset(GFP_NOFS, BIO_MAX_VECS, &btrfs_bioset);
>> -	bio->bi_iter.bi_sector =3D first_byte >> 9;
>> +	ASSERT(nr_iovecs <=3D BIO_MAX_VECS);
>> +	if (nr_iovecs =3D=3D 0)
>> +		nr_iovecs =3D BIO_MAX_VECS;
>
> hell no! How come passing 0 actually means BIO_MAX_VEC. Instead of
> having 0 everywhere and have the function translate this to
> BIO_MAX_VECS, simply pass BIO_MAX_VECS in every call site where it's
> needed.

That's part of the feedback I want.

I'm not yet determined on which should be the proper way.

Yes, we can pass BIO_MAX_VEC for call sites which doesn't care about the
vector size.

But I also think letting callers to bother less is a good idea.
(one of the few moments I think function overriding can be very useful her=
e)

If you have objection, I'm pretty happy to change the behavior, and just
do an ASSERT() to catch any values larger than BIO_MAX_VECS.

Thanks,
Qu
>
> David, please either fix the patch in the tree or retract it. Let's try
> and refrain from adding such "gems" to the code base.
>
> <snip>
>
