Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074B93AC1E0
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jun 2021 06:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbhFRETP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Jun 2021 00:19:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62960 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229475AbhFRETO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Jun 2021 00:19:14 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15I4G20e013148;
        Fri, 18 Jun 2021 04:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=BR1iA3IE4Pu2Z27sDkz7hLqNonawSOCRRWNlZpPP0ZI=;
 b=alQFSCoK3WT3d+f8xlcgqlDdHAC9NUAJiDuO5EDDFlU2zqEiexqV/ZKile/uqwZ5F/I6
 yLyptAC0wWwckfAnvZF/NRub4+ZRc42styv7ARtU5usmyrcbFR08speGG+mPvIevtolP
 WnGaQu+GZmD8+G5H9LhXwRS+M/FfvBE1k3DKZ4oXw56rQ+hKkwlWichLMBQX6asfg1tj
 8J5otRLy6Mh2yRpDGlAkcKhA7Nfo+PHHI6yLFwljMda9q3W1HF7o13oAVay9v/pRkhj+
 Y5+j48CQhiTS90UPVQCt5OVvTQc1x1SMwZ0rCvkz0f/2rXFI83w+60lESTIo4Hcg+vAj Bg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 397jnqudd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 04:17:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15I4Aw3L042935;
        Fri, 18 Jun 2021 04:17:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by userp3030.oracle.com with ESMTP id 396waqywea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 04:17:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKaorkcaAtSpBMJJm+2QS4yMOvpLK3GVIu0rHnWtitnCG4Aa2/Hs1MFgSC3SQqxEDBJKFhXRnZtiH7ZEHeGr6rj38dXazuS/yr8G2w0cPmcaf5cRnsI8qEeYLgYSOpIZSYsKtBrMlupJ/4MYfbVOA81KoS/SRSv6tXKcWAbEU0GErmYj3Rm8cTxRnPPPBVj9sCk5Sx6rrtsjA80VmUgWL1rM3KnzvOmmJScgQT8OEUy02BpT0LQVrDICxyz3lfIqJAiYJTzSxNM6YY7aP487HbcfIwTw7EftXUPkpgVuKl2lVRneqj0gaYzy/HDARjhG0eWLsM+KUBBr9SgUUAz1Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BR1iA3IE4Pu2Z27sDkz7hLqNonawSOCRRWNlZpPP0ZI=;
 b=Uk5hDdTRVKG4g3awljVbJTJZXnOAdsVX04wOBqo1AOWR8GQPtFBTIi2taQmgyTtRcP0B6/TwM7OgSJBAbDM5UhOWxI4PAFXH/U7R8B0O8RcBesvAFO4QEJJtWButanwcM8LxdF9LP5+3ruMtRcRgtqoIT3PgP+mnFnw11gfE3T5sWfhgcu1f6vzMdC376dKXDZDXj5DyEgZBbuULUikbGae9ESo9CF6vk5RGlTc4FnD+pWAzgazo1O9QJxnky5RFXBwFI2rk1c9puEBtSEl19Y6phlVlzoZi/ZR+WjofvNuE5z5ZD/JQ/7sdMAuIlEHO3bBXLDO7VyE8EjTJes9pgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BR1iA3IE4Pu2Z27sDkz7hLqNonawSOCRRWNlZpPP0ZI=;
 b=b/he0IKYVkdRKGsgoS9vkC1csBnZyFZcg0XMmtm8l5UYK+Czol8X8Td7uprD2uGlKse8GreitudifnZe1EKlBPT9JMRjLflXmkM3rGbt1imtdtJdAybpNWBjYBADcaFCYeJn9vXwdtWCmjur11p1ayiAqcDW3id6Ky2TqAE9sE4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5172.namprd10.prod.outlook.com (2603:10b6:208:30f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Fri, 18 Jun
 2021 04:16:56 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%8]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 04:16:56 +0000
Subject: Re: [PATCH v4 2/9] btrfs: introduce compressed_bio::pending_sectors
 to trace compressed bio more elegantly
To:     Qu Wenruo <wqu@suse.com>
References: <20210617051450.206704-1-wqu@suse.com>
 <20210617051450.206704-3-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <ed1c6ef3-e7ac-e1f7-d617-5bae3c85257a@oracle.com>
