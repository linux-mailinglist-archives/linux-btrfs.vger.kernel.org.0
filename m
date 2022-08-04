Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4291589F6C
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Aug 2022 18:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbiHDQbC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Aug 2022 12:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbiHDQbB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Aug 2022 12:31:01 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140105.outbound.protection.outlook.com [40.107.14.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E05272D;
        Thu,  4 Aug 2022 09:30:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKOuR9UcuXqCu3Q3qEEbcKkCFtvJ9cPjfs8HtLQWo7Btr+XYLfalHbvS19YYA3kNkL+RZteSW1Q4UFpUC9x5FdZ0qCGYuGFqQ/VkTEVNIICn1ecn3lr7KPEpJXPhjaQArQ17Yb4dDpjCdC0H5C2sV1MD9GG+Ne/u6QRm6/pBpJHTu4mc1pMyIPNyORALBGGqRNZJ7drBNuROHNI837M19UBkjWaXLThW4GD2b1HPJx3kNe3LJsPdwCMZ7Oij3m5EBFIueQJuKj0bJdQn9H5+Qq3Et+4ANXl+a+4pZdfB1utcF6yvdc79Tji4aUVTIQLk+2i0L1TaDScv52Yed8FVaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tokvOwhxPpEOUtjYDiq2d+CntuxsiMbe7SGev0ldasg=;
 b=KWlsOA9QVV7sMTj9aVsgAHaJ9SrdvcKa2gq4bo83BZuAOKpv51hWREIc37491JvqxhtSmWP8rG1h0c7dbcaFGXxucssjoheCbYjUdhurwMoq/dt4C0HYXgd66SSGXesLRAGjPMNiFEpVUjObKUT2XlF9uA6NJhNADr+eb6ZDCkovQD94vvz9LBWZHZRrcGiDUB4rJeCIIMlp7KGVqKjCjwNo0yi6Gz/godDzFXWwM9qhVHkYWeuAtQm3yUabiuPID1JZZW8bTeT4lVkDZI1aj5J3stSzrewANkHwAKC70CrjwJJZ4GiOI2xAePCYShK8yQUs52LpOJoeVvYtxsJxxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tokvOwhxPpEOUtjYDiq2d+CntuxsiMbe7SGev0ldasg=;
 b=lZ+etAwvZPTUY/pePNj2S0QdVrY5vtWx/QreMbacvE3y99A47+jmJYjLdFeubcA+fFCRL8P1c/okbxeghhxwAkeMhcQ6Pa1v3tXhRa9Jha6s01S2F7LRNysVGXXZG8YuOshK0yL9sRJw04DMPXbJbipyxShH1oIGXoomRRschsMFSimih3JAIBgZgDicKK0t87mok/m57pt2XbrGtKNX1yDQsWjyf3WHiYHyp1u6RyJlAEYJ6/nv4g0Z9hmOVvwHWTew0BcNcEslHTWQzSt2ZrTLCSugSIm4Tfruf/fu9GD8loTOFLKLGmW3VtoAhiXFHMxCo+CudFNt6lNi6bOSjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by PAXPR08MB7060.eurprd08.prod.outlook.com (2603:10a6:102:1df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 16:30:55 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::d94a:b37f:a70b:3c53]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::d94a:b37f:a70b:3c53%6]) with mapi id 15.20.5482.016; Thu, 4 Aug 2022
 16:30:55 +0000
Message-ID: <21dd32c6-f1f9-f44a-466a-e18fdc6788a7@virtuozzo.com>
Date:   Thu, 4 Aug 2022 19:30:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Chen Liang-Chun <featherclc@gmail.com>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        kernel@openvz.org,
        Dominique MARTINET <dominique.martinet@atmark-techno.com>,
        Yu Kuai <yukuai3@huawei.com>, Theodore Ts'o <tytso@mit.edu>
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: fiemap is slow on btrfs on files with multiple extents
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0751.eurprd06.prod.outlook.com
 (2603:10a6:20b:484::6) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b635fa31-71e1-471f-0d03-08da7636b45f
