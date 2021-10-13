Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C03442BFBC
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 14:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhJMMUh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 08:20:37 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:35284 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229715AbhJMMUg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 08:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1634127511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pL9JHhjbXSPRaBzwLbz08kWaac6XPakEDKA3eI69YnA=;
        b=RkIJiTzJI0VgJgdX6pTExVkZPLSxbX+38bmtTd9reagI5WcRdVdsfWUPqXnjGhF1K3B00c
        Zg25ATgJZ+7Q5I2p/UHzYcuoJcHQfZ3+PsMubOca6IsR+gFbgILJvvl0Nf2uDaxZJ2+29y
        vtEJI3mvX8ArUw/8om9qYb2cX12u0L0=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2052.outbound.protection.outlook.com [104.47.13.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-30-QrKTc1ZwNwOpJYVDeL-I0g-2; Wed, 13 Oct 2021 14:18:31 +0200
X-MC-Unique: QrKTc1ZwNwOpJYVDeL-I0g-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCeDRMnKwcIIlt7pTHDw1jFjcHuryTAeCfGJ5835pYPpj9OgIzIw/r7W39A/VE9JaMdpRPPQ9kH3Gr8v2ZdJva6mJ1tiWhRP4/anpGPCsM2dfLj6wXtVDiTaGd2CkMvMbS7Zw4R1AMPj16iY5ah1U8prbxJlJePF6evlXVEcu61RoKNX4wLmpGbzCVXmj07hH0J6zzIa5MbKYg7nPopr4mBQX8CWpvLxZTKmGymOMSo8N332TFznyXZpFfpcRAIBi3qaxVmkr/SmJlucvIk24wpwmSaRKagBk/tlY5X+LP0vqcU8K6v0YKWJzO56dF2FrtUEGJJ8HTqjzBLvga7tOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pL9JHhjbXSPRaBzwLbz08kWaac6XPakEDKA3eI69YnA=;
 b=HZb1oSN6IJ39OU/VSN9CJxd7kvh3Ocq0A3sKrFfBMrx72dS4OJn/RVLOhw1EnrJnEyITmYDaUg6J2I8VCo4GM4nOCfe2Mz2MFDNUab/4UkbkPCUpHBiPCsluQj/kfgbnEzZI7Gw4IggSCn7VLqUNugTGPlvgJG948BismX7n9AKr/9/q3rclwGljkiOXmiNgPNrNla6XQfRhnPq7jM3EOzPAGzilTl6QQjR9drlZxN64nH0s3ba5j+uHrFaeEhmJ0Qz8zIPXsnvIlIfnQIlaOA6MX4yHsrtofS8RL/c0BwgcPSkb6DjMR0My2nCm4OIT4wPx4cTLIo4IvmP0zWoscQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: colorremedies.com; dkim=none (message not signed)
 header.d=none;colorremedies.com; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB4279.eurprd04.prod.outlook.com (2603:10a6:209:4a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Wed, 13 Oct
 2021 12:18:28 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::2d84:325b:5918:7a19]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::2d84:325b:5918:7a19%5]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 12:18:28 +0000
