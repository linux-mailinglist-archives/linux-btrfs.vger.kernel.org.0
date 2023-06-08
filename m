Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638E772761A
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 06:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbjFHE1D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 00:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbjFHE1B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 00:27:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8664F2695
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 21:26:59 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3582qilZ027406;
        Thu, 8 Jun 2023 04:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=FuOCT+E4gRs2J2sRJBr+WG8MMTBpuvLpEVR7LNGsHro=;
 b=WM/JO3uEGw27/EMYn8fonP6jmaYUsIpRt1N4BqJOdeFm2uAYARsHVriWMl6aMikWDqdE
 QJ2n01Tf6wAjfNyyS5GGgalTb6b1Acp3sqLCuBAfyfiS6ZLSaH4fHqaRvsT/udMoqwD/
 PuiTpneJnYT7H1iJAmd6CtjgAH0VsAxzGmaBzw8LiLrJGphDAeGSXKC7eNAgwNangogY
 mao9a/Z1jW0UGEUz9FuJtX53zaMLOfbScIVM7l9vBAlw2L001ETzYaRANUyMZIRFsaF6
 DuCVb2iyxlz3tK1WacckDGXOcE2FPkpY2CNDa4Woh3Dn9bxoN7dTLCXxEF+WmGP/oimm VQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6ub8w9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 04:26:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3582sT83036915;
        Thu, 8 Jun 2023 04:26:55 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6kkc21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 04:26:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZu58aBCPtZcdNJobPC0FhcK8n876AVgX6vr9cnkTdfNwIxiePNmRvd7mjLp4LQSAq1J+EViDXZR0WFYsw0K5IXhvKA/V4EhMQG75uBe2hgrYwfvem88Q1qoy01eA1mrAM0wvVnwH7VyNUGIaAN2zoHSvZFWnjuQ/21CjGwgcqODvIWcpUqwcDzUXNsF9Gv6vB9i94jlWCy6VLb4NPA9KfZGedbp3OrlzdcFvuyEYDhRseyZb/SVC8pwOW+SkrUQM7fuHB9Kfl25lwOGKKsz1hPyDvKnmSL76F7ah8jQy1UxE+DK+EaR0F0t3b5z0Lr6RjDcwEeiqP7CxRriXUCORw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuOCT+E4gRs2J2sRJBr+WG8MMTBpuvLpEVR7LNGsHro=;
 b=V83VRUVNyRKKpSvecRKcUVSyc+2i54VMokHKdgdP/cn8sKFxaNg2U91OggZ3FaUqZBI54HO9MQUA0xot7SKJkUQ2ytshCd36Z9rwKAXPiEGo6E3ZBiFMMMUOmddQxOOwAQliarV06WgQiqe2+Vs3ZxBLVjqFuIOYwobVPqPXrjZyGUklwe4Aob9iAtOabviNi/Zhava4etYwLdaXRLndXn5LMicSR0Dj2iWPq8+UUkQ65eLdrNht/zI1aD041pQEULGPtlB463FomiAHo3btgvFJzTHkquE83CVsq8cHzsvtdkYdE5yYsTQRiUQe2bb7FVvmYRW2PhEjaHja1mnh/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuOCT+E4gRs2J2sRJBr+WG8MMTBpuvLpEVR7LNGsHro=;
 b=m9io58awjj+7ERI0gMEpMVZ+2QpV+iS3ocR2YhoWeEagAQlQ99X2Y/BQNfTv1wkoioA9Rn9m0q+jozrtJgtQ5LiBDdu2kFzAzuKFlvB7a2yBonLyesWEfOzr5QtnzWSXC5AA3SnK4mLs7nluqvBFaOuYWHVnxJa/sY17eaIZK6U=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB5387.namprd10.prod.outlook.com (2603:10b6:610:c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Thu, 8 Jun
 2023 04:26:53 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 04:26:53 +0000
Message-ID: <a5dab7a2-a65d-052e-a56d-c37c2a7f6b36@oracle.com>
Date:   Thu, 8 Jun 2023 12:26:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/9] btrfs-progs: btrfstune: accept multiple devices and
 cleanup
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <cover.1686131669.git.anand.jain@oracle.com>
 <89e1a74a-e8e0-ea44-974c-ac8877caf549@gmx.com>
 <689772ce-010f-9017-4767-2d5770ac51df@oracle.com>
 <d8a2bb05-7f5b-baa9-fd4c-082acdbce9ce@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <d8a2bb05-7f5b-baa9-fd4c-082acdbce9ce@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB5387:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dca0e5d-749e-4d5c-4c0d-08db67d895fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c3h5fgmgisPkBPSy8Xzb1mzaPwMeCE2i9ZOVOqj3TzqBZ2+vffOXQUe2cGYS3qlOukClEcv8ORFaPegKUn9SNwVTgW6AYwQf4Avbb4gC6lAw6cF2AtqHd7yAkaxq9RniBl27psUJ82jf5ag6GxiQtAHYSnb8t7QWB4zNR4auMlknXvQYT4bWPSoZ4Jds2p7MoWmxhJ434COWqvR0aMfqXizqfiXd5QpyLq552+umF6nllJxvIuJzcLiZu9z3LW3juYut448xJ5zBr7wxCXqBJSLNKnEHvrz9+7ufvlHe4uTBK/FTXdCBhi2PDeB7yU3I9L0cU9Dr98RajLzLDR8n0ZhhkDwsB3ugSxMEbTsCA2Rz+v0ffylYjjxKSlekTr7GM+48brbChd8TsK1YDp6Np0DvARiFYjHwUBjMwZadUaQPRy9yoCJAzaTAV65phjz5Zum1KkbzmXD0LJJeZyS7AhGkSNWTd8T/KfkKWt+yWtxuNzD15PgBfm59PAaybmry2doJMVJ1holJl+/5ONHZbOo27porBhVNQ9XwVekUSLQ+9TSV96trUhwgAoOfm3LXNOGbgVc8oDRHwpQ3uClPbx39uppFjlBaak39o+Mdm0LspnBHoqAhe1WdkxUGu+cvzmNGJtI3HsPPYnWZw3yqSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199021)(478600001)(8936002)(8676002)(44832011)(5660300002)(86362001)(31696002)(36756003)(2906002)(66556008)(66476007)(316002)(66946007)(38100700002)(41300700001)(31686004)(83380400001)(26005)(6512007)(2616005)(6506007)(186003)(6486002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zy9LTHNISkRFTWtQVUt1WllwVjdoUjRaSzA5ZHM4QzFvTERmbm42Y3BvSU8v?=
 =?utf-8?B?dW5NM0pPanR0MWtpTjNEbU5rd2JDalNDcE51UFRzamszNXA4WUgyTTBITnV0?=
 =?utf-8?B?eXl3SDkxbUJhMHpIM080NkZLL00xeUg0MHhKRDg3bG1lZ0VwdmtKUHFDdk9L?=
 =?utf-8?B?K05EZkpBNldxQmRJYWxOa2ZaTXZEeXladVhJV2dnVEIvN3k0cGhvZXpiYnMz?=
 =?utf-8?B?TEFUR29ETHBVb3dsQUR3OXBlaFlqWUFrT3FsRjRJSUptMGkybmY4VEs2Q2Yx?=
 =?utf-8?B?UUZFd3M3UGdxellBZDM2UE5mVmZWa2EyUG9qak5BL0FLTHFOc016eTh3Sitn?=
 =?utf-8?B?bXlsdWt2Yll3Tjh5MksxLytBdWdQclpLcjRHZFNmWlo5dWhScWJpaXpBVDZh?=
 =?utf-8?B?NDZyNlZlU3c1b1drY2g1SldUNDRDekFqZGszdFo2Z3NESkNwMDc4ZDNSTWJm?=
 =?utf-8?B?WGh0ZEdPUk1jUTNpNm5jMVczdWM5L2d1RUt6cTZkMHpWcnY1NTdiSTg0NWhF?=
 =?utf-8?B?MW1rdzArdjRmUHo2bGNoQ2dSNmJNSzd4dGxmdjMzZGZyL1BXS2o2a2tDUHQr?=
 =?utf-8?B?SnFTMGZPUUNHWThGMHE1T2o5d2NVQnJxM1NTeVZTdU9CS0lxVkxOVkpTYTM2?=
 =?utf-8?B?MGhKVzVJZVFhNGptYlZyb3dhbTYvNk9EOXlIVEkyVnBuNlJBVXE5Tll5TXRP?=
 =?utf-8?B?dElWZ2RHUjZNOTcyTEdvWHlDcnNBNmFWcC9BTWxQRnFYM05uLy9XeThxdnYy?=
 =?utf-8?B?cEs2KzZWcGxRczJnU1BSYit1ejBRZHd4MWt6dkxTaWk1c0dWS2R5cnlOMVRQ?=
 =?utf-8?B?WlVvSUx2bmlvRFZicFNVSllnWTJUaVNORjloaEZBSExWNlNFdFVDQ1VIYkw0?=
 =?utf-8?B?bUV3QWlSSCtmMDBmemlyZjJlRUc1bUhMbHMvRVpreXZJTkZNNkFGd3pHWWoz?=
 =?utf-8?B?UnllVjNKYkZFM3dWdnQzYWR0RDlpOER5TE4zUUtTajNaZkxCdHJ3a2w1bXpD?=
 =?utf-8?B?UkZwTmEzdHpXclpON2VuWmV2cGtoQWtkbFBBRmVEbXhVeUw4YzdRcndUQWVD?=
 =?utf-8?B?L0VQdnBIQTN6bEd0TC8vTTNHQmJNM1BQUlJYOVA4VHRtVkhVVWplVXcyYTBS?=
 =?utf-8?B?UUJzYytoY0g0azhlVFQ5aVlmM2JkdFczelBqU29Saysxb1lSbWFyYm1wTGtJ?=
 =?utf-8?B?T3g4aWlkcndxZExMTllEeG5mdWEvbXJIR0Yya2hZUmxLNGsxQThKTEpYLzZw?=
 =?utf-8?B?R3NQSXZLU3RhQVo2ZmlmME1PUkZjRGJUQ044L0d2ZXJFVHdzNjNvb3FQUGZn?=
 =?utf-8?B?em5XNGNlYjFSN1FYMXNsNGQ4SXl0bFJtdEltUW0xek1aRklMaTdacVpMWmFV?=
 =?utf-8?B?VVFubkl1aTgwVk93NkFyQVJLdktlRXUrM2hpOVlzSERUcDZtcTRLTk0vMEdF?=
 =?utf-8?B?SnNzV21vL2VLYlZnQmFQUFRMZFlEbis4aEV3S3dkbGhJalNwNmVzQVk5V2dV?=
 =?utf-8?B?a1dwMWtjeEo1aEhMOVorNFRuU2FEUWkydjdIeDlJN0tlWGpWYnN5L1dybWVz?=
 =?utf-8?B?b1dLVTEzeGQ1MUhFdVJJaENTejRlZm5xdUVQT01mbThKd1RoVEhqcXVpN0kr?=
 =?utf-8?B?bHFKQ3pLMDhucE5VM0NLTW5sTTNKcFRyR3J4eDIralFVdThhQ212ZXZZcHl5?=
 =?utf-8?B?dS9IK2JaZGN5SU5NUlNDSVVBeG1ELzR6YnZadnVVb1JzMjV5enkrQnhmYmc4?=
 =?utf-8?B?MXh5RWEwSktVLzFGY2ZHalc3bVhKRGRpbE5KTVE0YURGTGZSTEIrOERhckJB?=
 =?utf-8?B?QStZbTduR1NaYUVaZGpYYWJvRzVkRlJGSkZ0NjFBTlpxeEllL3lsQkt3RldK?=
 =?utf-8?B?S0orMnlOM1F6SnQxWE4ybjdxUU0wUSt1TG8yMG9WMUYxQmNjL0ZRZ3hTU1Fj?=
 =?utf-8?B?RXpDUHF5dUtGajRaY1l1MWV4aWcwTXJxQ3Z1U2ZlQngxZDRRSitWNi9DT3du?=
 =?utf-8?B?aThXQXRsV1FOemU1bXlFMFg3ZVk1ay95WElvR1NwaUJxcE0xVlhEUlhaQmpR?=
 =?utf-8?B?b290S2FEVUVJdWdWTnNOd2p1aXozRURZZkJDbnVteHcyUXZ5MC81UUQyYTJX?=
 =?utf-8?B?U3FLZSszb3M4NjE3Y0pudWpQZnZVSGltclpHTzFGUWF2M3F6cGlObWk1bTdx?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6VXGBZPib70OouA8w1BknmLXJx5A0LKTUgf/W+QTtRyfX0kDL8MdTs42y68ypBGkaa8godeDNDk7cvdiKwMtut9Zx4NIazgarZIsw8EUaF5V7ZOz3Pk+g9/GmiYTuKfBenAvb4bEzrGvlBhfcg9e3+siFIABFkLsAK3X/vMKc6RPegg/y3OOJUTUkSGTCR6J5peDulHdX9aVDzUjlUJIm9VQZTxlNCzdPOeMjF9JnvGQO9yTWgfawcaDkUoVN4muLPKz1KDDCOT3tQgbsSlPCw4CJvbaT2g9g+6Mp/i2MfhU56ilslcatQohqe69+hezzFh0A4mxf3OCCHf0XojtAXNuLcCxkPwultM0WZ7EKAV5YEjVeni67OPElnfF0r4MbEWvZW4TceZ39JsdR3pNYbO0RNII3eMXGkY0+HuE129WApaEgeKzJdf+rKXCvqtd/jdwjNg2aJZW04GTwHFNHjFWLQpZBHq7coHMA3r/JPLGLIIJ0Hgn8spiAcPwvk+kriqVCUTZJZfQO1i0jXB0Gqak1doSPONx8BfsuJc5lQmD0Pt+2j8UigzHFz/MvBlXic5JVx4CDPNbp/g+dsOqpSyP/VF/ovGfFogkXh2S+elmNciq0ImDqLlh6YU7Xd5Ayw4S9Y7OFlzaeBWD01o402koLhZn8/xPBofEkeEVx3rQ80qU+2swqaEwiP/MxiQi1zcFQ7nDeTjsTcSNPKGzy+lKe4bz/27ZsQQW7Mw6DfhSw1Q41sfsO9p0CKKTEHOPaSl6jNCPuEPl2HDUbHPseQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dca0e5d-749e-4d5c-4c0d-08db67d895fe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 04:26:53.2922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SbnZfaW6j1oL6Vfr7opT+Pqg0OHuIiKNLdf9NoK+J1f15BHKfoDN0jxl0fKIxQMXhvsKQFO3mMugSfC6uFgAgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5387
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_02,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080035
X-Proofpoint-GUID: N0u39KDUhBKTsldHI5btgrZ6TUqlR-uG
X-Proofpoint-ORIG-GUID: N0u39KDUhBKTsldHI5btgrZ6TUqlR-uG
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org




>>   As of now btrfstune works with only one regular file. Not possible
>>   to use multiple regular files. Unless loop device is used. This
>>   set fixes this limitation.
> 
> Here I want to make the point clear, is the patchset intended to handle
> ONE multi-device btrfs?
> 
> If that's the case, then my initial concerns on the multiple different
> fses case is still a concern.


>> $ btrfstune -m --noscan ./td2 ./td1 ./td3
>> warning, device 1 is missing
>> ERROR: cannot read chunk root
>> ERROR: open ctree failed
>>
>> $ btrfstune -m --noscan ./td1 ./td2 ./td3
>> $ echo $?
>> 0
> 
> This is exactly my concern. > We're combining target fs and device assembly into the same argument 
list.

> Thus changing the order of argument would lead to different results.

  yeah. --device solves it.


>>   btrfstune -m --noscan --devices=./td2,./td3  ./td1
> 
> That much better, less confusion.
> 
> Furthermore, the --devices (Although my initial proposal looks more like
> "--device td2 --device td3", which makes parsing a little simpler) can
> be applied to all other btrfs-progs, allowing a global way to assemble
> the device list.
> 

  --device td2 --device td3.. that makes it same as mount.
  I am not yet sure if it can be a global option though.

>>
>>
>>> - What's the proper error handling if operation on one of the parameter
>>>    failed if we choose to do the tune for all involved devices?
>>>    Should we revert the operation on the succeeded ones?
>>>    Should we continue on the remaining ones?
>>
>>   Hm. That's a possible scenario even without this patch.!
>>   However, we use the CHANGING_FSID flag to handle split-brain scenarios
>>   with incomplete metadata_uuid changes. Currently, the kernel
>>   fixes this situation based on the flag and generation number.
>>   However, kernel should fail these split-brain scenarios and
>>   instead address them in the btrfs-progs, which is wip.
>>
>>> I understand it's better to add the ability to do manual scan, but it
>>> looks like the multi-device arguments can be a little more complex than
>>> what we thought.
>>
>>   Hmm How? The device list enumeration logic which handles the automatic
>>   scan also handle the command line provided device list. So both are
>>   same.
> 
> The "--device=" option you proposed is exactly the way to handle it.

   Ok.


> 
> Thanks,
> Qu
>>
>>> At least I think we should add a dedicate --scan/--device option, and
>>> allow multiple --scan/--device to be provided for device list assembly,
>>> then still keep the single argument to avoid possible confusion.
>>
>>   btrfs-progs scans all the block devices in the system, by default.
>>   so IMO,
>>   "--noscan" is reasonable, similar to 'btrfs in dump-tree --noscan'.
>>
>>   I am ok with with --device/--devices option.
>>   So we could scan only commnd line provided devices
>>   with --noscan:
>>
>>     btrfstune -m --noscan --devices=./td1,/dev/sda1 ./td3
>>
>>   And to scan both command line and the block devices
>>   without --noscan:
>>
>>     btrfstune -m --devices=./td1 ./td3
>>
>>
>> Thanks, Anand
>>
>>>
>>> This also solves the problem I mentioned above. If multiple filesystems
>>> are provided, they are just assembled into device list, won't have an
>>> impact on the tune target.
>>>
>>> And since we still have a single device to tune, there is no extra error
>>> handling, nor confusion.
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> Patches 1 to 5 primarily consist of cleanups. Patches 6 and 8 serve as
>>>> preparatory changes. Patch 7 enables btrfstune to accept multiple
>>>> devices. Patch 9 ensures that btrfstune no longer automatically uses 
>>>> the
>>>> system block devices when --noscan option is specified.
>>>> Patches 10 and 11 are help and documentation part.
>>>>
>>>> Anand Jain (11):
>>>>    btrfs-progs: check_mounted_where declare is_btrfs as bool
>>>>    btrfs-progs: check_mounted_where pack varibles type by size
>>>>    btrfs-progs: rename struct open_ctree_flags to open_ctree_args
>>>>    btrfs-progs: optimize device_list_add
>>>>    btrfs-progs: simplify btrfs_scan_one_device()
>>>>    btrfs-progs: factor out btrfs_scan_stdin_devices
>>>>    btrfs-progs: tune: add stdin device list
>>>>    btrfs-progs: refactor check_where_mounted with noscan option
>>>>    btrfs-progs: tune: add noscan option
>>>>    btrfs-progs: tune: add help for multiple devices and noscan option
>>>>    btrfs-progs: Documentation: update btrfstune --noscan option
>>>>
>>>>   Documentation/btrfstune.rst |  4 ++++
>>>>   btrfs-find-root.c           |  2 +-
>>>>   check/main.c                |  2 +-
>>>>   cmds/filesystem.c           |  2 +-
>>>>   cmds/inspect-dump-tree.c    | 39 
>>>> ++++---------------------------------
>>>>   cmds/rescue.c               |  4 ++--
>>>>   cmds/restore.c              |  2 +-
>>>>   common/device-scan.c        | 39 
>>>> +++++++++++++++++++++++++++++++++++++
>>>>   common/device-scan.h        |  1 +
>>>>   common/open-utils.c         | 21 +++++++++++---------
>>>>   common/open-utils.h         |  3 ++-
>>>>   common/utils.c              |  3 ++-
>>>>   image/main.c                |  4 ++--
>>>>   kernel-shared/disk-io.c     |  8 ++++----
>>>>   kernel-shared/disk-io.h     |  4 ++--
>>>>   kernel-shared/volumes.c     | 14 +++++--------
>>>>   mkfs/main.c                 |  2 +-
>>>>   tune/main.c                 | 25 +++++++++++++++++++-----
>>>>   18 files changed, 104 insertions(+), 75 deletions(-)
>>>>
>>
