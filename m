Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E67E708EB9
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 May 2023 06:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjESEPv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 May 2023 00:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjESEPt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 May 2023 00:15:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9678D10DF
        for <linux-btrfs@vger.kernel.org>; Thu, 18 May 2023 21:15:48 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IIxZsY012449;
        Fri, 19 May 2023 04:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=s/k5vdzrDHLCppI+cA/qi+bU7/5Un88IHInogjtBm8c=;
 b=azjVfaj0fdZfaNFzEp34lQGyzmR3cTobdPwPZr1u9kI3sb5SMXDNjIfAuTRgxhfCdElt
 5Bohl0M6nabCc5maB7HJ5AL4nl43g1FxxVzPNiiuLAF9MHWQAGd2NHD3bQ5rwjEiPTz6
 g+1IxKPuaTriL6AiNjBUrLNzAVTJkc9N8ebH7RHttKVMHeV0XaXNK7Lxehi0DGK9lzHU
 DycvR7ctISIm7MjaEYDw3U5u5PdJCQpITc8vLEaPpOV3uM4RX5weLDBxroRurLs/vf7I
 x7GQ7I4EdyqNJwjXqffnwTWEGGef93jilVQwo2HUrX90SuQsyr3g3cxdoMBTbrMm3NNV uQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxfc419p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 04:15:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34J2V8AM004207;
        Fri, 19 May 2023 04:15:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10dwsuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 04:15:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lb6JWUMwy/wJlA5xaRbFWCPB9Z9oSBLzDIY/I/uS/Rg6fPxXcxsY1fkpId7NTw0Xh078EPp2qUC5ckrmy3MKK+3OSQmrOVaiDhyKLSX46i3vJmexvQmRp5EbGBUe2QZj9Wlya3oSjD2fKPTYEszg0ZsTZpmMMar1S/NwLf2FgzT5xqk/+1jOFadrP7rhhhZNm3tvv+8C1fNOmz35bLo9A0OlacMfZDNBptsPnNBeMuX5fYFSPa30Znqvm0js4si2ZBKezI5OzEaPj4dm3JigW8285BMeVfg4nc6aNCt1aOif3wLme0DcnNS7TlKR3soSgB9mnd5GEiphY0vf8DcVaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/k5vdzrDHLCppI+cA/qi+bU7/5Un88IHInogjtBm8c=;
 b=koT2ELPI4jK7Poc+6gd7gdXdW1n8oEuLM1AOOrvmCuj+w0uCfdJQi3CkH2hfzhTgJUB6+Hg7Kdj6QKpPgyoKuDVUjC2E/8YJIbd/vi3aezGsBlVGovpVVBycY8WY9B899FAKFdhNXLmDxGPLpWOwpj+9Siq+lXWjawTB44Gl00XdcuhOksISRaeWXpBmkcaaIpcFSSRCR4MLsBShy8FrQdmz66TcUTPUst99TmZBlUUnzSx71Os89H06in9BBwNxHToJlVOphySZB3Y1Zoky0okaCevRAOuNZ0ubL4RgghzkTkYsrd+VxN+vPpxBFA/As2OMMmK2YAuDUreP5df7Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/k5vdzrDHLCppI+cA/qi+bU7/5Un88IHInogjtBm8c=;
 b=pQLbixzM4x8F0mkpjoIO5Qq/L+0qoJ88zkVQOZK6L6h5o0xDrWm8LOFLj0kHNW9pjRS4wvoCD0EONZbt/Vbf62cpk4zeM3v58ilgbG1NiIGplthGn7YQbIJvShAoeSD/v71in8JvrmHaJwv1M16CrpPFk/e8XMfK/6IINOrBc1w=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6276.namprd10.prod.outlook.com (2603:10b6:510:210::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 04:15:36 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.017; Fri, 19 May 2023
 04:15:36 +0000
Message-ID: <f392e41f-94ce-3a49-539c-df921b4f0927@oracle.com>
Date:   Fri, 19 May 2023 12:15:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 5/5] btrfs: change for_rename argument of
 btrfs_record_unlink_dir() to bool
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1684320689.git.fdmanana@suse.com>
 <60e43369efe0f27481d5e2fc6ca1ccc2df64a3f9.1684320689.git.fdmanana@suse.com>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <60e43369efe0f27481d5e2fc6ca1ccc2df64a3f9.1684320689.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0034.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::21)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6276:EE_
