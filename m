Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020464AA02D
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 20:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbiBDTeo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 14:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbiBDTeo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 14:34:44 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DB6C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 11:34:44 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id k17so6050999plk.0
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Feb 2022 11:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=XR6Y+3jjYUGRmnewKpbrsCkM7f5pb2RRhZHYXjKLmu8=;
        b=WOk8RwHBuo2Qtt7uhd6WP35SKYDRWMrZYST3EUvYRKBhhRwOlGEXP0LKhsRQk94ME6
         E2CdEZQvJD5twUFT72VWyizATWL+NTh62dJIKqvWxmQK4KUjtFco7Dg7V6NJwgucxidO
         OvyscQP1/9TT6a9zbov7NMNBX2Szj0MNu2b/pzlDP/mqpLVLpy90BNn7i7ooDQOzCl97
         TVybA33qmtqtXiVwVm9g2JiGWaJ9srBIXmIyc4vhIHR/gCEnXsr8Z7NBaept5s8U+Bzx
         h2dhIpE6+TYqBKJ1/IenUniQrYrZzIunnBaq4QYDvxb+MeH/uDBErvLsITTJryvQD2RH
         RdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=XR6Y+3jjYUGRmnewKpbrsCkM7f5pb2RRhZHYXjKLmu8=;
        b=eahW66yedjGZoJ12ekCWbXU6t1CzbU13Zub0V0gWs1qzCaN2G/9aw6649U5x7huNcK
         WRDZfGq6DYu+mljxNqBf5QJGh70FtJsWTE9Vxf/qXB3tTyybchAMkKd2r0BSdnO2W7Yi
         h9XSb1t/LCz+DRgaO7q4DvMH945gGn+YnehaQTvs1kKk5n/9atK2ay4gnVzPtWG810nR
         0pSZPKqLBjv5ctEfgEZrF5GYRkF/AuHSQlrpZ8HgLzxG3JXS3gJ67pHr1MWOmScMQz7I
         Ya7FTaZA2rzZhlIXkOkWxq6n66UltZJJagnKpTl0Vhr8fH1guvERxyA9v+HwYOMi/BOL
         VrmQ==
X-Gm-Message-State: AOAM5327+V4LdyOUy+cQiTIEGzT3zLuuvqwt5R0WDRvFgCSQEwdqYqqg
        kWRzPmwtlrWTMTS0qCmoFHn3OHYFjl8=
X-Google-Smtp-Source: ABdhPJzoHzFCNsZ+ku5Br5OktAyJs0HJGYaeR1Xb50AtaxQWnHBLxmOQ/thnYO0YzXzkoSxm/Hd9Cw==
X-Received: by 2002:a17:902:f682:: with SMTP id l2mr4727798plg.114.1644003283358;
        Fri, 04 Feb 2022 11:34:43 -0800 (PST)
Received: from [192.168.1.223] ([47.151.162.98])
        by smtp.gmail.com with ESMTPSA id t9sm13451189pjg.44.2022.02.04.11.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 11:34:42 -0800 (PST)
Date:   Fri, 04 Feb 2022 11:34:36 -0800
From:   Benjamin Xiao <ben.r.xiao@gmail.com>
Subject: Re: Still seeing high autodefrag IO with kernel 5.16.5
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Message-Id: <O1PS6R.R1VLYNSP0TUR@gmail.com>
In-Reply-To: <MKJS6R.H0H9NI558A0Q2@gmail.com>
References: <KTVQ6R.R75CGDI04ULO2@gmail.com>
        <9409dc0c-e99d-cc61-757e-727bd54c6ffd@gmx.com>
        <88b6fe3e-8317-8070-cb27-0aee4dc72cfb@gmx.com>
        <5AJR6R.7DWSX2SE14RN3@gmail.com>
        <2d78b264-5a12-c7ba-21c4-26a56ef54101@gmx.com>
        <MKJS6R.H0H9NI558A0Q2@gmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's definitely still an issue even with the patches. I ended up 
disabling autodefrag again and rebooting my computer after 
btrfs-cleaner wrote about 300-ish GB to my SSD.

The patch does help things out a bit compared to before where it was a 
constant non-stop stream of IO, but 300GB worth of extra writes for 
33GB of actual data doesn't seem normal.

Ben

