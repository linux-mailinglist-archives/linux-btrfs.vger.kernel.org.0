Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC368756D38
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jul 2023 21:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjGQT2o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jul 2023 15:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjGQT2k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jul 2023 15:28:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8527FE60
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jul 2023 12:28:39 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HIxJFb027294;
        Mon, 17 Jul 2023 19:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=gnIujk2sD0BhmRZ6dKL0L/0U5ZiI3+novR4Tu0xB3Ao=;
 b=02bfSspVW+SnY3bef11MJNQvvJrkKAKczZhdibyVLeFTA34q0cL0ExHO3+XJyLeySNNa
 A6VJRDWfjTrSNj/ASgAZyDQ/Ti8WZ2znrluVo9ZsEGHPYHRVlq62Vq9ehzdQ+cUGJb3F
 2f3fXwllx/bvqDSwjdmzAlwZR3qZxZacHccAdAJUDcSlHBXeVaiUyoW8J1KTuSFJmMpp
 /rdb/UzQtKTPVz5Uz4I1iGTQef7mBe9dPilbXR85dR4BQWXq5gar8hj5oXfC3RH3gOsh
 +t7AEnflMFPK/B3KqT01yZb5LyJrM8TYyhFU1BD1ABbLkm5nvIHqjxONNhZ07XA1+xJ8 FA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run8a3j6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 19:28:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36HHjjex000852;
        Mon, 17 Jul 2023 19:28:35 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw441ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 19:28:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jbi1tkfpfQZ3A/vqYTW4EWKRPrurvdTBlovGlkN065sjR8sc8oxdEUTeSW0duyCOTFR+K5hLTCAJsYwBLocM30iVm5mlprFSMbBg5SEZNTkwmrlVyGNplhU4HuplTxMJoTQyp4n22A8T+m4v7i9+LeEun3FfhalC2XmyHV+vOskfScnfEAHSKK1/lVeAl7UdqjFZi23vav6o5yXxjrUZy9NQe49JincEPl0WtCpsxYhdBLfrG0liMVbv9CkAgFX8snl7iIL0GWUFaMh3Si+ehpWqm8eEcuuKjyu3LNKLk3LMXc8Hgsv/vIpCRG8+185D990R/cPuSc2xVUxqdfEEdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnIujk2sD0BhmRZ6dKL0L/0U5ZiI3+novR4Tu0xB3Ao=;
 b=dsjKMWdHwyOZTAIUdd65p7WAjhPzV9AzBVInFK7j3qpoTeUT1J9ys3c8bJmTUoOacK8wfPmp21d2FUnAE++44AnKYeScpR8tDCku4GLLseXxd7RFlRRc3y25ALaCPBx0g9NoEb+D7cHD45v+LLSCrrmOhnPOIk4ho6ZLJxxt7zgXBPb63/YZgic3lHTuUda5YbgNd/UH46pRMA6AhABx5omjjRZNTlGTZqLfelVOomU7Tji4669AbfzjU7QxCSm0SnF0HBRAfaMMJcMjjP0CqbHFB0Js01x/7uILfzvW4sWE0dqgAR339kQX3IzcpF2YsTWEpp4k9A0h2UiRKw2aVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnIujk2sD0BhmRZ6dKL0L/0U5ZiI3+novR4Tu0xB3Ao=;
 b=BeGPgxNoAwMP8ZImsS4VIH2awqnzCgDOEU98UyN2zy7llfhwdZBZt/t5/gQ5AvR+v1r9e03TDgmN5eFMici3rFwwlleYbdLsYqmN4W8LjgpaOeBFV/nuogCgSVBl/mvPuueeC/O2Mtch6iow4/xNJ7nm5ZWhZXOT81diuP+m/As=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB4847.namprd10.prod.outlook.com (2603:10b6:5:3aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 19:28:33 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 19:28:33 +0000
Message-ID: <ca797932-0b7f-dee7-ec08-0ff722f6180a@oracle.com>
Date:   Tue, 18 Jul 2023 03:28:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 08/11] btrfs-progs: track total_devs in fs devices
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1688724045.git.anand.jain@oracle.com>
 <25c9f3b987016c897132146360c5aeab0cca9a12.1688724045.git.anand.jain@oracle.com>
 <20230713185835.GF30916@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230713185835.GF30916@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB4847:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b0ecedd-e5c7-4d1f-87fe-08db86fc0222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AGV8ejn23UNJv3pQpRUfU187m6QmkzPEKtZONHlbf3XRnhF2VyOmgTgjKi8UYA3Fp6Z+85EX58wtfyPE1qSfqrg+3FCLYbds1abn1xgFl9T+b05Y3ZOAhUHB1qKFA4QooI2ZOdJV6SPQvAEfGRPZvJ4zQxn86e+5x/8hidYQGL9bda0KmMqrKsdjf2DRE/6EOpSBH4KWKacjsfYgQUibZO1S51suzSmrKwQMlldkc7z9zfsE7YMw7+BXsI0lLbCnxHaouDuU8MRpTuaWFFBoYSSI2xB3SpzAq7ThbjAP5MzQ/bHQZar4To2hKc592aIMPNEp3L7nGD57/my8nA7aApCQ3sM1GUr6gP1GfAx/u8LOwwuKCJIjIKwrYoXCuKnQypcZyOWc1LJMCTMkJUGt8OrAp+OeU6+Zs5VJcyum39KpXAXubu/O9l64BmG6ACBvyCvJuWFz8sl/367LUyWywUmqHJdtRWiQQZMtcrsgVx3gY4ySKaIv4sGUOupi8sOIBYnzgi/k8m4gXz5uQc7NMQWxayKhvxVZxmnpI1b2Xo5xDFlLRSpQy1zqpdXMQpjFg2HPEZ+iwCfo5MLHvWK1gHXCSE47/lDg6Onf4Kn/zsTo7U3xCNfDHrzhVnUSc92UJTt8fa6TXDw/L3MiyMXa0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199021)(31686004)(6486002)(6666004)(478600001)(83380400001)(2616005)(31696002)(86362001)(2906002)(44832011)(186003)(6506007)(53546011)(26005)(6512007)(6916009)(66476007)(38100700002)(41300700001)(66946007)(66556008)(4326008)(316002)(36756003)(8676002)(5660300002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OCsxejlNWTVUUC82cHAyaUVvVjBvaHBYU1V0aUJPUmxac3BzYUdQdTJmYUl1?=
 =?utf-8?B?RUFSTmpRd3I5d1VkMzVqdFRvVGlKbUtNWjdLQlJDRExtTzV3SjYvSkhBTzFP?=
 =?utf-8?B?R0Z6QkpjaHhHWkIxNWREbWVCem94Qk05T3NwRWZVV3ZacHRzK2ozZzh2eFM1?=
 =?utf-8?B?YmdwWkM0YkQwc0U2VVpIRzJlT0dJRjZTcy9BRmJleTd5R2s1Mi9wNUJ4WVdt?=
 =?utf-8?B?akZNRjVXS1M4aUlSaC9QTUUvWlN4WFF3ZU5KY3RvdTcwNzhOc1F5QjhwdkZS?=
 =?utf-8?B?MzE4dC9Vb2dpTkJqbnM2bWJiSWswdysvOVhWaU5uVDUvby8xUDZxd0FpU1RZ?=
 =?utf-8?B?bEJXNFVyc1Zxb2NXOTNXZFNWL3lZV01aNFJjYXdpdkVGWlFzS1lBZjZWQ1BJ?=
 =?utf-8?B?dXlLSkdqVm9UQU16VG5zYnNGS05UdDFZeFp0Qytnb0h4WDlnWmgvTG1kZG9W?=
 =?utf-8?B?alRJUVNGRHl4QmlQRHVoRk16UmxSdk5JWFFIaFB0QkkvTXBMMlovQytBZXNz?=
 =?utf-8?B?bTJOSVZRQUZYZGo0ZWViRy8rWHRqdGxiVlVGUzJXZFIrc1g4NFNCb3dHaW1D?=
 =?utf-8?B?ejJKTU0vOTRteWdsZTlXUTRtcDFrbkRIcEFBSzJ6aEpVN0Nkb3I2dlFJdHMy?=
 =?utf-8?B?ZGxzTTVEc09iT05ibzcrUmZNNml5ai9oekFXVWFHUk9SQ2NWUFR3NGJFTFF1?=
 =?utf-8?B?ZGloRFVjb05TTFlscVJsRjQwUE1GOTF4ajlPUWhVengzdGFDQk5VaVZlRmpj?=
 =?utf-8?B?VE5neExCMGlmdW9JWnNVcUhNNmQza3N5VHEvak5KWldrRHR3ZGQzTXhQWTNG?=
 =?utf-8?B?VUpOY0pkd2hUSjJFbzhZMDhzcU13RHIzalFSVmlGYjlsc0grUHZ1VGxjMk0v?=
 =?utf-8?B?MUF1Skx0NVhFWE1QTWZQTEk1QXZ0bFVpSHczV0RzeWlEclBrNjVnSDZCdHVR?=
 =?utf-8?B?SEdOQ3p2U0dqdVVGUnBaTURFZEw1c29aWjFFTFdSeDUwVGRrNEZLRjc2ZTAy?=
 =?utf-8?B?OWRNMEkxNzFTVEZTeG54RDlwcE54VmpqMEZzSmpIT3Y5YUFCaU9VZXVTcVJW?=
 =?utf-8?B?cUYwcjQ4MWJwTzdFdjN4TWFzbUVVZ1J5QXp4TEFYcFlIY1h4V1o1czRlL2NO?=
 =?utf-8?B?S3UvMUxTUFRicVU4VDBTNVk5aGIzaWN6UmN0dkxBRWFtbkxlbVIyNjhkVXpa?=
 =?utf-8?B?Z1pETlBGVHh5VEJHOURvcTNPYXlHZ2ZIdGt4eEdvNEg0Q05pV0tXZCsyN2dT?=
 =?utf-8?B?OUt0U0Y0VnZ3YmNncFNJMWd6aWlodXYvR09pdXRaOEJyeVgrVGdGZ1piaytT?=
 =?utf-8?B?b1BSNi9WWlVMbE1NRDNKbVRXNkZxTmgweUQ1a2ZWOVpqUGhWWkRoc2tpU2M1?=
 =?utf-8?B?aXlPdUlkZjhOQ0tBL2pEdXBSRlppaDZIVVVyeGNOUDQ3TW1taXIvdlIza2Fv?=
 =?utf-8?B?d25OYUdhd1U0MEQ0eGNsbVpmcTFTc2F5c2t0cXVYNW9oR1cxeGE4VW9QWHR4?=
 =?utf-8?B?elB2eWMzbkhQazgxNVRNN0pUZHhPbXo2djV0NlptY1FvTmNNV1ZhRk5NNjZR?=
 =?utf-8?B?REZkRGZsS3BhVG1uR1lEdXgzRnhHSmJVODI4Y3kvR1d0ZXlPY05LUVVNNkdR?=
 =?utf-8?B?RTRHd3gyV0pPdmt6Y1BLeThLc0ZDQTkvQ1pWa1ZUTkZHL1QrNTNDQm13Mm5F?=
 =?utf-8?B?NnBiUVR2WFFNaExtTHlpZUI2ZXRxQ3U2OVpPdGhqT1lJUGMvcVRqNERacnZw?=
 =?utf-8?B?WkFBZ3VMVy92M1Q4ZFV0Y0hxQndGR09PY1krVWxhUG1CdWR0R3FlM0lrSmsz?=
 =?utf-8?B?bTF0Zk1ERlVlcEVnZjdmdXMvVDdLQVF1Q24wQ2I1THNwdWdkQXFESWdLdUIr?=
 =?utf-8?B?dnpyOGhHaHJLRUxBQnI2UTE2QTF2RmJ2a2I5eE1NUzdVUEJkS3RZRitDS3hz?=
 =?utf-8?B?MHB3QTJZNDFhcSt2WGNFMDY4WkdMUVo3UHp0ZU8zRDFpNGsxNThwTXV3SEha?=
 =?utf-8?B?REpMWGFpMVZzd1c1NzB4ejdHZ0QvMDhmYk9TWU1UK3VFNWxDM2ZqNnhZOEhy?=
 =?utf-8?B?VHk2VDRRbFBaU1QybTVXWlZENUhLdkMrNEV6TURVRE8vUFhVU05seG5HOUg3?=
 =?utf-8?Q?OSxGCk7TzJulLFsFbXTvmNa8B?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: a3uIxaMJwx1JJvkT6z8+qUZUHTu46V7yMdsbTCsdkzW9Z+1w2TWwxptLLX1WErob+TY5/4m6bdtiSauQteqpUNf/WDLAfNHN25VpXhUFC5m6dtFpZ1gQjQtnVI7jWT0unfhgZ9ArBdS+pCqa2tqghgytMp0TtI+2sywBGgE+obZi4fsH5d/6xOpS5ox124jZcU35ZZS627R+zUk2/EVqW7+AhqVm3cjKxAf1MX+D2MQfpyvxGZGnE6BlYGRNot11rf26WcqWYg9wCfevnOezSrWU76RXHeQDnowDFa2JMgMu28Rnp4OCMNtpmKyBbfXJoIK6kgKvVeL5+7hHspkl/jY/tWt82J9PuSHPJj2H3azlijXR/JiB6l5m+O/dXbh5RGCPcU69TGUhACmesumdn3TtB003qsYIu+wRSyDUCchh8EnMs7j6MpOEEQ1FxJHeyFg7UQKtVRtbsu4eqH2BqozA6HiPXAV2XWxblR4YaHTyzTKXd6O1v9qZ9VeLU3JvALl0Ta7sjtMxcu7ayGWOCNKB1mYiQIueE+vXIdO4VtMhX2gqIq615Aslmhxdh+HWH32FAKKqJT2bA/EodtYUKghjIZZ43xMqbWQAt9vW27t4jjSuBtERy8vjX96LW1vXo1GiN6agS6Y2TzKUjwbG7ofwCIoBVM83uwBWOGYqDbC09ju0Mkh2kLnFPW40WU0G80raI3RVu5YbGOCL1+goV/SKXadyltLtSbwbbEx0o7grwVqq1rO4ri4PH1vYxwKCqJr+8Vxu3jakmxoVMkyaNvh0P4DBK0j9is9mO7gzxqY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0ecedd-e5c7-4d1f-87fe-08db86fc0222
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 19:28:33.1814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: byK73phTyTaZh83WMGMT3PJsXW8mTOIuPgtkYfRB4GpxHILMXE7oJdYpXsoMQs5a0TcnxvPvY+wIhLnvvr3YDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4847
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_13,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170178
X-Proofpoint-GUID: cv_CENr7O93FcLr1FH3E8XqxREOCmUMk
X-Proofpoint-ORIG-GUID: cv_CENr7O93FcLr1FH3E8XqxREOCmUMk
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 14/07/2023 02:58, David Sterba wrote:
> On Fri, Jul 07, 2023 at 11:52:38PM +0800, Anand Jain wrote:
>> Similar to the kernel, introduce the btrfs_fs_devices::total_devs
>> attribute to know the overall count of devices that are expected
>> to be present per filesystem.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   kernel-shared/volumes.c | 4 +++-
>>   kernel-shared/volumes.h | 1 +
>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
>> index 1e42e4fe105e..fd5890d033c8 100644
>> --- a/kernel-shared/volumes.c
>> +++ b/kernel-shared/volumes.c
>> @@ -367,7 +367,8 @@ static int device_list_add(const char *path,
>>   			       BTRFS_FSID_SIZE);
>>   
>>   		fs_devices->latest_devid = devid;
>> -		fs_devices->latest_trans = found_transid;
>> +		/* Below we would set this to found_transid */
>> +		fs_devices->latest_trans = 0;
>>   		fs_devices->lowest_devid = (u64)-1;
>>   		fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
>>   		device = NULL;
>> @@ -438,6 +439,7 @@ static int device_list_add(const char *path,
>>   	if (found_transid > fs_devices->latest_trans) {
>>   		fs_devices->latest_devid = devid;
>>   		fs_devices->latest_trans = found_transid;
>> +		fs_devices->total_devices = device->total_devs;
>>   	}
>>   	if (fs_devices->lowest_devid > devid) {
>>   		fs_devices->lowest_devid = devid;
>> diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
>> index 93e02a901d31..09964f96ca37 100644
>> --- a/kernel-shared/volumes.h
>> +++ b/kernel-shared/volumes.h
>> @@ -90,6 +90,7 @@ struct btrfs_fs_devices {
>>   
>>   	u64 total_rw_bytes;
>>   
>> +	int total_devices;
>>   	int num_devices;
>>   	int missing;
> 
> All the device counters could be added separately, that's for the
> kernel/userspace parity.

Hm. I didn't get this. Could you please elaborate on this?

Thanks.

> 
>>   	int latest_bdev;
>> -- 
>> 2.39.3
