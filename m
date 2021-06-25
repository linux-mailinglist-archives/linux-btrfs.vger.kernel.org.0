Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE6A3B3FE3
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jun 2021 10:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhFYJBT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Jun 2021 05:01:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:4196 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229956AbhFYJBQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Jun 2021 05:01:16 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15P8sWIb012105;
        Fri, 25 Jun 2021 08:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=egZAVbfEET/Q/EPW8CwCwjrRX7yISufPiGgFEsrIqXY=;
 b=ggpxLjSSahpm6w8uFPy8niaVc19SKDjhlXO2dT7rnuJffuZF1Q/BuA5DBr2nvMT0MVaR
 1XrpG6tDqSrLbB7OUxc5WjWbWGke2uO/4JDYzsnzvDi0DcgxdbESQOOAXyKYPy6twdgt
 4dem/SSe6zoyRU/49XsaX5bdd/OOIi++bAv74BpgXCiAd9HGpaomT/ta6MWimRwlahMs
 YCAIxoNkEd+IfFCiJBM1HpMouls7vi75UAlv6/3yWH2Dk/5ztdjLgbLqtoRozedrG3YT
 CKF5pRYkkMF4aMTgjSlqsopgmxlHFDkLnFJ5j33g2HCxPxXoVdFD9Zu8hY4rnWJqcU0d Yw== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39d24a8wfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 08:58:52 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15P8pbp9098524;
        Fri, 25 Jun 2021 08:58:51 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by aserp3020.oracle.com with ESMTP id 39d2436rk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 08:58:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3xRdpQXn0gmzU9ZhYTu8IyIGdPzJ/MBGF2KzUultmCJE3IHOA+yK0k6pDn93OPKJ+CVrHYPdPRcZn40RZcs6/C+DC3lot5/17VussG1KVZptR0Ejoh4NzkxFBw0Bdxp2eFZ3fFNqp1YsClQeWUSlwULlneTR8KvApTpR2aN8hETwEHEmdGGoaykVesxUtdIb69ZsuDVgqzDajfDD7YitbtiUgp1C4gaALuIk6LTDcOwi+842YUQhXtvA1CLgDVdcFEVwjEW9Mc3rKu2e+++YYYYWnnJ6Q/YreemqFtiOpqQVLFDY/Cb6XTUnayf1P7rGMaSkseSDhGPHOUF9afYTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egZAVbfEET/Q/EPW8CwCwjrRX7yISufPiGgFEsrIqXY=;
 b=Y+ZiYlPiOIXhEn1Y1KLdBfD5P4CGXbaACafS0luqN1hLbMCZLvjDjFQm2Nm4iFWySxfSj69A+5wNlczLnEDF+RwXiwsdm0XE3P+eYbHVYVHf+x+W5bUwuI+MHYpO0KuGWDRT8GXDmU94JinB53QzUkkOsd0nW25+FBkLAi7SOb8RfuzUstKOLVcm5KfSfv0XVOT1fc1qVmUH0VWPDSXNaaXZL1hKUb6whYLxrymq8puSgR0Puu6f6p2N2Uzm2b8KLKDE4n3RKrUVjGApEf7oI1Um5SpQSU+29GPuQaZ4W8w4q/bno8agZvR4gSkPltoNmcNUxT1at8XBwllSf/YlkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egZAVbfEET/Q/EPW8CwCwjrRX7yISufPiGgFEsrIqXY=;
 b=nNuEXA0Gwl5xofKjTXQLjjlo/Hg4flpiC9Q+v9pxhcSWZfD+bKi3RqyvOPxZJNiI0g9xBYN+f/9Qp4S2skZaV69hmXPNYRufQfHjf1/yETDZHzexyBlB8mtNkm2Eflah1gfECj1LfOrMxaugn+K41Gt59DM9GOSpasb08eC/uSA=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4047.namprd10.prod.outlook.com (2603:10b6:208:1b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Fri, 25 Jun
 2021 08:58:49 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%3]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 08:58:49 +0000
