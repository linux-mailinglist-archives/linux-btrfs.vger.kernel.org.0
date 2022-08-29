Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DD35A5691
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Aug 2022 23:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiH2Vz6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Aug 2022 17:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiH2Vz5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Aug 2022 17:55:57 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20075.outbound.protection.outlook.com [40.107.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8885D580A5
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Aug 2022 14:55:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEmqjRXQE/Vnjs9Dl06l/ilZinw1RkhvL9OwKZQWywIQg4OOhsEV7OkaoYsKNNopgy1yjDPzFGj/CCBd+mB7v+FoAVb+mBWE7KG8kpseuCFiy2PBy1LFLn/DMQ36s4v/rDAzI1dd8c7fCClVepL6jd16nqauwTu/GNm44k5Te4FUTECjzdIF/WxkDF/3U0W8UPL8EsbJg+c9Nqps89aJfHWSTKWCt1F6sg8hu3BDEDBEO/h+v4ODLVTTC6SNhKzF5LH6SY/r5ypahFtBnJxcfjwXCqoueo7kpczuqMPsYpeti2jmQc2ln+DhdbWv6IuogL9b+kr/KPmb9t85Kw+E+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2qa9iDRniQ9saC9sfDMP7bL4RFqtkZ6sHmOMmVUfU0=;
 b=JjB64UL1UKyyGl4KNaJxbyqGiKXY2IU9oz9cR6WNFMpuLVObftUUWcwWN04Xo7fg54juGvzFkjCYyB5+RPITAgkG5vdURIIIy+GoKAsJtFFz89n5uNGpkhDcg3cctqapwo05T3F1X34DR2czYehkrbS80kNgpXD5ypCnzWk83c4oR6QuCafMu7+wL9RJaAKtcgK5kvhEw0WeqrITDN9Z335IY9Jfd9xD+NQ2IUGgzGQk7n8RIxvHdxMgc6JAiC3z7VLAEyFRu2sLPstCAQI3/gw+KMHdmTQsYM/qYGmuymqIiddLgDKtcPK5L1qcbSoSBezDxwtLWeWaqmzH9TPd4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2qa9iDRniQ9saC9sfDMP7bL4RFqtkZ6sHmOMmVUfU0=;
 b=wAjDtibMHXZanhj1fP/h465WG1X2GLsZZq7EjhobGvg7OhiBnjCqzYBGMQvXmgQ8DMSpzPL9z8OTKFQBwnonDrvrKUFcED3BfAK7FwGYy9CK8qmzTKYQZoSapPt3gjU4eo7JqI/U6u1OANuUelpXHVvUvbwGixe+gdHOblgaGR1tDRmFaji6z/kGTRPcZUorc5QtttGukyNBqUme7UBlcatvFs2yBtphFHZV7KIQhJogk1lUdczwKYg3hgo64kU1nsKpfKzjWHfELjs4rBbCbIrFCzpjY8k4zTrbsGzQ7ndK0zNnzcGnnPAGgDFamseIXt0J+XLlmvNJfkRUsXAZ/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 21:55:52 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::987c:9190:1b0:f3ab]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::987c:9190:1b0:f3ab%5]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 21:55:52 +0000
