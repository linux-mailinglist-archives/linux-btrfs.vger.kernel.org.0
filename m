Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4686FC4EB
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 13:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbjEILY3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 07:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbjEILYX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 07:24:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A86683C8;
        Tue,  9 May 2023 04:23:54 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34972VZJ018850;
        Tue, 9 May 2023 11:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : references : cc : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=rUcd8OMZ8gD+sflEy+dt1jODXAxlL9LoHbd0n+kzqAE=;
 b=XWuxCzWGjl0Igdv0OYgh3JM1DRP2zzC0XpX8s6Zuew+YwD5+ZJGU26y5k9oACiW+hQPV
 DHhsY6rfzZ6jpnsM51asW2AbohqAGAPY3qOz1E1Yd+LlminTFXoQJtkSEtFPrwuL+HUF
 HZYhbNooAxWioEDGbL9dVoNR6qCYAE7NivNPCmtx6PuFBjrIm4ob2TWEXe0kJGPMD0Da
 91hADbjJLj54AZmEMYZ6LQfjA2IQYXPxzdTFfXXzaLRm9pOR22wwy1+2eb1RVUtzg4qw
 dRWODJIl+kmUhWIwyU2I8Em6isY5cZpKv6dMoiyd0YASf0eyJuu71Yq4HATwT1SoxQD7 /g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf7771gt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 May 2023 11:23:51 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 349AmlUO005827;
        Tue, 9 May 2023 11:23:46 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf7ph1ytx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 May 2023 11:23:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bezsYgde0dHw0dclg+/V1qZ/kMAknSsoIa378EBO3XhzBBj6k7rm0e6FNqDHQRxHcZcqf046sGrZ1jkyQvi65+1Q8ZkBeiXcEleFoyoONy00AnSbMKJCCqsjbx282jKhVeJuQgcKGcSXeEPTg4b2O2CRifuOLwH4kBusd1Pd1xC5EE5Dwf+P13nc9xREgLma2kMt8PfRLw+c+Enki59JsZtTT378wx+G9HwrpKzau3WQ5rvg7quJDeqRQYJKaWdzd45Rsu2fxV2soi2CVzyuwT5asmdDzULGUmsvnKhvFG2bm1zNKPOKjXfJnq5CvC9VKghBRyOaMK6u5XERZ9+baA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUcd8OMZ8gD+sflEy+dt1jODXAxlL9LoHbd0n+kzqAE=;
 b=ZLva4PhPEvWTYAKGUgLXQaWHZNhFyRJ4ufnQtbLDLFUNaxQ6j6GWiNOimpB2li/r/DXQUDNaMY31wpW/2Oxwv5nCUK/K1jIjnUgRlvljjXa+Fn12hnNdcTQh3aqnwHQV77jO+2or6Vf1PXdgUjWO0ZsfdDJ7rZ5IWfZLQQzaUrO4CEibWLVpJpE7GC6O0jeqSggvKrq6r3Ya6ObaHY0xOiZ3iZ+TMTgsT+RaRJ7NV19c2BrP9IG+nLGNk5SxWLVaEhW2nE3x2i+dZJswLtG45d/cB6XSdaGfd7zSuXPKPik7+XUZpsosNI6MXdRPw7ptsiP+oY3UIKng9S3BdgzAJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUcd8OMZ8gD+sflEy+dt1jODXAxlL9LoHbd0n+kzqAE=;
 b=yPRjSK/SiaMEXrcHdUBlfEVGpEQxjEjhsv/JbIac2biBy8JVIt+Irlt+9Gom38s8HJULPay6wfhA4pvgtHPqGGEbfq/eqrqF4IdkyXwhe81q2BJCnmHZJuRHWgBnw6stV1VdsOBctVUYd2WEQKg2XpIDeMo8or1Lv3H0RBH24T0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB4818.namprd10.prod.outlook.com (2603:10b6:208:30e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Tue, 9 May
 2023 11:23:17 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 11:23:17 +0000
Message-ID: <cda983c3-f407-9bda-c571-c9e96b7557b5@oracle.com>
Date:   Tue, 9 May 2023 19:23:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH] btrfs: add a test case to verify that per-fs features
 directory gets updated
