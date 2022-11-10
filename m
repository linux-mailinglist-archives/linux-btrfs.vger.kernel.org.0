Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51877624E78
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 00:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiKJXb6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Nov 2022 18:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiKJXb5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Nov 2022 18:31:57 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DD549B68;
        Thu, 10 Nov 2022 15:31:56 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8XU1-1p6B8a0nHF-014VMQ; Fri, 11
 Nov 2022 00:31:30 +0100
Message-ID: <48ac1a74-6349-ccf5-92ef-2189037122b8@gmx.com>
Date:   Fri, 11 Nov 2022 07:31:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] btrfs: qgroup: fix sleep from invalid context bug in
 update_qgroup_limit_item()
Content-Language: en-US
To:     dsterba@suse.cz, ChenXiaoSong <chenxiaosong2@huawei.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, zhangxiaoxu5@huawei.com
References: <20221110141342.2129475-1-chenxiaosong2@huawei.com>
 <20221110205436.GJ5824@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221110205436.GJ5824@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:4oCQ3HhMBayFOLppa1woHkyiYxsDNghBUDJexb3pxECSW3EXyva
 gVka90317DNKpFBd+JXF4CiSdJ+rEYNLr6riZ208vsPAcYAzfm4C75CSVF4n/Z0lvcaEqCh
 TXGU3Tlo8VpbtLfeYETjU45RCKqr41mpl1U8+lRvXjxdIspz/bf5S43d4a+qy3ByfDAr//0
 Y/0y/zv3rXQm3xLntpkZQ==
UI-OutboundReport: notjunk:1;M01:P0:NuTL+cAbFYU=;hJgHW4JcOvLOG7wP133Ss71eP1k
 KgMDOWrv1/n4Zdfg5TkuDrzskod08rizKgti47UdtKVHanjI77qhYokUcEfifl2UGeji3wJbH
 ZLD3SukPODEWNmQYpLYz9C4uwQ16M6QMCulVKvXoBlXi6IkkdRPuVIa/4OCDWTVKFxRmnvd1i
 5/Kdf2OkUuxvniWxdJoSIhA+DtVJYxRQtTrMuBuqk5ClggUzcz81im0KQKzVKlDj8D3zHG/S2
 jF74ZZ1JUpoonyplus7CpJtySO7w7AjZ/XF9L1tBaVPkW6uWjxuo85L5qIaE6AnjzNfKgWiUA
 cSjMT67NqpaRlGu4pw4JuOrkGLLkdizsUZhUojUbZEHCzjM4OFRQctwS7o/b7A7lx7yf52jGK
 A8kOAmO764qgtuRACqGMfg2YsWA7N65RG5mza80sqtKaUXh+eqx0qaqmpNL0vyyo8OjN2RSZf
 u/B36cJGqVTzd9B+Rkqf4aFDwBg4LUm5RMBh5ky/L6famRUu/8GPXB+2dX2WdVrpTlBrXBqKS
 9PNj/e3qp7pV6UhMO+SxFGBnhrZPk2Lm7aeCEyIkFjyRAsKv1wv4xYttvsaUfy0WhzVdl0Ptn
 I9q+oNW2QXrzgkqc6ihfB6+XKYIXi+Ned2gxJJ7uFpZEXDbBe30zn6TSR/CGPKuYe42w5ddf7
 GC+XTP0ZKlxP5uIJuiUzCulQFSdNh+JKUj8PX8uyqJJLoUU5BomIt+BHqXH0Wddkh4dxLqXIh
 xcQtjTPb0uFYgplgcs5+YceGYDeY84S+XzESL3nJXvR5i/y3+yWi0UXaCZx5q11ih2hl+Qt6h
 LYb46WPAqKFTJsrRemcnNkvlxDhsovBINJWZhP49Bteq54bpqTziDrUeJdTi8jVB9zI97C1OX
 hDDmanqxnx4bONN1mwTmbu+TVFQYO+28w96NUfpEX4PYDpW8DZzY2bODldwBhOVF20CeIOgv4
 KIgWRRsjzbsDJxE8xa7i32LsNf8=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/11 04:54, David Sterba wrote:
> On Thu, Nov 10, 2022 at 10:13:42PM +0800, ChenXiaoSong wrote:
>> Syzkaller reported BUG as follows:
>>
>>    BUG: sleeping function called from invalid context at
>>         include/linux/sched/mm.h:274
>>    Call Trace:
>>     <TASK>
>>     dump_stack_lvl+0xcd/0x134
>>     __might_resched.cold+0x222/0x26b
>>     kmem_cache_alloc+0x2e7/0x3c0
>>     update_qgroup_limit_item+0xe1/0x390
>>     btrfs_qgroup_inherit+0x147b/0x1ee0
>>     create_subvol+0x4eb/0x1710
>>     btrfs_mksubvol+0xfe5/0x13f0
>>     __btrfs_ioctl_snap_create+0x2b0/0x430
>>     btrfs_ioctl_snap_create_v2+0x25a/0x520
>>     btrfs_ioctl+0x2a1c/0x5ce0
>>     __x64_sys_ioctl+0x193/0x200
>>     do_syscall_64+0x35/0x80
>>
>> Fix this by introducing __update_qgroup_limit_item() helper, allocate
>> memory outside of the spin lock.
>>
>> Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
> 
> Added to misc-next, thanks.

Please remove it for now, the patch only addressed what MM layer 
reports, it doesn't really solve the root cause, we're doing a tree 
modification (btrfs_search_slot()), under a spinlock.

I'm pretty sure there will be a v2 version to properly fix it.

Thanks,
Qu
> 
>> +	path = btrfs_alloc_path();
> 
> btrfs_alloc_path uses fixed GFP_NOFS flags for kmem_cache_alloc but that
> does not try to detect if it could sleep or not.
