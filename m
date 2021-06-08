Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4FA039EE03
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jun 2021 07:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhFHFSo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Jun 2021 01:18:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37032 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhFHFSn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Jun 2021 01:18:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1585Gd9W008120;
        Tue, 8 Jun 2021 05:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=BpzXddntWovZsR4BKepXUrxa3C+O2KC6PPEJngFtPUo=;
 b=tDYhW2gN2/IX+jMGVzbzfZoDeMtjeSKztBlR4TPzrXXVVsfbwAYbUXa4JKcIO7fzetwi
 XG4sBHdNDKrZyxLj0wEGQORQj5+6GDcTxn8MXmFUOMyuvrsDIFX7R8NMfx7CgnMASKrU
 BfjXQSK4wyIcjVA7qkuRZ9LkgROoCiV22TO729PNdoCdXzSytCdvf5UCBDvpZ8Hv7IUT
 twMNsq64ufY2a5xx7PfMgGtwaLI5Alp23Wk7yUECd6p38IVg6df+Cx9d6XJhoUwHcg+U
 bytRfdymvZqoDmMAYOhCEHhx3HC5474n4SmiyCM+lBKOFEkdhmECxv9Ch8/suHTcyxRK Nw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3900ps4qv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jun 2021 05:16:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1585Eo9F166270;
        Tue, 8 Jun 2021 05:16:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by aserp3030.oracle.com with ESMTP id 38yyaakj2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jun 2021 05:16:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CS6T5NoB57TaqCr3dkVOBprYiXlzbzC1wX0c/0L/k3CQfYEsPwJIKaaM3sWlXS7pCspW0Y0hmQJ6T4LXkm5daDMwwCNfgG7amayNka6hNSPSloXOGqRYGwC5Wj618F7xSWEzbiyFQ4q65tUrlHba0u1w576RzzMp3r44V06jmL/VuPYBqF1dQmsl+ZGti/4Ppdy/UcZOa0F3IM/DC+OUyHjtbOdnuqH+LHBBqqngRvbzz2LgyNqgF2OV4ZCrSooBjlAMkBnVrdkFcdAEieP1+VUQbCLB8a4T1r3hGANWrp6bLNS0/54pHF1Ft5Immo0fQ+kjXf4wcXXVmosBZR4FMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpzXddntWovZsR4BKepXUrxa3C+O2KC6PPEJngFtPUo=;
 b=YtFTtNcndb0rGHvgg3yfgcNLN0GOpvLBIg3DTYOhWAdQDGLWIKCKzhzMn4g2QRJO4sUHaRfPKh/4rTje5vvNYDAtAItj7VesioghWPkKgT4gMLTw8tEFmZkFALdD+7cbYB2hPy9qpPHYQGss3aJWPWfRJQZbwOMlqnDYx45Cyv7Q2VbhMUwcvaS2H6dC6Vd5upZyXOSO0LdOeYZs+iML3v/WUtHjYDGDSdVRac127cRUc7hA5JamPM7wtmfbo/V2qyWUeO49c4JOIWqpnAhU7+QKqHG6kaA6jjeXipai3hp8aS6V9Gntx9ygZdEU9Knlido9K2TRUAOEZICsXc+vTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpzXddntWovZsR4BKepXUrxa3C+O2KC6PPEJngFtPUo=;
 b=qk7l7Ps+rNhC6ddUH8t/W0JPJEWmyDue2Xlu1hOfw2zUeYLsFQoVx/yEqL+/yMHIdIN/uIcMEKHn4DoJtHTvfoUU0rDMlt/e83je+kzSPQMQNda4hnsqepGhd5EbSL0zcLmq877ehTMup5q7sxncIOrGpeaVyqSjRM85RC0cg6w=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3789.namprd10.prod.outlook.com (2603:10b6:208:181::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 05:16:34 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%7]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 05:16:34 +0000
Subject: Re: [PATCH -next] btrfs: send: use list_move_tail instead of
 list_del/list_add_tail
To:     Baokun Li <libaokun1@huawei.com>, linux-kernel@vger.kernel.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     weiyongjun1@huawei.com, yuehaibing@huawei.com,
        yangjihong1@huawei.com, yukuai3@huawei.com,
        linux-btrfs@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
