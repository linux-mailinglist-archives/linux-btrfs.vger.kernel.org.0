Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD63352503
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Apr 2021 03:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbhDBBQH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Apr 2021 21:16:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36290 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhDBBQG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Apr 2021 21:16:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13219xR3174301;
        Fri, 2 Apr 2021 01:16:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=jTrWhhd4smOJYHpiKVzBzZqgh5GVphP3qaKcnre/w4I=;
 b=mutvuX+uBnWI2+5RPgqpfPKGGq9NgD/xKoKW7NQ7vXTBJ3GwfNPFWz9oJ3lIGXUDiL3A
 7gKzGFS9sQvkmhBnSAAccB6WqUxdYLSkGCwZzaIVSzDPVK3ncstEYSlG19VBGCYe0WqZ
 Atsf/ssULyO4Ue6k+B6mXtT/JbWvm4kXyLFrVHd+kfdJFOKP086hbHqrFnkpQbIos74S
 xCyXcvfxhe3tJFxgOh4rGSwp6ke87balggoMAPXJ1xJrvUCWuEnLZVk8V6Pb+4ivYgpN
 QKbFspHHCyARQDheqtoApV/1DvZ1fYp5f2k5OisqYkt6u7bDKH0E/rwrPi6yE3iKNUIt yQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37n30sbfju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 01:16:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13219cuN083832;
        Fri, 2 Apr 2021 01:16:02 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by userp3030.oracle.com with ESMTP id 37n2athc3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 01:16:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhcgTVPpdiqYCvYnVgwOFlZBlBM7BY9MWDqwK9KSZvjMqAAMfgdInl6xjtUyPQR0QDBIPoFSG6SFyNCK1IlQclI+uS9ckTPiHO3BYdDRcj4w27T4xVsP2NdoWyAF4gE3y8zNnHv/njEBw3tfShCrXz8AEfD+vGS7k01rmcm4JEHYZejp8EioC63DNPOb9B4/r3FfRoLLUMnPG5dY3zZS9+kHaIlc1kyueNigxfCiL1b92NcfWNC3Lhsfb0ppbV6mOw/64bvBOY/HEfGTk9/dCGcLObA36APU/1qMt+9ZHu6rf7AssE4lkDPlHFWgJ22YyhKyYPbe5DwhwURtLRhFZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTrWhhd4smOJYHpiKVzBzZqgh5GVphP3qaKcnre/w4I=;
 b=gyqaxrV3b/+YKaU88tbhGQ/hb9FQ3rOuEZ96442//ifCeLkBqZ0na7Ynpx1vGV6coFlkYWDuJhufJVjGkA4wg7H4ReCy7AXhu9B9sQm1w6qVpwW9cF7SZhd3kDCClU4XoyhZjazwWI+i5UtRTEFdiyi/7wNGpVjiC9ZAo0gqO2TT36sgCeseutVPVweu8BrJbdK9zACk4YlkfKCRZ/d2CTL5NfWPLiDTNoBu67j7lhNNKxLuouLgJBqN5nBMay1p5g0/13KBrioq3CodTkqjqFtQmbbJflOidomh64w+qBFHZ/yrZrW5MlegGln/HInZuKDqkVIfVIE9r6JjklXswQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTrWhhd4smOJYHpiKVzBzZqgh5GVphP3qaKcnre/w4I=;
 b=MI5sg/POAd+KgoZWIhssEhP738X88znuQDcA/oeBy7gQMOaRDvB/6+1/ZbHAL+kPRLgWELdOsikO646tofdpjw5LL2CkaZ8symBjEv1hK4srMIv/6IETapPV8XaScpFzDL24zvpZovrZU30m3qU6U3eTv4OeDSOLVgbQYl49ojo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4366.namprd10.prod.outlook.com (2603:10b6:208:1dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Fri, 2 Apr
 2021 01:16:00 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::9aa:6ac:8d40:c076]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::9aa:6ac:8d40:c076%6]) with mapi id 15.20.3977.033; Fri, 2 Apr 2021
 01:16:00 +0000
Subject: Re: [PATCH v3 04/13] btrfs: refactor how we iterate ordered extent in
 btrfs_invalidatepage()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210325071445.90896-1-wqu@suse.com>
 <20210325071445.90896-5-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <09d9c11c-02ff-8109-5244-021fac5c3626@oracle.com>
Date:   Fri, 2 Apr 2021 09:15:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <20210325071445.90896-5-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:d47a:f48:c77a:6201]
X-ClientProxiedBy: SG2PR01CA0151.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::31) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:d47a:f48:c77a:6201] (2406:3003:2006:2288:d47a:f48:c77a:6201) by SG2PR01CA0151.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend Transport; Fri, 2 Apr 2021 01:15:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5dec549-4e62-4602-c60f-08d8f574dff7
X-MS-TrafficTypeDiagnostic: MN2PR10MB4366:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4366D75220006A885A60587EE57A9@MN2PR10MB4366.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o1lc/mDa6+0hAkGjnMoLg3x29GiePBy1/t9VVeFGAhxUvceSpfmTBejorntnN/goA4zqUuG7m+yaKneQSJw/7SNT4nA+rEt4rgaCucOL30ahmGmNtv/58K6ZldMKq/Nz2dmi/PRyiWRWbi97K8mVKCVRw+fDrSdhTa/6mRJ4MwLvJb7x1BxhNxqRWbEnrvnVgOnim9fVhaHzhSIleu9CB1Q61MeqkagAZKJWV/4f/C31Hy98cr7+SXwfoz6Z9gprQEAwkF4NNXogOtQz010mPVG6v1Tc2IjFjGjHLMNrEDlQv/kFOv27M112j2/OOMKw0lGoD+kMnWRtE4Nr2YTK8J746KIKPDVYMgHeXWcczqxVKb///RCf4jyCS1II8Wq7sLjBIgmApJM0rEMWzgrNYV1CqguxKfpxUOtrXUBN2WQIE3R3yFEAHsjktju3u9UpZotlJAa87lm+19Ab0tWctgsih2/qQM2l8nL3k8vf07zRZc0/qhy52BSdg1YUJbySOs5cdgXoXwj9aXBOtSaBOSsgv1i44NjzhKpmR4jRSVD6f+4zh1ARHH4KeksskLK9GCNWeFrVCwc0XKxIIkvdDegZFnADI9/KFv8zwS8HaYiPuS4PtKxHjOp1D0oWi/cP20PvWAmaj5H1u2n6GmOufe/tP8d3JDE3eiWH/2dMFOHX4jfWY4e7/PzOnn3QURvn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(136003)(366004)(346002)(396003)(36756003)(53546011)(316002)(478600001)(66476007)(66946007)(6666004)(2906002)(5660300002)(38100700001)(31696002)(8676002)(8936002)(86362001)(44832011)(66556008)(186003)(6486002)(16526019)(2616005)(83380400001)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WUMzTzBzdmRNczB6VFRDVEw4RXBDMi9wbENPUVBQSFFHdzlwVS8xcnBKK0o3?=
 =?utf-8?B?YkZ5UXoyOGJPdHhzZVRzUlBrRDhwejFsL1NkL09rcWw0ZWdQVTFjZFJnc3VX?=
 =?utf-8?B?U1FYYTgxUEhCQ3ZZN0dtNDVMY0JCQXlxMFIya05JVVNRMlpSazNSRDcrZnJ4?=
 =?utf-8?B?bGtabnZkaE0rWDNKbytSMkQrSUlyYVZJUW1wTE1MTDM5Uy82bWwrK2pNdjNZ?=
 =?utf-8?B?NmxqaWtGdnoydWxvUVZGcy8rMDNPSVlML0ZPdXRNT2tGV0Z6UTgxMnRnTjJE?=
 =?utf-8?B?ajdqZURySHNwM1diT0N0SUprcmJ0aVdkVFFKV01acklYYmtqT29qa3JTQjNa?=
 =?utf-8?B?WlZHaXZWNG9OdEVqTlhrb29YamxoLzc0cWdVWWlzekxzZENzRXNycDdlb0dt?=
 =?utf-8?B?RWE2RGZZVTNQV3NJdXUySExpLzZpK2taamtxN0o0Rk52RlErTjAyZGFNdmNP?=
 =?utf-8?B?Q0lFelpwUGR4TytLbHpjRFdoa2NIeGplS0Y2S1A4RkppMGRNcHNqWGNLNkZj?=
 =?utf-8?B?MjB5eGhLNWtGcXM2c01YOW1FOVdMMkpBd2t6dXhHcXduZnV0cXhObjJYR29j?=
 =?utf-8?B?MUExM3RUaTJZMG12cFVIWkZFTkhRSVhmRlFXcHJWb2QwTlpYT284Vkpsc1RL?=
 =?utf-8?B?WDNwbUtFOHVMRFdielU2aDl6Sk5ISTdFdFZ0a2t6WnQzcWtuZDQwekoreTly?=
 =?utf-8?B?allmVjg5THpCenlwN3N2UVJGYm9GT25HSUlNdFp0NHZaWGRPYnhTY2RVWm1P?=
 =?utf-8?B?Y1dGclVkbDc0SDA2NWpQU3BFaEprZDVDRC9oQVVZNVROOUtrR1M4TjFydnow?=
 =?utf-8?B?UmlZenYvbVRlbFVmMHNXL0R3aCt3U1FkTjZHWXZWdnFHZGNKdDhjaEVKVm5a?=
 =?utf-8?B?bHFlVGdJdVJkMFcwYXh5UWo3RzdsNEdvQzhmVm9PRTA5RjBnT0xOQ2Rkb29W?=
 =?utf-8?B?bW8weHROUTZZQUVBUk9ra1lhZ3FKQzg2MlNuVS9XT2JBSmczT01lVTJyaU9G?=
 =?utf-8?B?aklISktmMkdYUWgrcncxWnRPcldjMDA1NDNMSXkvVytBQ1hMQlhiNnlZTzBW?=
 =?utf-8?B?c2tWdW9hR2tad1IxZm0wN28rZ0RrdkFqeG4waGFnSVZ3RStvNVRSbVhrb0RX?=
 =?utf-8?B?U2FzVHFuUE1JdTNXZ0p1dmJGMFpVZmlqVGNXeGtRWjZJd2g2YXFPeEVYR2t3?=
 =?utf-8?B?OVRsVS94cVZvbEdQR2FSQ1hCZjhnRUtkOFpENGh0Rzc2UVNQOXBDQkw4a2ZD?=
 =?utf-8?B?cmh1WXRpMDBjVmFZSGcvNklDZmpzSW5ESkZLNWNFTm13QWVFUFlhNUhYWEJ5?=
 =?utf-8?B?cDQ2TXlWbkdsa3hWOEdSNURVcG54amVGOVR4MTBQUVRrTEJZaDFyTmlwV0dv?=
 =?utf-8?B?Sk1zK253VUFLSXFwWXJIaUFZalVrc3l0dTFDdTk1d1R6YWs1UWFWbVNJMHli?=
 =?utf-8?B?N2Uya1BSOWRKYW5kWXpmRXRNV1RiZUJjcS9rK0VpdERZR0NvNTI2eHVSQita?=
 =?utf-8?B?azVxTWtVNDNXbjZibkFmM3g0TWttaDdZSVErNkQ3WG9USVpKVStDV2RiNjFF?=
 =?utf-8?B?SmlYNzRYT25NL1E1NCsxN2YwMFJ1UFpublFkMHVzMlFhVjhXUkVMQ2Y3bmF3?=
 =?utf-8?B?Z3RVQzQ3bktib0ZDSUorTHVCWXlacW5zRHdLeG54WmFiM01MeEZ2R1pTWDJC?=
 =?utf-8?B?cmhaMVZKKzgxd0U1TDFpK0xzUDhUVis5OU9Lc3UxbFYyeEo0djZqVGxDbXZF?=
 =?utf-8?B?TFBGRHVoZzhtblV5Qko2cVYrTDdZVURLL0F3c1FzbFRENkxxUGtRbUJBekJh?=
 =?utf-8?B?RlN2T3dSVGhXcnJ5UWNvVUt4NEZ4dS9Ld21qN2VDR0NSMXpkOXErRUkxbUNT?=
 =?utf-8?Q?9VMauhRbYSRJC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5dec549-4e62-4602-c60f-08d8f574dff7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 01:15:59.9635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJfFFS4t43oqkFYlnSpOj5AqZBpIm9UqSzQ2jPrQ1475c5O6VXACoVKYpU/P+TcYKFwdhSZcYUvp+a8xosq4JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4366
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020005
X-Proofpoint-GUID: CF-MzpRRbcgxivfC4OToeaJVgvbGU-Om
X-Proofpoint-ORIG-GUID: CF-MzpRRbcgxivfC4OToeaJVgvbGU-Om
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020005
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 25/03/2021 15:14, Qu Wenruo wrote:
> In btrfs_invalidatepage(), we need to iterate through all ordered
> extents and finish them.
> 
> This involved a loop to exhaust all ordered extents, but that loop is
> implemented using again: label and goto.
> 
> Refactor the code by:
> - Use a while() loop

