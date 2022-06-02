Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14E453B430
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 09:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbiFBHN7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 03:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbiFBHN6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 03:13:58 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088C31091
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 00:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1654154034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=srzN/gkBnFeXO6VaDMbhVDVNpKt4wg2KqNwMBgdO/ew=;
        b=JnUnlEE6c9vrrCWTYHmjgyf9a3LuVFOkO3P4gmKUvMrxrTYZZAiGHXi1cuQg2LWh/yAumy
        b0+YnZJpPyjQ85kTE6VHOZhBd9DldZFjOxaqpWb6qLByHHjNB170uQlMGsD2HTRd08z+ni
        eTGAG7MgMEurOXl6oO0uuEjrX24gPZU=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2051.outbound.protection.outlook.com [104.47.8.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-28-9NAm96QjPDGhQnTr1seIBw-1; Thu, 02 Jun 2022 09:13:53 +0200
X-MC-Unique: 9NAm96QjPDGhQnTr1seIBw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lN3ERHzHY5oH/JOOmSOBbc+JQkHE6pebYwibCqkYc0SqEChu/0AUyiKZp9sEf8VQEfLzBdiTo4TortdO8Zm6jOn9jYN3xqHu4U/s3kx2DsnUeFWdQ8jW5f/acvBWJSDUU50gZu9vxcbJfEoztRD53I++BQCJI+5U4tkYbDIzhevwnnhcGEDG1JFtYRnE+0+3snLNC3SRTphdg+Z8ZvY8eIn+g+1hDW6n0UOJT2sMV/8DSIk0JqfOJVErpngmJ30fYPFZ/YyMs53vMtc/4r0fZQqH5gsCEH1AgRfyjtCmBNdZXlPNP4n/MKZGuV6hmx1QEMgLjF4OP3rsHrIOykhlSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srzN/gkBnFeXO6VaDMbhVDVNpKt4wg2KqNwMBgdO/ew=;
 b=Pqj4vXjY9otaZ4OIjLMSb08J2HbzmuDCA0t7E7psCJaWSEFWwrPbSmXtaxZJIg6bUKaVomKbyQSBxXjEqqjCf90fB63sN7oJD4ye9fLA9o3qbG7Mb5opaFPxWG5VXFHb9JsL2xCiJk9eeHKG5UX7TD1Re66gOxUmsmYpTS+o6YpfbcNIipPs+iQzzjCky2LZJXyIWOBGObj6eAcCsylFqOAXQKlVwX+fbjmn7IUp6KvlpGniIR0vunif6BVpD5XW3Z9iOnv1ZF2zdFagr6Zx6g/GfdwB4FR64m82PlLicpMEkuUZ8RxYYjTMo4U622A+imDnGO1j+2uIfovIwp5fpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by VI1PR04MB5855.eurprd04.prod.outlook.com (2603:10a6:803:de::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 2 Jun
 2022 07:13:50 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::a57d:280a:598a:85bf]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::a57d:280a:598a:85bf%9]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 07:13:50 +0000
Message-ID: <dffdab18-5c5c-564f-00f2-c73a85c2fb76@suse.com>
Date:   Thu, 2 Jun 2022 15:13:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/5] btrfs: avoid double for loop inside
 __raid56_parity_recover()
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <cover.1654153382.git.wqu@suse.com>
 <93d3f15f66dab25c4591f93fc6dd928c2d29355d.1654153382.git.wqu@suse.com>
