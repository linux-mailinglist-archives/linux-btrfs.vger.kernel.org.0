Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495DD43C666
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Oct 2021 11:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240120AbhJ0J0V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Oct 2021 05:26:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:2724 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240102AbhJ0J0U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Oct 2021 05:26:20 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19R7wm17014743;
        Wed, 27 Oct 2021 09:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8WgZrwRNSxq1F+Z3hlD9tJFT+N0cP24xKohdaWH/pvY=;
 b=P34tzFnB1IEfVqs2bVZy0NvXl6bH+034SzZK4XLu+LzMo8rBwU3KBLsPDd+XSVo139Sn
 3/Awkxc/codZysxyD0JARKO/v/1a/juiSF/GOP/hthbQ7w1L74grFOFYK7MznCV6FcHp
 RX/7QMGV0pK6N8DP6ghw2E0X+pz9qETfXbSiGfvg+BqGCFtByNDw5pTnGvvrPKKXC/JF
 d/bH4PYaZAYLrOgo2MGgXPpeU5LJJ8T59G5kFcyHLi+yMbvJIa65pcUCKAVEMS+a9kn5
 9UwqTTUO9KuBOt+bKpnd0/2R6b3gbPDLsypAsa62Kjy/LYfgM3uWUOB44VcQ5FlgEan4 5w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bx4fg1c13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Oct 2021 09:23:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19R9FH2F077468;
        Wed, 27 Oct 2021 09:23:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by aserp3030.oracle.com with ESMTP id 3bx4g9n8xf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Oct 2021 09:23:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JulgWQpCOriPsroXiIfIZcu0pJd+Ebmlj9/t+UO40CCJRnQAvHVNJNTsNAzecbia1lVVxTzRL1fhch8rWShWFkJJQ06CGNaWrspn+OK3ub+9xODaOle0vpzdlJTjyICoq22Y6yZrJN3q/AbGso5oMlSQBnxKZcgkOsiH/SskWi5lSH5HSAbHr7H9IBbN2LfxMd4PdYfyPz60B1vKlVxQBAEjRAOe2zlJ3d0c2J8fpTf0rLBo/5143jE/98ISFV4+IvAEuTSg4zYmSkqNQDdHsC7aGRyM9EuGLevUyGIL5AU5vCQpiz2ccDcpqkR2QTibgrPeqIt30kRahF0yw0d7nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WgZrwRNSxq1F+Z3hlD9tJFT+N0cP24xKohdaWH/pvY=;
 b=Si6I7ojTuusJ8GSz8D1SvGkckHGrf6wJ2NyyhDrzpDXqAmvSZ8esXx2NOC5pTdyE8c/VJG8rfMZYEEGLhGi6/GvgoHHXdK34AGsSXY1yO8UduYhFPy+P/6l25HpfB/W/iIMa/INY2ShZH+KAgdrr3Kl1LBD2sM1w9vuUlMfFlrG2hn5BrNlN03DqES+oeMxnaBbxM03gENRRKMwuVy3fL+X05TcDjIJi5luGjdBxxGrGkJIcm69wPeOKyP/iqPxvuwL+roCPHtP3hto2sw3fDELZ6JJye/P/R5xmG2PpjCh1RYWRGYyYOenEkpsMsxtu0X0NtSRUc1ODggzJi2uQmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WgZrwRNSxq1F+Z3hlD9tJFT+N0cP24xKohdaWH/pvY=;
 b=s2ymxaj+AjC1tOctTOQY9wBzNEk6uHzerZ/XgJ+qBu4orAWDG6laI3GvTJuyT/UBjqqCicF3W4sx0pO18HERY/pTzNd4KFuyRsnLR7YXjk3CAS//DbisMwwh41392kg68PI6BCGezHWMw5UjhxB4tEH9NVxvVMby+75eEhKszm0=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2930.namprd10.prod.outlook.com (2603:10b6:208:7b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 09:23:49 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 09:23:49 +0000
