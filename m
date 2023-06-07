Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860CF725BAF
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 12:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbjFGKfG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 06:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239343AbjFGKew (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 06:34:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424451BEB;
        Wed,  7 Jun 2023 03:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686134081; x=1686738881; i=quwenruo.btrfs@gmx.com;
 bh=dkbRL+tN9enDzUzREanGQvT2cBUXCTAlyaL33f9Ajhs=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=aw8yCg8YIsstjHzXBOlx9qhNMN595MFiRm1OwlJbw1OqzNrlJ3vSrRq7C5OSoUUibTE0JQI
 RdsGXqJbvUymPsCb7Oro4+8bWrmSSronAXvwdZwgbG2mmZkTLbSzlemflvjkTRZzX6nGFYQvw
 1lYYNC8nNaTyPwnD2dOQnvFdkhrxr8q0Sh5xy+NT4J53wvKWOPOF3QfwpKKi2oGj5mx7Zqzdy
 qIO9wEYwV5W9F3o5WOCUGrshIxGybw/oQYuQjso8ayByNSMMwQcDaqyD3cLRgBJSBC7lFFQRg
 TUbXHvYxG6Tubn5nXf8oJWvXbgE+DLfLxWMHoGxV8FC+wQ7GmeyQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MEm6L-1qN4zz33YB-00GKu6; Wed, 07
 Jun 2023 12:34:41 +0200
Message-ID: <6f73e342-39f7-832e-8177-ed4774f891c8@gmx.com>
Date:   Wed, 7 Jun 2023 18:34:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] btrfs/266: test case enhancement to cover more possible
 failures
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20230606103027.125617-1-wqu@suse.com>
 <2f4659d6-667d-d9d2-7bf8-656019fd3c99@oracle.com>
 <f0745b27-2e93-7e35-384a-e5cd7b832a3f@gmx.com>
 <46c2f952-7d13-5e56-56ec-902fd0387632@gmx.com>
 <3e5e3edf-8d3a-e498-ee25-2d5a19d77def@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <3e5e3edf-8d3a-e498-ee25-2d5a19d77def@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uAgv0CH2RdRQRGSdkVaB3Ea61lzH1Yhd0oAg33ksbuxKApHgAYb
 auw3qjhoVblUoL61BspkI5qbft0d6o3xTpU8+TyPzlLh+RbgXp3cHZnQVzNVhxkd2763JAg
 ROVD0uC0bd9hVk/KKgFcNbHXBKtM2kIbVlMoQM1i9WEW1RuBHNMZUyMQFp0CY1btOSVl76F
 UIQt9gdu/PSIQMjxHrI8w==
UI-OutboundReport: notjunk:1;M01:P0:69xkQmukIck=;jeWvYPcpqYGnVFt3OI12lYkna0v
 5zyY35hRrs1p0mWNdnN0lTOCPXn4uDXDqTXo5edKUwP4yiyJK53mNKlwOh8c6R4xBInypwK9E
 xVzs/hlVH2M1cPB2xuKw8/xLypym4Lq6aVDOwMMLlqiCeNpfHzbE4thJSxDBYdBW19NcqrnTp
 9iLZMFSogt9B6Ik3DSl6cEDQRCAPDbAxyOPaQ8NvRooHTSujSTWwXgKfRlNyv6v2vdN0ZomxO
 EG8w+TVp6Nnhs7+MY+iJlMgKMO80yHQQy91WTYEWSf0Pq3gr32jXAkghYZNMzyceycGznRSan
 pptwi4ILHdUOHcj8uyFl/DnW9WoqO4JKJurhyVfqwDPGc+AkGJe17p5pH/bLD03orQvTBc+j+
 Uuln37xZNcovEKBo5TXXZWgLl3QsdktvfKhmn9TV0rWQs/JjMe0dtYK17+UHyQv2IlH7ncTtN
 Ze9XmZMqmt5YaS+7xvZFOvf1N11DCrK5CCD9HKlTV+MODNqgkAH+UlU+nYasP1hx5qsYwsuyx
 SaoM861LUmegd5mcQUDaMe0ulycs+IU7X10AHLhDo8wSd3V3Zd0E9ae6BgtEWbtuiizZXCHbC
 kp0TE3Jk08c64puyn2CRyniGxA8FCPkieN/uzonfwD8u85dgixfFWkCfcOyEDUSeJtKmTo8yI
 IREEx1flSrm+UCcIpB50J7vNhzmA2uWTlaVJ6gRVb9W4J7GfP+Ao0Vglq6GxE6nQA+XF+RpaA
 geAgJw9UUBUybJ4aI6UoOV8eA30/wwZwcC2Pab20k2/0GUSt5A9lxwqQpfwlMbDw03OFSRX0q
 p/IMUBRmBpd+PKY21d1GyrDGCuCHaxWJiHsPBG9nwVWzdoBCvDG5mHtmXPWlCv0W0ec7XMK9f
 PO1rtaTOhH3fBeQe5Tl/gRUrWP0gqoGE+q8Eg1HjMzRrZRJ/8PezJDG1VXcrxNAsobNchW4j9
 F0cAd42q1z7g/RjRbeP7tH0Zy4s=
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



