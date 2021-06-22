Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69733B01DA
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jun 2021 12:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhFVK4I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Jun 2021 06:56:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55438 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229968AbhFVK4H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Jun 2021 06:56:07 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15MAqp1m020137;
        Tue, 22 Jun 2021 10:53:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=jducg8RwTxza7q1N4Oi9qUBRSQybrdomMEijTYnGqZ0=;
 b=mGZmNJRF7kIeEvnPA8N9/F7gSLzg6RqAOA8iuN68BaZdJRSJ3lhTMrBcnCWzSYgrA6N5
 egBzDp/vit7hSNzx8nHiF2Z+nTl5pT0yqnyF7FLOhANdi2dQcigcKW8ZzCyA7/HuzgIs
 ITSqUp68ZWCU064fs0tEbTO88ZUORuRMUJC3czCM/FZtgWfT0XvF7YYN8T5A6JsGW/tL
 X8NIvaIZVrcrfDVN0Hwdvnf6TQH+REW8hAEi3XEauWqnZ6ScudjUlzitL0TNnbI/fXQ8
 QpS+61IknCIZ16cPXhDCpUcQgShkNMfGnEho7KiYnJjgS5G0WRRvEMbVHNl2stxkSOHq qg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39anpuu3dd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 10:53:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15MAnqjK091937;
        Tue, 22 Jun 2021 10:53:47 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by userp3020.oracle.com with ESMTP id 399tbscyj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 10:53:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjV8IpAlXR+zoYW6FdNvHefMxQhJLAdJ6YYxJZmgMIyd1rOTn3CMAEK87WNFdLtlEeCYnpdfXOU52ZgH99Fv5heDrnWbgjnbON4HUAcOzaUk5d6+3Iji+Xh3LVPqmJmLuopo1feMfNkffMTi/eQWdka5nEK2VHzpQODZfviUQbzBQvsQSTQG1kPI2Uh2+LxvIdv0IXMOHL/w7cn+JuLkiNjPfqAt0anN2qif6zcFInQdbFnI1wA0m24KhFHFkPPcHbRLH1alErchv3o1DJtSOEGf1ErYTbAUz7GXqGRjim0JTBeiMs/shqjLzNUPa6YYqgvnjKCn4WHoBpwcFhF4Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jducg8RwTxza7q1N4Oi9qUBRSQybrdomMEijTYnGqZ0=;
 b=EyqcnJBVsn72oojII9Z/VCDLdsWDhYNnkApHM3AHV6WVWvkvWNk2bhk2elwuxFU8J9trvivW1IACSS2TfMZxbj/X6PW2P5Sx2Aqjs/bPUbqBNoq/A1ZWOKuNwBUJaImGPAVaRwDTZwbFU1HnYOKXa4ZNaj+v9V1022b7z/My3XKWX2H4xIq/jL5JYqQ1vY4tckfDX5htRGq29mrLI0jlipaazbbBuzu3kf8V+EV5f1NQZ/NHXdioAdMDQfSfwZylYkAFPY6QgGyOMrzWDynxLMSRUYFU8/ny7y0P319BRYtwK2bbbVYvbDjpot/T6dTyvwpva/EA74ksnXC7zMGQiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jducg8RwTxza7q1N4Oi9qUBRSQybrdomMEijTYnGqZ0=;
 b=qgMUtBKa19OmoVg75tEBUpvzM9UXP20543vOOrmft00WMcwWKBzjEumhekHzeWOPX2/lNRUtQKxkAo/ITOsDknn17TWAiRrsBPAWQRDZ82wmYET1yOIT/0JgoY4jttiY/L5IxZALW+hiNXzuFcmyqfgDWnvA/rYw6tzY/Sn2Rt8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4868.namprd10.prod.outlook.com (2603:10b6:208:333::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Tue, 22 Jun
 2021 10:53:44 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%8]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 10:53:44 +0000
