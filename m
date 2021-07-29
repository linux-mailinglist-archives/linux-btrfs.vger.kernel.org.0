Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E093DA669
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jul 2021 16:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbhG2OaA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jul 2021 10:30:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:50210 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234361AbhG2O36 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jul 2021 10:29:58 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16TEBOl2016984;
        Thu, 29 Jul 2021 14:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=sQap+LBQU6iHk2n9ckcEcry9ZHctijepLGONu7sE5ng=;
 b=RlriPgPjSxMuK3V6v/Y2a/va7upIG6EX7TM3T6iRBD+ysSsWSYvA/fnSujS5X5IVD7uR
 so0e58WYBou/uLLq82NUpRWM9UkYt8Kb3AgA99iXrnwyW0MUT5Iu7PKnk+W0tEeGgOPN
 hzZlgQKUaziQyIhXM7KDw+7pXsjs2dd9gVYTj0uMogX0uBDrp0h7cz/9Lqr/4uKNzGKp
 wj5iwFvmsEr+SmRGs0PPkeJMbp8TdN78B6PsnMCDdmtQ11kRg6+PDwhlGT1EuLYN8LYG
 D9/cY5GNq9UDVtgVbTFIhXktJDpjqB6ytkpqpSptwGv+u6rdy0TWBjWhh2bJE8D+W26Y NQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=sQap+LBQU6iHk2n9ckcEcry9ZHctijepLGONu7sE5ng=;
 b=yrzNrQVMCDsGbCdxVfbTRsa1gu+Z3uAJOiLj5jy1MBRGwS8FGg/et+y5p+ieL4ZlVCzj
 iMVeNxLA/eoMLPZhyY80i9zM6EVHPHd60NEDHWmEePePz5V3aPN/KFJ0laB+bmWFiOSn
 5OtewublXBvqg6KGM7guvUEew+P27PgDPMASYZANdHSPFkHdZzhk+k0b/Ie4LV8SCgjd
 vif8f9FULdDZk5J/UyzMq1+4jk3iG+azagqHxzA+o5yU+p5zKtPB6K1wrUqxLsJcJMcq
 6OkHZgv+Kh66mirWTTxG+25iXSJt0F/uCbbbYAXi1xlAF/lTTJml0dQpRXzLejh8rFb+ NA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a2jkfdmef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jul 2021 14:29:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16TEFb84187001;
        Thu, 29 Jul 2021 14:29:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by aserp3020.oracle.com with ESMTP id 3a234ccbqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jul 2021 14:29:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmviE+3uZf8JVaQtaWhEJy5ReLWHs9NCO7qSYrdii6FbfF8UQJsXiGWTV6QNBgx+qL+Hp5COpbIcR6cLLPI8iug0//hXUIySTyPx0cMxvGyiH40+jVgkR2AIjg2cHc//mm/JGNkGiUD+oUk7cAA2s7c5JwGKONtbi1tIQGkR1Z8pFns7RmyNZ+fprMx3frXyH38mIDbHntdTBKiXRc/K36+WSm0e1owBxgn+Tg09OXZ7IZj8hePfFWatb+/YsJRhY7ZBJS/FyPYgKBm9FSWyJqr1SUhot8ulOSpQevwj+J7OPzLNYkYsys84FpDq7veHD8arbgXvRnfx4+B3r3Vpng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQap+LBQU6iHk2n9ckcEcry9ZHctijepLGONu7sE5ng=;
 b=ZLX3O/GFJX+AL7+c7xhBF4+LXLHBXaCgkbEWYK1Q9FBouImerZ98hl30UHHTjO/SIwCUAVXQ3h4FAVYDuk3HChmPTMNAube4B3PKhYC+vgH302CvoDn/U9L6GFy0DJQ+Bq8BXnNPTiEtMQ4ZgWSZafDS2Bus+9fe6b58L9cwqcwk+KL7wEBA1HJzlQFVyUKOKBjOY5FS83ntLA9SJMfoMLrBsW9llIA7R5rHq67KW2zMnZdeWWgCE2OWsvRkKmpFOPGN4V94VeDz45gh0weIN+sy80UUpegMhJawQJaZJc6dFla/3aXwRfd87qAFv9dlV6MRt1HmUS3R6F+MSmn+qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQap+LBQU6iHk2n9ckcEcry9ZHctijepLGONu7sE5ng=;
 b=pURZWMLa2DJlUPTD+B5ZxzQ5WmzRhMh1qtlIBL3QJoBJSCJieo5Hhz3lKOjbSBIDV6oGILLwt+HUIwiPCwjjuDeTlYr1sLUWYDQPRr/GSrU8Sn+Gya2K+ZLNyaZ+Vgv4u99qdQzrOv4F6mlF2XvwiumcsSNbJiJ9kKhD+cd8zzU=
