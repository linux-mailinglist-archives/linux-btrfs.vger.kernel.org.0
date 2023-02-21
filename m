Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B5669E26C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 15:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbjBUOfz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 09:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbjBUOfy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 09:35:54 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC1E28D1C
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 06:35:53 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LDj3aU016441;
        Tue, 21 Feb 2023 14:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=zx9/09uxBbTCX6go6UeXdHjxlycz0f4FN6PGw46XXaE=;
 b=puTkS7ONQBIUdmAnd4cuSdyiC347gcOKKvhaVduf1AWe2I2RyQQlkPDZlpW+V96OAeyq
 vM3eq2I1ZxxjeHQibWBwK1Me1L4fabuy1rKmNGUoI2fuBHTzmRS6pxCbGvm9pTTEEWm2
 bXbYOF0lPP/jt8rntgpIqVJdqWURHSNSXb5Ch0dipUF4zYy6iudA4KwSY6yUxdSvnTIK
 PZE4I60GjxM7D/bukwT7j2n5a1TFnVQPZflHCkLYDLw7bOTFjIhNgOMLyxnQxVSlVHhG
 9ICDXlwe98+omBVsah57RRw+wMm56sx+BgHP9Z4d8Ls6LW42TQOgqbLqm2M8TX5blF4J ng== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntn3dnayg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 14:35:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31LDxX8I013098;
        Tue, 21 Feb 2023 14:35:52 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn4cfk5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 14:35:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQD72p/P0gLSLFSJH/SCp9/SWvpGYCEMD2R+iEk8ATpmUk2/LQs3fUzN6/nGWOkfBWFyfAfLT3QTETVDpcKaj+LduZeskFvKSM6k08BrO/C/vQSc6/Z2VzRHyA/d14xbhQd3n46jfAJko2rJ47tpuy1vT7aWaZ0ECrT6U25NC6UAkMc2gNBXSmckdSKENtpWPBlgFIsLgX4kjFD4XiAf1aJ8yUvmNYB8JFP2KALeoRnbx2gWJdiCXrHsou9uHQinSd25hzm1BZ8rbK+5jGKfS2lp0ux0rgJNiWOg3grIMQhK93mbVpxpm7bAuHR6EidqV4JJrGxxaoT88SdWJaUsWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zx9/09uxBbTCX6go6UeXdHjxlycz0f4FN6PGw46XXaE=;
 b=gbhZXoW5mL6eeW6Z+qqUOSoksxDtGW7VEfPzzMwFJ3Ze/lEq50zYQgw61+ZaHfmz/Emz94ptkGaZQGp5Jy3mh8RZDsovgFBir7yHT9QezShvv5Y/GLorNDZ777BiPyPs1SC4Wc+iIcBEpLkDhPF3dHwcCWfpxVIcNBi+sp8ZJ0jjVBH/hkbTUEZ1pro2KGfixIN479Y0q7Lx+9hg4DNcNaWM8DTZRhJdx2v5JHhW6omGDdvTZrkvgDPAU/v5AG0jkHuTO+BfNnF+6RYb9i5yR+I4ZOMIo1of9qtXWhXTdd4qPcBRer1V4jl7+tCLbuVa7VlTEbSQ1hLlmunMTSFy5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zx9/09uxBbTCX6go6UeXdHjxlycz0f4FN6PGw46XXaE=;
 b=zuVTPQWJpLcKqJozr8c5MRfjHxvT4Kvf0Xs6Dg+PiwmDsJzfwNOAwUPJxpccOId37u4v6pkk8CbG3AeyxbRK8bARhiKOa7HufeGaVGWHXenEVf5JdNMfOvLVFCIXC7N8vbgh0BHANv+oyyQVo5jxMIF2yabDlj0SKGAkwrSFXIs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB7204.namprd10.prod.outlook.com (2603:10b6:8:f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.16; Tue, 21 Feb
 2023 14:35:50 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6134.015; Tue, 21 Feb 2023
 14:35:50 +0000
Message-ID: <f50a47b7-2821-3738-f1f7-1a716079bade@oracle.com>
Date:   Tue, 21 Feb 2023 22:35:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] btrfs: reflow calc_bio_boundaries
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <9509878ff5631eb2563855c0de694f296e23e0f2.1676985912.git.johannes.thumshirn@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <9509878ff5631eb2563855c0de694f296e23e0f2.1676985912.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0111.apcprd03.prod.outlook.com
 (2603:1096:4:91::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b45441-75a9-477f-e35b-08db1418ed70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aInVGC8/mOZ1UVda+OnQMBEOuMOL6m/B9h0fPKGtTCVOpSaNf1wgQALYTcftaorGKoDLJbZN46RFqzOdffwmKml5dCu1H+opLK9lO1WL49xyZguyfvjWBGZ0N8voiHUx6+QbokB8KK4ak58HcKTpnKqwtMj7ZJtB5xEyCpprxIJhY/YLSViN0IHvXMZoF5N4f32kCL4nXGpoDP8IHbzCs2++XeG6POdqK3P/Zu7mSrOaTwMwGpyhv1uEIxHgUke2oIVj8fTcJE91r5N1c8YgT/IvfCMKG/s+yolSpoRtgyze+zN+/DCzNoXOwJfwCzvUoJqhTwp7NKf0KhF0hLwj9ZquCR2gj2rKLD8V5UOmQQ0z0enMQEgtoXTAmwQ+kO0xxg+i2RNHXLs+CPJkWWSwCpMVAbtKnir0UjEaDhtWCuGkGfzQKC2Qtf3CwWI0vnHUCDcPcaJb4wgNwuTOYGBtNqGeeY1LyrlBLhAYtimJH/6Rkin+lZY0UWchLBB0AE+8Vfht70tdCf7s7qFOrIuJxNXrJxO3Ray4FjAxvE8KmXvTPKdqZmRKghbp0lk7N1oYkbXWa1g4D5GZVIlT97Cgfn0bYN8SfEkjPV2Ai/iIMG8HSXfVSLWmvIhJzIIMIHIZSxi4IYqT/awaHqxN+i6yZr5IVJsUlvTfaVIDGUndt+n3jfY6Qqr97s+ZbP/1y9v6Z/fEBQ/CcAvL9ftV/33o9T0ERXguf+d+49tx8gQg+1E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199018)(31686004)(31696002)(36756003)(86362001)(558084003)(44832011)(5660300002)(19618925003)(41300700001)(2906002)(38100700002)(478600001)(66556008)(66476007)(66946007)(8676002)(6486002)(6512007)(8936002)(4270600006)(186003)(26005)(2616005)(316002)(6506007)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUt4MHlYN2hFYlVKN2Irc2VjUmpHM2JhRDJnNndxRUtjKzk4SDlucVgvdUsx?=
 =?utf-8?B?dWRZVTBoaXpXZHB2ZERVRG5hY0ZQSmo2T0xrVlY4Z3JNT1hMZjJ3NUcxYklS?=
 =?utf-8?B?V3ZIa2p6NXBWKzR4R29RNXU2SW9Xemt5U3dBSGVxQ0w1WDZkZHQvOWw3R2dj?=
 =?utf-8?B?UlY5RUhLeFNkZjQ3VHlRZ1hCQzdjWWxPMzQ5MTZnUVdGQXFmWm5SbWRBTnVW?=
 =?utf-8?B?Zm9yVEJoNjZsTTRQZGZJakppd0FnYVM5Uk55RnJiVUc5aGcwM0VtcXJKd3Ni?=
 =?utf-8?B?OUI0QW9DR2tLWkNvUU9pZWVCY3gvMHVRQWRhZmNjNGIyQmhVOVBvcStIWDNr?=
 =?utf-8?B?b0dDWTd6ZkpJOG1vYmRSd3VUTW1kZ0dHN1JNcmxVbnpVL3lUMTJQdnk3ZXZW?=
 =?utf-8?B?RnU2MEdiUGViN2dVb09nUWxnaXZFZW44UHZBbVg2c0xLbkxMSlAyM1Q3ZXhO?=
 =?utf-8?B?VWlsN0o1ZUN1Qk9FSVJUNWpVSURob21yUVZwTU1wd3dNUFhWaVZyM3BuQ2dY?=
 =?utf-8?B?NFpzTDBTbm5RUnBpUzk0cEdCVTUxTS9jNXlVWTJORVdkc2VVKzVOSit2SmZv?=
 =?utf-8?B?a2FMei9Sa2lIVXNxU2FwQUVldW5CVjQreUtoOUxCWnBDMUU3QTRTVGNJTDBQ?=
 =?utf-8?B?eTJNUjBibFFsTWVRNXJJaTVTbXRqOEx1SFlMaXlPVjF2dlVBSmRiTi91VEgr?=
 =?utf-8?B?S0pXU09CZ2s2bUpQeGZEQzdmQVVSUityLzhmVG1ZUFVEMWJCb04xa250Wlho?=
 =?utf-8?B?MEZFaDdodm5MVjNjWDJaNmJNRHlHQ20xVWp1S09OQWordk9iL0l1OHhlK0tw?=
 =?utf-8?B?cGpJN24wMEIzNFppWTlibWpucUhxeHQzbHAxQThPSklod1VuTEEyVGIydDgz?=
 =?utf-8?B?endVam5EaE96TlNVR2FpVjJOQlZkczZyNDdyQjdFQ2dzWGJYSlJCb0tSZ04r?=
 =?utf-8?B?ZHlzOHN1djJ6QnAvV2pjREh2eVpnWUxJa1BEakcwcDBhVnJQR2U5bDJDYUdq?=
 =?utf-8?B?czNYSFp6TDdBTktGRlN1MW9kbTdPNER2ZmdLd2tYdCtEdFlOc2hwU2JIMTM5?=
 =?utf-8?B?L3JTT3ozQjdDMndIRmQwdVZBcEZ6T2dtWDMyTHBxek1rNEY5VXJ2ZWI5dkN1?=
 =?utf-8?B?SFoxKzhyZGxZVjNycWdUY20rRFhoRGxCTXdsU21pRzN2OWpnQ2JvOGhSMEhi?=
 =?utf-8?B?VkhnMzZHYlE5THQ3WU9RLzRjN2N6RkpiaWtBUWJ6YjIzRWlFSFB6Y2F1L0Jl?=
 =?utf-8?B?c1BpVVlEemtnajJDbjk4QVFySk9BMWludXdQL28rTEx1REI2dld5OStHdk80?=
 =?utf-8?B?Z3NTU0pZNTV1STBlT3BFRkVSR3E4WXpxY3JnZkdqZmphcFhtcDRyRG9vWGgy?=
 =?utf-8?B?RHhkK2Flak02YktVQzUyR0xSWlVKSXR2NEtieS9MQlAzRzMrQmlyck1zUDZu?=
 =?utf-8?B?THFvZVE0Z0lhd2RXS1ZYVFpvQXl1RU43NUVIMGJjai9UcTByMlhBZExUSlBX?=
 =?utf-8?B?eUxITVFTNGdSalRWQ3VBL0ZLSFF6WTJlUzV2L0dxdkxkSC8velpxZ2ZMMVFk?=
 =?utf-8?B?UXN4Y0RsSFRBYnhsTHArYnFUR2RacVlyK1BWZHlsTDRadU9ya2FPcURYVUFR?=
 =?utf-8?B?VFdQUk1MUGJlUnZSM2VpR2dibStVWXU0a2xYSGUxMzZSbFlPRncraTh1UlBh?=
 =?utf-8?B?M0Y1WHRXYnBqSEwrbGJzQ25XalJnbmpRSTVTNm1ING52SUVwK0tuRDN4MGdC?=
 =?utf-8?B?bFJPNFJma3d4YmR0Zy9iM1I5MkdQTlF2SWRmSUpiOTJDTm5OQi9PRUdzMHgz?=
 =?utf-8?B?UzNGZjlwSkNyOWhvUjJUVmliMDZoUmtqZTFpUnhLbnpwemQxanA1MTZYdmhO?=
 =?utf-8?B?R2lxOWZRYkJuV3FDblRIck1LZHpDQjFYMEZhejhHOEhJUHZlN0psY2lMN2E1?=
 =?utf-8?B?NXV4WUtZQ3d6MHkzbFc4UFpvOGxKMmFidXNuZ096OCtoRTRvcU5WY0tsL00x?=
 =?utf-8?B?bzdrQ3ZUUTVGUUVFWngyak9QVjdCL0lnZktWbXBFSjVndlFiVDhvUVFUWlRH?=
 =?utf-8?B?SmVWMm0vM0xhY2FrRTkvZTk4ZnFKNUVWNldEaDZ3MGtpZjI1QXloYzl6MnZj?=
 =?utf-8?Q?mzrsw3qssQuv1hMZlUrEBMqVj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HZN/mkS3GZ3jOrs2V/d5kJpwnlQRPoL0qCbmWDoDbxxbDUneJFKocWxqBWxMvxn+mQJKVpni5Eq+RrD0O2e311PsIwylGqU2bPpqgkJuG1hcK4tIoaJiMtCRWlMq6/4/1JJ0VgnG+n+Z3q0gRh8s1yaSFMZoKpIZ22YGqMTCoSwHCgcujOyWI7X+oc+bZ4wBPoSoTVmGQywth7mxjhblfATvFKh797FG0sM3BR8rle8rVLrMXmrRzZWjdvUFO9BJtq4BTlCPYv3GCczN1o3t/MdSJAds4y3BG0Epyu9UD9qrwiLr9rru0JLH52V5mdI8YaAD/GP6H3682iyAeC+9v4dZPHwhDxvsah1I6ugPou3s5A4oJveEfB7Mx6MLPbjQVLl5WZadQu8Gg/K9dUXpbzuETdhNUOqOSpbdyiF9GLY31vySbR6cA0kcwwt30rurIlIlRVfMZPFTowfYSv0ABDW6Bz8glQ9FnEXK4r0wZIe7bL/CU4O6DzX7d+7zrAI0SZ4j5Xfux9pV6IcxYwQwiei5l9YYG48BNhyr+hiiOulyITIyio9QH/Zq31f9MgBTWuHj7pTdIqpQGk7GdoWgPwAlxpbwPPucj+mDT8EYkQjEMvi1Sfrw0hIsqx/S/BxUH1QtQH36e8jU8P18Orieu0eMhu7orPG821KXS3fHqfQhwdfbogJjv468TX1PZL0vioTT8UXIM8JiuLyXGJN+6lqXB41EHlrPWmTImo3HzFy9MmzoP2hlcUfz7PsFz4mcLxWbvhtYbVcqrudi8NZSXReHH7LZEKwGNHM5om0CR2o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b45441-75a9-477f-e35b-08db1418ed70
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 14:35:50.1863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FxkJ90wD87i9VngFr8NLSF5X+aJJgv2zFissfcxuRLxEM39rxffnQjJTOo65cH3FMEKfKA/q/vX6qQwFKhLnVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7204
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_08,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302210122
X-Proofpoint-GUID: LPS7TGPMyfNZQH9ys_GyEf7w7RzNnJ9F
X-Proofpoint-ORIG-GUID: LPS7TGPMyfNZQH9ys_GyEf7w7RzNnJ9F
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,TVD_SPACE_RATIO autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Reviewed-by: Anand Jain <anand.jain@oracle.com>
