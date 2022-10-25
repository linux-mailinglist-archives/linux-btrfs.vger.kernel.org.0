Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A5460D7EF
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 01:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiJYXbt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Oct 2022 19:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJYXbs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Oct 2022 19:31:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF14E9853
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Oct 2022 16:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666740702;
        bh=EdGUShqoVgFXVYV3RIpxKBOOIVIdTp2KNIIbJfvX3ao=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=RVBWVuT7vpDb7n7BqsaOVb+V+Y7nVFJ+Cu50We+E/9PhI3u33dz4naUHr1/c7Xf+2
         J5H6VP0yTjEkuazKp9AmZtcAw7zeN9N8NLVebl0P2hxqELrZ5akZyCDI9B4HZTi1TL
         hqKIewckugIyo4oDhKvUfcBPyI3Dqzthxzo8tZQ8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MjjCF-1pUCwQ2gfb-00lA37; Wed, 26
 Oct 2022 01:31:42 +0200
Message-ID: <21b3a262-7e66-179c-dbc1-b7fab5477734@gmx.com>
Date:   Wed, 26 Oct 2022 07:31:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH RFC 5/5] btrfs: raid56: do full stripe data checksum
 verification before RMW
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1665730948.git.wqu@suse.com>
 <9389bb7901990ef7c0d0c58dc4c1168fd4240d27.1665730948.git.wqu@suse.com>
 <20221025142140.GN5824@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221025142140.GN5824@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rxe+SZAib82FQUQbeSy5v0B/GorM3FU6zLyjIfCdgseYg//r9VQ
 dcIXu4znO4xdA7zkb8d1Rt4Z7BKF5EK7YSRO01PF/Yxo9U1R0pr9kq4kNc8ih87Ie57ugTA
 Mc3oyJV7IyxHGybAgXoOSh1iRkO+oqWN+kTPnfJ41EaWwYPhFEd9hTNXvw4Xg50HumdkItZ
 AWgjTnCD0gad5EwgxJJrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OpWcmFTeslY=:tMuU1kMglY3vETF1VppxJr
 MFaIRTthSYvxLLSIq79tOYGieBs1hDOwQm5441bhaFWwon7lsawh3D0qqX77rwyqcQiwEy56N
 lYSz0ghn6zKQfidZSPPGjAiEIHbkZQrGoioFt0T7JEugxzN5S/L/O0lV2fH59U2d9vg1eHZjE
 CGvIlfNC11nbFhO5p/Y2qbpWjQBHLggoJr/5rDZDHI/LcfYcz0jCeJxf6jtU3Hu58IsHtdFbe
 gtNG+hjfdGCUxaaehRZmGp7P5ycpUD2/N4VhtSXHxAphxswnEVekXyNTptY5p2JBeu6T5vmVK
 XWkmPLyo1lSNx6kNc0kig7Bv1ISnCBaShJKpDfN4kxnAp2v0wUd96N9y8skQXbL/X8iaTom4e
 uDpmPNerNuilMkR0c4t9zwTkbbuYHHqtts7yozSEQpXP5QAj56Z8T3wGm40U4VJXO2djgWNzz
 aGFJL23G2YnS4iSLg0cYrbhMv6/8Nol2RnLetOQwNbhAa86rDXS5tqbtbhn2JgfRPx7l8siN4
 u77zJClmw0BEYVB9tdBS7QFcuHho9wZLY8El7JjpnH6bhVcrC03S9WkhXhoxewU4uwCVmLXQe
 K+T52EJohHrMhLalJv7XUYTaJwQdCoRSzrI6FCOrOomZeKPzBDzUh3784ZbDC46Kn7qGIzxtz
 bjd5Q/cOSfBHXGFggNltSySfoS9enzCT2dVDSUbFdrLicYPvkI6sht1MKM8/juPsnJNUAcLgZ
 dWSMQJQa2KAzIXPqdyIqIMJZwysHCxe+FO2U3+ZXa30kVfBvtPdjfEvBrLFdAlcSJzo8Gf6/r
 7AgNNdILwa+tWUweFKF/2JzbIZj3QhDYIz0uK6oUpw9cT4orrTBe4fcSf4DO9ZDALs5s0keDY
 5wpLo1t1btqD0j1RWi7iRlSR1LR8pJ9CvJR1iPNUgfcUKJmGjImV8i4rwE3D6zvHpN+YnvHXN
 XRuyu0+Iy3fmD3CRwysIbwLh0ZQNxIcki3fJqplLyx0fACJvjkI3QzpbkkNNTF953r1y1p6JT
 Y1aVl7Opyk6667l+e9Uqg1qie3X12U6vH4+BRvdU+nPEV1TlKfQP8pG3KGPQmjR2dmk4wMBbe
 fBIAZsucM0uKDkjB13zhlwQZsWj3s4lyO7og3P2w6qTJISHKoGM63bq02JTYG5A3XsfXFca6o
 pMxoaCPL3RLtbMZG89QBo0QBeWCaARCPGd0wsB4poOoUs4ubBHnQQfHeZXVJQTvpJZLqli9N1
 9/W3Xc4g/0NItMKw2Il+NwckoyWE4FKK+bwCPchHklUug5NiE8pyuq+DDB+6deHQQ5fwrXiWq
 y3oc4jHYU+zES5mtR5K3WyeMYcCta3G52yw2cbIX8QKJIKj+6BgqWBD5a19ucai1upvA2NEmP
 eaJuYfwekWuLCgRCfF5xgb2ehlT0ZKp6G6VI63a00QSWYN9vyzuh+PBQAAZ8T6V2riWxdAA8v
 NUiDRrGKhcktC011HyhIEX1jqD+QrN9wFfknpKBV257tBGge2DuOs7WFAzAOYBVkS7zc+p0g0
 54C3rfaczSyBi+qsdaL7X9+ER8WERIGFq/EqogAlNSGgV
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/25 22:21, David Sterba wrote:
> On Fri, Oct 14, 2022 at 03:17:13PM +0800, Qu Wenruo wrote:
>> [BUG]
>> For the following small script, btrfs will be unable to recover the
>> content of file1:
>>
>>    mkfs.btrfs -f -m raid1 -d raid5 -b 1G $dev1 $dev2 $dev3
>>
>>    mount $dev1 $mnt
>>    xfs_io -f -c "pwrite -S 0xff 0 64k" -c sync $mnt/file1
>>    md5sum $mnt/file1
>>    umount $mnt
>>
>>    # Corrupt the above 64K data stripe.
>>    xfs_io -f -c "pwrite -S 0x00 323026944 64K" -c sync $dev3
>>    mount $dev1 $mnt
>>
>>    # Write a new 64K, which should be in the other data stripe
>>    # And this is a sub-stripe write, which will cause RMW
>>    xfs_io -f -c "pwrite 0 64k" -c sync $mnt/file2
>>    md5sum $mnt/file1
>>    umount $mnt
>>
>> Above md5sum would fail.
>>
>> [CAUSE]
>> There is a long existing problem for raid56 (not limited to btrfs
>> raid56) that, if we already have some corrupted on-disk data, and then
>> trigger a sub-stripe write (which needs RMW cycle), it can cause furthe=
r
>> damage into P/Q stripe.
>>
>>    Disk 1: data 1 |0x000000000000| <- Corrupted
>>    Disk 2: data 2 |0x000000000000|
>>    Disk 2: parity |0xffffffffffff|
>>
>> In above case, data 1 is already corrupted, the original data should be
>> 64KiB of 0xff.
>>
>> At this stage, if we read data 1, and it has data checksum, we can stil=
l
>> recover going the regular RAID56 recovery path.
>>
>> But if now we decide to write some data into data 2, then we need to go
>> RMW.
>> Just say we want to write 64KiB of '0x00' into data 2, then we read the
>> on-disk data of data 1, calculate the new parity, resulting the
>> following layout:
>>
>>    Disk 1: data 1 |0x000000000000| <- Corrupted
>>    Disk 2: data 2 |0x000000000000| <- New '0x00' writes
>>    Disk 2: parity |0x000000000000| <- New Parity.
>>
>> But the new parity is calculated using the *corrupted* data 1, we can
>> no longer recover the correct data of data1.
>> Thus the corruption is forever there.
>>
>> [FIX]
>> To solve above problem, this patch will do a full stripe data checksum
>> verification at RMW time.
>>
>> This involves the following changes:
>>
>> - For raid56_rmw_stripe() we need to read the full stripe
>>    Unlike the old behavior, which will only read out the missing part,
>>    now we have to read out the full stripe (including data and P/Q), so
>>    we can do recovery later.
>>
>>    All the read will directly go into the rbio stripe sectors.
>>
>>    This will not affect cached case, as cached rbio will always has all
>>    its data sectors cached. And since cached sectors are already
>>    after a RMW (which implies the same data csum check), they should be
>>    always correct.
>>
>> - Do data checksum verification for the full stripe
>>    The target is only the rbio stripe sectors.
>>
>>    The checksum is already filled before we reach finish_rmw().
>>    Currently we only do the verification if there is no missing device.
>>
>>    The checksum verification will do the following work:
>>
>>    * Verify the data checksums for sectors which has data checksum of
>>      a vertical stripe.
>>
>>      For sectors which doesn't has csum, they will be considered fine.
>>
>>    * Check if we need to repair the vertical stripe
>>
>>      If no checksum mismatch, we can continue to the next vertical
>>      stripe.
>>      If too many corrupted sectors than the tolerance, we error out,
>>      marking all the bios failed, to avoid further corruption.
>>
>>    * Repair the vertical stripe
>>
>>    * Recheck the content of the failed sectors
>>
>>      If repaired sectors can not pass the checksum verification, we
>>      error out
>>
>> This is a much strict workflow, meaning now we will not write a full
>> stripe if it can not pass full stripe data verification.
>>
>> Obviously this will have a performance impact, as we are doing more
>> works during RMW cycle:
>>
>> - Fetch the data checksum
>> - Do checksum verification for all data stripes
>> - Do recovery if needed
>> - Do checksum verification again
>>
>> But for full stripe write we won't do it at all, thus for fully
>> optimized RAID56 workload (always full stripe write), there should be n=
o
>> extra overhead.
>>
>> To me, the extra overhead looks reasonable, as data consistency is way
>> more important than performance.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/raid56.c | 279 +++++++++++++++++++++++++++++++++++++++++----=
-
>>   1 file changed, 251 insertions(+), 28 deletions(-)
>>
>> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
>> index 8f7e25001a2b..e51c07bd4c7b 100644
>> --- a/fs/btrfs/raid56.c
>> +++ b/fs/btrfs/raid56.c
>> @@ -1203,6 +1203,150 @@ static void bio_get_trace_info(struct btrfs_rai=
d_bio *rbio, struct bio *bio,
>>   	trace_info->stripe_nr =3D -1;
>>   }
>>
>> +static void assign_one_failed(int failed, int *faila, int *failb)
>> +{
>> +	if (*faila < 0)
>> +		*faila =3D failed;
>> +	else if (*failb < 0)
>> +		*failb =3D failed;
>> +}
>> +
>> +static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr=
,
>> +			    int extra_faila, int extra_failb,
>> +			    void **pointers, void **unmap_array);
>> +
>> +static int rmw_validate_data_csums(struct btrfs_raid_bio *rbio)
>> +{
>> +	struct btrfs_fs_info *fs_info =3D rbio->bioc->fs_info;
>> +	int sector_nr;
>> +	int tolerance;
>> +	void **pointers =3D NULL;
>> +	void **unmap_array =3D NULL;
>> +	int ret =3D 0;
>> +
>> +	/* No checksum, no need to check. */
>> +	if (!rbio->csum_buf || !rbio->csum_bitmap)
>> +		return 0;
>> +
>> +	/* No datacsum in the range. */
>> +	if (bitmap_empty(rbio->csum_bitmap,
>> +			 rbio->nr_data * rbio->stripe_nsectors))
>> +		return 0;
>> +
>> +	pointers =3D kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
>> +	unmap_array =3D kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS)=
;
>> +	if (!pointers || !unmap_array) {
>> +		ret =3D -ENOMEM;
>> +		goto out;
>> +	}
>> +
>> +	if (rbio->bioc->map_type & BTRFS_BLOCK_GROUP_RAID5)
>> +		tolerance =3D 1;
>> +	else
>> +		tolerance =3D 2;
>
> Please avoid the "if (...map & TYPE)" checks for values that we have
> have in the raid attribute table, in this case it's tolerated_failures.

