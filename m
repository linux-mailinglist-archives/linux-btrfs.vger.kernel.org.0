Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC46E72510A
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 02:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240122AbjFGANv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 20:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbjFGANu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 20:13:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C79A1985;
        Tue,  6 Jun 2023 17:13:48 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356IZPN7015510;
        Wed, 7 Jun 2023 00:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=TFCxwA7+ExJC7On2oCPyu/jeJWzhXI/o1Vhz8VtQCBM=;
 b=lY7Ek1eWOVNV72q3Tk3wUU5r+SEL0yWdGJa/8AtJFXKouP8OGJV7D6UQggsPL2oBeFRZ
 qZwFiWgM5GJY+0ajjVzpwrEOKCE8tXA/Opl9PHd3ZpCtbTfOYbGlHph3K3TixEnMa1J5
 2Q3nPisRW+QZtTe/zyAQfrvbXzfyru+wzMV5zr09gD/1ERgD7q5DF0QSEcWCWezLnRDG
 8R5xTx9TuLZkorsOkgEEcPiFSW5FX5ZKor3i1RhiS9X+jv5oPtdChxHFJMtCoyMxZbAP
 fAFCIrqnEIiAZFPeCMPLN7mAZ9hTRbSf5ROYTeFmTJ7drvljrkL03mngx5ii0Z6Lvz4v 0A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6urhy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jun 2023 00:13:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 356NEVM8035860;
        Wed, 7 Jun 2023 00:13:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6qsnxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jun 2023 00:13:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JylD3T+2Nj9DGJ4fmw0VFl7tEcc1UKU1oqLXAqFlkmIufZmuor8vRdDXzAOQv9VnXWpBYNmH7wVMr/KFnntRy07pEnsG4OaBG//yZ+aevNBB/8Z12CEYBajYy3HPX82R/ie2XZb88gcv7BOO7gBOyc66xJMpJbXyi6g12XPkR7X063WfDOPqEMxgmR3Kmoo6MCMfyDNvRG/PgG57kEcIUMvbqLDMus9DQeyoAlm8IVATs77qLooqkSmwH/cxx7LA3jTT392Hl8fs/Rce8PAkJp/4dJfYO3ZhBtTLeE3SiDFZnFcfdwq++vE4F5b0mSX67NL7yzEmnnosi2AcYjXr1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFCxwA7+ExJC7On2oCPyu/jeJWzhXI/o1Vhz8VtQCBM=;
 b=D/cZA+xG6YMdhXbdmee/U/6HPZh61vTv87wgt6/tVGMMWs+nPwMKMhX3jt9B4f3VIKTV1pyK2QLKIMMODmHytBgdMOaJ0ym+HgedFxHfqKvVeVdhWNWiMqLtmnBjgeoo2tg2R3Mcd6NzFOfGzZ0MCRy4ROSFoiQjPN1qxIScU/Py5vBLQ5l0hySYD6PPvsid00cN2+4z6HQXdP04u6uY3NyAQuWRmwebCOUL6K9jVLgAfIqjx2ld1dB1FIJrPg+TScACNR7wgaqBVWVwfhJN7VwegxfnAJhdYf/QlFvk8Mii2QXmmta1IsG/0hDaiYLxBUuRnVJnCX//3dW5traIlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFCxwA7+ExJC7On2oCPyu/jeJWzhXI/o1Vhz8VtQCBM=;
 b=meoFcvxzZrqZRzE/6NHF7eHCm/B2fkbWKhjFiuzjV9qEppYxpAqP4TSLVgYkuYRSHy6xSUW5pNZRCHKbmU7/wKXQqHehkPvl4ycak+Wyov+kfsAmDMHvtekCEYqmJzODO76j7E3VuIEhqc0zJIoWu+5av8KOrBeuQo467ItmmuA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6675.namprd10.prod.outlook.com (2603:10b6:510:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 00:13:40 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 00:13:40 +0000
Message-ID: <2f4659d6-667d-d9d2-7bf8-656019fd3c99@oracle.com>
Date:   Wed, 7 Jun 2023 08:13:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] btrfs/266: test case enhancement to cover more possible
 failures
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20230606103027.125617-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230606103027.125617-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0122.apcprd02.prod.outlook.com
 (2603:1096:4:188::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6675:EE_
X-MS-Office365-Filtering-Correlation-Id: 274f6684-6ea2-4ce0-25da-08db66ec0bdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AIHioGlGetBjkmYF3FiuSweRrWgu4Po69EM6um9zZa/TQ8zj25srRaquN+xcC+u40yE3XzLgVJpitx6HsyVUJT7/8pHi9J+sB+x+7YYzL2l/Lwq3+AcxiYiYS21/+WAknFhq33DjqojDsZVzw6joWJmr2xqmi36CLKZMavqWf37UIHhNDapaKHWYk2gPDAcAJI8axFubm2euBzbAeHdcMELbErE9g8nRmQvmGgGHD8eRhPdOVeBJZ8HvK7WYpODOfZeNyo8NeJBmIqBaz5qDbIGp+UjTKTNucr5W3A6tXaQ5HgFAZvlN6jyX4DGlt+xWujqKtyO3epS5M04OfPUpMQowX0qVD+fmyKlZHm7BWS1QcMmMBtOul3mJAt23KJHJeqkcYX8/8kpyI+gndBqpZcDQG6PpRyyJOYnmcMuuw+BngDWgUGF4g0wzbH33jrgVQxCqTqoFN2ayyQiH/Wfh2ECZIbJoDOy5FDhKlPxhSGJzBL0tnFFrXoh6B4mXMp7Xo1ppQ6wyL16egRr7oyos+Fs+Lx2L5jlkxsmu+jYnzy+fAKqKrbGkN89C0ZGOGgLSq2dIBuQsIe2ouB1IXh3ufgqx/BISIndwi/5yAk9YTj/BL5Tsj/pYG0q98khXgSZZSgI5pReGIgHobDahd//ejueYKud1i/xlDWzFHJcsk5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199021)(83380400001)(30864003)(2906002)(2616005)(31696002)(36756003)(86362001)(38100700002)(41300700001)(6486002)(316002)(6666004)(5660300002)(8676002)(8936002)(478600001)(66946007)(66556008)(66476007)(31686004)(6506007)(53546011)(6512007)(26005)(186003)(44832011)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vi9pcWszVkxNTzFTTTlkU2dMOGNsSFBxSkxZZ3ZwL0JOUFEzQXVIVkpmOUtV?=
 =?utf-8?B?T3M1UGZKcUd2T1ZmZ0dHemlVenVNMTVYZWxXdjN4WHg5dzNDWTIyUndJT0g3?=
 =?utf-8?B?dmZTQm14c0JVNy8wT2hmcDZpMG9kRk5sYVRFMzVsNjlyUk5hTC9vVVEvSzdG?=
 =?utf-8?B?dkhSMUQrbmZaZ1A1YmhaeVplSVRURzZiU3Zvb3RRU0RoeGhtTkNvWnRLZEhq?=
 =?utf-8?B?RFZyZDBpYXdKSjFUM2dNZUZoZ0lsK1FPalljWTJqOWFwZTNhSi9QVHNXVDdJ?=
 =?utf-8?B?d0tQZzVlalI5Ty9wTEdubHZITE91ZjQ1NTdXeG1WTUg0cHU5SWdPOUpteEM5?=
 =?utf-8?B?VnRsMWxXV25OSTg3cUVuUzd3WTRMdHRPREVSVWpna2FQeFplV1FJdDFCRXZk?=
 =?utf-8?B?S2tNRk05YzFUNVRPeWNDMDVRczlTbDYxQmtTVWxwMC83NUZHT1FJakM1UHRH?=
 =?utf-8?B?aTdDK3N3Mkpxa0xPa2ZSdnp1amw3ZU5BaWRlM1l5QkJqNjdpcjQ4eXU3am5z?=
 =?utf-8?B?V0hlMFRrUis2ZThnSi9wdk50TkpXUFo2WjJOeHBQSlplRlJzMkhUR1VFL1Ny?=
 =?utf-8?B?ZTE0MzQzQ2dWOXFGTEJNY20yaWdyVTgrVUxNM3k3QjY0bk0xTjRRMlo1cCti?=
 =?utf-8?B?RTJqMlhMcDhKcXB6NjNqQlpQYkZMbkZBOTBVTkJ1V1BxRG5LUUlzK2dRU0ty?=
 =?utf-8?B?VmhnMUJ4RExEa2pJSVZVL0lpS21tNThtRVdoaWtWMDJGdktBaEJoQTJ4MEI1?=
 =?utf-8?B?NXVTTWtCb3plNnRkcHVHZUZEaEFYN3pyRFN1cG4yQm5vZHNvR1VZU1VsKzJU?=
 =?utf-8?B?cEZtc0hOUlZBY1N4MGp0WUh1bWpZSUpUT29Qd3l5cVBOVWtTWkVpTTBxZSsz?=
 =?utf-8?B?KzNrb3dmeVJpb0h1OUYxYldHNWI3L2xyMnJkRE4yUWZDOHN3M09TUC8zamZN?=
 =?utf-8?B?eG93V2Jrd0ZJMFJKS0JTTlhLWXhuN3p3QUFPWjd5RFdNVzF5ZVY0ZEkxTDhM?=
 =?utf-8?B?bmxlODlNb3ljem1sMzNPSFNjelEva1hMdHMvQjgzTGZmVm9WTURMT29CL3pj?=
 =?utf-8?B?SkNrY3lzZGgxV0VqaUNUODhuUDd0YXI2WlBJekpub2ErU0dxTk43dmFSOEIz?=
 =?utf-8?B?Ukt1SkJwQ2JKd0g3cHM3alY0YXZGV2lhS0RMK3NJQmU3UXhFOWswSGhqa3ll?=
 =?utf-8?B?QTFLQzloUmJUMnFsOXZyaWRHSyszL0JSSTU2ZWduQUM2R1FBZkRrcUFkVVVa?=
 =?utf-8?B?S0hMS3BIMGtCcG01cy8rMWplamJKZXIxU09ZRStvNE5IMUxHSjdNODg2Q3dw?=
 =?utf-8?B?ZlYybEx4SDAxOWVMNXhkK3QyRHprOGJnRTJuQ2lhbnJQNDVETEZ5dit4RXBy?=
 =?utf-8?B?ZjZoK1ZnSXFrU3U4TTVWMlJNRitVbGd4SFA0VzlNby9GcG5kZysxQnhpTmFv?=
 =?utf-8?B?YXR4NkRnK1JGM3FhMEpTcnNpWkN1TUY1VVhsTlJyNnJNMGwzcUEvNWJuclNa?=
 =?utf-8?B?c0w0WWRnVUhBcVVnWEF4c0JCM1U2V1hlNlJYYkg4NWdobjFJd01YQ2g4TWl0?=
 =?utf-8?B?S3UzcTFJMXluYkFSN2I3YmR1eWozbDc1VG1UbVNUekY2SXdZWmZod2JtbFN6?=
 =?utf-8?B?TTdUZDczWm1nTi9Oc1AyaTJxR3FtSjc1NVR6Mk1HRVJobmtKTlRYcXZpeG4v?=
 =?utf-8?B?U29yZ0ZNMStqeEdvU0ZwcUhDaXZjUksxTTlCWnhrVmRDMStjNDVnRWIvSkVB?=
 =?utf-8?B?RkFabHh0d3pId042elVJVWExVU44OHlYVUlSa3RiUVpDb2NLTmtxb2VYSng3?=
 =?utf-8?B?dmE5WVNyUmZaQnQ1VEVqTmdpSmkwcDRyZTZnaklxZDRTdUozU2dROUNhOElU?=
 =?utf-8?B?ZCt1WFlaemcxUVJEdGY1YjEyWlBmSmFnQ3oycmZUbXdzTVpFS2JnK3BUN0xp?=
 =?utf-8?B?NEZqNHpOWkcyeTFoY2dDMzVUVGVZVi94ekhlVGJ3dTIwcnhjeWh2R2tsQjVG?=
 =?utf-8?B?aUxxdnJtVVE1eWFsQnNxRmJHQ0lyUUJJL3VTMm1GVUJDRHZrb1pjZklXUmZ1?=
 =?utf-8?B?YUhTZDBVYjNzMHhUQUJqTjZST3B2a1RlZ3MvWmFwTmRZaE81WXI5MHhxbEhY?=
 =?utf-8?Q?uuq69krVOUDCsP6PqmywF9rWS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: g83kh0ithH4glpAwkYl0HNsHw5pT8rf5JKnK28apdDm5Cud1MO1krLoeegw/vSN89IkFbezNL3mpmVuhxmBUU3huAw/xHPHiweZ0x1Ln809boomhecUOElQmQMXDVyGxz+gnQIJI68AORBYw21hQsLC1TBUkmMJuHkWGdif8IVKGq2mqvx5cdxP8oDaOgW6Iu1L/gRjpnSnFLeS3DU1q6vFrTv6vH8tJu5+A0s/z/GvTNPHuY+Q+xk985ZZoYYiueA4l8hL6+id//wUtNFgCD2GC+xKHF5g2FHPuS4LraMZb0yOoAwMdedfZZgkUEKS6ZqPfKAsZ8ZZAATF+YWZqeAxVAS13jrmrCDWA9FXcp7efm6nIq6wjOKJ03HxokAmRSWC2NkIicny4fdsx1QQSpDThnjzJHbh1NLJiL4U2EkXMkVs9TfOmpUrAP6JqJiHIhN3dm8asDV8hP0B++M487YRlnh4mVfRhQeLA2tn8rZLawvhUBNurRT6YOFPVK5DzJ9CX4538LTOIZ+23jJBux20NGH/k7w7BPsMfFNjpzqoKhztmn6PQm8yJrmmsLcLQAEd8A6UWunNvyDY2l9RBv+bZO1YBW74rXlyHV/HGm6HhAXe6kiXkXTxg5iCXsAlFPztNWjtGohJnn/J9gtMSd11BQym/sFssHRkfJ7NKd9oazEENsUDjev9UoWTlPXKTdG67Qee4KaGM3Mn2wZciRg3v0le955fTwuBDfVbxHGxfU8neASOybvSJnbncE1UuuTYWMyhN+z90b9q8Z7yQJR/KMF5zWmGLok8NBowU1Vw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 274f6684-6ea2-4ce0-25da-08db66ec0bdb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 00:13:40.4497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AERZ1ZPfwdBVjVyInijNbgJuVqVqOSsrlkolg4OlU0e6pVpo7unhQsaPOo2iWg0gDsRJZtbUX6IFOgB9bGsjNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6675
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_18,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070000
X-Proofpoint-GUID: k4Fm6dHfKnn4K80WxqhuwaVBHBQJ3ufF
X-Proofpoint-ORIG-GUID: k4Fm6dHfKnn4K80WxqhuwaVBHBQJ3ufF
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



  It is failing on sectorsize 64k.

---------
btrfs/266 2s ... - output mismatch (see 
/xfstests-dev/results//btrfs/266.out.bad)
     --- tests/btrfs/266.out	2023-06-06 20:02:48.900915702 -0400
     +++ /xfstests-dev/results//btrfs/266.out.bad	2023-06-06 
20:02:56.665554779 -0400
     @@ -19,11 +19,11 @@
        Physical offset + 64K:
      XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa 
................
        Physical offset + 128K:
     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa 
................
     +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb 
................
-------

Thanks, Anand


On 06/06/2023 18:30, Qu Wenruo wrote:
> [BACKGROUND]
> Recently I'm debugging a random failure with btrfs/266 with larger page
> sizes (64K page size, with either 64K sector size or 4K sector size).
> 
> During the tests, I found the test case itself can be further enhanced
> to make better coverage and easier debugging.
> 
> [ENHANCEMENT]
> 
> - Ensure every 64K block only has one good mirror
>    The initial layout is not pushing hard enough, some ranges have 2 good
>    mirrors while some only has one.
> 
> - Simplify the golden output
>    The current golden output contains 512 bytes output for the beginning
>    of each mirror.
> 
>    The 512 bytes output itself is both duplicating and not comprehensive
>    enough (see the next output).
> 
>    This patch would remove the duplication part by only output one single
>    line for 16 bytes.
> 
> - Add extra output for all the 3 64K blocks
>    Each 64K of the involved file now has only one good mirror, and they
>    are all on different devices.
>    Thus only checking the beginning of the first 64K block is not good
>    enough.
> 
>    This patch would enhance this by output the first 16 bytes for all the
>    3 64K blocks on each device.
> 
> - Add a final safenet to catch unexpected corruption
>    If we have some weird corruption after the first 16 bytes of each
>    64K blocks, we can still detect them using "btrfs check
>    --check-data-csum", which acts as offline scrub.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   tests/btrfs/266     |  59 ++++++++++++++++++++----
>   tests/btrfs/266.out | 109 ++++++++------------------------------------
>   2 files changed, 68 insertions(+), 100 deletions(-)
> 
> diff --git a/tests/btrfs/266 b/tests/btrfs/266
> index 42aff7c0..894c5c6e 100755
> --- a/tests/btrfs/266
> +++ b/tests/btrfs/266
> @@ -25,7 +25,7 @@ _require_odirect
>   _require_non_zoned_device "${SCRATCH_DEV}"
>   
>   _scratch_dev_pool_get 3
> -# step 1, create a raid1 btrfs which contains one 128k file.
> +# step 1, create a raid1 btrfs which contains one 192k file.
>   echo "step 1......mkfs.btrfs"
>   
>   mkfs_opts="-d raid1c3 -b 1G"
> @@ -33,7 +33,7 @@ _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>   
>   _scratch_mount
>   
> -$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 256K 0 256K" \
> +$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 192K 0 192K" \
>   	"$SCRATCH_MNT/foobar" | \
>   	_filter_xfs_io_offset
>   
> @@ -56,6 +56,13 @@ devpath3=$(_btrfs_get_device_path ${logical} 3)
>   
>   _scratch_unmount
>   
> +# We corrupt the mirrors so that every 64K block only has one
> +# good mirror. (X = corruption)
> +#
> +#		0	64K	128K	192K
> +# Mirror 1	|XXXXXXXXXXXXXXX|	|
> +# Mirror 2	|	|XXXXXXXXXXXXXXX|
> +# Mirror 3	|XXXXXXX|	|XXXXXXX|
>   $XFS_IO_PROG -d -c "pwrite -S 0xbd -b 64K $physical3 64K" \
>   	$devpath3 > /dev/null
>   
> @@ -65,7 +72,7 @@ $XFS_IO_PROG -d -c "pwrite -S 0xba -b 64K $physical1 128K" \
>   $XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $((physical2 + 65536)) 128K" \
>   	$devpath2 > /dev/null
>   
> -$XFS_IO_PROG -d -c "pwrite -S 0xbc -b 64K $((physical3 + (2 * 65536))) 128K"  \
> +$XFS_IO_PROG -d -c "pwrite -S 0xbc -b 64K $((physical3 + (2 * 65536))) 64K"  \
>   	$devpath3 > /dev/null
>   
>   _scratch_mount
> @@ -73,19 +80,53 @@ _scratch_mount
>   # step 3, 128k dio read (this read can repair bad copy)
>   echo "step 3......repair the bad copy"
>   
> -_btrfs_buffered_read_on_mirror 0 3 "$SCRATCH_MNT/foobar" 0 256K
> -_btrfs_buffered_read_on_mirror 1 3 "$SCRATCH_MNT/foobar" 0 256K
> -_btrfs_buffered_read_on_mirror 2 3 "$SCRATCH_MNT/foobar" 0 256K
> +_btrfs_buffered_read_on_mirror 0 3 "$SCRATCH_MNT/foobar" 0 192K
> +_btrfs_buffered_read_on_mirror 1 3 "$SCRATCH_MNT/foobar" 0 192K
> +_btrfs_buffered_read_on_mirror 2 3 "$SCRATCH_MNT/foobar" 0 192K
>   
>   _scratch_unmount
>   
>   echo "step 4......check if the repair worked"
> -$XFS_IO_PROG -d -c "pread -v -b 512 $physical1 512" $devpath1 |\
> +echo "Dev 1:"
> +echo "  Physical offset + 0:"
> +$XFS_IO_PROG -c "pread -qv $physical1 16" $devpath1 |\
>   	_filter_xfs_io_offset
> -$XFS_IO_PROG -d -c "pread -v -b 512 $physical2 512" $devpath2 |\
> +echo "  Physical offset + 64K:"
> +$XFS_IO_PROG -c "pread -qv $((physical1 + 65536)) 16" $devpath1 |\
>   	_filter_xfs_io_offset
> -$XFS_IO_PROG -d -c "pread -v -b 512 $physical3 512" $devpath3 |\
> +echo "  Physical offset + 128K:"
> +$XFS_IO_PROG -c "pread -qv $((physical1 + 131072)) 16" $devpath1 |\
>   	_filter_xfs_io_offset
> +echo
> +
> +echo "Dev 2:"
> +echo "  Physical offset + 0:"
> +$XFS_IO_PROG -c "pread -qv $physical2 16" $devpath2 |\
> +	_filter_xfs_io_offset
> +echo "  Physical offset + 64K:"
> +$XFS_IO_PROG -c "pread -qv $((physical2 + 65536)) 16" $devpath2 |\
> +	_filter_xfs_io_offset
> +echo "  Physical offset + 128K:"
> +$XFS_IO_PROG -c "pread -qv $((physical2 + 131072)) 16" $devpath2 |\
> +	_filter_xfs_io_offset
> +echo
> +
> +echo "Dev 3:"
> +echo "  Physical offset + 0:"
> +$XFS_IO_PROG -c "pread -v $physical3 16" $devpath3 |\
> +	_filter_xfs_io_offset
> +echo "  Physical offset + 64K:"
> +$XFS_IO_PROG -c "pread -v $((physical3 + 65536)) 16" $devpath3 |\
> +	_filter_xfs_io_offset
> +echo "  Physical offset + 128K:"
> +$XFS_IO_PROG -c "pread -v $((physical3 + 131072)) 16" $devpath3 |\
> +	_filter_xfs_io_offset
> +
> +# Final step to use btrfs check to verify the csum of all mirrors.
> +$BTRFS_UTIL_PROG check --check-data-csum $SCRATCH_DEV >> $seqres.full 2>&1
> +if [ $? -ne 0 ]; then
> +	echo "btrfs check found some data csum mismatch"
> +fi
>   
>   _scratch_dev_pool_put
>   # success, all done
> diff --git a/tests/btrfs/266.out b/tests/btrfs/266.out
> index fcf2f5b8..305e9c83 100644
> --- a/tests/btrfs/266.out
> +++ b/tests/btrfs/266.out
> @@ -1,109 +1,36 @@
>   QA output created by 266
>   step 1......mkfs.btrfs
> -wrote 262144/262144 bytes
> +wrote 196608/196608 bytes
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   step 2......corrupt file extent
>   step 3......repair the bad copy
>   step 4......check if the repair worked
> +Dev 1:
> +  Physical offset + 0:
>   XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +  Physical offset + 64K:
>   XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +  Physical offset + 128K:
>   XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +
> +Dev 2:
> +  Physical offset + 0:
>   XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +  Physical offset + 64K:
>   XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +  Physical offset + 128K:
>   XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> +
> +Dev 3:
> +  Physical offset + 0:
>   XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -read 512/512 bytes
> +read 16/16 bytes
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +  Physical offset + 64K:
>   XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -read 512/512 bytes
> +read 16/16 bytes
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +  Physical offset + 128K:
>   XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> -read 512/512 bytes
> +read 16/16 bytes
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