Subject: Re: [PATCH 1/3] btrfs-progs: check/lowmem: add the ability to detect
 and repair orphan subvolume trees which doesn't have orphan item
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Zhenyu Wu <wuzy001@gmail.com>
References: <20210625071322.221780-1-wqu@suse.com>
 <20210625071322.221780-2-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <c1606c68-c10f-9890-678a-ed2aaf10ad49@oracle.com>
Date:   Fri, 25 Jun 2021 16:58:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210625071322.221780-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR01CA0149.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::29) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR01CA0149.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend Transport; Fri, 25 Jun 2021 08:58:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f30a04fc-2b0d-48ed-d881-08d937b77295
X-MS-TrafficTypeDiagnostic: MN2PR10MB4047:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4047A316872ACF2E45266E10E5069@MN2PR10MB4047.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vF7B/LEjeQsQS5MvOPRq/8hx/oOSDvX2dTVrM1WwiRL0/LthZ9aiGR6n2XKWLholSO8zx3uEPxWEK6Qw/MLlK+b1W0WBWAkcvLfvFdAQ3fbbp+D9U74/6cpT+cAs/lPLTNn/mtz1yFgpDDAL+AoW4+S7g1i5XBDWmvIieRBmTljvaD3UNmSR+F6Jja3fCwdYp2RT6/jMzRXkQ45ptTX4r2cfJXzr8gdseZM3yjDCzru/B0PNTA4qno9AVEMQnmgB61MmvBd3iHloEOJ9sHaAgY2DVuHSZkUyd9NJ5c39fxdOawtgquYYXZ7+aDJVyXbv9YuuvH24K9tUieYv2uFLE22dc71JeIJWNNLJ/u8lYM65EvALeeG8TwarwXhDwEJVHNaAznzuFswl//b4PZdZ4vba+EbbWIQOLB3oB2GImF+KbqUOMIujpgeb43/0ZXGFQ6ojiC+u4pPJKtgw86cqTfZTaeDrHnEfgW05qG+blckwu52nSC3CxSzFEK8omumtfJo8sxZLDimc6AW9Lj1K4vLLfrLXbhh06v6n2mX5z0OCz+EzTvw7jtrssbdqIJixXO55vvc0uxdt/VGnDY2mFLDi+uzsWN+asIiQuNCrqKmh36MolMNQG0d1hpHArWGcuxZVDPARl8kfkbKQGB5H+daInrnYC4OPhPGZAx1BdOyJRefoq7Wcz4lyvZbz7w2BcevjMOILqmqGvLrnD9ZXDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(396003)(39860400002)(366004)(8676002)(2906002)(31686004)(83380400001)(6486002)(36756003)(6666004)(16576012)(316002)(38100700002)(44832011)(26005)(956004)(186003)(31696002)(16526019)(5660300002)(66556008)(66476007)(478600001)(86362001)(53546011)(66946007)(2616005)(4326008)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blhGaHhQZXdjT21PQ3piRVdNdWN6bEptZ2ZZeXQwZk1ReEt1cC82c1pVL1lw?=
 =?utf-8?B?dmx5ZDBaVW5FaTl5YnRCeUJpTG8yWXREcE9DOTZDZ1BZcC9SUWpsM0YrZ0dH?=
 =?utf-8?B?LzE3Y1JxaWg3a3RBamZxT1g2dUtpYmNVZ2tod2Q2L1BWVjJMVHV6Q2QrbGN0?=
 =?utf-8?B?VFNhL3ZHVm5sZFdRQ2N3S1RBR3pCNUswa1BUNWgrUlVGdkFudnZZM2xJOWVx?=
 =?utf-8?B?SGF0L3hjODhESkV6RWZPVmx6ZVc3V3ZHUkhGQk1qa3RqT1ppVEtMeVZhRFUz?=
 =?utf-8?B?Qk1JTTdZNHdJY2xmTUZ5ZkthaE0vOXB6RFNDcnFCSTE5ZzVjck5FVXFqVVN4?=
 =?utf-8?B?bXJMbm9tSFVSWDlMUW5LNmltcDNVeW9pMERodHppN1Y2ZEJHTzFhcy9YKytq?=
 =?utf-8?B?MjdNNjl3ZVAzNmp4Mjh2cEg5T2NxaUlwS2g0WEhmOXJQVTZnblF6YVFqdENu?=
 =?utf-8?B?QnkxMTVET2FEdkFFUjg2Mmdtb1BjNGovVWhzVjl3WHFEZTFKNjdwNUI1UWtU?=
 =?utf-8?B?YVZ2VDRnMW5oYUxZTDVzdEswQitRT3M1SXZUK3hYSG5YOE53MU55WVg2eDhR?=
 =?utf-8?B?YlQ5bVNRUWxiQUpUVnhKNWJMbkVkOWZZOXk2VDArRmJVWk9IZDB1bVNCQ2pD?=
 =?utf-8?B?YU9CZ3lPZ2lOQlROcTdXaHhGU2JaUklDSHBOWi9oZm1LWVlOVkpFRi9ZMkRL?=
 =?utf-8?B?R2FaUTJrY3djR1Y2cFordmZkT3VFM20xYUhYZnpNMG92ekRMVCsvVFgvSmtH?=
 =?utf-8?B?d1VlWFhKV0RtWkpkUktkcTdBSVZQWkMyU3E4Qkk4N3FrWFAxMS9qVkE4RGhh?=
 =?utf-8?B?SGttKyt4aFAwbzRSTjFUWm5jYW10L094Mkkvd3hDR0dsUGVFYm5ZZ002dGtx?=
 =?utf-8?B?dE10cVlTTjlYUExmMW5PazJ6Zkp1T1Zoc2FXQlhhNDI3SGlvTzNFQytBbHR4?=
 =?utf-8?B?QS8wL2daNHRCRFYwMURRN01Tckg0S0hJN2JlNkZWKzc5VGRmQWxlLzF6MXZX?=
 =?utf-8?B?c1JXYlRCZXYrZ2tCUlFWRHlIampkVktMbllFUzVoSSszNFlaYnoxelNyUHp0?=
 =?utf-8?B?ZHZlN3o3U0lQZlM3WDdjNXNhVEcwNzlOVUg1TkIzU1BjK3lpeTdDNEIrVERM?=
 =?utf-8?B?aWYyVmlrcm9nVCtKYjBHdnJyL05Na0Q3RGZrQmQzZHVNVDVYWVd0MzFoUVFY?=
 =?utf-8?B?Zis5TkRPTXhSdE81dXFoczE5Sk1uMXZ1aEtIbFdzTG9XRXZ5OHc1TmljeEVC?=
 =?utf-8?B?S29VbzgxSXdxTnByNjZaK2NHZkJSb2VENGxBVk1hUmc2S0ZGdS9JUUE1eExN?=
 =?utf-8?B?ZXpnSUxObmZxMlRxZVBuTlZhVEdmWmNxYnBmL3NVYXVWVmxMREYwSDVWUXZW?=
 =?utf-8?B?NnFuM2JpcStxZXo2alMxbXZwcXBBOGRSOUFBQ0Ywb3FtM1VaQUY2NGE2aUph?=
 =?utf-8?B?ZWtIQ0ZLM2k4YnBHR0cwTS9vOEM2L0tUalRtQ1NKQlcwZDdFRDNTNGVpZVZT?=
 =?utf-8?B?R21INXBnaVpaNzgvQlJjSGtPczltTDRZSGNvay8vWThscEFTU0loeXd4Rml4?=
 =?utf-8?B?OUNUcHFUZFJRZkVOTkZLSHAzdHY2SjBIUnQvM2h1YlgwWFJVTUU1dlh5ZnlB?=
 =?utf-8?B?SG5NNTdoNGp5ak1udFovSFE3ajRDRHRFNUoyenZkY0owR3RlZG42SGYvWnVw?=
 =?utf-8?B?RVdSV2RWVC96ckZzdFhHZ01ZZTVzN0NwK2lnQTlqb0I1UHRYV29WNG1qZGll?=
 =?utf-8?Q?uRIr5T8+I+vFUqFzAwTaBF/75WCJe3eofVAK6Ct?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30a04fc-2b0d-48ed-d881-08d937b77295
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 08:58:49.4932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+zeWosAORwaHIWVEogji/JBZLUquf+/sqfhlLtqsgKp0soOJY25UFS2mKB8an51th2EywVvK8xFSa79ivaXdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4047
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10025 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106250051
X-Proofpoint-GUID: w8gI6QSyziVLvcEyFiQ4w95_8M6EXQmi
X-Proofpoint-ORIG-GUID: w8gI6QSyziVLvcEyFiQ4w95_8M6EXQmi
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 25/06/2021 15:13, Qu Wenruo wrote:
> There is a bug report from the mail list that, after certain
> btrfs-zero-log operation, the filesystem has inaccessible subvolumes,
> and there is no way to delete them.
> 
> Such subvolumes have no ROOT_REF/ROOT_BACKREF, and their root_refs is 0.


> Without an orphan item, kernel won't detect them as orphan, thus no
> cleanup will happen.


Changes here looks good. But what if, in another case, the ghost 
subvolume isn't an orphan but a corruption? is it possible?

Thanks, Anand


> Btrfs check won't report this as a problem either.
> 
> Such ghost subvolumes will just waste disk space, and can be pretty hard
> to detect without proper btrfs check support.
> 
> For the repair part, we just add orphan item so later kernel can handle
> it.
> 
> Since the check for orphan item and repair can be reused between
> original and lowmem mode, move those functions to mode-common.[ch].
> 
> Reported-by: Zhenyu Wu <wuzy001@gmail.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   check/mode-common.c | 56 +++++++++++++++++++++++++++++++++++++++++++++
>   check/mode-common.h |  3 +++
>   check/mode-lowmem.c | 42 +++++++++++++++++++---------------
>   3 files changed, 82 insertions(+), 19 deletions(-)
> 
> diff --git a/check/mode-common.c b/check/mode-common.c
> index cb22f3233c00..d8c18f6603bf 100644
> --- a/check/mode-common.c
> +++ b/check/mode-common.c
> @@ -1243,3 +1243,59 @@ out:
>   	btrfs_release_path(&path);
>   	return ret;
>   }
> +
> +/*
> + * Check if we have orphan item for @objectid.
> + *
> + * Note: if something wrong happened during search, we consider it as no orphan
> + * item.
> + */
> +bool btrfs_has_orphan_item(struct btrfs_root *root, u64 objectid)
> +{
> +	struct btrfs_path path;
> +	struct btrfs_key key;
> +	int ret;
> +
> +	btrfs_init_path(&path);
> +	key.objectid = BTRFS_ORPHAN_OBJECTID;
> +	key.type = BTRFS_ORPHAN_ITEM_KEY;
> +	key.offset = objectid;
> +	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
> +	btrfs_release_path(&path);
> +	if (ret == 0)
> +		return true;
> +	return false;
> +}
> +
> +int repair_root_orphan_item(struct btrfs_fs_info *fs_info, u64 rootid)
> +{
> +	struct btrfs_path path;
> +	struct btrfs_trans_handle *trans;
> +	int ret;
> +
> +	btrfs_init_path(&path);
> +
> +	trans = btrfs_start_transaction(fs_info->tree_root, 1);
> +	if (IS_ERR(trans)) {
> +		ret = PTR_ERR(trans);
> +		errno = -ret;
> +		error("failed to start transaction: %m");
> +		return ret;
> +	}
> +	ret = btrfs_add_orphan_item(trans, fs_info->tree_root, &path, rootid);
> +	if (ret < 0) {
> +		errno = -ret;
> +		error("failed to insert orphan item: %m");
> +		goto error;
> +	}
> +	btrfs_release_path(&path);
> +	ret = btrfs_commit_transaction(trans, fs_info->tree_root);
> +	if (ret < 0)
> +		goto error;
> +	printf("Inserted orphan root item for root %llu\n", rootid);
> +	return ret;
> +error:
> +	btrfs_release_path(&path);
> +	btrfs_abort_transaction(trans, ret);
> +	return ret;
> +}
> diff --git a/check/mode-common.h b/check/mode-common.h
> index 3ba29ecab6cd..c44815a171ac 100644
> --- a/check/mode-common.h
> +++ b/check/mode-common.h
> @@ -192,4 +192,7 @@ static inline void btrfs_check_subpage_eb_alignment(u64 start, u32 len)
>   			start, start + len);
>   }
>   
> +bool btrfs_has_orphan_item(struct btrfs_root *root, u64 objectid);
> +int repair_root_orphan_item(struct btrfs_fs_info *fs_info, u64 rootid);
> +
>   #endif
> diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
> index 2f736712bc7f..1ef781ad20bc 100644
> --- a/check/mode-lowmem.c
> +++ b/check/mode-lowmem.c
> @@ -2500,24 +2500,6 @@ out:
>   	return ret;
>   }
>   
> -static bool has_orphan_item(struct btrfs_root *root, u64 ino)
> -{
> -	struct btrfs_path path;
> -	struct btrfs_key key;
> -	int ret;
> -
> -	btrfs_init_path(&path);
> -	key.objectid = BTRFS_ORPHAN_OBJECTID;
> -	key.type = BTRFS_ORPHAN_ITEM_KEY;
> -	key.offset = ino;
> -
> -	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
> -	btrfs_release_path(&path);
> -	if (ret == 0)
> -		return true;
> -	return false;
> -}
> -
>   static int repair_inode_gen_lowmem(struct btrfs_root *root,
>   				   struct btrfs_path *path)
>   {
> @@ -2622,7 +2604,7 @@ static int check_inode_item(struct btrfs_root *root, struct btrfs_path *path)
>   		return err;
>   	}
>   
> -	is_orphan = has_orphan_item(root, inode_id);
> +	is_orphan = btrfs_has_orphan_item(root, inode_id);
>   	ii = btrfs_item_ptr(node, slot, struct btrfs_inode_item);
>   	isize = btrfs_inode_size(node, ii);
>   	nbytes = btrfs_inode_nbytes(node, ii);
> @@ -5209,6 +5191,28 @@ static int check_btrfs_root(struct btrfs_root *root, int check_all)
>   			}
>   		}
>   	}
> +
> +	/* Make sure orphan subvolume tree has proper orphan item for it */
> +	if (btrfs_root_refs(root_item) == 0 &&
> +	    is_fstree(root->root_key.objectid)) {
> +		bool is_orphan;
> +		is_orphan = btrfs_has_orphan_item(root->fs_info->tree_root,
> +						  root->root_key.objectid);
> +
> +		if (!is_orphan) {
> +			error("orphan root %llu doesn't have orphan item",
> +			      root->root_key.objectid);
> +			if (repair) {
> +				ret = repair_root_orphan_item(root->fs_info,
> +						root->root_key.objectid);
> +				if (!ret)
> +					is_orphan = true;
> +			}
> +			if (!is_orphan)
> +				err |= ORPHAN_ITEM;
> +		}
> +	}
> +
>   	if (btrfs_root_refs(root_item) > 0 ||
>   	    btrfs_disk_key_objectid(&root_item->drop_progress) == 0) {
>   		path.nodes[level] = root->node;
> 

