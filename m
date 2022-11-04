Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E521D618D71
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Nov 2022 02:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiKDBJx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Nov 2022 21:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKDBJw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Nov 2022 21:09:52 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AB31F2E9
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Nov 2022 18:09:51 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N3MsT37dHzJnTb;
        Fri,  4 Nov 2022 09:06:53 +0800 (CST)
Received: from [10.174.176.83] (10.174.176.83) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 09:09:48 +0800
Message-ID: <afae4f17-0b89-ba2d-a57e-8391a0e15562@huawei.com>
Date:   Fri, 4 Nov 2022 09:09:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 1/3] btrfs: Fix wrong check in btrfs_free_dummy_root()
To:     <dsterba@suse.cz>
CC:     <linux-btrfs@vger.kernel.org>, <clm@fb.com>,
        <josef@toxicpanda.com>, <dsterba@suse.com>
References: <20221101025356.1643836-1-zhangxiaoxu5@huawei.com>
 <20221101025356.1643836-2-zhangxiaoxu5@huawei.com>
 <20221103164455.GP5824@twin.jikos.cz>
From:   "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>
In-Reply-To: <20221103164455.GP5824@twin.jikos.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.83]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/4 0:44, David Sterba wrote:
> On Tue, Nov 01, 2022 at 10:53:54AM +0800, Zhang Xiaoxu wrote:
>> The btrfs_alloc_dummy_root() use ERR_PTR as the error return value
>> rather than NULL, if error happened, there will be a null-ptr-deref
>> when free the dummy root:
>>
>>    BUG: KASAN: null-ptr-deref in btrfs_free_dummy_root+0x21/0x50 [btrfs]
>>    Read of size 8 at addr 000000000000002c by task insmod/258926
>>
>>    CPU: 2 PID: 258926 Comm: insmod Tainted: G        W          6.1.0-rc2+ #5
>>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1.fc33 04/01/2014
>>    Call Trace:
>>     <TASK>
>>     dump_stack_lvl+0x34/0x44
>>     kasan_report+0xb7/0x140
>>     kasan_check_range+0x145/0x1a0
>>     btrfs_free_dummy_root+0x21/0x50 [btrfs]
>>     btrfs_test_free_space_cache+0x1a8c/0x1add [btrfs]
>>     btrfs_run_sanity_tests+0x65/0x80 [btrfs]
>>     init_btrfs_fs+0xec/0x154 [btrfs]
>>     do_one_initcall+0x87/0x2a0
>>     do_init_module+0xdf/0x320
>>     load_module+0x3006/0x3390
>>     __do_sys_finit_module+0x113/0x1b0
>>     do_syscall_64+0x35/0x80
>>   entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>
>> Fixes: aaedb55bc08f ("Btrfs: add tests for btrfs_get_extent")
>> Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
> 
> Added to misc-next, thanks. Patches 2 and 3 are dropped as Filipe sent
> the complete fixes in his series.Agreed, thanks David and Filipe.
