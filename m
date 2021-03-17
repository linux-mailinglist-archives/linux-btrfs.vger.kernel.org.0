Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EDD33E6CA
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 03:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhCQCY0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 22:24:26 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52284 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbhCQCYX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 22:24:23 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12H2K4QR011924;
        Wed, 17 Mar 2021 02:24:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=nBDnd2Y5lgFmRaJXPNs4sdvcLIZc5yamQjkjgsRXtck=;
 b=yMxNh1QlapvbvCkfoMkqkYkPuFKvNham9xe5qGnA/NTnYcmhfEdzIqi2nQotJyiIWYdH
 s+iQ+SDS/NCgvKfp2zBF2Y1QcCBao6onbi4IZlYHu59f7OiAVxanBCD+u23JrgYMZkkE
 aRRlw7gIkJSVflBvQ2wGCFtF4OszdO845/7U/vBjiYQg4J8uWXJv1uCN3U+Ix47Ao3ux
 yVBDa27nXEmSGX2z9fXYDRZN55bNGjB5upFc2QZ0HbQIHyKDaoq1GX4JdOlXTgnZYJNC
 AsGubmQoVLeFbESKJRrrELJvbkOK1eAjOZ3p53JnRkWtI2hIhZGtBjHWoR5eU7VO6B45 Eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 378jwbjnsn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Mar 2021 02:24:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12H2JlEE078498;
        Wed, 17 Mar 2021 02:24:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by aserp3020.oracle.com with ESMTP id 3797a20j2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Mar 2021 02:24:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPTSz2m4emyVPmXf6laQElePM2ckQm3iLNhCdd17tQzAfL/u1jcUY/n300VvZ6lmV/CqJWhIFPOBnIYDJdbTlkmnB2ouwTeoZnsPjoX5A6NIZA9Ct9kOIzSqNotU43K+VzPU2KUqCaYafxSoa2a7LnGnxdOgzTib3jsT/lf1SSYNPvRAlcaTCBUgnSMF4iZw43toBBQ6YnhB/NKPU/1a5OA2Wv3W28pm7+ggdFo7h0yDmFj40nJ4urLqAlaLCPAy6ieUBidAEndQHpaPIKAQZQtfFMWlb4v37aSFK/hmn0pdYfsV0YkLVV6ejOC/kZ3Fx66DO1XBGHxAFkTVL8DDzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBDnd2Y5lgFmRaJXPNs4sdvcLIZc5yamQjkjgsRXtck=;
 b=XsmGX39Ty+rQohYCmBCwlbAXc+zfS3pWz/XgNrI296dSGJo8i9Rt9Ny+q0PhPqp6xF4YHR2KmnUbhcKBOBpjl5+RnjU48g0AkYkpC/LI+HWMIi+SDorzjhQFzJUJicW1XyXVwKm0vhpMR6R4vHnDeW85p+/+aDWL42sr9fR3fj0B5cm8vTXbe7dsVFe6E6vOPqgr4+0r6VbNYD2VOE3Clmm9DmuJFeB/1/WJEZKXY2HHm2IsWzXl9qzCAEqbl+5gTshmqPywVv6Egp/YZYgb/ItYiNpyc9cApV3IhqqAWwY05nACCE+Wfpv/ujp2ZnTqigfVrLaBO949TKOiE73q/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBDnd2Y5lgFmRaJXPNs4sdvcLIZc5yamQjkjgsRXtck=;
 b=v1o6c7QC9leIzQw7xWiOTK+rFT0OC2sCyYLgZ2Dlgu8pB1LL963MuAkCZMGI9tlDSX5VbIGslFxmFRA77CDPLiPlVFV0UXc9zmQN8UcXVHJvGmrxMkMNQwY9SECSJsqP3PpXw9mOlVfPKe8PcNNthtnWCogHkENpSyr5lZvA0sE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3840.namprd10.prod.outlook.com (2603:10b6:208:181::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 17 Mar
 2021 02:24:14 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125%8]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 02:24:14 +0000
Subject: Re: [PATCH] btrfs: Use immediate assignment when referencing
 cc-option
