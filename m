Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA9C69B687
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Feb 2023 00:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjBQXsT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Feb 2023 18:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjBQXsS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Feb 2023 18:48:18 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4EB21294;
        Fri, 17 Feb 2023 15:48:16 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HNXxlZ020158;
        Fri, 17 Feb 2023 23:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=RvM7X+fzhLIF7FxYNhKY7q+M768WQdeqPDt589dqvSo=;
 b=jui2asB+JW7A5/ifUAZIpetrhjA9aovwxRKv/Sl2gmMgJCnYpPowF6/H0W382tidhF2r
 KpH/0kZgb46I/by+J0mhioDFVqT4pn3gsSW/7FmIqskaDfdmeeSktba49x8cRZ8NQhJE
 k+tz5WJl1RkCjNI1wjvcsZ0mac+vDtZMfAndPC3fqS/mXMu8UMziRuJrrXgj+q43p3Fy
 oEW0QOY91L4JUbgaJQY2wif/Gre+8m91yOVF831Jk3aSv44K2SUb0ylixTpHPJztd/sn
 VOTgCsO9pQ7SAnVk6qqpSukFtm2tOIJyF9p0wbKSpbl9l8ZOXjpk6nzM1jSfHrpIXMM8 nA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np3ju76q6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 23:48:12 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HMVBPP036033;
        Fri, 17 Feb 2023 23:48:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1farxpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 23:48:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBQE4EviVAwhaDH0ESGxEztFA9axtySmTEdOl3Qeo9uZgToDRJkIztEJYvKrnW7Ge9yasy+e+J960C/wd61qPV6eSPzqw4wwq1NXBB7hxLIEdDn3rWEe/3Y24u6t1kp12pJ9CFzcL9qYdkWGveh/w8IW/B7/35/x71han2dgZ0LBv/CkOcVNOVMm/m/9+6jLLdxxf323Vmkmp0JzQTElHcLXf6Z49ZcRNhIY8Ycfve/Gszk/UO5CrZAe1bqS3/lVJSN0Nxn7uVBeNFvC9MvfMBi9H7vZG5KGNPEWAQMvfEEci0JVQu4g9a0Bk7qJPFGU1Ckr2NydVqRcyPv9Z0j99Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvM7X+fzhLIF7FxYNhKY7q+M768WQdeqPDt589dqvSo=;
 b=XepdOGT/buRqXeu/V+1L15uMfkSs4DOPWivIP9AbWZzuzp9IjF6kdGXEHfXthHHsQP436BAFdKx5BvsScfOQ7TFPGFwfnPHtE+QoaD+bqaYwNGMBq29GSVelYZYES8aAPwEagl4eOEec49t3HoKBa4dxKryGH+/5A39RDVFQOUGm6g3dRdO9MaEmRsSYYLSY/aRmAqp7XP4CXcY9OiLcddRaFPnaWE3LlNRKzV3n7ofcYQJvbR7iAU+blhmzRWece60LNgV3yPtzJUMHoQ1P86AAftezgBRCRa8dZiuoj/eVz5pIm0OeaFKXv5n2kGkUtwcRle7qqtp5nD5kOzhAyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvM7X+fzhLIF7FxYNhKY7q+M768WQdeqPDt589dqvSo=;
 b=SAQQefy04nO3v7sT8NHlmBe1k9vCaWLbOKOiqbn2oHXYNvW1K+XBoDasr+Xj6H1g3RfJ87DygqTDgnvOcnuV6MEYP/s8PpCd3wLXXrfESNjI9kgMQil7WSuk3SXuMlTKUpzvleI9dAF9itDFvL3znMtH5r5u1VnApQOBNoMVddw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6845.namprd10.prod.outlook.com (2603:10b6:8:13e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Fri, 17 Feb
 2023 23:48:05 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6134.006; Fri, 17 Feb 2023
 23:48:05 +0000
Message-ID: <281c0f8a-5e77-770f-a9d2-548b02950763@oracle.com>
Date:   Sat, 18 Feb 2023 07:46:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] fstests: btrfs/249: add _wants_kernel_commit
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     fstests@vger.kernel.org, zlang@redhat.com,
        linux-btrfs@vger.kernel.org
