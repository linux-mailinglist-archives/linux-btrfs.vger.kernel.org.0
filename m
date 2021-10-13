Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2AF542B99C
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 09:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238804AbhJMHxx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 03:53:53 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:13074 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238747AbhJMHxw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 03:53:52 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19D6q6Ck028297;
        Wed, 13 Oct 2021 07:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=njpzeU7U26n2y3KzfccXGACn3lsKHRVA1ras1Q2fJt0=;
 b=wkIJbICvXUdOXm6EgqyxsaJfEXnHktGK1IvSi4bNGZOmeLS+5fnS4C9QpuWjtSfChG2h
 0cqa2VLcNs6mEa1oQhbQ9Uxyckj04ioF4usMq/gNq/oV8qnGCfL3xk9lQGBi0k5gCSAl
 IvXXJssLxPLKg/Xnq13u2oDrYLQ0OMRigIHFXNBmsJRLNeCXqAJ334aINpYIWbTvtbDb
 VhHT0bt4egcf76gNmS0rBQUAup34N0/XlJFbt9FaZFuoaD/7OwOQETUL9uk8xhQMCDwT
 prGTTrfAGyt51nC2IzlWwTUx/cB34s2TV+X3VfHrM9W2NSTHMjT1Sq5ykVqq4WC/Bqe9 pA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bnkbja64e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 07:51:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19D7okSx003524;
        Wed, 13 Oct 2021 07:51:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by aserp3020.oracle.com with ESMTP id 3bmae0bvnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 07:51:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1c+qK8xE6AZ1bayT1wTqJS9NcRiQEAba8N1exycW8X5MVEyjDH3k14Tugg8ZHnrOt4uR7Vd3K+eU4tQmU6p1SgNTV1QCjoVZMzhRkMKRSwErvUw9wptHBsWxbhXpv0m2C6h/ARJpaXVDONf5FPgPAEk1NeSic/WS5wSojBb6ZzS31nQg1F0A7Gt5z6UYPheKwf80QquLjxgs2XtQgTmyg3Wnlj9tHsSPg4qtD/BOBQBz8h/PNpYrYYx3zji1z1YnLK/4xA9B6howRfYvbtZpAtaGROYWdQQFjYGQFK5wM9ysGTDPoI2YJcwOxxyly5ZTasv0BV264FIYLS8sifJLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njpzeU7U26n2y3KzfccXGACn3lsKHRVA1ras1Q2fJt0=;
 b=LmUbh3kRoaEIszQZ55tTM77J+Xzx99It3N0XC1HTNYlLuJkVofVSlovGOjsZkEwuXW7qhW7XD/6FtFQ0IAQb3XL5FRVGig4LSuBOf/vcra3N9pPF5beJbE6jzBPIy5ZclhFODWtzaD2qMF+q7ks7lrcTriZaIFf5/q31w+hQlpO/GlnOqp3icmALEIZR23cU72o9d9x/xXHkcS8h5fT1HYCpbT1KxhzpEI9XwQtESNESQpMRM1L6ybvK1E6KA3P0pVRBHMWeiFbp+ut0BgO/jvy8miw4LN09EXRFxcBz93jkHBEvtJ7ILp/HMBmryi8BRd9rezWDjCukMUNfqb+Tvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njpzeU7U26n2y3KzfccXGACn3lsKHRVA1ras1Q2fJt0=;
 b=rOwufV4TdCzlyIBcftqKPcWpog7Jcd2ow/Y2cixtZF4KzqrFCB7U4J5CbjMBWfTQZIdt1k1md2bBp6qpP0An5abOii+aSMAq8iwRC5kAODrfT66fabqwpMnVxbB9Syf9KJyn4Vv3+mlyAa8PWbYrbSEg5uJIE+Qe5N2G4+Z+YpY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4095.namprd10.prod.outlook.com (2603:10b6:208:11b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Wed, 13 Oct
 2021 07:51:41 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 07:51:41 +0000
Subject: Re: [PATCH] btrfs: replace snprintf in show functions with sysfs_emit
To:     Qing Wang <wangqing@vivo.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1634095717-4480-1-git-send-email-wangqing@vivo.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <6f03e790-6f21-703f-c761-a034575f465e@oracle.com>
Date:   Wed, 13 Oct 2021 15:51:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <1634095717-4480-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SI2PR02CA0009.apcprd02.prod.outlook.com (2603:1096:4:194::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 07:51:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79488dfb-fc90-43d4-2ed5-08d98e1e4b7c
X-MS-TrafficTypeDiagnostic: MN2PR10MB4095:
X-Microsoft-Antispam-PRVS: <MN2PR10MB40958ACE04D972B39BD193CAE5B79@MN2PR10MB4095.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7sukValwCqsZmhLS06mPzUsOgftVw0xbyftvKFBWqh0aS1Sc7rbSIiCw1H9P5wWIO/vcs1CAUjgzC4MSzNKu/wnBbhjgmwBDMwwfKIjUQ/45oYUbux267k+Cg3DkspSxr/BCOqZzejyK8BwUv6oudyw5ZDL/ySxNJQkqn9BKMp95dToZey+nrC2a17Eewzd1Knl9hemMp6ynqNDJKVpmpJLRt+hfJqCgo1XQmYLS/SmK0G3JGWvkbmp3TUGSpoxNs6X976rEYjP8EWFlmkfKnQW/Ib6mBg2tZqq+BbJ/vhTNAfTqjx6ywxDfIZ9r+7NmSqlbs3g5gRWDOxxJMrjNvzw2yxiZs6f7gA0dR4DV1b8g1IXK6DDNtfRDZe8PWzPbhNxp4laarj0TZ3M8U0/YaOe5GyqVDOfAkdemRMh9DN/cinJSEnfPigCa+E9urM8vqcx9aU95hD4sKB9uqkFyL2mv8i1+rPDKEcZCR3vzX8pKU2Vbj14ljd5u8kfE2ttfgqyDMyY42yIGCYpQgtslm8djSa3T0RycZ1cD84tNNlfOoBQ2tAS+8gmWpTCT94VL8gMeautc4zxdxOd0CUJBkjpnuiGSksnajwZqFDIYvJjJ/9UHKBWXaIvFyZnmtF33MveNeZlLxjbMgDBWi6/CtnKCgZA10llT8dmGYLGakls+GD0SeT7XH5T7xLrNwOIync4SeemBxTYOdxS1FMkedG7DwGQkHXCrTSijBSFlmnE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(31696002)(83380400001)(186003)(8676002)(2906002)(44832011)(8936002)(6486002)(66946007)(66476007)(66556008)(26005)(16576012)(2616005)(6666004)(5660300002)(508600001)(31686004)(956004)(53546011)(110136005)(38100700002)(36756003)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUdOc0lXWWVueDE5dlhhSkQrelFMNkJheHB2bWR1czVCVGdOdU1oc3ZzMjFB?=
 =?utf-8?B?V0tEK1Jtd3NjcC9WOGc3VlFkRkNmQ2JiWTFORFpuT3cyaUN4b0ZxTVdDUWxZ?=
 =?utf-8?B?RExOczc3cW5hZWRBYjRrNUptNzdVQkEzcTlnVldiUkFCdnNCUzRQMG1BVGEx?=
 =?utf-8?B?and4c1ZoeDJQazc3YkEvNjIrWjByY1VJc1UzVXVLM2FBd2dXalFXRjZhaGRW?=
 =?utf-8?B?V3VhdUtLRHVyZHNFMnhXZCsvWUhvN0ltWk01cDB0NVUzWmNSSS9tdWtRN1ln?=
 =?utf-8?B?Vm1QMXFLL1hHano1RDNMb01hTklYY05oR080K1EvQitZSm94L016bkRKU3lx?=
 =?utf-8?B?N1RjbGRLeVU2ay8yWVcyckpFNXRQUXFBSWhXRkhMNEQ5MndLQXNjNXNUV3BS?=
 =?utf-8?B?NEFvV3dUVUJZN3VWTWxFOXFCRVBBbTNBOEZtbjlWUmFWM3pUOVdsOVVLY1Zq?=
 =?utf-8?B?Y3ArRTMvcEEyVkJKSFBnZHBGQ1dwOS9GMmFYdmszcXRlRGNlMHNGcDlwOHBI?=
 =?utf-8?B?R0NaeHVTVHpDZEhlWWFJMUhVdlE4RE8xOGZLZmMzYXVTYXRHcjVRS3VkZk5x?=
 =?utf-8?B?SWdCR1hHVVJKWmxidGVkN0hiSUpSb0JlTk92aGRUVGFFU3Q0YWJlYUFuZk9G?=
 =?utf-8?B?aDJRenlVSFRTVXNUS2xFc1pUVXBCSUJ0Y0hldUZaeFJPMkN2U2RGR3pQNFVK?=
 =?utf-8?B?Sm1BdlpkVEVubFpDUU1XN0s3cFZTRFBEYmw5cWFMM2wzaU8rYkp1N3Z3d2hx?=
 =?utf-8?B?bW1kM051aEZ5d3A2bnNkalBmb3kyMG53Mm5lb1F4c0tYNVRNa3RBbUFlaVdY?=
 =?utf-8?B?dmFCQmF1VStGOFRQK3JCVjkrbGExaWJXVCtod251Q2kyU0NLQTYyOUcyQWth?=
 =?utf-8?B?TzZuc09JenhsV25iY2RTWTZrSnRNVFBxQlJqengzd3hMeUdhZ1lRdmJsMVdF?=
 =?utf-8?B?dmthZDRnMEFSYy9uZG8vb0FSRms0eFdzTjh0b0xaNjFBb2JRMCtGd3Z5eDZU?=
 =?utf-8?B?cDFPZWZXUkZsY2l4czVBL1dHUWJvMUNlMHgyT0x1MEI5SXRpZnJMdjdJYXVB?=
 =?utf-8?B?TUE1aFhFVmdWdzFycmdtSEgyRjY2QTFVRXIrTnBidGZRNGlNK1pOVjdzenJZ?=
 =?utf-8?B?ZUxwZld3Slo1bExWd0JqaDgvbHZ0bnIzNTdqSHJDQnN1ZXhIZzlNdlp3N3hV?=
 =?utf-8?B?Nmg0K21MQjBaVkR6WmJEUWx2WG5sM09BMHY0WEhGVzhTdUZ2Ny8rT0NybDRZ?=
 =?utf-8?B?ZVljVVJSRmZxd1F2ZENVVXQ3UXJyS083N1ZFZVcvdWs4RHJFbW5nMDY5N2ZW?=
 =?utf-8?B?dHJxcjkvUXQ0RHVwY3lSOW4vdUttK08zTmg2dTVsS2hGL2dTaEVKUDFERzR0?=
 =?utf-8?B?VVVxNC96QldyRUY1L3Eza2hZM0l1NUJpbnNkaXdnTUdLdk1yblRlck1RZFVq?=
 =?utf-8?B?cUNkVjZvcytiakQxck1MRzM3ZE00NXJBcGpYTWl4Uk1mYW1OT2VISmhsY2hn?=
 =?utf-8?B?ZldDWGdCOXhSUm9STVl5SUVacW0vcVBIR0FTeGQ3b0RTUnQ3UFdqT2ZzTWt0?=
 =?utf-8?B?MVBObSszdVV2UG5iNnM5cTg4b1ZlMGZwR3I2ZmNEd1loaHZrN1NLSFlVcDhC?=
 =?utf-8?B?RTB6eVM4b1ROelp4dHcxcFVBOEV5bTNJbnZCRWNVQTk0elB0WVNZbGx6Wnd6?=
 =?utf-8?B?UG1iZUR4c0oxUjd0Vjh2MUVlWHBJRjdxR1o0VmgrWll0bE9XM25PMHZ1UHNQ?=
 =?utf-8?Q?44Ezt6ZRuV9jEGakqVc6nQmSXBCkPC5ew2BcCnv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79488dfb-fc90-43d4-2ed5-08d98e1e4b7c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 07:51:41.6905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wmZ7B/X0y1CwO6Y1ZwpMpKaZ+KJAMI0fVKP1hjnMDcewejv7+fgIMhWw8Q0BbzgeabjX8hfXdr0VDMG2LbQmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4095
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10135 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130052
X-Proofpoint-GUID: VyXizssHNXxfxGlzH229aFrGY8uBUK84
X-Proofpoint-ORIG-GUID: VyXizssHNXxfxGlzH229aFrGY8uBUK84
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13/10/2021 11:28, Qing Wang wrote:
> coccicheck complains about the use of snprintf() in sysfs show functions.

It looks like the reason is snprintf() unaware of the PAGE_SIZE 
max_limit of the buf.

> Fix the following coccicheck warning:
> fs/btrfs/sysfs.c:335:8-16: WARNING: use scnprintf or sprintf.

Hm. We use snprintf() at quite a lot more places in sysfs.c and, I don't 
see them getting this fix. Why?

> Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Below commit has added it. Nice.

commit 2efc459d06f1630001e3984854848a5647086232
Date:   Wed Sep 16 13:40:38 2020 -0700

     sysfs: Add sysfs_emit and sysfs_emit_at to format sysfs out

Thanks, Anand

> 
> Signed-off-by: Qing Wang <wangqing@vivo.com>
> ---
>   fs/btrfs/sysfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 9d1d140..fda094a 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -332,7 +332,7 @@ BTRFS_ATTR(static_feature, supported_checksums, supported_checksums_show);
>   static ssize_t send_stream_version_show(struct kobject *kobj,
>   					struct kobj_attribute *ka, char *buf)
>   {
> -	return snprintf(buf, PAGE_SIZE, "%d\n", BTRFS_SEND_STREAM_VERSION);
> +	return sysfs_emit(buf, "%d\n", BTRFS_SEND_STREAM_VERSION);
>   }
>   BTRFS_ATTR(static_feature, send_stream_version, send_stream_version_show);
>   
> 