Authentication-Results: bur.io; dkim=none (message not signed)
 header.d=none;bur.io; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2772.namprd10.prod.outlook.com (2603:10b6:208:72::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Thu, 29 Jul
 2021 14:29:40 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%4]) with mapi id 15.20.4373.022; Thu, 29 Jul 2021
 14:29:40 +0000
Subject: Re: [PATCH] btrfs: print if fsverity support is built in when loading
 module
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     boris@bur.io
References: <20210728162209.29019-1-dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <12540898-56d3-53e5-df01-21189acb40e5@oracle.com>
Date:   Thu, 29 Jul 2021 22:29:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210728162209.29019-1-dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0163.apcprd06.prod.outlook.com
 (2603:1096:1:1e::17) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR06CA0163.apcprd06.prod.outlook.com (2603:1096:1:1e::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend Transport; Thu, 29 Jul 2021 14:29:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1870d91b-aebd-46f1-4833-08d9529d4cdc
X-MS-TrafficTypeDiagnostic: BL0PR10MB2772:
X-Microsoft-Antispam-PRVS: <BL0PR10MB2772189EFC0EC4E301A48599E5EB9@BL0PR10MB2772.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:407;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gqHjC1ElJvOImAlEIAbV3sSoYLt7B/uNRIvz4dl4YKG2C+pEz+bLwJlqjhDUGJ6tyGUrVBDasJdCxyZGFteFja84N/7k6ByReJ3B17kwH1vvtIfco9LjbHkM5aSBUVbs1vCc4fBFhcFqdrodIXwf7UtsE7E6DlnYinZXmOqVzAiaMcOOExIjsLe4SMZ/WbX2n0x2oAKFbOsssBJUust5dilBotQxDTqDZhWeNQ+zhDGUNxtNdC8nqMOonqdOCrHtnNJegcBEiuQyBAEjb3crTOrFAswPGyP+QO72FDUHw/Pt2SexfT+majwMtXJUVY+ujZ+2WP6OTv0RAl8h7RNECfkZsc3ZGnmPmOmxXKwlbRkdnFPFvZsUMuPaBBtarfCZ/P55PZ25e5dDToc0jCvMNY7o1vDX07u50R7TUTkvKUObwILlVafFQ7sh2EMlVU+C+QeMpm8rwlICs7cgFdoqP/7hg2hEGSJi8CTOyuHTUFvhiOzMP4fHs/PZjJU4Gh9rq4nncP9gFzHI0yixzEIMbzGJC/3JFbc+h5vVu+os8BCzaAGPDGfXTmMQUAFnbyEORM28Y2jQ+oZbUu2AZxUOaV8sdAUfKUhDOe5t+XqjVEy9wl1VCu/HvP4PZ2miofTvBVC4NQyTMHfT95sr97lGHe+weEqQDdUqD576HmXcBOcDvIKtRiyOuGWXcJ+gA2VWseTBdCX/bqtkZG7cuAoRsQVGQCOCJQPvf4Pav1RhuD0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(5660300002)(38100700002)(36756003)(16576012)(31696002)(2906002)(6486002)(86362001)(4744005)(8676002)(508600001)(8936002)(31686004)(44832011)(53546011)(956004)(26005)(2616005)(6666004)(4326008)(186003)(66946007)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTJnWWlEejBacG5uWXJHMDVhZkdnTHk5TDM5eTRESDhydXFLZmJDZGg1NWRY?=
 =?utf-8?B?YzRFZWhyc0paS1Ezem02M1dwaDVnRDFuVDBaK1h4OHBkNWMzczlsYkVVbDQz?=
 =?utf-8?B?am9zdm5yMzVTRldQM3pFL203eVFBS0ZHdm9mS2J3VStHQm0xRmJ0bkdtNXRa?=
 =?utf-8?B?SjRxYWZxMGVDYzF0eTREQXZoVHRWeFN2dThNWi8xUjdzbEdGbmZSbmtubFhG?=
 =?utf-8?B?V1R4VHdVdHpEWkQ3TE9ObFgxWW9SQ2N3NjJsbm03dGsvdnlKU01KNkFQc2dv?=
 =?utf-8?B?TlZhWFcwak1HMUtScGxHU3NIMVNyYW5JQldNZkhrOVJ5bjY2eG9rUnh3VGQ1?=
 =?utf-8?B?WDZmK1JWcEswMHdPaGt4ZHlrbTFhOU5KZ0QrNitOOFZOcGhkcXZXd0M1QWZa?=
 =?utf-8?B?T2FwWnYyY3ZNajJqOWRzZjlRMzBGVFNabms2L0lyYjBaRjk5UzJ3QmxYQ1A2?=
 =?utf-8?B?cGxCSGdhMnYwZHR5cGg5aHM1LzVUSmFDd0dTUUJpaUZ5SnRIc0FYeERIQmNo?=
 =?utf-8?B?MlNia3dJTXpFTmlWdFFPSDdZeDZxaWtGaklERm5DNFR5RGcxVnNEcmdONlJV?=
 =?utf-8?B?djc1Sm9QWDVxZjMzTG1yVnpVTk44WStmT2pLS2tQK3hTZnE2Vm8va3E1NmF1?=
 =?utf-8?B?aTJVaXlldnZnZEtRWmQrN0pTUm5hYWVKTkc2UkxSdGVtdW9xU1FCNlV2UTdH?=
 =?utf-8?B?cDh1b05BcGZHL09tdWNzQjdGU1h3c25lSkhKWWVqaVdvMkZGYWdEdUFON1ZW?=
 =?utf-8?B?MDBWTVFVQk1SNGg3NS8xU2UrS25NdTl2SklYaTFSTUlmNkFmUCtFbVVjVitD?=
 =?utf-8?B?WlgvM1ZTNkZmVm05QnZFWUd6YUlETit5UUQwQ013UDU1QlBmWnNuaUxxYVZC?=
 =?utf-8?B?bzFueDg3bDQ4WWZNZHM0dEpXYzluQVl3VGdETjRkL1NkMWpCVWZJWDM1VnlZ?=
 =?utf-8?B?NllzTVd1YkRxMFdoWC9HZExDTkQ0cTN3ZC9jU2N5T0ljNFRHZG9kRzFjSXFX?=
 =?utf-8?B?Z1BNbC9aN2JEdisvUFE5WjJ5RWpJRmpsV21tV25VQXo5TEpGK2UvTDU5WXh0?=
 =?utf-8?B?L3gzYnphdjNIMUQ5dnJjMU1tL0syVkVGMjgzaWIrMVN6MkhXdmhOOXE0N2pm?=
 =?utf-8?B?L05KN0Ywa0dGRGdyTHdObFBVVCs2VEsvSnJaQUxhdjJhV0lzT0VETjFTREpY?=
 =?utf-8?B?cTJKNVJTK0E5L1FOUEZvM25JbHpoYlM3Y3Y3RWN5WmxWWFAwSG1QWGZoeHNB?=
 =?utf-8?B?N1M2dmdicGdCcXdUQk1HLzNvSGlRd2ZXZHJ4dWd5dldRYmRva2ROTG5QREV4?=
 =?utf-8?B?d1pvOUdVdnBiS1Q3N2dvY2RzT0w0Z0VOUFdDdEtaUDZGT01sMkdxb2QvVWdN?=
 =?utf-8?B?U2VFcnQ0U1FFdmJhTENDdUlXM3JVdCtWVXFSVEphUTQ2NmY4dkhuMytFNlJj?=
 =?utf-8?B?MlJtU1lZOFY2ckhZYlhnZjkycGdQYVY1QmhGdG9QdHBTeGFRV01aUlBxdTZ4?=
 =?utf-8?B?ZWpNbnYxTzVyZm1DMWQxNlBobHp5c3BKVW4vR0F1Wk1VWW9ERDZQT2xyd1NN?=
 =?utf-8?B?ZmVDUFdOMWFpM3RQV0x0N2ZkbVFpVzhIZ3ErbGVwTllWMm1USXNVQkl6Zy9n?=
 =?utf-8?B?aU5heUVyOStCdGVYSjRsd2JUM3RLby85Q1NxamRYSDNGczhqbmlzSHpPNmdI?=
 =?utf-8?B?OGEydG0yckxLd1lqMGlEdG1ja1liOENXNFo2SE9HOUUxS1Mzc1JROHo1WThY?=
 =?utf-8?Q?7RsmtgMtaJWG3z57pBaFxZNIDm0JYkaB5dhrUSp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1870d91b-aebd-46f1-4833-08d9529d4cdc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 14:29:40.5968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFKePVAU6E0/bPEcoBu652m54rw4DT3rB6mznLuoIuk1Dp4mD+/AtxWogQemZ7za+PFx6kSKaStsbwromqIT7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2772
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10060 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107290090
X-Proofpoint-GUID: pPzkO2Rqx7REDeuT9D5saO0ZkZCg7jiH
X-Proofpoint-ORIG-GUID: pPzkO2Rqx7REDeuT9D5saO0ZkZCg7jiH
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/07/2021 00:22, David Sterba wrote:
> As fsverity support depends on a config option, print that at module
> load time like we do for similar features.

  So similarly /sys/fs/btrfs/features/fsverity may be required too?

> Signed-off-by: David Sterba <dsterba@suse.com>

  Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks.

> ---
>   fs/btrfs/super.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 2bdc544b4c95..d444338db3c6 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2566,6 +2566,11 @@ static void __init btrfs_print_mod_info(void)
>   			", zoned=yes"
>   #else
>   			", zoned=no"
> +#endif
> +#ifdef CONFIG_FS_VERITY
> +			", fsverity=yes"
> +#else
> +			", fsverity=no"
>   #endif
>   			;
>   	pr_info("Btrfs loaded, crc32c=%s%s\n", crc32c_impl(), options);
> 

