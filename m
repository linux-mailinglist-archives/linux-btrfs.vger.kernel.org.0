Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF404AB10E
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Feb 2022 18:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244367AbiBFRsh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Feb 2022 12:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236478AbiBFRsg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Feb 2022 12:48:36 -0500
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 09:48:35 PST
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38964C06173B
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Feb 2022 09:48:35 -0800 (PST)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcfb-btrfs-devel-moved1-3@m.gmane-mx.org>)
        id 1nGlZT-0009Ud-3f
        for linux-btrfs@vger.kernel.org; Sun, 06 Feb 2022 18:43:31 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-btrfs@vger.kernel.org
From:   Jean-Denis Girard <jd.girard@sysnux.pf>
Subject: Re: Still seeing high autodefrag IO with kernel 5.16.5
Date:   Sun, 6 Feb 2022 07:43:24 -1000
Message-ID: <stp1bs$l94$1@ciao.gmane.io>
References: <KTVQ6R.R75CGDI04ULO2@gmail.com>
 <9409dc0c-e99d-cc61-757e-727bd54c6ffd@gmx.com>
 <88b6fe3e-8317-8070-cb27-0aee4dc72cfb@gmx.com>
 <SL2P216MB11112B447FB0400149D320C1AC2B9@SL2P216MB1111.KORP216.PROD.OUTLOOK.COM>
 <61ad0e42-b38a-6b5f-2944-8c78e1508f4a@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: fr
In-Reply-To: <61ad0e42-b38a-6b5f-2944-8c78e1508f4a@gmx.com>
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi list,

I'm also experiencing high IO with autodefrag on 5.16.6 patched with:
  - https://patchwork.kernel.org/project/linux-btrfs/list/?series=609387,
  - https://patchwork.kernel.org/project/linux-btrfs/list/?series=611509,
  - btrfs-defrag-bring-back-the-old-file-extent-search-behavior.diff.

After about 24 hours uptime, btrfs-cleaner is most of the time at 90 % 
CPU usage

%CPU  %MEM     TIME+ COMMAND
77,6   0,0  29:03.25 btrfs-cleaner
19,1   0,0   3:40.22 kworker/u24:8-btrfs-endio-write
19,1   0,0   1:50.46 kworker/u24:27-btrfs-endio-write
18,4   0,0   4:14.82 kworker/u24:7-btrfs-endio-write
17,4   0,0   4:08.08 kworker/u24:10-events_unbound
17,4   0,0   4:23.41 kworker/u24:9-btrfs-delalloc
15,8   0,0   3:41.21 kworker/u24:3-btrfs-endio-write
15,1   0,0   2:12.61 kworker/u24:26-blkcg_punt_bio
14,8   0,0   3:40.13 kworker/u24:18-btrfs-delalloc
12,8   0,0   3:55.70 kworker/u24:20-btrfs-delalloc
12,5   0,0   4:01.79 kworker/u24:1-btrfs-delalloc
12,2   0,0   4:04.63 kworker/u24:22-btrfs-endio-write
11,5   0,0   1:11.90 kworker/u24:11-btrfs-endio-write
11,2   0,0   1:25.96 kworker/u24:0-blkcg_punt_bio
10,2   0,0   4:24.17 kworker/u24:24+events_unbound
...

Load average is 5,56, 6,88, 6,71 while just writing that mail.

And iostat shows:

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
            1,5%    0,0%   26,8%    6,3%    0,0%   65,4%

       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn 
   kB_dscd Device
  33893,50         0,0k       172,2M        57,8M       0,0k       1,7G 
    577,7M nvme0n1
    169,40         0,0k         1,2M         0,0k       0,0k      12,5M 
      0,0k sda
    178,90         0,0k         1,3M         0,0k       0,0k      12,5M 
      0,0k sdb

I hope that helps.


Thanks,
-- 
Jean-Denis Girard

SysNux                   Systèmes   Linux   en   Polynésie  française
https://www.sysnux.pf/   Tél: +689 40.50.10.40 / GSM: +689 87.797.527


Le 05/02/2022 à 23:26, Qu Wenruo a écrit :
> 
> 
> On 2022/2/6 15:51, Rylee Randall wrote:
>> I am experiencing the same issue on 5.16.7, near the end of a large
>> steam game download btrfs-cleaner sits at the top of iotop, and shut
>> downs take about ten minutes because of various btrfs hangs.
>>
>> I compiled 5.15.21 with the mentioned patch and tried to recreate the
>> issue and so far have been unable to. I seem to get far faster an dmore
>> consistent write speeds from steam, and rather than btrfs-cleaner being
>> the main source of io usage it is steam. btrfs-cleaner is far down the
>> list along with various other btrfs- tasks.
> 
> Thanks for the report, this indeed looks like the bug in v5.15 that it
> doesn't defrag a lot of extents is not the root cause.
> 
> Mind to re-check with the following branch?
> 
> https://github.com/adam900710/linux/tree/autodefrag_fixes
> 
> It has one extra patch to emulate the older behavior of not using
> btrfs_get_em(), which can cause quite some problem for autodefrag.
> 
> Thanks,
> Qu
> 
>>
>> On 4/2/22 12:54, Qu Wenruo wrote:
>>>
>>>
>>> On 2022/2/4 09:17, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2022/2/4 04:05, Benjamin Xiao wrote:
>>>>> Hello all,
>>>>>
>>>>> Even after the defrag patches that landed in 5.16.5, I am still seeing
>>>>> lots of cpu usage and disk writes to my SSD when autodefrag is 
>>>>> enabled.
>>>>> I kinda expected slightly more IO during writes compared to 5.15, but
>>>>> what I am actually seeing is massive amounts of btrfs-cleaner i/o even
>>>>> when no programs are actively writing to the disk.
>>>>>
>>>>> I can reproduce it quite reliably on my 2TB Btrfs Steam library
>>>>> partition. In my case, I was downloading Strange Brigade, which is a
>>>>> roughly 25GB download and 33.65GB on disk. Somewhere during the
>>>>> download, iostat will start reporting disk writes around 300 MB/s, 
>>>>> even
>>>>> though Steam itself reports disk usage of 40-45MB/s. After the 
>>>>> download
>>>>> finishes and nothing else is being written to disk, I still see around
>>>>> 90-150MB/s worth of disk writes. Checking in iotop, I can see btrfs
>>>>> cleaner and other btrfs processes writing a lot of data.
>>>>>
>>>>> I left it running for a while to see if it was just some maintenance
>>>>> tasks that Btrfs needed to do, but it just kept going. I tried to
>>>>> reboot, but it actually prevented me from properly rebooting. After
>>>>> systemd timed out, my system finally shutdown.
>>>>>
>>>>> Here are my mount options:
>>>>> rw,relatime,compress-force=zstd:2,ssd,autodefrag,space_cache=v2,subvolid=5,subvol=/ 
>>>>>
>>>>>
>>>>>
>>>>
>>>> Compression, I guess that's the reason.
>>>>
>>>>  From the very beginning, btrfs defrag doesn't handle compressed extent
>>>> well.
>>>>
>>>> Even if a compressed extent is already at its maximum capacity, btrfs
>>>> will still try to defrag it.
>>>>
>>>> I believe the behavior is masked by other problems in older kernels 
>>>> thus
>>>> not that obvious.
>>>>
>>>> But after rework of defrag in v5.16, this behavior is more exposed.
>>>
>>> And if possible, please try this diff on v5.15.x, and see if v5.15 is
>>> really doing less IO than v5.16.x.
>>>
>>> The diff will solve a problem in the old code, where autodefrag is
>>> almost not working.
>>>
>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>> index cc61813213d8..f6f2468d4883 100644
>>> --- a/fs/btrfs/ioctl.c
>>> +++ b/fs/btrfs/ioctl.c
>>> @@ -1524,13 +1524,8 @@ int btrfs_defrag_file(struct inode *inode, struct
>>> file *file,
>>>                         continue;
>>>                 }
>>>
>>> -               if (!newer_than) {
>>> -                       cluster = (PAGE_ALIGN(defrag_end) >>
>>> -                                  PAGE_SHIFT) - i;
>>> -                       cluster = min(cluster, max_cluster);
>>> -               } else {
>>> -                       cluster = max_cluster;
>>> -               }
>>> +               cluster = (PAGE_ALIGN(defrag_end) >> PAGE_SHIFT) - i;
>>> +               cluster = min(cluster, max_cluster);
>>>
>>>                 if (i + cluster > ra_index) {
>>>                         ra_index = max(i, ra_index);
>>>
>>>>
>>>> There are patches to address the compression related problem, but not
>>>> yet merged:
>>>>
>>>> https://patchwork.kernel.org/project/linux-btrfs/list/?series=609387
>>>>
>>>> Mind to test them to see if that's the case?
>>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>>
>>>>> I've disabled autodefrag again for now to save my SSD, but just wanted
>>>>> to say that there is still an issue. Have the defrag issues been fully
>>>>> fixed or are there more patches incoming despite what Reddit and
>>>>> Phoronix say? XD
>>>>>
>>>>> Thanks!
>>>>> Ben
>>>>>
>>>>>
> 