In-Reply-To: <93d3f15f66dab25c4591f93fc6dd928c2d29355d.1654153382.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0014.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::27) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7257ffd5-b915-4fe8-ea4c-08da446771bd
X-MS-TrafficTypeDiagnostic: VI1PR04MB5855:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB5855AD1CED7EA3E55FBD8271D6DE9@VI1PR04MB5855.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LVDObKiff6GHn6puyR+77PnN73Ysi+7WUk2oj+DVOfd00gLZikoWEJeJhDzEkazD/R8S5XFHGNkb3OTg4wGuGfE/cGP/zGkPQnF9wGc+jkAuH3tluTvRoB5N+kRxfhggE+NuI0DBlwjetQDhClC9l4xNSu58RVok1UnlUaR9jy3tPvdFij+qle9mzabWruMXxftZHAX84hsC4pamOrK0C/PW9cdqQzr5lt0w7lrjL1VVmEm7lC0+eLfdmrtXaBdwfS/bzOZpjcMneY3Am2SFtYESZ8JyW4ots/2kgNQYSqfAJsT/u2RhHaSH9JS+bcJ4GjbuzMnvs1xegPsTh08n14hZocICvgev+xeKofZCUgV7kbN/ZCwdoPcg2+9V4JCoNqqrXnQRuHnUhi0SOo7D8Es1Q+nLZ47uBKiNWv1lDSBIZsxH+zgV/EExoYJlZNrxyJ94jCMOcwSHPgC/3vB6jPN7ZZYEayhQEZuFoux/jERdp+G6Sa5tydJ9Ad5j6AbC8InkugP+IDMn1pr/F01L7SmaucFcVTtD9rZxf4NGh3WyZw7ChsaZHYDDDqQUNkaZzfsxPzISaVpmREpawj4U9ey4QxVhoH609Ao69nb7sWvy+TcHWysbGs+w0KA+2HoVOO91zgZaKlS4v0Rx/YxoYW3a7IQH4GQsZxDmATt92JIfoq79xTz0oi6PV4A0OOvlvstHb41HNRMQGxbha3KjT317b/1aP+QVMYW0kaRLzCM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(2906002)(6512007)(316002)(186003)(2616005)(6666004)(53546011)(83380400001)(36756003)(8936002)(31686004)(5660300002)(6486002)(86362001)(8676002)(31696002)(66946007)(66556008)(66476007)(6916009)(38100700002)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eW41MlhHRGF3Z2FDYzhtWVd1cTFMUmtxZkFDT1hEczZyaVd5N0NQcXh1N09W?=
 =?utf-8?B?d2hTbE9PdEd6b1RFVTlDRGJ3ZlZvZkRJd2RMbnpIWitQT0ZkWEhuK2h5NDNk?=
 =?utf-8?B?WTYwME9YT0JwZ2dHS0ExTXgwalpDWVJ0Q1U5WDJWRmFCei85dGxSRFRaMVA5?=
 =?utf-8?B?VjZkRDNRQ0Fhd0JRSnI4cTZuWTVoTUNVSjNabnBGWEFQWE1ZU0ZxbEt3ZDdD?=
 =?utf-8?B?bUZwdGo4amZJSEN0RlRDb0NpdzFJU3pmYVNxU1VtcHF0RG5hc3MyUXlzWHNY?=
 =?utf-8?B?UStmQkh0ZlQ3UDMycGE3UVY0WERxTHEwc25VRERETDJwbXFicHZMR0FVUHRF?=
 =?utf-8?B?ZHdzMG1iUXRsaE0xYXZuVWw2RytUem9nb1B2MStseDdnS0lxK3lnMlhLa0cx?=
 =?utf-8?B?dEFQK1RxeVVjOE5jM3dvOHplR0FPZVUwMllCNWp0VklQNDFZWmk0cUtTZHM3?=
 =?utf-8?B?aHZJVDBuaUx3dlBFTjh2UGFGazFtcFFNRTJ3R0F1WG9MTHAyM2xvcDZVaTJv?=
 =?utf-8?B?bmNuVkdMR0pweHBCa3VjREpwL1hVMHJpSU9IQ2pGeEl6Z0tYVCtZQmFPa21P?=
 =?utf-8?B?UEZnTzNJQlBzeVZHd1B2WGUrV2xBQW9WZk42S2tiNldLUHVza3c3SkgvYU1Z?=
 =?utf-8?B?TG9uVTE4Q0FiWitDZlEreFlzQTNrMHpFRXhYaVY3V0Z1Um1Tenl5TEl5NjVx?=
 =?utf-8?B?K0FFWDZMWmtMUkV3dGsvL1VUVGtiZUI0bDBuano4dEZDemxYVjREUjRZc0Zs?=
 =?utf-8?B?ZnkyQzZFSlh6ZjgrL2xkT2pwTU94Y05IUndzL3gyUisrb3d2WjlKVGpaOEZG?=
 =?utf-8?B?cmJ6cjBYbFBKZVloWXZ4cVRXenA3c28wcitjVFNmR0tSMEVaNi9RSXpwSlRW?=
 =?utf-8?B?bkM5cTIyVWJJRzhYZVk4UmYrZjBOWEhzOTRXMitaVngyMCtRVlBQcExxeEpL?=
 =?utf-8?B?RzVEMm05U1lFbGQrZlh4Ulcwc3lmWnVBd2tacnVSMERlL3pNQXh3U0xMTWMy?=
 =?utf-8?B?MWxoNm43cHlkckRNZGN5UDBINnhwOURoM0VyWFZCRWVQRmNGbkk5ZFJpY3li?=
 =?utf-8?B?QzY3WjA4d09meEZvRXJtS252UnJzMkt3dWJBVE5rNDR3dGdzNjVzU0EwNGVV?=
 =?utf-8?B?N21qbC9tQTZFUGcyTjUraVlqTisySFpSdWlDRTJ5K201NE9QYTZYWC93em0x?=
 =?utf-8?B?SVJEcm9Ka0g3c1ZYTmRjS3dVbnhlbHEvZG1YaW5MTE80MEQxNkdjZFZLUnlh?=
 =?utf-8?B?eFZYWnNMT0VGL2VWbENQWUx6VktISU9MTGxESTlqR3dZZ05UeWVTYUJYTDda?=
 =?utf-8?B?WGV0YzVQU3FDWnlaazBSMnpreFZYRm9KV3JRRWJCbXp6M2dKNlgxTlFSMzNu?=
 =?utf-8?B?b2ZOSG9XeDNibmIwYmtCcFY0OUVReWk0MWV5LzQxbDU5N0luK3Q1NEZWUWdQ?=
 =?utf-8?B?VWRxL1VRNkxDN29KbW1GaDFEMXVRT05UaTlRMFh6ZUs3S3ZMZXkxZ0djQWUr?=
 =?utf-8?B?Q3RQRHhaZjMycklMWEhFTHRTTTdvR0Z0S2Jiblp4TDNDVElJK2JlSXJ1d3pG?=
 =?utf-8?B?RHBzNWZFZG1pZE5ScU9sa1RSa3VVa1UxQ0s0MjZMeStidEY3bTFrMzZoVHNE?=
 =?utf-8?B?N1p4bjc1VHV4Y2NtWThUUmoyV0FWK0M1NzJsUGpjY3dVaSttMDJVZGM5K2NR?=
 =?utf-8?B?RkZtM1k4R3k0YmVVVEFZamRUUVYxY285SFM5YzBvSUQ5ckFpZklhVW9PTVMz?=
 =?utf-8?B?aFpJVnBVRjJWTTNqRDdtOG9GOEE3RmE5a1NvUmtFOHB5RnVTSW5rZDZQdHRi?=
 =?utf-8?B?bUZXSnBLUGw5bWlXK2IzZzBKOVhIRDNBbU9vd2UzTlJ3M24wS2htejN2ZS9B?=
 =?utf-8?B?OTFXV2pFVDBiV3J6NkpYQm9uWFkvc2huQ0Fvb3lHWG9JL01nNDRCYUs3enlk?=
 =?utf-8?B?ZW1ZTklHMU5DL1ZYOEhrTHNlNXFGczM5VURhMGt6SFpnY294RzhqZmZ2bG1I?=
 =?utf-8?B?VE50RStCMGp5a2E1SGMxMXFUYkNUOG5Yd0NIZ3BzSWNCelYvTXd2MTNXb3BS?=
 =?utf-8?B?amFpYXduN3BzWWo2ZjF5MHJSUlpLZi8rRXBEcHp1OThtVitRRWhzbkozNUlL?=
 =?utf-8?B?QjBtMTBzYnVDQWRTVU5wR0lkVFlZeEFPVWFpV2ZMMk14Wk10Y1JzbmNCVW5Z?=
 =?utf-8?B?UFdUMjEvVkFEcFBoL3dic3Q3TjU2TUhZSzBzMDlPMmZheWJNbG9hYnNCamdQ?=
 =?utf-8?B?OEt6YVp6YWRNTXVLSGMyNFFSNmljOHllYjgyNVM3MkwrUkxSUHRtcytvS3Yx?=
 =?utf-8?B?QWZMWW5HbUxralJwaC96eUxoUExCM3RFQTY5cmNIQldxcnk5STJiQndvRjhl?=
 =?utf-8?Q?uXqUlfm4Vuqi7fbKoOZc7iAgaR0VmTeOlh+z9?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7257ffd5-b915-4fe8-ea4c-08da446771bd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 07:13:50.8188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9ILgDyEk13iPoLbZHRF3bztlmsyzkmZSxecyiBWONaZACCkiQ/IVSYQTx/ZCMY3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5855
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/2 15:06, Qu Wenruo wrote:
> The double for loop can be easily converted to single for loop as we're
> really iterating the sectors in their bytenr order.
> 
> The only exception is the full stripe skip, however that can also easily
> be done inside the loop.
> Add an ASSERT() along with a comment for that specific case.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/raid56.c | 39 +++++++++++++++++++--------------------
>   1 file changed, 19 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 91b53ef20b0e..7c17f35e0830 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -2127,8 +2127,7 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
>   	int bios_to_read = 0;
>   	struct bio_list bio_list;
>   	int ret;
> -	int sectornr;
> -	int stripe;
> +	int total_sector_nr;
>   	struct bio *bio;
>   
>   	bio_list_init(&bio_list);
> @@ -2144,29 +2143,29 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
>   	 * stripe cache, it is possible that some or all of these
>   	 * pages are going to be uptodate.
>   	 */
> -	for (stripe = 0; stripe < rbio->real_stripes; stripe++) {
> +	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
> +	     total_sector_nr++) {
> +		int stripe = total_sector_nr / rbio->nr_sectors;
> +		int sectornr = total_sector_nr % rbio->nr_sectors;
> +		struct sector_ptr *sector;
> +
>   		if (rbio->faila == stripe || rbio->failb == stripe) {
>   			atomic_inc(&rbio->error);
> +			/* Skip the current stripe. */
> +			ASSERT(sectornr == 0);
> +			total_sector_nr += rbio->nr_sectors - 1;

This should be:
			total_sector_nr += rbio->stripe_nsectors - 1;

And this would cause crash on btrfs/157.

Now I'm not that confident if the refactor makes sense...

Thanks,
Qu
>   			continue;
>   		}
> +		/* The rmw code may have already read this page in. */
> +		sector = rbio_stripe_sector(rbio, stripe, sectornr);
> +		if (sector->uptodate)
> +			continue;
>   
> -		for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++) {
> -			struct sector_ptr *sector;
> -
> -			/*
> -			 * the rmw code may have already read this
> -			 * page in
> -			 */
> -			sector = rbio_stripe_sector(rbio, stripe, sectornr);
> -			if (sector->uptodate)
> -				continue;
> -
> -			ret = rbio_add_io_sector(rbio, &bio_list, sector,
> -						 stripe, sectornr, rbio->stripe_len,
> -						 REQ_OP_READ);
> -			if (ret < 0)
> -				goto cleanup;
> -		}
> +		ret = rbio_add_io_sector(rbio, &bio_list, sector, stripe,
> +					 sectornr, rbio->stripe_len,
> +					 REQ_OP_READ);
> +		if (ret < 0)
> +			goto cleanup;
>   	}
>   
>   	bios_to_read = bio_list_size(&bio_list);

