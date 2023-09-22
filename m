Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F357AB4EC
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 17:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjIVPlH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 11:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjIVPlG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 11:41:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FBD102;
        Fri, 22 Sep 2023 08:41:00 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MEFRKw008777;
        Fri, 22 Sep 2023 15:40:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4Ab49UIEqLNHBQaaezXI1fvB6DdzXItyYwMd6W0YO2o=;
 b=C/jX5In9yxFY0IYTBubFUAT1dlVcKrUjNFHXR/Uo67fmQnYtiN7VKJUkiCze3P/f75ID
 SYDtDI1EqB4DlW5oSfN3rEO0pXpKuxqsgGUGH5t53Vnq8hkPxtxxMGqMgQrowNbiklUI
 b9zmgpon73NcIxRPdJ+6KxWJlSz0tsrO5SUoOPOJxMs67PUP0A5PskgwqxFq2V5SIWYs
 sZb2ku2MmvFl/OGyQ+GtppPfgh5XbTJe4PMDBQvRrPk5MXRstWHaSrkz9q63hxAagXj8
 DQMawXpplLYNqTIAxlkRk9krSflq5cc1cUvgL6x+TgYYbK6v5RBvon+RIZ8icuhkvqMi GQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tt1j488-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 15:40:56 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38MFOcm2010187;
        Fri, 22 Sep 2023 15:40:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t8u1a7k6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 15:40:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVc0KR5A0Srcu+5F0pIAxeM35R725J5byb7Ha1+UzFwG+f+zD8L7SjMtHTIIn0FYl0BenSrpv4VLvwLdQ0+F8Vv6RUjtCEBP5wIjPpBdxefjT5Y+mImrhEw+w9wFGJIWBQG+PDTprFT0tVTMj2cPzZH375CTEbH0z2Xswtv/yPuAnvXsIrBkt/P+TXr8A+u+LgIjhkOihOq5rsqiryC5fua/g7ITZx7VDy79Wc3dtt0iTCnkhxNzS4jHe5UufjtxI1sZoUi8IQeNe9QTfQNKW2f5FWa4YAzkUBkXOxd3hXgBUY/RyYm2XG0CyaKDE6DDGcK0BY6IZpAdBbsMf4xMLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ab49UIEqLNHBQaaezXI1fvB6DdzXItyYwMd6W0YO2o=;
 b=lNUpApiLkSln1nWJXgXPwaLsiEjw+eoG8WscHuJTsOeuRZChHUDJhPzh7NJ6myTIY1RdpLQST7d6h6tvo8sFl9KNQyEJocg2fLtJxUBCrKluW4yTqYGamA9oSlyITUeNk4t+skCzdg3cOfGiXJPE4MKhJr9HBAw/DiFdusotKCbqd0LkrmZBeCDhvJ0xqpGj5qX7MSzXmT7LOyX63yZKbVmivmVZESxfBKpWgbFSq4zQpDmiM2ZSPpDjPK2GmJrD8uzDjg1Re8mZ8j+tZ0Wp9bCbiSNe62ciiH7lN5GqmgpsCQNa3pgIFPHkmzwb4vrcyXYjFR+nLbGRyH3tGmn6pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ab49UIEqLNHBQaaezXI1fvB6DdzXItyYwMd6W0YO2o=;
 b=b8skyhwas+AnnbiFxxD7aNHMdGqp6M9Fpx4IHFGtDOXiBcOc0syzEkYJrzAk8Tlua7mPlcThSHzlc0W33j+wFR1DSKb0LW75FHphWILqtjzIt2RNIEmDhdQlzcAY3pgzJ2BgvJmv4dvkCRbfouvOPos09jVd3teAmqK0Gkeza2k=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM3PR10MB7948.namprd10.prod.outlook.com (2603:10b6:8:1af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 15:40:52 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 15:40:52 +0000
Message-ID: <9d0abdf8-35cb-ace1-117d-dc45e7f13964@oracle.com>
Date:   Fri, 22 Sep 2023 23:40:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/5] btrfs/400: new test for simple quotas
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, fstests@vger.kernel.org
References: <cover.1688600422.git.boris@bur.io>
 <9df2554d5e427e47290a10cbfccf20305472c958.1688600422.git.boris@bur.io>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <9df2554d5e427e47290a10cbfccf20305472c958.1688600422.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::9)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM3PR10MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: 41e45265-478f-455d-80b0-08dbbb824d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9tfLwcn4Vq2ciCBohtwbNrpm8kKVoTnizeBy0zk51zmfGM1bJzur+q5eTy8Nk/u+dc1iRX1CBvt1ERlrlBk7+4kr/TPfOHQwsfftNlc6v58tePMG7FpibDjI5pj0LCCdPDbgfcF4xaYYODq5YTt21UzwiGY7NE40RP/yO+LC3JFIK+JqimsTP5VlzPUQ3SUEP4Iug1fHWVqopwRndsyMbFs7/CveOHldsFMPt9cG7JtzafSvLaa/FLcd9DLv63pc+27c/oxVrqPUw8Oo45wpdIdYFMtxLe/LgSXXENb+eKD07RYhyqEQVbMYP4ZXs1rEYtpcM/p1h5tUiH9PP8U6XF2tYyUsOkvNGRn7PRxvN8gD9HgFgLY1WHOuBapaCIkunpWf24pX418dcx4Ma1wfuRIy2EbQOa1Br5FzpTQwhaYhWBKmQv+vtq6JwJLxNtLAf4BpE2F0F0bzBeNNOSmomTeIybLnmonzsrGgAOseFaqTnQcelr8u0b97JBC9WayCjzBqdz3JDrM6ip6Qgr0U0EPbS8I8916IdB9EjdOQoJEzfwmQNmYIx7XRgdxLL0nzVwgz5lRi34AUhdBKC5vcxf5XUi3GhW0V+UhvI763gYRXk20/20P5DiHcGaqdYxmRlyXHSYy+CllxEbcB8xu1MA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(1800799009)(186009)(451199024)(36756003)(26005)(83380400001)(38100700002)(31696002)(86362001)(44832011)(5660300002)(478600001)(2906002)(15650500001)(66476007)(8936002)(8676002)(41300700001)(31686004)(66556008)(316002)(2616005)(66946007)(6666004)(6506007)(53546011)(6512007)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVEzMFBCbi9MK0RybzJQTGE5cFFPTUNqS28vWE1jQUlvYlV5VEY5Sk5ybExT?=
 =?utf-8?B?cjJxMDVWd3ZQdkZFaEphdUNQRVYxbHpIc0tiSzFpRStrLyt4Y2VqejZLUW8v?=
 =?utf-8?B?RVBYeGsvQXRRTFdoQUJLNC91VEZPanoxQkJ6bzZRTk42ai9mbjZxam42bVVF?=
 =?utf-8?B?TllpbFhMQmZsR0dwM1l5MW13RmRpZzExemZFc0JmSTE2WUJtZDU4bjBKYmJh?=
 =?utf-8?B?Y21GLytXSHdNQUt2VFAxSHZRV2NPYmJYTmN4cjZMdnMwcGo4OHFrQTIzOHps?=
 =?utf-8?B?OHNPWEFsTUdtTUZZK2NSLzh5dDhTWVU5akJGNmcwUmlzTFp6K0xYVVY4WmUr?=
 =?utf-8?B?cytJWmpucmUrdHFlQzVDU0doaWtabzdiLzg3eGxmR3p6SzZ5OUk2SkdFM0RE?=
 =?utf-8?B?VEQ5YjIzQTkwK1FqcloyUXhpZWxEc3ZnR095ellxRGlGUEo0d3N2WTlTcmFD?=
 =?utf-8?B?dHZvYWtYdjVTY1hJcmhuMjlISzhsTkVJa3ErL1dkU0syb04zdDk1SE5BVnVO?=
 =?utf-8?B?a0VxNTEyOVhEdGNrMzQwTWpabGR4azNkNHFzVHllcllwb2F0LzBwemRWL1Y3?=
 =?utf-8?B?bU5rVkYwTHZkajBwbVY3OTJWM3orRFQwRFlkdGdNcHByblVveVhXbVI3bHNE?=
 =?utf-8?B?bEMrVU82cUZ3QXcwd3FzRWZtR1ZWTk42MHVKK1Rpa1U3ZEZ2bDBoV2c0SDYw?=
 =?utf-8?B?akp0VzlOa1kxc3loK0MyaU1sYlQ0N1dBOFhUMmNIUGxSVGc3L0lSTHgvZzFW?=
 =?utf-8?B?OGxwcFZJYmkvTDJNdTNrS1hxaUJqSTRNWHV6dFlVWnFBQTFoOFM2eEtqUWtE?=
 =?utf-8?B?VGFhUFVHNmVWWnNLWFdaQlNSUzFqZjlodTh6dlhpOUZXN3RQakkxQWxFZktB?=
 =?utf-8?B?ZnpxZW4rRW9iUHNzYWw4WlBvNHg1aUtOTzVGOGVmVHhudSsrQkViZTMzU1B3?=
 =?utf-8?B?cG5IZmd3NGhsWFlQdjhRZUpCRkVGakc0UFRBbW5tZGd5L1RjaUVYMFRxZ2I1?=
 =?utf-8?B?VU1ZYlVTZjdtTzRRNVY0UGJFYUdlZGMrckV1MTVKR1RQTXVBYW9YbTFISGZ2?=
 =?utf-8?B?WFU1Tk5zSXN2OEZONWQ3d0RTZFl0OGpqTnJXNTNMNWtVL3dhcFFyVzhHS1BM?=
 =?utf-8?B?eFlET1JGeWcvM1BpSGxnR0F3OFZjZHBXY0xTcFZYa0lkQWdVSVZyQlhzZ0NK?=
 =?utf-8?B?OWE1N0YxWUk1VUZSSFRaTVRLTHVsYlAwK3RwS0Y2VXBja215TXhpeFR6Nmcw?=
 =?utf-8?B?ZkQ5TERpc0YzUnpVVi9vYk55MWlJNFN2QkhITnZvdy9Zc2RvVm9FcTlrcDlt?=
 =?utf-8?B?UmdxV3l1eVJtd3pmSGVMTS85NE5SYWoyYkFZdnJKNjZFK1Uzc0VNYUJSYUtD?=
 =?utf-8?B?eS9vREJPS2VyMjRYOHJ6M2loYnNEcjZORmhTb0laaDFnaUhRVVc4SjR4eHo1?=
 =?utf-8?B?a3ZtVk9HbWxIdW1sckt6YXBiZkVRQzRuaEVoa1kxSHI5NjhYdVNvbFQ1ZjFx?=
 =?utf-8?B?YTlUWjA3RnUreW5qbUZ3KzVFcUYwQzFYNTZrY29IY2tReWxPTFZ5OU9rRURo?=
 =?utf-8?B?Wnl5T0ZhSUp6ZWY4MkFMRnRpc1dqa2w4TUNHY1pWUm5mSExTcVRWbnk5VGpC?=
 =?utf-8?B?T3QvZWRXZzBXaVFFaUZObnFTZUt0WTVtR3djYlRtYXViMEFuUGFJS2Z4QTdp?=
 =?utf-8?B?dEFXQ1hiSEVEOU0rM1RlSGFrK2NDQnFVV0FWYmdjV0tTMHp6SE53elZ3T0hW?=
 =?utf-8?B?amVaYXFueW9jeVp1SnN4eDUzOXlyOHFIcWJrcjVubGpUNzF6QldoV0R4am5L?=
 =?utf-8?B?eVVkelN1Q2ViRHRGb0l1eWxITVlqVmtlZTBIbU5HVlBvNUllYWlBdWwrcEhy?=
 =?utf-8?B?aGhoRHZPemlrZ0ZrOTJWZDhmYnArc21acnBhQnkvd1ZuTUJPa3JCOW9oRk9q?=
 =?utf-8?B?MkNZTkxkV20yVFJIbGhqWVMrZyt2RzV1WXczWnFOZ1lYMVVFZ0xYNHljNzlG?=
 =?utf-8?B?RlM1eVNnU2Z5UUIrNGRWWWcyRWhwKzJUVUxSSXpiWXJVOHNTWFJoRXJWZTV0?=
 =?utf-8?B?QmJWeFlKRlE0aTdkMG5iNEp5cEp0aFBmS2p5SG9FeEFDdmZwdkhwQWxtNEpt?=
 =?utf-8?Q?KSSOXmxgEraYD06sL9F+43Iix?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hHaWb6WHVEUxc2VoEQNf2W0I68h8GlOqMqrD2WwfqI4WPxUuLhYwj3sp3VUXgeVd5zDUa1eL2xR8TWvIcXdf6KLkCMwmUzkT7yGRU+Hf+ivL0ExOUQLJoSYf62Vu4/m4VzCG82NVBaw9QvZ3P4MOClv/bnbnOYqa1Z/rsXEHKM9+uY+RPEIsitQNa1NUFRrZTV/JS/+owlvPFtj5ny2UYbTOhvQ99HL6ROJy9U5ZQDP3U4QKJYTSDKG/NBL+zTEJDPKYLPrVC3AcXNef3YU9VdtXXGh1qkt7xecLnoSWCRzzj5mzzhEb/yklGJAFt6hyOJbpjoDtcjNPsjwJZPSOH5RtkXLkoq3Ldaj3hVGL74h758Dknw9PSolrBPYmihJzX6BBFcBmG+FRr2RsdEzXyEBpJH1G4KBQpnt/R4neGSpiKWLJbxXQ1W3fNoCqTvMYHhJXPfdW23E1zjS3MUIuoe15ox/HfoTIfeltAxPsLWG5XHTkzrzQXqAt28I2hH5eq1hKi1Pg8K1xoSGnCwt6EKm04v9uKD9CjJpGtnnCUDcfFW57kCMHgebZU1NmZsihAHwak5EANuqFQ1MQi5zluY896ScbCturx0ZWk0G/W8L960qslA6liLdzegbB/1YcomMuev9Uk8H568qpwrB62reUNlB+0OaAxLmyF7z7Qfwyn/MdAbeGB7Osli/tLfzDsGLM3GBA3+MPhXUCdvHt3kpckd3iOCf/lQwLpDF5bkefB6ethv2m3R/HdcB2Xov7Gbzbd/J46rmYj7ZFvf3zy82gQVuFYM74mAaRjy4h1L0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e45265-478f-455d-80b0-08dbbb824d5b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 15:40:52.2296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZAI5gUQvc9vGZfGrtvDvNQyS1GuujrAtb7i8DUDHTesPZIjwqYkqJfNHFs/7GJfywQn7zFpzuEfkE3pw01eqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7948
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_13,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309220135
X-Proofpoint-GUID: 6OPZKGm_E3tczU0tESrecARyn2YxMGeP
X-Proofpoint-ORIG-GUID: 6OPZKGm_E3tczU0tESrecARyn2YxMGeP
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org






