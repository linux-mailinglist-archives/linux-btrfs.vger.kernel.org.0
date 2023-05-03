Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624F96F543D
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 11:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjECJPQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 05:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjECJPE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 05:15:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB71055B5
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 02:14:38 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3436pEqM014431;
        Wed, 3 May 2023 09:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=B5uaCzv5kfJT8dtqc0SEm48ujpU6MImQK1WAe9rgLSE=;
 b=klE9na9X3eiOk4/qQU5FRc8Pyk+OdFWYwaBoGpNf9LmmpU+h8wqZllaGD8Jxb+DOAcil
 sMTB+04CAO19lNq+yDJz1lRAfyIx6CiV4kuZJzYaYC7HnQX4aM8efR4WQtZ0dKThGnNf
 KqxjKoQoRCOEWpUYuVgfsNfTdz+m5A8ZiPtR57OkcyG+Ynf+/MS3lEOVqFnIRUNB6hOk
 swtH3dkLAvC8jQ4D/IXh1ppmWl/VuLA2t8/vgluWpk5l8/6gzEMa9hv0UOjzzTe/iib1
 IBI6WwpXqkvO0CMYfQyd0WtlR5zKDMWJ05iRhRpVeSvdygGEkhM8D4ogINU3bcwY3BEt QA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8tuu6t8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 09:13:56 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343876po024917;
        Wed, 3 May 2023 09:13:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp73yeh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 09:13:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeDPG4QyPz3txWUr9rg0rqfKt6fuohT+G4HA5iofA0agA0yR3sFTjC2LCdZfOYdrJ5Efyo62XdfMwP0ypEpAI/1Zk+XWIVdbHLr5OGPoNJTQLpMHL+g9jfkq9x0Od84lC8h2j8JXACwqShqT13JlRGOR3K3SRsJKJViShfT9kUPS4WHLPGt+vI9oR4dLsFbLe1HXlpnpE9ZxU6ZJVSmDpmqgUIJ2YXRE/utE2krfmw1TVpDcL5pE9jPFlUWJ/Wt8BK0wLoBNfpI1hPQf4v/WIJQCP5+STsiFFyI04iWlXRqb/aGfZno6rTtg0Gn2654hZwYWd8dBEQ9645jKjpNKWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5uaCzv5kfJT8dtqc0SEm48ujpU6MImQK1WAe9rgLSE=;
 b=fvSnPAb7ah0dt+oRa1MlRdRe2PEbsGEBUlAfjtw54tBZdHxxtRF8WzGHVTk9y4096xPV9Alll9FXECPGU2DZ+vpeAWTNDyfN+KRb0oiLdOyiLv5Ju54O3WY6hzNCqt/MeJhUmkvCqm3Aitw55GoaZQb0b/GW9vnAJanyNDnQ0dzS5tpEER9svQRNIIia+h7mQsDmlax+0uDl8BXEPnBAjWsXckaHAjuRwIPL7U0eZc+V67qQx4QgNXq51N5Y8cUTHqp7QrruEV3Fxk1rdIrcpwRtvS060JPhK5vf2eiuj8UexexQvPgH70APye8xuQbloufNIv51QCOmOWPnjsiIcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5uaCzv5kfJT8dtqc0SEm48ujpU6MImQK1WAe9rgLSE=;
 b=hJJKIOx5d2oUA//fMafILLGZAT8teLMI77yP5xEYxPAQPKfJ5wisjy2wiHC+VMwLVjtKtVoIFuvLdfp98BY6gi93dwmAbZcI0VPJb+wADSF5gy6mqLuCme/A0awdsiKaS3Ps/ew1XJHP2qCJllSNV5Gb6HmDJc6v4R+0j77uU3U=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4707.namprd10.prod.outlook.com (2603:10b6:303:92::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 09:13:49 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6340.030; Wed, 3 May 2023
 09:13:49 +0000
