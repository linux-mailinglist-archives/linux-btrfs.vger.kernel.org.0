Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE89F33B203
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Mar 2021 13:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhCOMDo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Mar 2021 08:03:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39852 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhCOMD2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Mar 2021 08:03:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12FC0h3L122643;
        Mon, 15 Mar 2021 12:03:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=hDeYMswEDdDvYPTwxhc/Tq0NklvvctnhBGldcaSX5m0=;
 b=nuvQNSYPuZ7zyVTZzrF1u3Q/GKZ2P0mutKUksGnbE1m2/tR12ngt3yVvIiTMy0w9PU6O
 /3n8EbPq43NPHyvUx9NOwCYaY0clmJjKM4PpQ1VYHbM9eCi+aftygDtdHosjTj1n3rgX
 3Sb2nhBNVgKxuRj0LZds6MBujHPwEDx9dhU6h5CfHLJfWuKkuOjXQXga4psUucrL5+ri
 4BWrkzD7yaMjS0xgn8mKUkEfI5oHelbIlct82380fMIJfqOnVLt3ny6oj2dOOyvo6wcK
 UrmS8Q9JXaYs9zJOuFf2jxnKTxU4D29tkq5W8T+ssALPu82yYhu2Po3ltHSWdeZfEgJO BA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37a4ekggpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 12:03:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12FC1cpo100115;
        Mon, 15 Mar 2021 12:03:23 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by aserp3020.oracle.com with ESMTP id 37979yrv56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 12:03:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEJN9x04+imCmmuq25Zd/ufGGcb2ua5sESU588U3rvXOuSLepj3Q0TICkyGZOkPGWBN51R7EqU6Z5kjCqHT3eldK0P7dG8hJHff/rpTdTEvadWzeYupQy05UOkbE4ss8ussey6v5ee0HFrjV6B/OjorBwWCkCQ8MlhbkDwkaPByEKFd9TNHmtVN7YZ+q0cQ7uvOlTKL96YtJppLjNPOx5Gm31ugFz6dVOSIGdajnDgMpsfbWZbZB/UnbgbSROAKuGx+qVYW+kZBhdo2tUlvypYvh2rhjAxXo513v2Jh1aVTniUB4UjgzNPPk1Mn+YAwjoo/7daX5ixjlfpQ/IX7pcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDeYMswEDdDvYPTwxhc/Tq0NklvvctnhBGldcaSX5m0=;
 b=WRSidNjr8LdZSbt2y7Hr0h5tVpQR3EbZljVRwmL/U0N2Hy0vXz3Tg0OwiQHxjc4HRIxO52favYwiJ3XSjh+6k9FO9vNtqkc+PMf7pmIMAXfa9GD8+RbChdgW1EazQ2vDbDKQA5noYzIgjv+yYvlXKHhVCR4veVxl7/HOS6SjHRf9AEEof21bLcfl1fcsQNKlhO3r9qt6VJhlaXcIrEgJTisej+YYTlhZeXIMy7dvcnFglqOTU4ij3WTi+jehUoUhHlmifRswEfpxde6WGGgmwxlYNXRcp5z6agKe8xw2V/3hHCrGdJo0ZqJIxNmkU8zd9rsEDf3vMC3afFoGo+fELg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDeYMswEDdDvYPTwxhc/Tq0NklvvctnhBGldcaSX5m0=;
 b=VL6zypi4tg4k/jJAi1HPk9EaDaYCa9y/t55m6bHBzwYDNNxQuCIZQMYcy0+avcyov6V7BlfRo5a7YbLMuieZsXrNhK7Z1uxZvrxSmGw88mHljpPQR+raFvvDADrKi/Jxmbv7T0K8WkBZWjDIsBytBoexi7eCx5ZHB+m/2nP7V6Y=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5314.namprd10.prod.outlook.com (2603:10b6:208:325::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 12:03:21 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125%8]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 12:03:21 +0000
Subject: Re: [PATCH v2 02/15] btrfs: use min() to replace open-code in
 btrfs_invalidatepage()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210310090833.105015-1-wqu@suse.com>
 <20210310090833.105015-3-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <8df46a0e-88e1-79fe-cb0c-00a5aa3271a7@oracle.com>
