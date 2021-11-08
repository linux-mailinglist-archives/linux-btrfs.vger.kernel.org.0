Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534C0447D9B
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 11:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbhKHKRf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 05:17:35 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33642 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238774AbhKHKQk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Nov 2021 05:16:40 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A8A9EBV005915;
        Mon, 8 Nov 2021 10:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=G8cw4QVctYXi2iJTxc3u0HAKEoMQKgRl7PPT8G6rPMs=;
 b=CaxHEooRaMTY2VhkUgMGh5X/MgOnlA+NGiwFA6hT95hqD6mr/rw8GZP65jFYhDhafa0F
 NkSaAoUDCfvTyQRlcvlx9qRj8appxqe+1RWUWNVqngc1GDQIeBNRITxdlVYw6iPYrEWb
 GWiYPZ/v7TXUDGZc3qrxgiImhK6Z3+pMMKtySRmBctTIc9ZK+V15L8f3BB1jz3A44/Wc
 xb12fFdWI671VF10wqjyKH9vTBvuhW9A/o50SCsbjUpAp7pGxd58jriJBvtPJN1rTqP3
 xF2wGD/2IcV5uo8/UTDU0OW5DAMMsfvoLPsQ96czdjM1LGTvYeubUb2/hUdviGpRgjFo uw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c6uh49uwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Nov 2021 10:13:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A8A7JDr011907;
        Mon, 8 Nov 2021 10:13:28 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by userp3030.oracle.com with ESMTP id 3c5ettr9s9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Nov 2021 10:13:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5/asp/9qpaPAYseuj+iF8bPhZEB96akOl3A07H2TPVqp943Zm1nbiPBuR4fsRF2A2kkMMRliSDjCbZz96Sk0Mcc/2gz21J/v4nicpnOZWs5sZ/FmBLF2UJMDcClZfaD8+62MZ1lSfix8ySR0YK6IgBmuxiEDqGLS7huIKA+1P9R3YLUU4LOdRKnoca1sfeWV/tohcpxTikKXr8ue2jWz7x6KQtLSl++NE8HVZTE+vzBzKM/mlEu0LtgrtLPjdjG9Ds9UN2nGUUpObA6n8Fbh/rkrWYTzUHm8G8IawKzzuSlUgFKweyFaU4Uwo5e+7y+vQ5q9mqDj4Rd9f/fhXKgyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8cw4QVctYXi2iJTxc3u0HAKEoMQKgRl7PPT8G6rPMs=;
 b=HkAHe2FyvA3Rw+Kvf2QPIm1O6rDcvbW2BLrppelecVybMiZsqcEswfIco6ZS7AP7bTwXRInOOgAXdioGTTyWReD5K8dACWuhAKNyUWEGmcoHVGSKXLl0ez6Ebx9HqRHI8ZZhrp95OEMAN9xXBxfKu1KC6WuhF/KyLOxMoeT+R/GLKBB8tVsDJBCnf0u1RAq8/QX5kRtYjC3TZ9ZWOxnMLBvkYBWi1W3c3u3W1WmGRDuCUVwpLcRWQ9tJ46rJgqphYCW3++i17c3I+9HRvwbTYnQDSnnzfIXd1ETrotbWeBUDp2VrZBq4EGYi26o/8y+U7dXvqt39A/gWNK22T6QCoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8cw4QVctYXi2iJTxc3u0HAKEoMQKgRl7PPT8G6rPMs=;
 b=SpSincdYQwAnlaY2lHBgxcLOBnQDgXe5EP9DkSyWncMKngqQVYd4gKmsAD1ipTLnxOqVBAWP3Qj0Yr2XG9vd03RCe+hECFRwRFqjrF80tOj0PvyvmmfLqJJnvBlyBqQo9pTEdT6YJBvZT9u8KsSDr+oZmLdo86g139rMWFoBw14=
Authentication-Results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5187.namprd10.prod.outlook.com (2603:10b6:208:334::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Mon, 8 Nov
 2021 10:13:26 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038%5]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 10:13:26 +0000
