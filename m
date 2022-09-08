Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC6E5B14E0
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Sep 2022 08:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiIHGms (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Sep 2022 02:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiIHGmq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Sep 2022 02:42:46 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12416A61F4
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 23:42:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzW5EryGrSe003Qr9CFm54x0BO29whVHz19Cz1EACFRctkdg/KU+khumhVpmnpgidzIr8LGzyjxf2TfjFWmT4Bh/apSh7nqMGC39yAYhYIKevfdgcUiS3nXNBOYfyohEXwPwe8iOLN32pPX1LFZCkHKq6jcYNkrpGqNtwBzu+oeN6UAeAZ4ufjAUORFf9cRV+JQSQavYo3m5zDT1G7IGHHvzW9yQ4KaQLzCqhXu2Fe7hJ/67Tw6y4WORZ+mfPzZa5wQTgwWYCWco6RnG8djyVZUaHKedIPRCC578vd/M5F0ZdiPquMwx9BwFEm6da0xUalMOskaypdjhDej/SgdCwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pAImg2avUcPeXIrEYtPpfMCQoQR7QhEeVrBzYEvXUw=;
 b=nAf7KMJuFEO5+ksCxvRu01VYnVzcq5p0aur5ytuy1Kse7MqcRIi6wnJWWBlQHtu3eC3GHatNPTQCPW8BE89OncaRA/vTgIgZRy875hKtazK408EypLq9YAuPKb25xbGlaqq/SZdVA37cCuDkTIyTb/7uLzROrQSRi+Enqh+HJ1MSDe0rGjGbDiApWRM3AprkdItpomXIMnXrPhVtokIaEBRU9KaxmI1IgsD0Y+nM2bdKYO8BW6GrJYYHRtl47/Gq4IHvZp+zm8BQVgtO3BIb/jrdGZDPgB727onMvjxFhQuY0a+L+ubPlb18wIfPzO/ZVf6VV17djrNtqWEuQql+bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pAImg2avUcPeXIrEYtPpfMCQoQR7QhEeVrBzYEvXUw=;
 b=PRQZPNqaLpcrdqV5BdeprGv+n9cMNfe1/2UX5mLPjelaoJpwBYgs/waXzeAkNrreAitrB1YbduolkjzsuKnMcgPyvwoZl4Nto2hVFU2gBOtf15BJiDQoMM1HNNje39JphJg/qk6qnOZLaoOBUJQNtSdsTEehjxCMIlp3xzVACOU8+Cr5twmb8OqW63cN3epzUeju/v/5PNx63CFoSpHVO5aPQvN+W7++9W/c4uSQexS56VrkmMfX/zDgonbpbyvwfwBtVuy85s1ycXeA/1IAwtXvMvy8N7AkAyD99TzJAZUw+unqDmRy2A0M8FYY+D3v383m+FE8n9wU9Ocp61FOmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM9PR04MB9004.eurprd04.prod.outlook.com (2603:10a6:20b:40b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 06:42:43 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::f9af:f33a:99ad:e10a]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::f9af:f33a:99ad:e10a%4]) with mapi id 15.20.5612.015; Thu, 8 Sep 2022
 06:42:42 +0000
Message-ID: <947820f7-c960-46fc-212d-518265fb5b0b@suse.com>
Date:   Thu, 8 Sep 2022 14:42:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
References: <bf157be545a0ad97897b33be983284a4f63a5e0f.1662618779.git.wqu@suse.com>
Subject: Re: [PATCH v2] btrfs: don't update the block group item if used bytes
 are the same
