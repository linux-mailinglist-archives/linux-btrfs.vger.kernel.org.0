Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED69E3C9719
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jul 2021 06:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbhGOEWu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jul 2021 00:22:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:53130 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233862AbhGOEWt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jul 2021 00:22:49 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16F4BZEN027283;
        Thu, 15 Jul 2021 04:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Ix6ivonFtp0ksE2KzpT85AQI0wjIwlx9T7ExnX+6hr8=;
 b=f4CAQkonD+aI096008INpESdjthsy5GEiiKP1M5w2L/At6a9N/O32c7sv4vMqB8maJU1
 PJgCQfVVLL6gE7w3qZCWPSiyJj4bUBOWxOmQmG1HtMGUSHhf4fuAq84331ElqvNu2KpV
 tmp7HqvXJmUkdU1OEkQLmA7OLGoRfXemmyQzeXIZGZNqwkLMdwkqbgEZ/JFqWISzmBK/
 0LrF6J55Bh8Uc9XgmNeY4mX45na9pvvy5eueM+Q0eiim4ob5w9jxZZuqTwNtJpNInl6m
 q10xm0pxlIN/xTwxjSW1Kjy5I3vhQAEraZI5t8BQkCZ9ucR0fNYKECBreIfX2oNTezkP 6w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Ix6ivonFtp0ksE2KzpT85AQI0wjIwlx9T7ExnX+6hr8=;
 b=IZQ2J7IDD0sgVwPUWH7bzFNEx/A3jY+ua5tJeInLFsMyj9IpdQ3oZwTCe1jLbst4eL/v
 jUkwQNbeaDMDe6fMD9ODGAUCOpsbmWyrNPJqAnCJcg0BG6kzrvFcetlB9QthZzIMHubk
 ASXG1iVV6hY+21MYxGzPK7jXunnLv7XHQp9i8RVL18ZY8CG7CcrE013VRDxhyqgk9SAH
 3Z60IuyG9u16dJWLA+HI1dU73ajGXyvFuenahmhUl+9b87Ikf+5N/bMhtmMAX4f1RTtI
 LbzDmLSjOtgGXubTf8MNsy450plD+yhXGcsORNauR6xzU2IiwwRW/KFvgolZndEPolcj iA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39t2mc1308-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jul 2021 04:19:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16F4EwdL188260;
        Thu, 15 Jul 2021 04:19:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by aserp3030.oracle.com with ESMTP id 39qyd21j3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jul 2021 04:19:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDmvIdEWwZSl/t/Lxn1RVdLbvou7LCiLud9iMJY4dSRg4P84X6lJ2T32xz/RKQNpQb8tmimj6JY7VYyzCdXjE/PQL2+t9rjnXWkdC8v/5/cpiRZjRS5HA60FL3AEZHdtve1ZIj1e61RNeb3xZI1VPwFeWEBZEuxTq0o6U9UKavPq8GsF4GBZ79UByAz0FQOo2I/f4LXN8jSpo9tVT5RFXlxs07jhlBlfWtrNf6o2fDsRiizBBMy3dDFArTEHkf8JhMzjILAIqPR3+i1Xji7iR7kVHBtRNJiM6OlEdPdLfjK3US3bv6LFDpzVzqav/ukX5BL3XDEknrUTFnA6atnWyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ix6ivonFtp0ksE2KzpT85AQI0wjIwlx9T7ExnX+6hr8=;
 b=nNGt2lZRo9QBYWz+yt6hcAz5iOtEbCxYfjHU4xTv9+2gOOi5xHIADgC43OuYjbdibmC1Vzya09Tnx+t9pcQie4504zW/sihKCdujNFfkQIHXDlOqB81+7txJ10qrSUYCI28qZi69mikTuYiYMweO90/XUTxX3g2hDw3K8OoPjssV558ZhpZ44LfKPjLiL5AxGTUuctd6CV2GVx0LOZl8i727b169QjFMEEW8oDlNVVYpStjwslH0t4Nqi7rC8aRs0wYXwopXIwvZoqM/MHqbyQgvhV5uCwbZggtz1zLdatujWWPxkZHpEDX4il38Xbo4MrRcJdYq1LqwpbUso59Wqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ix6ivonFtp0ksE2KzpT85AQI0wjIwlx9T7ExnX+6hr8=;
 b=gxYVT5BZdO1DApCcThHnFK6DXrwBw7tpTrWFWaRSx9GmZmQG1Fvm0y2nLtdty8CeMG2nG0oVfotI8jdbLfGiXxhD3YVyZCfJxtdJXTy/ss645qDzdFPsp7X4Zqngg15oxjz51pFnRnLLIt4BxN/rr0SVvA53jFhH4K6dd/9i7xs=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (52.135.48.88) by
 MN2PR10MB3838.namprd10.prod.outlook.com (52.132.172.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.23; Thu, 15 Jul 2021 04:19:50 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%3]) with mapi id 15.20.4331.022; Thu, 15 Jul 2021
 04:19:50 +0000