On 06/07/2023 07:42, Boris Burkov wrote:
> Test some interesting basic and edge cases of simple quotas.
> 
> To some extent, this is redundant with the alternate testing strategy of
> using MKFS_OPTIONS to enable simple quotas, running the full suite and
> relying on kernel warnings and fsck to surface issues.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   tests/btrfs/400     | 439 ++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/400.out |   2 +
>   2 files changed, 441 insertions(+)
>   create mode 100755 tests/btrfs/400
>   create mode 100644 tests/btrfs/400.out
> 
> diff --git a/tests/btrfs/400 b/tests/btrfs/400
> new file mode 100755
> index 000000000..c3548d42e
> --- /dev/null
> +++ b/tests/btrfs/400
> @@ -0,0 +1,439 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 400
> +#
> +# Test common btrfs simple quotas scenarios involving sharing extents and
> +# removing them in various orders.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick qgroup copy_range snapshot
> +
> +# Import common functions.
> +# . ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch


I don't see any prerequisite checking and call of notrun() on the
systems without the kernel or progs simple-quota support. Is it not
required?


> +
> +SUBV=$SCRATCH_MNT/subv
> +NESTED=$SCRATCH_MNT/subv/nested
> +SNAP=$SCRATCH_MNT/snap
> +K=1024
> +M=$(($K * $K))
> +NR_FILL=1024
> +FILL_SZ=$((8 * $K))
> +TOTAL_FILL=$(($NR_FILL * $FILL_SZ))
> +EB_SZ=$((16 * $K))
> +EXT_SZ=$((128 * M))
> +LIMIT_NR=8
> +LIMIT=$(($EXT_SZ * $LIMIT_NR))

