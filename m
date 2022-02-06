Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F040D4AAE97
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Feb 2022 10:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbiBFJby (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Feb 2022 04:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbiBFJbx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Feb 2022 04:31:53 -0500
X-Greylist: delayed 306 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 01:31:52 PST
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4521EC06173B
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Feb 2022 01:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644139910;
        bh=2qR6Qv3DnlWiTV9ySu1ToY9QCYBN/LVeNMT8wmUVVrk=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=FBv5tEvOSL+r7P7/Xh6GSZlgk93GQQtICxtHYYoQAVbPIhWzsXLz6ejusWPq2jKyd
         S0OrbdzJVhWEWBtsm7pCVyk9zR/XVvjH/gD/NsT1sTYXOKayhPDiVcHB91gEpwnvwj
         3eJa1b0yWad5ThGcS2mo11OAi1on2zCpwbEG6gFM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4Jqb-1nGMpi2tsX-000Hc8; Sun, 06
 Feb 2022 10:26:40 +0100
Message-ID: <61ad0e42-b38a-6b5f-2944-8c78e1508f4a@gmx.com>
Date:   Sun, 6 Feb 2022 17:26:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Still seeing high autodefrag IO with kernel 5.16.5
Content-Language: en-US
To:     Rylee Randall <ibrokemypie@outlook.com>,
        Benjamin Xiao <ben.r.xiao@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <KTVQ6R.R75CGDI04ULO2@gmail.com>
 <9409dc0c-e99d-cc61-757e-727bd54c6ffd@gmx.com>
 <88b6fe3e-8317-8070-cb27-0aee4dc72cfb@gmx.com>
 <SL2P216MB11112B447FB0400149D320C1AC2B9@SL2P216MB1111.KORP216.PROD.OUTLOOK.COM>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <SL2P216MB11112B447FB0400149D320C1AC2B9@SL2P216MB1111.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YxCWghUyCrBZuT3GQNkhv3eYKS8xN7/6KjIcMCYkaaW8sZmAHbi
 hAUZjzqleLDxM9H00nK4d3JM2cRz89YV8jJALpbgR3vDopQwG3TwM/oK2xcF5UDkGxmu/8t
 wTeOwdSsyASblcLXj8Sr5MD++uc5Ri/5miRxeePn8mzfOjhz2W+ADf8b62e6P4D7uQ4Jk+2
 ywRhWqkcT/hRifYMIiiXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5PCJjyrTIfA=:ol+5E8o2n/fA8bl9zvm9CR
 9mw3CyMmBrtWgpBm6Fb3cPto9NIFV40YZWU9FnUGpjZPQSIAWzuq7x8AtNiR8xLgC8U3rrObh
 cRR4WTHS8GIHUzhUQVS8neXLh4VM2d8atE8/E/eYo+ppRwplfU+gA40UC5/VuGtg/4PUwirT+
 AjT+gYFPOEcQFkbkg5XXILs250X6aWrv5sLfvqxnDgBeBtjsn7GxD0xFIdU/g32c3/cUhjXW+
 4nqC2kPj3Yb0yQwpLtAm+ksIsTO2L1ikYYnVq00jSC9aAJO863OTIZdi+h/Pfa7wwDCKRmLBy
 /xiUi8poCK+ikiTEqATYwkYwABFruM2hhej06RzW4p3zMlcZnGS4wjfKBbFL2Vu8jepR/v2pC
 MTeEtubcDksccb5tglB4dGZyfLBRmAd/6801z8yTJPy2qylJUcmAf/jZ+SeYmhxeTGxDox8lL
 QP1eiZLsua88E9ZmvffAqmJzIcdxhJEO+o+DAGHsVxMKxutgShXDPqmmyKbsDD6zXbfOLTvl4
 qyaNKrCQQCoBF+Ut+Is/ULzNG5LbBV7ewPIxzFhJdAiJcw7+0GuPksObvFy7XI+57pq8fJjdD
 BI+HxLbD8oz1C6dtbd+5I1khRNkKpNUNd6yFSxTEzzjRKPXQ/tBlxN6JLZ6Y3yHmGLV7yeIFd
 BTvHics6AbqZNY4Y6SWA2rUyeagodJTjsAJqMpU7Ev2/XeCpRPfsypXIN5VboF1XabLHsXA2x
 YCEYoEg3/vVHuN0ytW6DGP7L0a7fHWlRfsjvYs79A8IFY1haKanHvW1PmpqqTKJX4/0R+bM3m
 deuZ0jjphnT3aQtW03edd/bJZfxNSvVNbConUa7IhjMRF5Ns2r7ZCEMtZUC/NNxChmTnTUdlP
 7yPJTR8PeXOr/5460r4/Ze+5daEYK2IqmbIgoWG4FzvRzrgrYTsNutocNkn2hjAX2J4TRhvxK
 Efc2fosjQiwVZduCyLzz56pt302+1lb598Rmb+rbFk5rmGCRhu0/yPt3fjcdK51Tv1c8ivBQq
 gvFAHixZYieQWkwkTS1y6hUMN6GH2yr6M/ZqtcpBBGzQ/1Ud4fAD9XlXnlF70No4EYjXceILr
 o+z3r37hGCtE3A=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/6 15:51, Rylee Randall wrote:
> I am experiencing the same issue on 5.16.7, near the end of a large
> steam game download btrfs-cleaner sits at the top of iotop, and shut
> downs take about ten minutes because of various btrfs hangs.
>
> I compiled 5.15.21 with the mentioned patch and tried to recreate the
> issue and so far have been unable to. I seem to get far faster an dmore
> consistent write speeds from steam, and rather than btrfs-cleaner being
> the main source of io usage it is steam. btrfs-cleaner is far down the
> list along with various other btrfs- tasks.

Thanks for the report, this indeed looks like the bug in v5.15 that it
doesn't defrag a lot of extents is not the root cause.

Mind to re-check with the following branch?

https://github.com/adam900710/linux/tree/autodefrag_fixes

It has one extra patch to emulate the older behavior of not using
btrfs_get_em(), which can cause quite some problem for autodefrag.

Thanks,
Qu

>
> On 4/2/22 12:54, Qu Wenruo wrote:
>>
>>
>> On 2022/2/4 09:17, Qu Wenruo wrote:
>>>
>>>
>>> On 2022/2/4 04:05, Benjamin Xiao wrote:
>>>> Hello all,
>>>>
>>>> Even after the defrag patches that landed in 5.16.5, I am still seein=
g
>>>> lots of cpu usage and disk writes to my SSD when autodefrag is enable=
d.
>>>> I kinda expected slightly more IO during writes compared to 5.15, but
>>>> what I am actually seeing is massive amounts of btrfs-cleaner i/o eve=
n
>>>> when no programs are actively writing to the disk.
>>>>
>>>> I can reproduce it quite reliably on my 2TB Btrfs Steam library
>>>> partition. In my case, I was downloading Strange Brigade, which is a
>>>> roughly 25GB download and 33.65GB on disk. Somewhere during the
>>>> download, iostat will start reporting disk writes around 300 MB/s, ev=
en
>>>> though Steam itself reports disk usage of 40-45MB/s. After the downlo=
ad
>>>> finishes and nothing else is being written to disk, I still see aroun=
d
>>>> 90-150MB/s worth of disk writes. Checking in iotop, I can see btrfs
>>>> cleaner and other btrfs processes writing a lot of data.
>>>>
>>>> I left it running for a while to see if it was just some maintenance
>>>> tasks that Btrfs needed to do, but it just kept going. I tried to
>>>> reboot, but it actually prevented me from properly rebooting. After
>>>> systemd timed out, my system finally shutdown.
>>>>
>>>> Here are my mount options:
>>>> rw,relatime,compress-force=3Dzstd:2,ssd,autodefrag,space_cache=3Dv2,s=
ubvolid=3D5,subvol=3D/
>>>>
>>>>
>>>
>>> Compression, I guess that's the reason.
>>>
>>> =C2=A0From the very beginning, btrfs defrag doesn't handle compressed =
extent
>>> well.
>>>
>>> Even if a compressed extent is already at its maximum capacity, btrfs
>>> will still try to defrag it.
>>>
>>> I believe the behavior is masked by other problems in older kernels th=
us
>>> not that obvious.
>>>
>>> But after rework of defrag in v5.16, this behavior is more exposed.
>>
>> And if possible, please try this diff on v5.15.x, and see if v5.15 is
>> really doing less IO than v5.16.x.
>>
>> The diff will solve a problem in the old code, where autodefrag is
>> almost not working.
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index cc61813213d8..f6f2468d4883 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -1524,13 +1524,8 @@ int btrfs_defrag_file(struct inode *inode, struc=
t
>> file *file,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cont=
inue;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>>
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (!newer_than) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cluster =
=3D (PAGE_ALIGN(defrag_end) >>
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PAGE_SHIFT) - i;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cluster =
=3D min(cluster, max_cluster);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 } else {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cluster =
=3D max_cluster;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 cluster =3D (PAGE_ALIGN(defrag_end) >> PAGE_SHIFT) - i;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 cluster =3D min(cluster, max_cluster);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (i + cluster > ra_index) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ra_i=
ndex =3D max(i, ra_index);
>>
>>>
>>> There are patches to address the compression related problem, but not
>>> yet merged:
>>>
>>> https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D609387
>>>
>>> Mind to test them to see if that's the case?
>>>
>>> Thanks,
>>> Qu
>>>>
>>>>
>>>> I've disabled autodefrag again for now to save my SSD, but just wante=
d
>>>> to say that there is still an issue. Have the defrag issues been full=
y
>>>> fixed or are there more patches incoming despite what Reddit and
>>>> Phoronix say? XD
>>>>
>>>> Thanks!
>>>> Ben
>>>>
>>>>
