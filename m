Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC6C3CD140
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jul 2021 11:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbhGSJOS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 05:14:18 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48924 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231928AbhGSJOR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 05:14:17 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16J8CZVS025306;
        Mon, 19 Jul 2021 08:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=4oBmmz3G8WJra5E3RZmYjmoCcmWF/x1hj81UEaWbuMM=;
 b=APmvliJQ5xRamblTqQYRqB9oKlYGhRU8AUV+CTR+3adSq6V2XS6qlf+YtqtGosiHiDL3
 pPh74DU7vRAOWGsqenE/8BjT22y1b4Fbvh8z1H5NwOmWili51y74CZeRX41bwQy9f6Lk
 PYxytBCJlLzE0Noi13gsJoPGX+0rkXNTTWE62Q7BMbu3rGv9VmUJkJiucAhRVq0mYHiX
 OswBLP02l3iD2l2vTQu19BjiFaRSfEbM9Q/OSCD5ZU/Xj16qPeeWvoXiWvMt1LvJDgwQ
 j7U2y6tDLAxgBfgjLqmr6p3IZqQ2rSNQaQJI+9ZGswojQBWlMu9bNGaubdPxLlYXkgij qg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=4oBmmz3G8WJra5E3RZmYjmoCcmWF/x1hj81UEaWbuMM=;
 b=EgBFfj7RpyiDpNkeyf0qKiljercUdJR3dfa1JAE8S28mTG43N+Dut+Th/aCLSMUH23qu
 pI+VE/3NV0AfM/rDE5rXDC/or2NVme6At0AroHhZOopfo7adk6kwqpI+MukaOGX8Ol5o
 XYhSq9Ni2DpR5IlNeT0AE2kUcOJkajwPkYi97SC5UhzhHlqRWEH+RRoDBrIJWTdbUNde
 nAx5moQKlZ+U0h0w6CjJAP871F1Pb2HObbrzfg+RIC+6qJZ51ui3Caj/OCYCCKO05efa
 cDSOcxersXTAfmE614BKFybVqZFDXS6tMO5OUvCSARJVIekM241Bm1CuyI9MNAaOw3/w wA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39vrn5gtqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jul 2021 08:19:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16J8B14G041853;
        Mon, 19 Jul 2021 08:19:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by aserp3020.oracle.com with ESMTP id 39uq14a2fa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jul 2021 08:19:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBCSuFGk+i8u+ZeljZKgeQqKYrt0WRNUSh9YiGCIxPvErEkA7mFe3S1dOAEvOBzsyhWmw5DtEbqICFQFJRf4Gb37tgaI0hVh4LVcF/uEEz0iRhUgjEahMY/9Al622PV7tTyOr9n22kkBi+7gz+103pDBlpi5P+UVDFvW3cc4X8kuQf4xKwBgQqT1BgJGUQo//ujoNtpNyAmbKc40yQVilNtaJ+iezuxeYiUIfi3Kcga9/fYR+9d0HOXHAV/G1s0/gqvW8SD5emmlw3QKkYkxvgpNaO37T3ZmFBut9JA1T7IS5FQG5KHJ7czThLFvXWoJYNSgwya07heby8cEbaUolA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oBmmz3G8WJra5E3RZmYjmoCcmWF/x1hj81UEaWbuMM=;
 b=Na1d6gcBPDkk8i6826yjjfaBq+7Rr5ICtLb3AHegLHq/zRZxZ8RCjdJWHt2ld/lCCzC/erXcXSSPx73MIlZl+nQ1F8hZxp/mhtL6Uef43WctYk96oSAs8RoxCBHxSTAhbLufr9/QpmmahyLaCWHL+IRdBJGzK1WVbCRH9bzugOLu2JdbR6157ZQNE6o9XtrE6qW9AZDT6DNPuhHLHAomAkz9TgYkPcbpnJ51+r+vDdXSAqPWvhl1Erecwpuy9RpX94ckp3HOMF5524CS15AVgTnelFlXEy5Hle2xQ8ofGShvYYbjtAwnTLaF/3Iw2OyurT5pLVNa1kjwJyavf1cXIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oBmmz3G8WJra5E3RZmYjmoCcmWF/x1hj81UEaWbuMM=;
 b=tYaelNuwTvaSNBPEqzDVqf7laKLY7dt/aADaqe3SxVavGL+D2OgTzPQenOMzzqChEWQaxGdJ8xKz8iVHQgkHJ1KYto4Whmnk5UM3D7bGxCuLHQFu8oylhnr9MhYMAVcP9myS0+esYMIn/5pJRtX8qsHwVldvpUyCWS8oTP828bM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4932.namprd10.prod.outlook.com (2603:10b6:208:325::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.32; Mon, 19 Jul
 2021 08:19:15 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%3]) with mapi id 15.20.4331.032; Mon, 19 Jul 2021
 08:19:15 +0000
