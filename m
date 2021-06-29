Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8EF3B7001
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jun 2021 11:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbhF2JVO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Jun 2021 05:21:14 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:6744 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232568AbhF2JVN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Jun 2021 05:21:13 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15T9CEsR015150;
        Tue, 29 Jun 2021 09:18:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=HZInwS0IBnUvCP1omAwhtnWxWlumm7BmEp+g8IfS9ks=;
 b=Jdh4gXvjy+EorsIXiymVh3TJ+p+oe4+drq0z9RiULrbh5GxryxUdsRwt61l9mtK2sjPk
 z6OvaEMusyYdCU5GpoGsne492oe4Wn6pWT4bIgz3/WhtTz79Jr4+mgucmz0YHveUP8UU
 nUYiuYj4q5gg1yFCdEi4dfcHPY5LhWu1DXl0UZTVsJuWH7RhBf7ij8gR/0RN24SwJ5zJ
 xMbZbrQF6/dih4tv/mNOkhwiGEFxB6CQ9CTuMKoCCKPZzecYUao4cBBFOe6WywM8KGZ9
 Zm+68yG564R7L2O5jkO2Aq27FlByfV5JYDALHKZNaXL8AsqNbBseZa6n6BfnX5mPhKPd 3g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39f7uu31dr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 09:18:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15T9Fpbw112802;
        Tue, 29 Jun 2021 09:18:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3020.oracle.com with ESMTP id 39dv2582kt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 09:18:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZ4bA/JMDlVykNgvWsiV9i7gD4T8+xXqqozFYepe4OUwNF+6Rc8JUBEjCWDEpagAwioEHZXOdCaMajmq0nGTrbx/gkC/06fMSHrdMsnfJnRfUEI21Gf6Sl4w0kkyY9+CJMzdXCEa7IUpOpoKoRofXtm7TLiCaHeA0cb1a6C+MpvrziCK1kiUvFrgIXAa+CJ0Nlx7Q1alwKnyqqIxc2HTOIttbvwrboiX7ec37t+bDqNlizudo6SXhCEwvTne+7E7vZ7zPchX27OcWi9CSTMB/Wyz9JkndLWr/gSX57u9f1Fn48cUvd2TteFnD3ousORCSmwEPr9N894o2uIWQuXUAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZInwS0IBnUvCP1omAwhtnWxWlumm7BmEp+g8IfS9ks=;
 b=NxIh6CqnrDLJ/YGce2C36KdzCjMwem/fUSPYWTrWVoET7Ml65lnZrRDwKqoIO0a5sBib5F+7nvph2HSvLpRZBje13y6foGQSzNl/PfTFDCND81LykzssjEcBVhLEOF0xnBVOi6lsJLXAINCezLAtut01Yf3vJUHal+xa9LqJzcxHmxWMIHRubRSdOE6MRg5PmGHQSHWZJU0onlXDiyOe6fL3OdhcZjfG9I+Atj6cTQR4VcNpmmRDaNg7agOg5MuFRZKjHnLlp9tDJqYIS8YjLipl92HRocv5UOCjRSW1WWzW9bvXirkI06Mr0IPgiMB4MmjY/wzmXyspp25Mbo9JBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZInwS0IBnUvCP1omAwhtnWxWlumm7BmEp+g8IfS9ks=;
 b=US8NROoS8v9LhhC+Rhy7rk2Mt+5srhEKIxvlpFjTj6/o8HR/NbKHjsGsCyA/ESJTI8gKY8hyoZ0foWF1SErVtrBXZsrdgXFCZG0xnDpBdn3mbA3YJMqPIKxzSu8EKe1u3/FjluBtNRu7ewL3C4EIMzzJLUtPhALrRE0FJzyG+O0=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4125.namprd10.prod.outlook.com (2603:10b6:208:1df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Tue, 29 Jun
 2021 09:18:40 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%3]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 09:18:39 +0000