To:     fstests@vger.kernel.org, Qu Wenruo <wqu@suse.com>
References: <20230113070653.44512-1-wqu@suse.com>
Content-Language: en-US
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <20230113070653.44512-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB4818:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a8e0782-f299-4ce3-9097-08db507fc919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zcFv2MDGumhZEerCaakQRAS0s36L4j7l5jzLCGhYN+q/0zGVRmUcBFH8M9W3q4EEG79KWk/CQRZOuG30stEFgLrHNVVE0q77jPYcanK6mdxZYHelG33C38+QJX1q8n9aS7ioNqk8D7A9hbjp08FUjbA1btrDBnxIs5H1CYB4cMM5VXDCBtxJ69wPi0cWEYu4VqtS/30H/u4haN/fe0wyIkeCIOdcUDmvE2hy6d8LZObJgYV028r+J3ZwPXwawuFYiTbsl55pPEKVybLoSUPxAGTDJDyTwYo/nzxOclWikITzx/Rn2kUgzC7TPly9lbaa2wrSbQHXhfOcX97D/wknYuzI89iqdjibiXctBFv0TJ24MkVCcZFi4m3bjyVanU7iQDXYgbxUytZGpMw68Q7oc6lgRCaFpvfM21hqL9UXLkJ+fWImHstfulw5AFJBo6xeVVu0cvWtJ9SYvukIsg1A855buNuFlCIGgep/mIU/PEJ4E2+w/i9/skV6965H0RV0abOVVRHAxIFbUQmctxQ/b3TxtzmzVCh8ThO/QgFONS7N2r4p88xWv1fFn+TT9DaruHOg5RxGdRKAwuKWsYhBfyVjv8LSIpV2sbTDS7TK5CPXcaulmA2L1doz0u0lazROINmYeuyft+2h4VHw+RKHBPeyqsIyXExScN6dz+yubJObcoxRR1qdDlJUHfzTgJ4pbpa9cN2UKgnDLY+tfQ8ytQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199021)(2616005)(8676002)(8936002)(53546011)(6512007)(6506007)(38100700002)(26005)(478600001)(44832011)(15650500001)(36756003)(5660300002)(186003)(2906002)(66946007)(66556008)(66476007)(6916009)(4326008)(83380400001)(6486002)(316002)(31686004)(86362001)(31696002)(6666004)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzFKNkxVbHF3dC9OYUxYNS85WHFMK0lpd3dCMG0vUTgwTWRzS0VPR0tHVW55?=
 =?utf-8?B?Nnp4SG1vcFNXaFVVNGZGbXQ1ek9KQWsxQUdWdUwwMGpVMHBGNmFCUXdlYzNh?=
 =?utf-8?B?MEVoMHpOUkdza2hCUGJHUnBIK1ptYkkwV05iOWVJVjU3MFZNZ2ZXRkE3eVNo?=
 =?utf-8?B?YmtOQkRsa240UHFRNlJLejBSWDVKUk5WWGdFalRQVHl5SG1PQnVpL3hnanBs?=
 =?utf-8?B?QU54ZVhXeXhxRy92RzJkSE8zN0g1Z2JaU3RWbm52T1dtQlREYjIrSXZwOCtL?=
 =?utf-8?B?UnVGWEJTOXhnQ3VQTE5BNEdPZGlndVFyaUJPSVlOdVlZaEVMb0NsZVdQaC93?=
 =?utf-8?B?a0NxL3pteVN6Mk9EV3BnNmNnNm10QVR1L29jUHVoNGR2R1JtUVFVR1BKaWdG?=
 =?utf-8?B?MFdwOGZveFFGV1JQRmZ2T1hUQ2hIUlBVcXNQZHA4dCtqK3RmRlIxUjZ5bHR5?=
 =?utf-8?B?dnJ0ZnVhU1h0L3g3WnhLVDlJZVZsekw1SDZ3ckFVVkNmaFYxUHdkQ3NGbUNF?=
 =?utf-8?B?TFkxWFRuTlRHWE56TDJrSVVMVFYySW1tQ1oxYlFPbjYzQWVBUGdTa2hoYUlX?=
 =?utf-8?B?K0l0RnpTdzkrRWdMaHQ0YnNFeGVEcDdtc0NHSTA5UndqRGhrWXhpNGhyNlhr?=
 =?utf-8?B?djN6VVNZRkRWek5UWlYvcSt0Wk1PM3FjVGNzeFRXcVhZcFdBQmtCUjhCdHZ4?=
 =?utf-8?B?Z3UxZExDdVptUHl4YWpqVDhUUVVqVmxaT2V1N2o1QVlpNHBaWFh2dUlmbFVv?=
 =?utf-8?B?em1ZclU3RWlheVBoNGx0MS9GNFBwVXBHTUl3bWJFNXdwdVE3S0wxdzYwVXh2?=
 =?utf-8?B?L1djMmhRZXRBZGdEN0VuSDNoaUxibEk4UEx4SGltRG1ZL0U2WmVXQjZ3STJZ?=
 =?utf-8?B?ZlQvSjYzc082N3FCYXE3ZmlKdnBMYkpDdHorRHhhcE1OdTF0RHQ2bHNEaWNB?=
 =?utf-8?B?SE84VktRcno1TVQ1TlExd0tweFdaVFRzRDNsUEk5NzV3ZHJHelJnRzF2clVH?=
 =?utf-8?B?Wm1rek9VUlFpc0RNZmttci9BNFhvaGhrYW0zNnlvRTVJRzhHV0xNWkR4UFoy?=
 =?utf-8?B?OW1xK1RDbUJuRVk2ZXNybkNiM0ZmYzJlTVFHWGkvV25vNHZSYUF2MlFJWGcv?=
 =?utf-8?B?THhoU25HYTh1VEZOb2pGZGFwMzZYbVluVnF0ZHhmRFNMY3ladUJROFBMeUFM?=
 =?utf-8?B?bE1aeTJXOVZmbkFIRjRsTmVhVkwwOWE2SjNJWGJXUmhaMlY4ckVQOVFoQXhk?=
 =?utf-8?B?cG9lVjlGdUVBSlA5bG1Xc29LaDJHMFRENWc3blYrYlZrbDV3T1RQdDVWMFMv?=
 =?utf-8?B?aDZ3aU5VNnp5SFhMdXNUR0ZtRW82TGxaMndBTnVBb3A0OGxYeThBVjg2d3N1?=
 =?utf-8?B?K0FrYjJwdnM0NWRQcVlQVFp2elh0UmpkRTFQSmlIaVdTT3IrajB5SDVORlhy?=
 =?utf-8?B?emZTT1A4eHhSeUxZYS9YN2FQNUFra2FKZW1PRUpSUllPVDlQdGpzYnFpNmY1?=
 =?utf-8?B?aVFHbUpvMUUrYVZueHpSU0xFSVEzQlp2bDNESjBBZEVoaERtQk9aQmhaQW1F?=
 =?utf-8?B?NHBqalZYTy9JLzNnYW9MWnp6NHlxdVVEZlF2Ylk1MUgyQ0w2TCtBMDlGL3Qw?=
 =?utf-8?B?VnFxN1drSy9jRHFTSWVWZzZDVFVQYW1JWmhCakRYTDE3eFFXNGpnSlk1UVpY?=
 =?utf-8?B?MCtFUllYQWRBVzRhM3ZoT2wzWlV1ZEwvRnE4aVdkT2tUYTg1Z0tuZ1hSM2d6?=
 =?utf-8?B?Yk1Md2pFWWIxaW5NTmRDR01vZ2dNZk5mMEpybWg0Y2h3dUhNV2hHVnN3WjhN?=
 =?utf-8?B?Tk0xbC9OSEVmRXRYUzJNMUk3VHhSNDFOWHhXSEZuRTlaQ2tqUG95V2pGYWJ1?=
 =?utf-8?B?RERzN0l5S2poeHpELzI3U1NJRElPUm14b2s1SlhhRUhUMFhpc3ZFQ0tDYTlq?=
 =?utf-8?B?NFlLTjBnWTZxaGl5d3BXRm4yMjBBRGRYU0E2aGZJV25ZYXI0dGt5NUZWbWhT?=
 =?utf-8?B?QVJwdWxUQ2k2OEVwRzgvdlViTk5GVmg5U0s0TnBxSmpOU3dJM1JFQVpPUDB3?=
 =?utf-8?B?THBkRytkVEMzaEZlQUdzM2ozZjdabnB5SDVSdmFtUWoxQjMrR0FDaUU2UVVI?=
 =?utf-8?Q?KxChwm9feLRA4AlvYRSuyqfcQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MDw5oxBaPFDQDm2FQjcf9lVG8pd8hmiAQ3VfmO/RMaCuvUj7keQE62bGB+mgQ4Sj8LBrg+whziH/TE7yGm3nOLyKDsdTMCN2N9o3LiKGonr2IBY7rMyroH774cNHuyCLZA3sD1m30Pr9FEof7en2wpCiqAQM7JXrrGztGYbxml45ElugRqpjkC/tcXWL7YaZDL6tulOjtQ90zYwgOpwHmZVVXmKMMGWVxR2m/iv/iMLfYN6xh+oklDvS4nVd+lrYrJeHuVqip/pFsNb8mlcGb+zuzeP3jTncq6DLd3Uic1Z7xnCezwEQzdKCuPHB3EvhimEwlq5wrH34pDYUrVksW3hJ4KNjdRVkjRHz4/uS9bDkQyhrQ3hjZH7ACBwgYo48af71sDGxPWgJ6QZqUy5Xbha+tAlqXNHG7AXHEzOUh3ss3eAUGLuRRnR5lmiECTslASsnRn15lMtMqd1CSi/D1WbNP2t8NEDQuqNykGhR6ksK2lbzkGjbCoV0h1jHbw5EyTl2JbeYEo470U9KMMq5BTJnrriekwilFvSgE0BWeC3dca7lyPF1zd8sfP5OMrR3Qj8wrrWXWztlBhX+i1Udyf87+oVATI0+mDxL5lVYboaUF3exwSoTRued3ogmPBwe0ym8IPHu/ZNz1EjuCszu7NRXodYrdOauJNiYT2Wc1Tcp90lxycYqjemsdW8TbcJW4mRpvrrDCZv6DW0tc7hM04zWSfsq1M95rTHMzathVzwXDvgD9hKf7yXciI2K7IoGwQKwpCtcg9OIi6UM8jhVRC3Ogjzmu50T0vc3afzeosE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8e0782-f299-4ce3-9097-08db507fc919
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 11:23:17.2265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ttLbIfmDvET1m35TMFYAr51jzUMG7eGncLozaUciAGS/dSQ0ZXhjB1jcIxpKUIa18R3vwnfRyZqk9PV4lSa3Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4818
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_07,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305090091
X-Proofpoint-GUID: Toc2x3EV_RopUJvy9VSkyQlRfxsKTN48
X-Proofpoint-ORIG-GUID: Toc2x3EV_RopUJvy9VSkyQlRfxsKTN48
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


  With the following changes added to the local repo, I am currently 
