Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CFF53032F
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 May 2022 14:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345405AbiEVM4u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 May 2022 08:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237612AbiEVM4t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 May 2022 08:56:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441F0E0F8;
        Sun, 22 May 2022 05:56:47 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24M3xG48025507;
        Sun, 22 May 2022 12:56:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ceVhi24v2ZvePmfxBpJkuTmZEmtVrj+WB5MRr3J1kDc=;
 b=UA1CYnyQYzlcKX1RtelFL9p+TAuN7L2f916v/Ed+1hA3eO6V6nMxtZu0/imDVR2B6I6v
 JTSHtL/3pQovZym3Bt6C6BR0MRhNC7WX4bJisc/P4WpYBkmaZQhehQI2dxzdOxOXj6e6
 keVgUYFwkTBQp2sxIllkSTNjV5UFE7RWQz1Uy/sHvgMgNtSNMM7mq4/JsxFgW/rAOpd9
 QOjqmpbhKrmc6qX6JRQ0DautDO6nDzlf/QBziqLJVdGYPjFoA5vMLvrO0xMNX9etlLkT
 d+629zabmGd0qDoPHT11WmVq4d8vLNjK2hZXQZdPnmYGWE08EDbnXtnczh6cXIEsmQzo Ig== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6pp01mgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 May 2022 12:56:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24MCtqrX037966;
        Sun, 22 May 2022 12:56:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g6ph736w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 May 2022 12:56:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1z4Z1VBYJK3XqyXkVh6EDjP+kQ1iAqT8MXay757YOz8bz4vs8L+I1lFCzaFiqs8wICQVYo0FkYq7P3g/bjoeKK6tHwcv/xWISJtNMtkXGylpHdF+viq9dl+AHI84jG2O+MpiifE87IFZIH100fRI8RmTLuBQoM4Pei0pZttXZVv2uoBrI8CZ4Qxf8esyrgESLB0aT+WYBIbuou9/s0uLhLfMiQF+XcBv4JyoSndgIVw3kt8QFGM8LYCaPHgNrMVYhQ4hO0Lb0exUUtHBMzFwXGPz3AnmGSXkDUgl8r75i6tSM/IQcMnG9pO7HmaSWK7o4Ozb/lVpiV7OJsIbt438g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ceVhi24v2ZvePmfxBpJkuTmZEmtVrj+WB5MRr3J1kDc=;
 b=GpjpZMYpQRaPOeOZyxbbfxndC12Xaq/l/b7eFmndUS2lJ5Xr9tBW0PMhyKqd2oFIqriS/q/LbhyDtbb2cV4bE6QLtBrh5r3T101Or+rAGMd23ajhFy5DW7bja7/3lWmr4PHrXPAC9iCw6sVBO9z1eAoapE8Ym6aAXYEMzXL/HlgS2te8XYUxdfp9qeECtcWftTmnSMvvURTIb/U45uypNXP/kkEt3zMh25tddyZ2o11lwaW0VRCoM/PoXuAy/9R75Btt6bRmgRXXB79DKh2tyftxHx58CeRVwJHmXvrGpGpJLobsEMxZQEv/PeFwv0wczPE/Si3niYmeb3w0riexoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceVhi24v2ZvePmfxBpJkuTmZEmtVrj+WB5MRr3J1kDc=;
 b=VdDfQKYerLqJws/7ul1a1wpGoH3k5hw7V+hKlVltsyso14QWQw9sEIKfg8AvCX78gT4XSytDmobuFmshMTtdvD0rToBRoPbg6QSEQX2dVC3V1AYIcSARmU1S8Mgh5N3BbaKkMbZv2/LV7hgat6OjTqkc8YxiCRJDb+k5HjDJvW4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN6PR10MB1796.namprd10.prod.outlook.com (2603:10b6:404:fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Sun, 22 May
 2022 12:56:37 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::31ba:9027:c384:ea75]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::31ba:9027:c384:ea75%4]) with mapi id 15.20.5273.022; Sun, 22 May 2022
 12:56:37 +0000
