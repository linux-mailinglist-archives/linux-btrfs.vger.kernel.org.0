Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FD462E5B4
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Nov 2022 21:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbiKQURP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Nov 2022 15:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbiKQURO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Nov 2022 15:17:14 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA6A7FC1F
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Nov 2022 12:17:13 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHKB5Lm028097;
        Thu, 17 Nov 2022 20:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=FHMu9+Z7S00zuHkyLFusWAIMNimLD4DrvMjlizdGyH8=;
 b=PC00SbwsQ4fS4bGfTCxx+hFc2rD+SpHWqFWVL7AH1uiaaoI31Ym2phN6gDbeL60NTlHs
 UaQ7v+XSxvLbYjKzQiM0Vvr8qJ4DL/kDLimMgPQnGCA4aCP5hoNeCS9SgUkyCeVPdgGd
 41XD7R/PYLn23/JPSS+aBu0NqG/gf85idE9/jLprlmC2UESIWutogOxaqtq72lVM1uGY
 DkniDZcDJh6wLU8uJ90Xwy0XWoaJBYs+cxl7ZZ0YQvzcIM82ydlXWazuLN0757Vg/1qx
 NN1irW0DAD34hNAtrJ1K9zcjfjujmNXOpyD3cG9DKXqPLj8+eIsqvVofciHKvivxFRBq wA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kwrt6rmc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 20:17:09 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHIwJqU010756;
        Thu, 17 Nov 2022 20:17:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1x9kksy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 20:17:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEro7OoPv0X8I+ddhR8R3asALk3PQ5TMdC10+zVGyP2a0+JawKgfsrfRtlGj17CD4Sk6Z6I8afIBmdUjkHLhM0BLStXICYf7lebz6QjLDJeL4OXud7JiCdNlRkj6l94G5pVzO3gVykc5aKaxesPvdkHuN5mPHfeYtOurliP37AZixQgG9GoZICbQ00XShnnUAqwso2THXhUU1ipf8J/1Fx8238riIuBzij1GsgKPLdfrMbObGFZlTf34Vxo/DkY17S4OZZXOnMbOo5qh5m946eJG3hLFySnUxTiqAK3eh3DL9HNgywcgZTs6/QWK4kjHw51s1eii2o8YjbYiytul8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHMu9+Z7S00zuHkyLFusWAIMNimLD4DrvMjlizdGyH8=;
 b=aP5op1X65lKoLEoEUnxY8PauqBuL+CWayDLYFncr/gMgPvBw0vuPaLMD5K2UBpNJL6U4pVXPH0RvZd6QKUBE118xi/yMQ3NMt5DSsZwjJZ25Z1ptLLvNQrgUZiYURcgagvyfeHKXQWaGpX84H7lGejTIyirqz0dPNR29n/vaWWdfXxQOhx/TFfotD0bicLUR2V6QBB74qhjxHrGFtVZW0Pc2/lVxwlZsC8Lq6DAJOVjxtTd7WEgh7Rl/PbyXY1RqTRYicwA6UUwT9v2wy/UAK83EeJTXTVh+9tpXtGxI8n6ZJZJe0aUZguLcY90DHeCZ8V1+KPo6TsiO2m98s+tRXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHMu9+Z7S00zuHkyLFusWAIMNimLD4DrvMjlizdGyH8=;
 b=A3g5qv0NCoPLd7cOIyeF14RUIDXw1V/lUlq6q4+iMLPG4gg7PiQKlhO2M8icnsc446lditeY1I/OyKzswhEuKdg9UMp0jBJXisyqNEXNclhuJBZZE+68j9L0XUxJUvgSdRXP0v/453gFEJHWNvrIb50tgxPabNH1AOVzhok9Jag=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB5900.namprd10.prod.outlook.com (2603:10b6:208:3d4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Thu, 17 Nov
 2022 20:17:06 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65%7]) with mapi id 15.20.5813.013; Thu, 17 Nov 2022
 20:17:06 +0000
