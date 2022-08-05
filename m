Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EB158A5E9
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Aug 2022 08:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbiHEGdC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Aug 2022 02:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbiHEGdB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Aug 2022 02:33:01 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80078.outbound.protection.outlook.com [40.107.8.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA79F7173C
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Aug 2022 23:32:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWJkuxUkggjb/NMxX9bSQ6NudMWovH3uhB8ayZxnVmCJr6adLIfUeSPt/WHPXVYTgfKn+3Ggz5f/zi2o5hfWl9DH4tthzWuf3MIGlefl9Ns8PFCYElYhe1p+jwCFgXJf7tS/4psS3LpMoEfUIUeRJ1GwzSYveKMK8BSXUYrqjVoR62exqSxUetj8UuYcKGcK1NeSaXv/RQCEShLPxE9IlLx1sE7hyDh5Kdm0F8mC0dh3Q6dDVQa9+W3xRyFBJPJL6CADyRoSW4DAjo4LsT6aCUOea1L3ork08jxnT90sHm07ylKHKmbCWmpqRpVhn43GoWixoettkCBoxfC9fJU9aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Qzh/EwhAVzN9+/YRXn/PEwC8Leum6mnsr+r5277vQg=;
 b=a/pu+K3XrM+rqMjVRev0J5KWtZb/RMerZ/FpNvwoG+bGNsHhiw7blRmVp4jnVjugX0R5WhBIvJ3o5fkCLY6jhQ2rH2NrPt8BJLoY6BnH6oluOg9JPh0jueYHMyqpC/5aQ9YbDTLiT8+uJYBZcuBR5Hgtpp7kXuB/Cd/bBoyO9bXDN+zJNxsB0g4TXw8oFd/6QhkqTIr6XYkq2x9uFR0Gn5MD9JRaNRZPzIfcudhoZYLAegYGHDL5VOvXkRcMD/L9kRzCeOxIXP898nBrjpux300qFfngw5BTTg2lMxhisk/TGE+A6bHLNI1YqU6ybXxKG1vEpgT4N5BX7mgO5Co/iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Qzh/EwhAVzN9+/YRXn/PEwC8Leum6mnsr+r5277vQg=;
 b=gaxJQX2t7ByNEL1Ijwf/nrJOirGs/MS0s5wUVXirt2SxOjm8/pDwY4rUeEHmaE6/JDzy8yP0KmqP4qmDEw77OX+O/d4ZEQqXPIeo+9UQS7TP5AmaNTsCZewx+x6iPx0bSTg3N86ogTLnOSCH6qj7kIX/4tFbzsbbTMV8S1mhZscDy7OYUZqvBPFQlmn72xwzNB6bwnYVL6H/n0arxzvLIXQxb0ktgiMkUzU0Ni/xBn7VVcbHc1PcteH1F6M/dZJCEDrEsof2XaxcuRTZ0FhsjVLxcoj9O6TsOuJEnmY839U70iavKUwns0fDhVv2rNYnHLDDXCJ9beFKNiY+aBEF3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DB8PR04MB6841.eurprd04.prod.outlook.com (2603:10a6:10:116::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 5 Aug
 2022 06:32:57 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::c4b3:5f3a:8bf5:f6e9]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::c4b3:5f3a:8bf5:f6e9%7]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 06:32:56 +0000
Message-ID: <29229e8b-d4db-ed4c-1e06-90ab9b43a206@suse.com>
Date:   Fri, 5 Aug 2022 14:32:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/5] btrfs: scrub: make scrub uses less memory for
 metadata scrub
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <cover.1658215183.git.wqu@suse.com>
In-Reply-To: <cover.1658215183.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0068.namprd07.prod.outlook.com
 (2603:10b6:510:f::13) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d7de68c-fdc2-424c-9921-08da76ac5517
