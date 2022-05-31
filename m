Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB530538F27
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 May 2022 12:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343538AbiEaKnJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 06:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343534AbiEaKnI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 06:43:08 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9B222BD8
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 03:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1653993784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hV2ruYFUwQ35ytLGuJIDREo4ij2+s2BM9JbXHZHOLV8=;
        b=DAVJfPGE4VxN9zXMOApSx/RgC9F0L6/LoXWoZh5fAyEIg3MiDRmdmfU5BQhnk8EPXiiEps
        rZdJOOfoUesW4sLFvtG6SCQPd1JTF6gh2VEHKGv8rYJhVBZeanTyS/OUdXGe/eq/eCu8OM
        cCaWah8yziW4KWPps6RUGAtKNunVJwg=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2105.outbound.protection.outlook.com [104.47.18.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-19-4QnRxHgrO_W8vk6WrMriZA-1; Tue, 31 May 2022 12:43:03 +0200
X-MC-Unique: 4QnRxHgrO_W8vk6WrMriZA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8E3UQbI/rlAp/6o7CqrdHDaftAtPK1ktlqHpE+bjZ3zjqk2bZOdnn+TNwsz2js6YmM1G6GilO73+VXYOZcjKMVikvslDNvRW8RIt0XxSayowbF2B1HJuuxSxuw8NWbr929w0/3fPLL/M879gJDT+6VWSqO47IeAus8gOeZyjgdZ4ic5d1fgt2Qewjfzr8H+kDmGV/zPzwpWnaxI9nLMbScY0lO6R84m71DkpavPfNVXMK6vlQf7atpXZofVmPr66Rds0NQ90ICXuId9EaJyKbXiTnQddSpWtqgb1pu4d+jx0ngcSoe3GdNTqxpRHGHLMQsfnbznGJ7aKJRj3bk6IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hV2ruYFUwQ35ytLGuJIDREo4ij2+s2BM9JbXHZHOLV8=;
 b=DPi3FaV0GBoHB4jTLfiI4y/1vxF4V8wsIIhkovSsbbBl9eyEAMJp1ruCJpCUd/5oo9j/jRwF/2fQzH+kIIcu3rvoWwMWWtBD8kIFstt1GnzFpOD+nMBATtdVTpNdA6FCsJIrZ7+fuzZNPi6vpkBvcowH6kj/VRlkC2G0sxlAU4zarrBKYd7qhhbc8z84gwKo5HSUUpDd6gMDdG+fiiH0A+s6Mak5hN+A2Ot+kJGN90Uod8mxKpHkcgvR6ETcELj88TM+ktXMIAnkuEjYKZ6mDyhcrLdF+Llka7cFZyKjnNCsPVYPQoVd+kI6ugs6brK5ZbkRLVNxK5dgs5BvVHeEtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by VI1PR04MB5808.eurprd04.prod.outlook.com (2603:10a6:803:e4::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Tue, 31 May
 2022 10:43:02 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::a57d:280a:598a:85bf]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::a57d:280a:598a:85bf%9]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 10:43:02 +0000
Message-ID: <92b53bec-e34c-75a9-592b-5c6d20902ee1@suse.com>
Date:   Tue, 31 May 2022 18:42:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 3/3] btrfs: only write the sectors in the vertical stripe
 which has data stripes
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <cover.1653636443.git.wqu@suse.com>
 <9ad6484a6896b6f15b41daa85ff5f10337acaef5.1653636443.git.wqu@suse.com>
In-Reply-To: <9ad6484a6896b6f15b41daa85ff5f10337acaef5.1653636443.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:a03:331::9) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 675bf0bd-925b-4388-18f6-08da42f255c1
X-MS-TrafficTypeDiagnostic: VI1PR04MB5808:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB5808422EF26A979D986409C2D6DC9@VI1PR04MB5808.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: njDlKXO5GaOAl+YZT37dDYhU+/Oo1IbXdY6OR1buXnJmvfH+1HahT4hOfuMNNBolHrwQuHxcICQA+tiF/ntzIpz3H39xs24rrEdW7xpk5pzr/u3mQQGKwx4k82NfvRHmodkHZmuLB1Crjq7KgQl4gYj6PetIuqy3Jh+P5yikAOGhFyFsfcUZ02Y2dEmQEO0cpbOVvATW3GnMgYzMBy4ucUnYI0WyswialXXQoQ+d+kiJwBaGWzO8yc0OWuR+437+fOGNrXGD/1hZNZqfX067jpUBaMrM4njLFxdBlLQwhNFBXUPrFBhxIUR9gGNeWshy+56V0UQbG9EPbZH7hLi1dyqjW9OXOgeVpI7oyVS1SsSXDZjGVVdA9YJo7AlNvgBcOdQMbunhcU1Nvtsc+zmYpXFUaiv6nKCLUcPJh9GWwJetwAl5zzkpnV+bQDo9cm6Mzcgz9ZDA4c51xVBYa0DrGPTa803N6EEI6pGwpvOc+6LHiy7M+VPmPA3C28N6Cvn1flzn4mkteQlQVmKv5N8bR1uUGfPXZNJSF3XnDMGrHl+BqlDhuUgJfQZyIbpjZjLwJZR/ASF94ZkjHc5phgnRKVhLhDFD8RsHxFcESVLzi8T1faK56dq81//VrOqWxPZ56cLdD67GquthXK2/ebin/PzHgtIzNprA4bGeGTa663Ql5bpFxhFOVF906I1h5ks8c8RFSANOwFpivkIi+oHm4h7zsFdzvTcN0TGHOZ4vXB4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(508600001)(8676002)(5660300002)(8936002)(38100700002)(31696002)(36756003)(316002)(66946007)(6486002)(31686004)(6916009)(66476007)(66556008)(6512007)(2906002)(6666004)(53546011)(6506007)(186003)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUd6QjNuSkd0WklnR0ZnQzAzd0hnbzdscExxNVhsdFZBUVFTenlWd2FtQWFE?=
 =?utf-8?B?UkNpaE9GdmtqbDBoK0RXL3VWK0g5NkRiWUtQcEtndHRLM1RkMFhHQmh4VkJV?=
 =?utf-8?B?QTlGYVJVVEtQdHlPUDBwQjV4NGxYbEMwQlFLN3FJZHJmUUlLTmkrbk93V2hK?=
 =?utf-8?B?OVptVWhFOUk0ZmZ5SytNb2NvM0hNZGVmMzdMdUtDYXNRRzZ0cW91SXA4R0VG?=
 =?utf-8?B?VWRick55SVJxc2lFODBvQ3ExanMzckV2dWRNTWVjN1VwUmpEdUE4WkNZR3lt?=
 =?utf-8?B?ZjBmSXJnU2FPSzJiNHBIRkxkVEhvR1JmTHhCd0QvcnJTMEhkcEdRZWcwSVha?=
 =?utf-8?B?YVk4c1c2ZTJHWVhHaHJnWGQ5bnJaRHovNmVQbUoyOUV1MXFjaVRKd3dUa05B?=
 =?utf-8?B?WUpGdE5mSXg5K3JEb2FHU3V5aWJTY29hMGpWbGQ4VnN3U1lHWTRzSjc2M1V0?=
 =?utf-8?B?RWoyT2JwOUVFa2wvd2pBNXdjZlVwQ1A4VHZVVVZLOVhidy9RaDRoRjY4U1lr?=
 =?utf-8?B?SU91ZUpoT3NsZ1Q1ajFDd1RFTGprVXhZMzRlZkVxNzRhaDRYTzZmR1FBaGtr?=
 =?utf-8?B?ZVlyRjVpRTBrdG40ZDFhVDJML2VNTkR5NmpoSUROU21yZFcyWFJFdWVEa0Rr?=
 =?utf-8?B?VUY2SFdpVmhVRllVV0dqZEgzSTlNYzhET2liVmZwbDFvYnpaTkhMMW11Zzdx?=
 =?utf-8?B?RE15MHN0dGNjM3huaTFOK1FXTS9PckZGNmpDWTUyZlZ0ZUlwOVJjVERIcDVH?=
 =?utf-8?B?Nlh6Tkd5dlBIaWdmMUxKMlU2dk9NS0Q5b1ZCUUlZSmdlb083dW5kR2l5WCt4?=
 =?utf-8?B?cVZGRkYyUFdxU2FQMjg1VUVHWlNydUdFSWovL0RyTllIdlpTOEFjbUNneEE5?=
 =?utf-8?B?bmw1OHhVWWJxbGhWcDFORVpvQjRJU2IzeUEwdHU0TWlwREtXQks2c2pBMVcy?=
 =?utf-8?B?aDArSlUzSVJmM3B1UUJJRmhCK1NHZy9WRzgrVW9heGxHV2l2Tkt6MnFEZTRl?=
 =?utf-8?B?Vzl1bVQyVHJVNUdOam54TUJycitKSjRsUkFzRlFDTnoxaFI5NE1kNzNweGR5?=
 =?utf-8?B?QUVuYXROMkw3ZFRBUWR4NnV2YkY5Z0dyUVArWS9sMCt6ajg0a2NiaTR4SEpz?=
 =?utf-8?B?LzMxQTlyN2NJT3Y4S0VTT1R4N0NQM1dRaW5ZdXU5S1lkdGFZSW1SVTVzUGNz?=
 =?utf-8?B?V1BXdkphOS9BaGRGOURNWDRuZzhPUEttdDE1WTkxZE9xNTV4NzJCbXRNV3NG?=
 =?utf-8?B?bkFpZ3hidnU0NEFSYjVwcWJQRVd5UWYrRUNnbEU2S0UrbkNGL0FzcW1tSlRt?=
 =?utf-8?B?Mk1YN0hXeWhWMnZMNlUyTWZjcThUQkdTUnpvWEhxZmtzQjJTMjMrWjA4Z0JZ?=
 =?utf-8?B?anRHd1g5YktQbzJFNVFGMUdNeEdXRGQya0RBU1liNFZyYTNvNXFJd05NRXBj?=
 =?utf-8?B?aE5QRWRwM09sTTBDVmgyZGFzTk9tYWFzSWcwWHF4Q3NZTU9kYTcrQmlIRWdS?=
 =?utf-8?B?RFVJWEg1SFlnUWw2MW94NkJxbWRLNFMvWjAvRTY4endoVXRYQWtkSGxlRk03?=
 =?utf-8?B?VGFGM2FxV0R4NlpjZ1VGdjNWMGhZaW8wanN3MGI5YmhXejYwNDI2bEVUSHFZ?=
 =?utf-8?B?Q0tDdHVkME9VT21pOTJXaXdId1dlTjlpcTVEU3lEN1lXeVR2OFBnN1B3UURB?=
 =?utf-8?B?SWtFSzc3WnFoS1VaL05EeStPL1FsOHM4WHNhKzM2MjVuQm9XOWc5S1lQY3dO?=
 =?utf-8?B?Y1NiY2plN2FGeUxXdDJVMVNreVJjQ0xGTHFQOFNKZHB1aTZrSk50YkJFMU5K?=
 =?utf-8?B?WDFOVkdReWd5OVFIYmJTSFF4MjAwaEJtZWQ2WExpNHFESFZKYW1sbzNnZFBU?=
 =?utf-8?B?UDJmTGNNaHlzaE9FcE1PbnlDRlJKU0c2V3RXL0ZsUHRqSXFzTUNuRnZvRXo5?=
 =?utf-8?B?Z0FsOEtuNWxRcHRkY2ZMM29BTEYyNzhvY1IreS8rblJoeUtGMHpubzRNTTlz?=
 =?utf-8?B?YVBBUjJjbytxNlBHWnpROHZYeXB0RTJza2JNdC95NEVRZUpPR1R2VnV1SG5K?=
 =?utf-8?B?cjlzMVBPUnZnTmJsTjl2K0MzVE5JMDFjL1daYWhPSHNtT1hnc3M5RnFYMmJn?=
 =?utf-8?B?di92VDlFRkZXekxGb1crN1NTZTU3VVdLMGxVVE5POVUzV2FDb1FyLytTTTdH?=
 =?utf-8?B?NjNpcHk4b1FBbjQvWGlIWk9PV0tmb2Y0T3VYK3lxVW5CdEFwRkNvYmFmL0lY?=
 =?utf-8?B?TEJScXRTNVVNb0xDKzRoQy9hV1ZjamFYdkxxRCtaalpSeTBvM0pQMTF0bFlH?=
 =?utf-8?B?cEplUzBoaWNGVHowMDIrMTZwVVIwenpsQXIyZ0lMdW5CNWpDUzhCNjFuaWxG?=
 =?utf-8?Q?ldzGeWbZMdSNHbzi1CkD6qjCr49qzH84JuiNK?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 675bf0bd-925b-4388-18f6-08da42f255c1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 10:43:02.0676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dq4a1A70o4pEnd1EWSuFs94Bs5B4PlbjgOgQWtKLYm04yGEsYbOw/+1QeZDaYTHW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5808
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/27 15:28, Qu Wenruo wrote:
> If we have only 8K partial write at the beginning of a full RAID56
> stripe, we will write the following contents:
> 
>                      0  8K           32K             64K
> Disk 1	(data):     |XX|            |               |
> Disk 2  (data):     |               |               |
> Disk 3  (parity):   |XXXXXXXXXXXXXXX|XXXXXXXXXXXXXXX|
> 
> |X| means the sector will be written back to disk.
> 
> Note that, although we won't write any sectors from disk 2, but we will
> write the full 64KiB of parity to disk.
> 
> This behavior is fine for now, but not for the future (especially for
> RAID56J, as we waste quite some space to journal the unused parity
> stripes).
> 
> So here we will also utilize the btrfs_raid_bio::dbitmap, anytime we
> queue a higher level bio into an rbio, we will update rbio::dbitmap to
> indicate which vertical stripes we need to writeback.
> 
> And at finish_rmw(), we also check dbitmap to see if we need to write
> any sector in the veritical stripe.
> 
> So after the patch, above example will only lead to the following
> writeback patter:
> 
>                      0  8K           32K             64K
> Disk 1	(data):     |XX|            |               |
> Disk 2  (data):     |               |               |
> Disk 3  (parity):   |XX|            |               |

With the latest debug patch, it turns out that, this patch is only 
working for the initial several writes into a full stripe.

Since we didn't reset dbitmap after the RMW finished, it will slowly 
degrade into the old behavior.

Will update the patchset to address this soon.

Thanks,
Qu
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/raid56.c | 47 +++++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 43 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index bc1e510b0c12..88640f7e1622 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -392,6 +392,9 @@ static void merge_rbio(struct btrfs_raid_bio *dest,
>   {
>   	bio_list_merge(&dest->bio_list, &victim->bio_list);
>   	dest->bio_list_bytes += victim->bio_list_bytes;
> +	/* Also inherit the bitmaps from @victim. */
> +	bitmap_or(&dest->dbitmap, &victim->dbitmap, &dest->dbitmap,
> +		  dest->stripe_nsectors);
>   	dest->generic_bio_cnt += victim->generic_bio_cnt;
>   	bio_list_init(&victim->bio_list);
>   }
> @@ -1284,6 +1287,9 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
>   	else
>   		BUG();
>   
> +	/* We should have at least one data sector. */
> +	ASSERT(bitmap_weight(&rbio->dbitmap, rbio->stripe_nsectors));
> +
>   	/* at this point we either have a full stripe,
>   	 * or we've read the full stripe from the drive.
>   	 * recalculate the parity and write the new results.
> @@ -1358,6 +1364,10 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
>   		for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++) {
>   			struct sector_ptr *sector;
>   
> +			/* This vertical stripe has no data, skip it. */
> +			if (!test_bit(sectornr, &rbio->dbitmap))
> +				continue;
> +
>   			if (stripe < rbio->nr_data) {
>   				sector = sector_in_rbio(rbio, stripe, sectornr, 1);
>   				if (!sector)
> @@ -1384,6 +1394,10 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
>   		for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++) {
>   			struct sector_ptr *sector;
>   
> +			/* This vertical stripe has no data, skip it. */
> +			if (!test_bit(sectornr, &rbio->dbitmap))
> +				continue;
> +
>   			if (stripe < rbio->nr_data) {
>   				sector = sector_in_rbio(rbio, stripe, sectornr, 1);
>   				if (!sector)
> @@ -1835,6 +1849,33 @@ static void btrfs_raid_unplug(struct blk_plug_cb *cb, bool from_schedule)
>   	run_plug(plug);
>   }
>   
> +/* Add the original bio into rbio->bio_list, and update rbio::dbitmap. */
> +static void rbio_add_bio(struct btrfs_raid_bio *rbio, struct bio *orig_bio)
> +{
> +	const struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
> +	const u64 orig_logical = orig_bio->bi_iter.bi_sector << SECTOR_SHIFT;
> +	const u64 full_stripe_start = rbio->bioc->raid_map[0];
> +	const u32 orig_len = orig_bio->bi_iter.bi_size;
> +	const u32 sectorsize = fs_info->sectorsize;
> +	u64 cur_logical;
> +
> +	ASSERT(orig_logical >= full_stripe_start &&
> +	       orig_logical + orig_len <= full_stripe_start +
> +	       rbio->nr_data * rbio->stripe_len);
> +
> +	bio_list_add(&rbio->bio_list, orig_bio);
> +	rbio->bio_list_bytes += orig_bio->bi_iter.bi_size;
> +
> +	/* Update the dbitmap. */
> +	for (cur_logical = orig_logical; cur_logical < orig_logical + orig_len;
> +	     cur_logical += sectorsize) {
> +		int bit = ((u32)(cur_logical - full_stripe_start) >>
> +			   fs_info->sectorsize_bits) % rbio->stripe_nsectors;
> +
> +		set_bit(bit, &rbio->dbitmap);
> +	}
> +}
> +
>   /*
>    * our main entry point for writes from the rest of the FS.
>    */
> @@ -1851,9 +1892,8 @@ int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc, u32 stri
>   		btrfs_put_bioc(bioc);
>   		return PTR_ERR(rbio);
>   	}
> -	bio_list_add(&rbio->bio_list, bio);
> -	rbio->bio_list_bytes = bio->bi_iter.bi_size;
>   	rbio->operation = BTRFS_RBIO_WRITE;
> +	rbio_add_bio(rbio, bio);
>   
>   	btrfs_bio_counter_inc_noblocked(fs_info);
>   	rbio->generic_bio_cnt = 1;
> @@ -2258,8 +2298,7 @@ int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
>   	}
>   
>   	rbio->operation = BTRFS_RBIO_READ_REBUILD;
> -	bio_list_add(&rbio->bio_list, bio);
> -	rbio->bio_list_bytes = bio->bi_iter.bi_size;
> +	rbio_add_bio(rbio, bio);
>   
>   	rbio->faila = find_logical_bio_stripe(rbio, bio);
>   	if (rbio->faila == -1) {