Subject: Re: [PATCH v2] btrfs: zoned: remove fs_info->max_zone_append_size
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.cz>
References: <a7f717432896b5f12847435727838b32bd6e2b35.1624905177.git.johannes.thumshirn@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <7bcfee70-adb4-4d00-c090-42147010c837@oracle.com>
Date:   Tue, 29 Jun 2021 17:18:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <a7f717432896b5f12847435727838b32bd6e2b35.1624905177.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:54::19) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR02CA0055.apcprd02.prod.outlook.com (2603:1096:4:54::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend Transport; Tue, 29 Jun 2021 09:18:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e256c250-4229-46f5-215c-08d93adee1ea
X-MS-TrafficTypeDiagnostic: MN2PR10MB4125:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4125F85B3D4063BB42FF1250E5029@MN2PR10MB4125.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S7zXoCaa/94/TjPomPsQeJogd8w38n443YNmz9iIEtNLUl4Q8yxzPgcmxGvrRxtwI6aefXJR9Zy+DxrE417oNgK49x3igv5yvPaTkoCD5N67WN1yUXLYsRN1y+6RM/hV17nHXs1/AjVHTVUqVMYx/yeAlCOwD+eYgJiSiBrBb9z7P6IaCjT4/cSp9tgiFvWY6MemnsEIUg/lDMM6AQSgfTUwxJgoUifFhHauvyJ9bvSE0x0n0iVZwDEF1NzxHDgIxFtIxo1R0hg0Dw8cPlrs6ljZH+gYy1/cMN4xFIMzJPV1n+4AzR4TL5ttv6uYzep6qcfzw/7yBg0/mncorWYyz06xX3Kx8EzTT3wNiMdlv0eYbTPV7H+RyF00cAGeglyxv9LQYinmF+w4zWEAKtjBnp/K6PwzWtdvcjPIryfbOmBRBQ1MXXXq7BCFEa9Ph5YBuhiYYsBys68JrFo8Npe/+6YXX3vdFQx6Yq+jE8mYYsM3sXdYXef0y/6lSY4yaN2j9/0qDD6maxW6yzeOFDkXW/sOJZWO+UWHerUbZ6yYO+Le3L1ela8t8G1ENxSPqznHwgq1lRciPgVK2Yh4oB69jD+U6caE7SKMUnjRUzfJsGZ+gJAQUQX6Z9CZUSkKm8BwkWaWyXS5a+1IL8uZYTxlfSzpfNsshAI0m7BYPbsSzrf+cX5OZzohBmKW5VROCpRAD5fcY65BqRPGO8X4Q+yl/lE3mHYvEKTvtaCUXwwOViA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(396003)(136003)(39860400002)(66556008)(66476007)(6916009)(5660300002)(186003)(53546011)(36756003)(16526019)(2906002)(8676002)(38100700002)(54906003)(8936002)(66946007)(86362001)(26005)(16576012)(83380400001)(31696002)(478600001)(956004)(31686004)(4326008)(2616005)(44832011)(316002)(6486002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWk4Mlh1MTc4Z0tnQk5MTktJZmdXRzg5OGUzM2pub1BPazU3Q0xKRVZZM1Y5?=
 =?utf-8?B?ZitWVE5JcmMzenkrVlVBUGZ3cUFycXhJMmJTd2owdUdlKzlJcTREbEUrSmtu?=
 =?utf-8?B?NU9ob0pONEdLVW85QVFMbU5iWXdscWFTRDQwVzJ2NytGOFloRVNxSUNTSnha?=
 =?utf-8?B?bm1RQnhIUnJjQjNReG13Q3JGSGtOYzFRdEJkS2E0TTV4cTZTWlZlbS9LMHpy?=
 =?utf-8?B?YkVsYXdHUmVoLzIwNW0yNWZ2RElxSEZwcERwTk1JWisrVmZXWThzdmJOVW9p?=
 =?utf-8?B?VDEzOURFbU9jL3V0RGgrTHNaV2xZVG5YOGVNVDRoOVVROVd6N215bWtZMkVF?=
 =?utf-8?B?SWJFZ3ZONFdFbzB3anY2SUx1SFRBNjB2dm0zUlBWb0s1OVgyQ3FoTmU1SlZj?=
 =?utf-8?B?M21BRnlCSDc3TTVYQjByRjZ4ZklIY01nYURhaHFjY2ZjMWdaQnZ4dmRpVHJm?=
 =?utf-8?B?VThBQm5PUWp4K3JwMHAycXpJQmt2OHU2VUZNTDcxMG0vTUJHQUQ0akZCb1BZ?=
 =?utf-8?B?b0RkQ3pPdlpsMFlZbUVwc1NXMTN3d2lFRThXSUxiNzdrc2tBTDR5MjBtMy8v?=
 =?utf-8?B?WCtMMmZSY3IwaElId0tMNFlUdGJwYTcraG1GYlJkVDY3dnN0UFd6TFVTQ04v?=
 =?utf-8?B?cml4aWkvOU04RHc5QjB3aXJRZDBTa01sbjZUTlptaThwZ2NFQzk5Sno5WkJw?=
 =?utf-8?B?RU9oMVFqUWJ6NHU0Sy9NNHZYQ3YvUlM4Vnk2M2pIVXRaRFJuN1JHWGxBVHVt?=
 =?utf-8?B?Y2JvMFhBdFp5dmd3TU1Kak1FcTkzTWVhQXdORkxTaEpQcWRRUEtxblNNVEdn?=
 =?utf-8?B?TkpjV0FraXJ5U2d5ek9Pd2xaMFhvLzJJaW45eDNVS0hTY05ETVAxUnp0M0NE?=
 =?utf-8?B?dUNBZThYZWVwa1JiY0lOdG1seTRjd0lFMEMvaUIzZVFDTjZFd3JNbWVEWWRx?=
 =?utf-8?B?VUhIcHkydm9ESEJ3Z1dHUVdUUEhSaHBvVW0zSnI4QUR2b1dMcUFxaWJRbWJa?=
 =?utf-8?B?K0htSm1oenRXUEdPMDRENHZTMlVQeHovd1ZOM0VEc3NxdkpqUTJuc0k5Sk4w?=
 =?utf-8?B?V28xaFZEbGowbktMdlV1NE1sTWc3bHEvZHJXdUgrclQrQ1ZkckxDL3luMklL?=
 =?utf-8?B?VUxIU0daNytIR0llK3pvVSt3ZVhSTUtTZU55RXE4b3h2OUNWU1U3REtnUkhT?=
 =?utf-8?B?VE5uNHJmblhnZWY2YzZJWWdGZjZQZlROeTYrVE00VVJwR3k2cTlYT3p0YVpw?=
 =?utf-8?B?alBaT1BvcjB5VGdiQWhXaE1TZ3hxWFoxM2VqN3gyVEVFVmM4SWtoakl5Nmxv?=
 =?utf-8?B?S0o5dlltUSsrT1JaUWV5RzVlb0k0NjBjQk9KVDNCaDlPamVyQXVjQ3ltTFJR?=
 =?utf-8?B?aVRZU0k5UWt3a1BzWXhmNnVyZWFvTDBWWjJVZ0NyRFEzeExqYWRvTXAwZzNL?=
 =?utf-8?B?bnJtdGM4L0xSYTh5aC9OeTFFNWxheEJNS1JzV3ZKeWg1OVZWYmZRNDVyS1Fi?=
 =?utf-8?B?QVYxbVBRMnAzMXZVTGEzdUhGVUQ2MUZ0ZmREOXN4ejZ5aDZ4dm9QWGtqT3Rj?=
 =?utf-8?B?QTdwTXdKVjlnK01ydndxTGUrRkpiSXViSHVnYWNVellyL2o0UGIwY3UxMjRs?=
 =?utf-8?B?aUJwUlBxN1hLNE5FQy9GOWo1MXR2bHlZbEM4aU00b01NbGozbE1hTG1ZN04v?=
 =?utf-8?B?SXNQT0ozYnY0aXAva1pvUDArTjNSWkFaZ0wrWnB5ODVhdll5SW9wOFRJRWw0?=
 =?utf-8?Q?2jqH4No58pVYh4k07Y2R74rDXvQ8fdCKM8eUhM3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e256c250-4229-46f5-215c-08d93adee1ea
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 09:18:39.8706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Ulq2zGyC+44vZM7lfQPePprcJ+oOgcW/mUXGwgFLt/0RfBJb/vsuIT0+ynAt35ggAFrpHlf7VdV5ZTKxi0nmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4125
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10029 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106290065
X-Proofpoint-ORIG-GUID: oTgaKPKhSx8sUecIksH-mObi-Hf2ZsUr
X-Proofpoint-GUID: oTgaKPKhSx8sUecIksH-mObi-Hf2ZsUr
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 29/06/2021 02:36, Johannes Thumshirn wrote:
> Remove fs_info->max_zone_append_size, it doesn't serve any purpose.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>


  I hope the reason to remove max_zone_append_size shall go into the 
commit log.
  With that,

  Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand


> 
> ---
> Changes to v1:
> - also remove the local max_zone_append_size variable in
>    btrfs_check_zoned_mode() (Anand)
> ---
>   fs/btrfs/ctree.h     |  2 --
>   fs/btrfs/extent_io.c |  1 -
>   fs/btrfs/zoned.c     | 10 ----------
>   3 files changed, 13 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index d7ef4d7d2c1a..7a9cf4d12157 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1014,8 +1014,6 @@ struct btrfs_fs_info {
>   		u64 zoned;
>   	};
>   
> -	/* Max size to emit ZONE_APPEND write command */
> -	u64 max_zone_append_size;
>   	struct mutex zoned_meta_io_lock;
>   	spinlock_t treelog_bg_lock;
>   	u64 treelog_bg;
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 9e81d25dea70..1f947e24091a 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3266,7 +3266,6 @@ static int calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
>   		return 0;
>   	}
>   
> -	ASSERT(fs_info->max_zone_append_size > 0);
>   	/* Ordered extent not yet created, so we're good */
>   	ordered = btrfs_lookup_ordered_extent(inode, logical);
>   	if (!ordered) {
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 297c0b1c0634..76754e441e20 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -529,7 +529,6 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
>   	u64 zoned_devices = 0;
>   	u64 nr_devices = 0;
>   	u64 zone_size = 0;
> -	u64 max_zone_append_size = 0;
>   	const bool incompat_zoned = btrfs_fs_incompat(fs_info, ZONED);
>   	int ret = 0;
>   
> @@ -565,11 +564,6 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
>   				ret = -EINVAL;
>   				goto out;
>   			}
> -			if (!max_zone_append_size ||
> -			    (zone_info->max_zone_append_size &&
> -			     zone_info->max_zone_append_size < max_zone_append_size))
> -				max_zone_append_size =
> -					zone_info->max_zone_append_size;
>   		}
>   		nr_devices++;
>   	}
> @@ -619,7 +613,6 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
>   	}
>   
>   	fs_info->zone_size = zone_size;
> -	fs_info->max_zone_append_size = max_zone_append_size;
>   	fs_info->fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_ZONED;
>   
>   	/*
> @@ -1318,9 +1311,6 @@ bool btrfs_use_zone_append(struct btrfs_inode *inode, u64 start)
>   	if (!btrfs_is_zoned(fs_info))
>   		return false;
>   
> -	if (!fs_info->max_zone_append_size)
> -		return false;
> -
>   	if (!is_data_inode(&inode->vfs_inode))
>   		return false;
>   
> 