Message-ID: <1fc36e3f-8fa9-2bfb-ede1-d4f852bcb8cf@oracle.com>
Date:   Sun, 22 May 2022 18:26:26 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH 2/2] btrfs: test repair with corrupted sectors interleaved
 over multiple mirrors
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Christoph Hellwig <hch@lst.de>,
        fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20220520164743.4023665-1-hch@lst.de>
 <20220520164743.4023665-3-hch@lst.de>
 <791e365d-eb41-9073-80b7-40ee9a42d659@oracle.com>
 <c28607d6-34c5-5c9e-cb55-2a64273c477f@gmx.com>
In-Reply-To: <c28607d6-34c5-5c9e-cb55-2a64273c477f@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR0101CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff70835e-55f0-44c0-6abb-08da3bf281a7
X-MS-TrafficTypeDiagnostic: BN6PR10MB1796:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1796D26AD5D6DAC8546F881EE5D59@BN6PR10MB1796.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u5Fy5IB0oN7sfkDR2R9qNGcpTtWhEnDiIMsFRfQ6BtPz433Ud0CFtfxNgt7WGpzIIKMie90YZ+Brr3cTW1tfcbP2Odda7mdm7UadxQ3ydOTzGX8HqUiJKfufSeoEugXGPqdT7deZlQ/DNz4pFwsUvVcXfyvZylpS/QlRZGiiClKuX8Z74EbxkU1/KiEyOB2F3jYwfejJZBUFLi9T9nTKhiY7hzfUJHHYT47ZLTyiFQ5en3zGoT7L5IxyHPT41vl1r4pcaDuKqEpmOyqPy18oG+y4ZaJMfxs+ViJdG0y/tIy56LgVLu13yh6gym2Sznrm5AodKS93XEnf8L01h4nmpyw/safQGg8K0PIuJEg8QN3v2CURafAjEZvfyhrwf6WNo/MCZ2fhQywAmcaiNXzZC3xtQgwR9dPtWBBwXdwA9xzvmR7uzl+WuXe42sp7onmE+8CGexid73l79ABDFgjEWfl+QYK+vqzmwAFSmY0d8guBzNFlwl3gPxZKCc5Wviw+IUH7ppKMa0orVXUtffsfZqDDWRTclB2Qf4TVFIs7PIA2eqZVclqQpZKnvKayRb8YBqmPxyuFf2Zyx9SpD4X9BbzMtvENsqtfQWJ7ixxrbQexIqssbcY+hHSfLGJHEh50hvUvxJs0MoX4XmRrVLJRh7A9/hyuLYQy8ahTUV6xFCN+HVBArTPa792+axHEXHteJXrK5v26Jjh+j3OQP/Vdu9hEIeLzn4Q9n1Oxw8CkT3S6UozhQy25Zad7HG+GsjPc/6IE+4M5NTmNmcpMZ5O99A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(6666004)(31696002)(316002)(53546011)(30864003)(36756003)(31686004)(6506007)(86362001)(5660300002)(6512007)(2906002)(38100700002)(6486002)(66946007)(4326008)(8676002)(2616005)(8936002)(66556008)(66476007)(186003)(508600001)(110136005)(83380400001)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjkzYUhkOVd2R0FXRUwzNFBTWHpiZzBOdEVWWW1oR0lYL0ltbnhsamdDczVI?=
 =?utf-8?B?ZFp1QTd1VTdNWUVpc1d0Qzl6ZGxFWVdvSkY5Wk83eWxsTDdZcFU1eXhXeUcx?=
 =?utf-8?B?ejRSODUyNVl3OEQ0aFd5UlQrWTNWdTRwOW96Wm53WjRTSnQ4V0RaN0JMS3pK?=
 =?utf-8?B?QWdaNDR3Qi9XZExhVnVnZ1k1blZaWlQ1L1NVem9mdmRMOHVBcG0wR0NTdW50?=
 =?utf-8?B?cUYvUkhBQ1g0R0tnY0N4cE9KVmZpRkx2R0ZPaEZoREkveG5rR3BZQUVTY3dT?=
 =?utf-8?B?WUIrU1IwTUlEYTQzNUpLYVkrSFg5aFNJK2h6TlBqQ2lHeVdMK3JYZWo0V0lV?=
 =?utf-8?B?VGhFR21xTzEwUWl1WnZCOWtDY0dKcnVUZ0QvQk5NbWNZNjBIUlZqZXdraVM3?=
 =?utf-8?B?ZWRqYWorRFlkVFBqV3JCWTVRVWduK1ErclkrNEVocWNPVndaMnVGL1krMEVF?=
 =?utf-8?B?NEExKzdZbmd1aFA2OGZSYnVxUnRWK0dVd25ZVUcwQ21ZUm9UMmlncnhkUDVW?=
 =?utf-8?B?Z0d2R05jcEtpczdwSGZzVWp3T0drWnpMbVlieDJCclQ1cDk5c1QrWEVhWmhV?=
 =?utf-8?B?T2VxbzhuNUVUbGtjd0pMazVJL0VycEQ2OGRraklyNUxPK0hCd2M1MGowMmVQ?=
 =?utf-8?B?cEtINEIrV05kdHFuMWNGZWpRb1FFa3dBNEVjZHlzV3p1cjdUVm1pSXg5MXZu?=
 =?utf-8?B?clMwZlBPWFpLUlU3OVRmQ2w2dnpGbVpQY2VWa0x4ZEp4RUFUbmFWSGluV0V4?=
 =?utf-8?B?NDZSUE5UQzB6OTk5bnZ1OFBMYzlyamtjUnNRYnhZMFBLTnFsT1JYd0QzMG05?=
 =?utf-8?B?aC9JQjUwSWRQcytIRkUvYUpVQTFnUGFIV04ycTB6b29PVDZGb0pmTngxNWw0?=
 =?utf-8?B?ZHpobFg0aHN4QXpPdzhjUVdPMXBCRWdob2NrdUlpbEprYlNNWmlvOUpBK0Zt?=
 =?utf-8?B?bFJBRTlrOTE5eTV2dWFGRUNoNk00cS8vWVo0U3JNcFFRMHBLUHUydkdwRCtW?=
 =?utf-8?B?WEZtSWFaTVpldGpjN2RlREcyMGczTU1tdGkzdXV2WWlwNmhLcXFCWnJmLzNy?=
 =?utf-8?B?QVVOendVdGFOcnRVTWtFQjZQUGZyTUdad2JsOGRPQkFIb3Z5YStzcHhjM2k5?=
 =?utf-8?B?dFRnYUdIMnpJT1p3bVlkY0lvdDZlUVB3VDh3Y1ZtalRWMHFTUW5yNTdJRXhB?=
 =?utf-8?B?cWJYbjVTMTlYNWpWTk0yY2E2YktpTUFQT2VWMllxSTNDMGdOL09VNjQvalVW?=
 =?utf-8?B?YTY5N0JGdGltaG5oUmRtRnVpU0EveU9US29hTXhPZTlSY3dnSnd1bnhUMncv?=
 =?utf-8?B?a25xSHJvK2ZlWkNFRzdmTnlrOHNmbFFVUHFvSDNkM3RpYk15b0UwVE5iWkl1?=
 =?utf-8?B?YWNWM1FPN25zTWZjUTk3TVVqQlBjRWUrVTNyRzJoakRsV2dSZldhd3ljOTI3?=
 =?utf-8?B?Z3dUZWVaRWlaMHpIWEpWZWk1Uy9zTkRpcXF0a0JmWWJNcFVqYjhtbDErOVpG?=
 =?utf-8?B?U3NhSVNaemdyQk1keGZoY1dxMVROYjI1THJwOGRaTjgxK0JWaTdORmVqOTRm?=
 =?utf-8?B?Y2s3SXNiS3d3M0kzSUxFdnNFTmlzMUJ3Y2JES0FjcXZYNkhOTnZJdmVqSDJ0?=
 =?utf-8?B?OFBFS0paV2RWVU9tODNWU2htUTkveHBqR083TFZmWFFJakJWYXltdVNrTGhV?=
 =?utf-8?B?NWlsMXBpM1VJbVIwUU9QOGROZWxHUlVoNFplZUZCdmg4MEY4MlNXellTVFU4?=
 =?utf-8?B?ZlNBM3A5aTBJbm5OZE4vbGwwZ2pWYmNDS3NxNUV4YzZJRjJNNUZCdHFqK3Bi?=
 =?utf-8?B?emFzczM5SzFyRWFndnIyN2QyRFEyZmpDZ0xZLzZRQjdEbmszRDFvQSsvQmxW?=
 =?utf-8?B?cVlIeWNUOFd5cXZhOENhMVdXU2NJTlFrbHJYYzhHcWR3c3U0VlFndjBPTHNx?=
 =?utf-8?B?MHNNUVBUUWdxbTd0TEh0VW13QmY1cG1mK29QMWJyN2NHTU5hdnpKbDJCVXo3?=
 =?utf-8?B?R3h0V2x3TCtHekNFY3U3NEtoZjhoT1VXUTdFRmhOREc5U1pRbEh2Q0Y3enFl?=
 =?utf-8?B?alcreis1RWdGMEpqaFBZZ2RPVFFiLzI1cEczYlhHU1pKQ1BOQXdFZGpMMHJm?=
 =?utf-8?B?bkR0VmZER1BiVFZOeXFURTk5blJQOTVuTmhXUGZiVWJxc2dhQlZVSE1xUlVa?=
 =?utf-8?B?RkF2a3VLU0ZNbzl6TXBGWjU2T1J1TzdoWGpSYnlHWDlxVlhObTZ1NytzRFV2?=
 =?utf-8?B?Q24yRHVLMVNIRUNqd2VmWHI4YkRNUW9DaEJNMlZWck1sNWorZTF2bWs4OG1l?=
 =?utf-8?B?NXl6NXo2Q1VwSE1HTUl3QjRtNzg4Qm9PejY4Qy8ydE9tYkRMZkVQVjlPOVRp?=
 =?utf-8?Q?tH3LWRzW6emjRxZ7s8gCTlDRWKvjZJ92WvOuyPKIKyYLK?=
