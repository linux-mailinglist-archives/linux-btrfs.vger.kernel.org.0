Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CB771793F
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 09:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbjEaH5s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 03:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbjEaH5W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 03:57:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C51AE68
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 00:56:25 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34V7MiYk020620;
        Wed, 31 May 2023 07:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=TRdgtQ6TCoVG+1TMd6G/8IvDPwQCwOe+T8PGnXcSyqk=;
 b=BAeldA5e3fe0sonMQibRH4kNgwiLE0ulx0wR4J+IDg96vcigWSITxC2ResctTSs91ccy
 n3rpk31pLC7DMxCWfEWKX1Te98MN+AWmij2Vaw0gMypw/3Aenxn9EUSP7BKBC0sI8Is/
 KJIEfe5ZkQKKBqbqtlgaVJgFoDIn8qQYsvHWv7oUCjgjGhIqaaDDdH9MbLYsbNfmiVIL
 xSkzwSoZHbV/pJRIHjvPt7ZTiMHqRtT0gP/bEuEXCpdxYWzLqkQVlQ8MgXURkMJFtOsE
 XXot5oPrF74QO3rcQBCAOTIMWON5zLUO/1TXGRDEMrpVkeCOn+W7Gh+mWMuhqRa6zFnO 1A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhd9w5yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 07:56:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34V69peh014618;
        Wed, 31 May 2023 07:56:13 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a54taq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 07:56:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUDo7n50Yv9DZ304zc9eQsePiL+WZSJdcUIgx6EHlYtRGPK+NetRH4c7uL8NRAIU9zpRREFCKTtAEg948yTKMC5PqN835LDga0c9RUkkHtfaB7RlsV5+x66Z8MIlLqWY1ULYKa3+rQeZ3fDWzP3Q42wrRcj+cUZiiKdCBAxet/qR82Q96Fx5WrbYpTK4MJcC+XUu+mHUNy52tBehXD2XzBMhY7yl8hyTUFZnDFMkFYYEfDy8/LItIs4zfu2mA4iDruDmQ3Ql+eI5WmFu6tMSZ50Mf94zUS0alTlVrvLWCUf4uTxzONuaZH4Rj3YgqiDa/Vp7X4qGWo1jZ9TzWwLkNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRdgtQ6TCoVG+1TMd6G/8IvDPwQCwOe+T8PGnXcSyqk=;
 b=N8benBpvX0NIZBI+qAkOGrKKf2hT2RxLMShypXz1jowkGfBrbIvIXp6qPxZU5UzVnCV4mj7wbo1KYfweUO9z4NmLiBPXpR/+ITo1e1zcpVO9eWt+ZgsfplgDYheZJ5EX823jo2h1wMaI0g3663pkGFYc2ENq3COAOlV+TDhU4wIqZEoeSdyjy2ZHL9A31V3CKdUSZ9jfQLm0TskArlP20pfwfAs+DfnpGC07Q5W6MeJn4cAS4IQDkApBv6yspe0LX8sLMewDda7aejrWMcrg05gi5VyA5i567xgKNJy3rCELE04O5MRPNHqE+cDR3nI6XcQ5PMcKXQ7rxKuDajVzFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRdgtQ6TCoVG+1TMd6G/8IvDPwQCwOe+T8PGnXcSyqk=;
 b=dUk+/8/hyEfwLVlzD+nHfWlJI6pzSc/ANYznXt1yi0MEsyOnbXPIg7tgUGY8BuWesfnNxbrna/xeleGtII/uEAdV2ArE4q/IjHdwo1Mt3MCUoHjs5RVxzo5b9IeN0rL5rQYZfkSRe9ADelhcqZqlUPHl+suR1i19SKuiKIqMHPQ=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by MW4PR10MB5838.namprd10.prod.outlook.com (2603:10b6:303:18e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 07:56:11 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::cc8e:8130:ef15:a31d]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::cc8e:8130:ef15:a31d%7]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 07:56:11 +0000
Message-ID: <61b790b7-ea57-6c97-bb69-038106b59b50@oracle.com>
Date:   Wed, 31 May 2023 15:56:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] btrfs-progs: add CHANGING_FSID_V2 to print-tree
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <8e152cd504552e92680290cd34bf30bfef0cc1aa.1685440589.git.anand.jain@oracle.com>
 <9ffdb317-e679-0fb9-4181-c40526d7668d@gmx.com>
 <48115fe9-e181-9045-3d10-e1549e67478d@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <48115fe9-e181-9045-3d10-e1549e67478d@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0098.apcprd03.prod.outlook.com
 (2603:1096:4:7c::26) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|MW4PR10MB5838:EE_
X-MS-Office365-Filtering-Correlation-Id: d6ea9cbc-7c92-498e-a36a-08db61ac7fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HCmy0nekryyYUSckLuzGmrJb6H1EwbsGSyAl8HYnGEOvE5IIRQyflE1yxGxfFaG2G9bPOTDSH5LOmmisxpIRm0vZovNMoJfA6m71fxitgp3i0xSiGrrNRBfvGffqcowD68Nty1JKk/6dLbOW2EbaRd4CvyVN1E5f7uon3g4+J7PH+yMrOpBZrMKvpzb6qZJ1RcZ98bQrpDGcfhiRJz5Dkr2gEsP0dpgxx0jU8UYFjuRW3wrYKpx5AO2OQ+NKL+0mA4FLGIwvQU/athTGMfxYcZnG9wwAXf8LTZzue3wL8OtWycPzb7tQUI3lUi8mSkDS4ijwlOo0Q3ccLX0hbYt41xhG5p+9uCgJvQSkt3qEKPZ8Y8rEARTiaAiVNEGTlXFzU9PHFrl2PheuoVuZ2rAm7i/tacNpnsdkrcdojhoJv+OWdcCJAwWTXMELnbSxt6vRSNVSG1p9X2OeOOo06qL9+8Kns7FnZqdgYRg5C+KxshW5o5QFU5q58wZNZI7Zrd5X8MCBe5rja9E4OtP0dXDCTkWIlAMPNoHKabnxDvDQXPTakZMs/6f7VfVjs7IhwqMWdFWLfUj1AR6Jk6hLZs+JWuWIsj70cpmzqIu+5PcKvYlcoaGRoKnCaOxS6/4Ccu2yxVni9w1xLTeWgbj0G4mJOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199021)(8676002)(8936002)(2906002)(41300700001)(31686004)(44832011)(5660300002)(66556008)(66946007)(66476007)(6486002)(36756003)(478600001)(6666004)(31696002)(6512007)(6506007)(86362001)(38100700002)(316002)(186003)(2616005)(26005)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVYrdDhGTlF4RU5mZ2lVYk5RUFFML05FUmNWejBHSlpHT1dldmh5Nk15M3Mw?=
 =?utf-8?B?aGJjOVI0Z3AvR1NwTTZUNUFNSmJWajJmR0xtSkUrdGtKZjhRZUx1ZiszTVVq?=
 =?utf-8?B?ZTB0bjV6QXY3TmhjRHFEcC9rbXJXMDRNajFiV09nbjJHdUk5L0t5UVlnSTQx?=
 =?utf-8?B?NnFXd0VRWERLaVJWbjhObG8wVEx2U1RaQkJkbHpUUkNTWGZ1Y3Z0aU5kZ1BS?=
 =?utf-8?B?VTZsdDZMYjlWRXhMY3VMaXdTKzhKbVRuZmdyclhvT0RWaVBSZFV4TmNHRm81?=
 =?utf-8?B?WmZRTmR4aWpNNERTbzBBOVZ2Vk9oVXFWdDRPaGZiUE9EeXpzZjVEZWZTdEVv?=
 =?utf-8?B?Wm1ybURuWTd0YlkyeXp4ZjJ0WXlzS1E1VmtFSTdNVFprVFFhK05mZUZuRm43?=
 =?utf-8?B?alhGc1p6RTlGck9xajRabXMxQ3NMa01PWVVlVEs3ZlRTamJPUUJnelVONTha?=
 =?utf-8?B?Nmt0UFJOMUZSTHUvajRhdm1kS0czYTlFWFJXTHNVYWVFOFpYaStqVFY4QU93?=
 =?utf-8?B?NTdsZzF5anFVSEkrelBTR3cySVNPYng3Z2NhNlBLT1VDam9aSXI2b0xSOVFs?=
 =?utf-8?B?Uk1pNEx1bzE5UUh3WGhBQnUwM0hCa3JOblBNamdiaHYwM3NkQnZwYzhqaFo4?=
 =?utf-8?B?OXBkaHZGN2ZXcTJGY2VFcXBrZ1N5MFltVmJwRWorYnJkS2F6M2p4ZlVUMDNw?=
 =?utf-8?B?TDUyY0xaMzV2bW4zZmdZN2N4RVJwVFM3dFFiWWdiM2NZVWg4cVVXRkdGNmk5?=
 =?utf-8?B?VEIzVCs5TnNlSDlnYmNaYkZKVFp6ZG9SS3ZmbnZuSlRjbDNIOTNEVHU5b1hD?=
 =?utf-8?B?cm9pQmVZa1hmZ3A1UkVHUFVQbXJ2SFZwSEpYazh0TnZITE5ROEtWRlBJbzA0?=
 =?utf-8?B?Z3JnNnZpWTZ6V1NIbUhsRnF2U0tsUGlpOUFvVmRHdGNEamVkanBLVk9Uc0xE?=
 =?utf-8?B?clc3WHY3OEo5a0hwdFY2OXZkbWVuVTB3UWw2dXc2K0VFOFlEbFVsMnc1TWd2?=
 =?utf-8?B?eVRJTWttNE9PVWN3ZVlIb0F5b28ra0hVbWRsbUQ2dUVWRHExMzE0ZVJETi82?=
 =?utf-8?B?NUpZdjRNcmlVcUUzdURRSERNRnhhSWZBYmRORDF0d2NJcStVcnQrSG52WVdn?=
 =?utf-8?B?Nmp6ajBmbnFjMG1HU0tWSzF6REJtYkRISDc2NHAvSkl3T0hDWjltZWQ2MnZE?=
 =?utf-8?B?NDB4aHdFOUgycUNmYi83T2VsVjlrUzZsaStlQWtEYTQxZkFuMWFwRWt0dHl4?=
 =?utf-8?B?bld0bWRLSmh3VHg3bWNsSGhxU2JJOHBnZCtCVGNDa3lyd1g2a2p5UFRxSlhV?=
 =?utf-8?B?TEk2aUpBa2lBL1p2LyttU0xmQmE3dzZkd1BrV20xSEVtUEhQRkxtendwaHhp?=
 =?utf-8?B?Z1BqWFRtWFo0STYvY2FlNFRRNy9KRUJ0Ty9ZZUtxekpPeHhSeTJRY29XeU9B?=
 =?utf-8?B?blFrN2oraWtRTW9EbFJONFlBUjQ2NVkxcy9FWGwvdGpjNHVwRkpPN3lLUmpC?=
 =?utf-8?B?aTByU1lycTJCVGwrRnl5b0htT2VLUjRBbmNYQXhYZDhoVE4wK1I4bmYrWS90?=
 =?utf-8?B?d1RyZFBUK1V5VDYyMk9qOFIzSSszcXFuaDkzU3FBamhFbC82V1ltWkpRSTF4?=
 =?utf-8?B?ZmhKRFptSDMzM0QvaVArN0NXeXN4SVdzNlRLTUJQdEdwQzRaWHJ2clMwNjZq?=
 =?utf-8?B?SWdZVmp0QkhzbnZxdUd5b1VnV2U1ektOenlUV1hPdkJ6VnFuaFFyUkE1N2Fx?=
 =?utf-8?B?UUhqcGdOeFEyT09zdTlsMHBZMHJtSTY2UzFoZms4ZGo4OTNzSEVYQ04rNC94?=
 =?utf-8?B?dGdWV3dMVWZKV2NPZEM0WG5hdFdabUFRTThkYkdKWkIxeFhyTzhQb0N6NnZl?=
 =?utf-8?B?OVBaMjRVRGpDRXlZSnhZeEs0Nzcxa2xFNzFqSStOWU5xVUJISFA5WVFZZ29F?=
 =?utf-8?B?N0NqRkNKclBUZUxYcHkyd2lXMmhZVEUvWU1CVk9OVTlMems4YjcyOEhDWXpu?=
 =?utf-8?B?ejcvR0wrMUpkODU3UHlJcjhWTklWRFdRd1lvMzZMN01KVUo1WXJRODRyenhD?=
 =?utf-8?B?d0JwRGdFaGp2Sm9rQ0RNTEEzazNpdGhvNUErS3hsZjk5bitGTHpwd1c2QUNL?=
 =?utf-8?Q?4Kx6BXUi41WC4ItkwLhOdIf6J?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FmGXmluQmx3iXwo8An1noM9U8rlprwVhjD58P3R14h54tUubgWr7ZvH29+Y1EgBSJw9UVts8FTlWWu8DRpFdElVS1TUKkcSjVpyITIFoPJSdnw1oD+lvrONt4jeh/R+adlteWIJs+J2wf9QMgY1kipjsmzZVqPDHser9EZqqQXu7s/HXvMX3kQwC431gkD0q1Em76EggFtMa+qNJj5nTVQLPE/TlsAVKic8piIE1E+gKa5r4eux1Dq3HBvB/835qr52kM9jSJHHTbJtPx2IaWh7KJy3eJG4m3x6Px78pJGdzGPiqlVO8DaF3+XW81ZcF+sBQsHb02li9QDC+l8sabEn15MY2eKZl4TjXJJqdwxRU0pVpRduCSIstNwe11xZ02i6WoauOWelssDd1zu5Bf5UqG/OYkoBKjgtXakjX6phAcGjokd/ZPDZ1/zPbPhdEUEueY4EwvUtDQBgD+03QGZJf9hWTYEHBFUlV2TMY1eM9zFaz5hHcV7BZFWl7hKhLb13VVn/y5i7UYdf5JKcZ6PbPeQnLW4P81inoW6rPFrCbUyK4NszDVGZIAmqMOE+jS9T802yeD4wPW5PT9KntkOKR5Xh9oD4piXNVmN5KEQzrmS4LzSP8vCYr2QBeey01/oKHisUY+7Foe4sgDIrnU/LyDkKRcREVPz+HX0kYTXcn5zmyhvutJh3d/mrgn4xBocAD7InkQGrrsNx6tzkQzDMSQ5EFntKMDYxCdrCZ6iShr0t+5ks0519orzUjahOzz7Dz5S2qxFgavhCDhxsgmbZwopPBr5Yayq52dpjUj+8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ea9cbc-7c92-498e-a36a-08db61ac7fd3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 07:56:11.4171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59nyJ0XgOuZiiaGKxWkZoZ/pdUrgIr3Aay0A/d4H59ixrETbmm8YuAiZyUWhiIBD2ddksqNWk3LuBX61DtN9KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5838
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_04,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310069
X-Proofpoint-GUID: L-mc3kLh56XtQWsspd6rCL5fu4JbTv8m
X-Proofpoint-ORIG-GUID: L-mc3kLh56XtQWsspd6rCL5fu4JbTv8m
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 31/05/2023 10:08, Qu Wenruo wrote:
> 
> 
> On 2023/5/31 08:01, Qu Wenruo wrote:
>>
>>
>> On 2023/5/30 18:15, Anand Jain wrote:
>>> Add the DEF_SUPER_FLAG_ENTRY for CHANGING_FSID_V2 to our btrfs-progs'
>>> print-tree.c, as it is currently missing in the dump-super output, which
>>> was too confusing.
>>>
>>> Before:
>>> flags            0x1000000001
>>>             ( WRITTEN )
> 
> But my concern is, why we didn't show something like " | Unknown flags
> ..." in the first place?
> 
> Isn't this a bug already?
> 
My apologies. I have the patch that adds CHANGING_FSID_V2 to
BTRFS_SUPER_FLAG_SUPP, preventing the "unknown" flag from being printed.
And now, without it, both "unknown" and CHANGING_FSID_V2 are printed.