X-MS-TrafficTypeDiagnostic: PAXPR08MB7060:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RU2jC1COlehWhjN6Ru2u/WOXK1uW8HyYaNRLak54UKPXgDu9+O2KIdLvZX3dtS3YbvHcO4HqMoO9M9CNTihMRalheFJsadFpDfg9GQ+YK9Phu2TayLOE1ZoDR0wqrQ8skjXhKc7utnApUP6FbykdJxqvx9UkMXYV5l+ktV7rcpUWOQtZpdqrv8X2Eg5Wby6SB+OIWSTo2773wHpvm9Jp0cMtyHtfjlAgEyQuknjACy9ELwtjuED5cZdPGwSAU08SQOXkoX8sO7l6HehoVJzSYIzvXNoQ4Yl9WWkIAOkJcoo56zgJUrQXj+15OR+j8PBT4tWlqS9Zz7B1jTRlVK9lZ2Pbunf+t7LduHmE/JI1HPBZr/m5PBhsNKZM5DcfQfEdR6nbFhObjh/pqwiGJMVzn64parwXV6HKCsD4QEfnftN7k6kEXh2oUjxa9R0xh8Kp/sMFKfk4KJIAS5+Ygj9o71Jp8XUS7a0vPUWRXxDJMxEYvyFi2KuX2qHBmOFeQhHEiUh88Ljt+Je7CQvlCf+Oo1teyGZnPup8Uuu/kGLgIw2/Hoyfo9ZD/vNz0QKJfWS6lcKSbDAy72GRmDOX+GiT92DFE7i8/7xumQelgYknDOO/2zMtkeVUUgTKGTXtLfmj687zayjhos3U9tJLVPvaS7hCGodNJ48rHqkM+T9BtlF+ax/mJg0H3X12OjCp2DtGztIpoZics3VBiy++oI4x8m0O6jqbFqlYF+Vq6Abba5xtd/Q5TWu5cX7ImCnvrJ4yaOXpRZKcGrX12CrY1Bq41MDGHighRWgfeuFACJSdfxNBOCVog93Nd0bk3E+trnn6oGREBpm1W4nMxoEodjNdYZiGdEgd45x8L8rFvpAdBcY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(39850400004)(346002)(376002)(38100700002)(6666004)(54906003)(86362001)(110136005)(83380400001)(316002)(31696002)(186003)(6512007)(36756003)(31686004)(66946007)(66556008)(6486002)(5660300002)(6506007)(8676002)(4326008)(66476007)(2906002)(26005)(41300700001)(2616005)(8936002)(478600001)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a01FZ09DWFZYanlINzBDaldnNm9JdE5jcFh3dXp6Zmw0WGhrSHhMUzFFU21p?=
 =?utf-8?B?dG5FaXYrU04rU1RkQzErV2xOZEZZQlBUWkhxc25ONHFJTDdqYjZRQ3ZscTdq?=
 =?utf-8?B?aXR2Z2E4bmZRYy91VFZBYkFRWWNpRmN6bjY2SkRYMHl0QTRSeFZYM0FXakxC?=
 =?utf-8?B?U3BRR01lRFBEbzlVSjljcE55V3F3TXIvRUJZNXloTDVicE5ieUFsL0J6Wmxr?=
 =?utf-8?B?Ti9JT1dJNmh6aGExWFVOSnFGdG50SGNWZFVKVko5ZVpJbzJybXNyUHczSXpM?=
 =?utf-8?B?NG9Da1RubXd2aFVkVndFbmowZ3R1QVczc004enpyVUFuNnd0bTRQV2lmdzNV?=
 =?utf-8?B?cEVWS3dlaW5rOVV6eGQwNEl1T0d0TldaL0Voc3dTdE04NGFPeFhGZy9OK0Fq?=
 =?utf-8?B?M0FRMjdwWHNQWWErcGNzRnUzRnZoZDFqZXBySU8wSnl4dnNTSXhIZzVrVG51?=
 =?utf-8?B?THpPZUlSUndMVmRnY3ZLSUtJaWNLSUU4dklKWjduYi9URVFXdXR2bCtHNzYz?=
 =?utf-8?B?VXRpaEVOc1JwbXN0NGxvY2R0R2F1eTFmRXRRRFFlYThDbE0rN1Q4aHNzU3Nm?=
 =?utf-8?B?RkxmWEhUNW9Lc2NaK2VWQ3hzbmEwaGFaR01qSVdNVlByVE5aY3p3SVZuL1NL?=
 =?utf-8?B?R0pEUFF1a0xEZ29EM3MyZ1V6NG5Ib1pGb0p6YlQzLzRrcDJNd0VFTmRDWkFo?=
 =?utf-8?B?eVhjcjhnR1gwQ3huaTcwOHNldDRFTW9waEFZSTZnWW5JK29WbzFCQXV4V0dG?=
 =?utf-8?B?bUFGTWdzbzZZalpyM1Z4UVdPcCtJYmN2Q1RRZCtHWDVGdVRjcXBsTmk4RTdz?=
 =?utf-8?B?NGdCeENTZHpnQW5lazF5Z0R3M2kwSWtxRGVpV2FBZjRsaFk1YmpGdzUvRi9X?=
 =?utf-8?B?Y25BVnVlNGNYbW1tR2xsaXRqYU12T3Fsc3crTW9vaFlpZi9Yc2dHMWptUU9P?=
 =?utf-8?B?UTBXYVQxam9oNGxvNkhXbFhGekVaclBpRWMxaDdRcFdiN3UvcVF2emRvalpa?=
 =?utf-8?B?OS9ISHkrRWV1ZDUvOVhrSHpVTlNia2pqUnpVMkNUUEJQMG9jQi9aME12K01m?=
 =?utf-8?B?ZzdhZ1NDdkNXU202d0xRV0I1d3cvYWJFWVhwc21DdThZYnp3NkpmclBSSDEw?=
 =?utf-8?B?UlhzYzg4TnNPcDlZWDFvdHkrcjBGNThlZjlQZDViWWJHV1lpUzBrM3NDelZz?=
 =?utf-8?B?Rk1ocm5OdGFmS0hUQVk3ZXhBRExXMzhWOTRwR1piclYrdm9MYm4rL2ZzaFgv?=
 =?utf-8?B?bEhZanRLaGlsUmJXVkhBdExIRkRUVnJRS1l2dXJ4eDFzQTRoUVFqN1VnYnZn?=
 =?utf-8?B?c1Jnd2VWcmY1QmRaV1lvZVFMOG8yZHNXL0FLZDFkUXFabXd5ekxzODdTTHV3?=
 =?utf-8?B?b1VZTStpdFJmaVNWVDlvV2VQOHh1Q1kvYXp4V2VQUDlaWnlWUW1iZEU3aEE4?=
 =?utf-8?B?T05QMDM2MUZQY0J4Y1g2OHQxbXNrQW1VSEEzZDBjeWw5RmdMNjlnTk1zRGt2?=
 =?utf-8?B?RHR6cGV0VCt2REhJSGRoMW9FQkxUcVZTVFBUbXhacmVycFQ2ckIrNGt3VmVy?=
 =?utf-8?B?TWpWdWZvMjl3MkgrNkhHZFNUUWI3S1k5T2hJZGo1L21qSUlpZ3dlWGw0aWhR?=
 =?utf-8?B?bHhYQUZKS21NZGFhUTQ5ODNrYU1DTUhDV3RjZmNwd081Sm1iZlNLR2M2SEhI?=
 =?utf-8?B?RUkxZXZTWGE3cUVzeWJwTndyVzJjUG5Xay9NOXJXT2V5elJJVXlHZVo1NG1J?=
 =?utf-8?B?QkJ2RjFxcUIrRkI2aDNsN3hmY0wzay9yNjBVTXB3WHVLVU0xYk1xclJqTGVk?=
 =?utf-8?B?dFd1TXhmNUwrM2tpUGJabjJaY1YyeW5JRVJhSjcwQlhiK2c4NnlTRS9pY0FW?=
 =?utf-8?B?YWlpTFMvSktwS0s4UW5ZZ0lzNlFlVzhVamNMYVJ3MHZnbEhGWDJuSmE0VDBt?=
 =?utf-8?B?MUdCL2Era0hxdXBYQW00L3BBdGhVU1JJUS90UDd6R2NLamg0L0RmWllqY3NQ?=
 =?utf-8?B?Q0JQSW5XTzBnczhwclY5VXRxQm1Xd0doMHJLdUlZL2p4N1BoVHZwZ2dyck5T?=
 =?utf-8?B?MVJUWDhXTnltSjRKY05QTVQ4R1IxUTFPeEQrbXJlTHZ5ZVI2TWZDNlc4a0tQ?=
 =?utf-8?B?UW8vWlE1TDN6aWVXd1hOZHdHMzJhY3RkQm5KODcrVUJzQ2c5UTNyTmlDeHVx?=
 =?utf-8?B?YXc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b635fa31-71e1-471f-0d03-08da7636b45f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 16:30:55.4036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OtGR2VtQB9hNplX2K+RW2KeIlgPYOy0YRJ5A291XdRBapoCIMxYZyi5zZEP07kG55h+rx/fR4nqiDLuWrwSY8kEaBS5Wgf6e8q6Y2a18ypE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7060
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I ran the below test on Fedora 36 (the test basically creates "very" 
sparse file, with 4k data followed by 4k hole again and again for the 
specified length and uses fiemap to count extents in this file) and face 
the problem that fiemap hangs for too long (for instance comparing to 
ext4 version). Fiemap with 32768 extents takes ~37264 us and with 65536 
extents it takes ~34123954 us, which is x1000 times more when file only 
increased twice the size:

256Mb:

./fiemap-reproduce /testfile $((1<<28))
size: 268435456
actual size: 134217728
fiemap: fm_mapped_extents = 32768
time = 37264 us

./fiemap-reproduce /testfile $((1<<28))
size: 268435456
actual size: 134217728
fiemap: fm_mapped_extents = 32768
time = 37285 us

512Mb:

./fiemap-reproduce /testfile $((1<<29))
size: 536870912
actual size: 268435456
fiemap: fm_mapped_extents = 65536
time = 34123954 us

./fiemap-reproduce /testfile $((1<<29))
size: 536870912
actual size: 268435456
fiemap: fm_mapped_extents = 65536
time = 60404334 us

1Gb (the whole Fedora hangs sometimes when I measure it):

./fiemap-reproduce /testfile $((1<<30))
size: 1073741824
actual size: 536870912
fiemap: fm_mapped_extents = 131072
time = 231194793 us

./fiemap-reproduce /testfile $((1<<30))
size: 1073741824
actual size: 536870912
fiemap: fm_mapped_extents = 131072
time = 347867789 us

I see a similar problem here 
https://lore.kernel.org/linux-btrfs/Yr4nEoNLkXPKcOBi@atmark-techno.com/#r , 
but in my case I have "5.18.6-200.fc36.x86_64" fedora kernel which does 
not have 5ccc944dce3d ("filemap: Correct the conditions for marking a 
folio as accessed") commit, so it should be something else.

Some more info:

cat /proc/self/mountinfo | grep btrfs
106 1 0:47 /root / rw,relatime shared:1 - btrfs /dev/nvme0n1p3 
rw,compress=zstd:1,ssd,space_cache,subvolid=257,subvol=/root

perf top -ag
Samples: 268K of event 'cycles', 4000 Hz, Event count (approx.): 
77250404934 lost: 0/0 drop: 0/0
   Children      Self  Shared Object                       Symbol
+   74,25%     1,16%  [kernel]                            [k] 
entry_SYSCALL_64_after_hwframe
+   73,14%     0,65%  [kernel]                            [k] do_syscall_64
+   53,05%     3,30%  libc.so.6                           [.] __poll
+   39,53%     0,76%  [kernel]                            [k] __x64_sys_poll
+   34,91%     6,44%  [kernel]                            [k] do_sys_poll
+   29,37%     0,00%  [kernel]                            [k] 
__x64_sys_ioctl
+   29,08%     7,65%  [kernel]                            [k] 
count_range_bits
+   28,44%     0,00%  [kernel]                            [k] do_vfs_ioctl
+   28,43%     0,00%  [kernel]                            [k] extent_fiemap
+   28,43%     0,00%  [kernel]                            [k] 
btrfs_get_extent_fiemap
+   27,87%     0,00%  libc.so.6                           [.] __GI___ioctl
+   25,89%     0,00%  [kernel]                            [k] 
get_extent_skip_holes
+   21,76%    21,29%  [kernel]                            [k] rb_next
+    9,50%     0,48%  [kernel]                            [k] perf_poll
+    8,04%     0,00%  libc.so.6                           [.] 
__libc_start_call_main
+    6,93%     3,26%  [kernel]                            [k] 
select_estimate_accuracy
+    6,69%     2,15%  [kernel]                            [k] ktime_get_ts64
+    5,60%     3,99%  [kernel]                            [k] 
_raw_spin_lock_irqsave
+    5,16%     0,40%  [kernel]                            [k] poll_freewait

Here is a fiemap-reproduce.c code:

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>

#include <sys/stat.h>
#include <sys/time.h>
#include <sys/ioctl.h>

#include <linux/fs.h>
#include <linux/fiemap.h>

#define FILE_INTERVAL (1<<13) /* 8Kb */

long long interval(struct timeval t1, struct timeval t2)
{
         long long val = 0;
         val += (t2.tv_usec - t1.tv_usec);
         val += (t2.tv_sec - t1.tv_sec) * 1000 * 1000;
         return val;
}

int main(int argc, char **argv) {
         struct fiemap fiemap = {};
         struct timeval t1, t2;
         char data = 'a';
         struct stat st;
         int fd, off, file_size = FILE_INTERVAL;

         if (argc != 3 && argc != 2) {
                 printf("usage: %s <path> [size]\n", argv[0]);
                 return 1;
         }

         if (argc == 3)
                 file_size = atoi(argv[2]);
         if (file_size < FILE_INTERVAL)
                 file_size = FILE_INTERVAL;
         file_size -= file_size % FILE_INTERVAL;

         fd = open(argv[1], O_RDWR | O_CREAT | O_TRUNC, 0644);
         if (fd < 0) {
                 perror("open");
                 return 1;
         }

         for (off = 0; off < file_size; off += FILE_INTERVAL) {
                 if (pwrite(fd, &data, 1, off) != 1) {
                         perror("pwrite");
                         close(fd);
                         return 1;
                 }
         }

         if (ftruncate(fd, file_size)) {
                 perror("ftruncate");
                 close(fd);
                 return 1;
         }

         if (fstat(fd, &st) < 0) {
                 perror("fstat");
                 close(fd);
                 return 1;
         }

         printf("size: %ld\n", st.st_size);
         printf("actual size: %ld\n", st.st_blocks * 512);

         fiemap.fm_length = FIEMAP_MAX_OFFSET;
         gettimeofday(&t1, NULL);
         if (ioctl(fd, FS_IOC_FIEMAP, &fiemap) < 0) {
                 perror("fiemap");
                 close(fd);
                 return 1;
         }
         gettimeofday(&t2, NULL);

         printf("fiemap: fm_mapped_extents = %d\n", 
fiemap.fm_mapped_extents);
         printf("time = %lld us\n", interval(t1, t2));

         close(fd);
         return 0;
}

-- 
Best regards, Tikhomirov Pavel
Software Developer, Virtuozzo.
