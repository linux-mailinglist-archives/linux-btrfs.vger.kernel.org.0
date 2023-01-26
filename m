Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A14567C49B
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jan 2023 07:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbjAZG7V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Jan 2023 01:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjAZG7T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Jan 2023 01:59:19 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8705EFBE;
        Wed, 25 Jan 2023 22:59:17 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PM4Stu008015;
        Thu, 26 Jan 2023 06:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Y9vfUD7Gr6eF0wOiFZR/l99IweL3Uj5EYWqwOirzxSw=;
 b=fZRLp6FQcdzC5njUYWKnWnTuDSZ9QL5nPeSAxkThA7GSNOT1tKJcfSCX49tQ1gr3EmB2
 mqWsYgDOgU0hf5U+GetFIvxxrPkTwHWasSLbDRsErE0EFXX9bDeCr1v4nso37x1DzDOk
 YRMqyQrbguLfOwtZzczTpaI1ezPus1FmNmlDljoOdOJghBXHsaih9fviS6KgS1Qbgbq+
 pJVBpauKgs0/Sr5WY8aVto/4180+YRmx/+tp60OMw1Vb+gf8UEyPQwnsEg3EPTOQRIR4
 9L0kZ3FxwS3F28gXRfGxb2GisIqPYUjbYf5kCWNSbOCLWo2+ujj7Z/6I+BSZcT92/oyR bQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n87xa9nxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 06:59:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30Q6hWxU025074;
        Thu, 26 Jan 2023 06:59:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86ged8nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 06:59:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2qPSgV7xLGPUCycWJkWY8E3ozivcpeBI8kuthB19Bo/Fgg+xph9XiGbiXxs26vW3wzuBVphWkmWyGDVll1U0jKfnd/+umrvgRWE0/8hNLjfF6LPSzI1hoNN0IcETUC/sp2vbv0U9An076Gjlin8C74b8RAVyT1J5W6F+TVpGJ2OrNgYMeX5zILd9gvBPDzumvmCDexRQQ61NNc12RuhnSA+ziLR6YPPu8Igkn+umYVEZ0AbfcPPM7Z2rpBJvI7vgf1srTnCk2kPo0kg3S/Mron8WdwAxIHYOjXC74c6UfQbwiiK0mSY2c+Hi6EMgWsuBCal0f+UU5W1+u8rt7NfGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9vfUD7Gr6eF0wOiFZR/l99IweL3Uj5EYWqwOirzxSw=;
 b=aAX36r2+DOokhJwq1wUUmIHxnWUjeUsnlXw97vVcoypuWKk98WryResvT9xIN8LNQHjClTvxByAf0pbH6fFJBPIpFNrP9lbRze2XUKoX562kLiM/wgNlzvbzdUsotGSwLjN3lsjYW6pRCab1t9z+BBNKwSqvPkuCPvQARKq/Ac7FhB9NBgZ5kFl8JsoBkwvcC3hfROTtLUp/OYQnY82Z8Ce+kF06Vt/T6kbhw3xpkXgjiaeBbJu9pZcc35d8OQlVO5EUb79H52kpb07requz1OWTLbwbLE5vcMnxHnOxxRK6RmysBXFlrICU1Lcwx77tK5Rb3XbWC5noeGeJ7yIRfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9vfUD7Gr6eF0wOiFZR/l99IweL3Uj5EYWqwOirzxSw=;
 b=pOYqMl0Vgr4LqfMs9o1CfpWdx8/Fr8NFihI3OSie0j/IY41p1rFuSy9UqaXU9n10Tf2kvBauY9pXqSZX0d0ybXCAN07KzUagameGSgYFIv1wprz9Jg17FOgqhbaFiaZuJwVqSIxoB7HcBl+LuhWwrWrwnEcuBgsuQNP7L5/Va/Y=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6805.namprd10.prod.outlook.com (2603:10b6:208:42b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.20; Thu, 26 Jan
 2023 06:59:03 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%8]) with mapi id 15.20.6043.009; Thu, 26 Jan 2023
 06:59:03 +0000