X-MS-Exchange-AntiSpam-MessageData-1: BdZ2nP4eg/UdTNKbOwH5uiaens6IicDWrsI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff70835e-55f0-44c0-6abb-08da3bf281a7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2022 12:56:37.3921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +alioO/6gm6AfeIcGoTay//NIVs3WwCQj+tVw/WEkp5oq4SfilpF3VFVcpauH3Sd+o3cL/95P//Q1F4+pKkDyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1796
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-22_04:2022-05-20,2022-05-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205220081
X-Proofpoint-ORIG-GUID: D0nuo57DqLzzD3-csHTvHOSHT4zckaLy
X-Proofpoint-GUID: D0nuo57DqLzzD3-csHTvHOSHT4zckaLy
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5/22/22 12:01, Qu Wenruo wrote:
> 
> 
> On 2022/5/22 09:13, Anand Jain wrote:
>> On 5/20/22 22:17, Christoph Hellwig wrote:
>>> Test that repair handles the case where it needs to read from more than
>>> a single mirror on the raid1c3 profile and needs to take turns over the
>>> mirrors to recover data for the whole read.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>> ---
>>>   tests/btrfs/266     | 145 ++++++++++++++++++++++++++++++++++++++++++++
>>>   tests/btrfs/266.out | 109 +++++++++++++++++++++++++++++++++
>>>   2 files changed, 254 insertions(+)
>>>   create mode 100755 tests/btrfs/266
>>>   create mode 100644 tests/btrfs/266.out
>>>
>>> diff --git a/tests/btrfs/266 b/tests/btrfs/266
>>> new file mode 100755
>>> index 00000000..24c2b5fd
>>> --- /dev/null
>>> +++ b/tests/btrfs/266
>>> @@ -0,0 +1,145 @@
>>> +#! /bin/bash
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +# Copyright (c) 2017 Liu Bo.  All Rights Reserved.
>>> +# Copyright (c) 2022 Christoph Hellwig.
>>> +#
>>> +# FS QA Test 266
>>> +#
>>> +# Test that btrfs raid repair on a raid1c3 profile can repair
>>> interleaving
>>> +# errors on all mirrors.
>>> +#
>>> +
>>> +. ./common/preamble
>>> +_begin_fstest auto quick read_repair
>>> +
>>> +# Import common functions.
>>> +. ./common/filter
>>> +
>>> +# real QA test starts here
>>> +
>>> +_supported_fs btrfs
>>> +_require_scratch_dev_pool 3
>>> +
>>> +BTRFS_MAP_LOGICAL_PROG=$(type -P btrfs-map-logical)
>>> +
>>> +_require_command "$BTRFS_MAP_LOGICAL_PROG" btrfs-map-logical
>>> +_require_command "$FILEFRAG_PROG" filefrag
>>> +_require_odirect
>>> +# Overwriting data is forbidden on a zoned block device
>>> +_require_non_zoned_device "${SCRATCH_DEV}"
>>> +
>>> +get_physical()
>>> +{
>>> +    local logical=$1
>>> +    local stripe=$2
>>> +
>>> +    $BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV >> $seqres.full
>>> 2>&1
>>> +    $BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV | \
>>> +        $AWK_PROG "(\$1 ~ /mirror/ && \$2 ~ /$stripe/) { print \$6 }"
>>> +}
>>> +
>>> +get_device_path()
>>> +{
>>> +    local logical=$1
>>> +    local stripe=$2
>>> +
>>> +    $BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV | \
>>> +        $AWK_PROG "(\$1 ~ /mirror/ && \$2 ~ /$stripe/) { print \$8 }"
>>> +}
>>> +
>>
>> Can wrap into a helper in common/btrfs.
>>
>>> +_scratch_dev_pool_get 3
>>> +# step 1, create a raid1 btrfs which contains one 128k file.
>>> +echo "step 1......mkfs.btrfs"
>>> +
>>> +mkfs_opts="-d raid1c3 -b 1G"
>>> +_scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>>> +
>>> +# make sure data is written to the start position of the data chunk
>>> +_scratch_mount $(_btrfs_no_v1_cache_opt)
>>> +
>>> +$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" \
>>> +    "$SCRATCH_MNT/foobar" | \
>>> +    _filter_xfs_io_offset
>>> +
>>> +# ensure btrfs-map-logical sees the tree updates
>>> +sync
>>> +
>>> +# step 2, corrupt 4k in each copy
>>> +echo "step 2......corrupt file extent"
>>> +
>>> +${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
>>> +logical=`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_filefrag |
>>> cut -d '#' -f 1`
>>> +
>>> +physical1=$(get_physical ${logical} 1)
>>> +devpath1=$(get_device_path ${logical} 1)
>>> +
>>> +physical2=$(get_physical ${logical} 2)
>>> +devpath2=$(get_device_path ${logical} 2)
>>> +
>>> +physical3=$(get_physical ${logical} 3)
>>> +devpath3=$(get_device_path ${logical} 3)
>>> +
>>> +_scratch_unmount
>>> +
>>
>>
>>
>>> +$XFS_IO_PROG -d -c "pwrite -S 0xbd -b 4K $physical3 4K" $devpath3 \
>>> +    > /dev/null
>>> +
>>> +$XFS_IO_PROG -d -c "pwrite -S 0xba -b 4K $physical1 8K" $devpath1 \
>>> +    > /dev/null
>>> +
>>> +$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 4K $((physical2 + 4096)) 8K"
>>> $devpath2 \
>>> +    > /dev/null
>>> +
>>> +$XFS_IO_PROG -d -c "pwrite -S 0xbc -b 4K $((physical3 + (2 * 4096)))
>>> 8K"  \
>>> +    $devpath3 > /dev/null
>>> +
>>
>> Could you please make this test case compatible with the 64K sectorsize
>> configs too?
>>
>>
>>
>>
>>> +_scratch_mount
>>> +
>>> +# step 3, 128k dio read (this read can repair bad copy)
>>> +echo "step 3......repair the bad copy"
>>> +
>>> +# since raid1c3 consists of three copies, and the bad copy was put on
>>> stripe #1
>>> +# while the good copy lies the other stripes, the bad copy only gets
>>> accessed
>>> +# when the reader's pid % 3 is 1
>>> +while true; do
>>> +    echo 3 > /proc/sys/vm/drop_caches
>>> +    $XFS_IO_PROG -c "pread -b 128K 0 128K" "$SCRATCH_MNT/foobar" >
>>> /dev/null &
>>> +    pid=$!
>>> +    wait
>>> +    if [ $((pid % 3)) == 1 ]; then
>>> +        break
>>> +    fi
>>> +done
>>> +while true; do
>>> +    echo 3 > /proc/sys/vm/drop_caches
>>> +    $XFS_IO_PROG -c "pread -b 128K 0 128K" "$SCRATCH_MNT/foobar" >
>>> /dev/null &
>>> +    pid=$!
>>> +    wait
>>> +    if [ $((pid % 3)) == 2 ]; then
>>> +        break
>>> +    fi
>>> +done
>>> +while true; do
>>> +    echo 3 > /proc/sys/vm/drop_caches
>>> +    $XFS_IO_PROG -c "pread -b 128K 0 128K" "$SCRATCH_MNT/foobar" >
>>> /dev/null &
>>> +    pid=$!
>>> +    wait
>>> +    if [ $((pid % 3)) == 0 ]; then
>>> +        break
>>> +    fi
>>> +done
>>> +
>>
>> Same here. They can wrap into a helper.
> 
> In fact, we should recheck the way we handle the read on specific mirror
> behavior.
> 
> For a lot of runs, btrfs/14[01] can take super long time (over 100s) to
> really trigger the data read on expected mirror.
> 
> For a lot of runs, the read just got the same pid again and again.
> 
> Can't we at least add some noise at background to make the pid more random?
> 


  Agreed this method is unreliable. But there is no other choice.
  Unless we integrated [1] patch in the ML.

  [1] btrfs: introduce new read_policy device

  [1] is more reliable. You can set which mirrored device to read.

Thanks, Anand


> Thanks,
> Qu
>>
>> Thanks, Anand
>>
>>> +_scratch_unmount
>>> +
>>> +echo "step 4......check if the repair works"
>>> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical1 512" $devpath1 |\
>>> +    _filter_xfs_io_offset
>>> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical2 512" $devpath2 |\
>>> +    _filter_xfs_io_offset
>>> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical3 512" $devpath3 |\
>>> +    _filter_xfs_io_offset
>>> +
>>> +_scratch_dev_pool_put
>>> +# success, all done
>>> +status=0
>>> +exit
>>> diff --git a/tests/btrfs/266.out b/tests/btrfs/266.out
>>> new file mode 100644
>>> index 00000000..243d1e1d
>>> --- /dev/null
>>> +++ b/tests/btrfs/266.out
>>> @@ -0,0 +1,109 @@
>>> +QA output created by 266
>>> +step 1......mkfs.btrfs
>>> +wrote 131072/131072 bytes
>>> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> +step 2......corrupt file extent
>>> +step 3......repair the bad copy
>>> +step 4......check if the repair works
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +read 512/512 bytes
>>> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +read 512/512 bytes
>>> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>> +read 512/512 bytes
>>> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>