In fact, we already have one, it's rbio->bioc->max_error.

I'll go that way instead.

Thanks,
Qu
>
>> +
>> +	for (sector_nr =3D 0; sector_nr < rbio->stripe_nsectors; sector_nr++)=
 {
>> +		int stripe_nr;
>> +		int found_error =3D 0;
>>   	     total_sector_nr++) {
>>   		sector =3D rbio_stripe_sector(rbio, stripe, sectornr);
>> +		 */
>> +		sector =3D rbio_stripe_sector(rbio, stripe, sectornr);
>>   	bio_endio(bio);
>
>> +static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr=
,
>> +			    int extra_faila, int extra_failb,
>> +			    void **pointers, void **unmap_array)
>>   {
>>   	struct btrfs_fs_info *fs_info =3D rbio->bioc->fs_info;
>>   	struct sector_ptr *sector;
>>   	const u32 sectorsize =3D fs_info->sectorsize;
>> -	const int faila =3D rbio->faila;
>> -	const int failb =3D rbio->failb;
>> +	int faila =3D -1;
>> +	int failb =3D -1;
>> +	int failed =3D 0;
>> +	int tolerance;
>>   	int stripe_nr;
>>
>> +	if (rbio->bioc->map_type & BTRFS_BLOCK_GROUP_RAID5)
>> +		tolerance =3D 1;
>> +	else
>> +		tolerance =3D 2;
>
> And here.
>
>> +
>> +	failed =3D calculate_failab(rbio, extra_faila, extra_failb, &faila, &=
failb);
>> +
>> +	if (failed > tolerance)
>> +		return -EIO;
>> +
>>   	/*
>>   	 * Now we just use bitmap to mark the horizontal stripes in
>>   	 * which we have data when doing parity scrub.
>>   	 */
>>   	if (rbio->operation =3D=3D BTRFS_RBIO_PARITY_SCRUB &&
>>   	    !test_bit(sector_nr, &rbio->dbitmap))
>> -		return;
>> +		return 0;
>>
>>   	/*
>>   	 * Setup our array of pointers with sectors from each stripe
