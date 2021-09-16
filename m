Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C77D40D3C3
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Sep 2021 09:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbhIPH2I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Sep 2021 03:28:08 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:3114 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234715AbhIPH2F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Sep 2021 03:28:05 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18G59exT022454;
        Thu, 16 Sep 2021 07:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RNIGeKG9vbyG+FDcfCJovBhIFRJNQZJHau2duoVGlH4=;
 b=tZ83fPLd7TJzvYYskMGq+29XJVpbRaK8oWvZtLsQwwQJR9P8D8eOybANgd+YBybl2p8B
 Tw+Qp8sP2sN+uDeCv17wrITBHOli/wmouVqzjFnBEGAF+lLExKjeaqX0OMKLnjPNBIKD
 R6jFMg2uuGn9FccfSR6J77FHHb/BBZFIsPsP/jn/+E8VbHGJQmDRdLO65Sg9tBkRIibV
 5hXr4pZjhzdGF+2mzcVE7Feb0EsjTNvxvoTvUyEmeJCqI18WbapY95pr5iMn5K1vPLMY
 qdAQo4ph4N24w0oGp33dd/+J2wR1Xcgy/jEJJ3Ok80xsu4rh5I2YY522s1KktbkCwN/d IA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=RNIGeKG9vbyG+FDcfCJovBhIFRJNQZJHau2duoVGlH4=;
 b=BNTzfjiCuNZKAU1cTvokb7lOM4XRi9nt4X9s5eja5tV7SUBO9cQYWuH687vOFAh4c5qg
 Bz137fndq/ev02OARi2NAxnzuLWj8ePJRUADgkWis/OL9U7X95+5/PaoOjqKuG3Muehx
 AbQ6ID4Rs+g+QBppASAlAF6Lm8q0+mCP/GOiyH0RH46x7JGHxOsUef2j4EQikTt/cArz
 m3JWK0z6J8cFCczivvRqOd29FLffdNLmPmtQsZworV1K5rhfBNgEQ3gKtP9awp5PwusT
 2GKZJn9OZnu6oq3dSNZ4vDMIuI1Yjlhfk1fAYoYYGJrY+jVaaikPgED+upEZcQ5t6C0J 7g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b3jy7j7qs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 07:26:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18G7Gd8h176985;
        Thu, 16 Sep 2021 07:26:41 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2044.outbound.protection.outlook.com [104.47.73.44])
        by aserp3030.oracle.com with ESMTP id 3b0jgfpdru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 07:26:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLWFA3upwU1R/TqKSLj1Aw7x4GdRfnD266n/5qfI48DJueD1QCbcNhLH5JjvHcYIWuDZP2Iy4fRdG9qDJyR54lQeKocnTltWZSegDIVX9j5BH85oos0yXqMkmK9kpmbrvjcR7hNfCfE7QulWP/uh5mEHrWWfKu0Ri5kvnaIHwRxeohPOJElJFB//ucHkhkNpQIXYBCFSH5Kexz3cZIgzkdoPMI2bPb5EZJAyqhG7PMvrapGxilsSyYDMPWQelop7weJFlOF+EEbMEtV9Yc0CcPcZVhbAD13V1+xehniqa22/PKib1k9UIFrUn2UcA0MsLS9OsBIBqgzpbNPE9bC6mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RNIGeKG9vbyG+FDcfCJovBhIFRJNQZJHau2duoVGlH4=;
 b=nvuUiZWMh5dgcGTNLmvGkaLlfmR88J+P6lTWn1NuhojuWMNVeewgC8BsonRct4XjcYAjGlE0MvAvV0IUwWOBYDlFdOtQ6VC6lkh8lwOk0hc1gmtfQBi7iwvSJeXBeAXB0WZ06wewEDwqG0dB00OwxzFynlDOZjHYI/eye6btKRWPNtQQvvzs60efkqpgKyUZFUJJ2qJgRu/QiKrhdbjJipyBU9++Z0MPAR4Jt4NF6h14arhG43tEFKw9qVCCYpLNndM1xETAuz9Y1DOYpm1EUT5fRiTrj/jHrU5Ia2SPW7CinBH7yZlYWKUm0/RI/7AGd+rBrYE+YG1vfHzXuibbRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNIGeKG9vbyG+FDcfCJovBhIFRJNQZJHau2duoVGlH4=;
 b=m+ye4GakgfpJUIktzmPpm+5+/pHNvMGho+PSBrAA2JCWKeXU6ggEhGx1NrrPvtLFtl70cDYEK7peAv3I0pVAEBCZOG4MhEgAxlPi9ijmgT5jBRTSSWCRh3PkxYfwcbDCQ7B7nlCTHYIqFURs2rIV37Swwr5GGMm1PZ/MjL5CHJU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2929.namprd10.prod.outlook.com (2603:10b6:208:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 07:26:38 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4500.018; Thu, 16 Sep 2021
 07:26:38 +0000
Subject: Re: [PATCH v2 1/8] btrfs-progs: Add btrfs_is_empty_uuid
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210914090558.79411-1-nborisov@suse.com>
 <20210914090558.79411-2-nborisov@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <15a241b0-e545-7603-f287-811216ca2eef@oracle.com>
Date:   Thu, 16 Sep 2021 15:26:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210914090558.79411-2-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0157.apcprd03.prod.outlook.com
 (2603:1096:4:c9::12) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.66.145] (203.116.164.13) by SG2PR03CA0157.apcprd03.prod.outlook.com (2603:1096:4:c9::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.9 via Frontend Transport; Thu, 16 Sep 2021 07:26:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42af8e26-46c0-467c-ed2c-08d978e3525a
X-MS-TrafficTypeDiagnostic: BL0PR10MB2929:
X-Microsoft-Antispam-PRVS: <BL0PR10MB2929FBB82067DA660B087103E5DC9@BL0PR10MB2929.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PmtEUt832Kx22lsl0F3jYn2DPm6pOHZDyEXgLWlXlIWadTotJGvaniAlodKj8g3YQP7ovKJLK4Wu7BeqSNxwQQwp4XcsNRlPuTWiQ9vgyRpLxRgWwsILp3kmIgVpvq7uZpiV8x9kzizu2EPs/YYtCaTd+wRWF4vB1UJu3ESiLguyIo7dU7y22VFB3vXHY64xrVikC0hiwx6vno5dGhUgc1hRVfdVOarF9w2k5FhgC3t9KGXKuLgRM0kJVG6W5d8V14C4KvaoMQ5pVCGSeWW3VME2Ppmo8fj8SEOndI4SS8OwUTbAFmzWYaSV0eIU6RKhUvGRKW1B1EeKY/Q5e+SC/OIrsc24u7Pdg/NY0gWLEua+Rp+3CJwS+JHHfMJN85EKgjduEvjykgk83vTO69uuAYoHNPHLsalrEbx6f6k6Lh1mDf904Df3/Z0P+Zq+bKGthYvmgsLVi605g/gAMDU6uxMe1/akrPWPU0lM1WwTWWdg/HTNY3P97drxTtgFFbtOGJcoooQ8h2EGGTCXAjUC2+1WoMByrYHlfCqr6Z4fW0tQea1pXzC7zsomvjLMYm+TvKl4EZC5PcQqzNogRRdaOnCZ+rv5oCLXxP98wrKvS3uM94hafZItlBUyyquxoJNmIb0heJ/pRdFxg9HA4UWBymj5DFXDhN+qKoULHOu+Eiu+niIidQZtrEnG6B62od5rZ/StpA7niymV2Zpc7ZRd7mO/BouCczh/obtIjqEojPk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(346002)(366004)(39860400002)(2616005)(26005)(8936002)(956004)(86362001)(5660300002)(6666004)(8676002)(66476007)(66556008)(186003)(38100700002)(66946007)(44832011)(2906002)(31696002)(6486002)(478600001)(53546011)(31686004)(316002)(83380400001)(16576012)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckFrWnNuRHNiVThKZmhsWnRWUUJzRWt4YXY1NCswWmowK083b281bVNZOUFY?=
 =?utf-8?B?VnN4YWFKYkZ4SExWNFVnd0RJWS9iMmhiNG5jUDFFTXlTUWpBTk9Bd2hWaGlL?=
 =?utf-8?B?SWVjQ0J1bURoaE9EVE1oOHVCMnhDWVVPWms1UFViYVFFeHZTMFpOVXdVZU1B?=
 =?utf-8?B?eGhvdnRFKzhvOW9INCtqcXBxYy9wVjlZMlEvMkJIR1FsUmxydFE5TXdKTFp2?=
 =?utf-8?B?TUlCajdNbG1CZVlYRTd3L1M0WEFrTHpZaWZibTJ2WEYxWGVYK1dBSlBzT1d4?=
 =?utf-8?B?UWRNMzhDdVA4a0ZGV1JOVWJ6cXlRMjdvMWRkc2VGd3V5aUh0a2pFV0sxVWls?=
 =?utf-8?B?b0wyRHBmNXhaSFdOS0U1SEtOUkprNU1hS09sWCtJZ1VzR2NqVHF0VE1kcUlV?=
 =?utf-8?B?QlJwMHcrNGgxQ2FFcWxac1VVMjJWRVNwRGlONHpocDNlMDQxcm13NkVhckV2?=
 =?utf-8?B?NjZ3aDVKTTBiQVNjWFROTWpxOUZOcVgyZlVLOFFCZEFybWhnS2ZHcS9oUDBB?=
 =?utf-8?B?NWExQ29pak5qWWtFSm9qbDk1czA3RWplZzNUNHJCalZFMG4xaGNtdmpTWVZ3?=
 =?utf-8?B?TlozMUxpRk9qbk0wN1BZVFAycTVla0ovL2xKbCtyOVF3S1RZNFU5dzQ4M3hX?=
 =?utf-8?B?ZnZ4enJOYmo5aEkxZTBtQ05qcVpvaFl6VnJsMmRJV2UvNlA3RlBpTUhZdUFO?=
 =?utf-8?B?OEhNc3NFWithUzJmNFovS2s1Ry9SYWN2WnhaTERiZlJyejI4YUEzcXF6Q1ZV?=
 =?utf-8?B?b2Q3NE4vdy8zWktOWXdwb2hmYXlxVTN2WEpTWXovUDB3NXE0OU5tWllrT0o0?=
 =?utf-8?B?akU5RkYraGRMUWVvZzFWbVRRbHpWMGNEUVJsWm5qVmVMek5oWkVrWEFwemF6?=
 =?utf-8?B?R29RYStpZkJiajFFR0hRRDduNjBkZlgvUTE2V3oxZ1BsY1F4MHlFTGc4SWph?=
 =?utf-8?B?Y2h3dUJLYzhtUVR1Ujk3WUZCV1YzVHJjb0pUNmRpYWc0MTJkOTB1YWN1dEo3?=
 =?utf-8?B?UTZWckJzTjhHSXZ4QTZKeVNOSktXMGFhcTFnbjdqT2h0ZndpNFd6d1BrUGNF?=
 =?utf-8?B?LzR3eUlsQnRpS3kwM1BPL1laTTA5dzhYbm90VjFoV0Mvc3RMdnhjOE1sZHp0?=
 =?utf-8?B?WXIxLzNKMHBhYXpweHhWVm5ZOWRRSHlHNzFNM2RGQ0hWeXBZWFE5MWxpWDk0?=
 =?utf-8?B?dkxSSUxWS3BwdmtsK3hzMms3VlBGRjFpYzJwK0V5ZVhpbk1JRzZZTDBLdGZl?=
 =?utf-8?B?T29mVU16WG9SZjIxZG5id0p3N28yeWRjb25nQjJVUzdYbi8zcGpqcEFKcDJo?=
 =?utf-8?B?WHBCVnM0NUZ6MGg3ZDlQVWFDVEd0OUcranppd29KbzlpNW91TEZBTGNkYWVz?=
 =?utf-8?B?cFFBTTk5Q25iV3NVSHRSTGZYTGVuREN0bDhBZ3ZGNG5uQW5QU0xiUWdwQkFj?=
 =?utf-8?B?U2tndFlxM09tazJ3SmhNUFphNStSYThlNk5nTkxETERCcTYvVHJhbzBrOVFl?=
 =?utf-8?B?cGNQL0d2VjFEb2FQazRpYzA5YVRUMzRGTXoxaStqcXgvYUpBMkRJV3RPbXZS?=
 =?utf-8?B?WVBibkJaaGY5WjV3cTJ6TmZoUnhTNFcyR1g4Slp3RG43bVNXYUpTZG93T0lX?=
 =?utf-8?B?UmJoVWZ6aTlYVEJCNGFPeFFmTnlNSE4rQW9PZzdvNlNOZXQrbUVoeGRKKytZ?=
 =?utf-8?B?L2RXS1N3VXV2Z1M5THZnTHRINW1mRjhKRUkzVTAwN204aDFUNG1xaTNURlFS?=
 =?utf-8?Q?Up9Cy+ZjKKZLhe8mMJ9a+E+tVfTWV/NurRwwC47?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42af8e26-46c0-467c-ed2c-08d978e3525a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 07:26:38.7441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+o9zj7e6JD5YhFkl5CT1WoGBadzC1NQQSMedW+qw0mOzD0sKj1yBRSH5DriA40X45+QIO7PDwncmUZw8Pl3bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2929
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10108 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160046
X-Proofpoint-GUID: IN4cIKlu1BO6fMwlrBitQPRtFz2ejJhd
X-Proofpoint-ORIG-GUID: IN4cIKlu1BO6fMwlrBitQPRtFz2ejJhd
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14/09/2021 17:05, Nikolay Borisov wrote:
> This utility function is needed by the RO->RW snapshot detection code.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   kernel-shared/ctree.h     |  2 ++
>   kernel-shared/uuid-tree.c | 11 +++++++++++
>   2 files changed, 13 insertions(+)
> 
> diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
> index 3cca60323e3d..f53436a7f38b 100644
> --- a/kernel-shared/ctree.h
> +++ b/kernel-shared/ctree.h
> @@ -2860,6 +2860,8 @@ int btrfs_lookup_uuid_received_subvol_item(int fd, const u8 *uuid,
>   int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
>   			u64 subvol_id_cpu);
>   
> +int btrfs_is_empty_uuid(u8 *uuid);
> +
>   static inline int is_fstree(u64 rootid)
>   {
>   	if (rootid == BTRFS_FS_TREE_OBJECTID ||
> diff --git a/kernel-shared/uuid-tree.c b/kernel-shared/uuid-tree.c
> index 21115a4d2d09..51a7b5d9ff5d 100644
> --- a/kernel-shared/uuid-tree.c
> +++ b/kernel-shared/uuid-tree.c
> @@ -109,3 +109,14 @@ int btrfs_lookup_uuid_received_subvol_item(int fd, const u8 *uuid,
>   					  BTRFS_UUID_KEY_RECEIVED_SUBVOL,
>   					  subvol_id);
>   }
> +
> +int btrfs_is_empty_uuid(u8 *uuid)
> +{
> +	int i;
> +
> +	for (i = 0; i < BTRFS_UUID_SIZE; i++) {
> +		if (uuid[i])
> +			return 0;
> +	}
> +	return 1;
> +}
> 

   You could use uuid_is_null(). No?