To:     Victor Erminpour <victor.erminpour@oracle.com>, clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1615934770-395-1-git-send-email-victor.erminpour@oracle.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <ca8f318a-cfbb-d232-88ce-0b5be90c8b27@oracle.com>
Date:   Wed, 17 Mar 2021 10:24:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <1615934770-395-1-git-send-email-victor.erminpour@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:2944:6a32:b978:afe5]
X-ClientProxiedBy: SG2PR01CA0124.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::28) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:2944:6a32:b978:afe5] (2406:3003:2006:2288:2944:6a32:b978:afe5) by SG2PR01CA0124.apcprd01.prod.exchangelabs.com (2603:1096:4:40::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Wed, 17 Mar 2021 02:24:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21c39a8c-2933-4346-550f-08d8e8ebc22a
X-MS-TrafficTypeDiagnostic: MN2PR10MB3840:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB38406DB207AEAA9DF109ACC6E56A9@MN2PR10MB3840.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PkbYQe6L3QEdwgLW0aQ3MxpSCP5iK3mJF4JU6r8/mFtBpX//d1OHV7VDJFWlet2q8s/xaRgOn2jLzPZowIxMKjpe6B5RgRCaSZim1ZopG3nv3xQQTpjexlBG9lhn+EOQDW/eQlhHAXSawPUKZM/Qo16sfjeUiX81RqO/cB5U71KV62W/jHfinmmQmVmEsPTeD9e6t0O0jpnT4WPIBovM4Lcie5GM4UdtSmKXRJZHNSxdrEeoASa3wz1QZ3p4q39XKEo/gqwsUX7IBb29SX1y2TgQo2+2JjHlXDd9fF+hDVHNEGSeeNGFICq8JxK4tkuNfEnUMLGiW0sa7msK9waabOy+Z5egIRmKeTtiWAE5vYIkZvJIb5H6mQKgjzrKlhCMS5mQl7zUFGiK/BOV3TTyKHdxWM0y7kR5ao2iA/9f5zlAPdipDwYJ3Kt11Uj+ofEXGjHIjX3sHJYs1uO4bNU+k/69G/6Din5slP4EmOP5MYJzoyyQUCtwO2brL9jiJrskCxiElx/axbe2JEUEL4CWV93TWf4PzfCcYR1EyRILU6Ri8HX7dqvYCXBlZ9id2JHDCzqR/Sm7q7YRMrzaOlQW3bgRg+y3zERwMINosrX0jLPvoXbTn6oih/URdSmlYD1OVrqBl98tKiGapgPvnSUn0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(366004)(376002)(346002)(66946007)(83380400001)(31686004)(8676002)(86362001)(66476007)(53546011)(6486002)(8936002)(6666004)(44832011)(31696002)(478600001)(316002)(2906002)(36756003)(5660300002)(4326008)(186003)(2616005)(66556008)(16526019)(14773001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MUtoTHp0Yk9PL3RMWktBMEI2THYwUFIrSVliM0gzWFhrRGVmRmRlWHArblRu?=
 =?utf-8?B?eGY3S2IwcFVqUXozejRTUXBXUCs0ZldzT0ZRVkFWWTVEOC9aSTg1eVA2bTB6?=
 =?utf-8?B?eGk1eG84SDlqR3FPeU5BYVV1eDZzQVRGOVMyNE5COW1QbkNGRWJ4ZzFacmUw?=
 =?utf-8?B?S0xFVzVidVJXV3J1V3doODVRYUcvODNCbENqQVhlVlZrbnlraUFLaTd5Um03?=
 =?utf-8?B?eWFYMmhoTVNCWnJUSjRHYlRkdzNKNURCNTlRQ1FzMS9CQ2FzRlNRTkZzL0pw?=
 =?utf-8?B?cFdKRXV0K2tNa05uMythbDVSZzhrU2x0Y0VoWW5aRWF5Wi9meG05dHZLZTNl?=
 =?utf-8?B?R1R1Z2ZiVExUQStiNWZIRjZUYzJoNFNCTWhRN0M3TDF1eEZDZ014UlFEVHB1?=
 =?utf-8?B?UDAySnYya3RVOVdvN1lTdkttNTdoZ2hjbVJsSTRqa1M2ci92c2g2OXc1NmtK?=
 =?utf-8?B?SDd3aTRqZWZLcGQ5cTU1TXRuRlBId082NGc3KzZhc28wVEFWK2tJRCtRNVlO?=
 =?utf-8?B?dUVYM2Rrc3dkYnhVWVJyQTF6RE1xbW13cTBOV0lnWXRqcFk1SDk5RjFaNEVM?=
 =?utf-8?B?M0RGcWs1Njc3WTZ1WUZIMklZQjd0TDloRUdUeDcwck1FRjcyVVhOVVdmVHRa?=
 =?utf-8?B?bDk0R3Fha1FrcUtHMEJoak9YVWpRS0ZwSkdISDltMjlyRTRzNHdKcDg3OWNL?=
 =?utf-8?B?SWQvcTQ4VWU4Z3lZUldTZFhRTzJhdVBJVmo5NEpBWFUzV21VcTJ2L2oyaWFn?=
 =?utf-8?B?RSthbld5amR3Tnpkc2ZEbzFXM1h2UnJFbUU0YnVTcGw5Z3BOeVROeGZlMk9F?=
 =?utf-8?B?aEJoeUJ6NW1JaGp2OHA2aGtCenNBenB4Q2NxL3ROZm9LTENBRTVLMThsQ3BQ?=
 =?utf-8?B?aGE4dUdYVS8zbXRGaEVHY2ZNZVVqeVo2a2ZZWTg0aEtxL0tZb3hGZWdWM1NP?=
 =?utf-8?B?eDR2NEtrODBvUEpwbkpSSnRnL3R5bVJ0d1gzaXpNUmdjMGViNVNQTWpWS0RH?=
 =?utf-8?B?Tks5YWdXR0t2Tys4dXlJZ2hKODM5Q0FJdXBLdStSVGgvYkJDbUEvV2I1ZkN4?=
 =?utf-8?B?RkNzeVh4RlI2aSs3aDJnVHJYekZESFUwNnZWdHd4WE5XV01hdzRmK1VheWI5?=
 =?utf-8?B?OTQ1ZStaYXVNcEFycWRCUlE4RzJaU3J3Q3B1djdyR0xiRFlxTk1pUkxFb0o4?=
 =?utf-8?B?Q3g3OTdoYWZWblVzV0VQRHlOQjVUTmt2d3YvNjZheXI2aWxSOHNzVFpPS1hl?=
 =?utf-8?B?eWJSeDVOVEZMZXAvNGtHSERYTUIyNmdNU05ZYWk2YkdLbGJCYXhQdVBWczRP?=
 =?utf-8?B?YTNHRlBzK1E0WXFvVCt2blZtRmEySW5ROStweDR1QU84OGdpVlBIQm84OGxm?=
 =?utf-8?B?T2pMWWs0S3NOWlpPalkwakp1QmphY25MYmpZU01oVWFKOVlENCtoSFRud0Ji?=
 =?utf-8?B?SzZveTdmakhaZ2xtT3V6NWkyK3hRdnZlUVB5TlJLQmx1NmlmbDQxWDh0SFF3?=
 =?utf-8?B?ZlNhNEZrUy93Nk0xUWo4V08rNW9zb09ubkdIT2Y1QzRNN05HdkY5b2hXVmN0?=
 =?utf-8?B?enpBWFdCMG1zN0dBK0UvRUVwS3ZEeElHUXcrcGI0Skp3ZkhXY09wRU9kaytQ?=
 =?utf-8?B?KzZNbndYUGVtQ2ZLVUtnRTYrTVF3MXNyeGJrOVVBeDdhdTVMRWsxQUl1cFFq?=
 =?utf-8?B?K2lqcWhxWWtVVjNZamhBU0NBaDFQbmdqdHI2SVVNWTltZjgraDRkVm5DUXhy?=
 =?utf-8?B?RmFLQnJZMzNUczZ6ODFUUzhmTkNoZ2VzUW9rSDEvOWY1MjBUc1kveEprTHkx?=
 =?utf-8?B?Q21qbXMvNE45bE9QMVJHWjAwQWxMWTEyQ3Jnck9STDZkVmN0SXM1UnUyQ1NI?=
 =?utf-8?Q?LwmdoS8R7vdgk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c39a8c-2933-4346-550f-08d8e8ebc22a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 02:24:14.7110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /x9JTtGCVUBlqsOR7TlKCRDODQU561jDAbDQ2KP6sJi69Ic9tBa9RAP/3INWNMOzj/LBz4WohdA40G/gr3tTdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3840
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9925 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103170017
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9925 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103170017
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/03/2021 06:46, Victor Erminpour wrote:
> Calling cc-option will use KBUILD_CFLAGS, which when lazy setting
> subdir-ccflags-y produces the following build error:
> 
> scripts/Makefile.lib:10: *** Recursive variable `KBUILD_CFLAGS' \
> 	references itself (eventually).  Stop.
> 
> Use := assignment to subdir-ccflags-y when referencing cc-option.
> This causes make to also evaluate += immediately, cc-option
> calls are done right away and we don't end up with KBUILD_CFLAGS
> referencing itself.
> 

Thanks for the patch.
Reviewed-by: Anand Jain <anand.jain@oracle.com>

> Signed-off-by: Victor Erminpour <victor.erminpour@oracle.com>
> ---
>   fs/btrfs/Makefile | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> index b634c42115ea..3dba1336fa95 100644
> --- a/fs/btrfs/Makefile
> +++ b/fs/btrfs/Makefile
> @@ -7,10 +7,10 @@ subdir-ccflags-y += -Wmissing-format-attribute
>   subdir-ccflags-y += -Wmissing-prototypes
>   subdir-ccflags-y += -Wold-style-definition
>   subdir-ccflags-y += -Wmissing-include-dirs
> -subdir-ccflags-y += $(call cc-option, -Wunused-but-set-variable)
> -subdir-ccflags-y += $(call cc-option, -Wunused-const-variable)
> -subdir-ccflags-y += $(call cc-option, -Wpacked-not-aligned)
> -subdir-ccflags-y += $(call cc-option, -Wstringop-truncation)


> +subdir-ccflags-y := $(call cc-option, -Wunused-but-set-variable)
> +subdir-ccflags-y := $(call cc-option, -Wunused-const-variable)
> +subdir-ccflags-y := $(call cc-option, -Wpacked-not-aligned)
> +subdir-ccflags-y := $(call cc-option, -Wstringop-truncation)




>   # The following turn off the warnings enabled by -Wextra
>   subdir-ccflags-y += -Wno-missing-field-initializers
>   subdir-ccflags-y += -Wno-sign-compare
> 

