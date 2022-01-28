Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7068E49F3B3
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 07:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239308AbiA1GcL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 01:32:11 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:57043 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231443AbiA1GcK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 01:32:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1643351529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FeUkIB5EYYF209svmPNGYa1gdDzSQMXO3+0ufHprWb8=;
        b=mO1oudn9UhdMjuURyr8Vn7ptO1ReQWTLw3bGulXJ30Ta7DRBG2DtkIf2Vmj48UMPVieHnh
        T9vDQTn9H44w7WtGLxPwaXosIhvTay5X7iHWQLZXEB87VhjwkxF79P6P+1kQuv/WQ5ajoG
        5mhWZjWdQ6cW9OM/pT8zoJsi6aTpICY=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2056.outbound.protection.outlook.com [104.47.13.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-8-xns1moKkMzu60X6Olaq9QA-1; Fri, 28 Jan 2022 07:32:08 +0100
X-MC-Unique: xns1moKkMzu60X6Olaq9QA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhL9TTNFL3JOoqYzKuadJJNvivoS6io1+7lbm2gZxv0+r0ptAQeVugMFKbHJe0RUX3B2wiH3DdI6RJBwu1vtp14YfzXMItOAYEppzwRl0p/NEQtAsuSDFUHhn8+X+A4tV6t1am689EY0LLJbCkihAiC0qr5Sn7RaXDIhgwKgvrHQaXViDmaCXL9Jav3x3xPSUfvxDUeqMZgAHFbn5U0AmBa2EL7vQ/LGIKXh4jx5BSXjLhp5UKNo2kWKSuMjN0iA5feoBDz/DcB470y6NYGaB+rnag33LcifMiheU+XRY3l6Z2bellfk/zUPpKsn9w4Iqpz7iQG0FmQPGnfBSqxGMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FeUkIB5EYYF209svmPNGYa1gdDzSQMXO3+0ufHprWb8=;
 b=bmCQ454jZRKMOqxbbBbPo9retCrz7qlsE/8HJ/AaXKQFYAuLulylSxNjQUB+T9VpeT3n4urKPbOx08fzoVcdFT1peViAa5W8NY6joGRyjQo6mhXN6Wx3NTc6tps/CkWrgQ8mnYAQyUpfI2lJD7GLLwAhLBckXbdfrThVyydzyclgonb9l0Vs1hksdRijNC/w/z7WnlmWtGpLc75my/zPAQUQ5+V6J417VnD6s/I0/2mS7osNLyEXv8ibYr4v0XDEtZ6indKtUkxKj0QjMoBRW0jiUVKVLFoaDHhZ0TU32GaijSMZraUVlRn0Eh9DtYD6Xpnq4fuJ8MzS7qqHnGpMEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by VE1PR04MB6446.eurprd04.prod.outlook.com (2603:10a6:803:11f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 06:32:06 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::18db:1eae:719e:ef4e]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::18db:1eae:719e:ef4e%5]) with mapi id 15.20.4930.015; Fri, 28 Jan 2022
 06:32:05 +0000
