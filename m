Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA994AA49D
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Feb 2022 00:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244418AbiBDXvh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 18:51:37 -0500
Received: from mout.gmx.net ([212.227.17.21]:41273 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233874AbiBDXvf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Feb 2022 18:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644018694;
        bh=fqL5JYYWnwF8FAXlgwR1Nn33jKUfjJR+tv8aFrvWiIg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=jTQ6/v6SjXBFlu2LQ2s0HkAKpsqbwj2OvHW5ZvBCnooHEFCJQGkH6/vgoAhEOdwng
         hPzVXEk9K2KnrW6LbCa+4xPFT5jmfIh56bP2+K19jBvCG9oIHkhMJ5LOUYhcOkpk2+
         bj5VJraBmGpENN3QqHMzVVtds19JsHC83Mx0HPQg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8QS8-1nBiWD1Juy-004QVF; Sat, 05
 Feb 2022 00:51:34 +0100
Message-ID: <3f0c7ad3-176d-82a5-1399-ec7984335dd2@gmx.com>
Date:   Sat, 5 Feb 2022 07:51:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Still seeing high autodefrag IO with kernel 5.16.5
Content-Language: en-US
To:     Benjamin Xiao <ben.r.xiao@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <KTVQ6R.R75CGDI04ULO2@gmail.com>
 <9409dc0c-e99d-cc61-757e-727bd54c6ffd@gmx.com>
 <88b6fe3e-8317-8070-cb27-0aee4dc72cfb@gmx.com>
 <5AJR6R.7DWSX2SE14RN3@gmail.com>
 <2d78b264-5a12-c7ba-21c4-26a56ef54101@gmx.com>
 <MKJS6R.H0H9NI558A0Q2@gmail.com> <O1PS6R.R1VLYNSP0TUR@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <O1PS6R.R1VLYNSP0TUR@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lPZCANnBE7M/B3ZL7pCNa5BQ70hyOiFaJmp4IIj8ff6EPss2wUz
 TOnT+UmaRcZ1iqBvJ8lNqbcVSPeVKMwg+4NKW7X+RtB/auq77Z+KTGpaM8skWyUmt2yTYhu
 61qDAURz4bplrTk2sWCWN7YwRqhAzBbtyOg3oCUwu2pV706eE2eC/e5Ueyq5QkQxr5DTpzb
 AZiPCGnyrjW5TUTSDa77g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vulqAZWZew0=:kbprKY1CfXCmDKF8rnQGHD
 0jurFNDUhem4f++gp6/wnW6EeVu/o0fx6pokfvV0n3nbg5gLdXN1BxfGPFFVDDVHuTT2rTHLA
 swSfzK+zjPQOobrihjBrLpgav+jy7C/8vC+G0a+88X5NcfbYWyedUT9ZfoZukGeRKTIvpPcfP
 JSsDsYaAJuGA5s+gFPwwseffGo+p9BlAOPnpntRC6UxnP7bLeTRt1IdXPfa/sCNxBBPANdG6f
 Q65Cqvi5suv1D2pD0FGqJQ4/coBWIb3/b6LUBP3TP2SNv+TYvg/k3r6d4zLNBXwPOluH0Y/yU
 2KZbfurQXCdy4nb8/qT1j5V1Be7Emqc4vv6yNuNPXHB0kwmhEeUILKKIXKiQjFSLmoZWRVa/H
 NlQVvMyYslPvyStxHdmrs5av4otTqJTe2yIg8PCc9tZA2UNQN+/3zsMuOr7xJGYU7ymJJ9uw6
 Zu6Wj4iehgGK2ODlCyVKTi7wjxuqBIT3+U7Wx2D5cLrK3CjFAcE8RkGcX9uv+VuaivJEVC+mf
 m+YkFO2Cm7Uhg4rAVKzLPO7sEocY61Apbaj+GZszwuvzLh5sOuy/dtRLgqaWLVu/VbnpHbWtI
 q+kPxbHLdWFoYmZUbzlswf38UoswNGWfL85l0f5QQKbNM0W1yYRFMHsqtwP7cQHDDM8uifYx5
 tHQbxLtg746RFJBTN6KiVFrCnu1Ag3aciCfnyKiM0G6QKNLA1+y+djyLkWLTCN7iaRw2LNJGL
 W2ne07WLli9MFgNKAgeSpQ9rLB9cUYnVh78N+p3DeogN/N1mwt5KbSNpXu5WBkxKBvbprZ0Sc
 nb9fwp6w+BdtYOMqugxkK0v/Nbz38QpJwFaEVvtQQcgrZO5ubFEIVd9rKd23MLKOrJS7n4lye
 dyFpSZnYSDo8gWUE8k5pVLdWPkOCylVCLVTvCFn4mgc8MteYQjWlbZNRutak2zptpOU+y3TpH
 YVGDOzrKCWrcyrE3FxLgNlgqPMST2sEgMzBZoc+X03qrvPSMYh/1kAo0jEMlkf55XqoBnHj8b
 m4QvrUfvltTAWRw9D8jc/CKYTsSDCOonxntUg2K/imx5/iBGrIggn7bF8ThZN5p+J9c5KDE9V
 GITZRucvVAUgi4=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/5 03:34, Benjamin Xiao wrote:
> There's definitely still an issue even with the patches. I ended up
> disabling autodefrag again and rebooting my computer after btrfs-cleaner
> wrote about 300-ish GB to my SSD.
>
> The patch does help things out a bit compared to before where it was a
> constant non-stop stream of IO, but 300GB worth of extra writes for 33GB
> of actual data doesn't seem normal.

Have you tried v5.15.x with that diff?

Thanks,
Qu

>
> Ben
>
> On Fri, Feb 4 2022 at 09:36:22 AM -0800, Benjamin Xiao
> <ben.r.xiao@gmail.com> wrote:
>> Okay, I just tested right now with my custom 5.16.5 kernel with your 3
>> patches applied. Redownloading the same game, I noticed that there was
>> significantly less IO load during the download, which is great. It
>> looked kinda bursty instead, with periods of no load, and then periods
>> of load ranging in the 150-200MB/s range.
>>
>> After the download, I am no longer getting that constant 90-150MB/s
>> disk write from btrfs-cleaner, but I am seeing periodic bursts of it
>> every 10 seconds or so. These bursts last for around 3 seconds and
>> load is anywhere from 50-300MB/s.
>>
>> Is this normal? Does autodefrag only defrag newly written data, or
>> does it sometimes go back and run defrag on data written previously? I
>> am gonna let it run for a bit to see if it eventually subsides.
>>
>> Ben
>>
>> On Fri, Feb 4 2022 at 02:20:44 PM +0800, Qu Wenruo
>> <quwenruo.btrfs@gmx.com> wrote:
>>>
>>>
>>> On 2022/2/4 12:32, Benjamin Xiao wrote:
>>>> Okay, I just compiled a custom Arch kernel with your patches applied.
>>>> Will test soon. Besides enabling autodefrag and redownloading a game
>>>> from Steam, what other sorts of tests should I do?
>>>
>>> As long as your workload can trigger the problem reliably, nothing
>>> =7Felse.
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> Ben
>>>>
>>>> On Fri, Feb 4 2022 at 09:54:19 AM +0800, Qu Wenruo
>>>> <quwenruo.btrfs@gmx.com> wrote:
>>>>>
>>>>>
>>>>> On 2022/2/4 09:17, Qu Wenruo wrote:
>>>>>>
>>>>>>
>>>>>> On 2022/2/4 04:05, Benjamin Xiao wrote:
>>>>>>> Hello all,
>>>>>>>
>>>>>>> Even after the defrag patches that landed in 5.16.5, I
>>>>>>> am still =7F=7F=7F=7F=7Fseeing
>>>>>>> lots of cpu usage and disk writes to my SSD when
>>>>>>> autodefrag is =7F=7F=7F=7F=7Fenabled.
>>>>>>> I kinda expected slightly more IO during writes
>>>>>>> compared to 5.15, =7F=7F=7F=7F=7Fbut
>>>>>>> what I am actually seeing is massive amounts of
>>>>>>> btrfs-cleaner i/o =7F=7F=7F=7F=7Feven
>>>>>>> when no programs are actively writing to the disk.
>>>>>>>
>>>>>>> I can reproduce it quite reliably on my 2TB Btrfs Steam library
>>>>>>> partition. In my case, I was downloading Strange
>>>>>>> Brigade, which =7F=7F=7F=7F=7Fis a
>>>>>>> roughly 25GB download and 33.65GB on disk. Somewhere during the
>>>>>>> download, iostat will start reporting disk writes
>>>>>>> around 300 =7F=7F=7F=7F=7FMB/s, even
>>>>>>> though Steam itself reports disk usage of 40-45MB/s.
>>>>>>> After the =7F=7F=7F=7F=7Fdownload
>>>>>>> finishes and nothing else is being written to disk, I
>>>>>>> still see =7F=7F=7F=7F=7Faround
>>>>>>> 90-150MB/s worth of disk writes. Checking in iotop, I
>>>>>>> can see =7F=7F=7F=7F=7Fbtrfs
>>>>>>> cleaner and other btrfs processes writing a lot of data.
>>>>>>>
>>>>>>> I left it running for a while to see if it was just some
>>>>>>> =7F=7F=7F=7F=7Fmaintenance
>>>>>>> tasks that Btrfs needed to do, but it just kept going. I tried to
>>>>>>> reboot, but it actually prevented me from properly
>>>>>>> rebooting. =7F=7F=7F=7F=7FAfter
>>>>>>> systemd timed out, my system finally shutdown.
>>>>>>>
>>>>>>> Here are my mount options:
>>>>>>> rw,relatime,compress-force=3Dzstd:2,ssd,autodefrag,space_cache=3Dv=
2,subvolid=3D5,subvol=3D/
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> Compression, I guess that's the reason.
>>>>>>
>>>>>> =C2=A0From the very beginning, btrfs defrag doesn't handle
>>>>>> compressed =7F=7F=7F=7Fextent
>>>>>> well.
>>>>>>
>>>>>> Even if a compressed extent is already at its maximum
>>>>>> capacity, =7F=7F=7F=7Fbtrfs
>>>>>> will still try to defrag it.
>>>>>>
>>>>>> I believe the behavior is masked by other problems in older
>>>>>> =7F=7F=7F=7Fkernels thus
>>>>>> not that obvious.
>>>>>>
>>>>>> But after rework of defrag in v5.16, this behavior is more exposed.
>>>>>
>>>>> And if possible, please try this diff on v5.15.x, and see if
>>>>> v5.15 =7F=7F=7Fis
>>>>> really doing less IO than v5.16.x.
>>>>>
>>>>> The diff will solve a problem in the old code, where autodefrag is
>>>>> almost not working.
>>>>>
>>>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>>>> index cc61813213d8..f6f2468d4883 100644
>>>>> --- a/fs/btrfs/ioctl.c
>>>>> +++ b/fs/btrfs/ioctl.c
>>>>> @@ -1524,13 +1524,8 @@ int btrfs_defrag_file(struct inode
>>>>> *inode, =7F=7F=7Fstruct
>>>>> file *file,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
ontinue;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (!newer_than) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cluster=
 =3D (PAGE_ALIGN(defrag_end) >>
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PAGE_SHIFT) -=
 i;
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cluster=
 =3D min(cluster, max_cluster);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 } else {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cluster=
 =3D max_cluster;
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 cluster =3D (PAGE_ALIGN(defrag_end) >>
>>>>> PAGE_SHIFT) - =7F=7F=7Fi;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 cluster =3D min(cluster, max_cluster);
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if (i + cluster > ra_index) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
a_index =3D max(i, ra_index);
>>>>>
>>>>>>
>>>>>> There are patches to address the compression related
>>>>>> problem, but =7F=7F=7F=7Fnot
>>>>>> yet merged:
>>>>>>
>>>>>> https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D609=
387
>>>>>>
>>>>>> Mind to test them to see if that's the case?
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>>
>>>>>>>
>>>>>>> I've disabled autodefrag again for now to save my SSD,
>>>>>>> but just =7F=7F=7F=7F=7Fwanted
>>>>>>> to say that there is still an issue. Have the defrag
>>>>>>> issues been =7F=7F=7F=7F=7Ffully
>>>>>>> fixed or are there more patches incoming despite what Reddit and
>>>>>>> Phoronix say? XD
>>>>>>>
>>>>>>> Thanks!
>>>>>>> Ben
>>>>>>>
>>>>>>>
>>>>
>>>>
>>
>>
>
>
