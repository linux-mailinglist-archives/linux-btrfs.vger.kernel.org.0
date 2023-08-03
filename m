Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7449776DD36
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 03:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjHCBbC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 21:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjHCBbB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 21:31:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99362D62;
        Wed,  2 Aug 2023 18:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1691026250; x=1691631050; i=quwenruo.btrfs@gmx.com;
 bh=ZC7pBTD8yKM96RW4jqrBNvwx818PWy+fcMk27orfhWM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=XDDoxkMHkAMBUe0Elj3/IU/RBhyhpIYWvQCZgfIkwa8KVCro+r8gu7+ygC1g4IrKNlF+EtO
 GQ/M2cxdkz6/EocxTNOkxavFlxlirLJJXWmHvy9JxVhVYBqes9YnW1qAekGegTpvL5wrZxxI8
 4cb9UCgM5JQoU+dPIOPhI8smlgwGlrFa9qZ6lpmvyvfXTgyuvGG3eEOvfi/eqlgd1ZZdI5Dfq
 0bXsZKSDoCylO2BhD6E0NtKcPX0wNPGVOQv6U1cltRIa5MyZZqMpo37b0NM5FnJ7aUPNGd7tX
 kEDV644+1cpBp9TijAhLE7JdJxBr8rAC87jrTZDqYFMBzhpWwkuA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M42jQ-1qRNAw0Kye-0002bb; Thu, 03
 Aug 2023 03:30:50 +0200
Message-ID: <b8c5c67b-57f9-eacb-bf54-ee49a89f6e98@gmx.com>
Date:   Thu, 3 Aug 2023 09:30:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/276: allow a slight increase in the number of
 extents
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20230801065529.50122-1-wqu@suse.com>
 <CAL3q7H7MbA5Vfwgu=8Xuhh2o-SMnSCg9CJQszMTgLfHzmuBFWg@mail.gmail.com>
 <26ccf055-8ca2-275d-627d-e8b6c2e12ffe@gmx.com>
 <16f417cd-a625-3abb-b11d-8673bed265ef@gmx.com>
 <CAL3q7H7kNyMBRPOH2DjohGKog69H4sdd306cZpe17fLLsHPsSA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <CAL3q7H7kNyMBRPOH2DjohGKog69H4sdd306cZpe17fLLsHPsSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ctVPQj5GKgooUWEdE8oaUAwZZi++vHc00pDNqVbXsZwIQuY40Ob
 tlmKZXU4WtUM4++L5xosfz8aE8ewJGDPwYygyR2DShJQiQMH/4oPhNuc1JNJhVZbN+U0mpS
 pSeirMp8odprCeCJXnumtn5s7aSZAqWit+PjZy9wybOEQbqE+trlyYfgY72Gg7faCPL699P
 drZ9wsO04nEjPU2ACJQNA==
UI-OutboundReport: notjunk:1;M01:P0:0jzvRYTkmjs=;ILeyOeWVCk8WxlyYMDj5VMnIFVg
 kSVmZTk2oxTcUPBjgGTnVceNce6rSjcZQUDRa3pny0jd/R6j8s6PNT01DH6yCjP/eN2/y8ID+
 ehZrIXlNUByEhNLzBaZeheENmahgi/+NMQUzm9N+GNZ0HyjCizlqK7YnNE3Xgeo3TvC2incqX
 deRN7RvWby1AUXPDtSKPS2ou1PVwbSinMim+sTB4w8DmbUreSObhh/eIYZezW4yPJpEhuIGvQ
 MEJvFWzjroYQT1RIq7EVQ75bip5Ick2j1d1D94/5539BHBLuYZ7xWzo8HPmTjE6Sv3AR9XHDh
 uCCGehvcxVgxQ94XgGQDxDHguDNz63vT3B2m2uM2gAoTHwNK0Id4OL74gW8yhk07t+BzkG0rK
 UO6suJT62xhp+VeFJTvBjA1WQR8sqq7ofLperRD73Y1G0H0k6gouqA1UfQv8ZT7Zo4f/FzY1y
 8cKnQVhH9OlFDUaFGlyRzWbNF1knpSNzA+8t67RUjbJ7eeziI9j4tPbDyWSHDeJGM7z+fsD79
 VEPEi/XwrhUuDuIxXAQ4HdhznC/FV+WejDxQ39rmrplPIotxQgopeENgralOOYJAhcBOeYBm8
 NeIbFvDJsPS5Xx1PSfHqw/W3ykUMPYv5xpvnRLB51aYqmIhamXeFa/m8hcbFBwT7AccOKONEP
 DDIxhaLZoSNkWFcobPmsVFlXYqrCEbrirQguFDT27de3vYH3EjZlq9o+VynoJiyqGXlIZgAqY
 i6z/DP1pdKUL7/gy5O5xx0xVm6SfHkEirDfcqwkfXacA9Wx2Onmv2EL7+M7j23PNcE4z8PWjA
 CQI063rkveI/4dc33x/IPzN2+1OSjC0yy4nQ9mlEtCIUk72T6ba3mhSz9PLRd+jQA/Sj3E3bR
 AAm799aBHfvazlaMwyDXWhfqqQrN5aPbNIly8Cq2MiZVK9EpmtU42KBo54J6YJMueqD5jHW3q
 HVV2z3FunYk6G0QWXAMQV4jsC4k=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/3 01:28, Filipe Manana wrote:
> On Wed, Aug 2, 2023 at 12:18=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
>>
>>
>>
>> On 2023/8/2 18:36, Qu Wenruo wrote:
>>>
>>>
>>> On 2023/8/2 18:23, Filipe Manana wrote:
>>>> On Tue, Aug 1, 2023 at 8:16=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote=
:
>>>>>
>>>>> [BUG]
>>>>> Sometimes test case btrfs/276 would fail with extra number of extent=
s:
>>>>>
>>>>>       - output mismatch (see /opt/xfstests/results//btrfs/276.out.ba=
d)
>>>>>       --- tests/btrfs/276.out     2023-07-19 07:24:07.000000000 +000=
0
>>>>>       +++ /opt/xfstests/results//btrfs/276.out.bad        2023-07-28
>>>>> 04:15:06.223985372 +0000
>>>>>       @@ -1,16 +1,16 @@
>>>>>        QA output created by 276
>>>>>        wrote 17179869184/17179869184 bytes at offset 0
>>>>>        XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>>>       -Number of non-shared extents in the whole file: 131072
>>>>>       +Number of non-shared extents in the whole file: 131082
>>>>>        Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>>>>>       -Number of shared extents in the whole file: 131072
>>>>>       ...
>>>>>       (Run 'diff -u /opt/xfstests/tests/btrfs/276.out
>>>>> /opt/xfstests/results//btrfs/276.out.bad'  to see the entire diff)
>>>>>
>>>>> [CAUSE]
>>>>> The test case uses golden output to record the number of total exten=
ts
>>>>> of a 16G file.
>>>>>
>>>>> This is not reliable as we can have writeback happen halfway, result=
ing
>>>>> smaller extents thus slightly more extents.
>>>>>
>>>>> With a VM with 4G memory, I have a chance around 1/10 hitting this
>>>>> false alert.
>>>>>
>>>>> [FIX]
>>>>> Instead of using golden output, we allow a slight (5%) float in the
>>>>> number of extents, and move the 131072 (and 131072 - 16) from golden
>>>>> output, so even if we have a slightly more extents, we can still pas=
s
>>>>> the test.
>>>>>
>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>> ---
>>>>>    tests/btrfs/276     | 41 ++++++++++++++++++++++++++++++++++++----=
-
>>>>>    tests/btrfs/276.out |  4 ----
>>>>>    2 files changed, 36 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/tests/btrfs/276 b/tests/btrfs/276
>>>>> index 944b0c8f..a63b28bb 100755
>>>>> --- a/tests/btrfs/276
>>>>> +++ b/tests/btrfs/276
>>>>> @@ -65,10 +65,17 @@ count_not_shared_extents()
>>>>>
>>>>>    # Create a 16G file as that results in 131072 extents, all with a
>>>>> size of 128K
>>>>>    # (due to compression), and a fs tree with a height of 3 (root no=
de
>>>>> at level 2).
>>>>> +#
>>>>> +# But due to writeback can happen halfway, we may have slightly mor=
e
>>>>> extents
>>>>> +# than 128K, so we allow 5% increase in the number of extents.
>>>>> +#
>>>>>    # We want to verify later that fiemap correctly reports the
>>>>> sharedness of each
>>>>>    # extent, even when it needs to switch from one leaf to the next
>>>>> one and from a
>>>>>    # node at level 1 to the next node at level 1.
>>>>>    #
>>>>> +nr_extents_lower=3D$((128 * 1024))
>>>>> +nr_extents_upper=3D$((128 * 1024 + 128 * 1024 / 20))
>>>>> +
>>>>>    $XFS_IO_PROG -f -c "pwrite -b 8M 0 16G" $SCRATCH_MNT/foo |
>>>>> _filter_xfs_io
>>>>
>>>> Does adding '-s' (fsync after every write) to the $XFS_IO_PROG fixes
>>>> the issue?
>>>> On my test vm, it doesn't increase runtime by that much (16 to 23
>>>> seconds).
>>>
>>> This indeed is much better, without dirty pages pressure we can go the
>>> old golden output.
>>
>> Unfortunately I still have a very low chance (~1/20) to hit 1~3 more
>> extent than the golden output.
>>
>> There are still extra things like the commit intervals to let us to
>> writeback halfway.
>>
>> The best situation would be direct IO, but unfortunately direct IO
>> doesn't support compression, thus the resulted file would lead to merge=
d
>> fiemap results.
>
> The compression is not needed.
> I wrote the test to use compression because it makes creating a file wit=
h
> thousands of extents very fast and using very little space.
>
> The goal is really to have many file extent items spanning multiple leav=
es and
> to have a root at level 2 (or higher), to verify the sharedness
> detection is correct
> for subtrees.
>
>>
>> The other solution is to write between two files using direct IO, to
>> make each extent inside the same file not continuous with each other.
>>
>> But that would lead to at least 512M * 2, and we also need to do the
>> same interleaved writes again for the 1M writes.
>>
>> Any ideas would be appreciated.
>
> See if this works:
>
> https://pastebin.com/raw/QnNtSrDP

