Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA65976AA3B
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 09:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjHAHp4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 03:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjHAHpx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 03:45:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5622689
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 00:45:35 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VKL4SA017799
        for <linux-btrfs@vger.kernel.org>; Tue, 1 Aug 2023 07:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ZhHig/71V2KUFMz5Jwyko14+/jszWyhiMW2jCD1tE2c=;
 b=p7QyiK03/elFF8O67bS8nQGxVSEYM1YLlAbD/S7ZtdCaUefbvldx1fZeeI2agXX2Kpoa
 /sW8tPoV/L5cFWHasjpLW3qbdA7Ln4WtqyEiuU9a6ejzHYbP3ssTH8iyw8cmUhDeU+po
 /uBz/obmsAAMW83I0+AfBRKp+Y7OmjItAcrOk2hPBlXlXipuRxyn02RXyKr2M8OIXMGh
 t3E1YFoy9AG/qyhgOw3IZOhowpNTVuSLIEDqrKp+0luq4xy8cBbs9A29BDaeZbtHn65m
 VB4n+bVfz1XjsLcatNA+Fk0+WZbk67bUub5FdNMLswF72TfXNZ6MXR8mkIu8mEsGAgpU yA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4sc2cc1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Aug 2023 07:45:34 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3717SSNq037492
        for <linux-btrfs@vger.kernel.org>; Tue, 1 Aug 2023 07:45:33 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7ccu69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Aug 2023 07:45:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHUxMcyhWd1xfV3aKAf0Q6nApGCcdbks6rE4hkyhF1G7y3ZBBg9sf+ao7IcQQDq09caVnCfV1sDyEJG6UjV9JJzxHcWj9nmaUA1oYCIlLZn+9suDZYzoVkyYC5jUsdrOw8xh7xjRFDo4I4YMYI21g2TPQHYjILk8s2YoCV3stDV2ZmSR/Smn+Nh7qq2w57vbF4JpXagoMZCi1T+BHhouMXvIbMy7IJAK8l7vJzSNyhRGQiZBixd6U7nDQw3Wi+j8BqKPUySSBlgIEpK73mjsMOqnuu6FecWZhFnWIFcDNcDa1KwtKq0g4eBP7EYvp65QlRzI/dWK4WV+fJtP8pROnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhHig/71V2KUFMz5Jwyko14+/jszWyhiMW2jCD1tE2c=;
 b=dqBrym+P965WAnwS3XMWWkuWxsMJ1JfZ3zg4kGKflsQBfiOl+iKtDp7cCmNgTcQDnEXBIPCHIntFFpDMUWb4QLNBZ+s96LVEeLJv0blHPyr7Hh6HzeOuqqE74HmyBjvaCSuyeDzxy2T/c1pLPVV029/VwySG0SsiizhGvsmi3Q2sodQd6noWzyUZCXSUZl7/Vbn8+lBC9zIecsV50uzZLZetSmcDrIk4oD0iDtAgjxzMF8rP1uLvnUZMksPa16mTJFRePKwZ6RJcX0yZ0orimMQZ7AIRUyeH/6VGerCOhL1To07qMiE8O9xPEi6rbjdEj48JTXcqb8OuM2JA3RkvsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhHig/71V2KUFMz5Jwyko14+/jszWyhiMW2jCD1tE2c=;
 b=d6NsU3yqYfkKIayfnB/dbIeQ2jM8ZWnhWgVFo+CXQtWGCKek7Sw1cts/08V7B1Gz++6rF8jbbdADz2F33MDu22m5ouZ8w1JOsnjWgDo5UZxXKfPdWDbCtRzNh54crcNiew0vctcrMu6QvE8s5eYQ7NSeGivSXbigW+cHyd+Eb1g=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6856.namprd10.prod.outlook.com (2603:10b6:208:423::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Tue, 1 Aug
 2023 07:45:32 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.042; Tue, 1 Aug 2023
 07:45:31 +0000
Message-ID: <2bb45c33-7944-2969-0b5c-d3cebb6fd129@oracle.com>
Date:   Tue, 1 Aug 2023 15:45:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] btrfs: fix replace/scrub failure with metadata_uuid
To:     linux-btrfs@vger.kernel.org
References: <50a6bd0ecd4e9e2b900de07c8ea47b71959df8ca.1690526680.git.anand.jain@oracle.com>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <50a6bd0ecd4e9e2b900de07c8ea47b71959df8ca.1690526680.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f6f2ab9-f6ec-46ae-55c1-08db9263484a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6J5cAacb052PijU9JsTiJz6q+Wo0HIXpgNEvuST5oPYi0q7aN/S18sYi2lfGxOwZJq75ZqhMTKobQLmLDhpZz4pQ50nzCkR2g0/IzAdKjNMcws8+LZlERAQaakbC2SMb7IcYKVzED3QTbyQp5PJZ/J+8/3L972nP1n1CVYV+rBxyAB4qvMOVa/u44C7ZAwiVLr1vTGO6EQMkhrpsq0QCN0s4mLj2LTFMm8SqC4nQtUhJRhJtBowKYb14zqUVF0DEgTrDdhIhLuo57JlZ4TXe/tGbEWXsNe4v9lbW2n/EdffiUc6WHzzZySZA3y3VBLdEIA4Feyl+XeU7wbI/0Wc9K1S7qRbESvB1S5ZIAA8mLgYTyb71eSkxtaNDNjRm1p/SPkig1vqHZhoSbnwhJfcOgsJdMXyUU84M6wvWRXmh7xzYomkupx95A96WScHyC8+uzqS08iOHSrTwCLS8TYLGokmlphFNOzhDBh4FN+emxbETJgfGUl47WnxdyfZ14mBlGWR3wzgpq3/PU/zeQY0A4jnbKbSdAUHnA+Cfe/tbKKNzgLnuKBa4IRrHRUNB8I8zzFbMyfrn4B01jnjL44G1Ts9cQf0ANa0ZWBJrkpi0vSXlml8B70oCYmVYLmSdt7G9p4Jhaa6vEZaIj780nPDHIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199021)(38100700002)(31696002)(86362001)(36756003)(6512007)(478600001)(6666004)(6486002)(2616005)(186003)(53546011)(26005)(8676002)(8936002)(6506007)(44832011)(5660300002)(66556008)(66946007)(66476007)(6916009)(31686004)(41300700001)(316002)(2906002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z053V1hjQmpIS1lDK2VOZGRlQWpsODRjSmFFTFdoWHpFcnMxL3huc2F1UVEy?=
 =?utf-8?B?RlRkVzBXZHRVSjgyaXlLZU04MGRreE5mTHJ6aWtCczBieTNiSVJUa3ltT0ZE?=
 =?utf-8?B?UmVENHFYeEJrK1BsdXhLc2dBaU9oTG5VRXNzR2plZ3UzNjZHc2RDd0lCZlNM?=
 =?utf-8?B?UjlSTmhUcXY0WXFRK2MySHQ5SXBXSlZiNC9QMDV0MDlSS0pRcWFkVkdUczZ6?=
 =?utf-8?B?Mm5JcnVDc3NzdUlNc2F1ZG1nRHgzZjVZUk1hajhySlM2MlFJRUVUZDllOWk1?=
 =?utf-8?B?TGtKZjFmTVVTZEx4QXUrT1h1VTNTQ1RqSEdFYUNSWXU3V3VpdS9tNGVvK041?=
 =?utf-8?B?ckpvektKNm5PamtuR1RvVDZEa254YjAxVnB4UjRvU1BuUHd3R0hTWTZHQ3dP?=
 =?utf-8?B?Nm5ib1pLbkZoTFQvQklJVi9iM3Nya0k0emM0aVV4aGxlSG9TWGdra1pYbENJ?=
 =?utf-8?B?T2JCc3FhblMxWm5ocnZsV3FEV25SeEY5aGxrb0l4cTNvQlFscytaaVJtTjM1?=
 =?utf-8?B?VHN2aXEzTy8vcHZ1c283Qk50ODdGUnNzN3FrTGxCUHplWmEvcmdwM2hxTGls?=
 =?utf-8?B?d1dTcCs4RU5kakFXRHQwYWRSYXA2SzVnaFNXOERsU0J2bzFyNzQvS2ZrU0Zp?=
 =?utf-8?B?emkrRWpIVVU1cmxCb0pEWU9PRzU0b2RxOWt4bFBQeDRQRFNCVXBhRjN6TGwx?=
 =?utf-8?B?bjVBRkVZZmhzMWpxVHREeTFHcU1nNlc0cWRacktxOE93bW1pQkxSZzB0cW1W?=
 =?utf-8?B?QUtWcUtTUVM0dEp2QjFMWGlXU1VSd1ZtbHRtTGlwZWdSay9FLzBMajZXSm8x?=
 =?utf-8?B?d1hzcVF2SVl0V0tudHRBT1B1aDhQVjlXZUFtRVg3MExaYUsvZHVIdnk5ZC9U?=
 =?utf-8?B?Y1IrcTJzbmZCSXlFT1Q4bzc4NElXZ0dZS3ZTUTlRZmRQKzBWcldtY0NHTmF3?=
 =?utf-8?B?ckpNNXhvd3NBYmM2MG1pSXVTQ2JldWVNcXNvUWhXaWkvSTZISTlSNUJSS0xl?=
 =?utf-8?B?QzVTOFJnTU5BN1ZmZTZIQnQwaXVqQVpNRERxcTVuRU5TMmhjZ2haY3VLbGJE?=
 =?utf-8?B?eW5yZzZCa2FmVTc5T2xhbVgxNi9ONkUzRExYMGRTdzBNWHZaNGdYTE1vL2hR?=
 =?utf-8?B?ZytFRkErRzdZVlh1V3grWlFuUU1SMUJ0cCs2OXp4clJSUUppOTdkeWpPb1Rt?=
 =?utf-8?B?VlhFdDROVU1PYXlaWEdFKzlRdmc5QWNCN1czcmlaand0U3JyUUlaeWZRMXhZ?=
 =?utf-8?B?emxhbDNUcFczczNQSUpnS3dQdFVLdDlMTUxRbjlBeEFqYklBODlIbk50MGd1?=
 =?utf-8?B?blh6ZzI4NFJGYWtLN3p3NEtzeUxWZEJWTzhsZDFPSElOZmJXdDh0d2RBN2R4?=
 =?utf-8?B?bldlc3dkakFLNDBzeEZYQWdXNmUwR3pKZkExdm5vZGtLM3dRVXZkV05jd0NG?=
 =?utf-8?B?b0lDQXprRmk3b1FGdmxmM0Vhdng4UDNkUzVqc3pXQkZLMXRiQUhPQXFBSmp4?=
 =?utf-8?B?WENLTWZxQTVuSnZPbmRqY2lMZ000WlVKei9TN0FKTzFMeTZDNWZOMFFJNU9Q?=
 =?utf-8?B?Y3hRMWhJK3VwbDRVUFZKNXM4VEF4dm1wNnFXeEJJNEpuaVU1ZFBySlVmWkRr?=
 =?utf-8?B?N0NpQ3FMbG16SU4zQmV4cGF4M1RPRkpPdHJMVjJVbUZhQVVYR2I5ZkpjYWdj?=
 =?utf-8?B?Wll5VGtpNkdwR0t2NHVvUDhENXpzZVBKcThVaHk4Z0ZnQ2NUbHBXclRxb240?=
 =?utf-8?B?QlN1VkhDdmwrbVdQUDd1YzNlb25BTFBtTXJxcmwxd2xkT0MzVWZ2LzIrbDZV?=
 =?utf-8?B?N0U3VXIxYjBPL0Z6cytVU3NFOG5yOFY5MjlDSjFTK1hyZnZwZVUrNFQvL2pW?=
 =?utf-8?B?RnVsTE9iR1A2aHBlTzJmcHZXZ0c4c3JkUFMxQWpaVk5LQWIxVC8zZ0VRVFZL?=
 =?utf-8?B?Sm15bEZVeVhleGY5UXVTa3N2NmFXNU5HWHNMaklRVTdZcFdNTGptSXQreE16?=
 =?utf-8?B?VUhVQnRtWEhVbDMvK2lGNFBIZFJGbHVXYWt4M2tOWnAvd2xNNmg3ZUt4M3pE?=
 =?utf-8?B?R2MwT3BseEx1Y0JOYWUzRnhGWkdsSGRwM0NzT0hwOE1kYkRrTWxyRzhoME5Q?=
 =?utf-8?Q?xnhwoKn1d1r57lSCo6b25QUG1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: B7rOIYFVWA/n2kW8WAFaMnW0NQgTsi3TXZqDL1/w/vZxQVAs3lshFT6hsO3Dd/dltz718/gSAfdnteXcBLlRN/1qaMrZxuVwld5bUWus5JL7WichWOiW4MVIKt/ohLnA44+B/YUXHW8hCbuQ9LdpSegrtP+wQi85hechVkkdNQJgVAdzOLmuR65LonBs/jiCpX5rTtD81e0VsmyUNCAsFEiUL00lhtnkk6xZLdSEP/e75URPiuSTtjBfIsUVxHAY+Pi338HUz74EBckjKbF6/XHFY6K/Sq0lBWnQDiTbl9cv4OV1EsWF5izLBF/rPKf67AoGnyGDQThgm+wPrByKQH/LhfhUC8f1zBoLh+myRZD4A0sghJ3bbO8+ZYbbVHNQ9vS6TRg4DnQpOuBuW3EEi8Hkjf+7W09pNNjHUF5dsS0eXuVeKJgssxBAkFrPYgSFw4hOMSVN3caFyH9+4IEhZ15Xk9wYwZhKmjhBYP99nODxJpay9cR0YK0ti4PFfxzQPxIyY8sh0Je1Qh1TnEprIZTvm/KCoXUCQuNo9DbNzzMCqZEc42QVRUGocEOghqZhullOmC6Y++Ppe4610/dtpSVOgwrjGWJOp/yLS3nzOOxF8K5WIOnZcz3P5Rh3MvRvvlMl3FVD3UmxB56UDrWpxAtfS6RtT9Cwd29UDGb7crYMh24OrDvSy0W7k3Y1cIc9yLwp4r/QYvRFCM5rrhmFCZ0VYHVxiHrh/TcivFdoZ4dyBuuhIGla0PWUcAnal2pj
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6f2ab9-f6ec-46ae-55c1-08db9263484a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 07:45:31.8996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MTBUpsL3ic4O3+pXe/uG9DrATiNIas3d0xCYVs1q2cgf7KFN+oS8X4D6WAgHScEJqi/dZNA2FxqtctK8fovwhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6856
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_03,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308010069
X-Proofpoint-ORIG-GUID: kIKstEN27qB8WFTZ9brMNZRqGq81nEPP
X-Proofpoint-GUID: kIKstEN27qB8WFTZ9brMNZRqGq81nEPP
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Gentle ping?

Thx.


On 28/07/2023 14:48, Anand Jain wrote:
> Fstests with POST_MKFS_CMD="btrfstune -m" (as in the mailing list)
> reported a few of the test cases failing.
> 
> The failure scenario can be summaried and simplified as follows:
> 
>    $ mkfs.btrfs -fq -draid1 -mraid1 /dev/sdb1 /dev/sdb2 :0
>    $ btrfstune -m /dev/sdb1 :0
>    $ wipefs -a /dev/sdb1 :0
>    $ mount -o degraded /dev/sdb2 /btrfs :0
>    $ btrfs replace start -B -f -r 1 /dev/sdb1 /btrfs :1
>      STDERR:
>      ERROR: ioctl(DEV_REPLACE_START) failed on "/btrfs": Input/output error
> 
>    [11290.583502] BTRFS warning (device sdb2): tree block 22036480 mirror 2 has bad fsid, has 99835c32-49f0-4668-9e66-dc277a96b4a6 want da40350c-33ac-4872-92a8-4948ed8c04d0
>    [11290.586580] BTRFS error (device sdb2): unable to fix up (regular) error at logical 22020096 on dev /dev/sdb8 physical 1048576
> 
> As above, the replace is failing because we are verifying the header with
> fs_devices::fsid instead of fs_devices::metadata_uuid, despite the
> metadata_uuid actually being present.
> 
> To fix this, use fs_devices::metadata_uuid;
> 
> (We copy fsid into fs_devices::metadata_uuid if there is no
> metadata_uuid, so its fine).
> 
> Fixes: a3ddbaebc7c9 ("btrfs: scrub: introduce a helper to verify one metadata block")
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   fs/btrfs/scrub.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index db076e12f442..8381174bda15 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -605,7 +605,8 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
>   			      btrfs_stack_header_bytenr(header), logical);
>   		return;
>   	}
> -	if (memcmp(header->fsid, fs_info->fs_devices->fsid, BTRFS_FSID_SIZE) != 0) {
> +	if (memcmp(header->fsid, fs_info->fs_devices->metadata_uuid,
> +		   BTRFS_FSID_SIZE) != 0) {
>   		bitmap_set(&stripe->meta_error_bitmap, sector_nr, sectors_per_tree);
>   		bitmap_set(&stripe->error_bitmap, sector_nr, sectors_per_tree);
>   		btrfs_warn_rl(fs_info,

