Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC19D60587A
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 09:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJTH16 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 03:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiJTH1y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 03:27:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA72F15F93B
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 00:27:50 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29K5odYb003938;
        Thu, 20 Oct 2022 07:27:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=x5pWDo0OtZOOynQ2xM2C+5MjqUIIeuc7bS3XqjPojUk=;
 b=Fp5Fa/OiHGK8wpb0qT6KjJwVAZYoqXDko3MKZ3VPMeItORL1epeR1+cnS4ezcW1UModl
 pFluLMyqsUEcG0xeKLuaPP8Vfr7A+kjQN1PltPvzGs6U8eZOYTTgHBiUNnEihMqyMivH
 +WTurpiM/w2e3Zlq+tCxgYgjy3uzvyGBTT5qMXxGBNhL/BHPMo2QdiHb9Kx91xSlq8Jh
 W6dzvM67WYWJHx6lTpB1DqFzmCBtPEjZRIv9mgUD1a5ovVAmpc7FqFupKYE3hJwvzEVd
 YMOVEZD7vF2Pb8CiVaSYAc0mGABOK9MClhNrFUprSZK29a4TwguJvyV6tQVC5y0GbezH Xg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k99ntgf30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 07:27:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29K3sS65002887;
        Thu, 20 Oct 2022 07:27:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8htjaad0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 07:27:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaoEWa5AU/Q28aMajYKbhItIDzO9Pijgf8GplZcKH5tcNfoA5iI84/Jg074bbufdeoqQR6wL/Y7LjFBYScnUqwdQCWn2ALquyoYr+JeOwhIZjLISz9OCApe8jxepmmJjKUhPNf/SAeGRkDC7S5GYxzbHi/NTB58hLuO5Dvh2BKkXQYAkE5L9CMpJzCrEhVKHSZitSYJLb+CblCNuoFlfLyOzOYLYsEBJtzmv83iLFvfFVbKy6qw1FjDhBy9KQ28HF5aYTChU9m4HX8AIZQ2WXeYuRfdVSqjssg072zERHU0iUHkHTlA7tWJkuF5RCdx3Z6kWrodNtaVC44BXDbCfJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5pWDo0OtZOOynQ2xM2C+5MjqUIIeuc7bS3XqjPojUk=;
 b=M6ccGAzBYvkRXxB9QY/h613woTv3zqwVEyCmwWUuqdORMekV35pTEnJghAafXctINyWj2PFno2mQWC/JqIzGSZNYiBXSbngOaE9nNjLuc7QiMXaI3X7vNQQC/VDh7PUgi/+Syk13yQKKElAX3t/QsGZ8JIsO/QvLRLU8YUr9HIDNqoGs3ieblo8T4+6bDjbK9ZEloR563FcUfLjfjbdl1ShQ6HfCrUWqnKiC3WRXT3FQ2n/r6ktE9d+45JZYJIc9huNmlpVscFQHfMUv4GuXFz4SjtntVaB8+j8e4RRSbhazO6kjn7Eu8OM5xFqoTmLGkkVjofi+qQr9zfQLyvOhhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5pWDo0OtZOOynQ2xM2C+5MjqUIIeuc7bS3XqjPojUk=;
 b=U7ZtWzMfgk93nACoMR5YfzMGXmnKsriQquiVZuDRZ+17lQD4/YZsfjFsOzI5SUXuf50Phjor7vpNB5vlaP6E4OuDuiJWZq8/PbNAABESH2mlyihqSkCLXguN6en7Ma56q/6Rn4cmig5+jE1fBxKybUVGo0sCLVUPOzeEvxChu8U=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6364.namprd10.prod.outlook.com (2603:10b6:806:26c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 20 Oct
 2022 07:27:39 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a%6]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 07:27:39 +0000