The CHANGING_FSID_V2  flag in BTRFS_SUPER_FLAG_SUPP flag in fine.
It has passed the btrfs-progs misc-test 034 testcase. I will
include this in V2.

Thanks, Anand

> Thanks,
> Qu
>>>
>>> After:
>>> flags            0x1000000001
>>>             ( WRITTEN |
>>>               CHANGING_FSID_V2 )
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>
>> The patch itself looks fine.
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> Thanks,
>> Qu
>>> ---
>>>   kernel-shared/print-tree.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
>>> index aaaf58ae2e0f..623f192aaefc 100644
>>> --- a/kernel-shared/print-tree.c
>>> +++ b/kernel-shared/print-tree.c
>>> @@ -1721,6 +1721,7 @@ static struct readable_flag_entry
>>> super_flags_array[] = {
>>>       DEF_HEADER_FLAG_ENTRY(WRITTEN),
>>>       DEF_HEADER_FLAG_ENTRY(RELOC),
>>>       DEF_SUPER_FLAG_ENTRY(CHANGING_FSID),
>>> +    DEF_SUPER_FLAG_ENTRY(CHANGING_FSID_V2),
>>>       DEF_SUPER_FLAG_ENTRY(SEEDING),
>>>       DEF_SUPER_FLAG_ENTRY(METADUMP),
>>>       DEF_SUPER_FLAG_ENTRY(METADUMP_V2)