This works fine as after 20 runs I still didn't hit any output mismatch.

Although you can further improve it by using direct IO and much smaller
blocksize (4K), which can further reduce the size and completely
eliminate the possibility of writeback halfway.
(This would require 4K sector size though)

In that case, you can even reuse the old 131072 number, as we only need
around 512M (file size would be 1G) for data.


Another thing is, if tree level 3 (root node level 2) is needed, we can
even further reduce the file size by requiring 4K nodesize, which can
further speed up the test, without the need for xattr.

>
> It accomplishes the same goals and it's still fast (about 23 seconds
> on my non-debug test vm, before it was about 16 seconds).

The modified version is already fast enough even with a KASAN enabled
kernel, only 60s compared to the old 120+s.

Mind to send the modification as a proper fix? That's a much improved
version compared to mine.

Thanks,
Qu

>
> Thanks.
>
>>
>> Thanks,
>> Qu
>>>
>>> Thanks,
>>> Qu
>>>>
>>>> I'd rather do that so that we can be sure fiemap is working correctly
>>>> and not returning more extents than there really are - this approach
>>>> of allowing a bit more allows for that type of bug to be unnoticed,
>>>> plus that little bit more might not be always enough (depending on
>>>> available rm, writeback settings, etc).
>>>>
>>>> Thanks.
>>>>
>>>>>
>>>>>    # Sync to flush delalloc and commit the current transaction, so
>>>>> fiemap will see
>>>>> @@ -76,13 +83,22 @@ $XFS_IO_PROG -f -c "pwrite -b 8M 0 16G"
>>>>> $SCRATCH_MNT/foo | _filter_xfs_io
>>>>>    sync
>>>>>
>>>>>    # All extents should be reported as non shared (131072 extents).
>>>>> -echo "Number of non-shared extents in the whole file:
>>>>> $(count_not_shared_extents)"
>>>>> +found1=3D$(count_not_shared_extents)
>>>>> +echo "Number of non-shared extents in the whole file: ${found1}" >>
>>>>> $seqres.full
>>>>> +
>>>>> +if [ $found1 -lt $nr_extents_lower -o $found1 -gt $nr_extents_upper
>>>>> ]; then
>>>>> +       echo "unexpected initial number of extents, has $found1
>>>>> expect [$nr_extents_lower, $nr_extents_upper]"
>>>>> +fi
>>>>>
>>>>>    # Creating a snapshot.
>>>>>    $BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/sna=
p
>>>>> | _filter_scratch
>>>>>
>>>>>    # We have a snapshot, so now all extents should be reported as sh=
ared.
>>>>> -echo "Number of shared extents in the whole file:
>>>>> $(count_shared_extents)"
>>>>> +found2=3D$(count_shared_extents)
>>>>> +echo "Number of shared extents in the whole file: ${found2}" >>
>>>>> $seqres.full
>>>>> +if [ $found2 -ne $found1 ]; then
>>>>> +       echo "unexpected shared extents, has $found2 expect $found1"
>>>>> +fi
>>>>>
>>>>>    # Now COW two file ranges, of 1M each, in the snapshot's file.
>>>>>    # So 16 extents should become non-shared after this.
>>>>> @@ -97,8 +113,18 @@ sync
>>>>>
>>>>>    # Now we should have 16 non-shared extents and 131056 (131072 - 1=
6)
>>>>> shared
>>>>>    # extents.
>>>>> -echo "Number of non-shared extents in the whole file:
>>>>> $(count_not_shared_extents)"
>>>>> -echo "Number of shared extents in the whole file:
>>>>> $(count_shared_extents)"
>>>>> +found3=3D$(count_not_shared_extents)
>>>>> +found4=3D$(count_shared_extents)
>>>>> +echo "Number of non-shared extents in the whole file: ${found3}"
>>>>> +echo "Number of shared extents in the whole file: ${found4}" >>
>>>>> $seqres.full
>>>>> +
>>>>> +if [ $found3 !=3D 16 ]; then
>>>>> +       echo "Unexpected number of non-shared extents, has $found3
>>>>> expect 16"
>>>>> +fi
>>>>> +
>>>>> +if [ $found4 !=3D $(( $found1 - $found3 )) ]; then
>>>>> +       echo "Unexpected number of shared extents, has $found4 expec=
t
>>>>> $(( $found1 - $found3 ))"
>>>>> +fi
>>>>>
>>>>>    # Check that the non-shared extents are indeed in the expected fi=
le
>>>>> ranges (each
>>>>>    # with 8 extents).
>>>>> @@ -117,7 +143,12 @@ _scratch_remount commit=3D1
>>>>>    sleep 1.1
>>>>>
>>>>>    # Now all extents should be reported as not shared (131072 extent=
s).
>>>>> -echo "Number of non-shared extents in the whole file:
>>>>> $(count_not_shared_extents)"
>>>>> +found5=3D$(count_not_shared_extents)
>>>>> +echo "Number of non-shared extents in the whole file: ${found5}" >>
>>>>> $seqres.full
>>>>> +
>>>>> +if [ $found5 !=3D $found1 ]; then
>>>>> +       echo "Unexpected final number of non-shared extents, has
>>>>> $found5 expect $found1"
>>>>> +fi
>>>>>
>>>>>    # success, all done
>>>>>    status=3D0
>>>>> diff --git a/tests/btrfs/276.out b/tests/btrfs/276.out
>>>>> index 3bf5a5e6..e318c2e9 100644
>>>>> --- a/tests/btrfs/276.out
>>>>> +++ b/tests/btrfs/276.out
>>>>> @@ -1,16 +1,12 @@
>>>>>    QA output created by 276
>>>>>    wrote 17179869184/17179869184 bytes at offset 0
>>>>>    XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>>> -Number of non-shared extents in the whole file: 131072
>>>>>    Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>>>>> -Number of shared extents in the whole file: 131072
>>>>>    wrote 1048576/1048576 bytes at offset 8388608
>>>>>    XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>>>    wrote 1048576/1048576 bytes at offset 12884901888
>>>>>    XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>>>    Number of non-shared extents in the whole file: 16
>>>>> -Number of shared extents in the whole file: 131056
>>>>>    Number of non-shared extents in range [8M, 9M): 8
>>>>>    Number of non-shared extents in range [12G, 12G + 1M): 8
>>>>>    Delete subvolume (commit): 'SCRATCH_MNT/snap'
>>>>> -Number of non-shared extents in the whole file: 131072
>>>>> --
>>>>> 2.41.0
>>>>>
