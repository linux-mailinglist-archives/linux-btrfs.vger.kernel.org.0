Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3519324951
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Feb 2021 04:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbhBYDPY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Feb 2021 22:15:24 -0500
Received: from mout.gmx.net ([212.227.15.18]:39633 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230001AbhBYDPY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Feb 2021 22:15:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614222810;
        bh=kXV1QJdPuhDxLXcLEYX1uVe4f4bHrJLIp4Qi4IsT1zc=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=KIb3rlopVxa7E/HrnZg7bnZchqiHipz5ERkWDsGsdm5YKEcCT6arL1Ux07tdK2rzS
         JyMkJUdbsJyj+G327tBmIuXkRsIoXfknZVL2yH7xJnkZUtbk4nfuIf2OhPerOGwSWu
         uxIC/J2PaWOEDmE71Teyz4vGFCeX4yGPDxMBAgjU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MAfYw-1l8YaX3F4C-00B7hz; Thu, 25
 Feb 2021 04:13:30 +0100
To:     Eric Sandeen <sandeen@sandeen.net>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     fstests@vger.kernel.org
References: <3e8f846d-e248-52a3-9863-d188f031401e@sandeen.net>
 <5e133067-ec0c-f2c6-7fb6-84620e26881e@sandeen.net>
 <407b5343-4124-2e30-0202-13f42d612b7c@oracle.com>
 <68737772-deb2-6429-2ac6-572e15cffe57@sandeen.net>
 <b119f3a9-bf78-5b09-2054-09a2f583581c@gmx.com>
 <eb0d9c05-2818-fb57-4b2c-75b379d088a5@sandeen.net>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: xfstests seems broken on btrfs with multi-dev TEST_DEV
Message-ID: <74ea7a30-fd25-7ac5-b3ae-98cf7b70e80f@gmx.com>
Date:   Thu, 25 Feb 2021 11:13:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <eb0d9c05-2818-fb57-4b2c-75b379d088a5@sandeen.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QfCz2vGLmqoJKxQRWzPOivO8oZbcrSqPUnG9excEph8Ow8ePwxs
 Y8Orq1kcthsNzxuQgfD5fP50/IOyZAJychOwFzc/OLD8DZa6I8Yb/4+Zfy00hn50r2rMHhY
 GE4fYi2oqJ9qBz0c8FgZgeDfqt/Mw3KJ1aWPlFLUamCp/Ff1b1z/1YzP4nH1KLdD6586ncU
 4EYenUwVX+EhYhFLoRRhw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2eXtgLltXFE=:SL7nWz5m/oPLOmySiZaR1S
 Idr9KYZLkrRRFM0QavT+Fai81sa9uGP8g8WKqwKbidVHKtXh0Ow+i1YwJ/yrOP/vzhUoE9Yq1
 HO7ewrdZLYXP1tXYg6UUSswfvlwDXSbmSkB5+tDuepr5yLd+ohwTCEuyEEmMNEZjbJIQOLyR4
 TnyB7wf6ZK0XETrVTSsTrRQUjVSWN0oeDrWbz3orlhSObMCK4W3fx103hePBAhPJupJUAlllY
 Cr78RtIbdWMAYHjIgke32KVIkKL1qTC+x9g5YuWSiWwUMFZ1HJuWrii1GtizwhBJDwkbscLe3
 O/YKFT5uiOrlIm+YgsevfLMC2dFmu1Tt4FpLdhfPGjsbcefrlUho6BuFUNXuGZZIzXuswI8Zr
 YTPQeblLG87ehNeJgdLEPxnEwy7+jCfQSFNW6rAbOBXwtUAD3ajaJRCjm8hrFKXBnIYdoxbYH
 jvN18xy3/Gq7mMRedgYFm8MhRqs6dpy9TxIsyKMG5KH97jQ8ICq2u4wDS+fHV+Ao74jFyvTCf
 gsWSGgw3+ktMuXh78xffUK6hzTo3zRt5obhYMHO4Kv6buQTXMftA4n59eBEG3ia92QlmCiBtS
 CWTx4filrRsY29AzlxTpGFDKyzx+tzA8KSlBSihJXE+57CQXaSRzs6fsePyfTNvLEtXTvwJN7
 x569SJkjhQvmGn6cfDJzuCAVITOp82TehoghTyLsi0CFu47t4DKM7ibpMbTCpQeMIDPfw17/y
 tn4RfkliXLQSkZ0ShiG+I9gdvN/mX461eqgHZc3+y7xqpv1ehG3pUpFpit4YsimxMAucDQYoh
 cj5SlomrwkVsciGwzPiHrmF6emfaZt15CVfKnOon7J3ZTLQm1G3zEcJUUWax+2XJSHDzLzkvd
 vWyBXixYZkm0OGiqKO8w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/25 =E4=B8=8A=E5=8D=8810:45, Eric Sandeen wrote:
> On 2/24/21 7:56 PM, Qu Wenruo wrote:
>>
>>
>> On 2021/2/25 =E4=B8=8A=E5=8D=889:46, Eric Sandeen wrote:
>>> On 2/24/21 7:16 PM, Anand Jain wrote:
>>>> On 25/02/2021 05:39, Eric Sandeen wrote:
>>>>> On 2/24/21 10:12 AM, Eric Sandeen wrote:
>>>>>> Last week I was curious to just see how btrfs is faring with RAID5 =
in
>>>>>> xfstests, so I set it up for a quick run with devices configured as=
:
>>>>>
>>>>> Whoops this was supposed to cc: fstests, not fsdevel, sorry.
>>>>>
>>>>> -Eric
>>>>>
>>>>>> TEST_DEV=3D/dev/sdb1 # <--- this was a 3-disk "-d raid5" filesystem
>>>>>> SCRATCH_DEV_POOL=3D"/dev/sdb2 /dev/sdb3 /dev/sdb4 /dev/sdb5 /dev/sd=
b6"
>>>>>>
>>>>>> and fired off ./check -g auto
>>>>>>
>>>>>> Every test after btrfs/124 fails, because that test btrfs/124 does =
this:
>>>>>>
>>>>>> # un-scan the btrfs devices
>>>>>> _btrfs_forget_or_module_reload
>>>>>>
>>>>>> and nothing re-scans devices after that, so every attempt to mount =
TEST_DEV
>>>>>> will fail:
>>>>>>
>>>>>>> devid 2 uuid e42cd5b8-2de6-4c85-ae51-74b61172051e is missing"
>>>>>>
>>>>>> Other btrfs tests seeme to have the same problem.
>>>>>>
>>>>>> If xfstest coverage on multi-device btrfs volumes is desired, it mi=
ght be
>>>>>> a good idea for someone who understands the btrfs framework in xfst=
ests
>>>>>> to fix this.
>>>>
>>>> Eric,
>>>>
>>>>  =C2=A0=C2=A0All our multi-device test-cases under tests/btrfs used t=
he
>>>>  =C2=A0=C2=A0SCRATCH_DEV_POOL. Unless I am missing something, any ide=
a if
>>>>  =C2=A0=C2=A0TEST_DEV can be made optional for test cases that don't =
need TEST_DEV?
>>>>  =C2=A0=C2=A0OR I don't understand how TEST_DEV is useful in some of =
these
>>>>  =C2=A0=C2=A0test-cases under tests/btrfs.
>>>
>>> Those are the tests specifically designed to poke at multi-dev btrfs, =
right.
>>>
>>> TEST_DEV is more designed to "age" - it is used for more non-destructi=
ve tests.
>>>
>>> The point is that many tests /d/o run using TEST_DEV, and if a multi-d=
ev TEST_DEV
>>> can't be used, you are getting no coverage from those tests on that ty=
pe of
>>> btrfs configuration. And if a multi-dev TEST_DEV breaks the test run, =
nobody's
>>> going to test that way.
>>
>> The problem is, TEST_DEV should not be included in SCRATCH_DEV_POOL.
>
> Sorry, I typed out the config from memory and made an error, sorry for
> the confusion.
>
> Let me try again to demonstrate. I have 10 completely different block de=
vices
> (loop devices, for this demo)
>
> # cat local.config
> export TEST_DEV=3D/dev/loop1
> export TEST_DIR=3D/mnt/test
> export SCRATCH_DEV_POOL=3D"/dev/loop5 /dev/loop6 /dev/loop7 /dev/loop8 /=
dev/loop9"
> export SCRATCH_MNT=3D/mnt/scratch
>
> TEST_DEV is a 3-device filesystem:
>
> # mkfs.btrfs -f -d raid5 /dev/loop1 /dev/loop2 /dev/loop3
>
> so: 3-dev TEST_DEV, 5 /different/ devices in the SCRATCH_DEV_POOL
>
> Run btrfs/124:
>
> # ./check btrfs/124
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 intel-lizardhead-04 5.11.0-rc7+ #128 SMP F=
ri Feb 12 16:15:39 EST 2021
> MKFS_OPTIONS  -- /dev/loop5
> MOUNT_OPTIONS -- -o context=3Dsystem_u:object_r:root_t:s0 /dev/loop5 /mn=
t/scratch
>
> btrfs/124	- output mismatch (see /root/xfstests-dev/results//btrfs/124.o=
ut.bad)
>
> <ok it failed but ... beside the point>
>
> Now, no other test can be run:
>
> # dmesg -c > /dev/null
>
> # ./check generic/001
> mount: wrong fs type, bad option, bad superblock on /dev/loop1,
>         missing codepage or helper program, or other error
>
>         In some cases useful info is found in syslog - try
>         dmesg | tail or so.
> common/rc: retrying test device mount with external set
> mount: wrong fs type, bad option, bad superblock on /dev/loop1,
>         missing codepage or helper program, or other error
>
>         In some cases useful info is found in syslog - try
>         dmesg | tail or so.
> common/rc: could not mount /dev/loop1 on /mnt/test
>
> # dmesg
> [544731.787311] BTRFS info (device loop1): disk space caching is enabled
> [544731.794514] BTRFS info (device loop1): has skinny extents
> [544731.801050] BTRFS error (device loop1): devid 2 uuid 2cb73b87-b5c9-4=
6ec-a457-594455cfb7e3 is missing
> [544731.811343] BTRFS error (device loop1): failed to read the system ar=
ray: -2
> [544731.826098] BTRFS error (device loop1): open_ctree failed
> [544731.863343] BTRFS info (device loop1): disk space caching is enabled
> [544731.870530] BTRFS info (device loop1): has skinny extents
> [544731.877022] BTRFS error (device loop1): devid 2 uuid 2cb73b87-b5c9-4=
6ec-a457-594455cfb7e3 is missing
> [544731.887335] BTRFS error (device loop1): failed to read the system ar=
ray: -2
> [544731.903094] BTRFS error (device loop1): open_ctree failed
>
Now this makes way more sense, as your previous comment on
_btrfs_forget_or_module_reload is completely correct.

_btrfs_forget_or_module_reload will really forget all devices, while
what we really want is just excluding certain devices, and not to affect
the other ones.

The proper way to fix it is to only introduce _btrfs_forget to
unregister involved devices, not all.

I'll take a look into the fix, but I'm afraid that, for systems which
don't support forget, they have to skip those tests and reduce the
coverage for older kernel/progs.

Thanks,
Qu