X-MS-TrafficTypeDiagnostic: DB8PR04MB6841:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rerZz/7eYuwhkaBTL+s+RUwkfkU1wOXTPpRp40S21WLPD+wOW2gHvOPEFy6FckSZSGMItDfyML/wA/mGx5aKSW8+uMraCFzA08ueb3I2Xl9HdWghRJ6zGj9HSbu/XeocaAJouic1bU9iZav2D6Y1zH8vXeGdvIpndi/ja26EbMP7JX16GFFWdpOYvgz7u/fQMhbPUNSc5TV+syPU9mxYzCg6IbuZVyWfLmnVTCeEd6tjs/mbj7OPcjhnKIMHyzAaEtJUViSowLzrpz1arjOVyOeOMlJFJYKCf7W3YkURfssuicVs3tqgcGh9uLoRmMqEeoFGlD9JAx8eAEwfvAGPg6z8aJWIFVL26nbMSJ+OpbE0JgxBMEi+NtNfMwIuAsaG3RSpfysJkAf3fRb+xxJnPArJ/pfDzmx1uEjaziCUZoP2gP2zhweDjCFgvnPKjMAfsqdSd3RCOyyLDcyD5NpuyKYM1TeEhrr3kibczHA24hiZRNBFqtf5Gt4mIf3PNz24na5kzOVjPhRFEbLVv8g8yfVWdnQyyaAU6Aq1UFchdis7jGDoCZ4dgBDZ1J5KNAlNODIirwx3SiLeDKfP1FbF3p8Kl8kThvFz3AJ151gPFeWCLUEtXoEnHRaYR5r2rkim8p53d31V45CzXH7WAB7ThL9gh71aeg7vCryTUpko8S93YSGklpK4iPmkRkY+iaV2lZSRZd1tqRnetwQZTVjIWUutyzutU2A3kaM+xPjv17q1JWuoBzKVdr1NVKsnfu3FvU1yEPST+qlYEN+50/CF2WaVbJxs/xx9jceBgJe+tj7RRSn0noNWwhBEleNUetWm4sLK0QVLtsYJKH/qbwsDqJ4kyK6ZW6BgM4tK9pVByVs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(39860400002)(346002)(136003)(396003)(186003)(6916009)(6512007)(8936002)(66946007)(66556008)(316002)(8676002)(66476007)(2906002)(83380400001)(2616005)(31696002)(86362001)(6506007)(36756003)(31686004)(478600001)(6486002)(53546011)(6666004)(38100700002)(41300700001)(5660300002)(438634002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGVXRUlEQmVFSWxrdTdpYytoZ0RiNkZQeW51b2czMTN3MzBsZEhydkY2YzdL?=
 =?utf-8?B?QkZVS1N1WGZyVVkxNDVjcDhOcURNZktaYm1kTkw1dGRIZ3Z2b0hnQ3IwaWE4?=
 =?utf-8?B?L2IzYjFTeCtGcFc2cC9PZWxuN0Y3MGIxMndyV1owWGZlZ1U2L2ZKK3RDZGlk?=
 =?utf-8?B?S0szMkx3OHlPSFFvTlpQUWcwa1dNb1BSOVIzS21TRDVQSGxDbks4Q3QvVjNZ?=
 =?utf-8?B?UC8xemFOQTlzMlRacGwyOWNTMjJOM3RHcmIvcWlnb1hYeThTRDZ6NW5tTmlC?=
 =?utf-8?B?UDJNRllMbXlPNFBFcUkwQmxTeGtRcjIvTTF4blNIRzdOTmw3V2Npc3huOGJI?=
 =?utf-8?B?N3BUNjI3SkMweXRDRWJtS0lWWFFSZGdVT0I3RmZsUWxNN1haM00zTmZ1dFNC?=
 =?utf-8?B?b0tnVnd4RWFRWlBDNjk3aFh1ZEQyS0Y5WDlQM3dZZXFtNStvSmp6b0VVUGRa?=
 =?utf-8?B?YWhEczhRSjZGcWgvYzNPczJuN2xWek1WSUlPdW0vTTFiQW94eko5MDhYMTda?=
 =?utf-8?B?em0yZFpLRVEyK1dXbnBHTDdnZStFajAwL2o5Q3QyckdmeFgxaTl4NGd0SnBH?=
 =?utf-8?B?cVQrYzNWY2N6eFFrOWltWmZyRXJibUJLYm0vV3VVT1VvMlFkYjlaZ05mdWc2?=
 =?utf-8?B?aTc3RlpMeFoxL25DSEcyODVUVXBhVFFvQ0dEMnRnWUdWR3BubHFwQUlNTTA1?=
 =?utf-8?B?TERLYnB1WjJpVVZ4U2R4VjZiOUhJTjlXUzBrVTFxNHd0cndpL2FJc3MzSmIw?=
 =?utf-8?B?VVFINk9Da3oyOVRyUkNaeUQ4OXdjb1BYSzZhODNMUXZqZStHL2VSYjAyL2JC?=
 =?utf-8?B?STIydXUrSk0vSklvRkN6YVNjZmFTZHdZQlBNUUsxOVY1ZUt0ZW4yVUVjL2Ra?=
 =?utf-8?B?MHp0bitzTXI0eENVUUZaeUtoOTFIaXhjbXNFT1VRVHgzSFZPaGcyUy8vYlRL?=
 =?utf-8?B?eDRrQ2RWemhVUGEzc2JLQXhMZ0tRbTVSNTV4TmMyNnk3VllZT3BNQVlwR0xS?=
 =?utf-8?B?N3B0TVBzN0YxcTF0bVlBN3IxNmF3eGdsYnFzb1ZvNkgzVDJ2Ym12aERIUXEr?=
 =?utf-8?B?eFU1S1o1cE8zOFh6Tmo4Wklaa016WVk2VlgwVWIxay9DcTQ0K080S2hVUDQ0?=
 =?utf-8?B?RlNzeFU5Z1lxaW1wd0xCU0dveEtwT2FtckhJd20rdFczd1VuQzJ3NlY0WlJI?=
 =?utf-8?B?U3Q2VTN4MXdQRGUwdTRaWmpQZXhHc0RodklNTnVJdHpreWQwa2tBNGdGR3V2?=
 =?utf-8?B?d2JzUGxnbTlWcENUMyt6Y0ZnVFF3by9KcTFWRWFCNHMydkVGWlA2YUptTW1l?=
 =?utf-8?B?YlFBZjVDWVRaR20zNWd2VEd4WThadWp4YXVWY1h3SWNFT3BJWW1uejA1bnIy?=
 =?utf-8?B?MmtqVnd0WmtTa0hVVGZVcEJtK3dWS1kxVFo0WDhaZlFaTHdUSjAxNTJVUm1D?=
 =?utf-8?B?NEpma3JoTitCUmtzQkF0QXJOZFVuM1VkdDFVNzZ3U3A5N2c3VjIyWktEKzFJ?=
 =?utf-8?B?c29FbERDQXU2V2hTU1ptdGprd0xsV2pWUFdYanlDUmoxSFNzRG5PQWJubGFS?=
 =?utf-8?B?OGlGQWR1ekhHbTlPU1BZMitUUEJsYW53ZGR2RXRnZXM3emtua2hlRUpiRndn?=
 =?utf-8?B?OEZqd3NwT1dONThmZFpaUGpzZzVORjNuSVVSMjRyQkgyY0xVR2ZiQ3RkeDRQ?=
 =?utf-8?B?cVErV2RDeFVMM3Y5MzlIdEpmRCthd3BsdUN1NndRU2ROdFJBY3Y4OFE4K1ZP?=
 =?utf-8?B?M3ppQUczZ3R6RnNOZ1NTb2lMQzhqc3BOeXVDM2FiaU9QNXlCenh2UVdnOHlj?=
 =?utf-8?B?K3BTWWJqUUhBOHMwdXVXV05DM05GNnJocG1rajAvRUpFWEtONzVmWVdQWGFs?=
 =?utf-8?B?bHNmWlIzWFpFN2Jic2hHZGlneHlpVGVPQ3lobC9Mc2JaL0pQdDc3bUR3dVFl?=
 =?utf-8?B?NEtHZVdSYXhOK2dOREhvcjVOL2NRY3lDUWd4cWRRYStRZjZ0QXpmVUw3ajlZ?=
 =?utf-8?B?NVZvL0pvVnhySW5ReGQ2STB0SXZCRTEzZzF1aS90bDNtSCtOY2R2QzZxUzBs?=
 =?utf-8?B?dlpLL1BybDJ5dGY0YXlmb0UyK0Vwa20zVGlkNFBqY0Q4eFJmb0dlSjJEUWhY?=
 =?utf-8?B?cjc0M0V6dGd4dElZMEpPYzJGVHJZbUt3dXZzWEdWb0c0L29XeWtlNDJTWlNS?=
 =?utf-8?Q?O748QogmpTnliv0ihGqwgf0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7de68c-fdc2-424c-9921-08da76ac5517
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 06:32:56.5251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfzO/80Xzi30e+TKGgFP6atAuzv5QyePNMKyMBx7gWxYH0UgegCb/mOiSVmHsVa7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6841
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ping?

This series would begin a new wave of changes of moving various members 
to scrub_block, thus being able to further reduce memory usage.
(Per-sector to per-block)

Thus it would be better to get this series merged before newer changes 
to arrive.

Thanks,
Qu

On 2022/7/19 15:24, Qu Wenruo wrote:
> [Changelog]
> v2:
> - Rebased to latest misc-next
>    The conflicts are mostly from the member renaming.
>    Has re-ran the tests on both aarch64 64K page size, and x86_64.
>    For both scrub and replace groups.
> 
> 
> Although btrfs scrub works for subpage from day one, it has a small
> pitfall:
> 
>    Scrub will always allocate a full page for each sector.
> 
> This causes increased memory usage, although not a big deal, it's still
> not ideal.
> 
> The patchset will change the behavior by integrating all pages into
> scrub_block::pages[], instead of using scrub_sector::page.
> 
> Now scrub_sector will no longer hold a page pointer, but uses its
> logical bytenr to caculate which page and page range it should use.
> 
> This behavior unfortunately still only affects memory usage on metadata
> scrub, which uses nodesize for scrub.
> 
> For the best case, 64K node size with 64K page size, we waste no memory
> to scrub one tree block.
> 
> For the worst case, 4K node size with 64K page size, we are no worse
> than the existing behavior (still one 64K page for the tree block)
> 
> For the default case (16K nodesize), we use one 64K page, compared to
> 4x64K pages previously.
> 
> For data scrubing, we uses sector size, thus it causes no difference.
> In the future, we may want to enlarge the data scrub size so that
> subpage can waste less memory.
> 
> [PATCHSET STRUCTURE]
> The first 3 patches are just cleanups, mostly to make scrub_sector
> allocation much easier.
> 
> The 4th patch is to introduce the new page array for sblock, and
> the last one to completely remove the usage of scrub_sector::page.
> 
> Qu Wenruo (5):
>    btrfs: scrub: use pointer array to replace @sblocks_for_recheck
>    btrfs: extract the initialization of scrub_block into a helper
>      function
>    btrfs: extract the allocation and initialization of scrub_sector into
>      a helper
>    btrfs: scrub: introduce scrub_block::pages for more efficient memory
>      usage for subpage
>    btrfs: scrub: remove scrub_sector::page and use scrub_block::pages
>      instead
> 
>   fs/btrfs/scrub.c | 398 +++++++++++++++++++++++++++++++----------------
>   1 file changed, 266 insertions(+), 132 deletions(-)
> 
