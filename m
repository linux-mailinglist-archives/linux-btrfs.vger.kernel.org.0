Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE55A7251D1
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 03:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240678AbjFGBxW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 21:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbjFGBw7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 21:52:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A5F19B2;
        Tue,  6 Jun 2023 18:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686102760; x=1686707560; i=quwenruo.btrfs@gmx.com;
 bh=R4cTetJKfHkikyB8UWgfzqUFs9dNVAFAq6vFFQ6DqIw=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=EPG0PMjhkwMGSps1Ldvjx5bMa8PFszd5WXegx5QNl9fDoG+jCwgWShk5bc5YE2Ung9Fdr40
 Du4HD18M1wNltcDWcRg0EaSaqrqqGWRlxBwNBuge2Wc6s0QqjKzqLoOwK8905g92QAelq7UIG
 5biOVU4atXP4KpKBax65O70jZmcGW2XO8uph/1x3Zw1LJqEB1JLnmbC9XJTQg2kO68Ei/ckCO
 0sByh9RNbynDouN/ef+R+DOFndCbqEu0casu6K28w37lezjX33gP8uLf/Xt5AOsmQz3/3pk2S
 e5lc527oo+U+nN2xaPFcS5p1ZLOaFJ0qEf/hYBhQSVL5S0ToCoHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MkHMP-1qUTVe3YHR-00kfSw; Wed, 07
 Jun 2023 03:52:40 +0200
Message-ID: <f0745b27-2e93-7e35-384a-e5cd7b832a3f@gmx.com>
Date:   Wed, 7 Jun 2023 09:52:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] btrfs/266: test case enhancement to cover more possible
 failures
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20230606103027.125617-1-wqu@suse.com>
 <2f4659d6-667d-d9d2-7bf8-656019fd3c99@oracle.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <2f4659d6-667d-d9d2-7bf8-656019fd3c99@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nOAbQzuuSUwwWa63p8nSuWdEyptgj6VVogsSG0OXIVg50y2NliB
 06WAfpWAsGJ086ttqnGu1uiviDV2A61rFnjK9IuS6DvGPZtJRPA8MrFRkBM32EiAmhER/55
 KEuMpYewj36c3ueg7jYsdqUhwJbSED1vslebKCzNZhBCFzAfQFK5X5LcUtVO24C3qZdceUU
 7opfM7V0JyAg1jMOzJ7wA==
UI-OutboundReport: notjunk:1;M01:P0:C24SDvN80og=;y6QBehUq6O1vx2fRP5+599XHllh
 8nK+zFwylu9nZIcSb0Msn05BkkhuSLPaYecnVdQY3mDLtmkT+7QWqSikL3Ehps1XHZNbuwnqA
 MiXX5rXKUj+vnts69gCIYLCAwT6js1J/FDTvk2T69MEOaF6CBI7LDVODNNUOqJ84LE0jAahP4
 aBc/vvxHo4PKMEIZ2a4GLbSp7Pmf874q66c+rfHTo91g70MVFzUewH2RXbfPWvDJc75maGYdS
 9uQ2b2+ee53fvcIfUNYlpM8ZsezRnjh0ri6SWlfLgimwm/kaKrrq0mcjRRlYGdrDzomYm99gI
 CY69e1zy/bl3+LvaSDoYYB1laIhc59QotBBEPgyXJ+W6looJGNyYPaBoaB5jc9mrxE0hSIoIN
 wuNho+cqM0Z6ngLHJ41LarA5Ugy+MJ21yj5LTb500lk7nwx4FD1RZU5hHUymkmC788hLNtli2
 +ULdSRdSQp7+RcHDAbY+G+jdMj2mc9YUjNj8F5hc9I8rdG9dFvfbX2gsVZpgb6D3fE3DJi3L+
 EP2Hthag1MopfHY7la1NvvZIhHW8OCb15TLdDD0SlTQQzIOgzUAXW9ke3uZlQixb+6RKUf7qH
 IeZoPOwqrN85RMokdELMTh0rFR/iQQBumbE2F5kCyXazdS1MTKax2lPBeB7bHQONVHgLCpnk0
 a76cm2nTIrlzMwmCLp0E4GpWqYel0PZJXinaG1YER7/lNiN9VxfllylD6bW9FmgeH9hkt4ypp
 Ja40atshnFO/lvp/dW/sYWYaJYvvO4elZz4nY+M6v+WcL6W4z7qTM7dtWBoiwktRBxrWIEuhQ
 iHjAoVNNXfQYbaH4xcM3UFBkqzXN1cJfp/cq6KvJYNs2tRuvYx8bkydj4xNv3ocnim/jeKR4K
 aN/MXp8W1d1GWDJAMqTfMKMA7YFKZwALPEFpGqbh70wAgy7ujZaDyR1uhenRSq+zN5VNUlTaa
 S8IAVb/TOwv+Gq4ALBuAw1yY17E=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/7 08:13, Anand Jain wrote:
