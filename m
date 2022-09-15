Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557F35B98E6
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 12:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiIOKhY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 06:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiIOKhX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 06:37:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1639A785B8
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 03:37:21 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28F95TiK021818;
        Thu, 15 Sep 2022 10:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=zeZA2U5V4/6jN45QQpEMuTYZONGebBPiK5gnK1lH8QA=;
 b=RfphyLxIDe8udVuKeAhbHKQKzq7w9W1rCmb7R2/qYGFDQIpwsnJvVifqUGgfIaMYRoZ9
 P/OqD8mzULaWJQ/Bf2U+V7ZF7l2Od/UJKCayAQdbCCsKpD60uLMEhgIHOaI3EspqCv4G
 Szr8nBa/id4D/Ex6VQT2lTHHXmbfcSnCmnQXzwLXi/C3UC0cR51t4Ouqi72AcquzzWpD
 +K0mByEKHNIeL9y206VzOgVHo803L73LANwmSAUSTx4PJYI5+6Zgzeytd9WrtUQbIiZ3
 muuhD4FYz9GZOq8zDbGB7xXFg8L+1PIZDWXS4bWQ4JEAuI8HaEZApITI5bHGYv7ZyOQ7 XA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxypcud4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 10:37:19 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28F7qM6H002805;
        Thu, 15 Sep 2022 10:37:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jjyejh52c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 10:37:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2ncNsOrPNJ0gI3LQN2qyQJ2VEQQ3PfdO4roR7BBijUv+k+aDl1Emec+xFn0qNx6x7i84TaOSK9JVWZC1Iqg4TI0eFSUs3OsHjjMa+f8z6HnqpexVVUOrCM13Yynjrr9v2Y9mtZaJFqL1/oUtJfi+2gSpEiVbM9eZNeIM3c4wLYX1/LbTx58IfJHQ0NAb9w7cNFMD1RMxcuGiWjPmFtTpUH+y7cw1OvANii9v+IDGDlW4wTEAeCsXwifiG3qSsTNtt/3iahuvj/yHAxctClAkpXZZdflc7u0PyYbCkN79jVejrvmmZvkDiA5q7v7IVY0ik0MH4uUzcg2WGQq8M29tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeZA2U5V4/6jN45QQpEMuTYZONGebBPiK5gnK1lH8QA=;
 b=Fg2sNcRSqgPH/e2kiWs6jMcIj+xFkczRSs+oBpXjeExxa26eckVOgyJyLN8pHd2Wd7K2r1mqKDAliwUcuOgCiL++edwgAi2tPd/hYNDhcX64uWEctDnhXULUNJeHtukUn3ey99M/a44cSOfijQIWcelsHfioAYxd/igZv2piijcX9RMD/R6WrhFxFuc0xfkWP4H9dNa89LCdKpu0/JjesEK/h/LgaklWw+MGWFkiPy/Pd2Jls4K0VjNMbrljVzjjJTnRUEw8gET5+foN0WtA9T3vZxVojziooIZCbd4Iaf4XpjMAd9ZubagRimZ+it8EJDrNCEQdycYxTtjoJY2kcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeZA2U5V4/6jN45QQpEMuTYZONGebBPiK5gnK1lH8QA=;
 b=YN8bCD7LGZHs5+NuHgR8+ISn9E90BRqMgtYsrF/Z48NpV9IDSJ4nhqzKb3mEfEtpPdZ9SYgIfRsCmJ+72v6UCQ3kpPpNx8SwYv5uBDomEKT28tqDiC0GDSL86RpN5MMrMZGlJVz5IJ6n9GDi/lIZ2hlIf7qJfCmBR9uA+2x57LU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB5898.namprd10.prod.outlook.com (2603:10b6:208:3d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 10:37:15 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f%5]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 10:37:14 +0000