Message-ID: <62ad323d-2199-4c79-b2b7-c8e9f4595255@oracle.com>
Date:   Fri, 18 Nov 2022 04:16:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH v2 1/4] btrfs: use ffe_ctl in btrfs allocator tracepoints
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1668626092.git.boris@bur.io>
 <ef44014bc0c5599a0cc7034d9912a4151e3c8e3b.1668626092.git.boris@bur.io>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <ef44014bc0c5599a0cc7034d9912a4151e3c8e3b.1668626092.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: 847270c8-f79b-4c5d-6bcf-08dac8d8b261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nFSQMf/CunJ3X7vzpn3dCfzxDY2gqhyCHpo0TkFFssH2XGR1PGpzqfHAC7AtAszQaHXwBG95eve/9GWSVureDggGmL5XovQlQrZUUvRDYyWvmzMUt2F9svz5+SnnnaH0rkrMuQN6h0AsLY2tMiZvdHvq37Imy9pAhNobWStc+uYtgaTtvA4A8OIc3TdFGN5GxVgCIJVy7uqUApTiu5v+Tvpq2153xmhi2kEsXb8FfR8bSRPV39D1CoCaeDZ8jT8UqbawyHFMSDPPa//+Yak7BdnABXIGFUTrSqCpOT+tthvXeLq9p5rm9hCZOHXmK3fCq+lDgyUAn5e4AwSFpZgQbWA4pk8XUawXIArgCzT+8FywbBXnmjyuKKtR5rNbAJ4brsEhbmcvSuuFtqUeaGVsvfWMcaZdBDYWSDhhnqu5DorWrwJAJEElBNtneXrlB6ohh0D16yrLlRzffJu0SYCCA2IgE4LtsRHjo0VS7JuvlTnSB4lMpX8j87gnrdYjeoJNJG+r/KgqwMe3zFMTVt27pivez/zGvTA5SOjQrTtNfDb1R5ICJOdS/3MgNNsVW6Mdj9jJM8OuBX3k0T2mytL2I0ESGCukHQxrmFKzlDD/ldkhCtcl+Mj8aon6/ti6w3IDKpgU7PnmTgMvpN/8SmQcO2h9ycZdfZbZXZfk2t9ShPOo2IrGkuAd+bUzM1ITt+OV5dL8tdMZPqZTg09W5fU+QwKOSL0Dm8sKT32ghnBM1rY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199015)(316002)(66556008)(66946007)(478600001)(66476007)(6666004)(31686004)(6486002)(41300700001)(2616005)(53546011)(44832011)(26005)(6512007)(8676002)(186003)(6506007)(36756003)(5660300002)(8936002)(38100700002)(2906002)(31696002)(4744005)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE1uZGVQWjAzN21TNGNMUE1qN09zN3R2SGFHck1zZGtCUVJrZGVtV3hjUkwr?=
 =?utf-8?B?c3RmbFd2YU9EOERNS25yU1c3YTdHU25JUmdRUTd0L2xGamNJd2FYeVZ4TTFv?=
 =?utf-8?B?Vm8yR0E1UFdrZ2wwbzNrUXJKaVdleVgwL0xZVDVoUkFJQVNjbktveUtmZEJ1?=
 =?utf-8?B?UmgyaGpWZWNVSllQVFEzOVo2ZTRhQXJBOWRlVmEvVXplVU1ETVljME9CY2U3?=
 =?utf-8?B?bU50eXBqTXlEQy81WXZIMFFkVlRwK1U5cmxHNS9mekIzUm8yanJrN2NpR1pW?=
 =?utf-8?B?TmlRcVYxWi92N0NSWVM4TmxVQXJqelBYOW5xenRudEZwZ0IxRWZBS2pqRy9i?=
 =?utf-8?B?amxSOU1nQXFTdU9BY1IwUWp5cldjUGU4cUl1UGFOMjRsT3lpVFRoMzY5VmIr?=
 =?utf-8?B?VENEK0Q4R0xVM3ZHbHhaSnQwY2V2SGhWajh2OGxyNUZ1aFA0a2xRcThLcjFr?=
 =?utf-8?B?c3hPWGRFV0psK0FvdEc1RU5FQzZKRGNnQ0hXdUlzUzAyeVZ2WDRTdUcybytK?=
 =?utf-8?B?VVJQWWlpUHIwUlpEaTZHM1VTdnl1ZHNwWFlUQW8rSWg1RWFKdEtUV1lTVldh?=
 =?utf-8?B?YzNKZzlhand1Q2VvZHY4bitsU2hwT1poZWtFclB3NzIzNEZsdDFScUVXdWQ4?=
 =?utf-8?B?bFJLYVRXK3FMVmRVMC9uQlQ2cGpqYWlwVEVyOTBnTS8yRlh5VXhaU3FXejhU?=
 =?utf-8?B?M1lFL1FzZU1FYkxVUmh3dm9XbWNnT0VxazBXNEJ5WmNtSUVCZllqK3d6RE9s?=
 =?utf-8?B?TmI1REk2ajU3MUViWDFDbmJqM0pyNzlWYmFIY3UrS1lzR0VpdEZQY1pHaXRL?=
 =?utf-8?B?WnFVU1p4L2R1cEVUSXRLVW9EaUlwdmVUOWpRQVg0WEx0N1N3eDJ0ak85R3dX?=
 =?utf-8?B?b1FxL1lBdUc0ZmhuTFhYUjlKa1REWFQ4dXo5dm5TeGFZWDFiR25LSm42dnM0?=
 =?utf-8?B?Zno3a0o2d2wvVFVVYUI0QWhOZ0N4UHk3RGVQV2plTDQ4NDZUR3F4TFMwa1ZH?=
 =?utf-8?B?ZWVhZjdWLy9zLy82bTBHVGNJclZmdFNSS1FkVnVaU1ZZWnNhMmNRY09OK2t5?=
 =?utf-8?B?b2IzcGFwZnRiWVkydy8xRndUQXRnbDBxMmJERWZ4Zmcza0xhRVpqbll3eElt?=
 =?utf-8?B?Yzc3dDQ0dzRYcXZkckZ0T0ZQWVo4V0RuZXJ1QW9pWk83ZDRFWVR4WUZKT0pN?=
 =?utf-8?B?d0R1ME8vbTNEcHBuWVNqMFZQYVRYOExNdktXWG9OY1IwVmsraVJUV3YzaTRw?=
 =?utf-8?B?bnArRmtvenVsTzYxZDkycG5BRkkxZWlxSU44TWtWSkhOblRhODZ1eFB4cHZi?=
 =?utf-8?B?aFM3WlY2Q0dSdkphMUFiTUN2bUJqekd3aHFpdnBTQWtCWkFQU0ptR2pLeGlw?=
 =?utf-8?B?M0dCQW5DUTVCbDZqSU9iWnlvRWZwYzdtenA4Zmx4TUxMRVREc0Q1REVqM1NW?=
 =?utf-8?B?TkFVanlkZllic1BpUlRjYU1IdHE1MFRTOW9xQTErUVA0K0kzWVBHT0REQk1V?=
 =?utf-8?B?MnVCZ1pTRE9HdVdaUVExc0piWXovYlVBRWtSUXBtTjZnMFludldQTWcyNkdU?=
 =?utf-8?B?WkdkcjR3SkRVMEFNeGtiNFhScTAvaUVmNmduK1N4c1NrTkZSK0tCUmQvY1gv?=
 =?utf-8?B?MXd1U05DaHMzajhYRXcvYXBjM0tZUFkwWENaME1aZ3hHOCtocWhDKzlqd213?=
 =?utf-8?B?N2E1clRZMmdyRnJWcVVFdG84TU5vcjdQNDdaaHAwTEJaU0F5c1ZjZWhQM1dv?=
 =?utf-8?B?SnY1QTl6OUpGaExKa2VQZHBrejVlWDlJNUx0aVVKK0xubkdRQXBKaVd3NVJH?=
 =?utf-8?B?SDI0MVpiVm56Q1MzU0QxWWJnK2VNeXk4OGlYMTRLS1JMS0xiaDk4QXdRZ2ZH?=
 =?utf-8?B?emZHQWtXYUt0VTJUcitpbldiWXVNTzZOOWJENVlMd001R0VvL2VEUk1oTzJ0?=
 =?utf-8?B?dGg1TlBVc0JTc3Bkd2xvM3pjTy92bjhVbkh1K0ZoV1k2cUs2RU54Y1N6MWpZ?=
 =?utf-8?B?azBWcUw2U084WjAwaEUrZGw0a3FGVFJtdVRTaVg2dEhWWTNQa1pGemRFdnZy?=
 =?utf-8?B?Q0F3YzRrd3dJRUpyS3RnNEZWTFRFNHl1NllvZUZOeVRjMnRBdEtQMkhmWERQ?=
 =?utf-8?Q?O6yU8mGlgjY+MDTmV3ACjcptE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xvqmBb5ZElPufl65o+GJNKC9xnIClR8VvZlCOeEppRrf+gL7k+L9vC2mxjuHHsYnfScElFNiAWnMHytyT0u4LnEF69yQyc1TyhUoyDixh1BjiuIbyKRqzXHnrTtQVpuhmDSY4+YYs/EkCw88n3rXJkpiv5CluWAl2zFAMwov5FJ79Obl29drB5hIO/JMOEI26TucQIBgRcsT8NzKtAEFNQdpx8dJoiSDKabItYfe4dxib8miRvvpKuU1iwSEXWxNEMaDT7YXVNNuwF4KdVGvpONvam18xYzUGZBeRvmXwx+9YNV1SGAouL1zQ2m5aNpvl2dKLqv8w+dvawvat3752OuZkFoM4Eo7YYgwb9NDoaA0GLP/8UCjJnQfqPwAgvRvc1uHTB9+sIH8Ui/NopJEeBLU92ewNShHI7mIgcIRhmCsoIJLG1a+4BKtTVRJPhA30IJ1AvX2uCHT5fpQ+k5g7OhjCVIjwFlUcfkKQ2IhYaaSwCqC3H/q/3NzpFwwO/WpYXm7OJb+uI4FiZ0t2IQAISe+LEVIZnQwb4xVwUoGuFpgPtMwDTdkzXR8yZrgqMIYuu2eSRg1hsp1bOg844eoxfAybdrf+hIhgvB6BU9iu5mYv3FKpSyytJ6u/uIs8qAqYm/6Tk7VtfAb+iZywNI+UUWzIVNJY7snLFjxf5AFR9lpzv4AszA/ulPlC0qUzNVJqlxB3KfntSjZmYEMa/eQfPcH8j7iQg+EX5MSOMTzM6RSsw6Pj//QrcMSul1jT/zDbHCFxlL3gn/O2xLPF7/ZlHp8kkA38Z7E7vS32CKQVIM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 847270c8-f79b-4c5d-6bcf-08dac8d8b261
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 20:17:06.2253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fdubxGhnTLJHNWOnNhitaNE2+UuBKVSJtFj14oifybDUNLyFrVRO/LvuAK2kf3eSUBSb0NXWY2It/RvkpGBF7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5900
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170146
X-Proofpoint-ORIG-GUID: Op21_g4coELs-nBuOFcyN49A6wUuxKfm
X-Proofpoint-GUID: Op21_g4coELs-nBuOFcyN49A6wUuxKfm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/17/22 03:22, Boris Burkov wrote:
> The allocator tracepoints currently have a pile of values from ffe_ctl.
> In modifying the allocator and adding more tracepoints, I found myself
> adding to the already long argument list of the tracepoints. It makes it
> a lot simpler to just send in the ffe_ctl itself.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Anand Jain <anand.jain@oracle.com>


