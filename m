Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E3C39113F
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 09:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbhEZHRz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 May 2021 03:17:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56770 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbhEZHRw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 May 2021 03:17:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14Q7GAks136243;
        Wed, 26 May 2021 07:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=6cW3wlgI0U4wLn9a/BMHrIfNrqx5QvyFLCUJ4NXiH6U=;
 b=eIs2Z+D76gt4EBnPngD23JwRO842YHZQk3TabUNK+JpFs1S/5MeTJMvMBWIHsJP+9oBz
 EuIGgxgNABgFQsZEFrTYTeI9DDOzzPqofkW3898CbojT9H6OBTudA03bSkLmhjEtrQir
 GIp8W83ykK4nMXEXOJT/qbtizW4qu4TurbtlhKrllGnMz/MZMX5uuWv6XE6zpTsb6Bez
 VrbZEt4Xv1JQuN7jKfBn+xJ81Hs0u1fNIb9om5zuEAmCT7QCOsLpef5t5NtU60QCUe2g
 zczxmLbzji8KJMDWQEXTb4KHqhi2i0Ly05ytFIiobP/4AIh4MuXlcu8/RHpxkWxm+Exn 6Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 38rne43nae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 07:16:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14Q7FMkg086394;
        Wed, 26 May 2021 07:16:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by userp3030.oracle.com with ESMTP id 38pq2v15cf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 07:16:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STwKZe5kKg5E+GI1njkcm35hDZfxdLw9cjOaDqKRjWGRWEsMi+VlBGub0yJAn+MyLsjVLHSt6iFeu4DKjpDKiMP8mfORjci1JgXWMJNRIT99JJ2G9ZU0RzvBLCG0CdAv8yBn9ydec41aD0e1eFIkc8px0b/k1MvfgFa5aqgP0a511nMbY8RZTjd/wugK7sttIm0Y65M2wSMPFYjlLMRGCo2oFEyIAM2MKbAc8KysrJblDlAyw5+u96peeWXByamhKKlwzz7DE/5fR9Dzc8LLlKN6aTXod2lpXI38LnU8X4qvPL1fHyInZSNBUpCDNF6XFIUZ9utbZytHGnLE9I3kyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cW3wlgI0U4wLn9a/BMHrIfNrqx5QvyFLCUJ4NXiH6U=;
 b=cUv9g/xQvIPtAe7wt+3Cx9m2+i7ySLIH4nrHlbMbe5/foDWCtNd42fhTJyGOpzT4lh1smu8KE8+5RlfSKODme+VNO06RB/UwkgbVym+80e4qDk0/AhD5bZUv6EYStWQvANDE58bwjU0Th/hRfz8ftbyylhHPAAMJnOvt7f1AaOb/CLAsSlmjs6fjED9lK68Uz//Whevp8cDga+x7t4CZ6NS3kbGJTn9rT0SbBy9VJ9lvj5oqcVQt34qPUR/Ps+5XN/o5ArHMM1cTdQiK+y0J3OkiRMYp3pWCk7H+7fA5XAlLW1Y9zYw5WyfKf2x0aXxoKOz6GfRBdnXbtN9jL7ByWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cW3wlgI0U4wLn9a/BMHrIfNrqx5QvyFLCUJ4NXiH6U=;
 b=Ni3K8a4eoWKIYq7ew+7baJBwzjzEN19g0sMmXbqaxJZsBnbfoxRcgYxH+y8nK77c+bSlI2xZvkxiqI9Qb03ZjfuEsxGUurNxUD7nD47o3L097pRGX1YfZKOgIoTBFeGYSXxyDGcPDdkagvCQDea08Mr+pf1Y/qJ3f6LORmBFs4c=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4142.namprd10.prod.outlook.com (2603:10b6:208:1d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 26 May
 2021 07:16:15 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%8]) with mapi id 15.20.4173.021; Wed, 26 May 2021
 07:16:15 +0000
Subject: Re: [PATCH 4/9] btrfs: scrub: factor out common scrub_stripe
 constraints
To:     David Sterba <dsterba@suse.com>
References: <cover.1621961965.git.dsterba@suse.com>
 <d175e98023012390c53755ba85f93606376f51a4.1621961965.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <0cd0a967-84fc-25b8-1e7d-1cd51ceaad98@oracle.com>
