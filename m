Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C41E65890E
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Dec 2022 04:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbiL2DGI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Dec 2022 22:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiL2DGG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Dec 2022 22:06:06 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B183C63E9;
        Wed, 28 Dec 2022 19:06:02 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MtfJd-1oqJsT3ZM7-00v3n0; Thu, 29
 Dec 2022 04:05:55 +0100
Message-ID: <9d56a546-ea4f-83cb-4efb-093af270544b@gmx.com>
Date:   Thu, 29 Dec 2022 11:05:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>, dsterba@suse.com,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <CABXGCsNzVxo4iq-tJSGm_kO1UggHXgq6CdcHDL=z5FL4njYXSQ@mail.gmail.com>
 <CABXGCsMMYmCT_Hz=wfKWDy4OQJ2KyBO3rNAFC1YCAthziWm+Lg@mail.gmail.com>
 <41734bdb-2df0-6596-01b6-76a7dfd05d64@gmx.com>
 <CABXGCsM6GOzr+wL9BEk7mD5xLNgsKE5KUBADD8r783V6-FwXdg@mail.gmail.com>
 <e9f4d768-d91b-b5cc-dbe6-041a81833cf3@gmx.com>
 <CABXGCsPK6ZZ4=5qathvjqSJNde6MYhA0uvh6zAMznT9Yj3xk2g@mail.gmail.com>
 <24cd64b2-4536-372c-91af-b425d2f6efd4@gmx.com>
 <CABXGCsOG1GR1QqQSULHRcqJyfo5zY1bkZA+Mkb2m3C=rV_2z2w@mail.gmail.com>
 <ff262ad5-2ae3-329a-ba88-19721850131d@gmx.com>
 <CABXGCsOgy0N_TLEadgacMBQLuU5xBe-hmoRvv4h=q-M5PcPvEg@mail.gmail.com>
 <7d2edc1d-922b-763c-3122-0a6f81c3454e@suse.com>
 <CABXGCsOq56Qjq+-Bnfbe7ZvhfjSs204cbc8VFG7b+J2Ncss0ng@mail.gmail.com>
 <fd0a0bfe-5c67-fd95-b17c-78a14c63bea6@gmx.com>
 <CABXGCsMev+96zixic3=5cLgzMfZKcJE-zOLPrc3-vTrrDZQDig@mail.gmail.com>
 <de8fb932-2934-7ad2-112a-a9a2e63b532d@gmx.com>
 <CABXGCsMN-wviuURYkGXxr_d3BKtW3vyYhQ3Kpd7ZVo-Yr4gBvQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [6.2][regression] after commit
 947a629988f191807d2d22ba63ae18259bb645c5 btrfs volume periodical forced
 switch to readonly after a lot of disk writes
In-Reply-To: <CABXGCsMN-wviuURYkGXxr_d3BKtW3vyYhQ3Kpd7ZVo-Yr4gBvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:C48139QmNLwssfAzBbQOj1vGYGq7X0X5q4ZfCR8qbV8N6cEgVmO
 W6iO93jPmsNMIktPTPQxYcYByTdwbh4nw84ReaDWIdr0945+xqiEZ8e6XBlRv70sAZDRkaM
 sfsH32/0mdrqqqddz8zHNBpv/LqYQp5Q2mBZHfFKB/mI150SI/QmJJZHqa0VNOmMFWr84qY
 6SAm1DQs0GgQqonS9ShLg==
UI-OutboundReport: notjunk:1;M01:P0:+y0CddqR3Lg=;wpvM+eqjVe2cokghf//YUuwhdQ7
 UsXUL4dAv7pR+XRWlPWZc5KBv6Buq12sTRA0LiXvvAKQ3WAKAOjFEPQy9MVnx5whKJi34/PZ3
 qY/9D5blBXJJPGmbnLxkW7buDHNl5kf8Ee0jIVh5BP/g4ILtWjF3+euQkKxlFN99m5KY9no3V
 53jaEmqJhYB3ao8DPfYIc66eBqyIUyz/Cg+LTGelDqrMh+68hMMsEqnfg0yQllc1+rKcDyZ2B
 e5wk/LyMGOTdduTTN+nFniAc8q/ke0+Y9j27vndBTIVTO0qtw/loFjtHAFY75Fl54NcUl2R6u
 UiWb7sQwkYBl7kqQQL1bluBRfBi1+SDcbshimUNme6k9hTOLdk5RsgOKiaSpYYZs6osQqorvy
 N9fc/HdMqcj/9wiLt4wHoZ0kZC2LEDQQbHh6oi/UBuQrN4oifyjFUfAK9zX5IhasvgHS1ZXCI
 uG/9odCXnJkT1ylzOTJtKRRqrx+aSpe5kAz3PPjqOE5cWDOA7V19NE+71/StS8RP3KBPfPO3+
 sZsUGoNmB8rUAanYU9WeGiTnB/cvTpeRqpSYDOrkGMZhietnzdNaCLfHz7Z9hm2zaUqVxFnSy
 u/6vgz9VxVDgIv7KBG70OgBmtA3ihMeYEivM4AqXiHrpKL7ESiYQBQT7a7ND3oTEk/2ufKxli
 JaFyqtVgzSXafD0l5hfYfIzSqA/7CpzgE6m+4x5M70jOnz7fw/IPBWoMVvMjAPNpGbr6WZRc7
 hmmzSG8xDUev4D3BTIQLhkNA5pyHJaKy6YL0iDSdkERO8uix915H53mmRSDndvJ9ySERUVD6H
 C+HpA05IWyLbUBA7vpls1XlX2Bh4zTvssM+LJ6AU4EFnjlhWiFXzijCmCPeDM8YBxTzNY6OdT
 PT7FnrHzHk2YYk8DtZ/kH93g+srZkIOcZurdH+ldkLbgqPHw9b+6R+elSv9BqOORdq74S/C4M
 lqaL1tGdi/FeqxUDUy6eVrH3+pw=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/29 08:08, Mikhail Gavrilov wrote:
> On Thu, Dec 29, 2022 at 4:31 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>> Are you using qgroup? If so it may be worthy trying disabling qgroup.
> 
> I do not use quota.
> And looks like my distro does not use quita by default.
> ❯ btrfs qgroup show -f /
> ERROR: can't list qgroups: quotas not enabled
> 
>> But for newer kernel, qgroup hang should only happen when dropping large
>> snapshot, I don't know if podman pull would cause older snapshots to be
>> deleted...
> 
> It is not a regression, it also happened on older kernels.
> But it is really annoying when the browser process waits when "podman
> pull" writes changes to disk.
> In fact, I have been waiting for 5 years for caching of slow HDDs by
> using the cache on the SSD, but apparently I can’t wait.
> And I started slowly buying expensive large SSDs to replace the big
> HDD. I still can’t find time to connect D5 P5316 30.72 Tb to the
> primary workstation.
> I want to make a video review of it. I understand this is an expensive
> solution and not suitable for everyone, unlike an affordable SDD
> cache.
> 
This is really sad to hear that.

For now, I only have several guesses on how this could happen.

- Extra seeks between metadata and data chunks
   You can try with mixed block groups, but this needs mkfs time tuning.

- Extra inlined extents causing too much metadata overhead
   You can disable inline extents using max_inline=0 as mount options.
   But that only affects newly created files, not the existing ones.

Otherwise, using bcache may be a solution.

For now I'm not aware of any HDD specific tests, other than zoned 
devices, thus the performance problem can be really hard to debug.

Thanks,
Qu