Message-ID: <5131b7a7-ce08-7503-c6be-ee8570f4a254@oracle.com>
Date:   Mon, 8 Nov 2021 18:13:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 01/20] btrfs-progs: simplify btrfs_make_block_group
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1636143924.git.josef@toxicpanda.com>
 <c34d973b32d46595546ac9f7b80984a0fb21f74c.1636143924.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <c34d973b32d46595546ac9f7b80984a0fb21f74c.1636143924.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SI2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.0 via Frontend Transport; Mon, 8 Nov 2021 10:13:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c529b99a-ffe9-405b-87a9-08d9a2a06733
X-MS-TrafficTypeDiagnostic: BLAPR10MB5187:
X-Microsoft-Antispam-PRVS: <BLAPR10MB51876D5485A441718AD6F60EE5919@BLAPR10MB5187.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iEj6ZoTJdg92MejzlBN6FljT/smyZZAbPHJAIepNNPot3qAG9K3SurY4bbM/yaBSIPVTMrQF0HYhfbYM7To33f2ztNt+hnzEJrMxb5irzTJ0B3axDjd7ELcZXOg/zmm+5QB5BXVdz+uXlVbfQv1GE8DzG7SvmVXUtFFaq3BRlYSd+7ujouSDugU2f2DJcBY32XKmbE+8FpqODKZFBNJUSxmyTRjOET9t/Aw6/qXQ67KL13XlRsAN3wR6NzEqc2kg7BWhwai8QQmEbW26CSCQf6FSryxDaJBXzq1AjlAnitJN2iiXqBdlctvvDFVFD3JdM5CDDFT4hUBsd+YuCICvJUMHD/XJXYjQzexE1KBBMZKsCqgH79nUhVWOAWAzS8MHZNlryDfGktLGr9usg73XB1kLBQFH3a9PyTSzv9Pg19b7kmsnqPsI3mHoYehh8iYrpF5+JDxfhy3QlAkSTGjzII81+vTVd3R8t8Xnsw7ynquP5sOgkjYsJdAd+fuiOFIse5FpZ8kuwecG0oTE1YUBtF3qwuS2Ei3KvWuro74/8reDK66ieQ/XWxTIPyW6unKl6vFiPJmURnvMtiUUWkCc51/6K1BJMYPznzsZd+w3AyzEC+J1SfMpO80X0hJHG/TGGdAa54QDaGr3rXdy7TXCizz8KUegEwqAn/BgKVmX4FDfPepXk3pbW884/zEEnGTaPTOo/z6w6j4E+kyKH6ktArxvcmiRqRdYIrFpdB9HhR0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(6486002)(26005)(66556008)(2616005)(38100700002)(83380400001)(6666004)(956004)(508600001)(186003)(316002)(31696002)(16576012)(2906002)(66476007)(66946007)(86362001)(36756003)(8936002)(44832011)(31686004)(5660300002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFZ2UkU3M1ltNE1LVVF2Z1hwQVhKOWlncFN2azU1Ky8wTVlqN2s1aDJ1YjZT?=
 =?utf-8?B?M0w0MzVXTnBJZEk3ZmxYVUpaRGZaa3hwVUVEV3pVa2tzRzBDNTVEbXN0Y3Fl?=
 =?utf-8?B?RllFL01jSXorekkxOVlIOFdabHE5Y3RIV25WeVhtOFRJaU1LamF4YUdiRXNY?=
 =?utf-8?B?REhKZ2oxNGFaV096RlNCQTRTMC91VndrYlNCUVV4VURSMC96N0ZIckV5WGJI?=
 =?utf-8?B?MTJ5Q2VmQXMrbW90K050QXd3SURPbWlZYkl0bWswQmpuUUFzZkNQVzZDc1I2?=
 =?utf-8?B?WUQzb2lQUDgwY3Jaa2NmVXZWb29HbGNtdTcvcFdCTGxHc3BZRmZhdk5PeStj?=
 =?utf-8?B?VXdZVStMSkxPL2wweGdCd2JXbHJsdXFpQTFxQ3RHK3B6ZENSQTVRN0FOTlJO?=
 =?utf-8?B?bXV4ZFRFeUZYZVdneXJ2ZTNsVCtRRnVqdXpoVmliaGR4QVRSTjhweWd1cCtx?=
 =?utf-8?B?RTdnNDR2NSs4R2FkSzFMdHJtSmpDYlR0UTJLTU9yK255cW1UQnV5STIvcGJW?=
 =?utf-8?B?ZGZ5UG9yUWxKbURHNmFvMmZ6bDB4MzJVWWsyZWZrZmRJWXU0ZDcrTEFpRGNG?=
 =?utf-8?B?b2xmWDNGQ29ycU9uUThkdm1zUG9kZ0srcWt3VVo0UkFmcHZLMmZoSGF2S3Ru?=
 =?utf-8?B?ZVpGSG1GSktVNXVpbENYMWNucjA1R1FZRnRBWDlGMFBZTy9TTmluK3F4Ulgv?=
 =?utf-8?B?enVwczh1SDlTOWxyeSsxTVlPVFdiQ3NvbUcxN0ZHdHdsejQyZDFXckVuT0FX?=
 =?utf-8?B?bzc0QXpBc2ptbEo4clMyK2dGUm93VkRLS2RsNWFhNFRwNjdpaDJRYUpZOHRs?=
 =?utf-8?B?QWM0M0RiSHJmWmF0QlViU3pLT1h4S3MzMkwvYTVrVkNkM0dCa1k4VzJ4Nnk3?=
 =?utf-8?B?SEFDYmRROXlxKy9TVlVDaVBsZGd1UUpwY0FQejFmR082NmFlNWJySk14bmkx?=
 =?utf-8?B?SFh4bE1iUTgyTGlCRGlCUGVrMk1rd1BwS3R1Yk56TktLS21iWEtWTVRBMFV5?=
 =?utf-8?B?WHdqYnNyemVmSmFrN3FtTFFkYnVnd2dqSUdtR2RUVXhDak9iMGpkRlh3eDBh?=
 =?utf-8?B?ZnU2U0RxdjlOdjUzd0t5SEREbjE1SEtKYmJmN2xiS3hxeGRTazdIMzRjYm1i?=
 =?utf-8?B?dzBXVmtwaXMxRkNLU1Aydm43Qk9SOTFXS2l2QVRZVVBnYmE3U1ltRVJpeks4?=
 =?utf-8?B?NWxJcFVEU1F3Mk5nU3UxMW5sSVlUSW1UZGc2ZkoyeEdoNHhyNVI0R2s5N3lp?=
 =?utf-8?B?M0dNZTB0VGJqK3hwRTYwbVF1WURVMExwU3I4cU52YXRUOXJOWVJFSHFXNUlu?=
 =?utf-8?B?Q2taeEJERTJYYzk4VDlzSnFYdHRZNDVwS3haWnkyU09FZ2VtUFo5QjRzUlAy?=
 =?utf-8?B?L3graldhUTk2TFFHaTU4bW1vbkJ3cmpkYlF4NTVnL244bDYrL1lzWlpjdkZY?=
 =?utf-8?B?NFlTclhGVjd2OTVMNUVYQzFoMkduT2pTa3FkTG5TeTgrTkIxaGpkRkhHRWNp?=
 =?utf-8?B?TzhXVFRvQ3JlWExqWE11ZEZiYnh5b0IwQXZudHBIdXhxZ2xkQjZKVHh1cVhU?=
 =?utf-8?B?YTRjTTJGaXBFd1Q3MFRVSlppRXZPVHM2dmtCdGdpbm8xKzBLemFCd1VPVG1C?=
 =?utf-8?B?dVo4cDU5a1NCc0lYYkRlU04vcWduNVEyOGtTc2tYb2VzTCtlOVlzZlRHbjFZ?=
 =?utf-8?B?VThvT1JrRVJPcnhyb0Vsa2ErZjV0R21zYzRjRVlJU29kQ1oxQVNJcjB6czhl?=
 =?utf-8?B?eWRTVGRnNDYvQTJJNGxab3FxMVVSV1I0R2tXamYyRDkrUzBGOUhQQytSRnRs?=
 =?utf-8?B?S21PdnVTaGp4dTRFd0VqQzJWNVdsZmxNQi82WDBoYlNPVTVpdmFMOGNUbUZw?=
 =?utf-8?B?UVpPWmxyVGkydkxaNHFzUFloOHZsN1UxZHROa2JQM0JySFJ2RXFaeml4MTZF?=
 =?utf-8?B?MFR0eU5jejFiMGdxa0kzdCtQWDJ0NElGeHhPcjhHTnVoWWNIbXB0VEtFV0xa?=
 =?utf-8?B?Tjcvb0hRNVBRWnlxSENIRFQ2bFQ3aVpXcUZzaVV3OVFaSW5qNXZmQlNZVTZ4?=
 =?utf-8?B?dEdqZUk3T0NaMFRjZnMraDNKUThCQVVXbUlmSnFRbXpsQVkyM28vSlZ4Y29p?=
 =?utf-8?B?NlFkcGZuak1BOHdnQ21taHlMakY3UHpyRmlkazMwYlJKQjg1OXVKcXFnZUtP?=
 =?utf-8?Q?4leHxe2FyVAex8qsIveQEYM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c529b99a-ffe9-405b-87a9-08d9a2a06733
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 10:13:26.3515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/Ox/KwK9YR7CVXrf8v0Z9+CRl0qObVj9xawnAUyYq/6QmdyMo9qmBzs5t6Lz25gnIovRhyWjFDhtQ1R1jz3ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5187
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10161 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111080065
X-Proofpoint-ORIG-GUID: FYSs1NG43fhEHzjZM4REUn46LaJ0PSau
X-Proofpoint-GUID: FYSs1NG43fhEHzjZM4REUn46LaJ0PSau
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06/11/2021 04:28, Josef Bacik wrote:
> This is doing the same work as insert_block_group_item, rework it to
> call the helper instead.
> 

looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   kernel-shared/extent-tree.c | 43 ++++++++++++++-----------------------
>   1 file changed, 16 insertions(+), 27 deletions(-)
> 
> diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
> index 8e0614e0..a918e5aa 100644
> --- a/kernel-shared/extent-tree.c
> +++ b/kernel-shared/extent-tree.c
> @@ -2791,33 +2791,6 @@ btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_used, u64 type,
>   	return cache;
>   }
>   
> -int btrfs_make_block_group(struct btrfs_trans_handle *trans,
> -			   struct btrfs_fs_info *fs_info, u64 bytes_used,
> -			   u64 type, u64 chunk_offset, u64 size)
> -{
> -	int ret;
> -	struct btrfs_root *extent_root = fs_info->extent_root;
> -	struct btrfs_block_group *cache;
> -	struct btrfs_block_group_item bgi;
> -	struct btrfs_key key;
> -
> -	cache = btrfs_add_block_group(fs_info, bytes_used, type, chunk_offset,
> -				      size);
> -	btrfs_set_stack_block_group_used(&bgi, cache->used);
> -	btrfs_set_stack_block_group_flags(&bgi, cache->flags);
> -	btrfs_set_stack_block_group_chunk_objectid(&bgi,
> -			BTRFS_FIRST_CHUNK_TREE_OBJECTID);
> -	key.objectid = cache->start;
> -	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
> -	key.offset = cache->length;
> -	ret = btrfs_insert_item(trans, extent_root, &key, &bgi, sizeof(bgi));
> -	BUG_ON(ret);
> -
> -	add_block_group_free_space(trans, cache);
> -
> -	return 0;
> -}
> -
>   static int insert_block_group_item(struct btrfs_trans_handle *trans,
>   				   struct btrfs_block_group *block_group)
>   {
> @@ -2838,6 +2811,22 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
>   	return btrfs_insert_item(trans, root, &key, &bgi, sizeof(bgi));
>   }
>   
> +int btrfs_make_block_group(struct btrfs_trans_handle *trans,
> +			   struct btrfs_fs_info *fs_info, u64 bytes_used,
> +			   u64 type, u64 chunk_offset, u64 size)
> +{
> +	struct btrfs_block_group *cache;
> +	int ret;
> +
> +	cache = btrfs_add_block_group(fs_info, bytes_used, type, chunk_offset,
> +				      size);
> +	ret = insert_block_group_item(trans, cache);
> +	if (ret)
> +		return ret;
> +	add_block_group_free_space(trans, cache);
> +	return 0;
> +}
> +
>   /*
>    * This is for converter use only.
>    *
> 