References: <a9970cfc5eef360f6eff8cd24b41f50c07c1d744.1676207936.git.anand.jain@oracle.com>
 <75cbde02c45a75268b19dc8091a3af13ca1c2903.1676393253.git.anand.jain@oracle.com>
 <CAL3q7H6e0aPfx32q847X4jfH6BS6ox_rTY=ypT9f7jaFRTU6-A@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H6e0aPfx32q847X4jfH6BS6ox_rTY=ypT9f7jaFRTU6-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b853eb-1831-448b-3a20-08db11416a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pJGd0ZXvz1iiscSOo2aHMh+pleV0z4Haavfs/nenaE38O8s2Xe0D9sdInLH9Wz55hXEkIKoa6Ws/nWeANaxKDo9WRyLY4soTtNstRkcxsLyOEzqxnKE1mJ0mZw3anf8yF4+VFEFVIwqEQPoTnRYocFg8twLgMakLyvTf91XwUB0xB53+riO4rJifGG9iK6nKVf/vYpO8HuN6Xpsi3XD4esYovBgSP30Yw5Pk6JtamhXLwOlUztxuFRqOpcy8FfXnQj9KWvCT8BOYSQ3V+o+oOFGNjBCuVhDjNTxGDx0Ekt84hZzyzKDHBYEUqUrnNsbk2UkDmA9U4M9zsTY3KtV42X1e3ZMfFgNZn2kJI2fxKeNqrvSCZIT+EQekxNj35bAR56cIYjF4078/Jm+JKOTwib1z7ZnU+/uHUwB9gK3c1UHfbuRqY2SCVse3ARwmeaMqvZEnKE0UzWHmZRtNXXr+dtqK+iPJ/wCBHSR4QNOM0J83f3fObsFTERTQkoecG/ij8BHUP0JzTKU9f+Xw8L1FPgdFVgXU5IVbglmwWnE/l9gcQKTD/brure0BFTVdbm1dSet+J6YlaSb7uHjWT1UWZ+gtFR9tS9TejwaWdSO0xY3Hjp2nf6ma7w5Uaa+6GgcW9XfNE75qBWob1LO+JVmNjt4rK+87GH3UTNrTKtfl1eaZGvXLls9eSkxVyVUkA3eFXrpRnVZP1FbRtjRScgrmf7dmZij3HzGdY+MA7LZordw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199018)(2616005)(6506007)(31696002)(6666004)(6512007)(186003)(53546011)(26005)(478600001)(4326008)(36756003)(66946007)(86362001)(83380400001)(38100700002)(6486002)(66556008)(8936002)(44832011)(6916009)(316002)(8676002)(41300700001)(5660300002)(2906002)(66476007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0RFYkRnbnlHckx6MDdSa2tUM3g1WEhCS0pPcHJXellGSVp4S3FNWDFaQ2h5?=
 =?utf-8?B?M3lrZTZRZFdJcVQwdjJrbTNXMEJOT0hDTmgwbVdCaENvd05CL0ptamFRK2FW?=
 =?utf-8?B?RERIaWJMakFSTVYvTDdUTXlyRDNGNDlCMjVzRXRaYkVzRFFyekI2OEZlU1pM?=
 =?utf-8?B?RDlDdHY4bzhCNUtyYUovYjlEbi9mc3N2NWd4eStoeGVsNS9uNzdRRFBPVUZM?=
 =?utf-8?B?a1VJeDVLSXR4OGhab21GUEFqUDJ1VGJvZTJ1NFhYQVFEYVlreG1naHQyNHlq?=
 =?utf-8?B?ZGFUWVNkZ2I3RzRPaTdSR3JqSXNWQThBUm0xcU96ZWkycGtTaTJJYzNOeXVM?=
 =?utf-8?B?ZlYvaVd5WXJjNnBZWjV3eHVaWVVMck1wUnRhRFprMDFxYXZpVzRXM2VuZkNj?=
 =?utf-8?B?dDk4ZVJnNHFYT1lvZzJYdE1HNmVTaDA0ZW44T3Nvd2xmeXN4T0cxMjRjNUtX?=
 =?utf-8?B?M3ZDU1BKWEF1MXE2SGNGMnkrY2VtdnE4TDhXNTFWcUtaN1hrY1ptQ3dGN3lq?=
 =?utf-8?B?S2xpbFhlTkRCN3RGNmNYLzBkRUpDL0N3SmpCb2ZNUU91V2QySWtpWkhGa2Fu?=
 =?utf-8?B?SGlybW9Lc3A3bkhPT2lFSXp2N1ZxR0tRUzdzQytCbEpnVis2dEN1cTJEQ3lB?=
 =?utf-8?B?ZUNoY2R3ZGdXa1FWVUdQTFE3enZwZzdveDR2UjZ2OExvMVZFbWFvVXJraVAv?=
 =?utf-8?B?eDNOZCsxQ3hWaHdGdEdObld0bU1Lemdaek9OMHQrU0lleElUTGYxWnRNVU01?=
 =?utf-8?B?S1hVdWkvTHRnd0E0dTZjM1JEV3IyUExBYjNiK3FWbU5wSXFIQzN4ZzV0QW52?=
 =?utf-8?B?L1YvUXBjbXdMNnhTM29yTlRKQmtBdnhob0I4NHRuUXRUdDI4MkZJMUpiK3pi?=
 =?utf-8?B?eThoNm5lU3JHVjNNRmpaaVBySlE0eDI0SW5rbzVIL1BxN250TnhOQkV3N282?=
 =?utf-8?B?NklNUEMwZ2NMQWdDT3lsb0VoVEFzZ1FySXp5Q3F2cjIzdkxUV0llUTUwbjFR?=
 =?utf-8?B?OUxGVjB6eDg3NHYrc1plcS9iMjdlKy9rTS9YazAvcWwrWENRM0lwYnBPWkFO?=
 =?utf-8?B?bVpSbEFrM2N5ZlZ5TWtsQzRmL1Bpa2NrWDFKWFRIRjY0aUNLTkJNQzBqN2hP?=
 =?utf-8?B?Qmt1M2ZWSEdmR2tDdkgyNmoyTFd5WDc3RXlzRDZoZmlPTEZ6bDlycDgvUFFT?=
 =?utf-8?B?QzVPQW1waC93d3hvd0ZJY2hXQWlMYmZ4SlBMY0pEK044T0I3L0dJOXlTYkFC?=
 =?utf-8?B?U1lJTzU1VzEyTDhjZ3N0RlFJSG5EeFVndStYL0llYWFScGFERm1ZekUzRUN1?=
 =?utf-8?B?bWQwbWZvdXFzaGRaMytDWkFmV21taXphYjRnTW1nNzVDNkdUc2FjYWJFSFd3?=
 =?utf-8?B?cXVTejVUOTI3bWRoem0zcFdMU2R0YnR6eHcycjZLdXZDY0xNUEh2eGpOMFp4?=
 =?utf-8?B?cUE3QmJ0R1JMTE5sOFJUL0llMVRpd0wwT29BYWtzaTJpd1ZPT3E5RXd2RENY?=
 =?utf-8?B?UE1WR3BZTU4wS2ExOG1LSzJsZjJYN2hDV3loaVg0SnBUaHJxSlVwNDZnbjl5?=
 =?utf-8?B?eDJ5RXpuam9jNXVGQ2VzNnVCemxJTFdINkJFRGwyUEZsYk5WL0VtQTBZRUdU?=
 =?utf-8?B?MzhhWGhqeEtzWGZ1akx4Tlg5NFRwZjArRGovV3gyYUFaNHFKeWJIbld2cVN6?=
 =?utf-8?B?bStzT1ZZN3ZqWE9ObVpOVHVhdXY3VU4xR3Z0TWM1cVFEOEgxUmFJdm1TSlpC?=
 =?utf-8?B?Mlp1Qk5yc0lKeHEzdkdGSGNHN1phNTkzUDNmVmdDOUY1dE9RbDF4SUVyUHNO?=
 =?utf-8?B?cVUzZHcyRGRGaXIvZ3Q3Y0pjZjBqUUYydmx3UFMrUWFUQys4M2pUMmlhL09z?=
 =?utf-8?B?SUxTS21mdlBCV0hYaFNtdWlseEtRdC91U2M5MWhEUVZRbHVoUDRSenZsdlND?=
 =?utf-8?B?aGhFLzM4eHFqakM3T2R4ejI0Qm9yY1MwUUVVVkxuNjBJMlZZeHJFNXR0cVJq?=
 =?utf-8?B?Q0hRWWpVdHVDOVdQckkyWW9tNERUbHpwVEkycENOYU1MQWtYWEpBdk1nUXRj?=
 =?utf-8?B?d2d5MU9EMGJYRExLZXQxcHRDRTQwdElSWXEzTFZSMW56NnptSlFiL2Rrc3dP?=
 =?utf-8?B?bC9BQ2s2TVJGdG1XZ3ZVOGJINm44MUVJaWNMWHhkNy9qWTVVb01MRFJHWWlX?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rz9UFNyXZKw436T0Z14fmvIEaoPsPrg6HxuP+8iUZRTILl4gI+ZRXZJ3ZRVjI4KYdE3m5xwjUZMTalRtBz7eZQIVRkSNPQnvZXw6Dwks0U/tEYkd9Qo1jZkwIHA9Ri0R27J3q18GgwS9gYGFoAGp1sMNuy8lRujuuShKkTTM9rL4UK/tHX9LMfN5ieXo6lhj7VXEP55jqsWw32ka4ep72ZiIaTIvXB70W7QB7U+LmAxVTCSvS8RzKqU9JwYuJEZ+8GbGO25pOR/LwRq080zH/LLQ/Lc3THSHP8wO6ubx5he6gz6pReF3MtmWRTRvgOHnycB4G7ZgH8cw5Yvi3E6GO3VLKhUZTsxCK8MnNy2gvQPDFaXC7LiLQEAD43pInrcVs+oDbL6CTwk/Nnep1LP4aL1eB7D9dl35x6L7xlgsxOrePQ2zMDEQdErXF7iz8/ZnvyaQUv8PsQm3K6MCRjOJNHrABmpH+WJ5Dc8qJ5vD1nrx5aZHNoMb7np8bxujSjTJupsV/F8iC0HP7Z7gM2f3CJIiTnhqXrUvg7ZYloZxIdhEBwp/2w7BwQ3JAp7udYn389LV6ijLfnUaibqlUS1PH8TnwKM6qlXESOoXWn12QWJTJ2Xlu6sEgXYv4p00ZoMr2MnjOy4GXK5FJFVmDWSg2ltDBfxbAeowRSyn/wV6jrFXSepTG7YKznAA5S20SqUHBSLWE7c0Hj1cVRyivDanrWS9erVnUB7itK7HCqqVuoR6Zz+rZV2LSUgogmdpafbAMP4mKJEJPTjpcuemD5wxaMSTSssVnY/0YGZ2FeVOYLtz6v8jX65q/KMdBAZ8sLl3
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b853eb-1831-448b-3a20-08db11416a1e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 23:48:05.7250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i5o2bTmMApO7xjIxkRxobjf+XMorJEA83Tjqpar8XeUL1gJ2qoXIZr0C6OzKPG+bR4xGPpLqIln2R1gupKVl1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6845
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_15,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302170206
X-Proofpoint-ORIG-GUID: DtmIVlLipEkoyh_cSehgTdsdWWaMU1e7
X-Proofpoint-GUID: DtmIVlLipEkoyh_cSehgTdsdWWaMU1e7
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/02/2023 18:55, Filipe Manana wrote:
> On Wed, Feb 15, 2023 at 7:54 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> Add the _wants_kernel_commit tag for the benifit of testing on the older
>> kernels.
> 
> And the _fixed_by_git_commit tag for btrfs-progs too.
> The subject is also no longer up to date too.
> 
> s/benifit/benefit/
> 
> Otherwise looks good, thanks
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks. Fixed them in v3.
-Anand.

> 
> 
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v2: Include the necessary btrfs-progs patch.
>>
>>   tests/btrfs/249 | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/btrfs/249 b/tests/btrfs/249
>> index 7cc4996e387b..06cc444b5d7a 100755
>> --- a/tests/btrfs/249
>> +++ b/tests/btrfs/249
>> @@ -12,9 +12,6 @@
>>   #  Create a sprout filesystem (an rw device on top of a seed device)
>>   #  Dump 'btrfs filesystem usage', check it didn't fail
>>   #
>> -# Tests btrfs-progs bug fixed by the kernel patch and a btrfs-prog patch
>> -#   btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
>> -#   btrfs-progs: read fsid from the sysfs in device_is_seed
>>
>>   . ./common/preamble
>>   _begin_fstest auto quick seed volume
>> @@ -29,6 +26,10 @@ _supported_fs btrfs
>>   _require_scratch_dev_pool 3
>>   _require_command "$WIPEFS_PROG" wipefs
>>   _require_btrfs_forget_or_module_loadable
>> +_wants_kernel_commit a26d60dedf9a \
>> +       "btrfs: sysfs: add devinfo/fsid to retrieve actual fsid from the device"
>> +_fixed_by_git_commit btrfs-progs xxxxxxxxxxxx \
>> +       "btrfs-progs: read fsid from the sysfs in device_is_seed"
>>
>>   _scratch_dev_pool_get 2
>>   # use the scratch devices as seed devices
>> --
>> 2.31.1
>>

