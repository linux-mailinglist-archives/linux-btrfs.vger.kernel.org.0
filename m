Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913FB682BA1
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Jan 2023 12:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjAaLig (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Jan 2023 06:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjAaLie (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Jan 2023 06:38:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7F9CC26
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Jan 2023 03:38:17 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30V7wmqB005442;
        Tue, 31 Jan 2023 11:38:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=09f6eLOD2yno9d+YHeOrTolYrwxhIKOCFgBPKPhMm+Y=;
 b=eMZK7pe6gOKSJFub+EpxLuV7P2tqQoF97vWmA/77DJdkvgdGfIjcwx5naKQ3w5EN/8Ie
 leOJ4jtBhgTGaiTbAApkkY1W1nSNIFyirlcRhv68bqm3UCvHgUhoT4Y2hmuwr8shd2Iu
 cWuxHrztcfMoyBMNg+jtE8kJ1AVlWSu42aohQFVDArf7fuqqz3hDcnctIYvhhU+8p8qE
 f6ubHUXg7xBkpHDharY2AeW32+tp3q9NwyqXpD9mlV0YWb6VI33SykC9fH1pxzEXSeBR
 gvkE0ioRSa3ShE+YxmtbPYLrduHckFWjsw9zW+eBUCR6FrZ7RbwXs/34hVzOHKFzdv/R 1A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvqwwbhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 11:38:14 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30VA3KCF005173;
        Tue, 31 Jan 2023 11:38:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct55s0hm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 11:38:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4q2WQgNj/hMLFVH2WZCHT6fAGy3N03ZyI9lK+k3smmf3yI3HIOpJ2HizON7YBZ0bs7dEIcDQmTLaBAA+S4RsGZM2Xf5Qd/55awZhSc+tBZletO1YLcKWMCIeeIginhGMpu+Cy0PcfuJstwhoCHSzfdl61boELS53Zbd8n9m09hv6qEBt7PkDir8laKNL8LDkeNEdfs8ZT4vUesm+xFkDxrjmaAa1j92SOGDl3dyJdOTktK5p3Tkp6VWqgxV7Peif/TciiKuedXShPrRAKWGRPf6oB1JvNa7Hu97+9qwb/2nImS+83J6wJAasy5HDY5TcMLhHlox0XAqVQ9poAcjzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09f6eLOD2yno9d+YHeOrTolYrwxhIKOCFgBPKPhMm+Y=;
 b=FsmpiNo9SnuRxykAYsjvDvlElsBG5+BrtAcNG6aSYXGk1TkDqLby8qCpsyUPVvMGDnfcj50UQeZr0vQBr0y9pJ8QmBF2Yg3CXr3BoByIGGeX/wTU0G+Hpav8/y0e31n2cA+Y3wdvG38KAM2YTUEkz0Oxc6VJ2nGbei22OelUWUJ0Xztzh+nUW2onFG0ZOtCWffxalYpEgRsXB5SE2s29Q1+/KRML5iG6mR8+kYo1QCru1ynCh6USLQRi9GKo8R7M48Lcs2q/tyziI8Y53itzVe0oWktTZAIdz613oyoMA1Z/XsTiYrGfQK/6AQMJd5nw7rykkFH0EcdOi2p5iesglg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09f6eLOD2yno9d+YHeOrTolYrwxhIKOCFgBPKPhMm+Y=;
 b=Dha0O4W3G/9ek4Zp2cJk4UWZ8v/QtI6KNHtM79wZT93UOgx9lpvKf3mU5RkR/Yu9/9cpvZH/50xNd2WmRraalNpo0+XhqnTdqlw6KCqkTHb1z73NJGGmtL6bMGAjGvqgpSqqrxU7+lBmzKaVIBMDom32VNMNcb75IDucp3/KmIA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4643.namprd10.prod.outlook.com (2603:10b6:303:9c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Tue, 31 Jan
 2023 11:38:12 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%9]) with mapi id 15.20.6064.021; Tue, 31 Jan 2023
 11:38:12 +0000
Message-ID: <da80d0ab-47d6-df91-7e6d-3fbd7848819c@oracle.com>
Date:   Tue, 31 Jan 2023 19:38:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] btrfs: handle missing chunk mapping more gracefully
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <7ff90508841683ca3aaeb5c84e27d7d823218146.1670389796.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <7ff90508841683ca3aaeb5c84e27d7d823218146.1670389796.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX1P273CA0013.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:21::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4643:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ae2fc9-cdf4-4849-e55e-08db037fa1f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +rq3v5aHt6UVh8a09b4bgvtneNQVbn7UMjqNQkx6oF5n1qDOQsZr75bizusnBjFdaD0NKkGexnxoM22x2RDyoyJMaIrxIbyz3RB24ZcrMXXYMDrgXgB9wwekGs9AnBxRuAo+a+P9yiOLQhMjJwF5aAC1OjY6SEP1r5kUn9/Jtha/wZNHXEIazuMatfZzcYVk3lZotCDFYEiC/dwdu8TjkUdHiTHuATnUIfukcI6SHg6+pZwyFqrTM+SRL8LHFRHuf8XS1r0vSY6IKIDcYRZS9+xasVIhRngLKiXqtInP3q8EGXoezgKb6P1av8AS3UHMJ9qoU7++pSQnT4ihDWQur+9f0BHfMgmzBtbD37+Q8TkjybSbnTr6UB0WLw39gSliKCIrzzCUd/7od9AEnxyQ+t1zo2efCBkVzylFPdg+bnJWngRchHxLbMc/bF02x2y3pT/Oy2LjGwAYRrxzrlJpOluco3l5tPqWY6rWTR0UHY6zKo0qo9Hv5UL9/zpqERPe5aYvLQnsVHWTH/X8fWp87mZn/oOzEP5wG5yJxuJtPCQPllzMlFpCXBu6bmsbrLHBzZc8AvptK+SNUTQmRvT+BVI3t9TbW6gD5qk3DdCGZaRT48UOkkMAXkj1OsFmWXN62ZW4i1Ci4yjEUa8Ses3+uCvGqv+PlOlEKclD9Qizi2Nu4JjTkDMcSN0pwa+p8L6SF/5AhMfCdtCcZ4qhK7XCS9gfrcVv6brNo+b60607EfY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199018)(6512007)(186003)(6486002)(2616005)(31686004)(26005)(6506007)(2906002)(38100700002)(44832011)(6666004)(5660300002)(66556008)(66946007)(8676002)(66476007)(478600001)(41300700001)(316002)(86362001)(83380400001)(31696002)(36756003)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1ZFTk5QUENBUndlUlljdkJjL01tZ2llbnRMKzB1R2l5djVqTC8xdFJSRG1t?=
 =?utf-8?B?aGdiUkZlY0trU2htQVBtTG5SQ2x5dUJqblR4OTZ2QVdaSG15ZlUycUNrTVFz?=
 =?utf-8?B?WEFMS251Tm92Ny9pM1pVZEJDcHpPVkFaYXFwSitEOSszQ0F1eERza1gveEZK?=
 =?utf-8?B?dytLNm9XSjZvdk9WSmNlbUVLcXhCV0dEK3puVWp2dE5hZTlzQlc1cU02dnJa?=
 =?utf-8?B?M1BaRFdsUHZqTGtQNGV2WXBoR1FVSTlJS1JvTW93T0JiR3hCM1lQbDZUVWZR?=
 =?utf-8?B?MThJMFJsNXc3bDNlODlDMVM4cVNSdGYyTXZtZHJBWTFWbmdNeGYxTGR4eHlz?=
 =?utf-8?B?M211VlVISjNwR3VFV29kTXh4LzQ2MnUxVkRXek54MVZTS1pNbWliVlhHanhw?=
 =?utf-8?B?bTAzL1pOd2o0SXo0d2NFWHhQbzNURUkzT0V6WjNzMGsvV2xVNDd3UTR6NmJF?=
 =?utf-8?B?UzFVRnhIS1NpM0FweGVna3dSbU9YWFB0T2gva2VBTXVKSlVEVlVYREhxU0ZP?=
 =?utf-8?B?alh0ci8vVFh2c3dKK1V1eDR6NGl4dUpMWERqNWpoc0wwVnZrbTVpYjRqdXJW?=
 =?utf-8?B?ekhDNGZOV0xpZTFZUjJ3ejVjR3Y3ZXJrL212T2VjdEw3My9TM2Q1OW1CaFA3?=
 =?utf-8?B?bzhlYVpNeGwrcDc4Z0lEK0ZjMkJLTmk2c2t6MmVhd2xLUndpTDRrSXYzQ3Nh?=
 =?utf-8?B?SVRtT3lHaWs5YTFNdjUxWjAxeitxODJ5MkxMTWpSYjZFWmVBMWtsVWxVY2lM?=
 =?utf-8?B?VG9oRHpEbkp1d2JlWkRwbTYrQVovVXBLdjRRMlk1VXhETTlrNUcvSmRoWEtI?=
 =?utf-8?B?dXBKSWc4amYyN1EycVBCd0JPV1hwWlU2V3BKeXhwWE5KbGszRW1QbGcwYVNi?=
 =?utf-8?B?U3NyMFlkLzkzWkdLYWsxbXQ0VEFYMGM2SGlvTW9LS1N3WFBTM1BlZVMyZ081?=
 =?utf-8?B?andHaXBmVXhpayt3SDFhYnd5ZFArRXQ3dk5ZRzl4OU5NZjQzS0YzRGlEb1hu?=
 =?utf-8?B?cXp4Q05QY2NsY2VOMFFiaStpWEViMWwva2xSd3loY0tHWHJBdXdKVmxHLzFJ?=
 =?utf-8?B?Y3NyZTBoWnk4WHVpUWZwSExSS21nQkdsT0ZJRlRLTENlRmRWd04rQUs1eXIv?=
 =?utf-8?B?cWZKOGk4ZXM2WnZDTlYwRDNLL1h6aFNiMkJsTzZ3OEd2bVA1QjBHM2pSL29r?=
 =?utf-8?B?eU1mbkVqOHZSRHNLNkZsZ1hsdkZ2WGtRRG9acG1IMjN3OG8xdStjbktCaXNk?=
 =?utf-8?B?cndKL1VTOVQ4WEZqdnF6VnBzaTl5TWhKSklRK3dmelZRQzZWWWtYMnRycGo3?=
 =?utf-8?B?dEk2ZmptVVNIa29XQ1RqbnIrcDNPUlF0N2tWdDBiUlVIYTluek1XN2NrU0hP?=
 =?utf-8?B?TzljSkNtTXB5cjkyQjRFaExHbTJlWkpYVkg0ZnhvMVBCTDRsck1mbGE4Sm9v?=
 =?utf-8?B?UkxYaDRRWUZtUGFkMDZYRktBbUJWK050QVNzRE5MSEZPU2RrVmp0ZnoxU0N6?=
 =?utf-8?B?OU9EYW1DNTlSbHYxTW5kS1F0NjMyN0hONDFxTTBMT2hzVG82a3loekVmZllU?=
 =?utf-8?B?MGZkSFRyeDluc3dkMzFPYVJzRGZJMGl0cTVsMXltZGVBK0ZNWHJOMWFUYWxD?=
 =?utf-8?B?eWxVbURsV3hsQzJKdnlodFlISHFLNDJlVG1JOFFLWDBsV20zcTJXcXBhOXpk?=
 =?utf-8?B?Q1hrUzNuN1Y4VUF0VFRwNUZtNXMvYlB0c25yOUtTSCtUTG5XaTJ1U25Vd2Mw?=
 =?utf-8?B?bzRFb1E5RU95YlFPdTBlaWtRV3B3QW9vZXZjeUx5R1BhT01saUpkWWwwZ2to?=
 =?utf-8?B?eXJ5OFlONVFMdkYrak5LT3BsU0xvWUhpaGRGblIwZVRQbXhteGNPSzFOdmI5?=
 =?utf-8?B?eFh4UDVwR0huSk9YZndXR2Z6SHB2SE04dEcxS0RQOE1vd3orRzBHdEhKZ1Ji?=
 =?utf-8?B?RzBMQ2swSEJMZjA5b0Fja2thVXlqYVl0Ny9OamN0d0h6d1ZlN3B6bDdGQ2o4?=
 =?utf-8?B?MGFkUCsrVHZxRWdENGZqMVBJTWtIUEtxQTZXejRoZ1d1d0s1QXF3ZWpadVpG?=
 =?utf-8?B?akQxZ1k2a1o3ZVVTTEJNOG4yZkJOMkl3dy9jcjgxTnFFc3hNT3pva0ZrSWR6?=
 =?utf-8?Q?sAshBc4+LXPt20IrUMEGwoF7C?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Pajsbvg6aSMYEkLGJ/neas+fTrTSSLUt5QFgq5IGxX1P/nZkcc9qNKZkXLOk4q8STLtzqw12XuYHkknMecZLsMulJzGNiQcQVOGv3s/GQKqbZPg8jYqaLe6VLyNlzxN2pucOq7nok/1BShq7bu9K/P9DvrEl6P/ujO3qEprn1yXvDUFwBaX5I9kk4n/qGnSJiYA5c7pvs7LODvbjbE9xxu0aXOP4h01xOaGrRidBO4RZ48yKAfcCT63zcPAvKdhYR+Kc92+2E7ttNRp5Arc4jCWOBblPm50SrwxQzcAPb5tcCwIxmumhVDlQQXcPuL/Oeav3gTUw+lfU5+dCtgcKYS45OjQmeW3DKuobnSN7xl6Wd7q5E3CD8a5ZoCXk6jWTLLoBJqqaDDBt0ZsgTQsfJEC6Qoy8r7V6uG0lWgw0jMYCnm/NNvtjHQM7i8MQ70LivrM5Y+e+p+SHz0fIx4ntdnef+jP2UlhvWyoqjXc4ismGBaFjuRgFBqqgpKMG9wuNemv/FwDptdAS96XIMwbJ1y5VC+UhLamQvu2n9BcHJmkzhhyuDPyQqaSjGEpR4LfrRH/v0Z9GU9u7vFOBLWLyrVIFmb/5f7uH3BKJGwZg8xCOCdtFgs1GK1a8n2Tcl8L8jEiqn2ZFt+fupEGp2mgr/u4OVN24vA2hH4FmTb4an5mPo9LDSZ0Fdk0xp+PGhX1p/cdnq6nBQ9pncb3947nTTGvJdEHopH/X18LV45Ebuy+r3ewlPRr1Nh3EWAHxTVvvSohHGPyE7G54axkQNaZrlhjkQBPRzdpNBCS+DVUJ9dE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ae2fc9-cdf4-4849-e55e-08db037fa1f3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 11:38:11.9652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YG237GfhyF47/pEFicf/ODlzVYvcDCiDT1Zis0++Yegh3c+BzNka8vIc8xGf6HINHl3oevjW20H83Qx9OS6cAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4643
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_06,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310103
X-Proofpoint-ORIG-GUID: mD3e1YlHE_D2yMlXZCyTRT-JLACMltBk
X-Proofpoint-GUID: mD3e1YlHE_D2yMlXZCyTRT-JLACMltBk
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