Date:   Fri, 18 Jun 2021 12:16:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210617051450.206704-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR01CA0107.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::33) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR01CA0107.apcprd01.prod.exchangelabs.com (2603:1096:3:15::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Fri, 18 Jun 2021 04:16:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cfd31a2-9ff9-4b09-e97e-08d9320fe905
X-MS-TrafficTypeDiagnostic: BLAPR10MB5172:
X-Microsoft-Antispam-PRVS: <BLAPR10MB5172124644AD9E13FCE1A3B5E50D9@BLAPR10MB5172.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n/rLV99/muwnij4Xo0JjiyZOzZVd+i5SbxHo2YEJfMtjI7WguX+p+XptkY1oWVJ4HdTTmqkgS+MIbT4tVteaXSWwPLCAR2A/qGvidQWhKDUG+q0ML8e1MzBfw9O7+YTr7+Ltwy3GDy0FIXskFXjXZOVxTr0c+8JSQIC+Dw7wbxNv5X00uzZYOumJMfE0vcTQTrNKJ30ZF3bSDRu48N00Hoc8nbp44Kuwj7jFWhUSl5+AbJ+fomLfpgPSAlT4f8iw/UoMsWF0y+jR1hk1ur0AKZwePus9l7fiQF6Cy8TyorlP9oyf2LXdCf72J/X5TB1mKDeop9/RXNhUcz2wMnfXPWsNI+69g6CyFctnqG+1vNhfMYEYgY2Q4pBSFzUvz0mZpvvxWsR6iIAGbbnOnwUpYX7MGhxt5Zn4blcrO8M95YWG2HHtYvFiF2ogXkCQg7MMxs18VNHeQiMbDqOtyBRKT5uX4Ws7Chjk/I9XnMY2qd5lk9BO4jYlkECv9jG6znXK3Z0IaMWsCJQmRq63oEmL4kocTg/n2b2zZOTlQedlcn/r/erNyBF5rkh+WwDJMf7D+0DbEOmIM6paxYSgeXg97t/WQTPwKzs/6Yhv1NaazgDTP44jZOHorU0Uhybdh2czA6i6e5OKdO4FPhqB5t6osw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(39860400002)(366004)(16526019)(186003)(44832011)(6916009)(66946007)(6666004)(66556008)(26005)(478600001)(2616005)(66476007)(956004)(8936002)(31696002)(53546011)(316002)(5660300002)(86362001)(83380400001)(6486002)(36756003)(8676002)(4326008)(38100700002)(31686004)(2906002)(16576012)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmRHeVI5TXNUSEhrSjNIVFVCQmNLY240SFZ3VjZrbVlXWnFxeVlQM0xtNWZw?=
 =?utf-8?B?bWU3ODhPMXZOLzc2T2pIMCtndWt1VmUzOHJFNzEvRWtmRjUzMldscDVkc0Rs?=
 =?utf-8?B?bEJlK3IvYkZUa00zR2txa1kwNFNMMm5qYXZmcHFmK0xYUmMxZDd2R1RaYWhB?=
 =?utf-8?B?T2Zuc0laS3RTa1ZITGNWYTJXRHBqYS8rRUs0MWR2Y2x0dFFnUVdnQmtibEdo?=
 =?utf-8?B?MlhkWGJyWTRmVTlXTkV5U3JlL3NFekhGNlZCaXFzYnc2R1NJcE5oUHlJVit4?=
 =?utf-8?B?YTZaaTk5K3AwQ1hnQjB4U0RiSlBEVVJIeTd4SGp3bmxWcFdlOTdNdDZXV0tr?=
 =?utf-8?B?N09WcmI5VWJLMnN0ZUo2RHdqZkxZcHo4WXpmU2lZMktOYllKWGNYQ29LNjhE?=
 =?utf-8?B?TGlYMHFQQlBkWS85aG40TGV3aG1OaG9WZHN2VHYyU1RnSUxmNFJUclJPWTRD?=
 =?utf-8?B?SDhIMTQ4dkdMZit6YmQrQUdFeWVEZXBYVTJkRjJQMS9Ia2hEMi9zK0NUMjJX?=
 =?utf-8?B?bW9WSDdCam1UUGNncUsxb25oeHl3VytzaTNvLzRlR2xIRVhtdkFGN1M4ZTRO?=
 =?utf-8?B?SEwyYTJydGYreUh4Z3ByakZoeDJuaGZ1dmtvQmxZZDFjemVVYWpjMnZoMFI1?=
 =?utf-8?B?NjVwanpGY2lKRnNKL0dsc0hJU0twamlvS2k0di9qY2RyUERaeTdQdFlJeXFt?=
 =?utf-8?B?b0U3VjlyN29QWk1PV3JEYzdQTXAxZTJMMVFHSU05NytWYnBudEtmWmQ0YTVX?=
 =?utf-8?B?YzJjWFgzWGtkblhqdDJMdVpSV0F0OXBDK0hZTmZTeFhLYjlvR08rSFBETUhR?=
 =?utf-8?B?azMyNHVxdXRRVE9HY1lrN0p0N2NpZDAwYkNCdE11VzFldng3S0d1N0xvUlhL?=
 =?utf-8?B?ZHZnS0oyMjBWKzFFUkRKVFBTNUVuU3lSZ0c3Y2tBdzQrMFphejdwaTdsSmhk?=
 =?utf-8?B?R2VvQXlBMU0ra1ljZjhvUFVnTWgyTjZDamJTdjZITmRlQnk5UjYzRkFTUUZO?=
 =?utf-8?B?UEpKT2FoMEY4THpwSlZ2NHdldmpIRnZsZFh1ZVRpMWM4MHBjOWFTT2lhMmhM?=
 =?utf-8?B?Y0VoZnIzUnlCclNJQzNnVTdOSUR2THVWSmEwUFBscUYxbUNmOHI4SW9TeTBX?=
 =?utf-8?B?dnVqWDJIUENsZnhDODcxaktQUGJhTGZpSkRIS3loRitpWEgvcmZnVGtQOC93?=
 =?utf-8?B?Mmp6U0VYUGxIa2x2OXVrYjZGa3duNW5wZ1l3V250ODdDMVdpQk53dWtDN01x?=
 =?utf-8?B?Um5lSEV1TTNjeTU2OHNCai9uT2E5WUlUa2pNZ1BRaG43S2V2S2Z3ZlV0Ymhv?=
 =?utf-8?B?eG5ZRi9KNHRYTTdLMTVsSTFSaW9OWkprZWtrZGxaVTBzcWFVZU51cFZPTzZh?=
 =?utf-8?B?ZG1VL3d2QjJ3U2o0bXVPYVM3Tzl6RHJIQnFMT1VrOEwweGU3eXBWYW83Wk9Z?=
 =?utf-8?B?dnRoaWoyaVZ5Ni81OUNLZlk1U3hEc2IwNTlZNTZrSHNLUUNLSWVDSVA3d0Vr?=
 =?utf-8?B?eVJKU0dyejNWT3U1aGQzTUJDNnlwVUlwZTRreXRoTkY4MGFodEp3VTM4TjNn?=
 =?utf-8?B?Zk96VDRoY3hXaVdpTXM2UTBmSFZxQkcycDlHazI1N3NRbzUxemNQcWtDdkdp?=
 =?utf-8?B?WmhVMndHd1Fvc29Tang0d2dUUnVIUTBCaXZMdWVzMEdkeWxIaEozS08vSVJ3?=
 =?utf-8?B?YkV2eTNIS3gyOUIvamVFcnl1L2JjZ0V3MmVlcnhDZGduZzVnYk96bERsZE5K?=
 =?utf-8?Q?Xn76wc5Jv8rMtCbqxhaJBY+p1uME0h14IYwDKcz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cfd31a2-9ff9-4b09-e97e-08d9320fe905
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 04:16:56.6476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7k5KmwWEpQ56t1J7bc4cysV/QCy/FiYXawpT9S6pNES7pO0q177xbZ58+d5JgX54lSgqQl+6U9k1VC9D3jhZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5172
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10018 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106180022
X-Proofpoint-GUID: msJk9TDgbpfRbRn3z5OD-g-z8Rt9fzUg
X-Proofpoint-ORIG-GUID: msJk9TDgbpfRbRn3z5OD-g-z8Rt9fzUg
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/06/2021 13:14, Qu Wenruo wrote:
> For btrfs_submit_compressed_read() and btrfs_submit_compressed_write(),
> we have a pretty weird dance around compressed_bio::pending_bios:
> 
>    btrfs_submit_compressed_read/write()
>    {
> 	cb = kmalloc()
> 	refcount_set(&cb->pending_bios, 0);
> 	bio = btrfs_alloc_bio();
> 
> 	/* NOTE here, we haven't yet submitted any bio */
> 	refcount_set(&cb->pending_bios, 1);
> 
> 	for (pg_index = 0; pg_index < cb->nr_pages; pg_index++) {
> 		if (submit) {
> 			/* Here we submit bio, but we always have one
> 			 * extra pending_bios */
> 			refcount_inc(&cb->pending_bios);
> 			ret = btrfs_map_bio();
> 		}
> 	}
> 
> 	/* Submit the last bio */
> 	ret = btrfs_map_bio();
>    }
> 
> There are two reasons why we do this:
> 
> - compressed_bio::pending_bios is a refcount
>    Thus if it's reduced to 0, it can not be increased again.
> 
> - To ensure the compressed_bio is not freed by some submitted bios
>    If the submitted bio is finished before the next bio submitted,
>    we can free the compressed_bio completely.
> 
> But the above code is sometimes confusing, and we can do it better by
> just introduce a new member, compressed_bio::pending_sectors.
> 
> Now we use compressed_bio::pending_sectors to indicate whether we have any
> pending sectors under IO or not yet submitted.
> 
> If pending_sectors == 0, we're definitely the last bio of compressed_bio, and
> is OK to release the compressed bio.
> 
> Now the workflow looks like this:
> 
>    btrfs_submit_compressed_read/write()
>    {
> 	cb = kmalloc()
> 	atomic_set(&cb->pending_bios, 0);
> 	refcount_set(&cb->pending_sectors,
> 		     compressed_len >> sectorsize_bits);
> 	bio = btrfs_alloc_bio();
> 
> 	for (pg_index = 0; pg_index < cb->nr_pages; pg_index++) {
> 		if (submit) {
> 			refcount_inc(&cb->pending_bios);
> 			ret = btrfs_map_bio();
> 		}
> 	}
> 
> 	/* Submit the last bio */
> 	refcount_inc(&cb->pending_bios);
> 	ret = btrfs_map_bio();
>    }
> 
> For now we still need pending_bios for later error handling, but will
> remove pending_bios eventually after properly handling the errors.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/compression.c | 78 ++++++++++++++++++++++++------------------
>   fs/btrfs/compression.h |  5 ++-
>   2 files changed, 49 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 9a023ae0f98b..b84b9f7420c2 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -193,6 +193,39 @@ static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
>   	return 0;
>   }
>   
> +/*
> + * Reduce bio and io accounting for a compressed_bio with its coresponding bio.
> + *
> + * Return true if there is no pending bio nor io.
> + * Return false otherwise.
> + */
> +static bool dec_and_test_compressed_bio(struct compressed_bio *cb,
> +					struct bio *bio)
> +{
> +	struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
> +	unsigned int bi_size = 0;
> +	bool last_io = false;
> +	struct bio_vec *bvec;
> +	struct bvec_iter_all iter_all;
> +
> +	/*
> +	 * At endio time, bi_iter.bi_size doesn't represent the real bio size.
> +	 * Thus here we have to iterate through all segments to grab correct
> +	 * bio size.
> +	 */
> +	bio_for_each_segment_all(bvec, bio, iter_all)
> +		bi_size += bvec->bv_len;
> +
> +	if (bio->bi_status)
> +		cb->errors = 1;
> +
> +	ASSERT(bi_size && bi_size <= cb->compressed_len);
> +	last_io = refcount_sub_and_test(bi_size >> fs_info->sectorsize_bits,
> +					&cb->pending_sectors);
> +	atomic_dec(&cb->pending_bios);
> +	return last_io;
> +}
> +
>   /* when we finish reading compressed pages from the disk, we
>    * decompress them and then run the bio end_io routines on the
>    * decompressed pages (in the inode address space).
> @@ -212,13 +245,7 @@ static void end_compressed_bio_read(struct bio *bio)
>   	unsigned int mirror = btrfs_io_bio(bio)->mirror_num;
>   	int ret = 0;
>   
> -	if (bio->bi_status)
> -		cb->errors = 1;
> -
> -	/* if there are more bios still pending for this compressed
> -	 * extent, just exit
> -	 */
> -	if (!refcount_dec_and_test(&cb->pending_bios))
> +	if (!dec_and_test_compressed_bio(cb, bio))
>   		goto out;
>   
>   	/*
> @@ -336,13 +363,7 @@ static void end_compressed_bio_write(struct bio *bio)
>   	struct page *page;
>   	unsigned int index;
>   
> -	if (bio->bi_status)
> -		cb->errors = 1;
> -
> -	/* if there are more bios still pending for this compressed
> -	 * extent, just exit
> -	 */
> -	if (!refcount_dec_and_test(&cb->pending_bios))
> +	if (!dec_and_test_compressed_bio(cb, bio))
>   		goto out;
>   
>   	/* ok, we're the last bio for this extent, step one is to
> @@ -408,7 +429,9 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>   	cb = kmalloc(compressed_bio_size(fs_info, compressed_len), GFP_NOFS);
>   	if (!cb)
>   		return BLK_STS_RESOURCE;
> -	refcount_set(&cb->pending_bios, 0);
> +	atomic_set(&cb->pending_bios, 0);
> +	refcount_set(&cb->pending_sectors,
> +		     compressed_len >> fs_info->sectorsize_bits);
>   	cb->errors = 0;
>   	cb->inode = &inode->vfs_inode;
>   	cb->start = start;
> @@ -441,7 +464,6 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>   		bio->bi_opf |= REQ_CGROUP_PUNT;
>   		kthread_associate_blkcg(blkcg_css);
>   	}
> -	refcount_set(&cb->pending_bios, 1);
>   
>   	/* create and submit bios for the compressed pages */
>   	bytes_left = compressed_len;
> @@ -469,13 +491,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>   
>   		page->mapping = NULL;
>   		if (submit || len < PAGE_SIZE) {
> -			/*
> -			 * inc the count before we submit the bio so
> -			 * we know the end IO handler won't happen before
> -			 * we inc the count.  Otherwise, the cb might get
> -			 * freed before we're done setting it up
> -			 */
> -			refcount_inc(&cb->pending_bios);
> +			atomic_inc(&cb->pending_bios);
>   			ret = btrfs_bio_wq_end_io(fs_info, bio,
>   						  BTRFS_WQ_ENDIO_DATA);
>   			BUG_ON(ret); /* -ENOMEM */
> @@ -513,6 +529,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>   		cond_resched();
>   	}
>   
> +	atomic_inc(&cb->pending_bios);
>   	ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
>   	BUG_ON(ret); /* -ENOMEM */
>   
> @@ -696,7 +713,9 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>   	if (!cb)
>   		goto out;
>   
> -	refcount_set(&cb->pending_bios, 0);
> +	atomic_set(&cb->pending_bios, 0);
> +	refcount_set(&cb->pending_sectors,
> +		     compressed_len >> fs_info->sectorsize_bits);
>   	cb->errors = 0;
>   	cb->inode = inode;
>   	cb->mirror_num = mirror_num;
> @@ -741,7 +760,6 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>   	comp_bio->bi_opf = REQ_OP_READ;
>   	comp_bio->bi_private = cb;
>   	comp_bio->bi_end_io = end_compressed_bio_read;
> -	refcount_set(&cb->pending_bios, 1);
>   
>   	for (pg_index = 0; pg_index < nr_pages; pg_index++) {
>   		u32 pg_len = PAGE_SIZE;
> @@ -770,18 +788,11 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>   		if (submit || bio_add_page(comp_bio, page, pg_len, 0) < pg_len) {
>   			unsigned int nr_sectors;
>   

> +			atomic_inc(&cb->pending_bios);
>   			ret = btrfs_bio_wq_end_io(fs_info, comp_bio,
>   						  BTRFS_WQ_ENDIO_DATA);
>   			BUG_ON(ret); /* -ENOMEM */
>   
> -			/*
> -			 * inc the count before we submit the bio so
> -			 * we know the end IO handler won't happen before
> -			 * we inc the count.  Otherwise, the cb might get
> -			 * freed before we're done setting it up
> -			 */
> -			refcount_inc(&cb->pending_bios);
> -

Looks good so far.
I understand pending_bios will go away in favour of pending_sectors.
But here, is there any purpose  atomic_inc(&cb->pending_bios) is called 
before btrfs_bio_wq_end_io() that might fail.

-Anand


>   			ret = btrfs_lookup_bio_sums(inode, comp_bio, sums);
>   			BUG_ON(ret); /* -ENOMEM */
>   
> @@ -805,6 +816,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>   		cur_disk_byte += pg_len;
>   	}
>   
> +	atomic_inc(&cb->pending_bios);
>   	ret = btrfs_bio_wq_end_io(fs_info, comp_bio, BTRFS_WQ_ENDIO_DATA);
>   	BUG_ON(ret); /* -ENOMEM */
>   
> diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
> index c359f20920d0..8940e9e9fed3 100644
> --- a/fs/btrfs/compression.h
> +++ b/fs/btrfs/compression.h
> @@ -29,7 +29,10 @@ struct btrfs_inode;
>   
>   struct compressed_bio {
>   	/* number of bios pending for this compressed extent */
> -	refcount_t pending_bios;
> +	atomic_t pending_bios;
> +
> +	/* Number of sectors with unfinished IO (unsubmitted or unfinished) */
> +	refcount_t pending_sectors;
>   
>   	/* Number of compressed pages in the array */
>   	unsigned int nr_pages;
> 

