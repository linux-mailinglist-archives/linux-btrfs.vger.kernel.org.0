Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB776A6AFD
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 11:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjCAKnm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Mar 2023 05:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCAKnl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Mar 2023 05:43:41 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4196C222EE
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 02:43:33 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Ma20q-1p1TBP47hE-00W1gc; Wed, 01
 Mar 2023 11:43:24 +0100
Message-ID: <83ff77a0-005c-5ba8-4ec6-8578a922cd5a@gmx.com>
Date:   Wed, 1 Mar 2023 18:43:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [RFC PATCH] btrfs: relocation: add a quick in-replace conversion
 optimization
Content-Language: en-US
To:     Paul Jones <paul@pauljones.id.au>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <4cb0ec4c8bc6b6aa1777c7d4f7ad1f0de975f6a9.1677659834.git.wqu@suse.com>
 <SYCPR01MB4685A69A98C3D3CFEA23038E9EAD9@SYCPR01MB4685.ausprd01.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <SYCPR01MB4685A69A98C3D3CFEA23038E9EAD9@SYCPR01MB4685.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:J0pTZCOCFHroN4bvOeLyxRfgn6tT8zcPgrLOjEWi1F6yTMTWqcl
 dAjiDhH8r9Zj3jLJlo4vse+6tiSsyBnuG7w9BLKJMZPlSBsSIpovLv9MEqI4PHp0wu7ubJS
 SCAcnug2G945JkMTb2bLfZy+UwTSvskP7++QyY4+DFUBAt78BvGJEwbow0Eo11RXo34f23a
 8qUrv/KbLa5MnRS6vi5MQ==
UI-OutboundReport: notjunk:1;M01:P0:cDMx1LPiRRw=;x5J0RO55iWIz8itWrmWYVt/gCCj
 jOCObUxDyzlCFLJJAKXJYvDjtfuLcKG5rx1IivKXW4Ev9brEe1IioaocZzKzpDU0+foHfRYfL
 d4RW5uQ9TbapZ5/KeOkyYdgx7oeT3kMNyxtpIOiyI/KaKV4JVk4pqwvnelCTTU5r3mPNLSFAs
 eiW2yqDDbUb4tyWwh91+lzVFtb4caNPnsy+F7mdiNeH80H5HO7P4zObXeOrykAi0ksdr4WKUJ
 oq/gLuIX3zfYOHhXx+zzGIewrvhQvRX6VvWuq2URSPdVE+NSR+KfItdiTmwvZtjhDdlxJ2BQw
 zjbOkMsj5EkRzcbSbugs7pEqvxbhtIKoyBFsFsqJoSQUrsUAv5/NgGTgVLGJE12Gmwig2DeXz
 tr2U149/ASMVf3bwP3dTbHMHMAUD96S3MhmV7w1wYpCivM9DRAEIejmGq+74jPtPVDaJQ4QtG
 0rws8T2ktVSmcBI4sZQZReAnhEKdbiLcQtDKiVfvvVntgCQszqeeM3DNC4GbkPXhiFOiTOSJV
 F3Olols1vyrrUXgALlysZR6RsMmL1xbTOE4BYpN7XBVxQnloRGxN1/DcRt75J1FtSR5GL9EEQ
 k4ninZs2NL6PQKeZQibJUVPEkUGJIR7Bu9NMql28AWRdd7cxsWZmLGv9cJf+4UuCI3zmLc+Uq
 IXVfBnekyhtHKJXa3maQl+mzdsOi4j37M0E4sN3QuxnwKWsXV47jVWNbZpr0D1XRrx8QanpIh
 asEluqKlJm6iS4I7agLz0TXwNtuojD2mALLhL4wdjX1wo6ocpomgLfPUO0ZWmDOdDbA2Z7AzL
 mqHF0tXzis/8aV+lBpyBkuSXZLyVsmRd6kjRBPzv2w6wPXtTQLkxOvZnNunG9HvYj3oq/2rog
 vG6M05hQKWuMYJtAGBFig7k4rC0YkxEKUlqRcZFQ7ETZs8aYheucczFYZ88wi45Xl9J8X2yhy
 3wrMdHPO0ZCVbivfAwDQw4t+8JU=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/1 18:36, Paul Jones wrote:
> 
>> -----Original Message-----
>> From: Qu Wenruo <wqu@suse.com>
>> Sent: Wednesday, 1 March 2023 7:37 PM
>> To: linux-btrfs@vger.kernel.org
>> Subject: [RFC PATCH] btrfs: relocation: add a quick in-replace conversion
>> optimization
>>
>> [BACKGROUND]
>> There is a recent discuss on why btrfs balanace can not convert
>> RAID1C*/DUP to SINGLE fast.
>>
>> After all, RAID1C* and DUP are just SINGLE duplicated to one or more
>> devices.
>>
>> [ENHANCEMENT]
>> The basic idea is, we don't need to do the IO intensive relocation, but just
>> drop the extra device extents, change the profile to SINGLE, then call it a day.
>>
>> [IMPLEMENTATION]
>> This patch would implement such quick path for conversion.
>>
>> It has the following requirement:
>>
>> - Source block group profile is RAID1C* or DUP
>>    Other profiles are either stripe based (RAID0/RAID10/RAID5/RAID6) or
>>    it's already SINGLE.
>>
>> - Conversion target is SINGLE
>>    In theory, RAID1C4 -> RAID1/RAID1C3/SINGLE is also possible, but
>>    for now let's only allow SINGLE target.
> 
> What about the other way? Ie. SINGLE -> RAID1C* Does that create two new copies or just the extra one on a different device?

That's the ugly part of the whole thing.

Yes, in theory we can go similar way by only coping the data to the new 
copies.

But that would not be any faster than the existing IO intensive relocation.
And it would require a completely new mechanism (more like dev-replace) 
to handle the SINGLE -> RAID1* profiles.

That's also one of the reason I sent out the RFC first, to gather 
feedback on if this RAID1* -> SINGLE makes any sense.

Thanks,
Qu

> 
> Paul.