Nit:

> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index b8fb7ef6b520..8f7b56a0290f 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -246,7 +246,11 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror
>   		btrfs_crit(fs_info,
>   			   "mapping failed logical %llu bio len %llu len %llu",
>   			   logical, length, map_length);
> -		BUG();
> +		WARN_ON(1);
> +		ret = -EINVAL;
> +		btrfs_bio_counter_dec(fs_info);
> +		btrfs_bio_end_io(btrfs_bio(bio), errno_to_blk_status(ret));
> +		return;
>   	}

After this patch, the duplicate code lines can be consolidated to:


diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 64268278bf8c..d13825a4ea7c 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -236,11 +236,8 @@ void btrfs_submit_bio(struct btrfs_fs_info 
*fs_info, struct bio *bio, int mirror
         btrfs_bio_counter_inc_blocked(fs_info);
         ret = __btrfs_map_block(fs_info, btrfs_op(bio), logical, 
&map_length,
                                 &bioc, &smap, &mirror_num, 1);
-       if (ret) {
-               btrfs_bio_counter_dec(fs_info);
-               btrfs_bio_end_io(btrfs_bio(bio), errno_to_blk_status(ret));
-               return;
-       }
+       if (ret)
+               goto err_out;

         if (map_length < length) {
                 btrfs_crit(fs_info,
@@ -248,9 +245,7 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, 
struct bio *bio, int mirror
                            logical, length, map_length);
                 WARN_ON(1);
                 ret = -EINVAL;
-               btrfs_bio_counter_dec(fs_info);
-               btrfs_bio_end_io(btrfs_bio(bio), errno_to_blk_status(ret));
-               return;
+               goto err_out;
         }

         if (!bioc) {
@@ -278,6 +273,13 @@ void btrfs_submit_bio(struct btrfs_fs_info 
*fs_info, struct bio *bio, int mirror
                 for (dev_nr = 0; dev_nr < total_devs; dev_nr++)
                         btrfs_submit_mirrored_bio(bioc, dev_nr);
         }
+
+       return;
+
+err_out:
+       btrfs_bio_counter_dec(fs_info);
+       btrfs_bio_end_io(btrfs_bio(bio), errno_to_blk_status(ret));
+       return;
  }

  /*

