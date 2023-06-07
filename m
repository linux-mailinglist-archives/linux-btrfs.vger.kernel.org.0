Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326A772561D
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 09:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239223AbjFGHnW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 03:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238784AbjFGHmw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 03:42:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B389358A;
        Wed,  7 Jun 2023 00:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686123601; x=1686728401; i=quwenruo.btrfs@gmx.com;
 bh=muIWV8ofVmm0GcmNwynoYIPCKGvPkZeQ2k4VlwAOfPg=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=ZT0+6lUr2X7oF2YEvTJ4JRskPXpG8v0OLmMtr4VbCL9nlA3XnEt3TeNm3ZkeVXEUszeh8Ck
 9tbQpZiXuOozhDgezqjfwHpCEirfmZfXN/ahsYLIB60Mak0l8E0lAy+j5beUoiyDxFB2CETXI
 jbdf58A1y8WYsD8pDIgx9RWsQ2pR2SCJAQg4OLmUmY9RdFo3YN6vIuQMaoFTnSH+TA5eBzAC+
 v5rGAdRpN2UOYDj3VdRx+SK9fPzErK1dGDvdt7IlPVoSWH5pU4LWdEtI4BoG/Cp+clerEqnWr
 Dq93okBKYSJ3d46Q53ksw15TOYmtrDoNUOcsWo1KA4RYAZHPi64g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQe5u-1qUV1T0Wms-00Nj6Z; Wed, 07
 Jun 2023 09:40:01 +0200
Message-ID: <46c2f952-7d13-5e56-56ec-902fd0387632@gmx.com>
Date:   Wed, 7 Jun 2023 15:39:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] btrfs/266: test case enhancement to cover more possible
 failures
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20230606103027.125617-1-wqu@suse.com>
 <2f4659d6-667d-d9d2-7bf8-656019fd3c99@oracle.com>
 <f0745b27-2e93-7e35-384a-e5cd7b832a3f@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <f0745b27-2e93-7e35-384a-e5cd7b832a3f@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yrAj3S33sGekUOwoP5m7BTnB4c5orody6eDZxkj0Hf4PCeHVWbQ
 p7C0JuMthj/6ua7Os+UCR0/0f9GmtxEIKcOG4IbgGs6ManDRh6imSZO05IRg76lie+0ckxv
 icRQDpjaf3KANYkHKzP/4BcT2VbZddiWgUs4PZp2e0FfYGuI78WSlLmwWiSE9WVXdDUUW4A
 +K+TM265+ogOrLEwROKRA==
UI-OutboundReport: notjunk:1;M01:P0:m14clE1PHLI=;yLSkJjl57FNoV3b6RMeM3w7FzKc
 1Z16cCJXoKxkI4mJ1MH4ozdjf03Axb7qcrhvvg3vvYjo+2UqJipU6s5JVg17cxqzVntZ2331o
 5uFltnp11FbqbMrqjn52qXPVK0owUG73bNCoZiv3rVpqCuqEYQfiDAo+qoHVWK5SPb1P2mov9
 POhmM6AniZTKZaSRPHh0po8kI+Ip0y190BS2RoCIKNw4kMJdtShbPkiQ7UaYSlW9XCaxWLICx
 gU5GnlSpCU12vbFTzQJX9n0THhwTLrNDD1MkW34jSdUos/tLKkBdvII0ibG1sqj7XNmm9cGOd
 NjI4qT7xBfaIqOrJ9t4J0yFSvdLx0gxsWk9KxvHaCVxxwq00HavmaJSzgDSvk0BdPZhl9HbYV
 mTKXoQ27f8LlHNUo+SalMg6MGy1HWnCnD4IpDOUVzIu/1pfI6CFqinY2ofNVZa+b9vhMdq3Pa
 y4J5Ro/FWtho71qq8+AGO00fz+owdTNGdK0h/HnCTPEW4I/9YdL5KdJF7l7pgxAV6TUh+zBAJ
 KK0FkL4rM/jJOQHnCK5ybt6nezGpU4D9xH5sJMMFN2gpliJGMRu7qI0KN+tdupg0Dlfj5ocCL
 mwJTN0N11MDQsUEvqIVde44UNrnWPL67cpD63ZLcBhL+yrK89xYtxx9CY02CKuj9DLL0vFS4L
 fpH6uGtW/abC+ep2rE3AItesNnjlTSM5RgrbMkM+ngizLuMiSHSHfpec2cjCxPBgpYI5GhMYY
 0DOuXK+9fC56Su5/uuAa7Di5msSE1BAKOsSurl9wT+XRmt15/9Cyr4A9j42Mh7AWVkkrjgeqn
 yCRcq8fORxWBK1qnjcWVsgWJ2VmMKS9iHO4I/geKtG5w8yfo2KE/BaNk9SIPE/dyDcZ0+PQ9v
 UUA/f+QfIUgKbCjlw6/Y7LhIEtIUrisbZ44e9b8FP/IC+ElWZv97lNrlNXL2z5FFx+BBP99ik
 xXls4Boa9jLtKAQ7Y7hP5hmA/ms=
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



