Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56215624E35
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 00:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiKJXFf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Nov 2022 18:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKJXFd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Nov 2022 18:05:33 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF5A1DA41
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 15:05:31 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mg6dy-1pU0Kk1SoQ-00hc61; Fri, 11
 Nov 2022 00:05:29 +0100
Message-ID: <798c8be3-5f9a-d74d-cf69-1e8991663327@gmx.com>
Date:   Fri, 11 Nov 2022 07:05:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <0cb5e2dcb02a3f6f8f7ec1f42543d146bed31b51.1667956749.git.wqu@suse.com>
 <20221110193950.GI5824@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: raid56: debug: verify all the pointers for
 generate_pq_vertical()
In-Reply-To: <20221110193950.GI5824@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NRrew8mPWlIGZyjSHiqLGNTPEtmm339j4zcGcDYoQMNP6WZUew8
 1lrBaeRw6s6gu/qafZPwpFdSejHzHVIoABYcQTGlLren3RqHMu5eDwY3FnK9YZh+nUUKtYO
 OkADa78ccs2l+GiYc13Bh+DARV/0vxnshTAlefWhd2olyyQuGmFM2A6P2HJfZrF0Mf1TPeg
 v5hmQA7abgDk1wFIwZR2g==
UI-OutboundReport: notjunk:1;M01:P0:xYxZT6TwBoU=;u25itdmSQIKrk9pBfe99bekWiN+
 L90NaoLRP8tanpyRPXhr5sH3NVsqSCZ/6bKhqzqF30hLCToOVX94Q4h/p+RVVPU6vTYJXVVha
 WgRjHN8z/lTJOuzWQZkl5bsWVMsHWLIt3CEth5xp0umtaHsQmtV549bdNCUSPchj8o+pKlZyI
 mcp5x3fBF4vTdD9YY0BN2jNTjvvzXxVr0wu4V1TOMmfU8kRt9Frb9E3flBVZccPk/YIYBEwNo
 3/zkPuQVo/5dqjMjmeXBOELM7lGHXDZxBLxRaTqfUlYjYIrfmpbNNpdg1bBOY66K5LkDD4c0f
 WmSAF5KHnxHVAGMn5d11bJ6jthRuBUFtUqyKqqTe9laZyqBUIHEof7HpXHm+1yJencQYHMGKt
 SypYxr7wzC7BpkSevWESac8tq63+HoqHGFKq9FA1b8hIayvGdXAliQxJuBTKRcUYOR1rEaLLG
 0KtxHYkpCx9B0GezmV5uevbGMhGf4CtlOzhnBsu0gqGAST3UFIHLQOc178HJAr03lKQZwK0ne
 LNDNidmGdBkB7qXltdgY2qih9TalZoRZ/zZlzzIb6uRbjA4hGuYH5i6GpDT1e/GFdR3GZxIUD
 /uya17BszmDVMoHPHy8ZLAv/ZzhFp+IXVDdOUbZd5QO7nxxv10sCbbLxMJIDBtOkGyPVvxWDM
 xIe6Caeikf4+EuS7zkOdHRR6LKqnXJvnlVoIFfWeEiRfYDgFkRHjqT0KhsK9hA5zcTWMCi1kt
 396PYnDnvuvt5Ef1mEprRtrLZIwUYUdhI5/FMTL9+5X1YNZJIYdH5HMg++aK8TSl7cyYnBEr1
 m/wsG3KqXhIY95ReZTLG+vNAbBOS/YusYZH2uRwIkESUAKlSGnTrhF14mU/M75WBDWOU/Sh6h
 RVRuasJnp1VHK0EykqO41AOq04I3n15prWhd3VFv6f07LY6poZazi6ctPmIkJiHLC8rt4xwA7
 Udp+o1xM4ZTvJQgIErJewPyRllA=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/11 03:39, David Sterba wrote:
> On Wed, Nov 09, 2022 at 09:19:10AM +0800, Qu Wenruo wrote:
>> David reported a KASAN error that raid6 gen_syndrome() is accessing
>> beyond slab boundary:
> 
> With this patch I've hit something else. With KASAN and SLUB debug
> there are some hints (stack traces at the end) that this could be
> related to repair.
> 
> Full trace:
[...]
> [ 2424.855661]
> [ 2424.856109] Allocated by task 8:
> [ 2424.856874]  kasan_save_stack+0x1c/0x40
> [ 2424.859469]  kasan_set_track+0x21/0x30
> [ 2424.869220]  __kasan_kmalloc+0x86/0x90
> [ 2424.870549]  alloc_rbio+0xb6/0x470 [btrfs]
> 
> This is ok, normal path for a request
> 
> [ 2424.872604]  raid56_parity_alloc_scrub_rbio+0x3b/0x1e0 [btrfs]
> [ 2424.873580]  scrub_parity_check_and_repair+0x25a/0x300 [btrfs]
> [ 2424.874701]  scrub_block_put+0x275/0x2f0 [btrfs]
> [ 2424.875598]  scrub_bio_end_io_worker+0xed/0x4d0 [btrfs]
> [ 2424.876507]  process_one_work+0x557/0x9d0
> [ 2424.877663]  worker_thread+0x8f/0x630
> [ 2424.878618]  kthread+0x146/0x180
> [ 2424.879153]  ret_from_fork+0x1f/0x30
> [ 2424.880146]
> [ 2424.880669] Freed by task 4823:
> [ 2424.881638]  kasan_save_stack+0x1c/0x40
> [ 2424.882744]  kasan_set_track+0x21/0x30
> [ 2424.883718]  kasan_save_free_info+0x2a/0x40
> [ 2424.884663]  ____kasan_slab_free+0x1b7/0x210
> [ 2424.885746]  __kmem_cache_free+0xc7/0x1b0
> [ 2424.886816]  rbio_orig_end_io+0x9d/0x110 [btrfs]
> 
> Freed in end io - perhaps too early
> 
> [ 2424.888108]  scrub_rbio_work_locked+0x440/0x1310 [btrfs]

