Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6464945BFF8
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 14:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245499AbhKXND6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 08:03:58 -0500
Received: from mout.gmx.net ([212.227.17.22]:48443 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344951AbhKXNCJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 08:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637758736;
        bh=h8TGvTdMhOw3Pwi4yG/cfWB5rtS26XyFKo+WgkG6Jag=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=YvQojrk+JepKSrWZXsXZmkuBn1Mk2C+qvt2YTJLwMWSXiq7Sstj6j8WFG6rZNRj7v
         hsA+NRcXBbh5JtbgwaTiCptyamcnWlusVPcIt/vFRx/mZRaQUsotvwt0+48dm/k9Ko
         Slz+42hgmDPWsgw6l7ZXMzmfJEGdMzQob7Ztp1TU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXXuB-1n8JIO0bap-00YySB; Wed, 24
 Nov 2021 13:58:55 +0100
Message-ID: <ba69127d-3ca7-2159-0a5f-ac1de50c3c8c@gmx.com>
Date:   Wed, 24 Nov 2021 20:58:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2] fstests: btrfs/049: add regression test for
 compress-force mount options
Content-Language: en-US
To:     fdmanana@gmail.com
Cc:     Qu Wenruo <wqu@suse.com>, fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20211124065219.33409-1-wqu@suse.com>
 <CAL3q7H7FB96c753TniOvZwqqOvvT0MFiyjg0=Ev9wHThD4z-Kw@mail.gmail.com>
 <e094e7d5-7f4c-2583-db85-fe296ce24528@gmx.com>
 <CAL3q7H5PnRLEFnwUDmS5igBbGBxJW7+EaCvEi7ig78S-7mWcZw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAL3q7H5PnRLEFnwUDmS5igBbGBxJW7+EaCvEi7ig78S-7mWcZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VlrmyXIsibwOwkSctNiGX9Bia/6MEXmLdknpd2YHwUdCQTh5FLj
 FLzbGBltUygtt+GM+9frmk/iyEH5nf+ewlFp6jnC9+9HwJo6ndPPZw0ly1Mc0zAvOEVOR5D
 wDqkOpRPs9qGztw0Jbyhw874OuOrT5IV6lQevVvK6bDiQjNdR3bneEptZNJVBSgHOGIjgj9
 yEUgXtFFP+dvcoARKwtsQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+ATBrIdCqKQ=:qfhJwjNv7FDdyCd5NpD5nP
 RzUCU8lLUGhEosc2kUsFT5S2hjEJFhCENfGBeWOlCbRUayWmw4NCHJRvbKTRQaSNx6Esn7dt/
 e1IN8Kwp+1G29LA+XkoQDe70yUAxaKbUFA0HQzAGufEByyIJIkFfVwhM0uViu4FkaaVR4FMbI
 RxWGV22SC7qyNZac5kYHsrZArb5J0FG7HrpKY4GmwoUXgEFA+SuTvtX8bBGzl/pRk/x97/Je9
 WHPg3v4XVexIfObYkGt7zZWMDckqIwPfzrIW4xBqQoi+zrvOqijqeSxhA/h4yTqQyZOXA2n/n
 IDJdTprdOuwxDF89Qzc3x29iJsLAqIYSEDOpt4+KQx/WYHYFsXWHZ65g8Q/7yUZ5JAn8NI8Gh
 ZtMWTbJV9QR+yzlUmigolDZ1TNS38E/J9mkgpBjy7gc5WvZ90/zXqFw3plhdRbCGNVuSIgz7b
 HNQNjzwBVZTtNYeHpJ7FKamvb3VXIblsHD/J+FJ9yNDWuGX4bIqBy+/XuRzdzLRwbBAMxIO2+
 Ju++B6Jc1w67A19u/cS1bJL4W0AMwYRSZmfGn4rxILnvDz5ozs+TujYDhZfrZ/3sVgZN8xGCt
 mI4qAEyKvvSK6p8P5KKFGzghJUArYphxx1dt8mjlDx1SOK9x3dVzYTT8WJPtxtENb4Snhu6TN
 raaWO0Z+Xubgaz/ex+AB+L8xQW4ZNwPxq7fO6xrs3Y5wV3Yl+dC6scBeadExqcwoGJPZpo7zf
 irJ0N2l57lsh2lBPDqrVvBQzYvGrKn6Ktc2nS9MiQn7v8df6l5K7mlmGRn5xpnxfdjMDibsaq
 MnabITTAws6ROxCArB8mwR/cCEn9j+8NOAuS3cbb6+rw+sbfBG80Mb2ZadJ7dbSPIZ/Lv3+mx
 tPUF48aGD9OfOZzzxYgV5s6jjE/VHeR4AOi6NGf2NHcw/pfJj+MXB3aKlz+WoE6SuCvp0udeL
 nDmPAuDu/LxDfEB3d4gCvcJAXrk2vD3r/0Al0BVKIOkWNCKVEkgogtBUkoI25UD55ppuhPVAT
 W9LvIx1CdAWMNfT21hxrWqp/adnN6XCLuF2WAvGr1Xcs4J31KRQmGYXD4Jayjwn3i1YJwwTe7
 IMtyejXZbxPi8g=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/24 20:51, Filipe Manana wrote:
> On Wed, Nov 24, 2021 at 12:28 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>
>>
>>
>> On 2021/11/24 19:22, Filipe Manana wrote:
>>> On Wed, Nov 24, 2021 at 9:24 AM Qu Wenruo <wqu@suse.com> wrote:
>>>>
>>>> Since kernel commit d4088803f511 ("btrfs: subpage: make lzo_compress_=
pages()
>>>> compatible"), lzo compression no longer respects the max compressed p=
age
>>>> limit, and can cause kernel crash.
>>>>
>>>> The upstream fix is 6f019c0e0193 ("btrfs: fix a out-of-bound access i=
n
>>>> copy_compressed_data_to_page()").
>>>>
>>>> This patch will add such regression test for all possible compress-fo=
rce
>>>> mount options, including lzo, zstd and zlib.
>>>>
>>>> And since we're here, also make sure the content of the file matches
>>>> after a mount cycle.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>> Changelog:
>>>> v2:
>>>> - Also test zlib and zstd
>>>> - Add file content verification check
>>>> ---
>>>>    tests/btrfs/049     | 56 +++++++++++++++++++++++++++++++++++++++++=
++++
>>>>    tests/btrfs/049.out |  6 +++++
>>>>    2 files changed, 62 insertions(+)
>>>>    create mode 100755 tests/btrfs/049
>>>>
>>>> diff --git a/tests/btrfs/049 b/tests/btrfs/049
>>>> new file mode 100755
>>>> index 00000000..264e576f
>>>> --- /dev/null
>>>> +++ b/tests/btrfs/049
>>>> @@ -0,0 +1,56 @@
>>>> +#! /bin/bash
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +# Copyright (C) 2021 SUSE Linux Products GmbH. All Rights Reserved.
>>>> +#
>>>> +# FS QA Test 049
>>>> +#
>>>> +# Test if btrfs will crash when using compress-force mount option ag=
ainst
>>>> +# incompressible data
>>>> +#
>>>> +. ./common/preamble
>>>> +_begin_fstest auto quick compress dangerous
>>>> +
>>>> +# Override the default cleanup function.
>>>> +_cleanup()
>>>> +{
>>>> +       cd /
>>>> +       rm -r -f $tmp.*
>>>> +}
>>>> +
>>>> +# Import common functions.
>>>> +. ./common/filter
>>>> +
>>>> +# real QA test starts here
>>>> +
>>>> +# Modify as appropriate.
>>>> +_supported_fs btrfs
>>>> +_require_scratch
>>>> +
>>>> +pagesize=3D$(get_page_size)
>>>> +workload()
>>>> +{
>>>> +       local compression
>>>> +       compression=3D$1
>>>
>>> Could be shorter by doing it in one step:
>>>
>>> local compression=3D$1
>>>
>>>> +
>>>> +       echo "=3D=3D=3D Testing compress-force=3D$compression =3D=3D=
=3D"
>>>> +       _scratch_mkfs -s "$pagesize">> $seqres.full
>>>> +       _scratch_mount -o compress-force=3D"$compression"
>>>> +       $XFS_IO_PROG -f -c "pwrite -i /dev/urandom 0 $pagesize" \
>>>> +               "$SCRATCH_MNT/file" > /dev/null
>>>> +       md5sum "$SCRATCH_MNT/file" > "$tmp.$compression"
>>>
>>> This doesn't really check if everything we asked to write was actually=
 written.
>>> pwrite(2), write(2), etc, return the number of bytes written, which
>>> can be less than what we asked for.
>>>
>>> And using the checksum verification in that way, we are only checking
>>> that what we had before unmounting is the same after mounting again.
>>> I.e. we are not checking that what was actually written is what we
>>> have asked for.
>>>
>>> We could do something like:
>>>
>>> data=3D$(dd count=3D4096 bs=3D1 if=3D/dev/urandom)
>>> echo -n "$data" > file
>>
>> The reason I didn't want to use dd is it doesn't have good enough
>> wrapper in fstests.
>> (Thus I guess that's also the reason why you use above command to
>> workaround it)
>>
>> If you're really concerned about the block size, it can be easily
>> changed using "-b" option of pwrite, to archive the same behavior of th=
e
>> dd command.
>>
>> Furthermore, since we're reading from urandom, isn't it already ensured
>> we won't get blocked nor get short read until we're reading very large
>> blocks?
>
> I gave dd as an example, but I don't care about dd at all, it can be
> xfs_io or anything else.
>
> My whole point was about verifying that what's written to the file is
> what we intended to write.
>
> Verifying the checksum is fine when we know exactly what we asked to
> write, when the test hard codes what we want to write.
>
> In this case we're asking to write random content, so doing an md5sum
> of the file after writing and
> then comparing it to what we get after we unmount and mount again, is
> not a safe way to test we have the
> expected content.
>
>>
>> Thus a very basic filter on the pwrite should be enough to make sure we
>> really got page sized data written.
>
> It's not just about checking if the size of what was written matches
> what we asked to write.
> It's all about verifying the written content matches what we asked to
> write in the first place (which implicitly ends up verifying the size
> as well when using a checksum).

OK, then what we should do is first read 4K from urandom into some known
good place (thus I guess that's why you only use dd to read into
stdout), then do the csum, and compare it after the mount cycle?

Thanks,
Qu

>
>>
>> Thanks,
>> Qu
>>
>>>
>>> _scratch_cycle_mount
>>>
>>> check that the the md5sum of file is the same as:  echo -n "$data" | m=
d5sum
>>>
>>> As it is, the test is enough to trigger the original bug, but having
>>> such additional checks is more valuable IMO for the long run, and can
>>> help prevent other types of regressions too.
>>>
>>> Thanks Qu.
>>>
>>>
>>>> +
>>>> +       # When unpatched, compress-force=3Dlzo would crash at data wr=
iteback
>>>> +       _scratch_cycle_mount
>>>> +
>>>> +       # Make sure the content matches
>>>> +       md5sum -c "$tmp.$compression" | _filter_scratch
>>>> +       _scratch_unmount
>>>> +}
>>>> +
>>>> +workload lzo
>>>> +workload zstd
>>>> +workload zlib
>>>> +
>>>> +# success, all done
>>>> +status=3D0
>>>> +exit
>>>> diff --git a/tests/btrfs/049.out b/tests/btrfs/049.out
>>>> index cb0061b3..258f3c09 100644
>>>> --- a/tests/btrfs/049.out
>>>> +++ b/tests/btrfs/049.out
>>>> @@ -1 +1,7 @@
>>>>    QA output created by 049
>>>> +=3D=3D=3D Testing compress-force=3Dlzo =3D=3D=3D
>>>> +SCRATCH_MNT/file: OK
>>>> +=3D=3D=3D Testing compress-force=3Dzstd =3D=3D=3D
>>>> +SCRATCH_MNT/file: OK
>>>> +=3D=3D=3D Testing compress-force=3Dzlib =3D=3D=3D
>>>> +SCRATCH_MNT/file: OK
>>>> --
>>>> 2.34.0
>>>>
>>>
>>>
>
>
>
