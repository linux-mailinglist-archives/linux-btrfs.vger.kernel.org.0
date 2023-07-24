Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C7775ECBE
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 09:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjGXHtS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 03:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjGXHtO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 03:49:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D217B1AB;
        Mon, 24 Jul 2023 00:49:11 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36O6mlCM026686;
        Mon, 24 Jul 2023 07:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=7SzH+IZMCEUurBVFFWUswZkRwJFFrSsOCh3TUOTM3CQ=;
 b=GJ05Cx59ACis002aRwqwvlWSwqe7aYEbWlYBo7RXN4p4qXG2n8m9IIfJjnshy0/0QGS/
 bDmuTwHFK7V4wnchKvmNh9ZedH17FcojbCHyuk4uvpj/xP4LQFOQQKngEJTnqks6muLL
 eHgHPfV2lTo4x6yOXe2rj42hezhRArmCw2qq+rvzSG6CM3+95ljHStWPqwDrUvGHWX2l
 gy60v0jEHtQ476JjYpuaWYb60puH/wI+onUSmt9wGQYWgG3kOLhiLqlomIIsOQ047N6H
 3yOYC1GjU7XRBvbzarTeIryHteC+YhD4Vzrm/sJJXOtSdYcGb7NEzmpMGNn5Na/7hbDM yQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05w3j52j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 07:49:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36O5YejP028703;
        Mon, 24 Jul 2023 07:49:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j3b9mr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 07:49:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOIkdo20JEXHMB5AsvkqHELPGxabSNCULsi47tyhV7Bvj0KGRGwzxSCK0xrf11IXiIAn7STtkIBrI9P9unsrmptd20hrWho6uHH+ZtSIz7Kn+wAQAz3A0er3Fft+sI9Sr4N0OyrCJ+8fc9Rys1y3dLv57uzK9s/N23hB3OUh12XGzeCqOeII1bQy//6+zKJwgDO0CLIJIRI4ElWqaOzlHKrqRFXgQp5/36AMkv/PKNYt5yqVXnZRIZLFIF4Wv2DW1cR7qD0f6uCTCcOwoFFb2/M8fPcZ7IdRVrxZa74tqTtgCvjnnJgcvJ/WAVpJpqyEiFEHfN/WwcYpOKDiScn9kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SzH+IZMCEUurBVFFWUswZkRwJFFrSsOCh3TUOTM3CQ=;
 b=Cehaz16828qzO9yxKleL87IOiwMsqF9sD3tDGcd/3mtCqVxc4H54F7Bw0GxE7xen42CVXyPrKefG7KGfhEkWmSg9DbbFphStt64QL7Df41furYEg4de+shJ9Put1xZexnjBgdRKG9Jz9G/g/K29QuftDDP1y0tQpADgSUcDJ72XKE8vfxBknthDgEr2O6Rjt6jnjhEqsAafphLjP+sIHWYHM5OhPbOSbXfMe4MBdQAdcgtnLwQKgXuUpMFt6pO/VfBj4qLQtuttKzGZAyKXRIAZEV9DeZbOspW/hzvuAfQubus0g4v6PwCBoTkyk0vKANGiVgK9L1jmznSsDoIBVjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SzH+IZMCEUurBVFFWUswZkRwJFFrSsOCh3TUOTM3CQ=;
 b=wwjvv4dL51GVA/Mgm7MYpOy+p+gJM8wPoUhC5HGmaSnyZzBTmbo+ax1cfEBe8Y8yy9ZGUdQakhsPUryz6e1vrKt/xGuSqK9+9nvYZ0PSS/W+ruznM1aoNL6zUio7f1MxKu9yIoToh4GfQTwsi1LjZpWwauq6XvEME/YDeiowPTI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ2PR10MB7620.namprd10.prod.outlook.com (2603:10b6:a03:53f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 07:49:01 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 07:49:01 +0000
Message-ID: <334de8f1-5f7f-5817-9c33-f7fac7b2a24b@oracle.com>
Date:   Mon, 24 Jul 2023 15:48:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] btrfs: add a test case to make sure scrub can repair
 parity corruption
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20230724023606.91107-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230724023606.91107-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ2PR10MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b412da1-734b-4bad-be06-08db8c1a71cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jo9gi7aJ+W4X6Hz3u7QVE2BIFV8L97YocxknNG7OJbrp7jtcA7uk2y2F3XcOZh8dFH1E+sGbkyPneYvFLBoDcI1vwlZ07bFIovNWqfcWIay3TkXWOjxNNdSIKVFBZ/q+wmxn2TV2QCiBmYUhN2MKnx8Q8U67cMc0HxwCI3z02N8V1CDNHIjAVEyXpui426GXhqOEjOwLmtN1K7t4HeeuXWRlFsiERrQvEcLlTrtP4xnczJzRoXa9AVJI1JaMMKwM2ZlJIh/nKNKE5FTPUbQhhrZhGbwC2bg+97N73GQLHhzMItdlv8Qy10fEqEVgAVSsJA5VXgfvrop9y9H/sS4g0efXzNQnTRVdd6Eb8esZLlCjbqBWf7oKU6FQ51SaOkFHhABVATQPcCsc7ao06V9bGbIt9ahVKtePzzJv+YdpvWQib6TSi2n6vbkqqoXdU4TgN5s6HqDfZzkg3u6hFFqNqURuc04z2vbSmPc5adwn0kFttMCK1u/HHh2t5X6cH3WetDA7vkhic/lHdpMKPaeE8SiNy+oNCeBd/rplZ/nQBV1Czzwf0K5FQlH5T3zgiy/xt5pjIwsaak0oR9cgwRa8PJP/+vwYW1iEZDEb6X66t+vvlYMQZjEWBXTbVgvv7i/XJ6QVrFak69tzYNzF4kHx0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199021)(6512007)(6486002)(6666004)(478600001)(186003)(2616005)(53546011)(6506007)(26005)(44832011)(2906002)(41300700001)(66556008)(5660300002)(316002)(8676002)(8936002)(66946007)(66476007)(38100700002)(36756003)(31696002)(86362001)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWk4K1loak8wd3NPMlg1UFp1dXJFQTE1eFhpMWRRR0szbGlGR0NjUWpwVFhi?=
 =?utf-8?B?Ry9COUY1TTdVTG01aVNUV3IxdG1QcmcxL2piY3o3RjJYQmIwa3daV09TeHZQ?=
 =?utf-8?B?VDdaRWtPZXBQUmJTVEVab2EwZklYbDFCVXptUi9mSlVuZDM4MnJYNm9lVGZJ?=
 =?utf-8?B?OTBYTFN6dFRsSERVSGNlS1FtM0VGbzk1LzlmMGV0czNkZm9Pckk1cC94YW0z?=
 =?utf-8?B?dVNYUllPbmVKam1EQ0hpQ3hFT0tNa09KWVc0bUhPV2ZralFKUkJpbm9vdlVL?=
 =?utf-8?B?TmNxZndYY2ZmbnV3dWU5cWtpWC8wVlZRN1Q3MnpERkowTW11U0h6Z3g2K1la?=
 =?utf-8?B?bjJKVTVVaUtwaUZ5aTdtc1dvejl3RC9ZbUFDK0lMbGdWd0VaVm1LRmxPM0tF?=
 =?utf-8?B?Qzg0SEVuS2Qrd0kweG92NGVoZGYydDI2UnZDQ0xmbndrckRmQUd3WTFaeGV6?=
 =?utf-8?B?NHNuSXhobFdRYmFHdDdic3plUmdBS2ZsZ1ZnRWI1TDZtekFuMngrVDRDN3hR?=
 =?utf-8?B?djN2YWVrUXVkTU10NGs5b2kxWjd0eExudXpxMDlyeGtLNmZtU0ZpcmtUSEpJ?=
 =?utf-8?B?QWJBc1pydk9TR3ZySms3VXZMdU5icDhkTlkyU0tzbE80TnhvTHZhWkRnSVFz?=
 =?utf-8?B?ZkVZajEydkpQUWhjZ0ZEdnlnc00vdFVhQU1lVmV0VGY3YmM5Q2Z2Wjh1RERt?=
 =?utf-8?B?eG4waXNuM3orWFQ0THhFVHlLdWhjK2tBRjYvdzdLdS9sM2FqeXJJQmEyQy83?=
 =?utf-8?B?WEI3enloaERPWE5LSVNtTEV0cEM1YnJBSm9sTDVHL3UvQ3NPdmJ5QmV4K3Z2?=
 =?utf-8?B?NVdMNGE3U2tRZTJMYkMrRW03ZXZhWTZua1FzZWg2OHpoWDRPdVNWODJEdEw1?=
 =?utf-8?B?NG1OVzZPTmF1M3NERnlXaTVPYWFkdVNCaVRlUnJybWJDV0Z6MVRQUk5kaE0w?=
 =?utf-8?B?K1JCdE5Mczhmcy9nRW84ZXJGUWNuT2VYV3l0aDlpV21kUDJldDlWcnFnSXVM?=
 =?utf-8?B?Zm1TN3U1dUZYNFp1OVF2RXptMk9uc0I3VmdlMlVoaS8rU0Y4cThzMUg5WHJz?=
 =?utf-8?B?VUhScDlGdTNwRlpFWVc4TWM1K2lnVnBYVUpoVVNlVUtPaHcvK1AyL1phVTNP?=
 =?utf-8?B?WHB6MGtyWWZwU0FDdUsrTk14OTNvbzVBRVhlR3lETXVCSUtiZkNjbkpQdGpJ?=
 =?utf-8?B?ajNEQitMMElzd0hWU1k5dmFCMEZ3eDZmZlkrNUYwcEdWMWt2ZmcwNWVWRUl3?=
 =?utf-8?B?MnlCaEZKVDNBVUY4VVIrSEdmUERnRm8vMHVQZFNKY2JvRW1zWmh5Sk9heHVn?=
 =?utf-8?B?QUhOaUZVV1JQS2tSakJ2c20xRlVsQXUvSk04bSsvSlRqT0JESXBVSytNQVRU?=
 =?utf-8?B?bGVWRUplTmF3RWs0dE9rVGVOTmFGd2RVRVR3UVlHZmNFd0VTdlA2L1R3UnBY?=
 =?utf-8?B?VTk3eTNDTnJubmxTQTNrTXV2ZVVRc1JVb09xT0doNm81YlhIRW15blAvckFU?=
 =?utf-8?B?MFI5Y29kTThiUWNmS0d0cTkvT2pJYVBieFd3b015TElzaHJvMXlyb1QwZmNr?=
 =?utf-8?B?amJ5WkltdE5nUHdqTnZBNitsdEtpMWRjT2NrMXFEdWNLNHIyQnhVU1BSTHkr?=
 =?utf-8?B?L2IwSjlSaWhXSnlJbXJsRFNERFNwby9pTDZ0NnptQ0Jrd1d6eXBzeC9nMTNi?=
 =?utf-8?B?Y21zdmJoQlcxVENxS1Rwc0QzTGE2UEtLQXhpZ1VtZkxSWVJBVVJYNmZ5L2o2?=
 =?utf-8?B?ayt2WFRaN1RrOS9VWEFuVDBNc3F1MldidDFiaWJ5NDRkK21LZG5zcXczUVpH?=
 =?utf-8?B?RU1sZnREckh2bzhXVUhUb2MveGdodFhEUXd1Kyt6N29pU0lTSXNnT3VnZWQ1?=
 =?utf-8?B?S0RTblJxRzFCMFNTa2tBZ2huUkZ6NHhuSW5kQ2RnSDdqaTBETnl2bkZadjI2?=
 =?utf-8?B?c2pFeEpSMFl0U1NPV0ZpcHRKaUV1MHAzMlVJYW1uc2xwWldQQWQrYnNWMFh1?=
 =?utf-8?B?TU80RkVrNEFIU0s4MWR0VW83V3JyU1oyS2I1VHg4VXM1QnN6R0ZuVXhtMVBC?=
 =?utf-8?B?dlBRTk9KOUEwdm9pVlFweDR6aEE2SVlMdmloakxiOXE4bmNnOTdzaWwrQWF5?=
 =?utf-8?Q?XWcVGJaY8sViYBjBJKMlebck1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: G+vIlBPW35eQ0fn1D554X52bCIinZgyRIJB/iHkiGNJEhUv2MWmg4bD7Dm0BIODjVJV85HlNjvCce/nI36PKF33pNNCoTz78R9gTOn8dhUGb1T76k4g+bhV+bB/9MlQunHNieMxiQ3gGxDIBiCV8tRHT5qQOzOFr6VJDfV8s+4vjL6KQ6zaaaodZt6t6yx8wKAPbhjhQJu2SvGRnxHMQVgw5QiNrZGfFmkBLFdD8LedDj3BZK9ibiGc8xcA954LFoaqPL0fwLKEXMrZhFR2GPm9MHu0GsAcXMfZ92mYa1cZ9Z3Y6W520nMxfseAT8oUEzw2yYxkl6QsUCNj+yEdAg6T3u2+MdHe2IPUZIzNcn4VVzXPEa9U/iQVjta1fXY1aYSklrXhsiRCGNW6EjYRYOMXGGwHO5+DeW3hpr7HTmHisWPHUbDv/n3fYuTHoB0U903dimlyUsISuIWE1lpx5wOwkNIGj6Djw10XNthx9hu1/Ygvvq/iFksWnwhEm+kurE62HiDgwfvMGdfCM2SRE7vLj5oji/jFNqUeDccYZsaewyxJbPPJdYk4rb2CZ4G9GlzILOFXUf3xi+6KywUzGDHkMWz4m/a3zjN3d7hP6B56nEcTV/emXx6y7ySRoKUeAoNtd4dtJxU4mkKP5QXfuADszDShaP0bg0dcFSNb5+lnyZRZg5D9+0XlUpESyNB7/5SpMcDyd2MUVG2UZtCrBjiFo0rv7ygQutqlxP4Z9CsyjRQ0XBNgq/khEsddtK8qDH/SblB2B4tS2FSHDuDV4wyopV7nYFqrGmJIXFb15Aak=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b412da1-734b-4bad-be06-08db8c1a71cd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 07:49:01.2506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uepEx+4ZNfacDbCjHwjLpn21WL+VwwcG0py/7DE+6cBEH/ryKnwAlnAeTDPSszyUG9PpWk1R9YcTpCCF1lviEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7620
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_06,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240070
X-Proofpoint-GUID: egkKIaEWAuNRS-Nie7RlDGL-g_HJDGqP
X-Proofpoint-ORIG-GUID: egkKIaEWAuNRS-Nie7RlDGL-g_HJDGqP
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/7/23 10:36, Qu Wenruo wrote:
> There is a kernel regression caused by commit 75b470332965 ("btrfs:
> raid56: migrate recovery and scrub recovery path to use error_bitmap"),
> which leads to scrub not repairing corrupted parity stripes.
> 
> So here we add a test case to verify the P/Q stripe scrub behavior by:
> 
> - Create a RAID5 or RAID6 btrfs with minimal amount of devices
>    This means 2 devices for RAID5, and 3 devices for RAID6.
>    This would result the parity stripe to be a mirror of the only data
>    stripe.
> 
>    And since we have control of the content of data stripes, the content
>    of the P stripe is also fixed.
> 
> - Create an 64K file
>    The file would cover one data stripe.
> 
> - Corrupt the P stripe
> 
> - Scrub the fs
>    If scrub is working, the P stripe would be repaired.
> 
>    Unfortunately scrub can not report any P/Q corruption, limited by its
>    reporting structure.
>    So we can not use the return value of scrub to determine if we
>    repaired anything.
> 
> - Verify the content of the P stripe
> 
> - Use "btrfs check --check-data-csum" to double check
> 
> By above steps, we can verify if the P stripe is properly fixed.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Rebase to the latest misc-next
> - Use space_cache=v2 mount option instead of nospace_cache
>    New features like block group tree and extent tree v2 requires v2
>    cache
> - Fix a white space error
> ---
>   tests/btrfs/297     | 85 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/297.out |  2 ++
>   2 files changed, 87 insertions(+)
>   create mode 100755 tests/btrfs/297
>   create mode 100644 tests/btrfs/297.out
> 
> diff --git a/tests/btrfs/297 b/tests/btrfs/297
> new file mode 100755
> index 00000000..852c3ace
> --- /dev/null
> +++ b/tests/btrfs/297
> @@ -0,0 +1,85 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0

> +# Copyright (c) 2023 YOUR NAME HERE.  All Rights Reserved.

NIT: Actual name is required here.

Rest of the code looks good.

Thanks.

> +#
> +# FS QA Test 297
> +#
> +# Make sure btrfs scrub can fix parity stripe corruption
> +#
> +. ./common/preamble
> +_begin_fstest auto quick raid scrub
> +
> +. ./common/filter
> +
> +_supported_fs btrfs
> +_require_odirect
> +_require_non_zoned_device "${SCRATCH_DEV}"
> +_require_scratch_dev_pool 3
> +_fixed_by_kernel_commit 486c737f7fdc \
> +	"btrfs: raid56: always verify the P/Q contents for scrub"
> +
> +workload()
> +{
> +	local profile=$1
> +	local nr_devs=$2
> +
> +	echo "=== Testing $nr_devs devices $profile ===" >> $seqres.full
> +	_scratch_dev_pool_get $nr_devs
> +
> +	_scratch_pool_mkfs -d $profile -m single >> $seqres.full 2>&1
> +	# Use v2 space cache to prevent v1 space cache affecting
> +	# the result.
> +	_scratch_mount -o space_cache=v2
> +
> +	# Create one 64K extent which would cover one data stripe.
> +	$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 64K 0 64K" \
> +		"$SCRATCH_MNT/foobar" > /dev/null
> +	sync
> +
> +	# Corrupt the P/Q stripe
> +	local logical=$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
> +
> +	# The 2nd copy is pointed to P stripe directly.
> +	physical_p=$(_btrfs_get_physical ${logical} 2)
> +	devpath_p=$(_btrfs_get_device_path ${logical} 2)
> +
> +	_scratch_unmount
> +
> +	echo "Corrupt stripe P at devpath $devpath_p physical $physical_p" \
> +		>> $seqres.full
> +	$XFS_IO_PROG -d -c "pwrite -S 0xff -b 64K $physical_p 64K" $devpath_p \
> +		> /dev/null
> +
> +	# Do a scrub to try repair the P stripe.
> +	_scratch_mount -o space_cache=v2
> +	$BTRFS_UTIL_PROG scrub start -BdR $SCRATCH_MNT >> $seqres.full 2>&1
> +	_scratch_unmount
> +
> +	# Verify the repaired content directly
> +	local output=$($XFS_IO_PROG -c "pread -qv $physical_p 16" $devpath_p | _filter_xfs_io_offset)
> +	local expect="XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................"
> +
> +	echo "The first 16 bytes of parity stripe after scrub:" >> $seqres.full
> +	echo $output >> $seqres.full
> +	if [ "$output" != "$expect" ]; then
> +		echo "Unexpected parity content"
> +		echo "has:"
> +		echo "$output"
> +		echo "expect"
> +		echo "$expect"
> +	fi
> +
> +	# Last safenet, let btrfs check --check-data-csum to do an offline scrub.
> +	$BTRFS_UTIL_PROG check --check-data-csum $SCRATCH_DEV >> $seqres.full 2>&1
> +	if [ $? -ne 0 ]; then
> +		echo "Error detected after the scrub"
> +	fi
> +	_scratch_dev_pool_put
> +}
> +
> +workload raid5 2
> +workload raid6 3
> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/btrfs/297.out b/tests/btrfs/297.out
> new file mode 100644
> index 00000000..41c373c4
> --- /dev/null
> +++ b/tests/btrfs/297.out
> @@ -0,0 +1,2 @@
> +QA output created by 297
> +Silence is golden

