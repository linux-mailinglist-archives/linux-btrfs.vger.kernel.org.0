Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1096FD566
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 06:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjEJEwA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 May 2023 00:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbjEJEvq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 May 2023 00:51:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFC1F3;
        Tue,  9 May 2023 21:51:45 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349LP9Zd001475;
        Wed, 10 May 2023 04:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Lv/UI5s26Kp6ZKRjQrR1roaeMEJ3KeQ9Eh3BcOZTLJc=;
 b=G7ULi4LWxdlqTWVFkNUVMHuMYmxDjcdpFor/IWZBplOvZ38BuVKv6AZ/TO7pVUDpAjxL
 UiOUiIR29kr7oKHeH262y5RGr1VYeoWQjjEK/cxH68ZxJdaigGxA+weA/Tc44eQqQk/C
 uaL+jjvNjP+q2uxp3SSFoH1iCo/a9PN2LcdWCV9gYFtkP/N7VYs/SA+O/UbUcCBoqW3+
 CzvETMWyL5pohDQUVrN8YlxBkI4CIwSzqcg/s2qsSG1ht5yXXCx8d5e4/fIy4h51WUoG
 T6K8tAQvvG0FMsfySOJagshXhgl3YPMB2iuqQhgkG3XUgI+3WeUdDUOSBccvA+23f+Bz Vg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf778ue5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 May 2023 04:51:39 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34A3bfgm022334;
        Wed, 10 May 2023 04:51:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf82whm84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 May 2023 04:51:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6k1Q9MYbXgCBpKU/VzeaaLIBdt0l6cuF/XstjuO/EGHj5waGYAiy52IeXK+JV8pLCEvlJR/JLzrJOMVxCQRgCtOOGLgQ6bzHyaj62f0SWc2QxsFX0AR3PGxdz5HwBO+Ly1lNo46LAjY+zJVR9u8Ok/tCQSU+Ad6G2TpUxR5m3UbZtasQsvp/armwIJ8DkbEnnmxx8YJbVrjzpCdW9xnjW794HfFxf8MRv5uOT9hxJl3qthPsW9RfyjuQmjU9/dwzlzvWNGb8ffRlNleoVoNNTdMtbnwTCPh+L0v2LanGG8ITaU1bj6MtvW6gGm47GBKgIBRUkl4jEWdTxmUOQ5lmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lv/UI5s26Kp6ZKRjQrR1roaeMEJ3KeQ9Eh3BcOZTLJc=;
 b=WRt3+YHCH7a1xPlv03BC7qU4g7FvPysHHcnn9HAIEMtQvVYX73wt3vVKJuenysSzoZV/3JHq4+qyyA1YkNUFTPSXsCGcHU9pGh5qnmX9NUArPkZnl8T+07+KjRORNMSTlcDZx4epEC2ZAIk93D3lj+vfxt2uTu6BDMfe8dMjWfeaoxgH1qw5n7Sv2O+VpqNKdcJQOQXfqvxo8d/NetALIdDnKIMB8jaCm6Tm/+kwxhol867SGVumyEq3yXYuZIR0inGBFAKveXb2bzJ7LOOTJ1te5KPFSGYznL2wv8mXXYrLpSj+EjR36zs8RWZ5ixpy3Sjod7V1hNKv82Djlsnn2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lv/UI5s26Kp6ZKRjQrR1roaeMEJ3KeQ9Eh3BcOZTLJc=;
 b=UL34p3khIFX5dkdHKzj+MVeHTRKuSC1uEZRmah1kuNREfhieP5lJTffaCeM6JP/wPdaegc+3hMujAbpxQCZxLY2iFtoqJgowrL8X8GKSryVgrtfsT77bVqdPCbCwCmD+O+MmCHfw60/hoOXYw1cFTs3BScbFSLVfs02qdINs1dM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB7478.namprd10.prod.outlook.com (2603:10b6:8:166::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 04:51:37 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 04:51:37 +0000
Message-ID: <88f01656-869a-2909-ec2b-58981dd278eb@oracle.com>
Date:   Wed, 10 May 2023 12:51:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/3] groups: add logical_resolve group for btrfs
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1683632565.git.fdmanana@suse.com>
 <a0924b8c782b146736555dc73305e15a9093f26c.1683632565.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <a0924b8c782b146736555dc73305e15a9093f26c.1683632565.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0223.apcprd06.prod.outlook.com
 (2603:1096:4:68::31) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB7478:EE_
X-MS-Office365-Filtering-Correlation-Id: af91f59c-888b-423a-b9be-08db51123c23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wEXNk557rumjgYAcw6qHN4mb4oQ6R2iGLY52U9lrmkxwfCnQgVCRcEPwkVdCgCGJvW9qRC/iAXHHg+iNQiEhg7l1muq0C5bzAfzxTKlF2LS2OVNriAxtLI/wPe5fmjJS9Xd821DvEpQD3k0IaaMFlNtjwnnjnWQGDPJ7VPqCQJ0eeIxf4DQetAh29v21gNtHJnoF6ocpOyALm1ks/OaNRF9cGIPTzNSsxVUakB3mGqtGXkTkvXVUPxyhlAnh7zVpoPTyFGnppE5TWqZOm1cdi6oGtA9/gigDcdIHpMafno/oxl/oF2KokX+8qpy4NOvtWYA5gan3B+ianwolcajnQ3x/AUXO7/VIV3AOMIOxrh3fTh3IjnXNlCNJid+zlpBqr1ZUqnwfec6CaPb2INvZ0/I9r21rEV/RYdqmL96jr+PAsq/t8KchImDre9PSdr8zxr+ETH9f9QZP01xVwRqm4CULj5HpjnBDdFQWV2V8vpMRVooCXBWbx7yqu4FTTKOs3neCppoO1k3gdy0pf63jTRgxRRp1pFu3J0HIIqylWrR3cAXfB+OtLMLZkvA3SUtwQspZ/lXT1JInQD0sh59xLc2O6yQLWmss/rnzvtpCr7wSZuKTcqDVekjR9SMP86q6czk80z7catP2oeN2kI3hlE3iA4QLRAqlR1cY/MD87V4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199021)(31686004)(2906002)(8936002)(4326008)(316002)(8676002)(41300700001)(5660300002)(66476007)(66556008)(478600001)(4270600006)(6666004)(44832011)(66946007)(19618925003)(31696002)(6486002)(6506007)(6512007)(26005)(186003)(36756003)(2616005)(558084003)(38100700002)(86362001)(17423001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTFvbUxaUCthckhZVVEvc1h6T1FXbTlrNVMwR29IQ0tTOWJuZkVDazQ4emtH?=
 =?utf-8?B?U0JaN2sybGV5M3Z4ME4yR1lDUG1MaXZRY3pCM0NpQjNVQ3BUdjBabmF5bm1M?=
 =?utf-8?B?dldtSjVYNkIrb0E0QVlvUFFmNGthZ1ZVT3EyTGpNQyt6YThjZnhzUmJiY1FH?=
 =?utf-8?B?cE1KY29VRkxNOXYvcEFkSmlDeENoNGVCaitlbXJWUnpsdFdqemJOdnVZa2R6?=
 =?utf-8?B?YWVDdFIvcjRiK0FOSDZpVUJyeS9PeVFCMklpeHVwcEtGU0w2bXhpNXNDWXhu?=
 =?utf-8?B?aUxqRm54SFBNRnFuVnVTMXFBWHdhMEMvZU9lZ0hGSDBRSHhqNTh2Wk9yVHoz?=
 =?utf-8?B?N2N5bDF3L3BxSUVqcWV5N2MrQWIveUdUMHNqT1J5NlM0YWlORTNybXRBZFlm?=
 =?utf-8?B?bk5iMGpwQ3VzRWlZbkVTVXA4eDhjZXZaaGkweWpCenZrS2Z2d3JLQzAydFgv?=
 =?utf-8?B?RWx1WUQwejVRQWRMTXd1NlYyTG1BY2RGUWx2cWJHWGk4ODNmNldPY3lPWHF3?=
 =?utf-8?B?WmMxNFR5b1RUNmlGYkphM0FTYjloYVIyUi9yVmxQRVBKTHlKbWkvR3pveEk0?=
 =?utf-8?B?TDIxNGFTWGpZSmlDVnhSbC9meUlLSmdxODBQbUF6dUQyUERZZGQwODhnMjBu?=
 =?utf-8?B?WGs0TFY1TXVqMkdNR0Y3bDlxaXBlTjJyVUR5akU0a1ZtMEpCWFU5SWlDQXlI?=
 =?utf-8?B?VHpHRUZ4cVRtbXRxMS85cTNvVjJmTi92dEJvTGcrWHU4allkbTRhVG4zV0Fx?=
 =?utf-8?B?YnR0bGhLSE5Xb0d1RUpLa1lCMVEzN1hjdDVOdXRmaE1PZE1PN2oyYmJSYzVN?=
 =?utf-8?B?ZnBWMkczMmZjM2NtYWNDSkZqbm1iWnRzblR0SFVyM3Uya05oejdmYkFVbC9s?=
 =?utf-8?B?ekQyNU9sSTBxU3c5RldhSndTZ2paMngxOFhTYTBtNzNiejdIRTBoZDl5ZVpz?=
 =?utf-8?B?V0tQWG5nWEpKbzRRdXZtSDBScGNvSDRzaE1PeDlsY0g3VHM5b1lWMlltcXNr?=
 =?utf-8?B?WXNLUG9Pa2ZRcCtMTjE0UzA5Sm9kdHJRZVREVWpmaVRaNTVlamRZck02RHhL?=
 =?utf-8?B?NGFVbHNwUEpFMEZhZkNTaEZZS0ZhTjloanpHY3ZUSlhwQnRsOWVCYUt1QWt1?=
 =?utf-8?B?NWR3ME1NNjhSVVkwSFEwSUg1c3NHYm1xNVVic1Y2Q0wyMElqSkN4T1N1Qzlq?=
 =?utf-8?B?Mkk1K3JaUjF1ZXpNaFRiRS91RDNSY2xyY09RV1NLRWFTdExUQVdUZDhBSVM1?=
 =?utf-8?B?RzRvRDFxV2N2TlVRQ0h2dFZTeHNJdE9jVW93UXZNUFI4LzNtUUovRXdyVGlW?=
 =?utf-8?B?L2h1NEgvQUFsTm80YlF3VnJZaVRiRXRMTmV6S3lUTTRvd2FYZUhEOVErNEFK?=
 =?utf-8?B?cjBaLzFzQXVLNi9UOFF0WVo3djY0dVZxREVGNklDalFYZjVzSStHM0ZIcDFw?=
 =?utf-8?B?cm1HbVVXZW5vR1I4U21lQ25CeHlPMXR1VVFGOXFSWktpZEkxYk93aVpTV3RP?=
 =?utf-8?B?SXk3d1JOVkk5Ynl2QzhFcERBYXAyZVlleTVURm1YbURtTFZQejVOR3hBYUp1?=
 =?utf-8?B?b2FiQkV2a3EyVjAzNVNSWmptWGZwcnprSDlLODVwRGlGQVg2ZzdTeEh1ZGZT?=
 =?utf-8?B?RWRORk5UbHE2ZjZkenVJRmx0UGt3cVFGTC9JV29SMHBIaUNJWkJCdGpjTlQx?=
 =?utf-8?B?dkRNQnJaUURybXpYdkNoYmhLRnVWMGlpRXliWXljZ2Z2SndNNnNVcUR2Qkd1?=
 =?utf-8?B?WFB3TkdyNXNLaEhpcURXTUtOamt3TVZrK0lRbURPMG4xVTJLUE5hSkI0WGlH?=
 =?utf-8?B?NlkyNFdBcHF2STBMLzZMWFlYbDNOanBvWXk2MFpSMXBaU1F6TlRZdGxPRUlN?=
 =?utf-8?B?c0xGZklDSUVTZk5MNk9WKzZxc2R4eTFvQXRhdUpRZ0JnbHFXU0FyTm1DY1Fl?=
 =?utf-8?B?MTVsS0tLKzRHcWJrTis2TzFzbTkxaFFkdkg5Zno5T0tySFRwTWdrc3VVWDdR?=
 =?utf-8?B?a0ZTTm01dUVyV1EyMmthWEkveXJ5dk1aakVROUkybHgrdWpVSU1hUWREV1Y2?=
 =?utf-8?B?eno2SFkrRUlFbWJhVkZtTXJUZjFvaTltMDdyaURRZms3eWdyMVBwSnUzSU15?=
 =?utf-8?Q?aMWWcvASy00kQxMyK7xSiI8Ii?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7J13VZnJs9tzn/TU2NU0lqDqJ2Bzsr4p9lYywzHIfXmOTmA5ZX6BWYqkS8LZOLpFiVLGn8g6M/Kzb5fSNpToUnzqRsm+IuJzix6LptmKna8AHRRM4+mHtK9NR1P5YXoTAInFcSRn7pQ9/YpVwDPxusGFjBk8PnxTQRzp9Ttb/9odarQ4VKwh2CY5a8fyJx/1pM1Fkdg632nfoDFqm+Q32TPEAU3y4m7sS6pI5E1CBvqCUghXZiTCFkeBdGBHjsr2TpBdH9bYgftQ1ejmaDnhriiyCRzJadX4O3jms9ycEaeqIqVc0oUaY2CoddQ7mOtpf83rnEEvGmb2LuJsBOOJkGlb80GHfsaaAOmASehifv9kQ+Oa18844ipWh52dh7AhWqbaPRrdEoeUoRNKbn8vU+9J5nxGgRcpDbzYMl0gZNd/JfSr0O6kX3QdnTfpl7AZUZggGX87ff+li/V+Jg+bFNY/nqeQGkiRwxdoDvublNl78FQQtMrcnw5g1WcG4OfBFmm6waYqKuYiAY3jwWcOwTrU+n7LOrlTkn70greBeF3EZ+oiWEDpI4E0fJWaVIjhy1MeSPZ7aPBTLeP3ozpDS3ZPtXQG5IE/hfe15dXCCqe+NHmlGLbPLmr0baIxeqP92hLBxm3Um6ErYFW+4cXL1UvlNBoXpvSgWKxkSv+ai87vQ59Npo58X+kIAgd6hmnwhOzlzUHOJ+QcLUw/f7PHb4aXgsROh0mo0XuUr7NqrE1wYna/xfVpj9kJpmIdRVY1mwTKDLjZcjPdpdQztKAOO+IUcNpzFgvPJRw9CzMVqtPsS/SkVGD5zi7nT3ieOKR4
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af91f59c-888b-423a-b9be-08db51123c23
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 04:51:36.8627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bS7PpwXYOqMxBVClIbT2IzBVCF4xpbPfn3zrY9fCo2yFsdxEN81/leGmtdn24uzUnYVhF3jFiuKWCzN6MHNbow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7478
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_02,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305100037
X-Proofpoint-GUID: btAWMNrug6yHQK46Ny6K83D6yUS4tcib
X-Proofpoint-ORIG-GUID: btAWMNrug6yHQK46Ny6K83D6yUS4tcib
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