On 2023/6/7 09:52, Qu Wenruo wrote:
>
>
> On 2023/6/7 08:13, Anand Jain wrote:
>>
>>
>> =C2=A0=C2=A0It is failing on sectorsize 64k.
>
> That's what I'm investigating.
>
> And the failure is random, if you ran more times it would pass (the
> failure rate is 1/3~1/5 in my case).

And to my surprise, this is in fact not a bug in btrfs, but more likely
a bug in drop_caches.

I added several trace printk() for __btrfs_submit_bio(),
btrfs_check_read_bio(), and __end_bio_extent_readpage() to grasp the
repair work flow.

It turns out, when the test failed, at least one mirror is not read from
disk, but directly using page cache.
Thus no wonder the data would be repaired, just because that mirror is
not properly read at all.

I'll start a new thread on this particular problem.

Thanks,
Qu
>
> Thanks,
> Qu
>>
>> ---------
>> btrfs/266 2s ... - output mismatch (see
>> /xfstests-dev/results//btrfs/266.out.bad)
>> =C2=A0=C2=A0=C2=A0=C2=A0 --- tests/btrfs/266.out=C2=A0=C2=A0=C2=A0 2023=
-06-06 20:02:48.900915702 -0400
>> =C2=A0=C2=A0=C2=A0=C2=A0 +++ /xfstests-dev/results//btrfs/266.out.bad=
=C2=A0=C2=A0=C2=A0 2023-06-06
>> 20:02:56.665554779 -0400
>> =C2=A0=C2=A0=C2=A0=C2=A0 @@ -19,11 +19,11 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Physical offset + 64K:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa =
aa aa aa aa aa aa aa aa
>> ................
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Physical offset + 128K:
>> =C2=A0=C2=A0=C2=A0=C2=A0 -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa=
 aa aa aa aa aa aa
>> ................
>> =C2=A0=C2=A0=C2=A0=C2=A0 +XXXXXXXX:=C2=A0 bb bb bb bb bb bb bb bb bb bb=
 bb bb bb bb bb bb
>> ................
>> -------
>>
>> Thanks, Anand
>>
>>
>> On 06/06/2023 18:30, Qu Wenruo wrote:
>>> [BACKGROUND]
>>> Recently I'm debugging a random failure with btrfs/266 with larger pag=
e
>>> sizes (64K page size, with either 64K sector size or 4K sector size).
>>>
>>> During the tests, I found the test case itself can be further enhanced
>>> to make better coverage and easier debugging.
>>>
>>> [ENHANCEMENT]
>>>
>>> - Ensure every 64K block only has one good mirror
>>> =C2=A0=C2=A0 The initial layout is not pushing hard enough, some range=
s have 2
>>> good
>>> =C2=A0=C2=A0 mirrors while some only has one.
>>>
>>> - Simplify the golden output
>>> =C2=A0=C2=A0 The current golden output contains 512 bytes output for t=
he beginning
>>> =C2=A0=C2=A0 of each mirror.
>>>
>>> =C2=A0=C2=A0 The 512 bytes output itself is both duplicating and not c=
omprehensive
>>> =C2=A0=C2=A0 enough (see the next output).
>>>
>>> =C2=A0=C2=A0 This patch would remove the duplication part by only outp=
ut one
>>> single
>>> =C2=A0=C2=A0 line for 16 bytes.
>>>
>>> - Add extra output for all the 3 64K blocks
>>> =C2=A0=C2=A0 Each 64K of the involved file now has only one good mirro=
r, and they
>>> =C2=A0=C2=A0 are all on different devices.
>>> =C2=A0=C2=A0 Thus only checking the beginning of the first 64K block i=
s not good
>>> =C2=A0=C2=A0 enough.
>>>
>>> =C2=A0=C2=A0 This patch would enhance this by output the first 16 byte=
s for all
>>> the
>>> =C2=A0=C2=A0 3 64K blocks on each device.
>>>
>>> - Add a final safenet to catch unexpected corruption
>>> =C2=A0=C2=A0 If we have some weird corruption after the first 16 bytes=
 of each
>>> =C2=A0=C2=A0 64K blocks, we can still detect them using "btrfs check
>>> =C2=A0=C2=A0 --check-data-csum", which acts as offline scrub.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>> =C2=A0 tests/btrfs/266=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 59 ++++++++++++=
++++++++----
>>> =C2=A0 tests/btrfs/266.out | 109 ++++++++-----------------------------=
-------
>>> =C2=A0 2 files changed, 68 insertions(+), 100 deletions(-)
>>>
>>> diff --git a/tests/btrfs/266 b/tests/btrfs/266
>>> index 42aff7c0..894c5c6e 100755
>>> --- a/tests/btrfs/266
>>> +++ b/tests/btrfs/266
>>> @@ -25,7 +25,7 @@ _require_odirect
>>> =C2=A0 _require_non_zoned_device "${SCRATCH_DEV}"
>>> =C2=A0 _scratch_dev_pool_get 3
>>> -# step 1, create a raid1 btrfs which contains one 128k file.
>>> +# step 1, create a raid1 btrfs which contains one 192k file.
>>> =C2=A0 echo "step 1......mkfs.btrfs"
>>> =C2=A0 mkfs_opts=3D"-d raid1c3 -b 1G"
>>> @@ -33,7 +33,7 @@ _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>>> =C2=A0 _scratch_mount
>>> -$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 256K 0 256K" \
>>> +$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 192K 0 192K" \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "$SCRATCH_MNT/foobar" | \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>>> @@ -56,6 +56,13 @@ devpath3=3D$(_btrfs_get_device_path ${logical} 3)
>>> =C2=A0 _scratch_unmount
>>> +# We corrupt the mirrors so that every 64K block only has one
>>> +# good mirror. (X =3D corruption)
>>> +#
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 64K=
=C2=A0=C2=A0=C2=A0 128K=C2=A0=C2=A0=C2=A0 192K
>>> +# Mirror 1=C2=A0=C2=A0=C2=A0 |XXXXXXXXXXXXXXX|=C2=A0=C2=A0=C2=A0 |
>>> +# Mirror 2=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 |XXXXXXXXXXXXXXX|
>>> +# Mirror 3=C2=A0=C2=A0=C2=A0 |XXXXXXX|=C2=A0=C2=A0=C2=A0 |XXXXXXX|
>>> =C2=A0 $XFS_IO_PROG -d -c "pwrite -S 0xbd -b 64K $physical3 64K" \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $devpath3 > /dev/null
>>> @@ -65,7 +72,7 @@ $XFS_IO_PROG -d -c "pwrite -S 0xba -b 64K $physical1
>>> 128K" \
>>> =C2=A0 $XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $((physical2 + 65536)=
)
>>> 128K" \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $devpath2 > /dev/null
>>> -$XFS_IO_PROG -d -c "pwrite -S 0xbc -b 64K $((physical3 + (2 *
>>> 65536))) 128K"=C2=A0 \
>>> +$XFS_IO_PROG -d -c "pwrite -S 0xbc -b 64K $((physical3 + (2 *
>>> 65536))) 64K"=C2=A0 \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $devpath3 > /dev/null
>>> =C2=A0 _scratch_mount
>>> @@ -73,19 +80,53 @@ _scratch_mount
>>> =C2=A0 # step 3, 128k dio read (this read can repair bad copy)
>>> =C2=A0 echo "step 3......repair the bad copy"
>>> -_btrfs_buffered_read_on_mirror 0 3 "$SCRATCH_MNT/foobar" 0 256K
>>> -_btrfs_buffered_read_on_mirror 1 3 "$SCRATCH_MNT/foobar" 0 256K
>>> -_btrfs_buffered_read_on_mirror 2 3 "$SCRATCH_MNT/foobar" 0 256K
>>> +_btrfs_buffered_read_on_mirror 0 3 "$SCRATCH_MNT/foobar" 0 192K
>>> +_btrfs_buffered_read_on_mirror 1 3 "$SCRATCH_MNT/foobar" 0 192K
>>> +_btrfs_buffered_read_on_mirror 2 3 "$SCRATCH_MNT/foobar" 0 192K
>>> =C2=A0 _scratch_unmount
>>> =C2=A0 echo "step 4......check if the repair worked"
>>> -$XFS_IO_PROG -d -c "pread -v -b 512 $physical1 512" $devpath1 |\
>>> +echo "Dev 1:"
>>> +echo "=C2=A0 Physical offset + 0:"
>>> +$XFS_IO_PROG -c "pread -qv $physical1 16" $devpath1 |\
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>>> -$XFS_IO_PROG -d -c "pread -v -b 512 $physical2 512" $devpath2 |\
>>> +echo "=C2=A0 Physical offset + 64K:"
>>> +$XFS_IO_PROG -c "pread -qv $((physical1 + 65536)) 16" $devpath1 |\
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>>> -$XFS_IO_PROG -d -c "pread -v -b 512 $physical3 512" $devpath3 |\
>>> +echo "=C2=A0 Physical offset + 128K:"
>>> +$XFS_IO_PROG -c "pread -qv $((physical1 + 131072)) 16" $devpath1 |\
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>>> +echo
>>> +
>>> +echo "Dev 2:"
>>> +echo "=C2=A0 Physical offset + 0:"
>>> +$XFS_IO_PROG -c "pread -qv $physical2 16" $devpath2 |\
>>> +=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>>> +echo "=C2=A0 Physical offset + 64K:"
>>> +$XFS_IO_PROG -c "pread -qv $((physical2 + 65536)) 16" $devpath2 |\
>>> +=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>>> +echo "=C2=A0 Physical offset + 128K:"
>>> +$XFS_IO_PROG -c "pread -qv $((physical2 + 131072)) 16" $devpath2 |\
>>> +=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>>> +echo
>>> +
>>> +echo "Dev 3:"
>>> +echo "=C2=A0 Physical offset + 0:"
>>> +$XFS_IO_PROG -c "pread -v $physical3 16" $devpath3 |\
>>> +=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>>> +echo "=C2=A0 Physical offset + 64K:"
>>> +$XFS_IO_PROG -c "pread -v $((physical3 + 65536)) 16" $devpath3 |\
>>> +=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>>> +echo "=C2=A0 Physical offset + 128K:"
>>> +$XFS_IO_PROG -c "pread -v $((physical3 + 131072)) 16" $devpath3 |\
>>> +=C2=A0=C2=A0=C2=A0 _filter_xfs_io_offset
>>> +
>>> +# Final step to use btrfs check to verify the csum of all mirrors.
>>> +$BTRFS_UTIL_PROG check --check-data-csum $SCRATCH_DEV >> $seqres.full
>>> 2>&1
>>> +if [ $? -ne 0 ]; then
>>> +=C2=A0=C2=A0=C2=A0 echo "btrfs check found some data csum mismatch"
>>> +fi
>>> =C2=A0 _scratch_dev_pool_put
>>> =C2=A0 # success, all done
>>> diff --git a/tests/btrfs/266.out b/tests/btrfs/266.out
>>> index fcf2f5b8..305e9c83 100644
>>> --- a/tests/btrfs/266.out
>>> +++ b/tests/btrfs/266.out
>>> @@ -1,109 +1,36 @@
>>> =C2=A0 QA output created by 266
>>> =C2=A0 step 1......mkfs.btrfs
>>> -wrote 262144/262144 bytes
>>> +wrote 196608/196608 bytes
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> =C2=A0 step 2......corrupt file extent
>>> =C2=A0 step 3......repair the bad copy
>>> =C2=A0 step 4......check if the repair worked
>>> +Dev 1:
>>> +=C2=A0 Physical offset + 0:
>>> =C2=A0 XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +=C2=A0 Physical offset + 64K:
>>> =C2=A0 XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +=C2=A0 Physical offset + 128K:
>>> =C2=A0 XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +
>>> +Dev 2:
>>> +=C2=A0 Physical offset + 0:
>>> =C2=A0 XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +=C2=A0 Physical offset + 64K:
>>> =C2=A0 XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +=C2=A0 Physical offset + 128K:
>>> =C2=A0 XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +
>>> +Dev 3:
>>> +=C2=A0 Physical offset + 0:
>>> =C2=A0 XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -read 512/512 bytes
>>> +read 16/16 bytes
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> +=C2=A0 Physical offset + 64K:
>>> =C2=A0 XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -read 512/512 bytes
>>> +read 16/16 bytes
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> +=C2=A0 Physical offset + 128K:
>>> =C2=A0 XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -XXXXXXXX:=C2=A0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> -read 512/512 bytes
>>> +read 16/16 bytes
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>