X-MS-Office365-Filtering-Correlation-Id: d821264f-b7a7-4cd1-6b5f-08db581fb1f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8R6HZk+yIkn9irwNBAQYNUV/4orEeq235BxDFgk6kRZ2ZSOzZ1C020fiYlvYgQFfEsEG5FPsKtzQV9Wh4CFPiSnh41imJERNvZ+sArcu0B9O5DAUdMPxXZl/AYiJUS50tx1lqmflCVY8qZcgpALxLVkr1AWSXBrgbrPqmLnD1G/8ZPhJtcEaU44OxAIXS/H1SJHA1p5xq6y+JPgcgxo9PW7n3JNfXPBpvwuZH4T0B06Y8CnGF6kQ0IjIjK5xXeUk3bihl77of/CNT/yYMPL/y596PLDCEZi5unZEeVHz0sdjAyzfJyytv0VJ0DvrCQnDniwp13B5PSUVEuxuxf+1RC+Ol4p/BH8uZOHJb2bS/W09ZcfxB1ug2ti9Bd5ULtwiEHfdjqKqyzxf6RI9L/OwhmbhNzQp2OVjbLZHxkmBe/LDXt1LnjD9KyyhkNIET6V16ShriIJIyBipFjV5z25+LeB/wRCt+4KeI/D+0yWHcwQMHfTO3ZIP0bcfQtsfr/4Z+nGhaM9szW/4ImGQn7E5hPFoevVg+YH88lgugJ8kdwry6YF5jMqfKnq98qvRgYZBQRm5jG1uGh17ZJTKSnvxBLpCKhvdfzi1zlEI+p0otO1yW3O2DhTA0vYIyKPg1Qj4scFi2BUCgHo2uTnL1RcFUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199021)(36756003)(31696002)(86362001)(316002)(66946007)(66556008)(66476007)(478600001)(6486002)(6666004)(8936002)(8676002)(5660300002)(41300700001)(4744005)(2906002)(44832011)(38100700002)(2616005)(6512007)(6506007)(26005)(186003)(53546011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzRQdzdCU1ZUNkxQWkdyN0VqcSsxNEJIU0Fhb0F3OHJUMFhFa1RIS1BLNmNM?=
 =?utf-8?B?MnhYdmlsWHNaWE1KVzJpdDJ4YlZhQVU3S1NVWWNuYUVzNm0veUJqTXV2bXll?=
 =?utf-8?B?RjNFVnpGazhkaFlVdXhITzVZMjlwclFhWlVXY1BkM1J4VmNrZFN6djAzMmdB?=
 =?utf-8?B?UXl4dGVldkZjQWZhenU0MUVoWjA2cFMvTUV1SUlKSGpPY1JGK3g2aGFQOGxW?=
 =?utf-8?B?dUhTMWRNTlVMN2duZkN0Zm9xS2FtcTRmbWkrbEg4eFNtVjVITWNXTDhxNXo0?=
 =?utf-8?B?OEFlck1MZXNuZ0dMQ1lZUFdnb2JQVlY3cGk2U3ZETEUwQklrOWliekZKYVBj?=
 =?utf-8?B?SVl1VFNWNmJRbkVuN0RsVG8ycDRlNFIvbjA2dldIell2SUFES0xHVzZMd2F4?=
 =?utf-8?B?Sk9uaFZtZjRnNGowTHAweGhzTDlWU2VzNytDNzE5VHpWUkI0enNHS2dKOXlW?=
 =?utf-8?B?MTkyZHJvSUlFQlJJT05KaStHdzFtSExFSEZNaHlvVEJhT0VQcFlXR1hMK2Jr?=
 =?utf-8?B?aGUwaHF5SjVmV3c2aXdQdmU0WXZ3VFJhdUJXZ0dGZFpsT3dzLzlDcEM2NlU4?=
 =?utf-8?B?OWExa25NS2dZcXdNK3pkNG9JOHdXZ1hVaTFiMGZ2bkRmeTQrV3hvQ1F5Sm9x?=
 =?utf-8?B?bE92SWVZSG5nbGpib25oY3dwa1BxUGYrcFRkMVp1eE53UDNWZFdUSEpTUVZy?=
 =?utf-8?B?S0o0WWxjczVsT2VrdWNqMUcrQ2pwVENjUWVZTmFvT1RrYVBmV2Z4cWJNc3Ju?=
 =?utf-8?B?enBDREJVZjl4SG92NEl0YmZ1dGNueEdySTJxRDQ1eHBxbUZkQ3pIMkRBZXJU?=
 =?utf-8?B?ZzVuM2ZuUVlSaXFLeldOZTYxLzZ3NGVVcFlsckk3ZUNnVllNSHRwQ1NiTkRj?=
 =?utf-8?B?RlR4cTErR2wveVRGV0Y3NHVQWnhsNkNBY1VvWVVlZk5CZGVWOVNJTWpEaGJ6?=
 =?utf-8?B?b1VwZUZDMjVER09kUVN1V0lSR0NUMTdDRGJKeUFIYUlIT1VFWmxFWTNhMzZz?=
 =?utf-8?B?MnpGWXJCUmJHMlpVcVd6Q0NubDJBL3RZUEduZHNaTGE4eGpOazBuK3FuM3lx?=
 =?utf-8?B?WGlsZjZRWmRMWkp3dnNGdzdpRGt4Wmw0VGZIQ0h2RzVwV2xsVzRuTmNIN1Nn?=
 =?utf-8?B?U3B6cEZHNzFxdW5OcU1HZEwvSEE0eTlUNVpWVndVWlJoK2VjVGZheHhFekFQ?=
 =?utf-8?B?bnl6a05wdmVtNGxGRHZwT3V5R3BXcjArbkY4QkRCbmd3M0l5UzZaMFRCSlUr?=
 =?utf-8?B?VFpYeVFBNitROW9QV1V2OE5EUHhxT2tXVjVGTjJsY2M5TnBHRVJsd05SL2Y0?=
 =?utf-8?B?ZWFhQWNqbkhObjg5Q0dBaWkrSTdYd09jcHJlSDcrZytrdENuS3FCOHc5dG44?=
 =?utf-8?B?TDJEYkxwUHBoODd6S0Uzc1drSHdMKzBMRXZrMEJRbU5ocTBQTVkzM1pWTnJq?=
 =?utf-8?B?SHpLSUZ0V1hDa3hHczBUeFpvb3B1ZkV6bzBTalN4SzQ0YnFGZ3EyTDdRamR6?=
 =?utf-8?B?eFhTOE4vZ2g1Uy9HQ0xCR0NQc0R4NGhpVi9vUEs1ditZUGJlbjAvZXE4elp0?=
 =?utf-8?B?a2dCSDRjWkpLUllRL3o0MEc3QkcwdHo5OG1iU3luZ295d0VIOFdKUHlUSXdt?=
 =?utf-8?B?LzR1L2d0ZGNudVpMUHZpdzR1QTdydCtDNVNMcER3bzhIUEhGMHNsZkszbERU?=
 =?utf-8?B?VTMrR3ZzUThDUHM0UVZ4SWcyWGdxbUwrVGt4VER3akdWNXZpazJNYUszMWIr?=
 =?utf-8?B?UWpyMDdlczFmUDlBSGF4eiszQ2pxRkZZeUlTTTlQaHdRWHd0RDIwNjFHQ2Nq?=
 =?utf-8?B?eGVVTzdCMU9OZXZON29COTZSQ1FFeXhuUWN0Z05Makd3K3RzakdXS1BJb2Jo?=
 =?utf-8?B?SWRQUDhYdlZLYjhPdUNra1U4eENtMlhjM2ZMK3VXYUhJTHNZb3grcUNvdmhZ?=
 =?utf-8?B?ekl4bUxsY09qeEhKYkhPNmRINjNmVE5WUEtCbitCbitlRmx4MVdhYTg2ZWZs?=
 =?utf-8?B?dlJtRlE5dXdCOWxvWlkycUdSNVlERDBYRHRiTjFITjVacmpGM251emRhbndN?=
 =?utf-8?B?MVptTlA1bHBORHBTZzIzQXZ1eVJXSVlIR1FPeW1NUDgySXBKRW40YXZBMlo1?=
 =?utf-8?Q?xYMiQkZnNnWfG7/X5PlvKO6X2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WVw5WTVkcvKOQ2DLumdx6fFhAsvrq3sMLQiFIrKVastt1UT7SWQq8qnMKVqc69wxuVpXYisZxUoPfQok/klJKBzVzZb6SW/9hyi6UfDxG8FVzy5JOFLq4ABQBX60q/GC3I35FuAgENaFALBJgCtcTfQY2L2sP3LBrtTftZk6hLQw+JqBJSaGOr0RRqKnFQheWPQYJVgXWPrCawMT2SzP+oZvqyZAOqEVqat4niD5Q04uT7HmWPEmKNpMBhjGaSdh9jenzSdPVaYibhQ4k8/hrmp810CS5a/aFZARST2IilgpeJT3ihaSglQdUsi0x4zfqQDXfhH0rzWEitDcveZQtHfyoDd7Py6rIh3lQcVTGzgrRtyjcX03mB4QXwJN6K6GwMambvvL1BYKJri4pUoLOQY6LgsyJem6ZVdfF4iII7LH2HYfptrCtmLqfQjmkDx2D+QBIReeAw24WypYFsrixklnyLYbdjFcQPx++hFn+I0qK0tzWvpKr/k8AYeT5c/QruA4tnVw+96GjDc81UVb73ywYBVS2SOh49p7mDjP7EHamvKaxUNdD1JL4LU/Q34HeGwQNRGJ52/2w0MgLW5hXfeqYL7lIY7VonGBQD2Jum7RE1RW9H9Ib2RvPL0cEEvIAw8Fi3bEtbZJ8QDnHfTOOrm3gsYodq06sXnBqTlf4QprfueQfgMSXhoLCaFNbW0E83h8yNMlfp7C5qYgO84b3hNPH3BovmwNOS0PRJq7crEC8ZgehDYL9z9kRtjUaftvl9CeRkON/RiFzcgGvM4+IU+fL5D5l5BOPch3tdsRa1g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d821264f-b7a7-4cd1-6b5f-08db581fb1f9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 04:15:36.1883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0FXso8/WtmziYBRUNLnioPe6FlHobK68J8FdqDArn7CKUleTnahBIA/xNLaKi3qhicBio046vjD6LD6FSbwepw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6276
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_01,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190035
X-Proofpoint-GUID: efk1oGvIQjbbmIFdKwmshvIKYQ8bX3PA
X-Proofpoint-ORIG-GUID: efk1oGvIQjbbmIFdKwmshvIKYQ8bX3PA
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/5/23 19:02, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The for_rename argument of btrfs_record_unlink_dir() is defined as an
> integer, but the argument is in fact used as a boolean. So change it to
> a boolean to make its use more clear.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