Message-ID: <514d1330-6af8-4d48-fef6-f2732d7f186d@oracle.com>
Date:   Wed, 27 Oct 2021 17:23:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2 2/2] btrfs: use ilog2() to replace if () branches for
 btrfs_bg_flags_to_raid_index()
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20211027052859.44507-1-wqu@suse.com>
 <20211027052859.44507-3-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20211027052859.44507-3-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0152.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::32) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR01CA0152.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Wed, 27 Oct 2021 09:23:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed875d67-5a61-441f-bb58-08d9992b7bf5
X-MS-TrafficTypeDiagnostic: BL0PR10MB2930:
X-Microsoft-Antispam-PRVS: <BL0PR10MB293050C9256BF74565DC7134E5859@BL0PR10MB2930.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9r2+iQI4/AlDrj5d9I6FaOAh61TBxqqM9GsgzhhdOReUZM9qAn1UFJ+ocsdNCucDX2mdzl+/5i9ukMCctDm+7wMiJE5Z9DQzzbSOL2pBzKw9vkgFQ6A2Cfgk4IZJ9TbuOkSsquvQGZS6i7MMcjftfev4DPMkHEeqRPygrrwV8WceUJ3Itlj4whUyoKZqjzEYxMOEhtaL1ktJwfApoEsimPOlVX+yuDXIKyeqnEEniAKaURCMIGRPUYCAjgJMQpoEPxkt67N733sNPW8mtVwPHY3XiHN/REaaGiwQMvFQ16twsXYwDl82/R/xXskbrrZCQEd0XW8+u49GwEEz+PmSn8SJ4qr1yHsWI8hYEmMZO2zO36ET5Uy1PLnzadC83VT+j2QroQlXuHuagO+zcU6aQnhi3TGGOZTLkbKcqwG5J11g9bADO+hTt8qt52SlsgbUrt1XheXRoUYVUrCtBWCC6e44mthtkQ2gcVMf0X7OgnFBUNBEF3/LbJzVAUPdLZ7RO7h0AMvfV86gkaPxwOv/oSotcP+3iu6wU04bzhwKvfS5ht0g8HUWOyb0bQ+NJ6O8feYfgS1FDtpbsYJTB1CrUqVbCoJOVED0TEKEKq+qSB6/n/kl/QkO56vCHcW+f4yEMCoqZGSjWbl9s+/WNDipNtfZzAuy0EAJ4ooKel7Oqwdbu2MuuWH0SCVxCBSSkQ7VRNfiz05b/5EgxEAnujfyUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(16576012)(36756003)(186003)(31696002)(86362001)(6666004)(26005)(53546011)(2906002)(38100700002)(8936002)(316002)(83380400001)(956004)(6486002)(66946007)(5660300002)(8676002)(2616005)(66556008)(31686004)(66476007)(508600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm1XT3VOVU9jaUJkZ3RWaExid1lHVTM1bjNpRnZBc2J3cXhja1FVMEErSSta?=
 =?utf-8?B?MU5INFZiWVBkZ2JKQXRGWkYrUVZnbm14VVNsempzZVVZL3RkcVRUMDZ0VGNT?=
 =?utf-8?B?NllhWmRwOGtCMXBjV0V5eXBsTHd6emJTM3NWV0NnZVV1VUVwcko4K2FEeXht?=
 =?utf-8?B?S0xWZm5ycjZuMUV3eG5WV2N1NmRKNldkLzFBLytYY0lld01uYXR4ckY5UVRZ?=
 =?utf-8?B?cXdIQzV2aHdaRHNiNExXSDN1TCsvbS9sKzdiazgxN2JrZVYvZFFXc0NtelpI?=
 =?utf-8?B?TFdyODlWanhrcGUrUy95bjEzdlBxWkpqbVFPMVZJbWZnZkE2dkFiOGpDSlQ3?=
 =?utf-8?B?U1UwMDU1OWtrcERiRS9LcjRIeTluczR0UEh3SnRmNkhOckU5Tk1lMThiTFds?=
 =?utf-8?B?MmhjV2d2UG8wdk5GQURmK1RPb2VrUEEzVm1QZGwzdjRuQUZDc0h2djh3MDdJ?=
 =?utf-8?B?c0ZSZVFKTTF2KytoNks2bmd1cnM1N1hNalBaU2NqcWUrdFlqZEltRzEvbzNP?=
 =?utf-8?B?RGNRaHNYWTUrcGw1S0NOclNxSUdwOURNSGwzZUhTQzloUlY1cUpoMnk3V05H?=
 =?utf-8?B?YTAxOUttWUhseTdnb1NwMUd1TWZWN2IwREV1YUZmWlJqa2tMWUxlalFreW1v?=
 =?utf-8?B?bTExT1JiQlFFQUE3NHREUDhRZktPbEdBMHVmUFljU2hubHpJTmJ2L1JBaDRG?=
 =?utf-8?B?WGROV0ZYL1BxaHN1QnFUY3FLL0Z1OWxqUGdiTTFZclV6bVBmbmh2NzlVRjd6?=
 =?utf-8?B?a1JYTldEdUtYU0toUFF5UFdVWTh0TVR0cE1WdGMzazdiNVhPcTdzRUp0NWVI?=
 =?utf-8?B?SHJiUWp3VXJpNThrTG5aaTF1U2JCcndyeUdzdkdPMXJ5OG9MUHRkK0l2dlRR?=
 =?utf-8?B?ekdqQmMrRUhHb25MdU05cWsxWm5ONndweGZMVnk3TGRldzM4aW0xdUk2aEdT?=
 =?utf-8?B?RXBjOTZaSXNpczcwODlobU1EbTU3UmhtOGxZSnZKNWVOamVTN1JzZ0NxMFIy?=
 =?utf-8?B?bmpIUk93L2cvRjZjSVM0ZUdIbnFPMUt4aWNQRXlpc01rQWorWWRPMGRJaTl4?=
 =?utf-8?B?Y2pya2tLS0U5WnFvTkZsN2I5V1YzQTEwbFlkNGlVMkJkTTk4c1ZhdkpNQ05p?=
 =?utf-8?B?WFBucjdLWDB3dTQvNDVCVGlpZTYrcFozTkhDRytmQ2xoR1Z4dkRueGRPeVdp?=
 =?utf-8?B?NmVwaGFyMG5QaWxqY2srMGNXa284eVZ5S1ljMmhQSGZBc0RDaGRHNzVMUmVm?=
 =?utf-8?B?WjQ5R3kxMEMrRkV0OGV2dnhubHBaWDlSN3BzTlZnNFJ3ZVF1bkNCb0plSjdV?=
 =?utf-8?B?a1p2eTY1cGI2NjhvU3djYkpGclRGbnU0eXRFZ1gzRUNyczZBZmhjUktnVkg4?=
 =?utf-8?B?RG9TMGdEY2R5c0JGZXhhc3VtYk45MUczMVVhQm9NRXhFZG8xRS9uQ1NXMXFt?=
 =?utf-8?B?bktnMEp5S243eFBUd3JhamhmeEtNNkt5cmllZHRlY0kyM1F4MWt3Ykx5T205?=
 =?utf-8?B?d2RPVWNmeEJ3cmRWc2ZtOVR1WVB6WUExQyt5NXRFMkx1VVltL0pIcW5rODVm?=
 =?utf-8?B?bzA1OWdiT2tveDBKQ0U4VGtYTDJzL0FiNGQ2NXo1d044SzMwSGNnUHpUVnA4?=
 =?utf-8?B?ZENxVzdHSi9YOENBL1JqNW5ZTGJKU2I5WnRzMFVKK2V1VEx3Z0V3ZFpELzFr?=
 =?utf-8?B?U25zY2t2djZtQjhQcjJubTZtQUdHdnRtbk5YMDV6UXcxMloyN0JnWkM1Qisx?=
 =?utf-8?B?SXFqN1lnODBtaFc3b29ocnhTSnBEZnRZQk5sL1l6c2FWY3RSV3JMRThWY1dE?=
 =?utf-8?B?R2tMbXNYMkxHbVhEbjhFYklEcCtpa0VFS0ZpdTZRMnQ4ZjloZW0zb3FEM2dy?=
 =?utf-8?B?OUVYVzBkN0ZtNHZKalJWNlk2T2syWFUrMERJSUpDcUo2RVk5Q1o0cEV2d2x0?=
 =?utf-8?B?eFdQTTFicm05WGE1VldRR1Z4bVhlSzE2TXE1UG94NGdZK0ZIbE5PUkRlYnpX?=
 =?utf-8?B?L2FGbjFIUFJHTDRSUzd4NnROTHltZEtndExOSGtxK1hEMHc3MTEwaGJDYW5L?=
 =?utf-8?B?cjlQY2tOY2VMOFlTbGo4dFkweG9KclZWc24xL0ErZW5PNjJ2SHd5QjdIY0No?=
 =?utf-8?B?Q1BvbkdhR3hteEE3NFhNYUMwdm84RzIrZjV1S1hiNjVvaGJlL0tOSS9qMHg3?=
 =?utf-8?Q?YU5KaKuEpcceMMrfCNiIo3s=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed875d67-5a61-441f-bb58-08d9992b7bf5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 09:23:49.5764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RmN4fF/8WBAOz08NRTBncRiecWCmIv5FHy9iNW02OnqSabNDKob10JOqMq4pd7svwrJmvSEvgeFe0DbgZ430Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2930
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10149 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2110270057
X-Proofpoint-ORIG-GUID: _65lke61prHjCVoco6lUAnAvFBE1r9ab
X-Proofpoint-GUID: _65lke61prHjCVoco6lUAnAvFBE1r9ab
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 27/10/2021 13:28, Qu Wenruo wrote:
> In function btrfs_bg_flags_to_raid_index(), we use quite some if () to
> convert the BTRFS_BLOCK_GROUP_* bits to a index number.
> 
> But the truth is, there is really no such need for so many branches at
> all.
> Since all BTRFS_BLOCK_GROUP_* flags are just one single bit set inside
> BTRFS_BLOCK_GROUP_PROFILES_MASK, we can easily use ilog2() to calculate
> their values.
> 
> Only one fixed offset is needed to make the index sequential (the
> lowest profile bit starts at ilog2(1 << 3) while we have 0 reserved for
> SINGLE).
> 
> Even with that calculation involved (one if(), one ilog2(), one minus),
> it should still be way faster than the if () branches, and now it is
> definitely small enough to be inlined.
> 

  Why not just use reverse static index similar to

const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
<snip>
}

