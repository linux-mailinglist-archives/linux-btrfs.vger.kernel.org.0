Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47073708F7D
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 May 2023 07:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjESFgB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 May 2023 01:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjESFgA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 May 2023 01:36:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934A5E5A;
        Thu, 18 May 2023 22:35:59 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IIxYcq012415;
        Fri, 19 May 2023 05:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=zx9/09uxBbTCX6go6UeXdHjxlycz0f4FN6PGw46XXaE=;
 b=yFJKfMtp++yjFq704WiX+lvxxEPZMQtAOg0uRm3Ew0d0u19IGDFc78JQ1FPRB7jqiIfh
 e+cBxJOCiDQcNMWDtnUz6igT5yLpUJMqSzGvQ0B3uKmSjsMYV6GGXCQntsRw5uX8i/FB
 2DgFQXmWFqqswOB2QOqaP2LJROM20sjK1iCiGgkslxoTveilrEKTVbVB9Nk5mJyPBteG
 4bJPqIGQAy/+onWb7I7leDx5dZxD1KfeSP3+b3V3R9sHmA0KaIcqJIvQh61p3PchrJRi
 METgm2VBn5NXjdVhZiM67RKijfXfE97iZRcJEaB1ROpB8x5Bu7X1ShfnMJQ2H/7aeXBY rw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxfc43kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 05:35:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34J4T5kv040086;
        Fri, 19 May 2023 05:35:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj107dyu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 05:35:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKayY5a+EbJgLjublKa5qKhiav3X5y4oF8clbBM88olQb1EfcD+eg++U44bhQlmfK6aDip4yztcgXPz6CXoVmfDVykF2VN+HEjWZokznNyMw56iVb8nFh1UlNuYVm9ipyyijuUIFxuLjWtOcwe6EPBJkQ4dahQIwK+AyjxLCaPrGTyrZuLBhJOXUrlAzPLptYtt18MdouomtBm4FH/gRhPN6G4UlACcjrSDKQjnTjP3XFHfq4HEdyXsLm2J9uOFpprUVL0g7BhxcNZ6SnUN/wsl2ZCM/72V9Hke016oeGKQT4aQyhwaf9NZ4IeMWSOP8rk7mqDPrnWGBGDKvSSYOSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zx9/09uxBbTCX6go6UeXdHjxlycz0f4FN6PGw46XXaE=;
 b=gjLod59drAvnS9Plpb5XDhVBRiQ/D/2Hf3lolrW+sSGXcFii7roXL8NBIY7u9ZUxaMgwT3r0T5M0F8u6dVmDBjObCKlesZvakRt65gOL4Dz2oUGo6lJNxGKiruXbQ1rptVTrahNR1cbZIySWLLoZ9QLSUdmGpTKLtDQ12dzhSL+OZjsLD5DjzE1e/gGPsMQ/C6G3FtryN+Fo89NJJVD1MhtTjQb96LZ3y5j9KzBiXbWs/u/gVNAz2hw4xtbNKc4mYE8ZKG6qUYIUGesidWxmhqvg4N6uKTMbFuSYQ/BWwUrElIanYKpFbmBe6v9nigRVBRxNbfy6tQ5YjsSro8I/VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zx9/09uxBbTCX6go6UeXdHjxlycz0f4FN6PGw46XXaE=;
 b=NitO8NVnwqk668n0XEdIpCR1/udaW1Ci7xSruryQjSvi8eVE8oWksVhZwfC+ANKiYKghSQZr1uyACRvuEVgikhGKA28u1U98ALPIici3SLY+zgFCg/nlV7napSwdaNrkZCKV4U+EpNW0MwPyY3QPnY4V0TrXP2wz7C97CbFmaoc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by LV3PR10MB7817.namprd10.prod.outlook.com (2603:10b6:408:1b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 05:35:52 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.017; Fri, 19 May 2023
 05:35:52 +0000
Message-ID: <98b9f37d-d652-3c38-f9c0-5ac71f287af0@oracle.com>
Date:   Fri, 19 May 2023 13:35:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] btrfs/287: add git commit hash for the kernel fix
Content-Language: en-US
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <dd250729b7e59e9208f3e6a96b320a57f31f74cf.1684407974.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <dd250729b7e59e9208f3e6a96b320a57f31f74cf.1684407974.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::32)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|LV3PR10MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: 425c301c-fae6-4cf2-309e-08db582ae8b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NklpIxIkdhZz5qRE7Sc2oNpk/8F9nlN8U6jfWQiu8ApgCgpkvPm4VwqIxJYrpdaImAbbWV88n8/tqN/Xxp3MVnzHedRvwjcxEncbp9JUAJywlRTSWFvFMPlb9HOpuDvLVeoIP6GWKbEtDgpkbc4BHJfJrYmUjNnKtgLcInbz1fzMIdvTgLr+VOcpGYWJRTPm4DnzNmpI8kDQSFHzYCr3chBOgu7dQk6pu0Z5BJB7SQLXzeoPmsfXFEIM6WpAuQh2pNz0YX5iaAZKMaRNtj4THC718TQntX88cc48xrcHETkmmvoFtxScQ/lnnxMDz8Ajok3mmgoaZL8kY4fNmOxMjLfyEGoL9l8NsF6PdUohvEKvj5JazPMy2L2aMCdzhmRGfLAPrAdjDXI/nGMAnemoHO6hvOPYQqTH9BBCXRujnV/GmqDhD6pehqJub2FZNPsjPs9RtRQ4/j6IfYkrty0AJzPb+6qows99wg69Bm4ST2Xc37zL8y8dollyuaoBjURFOQtlIdaA6G/zoUha/+VlGWtR+3Y8Jy2xUeSnyR+BWi+5Vrx3fO+RKSrSr0ihWEor1qopmhcsaIir9cEhusLajz5MY7FScEXKsWxSy7fgvasEM7pLYMT92Vx9AlXaB752yl9gWmAIrSCzhE6/JYKJIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199021)(4326008)(316002)(2906002)(478600001)(41300700001)(8676002)(31686004)(8936002)(6486002)(44832011)(19618925003)(6666004)(66476007)(66556008)(66946007)(5660300002)(6512007)(6506007)(26005)(4270600006)(186003)(38100700002)(2616005)(36756003)(86362001)(558084003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elMzUzEwSXM5Qk04bVZQRkhhRGdtY3g1MFMwZXFScHNqMEFlQk0vcUQxN0pC?=
 =?utf-8?B?MEo4REdYV2FZVndGZytiZjVtdkVEcEp3ekltTFIxZzVUV2dDbS85V3pnM3Jv?=
 =?utf-8?B?NUl2RUJTMStUU2d1ZE50cnhNOUd2UWcwWjBTdUVnNDZwYzlaYWdWcFlmTEpj?=
 =?utf-8?B?Y2EvZVI3SWZHUU5TNDBiVzM0UDBNRWNSWjJrYjA3Nm4rMExHY3BzUXUxSVdF?=
 =?utf-8?B?b0xqa0hZZjZWN2Z1VGU4azBtVUNDQitIeEhZRTVyeFhHQnp1bkNLcHVpeGFs?=
 =?utf-8?B?Mk1qSE5QVzVydnYrYTRhZks1eFdtcHc4VXhkb0ZOS0hiZDFNRHREcy91VXho?=
 =?utf-8?B?K3JGc1B0UlYyYll6NS9uTUpBbGdSL2xxQ2JuQnozeTc4SG1sQTRsVitMOEhz?=
 =?utf-8?B?UWVZajBjWUd2VHlnRFlMMkdobzFZMjczZ1dndjZiQ0F4aDFzaFk5UGJ3cTJF?=
 =?utf-8?B?TmNnR0VUTjY3VmsxeU1rZFp1bE1HTWx1RDQ4ai9QZFhST080MmdNdlZnT09M?=
 =?utf-8?B?cnFaaVJWenNKMTRQYW12MFFYWjBTQzJTalBIZVl1UDgycWc4WTk5SmZXTU5F?=
 =?utf-8?B?UlRBNEFpenBSV2NGVitKTkY1K3ZmblVTeDdvK2cxcTZIMW1VWEI2dUpBN0hY?=
 =?utf-8?B?NlMxWkxIUHY0MVFYMk9rZ2t6bEpWZmx2a3FsRytYbysxeUFTYWFGWnFHMTRR?=
 =?utf-8?B?V3hBeFRHcWQ5VGcrM2V4djl5Z1ozWmd3SEZmb3c0dTI5dVYvZ0Z3eGUzdklk?=
 =?utf-8?B?T2ovQXJ1eGl2Tkw0K2N1SUFNVEZOaXphekIvdW5pQlA4ZCtWZy9SR3VVdUNY?=
 =?utf-8?B?NVRwbjdxRU5lZEdTU0plUGNGOGpkZisxRG9lb0ZIb1ZyczdPZ3N5ZEMrRjNK?=
 =?utf-8?B?Y0piL1hEaHlycnpGV1ppMFJBalZPVHpibXlFUitaZlg4OTM1ejhjeVFCSWNZ?=
 =?utf-8?B?ZkdFYW52bC9WR3pLQnBLeVI5TE0rd0gwRjJhNUZYbEQxMmk0YkliSDJNK0VS?=
 =?utf-8?B?T1JycVNnRWdSRHpZTlNSemNFS3daYzFNUGV2WG9ZSGYwQW1FSTU3TXpBWDN2?=
 =?utf-8?B?RzZPRXpBTmZOQVU5U2k5djR6NDUzVVJSQ3ZTY0FXODM5NU5vU1BpMFpLbU5J?=
 =?utf-8?B?OFZNM3JveEI5OUtnUzJiZGhLdnJkWVQ4bUMwRC9oZ016cFVPbEE4cmdkK00z?=
 =?utf-8?B?ak5oVG9iWjNYZTBPeURFcm1WRkQycWRCN0FJdlFWSVJVK3B2Q3NxVTNtRENN?=
 =?utf-8?B?NEI0c3ZTbWxXc1hmaWViczdUMnNlbUdkcG9SZnl1VVU0c3hNRHNKZHVNbTJh?=
 =?utf-8?B?WlFhRWN4bnQ4VUhaczNkeTFHWTF5YmtjVFg1SFQwSG9scGVkcG1mVmxIa3VT?=
 =?utf-8?B?RXJEVnBVVno4OVg2dTh2Ly9PZFJ2end0TU5rUTZKWmVxTCtydnlvS0s0T2J4?=
 =?utf-8?B?UlQrYVpLVTB0RkhxSVYxbEFFU1BLVGZSTmZKYmMyY3h3bGtLWS9PNFNUVnN3?=
 =?utf-8?B?bG56OFpKTkluUlpZYjFtcm1uTm1GdjVhdUZndTkxOExRZlVZZWltalpQc214?=
 =?utf-8?B?WExXSkVQVXB5cnZ4SFkzNG1UeC9OTGREK25xeDJ6VFduSnlSSGJYUy90M3BG?=
 =?utf-8?B?eWE3NHdpVEtsVmZXL0pDSnpDUi9mbW0yNG9HbW1kak5kM09WajVjREppYTVF?=
 =?utf-8?B?ZHl2TGFxLzZqOXAxeCtaTVZKWWZSQ3ljNHVtWnF2QjVVcnUzRGhYdkp2dUdO?=
 =?utf-8?B?U0pJZSt0eXhlZEJqNTNVYi9iTjZmNVF3ZzhHeWpjek5ObUcweCtLSnVRL2Ft?=
 =?utf-8?B?N3NXMndrZnEvTlE0SjdVNitwNGlJbzdQclU1aHppTzBmWHpxcCtQQWptZ2Ri?=
 =?utf-8?B?YkxKZFdvY2RPcnZtbVB5aXRUaDlLMElXVHM3R1NwcjFRWlNWK1A4MFc1QjFQ?=
 =?utf-8?B?bzBDVEJkbkhNVUFiRUh2WnJ3V3BCRWtOZzlyYm01WnpNNFFuSnJqYTgzaG1O?=
 =?utf-8?B?enlCd0lhT1o2VXp3SGhNY05PNjYzYkx1SS8wSlFxUmQ0WENCWWJBK3pQVHRm?=
 =?utf-8?B?OCt0czVPcnBadUVhZnFDZkNzWjJWOXhhS0RoZGU3R2hCZk9IYkJYeGpiOWNR?=
 =?utf-8?Q?8rFBUI5d8S+ursAb8IwKV1JHj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mjJyPs7xSMByOdylacnu/cY85OYcCn9jFI/wE35Q8jgQ8JHesTFPlUzLm9oxIZx5mNgkujIwpIvXEhPnp8N09sWVNbrUe9cocXuVjiz5dirYagxCT4vPOeWSEwFDKadEd7a18QHkp0sEXGHnpLK4PjI4ac89KaaRFk5zKf8R5n8gEcfhTMGNvy6WlVQed8M4J88jOF2jAuHCHajgxwPTz6oqQeMQgQt98dneruDc2SZ6y0qJ8+xMnQxyXLgLdddFSMle4cmRe2XpaEIVILoquOk4uLjGXNvOd2dcOPmdZF0OD3jX9l1LtIghXxm0QHO+OBP059qzQYg4ny5IKUXnEcSTIIQaa5EDo5ZId5GqVwxn0i136xvXOdkoFb9YKQQoWaFgLvcwaFmDSB1QP7ILlC1vr4yFXO6Sy5szPyNjySwMCoyASrpiA5xZerSALCuXxh9uaxqvGH4naAo+mKAW8X/dZNDMH+IT2AZCQjWdbdfmj3QQhkUPE8cz00rLLlz1LLAi8+PZ0Z8qgaLx3X0m30tufVb5Wu3++VS9YO/5MymDU7iNYz9RdNngtWurlP2Fa00i4CgV0GdOj0MnxMBBRnujZ4yByKLdAHhYCwXh2yR50cOrov3L4W7oAmLqGSQVn0u8skbsHWO5Ge2HJyKhBqsWVPdALnAeeRTljK7fvzJLbVnSXdlNPDa0jB0S4ZAjzeQ4rg7PRhmGSF8OI59FUFuDeIDMrEhsqgvQ+fNNNFBJoNnRdq3b77psot2c2JnNk2JrSSPRy/TdDI8Axt+lFkuYE9J21UzYfwY4O3dJEXPV6YN888wGuhIaHf916nuo
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 425c301c-fae6-4cf2-309e-08db582ae8b7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 05:35:52.3030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KxN6xjTtnx20oblct02/px5peFJgWTN+U8bJ8dtdIlejh0/bGBJr0kF0xbn5kiDbojwG6fLu2Fm4uqMgnGwB8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7817
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305190047
X-Proofpoint-GUID: 1AzFW3_bIvUKAdFMgQAUbeGRWOoXb3Ey
X-Proofpoint-ORIG-GUID: 1AzFW3_bIvUKAdFMgQAUbeGRWOoXb3Ey
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Reviewed-by: Anand Jain <anand.jain@oracle.com>

