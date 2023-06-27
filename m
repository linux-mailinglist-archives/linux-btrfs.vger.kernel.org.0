Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4995C73F7A9
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jun 2023 10:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjF0IpQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 04:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjF0Iow (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 04:44:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD5EA4
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 01:44:50 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35R8DlIk020737;
        Tue, 27 Jun 2023 08:44:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=W75N/T4s4Sss5c4WLZewhbbhiPm2LM/XcDPcguBT8sk=;
 b=XRCCn4eWWtsm0Q+McYid3vg1iOGcjMoPTdeM9kultD7nDHX8TS9/hP5iAsy35x9RsyhK
 /29tl0RORp5nC8/WG9pcDv6s9zsDIge+cBRHblBmhggr78IkjPP0wpwQSM3tFApMMvOn
 xCl17/SQwjvKDN9d88H03QMTaAjo7xPevHER5vJ2D/EvM3b+4QIM+fCCPjDhq03M429z
 vEUlOyplqdl7Owk7lkPByM/LzUI6q9lwMBEnxPDtIGGKLbr0pAgwoU2zhkYPxUsHD0w7
 +hrIf8PF74PQ9+7r5+5npY9ybvilVzFkgPRhGiKFJR1ZRRKfVZSpAvDIOAfeNi+zG9o2 Qw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rds1u4d3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2023 08:44:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35R8aeYl018821;
        Tue, 27 Jun 2023 08:44:44 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx4ef5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2023 08:44:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/jWMBdX41PdIwJhu3XUKJjOa8cacjIbXWhZAT4zNli8inujCA9KXOiiphkbk2Q1KFHvfS8foKxRjb9AA+g/39ML31NdkAP6ckNBU+YLHoSEiLXSR94DRn+mNAW0Pju3CTEbk8fMqvmjzH8rsuJhCyiVtSDTPM1IElHM2D0+Rj5HcLvLBfdfSc72CLYBDlHM7PBM1uK6xwLDdWhSnadkKtaKPe7er+cqpn/IztQOXbcOWWj+TrWkDbGhS/c+dtPXNXIVLO6nlQKOoB9ti33l+5U+smaBmBTZ07zFLAe9rmFuKeBexCbvJvYPcOj06zvgsTVxb3DMM3Zl01aNkhXxqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W75N/T4s4Sss5c4WLZewhbbhiPm2LM/XcDPcguBT8sk=;
 b=NEA3RyjecySEXTi4K8Df4ZLCXy6I1n9RuFKa8XhQ5EtLrVuvADOoiFXTaBlfgfJPacH0ATg9rVWF5+26cUWFMoj0arDh0YHH6zb5IA/FOeic+G/rKHfpIlo58mHtNNXgnNrLL4Z7ezRovKg5bYC5vuUqD5MFtCxOW/kJl1Vbn41EBIBOKjn9pFD6nyMGnD5ISJ9+zUQ+GWvun8VQ44Kd9GI8fCNCTolYNH2xf29Oa9hdkBTYJxqTQY0CHOfnjL3XACBALP76rukY2a3WU2GX65YG5LXEJRewqOHPiXGeYm6dcILdmna3Fklewk5YWdMW/QOz9peMmQZnZ0nXkV5pPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W75N/T4s4Sss5c4WLZewhbbhiPm2LM/XcDPcguBT8sk=;
 b=BwaURYEbpGrvUC5l1msQG7rsPyUaii7SieLy5CtyelD5W+VFTX0T9kelRsk/ZYfmSTvMYytuoVHKys1jID30QgNqN9PC3NX5kkiXDRMFr3MRGxsW91LlC9ymF560LHKdz/K9VgNla0R9RnBcd4swz4fwAbsyZYkRhxXo4e4495o=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6403.namprd10.prod.outlook.com (2603:10b6:510:1ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 08:44:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 08:44:42 +0000
Message-ID: <9a13efad-efff-1932-f175-695a3d063c7f@oracle.com>
Date:   Tue, 27 Jun 2023 16:44:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/2] btrfs-progs: dump-super: fix read beyond device size
From:   Anand Jain <anand.jain@oracle.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1687361649.git.anand.jain@oracle.com>
 <f7fed92047412c7e8f89e94c10ec80af564fe9cb.1687361649.git.anand.jain@oracle.com>
 <7783c9f4-021b-c323-2992-56e717276e64@suse.com>
 <57c09714-ece4-ea89-0a20-7390c85957b9@oracle.com>
 <0b53e722-fdd5-e181-e24a-ca2d3c91b8dc@gmx.com>
 <1831cacc-5534-112a-28f6-d6f1f63ec422@oracle.com>
Content-Language: en-US
In-Reply-To: <1831cacc-5534-112a-28f6-d6f1f63ec422@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:54::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: c46949b9-5876-4507-a4c5-08db76eac051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tb1bdzkjGX9IZplbMgK9T3H1w2Ks1+5m7mEUbjWDJaY34XEVn2Kb4N0W63xftsgI+bBangyLyNsJrek4WF1/0BKJZNNLy7jqOPOR758/bK2a+1DqLR0NVg0LQR/K+PcmATQ6DaUH5KSKL8Sz0hSLqaUWs52Nt2se1tnHgGz+mc7cb3YaAmJi47ujdWkY8IGCDtFE0IqYoC8gQzsdHAd3qOQBWJghoms2YlRKzyekHt6Vh8c07202fBiyaxmAzdbQxCEI0dBxe8Ntc17d416OyV15/idPNFDHLVoJI5ua4TgGDb9cyOJG0QV16OZLahilwnoNpda03t02tWp45IZWNI6LkQGVnSO4cN0ffsbJXcGIciAWpCIV13C9U5ZxzqEem0mQMuzqisfWVt3gdOE+KouZuTm3S5/9vmVkFmcfT4BVkO8O0tyPMScCNxRIKhIhsQbkd0KxvbXEhmrOrL6KLDPrMiHcwR1KPMIwJt6nx5HjaPFTa4pzTammWpJrGcBMxHn5TgNBuC8xHD9OA3OOCqWiZ/5Lh5oHAN2PzB7GMn/z+LzKiWjiaKK6YYOQCO+Mdk3wUzX2nBOqsjSas6FltWnvqDEhLVsguocp59ErcwgBq9hO95SsLX+32FG3rOb2ECQ4m+up4TwnW/bIbXGz4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199021)(2616005)(2906002)(186003)(26005)(66476007)(66556008)(316002)(6512007)(36756003)(6666004)(66946007)(86362001)(478600001)(31696002)(110136005)(6506007)(83380400001)(38100700002)(41300700001)(44832011)(6486002)(5660300002)(31686004)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0wxWUk1MGFKWmQ1elRDVEpqTHA4bTZTamM5aTBQbmRabjhjSUNUdzdtekdn?=
 =?utf-8?B?aktWQWlVZHZhWWNObHE2cXJFb1ZXVFhTa1YyVkZEbnpSbTlwcGFEY2ZObFlj?=
 =?utf-8?B?YWEwSGprNGVJeE02QnFLa3ZPZXp3bGt0Q3RJblNaQTVMd25hWDFPNEtBRlYy?=
 =?utf-8?B?Wkl3bWlweFpML1h1YXlsZGhTODQ4R1lNZThiU25ad0ptbnhDNmpzWk5RTTd5?=
 =?utf-8?B?RUQxZW9KNVR3MVEzZlFyRStXSFYyaStETXYrSmxMY0ZsZ0RjZzZuRDhnWWcx?=
 =?utf-8?B?MkRkaWhwUFJCWGtzWWEzd2JUSk1PNnlPT1JJczBnYkp4RVM5Y2ZleGhRZEEz?=
 =?utf-8?B?VmRzOFBsU2NMckpUNDZ1cDJvcDEzaHIvdTg0aDJ6bUdvYTZ4YmNZM3RDWXlT?=
 =?utf-8?B?ZXlhRlRPRGhMejlNMjBUN0xLU3V5a1poV0prc1VQVXFLR3VMdXJ4K2VwWjB0?=
 =?utf-8?B?VFE2RXU3WkN5Q1ZGbDB3REFubWdnS2xNY0IwelYrdzhqMC8xRkRZdVJRSDF5?=
 =?utf-8?B?SUhFRVdDM3pXSmVRbmF2VkdKUk40cVpleUo3eTFhNDNvdXZ4V1NzWnF5eWh6?=
 =?utf-8?B?V2prM0dsUkZqczJQQXZuaUN1SGdlVWRpR3VjSytUZG0zMGJ3Rjc4c3ZFWkxQ?=
 =?utf-8?B?UnZ4dytOY2paUFFHdjduMm1lS3RZb0pkUGNCNC9IM2lGNzFRWGFCcmhjV243?=
 =?utf-8?B?aEc1TFZ0Y25sc2pFT3NZN1F6a1lnSWlHcDYwM0p0UldBSnBKZHBEdDI4eUhP?=
 =?utf-8?B?MXQ5bGZxdUtTY3dUVTRVR0tucDhKTXlEUlhZakt2TzZHTUdRbFJIR3hjdXdB?=
 =?utf-8?B?cXlRSkp6SjJZc0JQQnJTdkNIeFB2TGZpSkhmMW9hWklKMjRvb2hqSTNvSDhl?=
 =?utf-8?B?M1kzTTh6OUwrc3hLSEVnOVA2a1ZaS3NvNUY4T1JQOTlOWGcxVW4yTFFQYXg4?=
 =?utf-8?B?R0tRb0VSTXJkS25QUWFTdzhYdmpBaWVjaDdTOEdOdDg1K0pOdGdFekdRdndq?=
 =?utf-8?B?N2lPZDUrVk00dWRJenVCYURva04zaWQyamlobFJ0dGZwVHkzQUtwaWpWdklI?=
 =?utf-8?B?SXpYbFUyS2srdmxEYms0YU9yc1ZqV2kvbEJQcHdZTjFCMmhTRm90NEV3am0y?=
 =?utf-8?B?d1BCYWl2VFBIRkxEb0EwN1FtUkxZNEUzZnFZR0VHWlhvTUtyOEJtNEJ6RTcx?=
 =?utf-8?B?K0tPM0dGd1FCMWREa0FCNnFiVHM2WkZ6RWVHam9OdkdaY3BiSkR5ci9LbjRU?=
 =?utf-8?B?eWFoVFVFc0ZUYVIvNnRLZTBmU09FZ2NtdEFuOTJvUTZHR1RZRjhuRmpxWStD?=
 =?utf-8?B?Q2FROVRXYVEvUmxLZXZ0dkhhZTh1d3lWMlVCdnpQQXN5LzVuNGs4bmFETmt0?=
 =?utf-8?B?YWVXUW9odTVUdlNIR3M3WFdsSCtocmNJaWk4OEJwQTVqWXBZTnVEVGQyNjIr?=
 =?utf-8?B?cUNWTlZqQ054Rng1OHpUM1A0Wjd5djIwYStrY1RBclFJaThyNEh1bnhubnFj?=
 =?utf-8?B?S2x0ZjBEaUNRSm1BTzlWWDc1OW5GMzFPR2U1RlVtMzF3T0s5NlNQdDRIZTlh?=
 =?utf-8?B?dm9ibGx0dUJwekw3TW9aUERjd1o3MG5oWithWUlpck9OMkZ0L2t3ekxjNGwr?=
 =?utf-8?B?ZzRMc3kxTjU2ZU9rcm5JekdURldpVGFqbXFvLzhmMmhPTnRXYVA5dy9ZaFV4?=
 =?utf-8?B?bFhkdWlOUlJSa3FGRGkvb0s0b3hDRzV5YXhldEN2MnRLdWVldmdGbnZsWWFo?=
 =?utf-8?B?cGZGUU56djl4aU9lTHh1aWpydVNZR2Q3RFFsUWxUTVU4dERvcWVMMXJRZlli?=
 =?utf-8?B?bkVYNVlMWlQ2MEdIN0FOdXVFRHB1VXRMenlydkxCVXc5NnZBY0hVUjYwQnhu?=
 =?utf-8?B?Q3RyeGx1YVdMdG5PUXFURitLcFpjbFNheGQyZmYzR3RtWlVsRDBneFRIVy9X?=
 =?utf-8?B?MWpnc00zRHp2TnZRV3J6NlZmVUl6LzBENUNnMFNSNW81Vnp2c0lRZWtWSUdU?=
 =?utf-8?B?VWFQd1dRNkg3enFJQU02MkpTVSt6akVURysrMnVXQ3dERFlMcWxFZUZML1pM?=
 =?utf-8?B?MUU3Q2FvM1c0QmtJelovdVZGd2cxcGlWYzdsb21RL0ZPOThpY2M4dXlkejJZ?=
 =?utf-8?Q?QjC/dOLg45WI+DJlXH3/VE5H8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9Ui2a0UTVSRrqnx2YcNFWGSecAMUdqNfSNqxsZfvJvfwxCHJdIPkd+fgyQ4VQ+gNyT4+oCs0GkT+dZhyfj79OmYWaQlYfLjLZB7WnqG2NVpBtH6B17okZ46mgdIRKDQGWju+NEuXPlO2WFPhlFdJyvDon45yvZzwZC8py5dzLN/1XsVQWLWW6AqsJNA/deFGJ3zJ/rhPQukEyneNmUTW3AFNaW9J5RbNiX8f9TDvq98CIayUru8sqH3TmFr9cWCNbYhteCBmIK+HsbZC85xbspwHoLtkLIgcijB98QqSlUMOu6UUpgZjmrX/z1ef+295j+BSRRlWkHBiYhMhLjGvzps1Ykfu8YaKV8my3R901W+fDIIGLxyIIm+du9acSFZlFrnwR5wem/5mYXyAYcPXAUYVNX/bc3D87+jh0EcACoWQVa01zvXscC9c9GmbKwjN/bCsPF99/v4QerD9KMIrp9jzKmJNt2sPVWBLT5++HGM/monGMppZCnTpNTOgg624/e+1nRfhDp1SpWlXxhZczL4hY9pJq0kOlFUgRav1piD/A2D0Vypj06q1Ut5BSFQVquBxoUyRn7LzXJOd+T5tYLQ6lhF8yLzJJcBgqev+1TJEwhW2gdKcZ1QOEnO2J+V5pQq7r64JoNzSRIHafRUscxww70L0RrplujinnFdQM6+5aR7vTD2jdCuAEOWhUVLP03QgEJ6JXNC2twg9baduPrf7sG8ACM5H61TEDG1adtlkDWnRXaGgLkszhFdkZOHdHcFTEm+13pClVSpyP3rY1MABg1mM2tQCX/8aaC3hOsXlfRYHQONmQMqsqU1EhTAo
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c46949b9-5876-4507-a4c5-08db76eac051
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 08:44:42.7557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+38rN7/LfOeXAGm5N/Pi+tOtOOaGPRXvXhp5a5zMgPdy7BV/CVkKZf5ZRaX7lVCsUUKpkkAXDeLQnsFR1eZ6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6403
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_05,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306270083
X-Proofpoint-GUID: dvr8l2xNz4pD3RRttxEagR04HRuqydmI
X-Proofpoint-ORIG-GUID: dvr8l2xNz4pD3RRttxEagR04HRuqydmI
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>>>>> This is because `pread()` behaves differently on aarch64 and sets
>>>>> `errno = 2` instead of the usual `errno = 0`.
>>>>
>>>> I don't think that's the proper way to handle certain glibc quirks.
>>>>
>>>> Instead we should do extra checks before the read, and reject any read
>>>> beyond the device size.
>>>
>>> I implemented that in a local version, following the kernel's approach.
>>> However, I didn't send it out because the test case misc-tests/015*
>>> requires dump-super to work on character devices like /dev/urandom,
>>> which is an interesting approach I didn't want to disrupt by modifying
>>> the testcase.

>>> Another approach is to check only for regular files and
>>> block devices, but it's not a generic any device solution.

Sent v2 with this change.

>> I think it's completely sane to update that misc/015 test case, so that
>> we put some garbage into the backup super blocks other than relying on
>> the support to run super-dump on char devices.
> 
> Yeah, I follow a rule of thumb to avoid removing a feature, even if it's
> not useful. It may just be that I don't know how it is used.
> 
> But I'm okay with removing the facility to pass the character device
> to the btrfs inspect dump-super <char/device> as you suggest. I'm just
> wondering if we have any more comments about that?