Thanks, Anand

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/space-info.h |  2 ++
>   fs/btrfs/volumes.c    | 26 --------------------------
>   fs/btrfs/volumes.h    | 42 ++++++++++++++++++++++++++++++++----------
>   3 files changed, 34 insertions(+), 36 deletions(-)
> 
> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> index cb5056472e79..5a0686ab9679 100644
> --- a/fs/btrfs/space-info.h
> +++ b/fs/btrfs/space-info.h
> @@ -3,6 +3,8 @@
>   #ifndef BTRFS_SPACE_INFO_H
>   #define BTRFS_SPACE_INFO_H
>   
> +#include "volumes.h"
> +
>   struct btrfs_space_info {
>   	spinlock_t lock;
>   
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index a8ea3f88c4db..94a3dfe709e8 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -154,32 +154,6 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
>   	},
>   };
>   
> -/*
> - * Convert block group flags (BTRFS_BLOCK_GROUP_*) to btrfs_raid_types, which
> - * can be used as index to access btrfs_raid_array[].
> - */
> -enum btrfs_raid_types __attribute_const__ btrfs_bg_flags_to_raid_index(u64 flags)
> -{
> -	if (flags & BTRFS_BLOCK_GROUP_RAID10)
> -		return BTRFS_RAID_RAID10;
> -	else if (flags & BTRFS_BLOCK_GROUP_RAID1)
> -		return BTRFS_RAID_RAID1;
> -	else if (flags & BTRFS_BLOCK_GROUP_RAID1C3)
> -		return BTRFS_RAID_RAID1C3;
> -	else if (flags & BTRFS_BLOCK_GROUP_RAID1C4)
> -		return BTRFS_RAID_RAID1C4;
> -	else if (flags & BTRFS_BLOCK_GROUP_DUP)
> -		return BTRFS_RAID_DUP;
> -	else if (flags & BTRFS_BLOCK_GROUP_RAID0)
> -		return BTRFS_RAID_RAID0;
> -	else if (flags & BTRFS_BLOCK_GROUP_RAID5)
> -		return BTRFS_RAID_RAID5;
> -	else if (flags & BTRFS_BLOCK_GROUP_RAID6)
> -		return BTRFS_RAID_RAID6;
> -
> -	return BTRFS_RAID_SINGLE; /* BTRFS_BLOCK_GROUP_SINGLE */
> -}
> -
>   const char *btrfs_bg_type_to_raid_name(u64 flags)
>   {
>   	const int index = btrfs_bg_flags_to_raid_index(flags);
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index e0c374a7c30b..7038c6cee39a 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -17,19 +17,42 @@ extern struct mutex uuid_mutex;
>   
>   #define BTRFS_STRIPE_LEN	SZ_64K
>   
> +/*
> + * Here we use ilog2(BTRFS_BLOCK_GROUP_*) to convert the profile bits to
> + * an index.
> + * We reserve 0 for BTRFS_RAID_SINGLE, while the lowest profile, ilog2(RAID0),
> + * is 3, thus we need this shift to make all index numbers sequential.
> + */
> +#define BTRFS_RAID_SHIFT	(ilog2(BTRFS_BLOCK_GROUP_RAID0) - 1)
> +
>   enum btrfs_raid_types {
> -	BTRFS_RAID_RAID10,
> -	BTRFS_RAID_RAID1,
> -	BTRFS_RAID_DUP,
> -	BTRFS_RAID_RAID0,
> -	BTRFS_RAID_SINGLE,
> -	BTRFS_RAID_RAID5,
> -	BTRFS_RAID_RAID6,
> -	BTRFS_RAID_RAID1C3,
> -	BTRFS_RAID_RAID1C4,
> +	BTRFS_RAID_SINGLE  = 0,
> +	BTRFS_RAID_RAID0   = ilog2(BTRFS_BLOCK_GROUP_RAID0 >> BTRFS_RAID_SHIFT),
> +	BTRFS_RAID_RAID1   = ilog2(BTRFS_BLOCK_GROUP_RAID1 >> BTRFS_RAID_SHIFT),
> +	BTRFS_RAID_DUP     = ilog2(BTRFS_BLOCK_GROUP_DUP >> BTRFS_RAID_SHIFT),
> +	BTRFS_RAID_RAID10  = ilog2(BTRFS_BLOCK_GROUP_RAID10 >> BTRFS_RAID_SHIFT),
> +	BTRFS_RAID_RAID5   = ilog2(BTRFS_BLOCK_GROUP_RAID5 >> BTRFS_RAID_SHIFT),
> +	BTRFS_RAID_RAID6   = ilog2(BTRFS_BLOCK_GROUP_RAID6 >> BTRFS_RAID_SHIFT),
> +	BTRFS_RAID_RAID1C3 = ilog2(BTRFS_BLOCK_GROUP_RAID1C3 >> BTRFS_RAID_SHIFT),
> +	BTRFS_RAID_RAID1C4 = ilog2(BTRFS_BLOCK_GROUP_RAID1C4 >> BTRFS_RAID_SHIFT),
>   	BTRFS_NR_RAID_TYPES
>   };


>   
> +/*
> + * Convert block group flags (BTRFS_BLOCK_GROUP_*) to btrfs_raid_types, which
> + * can be used as index to access btrfs_raid_array[].
> + */
> +static inline enum btrfs_raid_types __attribute_const__
> +btrfs_bg_flags_to_raid_index(u64 flags)
> +{
> +	u64 profile = flags & BTRFS_BLOCK_GROUP_PROFILE_MASK;
> +
> +	if (!profile)
> +		return BTRFS_RAID_SINGLE;
> +
> +	return ilog2(profile >> BTRFS_RAID_SHIFT);
> +}
> +
>   struct btrfs_io_geometry {
>   	/* remaining bytes before crossing a stripe */
>   	u64 len;
> @@ -646,7 +669,6 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
>   			       struct block_device *bdev,
>   			       const char *device_path);
>   
> -enum btrfs_raid_types __attribute_const__ btrfs_bg_flags_to_raid_index(u64 flags);
>   int btrfs_bg_type_to_factor(u64 flags);
>   const char *btrfs_bg_type_to_raid_name(u64 flags);
>   int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
> 