On 2023/6/7 18:29, Anand Jain wrote:
>
>
> On 07/06/2023 15:39, Qu Wenruo wrote:
>>
>>
>> On 2023/6/7 09:52, Qu Wenruo wrote:
>>>
>>>
>>> On 2023/6/7 08:13, Anand Jain wrote:
>>>>
>>>>
>>>> =C2=A0=C2=A0It is failing on sectorsize 64k.
>>>
>>> That's what I'm investigating.
>>>
>>> And the failure is random, if you ran more times it would pass (the
>>> failure rate is 1/3~1/5 in my case).
>>
>> And to my surprise, this is in fact not a bug in btrfs, but more likely
>> a bug in drop_caches.
>>
>> I added several trace printk() for __btrfs_submit_bio(),
>> btrfs_check_read_bio(), and __end_bio_extent_readpage() to grasp the
>> repair work flow.
>> =C2=A0> It turns out, when the test failed, at least one mirror is not =
read
>> from
>> disk, but directly using page cache. > Thus no wonder the data would
>> be repaired, just because that mirror is
>> not properly read at all.
>>
>
> Failure is inconsistent on my system too. Does the test fails depending
> on which mirror becomes the latest_bdev for the metadata?

Nope, it's purely a problem related to "echo 3 > drop_caches" either not
dropping the data caches of that inode, or returned before dropping all
possible pages, or something else is locking that data pages thus
preventing the drop.

Metadata has no impact, as we choose mirrors indepedent from the
lastest_bdev.

Thanks,
Qu

