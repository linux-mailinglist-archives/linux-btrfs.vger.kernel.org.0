Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED882784EC6
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 04:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjHWCiW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Aug 2023 22:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjHWCiV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Aug 2023 22:38:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127FBE47;
        Tue, 22 Aug 2023 19:38:19 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MMEDuE029956;
        Wed, 23 Aug 2023 02:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8h2d6YeHFEluU02tzPA5CDGP18enhcvHS5iXusRc6Uw=;
 b=t5xtMezfFOBe0vmTBLf8Qp7KihFiL14m3rbvsLgGn5UC/iK90IMInAcj0pgCejCl6bfz
 VxVUVI0kCB4qPsVHWu60vjHTkdJjN5Ob9p1LROuaE1xkr8BYkpLcQ19mgs2g1cmUjly9
 18muhOYxzDhNneCBPnYetDViudeWkElUIe4UHdJOJ3ImmeFe/HWuWspll109D8HUcE4W
 36uolwF8J+1Kr0+velen86fWqIBCOTi0lyYsR7dHxkDekUcKkB5OICKvtkkhaMsAnnlz
 +U2mFsc/MgWqj0/bXjDskiGsjuyFLcODHNUc646L119NwHHlLWRzhU9jCfphyLbWmmxY jA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yvrs6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Aug 2023 02:38:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37N0R382033220;
        Wed, 23 Aug 2023 02:38:07 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yues38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Aug 2023 02:38:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4y+gBEzT3/TTwCbwgy0vHynSvqs28v8hXp2+SlF/uRjm1ghO3bkn19Yrv60SiaecPtXobmqMrWaMOWm39pNU0V7BQ6wCGXfsKcc5vaTipQgom0mpW35FUoKMpvxrM+C49U46h+snWXD6T/oA01qJhaY4dYTXRKRGfc3n0E/wB2B07YdZq+Q35o41fnGkrXJjGQ8jKTQTn/Cx3+01hFpLhRURmz/ufdefGUfaQ6X/n+0+Og5YmORlNVFV6j/r7iQJqxslek0IPZWw5eFO1WtRynGDI21rTa5Ts/HNUZxr5bx97/PYjeZ6r8NBnlUdCUVDiqEHqTC9BhF6ZiGT/KPZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8h2d6YeHFEluU02tzPA5CDGP18enhcvHS5iXusRc6Uw=;
 b=IWImA8vYYzafpTebv4RWQSKBu411Z+ZFbc5PNrMzxWNiLN1nN3npJLdaRA/5w6R8En1qGuFpOfrWdcqXoHD0t+KoCFhTo7/FqpAb6ujoeaOtDdtUV4woSWIkhjOS2yIG92coX4coesi8AZ9BBe9KjMym7PgyVe5eZXReXuUXlHxU3TEZ9o9VpDInz6BklOfYp/DGl1ARdBAUDoppxpGKBpB+i1UQAmQqFvaPOsUPHB8trV2thVXzZIaLiMN8Y4WPiNs2JoUaak3obBaIFomgydhPwqfxOllfQSqBusKQSIc4O7HaSRUTtHAaOvHj3q1jy7NnNI99sdMX0PySrOKxHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8h2d6YeHFEluU02tzPA5CDGP18enhcvHS5iXusRc6Uw=;
 b=Wd+V5d0oJAVCkHt+4mppW5+KUz1tyw6tqrMIpZzRtSDp+GLUU1FAYqke07P1SrT86Z+XmNdNMdUkB/Hkp68VM9VocJI3zhjgRTgJUoQzJcVsC3YnviCXvvi7KaQn3hO+nAq1elc1rpD9OS5u8qMxlSwGwJvPaEeYOG0aObTFKN0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB7449.namprd10.prod.outlook.com (2603:10b6:8:17e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 02:38:05 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 02:38:05 +0000
Message-ID: <617bdb2b-7220-80f3-d31d-580a8901763c@oracle.com>
Date:   Wed, 23 Aug 2023 10:37:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] fstests: fsstress: wait interrupted aio to finish
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     axboe@kernel.dk
References: <20230821230129.31723-1-wqu@suse.com>
 <590727d0-5452-5469-711f-2b8cdff25719@oracle.com>
 <e1741eb5-db9e-4da6-9d0d-dbc09cb2b66d@gmx.com>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <e1741eb5-db9e-4da6-9d0d-dbc09cb2b66d@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: 66d00bd1-ece3-49d8-209b-08dba381fa48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rNQht8qN4wFOfYsiqvuw3f/fZd81HO6YH44wEHDvcezVHRxneSQgvBBwamsay3OZ+TfsbRyzDM+NYGXj1Y8PENC4dQ4/Gp4/VsUDoxugH7nZJibmaUTYLQqsUGZWqh8YAfagNLNSFpir4u67LOKZiRu01gWCFXZX+XD8EDAnIGvJb19kJKDGuhUO4tPyF+CmmK965fnBREFBOqd40H7FSd9uNP3OzHColaTtxe12UP9OcoTKM1SMVdpmuTBJpn5+vIKhD5g72FUvFV0A5v1h74K6v/5H4QOZAckfsV8xqBK41EUN00dMUAVo0kSRzUUquB09XPu/BLrpRJJTmpwQjuXzu+1eZusp1UPHojJkLwj0rw8BTHFlPpWV+66xjdz2DnxU6DvUxu2CfXDU0/3yrMU7piLMDzvp7qSQCXMLZFVOQWBi7YSfrHT4ATnkDn41wZgggvMRdvmHhuM5k90PeEx2oY1t8DoS+edJl9xzWfjdTE9PcejEEvY5v/PRhSCnaKKtttxdnnFIlYe2Sg6WoZqEocAdh+Z+lWeLPXpCb3KJyBWwY8ix+SXyJVgHl4GZi8CqjiOEWrAlpPFTGe82UKl9zgkKM7w/eG6kv+1iIeLPvBcaawi5Ays2P03Ure3y1AGSXhQF31SbJe1wdhWbNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199024)(1800799009)(186009)(2906002)(38100700002)(6506007)(53546011)(6486002)(83380400001)(5660300002)(44832011)(26005)(31686004)(31696002)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(6512007)(66946007)(66556008)(66476007)(110136005)(478600001)(6666004)(36756003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWdnMjdRanB6a2FlSXBHbjJFR3VYZ0FBS0VYbnJSV0JpLzI5a1RIUnl5OWlx?=
 =?utf-8?B?V3FjdzNPZERBTHFJQmZQSjJNcGRYYWNXb0xhVTBjZ0dtOVE2dmt0VjZ3WDJz?=
 =?utf-8?B?UkNwa09KU0d6Tkd2UHMzM0c1N0JkaXdQMC80NHhhVDFXRldLRmJhakUwTkxB?=
 =?utf-8?B?U2c4L1FjWnd0S0VUc0VtT21odHJOWHFqb3JVQUlDUXVXZkk5ZnpQMk5RWVFC?=
 =?utf-8?B?YUhTd2RVMFpEVUQxMGNiOEJhZFFGZzZ0SEtSeVVIbHB3MlVLTUtyMDIrZ1Ax?=
 =?utf-8?B?eTg3d1BTaUp2dk1kOEcyc0VJVmNKTUZRSm13bFF3QWMyOFBVNnhQL1ZOYVJM?=
 =?utf-8?B?T2IzeXluREdMSXJPcWtZMGxJcnhiQmN2cWlxVG1CV2d6Q3FEMVhLZW1abFN0?=
 =?utf-8?B?OFBtbGZ0eWRMd0lxbDViV3JVS3BUWkhkM3lsLzVhZUFtNytSdVhzRjJpbHpv?=
 =?utf-8?B?Q2VCSXFVRkQ0U3BZMDJTZFlaNFZmVDJkWmZxYW9DSkl6SWNzQ2EzL2MxR2Zs?=
 =?utf-8?B?eXJBSnlwN1g0NzlUVzM0Q2RIYVpSN1hzd0FhR3QyeS92WWpORW9xemVsQm45?=
 =?utf-8?B?V3ladzA3Z1g5dzRHZTNwcWx4WWR4bmFadTRBblhSeGFLWFJPMUdQdkFkQ2lQ?=
 =?utf-8?B?WXJUQ1RXL1dxTnl1L1Z0UUxhN04zRjMxeG41a3E0S1hIQWJTanFLQmJwZktt?=
 =?utf-8?B?TGZhWnRvNXVTbXFDa2tHUlVhbWVNZVhRRUpRMktReGxzQjNDQk84Ly9ZZmFZ?=
 =?utf-8?B?am5pcG54ekQyRURYUkxpZnExdzNqb2FEQ0tMMHFJbHBBU2l6TjZEVC9nN1cz?=
 =?utf-8?B?WFEwbGJZSHI3eEtPSnFlaDdoOXZCTStpTDlEOFk5cTZhZUxKKzBoSXRBck1l?=
 =?utf-8?B?aGpDY25MQWc1Q3FSWlh6WmVUWHluS0VNcENBa0VVTzBTNHpLTDlsZXJuRXla?=
 =?utf-8?B?MVhkM1VHUjR5aDJQSTBUUk5IM3dEQ2xCZ3FjSHV5MGpHRlZBMXJkMFJEbGMw?=
 =?utf-8?B?VmNFWDVKUDllaVBBNy93b2FlR0diaHVEN1FGb1g3OFVSZ2FsZVljaGxYdERZ?=
 =?utf-8?B?eVdiaS9veDVKK0NabXFrMlpmREVGbjJZMjZqLzdlSG5yeThYT1kwT0RxbTVC?=
 =?utf-8?B?MlVqR1pSaVZzYUZVUFpTYUdLeTN5c0hsTXBjd2V2Y2pXcjVpVFZlWFYzMGFq?=
 =?utf-8?B?RXJmYWJRK0Q1eHUveGxwTFBzeWVCNTBPR3JYOHVQcG4zUmJteEJUVEdZZmJU?=
 =?utf-8?B?Uk5TTG9GK0ZhYU9vQ3ZqdGZFWG00cVh6Q2hJUmhOTVpDTjhmU2c3ZXpLN3Nj?=
 =?utf-8?B?K3FyMWgvMEhQcTh4SlNDUXpCMTZYZ3k3YXEzV0RONzFuMzcvVnZpWlRvMita?=
 =?utf-8?B?cURNUWdmQjM0MytBRDRCaTVjMVMraCtLY1JwdWZ4eXN5elN6dkUzcW5aZUIv?=
 =?utf-8?B?c25HM0NEdjJoeEc2SVM4T1N4RWk5cnE1SnBBUVhQMTNTN1gvcW5Pd1ZEWmY0?=
 =?utf-8?B?Y0laTnY4YUd2c1d1RGtsZ21rZTlEVDdzWSs5KzN2RWRRZk1BKzh0bnBRSmVQ?=
 =?utf-8?B?TVRDZzl2S1NqZStzOXc1aXc5dHRVT0hNNHg0a0VJUnc3ZlpWQVNPdTVGKy92?=
 =?utf-8?B?QTFUR2NjU2FJcTdyNUpUb1FLNlFJRkl6Tm9XVHRTYzd0Sk9RdVNHRDYybVcy?=
 =?utf-8?B?QXdVTVV4QURqTzBnT2haSVdZQkI0MlJCaEhxdTJvcW5ibWRGV0JrNWkwakhU?=
 =?utf-8?B?MENBclJucXI1L1JQNHdPRWw2S2MvZEVhZTVlWE9WK3FVcmFJZFJRUHMvVGV3?=
 =?utf-8?B?ek8yOUZtdTNLanpUM29zVFBRZkZOYVhkSGdTUndTRmRyQzVUZGpBdXcwRURV?=
 =?utf-8?B?UXAyVC9lQ0pyRHhzak02a1VRcjZXOXJYamVNTS9GSjV1dWZUaVdQdnpLYk5k?=
 =?utf-8?B?eHhJSENuYWVaUEZLUWxRUEIvbzlIZTAxT0Vic1RtWHVNV3I5alNwcTBiUHdw?=
 =?utf-8?B?RVcraHZNUURGNlVKSUxjWHh2VDU0SVNnZVMyOFlGYjU2MnhSNm5jR3JPYmtv?=
 =?utf-8?B?bUxQZ3lGTDFIRnM5MElsU3RvT3Z5dlkxejd1bFM4SFlaOEFXZVhIY0ZQWXJO?=
 =?utf-8?Q?gsdX6hzvmT6WfWtWA1XhNZbKk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XGgUqbjhGe/u58T1PnW+3dYx8Glmlx1N3XJ9SGVHrWiVM9NvmwJjOGEMf/cfE12PCNLwKvrxcp9wOcqnJY6iUSOmGIFbeUse9cWQ0Hbo42M8/06GqUph/O+jTQ8A89oDuQpOTjlUq7SffZH+dAZYzKlEidFLyRs5JPHm0MTDLBdrW8eRiZP8mfOPfE3n6IZEkI8r07fzOfCWtDA0Fv/UkpHOr+NzDa5wEKbIIOxkvn8R9y01CIRSprrjIqMOitSwnkwGvrmpCtaU8lNnUOW6zwAdQ1goGFWPQJJvts2orz/Z1UR6oVXLGb3Bu74LPS2LIGIWyh39WyyTPHwXwoLzjzNIsB9wsTVLMcZfN1mqDzHOUprISUbJC8VEnpc/j+SNqRzEF9eiWhxDKD4DBLoN81pBbwVelITHk0hSr9DuVpDCT8J0xca3/cLEkKpXFW5v4Y+AzCtSyCJREABUahlnNBYRBTBs/wenAVil99Ll8frnPyO145rr8l35f8yU03JgCtp7WXDf6U+0RwRQEgZl92E4fsgbtrI++whYk3qqcZqsjxfeGHv7hf4Tza+Eiv57YhLp0GUZnA9PdRLRXTDNvog6QdJdQ4AWiSSnhKVDXcXz8b/1jLF4FtMQ+sYypC7TWAZnUVDi8FpZkW2d2Ivq3UnLYBARLXWt+cr5M+Rt7Es4l5LZqBYOTj2jThf3WxIvNT3dy8fZ/g7i3ucmKQ1e2zFgkqZI5DhuJwlwhCu4MnxjcjG2P1JsaYWL8wejv33ALRtW9eQnJaiZnhrVTFQ1dMkDpu/io3qmYIhbjppAVgTNy3AFep57I+1jxKgRzEUGYxNwPgJitpMZQgCPTBRplg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d00bd1-ece3-49d8-209b-08dba381fa48
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 02:38:04.9910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8C149RblFX3SrZgFG10Zpq9GWDJEvbNPIfLKvwmEtf7GMPknPsE6xJ7rVjdPhmmYLYGineumWL9L5QUk8voxpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7449
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_22,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308230022
X-Proofpoint-ORIG-GUID: 1sAjOldzjd6pWS805qkoAm9iUrEGzUtG
X-Proofpoint-GUID: 1sAjOldzjd6pWS805qkoAm9iUrEGzUtG
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/8/23 13:16, Qu Wenruo wrote:
> 
> 
> On 2023/8/22 12:05, Anand Jain wrote:
>> On 22/08/2023 07:01, Qu Wenruo wrote:
>>> [BUG]
>>> There is a very low chance to hit data csum mismatch (caught by scrub)
>>> during test case btrfs/06[234567].
>>>
>>> After some extra digging, it turns out that plain fsstress itself is
>>> enough to cause the problem:
>>>
>>> ```
>>> workload()
>>> {
>>>     mkfs.btrfs -f -m single -d single --csum sha256 $dev1 > /dev/null
>>>     mount $dev1 $mnt
>>>
>>>     #$fsstress -p 10 -n 1000 -w -d $mnt
>>>     umount $mnt
>>>     btrfs check --check-data-csum $dev1 || fail
>>> }
>>>
>>> runtime=1024
>>> for (( i = 0; i < $runtime; i++ )); do
>>>     echo "=== $i / $runtime ==="
>>>     workload
>>> done
>>> ```
>>>
>>> Inside a VM which has only 6 cores, above script can trigger with 1/20
>>> possibility.
>>>
>>> [CAUSE]
>>> Locally I got a much smaller workload to reproduce:
>>>
>>>     $fsstress -p 7 -n 50 -s 1691396493 -w -d $mnt -v > /tmp/fsstress
>>>
>>> With extra kernel trace_prinkt() on the buffered/direct writes.
>>>
>>> It turns out that the following direct write is always the cause:
>>>
>>>    btrfs_do_write_iter: r/i=5/283 buffered fileoff=708608(709121) 
>>> len=12288(7712)
>>>
>>>    btrfs_do_write_iter: r/i=5/283 direct fileoff=8192(8192) 
>>> len=73728(73728) <<<<<
>>>
>>>    btrfs_do_write_iter: r/i=5/283 direct fileoff=589824(589824) 
>>> len=16384(16384)
>>>
>>> With the involved byte number, it's easy to pin down the fsstress
>>> opeartion:
>>>
>>>   0/31: writev d0/f3[285 2 0 0 296 1457078] [709121,8,964] 0
>>>   0/32: chown d0/f2 308134/1763236 0
>>>
>>>   0/33: do_aio_rw - xfsctl(XFS_IOC_DIOINFO) d0/f2[285 2 308134 
>>> 1763236 320 1457078] return 25, fallback to stat()
>>>   0/33: awrite - io_getevents failed -4 <<<<
>>>
>>>   0/34: dwrite - xfsctl(XFS_IOC_DIOINFO) d0/f3[285 2 308134 1763236 
>>> 320 1457078] return 25, fallback to stat()
>>>
>>> Note the 0/33, when the data csum mismatch triggered, it always fail
>>> with -4 (-EINTR).
>>>
>>> It looks like with lucky enough concurrency, we can get to the following
>>> situation inside fsstress:
>>>
>>>            Process A                 |               Process B
>>> -----------------------------------+---------------------------------------
>>>   do_aio_rw()                        |
>>>   |- io_sumit();                     |
>>>   |- io_get_events();                |
>>>   |  Returned -EINTR, but IO hasn't  |
>>>   |  finished.                       |
>>>   `- free(buf);                      | malloc();
>>>                                      |  Got the same memory of @buf from
>>>                                      |  thread A.
>>>                                      | Modify the memory
>>>                                      | Now the buffer is changed while
>>>                                      | still under IO
>>>
>>> This is the typical buffer modification during direct IO, which is going
>>> to cause csum mismatch for btrfs, and btrfs properly detects it.
>>>
>>> This is the direct cause of the problem.
>>>
>>> The root cause is that, io_uring would use signals to handle
>>> submission/completion of IOs.
>>> Thus io_uring operations would interrupt AIO operations, thus causing
>>> the above problem.
>>>
>>> [FIX]
>>> To fix the problem, we can just retry io_getevents() so that we can
>>> properly wait for the IO.
>>>
>>> This prevents us to modify the IO buffer before writeback really
>>> finishes.
>>>
>>> With this fixes, I can no longer reproduce the data corruption.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>> Changelog:
>>> v2:
>>> - Fix all call sites of io_getevents()
>>
>> Should io_getevents() in aio-stress.c and fsx.c also be using 
>> io_get_single_event()?
> 
> Nope, this problem is caused by the fact that io uring is using signal 
> to notify the completion, which would interrupt io_getevents().
> 
> For aio-stress.c, there is no io uring utilized at all, thus the signals 
> are real signals provided by users.
> Although it's still possible that user provided signals interrupt the 
> operation and cause the corruption, it's not really a bit concern AFAIK.
> 
> For fsx, io uring and aio are exclusive to each other, thus it's the 
> same as aio-stress.c.
> 

Okay, thanks.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