Message-ID: <e9edfc22-83e0-ff2e-cc8e-4d45047b7f02@oracle.com>
Date:   Wed, 3 May 2023 17:13:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: Unprivileged snapshot removal after unpriv. snapshot creation
Content-Language: en-US
To:     Jan Engelhardt <jengelh@inai.de>, linux-btrfs@vger.kernel.org
References: <715r77s6-pp14-5q68-2258-nn87n1701no6@vanv.qr>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <715r77s6-pp14-5q68-2258-nn87n1701no6@vanv.qr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0180.apcprd04.prod.outlook.com
 (2603:1096:4:14::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4707:EE_
X-MS-Office365-Filtering-Correlation-Id: e01cba54-f265-4c77-473c-08db4bb6b46b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3bkSWhrmQ9IgGalT0ByehRfMhM0p4y4awdsNJv98otnASXBAtKg7LpgaxOCmsCcKYPxDB4IELp+UDIAwYhIvK0cpYFBkdQg+0iQLyutAVML7mcvsGUpy7aUsoFP7slPgkPXYxLDwFr7294cV3PJ4cwrZJVH6sgWzjmFDH+v21MtucUCkEj4K5jUAJJfugT6Zmzaz52/YrAbqqDp5KurNtzjTimrzdg0IhZwvtcsu3qa0VdpST4Yq4WK8OlZkM/IZ6Yas65CAAvSybqJ8St9kVGw8a8QipYPCa+I7Q8hx3B15vl7GmOjTdyh7jBe73IdMk+r8nHO5b7Xorbyd0IthNdU8iHS4lVxqvMfRR80MChIv9iNG4RIS0KQiewR/Nvj39h35MiA7pxPZ2//yvw319ZuSu4URPSYz2879pTmeQp3Q+IyZzO79V5EWsEyqLlhviAtuYjjgT4JBjlq8C7whWCdDpxCCwciLSEnfWnDb3/pPZdOVcCavlWW4QQmH+Ff5WSiJWTiTgdAjE9JnjD5/XjqK36nOqGxEqGR/r1xL53Mrl4Qa/WxCJRUe+MOxSaE4uy86TxrGdqehsMI0tT/2L1YSp93h4i7kZ+viF4ZZneKSuKoqWaT0MCZKh4zRUqAYwi8wxzXvsywIOBjEA1d9Xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199021)(31686004)(2906002)(5660300002)(44832011)(36756003)(8676002)(8936002)(66476007)(41300700001)(66556008)(66946007)(86362001)(31696002)(478600001)(6666004)(316002)(6486002)(38100700002)(186003)(53546011)(2616005)(83380400001)(26005)(6506007)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkRYOXQ2aFl0SlRRQ25lTGMzcWY0RXI4YzNobUpvL2haNit2QkRDZUQ5N1dH?=
 =?utf-8?B?dlVRS1oxbDhlTVBXVHA2V2lnTG9zclR4anhSL0hHNnVGQmtjTm9jbWh5ZytP?=
 =?utf-8?B?T0lrV2RPMzduWStHd1UvQi9ER2o4Q1VBRlZxb1JLOWd5Mk11U0lIYktrcm1X?=
 =?utf-8?B?T2l0SkpUOEljOHlkeUQ1b29nYUJBYTRxTlBaaU1OWlR4S2RtaHQ3Q3lEY2I5?=
 =?utf-8?B?L2laYzFKeUdaL3lpdktuSEhLeFhUeVFnS0ZlQkJ2T25WS3VNem5uN2QyZ29I?=
 =?utf-8?B?SGMyMjR5TUJlNm5hYlFhK2dFMCs2TlZzTCtLVkhWN01HRnhEdWVLaVdIZnMr?=
 =?utf-8?B?ZWh6elorRE1aN3hMSUNPdlhNU2NlQ1M2YXJqbGNES2ZyWHBiTDhrQ3dqdHpQ?=
 =?utf-8?B?L3ZicTRRdXZ2b0Fabks2SlBLeDNpazdkekNtbXoydml4YUVJeVBBd0ViS1dk?=
 =?utf-8?B?RmxTbzA3dkRZbVdXeU9CenV2OG1aNTJOdmp1ZFF0RkRBdTN2WXB3U3J3b002?=
 =?utf-8?B?NWxrU2lXb3RNU1hCTkdrZjA4Skk3dVRtclZjUm1UNHBYck1Oa1VQK1ltb2VP?=
 =?utf-8?B?V1Vpdm94QUN4WlpoT0JSQkFDMnJHcW5qUVVycEhBakRoMXpCWVpJbnFWS0lC?=
 =?utf-8?B?MEpmYWxBNFI2dzR6dFg3NWtyMTlzWWdlenQ3aTVYQkoxUisxV2N0bkNWbGdG?=
 =?utf-8?B?eU01LzRFWG96L1EyWVU4VktvdzE2QjIzd0JLMFhpbHRpQTBOc1pGUkprZ1RT?=
 =?utf-8?B?YnEvZmRGQmxrai9sbDhuaGwwY2JOb2Iwc3RmVkVpYXNFcmJHeWZXT1R2VlNT?=
 =?utf-8?B?QVpQQ2ZXc0JHeTM4MDRJL2NKVWhuMnlxc3lUSUtKckVDRys2V3RObjRBcjd5?=
 =?utf-8?B?d0VwOGhvd0cwYy9TWUNLblRDLzE4UFhPYlc0ZWNtemZDL0JlUjBlOUsxL1Vs?=
 =?utf-8?B?TmhJZE9kMHhWV0ZyMFBKTGZHbGNsUEJTWTE3R1VnUUkwOHJlVW80a3Bra25o?=
 =?utf-8?B?L0M4T3EyL1pnNDlldG9GWnlyaFlFblp5bWN6NWZkN054NXMrclQ4WHNBc0Nn?=
 =?utf-8?B?ZUxGbXcwSFFUN2YxVC9YTUwwTXZ0OU1KUHRBV0V6TDc2K2xOUk1tVGYzdjRU?=
 =?utf-8?B?T2J1Q1pxR1M1S3JiKy9mck1HODBJVDJ0ME5mL2xvUVp3ajdaMWpKVTA1eUZr?=
 =?utf-8?B?aktFT2Y0cEJwWVVKUWhuK1lmNkE0VWZaVVdxK0JQQ0h1OThlZVAzck53Qktl?=
 =?utf-8?B?d1BURkVjYlpBSGFjOSt3ZUhXSlRaYjV2b3BQOWRrNkJZNStmdjVFMnBuNHAy?=
 =?utf-8?B?d256VjlaeDdKTkY5VmhrTjZ2dTRVTmVORXNqWWVYQWM4K1BhdzZkQU5XRHIx?=
 =?utf-8?B?ZDBSZ3B2VGRaUHVLQW5zblF0MkpaaGFXcmovTmU3Tmc3U1RvVW9rUVNiaWZM?=
 =?utf-8?B?b3dmM25tTE0xZHMvcm1sUllHYWh2ZG5NaDZORUNUU1Rxc1Y1cUlSWXRBTXI2?=
 =?utf-8?B?Sklib3kzd1VxVXZNUjRqY2Y0YnR0UVhzUzluaDhSZmFvMnVVRTh4R29iMDdE?=
 =?utf-8?B?clpqMTBrNi9zYlFzbDJmWnVtdEdHZUZjSDEwS0o3YytqeTVVb0h1Y1hlbE5Q?=
 =?utf-8?B?VFg3Q0creFBwT1pDZTlXSnVVbVpNRHlDNUdzU29qd0tRcUc4Q3BIU3J0QnVO?=
 =?utf-8?B?RXZnVlUySWg2REdMYjgreC9jZWx5Sm1LWENaM0tQbFVBcEFDaytUODJNZUNQ?=
 =?utf-8?B?Y1pRTUlLZW80eElSSEFSeXJydWNFUTV3bnRYMkJhZXJQQmhuTTRFL25HcGZN?=
 =?utf-8?B?eHQ3OVJnM2FGQlZ4ZUF5NkdVQy9oTGJFYmlIVk1DQzhRbTFJM3BmQ3ZsUUxE?=
 =?utf-8?B?anc0SVJvRGxRbUpuUXpnbHBOTDlDQnFTMVdJN2wyd0ZkRWQyTGRoUWExWU9V?=
 =?utf-8?B?OEhYeTVIS0F3UGNmRWVkOWtBY3NtRGZqUWhUVWpMeGgrV01MYzFURW5oeEhu?=
 =?utf-8?B?UEZ1NzFwdENtVlNVekU1RWR3TzhiTi9kMVBKakpIWjBrM2hQUUpoZS9XUEl6?=
 =?utf-8?B?OHJtYzhCL3B5Y1pHYkNCU0ZlOVlzYUpZQUE5SytzdWpxNEhCOWxaZ1k3eGtQ?=
 =?utf-8?Q?/mFG4SnQNIlgtFp0dKjGAAGGQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kLONKEWyxFoDuqM2Op9MTiweUIlosOipjjBDLwwxIKgzgRI9EdVnAk2kNmht6D2g62jjExMC2N4j7vnYudSPBV6eFK0U2U6jLM3/M/w6qB2bzU/FYOjP2gndR5JVCU3xjL8l3MQxM1F5s3QvH9LHxORObEU+5+PdeYAfN8hQU3//IUxH/BMOnC7JxvdZF1221gi+HeM3/JiGiecSXlonUgD6epVxjTmAd0VFpKWEGl5BA4vXKVwqadtU50/SjvVWMskpUxmSinS8FkfnwALcRuIIhqitNIkJhXHY+v4Ep/ZLP+HdOi3ULaYkgT0G4vkBzKJSItiuOby6XoSOYnfdUQlS5z4AYYYPKlVXQqd88/CYTHUdHg80DcHlf6mkiZ5GsC11J+dfx/CzagitB0e3x3+SPey2E8zBRmy+mmO1QSR644WUsLJOMXT+1NyW4/lvmXnmvHJEScGnNUbiiKl0TzSwkic8ymUQjYIyqIWxBqRv91FbYTiSrmtTY73Z3XVq/8i2CypwkijvsIQUzy3FCBBk4TzM3U5T5P6OH0yy/XpDtYKjrszHuGfSSX6RF3HqLAJguZcLRz9kE4L3uGdoOWUZMAwnHWEPbW3JCj4vZsHkf5vvLEwE8MS0e1ftv2MnhLYwJ/skGugNag7LknxeJnm6HlGhUQriu2305r2CAakPcQCuQ/Fd89o3J4YVuCTkGvTG6BZQuBY2Jg+vbotzP7Cd5Cja98I8KRn8DFvcq/5BF8GBP/8cX+cks2ig6J0xmCBNv+Y7j++STgaQOqLuAA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e01cba54-f265-4c77-473c-08db4bb6b46b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 09:13:49.0432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vHTTKTfLFbWjPfimiE186+p3Nwh4bZypAmq5fjqthdpd1PKJW0ojilaDzcP6nBVXeIku94+MRiq4YIitpsJhng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4707
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_05,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030077
X-Proofpoint-GUID: iJEidrpv2ZuU-Sb2Br4ZC_jgqUZnIVbm
X-Proofpoint-ORIG-GUID: iJEidrpv2ZuU-Sb2Br4ZC_jgqUZnIVbm
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Pls try using user_subvol_rm_allowed mount option.

   mount -o remount,user_subvol_rm_allowed ...

HTH, Anand

On 03/05/2023 16:29, Jan Engelhardt wrote:
> 
> Bug report.
> 
> System:
> 
> Linux 6.2.12 (openSUSE Tumbleweed x86_64); I believe it has no patches
> that modify btrfs behavior w.r.t. snapshots.
> 
> Observed:
> 
> f3:/mnt $ btrfs sub create 1
> Create subvolume './1'
> f3:/mnt $ btrfs sub snap 1 2
> Create a snapshot of '1' in './2'
> f3:/mnt $ btrfs sub del 2
> WARNING: cannot read default subvolume id: Operation not permitted
> Delete subvolume (no-commit): '/mnt/2'
> ERROR: Could not destroy subvolume/snapshot: Operation not permitted
> WARNING: deletion failed with EPERM, you don't have permissions or send
> may be in progress
> f3:/mnt $ ls -al
> total 16
> drwxrwxrwt  1 root    root      4 May  3 10:09 .
> drwxr-xr-x 18 root    root    262 Apr 26 18:33 ..
> drwxr-xr-x  1 jengelh jengelh   0 May  3 10:09 1
> drwxr-xr-x  1 jengelh jengelh   0 May  3 10:09 2
> 
> Expected:
> 
> Succeed in deleting the snapshot that I just created.

