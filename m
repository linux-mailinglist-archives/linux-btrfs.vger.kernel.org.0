Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C17236AAF0
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 05:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhDZDD2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Apr 2021 23:03:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47174 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbhDZDD2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Apr 2021 23:03:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13Q31bLn180469;
        Mon, 26 Apr 2021 03:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=weex5ATTH74DC8WpautWOtVNTQGGQUAjENuk40mhJG4=;
 b=Q0lD643oishVP1FmDeI6ROjBeCwQG9UCa/5Xk++JV0O7Jq0bb1dhvit64v5Bb2reIibX
 P2nO7M+IxiBbyKcaptjk4ASdryRNmVLqop09PAssx605PIu98swc/9grTOXIeM9bHOrO
 smPrMBX/8nD60Fb591TRAXL85+VPPeRCz/D2tW3mBB/M7kgkZNwfN/3lYU0dARSRh92Y
 i8FsMXx6GQfPECMpio5pHmUd6Aol5KfLq9vPUiLAnvw/P4eqsFtUhRCxlV1ncsIyXk1t
 D53Q4MzQJnGOgNkd938fBd6PeP6LXHDuDFkwgDMGXrI5voe3SQm+vH7yOoU0aE9ev/JU wQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 385aeprew6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 03:02:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13Q30FXd066697;
        Mon, 26 Apr 2021 03:02:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by aserp3030.oracle.com with ESMTP id 3849ccdhue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 03:02:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UW3MdjFCgYXJDIwlC/XeOXEwIMOEcLFvv2kBaSpivf2IaEds+RMVgGvi6YyvQP+Cbt8DoQ7ZSbatTtRVGqJy/l1vma7fMmAbGZJ/7wwc5Zln03OMy5D/hadA+hNQRrwddtmMvhE8tS+2nrcO7VjRZR6s7KETjFdzjgGZAcW5Z2jAuDmx/cO6JuD9nnHpkpdsA3V3JRHyt1U7hzW90CznMZDu1BJhEzfhHf/mnkMGyouGWo4xhjk3rOWF/l1RIaSUSAYPyjrTJa86t4cATJzENigPg3Fs7cTzo7mNBDe0sKFK7E/RIZvIW/0iC/Paz7gVDG+BqVjaHoGXKkXv82Kdeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weex5ATTH74DC8WpautWOtVNTQGGQUAjENuk40mhJG4=;
 b=gEJIkq2FJxxlu9Va5N5deyTYxBM/Z4Wx4barRGq80R0vCTJ5svWweeTVc379HmHmar3Z+GaGyBP79SIKJCTeLrtzRG6TOGw23S9COLXupKTXDnZk29nFaV+Ij5ag1oxJiq6FiU1haHsjZSeC69jEm0/Wbi9SieC3nHabiyEmZrTJePYqttYSjvVlxGCrfsDj+m99Qkf5UJN+JPnNvLC6lfZNkQAgVEVdLYJHNeO7NleZ/1GLSVQUhIUu8VFPerTIgsAIN/dIavg2hkxk88oAJhL4Cjno/iUEjevg4G4DvvZBU2Kn0grG7yQ9/9HydZtQpQG2XkKHIeZ/5VhNB2B4wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weex5ATTH74DC8WpautWOtVNTQGGQUAjENuk40mhJG4=;
 b=G+9zd/Jc99c3Pje7XTfQkQvAYn49Caoof2V0SHPvlvWN47U8/jV0lXe0ESeqYUiYLg4QHwcsisCtUtsoYlE13IOKqXajyAalmFHTQJxGyjOkLY5XEuXxifOsMUhnQHKQmVVFSc/32tXeM8g2lLV+AECbi3faGyyZAAodvz9ibw8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4818.namprd10.prod.outlook.com (2603:10b6:208:30e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Mon, 26 Apr
 2021 03:02:39 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%7]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 03:02:38 +0000
Subject: Re: [PATCH] btrfs: remove comment for argument seed of
 btrfs_find_device