Message-ID: <6e4f65b7-2482-866b-fbfc-ea136910ccb7@suse.com>
Date:   Tue, 30 Aug 2022 05:55:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH V2] Make btrfs_prepare_device parallel during mkfs.btrfs
To:     Li Zhang <zhanglikernel@gmail.com>, linux-btrfs@vger.kernel.org
References: <1661697000-18809-1-git-send-email-zhanglikernel@gmail.com>
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <1661697000-18809-1-git-send-email-zhanglikernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::17) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39be345f-95e2-4b99-3c63-08da8a093dd1
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kzaFdUz3JK8WVUksDSTRahK/+EY+cms7p7MAWeyLHAurVi6oZauvKEerxC+JKBa9df50XHAQ7I1BrcL1rWc85RXXcwe1tfSPsHfp/fDRuyZQMK5LfgNkMTWgPlJJLvd/LZsIE6uxUKX+XFLXSQV7QDq9SHMJxz732/oLOUH6NQB/c7yWIyXPpNnSXfuZapAiRN39J1Csr+43nJ24yhPhyU7tcYYn7wTNnlOD1sSkMLJZK1tRr+Vs8PGplB+GjYEDkKHOii1u27Cuqymb6YFFUFdyudFFm2biX8SF6D/H/CNwvVZtVcobFoY6TesfQSc8BaeL4/1hN6GmCKFUJUxDfZ0O5Sa2cho7sn28OIF+pg+OubITWMcUrti1ihqK+it54MGTQ77QvXRdC0FjKR9ZPzafxwLRMyxLR2PccLvF04XLvFWaEVN+8zd52vsNsMLS2lr8Lj2NnYAYMetJInMr+xFJGecjWzb1CYxJ9Jd3zGsWg0xIjRa4HTh/HIhCUh2T0rZU2tjYEGsNcvcELI7omqGBCjBoJ4JVqe+DfvdZUaIgwEMnAUXUlyBzqngA1dZ1qYgtmz68TlniLS0G1PJ+/xqjlZAPbAifxW8+XllObI7G1f5KFMEqGieRrlsN6s8Idu0/QSAJqsBoM4xGacinNti9bsDD60H0DBDTiVNYFYoJjxYruh34TnorCxrrtLibNaRsvTsku1KKqsVAJ+F3AeA3DQJ5pap8oVKGhs1JTiNwpnfA5VgdHuZ9JhoCQeLIq5fC9QdJc0ZKy2f/aSbca1Xgle7H+OUoqZWPNkLiJptlEoEQJGGzQgnyJAUgC83E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(39860400002)(346002)(376002)(6512007)(41300700001)(186003)(478600001)(6506007)(53546011)(6666004)(83380400001)(6486002)(2906002)(2616005)(8936002)(5660300002)(66476007)(316002)(31686004)(66556008)(8676002)(66946007)(86362001)(36756003)(31696002)(38100700002)(45980500001)(43740500002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVpMVk5MbDVtbGR5TXJZWnlLdVUreW5TL0VCWlN5MG1aUHZGaTNPYVlnOVgr?=
 =?utf-8?B?RGJWVERiYk5EV3VDNEdqMDd2VGtYWTc0bWFJM3A1QWwzMXAwZDFuVEVhUUR0?=
 =?utf-8?B?eFFnNEczTy9SWDNJUEQwclhVTHVTVWVJcXJ4T3ZHdlcrWHZ3OURnVjFvNEZW?=
 =?utf-8?B?MGh5V0Q4OFd4Qi9qTVJIOHpNUzBpd0thSlVHaDVQWlREU3MxZWw3OXJWUmdF?=
 =?utf-8?B?cnJxb0FCK29lbmk0Q3lqbTlWa05ZdDR2S0diL0RBVXU2MHMzcEY1ZXcyYkRu?=
 =?utf-8?B?OGV2RGlEQzhSUzhaM2xFRU5nMG02NU41Sm8yM1pnQnBvRUp0a0MrOE9CZmtu?=
 =?utf-8?B?OHd6bkFTVlBiMGNzeWVpVE9YZ3BxZVhObEVkUThEYWF6QUhNM1JmU09PSmdK?=
 =?utf-8?B?cEoyMkFFZHlJVnFaMVZiR1k2dzkzbCt1b095bi90d3A1U3ZWUElTcWVCL0du?=
 =?utf-8?B?VnkyUnArWVRSazUrZFBCZGN0bnpCSk5yMXpDaGV0TG1TQ3hjMGhpZHkvekUv?=
 =?utf-8?B?ZURRSFBDYm5IdWd4NWd2TWxodzBaTks3cWd2SmJBWUhjV01QZWJPM2d1OStB?=
 =?utf-8?B?TzVXK25CL2o3VDNJRVlBT2JEZVlyQUJyeGNOcXlZK2tneEcwaXdhNjl0cnFK?=
 =?utf-8?B?UnN3TDZjWVFQSVA0UGUxdGdsQVY3ZmE1aGMvS040TlJDL1dDbHNDNWlyc2Jw?=
 =?utf-8?B?cEtya2VFdkllNHFmR3M4c0l6Ui9oVjYrMGZqOXBnQThQMTlOUDZHaUJwMjgr?=
 =?utf-8?B?ZnJ5UVgwcHlYa1dYUzR4dWVCQi8yR3RCNE5oc3daTXdNWWt0Wmp4QUxvRHIx?=
 =?utf-8?B?SVN2SEMzb3h6SUkrSHNVb0N5WkdVU0VOTkc5OW9qVVI4Mlk5NFBnR0VRZmo3?=
 =?utf-8?B?ZDFaRWpaREE5N3JZOGZnQjRyMmVaV21uOEY2MmZrak5MOWs4YXNnTHp4bVRm?=
 =?utf-8?B?TWVQOW92YWZ2d3dsTC9ORUZtQWpwc2Y1SFRBUllHNkpZNndmMTdPZHY5YnBP?=
 =?utf-8?B?alVEWDh2Um9YTms0ejZSU0Q1QzFwQXhzSkVhSDVyTWhybTJsckh1dTZJYTVY?=
 =?utf-8?B?OG1LMGpJcktaUjdsWVdUclEvbHJBMkVRMk0xUzlHRkNUd0dud2pWYWorMDBu?=
 =?utf-8?B?N09qY1gwYnhFaXU0bHV1alVHaDg4TnE4R0QrMFB1VGNQTERDdVJteHF1QnZm?=
 =?utf-8?B?M3oxRmxIMk1uM01DRU1zZ2RDVHZCRDhrS2h5NGtyTmhIZ0pVOHJSZERydFlI?=
 =?utf-8?B?d0J5QWxJNitrNVc0cE95RUdzOUIycXowZlhjakVMZnhZLzMzc01wK1ZBeXBK?=
 =?utf-8?B?U3k0NVQ2cGJjdjgzNzNrTmNwdUJZdnVaTGhodVhrNUx0QXlMTzh2cVZ3ZWpp?=
 =?utf-8?B?cEFGZUQybGU2Nk9jbHRSTUVCSE04NThZNm5Qek52K1RiWmFzMFNncUhiNHBo?=
 =?utf-8?B?VXE1eUZ5WVV1TmhGK3pTa0xUTHNHK2EyTDVUclZIeGN2ZUZyVkFiQ2RQN0FX?=
 =?utf-8?B?eWpsTVBhdjZkSDEyRzN3ZUU4VlVuOXVWaDZwQkEzMS9KdTZ1dS81eHdPVW5S?=
 =?utf-8?B?cnptNTgxWnFkdUpOZFhqVmd0QTVFUTdRUThNWTRvbE1CSnc3R21RQTViWjdO?=
 =?utf-8?B?UHE4NGJSWTJQb3ZTRjJFcjRWTXJEMkZ1eEs1bm5zUVBxUy9SeW85OHJkRkNs?=
 =?utf-8?B?QjVPMHlIU21ONnQvQjM5aUl5bkdpYzZ6MXRuaVBHS1dUdDhzYzR1NEVCeXls?=
 =?utf-8?B?TEY0R0tDd0Urbm50RHIvQlJ3OHQ5eFNwMFJOVlFETHlLSkFiLzA1MEVmOXZw?=
 =?utf-8?B?a2JVNkF4blFjZ2FGUWpBOEUzUG44SmhhTHZycmErMXBhRzNndXVGS3F6aitX?=
 =?utf-8?B?SHdwaXhKSHdMbU9PVFR3SXFyNDhDdEZnYlhhQXBWemZ2N01od3pTSXk0RG9J?=
 =?utf-8?B?QXBTWWFmWStLeWtPbXcwd3oveFN3TVVjZWgvZkNjMVFsVWdHZHRZc0JqbHdI?=
 =?utf-8?B?RGVEOXRic3V3SXgrNm1CYWpxcFRObFppOXlIekFRSXI5UUxnaEw5NVRWUHZG?=
 =?utf-8?B?WlRpdVdMK1g0RmF2QzZmZjM4ZEgzTFpLdEt5SHBFY205NE9DcWRsZWsvVnNC?=
 =?utf-8?B?c0g5RHk1MGU3dGMyQVFVY2Q3Rkh2UU9GYUFCZW9WdmVGUUcrbTNCTzU2eDN6?=
 =?utf-8?Q?yFPMJs51hNtwJo74r8wUizk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39be345f-95e2-4b99-3c63-08da8a093dd1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 21:55:52.5306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHu6v9mocZgCIsEciNzdkkcg6qY24/Bu9EUv//RAhjSmEAGg5Qf0dJ+xWcb2L/R1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7586
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/28 22:30, Li Zhang wrote:
> [enhancement]
> When a disk is formatted as btrfs, it calls
> btrfs_prepare_device for each device, which takes too much time.
> 
> [implementation]
> Put each btrfs_prepare_device into a thread,
> wait for the first thread to complete to mkfs.btrfs,
> and wait for other threads to complete before adding
> other devices to the file system.
> 
> [test]
> Using the btrfs-progs test case mkfs-tests, mkfs.btrfs works fine.
> 
> But I don't have an actual zoed device,
> so I don't know how much time it saves, If you guys
> have a way to test it, please let me know.
> 
> Signed-off-by: Li Zhang <zhanglikernel@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
> Issue: 496
> 
> V1:
> * Put btrfs_prepare_device into threads and make them parallel
> 
> V2:
> * Set the 4 variables used by btrfs_prepare_device as global variables.
> * Use pthread_mutex to ensure error messages are not messed up.
> * Correct the error message
> * Wait for all threads to exit in a loop
> 
>   mkfs/main.c | 132 +++++++++++++++++++++++++++++++++++++++++++-----------------
>   1 file changed, 95 insertions(+), 37 deletions(-)
> 
> diff --git a/mkfs/main.c b/mkfs/main.c
> index ce096d3..b111f12 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -31,6 +31,7 @@
>   #include <uuid/uuid.h>
>   #include <ctype.h>
>   #include <blkid/blkid.h>
> +#include <pthread.h>
>   #include "kernel-shared/ctree.h"
>   #include "kernel-shared/disk-io.h"
>   #include "kernel-shared/free-space-tree.h"
> @@ -60,6 +61,20 @@ struct mkfs_allocation {
>   	u64 system;
>   };
>   
> +static bool zero_end;
> +static bool discard;
> +static bool zoned;
> +static int oflags;
> +
> +static pthread_mutex_t prepare_mutex;
> +
> +struct prepare_device_progress {
> +	char *file;
> +	u64 dev_block_count;
> +	u64 block_count;
> +	int ret;
> +};
> +
>   static int create_metadata_block_groups(struct btrfs_root *root, bool mixed,
>   				struct mkfs_allocation *allocation)
>   {
> @@ -969,6 +984,30 @@ fail:
>   	return ret;
>   }
>   
> +static void *prepare_one_dev(void *ctx)
> +{
> +	struct prepare_device_progress *prepare_ctx = ctx;
> +	int fd;
> +
> +	fd = open(prepare_ctx->file, oflags);
> +	if (fd < 0) {
> +		pthread_mutex_lock(&prepare_mutex);
> +		error("unable to open %s: %m", prepare_ctx->file);
> +		pthread_mutex_unlock(&prepare_mutex);
> +		prepare_ctx->ret = fd;
> +		return NULL;
> +	}
> +	prepare_ctx->ret = btrfs_prepare_device(fd,
> +		prepare_ctx->file, &prepare_ctx->dev_block_count,
> +		prepare_ctx->block_count,
> +		(bconf.verbose ? PREP_DEVICE_VERBOSE : 0) |
> +		(zero_end ? PREP_DEVICE_ZERO_END : 0) |
> +		(discard ? PREP_DEVICE_DISCARD : 0) |
> +		(zoned ? PREP_DEVICE_ZONED : 0));
> +	close(fd);
> +	return NULL;
> +}
> +
>   int BOX_MAIN(mkfs)(int argc, char **argv)
>   {
>   	char *file;
> @@ -984,7 +1023,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	u32 nodesize = 0;
>   	u32 sectorsize = 0;
>   	u32 stripesize = 4096;
> -	bool zero_end = true;
> +	zero_end = true;
>   	int fd = -1;
>   	int ret = 0;
>   	int close_ret;
> @@ -993,11 +1032,10 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	bool nodesize_forced = false;
>   	bool data_profile_opt = false;
>   	bool metadata_profile_opt = false;
> -	bool discard = true;
> +	discard = true;
>   	bool ssd = false;
> -	bool zoned = false;
> +	zoned = false;
>   	bool force_overwrite = false;
> -	int oflags;
>   	char *source_dir = NULL;
>   	bool source_dir_set = false;
>   	bool shrink_rootdir = false;
> @@ -1006,6 +1044,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	u64 shrink_size;
>   	int dev_cnt = 0;
>   	int saved_optind;
> +	pthread_t *t_prepare = NULL;
> +	struct prepare_device_progress *prepare_ctx = NULL;
>   	char fs_uuid[BTRFS_UUID_UNPARSED_SIZE] = { 0 };
>   	u64 features = BTRFS_MKFS_DEFAULT_FEATURES;
>   	u64 runtime_features = BTRFS_MKFS_DEFAULT_RUNTIME_FEATURES;
> @@ -1428,29 +1468,49 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   		goto error;
>   	}
>   
> -	dev_cnt--;
> +	t_prepare = calloc(dev_cnt, sizeof(*t_prepare));
> +	prepare_ctx = calloc(dev_cnt, sizeof(*prepare_ctx));
> +
> +	if (!t_prepare || !prepare_ctx) {
> +		error("unable to alloc thread for preparing dev");
> +		goto error;
> +	}
>   
> +	pthread_mutex_init(&prepare_mutex, NULL);
> +	zero_end = zero_end;
> +	discard = discard;
> +	zoned = zoned;
>   	oflags = O_RDWR;
> -	if (zoned && zoned_model(file) == ZONED_HOST_MANAGED)
> -		oflags |= O_DIRECT;
> +	for (i = 0; i < dev_cnt; i++) {
> +		if (zoned && zoned_model(argv[optind + i - 1]) ==
> +			ZONED_HOST_MANAGED) {
> +			oflags |= O_DIRECT;
> +			break;
> +		}
> +	}
> +	for (i = 0; i < dev_cnt; i++) {
> +		prepare_ctx[i].file = argv[optind + i - 1];
> +		prepare_ctx[i].block_count = block_count;
> +		prepare_ctx[i].dev_block_count = block_count;
> +		ret = pthread_create(&t_prepare[i], NULL,
> +			prepare_one_dev, &prepare_ctx[i]);
> +		if (ret) {
> +			error("create thread for prepare devices failed, errno:%d", ret);
> +			goto error;
> +		}
> +	}
> +	for (i = 0; i < dev_cnt; i++)
> +		pthread_join(t_prepare[i], NULL);
> +	ret = prepare_ctx[0].ret;
>   
> -	/*
> -	 * Open without O_EXCL so that the problem should not occur by the
> -	 * following operation in kernel:
> -	 * (btrfs_register_one_device() fails if O_EXCL is on)
> -	 */
> -	fd = open(file, oflags);
> -	if (fd < 0) {
> -		error("unable to open %s: %m", file);
> +	if (ret) {
> +		error("unable prepare device:%s.\n", prepare_ctx[0].file);
>   		goto error;
>   	}
> -	ret = btrfs_prepare_device(fd, file, &dev_block_count, block_count,
> -			(zero_end ? PREP_DEVICE_ZERO_END : 0) |
> -			(discard ? PREP_DEVICE_DISCARD : 0) |
> -			(bconf.verbose ? PREP_DEVICE_VERBOSE : 0) |
> -			(zoned ? PREP_DEVICE_ZONED : 0));
> -	if (ret)
> -		goto error;
> +
> +	dev_cnt--;
> +	fd = open(file, oflags);
> +	dev_block_count = prepare_ctx[0].dev_block_count;
>   	if (block_count && block_count > dev_block_count) {
>   		error("%s is smaller than requested size, expected %llu, found %llu",
>   		      file, (unsigned long long)block_count,
> @@ -1459,7 +1519,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	}
>   
>   	/* To create the first block group and chunk 0 in make_btrfs */
> -	system_group_size = zoned ?  zone_size(file) : BTRFS_MKFS_SYSTEM_GROUP_SIZE;
> +	system_group_size = zoned ? zone_size(file) : BTRFS_MKFS_SYSTEM_GROUP_SIZE;
>   	if (dev_block_count < system_group_size) {
>   		error("device is too small to make filesystem, must be at least %llu",
>   				(unsigned long long)system_group_size);
> @@ -1558,14 +1618,10 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   		goto raid_groups;
>   
>   	while (dev_cnt-- > 0) {
> +		int dev_index = argc - saved_optind - dev_cnt - 1;
>   		file = argv[optind++];
>   
> -		/*
> -		 * open without O_EXCL so that the problem should not
> -		 * occur by the following processing.
> -		 * (btrfs_register_one_device() fails if O_EXCL is on)
> -		 */
> -		fd = open(file, O_RDWR);
> +		fd = open(file, oflags);
>   		if (fd < 0) {
>   			error("unable to open %s: %m", file);
>   			goto error;
> @@ -1578,13 +1634,11 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   			close(fd);
>   			continue;
>   		}
> -		ret = btrfs_prepare_device(fd, file, &dev_block_count,
> -				block_count,
> -				(bconf.verbose ? PREP_DEVICE_VERBOSE : 0) |
> -				(zero_end ? PREP_DEVICE_ZERO_END : 0) |
> -				(discard ? PREP_DEVICE_DISCARD : 0) |
> -				(zoned ? PREP_DEVICE_ZONED : 0));
> -		if (ret) {
> +		dev_block_count = prepare_ctx[dev_index]
> +			.dev_block_count;
> +
> +		if (prepare_ctx[dev_index].ret) {
> +			error("unable prepare device:%s.\n", prepare_ctx[dev_index].file);
>   			goto error;
>   		}
>   
> @@ -1763,12 +1817,16 @@ out:
>   
>   	btrfs_close_all_devices();
>   	free(label);
> -
> +	free(t_prepare);
> +	free(prepare_ctx);
>   	return !!ret;
> +
>   error:
>   	if (fd > 0)
>   		close(fd);
>   
> +	free(t_prepare);
> +	free(prepare_ctx);
>   	free(label);
>   	exit(1);
>   success:
