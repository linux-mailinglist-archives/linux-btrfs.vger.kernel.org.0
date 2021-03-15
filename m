Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498A533B21B
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Mar 2021 13:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhCOMG4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Mar 2021 08:06:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42110 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbhCOMGd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Mar 2021 08:06:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12FC5Rqu126491;
        Mon, 15 Mar 2021 12:06:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=1RgoGmJRzaJksC2HHoc7T+v0ocxycXV9Xy0IqsHIg4A=;
 b=jDLgHiGNRPKtPOY7BVufc4jAqd/DHoJM1sHn8O49v8NjjdNaVJrzjm1c5NT7G7N7MH2X
 jW1wcLCtPgDYv56GwoEIPkXyyvabOAVAYkAxPmOxlmWPtc/oWC6156ry8CZhRRhOyjAf
 roM8060MKCTfklY1bD4KYJHA4x2p33rRX82+oswMsHE+eMqJEfUhC8gkNI6P0Fj1hg8P
 zp49Kvc3+97OduKo82gLL68doyxEqsnRQl27KdMersR8Is0s7E/WcSWe7jsv3bCusGiL
 ucRYgzcnTwLRwSPwaC7YM+uhLAlR45qaqT/wVpyTToB0arYMsm7F+z5zXEYbizlOnV1q 2Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37a4ekggws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 12:06:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12FC5j57013257;
        Mon, 15 Mar 2021 12:06:29 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2175.outbound.protection.outlook.com [104.47.73.175])
        by userp3030.oracle.com with ESMTP id 3797axjxse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 12:06:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffZrN75f71vIzZwWDhUDEohryCQ+ZhfVJXcmJGzPy7ys+3Fb3lN9+OXJEGjxfWQtqlQmbdztVMgvQJaewdyRymgJRQMgV8WP03dC9aI2E6p2GXjO9Whn1h4v5S5abaD2JFc19B4o17neS9X/LZtfwzpIYbsN3A75kM76ncTWPFyeABqEFBlbcUWH1+eHACGsdLNwSkLmdNS6eGtmhZlc/YL/p7Ou+Iv4vEa2nUbPaAtUwgtej1gVVQ33SV2Kv5bHJf4hdPbbwByjz5wYHzBaiGz6CNf6pXL7xagoCkuflJzQiRBWMZO2KZNXohlC9xAUQYsZOV0anGvvaSdKfcz1aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RgoGmJRzaJksC2HHoc7T+v0ocxycXV9Xy0IqsHIg4A=;
 b=LaX9RVme2dg4MZuFvURtl3vUxVBttQ+qja3aqYb/9SJ9XcCr6206FMmQk4bnxqOsP/3EUmTSkkoOj7j2XMKChxe8v/OLUIJPaPUWiJkaDBTk/Wxy9caBBGei1kDGotoNTa0GuW+YHvhxAO2wHDMqTqOOUctxkyLofWMMhfyg3cOKwX0LmRWT5mK6MZ4hP0jIY8pMtmshZNc1C0UFFlf4sAhC1ZoZom7FeoPZbbusJJnPRSbxRCjS22VDY9j2M/2Z1YLBbt8pnZ0E1YlNoRQiN/gitZWa2/TZ0STdhd6tipj2wkujVbmD0J27ITCKUZiVg09qs1IKq6KFEBBTfETp7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RgoGmJRzaJksC2HHoc7T+v0ocxycXV9Xy0IqsHIg4A=;
 b=YaBDxXDOfRCqKNpXXaZ/LM9gm3lbSqPwHYVzAFEQ7Ya7aDMudTWLAz+2xSuwduoRjIsUs2u84eTRa6wbXQy+fLQsV2oajsdfR6Hit4K46UpBxq7U4+8P9XYNNT0/p1TbP+gUyLuzexMkVqi1sJAMbExzZ8WsJ+/v+HqxF22ohO0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4980.namprd10.prod.outlook.com (2603:10b6:208:334::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 12:06:27 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125%8]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 12:06:27 +0000
Subject: Re: [PATCH v2 03/15] btrfs: remove unnecessary variable shadowing in
 btrfs_invalidatepage()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210310090833.105015-1-wqu@suse.com>
 <20210310090833.105015-4-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <23c44b61-1609-b9ec-cfbe-b47febe988b8@oracle.com>
Date:   Mon, 15 Mar 2021 20:06:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210310090833.105015-4-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:a177:93a9:ccfb:d353]
X-ClientProxiedBy: SG2P153CA0009.APCP153.PROD.OUTLOOK.COM (2603:1096::19) To
 MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:a177:93a9:ccfb:d353] (2406:3003:2006:2288:a177:93a9:ccfb:d353) by SG2P153CA0009.APCP153.PROD.OUTLOOK.COM (2603:1096::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.2 via Frontend Transport; Mon, 15 Mar 2021 12:06:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a31530b-cf62-4fbd-ac23-08d8e7aac2be
X-MS-TrafficTypeDiagnostic: BLAPR10MB4980:
X-Microsoft-Antispam-PRVS: <BLAPR10MB4980E5D3615154FF87F2BEDDE56C9@BLAPR10MB4980.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M78XM3eg848Q66tIiTlJAV3KaaEzie5ZQ5ukRQQZnxGTvpQPndcFc+UqycullLTsBjoLUhSruOCSCfk7Q7JNkulxBxl+4NqeliEaoxwoGSNKnKBT4GMAKoQZkrk920Edu2NQsWHU7jDWatY8C56OC9VwVGav9DNShJ0LckQjcMJUfR8O4t7Kc6bCVcZ54FKR/MtUXmHnZCJdl1gpv0FYsuKRYMbdhu2yqyp/YeFNEmLRQ+BHqBKARIqwJhPmwql/KQPYE4GsmOJNyle42mexmikuXtG04XzDnUMPcXDTJEN3voVfeFsgTV/xPzMm2gYivJVgOKRzo+mJcyPGwrfRoPT7IQDybxh0nZrxZdI0rgMBsrsU7oK1Svy2/9+y7LBU3FKXVbkA2kVhkZq0gXxBR2Q7XY8VtEecmteSAeRkbTeTqHE7YiGLJ1bbL2WXkBSCafvtUIHYDlus1NLvZBXthDMWYn45zdv4UdvNbdzOyAtO3uvuLi/wigS06EmgW/xlCS783PXSZGDyX2TlcU1Gd16BRlFGW/DxDhDYj8SjGvHZNSCgw9wAT5J9A3LHiOJw8rvIotetd++eQiIEx/Nm3/Z1VrA0WuyySivX46EUs2pv6c7q9mzkg14lTX4obo9O7HDf/NEBdu915CO06qwVKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(39860400002)(396003)(346002)(86362001)(66556008)(16526019)(66476007)(66946007)(6486002)(53546011)(5660300002)(36756003)(44832011)(186003)(2616005)(8936002)(2906002)(83380400001)(316002)(8676002)(6666004)(31686004)(31696002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MkxRcDhxVmRTWU9yYko5UUI3Q2ZYVnpESGNYa09tckRaK0kvTUZxVFZ1aldL?=
 =?utf-8?B?VDlteUlrZ3pVVGMvV3ZYbnplWWZvVFM3eXE4YjhiTkppaDY5K3lCZkRlZWY2?=
 =?utf-8?B?YXM4TUY3ajRLR01LNlArZHRyaDVEbUFWSG81aTBRUGhRWlQ0Z0h4aEhwblRw?=
 =?utf-8?B?Y3hybEFKbjE1aXZUakFBQjZEYVhyWVdUbFdJZ3RaNEgvNGVINUd0aWF4T2FM?=
 =?utf-8?B?bExFZEE1UDRGV0dPZTZ0V1VhazR2eGsxeGlFazVpdm94czVNc0RFS0hQZkEv?=
 =?utf-8?B?QkV2Z3k3SUdubE9sMzM2T3V5NVhHZUtHNm5mRkdydDRhUHZwRDN1K2d5dCtE?=
 =?utf-8?B?eTU5ZGczQzRCNmp0VWh2ZnZVaFBsYUhsMW1PYm10U0t6azZ2V1FhdGpBdjN3?=
 =?utf-8?B?ayt0N0ZYV2pqZURyT1dYN0p4MWNkN0UxQlVoUFQzSHNRZ013dnRKbHIvTUNW?=
 =?utf-8?B?dXZzTmJqZkVtalFTdFFCMC9KVHNPcGJ2b0RkUzY5aTlCU3RYMFVURk9sV1dU?=
 =?utf-8?B?Y0xQUk45Nm1IOVJyMHhpSWxjUGwzZER4Q2x3OFJHL2FuNEVvTUdkbHZOQUg4?=
 =?utf-8?B?eEY2elJucG5vUEFxSmpJS3pzN0RsY1R3c1RNcnF3UDdGODBrWFdSY2xLZXEy?=
 =?utf-8?B?M0tsQnNESWNONkFwdmxBd1lqcytYQ0VwVHUyd241b29LdXd0amVRRVJLMWVD?=
 =?utf-8?B?YzNxQVAwTWlrY1ZkM3N1UElUSFRRMjZka293SGFSSFVkWXkrSUc0QlZpOGRY?=
 =?utf-8?B?UFBGc2JBdUFnSGdQNm0wL1RNb0hsSW9VY0N6YzFyN2VVeWNTODRaclZCZlU3?=
 =?utf-8?B?RkR0K25PQXpUNStFaDQvUEhjWEdwMmUyQ01oS3BGVU94UFMyWkxyYlZnbUxr?=
 =?utf-8?B?NmordXF2NGRHeDZGUXVVVTUzRjBxNFNPRmwvV1pPY0Z3dmZtUEt2bFIzc1NQ?=
 =?utf-8?B?aE0wczhrd0ZxVzRRWlhhNlliK2YyczRacExlbFJyU2dHa21LUEMzNFRLOHdE?=
 =?utf-8?B?OC9VM3lHSU5WallSekRoV3pUUmtUZHk5OHNQelpxMDg5aXNOd1I2aytFaFAy?=
 =?utf-8?B?d0JUUXhBREg1MlZGYVBMQzFGZGxPN0k0WDFMeXQvSTIrT2doR1prbXc2aEJF?=
 =?utf-8?B?OW1BUmZ3SVBSN0FFcUpSYXpOQ2wwdUtDckIvOEZPTWtDOXdveHBPU2RLNXFV?=
 =?utf-8?B?bnV5dGxDc1o3K2MwdUY5ckJ4YzVOaGlxOFFWWE9sK1VXY0QzVjAybWw5aC9h?=
 =?utf-8?B?WlJ1WnZ5QkNZbjBzWGZrUWJpZHI1cmJSMDhKbkwvdjVFKzFpY0JxWlZiK0w1?=
 =?utf-8?B?T3dTY2R4cVNuQkFEZGtEUHM5NzBLTDdXajNLRkdVQTc4STE1RG1OK3ZOai8w?=
 =?utf-8?B?YVlQUDhKZ3FTaUovYWdKdm5CUGluRG9TVUh4NjhsTWVpZ1FZS0MzeDZnajJw?=
 =?utf-8?B?WDc5MjBqQWl2U1htMXlvU0x2QmplSkFNcmlFeGtVVG50ZHo2MDJPVFZxTUZY?=
 =?utf-8?B?aDluZ0VVVnBRem5mQ3RTRkFoQmlDamhsL1FSUVRYeVNNRUlZTEdQSDdXSEE5?=
 =?utf-8?B?R0pKOVpIZkxkb2pGMHJqZ0oxM2EzV1dRdEhyR29KemUrMlA5RkR6QytUSWI3?=
 =?utf-8?B?NkJUM09jRGtraDJmWkVDcUFQYmxyY0dYTzIreVVWM3B0U09TOWRSUlZuMUZu?=
 =?utf-8?B?WG53NWFOWE9ZUnowT3p4VHlHRFFpQVZ0Ynh6aU1yalExZDRTNk1sUFdKelNm?=
 =?utf-8?B?OTFVaFV3cnNOSjZ3cmh3bThRY2g3MFV3M1I0MFRaT0dhN0Zia0czeElFNHNF?=
 =?utf-8?B?VFNpais2SDhuQ0VKeTlkVDlQZ2phZWhsV1pzOC85V09GL1h6ZDh6WDJ6aE1Y?=
 =?utf-8?Q?SPiCIHFLzjEOR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a31530b-cf62-4fbd-ac23-08d8e7aac2be
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 12:06:27.5406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OgNrhfF962SywFFX8a8gtXMq9z7cDzyBLgQhxMNbfFDSUYAdbvJTne0CTAaVFxrM/syUmDDYiaG9opKhPLe6wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4980
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9923 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103150086
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9923 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103150086
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/03/2021 17:08, Qu Wenruo wrote:
> In btrfs_invalidatepage() we re-declare @tree variable as
> btrfs_ordered_inode_tree.
> 
> Since it's only used to do the spinlock, we can grab it from inode
> directly, and remove the unnecessary declaration completely.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---

  Reviewed-by: Anand Jain <anand.jain@oracle.com>
-Anand

>   fs/btrfs/inode.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 2973cec05505..f99554f0bd48 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8404,15 +8404,11 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
>   		 * for the finish_ordered_io
>   		 */
>   		if (TestClearPagePrivate2(page)) {
> -			struct btrfs_ordered_inode_tree *tree;
> -
> -			tree = &inode->ordered_tree;
> -
> -			spin_lock_irq(&tree->lock);
> +			spin_lock_irq(&inode->ordered_tree.lock);
>   			set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
>   			ordered->truncated_len = min(ordered->truncated_len,
>   					start - ordered->file_offset);
> -			spin_unlock_irq(&tree->lock);
> +			spin_unlock_irq(&inode->ordered_tree.lock);
>   
>   			if (btrfs_dec_test_ordered_pending(inode, &ordered,
>   							   start,
> 