Message-ID: <5d3aeee5-4344-cc42-f0c7-f50f3b68619c@suse.com>
Date:   Fri, 28 Jan 2022 14:31:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/3] btrfs: defrag: don't try to merge regular extents
 with preallocated extents
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20220126005850.14729-1-wqu@suse.com>
In-Reply-To: <20220126005850.14729-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::13) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7be51ee6-faac-4f86-92dc-08d9e227e6fc
X-MS-TrafficTypeDiagnostic: VE1PR04MB6446:EE_
X-Microsoft-Antispam-PRVS: <VE1PR04MB644619C368611A6E4CF9525ED6229@VE1PR04MB6446.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /hMP5jKu9PWrKvGXUjvHCH4XeNxiaBzqL0dENRKk2nG7BxJcVNUSa2xsXixBdiwLJjGhU+jj6/FrQv0EUpZs++nRaW8+31erUctmxnZ0Yw6q4TTVrBlfvEA2TMH+6XBa6ww8BrJn8JbPoUUFa7Xa4gt8gJ4MFIL9EEChha7zhwvyx3NGPUqtV1UbWDXxkp3g8oydCOvb9xVJlKVKDD6dU4iOkGBeIRSGFy05XRZDn7bkjKw/gyLEpDdIIvdxn4H3JDK3RKAk2LE4HGvMHw9Q+mS7GABkUNhJOlPz5zho0Kd5/eAsbRZ2KxFF6A28EEJ26Ss062d0paCauTYimmGjHyXj++G3gsSyB4/TKJmpD/BsBoWqqwAdkd3lnPyiK1voDu7ZJk9ShBLY0FzkaLyYBGeUdprcpGzFmD9x12/gKCD6PDx2NdW+d14tHJlJI94k45tPA329RZkiV/ahlN4CurD3yOSguelysKvEBFZwwzfSz1c9TS7IkM4VimpmiRWE3iEMh1pP3ouOWwJZq1aXKNL4fdEbW0UWqM4Dg9oxI0Aeavw9HHsKO4dKnfLB50MS/DMYbA9eGv+/3f6a+Ha9WquuITqkJx1Lg4F+0+GXur1MZGNeMuYwTIEppdpHIlGtirXjgtHeMyeWjktfXZXg6tpHEpuBwQv479us/t5MQTxwOTMk5Exb4ihNy/PngcTn2gPnD8kaHnXdlJktkeyZ//Cp9XDvLQRuSVIRHNy+4Ss=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(26005)(186003)(6486002)(508600001)(86362001)(83380400001)(6506007)(2906002)(53546011)(31686004)(6666004)(6512007)(66946007)(8676002)(8936002)(66476007)(66556008)(5660300002)(36756003)(6916009)(316002)(31696002)(38100700002)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFRwQ2huMTlGWDUvbk5NckpCTnk4KytSVndsbW1hcUlCV25lODczZERzbk0w?=
 =?utf-8?B?djcray8yQ0hsTGFlajB5ZEwzS1R5V2JQUVhFKzZJMUtjUXp1TktyQXpqd0hH?=
 =?utf-8?B?RzNEVFpNRzB3c2FpYTZGRTV1aGlpTkFSdmRxellwQXFzZDFPSC8zRmJvT0RX?=
 =?utf-8?B?RzU1eXdFMWM2dlU1L1ZCRFdSV0o3NHhkTHZwenBnNjNhNFMzUHFhRUZLcmlL?=
 =?utf-8?B?RS9UQUxDMGYzQkl0YVZ4cXhIMC9SQ1hOVmVtdTEvclRhYTZBWUFHWDJEQjVR?=
 =?utf-8?B?djdwMCtMbUdkVVhJMGhubVMya3plTkVkRzNISmMwZjJCNjFkcS8waElGbGV6?=
 =?utf-8?B?T2JraWlXTjZwdFh2dDhrVnB1VlVsM0RuNXg3aHpBRENaUDlmemNmdE0wOGM4?=
 =?utf-8?B?NjFGckRjVWhZWXY2WHk4em9zT25ReW8zTVN0bC93NjFzMlNXL1RRYlp4TWli?=
 =?utf-8?B?Y1NVYmwrSUxhZE1WdERVeTY5M1F2VGZPb3o0bFZqT3Q3RVJvZXczWFhUdzZR?=
 =?utf-8?B?ZGZld2dONzlMdi9lOXlWbVYyREpHRHYvNWxsM3NyTEREL2N2N3BRNlJUK3hy?=
 =?utf-8?B?aDJMOEd3VHJqL1ZHUE5VQVJxMTU3MWU4bVJmTU5ERmhxcXlyUWZSK1J1b1U4?=
 =?utf-8?B?S2d4WjhQQThvSmZQV3Zmc0VtdG5ja0FiRFRGcmtOenZwRC9mU2ozQncrSUta?=
 =?utf-8?B?b3loMWFOV2xzWjZ1bXZOTjRCMFhUZXl5V1didythTWd0emMxUThIT0Z0VmJ4?=
 =?utf-8?B?WUVVdWF6NlhjSmwxNCtzOVZxcWNCY0l2b0lsTjJkb1JQZGUyem00UEpNZEh2?=
 =?utf-8?B?UWIxcFZGSVVTWi9KZGJZUGtXdFBiZVRNMUtHU1QrQ0ZLYzBuU3FYV3NGelRl?=
 =?utf-8?B?eGRsRVZHbDdSWWpqYjRuaGZJZnFCb2poTFZUWTNtVUM1SUl2NUJzUC9JdG9h?=
 =?utf-8?B?Vm9KYU84TEVoYnMzcy85ODkyQkpWMGFCSEM0VmloS1p1UEZGc2dRR2JDaUJr?=
 =?utf-8?B?eEtidjR1cU1XMzVPemZQN3g1V2Zwb01FN3VMWGw4M2JmQ0FEejRCSFFURVVF?=
 =?utf-8?B?aE1wdDBxS0RMZUZNK0FuVjd0QU16VWtSb25GR09MRy9ibnhOazBmN01tQUdV?=
 =?utf-8?B?QmF5RXdiZjcyOVdYTjdWdGlTZjlUKzJja0lKbHh2MTNUb2V3NnUxdXJ5Y2Zq?=
 =?utf-8?B?OXhRL1ZoSkNOK2pOTXE1Tk13L1NkTGIrWDJRQlcwZGJvYUh5cTRxNEVmR2JS?=
 =?utf-8?B?UzJMK1RVWUFDM1BvYmhacTQzRGN4cWhkU3FSUzhHMjdrWXB4Qkp0TjNEenk2?=
 =?utf-8?B?eWJ4VVNTN0dkRlE0c0tVRGhkaGN5MW53UklMTWhTU2JOV29ONUV5bTkxTHVX?=
 =?utf-8?B?NitnemhZZGFTQ1duT2VCaFQvdW5ZNm8ycjZNdytTNGpWWFc0MlZ4a1BrYm5U?=
 =?utf-8?B?TXhYYzg2b3JHWHpmQ2Z6SXRUMFVjUHgyRzdYc25DL3drYkRodTI5NEIzMDIy?=
 =?utf-8?B?alM0UlJVR3BHZGJrWnVFcnpwWFRNMUtqTnlscVpNaFI4WkJsZFdtL2UvVHdL?=
 =?utf-8?B?L244QmN3bUpnYUF5Tk1IWFcvM2xuMTRoS0VFVnhqbnJJcURIMkJtRUpDVXJy?=
 =?utf-8?B?QVgzVEIzeFNUN1NLZ1N4a2NCZ0YxSU5Sb2MxYmd1cGVzaDh2QWdCOW1uNWEz?=
 =?utf-8?B?UTRmaDhSSHJ0eG1SUVRPN0pKdzZFMEU3TkZIM2pjSmZiU251dDRNbkdVUlV0?=
 =?utf-8?B?Z0duYlFMU1RCRzQzdDQ2Y2VwMm83dXd5YjdQR25GUE9XUlRQSjI2aFZSTmhX?=
 =?utf-8?B?LytvQjR5VXZvdzc5ZGlNMW4ySUhWN3ZwSis0KzZQRDRtT0RISWdoRkVMZ24y?=
 =?utf-8?B?aU9DRU1DRzhReE9lNmFCUjlCQ3pEb0lwb3pPSmkxZ2EyckNtUzJ5dDJodE05?=
 =?utf-8?B?Mjljbmo5Smt1aG9mdkxXek91bmtpYTZZdEdiYWxXR1N5SXpkTjQzemNvUTYy?=
 =?utf-8?B?T080ZWM5Zm1EZWJFUWh6RGdvUDB1aEJrN1JUOElPMDdyWS82UXdPZjhnbU9j?=
 =?utf-8?B?eldQZGxTTFVJUGlRemRWclVkMnpRWklJNXZvb2Znb1ZxcE9KcjdmMmpENnRE?=
 =?utf-8?Q?EbrQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be51ee6-faac-4f86-92dc-08d9e227e6fc
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 06:32:05.9019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVuF2s7CGLFKfmCs1cKN0oTd4WQOq4WPK/6/oi0blzkBc4baIVxLfNy6yKD5ofVg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6446
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/26 08:58, Qu Wenruo wrote:
> [BUG]
> With older kernels (before v5.16), btrfs will defrag preallocated extents.
> While with newer kernels (v5.16 and newer) btrfs will not defrag
> preallocated extents, but it will defrag the extent just before the
> preallocated extent, even it's just a single sector.
> 
> This can be exposed by the following small script:
> 
> 	mkfs.btrfs -f $dev > /dev/null
> 
> 	mount $dev $mnt
> 	xfs_io -f -c "pwrite 0 4k" -c sync -c "falloc 4k 16K" $mnt/file
> 	xfs_io -c "fiemap -v" $mnt/file
> 	btrfs fi defrag $mnt/file
> 	sync
> 	xfs_io -c "fiemap -v" $mnt/file
> 
> The output looks like this on older kernels:
> 
> /mnt/btrfs/file:
>   EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>     0: [0..7]:          26624..26631         8   0x0
>     1: [8..39]:         26632..26663        32 0x801
> /mnt/btrfs/file:
>   EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>     0: [0..39]:         26664..26703        40   0x1
> 
> Which defrags the single sector along with the preallocated extent, and
> replace them with an regular extent into a new location (caused by data
> COW).
> This wastes most of the data IO just for the preallocated range.
> 
> On the other hand, v5.16 is slightly better:
> 
> /mnt/btrfs/file:
>   EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>     0: [0..7]:          26624..26631         8   0x0
>     1: [8..39]:         26632..26663        32 0x801
> /mnt/btrfs/file:
>   EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>     0: [0..7]:          26664..26671         8   0x0
>     1: [8..39]:         26632..26663        32 0x801
> 
> The preallocated range is not defragged, but the sector before it still
> gets defragged, which has no need for it.
> 
> [CAUSE]
> One of the function reused by the old and new behavior is
> defrag_check_next_extent(), it will determine if we should defrag
> current extent by checking the next one.
> 
> It only checks if the next extent is a hole or inlined, but it doesn't
> check if it's preallocated.
> 
> On the other hand, out of the function, both old and new kernel will
> reject preallocated extents.
> 
> Such inconsistent behavior causes above behavior.
> 
> [FIX]
> - Also check if next extent is preallocated
>    If so, don't defrag current extent.
> 
> - Add comments for each branch why we reject the extent
> 
> This will reduce the IO caused by defrag ioctl and autodefrag.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Use @extent_thresh from caller to replace the harded coded threshold
>    Now caller has full control over the extent threshold value.
> 
> - Remove the old ambiguous check based on physical address
>    The original check is too specific, only reject extents which are
>    physically adjacent, AND too large.
>    Since we have correct size check now, and the physically adjacent check
>    is not always a win.
>    So remove the old check completely.
> 
> v3:
> - Split the @extent_thresh and physicall adjacent check into other
>    patches
> 
> - Simplify the comment
> ---
>   fs/btrfs/ioctl.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 91ba2efe9792..0d8bfc716e6b 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1053,19 +1053,25 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
>   				     bool locked)
>   {
>   	struct extent_map *next;
> -	bool ret = true;
> +	bool ret = false;
>   
>   	/* this is the last extent */
>   	if (em->start + em->len >= i_size_read(inode))
> -		return false;
> +		return ret;
>   
>   	next = defrag_lookup_extent(inode, em->start + em->len, locked);
> +	/* No more em or hole */
>   	if (!next || next->block_start >= EXTENT_MAP_LAST_BYTE)
> -		ret = false;
> -	else if ((em->block_start + em->block_len == next->block_start) &&
> -		 (em->block_len > SZ_128K && next->block_len > SZ_128K))
> -		ret = false;
> -
> +		goto out;
> +	/* Preallocated */
> +	if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))

Nope, during the extra tests for unrelated work, I exposed this bug, we 
should check @next, not @em.

Needs to update it again...

Thanks,
Qu
> +		goto out;
> +	/* Physically adjacent and large enough */
> +	if ((em->block_start + em->block_len == next->block_start) &&
> +	    (em->block_len > SZ_128K && next->block_len > SZ_128K))
> +		goto out;
> +	ret = true;
> +out:
>   	free_extent_map(next);
>   	return ret;
>   }