>
> Thanks, Anand
>
>
>> I'll start a new thread on this particular problem.
>>
>> Thanks,
>> Qu
>>>
>>> Thanks,
>>> Qu
>>>>
>>>> ---------
>>>> btrfs/266 2s ... - output mismatch (see
>>>> /xfstests-dev/results//btrfs/266.out.bad)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 --- tests/btrfs/266.out=C2=A0=C2=A0=C2=A0 20=
23-06-06 20:02:48.900915702 -0400
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 +++ /xfstests-dev/results//btrfs/266.out.bad=
=C2=A0=C2=A0=C2=A0 2023-06-06
>>>> 20:02:56.665554779 -0400
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 @@ -19,11 +19,11 @@
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Physical offset + 64K:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa a=
a aa aa aa aa aa aa aa aa
>>>> ................
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Physical offset + 128K:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa =
aa aa aa aa aa aa aa
>>>> ................
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb =
bb bb bb bb bb bb bb
>>>> ................
>>>> -------
>>>>
>>>> Thanks, Anand
>>>>
>>>>
>>>> On 06/06/2023 18:30, Qu Wenruo wrote:
>>>>> [BACKGROUND]
>>>>> Recently I'm debugging a random failure with btrfs/266 with larger
>>>>> page
>>>>> sizes (64K page size, with either 64K sector size or 4K sector size)=
.
>>>>>
>>>>> During the tests, I found the test case itself can be further enhanc=
ed
>>>>> to make better coverage and easier debugging.
>>>>>
>>>>> [ENHANCEMENT]
>>>>>
>>>>> - Ensure every 64K block only has one good mirror
>>>>> =C2=A0=C2=A0 The initial layout is not pushing hard enough, some ran=
ges have 2
>>>>> good
>>>>> =C2=A0=C2=A0 mirrors while some only has one.
>>>>>
>>>>> - Simplify the golden output
>>>>> =C2=A0=C2=A0 The current golden output contains 512 bytes output for=
 the
>>>>> beginning
>>>>> =C2=A0=C2=A0 of each mirror.
>>>>>
>>>>> =C2=A0=C2=A0 The 512 bytes output itself is both duplicating and not
>>>>> comprehensive
>>>>> =C2=A0=C2=A0 enough (see the next output).
>>>>>
>>>>> =C2=A0=C2=A0 This patch would remove the duplication part by only ou=
tput one
>>>>> single
>>>>> =C2=A0=C2=A0 line for 16 bytes.
>>>>>
>>>>> - Add extra output for all the 3 64K blocks
>>>>> =C2=A0=C2=A0 Each 64K of the involved file now has only one good mir=
ror, and
>>>>> they
>>>>> =C2=A0=C2=A0 are all on different devices.
>>>>> =C2=A0=C2=A0 Thus only checking the beginning of the first 64K block=
 is not good
>>>>> =C2=A0=C2=A0 enough.
>>>>>
>>>>> =C2=A0=C2=A0 This patch would enhance this by output the first 16 by=
tes for all
>>>>> the
>>>>> =C2=A0=C2=A0 3 64K blocks on each device.
>>>>>
>>>>> - Add a final safenet to catch unexpected corruption
>>>>> =C2=A0=C2=A0 If we have some weird corruption after the first 16 byt=
es of each
>>>>> =C2=A0=C2=A0 64K blocks, we can still detect them using "btrfs check
>>>>> =C2=A0=C2=A0 --check-data-csum", which acts as offline scrub.
>>>>>
>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>> ---
>>>>> =C2=A0 tests/btrfs/266=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 59 ++++++++++=
++++++++++----
>>>>> =C2=A0 tests/btrfs/266.out | 109
>>>>> ++++++++------------------------------------
>>>>> =C2=A0 2 files changed, 68 insertions(+), 100 deletions(-)
>>>>>
>>>>> diff --git a/tests/btrfs/266 b/tests/btrfs/266
>>>>> index 42aff7c0..894c5c6e 100755
>>>>> --- a/tests/btrfs/266
>>>>> +++ b/tests/btrfs/266
>>>>> @@ -25,7 +25,7 @@ _require_odirect
>>>>> =C2=A0 _require_non_zoned_device "${SCRATCH_DEV}"
>>>>> =C2=A0 _scratch_dev_pool_get 3
>>>>> -# step 1, create a raid1 btrfs which contains one 128k file.
>>>>> +# step 1, create a raid1 btrfs which contains one 192k file.
>>>>> =C2=A0 echo "step 1......mkfs.btrfs"
>>>>> =C2=A0 mkfs_opts=3D"-d raid1c3 -b 1G"
>>>>> @@ -33,7 +33,7 @@ _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>>>>> =C2=A0 _scratch_mount
>>>>> -$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 256K 0 256K" \
>>>>> +$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 192K 0 192K" \
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "$SCRATCH_MNT/foobar" | \
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>>>>> @@ -56,6 +56,13 @@ devpath3=3D$(_btrfs_get_device_path ${logical} 3)
>>>>> =C2=A0 _scratch_unmount
>>>>> +# We corrupt the mirrors so that every 64K block only has one
>>>>> +# good mirror. (X =3D corruption)
>>>>> +#
>>>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 64K=
=C2=A0=C2=A0=C2=A0 128K=C2=A0=C2=A0=C2=A0 192K
>>>>> +# Mirror 1=C2=A0=C2=A0=C2=A0 |XXXXXXXXXXXXXXX|=C2=A0=C2=A0=C2=A0 |
>>>>> +# Mirror 2=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 |XXXXXXXXXXXXXXX|
>>>>> +# Mirror 3=C2=A0=C2=A0=C2=A0 |XXXXXXX|=C2=A0=C2=A0=C2=A0 |XXXXXXX|
>>>>> =C2=A0 $XFS_IO_PROG -d -c "pwrite -S 0xbd -b 64K $physical3 64K" \
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $devpath3 > /dev/null
>>>>> @@ -65,7 +72,7 @@ $XFS_IO_PROG -d -c "pwrite -S 0xba -b 64K $physica=
l1
>>>>> 128K" \
>>>>> =C2=A0 $XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $((physical2 + 6553=
6))
>>>>> 128K" \
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $devpath2 > /dev/null
>>>>> -$XFS_IO_PROG -d -c "pwrite -S 0xbc -b 64K $((physical3 + (2 *
>>>>> 65536))) 128K"=C2=A0 \
>>>>> +$XFS_IO_PROG -d -c "pwrite -S 0xbc -b 64K $((physical3 + (2 *
>>>>> 65536))) 64K"=C2=A0 \
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $devpath3 > /dev/null
>>>>> =C2=A0 _scratch_mount
>>>>> @@ -73,19 +80,53 @@ _scratch_mount
>>>>> =C2=A0 # step 3, 128k dio read (this read can repair bad copy)
>>>>> =C2=A0 echo "step 3......repair the bad copy"
>>>>> -_btrfs_buffered_read_on_mirror 0 3 "$SCRATCH_MNT/foobar" 0 256K
>>>>> -_btrfs_buffered_read_on_mirror 1 3 "$SCRATCH_MNT/foobar" 0 256K
>>>>> -_btrfs_buffered_read_on_mirror 2 3 "$SCRATCH_MNT/foobar" 0 256K
>>>>> +_btrfs_buffered_read_on_mirror 0 3 "$SCRATCH_MNT/foobar" 0 192K
>>>>> +_btrfs_buffered_read_on_mirror 1 3 "$SCRATCH_MNT/foobar" 0 192K
>>>>> +_btrfs_buffered_read_on_mirror 2 3 "$SCRATCH_MNT/foobar" 0 192K
>>>>> =C2=A0 _scratch_unmount
>>>>> =C2=A0 echo "step 4......check if the repair worked"
>>>>> -$XFS_IO_PROG -d -c "pread -v -b 512 $physical1 512" $devpath1 |\
>>>>> +echo "Dev 1:"
>>>>> +echo "=C2=A0 Physical offset + 0:"
>>>>> +$XFS_IO_PROG -c "pread -qv $physical1 16" $devpath1 |\
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>>>>> -$XFS_IO_PROG -d -c "pread -v -b 512 $physical2 512" $devpath2 |\
>>>>> +echo "=C2=A0 Physical offset + 64K:"
>>>>> +$XFS_IO_PROG -c "pread -qv $((physical1 + 65536)) 16" $devpath1 |\
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>>>>> -$XFS_IO_PROG -d -c "pread -v -b 512 $physical3 512" $devpath3 |\
>>>>> +echo "=C2=A0 Physical offset + 128K:"
>>>>> +$XFS_IO_PROG -c "pread -qv $((physical1 + 131072)) 16" $devpath1 |\
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>>>>> +echo
>>>>> +
>>>>> +echo "Dev 2:"
>>>>> +echo "=C2=A0 Physical offset + 0:"
>>>>> +$XFS_IO_PROG -c "pread -qv $physical2 16" $devpath2 |\
>>>>> +=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>>>>> +echo "=C2=A0 Physical offset + 64K:"
>>>>> +$XFS_IO_PROG -c "pread -qv $((physical2 + 65536)) 16" $devpath2 |\
>>>>> +=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>>>>> +echo "=C2=A0 Physical offset + 128K:"
>>>>> +$XFS_IO_PROG -c "pread -qv $((physical2 + 131072)) 16" $devpath2 |\
>>>>> +=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>>>>> +echo
>>>>> +
>>>>> +echo "Dev 3:"
>>>>> +echo "=C2=A0 Physical offset + 0:"
>>>>> +$XFS_IO_PROG -c "pread -v $physical3 16" $devpath3 |\
>>>>> +=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>>>>> +echo "=C2=A0 Physical offset + 64K:"
>>>>> +$XFS_IO_PROG -c "pread -v $((physical3 + 65536)) 16" $devpath3 |\
>>>>> +=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>>>>> +echo "=C2=A0 Physical offset + 128K:"
>>>>> +$XFS_IO_PROG -c "pread -v $((physical3 + 131072)) 16" $devpath3 |\
>>>>> +=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>>>>> +
>>>>> +# Final step to use btrfs check to verify the csum of all mirrors.
>>>>> +$BTRFS_UTIL_PROG check --check-data-csum $SCRATCH_DEV >> $seqres.fu=
ll
>>>>> 2>&1
>>>>> +if [ $? -ne 0 ]; then
>>>>> +=C2=A0=C2=A0=C2=A0 echo "btrfs check found some data csum mismatch"
>>>>> +fi
>>>>> =C2=A0 _scratch_dev_pool_put
>>>>> =C2=A0 # success, all done
>>>>> diff --git a/tests/btrfs/266.out b/tests/btrfs/266.out
>>>>> index fcf2f5b8..305e9c83 100644
>>>>> --- a/tests/btrfs/266.out
>>>>> +++ b/tests/btrfs/266.out
>>>>> @@ -1,109 +1,36 @@
>>>>> =C2=A0 QA output created by 266
>>>>> =C2=A0 step 1......mkfs.btrfs
>>>>> -wrote 262144/262144 bytes
>>>>> +wrote 196608/196608 bytes
>>>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>>> =C2=A0 step 2......corrupt file extent
>>>>> =C2=A0 step 3......repair the bad copy
>>>>> =C2=A0 step 4......check if the repair worked
>>>>> +Dev 1:
>>>>> +=C2=A0 Physical offset + 0:
>>>>> =C2=A0 XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa =
aa
>>>>> ................
>>>>> +=C2=A0 Physical offset + 64K:
>>>>> =C2=A0 XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa =
aa
>>>>> ................
>>>>> +=C2=A0 Physical offset + 128K:
>>>>> =C2=A0 XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa =
aa
>>>>> ................
>>>>> +
>>>>> +Dev 2:
>>>>> +=C2=A0 Physical offset + 0:
>>>>> =C2=A0 XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa =
aa
>>>>> ................
>>>>> +=C2=A0 Physical offset + 64K:
>>>>> =C2=A0 XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa =
aa
>>>>> ................
>>>>> +=C2=A0 Physical offset + 128K:
>>>>> =C2=A0 XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa =
aa
>>>>> ................
>>>>> +
>>>>> +Dev 3:
>>>>> +=C2=A0 Physical offset + 0:
>>>>> =C2=A0 XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa =
aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -read 512/512 bytes
>>>>> +read 16/16 bytes
>>>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>>> +=C2=A0 Physical offset + 64K:
>>>>> =C2=A0 XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa =
aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -read 512/512 bytes
>>>>> +read 16/16 bytes
>>>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>>> +=C2=A0 Physical offset + 128K:
>>>>> =C2=A0 XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa =
aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>>> ................
>>>>> -read 512/512 bytes
>>>>> +read 16/16 bytes
>>>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>>
