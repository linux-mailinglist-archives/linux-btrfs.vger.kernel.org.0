Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0516C4201
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Mar 2023 06:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjCVFT6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Mar 2023 01:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjCVFT4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Mar 2023 01:19:56 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2089.outbound.protection.outlook.com [40.107.15.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE1A2B63C
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 22:19:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYEp/jMPH+JyC9Q5FnuCkUX1OM1EQzByrR2wj/+bQSQCZK6grz6MkjvRP7pUqjd1+djVzTcaszRinetE3Jq2tZfpMeEvUy3CWaX5kcT5OAkqZ2NZh80jGw/KDJ3SjJtme5S8opSlrNT//DKvA/TuPEC81dBlmpoTsIhFGZ9ho01NaeA5zSl8nSR0E9rF2mcPiaXDsFKKoh8juoFR3n9+9xsq1jk+C7Wh+xcnJucYf2x4So6J8oUPbGj9M9vngmZay3ykVUmpWxFySvgUSBnrWk9eZNutqXRGl/9mGKXi/9vf25Sj1KSldJHwt05xV0rANDPndk1XEWt2wGN4GL+fHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWhR2rpVLIuodJilrqfXRESXnN4A8xo+YtRVsbOS32I=;
 b=K+r3yl6jCYXs4jJF3BV31nC76MZvpYG+PxnJQAJaDiPIqhs3gOCk8YL8wLabIswF4h1mQJKmN47lt1nua0KHO42kMoTQVOn8VZ/lTXbrxU/AxfvI93f69a+tI/m4NXfNUno7K3P+d4IdvEg0BfT9Na5r0PZGH6ktSO8PwdQVpu2d6uDIMnhDAwxwDaNaKCjgCdZKJshfwpjcv6C3nTlIeOyuNofnDqYsvps2cVlLXpms4torNR6tiK4eywFZT+44NzVtDPpP7lpk5TXytcV/6k+m0OKxWdBFj554pMBAzG6P9D9egrK1kamMhsZK/RNAic5uzYqjN5kuHh5B1SX/fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWhR2rpVLIuodJilrqfXRESXnN4A8xo+YtRVsbOS32I=;
 b=dZN2S0ECj3OTPnZ+nkjBuM06MrOLh9bOVsovHNa65sBoXnWhVpc0ETAkIqpS64CjNicTMINJytrOha0Y2NwzGygVDuHYA8S+/TjDU8S27qBJet6r272efGjVkxPI18OKIFBVlGNDjY6VsHkqlYugcyP2jF4Xh3J9AErjaDc9GTsjKAKDp0KfjM9pBNqu+pHhtXdvkniOJ81BBB8adzFoWDNDedeCrMqWbW2DCkgxVIIMhF+5DFvFhKLlSefxKQzmv2sqMJBwhjfsIIbRl3pNkBxTpsu4CRTtRqXj6Z6K7oyjXpt15gaWlcKTU/2RYc9ERA1d0GKC8tBH/a72CNupHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by VI1PR04MB10027.eurprd04.prod.outlook.com (2603:10a6:800:1e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 05:19:41 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb%6]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 05:19:40 +0000
Message-ID: <9d2a93c6-5e69-efdb-1f6b-c796c3f459d5@suse.com>
Date:   Wed, 22 Mar 2023 13:19:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Hector Martin <marcan@marcan.st>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Neal Gompa <neal@gompa.dev>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.cz>,
        Davide Cavalca <davide@cavalca.name>,
        Sven Peter <sven@svenpeter.dev>, "axboe@fb.com" <axboe@fb.com>,
        Asahi Linux <asahi@lists.linux.dev>
References: <20230321020320.2555362-1-neal@gompa.dev>
 <b4329200-650e-f46e-505a-e5248f187be6@gmx.com>
 <8a52f55e-9b91-c6da-f2f6-eb8ccb87093d@marcan.st>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [RFC PATCH] btrfs-progs: mkfs: Enforce 4k sectorsize by default
In-Reply-To: <8a52f55e-9b91-c6da-f2f6-eb8ccb87093d@marcan.st>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0019.prod.exchangelabs.com
 (2603:10b6:207:18::32) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|VI1PR04MB10027:EE_
X-MS-Office365-Filtering-Correlation-Id: 83bb9065-2a04-4ac8-c263-08db2a9509c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gqqf2Sm/1nLgM+zLwxclixfMCGY9WP6Q4c+0YfeGWeJ1djBJsaKtXF23v7bgp8WqG6KnCUZsZCzExNT5Piryxq+AlciYnssrnhftGOeQD1wkMVhIuRvcwg4IqJs/TX5txsO4idk4aTiuJ1WCgWleQ7Wa4rrxI6hj+Z30Ht7I2a6cFWFjnedshKOHAEm6WYUAIEnfkVPM1ewLClvWTAiRZD46jUOJBRlg3cT6nkQyxebDTw6j1P8LlBElyYEO0NBvItIuQ9xwRtgGEOw279DhumA3KYZgsbtnV0rgP8JKjtIVmaEJSD27f9jEAM0+ExNHBEWJBvepxQRhvDlGqWX2i9FuhjqioOl6WLSAuApMc9kplGAWzbtS4fFXgoy8aBW2CDrITY8LiHfymao1QTpPerdlso91isvxYCaD+XQvtjx46qXF4GpZVeGyMANPmn6wg4vYJWphywA0DBsZPe7NrhuxRU6NlCJeFzjo0JBGvVs+qO9UQierSzxDuLknL86uNQ7mrT+eh3CcaqsHR6QzrDqxELdmU6+vLmHYm+3Y/lM5tg7YpsAzB0hHtTZ0QeVyrIWjETMxartQHgHrfrwjZ5kFGulniN6YnOq1EnsDRS0IT95awxksHaKqyYYUltxGGXwJUTrp3s5dPaTI3kz31aVQ9YRpK0z32ofhYBPJ+mYUBKQpXHNmh1w/Nc0GNC7dVXa5YBjCDjeP/5dvVIfW2ogYcGDLXBy5bMhGNg+saJoRR12o8ur/gzhUFA95nxFm+q3RfHUbOS3DDuLWQxigaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(39850400004)(346002)(366004)(136003)(451199018)(41300700001)(6486002)(966005)(31686004)(2616005)(38100700002)(66946007)(2906002)(83380400001)(8676002)(4326008)(66476007)(66556008)(53546011)(186003)(6506007)(5660300002)(6512007)(54906003)(31696002)(6666004)(110136005)(8936002)(478600001)(316002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlBZQ3lBRU5aZWlGaXQ0SzRqcDYxMk9NakZLV0hHa1lpZndSeEJtUFNaeVpx?=
 =?utf-8?B?VzA1amRrWWVxdE5LemdiL3FvckluOGFWSDNDeVc1TU0wNFdlYy9Td01DM1Z6?=
 =?utf-8?B?ZGJYVUdvSWpOTTlFd2NNS0N3UklKNnFxcmlaZlVXbkVPc0sveUVXdVhiRG5l?=
 =?utf-8?B?N2FUV3dlSlRUTlBPUUgrRUZVQnZadmxlT2FoV0NYd1BCcGtQVmc3OGM5elgy?=
 =?utf-8?B?VG5iRTd2Z05hTkU4MFUvVVBNbXdDVmV3dEc0SGhpbnliWE9xOGdNcHJWT2Vl?=
 =?utf-8?B?TWVNWDYySFZXc1BiZUlGdXFRTDViZWkzT0N4Q0IvMm1JNDZ5VVNvbm5sZ09P?=
 =?utf-8?B?dGplU3dpUmxuTDhZNmNRcThFUzNFLzVXWWsvT2ZBVmxEWnM2VkxQTE9XYzd2?=
 =?utf-8?B?VDgvcG1EdlhBOHV1TG5Va1lTR0w2VVBYTGp0cHRNRnlsaFpvTzkyYjlkV2FR?=
 =?utf-8?B?YkdBd3YxbUF0ckQzbWtSUEVJZ1Y2NTRnRE1iYmF5TGx0QmU3cWFaVlBhdExD?=
 =?utf-8?B?cUFIUUpIRnVZT2NsTjA4TGl4Vi9YdXk3VFNFUFk2TjhSVUlEb3cra21YbTRP?=
 =?utf-8?B?cllHaDJIUG94Z1pkKzYrWnZ4MU4rZzBJY1UzelI2NWNkMUNYVWJja0s1dGdZ?=
 =?utf-8?B?WUxLVzI0Y0ZDV214YlQ1MEJLR0FlT0xLQnlJeENFeVM5VWtuK1BYdzRrMDRL?=
 =?utf-8?B?RzhCUTRHSWlrS3p5akdQaVVka3pFeE4wazF0Tkd5Y0Y1SkJ5SkdPcXlrOU1J?=
 =?utf-8?B?VFFYTU10ME14R3d2cTZsTXlvYWsxNlpvYlA5L3lvNm4wYnpzRzJVSFk0UVp6?=
 =?utf-8?B?MUJHR1NmWS9aT2U5NDN6OUdsWjN3cEZQWllLaFNTZk5qTzJvRDBGYVZjNTVX?=
 =?utf-8?B?em1LL3AvNjdndkgvdW1KK255Q3dDdUtvQis2RUlqM25KdXF3OU9RdDcvK3NO?=
 =?utf-8?B?a3FBQ3BrNGpBUTl1OVVPS1o0b3ViOXV2M2Q4bXdoNTYyc2Y0aFc3V3Jnc1dq?=
 =?utf-8?B?Z3VIMjlxWGJ6OW40SUp1Q0lxMmJ5TS9laTdsblIyUGFSd0RkYlZxTi9peEhF?=
 =?utf-8?B?VW1GWHoxVkN0TU5KWGhwSDc5U3R4Q1c4Y2VQc3FyYWlaYnEzYkZ0eVhEWGpa?=
 =?utf-8?B?UnpBMWg3Q2RSRWxjSTB5NnZQMEhZaS8vaitrcGIxejErK3VNd3pwc3NFUW54?=
 =?utf-8?B?Z0Iwa1I4Z1hYTU1KeW84L25Kb21SVGtwcnlZMVlWOXJVVWFPaG9SU2hxMDVD?=
 =?utf-8?B?aHVRSkpybnhYWTJ2Si9Ca2FvZ2diWXYwdjNxcEZ4djJIV0drbnFXWnQ0bXBr?=
 =?utf-8?B?VnZWdWYrYkJBTVR6aU1IL093OURoZDg3bXpNeEpUV1ZRaTFNYTdWMXhtYytl?=
 =?utf-8?B?QVRUOVc5RkdScHlub1RCa09ZOE9kYS9JK1dxbkVmRzNXSk5ha1NqeFFTWnBk?=
 =?utf-8?B?cUdOSzRzYytGcmgzSGgxclk3d1g3UHI1ZGVZMXBXdzlHaGJZYkExUW43QzZX?=
 =?utf-8?B?ZGNCazFDVW1IZWJHcXo3WGlkMHR2Q1k3RlNLMDMyQWJzaG5UQnErWWEzRGtR?=
 =?utf-8?B?dGdDb0dwZEhicndvZk8vdXlrZCs3encyWWNSSlhjaDJZVVlOUWZXeEpuVnpS?=
 =?utf-8?B?ODNXbmtaVUlFSnhoNnkzOUlTKzBmdi9scmN0dUk0WFppRjFWdng4VGJUVXFY?=
 =?utf-8?B?MzkvZU9KeVQyaW1PZm8zUE4wbjM4Wi9mT2gyQkVLZWE4cHJQVjhveUs3MXJj?=
 =?utf-8?B?aFp4YzEySjRlSVlCcUNUYW5wSUFsTkFzeVFLMExZRWVBNzc1T0RTNzBtak9H?=
 =?utf-8?B?RXliOFVvbHpIdmlSbHNtYjJRdkhQalkwc2RCZWl0RVFFZ2s5UjdCYmZPNllD?=
 =?utf-8?B?SzV5MERoT1haTlh4bVdmUFA0aFRYa2lWZDZkOHJLdUFPVlVXL3NzWXBwQ3pE?=
 =?utf-8?B?aS8xUHY2Ny9QaXFDUDhEUHpSWjVNL2FCc3Z6OHZscnIraHRpUWoyL1U2MDJP?=
 =?utf-8?B?VTFWNnY2Y3RWL294V2pLakxrT0Fld2doQXJwcjhpRTgvbHdyYXBFR24zQ3Rl?=
 =?utf-8?B?MlNwVFRUZzEzRjBpZGwxRlJiUVUxR3F6UkpXMkk2YkJJMS9tUkc5bCs3TDJi?=
 =?utf-8?B?ZisyV1M3dndZYVJyUUI2bjliYmVEa2FReGs2UVI3cC9YVUdqM0ttSS9BcUpJ?=
 =?utf-8?Q?7ABirkOl7IN/WzXB4nSZkVY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83bb9065-2a04-4ac8-c263-08db2a9509c5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 05:19:40.7067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjKgQlG0Pwu+4rXJBA9aoVduSz74/2qP2C26t3WqKjpxni+hT9ggDKcb+y2mbluz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10027
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/21 18:07, Hector Martin wrote:
[...]
> 
> btrfs/140 is the first one that looks bad. Looks like the corruption
> correction didn't work for some reason.
> 
> ... and then btrfs/142 which is similar actually managed to log a bunch
> of errors on our NVMe controller. Nice.
> 
> [ 1240.000104] nvme-apple 393cc0000.nvme: RTKit: syslog message:
> host_ans2.c:1564: cmd parsing error for tag 12 fast decode err 0x1
> [ 1240.000767] nvme0n1: Read(0x2) @ LBA 322753843, 0 blocks, Invalid
> Field in Command (sct 0x0 / sc 0x2)
> [ 1240.000771] nvme-apple 393cc0000.nvme: RTKit: syslog message:
> host_ans2.c:1469: tag 12, completed with err BAD_CMD-
> [ 1240.000775] operation not supported error, dev nvme0n1, sector
> 2582030751 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 2

Mind to share the reproducibility?

I tried it with my aarch64 VMs with the following setup:

- Page size 16K
   The host SoC supports all 4K/16K/64K page size

- Virtio-blk
   Backed by a NVME drive, with unsafe cache mode (aka, ignoring all file
   sync)

- Virtual memory 8G

- 4 vCPU cores
   All pinned to A76 cores, as qemu failed to boot if it's initialized
   across A76 and A55 cores.

   Paired with the virtio-blk with unsafe cache, the VM should have a
   very fast storage, while lame CPU perf.

- With extra ASSERT()s in btrfs_submit_bio()
   Making sure all bios submitted through btrfs_submit_bio() has a non-
   zero bi_size.

Unfortunately unable to reproduce the problem.


If you can reproduce, mind to provide a call trace?

> 
> Looks like it tried to read 0 blocks? I'm pretty sure that's not a valid
> block device operation... and then that test hangs because the
> _btrfs_direct_read_on_mirror() common function is completely broken, as
> it infinite loops if the exec'd command fails (which it does here, with
> ENOENT). Cc sven/axboe/asahi: I'm pretty sure we should catch
> upper-layer badness like this before sending it to the controller.
> 
> Excluding that one and moving on, 143 is broken the same way, as are
> btrfs/265, 266, 267, 269.

Also tried those ones, all passed here...
> 
> 213 failed to balance with ENOSPC.

Passed with 5x10G LVs as scratch dev pool.

I hope it's not Apple Silicon too fast to trigger it, or it would be 
pretty hard to reproduce...

> 
> btrfs/246 has an output discrepancy, I don't know what's up with that.

This is a limitation on the compressed write support, would update the 
test case to skip it.

> 
> generic/251 then failed too, with dmesg logs about failing to trim block
> groups.

It takes much longer time but still passed here.

I'll try my best to got some runs on real Apple machines meanwhile, but 
don't expect any improvement on my hardware situation any time soon...

Thanks,
Qu

> 
> generic/520 failed with an EBUSY on umount, but I suspect this might be
> some desktop/systemd stuff trying to use the mount?
> 
> generic/563 suggests there may be cgroup accounting issues
> 
> generic/619 seems known to be pathologically slow on arm64, so I killed
> it (https://www.spinics.net/lists/linux-btrfs/msg131553.html).
> 
> generic/708 failed but that pointed to a known kernel bug that we don't
> have the fix for yet (this is running on 6.2 + asahi patches).
> 
> Run output and some select dmesg sections:
> https://gist.github.com/marcan/822a34266bcaf4f4cffaa6a198b4c616
> 
> Let me know if you need anything else.
>
