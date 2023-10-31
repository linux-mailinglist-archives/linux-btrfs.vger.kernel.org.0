Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647E47DCF6C
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Oct 2023 15:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344310AbjJaOcn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Oct 2023 10:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344455AbjJaOcl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Oct 2023 10:32:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B800ED;
        Tue, 31 Oct 2023 07:32:39 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VCnlNT027681;
        Tue, 31 Oct 2023 14:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=VLJwCHefpHAdBF4U1eztlDg9o2NEfkl2A4X3TTOhrZc=;
 b=owYq5m8stdoiAYCBfxiv15EoSz2O4uvRSY0pjHMByKa8nFn9ycl8ra837UhEtf4LBWlS
 gniMeCA+1PjglLtDOokmp9hruj+0GtNG0Lo9H1Kg5OGFE2s19+2Vlclk3AXxMtuC458K
 U0UBGRpWCPKc/TJtb305mZuvHIvLc/JSXbHSUfodpSvdgay1reBi9vtycE6+pQt2PWyZ
 p1SZr4yJ1AwyySm9juCk75uvqF3KRAu2A3vjc32mOuHK4dGXQQafCsSrChxPTaWGih6Y
 PWPV3n9Vfd7E0ppLI0PO64+kQWSYzzYZIBgdnNGICnz+Hy7x2MymBZ7b6I62wB5P4JTq 2A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s33wbas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Oct 2023 14:32:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39VEE4cM020079;
        Tue, 31 Oct 2023 14:32:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr5tcgt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Oct 2023 14:32:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wv/lWdEdLPYwZnOJ1UPfteLo2yDhmgRNASykM9xADWoCwmtBPadsH70GCX+c6FJWC+s1+Jc/DXaFPCVkQ3TRzjZLj15iN0aRCmDE0l0DE9fDTIFkPH/+OXu1is9hu/420yrHYmlx8aUBhEXoD65yv50AzuwJbv4IqeDj/cQ+BZTxZOsyq2D+GRqD8pUt175C26ZQr6MN12gkrJc2NwhnMHrCJxY2nVixBspaqNidCB6Kcaus9ITWg3h9oIDogF4TiZSC9I6vVRuUgTUhFh+8ko1lihWHaS9IwfpwwqWn3YAfnLZBlhHTD8se+L+cuMzFJHlxmGVq/QTJVoH+SbdOPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLJwCHefpHAdBF4U1eztlDg9o2NEfkl2A4X3TTOhrZc=;
 b=QwDZzwg54o8ZGUPbaj6Z6c/yP4Ab9sinStebkUtFAz2KD4ZsBBJCfqOpLw1rwBTK6ycZovpJMDwez6+V8qn9ETxVqPLStofqPIwx1lEB5dFlltanfDrTOVJaoN38OhS0UR3wdxTNtddN4qQhbejcFWiabRdESnu3rKLmPt+eFKK8d9L1wTzOXmIwcz2tSwZItXulDxIkU1JeAq0GfySBx4J/WsDpp2Dgt4wFxc+jSofaAN0bCkbXZAamyzb01w1K1zno9AeHu1U9rvYNNUgdVPwkJ0lbRqYwYL62trAKAchDcNMM4HWnBviOSZO+OKISVpG/u23GJn6NhMrmeaIdzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLJwCHefpHAdBF4U1eztlDg9o2NEfkl2A4X3TTOhrZc=;
 b=lESxPr1qEro/vOczbK8Ziy48bqWIZAE69l58X1FHoOLwz1M7KWrdD8Gx1isq92kbTb4LuACRuuJx6Y7AcjWGCDsKne0ZQ2n6cAxhJ+YQKz9MIYgwjRna7TIxq98qdzNR7Yhl1mIq1FLsknywTiesjAxW2wSLEXcIW2YAy7jkU2I=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB7323.namprd10.prod.outlook.com (2603:10b6:8:ec::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.29; Tue, 31 Oct 2023 14:32:25 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb%4]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 14:32:24 +0000
