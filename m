Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC4C77BD2C
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Aug 2023 17:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjHNPgA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Aug 2023 11:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjHNPfy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Aug 2023 11:35:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C5FC5
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 08:35:53 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECi976017370;
        Mon, 14 Aug 2023 15:35:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Xn4rPbwtWfCIF08emROISUWuXj6XKEqs1fTfbakrlo0=;
 b=fgQmvOym+hVE+m7xKOe2+54jdNGM2xAxcWU/6sceAD2hg1elMBYlVrcTMw6ZDRj0PHd0
 TdHL5ITeItbg9shLqxRsyV3QrIAlQPS3GufnrHsKMtdpbjO11q3QL4c1kH04xGFJlluZ
 RdrCu7y1o7M5XG55rvF/dePXLPBKdhv1pKDVc6wPb6EKJ3R9Jx+ueokvw75ia4LGQrkA
 68fHM896z5IBDlb5cE+XvU22R/8BJu7GYelR1B8hBg/o2xC8kP1KgEypeKlJzarDrgNd
 qSoeLCk6A/XTHVUYkuQ7rh+zHcvAoN816W+UGbzEfhGhl97wtmc+76R7RLCaEZ4mGu9P Mw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se61c2sxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 15:35:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EFAAVD006684;
        Mon, 14 Aug 2023 15:35:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey2c23ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 15:35:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WY4vac43M3fXn5IlR30fIqYV5JBWizRjZOXpeVicRKZXfVNT/aadLWKSpRnxf2CNL1zaTQsIxP8nogqgDHAZIhNIPQP+Z6M2SIeOdn6fFeSkSmOT6QJer9RPNMlQ2JDd5UntKmUDqM2mcgh+tKRz5uPFcB8Qruh4mj/P0vr3xXX8K+fP0GTTjqJx6euoIy3MV60vtCtFOwWNMJNrO0dQuIRN5oCvVNYAtxhwsXHc80t5PoCPf1JuH3Op9PxxI1CjAsIp1EwXF1S912bhMIEtG8+U8VHbipm5iBpsXjG2dUkxrlYlTAH1Y6wP4hE2p3H/jYjtF/eQr36xk2/NYJdbfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xn4rPbwtWfCIF08emROISUWuXj6XKEqs1fTfbakrlo0=;
 b=iNSQi44I5T2cK8XopDicM6r/lw2U0oGtbGcNjIh7Bq+Xz8/zq5+dkUkMVFecb9PkAgkCS9Gv1gW8xpqGSfIxA/XJFqssBR7ukJcvflC88AQNcqTSXtDXJHfSu4SXzhnL88GP16BDwhBvvSjMpaHm5NM0Tf4g8JGJbmiaT0jK38hrMbU3yBloCtPlQQzWDJARbmBqmcusMsMzqFJaPpV4LQBgTKeb6fRjjaphwebZMZtk4INs3kMb7v1bK4NUIq/OixlvxqFSbwLXV1X7265zwX4KroVf8XMiVXIKEkIISbYJGRzTKoVRcvzP5AQf8Slsoc38BL6NbswtIO1e4Gm8Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xn4rPbwtWfCIF08emROISUWuXj6XKEqs1fTfbakrlo0=;
 b=CDfgJtxqe9ufNSBGa4f0Z18vuQU/YMf+mo3Ee55QHMi/ft/ivETjH8v5MZy8CFvk+Zp1mEx64YYAw0k+B84OY5RAUUJhjHvwPdDj0JZitcemD0RTX9octT8TZUmTYeYoli8lYiA9kyZAZndvHGR89qm5Lb2ZyI35jn5JzOL9Tq4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB4383.namprd10.prod.outlook.com (2603:10b6:208:1d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 15:35:48 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 15:35:48 +0000
Message-ID: <52f40dc0-31de-91f4-bb5d-ef4b4eb68b77@oracle.com>
Date:   Mon, 14 Aug 2023 23:35:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 6/7] btrfs: add a superblock helper to read metadata_uuid
 or NULL
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1690792823.git.anand.jain@oracle.com>
 <5ab449690af1ec46c64ff6dad0d3702c5ebbe18c.1690792823.git.anand.jain@oracle.com>
 <20230811153913.GS2420@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230811153913.GS2420@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN2PR10MB4383:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd4e67c-bd3f-4286-b5da-08db9cdc21e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LVJ/14L2EmhjExHZ3YzLGbLmTHy8Qp6+y3wpjxNA022CD88Ls9TwM2e9tlN0/IymDqr5O0ve6a4vAA4iDqVNWqT/ojWiUnp7ZPeBihrxCuMRDDiB3uUWV4C2DveQtvvkr0kI6fbBfutuMbZCzEVVkG5BRbiMQWsY/eytVi4udzCy8ziD/7ZzsGEbhD4gfqlZCzEaENEXCpTKZ+Fcj7lvjSXeUk49pmEo5xKPFH71uLzoGwTfGvgSDveKOtoIcIg07N/rGVyKjweayVP4SELzfsbWGgbRFxCstlvJW+dhm/lK7G7LmjMpBVONxRxSqipx4V0bcR517fVnC7Vo9AWJmahVQKEp8McarsAU9+Ht+kjJpxWqq+eIkQjnb48URn9MKlOqgtD3Zv5xQv5N2oQDAjjekwTzRy+k7xtU2meLMBJnnOaSmoJ2dAS+KzFQid0gSGo6EoHhARTp7Wy4HuIr3oN9EXJZsYHBks+GyeIR9tQvB/XbfhOm2iTje9odLGjzXg2zF3ON8Uuihmn8FpoVj1t4P2XGqf9EatVakx+yjvbl5/PuiqaD/At2keNyBScIPC/1m2RRr0yFAPVBeyd7aLnp+/JKdn8m6Eni7iyX2oVSmm9ojtx04JXVthFR0G1m138+QBkOLGn4dX+66wr9AQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199021)(186006)(1800799006)(36756003)(5660300002)(86362001)(2906002)(44832011)(4744005)(31696002)(31686004)(66556008)(6916009)(4326008)(316002)(66946007)(66476007)(38100700002)(41300700001)(26005)(6512007)(2616005)(53546011)(6486002)(6506007)(8936002)(8676002)(6666004)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU1XNzdQYVZHQnVVUGJxaHlvdW9EZ2NJU2Z4eTZMdXdsSVcwdFQzaDRnR3E1?=
 =?utf-8?B?djZqVFdUYVJkU2lNWUh4eWFaUThuSjF6UkZBa1pFbVE2N1dhaWsxMm5GSmtL?=
 =?utf-8?B?ZGtkcCthVVdNYmhxbm5tYytCMXpDRFBxMzQvWWFrQ052TVV0N3BtK2xvRVpa?=
 =?utf-8?B?MmZvcEljOW5ieU5kNHgrbWh5NW9QMGlkVGlCVkZsSUM3UnRaMkloSENiTFVG?=
 =?utf-8?B?RGorNEJIUEhXdm9aUVRBeGVWTGNkS0Y2SVhnUU5RTlp3WnkrVGpvdCtPcjBD?=
 =?utf-8?B?YWF4VW96VXVkak1RYkI4TVdSenFzRzhFZ29Ldk1Oa05DZ2V0WVlPWnljbGcy?=
 =?utf-8?B?amYwbUJxbURsR083VUwzeTVZZW5LUUREcEVJN1JqYTYyRktzemhwVi9LeDU3?=
 =?utf-8?B?bFlHaHlIMWowaEF6elNRdUFnVzJjdGgxbDBWdFdYUVRBWVl3UDVib3l6VjFj?=
 =?utf-8?B?MTdldTRraVZBMHYxYzM4Rng3T3l1QmR3NDBCd1ZDdGI3aG8yQllkMDhJOGNP?=
 =?utf-8?B?ZHpPYlpHVkJyV0k1MisxM09RVUxLOGV3MEtnQllGQlRFOVFPUk1nTmFyMmpT?=
 =?utf-8?B?WlplTzB1MTJVTWRUeVc2RDRPK0VVQ1VoUnI2OWVZeENPbDRhUmw2RytvZ0lG?=
 =?utf-8?B?bXZ1Wmd6UE5rVUg5Z2NMamhham1iTXNLb1A1MHhVSXVjZGJxbXdUVjd3NVFZ?=
 =?utf-8?B?MGQ3T1VzRlA5Qm1JM1dLWHpTYkR6djNhSHdEQUF4bjd4K2hvSWx2WkRUYmw0?=
 =?utf-8?B?MSsrTFFKMm44aTVmMWZCS3BhS0ZpeFkyVTBYVkMxNytwVGd5K0VBN1dheE5o?=
 =?utf-8?B?dUFkS1lhdjA2dWVERHhONDd3c0pmT0hJZ2lwOHVJN0Q0THJRd3B3YnZxdGNB?=
 =?utf-8?B?OEg1M3E1dkl0UWtacUFPaG5mM2lncUlYd3ZMa2s0MEVwWnlMYUswN3E0dlA5?=
 =?utf-8?B?dEE4aTlHSTRsY1lhZmVUZFl6QVlIZExZSkE2TXhFOS9FRTRvNjEzNTlPWnht?=
 =?utf-8?B?ejk4U0NGMzQxM2w5UE5wVThweXUvQSt1aWxRYzZRYWVkcGwwYzh1ekZGeXFW?=
 =?utf-8?B?YjJvQ3BBUmtMQWZvRHhBMFB0bTJlT0dxV3RFQndSZk1sbXFPcFNTNkJkdnB1?=
 =?utf-8?B?eGRqMGdqMTk3YXZkaWEycEl3Nmk2QngwMEcxRjZPcm1DZzJUSjVDQ3Nnckkv?=
 =?utf-8?B?cktSY3gzWENNMEFjMVlSR3NBOXhveWNpQ2I5UzkwZEpGV0JlQnMrcVU0WHFS?=
 =?utf-8?B?KzNIWklFVy9mZXREOS92cXJLRU9ZWkkwaVRmTThha00rQ3NIcWpGdjJFMzBU?=
 =?utf-8?B?VUIwSE9JUmI5YlhtZmpHWWhGUWpuQ1l0emphSXI5ZWR3VG5zcWFyYnozVjRP?=
 =?utf-8?B?ZnIzS1R1bEtXTllmNFE0MThkVGlxVXlFNFE2VndURzRxbVpWMFk0MnpodThJ?=
 =?utf-8?B?YzRIWWZBK2NmVmRLNXBUZlNncmlPNWV0MDJ3TmtsWVM4S3JuTmMrMDB3cXdR?=
 =?utf-8?B?U213OFRGN3VJK2V2ZmtLVEJUcGt0MEw0c2xiRGllQUpnN3pyQnZLNVpPVHEw?=
 =?utf-8?B?d2RCWTZoS1hjdUxmMjRxQnYxYWhkaHBHcFduWHRrYXE1ay90NEF0TDJNZmVM?=
 =?utf-8?B?dG1jdFMxQjlYa21JRHNCd0Z4NUJDM2h3UkNwTGxMOUlzc0MrNTM0Rm1EOElI?=
 =?utf-8?B?TXdHWEw3VFRnUlZHM01aOERBSlhXOFhCTzRDanB2OTdRQVI1RURrSDNUVE04?=
 =?utf-8?B?VDhqY2Y5c0J3QTRldmxhMldRTW5FNHVkU0lxaDN6V2wxaTAzeStOWmxWRVNX?=
 =?utf-8?B?L3B0RFUwMEFHdHlSVDEyOHo2dGVJUXNBTlFramVWTjVxY0RQNVdQNFZaQWE1?=
 =?utf-8?B?dmVMRjJ1U0M2OXpicXkyOTNYVGpCOFBPUW9LN3ZrYlFBSWh2SWFsRldhU1Za?=
 =?utf-8?B?dE5lbWtNTzZiTE9heUw5Q2NQcEd5empSYXU4V0dPZUVoRVNZMWRhVXMyTnJK?=
 =?utf-8?B?UFl1WDZVNVZyQ0pDR2tjZDl3T0Y2ZWl2TW9haEFpOWdHU292cUgxQTJYcElp?=
 =?utf-8?B?eGtEaDE3eHlFdW1RM2VTSEpjTGtNV2p0VFF2SlZSbUlkYS81dCtYR1VrWkFl?=
 =?utf-8?B?NVUxK0xYOUUySDZaNnVEOThzMVVhM1graHZMRlJvOUF0eDh5RE9hVExEOTdt?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LtsuVgYM8s/WZeEs9H2DI3zpwBSnvZKqmfEnzn0CjL7ZUQfq/5JRXoxQ9eXdJklXa3+XSslz1/h728zHgXX3m1XiENceiB39DVwH56TuYmJeySe/3G3Dy4hsJopYJWKxmCt1ek/PP2xms/pCCRAujjDgTwOIi6W9cpNrZZ8N5jfX4GGPNNMvxJz5TFxFPoG9su1+sWZWiciTqcOvezuGV5NcndAWx74entdjAVyR8ko56D1lLK/6Ep/Ccr0hOjx/jVpffTd0mGGItAPLAPMzIl3N9Jbtv7xNqnWiPl/GFnmUGrjtgTD+v9t2QqBdfxeBbJwc3Yzmoa9gXU36eZQgirRDPvK+ZruicHIUYxXdA4ATsx6BxTtJaTOdesQ2j5jD+cK0UwDMyRB6KBtzBp5lAojS1tSSdSvgL0f3NxEU1jKF6FWYl/lAfo/AxDGbJIkpc2suWfzBtqHUtqx1dVD02KLhVusJhMpJbzGCqYLYuPwRlGJCXaAVhtiX7yjU5sFXWLbDhnE5YGVyezRNzk/pehhkWij3ftpBeWPD+ndSbXp0uw2syIblACfiGsjr+X2Ow2sklhWw5h8WBhZ5u7IfyLr3ms4GYZtgE7at3mmQ84LVaUV+vRQt6XYSogLJgO8M9XcTXVk+lcZ7brtuGWZm8Ns8P8vtR5ZR+nopXZfroJQ1TDlpSw5PAmvplILi7mUNnREA+si9O/sf7VzRU0vxh1sj9TBFbq7GJamxfBkBxnMlMixv/9uv0Gm8KsoV7cZHsJb2z7A4251xQk7H1MiTs2OJ918dCoaFGDI3XevL6Vw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd4e67c-bd3f-4286-b5da-08db9cdc21e4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 15:35:48.2146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGj/tV2RKb5og3HTQeftZjOjLQqaXlO88XKB5F72RZzGXBPjB0SPg2Ky2cgX1MBIvNIptgcfYhpx+QAq5xKB6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_12,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=705 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140145
X-Proofpoint-GUID: DzvFWJHJN6nm4Kg2bUNaIl2hDAv7aaxa
X-Proofpoint-ORIG-GUID: DzvFWJHJN6nm4Kg2bUNaIl2hDAv7aaxa
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11/08/2023 23:39, David Sterba wrote:
> On Mon, Jul 31, 2023 at 07:16:37PM +0800, Anand Jain wrote:
>> This is preparatory patch next two patches.
> 
> There's only one more patch 7/7 and given how short the helper is it
> could be done in one patch. The split for perparatory work and actual
> use applies more to bigger helpers.

  There was one more patch which used this helper initially.
  I'll merge this with 7/7.

Thanks.
