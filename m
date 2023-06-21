Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D369A737BB9
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jun 2023 09:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjFUGwK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jun 2023 02:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjFUGvf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jun 2023 02:51:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEFB271D;
        Tue, 20 Jun 2023 23:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1687330234; x=1687935034; i=quwenruo.btrfs@gmx.com;
 bh=DY1w4JKQB5YQTEG1giUVdQHD0Z03i7kVXBCwEr7Vlm8=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=JWKvEebpqxM/qeu7YpAhzJ/k+hrsuXgwcVnTYhpVzvgeOHcU50w584zIh+FJbv01kF+tegI
 Op1T0XRpXhuUHgJtc5BGUkMJHqojM++7rCsSr0sS0n5g5q7/8qbdwfhmCPByEn29fbrXX+laI
 qHC/rxln6XaH/7MPi7ptaOHzHtU47vcqnWYYTrXaA+87uryRgOyrjkRf2/VHqZbt/R9G7XQnQ
 sGR36VnHaeJq4JQ30ykJLG/fRjdu0jh+krdOn56O/LaKPZvg/r1o94q2BLCvK2FMH85rVcTyJ
 rGzToSAQeXVoR0V1uf7/ECCquyYyn5IwTsyu6o3MAKNugezcfY/A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MsHru-1pvq9g0OxW-00tlnx; Wed, 21
 Jun 2023 08:50:34 +0200
Message-ID: <92c26067-8afd-c01b-ea1e-4a87fc260355@gmx.com>
Date:   Wed, 21 Jun 2023 14:50:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btrfs: add test case to verify the behavior with large
 RAID0 data chunks
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20230621015107.88931-1-wqu@suse.com>
 <90714755-3b63-b95c-87dd-1a7ef785c461@oracle.com>
 <790f7e19-a31b-c27c-570e-5e3125e4a1d9@gmx.com>
 <e30423bb-8b9b-06e0-3978-4711afb77c58@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <e30423bb-8b9b-06e0-3978-4711afb77c58@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ySzVhbFM0Bq9G5W2ou3Z1s2gNDqwpy5uMXTxOmlO78Yt+6c7BR/
 xVMREfFOET0egdD4A8W9yLccN68EgNg/m6oXw4AjY+Y7/R8tMB6S4ABVCXPXmquHBZv71gp
 JDghuolavmvlMfAAzwEOF+f+o9Zb8zGONAMxoH7RhfLoE0Y3PxI9M9wX8AfnNAG5032DsvC
 /SAEvPd6ZyTeABT/7R6UA==
UI-OutboundReport: notjunk:1;M01:P0:yj2d89+S0iM=;NXcAq8srgbMfIp9PsknfItCI5m7
 gbByqYjbZZOd0uKu7NOitPr61wSMdh4C50CFNuNnqqTjMptu1XiTtPR9/S3An3sAU9pN/GVu9
 B1c0fbj6reuKe2EeD0LePoLRhnWbA7g51VLymaWxUIqPiBmGeJJ0nKpxEM74tvlZs6G5yDB2P
 KjANkbl+1snTovIxSdtThl+kQrlgE6QZe1U1lk7wtRfZfxjE3gMXm41Gdypc0H1rByFB+uqts
 lyjBn77l0GkwMMUjg/mDzwBLIXqYqxWdnLZXerDcILP1j+mFHMVNWeBuveH10t94uAkrFSVVY
 /hB0ItmTIWZFLmvnVYQig/OrGsYwjjAhWAxIljikcSqwo6ihnJYjMKmFchpGNOzJIrvwgt9QE
 OydP6Y7Pwgga2ZorQ7ioOpjvoqiuZEhYSOlG0DuMOQt1pwF/oaV/pYci5lgSqTsTjk0TcRmdY
 kzAatEql+8bjXVNJLq1NLdAORPxLIJVOkwAnBEh2hFT3iPD6Rz+Pwv4hXnx0mwHWKAqrhFszy
 DOXmSUaDFtNp5N5tlWSrET9IyK5CPYYPnLimY+gAypQsnblPG81wQoZary8rumqNWYO7ppjrm
 t9NOQOFvV9dnH9HSnLfiAJhnxi25JAfzr6mT0VZXnvAqA3LPUkB5PhYjh6CrZFjJP/czpRjmj
 VMF866dEFqY70Whe+WHr8YdCv8t6wv30G5Ab0orXa6DRQCr6AKrF/nXfKS7LFeXz0rm4Iqabn
 YX22I2cYL/cmOdVyIy/0Eb/gvwNUrU/YPLNHxjnwN5RFfFYAlTTCOhh06Wl8p2E9c8FhuqkLr
 xJDdzsmZyu271Zff1DIMZE1XWyDpGwVDyC0xZScLhLsHSFAjOjEqPxhpe2IcyLqU6ycXBrNkN
 yszwppj9N9oJpKS3Oc4GYz4FyjgKmQ27VyiHPf2FpM5AsyaNxwKhpCSE/M2KhhKnC3U1r9anp
 8Y9CPZpO/4jkQdU8xZSO+UFkKis=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/21 14:35, Anand Jain wrote:
