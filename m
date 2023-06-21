Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC3F737AEB
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jun 2023 07:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjFUFsl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jun 2023 01:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjFUFsZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jun 2023 01:48:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6451998;
        Tue, 20 Jun 2023 22:48:12 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35KLYI9t000830;
        Wed, 21 Jun 2023 05:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=fBxiGFXPvFxWlTCBYWOUxZaNukD5gfEt1d49A5+WaPM=;
 b=A0yfYstelDIOrjYF5Ec6q11Zlg64V3zq3bKnVm8vsmmbrkfoDVYWQkb62c1e5DsmU5UO
 MzMBLqkaV8PK1O/3uabBAdwLaxYanmQX0GHwJnHRRtrgZhKHdEbaqYsowN1R6GVYUUSp
 wlFOaDtXW6/QrcaGPZ09BPKkTs7pptsvkbWODyXGr3QHuYaxdHkTmvGF5a1NxRldf5Az
 MnBSlbOOA0/GZ3sgvvC5yHQW+9C52CKDppXTJWSrWY9+gOAhmCv7qwPbWosm/+a+0Izc
 BCemotY0ssHVSb9LohNVFwr0WPXTRZBOjVTJCsg07Uxv25JWrwGRL9LUENeACB91ene/ Pg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r95ctxmax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 05:48:09 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35L4MJ5x008398;
        Wed, 21 Jun 2023 05:48:08 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9395ucy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 05:48:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjsRw2ftwhhhKVOkhKyIRxESDPyH7iEq3rvPjVZAEFaZAi7YNbrhUrrR18vvdNrSwLnOttx1Pf7Vr1hFpzKs1qcQJ9PzEh+9JXYDqyzoWeaTpNSXmjZ3JE0ABLHJvlJFVyCHBQNzIa7le0Sg4znM6o5DIixwKrBd7ua9O5mnOUIZlI04PNws1qYzaa/cfgJFEY9zBInjbMM2vz8F+0wOzoakRUW/QKlJq9r3jbMeORxhjsy1Uh/2p4wIc19Og+t+pUsQ49tyTE6UzEpAQS/A0+kLjHuFyi2S1Z6q6YdsHxGFArQkL/uWa0JNPbNFeTEJiLO7ZxVR7CXXwXsPgSDHfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBxiGFXPvFxWlTCBYWOUxZaNukD5gfEt1d49A5+WaPM=;
 b=YrR7uFTGYkspN7YgewY2Vo5f3vi86N7q6uPDJ4UePYs/8gSXStSyLYpGNDPshqBNUwXR9qjzDbPR3PIXwboWJ/Iw5oa3JdiSuaQpKOPwOQiCCOK7YYduGkQUr83xPc4HUMXmEJJIMAXia9bguOk1+0ZqopDxFHLRKJLsSpTCzwVYpK14K6qz+kXfjAwidPIXZGunTZkgyXzhDrf0QpbTZnXdC0jpBu0YYOs44oocpZieMZqxi5WwTWw02Eo34nHSp6MJhvL38lXl2kaaGmfWglYIKjbcQUEQefDgEIYUwR134ytbShfXdfE/hRNp0+vPamHR7d4tHnvMTFPoRjgWzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBxiGFXPvFxWlTCBYWOUxZaNukD5gfEt1d49A5+WaPM=;
 b=khyTWfdf/asIQyNqEFk/p18U1bfTgls0R40uq+TAgpo7mJouBqnJZVqOqXFu/aSwf5tUzkXMP4G1wehRfFg5OYPDByugdh4kO0ufo4fmZGKauX+NUL/gBpy+f74WtYIG/J0vYM3QA53vhMp44WLK6YPWiM51xXmhIUUZYk6t4yM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5136.namprd10.prod.outlook.com (2603:10b6:5:38d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 05:48:01 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 05:48:01 +0000
Message-ID: <90714755-3b63-b95c-87dd-1a7ef785c461@oracle.com>
Date:   Wed, 21 Jun 2023 13:47:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btrfs: add test case to verify the behavior with large
 RAID0 data chunks
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20230621015107.88931-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230621015107.88931-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5136:EE_
X-MS-Office365-Filtering-Correlation-Id: 8acf198a-8782-43b9-d322-08db721b1328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MjZ0hXxK11rkljezXqxLlDnDNkGpNBiJRvgs/Q+eOtixTlHFtB/gBjyLs1ndCSCwLhIwnb5cK3WQhqpm5+D6mtqwNV/AbICwaIN9QQwGmaxCMpCPUkl5U9Ff0AUYdxtFv84vy239LQtT771cM8/q0YhQCw/qstoje4c8qTUG009s1zS4PMr0oVLIFbe2SAh2a31Ci+Z4kbVX3jsIN0DF/RgNa9m9mXzFoMJtnIv97bszjOshHoovCgL/MIQ1I7tMqCKmMeOwTKCPhbhcV0+Vm9bfy/wN073Fqz7Tjx7d6djKkKKNkDzracqa8d0lWuBQF/K1JEqLBABl1ei2NUpWefDNWjD3r8yIgGXuzUxYUIRKgr/09riTykNV1eLrYjSlVVrLCzZ78ofNO4nfgp1wJjbU0E7c92dwDUKuKfcrR73l/A/e9qCV5Ywjxjztz1/UDQOcdPBdBUq10czP3UlDwEHkdu4zhs0mUA+kMe2KlCPfQI3dZiIsTiTuPyu1yFvoo3f5pnYLo/lzEqsMRAob9m2MMIyiOP/Lw0bS4xPlu3kgcT5l/TUHBM+ulL9yB7ajUDxU0dJMcB1sHa2lrxlWedHE+nm4JxfcEFSon/bW+4zT8czJS+8M3qBnSZFgpHG2yeDo0cxMlZL31TYwbMq7Gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(39860400002)(346002)(366004)(451199021)(6512007)(186003)(38100700002)(6506007)(2616005)(26005)(83380400001)(66946007)(478600001)(66476007)(2906002)(44832011)(5660300002)(86362001)(66556008)(31696002)(316002)(8676002)(8936002)(41300700001)(31686004)(6666004)(36756003)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXBsZVlUa0NibkdTdmVHTXZCR0RrYi95NGM5L0c0QmxtWUdoVHFwazBRTTY4?=
 =?utf-8?B?cmdzQWNjU3NqQ0QwemRGdmpPcFdhWUFtT2NBM2FjLzNObnVJbnp2dzdsWnVU?=
 =?utf-8?B?bExTOFhWelBDbXBqS25HV1BJVFNidWQ0UmdUcWtqWE9SNFZRN3hxZmJKdHZK?=
 =?utf-8?B?anZkNTFTUDVrdE9VT1FXbDd2TlMwVEhHK0FEUkIwdi8vN1NzdWsrbjI1UWlq?=
 =?utf-8?B?VTVsc3JlbFR3UENtZ3BxV0hmaW5zTDVUZ3lSdVdLOVV3cW1saGxUWEFjbVMx?=
 =?utf-8?B?aFBETU8vaFdMTGdmR0pldmhBZFl2MHZJWTJMSUpoaFhIcC90RFJGWStpcWFM?=
 =?utf-8?B?MmN2Y3ZHOEJJMzZ6VzRYSm9ZdGViVUgxRnZ4ZDloRGdqeFk4WHgzc0c3Uyto?=
 =?utf-8?B?MTJFd3VHamJWc3lXeDRiL3dPeVVSbUxQeXdma2JqUzE3cVNMSUEvZXVudlJs?=
 =?utf-8?B?SnZsUFhtQmRPd1V5Wkxna0lVdFlzQ0h6VE5BeG5BTzVzd2tpWTJwd2tFK1lu?=
 =?utf-8?B?OWpGcjAzMk45d3FNMk9RVk03dW54S256QnliTmVmYUdFdlRqT2ZSbG12NzFY?=
 =?utf-8?B?NHpZV1FmanNTZG9aU2x5SUxhallHckJtUTkvRTB1Y1FJODk3UVpJVTRGam8r?=
 =?utf-8?B?UTRVVWNaOHJLZEpXWEp0Z1BVdmcvam8zeHdPaGFqUnhKb2drenlOUy9naTMr?=
 =?utf-8?B?ZzJ4ckhGYXdmdFNDbTR5T0ZMVEc4dVg2Um5YNGM3RjJ6UmRZeDFVcEUxbjBC?=
 =?utf-8?B?d3NhbWNBazVaZFpkRk1JRGFNbFZBeW45K2w4M1RHRUU1WnVJcHliTVpEejQ5?=
 =?utf-8?B?K0NuQXoxb1pTL1hZbnF3QSt2ak4zNHR4NHhYeDdMejF3Y29qSWNBSm1wdkEv?=
 =?utf-8?B?dVM3cWM4dE5BSkdpN0ZkRWx4TGxwckZieHluOWVOd2JyRHhUbEJUR0RuNzZW?=
 =?utf-8?B?YW4rMzN4d1pleGVLbEdjQmI3SGkrMTltcGY3Yk5Uc2NiaUJ6UGd6RXNGVlpz?=
 =?utf-8?B?ci9qZEFPU3Njd3JvY0dOMVRXMlpROHljNzZZU2hSQk80Ulc2UjlhK2Z0WTc5?=
 =?utf-8?B?VzFjVnFEUkVEUHpxZ2F0RW1COC94VzhQdHVWRjh5SGJnZzVOdDhTYU8rbDNm?=
 =?utf-8?B?OXRaMTQxaVcxaW9YL2xkUXZMRXRNMTh2V2dweTNaeFliRTJwam40SXFTczE5?=
 =?utf-8?B?MitHeWhIZUF2NHczMFVmazFObW1VU0NzNXQzdm80akliano5dG5XVU9hV0Jt?=
 =?utf-8?B?bDRwMTY2YlhGczd3b2FsenlZaDZBd0UxWWNMZjlUMDl2ZGZSWG9ic3lGRkx3?=
 =?utf-8?B?NW5KUzF5QUNZQVBIanhxTnFML2ViZ0Y0RS9Db1JERXErZEMyZ29UUDhkUjY1?=
 =?utf-8?B?UDVsRXV1aExOL09VcFpyOVBwc0x5NUNCbTlMMnVEUGsyRnNEdGRXNFlOb2cy?=
 =?utf-8?B?SytlL0U3VURhbDdyY2F2RkN0eTFnLy9yU2NKTGtqeEp2czE2bWlmRXcxWHI2?=
 =?utf-8?B?bzFJWndUZi9qSTF3cjhhZ0lwMnVzNWRIZm5VS3BTYU1ENnhkTzZvbmxHRU55?=
 =?utf-8?B?U3cwTjM1NmlSdkpWaWJrK0NuL2xpZFIyZFhZNGVvSHF3R2dpUU96NElUZjFl?=
 =?utf-8?B?Qzk0V0RxQm1YMGdSOEQwZDBWMDc5MkQvTUREZ0tKQlVHSEZsUmlhZGlJbU42?=
 =?utf-8?B?Z3ljamczdFZVbXVFNDFLb2c3MmIvUmFpNFNic1A1NmJ4UlJBVjVjVElKS292?=
 =?utf-8?B?MytWNWFPcnJNdmsrUWFpU01oREgxS3lOYm5xclp0TjhUUllJU2xIZVhxK0Mv?=
 =?utf-8?B?UnYvWkVBV2F2TUV3Sm1zcUp5ZndUUENhVVlYZW1CNEJ3ajhYNzJYdExDeHRW?=
 =?utf-8?B?MkJvV1FhUjBZdzFFYzdkdGliaEwvTzlkYTk4c2lUUGhZZGZjb2NaUkFLajYx?=
 =?utf-8?B?V1dBQVFjZkphRS9rYjFTekU3SmdUeGsrMktuN0ZrbWtkWjJhVUtQZlJQN0E1?=
 =?utf-8?B?djFlMDBSeTdPbmtvZFFZbE5nN1MzdjRUR3J1KzJDdG5QbEhlMzllODAwbDk5?=
 =?utf-8?B?bVRQaUhkMityOUdCVThuekJMR2xxeUdCUW9qSzYwNEkwNlQ5eXhrZXZNdU1I?=
 =?utf-8?Q?JNKn7wHjOpC01mnC5l3JWwFEp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cf3TRN/h4FCS2L83e1iKMWZ3FSSvMp9UsHLoMgVTeKhuV7FnT2o/LIZjIJC2RoINoASsqA/F1EBOOe0Fm0/NBTpuEGzdYde8HTTJJZVTU/ztK5hKHiwBY5MTXAi+MoYIwafB9qGeMbdl7+ssVQotE0w4k9y3V/KL+FX8hk0YULFgMd0i49uIyVsvyLEuZjUH7uyIP8WX/r7/aSA4aP6nk+54yRD+FJtPWYA7saTNv2Y0A7slsJQsCgfTPWJLNFg9oe98+juKuu7BBh1fmsAdxWTsbpRvTduJiZ9w/7R+QawxlNcmVHbyCWhP+5M2yf1qsnaOi9jJ9GIVP+t1K4Lzefv4FxK4v/ndhf593R8tFF8w3W4DfgADLf1EUMHu6tTxy1S3lbYiYAk1SUuZ1bLBQJz9K1XT9l5gmOQfz+Qkvc5/JxcrWjYfEIQSAVAqSHR6ayxSFxHxW0yFwa7Kbj3nqPQSzZ6RD4f3UzucE+3ScenD48oM2qRfijZexy1c2f/eKjj4jIeX3D6vcgm/4Kqu1C0Z+MhBDDRVye4SUYYjSTOVO17H0x9SKwB56xK2K2USnpIgiqowzyQPx8QwDr2eJBDsiEDXZcDV/sPsyZXNUARpSUjLesK2auBSRwA2g9e2yM3/OWFtjsOGyswXM1jdF9jNDW4oSz+K+mD4ZpyLgfoMTYC5bjeZsil7tSGKrV2k5QhbHEnWbtFY9g5c/sZN8Q2gUsOSeLtRs/68zKh5COmmL5nPNi+vYzW6csJIYP4JFQvDlKHvRN2Epb7b3SdNL8x28QsPAFheRgZe0msc3CU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acf198a-8782-43b9-d322-08db721b1328
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 05:48:01.6981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5uSlmIIBgKJ8PKtLn6kAT/BbJGHAEXkQ1eVk6zGYrhVqfMKNAhjBm4idW3rL/yYnrqX4+YIwKEwWmOSCry1kqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_03,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210050
X-Proofpoint-GUID: 4j98hdf859UqgWcz_xMQCQ0uCD0No9yN
X-Proofpoint-ORIG-GUID: 4j98hdf859UqgWcz_xMQCQ0uCD0No9yN
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org




> +for i in $SCRATCH_DEV_POOL; do
> +	devsize=$(blockdev --getsize64 "$i")
> +	if [ $devsize -lt $((2 * 1024 * 1024 * 1024)) ]; then
> +		_notrun "device $i is too small, need at least 2G"

Also, you need to check if those devices support discard.

Uneven device sizes will alter the distribution of chunk allocation.
Since the default chunk allocation is also based on the device sizes
and free spaces.


> +	fi
> +done
> +
> +_scratch_pool_mkfs -m raid1 -d raid0 >> $seqres.full 2>&1
> +_scratch_mount
> +
> +# Fill the data chunk with 5G data.
> +for (( i = 0; i < $nr_files; i++ )); do
> +	xfs_io -f -c "pwrite -i /dev/urandom 0 $filesize" $SCRATCH_MNT/file_$i > /dev/null
> +done
> +sync
> +echo "=== With initial 5G data written ===" >> $seqres.full
> +$BTRFS_UTIL_PROG filesystem df $SCRATCH_MNT >> $seqres.full
> +
> +_scratch_unmount
> +
> +# Make sure we haven't corrupted anything.
> +$BTRFS_UTIL_PROG check --check-data-csum $SCRATCH_DEV >> $seqres.full 2>&1
> +if [ $? -ne 0 ]; then
> +	_fail "data corruption detected after initial data filling"
> +fi
> +
> +_scratch_mount
> +# Delete half of the data, and do discard
> +rm -rf - "$SCRATCH_MNT/*[02468]"

Are there any specific chunks that need to be deleted to successfully
reproduce this test case?

> +sync
> +$FSTRIM_PROG $SCRATCH_MNT

Do we need fstrim if we use mount -o discard=sync instead?

Thanks, Anand