Message-ID: <2ba532d8-6133-c92e-7a1d-5228a145d6ce@oracle.com>
Date:   Thu, 26 Jan 2023 14:58:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] btrfs: test send optimal cloning behaviour
Content-Language: en-US
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <49e01810eff8d5ddd7d3c99796a66b997faaaf84.1674644814.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <49e01810eff8d5ddd7d3c99796a66b997faaaf84.1674644814.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f94c7f-fd75-4f50-b392-08daff6aceb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0gjDoHHNlZrouphfp9nPDRuurYfDU3FNwSzTh+456j4do+BqxXdOsdcyl36ThXmO5TH/hRotuvAkr7uxJbuZOS19zGWartUTIt0mBl3MBuRvIUpwTQQCoGf1ay9rNnNjT2pfSU6asu1SbiYPdXIM0HS0g7quwZzDbbSf4b56pbwpXyPEsbckGnRqdOFToL8QgWld5AjH79K9YleufOBFbskxHGWrlFpNzm5kjDlP9pZVTbyhDhRVAqXesDIKITh9cUkTorGXiR2gT7AVLwKcQaexeGpOQf7uo0g10+2r8uBtxDNmYUS3s2QptCybqkWW7/GpiaL9fj4LwlAVEmdxD7tX5xbbMhd+k+mqZMR2rCqGSh/3z55B4cKpk5OO4Czg9yFKtWWn4j8kPG6VUp2BXdc4bioJ0OOgWDNVmc5+ie705h3LqJ/jSMH8Ubsi+rXkU2R/Nmpu8rd+U43oLqW7LVU5jXpuWRdgSra29i8EKyUWao5pjg4CM8sLQYY/st8orcIDdUEgj2yNQHjhf3qAncmU9sB5SX03RhZKjaUR47GH8+K7wkddq7C+Fsr82zxt8c6IHRw6oY+PfVCxzRZK/ai6AyT9KMHKoNplkqLEVE88QMsDjydYI1M5nzv+gRQE0UkfEoLldbvhLwJMH92Hlf5D9ECNO/LwGIEBtkKZMouy9vVF8cW0/1/3Fi0IiysxOzQKw/Ktgl1okta8jlYxF0OCEIa5J+hSgOWtptKoJ7A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199018)(86362001)(31696002)(36756003)(558084003)(38100700002)(6506007)(4270600006)(6512007)(316002)(66946007)(6486002)(478600001)(6666004)(31686004)(8936002)(66556008)(66476007)(26005)(2906002)(5660300002)(186003)(44832011)(8676002)(41300700001)(4326008)(2616005)(19618925003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlNsYUtVd3hHc0hmRXozeFBDUlJ4SHVYaURmeHk0REVwZjRrZXErVzQ1UU13?=
 =?utf-8?B?bkcxejRCa0JEY29lc3NkR2wxTlRseDhlb0NiSU9reUE4T2hWd1BxMXAwYkpC?=
 =?utf-8?B?RzdxS1p3T1N6YmVScWkxQWdYK3BOWWdrTWl1SjNVNHVBRWNZVWc3U2RyeXJB?=
 =?utf-8?B?L3lWWW5ZcjhRSFN6eU8rT3hGRlRlWkxZaWlGMGh2UHlUelNwcnl1bDJINVk4?=
 =?utf-8?B?aDZoeTIvdDJlYnVWWHo5MVYzZEV3b3dvZHZmYlJtWXBxV0poV0FQZkVGQVJV?=
 =?utf-8?B?K3ZMZzZtSHN1Zm9sNlJZaXVQQUgzUHJiTWVrcnVnWU1adzl6SmVZZmlGOFJG?=
 =?utf-8?B?SFNHa1FEbVZwVlBsM3BGaVdobnJhWTNINlJKdHZLK0hBSTk5UnVQRXJrZW8w?=
 =?utf-8?B?SjNTb3VuclV2Y3JtRWMrMnJ4MjNiR3dyczRWN0VjdFRLTlVOTG43ak4vblZ1?=
 =?utf-8?B?cWR5b1JseENHU3RaSzFUL1RjVzN6RmEvYzR5V29nVWhGeS84YXR0U0M5R3RL?=
 =?utf-8?B?QXY1M2ZiQzd4STdlZnBnRVlKWmpkcUFGNDFtV1NDTkdTMmxiRFROTVQ2Rm9W?=
 =?utf-8?B?UUExa2ExaHFvTEdyVDlLQ2NvSzhSb0pVaGRWbis3dWhJSjVpNDNkMWR4WXFR?=
 =?utf-8?B?N0ZBU1Vtd1BUMng4anRmb08zakNPZzJmZGZyVzEvQTllcUdTUTFCSXF4NHVK?=
 =?utf-8?B?c3MzTWw5dlRCM2g1YlV6bjkvb01saTMzS2NmZGlIbTBLcFdYSi8wcUFWMGha?=
 =?utf-8?B?Nis5elpIQ081NFpIcFZ5bmhhWU00UDVkUXZFbWkwUXdndXRNRk96RHZMbTdq?=
 =?utf-8?B?elp2QzlpanRyYnlUUFhCTmxMZnJqS2d2cUsrV1dYazBjVVJjemFGZlIzbmZ0?=
 =?utf-8?B?VjRvc1VCYnhQd0NuemlrcVRBeG1PcnZxMkxHenhOcHRnZWRmVGpaS1laZUlX?=
 =?utf-8?B?QWkxeklscFh4S0huSmVrUWZjUVA0SDZvRTVKNUhFYWdhSFFWMVhGVjFiYWQx?=
 =?utf-8?B?TU5YV3EvMGlPVVpiQTVLK3RNU0VKKzBxblJUcGNIWXJYSXZOT3lxTGlHZlVz?=
 =?utf-8?B?UXRWbkNTWlpsU1RZVGZjeGtMRmVaVVo4Rjl1YkQ0b0M2bXdIVFVLY1pkaStk?=
 =?utf-8?B?WTdidk1jd2lvQjdyZVJQNWhldm1hOEQ1emZXR2VPOFFjOE50bUpIZTQ1ZWtJ?=
 =?utf-8?B?eGVBSmxacWNsUnlXblhQWDFOZ002RHFkd1lLS3RjUDN4Rm4yQnFaWkVha3Ax?=
 =?utf-8?B?VDNQOEI0a0t1YzJoQWxJalIrN0ZORkhYSGo5RjcrU3lnQyt5SVdudWhJSXQv?=
 =?utf-8?B?cHB5WWJGY3Ewa0JGTm1MWDRSQ3lkZlFlWDNrbHFKUTVmaVdLQzQwRFZIS2Q2?=
 =?utf-8?B?RUxRd3pScVR0UEs2bDF5enM4NmVZK2JnSS9wYzhNU0paVHQzdTQ2QzNnekFX?=
 =?utf-8?B?RExNa3M0ZWlCV3Nab3d2dUxqTVJNT0xPbnpTejZYNU5UQjU1cWJZMGt4eTJn?=
 =?utf-8?B?UVRHcmxJanM0Q2dWSUZ3Mi9qb0g2b2xaUkUrLzkySkFnK2cyejFmbXJlbDF2?=
 =?utf-8?B?eUpoNUNVSTNXclhUZHZxbGVnVU1odzZDeWpPdnBkNHR4THBFNmN3bzFmZHM5?=
 =?utf-8?B?LzBzZU5SWjl0VkpjQ3JNM0E2d2pVa0lLRU4rbmZ0Uk0yd1VuSE5uNjlmUVZx?=
 =?utf-8?B?ZVk5cnViY1EwR01rTE0xdldRUVhJeWZnSWlBV0JHcytsck41U25vQWFFVlZE?=
 =?utf-8?B?SG83R0llanhqM0FsNHc5TGpkSnNqczJRVFAzTVR6MjJJd0t2NStqSkpuRWFU?=
 =?utf-8?B?ZmlQVng4b1NHM1dQdGJ5dEdXRUdKREZNQ2hJRndRTVVsRFh0ZCtWNXFNa2sw?=
 =?utf-8?B?Szc5UWNELzI2UnQ1ejcyd1VrSVFtMTZwUG1wdGExdnlJQ1QvTlQ5amdpTUNy?=
 =?utf-8?B?U3pGQkVzb2VjejhodjNmb3J4NDRLMFJBencyemNZaHpvMEZ6a0NRdXRyeXg5?=
 =?utf-8?B?MUkrQ2xMaXJ5eGswNnN6M1NKMW54bWZ5SVlMZzI1QnA4MVJwL3JmbkJaYk53?=
 =?utf-8?B?Z2MwU0tYTGpuOWk5MDJvbjF2Q3Z6U1ZQK2t1dTdpOVNSMjROUnpoRWFvdSt2?=
 =?utf-8?B?eVNEUWdkL2VEejlhcURIZm5MNndWWHBlbzlBczdoNEF3cUtMZURLWFJsYWM0?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: T+AZFD3ZRnC0Z9k35XZ7QUs4w1o0CR/eh6qGE9nc9oCzANRQpOPhF0n8e5+Ef+HG/4dc8j991ZrqZbH/Hj7bRhkc/i5Ytofa+tsH3aipsgXdG1DIyYSY8T8h58BKv0UZeIuMsIQFiUTyipmJkfqur/jRim9Uz0vzdhQO/nw+wjtH7h8wBIszJRRpH0usuNkxfADMtI4d05sSNROeItRfzwxzep4fYHM6Qext+7p8fkg1GPZDOf+eHdijsTHKIZRy2XVGrjvS03D7SpsA+zaKWJH9fGC3srbCBvEOhbWId0TC0EiOeKNkZlE+KJWHCgIArcQL6Su69qhRyOEa7sv4svRzXw7cvTM5SCm2Sjsjk01tqF13ZPnBwuRfr2PVd+jp2bGZ7PUPbcwC6viw1FAwI8UOOgyOu3nRWHcYoubYmC/sl2vzNvmbf0czs7iS3o55IYt5NOXf24lWBiNMp+B0mlgFVX4LM3CicGNX9PbDZqOZ1VBYPbJImDzOtSGWgVRiff/vmyffA2CI9uMMboJ7JpwYrmLqDIPUYsiuUVpfGehINFJqBX/HBB01pZ/hkGNm75N18VgoX2unY1Jf3wnGG1t6j53NMx3Rc75YXrcE5t2WP4OLLcCLzFNG/qL5wGA4kK7HOE+uLC6VkX082pL3Sb8DSi9O8rtIN7DPaVGhQZEskvg1OjABbVTSQsL3G3n9fk58AWPT5eYiBEPPzkZioqgpUMCg6mjW0WyDwEYCxuObbVKrRfhRAB7omAieZNspyj+RkRIbM/8NTIQbUfGJMA/t4KjOyYexEFy7XcEtUdngC7S0wsLfq8srpoYoH9iF
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f94c7f-fd75-4f50-b392-08daff6aceb1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 06:59:02.9464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2b9PnJbkpo6SsFxx4+Lebna46C1eJUsWAs7HPZHG3+j2uoci7u/cEHU2l4oTxwRMUUi2xeiI1Tpb7JXVGOKFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_02,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301260067
X-Proofpoint-GUID: VBxIytvUvhijB0ewIYJpA5Bq1Ndvj8iI
X-Proofpoint-ORIG-GUID: VBxIytvUvhijB0ewIYJpA5Bq1Ndvj8iI
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM
Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx

