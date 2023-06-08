Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8686072783C
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 09:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbjFHHK4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 03:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbjFHHKy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 03:10:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227A39E
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 00:10:53 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357MU4eV011486;
        Thu, 8 Jun 2023 07:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=VpwLvMh09hI5cZUAmrFHbY3Y+PWBblDVCX4rethxX0M=;
 b=gIRXxXKRBa632BdfJzm5BYiSplQzbxse5iY4BbuOKBZ+Dz01zOFpumu8wLbANwiRNy5v
 LkkR2Jj6xRICMkZZ5BxBS7e6G4gsmMabSwSG9laBTyhFJtTccbmeWkwplBIy8RMSDSaj
 Yb75cqJ5xXy5jn3OVOokGtvFahbGmvJeyzH2gYhvxx2moJsaed7dLPDJGPHmE2rnHBys
 vaPEe3ACKOuxWknYHrtNcbVGxtLg1m3Pu7RL7Vc1/5G10Cst/UJO+wXmG812EG0NSDTY
 gErMco5jZ32on1w145rrk1t3+NLiyWtt6zK/1/x2kEiXlTYoFvIuvTk9A/MPzmXLxsBM Mg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6uukhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 07:10:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3586gJ7p010438;
        Thu, 8 Jun 2023 07:10:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6rgttd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 07:10:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7Srwn/F986etsGpG84PmKFe5DDuePba1LnAf9AmRRzikODoMXooivgl2qbFwZmCu5TxUAY+jYarKDlqQ97Pafrm4HU0IhQ3xhKl+X0Q9Xu4pwsbORvcP4Ixbr2KEIhNuWWIY+u0wWkzcOY/R/8Kn5tueJfn46tBoz7bEF6U+eoi+xvxZ/PaxhFFSDfQv1rK6W07x5ZkQ5vj0yXdm1v+MVwGlB4mcCqeEhqkNSKG5v8p/QvZhfl2m1DqQbfg52SHMFEfWbRHWMJ0hfQYA+55RHtvyZONEar6yye4igv5rOGuPBD//f/CVFa3P/N9zDs7V8OJWKJgZJ2tCDx+b3ApNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpwLvMh09hI5cZUAmrFHbY3Y+PWBblDVCX4rethxX0M=;
 b=CcnxM0mCt+++ikb2dUXvG9YPXyX26PgxSJdB7xUjg3fw2TXDzRDTVYMs9UAUa8fv57FQTFJV8pUlYPQBr7CtXWceWFZA/GQNBCk8LeqJ0BRzY4ngK6kspl09YEDbk5xilQt58uxptO9Cd1vENc5whMxqP6f5RFseVefn34zBMsf8etDmefLkzuYlrBdEwOASQVnlb3aOD6XCcaruw3E+jdYykcpGlwk154adLr6MFXpmr6aU8WN2HP0W7CHqyNOeuPauIiosy/7capSKp1in7d/Js1M13tx/hH+BcujiKsuYb3m2TqwZpFLbxY7WvP6F/iyhnFTCg0EnjdRVjIOfHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpwLvMh09hI5cZUAmrFHbY3Y+PWBblDVCX4rethxX0M=;
 b=SskuKeszJkSt5nIhFDL6ws40JeRVdZRQp99COI3zAemP3/Ru4W/xQmaW8l8L4NyxwPAz/ypsngTGaCRFdAN95Epu/+PyVFLpNOrobLQ0rkhCFpmAWO031ri9drQt0Sw2ZRc2zIuKXI6AxaVq1vQBs+Q6U3cOBOLVXjmcADW1e/o=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6663.namprd10.prod.outlook.com (2603:10b6:806:2ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 07:10:46 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 07:10:46 +0000
Message-ID: <c657c159-aff1-5cd6-cd10-b5ab271bb80d@oracle.com>
Date:   Thu, 8 Jun 2023 15:10:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/7] btrfs-progs: rename struct open_ctree_flags to
 open_ctree_args
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <cover.1686202417.git.anand.jain@oracle.com>
 <d6b012af9307b8ff71a3715e2e3d5cc58fafbee4.1686202417.git.anand.jain@oracle.com>
 <ed6225ca-2580-de48-4d2e-bf637ead2993@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <ed6225ca-2580-de48-4d2e-bf637ead2993@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: e612810a-5ed9-44f2-714b-08db67ef7aea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kydiFqprH9FlYJM5vS4/PZfAz/ZELC4dcNXyb0sAMdZeeacnFoCQK5APntsmpVODy+7XMNxb06f4E7TC5qEhF6ooCWpy8bc0bVmpFJB6Y4v2IjPLQZMWOtL8um6QaCedmWC8Qz8vw6YG1AuCIJedcZOxawPduA34WqQrUXw2mgmhX6767CWmT24gx1Y48mF9ku72lwT1QGTSVyef1ZuzvTB4bvXFCzENNbr6K/qkhnazfMTMEN2sp25sqE77HaiJkRzyguVNL13TaXzlxKgIn2/klrytBj5m9mIeyshylyqIyAZDbE8jXf/jKXVF6JKQtRrJmWjJvHyo3WwpipM7sXGt+iXnQqkLrxg8ssFcuHvTKHik/qCkNFpgfju4lGzWM5Q30MZUOqIdOt6sc+ZUVgT7/3Jay7xNMTVVQAV9jGUmA6eCWjtTrXGcbjJoBikLVDLb6//ccPCrKgIHQMb0M4ISwtfDogKAfvvoMGAWzLcyimPCuwUbwJIlBGAxslqeWanBedibWyNZWYu8mWO2FKQRNiUTKkY46Wr6lINUdaTiyAK7nComLC9NFkd3PHm7l7ITtcuTaNw8vZQQWIcp2r0GEf3ywwfxHeeGwu5Pw6OVglD75AwVdm/B6aG7ACZE0AGPZeVsNsJP/wVAuFV4BQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199021)(8676002)(8936002)(478600001)(6666004)(5660300002)(41300700001)(6486002)(316002)(26005)(44832011)(186003)(31686004)(6506007)(66556008)(66946007)(6512007)(53546011)(66899021)(66476007)(2616005)(2906002)(38100700002)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjRpRkF0OWRkT1FXeGJ3REV5YU91NGgzUzA3bkJJZ2NDeVRaOGdFejJlSTNH?=
 =?utf-8?B?M3lON1c0bTArSE9YVjdqQ1RzODRldVFua2l1bnZVSFhzaHpwTHJVMjYwc3dP?=
 =?utf-8?B?a1pZVm1LdWxrMHQ5V2U5aE9LcTRTTzFaUlJvS0tLbTFpbTBId0x6WThWK2lu?=
 =?utf-8?B?QU5nQjJDemVkZFlhWXppendhWk1JTlpuekhtS05aWFlNVlE2Um8zenpNTlB5?=
 =?utf-8?B?STRMV0VsMldKek5OS3IyVEFPME1XdHQzaThxeGVkd3hVWXRtN21GYTVnZXFr?=
 =?utf-8?B?K3ZBZEI5TDJiK2FQTmxkdExscUUzQnFkKzlReFpGdEpTaWVka0J1OW9OOG52?=
 =?utf-8?B?aVN6bjFDWFdaeW5Rbk13bXlCbXhyT0Faa01yVFdrdFArbEJZVjFGaWd5SVBR?=
 =?utf-8?B?Qmd3aVgxYnVwZjBGckxZMjM4ZVU1UGFLV0dBQndrTkJ4aDRJQUJ5aWczM2Fk?=
 =?utf-8?B?TU4rL3FpT0JXdUxWVUhGK2VMakc1SWl4WjNnTUpMTG1yU08wQVI3dDdXUEhl?=
 =?utf-8?B?Z1k1M2svTDlTOFVOaERBRUFNdklMRVd5dEdtOVBJNktjVmRsVXgva1pycGhr?=
 =?utf-8?B?QW0yWHlOZ0RXOVpyUDFiMnFWcTI3cmlhUGw1MjA3cEdsOTNDYVg5M1NDalh6?=
 =?utf-8?B?V0JPT2JTZlgrV3Vya2EzRHg1Q1ltbGRuQ2lUYlkxd2pVc2ppVFRWUVllVnJy?=
 =?utf-8?B?ak9EbFpYbmpES2Vydy9Da0dmQytid29tNS9WMjdIUlMwTmMrUmU0bm5jQVpa?=
 =?utf-8?B?ZU9TNWYzQUsyZUc2Mkluc3JBckFybUhhUDZneTJ4QjVMY1JKL2dTN3VLSkhF?=
 =?utf-8?B?SC94ZXJDMDQ3dFd6V2R3c2J5WHdpQkh0SVB6cVR6bjBvRVJRdm1VYlhMSUJw?=
 =?utf-8?B?MFE1VmhKQkNNT29idnM3TFpyTEkxNFBjdGwzL3Y1VjlhNi8vOFlIUVNxMlk4?=
 =?utf-8?B?R1c4OHZ4RWtxSU90UjFTS0l2Nk91cEt6cGhqU1B0SjZLY3hEQW5IOWt4Skxr?=
 =?utf-8?B?akdIa3JZT1o3Uzl6WHN6eUtHbUU4MDVoS2ZmUk05U3VOd2xMem4zOVA4VWVZ?=
 =?utf-8?B?L1JWRnVhS2FKbFJtRkxuM2xHb1dGMk4xNDUyWHRxSk5ONS9MY0ViOFdSSWV1?=
 =?utf-8?B?TDBRY252TlJkZDRCZ2lVcFpLWmVEa1p6U0hDZSttbk8zK0F0aThlWitOeXdr?=
 =?utf-8?B?SU9DalZVSnNPZEdqV2M5U3JhaCtmSDgyYzBtMFBFSkpRb0ExVWh6UjZmdzMy?=
 =?utf-8?B?UTN5cE1qeTkwUVB6WHdKWjduc1BCSzhMeVlVeWxUcjFuWGhzaW5TbU1TMlpI?=
 =?utf-8?B?TzZMeFdrdkdZTkxVZ0hrdEdha0ZTRDdBRENXTU9xMTVZbVRIYVE0UjFSbjBx?=
 =?utf-8?B?bDZaeXBVWXliQ3VXTHFIeUUyMWRRckVxRURCWUV0OWVpOTdJcDRxOG16V1Jk?=
 =?utf-8?B?dHBpNk5FcmNGVGtmSXVKSi9xYmlSa0FRQjJ2UWFsSDB6N3dGeWVBK0NEbERW?=
 =?utf-8?B?RGJ1V3c0RUZxcE1EeHhXMjJFM3lBNzlmWm9yREVjUFJKRU93UkxLUWlpbExn?=
 =?utf-8?B?cWszWDFWOS9UTElvdklOL0ZZRzdnV3hVZXQ4YmdFYUpTOWZrbkFQVHFZNGk4?=
 =?utf-8?B?U2c4UlJqSHI3Z3E1T1VzY25rVm5sNnVBSmI1MEw0RzI5YVdWSWZLM0M4NVBV?=
 =?utf-8?B?OGZIVW5ZZVN5dzJvTlI2T3MwSTg1ZUFnQTZtUUNMK3VySXhMTytCekNhN1NC?=
 =?utf-8?B?ZkFha3gwMnV0K0ZnM1VtbGVDODJJdXZpbGQxM253WVljOGVGRElzeFlFcWlC?=
 =?utf-8?B?cUV0OFByeVdWWEIvRThXTTgyT1Nxa1p3U2JPb1pJNlZ0ZlI1ODJpL2xoejZB?=
 =?utf-8?B?QlJkbXBBOU9wWENWREt3WGZxOWdnbWNOaElCUXJSZnd6MVNQZS84dXdNUTVa?=
 =?utf-8?B?OFlRZWZkMzRFMitma2VnaXE1RzN5Y3NKbGc1Yk9Wc0VWd2dhcDQ5Y0ZKRmR4?=
 =?utf-8?B?akZUYjZGTHoyT1paT0RzRzcvdzlnZlE5R2JBNWlJTi9Ba3ZUb2JqeUEwU3g3?=
 =?utf-8?B?d0JCRlo3T0ZXZjBNYVdmcW1zNWQxQXhnSFY1TzAxdEdpRXYxbmh2TzUyaFZm?=
 =?utf-8?B?cDFidGNvYUNCOWJVLzFvZjVOeU5CeGVSQnNjeUhuUG5DN1RRaFc4V0NJV1c0?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FhX+x2W4T+V52KfIqlMAPcgxEgyp+v+CCt4hr3xo9VjpWo53rLDpalFB2VMgB0xnDHecvPm1SOr37y9EnEq3HzXsFnDHUatZZ3Ie9z6fMsaopU5/0wP2WIq/3ZG4m9ANbkm2qI3slawJHrBH00i+BHn9DKeLyv9HZ3sw3/RGHGwe6Cuh/VkP3NrfbO2i0XoosTFtqomulTS6xKpPJR4HBYdkK8mlEtC+7fjHbn2KvwHjTkAIPZQZfcCPDPGQqnENC7n0Lp5XmecfDDOOo5JbBOe96EsQjAtDunC5dMjzLOC4B3eCwnw+fcU33pl1z98laZovE75Rt8g6/+lxZofeWoc5Zgl2KmOPOQ/DoLPRKBjQ6fVdidcjRv4OE8UDmix0ecYpJpT7Do+0/kntR7uda0pZfASxlkhstQ+oero6ukH3FUJHuPIlzebF0HEAdG1YPV2hbBO1OnHInmoEJIbpV9oCj6O+nbZ8kioKH9s7qr8QRs2CXIVYQqvmlYHHNySScxvq+beYGqJPeAELObeGrG2k6hYLLJUt3BPMUaw2tNWyGpcp75ejgH5G8NOOSWiRS+XHF/GMUzoLl/rm5qmoMcj4FYb90rxE0/ZX1mRbilZOLTLKlYuJaXZ0Ou5fZzFT00x62DpQU7ii/60FAW/drdSD8qnrDh/ayxzU5cv9EvmFgM9J5JgxNGrIdYd15rjHMFxHlE4Q2l39JHn2qCew/m1nLmw8pwZH+HNw3FFNJw7ce/QVidbautqXaVQDdsOPPdQ9nQoc97f5CAjR1gxxsA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e612810a-5ed9-44f2-714b-08db67ef7aea
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 07:10:46.3148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hpTihCx/QJChEdKUZlMqy3ma7B7AfzvWGWRnDYEQgAZaFGVHjPJE09sb3zJjtbdQMt9mNXLfT+FRv9XqHsx/+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_04,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=997 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306080059
X-Proofpoint-GUID: txgHKr2blpZxc2cO50Hqp2VoKU-fRbEc
X-Proofpoint-ORIG-GUID: txgHKr2blpZxc2cO50Hqp2VoKU-fRbEc
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 08/06/2023 14:14, Qu Wenruo wrote:
> 
> 
> On 2023/6/8 14:01, Anand Jain wrote:
>> The struct open_ctree_flags currently holds arguments for
>> open_ctree_fs_info(), it can be confusing when mixed with a local 
>> variable
>> named open_ctree_flags as below in the function cmd_inspect_dump_tree().
>>
>>     cmd_inspect_dump_tree()
>>     ::
>>     struct open_ctree_flags ocf = { 0 };
>>     ::
>>     unsigned open_ctree_flags;
>>
>> So rename struct open_ctree_flags to struct open_ctree_args.
> 
> I don't think this is a big deal.
> 
> Any LSP server and compiler can handle it correct.
> 
> Furthermore the rename would make a lot of @ocf variables loses its
> meaning. (The patch doesn't rename it to oca).
> 
> To me, the better solution would be remove local variable
> open_ctree_flags completely, and do all the flags setting using
> ocf.flags instead.
s/open_ctree_flags/open_ctree_args makes sense as this struct is
not just about the flags.

struct open_ctree_args {
         const char *filename;
         u64 sb_bytenr;
         u64 root_tree_bytenr;
         u64 chunk_tree_bytenr;
         unsigned flags;
};


PS:
We also have
enum btrfs_open_ctree_flags {
::
}

Thanks, Anand