Message-ID: <e18c983f-b197-4fc5-8030-cc4273eda881@suse.com>
Date:   Wed, 13 Oct 2021 20:18:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
Content-Language: en-US
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <da57d024-e125-bcea-7ac3-4e596e5341a2@suse.com>
 <debf9d63-0068-84db-dcd4-1d923742f989@gmx.com>
 <CAJCQCtSsLSwtNTrUKq_4Rs0tauT45iSA1+AkGWnS9Nmkb=0oWg@mail.gmail.com>
 <9b153cca-2d9a-e217-a83f-1a8e663fc587@suse.com>
 <CAJCQCtTAHmvwmypAgnLVr-wmuJpOxnmXzpxy-UdHcHO8L+5THw@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <CAJCQCtTAHmvwmypAgnLVr-wmuJpOxnmXzpxy-UdHcHO8L+5THw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::29) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by BYAPR02CA0016.namprd02.prod.outlook.com (2603:10b6:a02:ee::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 12:18:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78cc3623-0b13-40e6-8fe6-08d98e439005
X-MS-TrafficTypeDiagnostic: AM6PR04MB4279:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB427928AF2EDA6CCC8246AE30D6B79@AM6PR04MB4279.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: //UEcJ8KGJv6XXe7ILc5txGiB9Mm9rUbZdDpPX/h6o4TIM+zxBChrAKFcoOxAknuG+07kbmdEDElngcBMQqkebZOwlb/tVFzLN6ijKppSoLgbQOIcKk0Ca7eVRAYLUAokbpllT5AgTRpk/RStU8wFQSYpqtwUlFFcuA2TArzt4O4924f14K5t84p/gSjwIrnGcYXog0tMrhaL4pNWIMMLFwln1E1zXk2vox5ZWKs8OYp0FjEb17Hbe1v9JyREst74cg8lPkn2DkJfhMFj7ba+Igka9qq/pymRU2DLdVoizJKwpfU4qXNuZ5+LMtwZII7xqIWgkX2DDTHOUAtXy5lkhuvvHIib63oCbPJi0Cm8nYoDl2EnmYdCGwx3F3ufetBNEMWe53F/oPEXF8MehFSPZFJGCg0YEO7Ylcaddk5juGiXaEklNQKsq2tcq++uGaisq6aoACvF6xXP9uBDJO6JRFch1QhAVmphbQ/SuFCJrnJE4nmZA0StKaFlpNsz96YuOBRojlz9rKxbFJTsYSXPjv01QfVgLiCsF+KvgF0b8BLMXnXVwMHHC4DMAQ8Q6dj20Xb5Qrri9vSb6zaZKOewbTDdFs0nS7q54BzphS3aej9TyuRkSPmjMZDxoIJS744uGyV2+XUsYxZiueYyFGvD+1djKeeLE9kV9y+T0vEHnndA6STxxkcR/XeL/YLhdEBdXmjsWzgqa6cp5qaShsUjsWxydg3Mr+88rkEO68Nr0dh2FZ6Wo6VExZYhTgQxHLC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(54906003)(2616005)(26005)(53546011)(6706004)(86362001)(5660300002)(956004)(186003)(36756003)(6916009)(16576012)(316002)(31696002)(8936002)(4326008)(6486002)(2906002)(66476007)(6666004)(66556008)(66946007)(8676002)(83380400001)(31686004)(4744005)(38100700002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVJqZmU0bU1NK2tQeVpCWUREV3lQNUFEYWtiNzhLVm1Odi9STDB0R3EzVGxV?=
 =?utf-8?B?MlhZc3Vqb0k3RGRkamlzWndHZ1hGM044RDMwOS9uUlpJVy9jMzl4VmlvSzBD?=
 =?utf-8?B?TElsRnlTWWhqVVJuWnJlMjBmWFpyVWlmb0FadWVmRWdSMGN1bktKeURHV2NS?=
 =?utf-8?B?T0FXRi9tM0V4NThEWkNFVnlkenNuc2I5cE9UbEg0SysxbHdRRE5DL0kxdDJh?=
 =?utf-8?B?MFFZTzJOMHkrT2NSSFg2VlI2bEVnWXN0VzRBRkVZcE5HQ1gzcmxqYVpnRE1S?=
 =?utf-8?B?ZHdHd2JlTTFlV2JQdFM1SWJKbUpDb1JHbFU3ZGZtdVYrRjZ5bldUWmNlcmR3?=
 =?utf-8?B?eFBxUEozTVpGQjg3dlRpcUExTUFkeUY1RlZOR3BhMEJWM3hGNGV2Vzc1a3Rt?=
 =?utf-8?B?U2ZGWEtWVXBhTXVhN0RQWW5WM0lxcVd6VmdkdWd3WlcyQXNMeVJYeTZ0NmZq?=
 =?utf-8?B?WXE5ZFNQTUFpcU13LzMzeSthUzlxNVVtbTlHUFhNeXl0cXJNTWR5WUpwcVJ4?=
 =?utf-8?B?dTh1UjROSkl3RWh6ZVg3M05mRzNsczJMeHNxcE1rRlloWlZZckxSdTBDSlNT?=
 =?utf-8?B?cnZjV0ZjWEh2MXRhRUhsSnpxYmcrNU9mdDhyUUFxbDFrZ0lxT3pnMFZ1M1Mw?=
 =?utf-8?B?bmJIcjFrT1FJRUE2OTNwV3lSU2VHTVQ0M25lNGhWZWZpRXZxKzNBZDkyem00?=
 =?utf-8?B?N2xLZ0FYOCt2N20xcmhURkc5QjBnVUcrSmJ2Q2ZIa3lXaWMrb2Z4WDhGb0Vi?=
 =?utf-8?B?K1dacE1wckFkKy9IN1pHNkw4L2V1ZTNXeDF6TkZPZWF2eWRtSlFHR1ZHeE4v?=
 =?utf-8?B?Z00wQlJ6YlRXMVdBY3RldmtRVU5iUTk1RDZ3TFVqY2NCYWRPU2FoL2ZVYjZX?=
 =?utf-8?B?alBFSzRjVkdGcW4vMFhKQkZHMkJFWG9oR0tFeTdyMDZWcElOQ1dFTlNpNzdB?=
 =?utf-8?B?SVhiaUhSTjcycWwwQTljN0poYW5pcEFmbUFQRnlYTFdCU3VEdTJaOHdyODdl?=
 =?utf-8?B?VzUzZzFoVDByMEYvNVZCMnFnTm0rUldCYjJHTTczVytkVVpTQ1ZsczBqODVz?=
 =?utf-8?B?Qk9YT3hreXRtVW9kMTZpSzAwT3dqY1Z5TkpJaE8xSDV6aEJwbzBEOXZjR1RT?=
 =?utf-8?B?c1hmL1kxY2V2Mlc1SlBQdkNLbzBaYVF0NkFNMWtGVVBqdDRmVStSY1RVd25U?=
 =?utf-8?B?Skwvc3RySUYvSWdyUFNUNFNJazVsUS8xVExKYS9WRWtsZ3ZxUG9qam90VTcw?=
 =?utf-8?B?WjhKQ1RlZjcwTmJFWCtkZzNMNW52QXBudTIvY1VINisrb0dIVVBveFZ2Q2kv?=
 =?utf-8?B?cHBlNWlPQ3VqVXRnckFnaUUxeDNPS1J3WmxtRmNoRE5qTXJremNkVFRpUmdJ?=
 =?utf-8?B?Zk00Yzd0dXR6TVJHb2JlZ1l3UnliYTlyRXkrOUcwSFJ5YUFhK3c5S052c1ZI?=
 =?utf-8?B?TGpXQTFhMFFUVHVnSnJrZVVYOXhnajdQNWZWYWdybVJYczlaeVBIdnk4WUI3?=
 =?utf-8?B?UWNMTHoyRXBwQ21IaGNQNXdadkhVQy9LU2RxNEhjdUFvbHNIRFN4eUtFMjhr?=
 =?utf-8?B?NVN6ejBOUS9JSUg2a1kwaFZ1aGxNWk1POFIyaE9MV3F6NVFJUExSMSswR1kx?=
 =?utf-8?B?dGtjcVdVbVFMcW1ISHp4bS95bGlVZzBKS3dmQkZKYmRnd1RBVUhic2wyQmwz?=
 =?utf-8?B?dzUwQWhYc1ZoUWIwMWV1ZFowSW1SL3RyK1h6SDF2MnErcWpoU1c4RzFOVklZ?=
 =?utf-8?Q?hheNKbJqvosN4F6Vi2S8tcivfWKJ8sGiig0mrOK?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78cc3623-0b13-40e6-8fe6-08d98e439005
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 12:18:28.2371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efzJkx1MvD6SvSu4tv0nZvOU9CfubCfV+PMhpalQBNPI8eCrUWciX50jYx4oFBsZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4279
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/13 20:14, Chris Murphy wrote:
> OK so something like this:
> 
> /usr/src/kernels/5.14.9-300.fc35.aarch64/scripts/faddr2line
> /boot/vmlinuz-5.14.9-300.fc35.aarch64 submit_compressed_extents+0x38
> async_cow_submit+0x50 run_ordered_work+0xc8 btrfs_work_helper+0x98
> process_one_work+0x1f0 worker_thread+0x188 kthread+0x110
> ret_from_fork+0x10


Sorry, it only needs the last the stack (submit_compressed_extents+0x38)

The full command would looks like this:

$ ./scripts/faddr2line fs/btrfs/btrfs.ko submit_compressed_extents+0x38

The modules needs to have debug info though.

Example on my X86_64 VM (which would definitely result wrong line number):

$ ./scripts/faddr2line fs/btrfs/btrfs.ko  submit_compressed_extents+0x38
submit_compressed_extents+0x38/0x440:
submit_compressed_extents at /home/adam/linux/fs/btrfs/inode.c:1041

Thanks,
Qu
> 
> Chris Murphy
> 