Just an observation.
At a minimum, while loop does 2 iterations before breaking. Whereas
label and goto could do it without reaching goto at all for the same
value of %length. So the label and goto approach is still faster.

A question below.

> - Extract the code to finish/dec an ordered extent into its own function
>    The new function, invalidate_ordered_extent(), will handle the
>    extent locking, extent bit update, and to finish/dec ordered extent.
> 
> In fact, for regular sectorsize == PAGE_SIZE case, there can only be at
> most one ordered extent for one page, thus the code is from ancient
> subpage preparation patchset.
> 
> But there is a bug hidden inside the ordered extent finish/dec part.
> 
> This patch will remove the ability to handle multiple ordered extent,
> and add extra ASSERT() to make sure for regular sectorsize we won't have
> anything wrong.
> 
> For the proper subpage support, it will be added in later patches.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/inode.c | 122 +++++++++++++++++++++++++++++------------------
>   1 file changed, 75 insertions(+), 47 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index d777f67d366b..99dcadd31870 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8355,17 +8355,72 @@ static int btrfs_migratepage(struct address_space *mapping,
>   }
>   #endif
>   
> +/*
> + * Helper to finish/dec one ordered extent for btrfs_invalidatepage().
> + *
> + * Return true if the ordered extent is finished.
> + * Return false otherwise
> + */
> +static bool invalidate_ordered_extent(struct btrfs_inode *inode,
> +				      struct btrfs_ordered_extent *ordered,
> +				      struct page *page,
> +				      struct extent_state **cached_state,
> +				      bool inode_evicting)
> +{
> +	u64 start = page_offset(page);
> +	u64 end = page_offset(page) + PAGE_SIZE - 1;
> +	u32 len = PAGE_SIZE;
> +	bool completed_ordered = false;
> +
> +	/*
> +	 * For regular sectorsize == PAGE_SIZE, if the ordered extent covers
> +	 * the page, then it must cover the full page.
> +	 */
> +	ASSERT(ordered->file_offset <= start &&
> +	       ordered->file_offset + ordered->num_bytes > end);
> +	/*
> +	 * IO on this page will never be started, so we need to account
> +	 * for any ordered extents now. Don't clear EXTENT_DELALLOC_NEW
> +	 * here, must leave that up for the ordered extent completion.
> +	 */
> +	if (!inode_evicting)
> +		clear_extent_bit(&inode->io_tree, start, end,
> +				 EXTENT_DELALLOC | EXTENT_LOCKED |
> +				 EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG, 1, 0,
> +				 cached_state);
> +	/*
> +	 * Whoever cleared the private bit is responsible for the
> +	 * finish_ordered_io
> +	 */
> +	if (TestClearPagePrivate2(page)) {
> +		spin_lock_irq(&inode->ordered_tree.lock);
> +		set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
> +		ordered->truncated_len = min(ordered->truncated_len,
> +					     start - ordered->file_offset);
> +		spin_unlock_irq(&inode->ordered_tree.lock);
> +
> +		if (btrfs_dec_test_ordered_pending(inode, &ordered, start, len, 1)) {
> +			btrfs_finish_ordered_io(ordered);
> +			completed_ordered = true;
> +		}
> +	}
> +	btrfs_put_ordered_extent(ordered);
> +	if (!inode_evicting) {
> +		*cached_state = NULL;
> +		lock_extent_bits(&inode->io_tree, start, end, cached_state);
> +	}
> +	return completed_ordered;
> +}
> +
>   static void btrfs_invalidatepage(struct page *page, unsigned int offset,
>   				 unsigned int length)
>   {
>   	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
>   	struct extent_io_tree *tree = &inode->io_tree;
> -	struct btrfs_ordered_extent *ordered;
>   	struct extent_state *cached_state = NULL;
>   	u64 page_start = page_offset(page);
>   	u64 page_end = page_start + PAGE_SIZE - 1;
> -	u64 start;
> -	u64 end;
> +	u64 cur;
>   	int inode_evicting = inode->vfs_inode.i_state & I_FREEING;
>   	bool found_ordered = false;
>   	bool completed_ordered = false;
> @@ -8387,51 +8442,24 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
>   	if (!inode_evicting)
>   		lock_extent_bits(tree, page_start, page_end, &cached_state);
>   
> -	start = page_start;
> -again:
> -	ordered = btrfs_lookup_ordered_range(inode, start, page_end - start + 1);
> -	if (ordered) {
> -		found_ordered = true;
> -		end = min(page_end,
> -			  ordered->file_offset + ordered->num_bytes - 1);
> -		/*
> -		 * IO on this page will never be started, so we need to account
> -		 * for any ordered extents now. Don't clear EXTENT_DELALLOC_NEW
> -		 * here, must leave that up for the ordered extent completion.
> -		 */
> -		if (!inode_evicting)
> -			clear_extent_bit(tree, start, end,
> -					 EXTENT_DELALLOC |
> -					 EXTENT_LOCKED | EXTENT_DO_ACCOUNTING |
> -					 EXTENT_DEFRAG, 1, 0, &cached_state);
> -		/*
> -		 * whoever cleared the private bit is responsible
> -		 * for the finish_ordered_io
> -		 */
> -		if (TestClearPagePrivate2(page)) {
> -			spin_lock_irq(&inode->ordered_tree.lock);
> -			set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
> -			ordered->truncated_len = min(ordered->truncated_len,
> -					start - ordered->file_offset);
> -			spin_unlock_irq(&inode->ordered_tree.lock);
> -
> -			if (btrfs_dec_test_ordered_pending(inode, &ordered,
> -							   start,
> -							   end - start + 1, 1)) {
> -				btrfs_finish_ordered_io(ordered);
> -				completed_ordered = true;
> -			}
> -		}
> -		btrfs_put_ordered_extent(ordered);
> -		if (!inode_evicting) {
> -			cached_state = NULL;
> -			lock_extent_bits(tree, start, end,
> -					 &cached_state);
> -		}
> +	cur = page_start;
> +	/* Iterate through all the ordered extents covering the page */
> +	while (cur < page_end) {
> +		struct btrfs_ordered_extent *ordered;
>   
> -		start = end + 1;
> -		if (start < page_end)
> -			goto again;

> +		ordered = btrfs_lookup_ordered_range(inode, cur,
> +				page_end - cur + 1);


  This part is confusing to me. I hope you can clarify.
  btrfs_lookup_ordered_range() also does

                node = tree_search(tree, file_offset + len);

  Essentially the 2nd argument ends up being %page_end + 1 here.

  So wouldn't that end up calling invalidate_ordered_extent()
  beyond %offset + %length?

Thanks, Anand


> +		if (ordered) {
> +			cur = ordered->file_offset + ordered->num_bytes;
> +
> +			found_ordered = true;
> +			completed_ordered = invalidate_ordered_extent(inode,
> +					ordered, page, &cached_state,
> +					inode_evicting);
> +		} else {
> +			/* Exhausted all ordered extents */
> +			break;
> +		}
>   	}
>   
>   	/*
> 