>
>
>  =C2=A0It is failing on sectorsize 64k.

That's what I'm investigating.

And the failure is random, if you ran more times it would pass (the
failure rate is 1/3~1/5 in my case).

Thanks,
Qu
>
> ---------
> btrfs/266 2s ... - output mismatch (see
> /xfstests-dev/results//btrfs/266.out.bad)
>  =C2=A0=C2=A0=C2=A0 --- tests/btrfs/266.out=C2=A0=C2=A0=C2=A0 2023-06-06=
 20:02:48.900915702 -0400
>  =C2=A0=C2=A0=C2=A0 +++ /xfstests-dev/results//btrfs/266.out.bad=C2=A0=
=C2=A0=C2=A0 2023-06-06
> 20:02:56.665554779 -0400
>  =C2=A0=C2=A0=C2=A0 @@ -19,11 +19,11 @@
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Physical offset + 64K:
>  =C2=A0=C2=A0=C2=A0=C2=A0 XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa =
aa aa aa aa aa aa
> ................
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Physical offset + 128K:
>  =C2=A0=C2=A0=C2=A0 -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa=
 aa aa aa aa
> ................
>  =C2=A0=C2=A0=C2=A0 +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb bb bb=
 bb bb bb bb
> ................
> -------
>
> Thanks, Anand
>
>
> On 06/06/2023 18:30, Qu Wenruo wrote:
>> [BACKGROUND]
>> Recently I'm debugging a random failure with btrfs/266 with larger page
>> sizes (64K page size, with either 64K sector size or 4K sector size).
>>
>> During the tests, I found the test case itself can be further enhanced
>> to make better coverage and easier debugging.
>>
>> [ENHANCEMENT]
>>
>> - Ensure every 64K block only has one good mirror
>> =C2=A0=C2=A0 The initial layout is not pushing hard enough, some ranges=
 have 2 good
>> =C2=A0=C2=A0 mirrors while some only has one.
>>
>> - Simplify the golden output
>> =C2=A0=C2=A0 The current golden output contains 512 bytes output for th=
e beginning
>> =C2=A0=C2=A0 of each mirror.
>>
>> =C2=A0=C2=A0 The 512 bytes output itself is both duplicating and not co=
mprehensive
>> =C2=A0=C2=A0 enough (see the next output).
>>
>> =C2=A0=C2=A0 This patch would remove the duplication part by only outpu=
t one single
>> =C2=A0=C2=A0 line for 16 bytes.
>>
>> - Add extra output for all the 3 64K blocks
>> =C2=A0=C2=A0 Each 64K of the involved file now has only one good mirror=
, and they
>> =C2=A0=C2=A0 are all on different devices.
>> =C2=A0=C2=A0 Thus only checking the beginning of the first 64K block is=
 not good
>> =C2=A0=C2=A0 enough.
>>
>> =C2=A0=C2=A0 This patch would enhance this by output the first 16 bytes=
 for all the
>> =C2=A0=C2=A0 3 64K blocks on each device.
>>
>> - Add a final safenet to catch unexpected corruption
>> =C2=A0=C2=A0 If we have some weird corruption after the first 16 bytes =
of each
>> =C2=A0=C2=A0 64K blocks, we can still detect them using "btrfs check
>> =C2=A0=C2=A0 --check-data-csum", which acts as offline scrub.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 tests/btrfs/266=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 59 +++++++++++++=
+++++++----
>> =C2=A0 tests/btrfs/266.out | 109 ++++++++------------------------------=
------
>> =C2=A0 2 files changed, 68 insertions(+), 100 deletions(-)
>>
>> diff --git a/tests/btrfs/266 b/tests/btrfs/266
>> index 42aff7c0..894c5c6e 100755
>> --- a/tests/btrfs/266
>> +++ b/tests/btrfs/266
>> @@ -25,7 +25,7 @@ _require_odirect
>> =C2=A0 _require_non_zoned_device "${SCRATCH_DEV}"
>> =C2=A0 _scratch_dev_pool_get 3
>> -# step 1, create a raid1 btrfs which contains one 128k file.
>> +# step 1, create a raid1 btrfs which contains one 192k file.
>> =C2=A0 echo "step 1......mkfs.btrfs"
>> =C2=A0 mkfs_opts=3D"-d raid1c3 -b 1G"
>> @@ -33,7 +33,7 @@ _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>> =C2=A0 _scratch_mount
>> -$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 256K 0 256K" \
>> +$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 192K 0 192K" \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "$SCRATCH_MNT/foobar" | \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>> @@ -56,6 +56,13 @@ devpath3=3D$(_btrfs_get_device_path ${logical} 3)
>> =C2=A0 _scratch_unmount
>> +# We corrupt the mirrors so that every 64K block only has one
>> +# good mirror. (X =3D corruption)
>> +#
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 64K=C2=
=A0=C2=A0=C2=A0 128K=C2=A0=C2=A0=C2=A0 192K
>> +# Mirror 1=C2=A0=C2=A0=C2=A0 |XXXXXXXXXXXXXXX|=C2=A0=C2=A0=C2=A0 |
>> +# Mirror 2=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 |XXXXXXXXXXXXXXX|
>> +# Mirror 3=C2=A0=C2=A0=C2=A0 |XXXXXXX|=C2=A0=C2=A0=C2=A0 |XXXXXXX|
>> =C2=A0 $XFS_IO_PROG -d -c "pwrite -S 0xbd -b 64K $physical3 64K" \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $devpath3 > /dev/null
>> @@ -65,7 +72,7 @@ $XFS_IO_PROG -d -c "pwrite -S 0xba -b 64K $physical1
>> 128K" \
>> =C2=A0 $XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $((physical2 + 65536))
>> 128K" \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $devpath2 > /dev/null
>> -$XFS_IO_PROG -d -c "pwrite -S 0xbc -b 64K $((physical3 + (2 *
>> 65536))) 128K"=C2=A0 \
>> +$XFS_IO_PROG -d -c "pwrite -S 0xbc -b 64K $((physical3 + (2 *
>> 65536))) 64K"=C2=A0 \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $devpath3 > /dev/null
>> =C2=A0 _scratch_mount
>> @@ -73,19 +80,53 @@ _scratch_mount
>> =C2=A0 # step 3, 128k dio read (this read can repair bad copy)
>> =C2=A0 echo "step 3......repair the bad copy"
>> -_btrfs_buffered_read_on_mirror 0 3 "$SCRATCH_MNT/foobar" 0 256K
>> -_btrfs_buffered_read_on_mirror 1 3 "$SCRATCH_MNT/foobar" 0 256K
>> -_btrfs_buffered_read_on_mirror 2 3 "$SCRATCH_MNT/foobar" 0 256K
>> +_btrfs_buffered_read_on_mirror 0 3 "$SCRATCH_MNT/foobar" 0 192K
>> +_btrfs_buffered_read_on_mirror 1 3 "$SCRATCH_MNT/foobar" 0 192K
>> +_btrfs_buffered_read_on_mirror 2 3 "$SCRATCH_MNT/foobar" 0 192K
>> =C2=A0 _scratch_unmount
>> =C2=A0 echo "step 4......check if the repair worked"
>> -$XFS_IO_PROG -d -c "pread -v -b 512 $physical1 512" $devpath1 |\
>> +echo "Dev 1:"
>> +echo "=C2=A0 Physical offset + 0:"
>> +$XFS_IO_PROG -c "pread -qv $physical1 16" $devpath1 |\
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>> -$XFS_IO_PROG -d -c "pread -v -b 512 $physical2 512" $devpath2 |\
>> +echo "=C2=A0 Physical offset + 64K:"
>> +$XFS_IO_PROG -c "pread -qv $((physical1 + 65536)) 16" $devpath1 |\
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>> -$XFS_IO_PROG -d -c "pread -v -b 512 $physical3 512" $devpath3 |\
>> +echo "=C2=A0 Physical offset + 128K:"
>> +$XFS_IO_PROG -c "pread -qv $((physical1 + 131072)) 16" $devpath1 |\
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>> +echo
>> +
>> +echo "Dev 2:"
>> +echo "=C2=A0 Physical offset + 0:"
>> +$XFS_IO_PROG -c "pread -qv $physical2 16" $devpath2 |\
>> +=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>> +echo "=C2=A0 Physical offset + 64K:"
>> +$XFS_IO_PROG -c "pread -qv $((physical2 + 65536)) 16" $devpath2 |\
>> +=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>> +echo "=C2=A0 Physical offset + 128K:"
>> +$XFS_IO_PROG -c "pread -qv $((physical2 + 131072)) 16" $devpath2 |\
>> +=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>> +echo
>> +
>> +echo "Dev 3:"
>> +echo "=C2=A0 Physical offset + 0:"
>> +$XFS_IO_PROG -c "pread -v $physical3 16" $devpath3 |\
>> +=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>> +echo "=C2=A0 Physical offset + 64K:"
>> +$XFS_IO_PROG -c "pread -v $((physical3 + 65536)) 16" $devpath3 |\
>> +=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>> +echo "=C2=A0 Physical offset + 128K:"
>> +$XFS_IO_PROG -c "pread -v $((physical3 + 131072)) 16" $devpath3 |\
>> +=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>> +
>> +# Final step to use btrfs check to verify the csum of all mirrors.
>> +$BTRFS_UTIL_PROG check --check-data-csum $SCRATCH_DEV >> $seqres.full
>> 2>&1
>> +if [ $? -ne 0 ]; then
>> +=C2=A0=C2=A0=C2=A0 echo "btrfs check found some data csum mismatch"
>> +fi
>> =C2=A0 _scratch_dev_pool_put
>> =C2=A0 # success, all done
>> diff --git a/tests/btrfs/266.out b/tests/btrfs/266.out
>> index fcf2f5b8..305e9c83 100644
>> --- a/tests/btrfs/266.out
>> +++ b/tests/btrfs/266.out
>> @@ -1,109 +1,36 @@
>> =C2=A0 QA output created by 266
>> =C2=A0 step 1......mkfs.btrfs
>> -wrote 262144/262144 bytes
>> +wrote 196608/196608 bytes
>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> =C2=A0 step 2......corrupt file extent
>> =C2=A0 step 3......repair the bad copy
>> =C2=A0 step 4......check if the repair worked
>> +Dev 1:
>> +=C2=A0 Physical offset + 0:
>> =C2=A0 XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +=C2=A0 Physical offset + 64K:
>> =C2=A0 XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +=C2=A0 Physical offset + 128K:
>> =C2=A0 XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +
>> +Dev 2:
>> +=C2=A0 Physical offset + 0:
>> =C2=A0 XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +=C2=A0 Physical offset + 64K:
>> =C2=A0 XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +=C2=A0 Physical offset + 128K:
>> =C2=A0 XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> +
>> +Dev 3:
>> +=C2=A0 Physical offset + 0:
>> =C2=A0 XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -read 512/512 bytes
>> +read 16/16 bytes
>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +=C2=A0 Physical offset + 64K:
>> =C2=A0 XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -read 512/512 bytes
>> +read 16/16 bytes
>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +=C2=A0 Physical offset + 128K:
>> =C2=A0 XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>> -read 512/512 bytes
>> +read 16/16 bytes
>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>