Subject: Re: [PATCH 1/2] btrfs: switch mount option bits to enums and use
 wider type
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1624027617.git.dsterba@suse.com>
 <b821156f786564e0eb16c036428cd819b1ae9bf9.1624027617.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <f54f27c7-e928-370d-3008-4ab78a52b08b@oracle.com>
Date:   Tue, 22 Jun 2021 18:53:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <b821156f786564e0eb16c036428cd819b1ae9bf9.1624027617.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR06CA0203.apcprd06.prod.outlook.com (2603:1096:4:1::35)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR06CA0203.apcprd06.prod.outlook.com (2603:1096:4:1::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Tue, 22 Jun 2021 10:53:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad839b68-8920-4e34-5202-08d9356c0118
X-MS-TrafficTypeDiagnostic: BLAPR10MB4868:
X-Microsoft-Antispam-PRVS: <BLAPR10MB4868A5836BBA570EB8162592E5099@BLAPR10MB4868.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TSuYNrSiiOq8IRR26kM1gNITjCcAd3vgP1vbk1QL7LlmIul7vVXwpTxZUkG8Cuy3OTZm01f998EzzVGi3UOklDovCLBEhdTajRaXeeLAVMjneanv2YLjxCWKspthNUbAJsWwRAglt0Thg3OPKNEKgUsouSBHpIuvy/jgWIG0z3RBZvQ7/YaU1jzYRdp4E56GA2R55pxk4KLNqd/tm0IWmSrMpb+JxSp/1HEAUyus51av/HZSLc7qyUHhfn7FAk5DEm2yXdf8nwUp3SANXTyr5xmvrt5jwZuVwmvM2+jC4MoUhwh733FkVPZgUIt8L/p49OvCyT9ATEmqcuCfh56DXKfDQax3twkSvS8LvoVhEJLIfzprqdzH+qsDdcYrj8gIL0iA+OOdjY1PaOYWs4HQRCKq8T2JhY+n4zEwlrDKCD+pfckskGsLJEufFdUQ38auB+pbwGFlTfFd10kcoQ32BAdzUw6gbstLeoNUQeJjA62fizoP3m7ncmhopEDwTtbY4BSRN4tyRfpkv281+kwMGf/OWWLMYBXXg3aRn1Coe8RXpG3RvSFhkdlZWVUFn/z43mjMq4/x28tME1M4YFbFCGs+cmdoWJz/v/MaFOYViIvvbjHE5pdQTAU1poFIwdzcJuer1Nx09yr38aHSpmxlVVIVCeza00bqpjho2UNfMuPampQH4qihqPZkLEBhi7eH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(396003)(366004)(136003)(6666004)(44832011)(6486002)(38100700002)(2906002)(2616005)(956004)(36756003)(8676002)(186003)(53546011)(478600001)(66556008)(66476007)(66946007)(83380400001)(26005)(5660300002)(316002)(8936002)(16576012)(86362001)(31686004)(16526019)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVcyeWZWWXNZaG5lNWhHcUVBa3BTQnJ1WFNvTlZXZzdmbmpBamJTTmttNy9w?=
 =?utf-8?B?ZGMwR3VCK2xSU2hlSkJhYTlmU2R2MXdrUDlyYk92ZXBxVjFELzhYTkRSUnVx?=
 =?utf-8?B?S0NVaTE4MmtObENFTGt2cjg3NXMvTFpaRXF1OWVLZVVRcmdEcGdSVHl2Wk5a?=
 =?utf-8?B?MW5JMmpqOE5HVTRLV2ZqM2l5ZlpZakJod2hZN21FL0VyQjBHMS9UNndRcmY4?=
 =?utf-8?B?dHkwTVVWaFZWSktFZDIwMVZWRVZWQ2hKaXcrTTBlU015aERzT2RTcW90SEV5?=
 =?utf-8?B?TmI2TkxNWmQvNEJNY2pjZnh0OTRYZEc3QUF4ZzRrYkVCWkNEWC9NWlVuYW5a?=
 =?utf-8?B?Q3pNRGVpR2lheXZtNFBCMGtmZ0h4aFQrTlF1anhZVkphN0FYajNZNEpteWZp?=
 =?utf-8?B?cHNjckMwUlU1eDJxSGVXNVZlVUJDWG5UYlhkeTFybVV1Y3MrVXAwL0xNQjAz?=
 =?utf-8?B?b28yVE95RHF6SFlQdkhBVU9kS2l2NGJDbTFhWXJqUFF6R1lSUW9mKzc1QXE1?=
 =?utf-8?B?bTMycFJVcVhTeFgyd0hxTWRuY3dhWUNhQnRFY2Q1cWFObFkyb3Qyb2M4S1pv?=
 =?utf-8?B?REs4d1FFenF6MjBjeUowZDl4ak1NeFd2Y3h3NkFHWXpFMkdDMHc2K0tkTVZD?=
 =?utf-8?B?b1N2Q01FTTJPQm1wbmFYTkF1Z0dKYXl2VU1Odmk3UVZmQWgxN3pnUHlrV2ow?=
 =?utf-8?B?a3NFdTVQQTk4U1V3V1FZdEUxVE55a2tILyt2VmtFOXVYR0RBY3k1TUYwS0Z3?=
 =?utf-8?B?bkJGWmNyRzc2ZG1Zd24xSW9CWFN1a3lZV0JTRXQ5RTFBYnF1RVZVK3cwbkJZ?=
 =?utf-8?B?UENXbmF6cEZKOFlJd2dCMlc4eVo1RFhTblIzSlcyVmE0TndCOEVsNVE3U3po?=
 =?utf-8?B?YnFVcnV6YmN3a2JJNk1HRVg2MlRjLytyMHpxK3lob0t2dllneW1XWm1vN0RM?=
 =?utf-8?B?SytERG9jNVNpU0R6Z1dENjBLaWEyU2VFRXhUZVA1VWZwVnRiMmJycEhUY2hT?=
 =?utf-8?B?eWZkUHpVNzN4aUlLZ0N2eGsyOHE2S0pkR2xxa1B2UVdySlc4MDlFSFlLVFMw?=
 =?utf-8?B?QUdUeDdMK1Z3ODdFUjhRbHFSczZsT09jNU1CY1FDbDFldEVudElWa1FHcVll?=
 =?utf-8?B?OWgwd1czekdtNkJCeU9SZnpUMUxYenhtM3hkM0FRZ1lVZ0kzY2ZjYU5tK3Yv?=
 =?utf-8?B?bWIrcXhhbVZ4UWlJeGpybEFxRUh5Vzg3VDRxVnM4OTR6amxQbXdvR3BrWldD?=
 =?utf-8?B?WEdzYW05MkdPbUxYdFpmS3dNalJ3VFIzY3pkTkg1aXNjdGN6M2paOW9lNHhZ?=
 =?utf-8?B?SXpVbHZTb01DTjFzTXpWeXI4cjd4bkw0SkxWb2lqcHNjMnJTRFVRdnFFUDdU?=
 =?utf-8?B?U3ZDV0NkU0xERFljSWQveUhXTUd5VDlnT09HMmJaRzBEcytLUlJrK3N3Qkw5?=
 =?utf-8?B?bXdXcmtSM0xmZGdEcm9jZzdHNTBERnQvUFYxUHdhZnBzRUlSYW9WbGR0YnF1?=
 =?utf-8?B?Y3duVVc2Ukk1SzY4OHE5NDlISVo1Q2ZqdDZmSjhOTDZodXJKZXplckU4KzRs?=
 =?utf-8?B?dUY2Q214Nm1ldzhWc1ExNmkrc0xvZ1FnMTZ4eUptUjh0Q0ozSlJNSFg3YlZa?=
 =?utf-8?B?ZjlYSEJzb2hSSGpER2V1bWxEKzVTN1YyRXQ1YUpWK0pOTzZDVzBWcnQzNGox?=
 =?utf-8?B?YkdINENZTWl0bkJ1Nk9YSmg1SFE2bW82Z0xwcTlxb1kwQWxWd0c5aWVYUXY0?=
 =?utf-8?Q?zSKv9PTpSbguFayj3WjjnAkFk5NW99xYTVJFZGK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad839b68-8920-4e34-5202-08d9356c0118
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 10:53:44.6352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x77GNAEBnip3UUvIdFAzrlojCWlmOPBZKRxDW81mRf3FFaH3gvSGGYMinJsqmLAs+S6jnHvlqtOEkoC08KYiJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4868
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10022 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106220069
X-Proofpoint-GUID: WcRdmvQTY4bp_3gCdHEnH6mwY9Z2ffnJ
X-Proofpoint-ORIG-GUID: WcRdmvQTY4bp_3gCdHEnH6mwY9Z2ffnJ
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/06/2021 22:52, David Sterba wrote:
> Switch defines of BTRFS_MOUNT_* to an enum (the symbolic names are
> recorded in the debugging information for convenience).
> 
> There are two more things done but separating them would not make much
> sense as it's touching the same lines:
> 
> - Renumber shifts 18..31 to 17..30 to get rid of the hole in the
>    sequence.
> 
> - Use 1UL as the value that gets shifted because we're approaching the
>    32bit limit and due to integer promotions the value of (1 << 31)
>    becomes 0xffffffff80000000 when cast to unsigned long (eg. the option
>    manipulating helpers).
> 
>    This is not causing any problems yet as the operations are in-memory
>    and masking the 31st bit works, we don't have more than 31 bits so the
>    ill effects of not masking higher bits don't happen. But once we have
>    more, the problems will emerge.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand


> ---
>   fs/btrfs/ctree.h | 65 ++++++++++++++++++++++++------------------------
>   1 file changed, 33 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 6131b58f779f..e0f6aa6e8bd2 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1384,38 +1384,39 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
>    *
>    * Note: don't forget to add new options to btrfs_show_options()
>    */
> -#define BTRFS_MOUNT_NODATASUM		(1 << 0)
> -#define BTRFS_MOUNT_NODATACOW		(1 << 1)
> -#define BTRFS_MOUNT_NOBARRIER		(1 << 2)
> -#define BTRFS_MOUNT_SSD			(1 << 3)
> -#define BTRFS_MOUNT_DEGRADED		(1 << 4)
> -#define BTRFS_MOUNT_COMPRESS		(1 << 5)
> -#define BTRFS_MOUNT_NOTREELOG           (1 << 6)
> -#define BTRFS_MOUNT_FLUSHONCOMMIT       (1 << 7)
> -#define BTRFS_MOUNT_SSD_SPREAD		(1 << 8)
> -#define BTRFS_MOUNT_NOSSD		(1 << 9)
> -#define BTRFS_MOUNT_DISCARD_SYNC	(1 << 10)
> -#define BTRFS_MOUNT_FORCE_COMPRESS      (1 << 11)
> -#define BTRFS_MOUNT_SPACE_CACHE		(1 << 12)
> -#define BTRFS_MOUNT_CLEAR_CACHE		(1 << 13)
> -#define BTRFS_MOUNT_USER_SUBVOL_RM_ALLOWED (1 << 14)
> -#define BTRFS_MOUNT_ENOSPC_DEBUG	 (1 << 15)
> -#define BTRFS_MOUNT_AUTO_DEFRAG		(1 << 16)
> -/* bit 17 is free */
> -#define BTRFS_MOUNT_USEBACKUPROOT	(1 << 18)
> -#define BTRFS_MOUNT_SKIP_BALANCE	(1 << 19)
> -#define BTRFS_MOUNT_CHECK_INTEGRITY	(1 << 20)
> -#define BTRFS_MOUNT_CHECK_INTEGRITY_INCLUDING_EXTENT_DATA (1 << 21)
> -#define BTRFS_MOUNT_PANIC_ON_FATAL_ERROR	(1 << 22)
> -#define BTRFS_MOUNT_RESCAN_UUID_TREE	(1 << 23)
> -#define BTRFS_MOUNT_FRAGMENT_DATA	(1 << 24)
> -#define BTRFS_MOUNT_FRAGMENT_METADATA	(1 << 25)
> -#define BTRFS_MOUNT_FREE_SPACE_TREE	(1 << 26)
> -#define BTRFS_MOUNT_NOLOGREPLAY		(1 << 27)
> -#define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
> -#define BTRFS_MOUNT_DISCARD_ASYNC	(1 << 29)
> -#define BTRFS_MOUNT_IGNOREBADROOTS	(1 << 30)
> -#define BTRFS_MOUNT_IGNOREDATACSUMS	(1 << 31)
> +enum {
> +	BTRFS_MOUNT_NODATASUM			= (1UL << 0),
> +	BTRFS_MOUNT_NODATACOW			= (1UL << 1),
> +	BTRFS_MOUNT_NOBARRIER			= (1UL << 2),
> +	BTRFS_MOUNT_SSD				= (1UL << 3),
> +	BTRFS_MOUNT_DEGRADED			= (1UL << 4),
> +	BTRFS_MOUNT_COMPRESS			= (1UL << 5),
> +	BTRFS_MOUNT_NOTREELOG   		= (1UL << 6),
> +	BTRFS_MOUNT_FLUSHONCOMMIT		= (1UL << 7),
> +	BTRFS_MOUNT_SSD_SPREAD			= (1UL << 8),
> +	BTRFS_MOUNT_NOSSD			= (1UL << 9),
> +	BTRFS_MOUNT_DISCARD_SYNC		= (1UL << 10),
> +	BTRFS_MOUNT_FORCE_COMPRESS      	= (1UL << 11),
> +	BTRFS_MOUNT_SPACE_CACHE			= (1UL << 12),
> +	BTRFS_MOUNT_CLEAR_CACHE			= (1UL << 13),
> +	BTRFS_MOUNT_USER_SUBVOL_RM_ALLOWED	= (1UL << 14),
> +	BTRFS_MOUNT_ENOSPC_DEBUG		= (1UL << 15),
> +	BTRFS_MOUNT_AUTO_DEFRAG			= (1UL << 16),
> +	BTRFS_MOUNT_USEBACKUPROOT		= (1UL << 17),
> +	BTRFS_MOUNT_SKIP_BALANCE		= (1UL << 18),
> +	BTRFS_MOUNT_CHECK_INTEGRITY		= (1UL << 19),
> +	BTRFS_MOUNT_CHECK_INTEGRITY_INCLUDING_EXTENT_DATA = (1UL << 20),
> +	BTRFS_MOUNT_PANIC_ON_FATAL_ERROR	= (1UL << 21),
> +	BTRFS_MOUNT_RESCAN_UUID_TREE		= (1UL << 22),
> +	BTRFS_MOUNT_FRAGMENT_DATA		= (1UL << 23),
> +	BTRFS_MOUNT_FRAGMENT_METADATA		= (1UL << 24),
> +	BTRFS_MOUNT_FREE_SPACE_TREE		= (1UL << 25),
> +	BTRFS_MOUNT_NOLOGREPLAY			= (1UL << 26),
> +	BTRFS_MOUNT_REF_VERIFY			= (1UL << 27),
> +	BTRFS_MOUNT_DISCARD_ASYNC		= (1UL << 28),
> +	BTRFS_MOUNT_IGNOREBADROOTS		= (1UL << 29),
> +	BTRFS_MOUNT_IGNOREDATACSUMS		= (1UL << 30),
> +};
>   
>   #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
>   #define BTRFS_DEFAULT_MAX_INLINE	(2048)
> 