Date:   Mon, 15 Mar 2021 20:03:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210310090833.105015-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:a177:93a9:ccfb:d353]
X-ClientProxiedBy: SG2PR06CA0246.apcprd06.prod.outlook.com
 (2603:1096:4:ac::30) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:a177:93a9:ccfb:d353] (2406:3003:2006:2288:a177:93a9:ccfb:d353) by SG2PR06CA0246.apcprd06.prod.outlook.com (2603:1096:4:ac::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Mon, 15 Mar 2021 12:03:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2801ce65-4118-4054-1cd1-08d8e7aa53d8
X-MS-TrafficTypeDiagnostic: BLAPR10MB5314:
X-Microsoft-Antispam-PRVS: <BLAPR10MB53143C0F136B7BA8A8BF2329E56C9@BLAPR10MB5314.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wsP68ZQ0v85M9WQUqxIdQIcqA8XW6QFoAGYX/cXF4CQfFj1VUl3S9JiRpd6WF5iSfqEyGkxD4lUhrCx7o5Y4rlYb/fuE02g5/RHKJsI32pMBNG0VCgtylU1WKB7ySuBzgdmWWSPLZpeHPFHKBEs5/7tV/snIIDfGS6hlGOh2qSqtlpb57dLhk70/6pQxCMnssQvxiFujEwsN4ggqHyJt3s5lWk8tkH5aCz88XqA93X0YUsX3oWj4t640jI0owcD9w4KZt5YgdWNcXikJMsV5J4C1tPAJTdrF96fRLi4llModxbkk3tpppn11V+G69/UA7+JDnZ5C8QC4Qp3bzPoJo+mKbE8+WCkGAx+QFNpqPca5Aj9/5ygMAMsPyHC5qbmh3xeyRbN7KOOmQx6VW7koyJ0vMwIrxaMn9zZa0LPIZNlFdSLksHlksL2sSSCrtSWgKBirVOCLCRgIpBAEdpTagAUgzWwwiDisY+bmKx8Of3Ymx59k4jWilNxUOLOYtaZU3N7qVHxodNKsQ9CNGMc1VpIeGaRh+Ak1LAkkMzILUl4s+YFU/qOJwpGD8Jbw3gHD0XBuwvUGcQKlYr/LIyoCvrHs/h558Hs0h9HgSsr1EHAMym2jGlBG/zUs+1UlgJu2smftlbjeNh3bYG3AdReJLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(366004)(376002)(396003)(5660300002)(316002)(8676002)(83380400001)(44832011)(31686004)(86362001)(36756003)(2906002)(66946007)(6666004)(2616005)(186003)(53546011)(31696002)(66556008)(478600001)(8936002)(6486002)(66476007)(16526019)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZVNnZVNoS0VpK3R1a3FwWXFJRDlnM1F0ZFdIM25QSG5RSk5oTGRkYzZBNzRX?=
 =?utf-8?B?NHhpWWpTbEplSTIwbnk3S2JxOUNyK1FNQWZpQWFjRjZpQTN0dlU3ZzFJbVI2?=
 =?utf-8?B?cjhMUFhFU05KTlNKK1hza0hEZlVmakVWWnZWU0MrOTdZbVNzYTJINzY1aVZp?=
 =?utf-8?B?OUdoOFprNUpNYy9LbklrUjBPamFRV2Z3dEx6YU1Ma1VQc3VabkpuQmpOdSsy?=
 =?utf-8?B?TWNzUWpEbFladUNaTTJXK1dyYmtNWVcyYXMyVTM3cDBFUW5UcUZRZUNyZkpn?=
 =?utf-8?B?UXFPVHlpeDZ5UlFZcm5xYTMzbFpocmVOZnJJU3hURGZJbUVpSm9QbHBJVk1B?=
 =?utf-8?B?WCtmU3lJTGFaZjQ3ZkRmQlFKU2g5Z2NLa0l3dk9vVi9ISkp4bE5CN3BhRmFZ?=
 =?utf-8?B?R0pTTUxvL2VrSHZyUFhWdmN1UWx4MWxpUzV3dWc5ZnNvMlVJaktFL1cvUy9u?=
 =?utf-8?B?VmpSTVVXSDVZUzZ6YVdUL0psL2Rma0VUQVNHaDluVldKZlZTYjVVLzROblJK?=
 =?utf-8?B?K0RjWmJ6TFJzS0owWk9xNDk1ZzB5MXFxN3hwM1NXdHllS2lDcnByY092UjN4?=
 =?utf-8?B?NGJlOWdJajZuY2M5eWRnNExxS0FMTnFJWlJkREtSSXU5blB3K09lNldhWnZy?=
 =?utf-8?B?MjAvQk9IbWpoR1VLKzUrNkp1UE85SVBNSlBFQ2JKZHFzSG1Lb05xUC8rUWdL?=
 =?utf-8?B?clNQaEZyY2JOaUF3c1RXWFBKTjlCR0l4eTUzT3lDc1BKS3pXRmpxbks5blVa?=
 =?utf-8?B?QVozTDZjK0IybDVOVHFmQVp4UlM0TWlxYUsyeGZwcVh4MHVHOSt5Mkh0Wkx3?=
 =?utf-8?B?d0tZVTdzTkFUcGJ1RG1CTlVOeVc1RmdVeWJueFIwZHhuZWZuTXdvb0tySXFB?=
 =?utf-8?B?L2U0Y2F0dHdNY29MdUkyRlJQcU00bVkrZ3p5ZHcyQkNRTmdCUFZIU3FhNzdy?=
 =?utf-8?B?RUR2RzUzb2MrMkdHMGxnNmpMdU9ma20vMmoxM04rZUNJb29KNlFPY1J6UXIv?=
 =?utf-8?B?bzFCQVZCanRycW1lWDVTb1h2SnBuanc2RVpvR0g1ZVNCTXA1NkhQclJ6K2Nz?=
 =?utf-8?B?K0ZCdU03aTBubnFrWDZUcDZuR2NGNTlkc1JKMmRmUUk0bkNRZm9na0trTmN2?=
 =?utf-8?B?T1BYVDQ4alZKV0QzR3VObTMrd0dVZW9Db2lJSzN5cXpFNW42ZmVmMXFRbWt4?=
 =?utf-8?B?dThjanpGUWNCaHVjOVZhcnVFRGtaQVdnOWtnZVlhQmE2a1RlQUxQaUIrbURz?=
 =?utf-8?B?SnVVcWxxSE4vL0NqYmNHZUVIQVhpMXhicjVkODdRby85YkVhTlNtbjdjU3RU?=
 =?utf-8?B?cU8xUDU0ZVk5TmRzS1VCaFI4ZzdHNHJsTjF3UDNJd3JrRW0xcGIrMWs5UE4r?=
 =?utf-8?B?cHFGcmtWLy9xZFVQemtTY2kyVjFvZnZlN3h4Tk1nMDU4UC9KWHJpNlhKRWxM?=
 =?utf-8?B?L0VpcVZSZEJnNmJRbXNoYk9BSFh4ZFNINmw5WG5HK3I0SDNxMk1HdXd5TVpq?=
 =?utf-8?B?WjVIRFBzY2pxcmZZb0I5YzlmaFNWL21NV1RmbHpUUU1aMnIxM29SRDlrZDRH?=
 =?utf-8?B?MVJudkNyajg1bms0aHppZTRzRGFLQXgyd2xpVUlyRG1IV0xncVdYNklqZWtl?=
 =?utf-8?B?eEEwYnZWZG05NFNFbExxZ0Q1YW9LNjBtRTZDZmplL0xOUEdKS2xNNGh3TG83?=
 =?utf-8?B?K210M0ZnTVh6K0hhemFnaU1oRVVWNDFiRmtrandWanVOWVVrbnE4clgramRP?=
 =?utf-8?B?cjhDcUpDL2RESFFTOTNoQk15Yi9YL0wrcEo1cFdZbEwwZFFOTTFyb3grMkU5?=
 =?utf-8?B?RzFRSjVWSjBWTTRTZGI4ckNkQVRyd2ZOZDRqZHhlbnplQXExSmc1WEV0ZkhW?=
 =?utf-8?Q?QGAs5WYdSdLyv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2801ce65-4118-4054-1cd1-08d8e7aa53d8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 12:03:21.5021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aEkCvZKm34s33B8a+XQGXGjNOaxa4A6+xU/J43JBdRtQnIEu9F2ZC/4VQLhXvINIE4YjdA6brE8TKSYABDXTrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5314
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9923 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103150085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9923 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103150085
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/03/2021 17:08, Qu Wenruo wrote:
> In btrfs_invalidatepage() we introduce a temporary variable, new_len, to
> update ordered->truncated_len.
> 
> But we can use min() to replace it completely and no need for the
> variable.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---

   Reviewed-by: Anand Jain <anand.jain@oracle.com>
-Anand

>   fs/btrfs/inode.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 52dc5f52ea58..2973cec05505 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8405,15 +8405,13 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
>   		 */
>   		if (TestClearPagePrivate2(page)) {
>   			struct btrfs_ordered_inode_tree *tree;
> -			u64 new_len;
>   
>   			tree = &inode->ordered_tree;
>   
>   			spin_lock_irq(&tree->lock);
>   			set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
> -			new_len = start - ordered->file_offset;
> -			if (new_len < ordered->truncated_len)
> -				ordered->truncated_len = new_len;
> +			ordered->truncated_len = min(ordered->truncated_len,
> +					start - ordered->file_offset);
>   			spin_unlock_irq(&tree->lock);
>   
>   			if (btrfs_dec_test_ordered_pending(inode, &ordered,
> 