>
>
> On 21/06/2023 14:00, Qu Wenruo wrote:
>>
>>
>> On 2023/6/21 13:47, Anand Jain wrote:
>>>
>>>
>>>
>>>> +for i in $SCRATCH_DEV_POOL; do
>>>> +=C2=A0=C2=A0=C2=A0 devsize=3D$(blockdev --getsize64 "$i")
>>>> +=C2=A0=C2=A0=C2=A0 if [ $devsize -lt $((2 * 1024 * 1024 * 1024)) ]; =
then
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _notrun "device $i is too=
 small, need at least 2G"
>>>
>
>
>>> Also, you need to check if those devices support discard.
>>>
>
> Howabout this?
>
>
> btrfs/292=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - output mismatch (see
> /xfstests-dev/results//btrfs/292.out.bad)
>  =C2=A0=C2=A0=C2=A0 --- tests/btrfs/292.out=C2=A0=C2=A0=C2=A0 2023-06-21=
 13:27:12.764966120 +0800
>  =C2=A0=C2=A0=C2=A0 +++ /xfstests-dev/results//btrfs/292.out.bad=C2=A0=
=C2=A0=C2=A0 2023-06-21
> 13:54:01.863082692 +0800
>  =C2=A0=C2=A0=C2=A0 @@ -1,2 +1,3 @@
>  =C2=A0=C2=A0=C2=A0=C2=A0 QA output created by 292
>  =C2=A0=C2=A0=C2=A0 +fstrim: /mnt/scratch: the discard operation is not =
supported
>  =C2=A0=C2=A0=C2=A0=C2=A0 Silence is golden
>  =C2=A0=C2=A0=C2=A0 ...
>  =C2=A0=C2=A0=C2=A0 (Run 'diff -u /xfstests-dev/tests/btrfs/292.out
> /xfstests-dev/results//btrfs/292.out.bad'=C2=A0 to see the entire diff)
>
> HINT: You _MAY_ be missing kernel fix:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xxxxxxxxxxxx btrfs: fix u32 overflows wh=
en left shifting @stripe_nr

That's true, I'll add the needed require line in the next update.

Thanks,
Qu
>
>
>
>
>>> Uneven device sizes will alter the distribution of chunk allocation.
>>> Since the default chunk allocation is also based on the device sizes
>>> and free spaces.
>>
>> That is not a big deal, if we have all 6 devices beyond 2G size, we're
>> already allocating the device stripe in 1G size anyway, and we're
>> ensured to have a 6G RAID0 chunk no matter if the sizes are uneven.
>
> Ah. RAID0. Got it.
>
>> It's the next new data chunk going to be affected, but our workload
>> would only need the initial RAID0 chunk, thus it's totally fine to have
>> uneven disk sizes.
>
>>>
>>>
>>>> +=C2=A0=C2=A0=C2=A0 fi
>>>> +done
>>>> +
>>>> +_scratch_pool_mkfs -m raid1 -d raid0 >> $seqres.full 2>&1
>>>> +_scratch_mount
>>>> +
>>>> +# Fill the data chunk with 5G data.
>>>> +for (( i =3D 0; i < $nr_files; i++ )); do
>>>> +=C2=A0=C2=A0=C2=A0 xfs_io -f -c "pwrite -i /dev/urandom 0 $filesize"
>>>> $SCRATCH_MNT/file_$i > /dev/null
>>>> +done
>>>> +sync
>>>> +echo "=3D=3D=3D With initial 5G data written =3D=3D=3D" >> $seqres.f=
ull
>>>> +$BTRFS_UTIL_PROG filesystem df $SCRATCH_MNT >> $seqres.full
>>>> +
>>>> +_scratch_unmount
>>>> +
>>>> +# Make sure we haven't corrupted anything.
>>>> +$BTRFS_UTIL_PROG check --check-data-csum $SCRATCH_DEV >> $seqres.ful=
l
>>>> 2>&1
>>>> +if [ $? -ne 0 ]; then
>>>> +=C2=A0=C2=A0=C2=A0 _fail "data corruption detected after initial dat=
a filling"
>>>> +fi
>>>> +
>>>> +_scratch_mount
>>>> +# Delete half of the data, and do discard
>>>> +rm -rf - "$SCRATCH_MNT/*[02468]"
>>>
>>> Are there any specific chunks that need to be deleted to successfully
>>> reproduce this test case?
>  >
>> No, there is and will only be one data chunk.
>
>
>  =C2=A0Right. I missed the point it is a raid0.
>
>
>> We're here only to create holes to cause extra trim workload.
>>
>
> Thanks, Anand
>
>>>
>>>> +sync
>>>> +$FSTRIM_PROG $SCRATCH_MNT
>>>
>>> Do we need fstrim if we use mount -o discard=3Dsync instead?
>>
>> There is not much difference.
>
>