Subject: Re: [PATCH v2] btrfs: rescue: allow ibadroots to skip bad extent tree
 when reading block group items
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Zhenyu Wu <wuzy001@gmail.com>
References: <20210715022848.139009-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <d3d1dfea-2858-0877-e671-73ef1e1ec7af@oracle.com>
Date:   Thu, 15 Jul 2021 12:19:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210715022848.139009-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0110.apcprd02.prod.outlook.com
 (2603:1096:4:92::26) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR02CA0110.apcprd02.prod.outlook.com (2603:1096:4:92::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 04:19:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7460d200-09dd-4223-e2d8-08d94747c996
X-MS-TrafficTypeDiagnostic: MN2PR10MB3838:
X-Microsoft-Antispam-PRVS: <MN2PR10MB38387617CB4F3DD9DC9A436AE5129@MN2PR10MB3838.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 878vUBykZ+nhC2orNomjRyBiQxhCRCPOduxIOn20yujbquB9qlB8XZoq3b5umVB830Nmz32NMRYxHUFxdZzHJ61j+LlRUNEqZCsp/13EWo1qsWsJREGeRDqoVlf6+l2KzlN/WJOX1niUs1pNMC8iOeXEk6v9Q8Cwx2VBZoPjppRb4BC/qxPpmK2rVudmqu6D7n8gSXDuuFijcCy+3Gj3kA0/vpP2o5ppTpE1cymbPd13iVqAF7slZNuBuA7SeBgumOEkDLj7J5zo0imNeBTImaoxGjQ1l3ZUwjSN6UkXDbm9VYw+alcpnymexZNnfm1Jz3Cbtbm2x6UVRBk8aTH0yZU8pBj6M6eTzHuY9WtjxtFcg7YWNPGbGUIrFRYp3xMObqC5UQrdJLmrDLHvot1iH8mJ7iyR1Y8bv9BQ2rxqwcebCsSgxSOQu9vfinp3/yS00cjuTb/GMwVwzas/UHJs+VbTMik+c7Tt2/CTUv84umq8eLHSQ6fR/WDcaJMYeVlcxwk9Hx2y+u45r4EiWYdV38r/ws8qwyX7K3iZEvzgJDsTyFyKu+WJ9JOX0wFJ2OAzKt2Op4VlIwhqZL1hIkx+AmNhL0qUI7fqhJY+zBYE5kxq6OYLZtcu6mykJyNlYY7JxO43laruz5kzKjSCLGyyzDs9iZsItURXZfvug8H6qplXqfgAnWyppSRgQQyb7NzgzybHdPvFWwzm9g0d6L5AexPZJuSIZJlbuSCNNWD20TPP37kiMKAix35pHQRwLeKXHycKiBmd7R804mDb2JqDlXfdWIhy+WT60VIKOJYWZXbUsEWo/Y/V3/7kzkHCGIBi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(966005)(31696002)(26005)(2616005)(5660300002)(8676002)(956004)(478600001)(8936002)(2906002)(6486002)(316002)(66556008)(44832011)(53546011)(66946007)(66476007)(83380400001)(16576012)(38100700002)(186003)(4326008)(31686004)(36756003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UW5Yak1KUlJYN3prbkJ3aVVFV1pOYTBySWU5VlY3eEloTDRPcGY0VHFPem1K?=
 =?utf-8?B?d1VRSGJMSkdtMExITC93d2VtRW1QSUQzRkRsaklCWUIxRDFPekFQZXRUMXYr?=
 =?utf-8?B?cTdQRkxJRkV0eWtOMW9UTHlHSlc5VGtFZmUyRlpSbjNqSEpvckx1R0ovRVNQ?=
 =?utf-8?B?ZEQ3VDhHUUp0VVQzT2xsK1Y4dnNkbFA1K3pHazVxcUU4by9rRExuQTlqK1ZQ?=
 =?utf-8?B?YWwzODNlY08ycEFNb01zZWdIMjFKVndibUZqb2xXM2oyU2g3UTFtcDlJakk5?=
 =?utf-8?B?b2N3cFdQamdnTDV6aStIZVZhR01ERGtDeG95a3h0YzFuU1BHaUpBSGozSXd2?=
 =?utf-8?B?L1RJeXZrYW1KM0J0YmtvbDNQTm1TelV0VEVsUDc5LzM2UWFSWjdWdnFlSnRB?=
 =?utf-8?B?aUFPelFYN0dvOWJWaG1ZUUlIaEdpUkVQT25KUW0wSGNuaW1QbmRrOGtwV3Ju?=
 =?utf-8?B?cXk4MzBvSjBjNzBKaEZOZWJkdS9OM05vbWZVMTJrNjZCaXBUajlYMml6dnVW?=
 =?utf-8?B?NlB6Z3FGWFV1YjBQWlNlbzdCc0VOUFg5VXdtS0JSMEdTWmU1cWRCd1ArYnlo?=
 =?utf-8?B?SzlqSUR1VkpmNUxBTXpEdHVJejNKaVN1QysvMjhpK3NZVFEzV1AraFVXTTJT?=
 =?utf-8?B?cGZHbkYzOEJ3M0hOOGMzc0YwTkVlcWhmUWpoUW9FQmZ4R2xTc0tkZG52eWRJ?=
 =?utf-8?B?d0FWeFlaYWFwM3VrbEpDRVU5SzgwN09mbHRPQU5XZlpzQ0RPaFNxNDY0K2Ix?=
 =?utf-8?B?azlZL3NMY1RQY1ZlYUQ5Skl0M2pHcGM3VlBZSEJnanNUWndyeVFjaC9leTU2?=
 =?utf-8?B?STJicnN0bysyeEl6bFNhbVMwSldXY2JlK2FsWnVnVVMwNmJNd0NONXY0UU1C?=
 =?utf-8?B?cis2djlBNjQwdXBGYkZQNDZGcUh3YkVINjZaRTlIc2ZYOWlFb05nTWJ1QW4z?=
 =?utf-8?B?ZnhyR0ZJWUtHUC9qOU9raC9WTHFNMzkrcW1SSXN5OERnQWREMEdOamMzc2oy?=
 =?utf-8?B?b3puUEFKUnMxRkJJN00rTUp6OUwvUXI0YWlXSGx5Q2tTK052NU45dEdGMXM3?=
 =?utf-8?B?SW9takVZWTVUZ2xyZTg3SUhiRHZQQ0JZR3dyK1EvWmRsWTNPY2RUNk40aDFz?=
 =?utf-8?B?ZUUwMlF0RkYrc3lFNkViNGNwcEhFUE0yaU1MT2RlOXJmTnNDV3Jyc3hZelpz?=
 =?utf-8?B?ZW9TcEQ0U3BXVFJicjJHQnJBeWNhS093STRyS3hPS05sOFdjbUlpT0lZa0pD?=
 =?utf-8?B?S2tuMWhyekxwN3RDeFpWU2dMcDJzbGk0TXgrU1BmVytFWVZtMGhNb3luMzRw?=
 =?utf-8?B?M2ZuNkNRblNLV2pWWUtENGVYQjRiSE9OdkZmT3FOTG0vODg4ZWhKTW9UUnV3?=
 =?utf-8?B?WUlLOUx3amNkdUd2T2R2dGw4MTNaUU5QcGU1YU5DbEM0UzlGYVdZQVBodWIx?=
 =?utf-8?B?N1JQVlRSNWJhWWRwZ0NYcGxHeW9mQWU3c2Y4MXRBQVJmUmN4VUk2U1YzV2Qr?=
 =?utf-8?B?QytLdFluOGtPcGF0YkZLVTFRcTVsZTJEMWlBb0x6NW9QWUtzemtkRitya21m?=
 =?utf-8?B?YmFjYll3OGh2Q2VrQ0lNallRRFA3bXFjSUtBTFl0UlJ1NVNQREhMUkg4NFRY?=
 =?utf-8?B?ZzArRDNrb3ZZdlU4dkVIRzQ5K2pVQU1Udmlydy9pZnBmVlg1bDlLWnhSVlIr?=
 =?utf-8?B?RlNpejlHTDBDK0QzL2FocXN3TGRyNFY4ZkNNVElVN0wxWVRHc1JoZnRrS3Rs?=
 =?utf-8?Q?ajInZs1K9z9WRXtA7FJtY6eptvIH02P879ZlLWB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7460d200-09dd-4223-e2d8-08d94747c996
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 04:19:50.1348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HVAZji+knXbLadLM9TbETpf21hZIVhCRl+4CmV1X6r0GEu8RZxvlFa77ObLrv0ptoZtJVo6kWZvTMlqxYbk76Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3838
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10045 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107150029
X-Proofpoint-ORIG-GUID: kIwQarHdHi733uR-VcDsIhe-lgeJoAd-
X-Proofpoint-GUID: kIwQarHdHi733uR-VcDsIhe-lgeJoAd-
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/07/2021 10:28, Qu Wenruo wrote:
> When extent tree gets corrupted, normally it's not extent tree root, but
> one toasted tree leaf/node.
> 
> In that case, rescue=ibadroots mount option won't help as it can only
> handle the extent tree root corruption.
> 
> This patch will enhance the behavior by:
> 
> - Allow fill_dummy_bgs() to ignore -EEXIST error
> 
>    This means we may have some block group items read from disk, but
>    then hit some error halfway.
> 
> - Fallback to fill_dummy_bgs() if any error gets hit in
>    btrfs_read_block_groups()
> 
>    Of course, this still needs rescue=ibadroots mount option.
> 
> With that, rescue=ibadroots can handle extent tree corruption more
> gracefully and allow a better recover chance.
> 
> Reported-by: Zhenyu Wu <wuzy001@gmail.com>
> Link: https://www.spinics.net/lists/linux-btrfs/msg114424.html
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Don't try to fill with dummy block groups when we hit ENOMEM
> ---
>   fs/btrfs/block-group.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 5bd76a45037e..240e6ec8bc31 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2105,11 +2105,16 @@ static int fill_dummy_bgs(struct btrfs_fs_info *fs_info)
>   		bg->used = em->len;
>   		bg->flags = map->type;
>   		ret = btrfs_add_block_group_cache(fs_info, bg);
> -		if (ret) {
> +		/*
> +		 * We may have some block groups filled already, thus ignore
> +		 * the -EEXIST error.
> +		 */
> +		if (ret && ret != -EEXIST) {
>   			btrfs_remove_free_space_cache(bg);
>   			btrfs_put_block_group(bg);
>   			break;
>   		}
> +		ret = 0;
>   		btrfs_update_space_info(fs_info, bg->flags, em->len, em->len,
>   					0, 0, &space_info);
>   		bg->space_info = space_info;



> @@ -2212,6 +2217,13 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
>   	ret = check_chunk_block_group_mappings(info);
>   error:
>   	btrfs_free_path(path);
> +	/*
> +	 * Either we have no extent_root (already implies IGNOREBADROOTS), or
> +	 * we hit error and have IGNOREBADROOTS, then we can try to use dummy
> +	 * bgs.
> +	 */
> +	if (!info->extent_root || (ret && btrfs_test_opt(info, IGNOREBADROOTS)))


   I missed this part before, my bad.

  info->extent_root can not be NULL here, which is checked at the 
beginning of the function.

2138         if (!info->extent_root)
2139                 return fill_dummy_bgs(info);

    So should be
        if (ret && btrfs_test_opt(info, IGNOREBADROOTS)) {
		info->extent_root = NULL;
		ret = fill_dummy_bgs(info);
	}

Thanks, Anand

> +		ret = fill_dummy_bgs(info);
>   	return ret;
>   }