Message-ID: <d21439a6-1adf-50ff-c409-b87ef87f54c8@oracle.com>
Date:   Thu, 20 Oct 2022 15:27:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 3/4] btrfs: switch GFP_NOFS to GFP_KERNEL in
 scrub_setup_recheck_block
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1666103172.git.dsterba@suse.com>
 <aed6063361919c409c72b208d361be0a5d094b3a.1666103172.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <aed6063361919c409c72b208d361be0a5d094b3a.1666103172.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0177.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::33) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: 5058afe3-2d63-451c-3067-08dab26c9174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ph5XKCDr88flnk2gpip9c+AUL1aRYA7E/Ld0m4lE230btHvxgjESt/fygqFFdiswnZR0WNbDfPtpxFBgDEkA1t4LSlz7ifjZHZyFFWCtHYdBAb+3x6elSPa+rWY3wXz7ZKMcTP/jf0IaQRDy3nzmP05jvdoaFjOvSGl88hR84FpnEKrJ61MgPoZXlrzINui8FD2LveTQX6IuCIh2U/WBcbXcx5olVEQPm14SrrpdSQopyucD+DK6c6TfOJEphXaX9uhscWBizB6jYfqe/rOEeLepFxc7/E8kCWZaGuXscYsA37MwSKhuJT2/wAxbDa0nuvSii/H9yyvPtX2GXgBM39MEONPL9v4Ap8OBsEbcAdhG44LzqXcjlTMorW2V7hAcd0/0AjJjBTYBsseUEUpaMLVqCpWPUzkRbhQjtxz2HDGDQ0uSJG2Q/k4F+4S5TQJhZmKfazHmBe5zbup5MAIxViyc3gWqBxq2q+85P0p4Mx1aCqOOHkK/p6+DxDVprjqYBjom/mrJZjHkCnDhIOEhe8fH/CoOnKmCZYzuL7+1tJCzJCJUL0RxZ25l+5fykocGPQXf8XFAm8amFdaGDau0BybSrOaxjxdEjBQRoCAd6tJPZ2rxvrDCZHOaKzZCZorKwYfpjeznk8TPMBsigDNZYd/kgDbFo4vw66vDet1Seq3RGJnlv/50RqIkUTG3YUhr1yK6zPxCjwAYuBVmEEKOoWFRTKKX67jXzZT7ZNzthWIc7CXrIO0OkEozx5OKzuYwQjXHnGdFcJ0N9/kDhoDdpq4rdmsovJ8Go+xe4Ia3JWk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199015)(83380400001)(36756003)(86362001)(31696002)(38100700002)(6666004)(478600001)(66556008)(316002)(31686004)(5660300002)(44832011)(53546011)(6506007)(186003)(8936002)(2906002)(66476007)(2616005)(6512007)(26005)(66946007)(6486002)(8676002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDFFbW4xRkpGUWpWU0x5aHZpaTY1aTNVL0llZytJTkhrdmdzL1RWRTJvb3p1?=
 =?utf-8?B?T0YzY2lFNHdPdUhhNkJ5YzRRY3d6SHl2cCtyOW9DTFJwQmFxL2o4YzNtbVJx?=
 =?utf-8?B?Y2FDYko4bjdsZ0FYRkZMbFVYenczbWh3Sld0REpHMWQrS1d4OWRER0dNOUky?=
 =?utf-8?B?bDJkRFZ5UTdjN2NCdW56aUtxbWVjQUVJSkJwa1Z1c3JaaHFrMHNyZlFXTUpj?=
 =?utf-8?B?UGd5UzRXdFB1QlVKNGRidVZPTmlzWndoWXRxYWdkSlFqYmtDQlFtSTY4Wm5F?=
 =?utf-8?B?K0ZRQm1JV1V6dnJWWEc5eTlkS0NhSDJNUFBUZGJNR2FBOGkrMjRyL0RtM29Z?=
 =?utf-8?B?MnZqUlFKVEVHd1pqYWgrMWZLT3l2ODVmZC94WFVPbE5wS1czVzBwbzE3S2Rv?=
 =?utf-8?B?cW56bjJXa1k5UFU5OWFUUWNXRWxjaWpRdE11dVEvRVFkNEI0dHVyeWI0czdr?=
 =?utf-8?B?dHVkS2lMUGx0bnJ3bG9Nb21HbVhCUU5mcWc3bk52TzdmMXB4NmhuY0FkN1Yv?=
 =?utf-8?B?L2NGd21Mc3hLNjlTL3phTUZLZFBqMS9mVWFNbFlIc2ZpUUt3Z2RBTVhuS1Bz?=
 =?utf-8?B?WGhmNHMzcHdFamNGdHh0S01oUnAwRTBNUEE4d0ttYjNRQUZZbVNZQUxxMjZy?=
 =?utf-8?B?eGsrVTE0NEkrTEcwa0dPa3pMZmhObkN6cTA4aTltbWp6dFdXSmJCNnQxVm1H?=
 =?utf-8?B?aWJtNVNubmFhWWJ0RFJMZHlqTk5NSGQyci9MN3FrUGRLYnMwSE50VGJNTU1S?=
 =?utf-8?B?cFNZMm9vWDNna21QcUhSOU00OS82WTc4Z1hZc2tzQmxYeTBwbER4enFrNkFp?=
 =?utf-8?B?L1ZPNXZndUJwL0pPMkNYaWFqWkUvTDQyc2JDUXlwbDZ6TzhnOWNLd1RVVEdH?=
 =?utf-8?B?MDl4R2FMaWgvYmUrYjlxM09FeEd6SFk3bnE2K3k3VEx6RWhZNDM3Nnc5bndt?=
 =?utf-8?B?eHRoTkxaalNsNnV6MVlnaEl4RHB0anppN2tOaHhPU1NBVHh1elFXeDBoM0RO?=
 =?utf-8?B?YTN3UXhsNjk1NUhoeDBzdldTZ1UvRmcvYkgrbHlFNnMyRUlxSE1kTXNpZm9o?=
 =?utf-8?B?QjltL1pGTDdyQi9NUElBTFZmNkNFU1pEOUlyeVY2NlRubGtlRlNYQVkyYTBL?=
 =?utf-8?B?Qlc0VHBNWmJ4R0l4bkRZU1kySVZoRTdrT2RCY1l4SDF1REY3V1NJMGlDTHFa?=
 =?utf-8?B?UDY2VlVrU1JmRnZOU3pyN2V5OEhKbHZYb0FkRmRtcUtGM1NINkNMR3lmd2M4?=
 =?utf-8?B?bngyWDFwZXpPTWIrVWd2aDFvYURIYnJLeUVVckFBbjljWTVnTlVXV1ZXRC9s?=
 =?utf-8?B?b0R0aVN0NnpFU2dvR1djRzJXTDFwOFUxc0kwN3dXSm9PdkR4UW56RnFDSGVW?=
 =?utf-8?B?MFZaZHlaTVNldkladXhGc3V4azRjSC85cTc2aVZHTzA3MkM3ZFJ3dzNKRVFy?=
 =?utf-8?B?YzdkRFhnNmNzcDAzRzJOWk9hU2lRS2taekR6K21aNGJHQStheTBJRm53NEhn?=
 =?utf-8?B?UkJhYTFQTlJKV2YxN21DSkVmdWd3Tk45WDBGWjU4LzNkQ0IvWFpZdVAvVXMx?=
 =?utf-8?B?UzdSQ0tJU3c3a09IWitmVE9hZEs0d1FUUTErd2hnU1NPT3pGSy9hUTJVZEdi?=
 =?utf-8?B?Mkx6d3FFTjVtODRIUDZiODJhbTBsY3JYZCtzeG9BS2lZS0phakFobVBlWkNw?=
 =?utf-8?B?VmUxcVNSREpXRTIrblhxTXNsNW1yRkZWSnRYTE1wNDAyblpPM0lkUVNORkc3?=
 =?utf-8?B?azRTdndQTE05NTlFblhOQ25wRE1HQmJHOWptZjhVWmp2UENUVHB0YlBIczJR?=
 =?utf-8?B?djFsaUgxbitpcTNORHprTVpiTEhZaXViYlV1MG1xaUJ4Q2s1NGhIRVRHLy9J?=
 =?utf-8?B?N2VjbFhhd09oSDdiaEo4ajE3RXVMWFJENVA5SHo5d2N3bHMyaWl2dVdLWmxl?=
 =?utf-8?B?ZCtsVENzL0pQcE5oeWV0Tk1HOEY3dXRKSDFkYlJ4UXhCVlFUdG5iRDhCa3Aw?=
 =?utf-8?B?ODkxbFR5R2NwNnBwbDBHY0UvZmtxekNUcUEvSUxJOXJIVnlvci9HSnN4S2lW?=
 =?utf-8?B?Z0dSR2QxbzFEZHJCb2VYV0dLbm85M2VMYjZ6SlllNWtJZU10VG5GZFNBaFRl?=
 =?utf-8?Q?vGsCvcyDn8QBKdEGDmR4xXsv6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5058afe3-2d63-451c-3067-08dab26c9174
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 07:27:39.6462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/wdxewphCQDYLCRivG3AoWa9j/L6/ro2veSF1ep6vqXNPAGWkwa8fqmTH4dX7Ky4OFeCfFJlfr3+y7/tuK2zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6364
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_02,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200043
X-Proofpoint-ORIG-GUID: b_kZbF4Eai8BBgTzx0Zp11GnCBL9GeLs
X-Proofpoint-GUID: b_kZbF4Eai8BBgTzx0Zp11GnCBL9GeLs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/10/2022 22:27, David Sterba wrote:
> There's only one caller that calls scrub_setup_recheck_block in the
> memalloc_nofs_save/_restore protection so it's effectively already
> GFP_NOFS and it's safe to use GFP_KERNEL.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/scrub.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 9e3b2e60e571..2fc70a2cc7fe 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -1491,7 +1491,7 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
>   			return -EIO;
>   		}
>   
> -		recover = kzalloc(sizeof(struct scrub_recover), GFP_NOFS);
> +		recover = kzalloc(sizeof(struct scrub_recover), GFP_KERNEL);


I didn't get why GFP_KERNEL is better here, or would it make any 
difference, given that we are already (and rightly) in the 
memalloc_nofs_save() scope.

Thanks, Anand


>   		if (!recover) {
>   			btrfs_put_bioc(bioc);
>   			btrfs_bio_counter_dec(fs_info);
> @@ -1514,7 +1514,7 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
>   			sblock = sblocks_for_recheck[mirror_index];
>   			sblock->sctx = sctx;
>   
> -			sector = alloc_scrub_sector(sblock, logical, GFP_NOFS);
> +			sector = alloc_scrub_sector(sblock, logical, GFP_KERNEL);
>   			if (!sector) {
>   				spin_lock(&sctx->stat_lock);
>   				sctx->stat.malloc_errors++;

