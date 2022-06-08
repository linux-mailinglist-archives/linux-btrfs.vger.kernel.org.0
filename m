Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4219F542F95
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 13:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238511AbiFHL70 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 07:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238500AbiFHL7O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 07:59:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928EC24CCA4
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 04:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654689547;
        bh=PpoSfq+Fd2xrsVsQx/961s9VfxDnOwqvmFNGmwRFDrw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=X7zQjVk3/1u0AsaHdX9lMk01rFroUbLNPXwjZgGMFW0om74P2CEXRdP73zd7uU/xl
         kT+5SYNOMe/hgf1CkHvAiQ9kS38Yc0aFDx+11/Y0ZlDdMeEyiSdDW6MwiljmWoxoYE
         Mo4FEG3JDpzrR1+YF8c6RUsXlrCCQi4XzYm2foZo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N2V0H-1ncaIv247z-013rso; Wed, 08
 Jun 2022 13:59:07 +0200
Message-ID: <fbe7377e-fc7d-9993-74e4-8e2928d61168@gmx.com>
Date:   Wed, 8 Jun 2022 19:59:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: What mechanisms protect against split brain?
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Forza <forza@tnonline.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20220608185805.41ED.409509F4@e16-tech.com>
 <d1d47581-9003-2202-55ca-279b2ca4dba6@gmx.com>
 <20220608195524.7F1C.409509F4@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220608195524.7F1C.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HabJLa4ivn/6B+T87pGimIzm3B2UbWJHOo0TyIyjfU0eY7axNDQ
 JvioW5OsRREaw2OS6glUdZR/y5yvZSLPvRDqTuD7akW0c2zwxIfHpFE4I4PXnGdqB6Sp8in
 9EZUqq7Nk4Rw+r5vkiT4KrdC+J4dSpQpS2EVMjcZYe40KRXRjXZQ5clWKqt0Mv4j4TXyXQM
 RFpokMHVf/XeRIOAtRd2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WDG6alnBHEQ=:9ns8sn1lFwCtwdFkIvnj1M
 POoyVR+Q9lNzUe1Fi5QUK1TFzp4fYVHQ8N26YePer/TdgXqmvrJ8mg382vZeQ2pua0a/Hb/Ve
 Fe7TTT4Y3FfFhX9HrFAv5cwi7KEA+qQv/5WpwgNoRirn5O2hbXu4DDwfbc3NofQRXTeTsGNbv
 gNvIFArQR1YP+/DwHdEup0YDZCCKqjjUFyFBTF8/K0juvMqCkFJbtCWM6wLFsK+HkesJY9ltl
 W2dihJ+OkA3rS3Lf8NKkY6RIhafoYX3jmDPLdIQCUrcVDx1Wy/cQvU5z9I37rQD/0mFZNQMML
 RzFM7nV4hNOrma9mebYnjGd8mfCJwO0b5iFzBbG/YiqtBHW2lntP3tMuTWhR3umBVQH3SzVM/
 eV6bihpYz5bhQErhtD26Jpe8bKvUcyyJ9fuc/DUOEmHNdsC3H5gcc8BPwLyijdFTC87Y+taYR
 kjOylf4Gq3DRpx8O7WQybxf9ukLBg8SB1hAYKzJIJ4vj/SiiEIBCQrkEKskA0ONqxU4tkWq9W
 TmpDHUSERwzUv9JI2w+j5h/nMWa3WMmdVuo10ZrhvsMNa92bjP7wLFB6q514IquAJuYtiA658
 WGquYqwnJd5cuW9bisznSxr6DH6qu7c+8H11V52u3qXvGydJuDGKXTo3Y1qqeS4ZDHdLGtvIe
 mIGgqDY6CzTQEM0jfCo15MX04LrJ6su67ZCn8fcekTGr6wIXQqChjMUbg0AvYLYM/C3DkvleS
 6VGi9s6N5dA5hpZKGEbevI43cVEc6Q5SxGi7dRPlZ1FGNJQ8rFjP2Z1L8kZvyWLqxpwKJHc0p
 SzRRledEDzFSh82JUWSZJ67LwQkpUyS3YrAmhVPrBPMTkQtcGiRvMFH06YiJKJGdoghvRt1iU
 ca93bpsWwsPDDU6uuQqyYDhpqy6sAftaA2XB1D+7EVt0D7x4gRqy6B8Uq1YT2fVavYR8ApsZV
 NjRgCIDfAVy91pC2vUFdr6Dm+st4frVrMVrRreuV7sNFUJ7jX72ZFHu2nxh3pKNpsjBDBt3bh
 4cdmHd1Ktd8/PmQA46UAWoJAAgIBxBmRpKdwheXvCiKKMxP1MalAMQmroluS+VEEiFDeU5yGh
 w3j01AyctfE+7cUzHpXVh1AftdVKNNDT8zDdPjLuG0RzsJHl35yrBnrbw==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/8 19:55, Wang Yugui wrote:
> Hi,
>
>> On 2022/6/8 18:58, Wang Yugui wrote:
>>> Hi,
>>>
>>>> On 2022/6/8 18:15, Wang Yugui wrote:
>>>>> Hi, Forza, Qu Wenruo
>>>>>
>>>>> I write a script to test RAID1 split brain base on Qu's work of raid=
5(*1)
>>>>> *1: https://lore.kernel.org/linux-btrfs/53f7bace2ac75d88ace42dd811d4=
8b7912647301.1654672140.git.wqu@suse.com/T/#u
>>>>
>>>> No no no, that is not to address split brain, but mostly to drop cach=
e
>>>> for recovery path to maximize the chance of recovery.
>>>>
>>>> It's not designed to solve split brain problem at all, it's just one
>>>> case of such problem.
>>>>
>>>> In fact, fully split brain (both have the same generation, but
>>>> experienced their own degraded mount) case can not be solved by btrfs
>>>> itself at all.
>>>>
>>>> Btrfs can only solve partial split brain case (one device has higher
>>>> generation, thus btrfs can still determine which copy is the correct =
one).
>>>>
>>>>>
>>>>> #!/bin/bash
>>>>> set -uxe -o pipefail
>>>>>
>>>>> mnt=3D/mnt/test
>>>>> dev1=3D/dev/vdb1
>>>>> dev2=3D/dev/vdb2
>>>>>
>>>>>      dmesg -C
>>>>>      mkdir -p $mnt
>>>>>
>>>>>      mkfs.btrfs -f -m raid1 -d raid1 $dev1 $dev2
>>>>>      mount $dev1 $mnt
>>>>>      xfs_io -f -c "pwrite -S 0xee 0 1M" $mnt/file1
>>>>>      sync
>>>>>      umount $mnt
>>>>>
>>>>>      btrfs dev scan -u $dev2
>>>>>      mount -o degraded $dev1 $mnt
>>>>>      #xfs_io -f -c "pwrite -S 0xff 0 128M" $mnt/file2
>>>>>      mkdir -p $mnt/branch1; /bin/cp -R /usr/bin $mnt/branch1 #comple=
x than xfs_io
>>>>>      umount $mnt
>>>>>
>>>>>      btrfs dev scan
>>>>>      btrfs dev scan -u $dev1
>>>>>      mount -o degraded $dev2 $mnt
>>>>
>>>> Your case is the full split brain case.
>>>>
>>>> Not possible to solve.
>>>>
>>>> In fact, if you don't do the degraded mount on dev2, btrfs is complet=
ely
>>>> fine to resilve the fs without any problem.
>>>
>>> step1: we mark btrfs/RAID1 with degraded write as not-clean-RAID1.
>>
>> Then when to clean?
>> Full scrub or some timing else?
>
> 'full scrub' or 'full balance' is OK.
> this is not the normal path, so no critical performance is required.
>
>>> step2: in that state, we default try to read copy 0 of RAID1
>>> 	current pid based i/o patch select policy
>>>              preferred_mirror =3D first + (current->pid % num_stripes)=
;
>>
>> That's feasible, but still need an ondisk format change.
>
> yes. we need to save something into the disks.
> but maybe 1 byte per disk.  so maybe no ondisk format change.
>
>> Furthermore, this idea can also be done by a more generic way,
>> write-intent bitmap.
>>
>> In fact, DM layer uses this to speed up resilver, and handle split brai=
n
>> cases.
>>
>> With write-intent bitmap, every degraded write will leave the record in
>> the write-intent bitmap until properly resilvered.
>
> write-intent bitmap have the problem of performance,
> so it is a little expensive for RAID1[C34]?

For regular writes with all devices present, no update on write-intent tre=
e.

Only when degraded mounted, we start updating write-intent tree.

And from some testing results, the drop in performance for sequential RW
is mostly negligible, thus why DM-raid always go with write-intent bitmap.

Since I'm going to (at least try to) implement write-intent tree mostly
for RAID56, it may be a good idea to address the partial split brain
case as well.

Thanks,
Qu
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/06/08
>
>> Thanks,
>> Qu
>>
>>>
>>> this idea seem to work?
>>>
>>> degraded RAID1 write is almost the same as full split brain?
>>>
>>> Best Regards
>>> Wang Yugui (wangyugui@e16-tech.com)
>>> 2022/06/08
>
>