Date:   Wed, 26 May 2021 15:16:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <d175e98023012390c53755ba85f93606376f51a4.1621961965.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:c97e:3e12:797:83c8]
X-ClientProxiedBy: SG2PR06CA0112.apcprd06.prod.outlook.com
 (2603:1096:1:1d::14) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:c97e:3e12:797:83c8] (2406:3003:2006:2288:c97e:3e12:797:83c8) by SG2PR06CA0112.apcprd06.prod.outlook.com (2603:1096:1:1d::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 07:16:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46a8ac8d-4487-4168-5ba5-08d9201625fc
X-MS-TrafficTypeDiagnostic: MN2PR10MB4142:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4142146675441CAF108D8157E5249@MN2PR10MB4142.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5AGdeNHFGOGSgdQRDFg1NJH/AGC8oztmavrY+X81S7QW6u+LBtjXAN3U/f8FZShW8T/i3pKI5hhaoMrLkI/GhcJYOj8NhXXbeRDExHm+7dL8B86JjOvuw2w0tsTojeGZ+TejpRlS7xlOV+466lQ6KRShxF6plY5/QgjeYKNjAp5MdmEDhqXJTzvrbSZ2pne56nxZbNyUf7N8Tba5ELA6+pVQrI4WvzuX4jb8olib6Pr0HMkIH41JSu3GYWPC6wmh99myVt0eYfGOgES7bsxnNaC2x8mqNctlXyOuzIZzxRcRNN3OywfNoOlvi4cgCQ/cm+JuEd6QwTOpbZ15aRJxdjIvnFpueDAtUkXTEngYnScQMRA7/9jh09a6IY7X6aN5g8P6VgsSpQBoI6VNGoIc8Qz44fKAD8GV/Ve3EcnyIiLvLlNDgZ6HGn+Av0EmQhZaYg7dkWeANH9SEMr676BoN2McoS7QfxHTkRPsAUuAsgwjX3+hFPABgsel7GzPlGNrORzYDWo6j6eLIOsdVJl7f8cVGVKL8PWtlBiaKPdrLLlHnK1wKuecRXiRTGIFMj3XH8E4YerFQYjHfE86O9VZfCc0BSHnWtmzsQl+orQ2e9prCJksMugua3e5IoxGE52V0sRmpP0ecguiP8d9oaTsnkq28t8/mjWVVzLF2ZHQ9as=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(39860400002)(396003)(136003)(16526019)(186003)(53546011)(36756003)(66556008)(31696002)(8676002)(5660300002)(6916009)(478600001)(86362001)(66476007)(44832011)(6486002)(2906002)(31686004)(66946007)(38100700002)(8936002)(6666004)(83380400001)(316002)(2616005)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dHFzRXZhYmR4NU8zWVRNUlhUcFgrWll4d2Z2KzZtR2dxRUk4VGNJQzdqbEZF?=
 =?utf-8?B?MFZOdDlPbUlvRWd4d3FTWVZCekRSK3FVRW5Bb0xBZDdrdU4rVDdvWDZYd3Mx?=
 =?utf-8?B?TDc0U2phK25mYm42Y1picnFncFdramtTK3FENDlkOThRTlU4Tk5zZHptS3NX?=
 =?utf-8?B?bTN6cFJXbkpuaWFBdURwYzdYOWo5c0pob1hzcGFCb3B2MlBwZWtpeEV5NW9m?=
 =?utf-8?B?UkcxUTZvNTRPMVMyQm1Ta3c1dGR4SURJMm1lejM2MWpReDFkaXpZS2xrb0pM?=
 =?utf-8?B?dmFzdXNYMEc4aXYveDdSK05LUm9WQ2ZPTmdaWHU0ajJRUzNoRDc0RFpGSE1i?=
 =?utf-8?B?OWZ1L0hBT3dmQ2pEbm8zRmVicTV0MVNKQWt4OGcvWXNYbGxpUFhuZEozV3Fl?=
 =?utf-8?B?RWdVbkpyU1F6QThmdk5xV0hSYS84eEtIY3o4dEgwQ0JsRUQ1S0szQmpzd0w0?=
 =?utf-8?B?MzMyekcrUVQzWTV2YzJwN1U5eXI5QTJrVUJ6YUlYTHQ2TEg0clkzTGRtNC9i?=
 =?utf-8?B?SE9aamx4UkU5ZDdqaXo2ZDZnVS9XeHZZRk83MkZHWWhPUUl1TUFZTmxxK2Vw?=
 =?utf-8?B?OXUzTXFKNUJDUW55RTJhUXVtNkIzd0JyN0p3c0hsSTJ0eXRzU21YY1ZiUHlQ?=
 =?utf-8?B?Q0V2T2d6SFRCdkVmUXlwNXJHVVQrUVJPcDk2cm1HRHloak5VLzdHK2cwWW4y?=
 =?utf-8?B?SHQ2VmdxU1owRGIyVTZTNll6TE5uekl6ZmNSMDBqVVpXNU0zblV2NU9hdWM5?=
 =?utf-8?B?YUxUbTVkVmt1d1did3k0cCszUXZIdjcvM2dZOE5EZ25xRVcvQ1VhaVFoZ2Ir?=
 =?utf-8?B?VlliVlNzL2hVVE1VcENudS8zaStuLzlJRWVoc3FpQ0ozK3dPUi9wN3BjMWpR?=
 =?utf-8?B?cWEwVGIyLy95YSs3WGQ5QlJ0TUVNeGxVc0V3NkpNcjVHMWdDREczYllrcnFB?=
 =?utf-8?B?R2VXVUJqdnlQbGtnek9XUm5LS3ZvaENHd0Jlb3dqNzFwVk8yNmlTRzQwYlBR?=
 =?utf-8?B?U2lDWFpsTnpjUldHeGdRNHVNMWhLWU9Sakt2Y0p0bUl5bEZRUHJqTU1Bc2Mr?=
 =?utf-8?B?UmlBcjViemdRaUZRQ3l5eDFVUjFrcUswWTcrUnJ4NDlHZVRVTEVOdXFvTmhT?=
 =?utf-8?B?OW94UlhiSlFiMjZ2ZlJOaWkzVXA2YmMzdHZqdFkzV2ZKUjAveUp3MzkzU0ZU?=
 =?utf-8?B?MUZ3SFVXeEpGTXNXUkpTWTVUYTVHZ2hRTFBMQVdvaitJaFJmN0hmVzlsQVkw?=
 =?utf-8?B?bEcwemdLSG5rT2MvWnczVFE5T0pKb0FOVUFTam8yWFdJWXdIOFlmT3l4N0l4?=
 =?utf-8?B?cWQzTmZFNDBrZ1V3VCtEM1FaMmpLQ0MwclNtY21DZDIyd2ZObk8zenBaWnpa?=
 =?utf-8?B?THk0RTBMWEd5UXlaZiswOTdaWStFdXZXR2U2Y0h0c096alN6d2dlNEhQeVhW?=
 =?utf-8?B?c2xQWEtYWFN3QWhRZ2htN3FERzQvNlp0TnllOU5RS05idGNkUUNBZFYwdUVW?=
 =?utf-8?B?Rm9SNUpHc0YzbGk4ZGZuU0hSTHRpQUg1WlVWRmpjVHpzY01SK2VkcWFxNzg2?=
 =?utf-8?B?Yk9qVHd0bnlFUVdLcTFoVkpkdVZWZEdRSjRDRkxQemEzdEFJRkMvbUJEOTRo?=
 =?utf-8?B?djNrREVlMHZwczB0Ung5V1RJZ214b2I0aFE2WFIyYit1QzhMOFdxakpCTTJ4?=
 =?utf-8?B?WWJFcWdsKzlJdkRiemRxSG04SjZ2QitjUFZGd0dRVWZhNFFmcGY1L3VvcnYv?=
 =?utf-8?B?QW0rZ3E5Y082c3Y2TFhqSXBJcDFFVkVXRGlhUXJvYlBUdUJWWjRUV3V3aVYy?=
 =?utf-8?B?OHZ3RmtaR2Uvay9td0EzVVJWa1RpRHZ3c2l1Zm9RTitPWUdVYXYyTFB2NTdI?=
 =?utf-8?Q?OFtta1GijyJb1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a8ac8d-4487-4168-5ba5-08d9201625fc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 07:16:15.2850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HGQqWyV5r2X9rVBaPjnckQasemtXTNalDXfvgrkGq1DbJSM3/6W42qrVD62IsiE2kKNcPbAVb5iBxqcvP4Yeyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4142
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105260047
X-Proofpoint-ORIG-GUID: SexPRuPQHY4zivhUkCJAbW8As4pldVPB
X-Proofpoint-GUID: SexPRuPQHY4zivhUkCJAbW8As4pldVPB
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105260047
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 26/05/2021 01:08, David Sterba wrote:
> There are common values set for the stripe constraints, some of them
> are already factored out. Do that for increment and mirror_num as well.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

  Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks.

> ---
>   fs/btrfs/scrub.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 518415d0c122..5839ad1e25a2 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -3204,28 +3204,23 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
>   	physical = map->stripes[num].physical;
>   	offset = 0;
>   	nstripes = div64_u64(length, map->stripe_len);
> +	mirror_num = 1;
> +	increment = map->stripe_len;
>   	if (map->type & BTRFS_BLOCK_GROUP_RAID0) {
>   		offset = map->stripe_len * num;
>   		increment = map->stripe_len * map->num_stripes;
> -		mirror_num = 1;
>   	} else if (map->type & BTRFS_BLOCK_GROUP_RAID10) {
>   		int factor = map->num_stripes / map->sub_stripes;
>   		offset = map->stripe_len * (num / map->sub_stripes);
>   		increment = map->stripe_len * factor;
>   		mirror_num = num % map->sub_stripes + 1;
>   	} else if (map->type & BTRFS_BLOCK_GROUP_RAID1_MASK) {
> -		increment = map->stripe_len;
>   		mirror_num = num % map->num_stripes + 1;
>   	} else if (map->type & BTRFS_BLOCK_GROUP_DUP) {
> -		increment = map->stripe_len;
>   		mirror_num = num % map->num_stripes + 1;
>   	} else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
>   		get_raid56_logic_offset(physical, num, map, &offset, NULL);
>   		increment = map->stripe_len * nr_data_stripes(map);
> -		mirror_num = 1;
> -	} else {
> -		increment = map->stripe_len;
> -		mirror_num = 1;
>   	}
>   
>   	path = btrfs_alloc_path();
> 