Message-ID: <92129e67-6f71-144b-f90d-f14f7d513d18@oracle.com>
Date:   Tue, 31 Oct 2023 22:32:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 3/5] btrfs/219: fix _cleanup() to successful release
 the loop-device
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1698712764.git.anand.jain@oracle.com>
 <77a360863a5d41d4e849fdb829145c6591d4e955.1698712764.git.anand.jain@oracle.com>
 <CAL3q7H4uK=WO=RcmpJHAUzQTyAGkoHu8-m2Ax0DE3bZxuGVWuQ@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H4uK=WO=RcmpJHAUzQTyAGkoHu8-m2Ax0DE3bZxuGVWuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: 313d6e2b-9aa8-4242-df30-08dbda1e3333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z6nKRnxZS/v7gQm+iD8Ay5u4w6ZDecABvC72n3wa58fQrScv6doX+I/5fMO+94y37KyTGYkoYcUtUECSjbMR80qexYiLyHeEm1ZighPmpshknSVTe3ayT1YHokQlllDHXJ/z3ZgWWB6re8IGzz2D5glBPPPu/pmUv/+v6pn5qX/QDrTrqn0U6SHTdG7oxAHwXokoznhP1IF7J6cbiO4aaqUIX3c1dD5sop7plPZLbFcLDnsIumQ9a1zlUs6DW4eEjrTOXoTjYa5sFyI7YPJon8DOhT6yQIvE+gq2SAvkETHT0b8NwdlDXY5gg0FcpQMOptestKYdlTnAlpQMNZQvx8fEtdH2Sx9H0s9IGY1nUxXQLx7OvvEFnG33G5EYXcoVSaUfWnFKCtKfeEBS+S7/Iop4DN5IdL3C+Kup1toAcjy1Oa/MgXS6tOatIklooP4NPO3sskf7Mov0yBavb1c3g2QBtvB0b48gQKh2Qy3OhrwQd4/kv7FZolBvx7JvjDzwbuqejXycdSpay1zs0dfqNYwSKUUCJy+7pLK8twEPNYOPmlM5kwtKH6TCYaSazEPJ4P2zgXChYtBz4cTqP8jgcEtjcMuEYE9ysrn3sQVv/MTIZL3+6WvCYdQuls1f6NM0mUKxdZHPI/fWJcHUskFnqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(136003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(31696002)(86362001)(36756003)(31686004)(6666004)(2906002)(6486002)(6512007)(478600001)(41300700001)(8936002)(8676002)(4326008)(53546011)(44832011)(83380400001)(5660300002)(26005)(2616005)(6506007)(66476007)(66556008)(6916009)(66946007)(316002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0xmQlZObHZCaWRxV0NFU2p6Q1l4MURnVkdTUlhJZ1l4c1FKWjhXR3dpUURk?=
 =?utf-8?B?NExFTmw2dW9YcG9OcU1PK3NZSUFLSHUrQklnaHBueXNqVER3NS9wMmFCeXRp?=
 =?utf-8?B?T3hHRitSRFMyczZTbU9IL0xXbWd0NjB6L3lCL3NibUpoZ2xqTFQ3UnE1dUZs?=
 =?utf-8?B?QWlZeWg4SVRtdWlEYnhsNVpyWjFQYksxNTdUMTFkQXZNakNKYkI0U0Z5dEo3?=
 =?utf-8?B?eVJ6NjhqbjJZY1pMSkFTVDhVaEZwQ0UrbnVyU0hOQjdRR2k0Y0IwOThnaVQ0?=
 =?utf-8?B?VmxlbFpQb3lwbzI5NEN6L3dmWnVKdStNQXhCVU1rbWZxQzRBbDRuYXJmNy9K?=
 =?utf-8?B?dTFwZ2VDZUJQRWFUNnRTRTNKK2tlYTJiaE1EVTdrV0JhNjB2d2xUTmlJMmJu?=
 =?utf-8?B?WFhrV2EvdisxbmZYUXQzbUtJVitmUG1UWXIvcE05RlZ6NDlVT0Q5VFpDZnl1?=
 =?utf-8?B?NmdzUHVMZVF2ekdNelA4VVdHTWVycXZpdUxJdXlqRFJRWU5jcFZOclpkUnow?=
 =?utf-8?B?K2VIQnZocVlYa2wwbk5QeDI5MFRyYys2R01jdDd0cDhFUEFVZk9wY2pydnZZ?=
 =?utf-8?B?MmJ6eVc3eDVYSFhVUUNUUG9DOFF5QXdtVzV3YjljYnBZZFdWQUJxRW5OamZY?=
 =?utf-8?B?SlYwQnFjQmx6ZUZYVTNlK25PRGRNWFJ5dGJybXBpVlRYblF0YVJDUHV4VEZJ?=
 =?utf-8?B?a2k5UnhxS0IvNlpzN1IycmJCZTlVTUN0S2Y3Y2N0ME1QalJ0UjJETkVuQWlU?=
 =?utf-8?B?aFdXR0MyTHgvN2xUc2dYZkpkTDJrL1A0ekVIRTZ1TUwva0tqcFY2NmlpbTRp?=
 =?utf-8?B?TGdwNklkbXNqZ0FUT3lxM0psMllKTXFDbHE4VUgrL2VtZ0NDcHF2YnVZM2JV?=
 =?utf-8?B?QTZBejVUTlQ0UGJVdmtzeWk3a0tVUmdBaFUxNExxejRramhheXErU1lpdk04?=
 =?utf-8?B?S0dpZG0yaDVaSi9SdlVraTFYOWtBOUpNTFZSbDgrQllvM1Y5b3hzeVMxbkVK?=
 =?utf-8?B?T0MyN3pBMzd3MURtbUFlbWNCTTMxY1dNMFVLamNiNTdOdU1RNC82WUhsd2lz?=
 =?utf-8?B?VG1iRVMwMklTeDZKN1E5eGgyL1JHbjNPUVVKK09FSTZQMndFNENweWVlcU4w?=
 =?utf-8?B?VTlYbVd3N3M0S1YrbnV1c1NiRUFzWEhUQU1zQVUyeHpKTTRMYmNiUk5FRUNi?=
 =?utf-8?B?c2ppYVg0LzhhenVJSHJWNnJxb3pvNXZsMFZRT3hKRUw0RFArcEVuTDNRdStU?=
 =?utf-8?B?L1hEOG9mdHBhbVpndXZVaVE3NnlCSm96ajdKU0h4dVhnRVR2OFNFR1dRU2o2?=
 =?utf-8?B?UG03aDV2Q0N4MjJMKzNsTjk0dURrZ3BGSUlnYnFHVHFaYVlFRFJVVmxPKzBY?=
 =?utf-8?B?VFRyeVVhL1VxUlBvUTlEOUtvNVRVekYvb2FEalFkMjZLQ1JXUGhnWU5JNzVj?=
 =?utf-8?B?RjNoZlFUYTBJVDBNdVdxcFNCTDRVU0R5QzZGdVZSNXJNbnQ1YlhXaXhDVTc4?=
 =?utf-8?B?Q3dVUUNIbGZpRkNYTkNjM0NPeEpGRDB0Sk5LM3JOaDJxY0k5TkNaQ3ZXSlJI?=
 =?utf-8?B?TGRxU1Yyam5UZTVqejJrWEwyeDRlVlJ0VXBJWXVCSm9OaFRMZWRqK0tSRVRU?=
 =?utf-8?B?clFkRWxZZ1M0bTFLUkV2c2ZadlN1cm92bFNCb0t4T2kyb0R3YjB0MUpWeEhE?=
 =?utf-8?B?NWFoUDAwb3pTUWZsb2dUTmtvaFBSVzFEN2pIWXE5RVUyR2JycU1qVlVsbGxz?=
 =?utf-8?B?UzJ6ZHZ2azA5bU5DVkUyZUlJWUhZYVYyNklURDhzbTR2MHNRYllWT0QxZWNU?=
 =?utf-8?B?QkhtMDIxNCs4UzBwRlVlTWxjdUNRVnhwWi80T3g0aERUYnBQMTJleiszb3dm?=
 =?utf-8?B?T2NHNFNuMnZzVEZQMmNtbEtVOE1KeldPSk14NmJ6SXBSUWU2OTBYYlJETXAw?=
 =?utf-8?B?dTV6WFVJU2Q4SkszcjNLWWF5VkRBMDhreGdKRXpFVUk4dW5SQVVLYjgrdm1M?=
 =?utf-8?B?QlhwN1cwc0Z3T3h6czUyVlY1dmdnL0E0YXU2TVBrc3JhWHVWb1QvbndJQ3ZB?=
 =?utf-8?B?RXM4bFhTUlJHbHVEbmFKUEQ2ZlZoUm9wcmdUSlRBTlVFc0Y1bCtsR1RTUU5L?=
 =?utf-8?B?RjluZ0YyazcvdVJKMHNOekhCaS9UdGQ3blRmSXpueEJzSFcrQysyYlBQK3g3?=
 =?utf-8?B?L2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Go78RcHZiRYMieeiJjBu6SSTOtRG8Q6tfU8SciGyLTwtVYIfkV+iMuUHVfLcgTLAurz9NtqVQ0Tl2r2vE1uubiPzzJyUy4m5JMnyB/VVzrkmjaazAFNKRBxyHbdsxGxoQ0nJRB5Cawi07idptmb5l7zQgzWAoTEIflTfkqr3Njzz5j7KsjqnmOp1Kj8HS58kempER07aiQNTfPvIPKCceQhpZbAuSrdK22KFGTKxPXx66gV0z5AwGBCvkPQqYLvb//osHMgvwRXdGrCt766T+FAFQaQb/symxCqC87SHTrc+8KI8szqVUDybEai4vEdbLhJnOSPbJcVLuvfLbBucjkdR4cRzl5+kb0Z0xI0rtfMbAq1zmd7Jazsa4WaYnyWte4v60ZfX8Q0GsEvhfL2uXr5ewpgnPjz9vt6noc5SiNnL90Kb3K0p/g+mKWxZz+8BF+vxroog1lU6TUODIrAQuL9dOqTk7swvQOHBahpDcdMF5FTYSuTerNPO9MNVbmzc11fCiLjFN+8OSF75GWneL1R21V36jZ6bj0MK08ttTa6ubyO9JOcRW1DLVnzfBCr2ZJxn+FMVICkYLoMYdjrnPUABQNyp6Y9ivjLHwD4s4oNWX2aA06GwhfrR6JsunAQx38TLnN0VUdJS44GfuTN2rNRO+r6eflCc2F7TMe++cfFl13XY0Z7xYe5UNRyv48enPl9t8TPgfySFqVxUEnYrzf1y2TEUEfTG7wibzhXe2fbxKKAGrSyLPvOAGm+Vgj/RXLO0Ahnx/JvmRq1733LJUeDuzaUj+Ev3nglHsEiPyzE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 313d6e2b-9aa8-4242-df30-08dbda1e3333
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 14:32:24.9014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VGfZg1it5BwKQa1pkX5laoewRZ0e/geKfaO9hr6xj9LhJUgBGXme/gzIvEa1kqgCiBZmjE+PuH3aUhw3bR1gKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7323
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_01,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310310114
X-Proofpoint-GUID: SKwuAE33kxFVgqXPDmVZeyCOzI6UBfgA
X-Proofpoint-ORIG-GUID: SKwuAE33kxFVgqXPDmVZeyCOzI6UBfgA
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 31/10/2023 19:41, Filipe Manana wrote:
> On Tue, Oct 31, 2023 at 12:54 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> When we fail with the message 'We were allowed to mount when we should
>> have failed,' it will fail to clean up the loop devices, making it
>> difficult to run further test cases or the same test case again.
>>
>> So we need a 2nd loop device local variable to release it. Let's
>> reorganize the local variables to clean them up in the _cleanup() function.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>
>> v4: rm -f, removed error/output redirection
>>      rm, -r removed for file image
>>      Check for the initialization of the local variable loop_dev[1-2]
>>       before calling  _destroy_loop_device().
>>
>> v3: a split from the patch 5/6
> 
> One patch has a v4, others remain as v3 and one from v3 is dropped. A
> bit hard to follow, as the common practice is usually to send a new
> version of the whole patchset.

Yeah, it should have been confusing. But I thought this would reduce
unnecessary noise. Also my '--in-reply-to=<message-id-patch-4/6-v3>'
option didn't work this.

> 
> Nevertheless, unless I missed something, it looks good now:
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks, Anand