Subject: Re: [PATCH v4] btrfs: rescue: allow ibadroots to skip bad extent tree
 when reading block group items
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Zhenyu Wu <wuzy001@gmail.com>
References: <20210719054304.181509-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <da3f9aee-4464-d70b-e5a8-b1009999e2e2@oracle.com>
Date:   Mon, 19 Jul 2021 16:19:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210719054304.181509-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0013.APCP153.PROD.OUTLOOK.COM (2603:1096::23) To
 MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2P153CA0013.APCP153.PROD.OUTLOOK.COM (2603:1096::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.0 via Frontend Transport; Mon, 19 Jul 2021 08:19:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94870038-a43e-4638-a6bd-08d94a8de54c
X-MS-TrafficTypeDiagnostic: BLAPR10MB4932:
X-Microsoft-Antispam-PRVS: <BLAPR10MB493217293478D6D4CEF172C8E5E19@BLAPR10MB4932.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C6jpE19tKZUKIxHi+OH9r44SDFkFrF6kP9KxBi126ednhbOKKajfk6Hil5DUQkl4oJQzCswtssxm7mGdztQQRo1+qBmWBxJWIDGh8PXU3TrgfnT99wkAR2qXHkhzFMtlZUop4ViXhWxbkrBh7Atw5PJa5MHZ8M5ljgmZSIf7Dsek7bffL17G+YFrSCEUTh0hQJlvfo7NKptmJBkGxnWJUfprjn+t6m7ttatMs+JWKlVt8U8Z5QYRCmMgTBBvBURtma/Y1I3ut1RTkIoBQGTbCtLE3yO8PyBssbWcNXhqqF5pcal/zW5Hl7q46t0NdpLOOzOQEqcX0YOl5/V4LVa7qimISi/tHL//my/D/idq9dt9rxqgnR5DU8eag6bDvJntzS/8U31gDgIh9npfi255WgZ/8ue49iKRC1A0Vuithgx4pY/K5+L5m/60oHuofaxlJFSsJvYRB2f7s+K5Bx27LHnyV9kbL1mpTro9Jy0JLu9rQwJBQUXwDIUidwGGLhIo7tEIBWmm4goQ/7KGTrE11WjsveF6TLxh3yWdvRHdPgo4VQSeVUHXNXDiXBVJ4FykRM/nVrbDfVWgWjf7emashcZiMBupvZligPpPHaPN8ljTst43u/ZnHcWLB3ZIc4xyKB4im2e5f6RH7TGeb16C4r++T+jlsGFImlOIG9kwBTWoYJp9p+8djQRUuHAJ79wcUaBqc148ntQyE3D0fzAJ7rQghLXTtQphl2L8oiXqe72BYHg5+rVl5WEcsPD+MrIIYpBwAZNunJ7OF8jod1ri3/ssV8FWKuzTMOTR+got4+aMvlgahib448gaxiBACzBj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(186003)(2906002)(966005)(508600001)(26005)(66476007)(6666004)(36756003)(66556008)(66946007)(8936002)(31696002)(38100700002)(53546011)(86362001)(5660300002)(31686004)(956004)(83380400001)(16576012)(2616005)(8676002)(4326008)(44832011)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEdFQnh3WFhwZFlaaStUN0x4RjhaeVNPS1NEbjZzdHcxMzlSZ2xlNnNtOHNk?=
 =?utf-8?B?eWhucWp0Z0kzb3dJRFdLMkZ3aDArMWpkbVVtU2V2ckpBK045N3dkNjllbFla?=
 =?utf-8?B?QWVYb0lFK1g0SEk0bWU2MHBCZkNMZ29yS1pqZjZwZ1pzT3RzbXVSbnVZSHRr?=
 =?utf-8?B?cmJ2MzI1SFIzT0pLWnF3YUZkQmhtWUJvdDR6WmV4alc5SUYzWTRweG1ocTF4?=
 =?utf-8?B?SUp6Zy8wNTRvanZMaTNOSW42N0dRcHJWRlVIcnp1RDlqRjhVaytuaDlSZlg1?=
 =?utf-8?B?WmNaK0c5Ylovb2JDUlRYOGF2NVYvL3BaYkI5ckpuQUdjVE0yVVFReVRDU3Jz?=
 =?utf-8?B?YVo0SmJTV3ZIZjRGZlFDRlRDTHNGYWpiazZEYXBIN3NSZTVwL0V3cDFSajhu?=
 =?utf-8?B?SElxME9VTjU0c2t1eThEbXVBcmdZa0VYQTZMYXY5VFMyRy9NbFJHbGFJQThu?=
 =?utf-8?B?bU1QMXpRaDFvSDhhOXFhQnR1UXpQNmV1REJCVFd1LzZQM25rUmg4bWlqWDBK?=
 =?utf-8?B?VzZuNU16bE1nS1laNTNiWTVoZ3F6bWNoaUpZL2ZDVjRnN0pVK2Z2MTZrMjR1?=
 =?utf-8?B?b2hEai9xQTBiMnJKeDBQdzN5Wmk2alFIanVxc09mOU9LZEJtWEF0QWRVSThI?=
 =?utf-8?B?UkMyNWtzK1dsQlNac2RzSG9ES1h6TjhPb01BVHZET0VsVGxhZS9zamZjR0xa?=
 =?utf-8?B?VWNCWWpLUzBQQU1MZk1VL2w0cTBwMHpUSUpOR0pEbjlFUEdCQTR4SDZEaSth?=
 =?utf-8?B?TVQvd244aEpBeXRqdisrQjBvRVpKVW8rcE5wMjdYYmNybG8wTkRONEp2b1FR?=
 =?utf-8?B?RmVzaVl3bXk5VzlHWTdZZkRPaDB1cDNRWVkyam9qaFpuN1pOZTlON1hSdkZi?=
 =?utf-8?B?cGRaaC81eDczZ0NTc3BjUXJ0L1BDazNNRDBlRFNxQURUZWRGQml6ZVc3THMv?=
 =?utf-8?B?eS9TWUpPb09LTENsV1ZhSlg1ekIwVDZWaWg0QVpnVkxxWDJiYnlneHl3RnRi?=
 =?utf-8?B?WURWc0I3b2tRV2FCRzRDbm5hOC9HbE05NDBOYWlpVmxmQ3BaajF0Q2pDUEM0?=
 =?utf-8?B?NUNwSitJbVExWDJESzYrS1RveDluZWI3MHNxbmVCSm9aZXR4UnZYMUN0SFBC?=
 =?utf-8?B?OHdVWFd5TmYzMmhXekNyaFlWd2QzR1dUR21SQlQ2cVp6R01zWm52dEdiYktG?=
 =?utf-8?B?NmQ0YkhGTERMY000Rzg1THRmTjJodFhpdUxkT3BmUEo4OFA3SENMUWRKTGJQ?=
 =?utf-8?B?VmdoOUg1akN2NVJUMlBUaXBmNUVzaWZNTFVhdzVIalNBOUFHeFRoMGxEa3U4?=
 =?utf-8?B?Nk81VnpCQUJVYXBYay80cnRnU1MvTW9LVzhMUHhMT0Z4dXRjc0N6RDhOdW9C?=
 =?utf-8?B?eFF4WWc4NmZOYTJMNzNqVWV6MHpwYlZrK0tzelVQTjgyLzFUQWUrTXVYVWRL?=
 =?utf-8?B?WGlNUzJEVUxvNzdZU2grL1RaU0VnNGRWZ01uck1WUVZPSUs3WVBWeXhMRkxB?=
 =?utf-8?B?ZjlINlEzcmNJTERFNzFwMi90OVN3NlNOQ0xvN28rRVQrcUpTNHNqRGRYUlZo?=
 =?utf-8?B?TktRcTZLM2tTNVhyekd2aHk2eGthVFVKajhVWEh6cHBPUkhjWGhsbUt0WFc4?=
 =?utf-8?B?K3FvWEV0OE45V2lJdmY0dld1S1diL25RMlJaRktJbENyd25DL1o3SjNrOWtY?=
 =?utf-8?B?eE03L0MvZTJ2ZmRjR2JDN1ZKKzJFMDJNME84eWNobkpHeFAvWlpkaUVmVGRi?=
 =?utf-8?Q?i/FFtuqBuZ70VLPcPxHmC/k20yx5pUGduNx80Fs?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94870038-a43e-4638-a6bd-08d94a8de54c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 08:19:15.4505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dKeHlocl8EJ0Phw7AKr4hLOGGhO0p3vpHzYNfo0wR2cHeKiAyui1eBeR9clt9mX6TcNyIMD8i1N8R3bcj/AwWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4932
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10049 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107190045
X-Proofpoint-GUID: fmLq57FY-Zy_eWBU7NsuF-pgsyXDNYjv
X-Proofpoint-ORIG-GUID: fmLq57FY-Zy_eWBU7NsuF-pgsyXDNYjv
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/07/2021 13:43, Qu Wenruo wrote:
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
> v3:
> - Remove a dead condition
>    The empty fs_info->extent_root case has already been handled.
> v4:
> - Skip to next block group if we hit EEXIST when inserting the block
>    group cache
> ---
>   fs/btrfs/block-group.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 5bd76a45037e..758ba856f8c6 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2105,11 +2105,22 @@ static int fill_dummy_bgs(struct btrfs_fs_info *fs_info)
>   		bg->used = em->len;
>   		bg->flags = map->type;
>   		ret = btrfs_add_block_group_cache(fs_info, bg);
> +		/*
> +		 * We may have some valid block group cache added already, in
> +		 * that case we skip to next bg.
> +		 */
> +		if (ret == -EEXIST) {
> +			ret = 0;
> +			btrfs_put_block_group(bg);
> +			continue;

Looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks.


> +		}
> +
>   		if (ret) {
>   			btrfs_remove_free_space_cache(bg);
>   			btrfs_put_block_group(bg);
>   			break;
>   		}
> +
>   		btrfs_update_space_info(fs_info, bg->flags, em->len, em->len,
>   					0, 0, &space_info);
>   		bg->space_info = space_info;
> @@ -2212,6 +2223,14 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
>   	ret = check_chunk_block_group_mappings(info);
>   error:
>   	btrfs_free_path(path);
> +	/*
> +	 * We hit some error reading the extent tree, and have rescue=ibadroots
> +	 * mount option.
> +	 * Try to fill using dummy block groups so that the user can continue
> +	 * to mount and grab their data.
> +	 */
> +	if (ret && btrfs_test_opt(info, IGNOREBADROOTS))
> +		ret = fill_dummy_bgs(info);
>   	return ret;
>   }
>   
> 