To:     Su Yue <l@damenly.su>, linux-btrfs@vger.kernel.org
References: <20210425083504.5187-1-l@damenly.su>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <75036b4e-61cd-c4ed-c7b7-5c6aff0a33a4@oracle.com>
Date:   Mon, 26 Apr 2021 11:02:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <20210425083504.5187-1-l@damenly.su>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:9d5b:c1cb:ca5b:74f]
X-ClientProxiedBy: SG2PR06CA0244.apcprd06.prod.outlook.com
 (2603:1096:4:ac::28) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:9d5b:c1cb:ca5b:74f] (2406:3003:2006:2288:9d5b:c1cb:ca5b:74f) by SG2PR06CA0244.apcprd06.prod.outlook.com (2603:1096:4:ac::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Mon, 26 Apr 2021 03:02:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f44dc7c1-eb59-4ffa-ac61-08d9085fbfe8
X-MS-TrafficTypeDiagnostic: BLAPR10MB4818:
X-Microsoft-Antispam-PRVS: <BLAPR10MB4818A89754AF4E5DEDC3DE6AE5429@BLAPR10MB4818.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nyDi4MA867PKLiYJ0K7jRrhEtgGxFTJMBFpt2miq5A5NrWMEx0mKV9isccl+QUj7b4GVSaH0WMTtSQCe9YZd2MLxBT8JFpmH1b50kZ10YnzTd6Zpubxl1K5va0npYymJxJ4Z3lcwWlv/YWzOipuka8xJrxIiVugFuVM+trCwmqWFOKoBAYZD7xZrqF1nnmaYzTlCAECrdYQT5+GVpNAHw7lSITAapaIUdJpEY8Vvp8Ro1fYfXhJLaTP4QMrkiUjFF7EBpMoe5gs/FGHt/O7BHat/8r69nDuCCaUknzNw34kFHHgYVBwDwhUSvsCKMLJD4v1zQFVD2oKl3QpxapKGwhXhHsSsRBxJ0qGQT4SdpdGQSt0d1XyHPHEFCMqqMrD5KvBmkhOMZbVZjZ1n6fTNPhZh/Yk+W8mXKQ3pHQ37fHcuvC8ROsXKw/i2xLTAiFYfU+sSHbKJCAschNKcwzhTsrZ8x3bKYtebFO2eZB5DsjGyPmVmO6IOUVS8xNpBsnWml54KhZPmTl7XGGQmSyOr22nFX7R1o0wCQcdVEo/RKXhr3eOx2XDiuwtUrPzUKvZEUwdxOPrRjUg+Xt+tNSo8A7Jo4w7EGUUXxhnEfFT1FyHQxG7k4AkVsuCaD2I11B6txVMMANMVmO3keqfRWEBt6YYYxcV5x/xgeDVqvjFZF/q09TaOjO60haoPGCCSydACzbIxZYXGKyU2hlDrdGv2PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(39860400002)(366004)(376002)(66946007)(36756003)(66476007)(66556008)(2906002)(31686004)(4744005)(8936002)(86362001)(8676002)(2616005)(44832011)(5660300002)(83380400001)(53546011)(38100700002)(478600001)(6486002)(16526019)(186003)(31696002)(316002)(6666004)(781001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aDB6aWRGUkVhWEFHQnBIci8zSHdHMWJ6aElZQm5sd2YySXhOVm4zYVlJTnU2?=
 =?utf-8?B?VmlPQ295TUhHSitGMGJJYlZuME5RZVl5UUR3WTJtN09CMUxuWjRzU1o3Ulho?=
 =?utf-8?B?VWM2Vk1kc3hhNHFrTkp4NUdMNlltVTNhWmVYSTUrT0R4WVErcTBkOUhqMk1r?=
 =?utf-8?B?M25ucDl6Qll4WFFZNGNFeTdVWXFDcG02S3ZLeURlMXdRcnRpZEc5WmgxVm5T?=
 =?utf-8?B?dXo0NUEyZlZGVEJ4U3dtQ3ArNXQ4QXh5dzRKZVV5eDJnaUJWUDhMT0ZaSHUv?=
 =?utf-8?B?SDVNbjBzUFhpSEdwbGMvTEIvdGZyNE94RHhEVnI2eVcxZ01BRkFJSTNCelV6?=
 =?utf-8?B?MEYrY0c1RUp1dU05ZFIzSFVuNkRSNHdLVTNXUWhXTVgreS9UcktibGpBU3B6?=
 =?utf-8?B?Q1NNZDAxQnZHWE5YVHloVTFWZjVCUUoxUlo4UFZFeWlOc3o2Slc1RHR3TjJI?=
 =?utf-8?B?aGxhRlN1ZzhrWXgwcit0V21UYk1pUU9RNm5VS1VDbEdWeEQrYW9Edkwwclh2?=
 =?utf-8?B?UG4ycEFPZjdaQUdzd2g2UENQYlZaR0psNWxWZUF2aHNwSkZBbm9nSjJlelJt?=
 =?utf-8?B?a0ZCSU04d095MGRTSWpBWTMrOHBSeEZFWmtXOVNsMytEbFlQM1dzb0F5ajd2?=
 =?utf-8?B?SzV1WXBlbnByTHY1WnhOaTVqNVdIT2pQL1lRM0d4RTlqUmxuUlpYTllyVGE2?=
 =?utf-8?B?cEY5U3FtVDY4TmtBTzVucjF6bHgvVVljYkdZbkxjMk9EZG1CeWh4N25jbzR4?=
 =?utf-8?B?aUlGQjE0Zk1qalhnQ2VWWWREWFlMWG1qcGJvUkNzc3FGaVc0VVNBMjhJUFht?=
 =?utf-8?B?L3pQMXZta04yYmh4UW1jaXo3OVpQWUhWQi9BRFdoSEFXU2VoUXhPVThzSXBW?=
 =?utf-8?B?ZWJpVEVGenY3eCtFbjdteHhNV2prWGtGR2xaUWdLUnV1WXphN0MyenFaYnYr?=
 =?utf-8?B?NXprRWZuaDJ1dFZYTjlPVUdwMUpGVGhySURHOXVBL0owQWtUcURFU0FXOXg4?=
 =?utf-8?B?dHJzNDlsL01mRkF0K0hUNTVqMjJqU1JVTG41SDNtczFTUHRQUld5MTlnVlo5?=
 =?utf-8?B?L3NKdXB5UzVtQ0dNY1hEWFNIT3M3VTNDVjlDTkRqRCtSbjcrTEZub1FsL1dK?=
 =?utf-8?B?M0ZFdWYzWThGdGxoc0pWOUw5RlF3dy82WkRTWmV1Z2tqZTNNQUg0bktJdWR1?=
 =?utf-8?B?RFIxWWgxb3hNSTF1WlMvTHgveHNvcUl6dU84Y3E5eXJLYkZlS3Z3b2RsdmQy?=
 =?utf-8?B?c3NIMHBwMmVMdDVxVjRqblhVQi9Ga3Z1LzhkUUo1aWZqUTk5ZVpyaE9oSi8r?=
 =?utf-8?B?VkdHZjh2eDJIN0h3TWJ4QkJ5cmYzNU11RzRiN0xHeU5ubkp3WUVyK2k5U1dP?=
 =?utf-8?B?RklCS2RZT0dBSllkaG5CYm1Ed2hOREZnTVltZ2lTQmc3akE5MDkxK3MvbHBG?=
 =?utf-8?B?WHFuUnFHcjZXbkYxeGI5Y0tBTHBGaC9mbE9mMXJ5OVVsK2FHdytabVFiRjlI?=
 =?utf-8?B?dStDcGwzTEV6UlVwSWtsN1piaG14YW0xU2syZ254RXVzWld3amp3cXJkVE9C?=
 =?utf-8?B?SVhjU2ViK2RWL1BoMmh6MzBpWTI1NC9aQ2FLbi9XRXgyaFNGVlpYR29BU0gv?=
 =?utf-8?B?U1RoaDFCcjNwL3BJQVQrZnM0TUR0S1J5MWhIak5HZXlpRnlmajRPSU1pa0xD?=
 =?utf-8?B?b0lYejJPdnFIY09hMnJ1bTczK09SV1BaOEdiSFB2M09MSjdKSXc2d3lDTnRQ?=
 =?utf-8?B?SnQ1M0hLK3Y2OFMxM0NFWkt3aUFEeHhzQzZXeE52dXY4S3dUYkxjRDlBNDNE?=
 =?utf-8?B?VGJtc2s0RmkwMGRrUkRiR1dNNjRuVHJwRFdVSFZzZ1dmbExBTVJ0ZVJDcFVU?=
 =?utf-8?Q?8eeWGRLGrOspW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f44dc7c1-eb59-4ffa-ac61-08d9085fbfe8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 03:02:38.8648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XO4ViStk4QD7MKNG16/5frt5jgr3jOpW0SmmA9pFgf8juPSKUZjPpp70kk/abQeAKZnZ7s7q9zpg7JcqYSkOew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4818
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9965 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104260019
X-Proofpoint-ORIG-GUID: GdRkuT5Y5mpsMdquV4bExAkQymW0B5GV
X-Proofpoint-GUID: GdRkuT5Y5mpsMdquV4bExAkQymW0B5GV
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9965 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104260019
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 25/04/2021 16:35, Su Yue wrote:
> Commit b2598edf8b36 ("btrfs: remove unused argument seed from
> btrfs_find_device") removed the argument seed from btrfs_find_device
> but forgot the comment, so remove it.
> 
  My bad. Thanks for the fix.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


> Signed-off-by: Su Yue <l@damenly.su>
> ---
>   fs/btrfs/volumes.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 77cdb75acc15..9ee17b2ff621 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6669,8 +6669,6 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
>    *
>    * If devid and uuid are both specified, the match must be exact, otherwise
>    * only devid is used.
> - *
> - * If @seed is true, traverse through the seed devices.
>    */
>   struct btrfs_device *btrfs_find_device(struct btrfs_fs_devices *fs_devices,
>   				       u64 devid, u8 *uuid, u8 *fsid)
> 