Message-ID: <370f8277-78d3-0f70-dbe6-bfb69177e3c6@oracle.com>
Date:   Thu, 15 Sep 2022 18:37:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 04/15] btrfs: move btrfs_pinned_by_swapfile prototype into
 volumes.h
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663196541.git.josef@toxicpanda.com>
 <4cddba7a242f71c09a9cedd03fe726482ab90c5f.1663196541.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <4cddba7a242f71c09a9cedd03fe726482ab90c5f.1663196541.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: b10fb15e-110e-4d6e-7280-08da970640bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: usIfNkrKsnKVPhisTS6AOPY4fAq2jtUFN0WvIFhvEbIXs+nYbTvAnwtPT6yf/uPi4ZQKQJ1eT4gx9pZgKNZzuK6KO/t4sEZ4TYBcYW7W58QH024cJqT2P4MNK42HHCJl+uXoU9bJS3tR7bblS8Wqrk/KjRp2pdEJPS5Us44XnvjJF1+9PITnNqBJbez8SuXb2VAPC4SV+KCY42E39y1No/5hfX2c315lpDeKsGr/Qy8c4A+fnaW7oey6fTeQFQR5SghB4VRRZ48/1L3EmuocAWjiIKAilAc3Rpo911p9RnawQMszPdKMpX/p9CZIDS/9LaOwRVDV2XUxXv98zQBPHHVpB+ivhFoLF7OeG2dyFx7Afps1hFsBh+/+TEAw+9TXz61p8xI/vlsnsmVr0j61/oIiwVSIsTD9BkntkPNT+dIaA5KRcgSfvYUp/CpIwiD75+SwPdVLJeULCUA1tvHyPCvyTu1GgsQJ3px/abYeuBJpyMrivol+28p5RoqlyzGXrKBDXMzENLujy2NggGVg5eA8xDGvprtxmNIzeBVolxuYjDcZaqqmfnAZEczFqBlagjTNXMxbK7SiqfZLFilNaC+vBEHOYbOpQS3aAKRD9/obXimckaiFVls/InSVidtwgzLqKAyyaNvUw/k2ud2LzFqiV92PQ3GSIal0i2nVT423bnUk0RQWcTjK0Ubut6+UE90FX83CX/tul7jMk2TxJtZlz5z7JS0JNQYQZygVF5VJbqid+iaWYnUS3MCI4Z0Bf5CQ8F4Z+5E76/Qupo+YdY8OfZe0POfZinv4q54b2WQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199015)(53546011)(31696002)(66556008)(38100700002)(66476007)(6506007)(44832011)(316002)(2906002)(31686004)(8676002)(6486002)(186003)(86362001)(6512007)(36756003)(8936002)(5660300002)(41300700001)(478600001)(26005)(6666004)(66946007)(558084003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEZXeitoVXExWEEyVGgxYlFtOGlrWEVzUllxTVRheklqS3ZhMUhZNkNDL3F2?=
 =?utf-8?B?VXB5YWVWTDYvakJ0V2RnY2JiU1VuUVlIZFZza3Bic2YxT09DNlBKVGpkVWdz?=
 =?utf-8?B?RkZRenkvb2I3MmZPbk5uYzAvU0l3djNGbUkzbDlOVlo0ZGtBQjlrbWdjSlIy?=
 =?utf-8?B?NVRjMitvbU85Ry9qenhCZlo3VVI3cThKaGFwdllzUFRuY1hNZTBpY3JsNDV4?=
 =?utf-8?B?aE1mWC9LcGI3dHhQRWIwUmxuWXQxTHBVSUdhMXhJVGtzSHE4SE1MOC9RdDRs?=
 =?utf-8?B?NUlsU2hVNjhPRHVoSnZ4RFZyRDRwS2Mxb2hSTE5ubFg2bmgxQ202QmlkcDZa?=
 =?utf-8?B?SnArOHNvMjFCQ1AyVHNOZy8wOHk4TGhSL3o1bDFmaWJPdkRveXZ4RldvaGQw?=
 =?utf-8?B?VTlBTmcyUWZVbWppZDg2dURMajZJYWNRTzd1L0lPQTlyVHB5VHRzK1dyQ3dz?=
 =?utf-8?B?NXRxd0MzZUo3WVhzMmFITUd4WGRsWVFuaFlNR05LcDNNQ2dpbUs5Q1dGWWRD?=
 =?utf-8?B?bkpIbGpvZnVYZVFkZ29VRHp6Z0hRdUIzOUdqY3ZpYmoxS0VzSTVGbHFhQit0?=
 =?utf-8?B?dnhkTjZEdnF1WWVmL0kvWU03TEpBVmo4R0FlZldwQ3A0OWtDMTlkT0U4cHpl?=
 =?utf-8?B?WjZzUVZtTXU5VVNmUDNDQk5Jd3FoOTgrUEgzd01QdVp0L0gzWnRtT1ZWRWtG?=
 =?utf-8?B?SDFJOUVpV3J6bUlmL0MyTm5MenkvVXo1T0pvbHNWb25KL0FrWGNqOGxlaWQ4?=
 =?utf-8?B?S0xqcTNVNU90TzRlbm5uYTNwTEczVXJGNWxuc3dFbjVMbnVmODZkV1VXdi9H?=
 =?utf-8?B?Um5rM2x1V3dZdWp3UytQejFRbURYNkJ2NW53MEoyRHhyTFM5SlhJd0d0SHZG?=
 =?utf-8?B?eG8wcjE3eStPWnJmSjViak5TT2dwR21PbVZmT2E1aTAzUjRjNVY3L3h5ckU0?=
 =?utf-8?B?SE9uN2lRNHh1aDh1djN5bkF2am5ZOUFWaFFjdzhidWZJU1FMeHlCUkZTUGxU?=
 =?utf-8?B?QitPN1VkQU14UVprNGVaRTFpOGxJYWoxTHBOdlpXUVd6NFp5bnlYVDc0eTdV?=
 =?utf-8?B?SUZvekNhcnJXOXY0NmlzVXFDNDVzVVgwMTJzQStrQzVORWRJQ3lVaXlKeTJK?=
 =?utf-8?B?TUdWWlB2YnNEc1lGcGhZa3JOVCsyeWd0cFQzT1ZMbUZXbTlDbjlZYTZndWor?=
 =?utf-8?B?Ky9lUmlBTW9jMHIvdTNwQ1o2RUlLdXluaWdybzVQSzkxMUxNTnBiY2hXS0Q3?=
 =?utf-8?B?cXZBQkluSWtBVkFCTHoyZ29lNDNpK29pVURzNGZNams0bzJOME93RmF4cmNy?=
 =?utf-8?B?MXNYSXJkaVUwenBQMlkwV2hsOThzeE5Ma0JUdnN0dHk4WlpJRXpJMm0wSFZk?=
 =?utf-8?B?Lzc0cDI3ZWxTeS9RWTZkY3FRZFh3Zjd6MHhwYU5nclRGRGlJYWJjSHdRQlFL?=
 =?utf-8?B?NVVFK21qalI5NitxdnFYUFdEazF5b0c0dTJFTVlHOUFlRmVCeThSUlNkVTV3?=
 =?utf-8?B?c1ViNWZROFdqajNiNUtjU1hhcjFibVNkeEdwcXhSOW51N0NHR0V2K2hzbDg4?=
 =?utf-8?B?TUhRai9jMmY0Vk1FZXhNYmlXb1ZjY3M5MlA0SEE2cjhBc1ZSNlRDaysxVTdD?=
 =?utf-8?B?QnFPMjVNNzN3eFAzSklRWkZPZStFby9teisxRnZPMnhENW03b2NsS2RPcDFn?=
 =?utf-8?B?QXQrSm90c1FtWUkwNkZHMnhZSGZSOGIyWlUrTEVTRmMyaExwbEhoTENIeGFy?=
 =?utf-8?B?dmllbWhTMWltd09KaHZjdG9sa0I5bmtaYWxxRDBzajBqcEc3dnNMNHhtL0Jn?=
 =?utf-8?B?THhucENVTGdTdjFLVGRaYXRMMklDdnRWSW5NUEJ3WTZJaG1lWEwyMkVnK1lq?=
 =?utf-8?B?MEJOTzM3YXgyZDF0U2xUb0VQUTZybFNwamJrdDRoTmRTV0FCWHhEZDFOazBF?=
 =?utf-8?B?anduTVQ3bHBrZThPZXhMaFZPUVl3b2o5QUtZb2g1K2JqRTlTcUZWVlpUemxS?=
 =?utf-8?B?MjhxRUxLUXhIeFhtYjA2YkUvMnd6bHlOeDhuSTVEVjEzTmJhY1BDb1NsN2Ra?=
 =?utf-8?B?bkFRNkRLaG9rQnl0b3NwTUJKcitGQThrTFI2cmdXdVhnM2ZmOVV1RFYzK1lJ?=
 =?utf-8?Q?XsghxdfxDmqbq5avBf4Wuuowe?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10fb15e-110e-4d6e-7280-08da970640bd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 10:37:14.2319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J89Kvyft5XvNGKy67zsfMjnbPf61I08iTHrxuNFxU7cIg2FLxvcq207nhrHgaXQCpN/vqQubtSHJtTOLD2HeSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_06,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209150058
X-Proofpoint-ORIG-GUID: Fl7jC8FusXXp1WqjqhOOjUVsxQ7kdz9s
X-Proofpoint-GUID: Fl7jC8FusXXp1WqjqhOOjUVsxQ7kdz9s
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/09/2022 07:04, Josef Bacik wrote:
> This is defined in volumes.c, move the prototype into volumes.h.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