References: <20210608031220.2822257-1-libaokun1@huawei.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <e860684e-959b-d126-bb1d-3214878ab995@oracle.com>
Date:   Tue, 8 Jun 2021 13:16:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <20210608031220.2822257-1-libaokun1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:4:7c::28) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.194.161] (39.109.186.25) by SG2PR03CA0100.apcprd03.prod.outlook.com (2603:1096:4:7c::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.12 via Frontend Transport; Tue, 8 Jun 2021 05:16:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: feb1bc1d-728d-40ff-ea03-08d92a3c9546
X-MS-TrafficTypeDiagnostic: MN2PR10MB3789:
X-Microsoft-Antispam-PRVS: <MN2PR10MB378979F1F80D5B2132F45225E5379@MN2PR10MB3789.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vqu3Cq022TS79Lwyd7ygw44ibKOxVql4kVsM2NZiwK+hXzN5IfYcH3esrCygMRX3528zAFGJLigUtc0brIBDXPbx8S8lxZjisD4MRj8Nvtxh75akoOOlAHgnhMkd+aPgB3dQyqhKLykaxgh6Clu7xip8RqnoGWkMH8gpWjQQyA4NN7B2lXOejmC3vO39xxvxWVgKRCnKZNA/DOv59bWHu+F6sFZS5z4ClU+q/mBoTKdNuGLpFOcZWhSJ+elsvnd85hXMMlbFI12y8gw2nwvpWGFRI+0Xw3/cfgdasayljwl2OlpAV5Bx63toqs3cDTL8nNGmJnuzIFMx+ji4RZ1PAdkKligjVVc/Ay0BTsbAOCtcWbQAZvfbp0ZR2iLrzXR8rOvUARMLU+bD3R68JlD2tP0nINT1Seavd9NSQDWlPlx/9q1dVQplERJbO32xHjZlkHL+RodWkInfRs9VfcZXdNSh521zMr16GsdRHrKpazw4sk0gk7PGP+/aR6nMTLLSaWS2zFzrSwg7FxuWMxUozZt0+SM882EKSSm0kiUJ4pj4+ZaNqbF2IvYXyjC0eJo1B5dTry8e2ZaDXkaWxY6AztARQ/ILGquP092zhpLhdvMtby+yts8WoSXH9aRwJkwuTCJpJ9qOUsoFvmpxT99bcTxU9uAX15kBlKuOSCrK74UTeiDer2tH+PlrZCdJ3cvX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(346002)(396003)(376002)(44832011)(38100700002)(5660300002)(66556008)(66476007)(31696002)(956004)(2616005)(8936002)(36756003)(66946007)(7416002)(53546011)(8676002)(16526019)(186003)(4744005)(86362001)(16576012)(316002)(6666004)(6486002)(83380400001)(478600001)(26005)(4326008)(31686004)(2906002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUpYbHM4NFowRVJ1OUtZTnlVSmJybVphcEhlN29KV0lmaFNlZ0FpQVBWY1RL?=
 =?utf-8?B?WGdRdWh0aW92Y2I4R1ptRjhlMkF1d0NhdW00ZjZiNDU3VVJHR3lGZWZPS1cz?=
 =?utf-8?B?eGtXc0ZlaEcvWUxRVDNvS21Gd3piMG42N2FaZnc4MWNJdG9GSmFJejB4VVRl?=
 =?utf-8?B?MjVsZE1BYkI4NUhteUx1U0I1YkNUVFRkTnNjdWRBelFnRUZDeHcxMnBPWlNN?=
 =?utf-8?B?OTdBVERQaGpwcFBnY254YU5YUHkwcjd5ZWl3MTV2eWpwU1VRR1k5b1M2UnNW?=
 =?utf-8?B?aENUUS82SjRVRy9EN1RDek9jUGVJOVVuM0dBaFFMNW0xUU1hN3pWdjRuUDJH?=
 =?utf-8?B?VVBudWh3ZHBSbGY1RHptZjZFYmpTRWplUkJ6WkI0M3YwSE5uYWhSMjdKQWJ0?=
 =?utf-8?B?T01SUEthN3ZuN0dPcDA2NzZHeEIvTk5VcU1zMVZlYkd6ZnN2UUM0ZitXbXRm?=
 =?utf-8?B?Wmt1dDRqTTJlRlkxNWFFaDh2MVpWRWg3c1ZXUWphTDc0ejFudVZHaUlDU1dM?=
 =?utf-8?B?M0NXdTZnRkNpMFRwTC9yMEwxaTIxcG1zbG83VnlXZkRIY0E3MHhsbjkxZU5E?=
 =?utf-8?B?UFhOOFJIalZseW16dUxicHZKV2k1K3lVTmp5UHA2ampydkJTTUUydDQwSmht?=
 =?utf-8?B?YlJxVFFURFJwMUhoWTRFSVM3NmdpeGcrOEo1cGFFY1R3bXg4VVZMUlNVQTVT?=
 =?utf-8?B?RGVkdUdxeWgwck1RL2MxWm03V0Q2TmhleEc5Y0g0VW9xTGM1RGd5RWdrangv?=
 =?utf-8?B?REJZVnp2M1o5eW5odDhRNFBvdnNMbEVzYWFuVHV2ZzNGSTQrU0Q2dEc1b013?=
 =?utf-8?B?WjREVVNCeGFSaEg3N2k4RXhkZzdnb3lCaVVQdndTbWptc0gvY0xXeiswWVEx?=
 =?utf-8?B?dlk3QVUxcjQ2dVl1QTVxTjNUT1h2aFBhRk9kNkxKSzhPUldBQkJsRDN0VXNX?=
 =?utf-8?B?ZFFqSVJDMjc0blIxR0dTR3JkaGhBWnRyMzE0SUN5YVVWL1p1eG4raGg0WGVz?=
 =?utf-8?B?bHdRL09rSFIxamNja0tKVEV4dW9YUXQvL3V2UWZ2bmMxQ0J0RFNYNHBQeGFj?=
 =?utf-8?B?bnh2TFVCODl2aG51cjdLaEVSRmdadFJZTzBlY0NjQWZNWGRTMjlHbWx5R1p5?=
 =?utf-8?B?N2hBb0pFeHRtanhkMGNPYkgwK2l0cytUQm8rWUJkU2RsWE1zMGViT1o3aXNy?=
 =?utf-8?B?dC9VS2t6cXVpNzZRRmkzL0RsUFM3eXNnT0FHOCsxMnhaVmE5dmw0cEErNmpI?=
 =?utf-8?B?dUZYUWJQaG5wenNObzZYSllxUjMrYkh1dWtpRDc5djdvak02Yy9CQmV1RUJ6?=
 =?utf-8?B?eGlZbldtdUNMYnNRbHVTUXNURjMxTTM3clJvbGlMT3ZkaUhkYVk5VktuOTBO?=
 =?utf-8?B?eXNNbkxHZXMyVjg4dFVxRlgvSk5kZUFkczNMSGlYdzJsNHNaMkozUHFkRUcv?=
 =?utf-8?B?bXFHTkNMVlN5bGtyN1g0SlBZK1RYR2U3YWYwOU1CWnlxZVgydGdtN3NrVEdH?=
 =?utf-8?B?ZmxFN01PdFJBcVV0UmpzWkZscENXUm5PbmJkVE8wODdNaWlUaEpSRnc4Rkpa?=
 =?utf-8?B?VjNMM3VhTXhiZUZXNU55RDk5RTQyZHljVGd2UVVCNVNyanIydmxtcnlQK0w4?=
 =?utf-8?B?NHU5dDlySm1mRW8zeDB5a2JPR2t3RTNqRnplcGFQMFk4UWtmRld3Q3djVXpN?=
 =?utf-8?B?QmtKNmhrcU1CL1NxamQxdUZDQmVQS0NrOS9NTm0wRXZET1d0UnlscGc1cFNX?=
 =?utf-8?Q?pw1sVzMAySkQTWm2hG9T8g5PFhvXrJ9ztFOgT9e?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb1bc1d-728d-40ff-ea03-08d92a3c9546
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 05:16:34.1777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XucXZ28MLoUbiftv3uoNZEKgoz8bDsKCMWFp3l3PW0FshqyLXIpInDNkbMH0DFxQY5WWe5fr+BseskS2+8KHUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3789
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10008 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106080036
X-Proofpoint-GUID: oWy9aMaNtuc-PCapJ-vGwzNBb25ys1Xs
X-Proofpoint-ORIG-GUID: oWy9aMaNtuc-PCapJ-vGwzNBb25ys1Xs
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10008 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1011
 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106080036
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/6/21 11:12 am, Baokun Li wrote:
> Using list_move_tail() instead of list_del() + list_add_tail().
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>   fs/btrfs/send.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index bd69db72acc5..a0e51b2416a1 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -2083,8 +2083,7 @@ static struct name_cache_entry *name_cache_search(struct send_ctx *sctx,
>    */
>   static void name_cache_used(struct send_ctx *sctx, struct name_cache_entry *nce)
>   {
> -	list_del(&nce->list);
> -	list_add_tail(&nce->list, &sctx->name_cache_list);
> +	list_move_tail(&nce->list, &sctx->name_cache_list);
>   }


  Looks good.
  You can consider open-code name_cache_used() as there is only one user.

Thanks, Anand

>   /*
> 

