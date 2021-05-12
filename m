Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10DC37B3B0
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 May 2021 03:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhELBu2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 May 2021 21:50:28 -0400
Received: from mout.gmx.net ([212.227.15.18]:50977 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229848AbhELBu1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 May 2021 21:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620784155;
        bh=RNJMoTo+V2xUk9wpEU5NoT+u70g6717RFqNr8EAvoas=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=WB0rnXsOdzkhjewlIGucJtMzfCmPPB3WCA1dOzcX2XUbZ4WVfXWWhocB0ogHV1eys
         Fd+JEQBv/8KUIjk5jzLkB+3bHqXiJbkfMrMYXhNJ1livhhFIHYDFpSMqr5xCCztA7w
         RtR0WHymdVTWX7ZOHs73EX7ZoCaFSQ8GuJc2z5AI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MuUj2-1lOhjs2nnm-00rah5; Wed, 12
 May 2021 03:49:15 +0200
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210427230349.369603-1-wqu@suse.com>
 <20210427230349.369603-42-wqu@suse.com>
 <46a8cbb7-4c3a-024d-4ee3-cbeb4068e92e@suse.com>
 <20210507045735.jjtc76whburjmnvt@riteshh-domain>
 <5d406b40-23d9-8542-792a-2cd6a7d95afe@gmx.com>
 <e7e6ebdd-a220-e4ec-64e4-d031d7a9b181@gmx.com>
 <20210510122933.mcg2sac2ugdennbs@riteshh-domain>
 <95d7bc8a-5593-cc71-aee3-349dd6fd060d@gmx.com>
 <20210511104809.evndsdckwhmonyyl@riteshh-domain>
 <334a5fdd-28ee-4163-456c-adc4b2276d08@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [Patch v2 41/42] btrfs: fix the use-after-free bug in writeback
 subpage helper
Message-ID: <fae358ed-8d14-8e14-2dc3-173637ec5e87@gmx.com>
Date:   Wed, 12 May 2021 09:49:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <334a5fdd-28ee-4163-456c-adc4b2276d08@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HBbOsLC/F24qxUBuQ8B7f+i8ddHjLIRtT8JP4LMsItZ9y5g2fcC
 7tNkJkaCyc8IkwpHUoJgHZg/JmehwRlheOV//XFWmMjldHbTaiaoI72mNXoGcCokUYWI5sS
 8Hv/tQlnvKYUgaUOZZEf+VJ/yQj029u9DE4Ou7VTikYd6Uu5+Xkiqb41pB4RMcUabFYmEpC
 aGLhnIriDbSZ6E4gc6HYg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kAVvDcfvUpg=:9nYsqqdDoFGRGCVpofsQUx
 +snFHHQwYDorlwdCCV95QWTqUrHCopzCrQKce92psJ4c0BHLJ1CsUDg7CFkzc+DupYiuGbaKZ
 q6OIfXkecHOyBUnDepQtcfUpOY+PV6vCePoJv5J0ZLa5Efc0pIJ2LS3ZW1J1gs0JlJFY3FhZV
 NKuVlwXEjPjcz+PLknyr5yeeuchd2VxWte3r5QWLtzWBJEfttMlLISMy+6gEnxLbAZ5z2dEDe
 vZGiR4eDo+VH1lwMQYHkajhriaBc2egW6GyWfYh1/WFXpW6jIsvbD3+dsnaZazzfU/yaxqf4f
 NJ2SEXupYJeAObrrrgYO3E9+E2Z+GK3EiprRmMkwKLUiCAgnaIxqO1Cr9LTD2ydrxJgW4uSm7
 5J8GlphHBxyOlOmIDF94e+J81Oh1HliX6+dyFM/UcOh98BlMhUWA/bzG9LpsFBszeWOsA71lh
 FYND93Zw9lxevtBevJqLPHBs5h2+TW4oaTLSrVKZYx6nGZ6GzOHSDyGqp1Ue2ZQ2UlK8Sr7i8
 UJQSQ1r56LDMH36wXbsgm4plygxo+TJ2l5sHNb3JKDLPZ5bLRBGelKj7HrcMwAM+RSQXtLEwp
 PM3x7MbAyo+J3/H4/lEMV+Zd0/2T8sgq2K85ljCdrhSE1Nn4f7fz/5Ee15auJJBeJXqmj7UhX
 6lVAi2evNSw8PmHhTCs3hUIGH9DNFoNcJgFDJ5d0zcyJ/+MiT75tuZWHiBGs3CWzEKJ4NuEcH
 Fbd61j8P8j9jWqxWEMHVgclYW0MOwF1Jd1cCP+VmdT2DgxQA+WDEl4RZ3FlCtWLxkKgQLBARO
 aoiPainRONHUHC0W9kJ1F8aiQBk46IJoXVhj/5Wai2x6G5FH5OLy+w+KRFQBG5V/rKiRZFYET
 niqoPgOIbT/8s3hPHRLvv4xMOD5rJLfuqm+oDnVvbD9f4q5kY4ht4049VbL75DDfgCFSsjYep
 843aXfLds0ugpwy49RwjdezdbrSzQ+w1W/np8mxVuF8eULRIQ5bwIslSAgs0YNv2sdFvb+lIX
 lv4UtKetXTyp/uY5pXyqhPXJ/1TDH6QQc450INybyjaVBFPwSX+BE+elRkBD6FopvnH7H5Ch8
 h3MfnzKHyIqoS9p9hvm5allgHYPslN1wbbSwG2dnBbjzDjBsFU8gf1rTfvFMTTHb670fv4535
 DEoLNOG2v3imngsIxG9WeLLUppyRP9I3shLHvK+DIrGt5FWhLITbsrA92zZsuia90gkU+yaXn
 NmNg/m1zjgCy4ihZ1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Ritesh,

The patchset gets updated, and I am already running the tests, so far so
good.

The new head is:
commit cb81da05e7899b8196c3c5e0b122798da3b94af0
Author: Qu Wenruo <wqu@suse.com>
Date:   Mon May 3 08:19:27 2021 +0800

     btrfs: remove io_failure_record::in_validation

I may have some minor change the to commit messages and comments
preparing for the next submit, but the code shouldn't change any more.


Just one note, thanks to your report on btrfs/028, I even find a data
corruption bug in relocation code.
Kudos (and of-course Reported-by tags) to you!

New changes since v2 patchset:

- Fix metadata read path ASSERT() when last eb is already dereferred
- Fix read repair related bugs
   * fix possible hang due to unreleased sectors after read error
   * fix double accounting in btrfs_subpage::readers

- Fix false alert when relocating data extent without csum
   This is really a false alert, the expected csum is always 0x00

- Fix a data corruption when relocating certain data extents layout
   This is a real corruption, both relocation and scrub will report
   error.

Thanks and happy testing!
Qu

On 2021/5/11 =E4=B8=8B=E5=8D=887:15, Qu Wenruo wrote:
>
>
> On 2021/5/11 =E4=B8=8B=E5=8D=886:48, Ritesh Harjani wrote:
>> On 21/05/10 09:10PM, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/5/10 =E4=B8=8B=E5=8D=888:29, Ritesh Harjani wrote:
>>>> On 21/05/10 04:38PM, Qu Wenruo wrote:
>>>>> Hi Ritesh,
>>>>>
>>>>> I guess no error report so far is a good thing?
>>>> Sorry about the delay in starting of my testing. Was not keeping
>>>> well since
>>>> Friday onwards, hence could not start the testing. (Feeling much
>>>> better now).
>>>>
>>>> So -g quick passed w/o any fatal issues. But with -g auto I got a
>>>> kernel bug
>>>> with btrfs/28. Below is the report.
>>>>
>>>>>
>>>>> Just to report what my result is, I ran my latest github branch for
>>>>> the
>>>>> full weekend, over 50 hours, and around 20 runs of full generic/auto
>>>>> without defrag groups.
>>>>>
>>>>> And I see no crash at all.
>>>>>
>>>>> But there is a special note, there is a new patch, introduced just
>>>>> before the weekend (Fri May 7 09:31:43 2021 +0800), titled "btrfs:
>>>>> fix a
>>>>> possible use-after-free race in metadata read path", is a new fix
>>>>> for a
>>>>> bug I reproduced once locally.
>>>>
>>>> Yes,=C2=A0 I already have this in my tree. This is the latest patch i=
n my
>>>> tree which
>>>> I am testing.
>>>> "btrfs: remove io_failure_record::in_validation"
>>>>
>>>>>
>>>>> The bug should only happen when read is slow and only happens for
>>>>> metadata read path.
>>>>>
>>>>> The details can be found in the commit message, although it's rare t=
o
>>>>> hit, I have hit such problem around 3 times in total.
>>>>>
>>>>> Hopes you didn't hit any crash during your test.
>>>>
>>>> I am hitting below bug_on(). Since I saw your email just now, so I
>>>> am directly
>>>> reporting this failure, w/o analyzing. Please let me know if you
>>>> need anything
>>>> else from my end for this.
>>>>
>>>> I will halt the testing of "-g auto" for now. Once we have some
>>>> conclusion on
>>>> this one, then will resume the testing.
>>>
>>> Thanks for the reporting, I was still just looping generic tests, thus
>>> didn't yet start testing the btrfs tests.
>>>
>>> But considering no new crash in generic tests, I guess it's time to mo=
ve
>>> forward.
>>>
>>>>
>>>> btrfs/028 32s ...=C2=A0=C2=A0=C2=A0=C2=A0 [10:41:18][=C2=A0 780.10457=
3] run fstests btrfs/028
>>>> at 2021-05-10 10:41:18
>>>>
>>>> [=C2=A0 780.732073] BTRFS: device fsid
>>>> be9b827d-28ee-4a5e-80a0-e19971061a58 devid 1 transid 5 /dev/vdc
>>>> scanned by mkfs.btrfs (21129)
>>>> [=C2=A0 780.759754] BTRFS info (device vdc): disk space caching is en=
abled
>>>> [=C2=A0 780.759848] BTRFS info (device vdc): has skinny extents
>>>> [=C2=A0 780.759888] BTRFS warning (device vdc): read-write for sector
>>>> size 4096 with page size 65536 is experimental
>>>> <...>
>>>> [=C2=A0 784.580404] BTRFS info (device vdc): found 21 extents, stage:
>>>> move data extents
>>>> [=C2=A0 784.878376] BTRFS info (device vdc): found 13 extents, stage:
>>>> update data pointers
>>>> [=C2=A0 785.175349] BTRFS info (device vdc): balance: ended with stat=
us: 0
>>>> [=C2=A0 785.367729] BTRFS info (device vdc): balance: start -d
>>>> [=C2=A0 785.400884] BTRFS info (device vdc): relocating block group
>>>> 2446327808 flags data
>>>> [=C2=A0 785.527858] btrfs_print_data_csum_error: 18 callbacks suppres=
sed
>>>> [=C2=A0 785.527865] BTRFS warning (device vdc): csum failed root -9 i=
no
>>>> 262 off 393216 csum 0x8941f998 expected csum 0x9439dda4 mirror 1
>>>
>>> Checking the test case btrfs/028, it shouldn't have any error when
>>> relocating the block groups, thus it's definitely something wrong in t=
he
>>> balance code.
>>>
>>> Thanks for the report, I'll give you an update after finishing the loc=
al
>>> btrfs test groups.
>>>
>>> Thanks for your confirmation, really helps a lot!
>>
>> Hi Qu,
>>
>> FYI - I re-tested "-g auto" with btrfs/028 test excluded. I didn't
>> find any
>> other failure.
>
> That's too kind of you.
>
> It's not a surprise for it too pass generic tests, but since I haven't
> yet run full btrfs test group, it passing other btrfs tests is really a
> good news.
>
>> Please let me know once you have a fix for btrfs/028, I can
>> re-test the whole tree again.
>
> Fix on the way, in fact btrfs/028 already shows several bugs I didn't
> expect at all, some spoilers:
>
> - The crash in btrfs_subpage_end_reader()
>  =C2=A0 It turns out to be a bug in the read time refactor patches. ("bt=
rfs:
>  =C2=A0 submit read time repair only for each corrupted sector")
>  =C2=A0 Fixed in the original patch.
>
> - Possible hang for certain data repair failure
>  =C2=A0 The same cause as above bug.
>  =C2=A0 Fixed in the original patch.
>
> - False alert for data reloc, with expected csum 0x00
>  =C2=A0 A bug in btrfs_verify_data_csum() which from the very beginning =
it
>  =C2=A0 doesn't take subpage into consideration.
>  =C2=A0 Fixed in a new patch.
>
> - False alert for data reloc, with random expected csum
>  =C2=A0 Still debugging, hopes to be the last bug in the series.
>
> Will give another update when the last bug get solved.
>
> Thanks,
> Qu
>>
>> Thanks
>> ritesh
>>
>>
>>> Qu
>>>
>>>> [=C2=A0 785.528406] btrfs_dev_stat_print_on_error: 18 callbacks suppr=
essed
>>>> [=C2=A0 785.528409] BTRFS error (device vdc): bdev /dev/vdc errs: wr =
0,
>>>> rd 0, flush 0, corrupt 1, gen 0
>>>> [=C2=A0 785.528857] BTRFS warning (device vdc): csum failed root -9 i=
no
>>>> 262 off 397312 csum 0x8941f998 expected csum 0x9439dda4 mirror 1
>>>> [=C2=A0 785.529166] BTRFS error (device vdc): bdev /dev/vdc errs: wr =
0,
>>>> rd 0, flush 0, corrupt 2, gen 0
>>>> [=C2=A0 785.529412] BTRFS warning (device vdc): csum failed root -9 i=
no
>>>> 262 off 401408 csum 0x8941f998 expected csum 0x667b7e1e mirror 1
>>>> [=C2=A0 785.529714] BTRFS error (device vdc): bdev /dev/vdc errs: wr =
0,
>>>> rd 0, flush 0, corrupt 3, gen 0
>>>> [=C2=A0 785.530321] BTRFS warning (device vdc): csum failed root -9 i=
no
>>>> 262 off 393216 csum 0x8941f998 expected csum 0x9439dda4 mirror 1
>>>> [=C2=A0 785.530637] BTRFS error (device vdc): bdev /dev/vdc errs: wr =
0,
>>>> rd 0, flush 0, corrupt 4, gen 0
>>>> [=C2=A0 785.530882] BTRFS warning (device vdc): csum failed root -9 i=
no
>>>> 262 off 397312 csum 0x8941f998 expected csum 0x9439dda4 mirror 1
>>>> [=C2=A0 785.531185] BTRFS error (device vdc): bdev /dev/vdc errs: wr =
0,
>>>> rd 0, flush 0, corrupt 5, gen 0
>>>> [=C2=A0 785.531428] BTRFS warning (device vdc): csum failed root -9 i=
no
>>>> 262 off 401408 csum 0x8941f998 expected csum 0x667b7e1e mirror 1
>>>> [=C2=A0 785.531719] BTRFS error (device vdc): bdev /dev/vdc errs: wr =
0,
>>>> rd 0, flush 0, corrupt 6, gen 0
>>>> <...>
>>>> [=C2=A0 803.459877] BTRFS info (device vdc): relocating block group
>>>> 10499391488 flags data
>>>> [=C2=A0 803.776810] BTRFS info (device vdc): found 29 extents, stage:
>>>> move data extents
>>>> [=C2=A0 803.979572] BTRFS info (device vdc): found 18 extents, stage:
>>>> update data pointers
>>>> [=C2=A0 804.276370] BTRFS info (device vdc): balance: ended with stat=
us: 0
>>>> [=C2=A0 804.427621] BTRFS info (device vdc): balance: start -d
>>>> [=C2=A0 804.454527] BTRFS info (device vdc): relocating block group
>>>> 11036262400 flags data
>>>> [=C2=A0 804.623962] BTRFS warning (device vdc): csum failed root -9 i=
no
>>>> 282 off 684032 csum 0x8941f998 expected csum 0x605aaa22 mirror 1
>>>> [=C2=A0 804.624147] BTRFS error (device vdc): bdev /dev/vdc errs: wr =
0,
>>>> rd 0, flush 0, corrupt 15, gen 0
>>>> [=C2=A0 804.624277] BTRFS warning (device vdc): csum failed root -9 i=
no
>>>> 282 off 688128 csum 0x8941f998 expected csum 0xe90a7889 mirror 1
>>>> [=C2=A0 804.624435] BTRFS error (device vdc): bdev /dev/vdc errs: wr =
0,
>>>> rd 0, flush 0, corrupt 16, gen 0
>>>> [=C2=A0 804.624682] assertion failed: atomic_read(&subpage->readers) =
>=3D
>>>> nbits, in fs/btrfs/subpage.c:203
>>>> [=C2=A0 804.624902] ------------[ cut here ]------------
>>>> [=C2=A0 804.624989] kernel BUG at fs/btrfs/ctree.h:3415!
>>>> cpu 0x1: Vector: 700 (Program Check) at [c000000007b47640]
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pc: c000000000af297c: assertfail.const=
prop.11+0x34/0x38
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lr: c000000000af2978: assertfail.const=
prop.11+0x30/0x38
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sp: c000000007b478e0
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 msr: 800000000282b033
>>>> =C2=A0=C2=A0=C2=A0 current =3D 0xc000000007999800
>>>> =C2=A0=C2=A0=C2=A0 paca=C2=A0=C2=A0=C2=A0 =3D 0xc00000003fffee00=C2=
=A0=C2=A0=C2=A0=C2=A0 irqmask: 0x03=C2=A0=C2=A0=C2=A0=C2=A0 irq_happened:
>>>> 0x01
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pid=C2=A0=C2=A0 =3D 23, comm =3D kwork=
er/u4:1
>>>> kernel BUG at fs/btrfs/ctree.h:3415!
>>>> Linux version 5.12.0-rc8-00160-gcd0da6627caa (root@ltctulc6a-p1)
>>>> (gcc (Ubuntu 8.4.0-1ubuntu1~18.04) 8.4.0, GNU ld (GNU Binutils for
>>>> Ubuntu) 2.30) #25 SMP Mon May 10 01:31:44 CDT 2021
>>>> enter ? for help
>>>> [c000000007b47940] c000000000aefdac btrfs_subpage_end_reader+0x5c/0xb=
0
>>>> [c000000007b47980] c000000000a379f0 end_page_read+0x1d0/0x200
>>>> [c000000007b479c0] c000000000a41554 end_bio_extent_readpage+0x784/0x9=
b0
>>>> [c000000007b47b30] c000000000b4a234 bio_endio+0x254/0x270
>>>> [c000000007b47b70] c0000000009f6178 end_workqueue_fn+0x48/0x80
>>>> [c000000007b47ba0] c000000000a5c960 btrfs_work_helper+0x260/0x8e0
>>>> [c000000007b47c40] c00000000020a7f4 process_one_work+0x434/0x7d0
>>>> [c000000007b47d10] c00000000020ae94 worker_thread+0x304/0x570
>>>> [c000000007b47da0] c0000000002173cc kthread+0x1bc/0x1d0
>>>> [c000000007b47e10] c00000000000d6ec ret_from_kernel_thread+0x5c/0x70
>>>>
>>>> -ritesh
>>>>