testing it.

On 13/01/2023 15:06, Qu Wenruo wrote:
> Although btrfs has a per-fs feature directory, it's not properly
> refreshed after new features are enabled.
> 
> We had some attempts to do that properly, like commit 14e46e04958d
> ("btrfs: synchronize incompat feature bits with sysfs files").
> But unfortunately that commit get later reverted as some call sites is
> not safe to update sysfs files.
> 
> Now we have a new patch to properly refresh that per-fs features
> directory, titled "btrfs: update fs features sysfs directory asynchronously".

  Updated the final commit title.

> So it's time to add a test case for it. The test case itself is pretty
> straightforward:
> 
> - Make a very basic 3 disks btrfs
>    Only using the very basic profiles (DUP/SINGLE) so that even older
>    mkfs.btrfs can support.
> 
> - Make sure per-fs features directory doesn't contain "raid1c34" file
> 
> - Balance the metadata to RAID1C3 profile
> 
> - Verify the per-fs features directory contains "raid1c34" feature file
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   tests/btrfs/283     | 73 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/283.out |  2 ++
>   2 files changed, 75 insertions(+)
>   create mode 100755 tests/btrfs/283
>   create mode 100644 tests/btrfs/283.out
> 
> diff --git a/tests/btrfs/283 b/tests/btrfs/283
> new file mode 100755
> index 00000000..6c431273
> --- /dev/null
> +++ b/tests/btrfs/283
> @@ -0,0 +1,73 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 283
> +#
> +# Make sure that per-fs features sysfs interface get properly updated
> +# when a new feature is added.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick balance
> +

