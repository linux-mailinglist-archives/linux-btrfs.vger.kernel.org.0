Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B172267B30D
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jan 2023 14:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbjAYNLz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Jan 2023 08:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbjAYNLv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Jan 2023 08:11:51 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2048.outbound.protection.outlook.com [40.107.249.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CB759244;
        Wed, 25 Jan 2023 05:11:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XR6ibwjA/96Rco8CBLCpEhRh/JfeQhoVFnn5MUuqeHSQageZK5vXihNuzM2xxdt6B5InZhjk0HvBsV71Ldzti/KCi+uzWkj3roI1yhTv1sU7bCJ38GklaGyXhfxcLfGq1uZM2DyD+Cp8/luw16f/VFxVvqCKynpcwiS5H3j0Qf4K2gdhIdyY7nFbsdLE+SYdVp6OrIpVfLPr9XRY1w8QhWabscKsjjZbdtL/lcRO4kaDDxktzyKdvpdfnabcPtAYIfdeuT9yrAebgVkwMDIoNoKG5WEwgGpWLVwen53N9dufBMNYizwYkUwgxklJOgigPzbMXwEOWi4rcya1qqn6SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gK58wyWLWo3eJ6pGML2LBA4LZ6uyGBIQBztwMzTaIv8=;
 b=HntW6LydgJHopxvbQOXSiz244XVaN6Lf8dqMhDMx8fvugC3QY5rZzK8ViD2d+xhY0umKEdkM3VNG8F4xXCEDpApZoGemxtIAP/mcjctu3aOVuuykQXhX1d6U8k6qfOAgYewjPGKq2Jj0jC6j3CJfuPqVAcG00DfJaYjA/Mtrw7cKGiR4Hh+iB2jWDJDxgnt16jUcPU+Ul3R7FhO5tff5Ef0I21S0I/9IBoYeg5FKgiiQ92CLxI0NjzKfvLb+F79hAFfbFiyGaBsAgPvyBxd9ztPK3g6HW2x8Tiya89Zi0DEBz7Bk0v2gOQt3Vi4o4pGL7IYb5lcl45rhM7gQzpi5rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gK58wyWLWo3eJ6pGML2LBA4LZ6uyGBIQBztwMzTaIv8=;
 b=LvgO7jM8LxIbi8rarDTsRx7KsCHsLi1lAA5selB9qxa3z69mueTdzY3FroSAp2gsxF81yBCWIZ3wHkIF1fJJQRzPbJOowZPi5LLq5NAiENg9JB/X7qz1qAWDPw3dRnV1pdbkGyHY0kMS7OtmrZotziwdqer/iRpohbpSNJtiU5ainN7K3YGnx4ZNWzcrsIW3/zZF2aunelgrvS9e8LWv9+H+MReRhnkp9FN5Ewmpp1vp+yb769isl2PsxX+rvAkKVDJzCMSYQl6cBe3KWxJRKl56cluSF7Q8sUaYDhoeyaoWXQt15iOcYd5mGkBbR417vrA7IGj0XT5Xqm9xmU0lGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB5383.eurprd04.prod.outlook.com (2603:10a6:20b:97::10)
 by PR3PR04MB7388.eurprd04.prod.outlook.com (2603:10a6:102:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Wed, 25 Jan
 2023 13:11:20 +0000
Received: from AM6PR04MB5383.eurprd04.prod.outlook.com
 ([fe80::96a:7fff:bee7:a6a9]) by AM6PR04MB5383.eurprd04.prod.outlook.com
 ([fe80::96a:7fff:bee7:a6a9%7]) with mapi id 15.20.6002.024; Wed, 25 Jan 2023
 13:11:20 +0000
Message-ID: <a13c50df-ebda-be79-c2c4-63d7018085ad@suse.com>
Date:   Wed, 25 Jan 2023 13:11:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [syzbot] [btrfs?] kernel BUG in btrfs_csum_one_bio
Content-Language: en-US
To:     syzbot <syzbot+d8941552e21eac774778@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, fdmanana@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000dca1ae05f3164d2f@google.com>
From:   Filipe Manana <fdmanana@suse.com>
In-Reply-To: <000000000000dca1ae05f3164d2f@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0243.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:239::11) To AM6PR04MB5383.eurprd04.prod.outlook.com
 (2603:10a6:20b:97::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5383:EE_|PR3PR04MB7388:EE_
X-MS-Office365-Filtering-Correlation-Id: fd45c1ec-1a4d-44d2-b4e6-08dafed5a62a
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tF2yv2USjNnFD65DwbyTjotMwiXdUkDmfcnJYAppgVDXZ78i7ehy6Kx0aR4lcpRj+BJldXBJ/QII04JemFmcgF6MMixRQ+QpqApMZeLfzI7daICwMJwVq4h5vHeyV7aoRbgiMzfW1gBLz6bY0hfhkcsHOMpUnavGkcNwcUxZ/MJBZKYB1vqXvu/V8g7xN4RbJdtsEvlaXW4VhG1HTNKdTgE+dFY+HJpEL1crnr/+rvAfvIWB4LoU68ctOogMdC7pmKVa4sH88rSkdOITnhhVaCqnV94+kB3DYSv8WSl7gr5VF34xZAHWDCcw5OQl6UydF0idugYn0WSVUgjomu+YqGLpkVOdAAuIfRv0M1Ac7AgHhTLQa/dwzJps8uD9oZd6RuWcbSGk18lEnPR/8Ryjizs1w+c7+SnmE1kmXkb0gJ5eRQm8M7FtxYVkEo3xBM2tJR+/yeWTzm6o4QyZInyywo/nqUt6aRH7khyVVOKDGXZ4soJ6+8ZwQAqlAaG/bsLX22VkPaL3BMlK5rGrBjeQmFXuwbeXdvKlm5M2psOuGZXXe4l70Up4KrYMxNVTZD2AKifOC3ucHOXsWI5cPS1svrcJ9V+5QXXpLxaStqAwDVdugBTWlCOEPj5WZPPnw+E2a7KD9hEGXI/CmnZBZKf1c05dlMePc9ovnzzEa62BAidBFca5Rl0PEPpuJxnMFQ1UqFiYayIbgsQug6aYq2ATEhSoE1Jq6MptC0FWdJXoOG9wGmfE3WCAvwb9OP3GiCxoCBNTqLAn2FG2lzqp0n51Eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5383.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199018)(38100700002)(86362001)(31696002)(36756003)(316002)(2906002)(45080400002)(41300700001)(31686004)(66556008)(66476007)(66946007)(8676002)(8936002)(5660300002)(186003)(26005)(6512007)(53546011)(6506007)(2616005)(83380400001)(6486002)(966005)(478600001)(99710200001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1N6bzUrbmxpbVdZOVpaeGUzL3I0QmowSnN3YzJzSklzN0k5bUpXYTd1eWJi?=
 =?utf-8?B?SStNYVFHaTJzY3QwTVpZMmFkL1FYWk9aNzNUSy9aSmdtRzBYZExFU3FtYjAy?=
 =?utf-8?B?RkpPL0xabjJhY0RURi9nc2pSUjBMV1RXQjFjYk50WC9tdk9Ja3d4WmxucjRa?=
 =?utf-8?B?Rk9POEVDQ2R4dXRtakpsa0FBVlpObnNHVnhsTGcrMmZ2Y0puc1ZJaFNENlpT?=
 =?utf-8?B?dHpZR243MFMvNGpzV1B6WjIzRGl5T0xyYjhlbEg2Q2JrYS9iVld2c3BPOFhr?=
 =?utf-8?B?UjB5MEtOdWNJdUxPcElVQm1QTzZCaEcrVWpxQzgwNjE1QitPTGxFV2dXMGR1?=
 =?utf-8?B?cU4rckxtUFJ2RmZKZDZka0VmQ2RuZGpTdnh3enVBam9TV3JDNGp0REdtaTZJ?=
 =?utf-8?B?aE5BelNNWkZSOW1weU1WV0luMkYyMG42VWhyQndRZk1rdWFLeE5WdjBoU2ZT?=
 =?utf-8?B?c2NMMWJPbEFOVlB4dXRGTzFtVnpta2ZRWVQxK29kbnBkc2l4MVpnQW0vbUVa?=
 =?utf-8?B?OEN6VUJCL3duNkpzVERmVllQNG9DMi92RTFvNFVFV2ZON2JYZnRLNElpZ1FP?=
 =?utf-8?B?SXhqSjNCMy9aQlg2U01wMnU5RVNYREo2THRNYTNmVjljUUVuNzN0S2lSaWJ0?=
 =?utf-8?B?ZkRTTDZ3dXNPV3RqZ1dVMWlhcVA4QkEybVZIODdLU2hqdENJQTFqQ2FUZ1JJ?=
 =?utf-8?B?a2RKQkpxRkxrWDBhSDlYM3RPeTg3a0RFeDk4M1U5NUFaZWV2N2RCT2VWMU5F?=
 =?utf-8?B?WXN3T0theVpZSEl6elJnSEpDNFpaSVRCQUtEc29wazhtVVJJWlhma1ppL3Mr?=
 =?utf-8?B?dHN0ZWtxNFlzM01udy8zSHRlQU5PUG56ZUtEdWQxZDhsRjI2eU4zMjBkeDNk?=
 =?utf-8?B?MDkvbHlub0ZCN01nck1zeXhwK09Ib2t6Vk0xOHd4WnRLTVNLaUNtcVN1R1ZY?=
 =?utf-8?B?VFdRanJrSzZyRm1hVU8yZG9jVHNKbEYrUEYyYm4zRjNnbFNNM2hYZkNPSU5M?=
 =?utf-8?B?cmJsN1V3NWxSMHJYdlM1L01QR1dqemF4MmFiVkliM1k5MWd2MERFV1ZxL2or?=
 =?utf-8?B?ZkFQaE8vRUpMdFZ5cTNjTHFzR3JnLzRvdmJLeVYwQm9YZ29nN1pybDdoRnow?=
 =?utf-8?B?c3ZkMlVzYW5iakNRbkZML3dsYlA4MFFoY1dtQ2JpVDBnZHBBcjAreElNcGdq?=
 =?utf-8?B?azVKcEdVOXFHdFJqeFhZR1A1eW5mdEpIaGd3TWdMYUxweU80MmF1dUpIYzNu?=
 =?utf-8?B?eE5MZEMyYklubDhEeW56c2dmWDBGdVpKZUI3cVZkbHZ2dXB0YVZnanoyc2c2?=
 =?utf-8?B?T1locHYyODd2M3pMaDhGLzFuRGg0eEpOSHRIck9xYlIrSml1TVFRK29CcVNi?=
 =?utf-8?B?alh2OVRCZ1NCSW10Y2ErWmZWbWJZOW5lMHVJVEIveEthcmNwZWlqNFBEMEY4?=
 =?utf-8?B?ekVYYzNxMjJlMHI0RG9la1dxY1NkZmE5VENGSFNEdVVQL2hDNFpJS1JrdExh?=
 =?utf-8?B?S0JCSGZ5a0Z5eDlBZEl0ZU9heWdUOGJzVW0zNUt4aFljTlhqOG10UXN4RXpG?=
 =?utf-8?B?ODVJQ3hkYXBXUlJrMG9qa0R4anFVd2lPQStVM0xaR0hUODQvU0JMTVpEdzhZ?=
 =?utf-8?B?dktlNWZsdVMya0hKWmhmb1lBV0w1NVJrR0NOVlQrUUY3U0NCS0Y1TkdDOUFC?=
 =?utf-8?B?dDEvKzBVQlB1Tno5UFpRUWFhbXRuZU1hU2ttTGVnUTFtRGFMOUpxY0tob0Vq?=
 =?utf-8?B?VXhXWU50V2pQN0Y3TnFpMFJSTFB2RkZLNzRNM0F6MkthQldzL2JZR2dsSUI4?=
 =?utf-8?B?aWNmdFhweC8ydk5aVGhQLzFLOXUwWlE3NmllTFNuK285b2NVbUNLc1NLRVF6?=
 =?utf-8?B?cnRCbVhibEYwTWY4QzdNempDMHZ6ZGx2RktnZHorYzRCU1Y1eGlESUduWFdQ?=
 =?utf-8?B?b2lySkVzMlFuV2pKMFZsQkx0WXVTVnVNbmNDZWFGbDRBcm5LdjdKM2s4TjhO?=
 =?utf-8?B?OHpYQ2N3ZXVpdlVJT1psTVlVeGFQZHpzMUpNTDhXeTZ5elRoNFFtZHdHSUlM?=
 =?utf-8?B?RmRUU0RkSWszR3NyQXBnU1ZpM2RJSjdIbzBDOEMwbUg2ZTdEeTV5RnhnSFFy?=
 =?utf-8?Q?4nCxuj8Osp5Us/wspKcXWBNpr?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd45c1ec-1a4d-44d2-b4e6-08dafed5a62a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5383.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 13:11:19.8777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aBAxRIXWHdHm8xcuxOtDPBO8mcES+INGggcUl25wkpav3vKZGY4njL4ox91vK3ydcQ0HtUzFbnRGGu92jc5BiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7388
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 25/01/23 13:06, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f883675bf652 Merge tag 'gpio-fixes-for-v6.2-rc5' of git://..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=114f4b71480000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d24faf5fc10540ae
> dashboard link: https://syzkaller.appspot.com/bug?extid=d8941552e21eac774778
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157373de480000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153fd539480000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a81ede383e7d/disk-f883675b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/510567d86f5c/vmlinux-f883675b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/0fc2746533ba/bzImage-f883675b.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/40fdc0e77810/mount_0.gz
> 
> The issue was bisected to:
> 
> commit 2c8f5e8cdf0f77670b1a9f72156ad4e82ed323d1
> Author: Filipe Manana <fdmanana@suse.com>
> Date:   Fri Nov 11 11:50:27 2022 +0000
> 
>      btrfs: remove leftover setting of EXTENT_UPTODATE state in an inode's io_tree
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14c1e256480000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=16c1e256480000
> console output: https://syzkaller.appspot.com/x/log.txt?x=12c1e256480000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d8941552e21eac774778@syzkaller.appspotmail.com
> Fixes: 2c8f5e8cdf0f ("btrfs: remove leftover setting of EXTENT_UPTODATE state in an inode's io_tree")
> 
> RSP: 002b:00007ffc233556b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f5e11d88ab9
> RDX: 000000000000fea7 RSI: 00000000200001c0 RDI: 0000000000000004
> RBP: 00007ffc233556e0 R08: 0000000000000002 R09: 00007ffc233556f0
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000006
> R13: 00007ffc23355720 R14: 00007ffc23355700 R15: 000000000000000a
>   </TASK>
> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/file-item.c:871!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 5275 Comm: syz-executor267 Not tainted 6.2.0-rc4-syzkaller-00379-gf883675bf652 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
> RIP: 0010:btrfs_csum_one_bio+0x11bd/0x1210 fs/btrfs/file-item.c:871

That's due to a memory allocation failure, kvzalloc() returned NULL.
The bisection is not valid.

Thanks.

> Code: 8b 5c 24 20 e9 85 f2 ff ff e8 0f fa 02 fe 48 c7 c7 e0 88 84 8d 4c 89 f6 48 89 da e8 9d 83 f7 00 e9 4b f0 ff ff e8 f3 f9 02 fe <0f> 0b 44 89 f9 80 e1 07 38 c1 0f 8c 89 fd ff ff be 08 00 00 00 4c
> RSP: 0018:ffffc90004a2f120 EFLAGS: 00010293
> RAX: ffffffff8388e1fd RBX: 0000000000400140 RCX: ffff88801fd43a80
> RDX: 0000000000000000 RSI: 1ffff11003fa8755 RDI: ffff88801fd43aac
> RBP: ffffc90004a2f458 R08: ffffffff81c50a8e R09: 00000000ffffffff
> R10: fffffbfff1a83333 R11: 1ffffffff1a83332 R12: 1ffff1100fba540c
> R13: dffffc0000000000 R14: 000000000000005c R15: 000000000000f000
> FS:  0000555556645300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055a1244ffb38 CR3: 0000000021b63000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   btrfs_submit_data_write_bio+0x339/0x4a0 fs/btrfs/inode.c:2755
>   submit_one_bio+0x353/0x490 fs/btrfs/extent_io.c:158
>   submit_write_bio fs/btrfs/extent_io.c:184 [inline]
>   extent_writepages+0x306/0x540 fs/btrfs/extent_io.c:3212
>   do_writepages+0x3c3/0x680 mm/page-writeback.c:2581
>   filemap_fdatawrite_wbc+0x11e/0x170 mm/filemap.c:388
>   __filemap_fdatawrite_range mm/filemap.c:421 [inline]
>   filemap_fdatawrite_range+0x175/0x200 mm/filemap.c:439
>   btrfs_fdatawrite_range fs/btrfs/file.c:3857 [inline]
>   start_ordered_ops fs/btrfs/file.c:1737 [inline]
>   btrfs_sync_file+0x383/0x1190 fs/btrfs/file.c:1813
>   generic_write_sync include/linux/fs.h:2885 [inline]
>   btrfs_do_write_iter+0xcd3/0x1280 fs/btrfs/file.c:1684
>   call_write_iter include/linux/fs.h:2189 [inline]
>   new_sync_write fs/read_write.c:491 [inline]
>   vfs_write+0x7dc/0xc50 fs/read_write.c:584
>   ksys_write+0x177/0x2a0 fs/read_write.c:637
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f5e11d88ab9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc233556b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f5e11d88ab9
> RDX: 000000000000fea7 RSI: 00000000200001c0 RDI: 0000000000000004
> RBP: 00007ffc233556e0 R08: 0000000000000002 R09: 00007ffc233556f0
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000006
> R13: 00007ffc23355720 R14: 00007ffc23355700 R15: 000000000000000a
>   </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:btrfs_csum_one_bio+0x11bd/0x1210 fs/btrfs/file-item.c:871
> Code: 8b 5c 24 20 e9 85 f2 ff ff e8 0f fa 02 fe 48 c7 c7 e0 88 84 8d 4c 89 f6 48 89 da e8 9d 83 f7 00 e9 4b f0 ff ff e8 f3 f9 02 fe <0f> 0b 44 89 f9 80 e1 07 38 c1 0f 8c 89 fd ff ff be 08 00 00 00 4c
> RSP: 0018:ffffc90004a2f120 EFLAGS: 00010293
> RAX: ffffffff8388e1fd RBX: 0000000000400140 RCX: ffff88801fd43a80
> RDX: 0000000000000000 RSI: 1ffff11003fa8755 RDI: ffff88801fd43aac
> RBP: ffffc90004a2f458 R08: ffffffff81c50a8e R09: 00000000ffffffff
> R10: fffffbfff1a83333 R11: 1ffffffff1a83332 R12: 1ffff1100fba540c
> R13: dffffc0000000000 R14: 000000000000005c R15: 000000000000f000
> FS:  0000555556645300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055cbc1e980c8 CR3: 0000000021b63000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
