Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC14421A38
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 00:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbhJDWnx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Oct 2021 18:43:53 -0400
Received: from mout.gmx.net ([212.227.17.22]:42789 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233501AbhJDWnx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Oct 2021 18:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633387319;
        bh=/puCFFyL+c5rWq4YDeU5BFnQkr2Xif5OZYi6CLN5h+E=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=eb4NI+pKl+9Za957jMP30z8KYGULOtarS6MlIYOgzRR8RTlOuvtuPUF/qPvSbz6EM
         o3sMlZnTKz5+V/0YhjGy4fUQVf2DnBoGIZTg3Sqtnj5K0O6Iu4ETjv9F7CMlSq/bSA
         eA6/t0A0kkwYArIHZ0YVhsIY/J13gvTV0N0MTKIM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MG9kC-1matEA1YiK-00GZvw; Tue, 05
 Oct 2021 00:41:59 +0200
Message-ID: <0c7be905-f943-0224-a958-0510c2c5c292@gmx.com>
Date:   Tue, 5 Oct 2021 06:41:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v3 10/26] btrfs: introduce submit_compressed_bio() for
 compression
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210927072208.21634-1-wqu@suse.com>
 <20210927072208.21634-11-wqu@suse.com> <20211004194231.GC9286@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20211004194231.GC9286@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QeQeXUdPrX5fB74NsjlmCpQjcOKXo6YdGPop1LqlsenIF8RalIV
 VOJTLWj/yogt3c0Qf/AbDQ6AhMUQ3c0dA1ZTpK8AamnTFxIBH5hdbUh/siYfq639DTucEdm
 LDJtasnKKfrOmmyRhFBOaNUbTCWk51U5kfXCshCez5Zg3AMb4xh1ouuhgOTHlAjFeMi5RkF
 t5SxA/z/pnBeLVnoBSi6w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NpvsYCMt65E=:Ny3HqQCrAYDUWNiOQ/Z0N7
 NWmNh+tyO8/yaJ8v6RGIxaHzn+w/qpGNCosm3M4w6/DOmCka7NmnMdJStTZoPtB3tY4hPJKkv
 pTIFMlXa5vJJAABkzK/oh/Pqo2EK0e8djXh+NTEPCe+gd5mUJ1P70bOYdi4T9xP361ddA3Uwc
 rCKPKFt/hz1v+qOKs53Sa/5vHQdUPdvV2pcLF+MdfeJZpH8SdMsz8UlOD/20uwL+FJsoZ4eQS
 AuKu6HInimxnX9j2IBB2OcnQ3IEqt1grBaOsUIGnvdtFAV/MGsFv63LN2Ckdg0EIPR9C6JE5p
 yFM5pcmfpa691ond04epJT6uStRUeiDPMoc83Ghf5M5C9lO6Y3aTkjoINHyZ/vnzOeLMbvn6p
 fLOOvR1QBr3UcGKdrOxRVeksl0A55Wgqw+1odqA+H05MXt9wVy4c/KpJoOualY918qIGHnDGW
 7aH0uVQ7lh2MWX12m5V1j8wmU6vJmtl7mPwpYnclXVfQgxcOYzaSwof4uVzZdZQm6zkZ8KdI6
 rvU+c+o0lc5WMkQnuXpDIZTyrs9V/VcldQxWzyCwaRkquSNJ0BbdH4sH5sRemC2z1L1qIdZcR
 +Vf28IBEwPSc1+S76IhldzNNo9qc71ONVJvGrywMK9dp49lZtMwgtJDhqViaHddQJeyc9biQn
 /kV3STTvGq/9WEIE6eXX0KxlLpjCrj6bOqAhefkSk1SuMI1umGcZuS1K310pn6KkAwv0zLAmH
 PKyilAhIKicb/fI6WFA9qYCVQjIOCgoYzEMh2I1nOaNKRtOvWPPxDX2y+rJz8h5DV0D1JJid1
 1ehzlHd4AMEovSx4XVNNopb4D9G3tMymX+AytocV5spJ9oI9SGWoQoqkOKY2sbXrnMkOCKu2p
 T+j/FgsPMbmfG0RRZqRNrnUtdYRGIX0UUovtS9PzIGEjtkk2Jo5YNx0vO16DIHkmPt3fzZ9QH
 ochFgSzeCnF6pEpzGwk1S2yWWFg4nKG7hQZwfYa5M1od+aI+eUyHi5EM9su3cTOowRAZCi3Wc
 Gn5XmzDVdmNGPmbOLi+HeJQauOiDvm7ZsBHhCV/ax7Hjq1M2tKKVS7aLor7+9PXXjhUvSKh63
 NAFNu6Kwr2yT9U=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/5 03:42, David Sterba wrote:
> On Mon, Sep 27, 2021 at 03:21:52PM +0800, Qu Wenruo wrote:
>> The new helper, submit_compressed_bio(), will aggregate the following
>> work:
>>
>> - Increase compressed_bio::pending_bios
>> - Remap the endio function
>> - Map and submit the bio
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/compression.c | 45 ++++++++++++++++++-----------------------=
-
>>   1 file changed, 19 insertions(+), 26 deletions(-)
>>
>> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
>> index b6ed5933caf5..3f0be97d17f3 100644
>> --- a/fs/btrfs/compression.c
>> +++ b/fs/btrfs/compression.c
>> @@ -422,6 +422,21 @@ static void end_compressed_bio_write(struct bio *b=
io)
>>   	bio_put(bio);
>>   }
>>
>> +static blk_status_t submit_compressed_bio(struct btrfs_fs_info *fs_inf=
o,
>> +					  struct compressed_bio *cb,
>> +					  struct bio *bio, int mirror_num)
>> +{
>> +	blk_status_t ret;
>> +
>> +	ASSERT(bio->bi_iter.bi_size);
>> +	atomic_inc(&cb->pending_bios);
>> +	ret =3D btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
>> +	if (ret)
>> +		return ret;
>> +	ret =3D btrfs_map_bio(fs_info, bio, mirror_num);
>> +	return ret;
>> +}
>> +
>>   /*
>>    * worker function to build and submit bios for previously compressed=
 pages.
>>    * The corresponding pages in the inode should be marked for writebac=
k
>> @@ -518,19 +533,13 @@ blk_status_t btrfs_submit_compressed_write(struct=
 btrfs_inode *inode, u64 start,
>>
>>   		page->mapping =3D NULL;
>>   		if (submit || len < PAGE_SIZE) {
>> -			atomic_inc(&cb->pending_bios);
>> -			ret =3D btrfs_bio_wq_end_io(fs_info, bio,
>> -						  BTRFS_WQ_ENDIO_DATA);
>> -			if (ret)
>> -				goto finish_cb;
>> -
>>   			if (!skip_sum) {
>>   				ret =3D btrfs_csum_one_bio(inode, bio, start, 1);
>>   				if (ret)
>>   					goto finish_cb;
>>   			}
>>
>> -			ret =3D btrfs_map_bio(fs_info, bio, 0);
>> +			ret =3D submit_compressed_bio(fs_info, cb, bio, 0);
>
> Can you please send me an explanation why it's still OK to aggregate the
> calls as it changes the order. Originally there's
>
> 	atomic_inc
> 	btrfs_bio_wq_end_io
> 	btrfs_csum_one_bio
> 	btrfs_map_bio
>
> While in the new code:
>
> 	btrfs_csum_one_bio
> 	from submit_compressed_bio:
> 		atomic_inc
> 		btrfs_bio_wq_end_io
> 		btrfs_map_bio
>
> So in particular the order of
>
> atomic_inc+btrfs_bio_wq_end_io is in reverse order with
> btrfs_csum_one_bio

The point is, btrfs_csum_one_bio() does nothing related to bio submission.

It really only fulfill btrfs_bio::csum.

The only important order is atomic_inc() -> btrfs_bio_wq_end_io() ->
btrfs_map_bio().

Thanks,
Qu

>
>> @@ -889,7 +887,7 @@ blk_status_t btrfs_submit_compressed_read(struct in=
ode *inode, struct bio *bio,
>>   						  fs_info->sectorsize);
>>   			sums +=3D fs_info->csum_size * nr_sectors;
>>
>> -			ret =3D btrfs_map_bio(fs_info, comp_bio, mirror_num);
>> +			ret =3D submit_compressed_bio(fs_info, cb, comp_bio, mirror_num);
>>   			if (ret)
>>   				goto finish_cb;
>>
>> @@ -904,16 +902,11 @@ blk_status_t btrfs_submit_compressed_read(struct =
inode *inode, struct bio *bio,
>>   		cur_disk_byte +=3D pg_len;
>>   	}
>>
>> -	atomic_inc(&cb->pending_bios);
>> -	ret =3D btrfs_bio_wq_end_io(fs_info, comp_bio, BTRFS_WQ_ENDIO_DATA);
>> -	if (ret)
>> -		goto last_bio;
>> -
>>   	ret =3D btrfs_lookup_bio_sums(inode, comp_bio, sums);
>>   	if (ret)
>>   		goto last_bio;
>>
>> -	ret =3D btrfs_map_bio(fs_info, comp_bio, mirror_num);
>> +	ret =3D submit_compressed_bio(fs_info, cb, comp_bio, mirror_num);
>
> Same for btrfs_lookup_bio_sums instead of btrfs_csum_one_bio.
>