> +# Override the default cleanup function.
> +# _cleanup()
> +# {
> +# 	cd /
> +# 	rm -r -f $tmp.*
> +# }
> +
> +# Import common functions.
> +# . ./common/filter
> +

  Removed commented code.

> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch_dev_pool 3
> +

_fixed_by_kernel_commit b7625f461da6 \
        "btrfs: sysfs: update fs features directory asynchronously"

> +# We need the global features support
> +_require_btrfs_fs_sysfs
> +
> +global_features="/sys/fs/btrfs/features"
> +# Make sure we have support RAID1C34 first
> +if [ ! -f "${global_features}/raid1c34" ]; then
> +	_notrun "no RAID1C34 support"
> +fi
> +
> +_scratch_dev_pool_get 3
> +
> +# Go the very basic profile first, so that even older progs can support it.

> +_scratch_pool_mkfs -m dup -d single >>$seqres.full 2>&1
> +

  call _fail() upon failure.

> +_scratch_mount
> +uuid="$(findmnt -n -o UUID "$SCRATCH_MNT")"
> +per_fs_features="/sys/fs/btrfs/${uuid}/features"
> +
> +# First we need per-fs features directory
> +if [ ! -d "${per_fs_features}" ]; then
> +	_notrun "no per-fs features sysfs directory"
> +fi
> +
> +# Make sure the per-fs features doesn't include raid1c34
> +if [ -f "${per_fs_features}/raid1c34" ]; then
> +	_fail "raid1c34 feature found unexpectedly"
> +fi
> +
> +# Balance to RAID1C3
> +$BTRFS_UTIL_PROG balance start -mconvert=raid1c3 "$SCRATCH_MNT" >> $seqres.full
> +

# Sync before checking for sysfs update during cleaner_kthread().
sync

Thanks, Anand

> +# Check if the per-fs features directory contains raid1c34 now
> +# Make sure the per-fs features doesn't include raid1c34
> +if [ ! -f "${per_fs_features}/raid1c34" ]; then
> +	_fail "raid1c34 feature not found"
> +fi
> +
> +echo "Silence is golden"
> +
> +_scratch_unmount
> +_scratch_dev_pool_put
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/283.out b/tests/btrfs/283.out
> new file mode 100644
> index 00000000..efb2c583
> --- /dev/null
> +++ b/tests/btrfs/283.out
> @@ -0,0 +1,2 @@
> +QA output created by 283
> +Silence is golden