On Fri, Feb 4 2022 at 09:36:22 AM -0800, Benjamin Xiao 
<ben.r.xiao@gmail.com> wrote:
> Okay, I just tested right now with my custom 5.16.5 kernel with your 
> 3 patches applied. Redownloading the same game, I noticed that there 
> was significantly less IO load during the download, which is great. 
> It looked kinda bursty instead, with periods of no load, and then 
> periods of load ranging in the 150-200MB/s range.
> 
> After the download, I am no longer getting that constant 90-150MB/s 
> disk write from btrfs-cleaner, but I am seeing periodic bursts of it 
> every 10 seconds or so. These bursts last for around 3 seconds and 
> load is anywhere from 50-300MB/s.
> 
> Is this normal? Does autodefrag only defrag newly written data, or 
> does it sometimes go back and run defrag on data written previously? 
> I am gonna let it run for a bit to see if it eventually subsides.
> 
> Ben
> 
> On Fri, Feb 4 2022 at 02:20:44 PM +0800, Qu Wenruo 
> <quwenruo.btrfs@gmx.com> wrote:
>> 
>> 
>> On 2022/2/4 12:32, Benjamin Xiao wrote:
>>> Okay, I just compiled a custom Arch kernel with your patches 
>>> applied.
>>> Will test soon. Besides enabling autodefrag and redownloading a game
>>> from Steam, what other sorts of tests should I do?
>> 
>> As long as your workload can trigger the problem reliably, nothing 
>> else.
>> 
>> Thanks,
>> Qu
>> 
>>> 
>>> Ben
>>> 
>>> On Fri, Feb 4 2022 at 09:54:19 AM +0800, Qu Wenruo
>>> <quwenruo.btrfs@gmx.com> wrote:
>>>> 
>>>> 
>>>> On 2022/2/4 09:17, Qu Wenruo wrote:
>>>>> 
>>>>> 
>>>>> On 2022/2/4 04:05, Benjamin Xiao wrote:
>>>>>> Hello all,
>>>>>> 
>>>>>> Even after the defrag patches that landed in 5.16.5, I am still 
>>>>>> seeing
>>>>>> lots of cpu usage and disk writes to my SSD when autodefrag is 
>>>>>> enabled.
>>>>>> I kinda expected slightly more IO during writes compared to 
>>>>>> 5.15, but
>>>>>> what I am actually seeing is massive amounts of btrfs-cleaner 
>>>>>> i/o even
>>>>>> when no programs are actively writing to the disk.
>>>>>> 
>>>>>> I can reproduce it quite reliably on my 2TB Btrfs Steam library
>>>>>> partition. In my case, I was downloading Strange Brigade, which 
>>>>>> is a
>>>>>> roughly 25GB download and 33.65GB on disk. Somewhere during the
>>>>>> download, iostat will start reporting disk writes around 300 
>>>>>> MB/s, even
>>>>>> though Steam itself reports disk usage of 40-45MB/s. After the 
>>>>>> download
>>>>>> finishes and nothing else is being written to disk, I still see 
>>>>>> around
>>>>>> 90-150MB/s worth of disk writes. Checking in iotop, I can see 
>>>>>> btrfs
>>>>>> cleaner and other btrfs processes writing a lot of data.
>>>>>> 
>>>>>> I left it running for a while to see if it was just some 
>>>>>> maintenance
>>>>>> tasks that Btrfs needed to do, but it just kept going. I tried to
>>>>>> reboot, but it actually prevented me from properly rebooting. 
>>>>>> After
>>>>>> systemd timed out, my system finally shutdown.
>>>>>> 
>>>>>> Here are my mount options:
>>>>>> rw,relatime,compress-force=zstd:2,ssd,autodefrag,space_cache=v2,subvolid=5,subvol=/
>>>>>> 
>>>>>> 
>>>>> 
>>>>> Compression, I guess that's the reason.
>>>>> 
>>>>>  From the very beginning, btrfs defrag doesn't handle compressed 
>>>>> extent
>>>>> well.
>>>>> 
>>>>> Even if a compressed extent is already at its maximum capacity, 
>>>>> btrfs
>>>>> will still try to defrag it.
>>>>> 
>>>>> I believe the behavior is masked by other problems in older 
>>>>> kernels thus
>>>>> not that obvious.
>>>>> 
>>>>> But after rework of defrag in v5.16, this behavior is more 
>>>>> exposed.
>>>> 
>>>> And if possible, please try this diff on v5.15.x, and see if v5.15 
>>>> is
>>>> really doing less IO than v5.16.x.
>>>> 
>>>> The diff will solve a problem in the old code, where autodefrag is
>>>> almost not working.
>>>> 
>>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>>> index cc61813213d8..f6f2468d4883 100644
>>>> --- a/fs/btrfs/ioctl.c
>>>> +++ b/fs/btrfs/ioctl.c
>>>> @@ -1524,13 +1524,8 @@ int btrfs_defrag_file(struct inode *inode, 
>>>> struct
>>>> file *file,
>>>>                         continue;
>>>>                 }
>>>> 
>>>> -               if (!newer_than) {
>>>> -                       cluster = (PAGE_ALIGN(defrag_end) >>
>>>> -                                  PAGE_SHIFT) - i;
>>>> -                       cluster = min(cluster, max_cluster);
>>>> -               } else {
>>>> -                       cluster = max_cluster;
>>>> -               }
>>>> +               cluster = (PAGE_ALIGN(defrag_end) >> PAGE_SHIFT) - 
>>>> i;
>>>> +               cluster = min(cluster, max_cluster);
>>>> 
>>>>                 if (i + cluster > ra_index) {
>>>>                         ra_index = max(i, ra_index);
>>>> 
>>>>> 
>>>>> There are patches to address the compression related problem, but 
>>>>> not
>>>>> yet merged:
>>>>> 
>>>>> https://patchwork.kernel.org/project/linux-btrfs/list/?series=609387
>>>>> 
>>>>> Mind to test them to see if that's the case?
>>>>> 
>>>>> Thanks,
>>>>> Qu
>>>>>> 
>>>>>> 
>>>>>> I've disabled autodefrag again for now to save my SSD, but just 
>>>>>> wanted
>>>>>> to say that there is still an issue. Have the defrag issues been 
>>>>>> fully
>>>>>> fixed or are there more patches incoming despite what Reddit and
>>>>>> Phoronix say? XD
>>>>>> 
>>>>>> Thanks!
>>>>>> Ben
>>>>>> 
>>>>>> 
>>> 
>>> 
> 
> 


