Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E6A4112FB
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 12:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbhITKjw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 06:39:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:14962 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232118AbhITKjv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 06:39:51 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18KA71K9008283
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Sep 2021 10:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=IcGHaGj1GIkrJBRTKt6nl/VPc+Q4E8S9zvgBfDILFbE=;
 b=aStAxeJ4N8xj9vgYT7Arg6Tw2nMCIOdvSryTHqShDU65BwqPYWfpMfKBA3RXC472MIgt
 CmafhQNABMpwUArdBbcYf22LtBLI/atxTW+sCJwUZKiuTZY7+77MQ1s48YHxg/UUVOOO
 KwWtLCnVy9X7J+AstneFhO+OoM5ILl7i6pBd4l7BAYMKRf/quVnJODWy1ff9f8PvaK54
 laq6aal12TEdRVNKns0E7ZpTYOOsAsEoIjv6oN229UcK99+5rpTP/Mls8GwDSmyAvdaK
 VdtM0g7mFnrYIYRhhKD3p+AWvJemm205XNbxIgHNb0ugx/XvPeG/Oxgg5ZFnj/11kpLE ag== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=IcGHaGj1GIkrJBRTKt6nl/VPc+Q4E8S9zvgBfDILFbE=;
 b=ZbFE4iHIqidhCbXZNNBLebQlhs6IThyKDi2o34FLA8l/18wN7rM1ngK0cHcxw/t0wXac
 3UQyd+NyBsjpOEFYDtVyO/NlgmFXj6ncsK74Oguy3D7YkK2yTY1Zv0ApTIWYarir8cpw
 hLX8WKqHb7m+6iHsTGGhpRsEAPGUC4Bm3afXMWwK88M+hFVb82o8yZ8UIJkWQeKqcfIM
 v+ms8w5CNeN4azU+UASdT8M4Ma+kjYwT4TFc6q6LYCT4pzn3n8w2fGsCneHyMYPDELma
 uVOXx2aJCH9A4yCu5Y9gnGKYYFABKQFgygGGaOHh8Yxp2F9z0BBsUvwFUB4QBGOQ7DvO TA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b66hnhv1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Sep 2021 10:38:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18KAUi60172953
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Sep 2021 10:38:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by aserp3020.oracle.com with ESMTP id 3b57x3us3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Sep 2021 10:38:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ztfkq4FCLa86zNJCA80puIlHVjj+/s5OuXqWT5J9kQzzLAy9jvY7JLVZ1BUyeIx1x7PJSpqcev727Fxr1X5A254vsUoP7sF68CKdClf8nxE6JovurRhfIXQu56ZnBp5kdibm+dfB3LboenACHg0Wt8I5lmb3Ece9A93xgGaIL16D0zFTJgCn/9G4xEb3BxiQGTc0BcD3SSbLtkDn3yaMXSg8HDdWPc1G+JT3nXIGDyyn0rVyS3JhWecfbA9t04ppyd0vfI7My6bcAgM8QDAc61feqy5eOqda3dro27NCpGmH7jc4xmUJmvjLBKmw3RS0X3mN7wroRtE9qGk+bj4VGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=IcGHaGj1GIkrJBRTKt6nl/VPc+Q4E8S9zvgBfDILFbE=;
 b=EKxjL63/zp72iS/Dg+vPxbQTT/iHW9NWdajU7kH0UQSLQy8A6hc8IobMCCV1zq13/Uiwvb3OXGZ43taf9u6UqcFYkA9MyQ7CBaOHwjUDxLCP+PYiz/TB2YrYJzWtb7WRf1nwm4PWTfz4Q0Lrjlx8fyB0xCIt+bTBdPmxJ93Sxw7YUxbnhdLB36KyQD/SyOChXG09i8Ri2Bw4X1gychbW86Se/6hr8T5hl8XwsywLG1FebpYh1Pv9dCpgN6gG7/F5lML6GG6fcXudCYGsCt82krGUc58Oteup1WR2KhH/jxhREAmx0DbkMlEwNz2xtx2QhFwzGyqjT30ptj1xjRrl6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcGHaGj1GIkrJBRTKt6nl/VPc+Q4E8S9zvgBfDILFbE=;
 b=NjW0laIpjv/Ct8wDutYdcvX1NkMqVgcu2IN2i5FrCNAcuaheTWdas9YqSNgJeuidD5j/LDuzb9H9dcbBh+RxYOx1f5CjMh/cZSXzwvQir2DDaJGdnka4IAIhe5yQzyVSEfy0EiW7R021znP0HqanUUis7JQ7wnZzG3i2NqmfO+U=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3981.namprd10.prod.outlook.com (2603:10b6:208:183::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Mon, 20 Sep
 2021 10:38:22 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4500.018; Mon, 20 Sep 2021
 10:38:22 +0000
Subject: Re: [PATCH] btrfs: open_ctree: call btrfs_check_rw_degradable only if
 there is a missing device
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
References: <dcf8a95ecd21656604202d904d5fad2ff9e96ea0.1630328821.git.anand.jain@oracle.com>
Message-ID: <603b0bc0-4efc-f371-f8b2-d1a2a2c83e11@oracle.com>
Date:   Mon, 20 Sep 2021 18:38:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <dcf8a95ecd21656604202d904d5fad2ff9e96ea0.1630328821.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::33)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG3P274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Mon, 20 Sep 2021 10:38:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65c9e6b9-3a75-4be6-34f6-08d97c22c48d
X-MS-TrafficTypeDiagnostic: MN2PR10MB3981:
X-Microsoft-Antispam-PRVS: <MN2PR10MB39818BDBEC1446B6F190D4FAE5A09@MN2PR10MB3981.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 98MQKMAGi5zFuPxwF2b0xxHhETtykKTE6PUfks7jwrotZIi08QHh9LAb++yyf0z1h4y+mLBECxTYh17xs8jUTdoEPr19tbUKKiqRuRnYbr9WHXEvzW9BR/Dd5dh1pcomVQkm2XlZf13+Xzur5AiHmo5lguri8QCn4Xz4SH13BfUKovcvuhpeF0T65DpCIRZnUYlZ0Q3tkZWk3afbUyD+uC05L3zJmH2yrfjFCbsP45b0pUJP0wgrxsf/G2TYs4MjubZL1lctzzQtTxVKL1hFpABUfh/Hd4/qAZU7eEpsCX3Oq92/zY/UK0bf0i5G/lrnpMXDopOv9SlGqwxUBPMIecHvEAiDURcy3QyRQiiLJDMcHxZ5j0GH45ZEWaiZZSO8Q3gwFPjfc4gJjj30fZ8O9XZ7PW3iCD/y4KRwmESUDjOamz7SRS0dl6Sjjl5LqkGjDfD7sPQytquZ+y13zP2zyr9bvqgcYioVtoGSoey/4pf2alBj0vayXh90EFcGBkvIDbvuvF4ryCsQOo7q05vYSIqXDb2LkMBb3fou2H61/sn6n2X3RZPMjAOyBg9/5koYBGUX3+70ao516hNOFCzHP7ccUMeboYGyubzEKQzgW412AyjkJqvGkZ0cULuAAFD4Syqiibv6Sy/1Zv1qBVHXf8stZFUbV5WzkIq/cWfjCdjnW9TT4pVuQdbHQDDAiE7245ebsR7BmDJH5VbBVaf4ivimsf1xOukaTrxMcB6Zg/Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(396003)(366004)(346002)(6916009)(8936002)(16576012)(31686004)(8676002)(2906002)(956004)(316002)(66476007)(5660300002)(66556008)(66946007)(186003)(53546011)(44832011)(83380400001)(86362001)(26005)(36756003)(31696002)(6666004)(38100700002)(478600001)(6486002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aE5WRXY0MWUvdFFZQ0tTVDE4V256WWpaRFdvT2NQazUyN00vNUMwaFZra3BH?=
 =?utf-8?B?K2xZc09PeVNUcU82SHpWclo4alY2UCtTTndDaDdJVFF1cks5ZnlLNHM4ZFFS?=
 =?utf-8?B?QXF5bTVHWm8yeTRSTmVhRld0SVpoc3NUS0JlUVMyYWNIdGhsUmxRUFQ0bjd6?=
 =?utf-8?B?ODJpQkhlTDJhWlZ2dXV2QWNIQkozcjcyU2krWGUxNDgySGpiM29qZjdrSUJk?=
 =?utf-8?B?cHJUTXUvcTlIdFZscHYyUy8raUtyc0JZNXpuRVFML0MrUWNjOEUxM2s0TVk5?=
 =?utf-8?B?a1h1cHh6c0c1bTg0aVFocm5Tc1R1S085anZTME1uNEh5SDE4aEpVQUZma01t?=
 =?utf-8?B?T1h0MDBsU3h6bU9ueXZMNTFvYVBESlVQMC90cVFZam1QZ2R2dklWcE5kaDhW?=
 =?utf-8?B?d0luMXYwd1VLZlZ2U2ZSSENiVVBFR2RSS3JheDJyV2VEOVFWS1JQd0EyWjZD?=
 =?utf-8?B?S0o2b1ZCcVpWSk1qb1lxWUk3dWw2L1VvUGdQL3dXKy9NT3h3RVpPR1BNbkVs?=
 =?utf-8?B?TitmdnR5RXBzTWozNWdObklxSzYyNmFjVTJuNjdoRVNKc0JJakpNV3RDbFZL?=
 =?utf-8?B?czRKZlYyZHYyTTFBaDRObmNmOFBGWnNGR2hRVmJUS0k0U25wQzkrUGlPMk5R?=
 =?utf-8?B?Q3dpTjVvejk5b2VmRUtzTUlGWHJZYlErdFFoWEZuR3dOZHRNNVg5R2xFRVNz?=
 =?utf-8?B?K291c05FTHYwUENkMUs0Ni9aU1cxcUNGL2QyRitVVmNEMktYZ1RZa3NLRmFn?=
 =?utf-8?B?UUNXaHJFQ1I0aXRNMGQ0OTRzMkFtcVBIR3NtSFZOdXdMbWlzMFNtL0E0ZlFT?=
 =?utf-8?B?TmtLeXdldU84WVhuVUlUb3BXemF1aWF3Z3pEVDFTSUgxRWUrV0xya3p6cTVF?=
 =?utf-8?B?cUtTWlExTHJDbEN2Wmw2bS9OcS83bUJzbWNkTHBGMEpPekJkZURwTVNucVpW?=
 =?utf-8?B?QlljSWhUdW4wMTlpYk9BTm5Nc2p2azhPYUk1WUxsdHFKQ3FoWjd3R3hvVDR6?=
 =?utf-8?B?TVJCRFlFb3BwUWRadXVhUjRPN1MyVnVhM2tJY1h2R0FjQ2FnTjRSdWk0eEx0?=
 =?utf-8?B?VTFOM2l4WFpnUmM0VkFMcFhuMzk5aE9id3o1c3FDWko4OSsvNzBENmladjJu?=
 =?utf-8?B?ZmpuZVM4bGtXRVM0UFMxYmpxdEFtb2MxV2lzVStET2MyZElWWlRNMzVGZVI0?=
 =?utf-8?B?RzJVYVRucVFtNlZRUENoenZuY1o0SFYxajZXUndDNGZSRHNBQ1dqUWdSWkYw?=
 =?utf-8?B?VlppVkRJcldPUWlPck02RDJMNHZOaFhEVjFpeHlMR05rYU4walJ3Y1dIck0v?=
 =?utf-8?B?bWs5NEFxdWgxYUFOVEZFVmFrOU45eGdYdnhvTnFtUkhsYzE0WnhzNXozNmsw?=
 =?utf-8?B?cEZFaTRCeVBvajB1a0tGSWgyVU4vbTluUUhsOXdFWUV4U1l1dTVuN1VjME93?=
 =?utf-8?B?akNnMDFGT1VQY3ZwbVMvVVF1ZnJnWm9QL0Y1RzJsWkE1N2FZKzJnMDhMYWR3?=
 =?utf-8?B?dndySUYza3pKZktnWVhRY1c0TzhwamtuZG1XbFlaczlic3JESE94UVBPWUp0?=
 =?utf-8?B?clBMVUpNS1BnK2o3VzMybmlnMWhLR3h0Sm1Oek5kclE1NGVOV2ZjaVZMTFlW?=
 =?utf-8?B?STYxZy9GWTNOV2tLTlJXUUZjc0pETm9KWEhBb3JucHZZWUUzay9lTnhIMVl4?=
 =?utf-8?B?dmF6MFBYZk93K2FySk82aFdqYkRiOGt2azBSR0VkOElmSlZvUjhOQjNucldE?=
 =?utf-8?Q?4fHT0+mcUcD7bKNIV7G2WrGnAEYGJwuVMtgd88S?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c9e6b9-3a75-4be6-34f6-08d97c22c48d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 10:38:22.1351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QsW3MUHG7aQjiUmAY1JA+NszcnRxdDBrQuA4r43rLLShO4fRwGoEP0LtNcbHrz/QNyOR1PYPMYLcz/hCMfoXvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3981
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10112 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109200064
X-Proofpoint-GUID: T2Xj1JVqglFnAxghQ1dNcwW0lYVAMXIC
X-Proofpoint-ORIG-GUID: T2Xj1JVqglFnAxghQ1dNcwW0lYVAMXIC
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Ping?

Thanks, Anand

On 30/08/2021 21:11, Anand Jain wrote:
> In open_ctree() in btrfs_check_rw_degradable() [1], we check each block
> group individually if at least the minimum number of devices is available
> for that profile. However, if all the devices are available, then we don't
> have to check degradable.
> 
>   [1]
>   open_ctree()
>   ::
>   3559 if (!sb_rdonly(sb) && !btrfs_check_rw_degradable(fs_info, NULL)) {
> 
> Also before calling btrfs_check_rw_degradable() in open_ctee() at the
> line number shown below [2] we call btrfs_read_chunk_tree() and down to
> add_missing_dev() to record number of missing devices.
> 
>   [2]
>   open_ctree()
>   ::
>   3454         ret = btrfs_read_chunk_tree(fs_info);
> 
>   btrfs_read_chunk_tree()
>    read_one_chunk() / read_one_dev()
>     add_missing_dev()
> 
> So, check if there is any missing device before btrfs_check_rw_degradable()
> in open_ctree().
> 
> With this, in an example, the mount command could save ~16ms.[3] in the
> most common case, that is no missing device.
> 
> [3]
>   1) * 16934.96 us | btrfs_check_rw_degradable [btrfs]();
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   fs/btrfs/disk-io.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 4f38a657a30e..0ef3a8660ebd 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3556,7 +3556,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>   		goto fail_sysfs;
>   	}
>   
> -	if (!sb_rdonly(sb) && !btrfs_check_rw_degradable(fs_info, NULL)) {
> +	if (!sb_rdonly(sb) && fs_info->fs_devices->missing_devices &&
> +	    !btrfs_check_rw_degradable(fs_info, NULL)) {
>   		btrfs_warn(fs_info,
>   		"writable mount is not allowed due to too many missing devices");
>   		goto fail_sysfs;
> 
