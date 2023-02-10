Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C005069228C
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 16:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjBJPpf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Feb 2023 10:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjBJPpd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Feb 2023 10:45:33 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF055FDA
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 07:45:31 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AFMvVm026277;
        Fri, 10 Feb 2023 15:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=l9hitYHttmBXiQF5YvhCCG9hW1UGkEgE7uIcaUXPc78WpFZ36Qs6n0A2DJks2QteWByx
 qYvOLSumG1akAKLKGiJzES+tf5URfdZzq/GppGCzjR7fu3KryyLvffBJLdSkq6d8cDx3
 XPGRXuXp5Hlcxf/pWHOA16DTXJL3mUYXGGgS1qIupBEvsU7cf2jaopy/n0rvsX/onqBR
 VYJoLpecLlykLjUoK71zgmiiU7weYl92ZGIvLQInNLcU05lWZlxW+nnr1lAcFXJa5Oh+
 HHoiIpquhHHejM0u2SvDbMOROVL1D3HrHjdRGJOKsWM0UnrxVnNs5YYKGyyxm6BIzjEu xA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhe9nnj6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 15:45:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31AEM5pI015145;
        Fri, 10 Feb 2023 15:45:27 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3njrbexbut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 15:45:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvLzWu/qvYFuJ3F4C81JJjV1h1tZPmit/tVaLZ8gMjaJzr3kMILlNqfLe45nHRWe4ldIRAfINR7p9RouJwUb7wrCB2FGBC1p+Ne0f9b1l08LFSBeaxf+IZJ7BNaydMBnpzDSttv9+zQ+ahVJ9jEErgbSEHnAP6EgJSnZ5/BqWPvM6BP71R33dITI/UtuCDDE8OPv152E3aGVnX0u4FqRuDipnnQzYe+EKZSn61yM5lwTpSagZT4D3tT2DTlvaKw30oxMcm4l2uZ9b61Ud1qjlC4fIhyQJgnNgYDQddxvvYYz/Gi82wg/HrjA+x7vrLyJqJzAVZToKb8WB34STUTIRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=fO2nE5RhmYODI/kj44SO+5iOoYAqTMphmP4S/cY8YPiqOQik8vOmJqOfy08m0auQ0Ua8oCKsfPBUHIRwb08OJ8Ir9V2uaIgXpx/0FM2U1XQyc4mfXtPc2WGYUCnOS8CiBqx0i2CrDOX5c9wAUydMusBsCRwcWDygVlwzTGECVMvLUxpdfTXK5YyZIcN8jjcnY/w45H2ypLNXgy7tTePw6EU3Hlt2i7o9FFBu8wSRCFwS+mshzVKHHbdbVopYhiiDCFccHtZ8KZI/EqQTSVKWqbbfJ9z5NFSww4r2XWhLsJ4YlhCUX4Z3aMXej2l1wK7bJ6Bk6MogJCWtZTPenn/+6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=en9Tdv0qvWDCaZJlgU2SIF4dJgM/yjEtK1VeVJYt+8414BFFfPuG2NQhsZSsTW+bZa83qezrnt9F4CUIiTUvVagGQAS3O7J8NvF/bb8kRtrBqZonx78+jdDzK4UBGdrkJ4IRhT0vePASCXpFgCJ9E/wugjQk2cmHuvMWxiiMVwU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN0PR10MB5933.namprd10.prod.outlook.com (2603:10b6:208:3cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 15:45:24 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%9]) with mapi id 15.20.6086.011; Fri, 10 Feb 2023
 15:45:24 +0000