In-Reply-To: <bf157be545a0ad97897b33be983284a4f63a5e0f.1662618779.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0055.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::32) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AM9PR04MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f8bcee8-c0b0-4015-0140-08da916554d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DptkbAB3xL0FKDCfdfLgw44GtpThV5qk4W4yPBbo9276fidz1PBYBuga6no4hT5uYw9/267FI8KfTksrrDhln0i2CQ4vk4ZE33hO5qEfC3vGco4hKS4JyOn0eyJ2SOVJ79Tiwaq36gRlWq6RRQ14FM0Xl1NhlHwubuXb0WqovRJ417e0xKXwUK9cx/84rWEkkZVTOeJ4caJ3Vj2LURZ1bu4+BZ9H5mCulGAXdjoe25j1mwrxbvoI6aqo8gCzD+/AAFjSkWAZ4xpImC1nwt59R+L8jubUSlaVXVFk/Gws6A20cwNDOwDBkys6DVrYndErcrVNRw08TVjy5xw/LY69dl8rkXgKti2/eApKyg3ewkK/iv77Tgm3SRhuYL9b5O3JNtMl50+XbejEcB9PkLka1kruzrQz5lhktnZ9wHKmAYL2DOMtJ7TcLXiTrXQlR/O3uOCVlQaSk8KM0CQMCq1fOHEazL0Jv8z7uIUfecsyk/ggS+Ydd/qbpfn7rYy/rMyrn3NJLhtH24h0DYW52ueeQCmIW6QjYJYnsaZ/CMLUd9ZF752URoGs4M1tA4Qm+3i2d+HaMsH9WbqwdMvPJ+naGKMTN0WZ3630XE4nGLn5pvkd3WCXYv+HYSY0Ko0gTPJq7PXYxqZHOvqnOzSpycrzRrVfT02+Od1rwVkQDTsj5G9s7DdD+mB5dlS8j4ZwIiMeShh+otoLqjReQ/trZXhjz8QI3i1RJwz0rF59yyjcR22LNf8y5buSwMiGt/hpoEXJ4dBhuR22gLZumoOSA1O9BGIQnJ8I2fbvzK21EvxrAf6KNxZDeCnovx7FzrfeR9E4HUoK3tM0X390RjNqUOOP7QYQlgBq1FB0byEykUtCszs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(346002)(376002)(39860400002)(186003)(66946007)(5930299003)(478600001)(31686004)(36756003)(66556008)(66476007)(6486002)(316002)(4326008)(6916009)(83380400001)(966005)(8676002)(15650500001)(2906002)(53546011)(6512007)(6666004)(8936002)(41300700001)(5660300002)(2616005)(31696002)(6506007)(86362001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0FJNWhtNFZQLzF0YW45dXpkdXR0Y05RdGxJUEptblNPK2RTdWo4NWlLQWdw?=
 =?utf-8?B?OGNHRkViYWVuVlU2UFlXU2VkOE9iOGM1M2dKZkhqVVFmMVVvanBjMGVQbXZm?=
 =?utf-8?B?ZVg2Z3QxMzIrODVLc1h2QmxtdW91aU5KL2VUQzdKUmRZeEx3dWM4bjJmRmJP?=
 =?utf-8?B?SW9qZEd4K0VHUk9JbURPMHg0cCsxZ1JMTFNHMktNdE1YdHg4eDQ3RnkxTktP?=
 =?utf-8?B?NnFaek1sOS9lVUlwOWdPajdKUjFzQzc3OXR1OTI3NGh6MWFvemM1L1UvYU1E?=
 =?utf-8?B?MmtYQXdoaWZsb3ZyWUhENmNXOVBLMDFod1VvT3pMLy9NVDFPNUxXbThvUjRK?=
 =?utf-8?B?NVJqT0w5NE9CZ2xsNFNybEQyWG9Ecm02OWp5TjNLbDdkR2ZkV28zc0wxVlp5?=
 =?utf-8?B?d0Y4M1NvT3NmM1VlSDhrV3JVZldQb3hwV1p5UVA5aGVvN0ZuZlBITHRSN1Uy?=
 =?utf-8?B?VjNNK0U0OTkxdTRPRENqTVNqSDBGVVdzcGJ6c0Z1TWdVRUFhMExIZ0FYYk1z?=
 =?utf-8?B?QVY2VG4wbVBtdlU5d2gzY1ZHVlZCZ0M2bndaUmxWdWN6VEpzSWJHd0dIdWVG?=
 =?utf-8?B?WjJmTllBTWJjTXBINm13MnhMOFJqdStlaUJ0N3pJdU5tczIrRjVyb2QyR0ti?=
 =?utf-8?B?RFZ6TmRPVUJ5UFFQRDZSanBINTZLeGhiODZKV2hqZENVLzJtQ3RnSG4rdEk4?=
 =?utf-8?B?TUNqVThpNmJmMDcyYVdnOTRFd3piODJNSXd0VDhURmdVM3ZxbTRhemorb3JO?=
 =?utf-8?B?a1NNSVpHd0FUemdhcG9qLzBQenp1NG5MWTB1dytIR1JjWFp4UmNDWmlIRGtT?=
 =?utf-8?B?bGpzYWtyVkMvWStpMnh2bUd3UzkvRnQwS1lMODhaNGFJbHBzSkl6MzVtdXFH?=
 =?utf-8?B?WW81MTBJazk4Yk5uS0NwMjZOWElJa2hNQlBHdlJ2Q0ptYUdlcmgzZVdJbFYr?=
 =?utf-8?B?QzFWS0dYdGRlYXV3NjRwZkNUY1RhUmpiTVJOa0tpSEQxeklVR2ZiWWZueHdy?=
 =?utf-8?B?UURlNXhHNkpNbldmNFFqeHQ2MFdPVHM0Si8ySVA4MnJsalpBdVJ4R3hxTmE5?=
 =?utf-8?B?WXdDQXlQMWc4Mmh0K1dlaXcvMDUvQ2tCZ3FQYUx3dzZTc1cvRUVyWlRtdlVC?=
 =?utf-8?B?L3dtN3pYRlNMOVhDbzRncWRhajA5M3k0d2hDc2hsMEIycTN1eXlkbmI0bERE?=
 =?utf-8?B?OE02UnNKcDdLcnJOK0p3MWhZcWdvM1MzdVBlNS9aL0N6dlRWWlhEYTVoZEs1?=
 =?utf-8?B?S1RvOG5KQUR1b1RBRzU0dlI5YzEraE40VEQ2UnNlSjFQbG5nV0JFNnJMUC9X?=
 =?utf-8?B?NGMwUkQrU3hraDVFbGZZQTRrM1J5VzR5cXo1QUc3MkYybElpS3A1eTEwNnlP?=
 =?utf-8?B?Y2wwR2VxOXU0cWo0WmJRdmxvR2FTamRVUDYvbk1uZjM2YmM5TEMrU2dod3Ji?=
 =?utf-8?B?S0lBcUN5Z0pQRWloQTJnOUZBaDNWeUVnOUNCOW9BcDlSeWpLakxvVFlGYVli?=
 =?utf-8?B?UFJ1eG44MVdNYmN3dEVQT0FNVmZYMVlOdk9DdTczVWUvYmUrVVBXdmY4M2hK?=
 =?utf-8?B?NzhzOHlmN3dsb3dkWmQ4d1lqRUY5ZE0ycHdSR1ZPR1c3aWhxaGdSOVA3R1Bv?=
 =?utf-8?B?eUgwS2RGb3lxYkpFTHZyMTl1WkN6eHhkN3lxOXFMbUNERk9VNDMvcGxId3Yw?=
 =?utf-8?B?SU1LSytuS1JvLzNlamZCb1NzM1lmeUYrRzNMR09UaXY3TzhlcWZJSDZVWUVp?=
 =?utf-8?B?ZFRRVXBrcVBtRTF1eVZvejh0WkZKREZKUy92cEpxZ0cyaGhnOTBxUlp2dENC?=
 =?utf-8?B?OEpadjZNOFJvdjQwZ2p0RW84OHBUUVRmOUV0T1hoempoNi9GZHB5djF2TW9F?=
 =?utf-8?B?d3U5MkpoTEttbkhSekJkRXRsYXpVNWl3bDhNOElEY1RtMGMrdVpSMWU4TFBw?=
 =?utf-8?B?VWJHT0FhWVpOQklSeU1mZkhTdVF1MXNpQW4wTnUyTlkreGsxMDFQcmd4aW9S?=
 =?utf-8?B?MFZwT1FrNzhRMzVDU3k2ZjZ5NWc5eWY1VlpiM2tzalc5dWlXQ0twdG9Zd2Nw?=
 =?utf-8?B?L1cvZHdBVWlFWGhPK1JQMTdGVFRvRWVlL2dxUVBBRUk5WlNnK1NDYkJ4U1M5?=
 =?utf-8?B?VStpbmhYeVF3QXNIQzZTdy9WN0swa2V2SFRQWjB5N1Ara0Yva0c2S2Q1ZjA4?=
 =?utf-8?Q?3FJVAZ31PkEsCJjLfVnuWjM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8bcee8-c0b0-4015-0140-08da916554d3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 06:42:42.8887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AO/DGcfIU685+9/ksg20p+S4KqBxF/q26AtEiGHHxb7CMN/hX+7nr8VA2fJOD1H2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9004
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/8 14:33, Qu Wenruo wrote:
> [BACKGROUND]
> 
> When committing a transaction, we will update block group items for all
> dirty block groups.
> 
> But in fact, dirty block groups don't always need to update their block
> group items.
> It's pretty common to have a metadata block group which experienced
> several CoW operations, but still have the same amount of used bytes.
> 
> In that case, we may unnecessarily CoW a tree block doing nothing.
> 
> [ENHANCEMENT]
> 
> This patch will introduce btrfs_block_group::commit_used member to
> remember the last used bytes, and use that new member to skip
> unnecessary block group item update.
> 
> This would be more common for large fs, which metadata block group can
> be as large as 1GiB, containing at most 64K metadata items.
> 
> In that case, if CoW added and the deleted one metadata item near the end
> of the block group, then it's completely possible we don't need to touch
> the block group item at all.
> 
> [BENCHMARK]
> 
> To properly benchmark how many block group items we skipped the update,
> I added some members into btrfs_tranaction to record how many times
> update_block_group_item() is called, and how many of them are skipped.
> 
> Then with a single line fio to trigger the workload on a newly created
> btrfs:
> 
>    fio --filename=$mnt/file --size=4G --rw=randrw --bs=32k --ioengine=libaio \
>        --direct=1 --iodepth=64 --runtime=120 --numjobs=4 --name=random_rw \
>        --fallocate=posix
> 
> Then I got 101 transaction committed during that fio command, and a
> total of 2062 update_block_group_item() calls, in which 1241 can be
> skipped.
> 
> This is already a good 60% got skipped.
> 
> The full analyse can be found here:
> https://docs.google.com/spreadsheets/d/e/2PACX-1vTbjhqqqxoebnQM_ZJzSM1rF7EY7I1IRbAzZjv19imcDHsVDA7qeA_-MzXxltFZ0kHBjxMA15s2CSH8/pubhtml
> 
> Furthermore, since I have per-trans accounting, it shows that initially
> we have a very low percentage of skipped block group item update.
> 
> This is expected since we're inserting a lot of new file extents
> initially, thus the metadata usage is going to increase.
> 
> But after the initial 3 transactions, all later transactions are have a
> very stable 40~80% skip rate, mostly proving the patch is working.
> 
> Although such high skip rate is not always a huge win, as for
> our later block group tree feature, we will have a much higher chance to
> have a block group item already COWed, thus can skip some COW work.
> 
> But still, skipping a full COW search on extent tree is always a good
> thing, especially when the benefit almost comes from thin-air.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> [Josef pinned down the race and provided a fix]
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---

Changelog:

v2:

- Add a new benchmark

   I added btrfs_transaction::total_bg_updates and skipped_bg_updates
   atomics, the total one will get increased everytime
   update_block_group_item() get called, and the skipped one will
   get increased when we skip one update.

   Then I go trace_printk() at btrfs_commit_transaction() to
   print the two atomics.

   The full benchmark is way better than I initially though, after
   the initial increase in metadata usage, later transactions all
   got a high percentage of skipped bg updates, between 40~80%.

- Thanks Josef for pinning down and fixing a race

   Previously, update_block_group_item() only access cache->used
   once, thus it doesn't really need extra protection.

   But now we need to access it at least 3 times (one to check if
   we can skip, one to update the block group item, one to update
   commit_used).

   This requires a lock to prevent the cache->used changed halfway,
   and lead to incorrect used bytes in block group item.

Thanks,
Qu

>   fs/btrfs/block-group.c | 20 +++++++++++++++++++-
>   fs/btrfs/block-group.h |  6 ++++++
>   2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index e7b5a54c8258..0df4d98df278 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2002,6 +2002,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
>   
>   	cache->length = key->offset;
>   	cache->used = btrfs_stack_block_group_used(bgi);
> +	cache->commit_used = cache->used;
>   	cache->flags = btrfs_stack_block_group_flags(bgi);
>   	cache->global_root_id = btrfs_stack_block_group_chunk_objectid(bgi);
>   
> @@ -2693,6 +2694,22 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
>   	struct extent_buffer *leaf;
>   	struct btrfs_block_group_item bgi;
>   	struct btrfs_key key;
> +	u64 used;
> +
> +	/*
> +	 * Block group items update can be triggered out of commit transaction
> +	 * critical section, thus we need a consistent view of used bytes.
> +	 * We can not direct use cache->used out of the spin lock, as it
> +	 * may be changed.
> +	 */
> +	spin_lock(&cache->lock);
> +	used = cache->used;
> +	/* No change in used bytes, can safely skip it. */
> +	if (cache->commit_used == used) {
> +		spin_unlock(&cache->lock);
> +		return 0;
> +	}
> +	spin_unlock(&cache->lock);
>   
>   	key.objectid = cache->start;
>   	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
> @@ -2707,12 +2724,13 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
>   
>   	leaf = path->nodes[0];
>   	bi = btrfs_item_ptr_offset(leaf, path->slots[0]);
> -	btrfs_set_stack_block_group_used(&bgi, cache->used);
> +	btrfs_set_stack_block_group_used(&bgi, used);
>   	btrfs_set_stack_block_group_chunk_objectid(&bgi,
>   						   cache->global_root_id);
>   	btrfs_set_stack_block_group_flags(&bgi, cache->flags);
>   	write_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
>   	btrfs_mark_buffer_dirty(leaf);
> +	cache->commit_used = used;
>   fail:
>   	btrfs_release_path(path);
>   	return ret;
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index f48db81d1d56..b57718020104 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -84,6 +84,12 @@ struct btrfs_block_group {
>   	u64 cache_generation;
>   	u64 global_root_id;
>   
> +	/*
> +	 * The last committed used bytes of this block group, if above @used
> +	 * is still the same as @commit_used, we don't need to update block
> +	 * group item of this block group.
> +	 */
> +	u64 commit_used;
>   	/*
>   	 * If the free space extent count exceeds this number, convert the block
>   	 * group to bitmaps.
