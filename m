Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB4A6A26CB
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Feb 2023 03:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjBYCUN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Feb 2023 21:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBYCUM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Feb 2023 21:20:12 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262833D0BA
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Feb 2023 18:20:09 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3se8-1oWBMo1Y5g-00zqYE; Sat, 25
 Feb 2023 03:20:03 +0100
Message-ID: <7def18b6-3573-0a55-1cf7-bc02e0742b57@gmx.com>
Date:   Sat, 25 Feb 2023 10:19:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: issue discovered by hung_task_timeout_secs?
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230225083600.126A.409509F4@e16-tech.com>
 <b12f8dbc-85d6-ada9-3ff3-d16b2d178911@suse.com>
 <20230225092749.E7CC.409509F4@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230225092749.E7CC.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:6wbZ9pRROWuR9ZgW9PHOENxu0f/pyaavSfWLnz9dmHL959ZZr5N
 Q8Uu1nu1+2e4B8ebn3y/fqpcyAtdhphYaCOpfcZdmT+yAjDxtg/TQero4NeP3TmjKLFqh6F
 MHq+r1hoAxB6QVEZoyzk7SYWJNvydoYxCpSEk6CMzoNXh22N09W8xmdAa3iKWEiCIDSgJol
 XaAIxlOmIqH+42ReP4oUw==
UI-OutboundReport: notjunk:1;M01:P0:tPCYJoH70ng=;N4fJfr5KjuHY3D59e2A4nQXkEvM
 ckIxrIsluemEH5BtfQxW/wvl+AK8dPyIRYiIusJjZRcPuZ75XvElTQ9ab9bC6VEJ4awuv/lN6
 CBg6TztmY9UO4MAkRC2pRWHwFyKpZnpmofjrYsMijJODsvHu0hHKlV/EKfpkdXviMtp1YKLXX
 v0sFkIp0gCSlOqqBhYroSY/YBrp/zn7zR6l0gYJYxnfNZI6jV0xFdXv/fh5cVdYiDSj/nTTi8
 DoZemXf8402Zin6RWE96DvcTACrrB6n8PkiMAlg3aMCHRJEdSP+Ag2WXob2Q2AJTKC3GqTwxx
 Y16Nw1znD7JRjKUBJpeRb+wdPntjdOXCZXLVsMXnObqsElJ/2dI2t9Azs3X87PIrxRSISm9P2
 yWsL5kwjzvJQ4TAJKMTTClV8lUGJsJl5HfeX02aXfmPg+ItBoXNfIPrZyqsCi4P1BRX2lhA/M
 P806xZ8yscdkLD0MnnatpWm3X/kE/4O4YtRvDNYMrfbmSZml3NARhgo3HsmGsiFCSRmWUPY4E
 325i0rOXhkbB+kQXJeHVbHHFPJwHPed6wftk5pGFH8Yk9/BLG7rLsJryla0L9Qntvd6YKPJsC
 QJlRkRzISGcwlEZ3PmAc/nwv2fXCBLzuBwT9oKpr+9V54BmrNBidQxf/NuhsACUh1JsnE6657
 GjY+hQsTcAfafG0khtwj3PVvwhBbyQEaFzsQR1wp8fMIviicwVM+K9/YfrqqRJWQoCDg468Hd
 1IH/YszcH+Pw1X28Uka29V33cYcrzwYph1ymtKxKMMbh0mteo4ooE8133jOIeFjzV//JvCkaG
 n5m78t2NSeG18MFJ0LZMTJ24JRFh7+MBC9BllwlddCdG9BN/BRa12bmsgXoHL05UHA6zz+d9O
 SeUhFqXiQ+unRA6I/usA1/4Swp9I/7b8RWg28TgneS4w3ATeXwvtWBI99RZH7J2xZTJM0vHMh
 Zs9iQf5sDdVF9hvEbU82OR/wTpw=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/25 09:27, Wang Yugui wrote:
> Hi,
> 
> 
>> On 2023/2/25 08:36, Wang Yugui wrote:
>>> Hi,
>>>
>>> The following setting maybe useful to diag the data flush problem inside btrfs.
>>>
>>> # we need SSD for this test case
>>> vm.dirty_expire_centisecs = 200
>>> vm.dirty_writeback_centisecs = 100
>>> kernel.hung_task_timeout_secs=4
>>> kernel.hung_task_all_cpu_backtrace=1
>>>
>>> In fact, only few cases of high load was reported.
>>>
>>> but some case of btrfs-cleaner when low load is reported too.
>>> it maybe an issue inside btrfs, or expected behavor?
>>> [...]
>>> [   59.591229] NMI backtrace for cpu 65
>>> [   59.591232] CPU: 65 PID: 1550 Comm: btrfs-transacti Not tainted 6.1.13-5.el7.x86_64 #1
>>> [   59.591234] Hardware name: Dell Inc. PowerEdge T640/0TWW5Y, BIOS 2.16.1 08/19/2022
>>> [   59.591251] RIP: 0010:btrfs_comp_cpu_keys+0x3f/0x50 [btrfs]
>>> [   59.591300] Code: ff ff 72 26 b8 01 00 00 00 0f b6 4e 08 38 4f 08 77 18 b8 ff ff ff ff 72 11 b8 01 00 00 00 48 8b 4e 09 48 39 4f 09 77 02 19 c0 <c3> cc cc cc cc 66 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
>>> [   59.591301] RSP: 0018:ffffaa169c5f7b10 EFLAGS: 00000206
>>> [   59.591303] RAX: 0000000000000001 RBX: 000000000000001e RCX: ffff8a840ec6f890
>>> [   59.591304] RDX: 00000372db98c000 RSI: ffffaa169c5f7c5e RDI: ffff8a8479adb353
>>> [   59.591305] RBP: 0000000000000020 R08: ffff8a840ec6f850 R09: 0000123804da8000
>>> [   59.591306] R10: 0000000000000001 R11: 0000000000000000 R12: 000000000000001d
>>> [   59.591306] R13: ffff8a8423cfb200 R14: 0000000000000019 R15: ffffaa169c5f7c5e
>>> [   59.591307] FS:  0000000000000000(0000) GS:ffff8ae27fc00000(0000) knlGS:0000000000000000
>>> [   59.591309] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [   59.591310] CR2: 00007fed7e13102c CR3: 000000a269810001 CR4: 00000000007706e0
>>> [   59.591310] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> [   59.591311] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> [   59.591312] PKRU: 55555554
>>> [   59.591313] Call Trace:
>>> [   59.591314]  <TASK>
>>> [   59.591315]  btrfs_generic_bin_search+0xf1/0x160 [btrfs]
>>> [   59.591348]  btrfs_search_slot+0xa38/0xbc0 [btrfs]
>>> [   59.591380]  ? kmem_cache_alloc+0x16b/0x530
>>> [   59.591386]  find_parent_nodes+0xde/0x1280 [btrfs]
>>> [   59.591443]  btrfs_find_all_roots_safe+0xa3/0x160 [btrfs]
>>> [   59.591497]  btrfs_find_all_roots+0x1c/0x80 [btrfs]
>>> [   59.591549]  btrfs_qgroup_account_extents+0xc4/0x270 [btrfs]
>>
>> This is the cause, qgroup.
>>
>> And you mentioned cleaner kthread, are you dropping some large shared snapshots?
>> If so, no wonder.
>>
>> In that case, you'd better config /sys/fs/btrfs/<uuid>/qgroups/drop_subtree_threshold to some lower value, e.g. 3, to prevent the problem.
> 
> the snapshot drop should be triggered by snapper timeline cleanup.
> 
> Could we do some schedule change inside btrfs to slicence it?

Above setting would disable qgroup when dropping such large subvolume, 
thus solve the problem.

No need to bother snapper.

> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2023/02/25
> 