Message-ID: <1802f304-eca1-96b1-33f1-0beba326a218@oracle.com>
Date:   Fri, 10 Feb 2023 23:45:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] btrfs: remove btrfs_csum_ptr
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>
References: <5a3df9c70dc6e6ec3f6ee6222090c4217e2ed368.1676026165.git.johannes.thumshirn@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <5a3df9c70dc6e6ec3f6ee6222090c4217e2ed368.1676026165.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0083.apcprd02.prod.outlook.com
 (2603:1096:4:90::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN0PR10MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c1a5b2-71f2-4e3e-05e9-08db0b7dd320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J2W7cQjgR6yMr+BEOGaFf4qJPrlRv97zAurYR6QbdUa/arfrvjh11mUdPPQ2XxXSPeW7P3vEEFaJ3w9VrrbXBthHSaFecFNGWjxHamft87TBE6s+4681Nki7o2zygRVPxyiKSzuuh7VZzcnEqznNjb+KIv6Lw52HZEoimUXx6xHSgFPxkMm5+IQhcoJQwqgui8QUFxg/QztGCjmTOprwVOiXRWUohqzKsU7s6j9mAJQjzgwvTsfFVcz6hVytkermM2FZJ3kzrgNmt0DExEEikEoOt3AsFcWcPpfs67q/W6sKsHxb1VTWzSTd44iuiESHNULDdZRM3E5wIGLP34T/BtCmmPtGgCRx3G2M6I/yPsByrOQk7ghtp8/2VSctrW7X/Se0WpgNR/1WzfVcGi8uHjfTrwCwrAF/vLdOs3JFVv2ZqVf6yJfS8MJxJ/WsMdtNUqwIPeDMf3dh7i5FRK61WlRa1iiV47HbJqLMQrQGCLKrCL5hxvuqbCNeaHjU4GhWhndCD0p4IJLkHOmIfoKsGPYqoPjN6IeUpmwasyDLhUSozRun6TaHcvlmSo667Q6FAKahyR3woXDoWAWvyqig96qBU83dqiq7ftZ1V32FLjC2XDBcTwvGMgDRzBQFe1dSP2MIkDNCFz8cFS6kfHxWKDH62lfx5iP2bme9seiefvvLCVrHkV60M4oxqIOiFV3lwir6RO+JtM+BkJYqvu3n0ICf2Rm9ykFLsu7l/UKi2Us=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199018)(186003)(26005)(38100700002)(6512007)(2906002)(44832011)(41300700001)(86362001)(6506007)(5660300002)(8936002)(19618925003)(31686004)(4270600006)(2616005)(4326008)(6666004)(66556008)(66946007)(66476007)(31696002)(8676002)(558084003)(316002)(6486002)(478600001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3RMZThZM3JDbE9OZStZM1hQQWlrVVg5MVl2ZjNKb2oxSTZLdHRsS1Z2c3VZ?=
 =?utf-8?B?QUdaRDVONXZlTTdXQm9pMWlZZUI1LzRJR1NBMGFvcGtTQmcySTd2dHZyUXl3?=
 =?utf-8?B?QkVxY3ZIeWhVRnBrT002U1ZGMjZ5aUJpMWpvNm00RWxJdWwxbEp2UmF4WmVl?=
 =?utf-8?B?bkltK3FuSXphU3JKWmg1SlRPL3VjMGJDckhlZFRYUC9UZlJ1cHdvVzQ3Zk9X?=
 =?utf-8?B?YnJLZFU3Z3BWaDM1Tm45aFVwQk0rRVM3K1UwemU4NXdMYUJPbEV1dTRuY1NG?=
 =?utf-8?B?T2gwNXR4RHZNZGdTUmU1R0pZeWJKWkhjMTZ6TSsxWktYTzZXKy9IcUM5NG5z?=
 =?utf-8?B?MHd2dXJZVTVUNTRUTUhzeEk1by9scXkxYXE5MkZJa2p6eDJtQ1FpYjk5UzBQ?=
 =?utf-8?B?dmJkb0NkcGlwMjZQYlFHR1hXY2NyWFRvWWs0eWh1Vk9xNittVUd5aDI0bWI2?=
 =?utf-8?B?UW1DNzRHajZUZFE5THFzSHhDTE5vTXBVcXNpTE1BV3o3T1RabzhtclBCbVgv?=
 =?utf-8?B?bXJnRnZhM1NjNGRwTkN5eFUza3M1OWNoZ1htR04rRHpvY093TmJVeDErVDZj?=
 =?utf-8?B?RDFId2xPdHpBdkpOdkJWL3Y2RDdSeDk0VDZkQ3ZKUUVFVHFqcW9MenBFQU5a?=
 =?utf-8?B?Ujk0QW8wY1NjVFdGQWdERGQ4SGRSRVFaTGt4QzNHRDR6Rmw3eDgzTUEzSmtP?=
 =?utf-8?B?cHBiWFVhQVM5K3JYclVSWlVhNGZBWCtydmY0dnBwOHRTMTZEeU9zeUJmaWdJ?=
 =?utf-8?B?Q3hTdUY1TDJod2JZUU1HYUlNcWVVSTVBazJ2SjJwZlpGNWdxT3UwQ0lmNlVm?=
 =?utf-8?B?Z04yQklZOHh5aEFkeW0wTFlYdzJWZHpvZk83S0d6cFdLQ3h6VjBHMm9RRDZP?=
 =?utf-8?B?TnFkT2tkRUdDenZXayt5eVFLbE1udERrSStoU28wVFBneTByTThoSlhkdzZk?=
 =?utf-8?B?N0VLUURwOWZjR0wxdkpEWGRPNE1iZTBCbit1WGhnamdBSDNuV01naWJ2aVM1?=
 =?utf-8?B?eGdOZjdRaWVjelUwREpaTlBvbjlYMVVDbUdDQ09CbktCVWdNeGhTbGtQOFBF?=
 =?utf-8?B?cGxzYnY4Y1lSdHArOER2WERYOU1BS0NlZkxSTGIzM2NKWHRlTGhWRVBxOXRV?=
 =?utf-8?B?WjI4K25adEgwalhvYXRERnBDUzFnalFIb3F3c2pBa1NZVjFyNE5UOE5rL3kr?=
 =?utf-8?B?MzhIb2tFTmxxdzRMcGJWbkdJaUFRVjdheHZGb0xRS1VIL3V6YVJYRzBxanN6?=
 =?utf-8?B?bnJXZ1VFaXNIRk1HRlo5aThxenUzMk5BYXBBNjNydWFzbUNxVlRiS3BlWFVE?=
 =?utf-8?B?MTdkWVdxSW5zTFVCcnFZbGZrUjFTMEFWYUVYUHgrSEV4dDdXbkxNZzF5a0ZP?=
 =?utf-8?B?c2htT3pJMjIzbkVGTHIwaVg2aXUwQVp0T0xNejVlSmRodk11UHRvSXpHUHdE?=
 =?utf-8?B?bjFXbnQ4T01PRjE3eWRVMWN5QU5tOFlrOTh5V1MzUXh0NnUvV3pBK3V6YUNS?=
 =?utf-8?B?NHFHVmU4aUMwYllQTzc0WVhIdzRIOTQ2bk1WMktqUCs5RFRWNzJVdHlRTUVn?=
 =?utf-8?B?NlVuN0dETEYrbVdYd3AyaHFsOWFSa01wbElVZVhjWlYvazBVWlB2U0VvV1JC?=
 =?utf-8?B?V0JsMEdOWGVzVkVFbjhHV1FDVXBxYmUydnZOdisySjRjdkQrczhzVUNUS2Ri?=
 =?utf-8?B?bDZDa0RYcmIwcFZHUG8wT0MxKzNpVXVPTC94dmtYWG9YbmVLMDVEVVIwa3dJ?=
 =?utf-8?B?b083UEhsQmYxSC9pYTkvcUE3T0NqUkREb21aTDdIYWlVelhZRzhPWDBnNVdm?=
 =?utf-8?B?MzFkWVozUkNjVDlBanJEaHZRL2xZRmpvN2YwYXVuSWVHUkt4aEwwczhOQWwx?=
 =?utf-8?B?RytXcGlzT0dDTytxeHVXbFFuMkdqNVcwZ0loaHVvVG9mNmhmQndtQVZITU9W?=
 =?utf-8?B?all4NVNIajhJc2RPRDhzZno0U0ozMUZ4dnhQU3J4OHZzY1BWZWtWMTMzZEhn?=
 =?utf-8?B?OGRnMldONGliZGc3bkxQMkhscGF3ZWhKQTBKbEJHVFBIdThrakxSVDdsODF1?=
 =?utf-8?B?Z1FqS3Y4VVlrYjRvNlUxYkk5Nk1hVzV1YmJRR0dlb3ZneXljMHRvQ0ZIdEtE?=
 =?utf-8?B?bnczZUdldDQ4SmtIY2dCMXFhaEJWQkpkOVBKVnpTY1FuU3JPck5zTmlYWTdw?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QUDun3IpPRjSwNpk5LXR6e/Yi6Gq8q3EEcSHY0VqTsclf29mzhMjhgXaXOGYoinv36s9CR/fUNbWR5D3yDO/qFIQUJc+74ifjVCirnbm/KG4QDUQmT7MyOWnGfRhxNwbMN2nOEKVrAJGGo3TqivzHrSoJb09rFrnXQUu+u3Aov19zarPHhwCtVcGKCXLU0NeO/f0EsTi1d11oB+q8vnhJoKkXKSvOBomXmMwXJsKiybaHbmwVLlsjgJb27PFEHV/d4nVGx9qpc2QSOgdG8OW1H0LWGP1FlrtdsRHmxxUEQWpY2d4r9usv5t7yCmWhLvZddHXd6IPtUWYzTk1CpRSYU9+mG6JbcATtF2dmfoU6jPVmkZwCdm6FkIllc3D8BsHzfb/G2PxYUqyCPjV4oMH/lY1jTGdc0xJ7oJzNZM8ySc/vTpvTzHFMQHBUpJpDw6gvGZumNmyG+wirIuhS9RJXfIehV0Rvve/m6SRkoF4vlY8VZoVF7VyuMIjPquqQ7uMoBUJorJh5zn4hwmXZ7wdnHhcw3OTs6Bi6nSS2IWm+LtkU1qgYWtvxFElRKRVJPRjpD4NDUR0cPW2//mX3PGJkU/nBBcSRgQ7ItZBmoTXPPkqvksr9Aw3AURyVYbiR4SGLjxHAo9ZpN0x86Pz3A+flRJ4LLEApAwaI8pj6mMwYHDnHoOdz/AcAtXJhhMLZYNS/AlooDdcj6rhfNMDmcetWF1PSrBwQTLbq3KMAEpXPHwGOU3l5/Sj8nBD5TJWFfoer4IBcdc3qNcIIyXW2MMJVvKZB8Jv0mulmpwAGNqjdBY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c1a5b2-71f2-4e3e-05e9-08db0b7dd320
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 15:45:24.7727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5EQZLxtsr3JorgJRt4lehROj6O/gW/zs9cnODJ4i+4CvhRg3KlV5P3XoHSdLL0g2hF3j4aFuhaift8DMKk74iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5933
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_10,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302100131
X-Proofpoint-ORIG-GUID: ctRBEKfPhzLj64hrwopcVsvISf41Xb5z
X-Proofpoint-GUID: ctRBEKfPhzLj64hrwopcVsvISf41Xb5z
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
