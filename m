Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6FF64F587
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Dec 2022 01:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiLQAHg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Dec 2022 19:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLQAHe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Dec 2022 19:07:34 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EB56E9ED
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 16:07:33 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mqb1c-1obj023VgW-00mazA; Sat, 17
 Dec 2022 01:07:27 +0100
Message-ID: <62ec6612-34a9-7b41-e3dc-70441697d594@gmx.com>
Date:   Sat, 17 Dec 2022 08:07:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 0/8] Fixup uninitialized warnings and enable extra checks
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1671221596.git.josef@toxicpanda.com>
 <6e0313f1-fb8d-808a-3489-9bee83990bea@gmx.com>
In-Reply-To: <6e0313f1-fb8d-808a-3489-9bee83990bea@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WbVuE8U3XdSr/LrKxRgRuMFX9JYHcUIFlOd0Tgqw2kT4q77+bJl
 zXh+P2w5FqZoVn3kAwc1OgdlR6ihNrxDCq/3hoIXrizhxNt+9lV2vGiiXBPjFe4ynMlbGat
 AjXYFqm7alItrVZCtUvAH8yeNzlL4EOwfOQG6jzMCJgOdWhXICd7h8PFWk3o7crdG1I9YUv
 fiNXtB5C7lO1Z+4zynO5Q==
UI-OutboundReport: notjunk:1;M01:P0:AGSca2GcKn0=;ykTAo2QZI5KMwc2Oj+w6jhmd4ch
 krJIjFIHAJu6AMrnTvj9DV8lwZo4/sWPFOhcDM8eOpM/ppEVYS/4XQtQNkc2xjmhUL5L/PhqB
 oN2SOr6NhcemyjkAFlt7o2WVPDl8GUlVee2o+EFzZkh4Um2tvJTsjGBGGMjULEfryrpEQ2lgy
 4XzH8FgKlTk5/ZWxqe6g9CtcOsDihDnHto0vZqX6DPNhJ7rJgMRqH20NtOiU6DWt8l8z1FH4N
 KkaQ1VyFsiSHmg+wswkmTZ5AvW+mDFimCYHuiWf6cbMvdNTNhhzDxlfRwim93MuytL6dkhw/R
 Y4bU8Vk+KyiwgDCIyQ7x7ME1k7J4lAYWsRzVLmja4lqX3KPxsCT++uDcpVo0doA7ajT4gO0Ru
 KiSR3dpBwbMst12ayQZdF4//9B/ZofTPT0fmWvYsE4gU49dHLKkPCy60PBrzabTnwsFlROhFT
 vQ1M8g37agIB2D2s3jhvFei84PAflUeSimVtiLTo4GsNcPg4Tnc4xEXkUALXjVLPi2akgep7U
 Hj9MHrhorBl9u+/7KocIDz2TTIQLNJctVDociASuCEbISSH/eFNiu2mCGAs6tLA1fk6KrhyaC
 nDhOC2PIhKcfhdhPSZAZsFF8QYxZLT/t0GbOioryDnjQ0TTQY7hcaL2FeVu/tRsLj50bX0nLa
 SiJ14oFc9YhVSWNosrTB8hgHC/7lDuV64s/dGbpn42Lv2TBFfW0tsUyHN+TJDQ8W7hE59dNJY
 Ja2WH1LmbEBsMcw8z3m2Z+TRpX+yMis525WrzfF5q6cWjRTU4rXu6w0EQpCupOkJPwPIHuFpz
 8BCvhzOCt5gZznotFZxLEmcjmsKAOitjuftdgSafcxYPGjrS+STNqZbgg8KwcaP6VUc3MQrpe
 7HqGzEQ9V05sxfmLcuFuY1tN+QA9jV4F/vU43WwRq+yzlAUnI1/2sNc75/Cyoi4Q1Ygc8HoFK
 hd8hGxWteHXeri8UqeBU4OawZMc=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/17 07:55, Qu Wenruo wrote:
> 
> 
> On 2022/12/17 04:15, Josef Bacik wrote:
>> Hello,
>>
>> We had been failing the raid56 related scrub tests on our overnight 
>> tests since
>> November.  Initially I asked Qu to look into these as I didn't have 
>> time to dig
>> in, and he was unable to reproduce.  I assumed it was some oddity in 
>> my setup,
>> so I ignored it.  However recently I got a report that I regressed 
>> some of these
>> tests with an unrelated change.  When debugging it I found it was 
>> because of an
>> uninitialized return value, which would have been caught by more 
>> modern gcc's
>> with -Wmaybe-uninitialized.
> 
> Any clue which patch is fixing the raid0/raid1 scrub failures?
> 
> As locally, I found my aarch64/x86_64 VMs are all reporting scrub errors 
> for all profiles, including RAID0/RAID1.
> (The failure happens after patch "btrfs: do not check header generation 
> in btrfs_clean_tree_block").
> 
> I didn't notice any of the patches touching the scrub path, or is there 
> some hidden paths involved?

In fact, it's still reproducible reliably here, with all uninitialized 
fixes applied upon "btrfs: do not check header generation in 
btrfs_clean_tree_block".


btrfs/072 30s ... - output mismatch (see 
/home/adam/xfstests/results//btrfs/072.out.bad)
     --- tests/btrfs/072.out	2022-05-11 09:55:30.736666664 +0800
     +++ /home/adam/xfstests/results//btrfs/072.out.bad	2022-12-17 
08:05:26.750000015 +0800
     @@ -1,2 +1,9 @@
      QA output created by 072
      Silence is golden
     +Scrub find errors in "-m dup -d single" test
     +Scrub find errors in "-m raid0 -d raid0" test
     +Scrub find errors in "-m raid0 -d raid0" test
     +Scrub find errors in "-m raid1 -d raid0" test
     +Scrub find errors in "-m raid10 -d raid10" test
     ...
     (Run 'diff -u /home/adam/xfstests/tests/btrfs/072.out 
/home/adam/xfstests/results//btrfs/072.out.bad'  to see the entire diff)
btrfs/074 32s ... - output mismatch (see 
/home/adam/xfstests/results//btrfs/074.out.bad)
     --- tests/btrfs/074.out	2022-05-11 09:55:30.736666664 +0800
     +++ /home/adam/xfstests/results//btrfs/074.out.bad	2022-12-17 
08:06:00.036666681 +0800
     @@ -1,2 +1,3 @@
      QA output created by 074
      Silence is golden
     +Scrub find errors in "-m raid1 -d raid1" test
     ...
     (Run 'diff -u /home/adam/xfstests/tests/btrfs/074.out 
/home/adam/xfstests/results//btrfs/074.out.bad'  to see the entire diff)
Ran: btrfs/072 btrfs/074
Failures: btrfs/072 btrfs/074

Thanks,
Qu

> 
> Thanks,
> Qu
> 
>>
>> In order to avoid these sort of problems in the future lets fix up all 
>> the false
>> positivies that this warning brings, and then enable the option for 
>> btrfs so we
>> can avoid this style of failure in the future.  Thanks,
>>
>> Josef
>>
>> Josef Bacik (8):
>>    btrfs: fix uninit warning in run_one_async_start
>>    btrfs: fix uninit warning in btrfs_cleanup_ordered_extents
>>    btrfs: fix uninit warning from get_inode_gen usage
>>    btrfs: fix uninit warning in btrfs_update_block_group
>>    btrfs: fix uninit warning in __set_extent_bit and convert_extent_bit
>>    btrfs: extract out zone cache usage into it's own helper
>>    btrfs: fix uninit warning in btrfs_sb_log_location
>>    btrfs: turn on -Wmaybe-uninitialized
>>
>>   fs/btrfs/Makefile         |  1 +
>>   fs/btrfs/block-group.c    |  2 +-
>>   fs/btrfs/disk-io.c        |  2 +-
>>   fs/btrfs/extent-io-tree.c |  8 ++---
>>   fs/btrfs/inode.c          |  2 +-
>>   fs/btrfs/send.c           |  8 ++---
>>   fs/btrfs/zoned.c          | 75 ++++++++++++++++++++++++---------------
>>   7 files changed, 57 insertions(+), 41 deletions(-)
>>