Style consistency requires the use of lowercase for test local
variables.


> +
> +prepare()
> +{
> +	echo "preparing" > /dev/kmsg


  Please use $seqres.full or stdout for debugging purpose.


> +	_scratch_mkfs >> $seqres.full
> +	_scratch_mount
> +	enable_quota "s"
> +	$BTRFS_UTIL_PROG subvolume create $SUBV >> $seqres.full
> +	set_subvol_limit 256 $LIMIT
> +	check_subvol_usage 256 0
> +
> +	echo "filling" > /dev/kmsg
> +	# Create a bunch of little filler files to generate several levels in
> +	# the btree, to make snapshotting sharing scenarios complex enough.
> +	$FIO_PROG --name=filler --directory=$SUBV --rw=randwrite --nrfiles=$NR_FILL --filesize=$FILL_SZ >/dev/null 2>&1
> +	echo "filled" > /dev/kmsg
> +	check_subvol_usage 256 $TOTAL_FILL
> +
> +	# Create a single file whose extents we will explicitly share/unshare.
> +	do_write $SUBV/f $EXT_SZ
> +	check_subvol_usage 256 $(($TOTAL_FILL + $EXT_SZ))
> +	echo "prepared" > /dev/kmsg
> +}
> +



> +
> +echo "Silence is golden"

We can have the echo part, like (echo 'prepared' > /dev/kmsg), directed
to stdout; this will be useful for verification and debugging as well.


Thanks, Anand

> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/400.out b/tests/btrfs/400.out
> new file mode 100644
> index 000000000..c940c6206
> --- /dev/null
> +++ b/tests/btrfs/400.out
> @@ -0,0 +1,2 @@
> +QA output created by 400
> +Silence is golden