I'm very interested in the code line number of this frame.

The 0x440/0x1310 doesn't really match the scrub_rbio_work_locked(), 
which calls rbio_orig_end_io() at the end of it.

Even if the scrub_rbio() is inlined (which should be pretty obvious), 
scrub_rbio() should not call rbio_orig_end_io() at all.
As now rbio_orig_end_io() only gets called in the *_work_locked() and 
*work() helpers.

Thus I'm not sure why it shows something in the middle of the scrub 
function.

> [ 2424.889493]  process_one_work+0x557/0x9d0
> [ 2424.890343]  worker_thread+0x8f/0x630
> [ 2424.891246]  kthread+0x146/0x180
> [ 2424.892070]  ret_from_fork+0x1f/0x30
> [ 2424.893235]
> [ 2424.893708] Last potentially related work creation:
> [ 2424.895204]  kasan_save_stack+0x1c/0x40
> [ 2424.897723]  __kasan_record_aux_stack+0x100/0x110
> [ 2424.899102]  insert_work+0x32/0x150
> [ 2424.900714]  __queue_work+0x2f6/0x790
> [ 2424.901589]  queue_work_on+0x70/0x80
> [ 2424.902360]  scrub_parity_check_and_repair+0x283/0x300 [btrfs]
> 
> This is speculative, but I don't have any other idea. A repair request
> took longer to process, meanwhile the endio freed it. This would be a
> problem with reference counts and with in-flight bio tracking.

Yeah, that's possible, and that's why I have submitted another debug 
patch to change the endio behavior to be more in line with md-raid or 
the old btrfs raid code:

https://patchwork.kernel.org/project/linux-btrfs/patch/20221109233938.9969-1-wqu@suse.com/

> 
> [ 2424.903491]  scrub_block_put+0x275/0x2f0 [btrfs]
> [ 2424.904789]  scrub_bio_end_io_worker+0xed/0x4d0 [btrfs]
> [ 2424.905671]  process_one_work+0x557/0x9d0
> [ 2424.907220]  worker_thread+0x8f/0x630
> [ 2424.908146]  kthread+0x146/0x180
> [ 2424.909055]  ret_from_fork+0x1f/0x30
> [ 2424.909826]
> [ 2424.910264] The buggy address belongs to the object at ffff8881073a4400
> [ 2424.910264]  which belongs to the cache kmallo... .c-512 of size 512
> [ 2424.912849] The buggy address is located 264 bytes inside of
> [ 2424.912849]  512-byte region [ffff8881073a4400, ffff8881073a4600)
> [ 2424.915502]
> [ 2424.916459] The buggy address belongs to the physical page:
> [ 2424.918064] page:ffff88813efce800 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1073a0
> [ 2424.920130] head:ffff88813efce800 order:3 compound_mapcount:0 compound_pincount:0
> [ 2424.921915] flags: 0x4100000010200(slab|head|section=32|zone=2)
> [ 2424.924317] raw: 0004100000010200 ffff88813ef9d408 ffff88813ef01a08 ffff888100042f40
> [ 2424.925278] raw: 0000000000000000 0000000000150015 00000001ffffffff 0000000000000000
> [ 2424.926207] page dumped because: kasan: bad access detected
> [ 2424.926807]
> [ 2424.927084] Memory state around the buggy address:
> [ 2424.927625]  ffff8881073a4400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [ 2424.928419]  ffff8881073a4480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [ 2424.930274] >ffff8881073a4500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [ 2424.931902]                       ^
> [ 2424.932686]  ffff8881073a4580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [ 2424.934224]  ffff8881073a4600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [ 2424.935717] ==================================================================
> 
>> This patch is a mostly debugging one, including the following changes:
>>
>> - Try to access the beginning and end of a sector
>>    To make sure we have correct sector assembled.
>>
>> - Avoid "pointers[stripe++]" usage
>>    This is super common question for every C language learner, but for
>>    real practice usage, it should be avoided, as it takes reader extra
>>    seconds to consider when the value really get increased.
>>
>>    Instead let's use rbio->nr_data to grab P/Q stripe number.
> 
> I don't see anything related to the added debugging, so the pointers are
> probably OK.

That's a good thing, and we can drop this debug patch for good.

Thanks,
Qu

> 
>> And to no one's surprise, I can not reproduce it even with the debug
>> patch.
> 
> I've hit this on 2nd run, the KASAN increases the run time but it's
> bearable.
