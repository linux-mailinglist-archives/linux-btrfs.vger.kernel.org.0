Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F4F77BD1D
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Aug 2023 17:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjHNPdv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Aug 2023 11:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjHNPdV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Aug 2023 11:33:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC69C5
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 08:33:20 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECiLTS019893;
        Mon, 14 Aug 2023 15:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8C/AogYTMgyVgCDXKLTLgdtb2AANsRzr4kZ3dnAdGFI=;
 b=tOstVx+LS710EQ9Dxc6VTgHOpJimcepLEPqSDHjlM0BrhTRsk281Ed95ZmKlUc2qeMfV
 ZPOIVyx2cm0Gob3ynng3ek3TwgFka+/9rj1pOJX0xiwhQa79yBZZSRtCjVYGX78Gh5+q
 lKN3JK41hgVYWPOdyWzLeMQ3vlIxx3Q+mXqMkaGmK2t+9G/E1NLhL3rTTK/cO+r7QuEF
 n3zfUf7MD0pexrTebmGud/CVdxu3mBsEBuCLAjtScC5sVpezrTaRBbFP3YjUhvcUDM1U
 ohQqjkSkdx4ax+PFj2Eo0eQ1ImbBt4h7bL8z3Z6fyqdSiJ0OfI/f24exWou0JNA/bxCy KA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se30stw24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 15:33:17 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EExHsT040098;
        Mon, 14 Aug 2023 15:33:16 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey0pt6q9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 15:33:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7a4syT1BuP8qTLtX2OM0OS0psil8p8g1sPyVOBMqa6S9MKjj6xgssO9tiTeNdA9taKv5LCwe+TZYSeJzQLbH9kXqts+FZaB8tcZOhxpNjoKEiQxi2hgvjHahqH/TsVVS7rse287pWxoFP/pkvNvQnJ9kV8OFfiGqag+On+SmCYvaqGQdpRy+3K/lo3EUND0Udn6J/OkiQ3cSk0qq2D6Fc4yi1e5hX/DoRTf/WiaaEX8O2mRnuhSPdx5PayBcpB7+3awKfp/UntvimGvYt/ZRzmPD+yJ7wMVFLObzuUcPYu2yBlVSgbjblrKlHdjfyKHl69MQG1X0SiEoH/8VlC8EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8C/AogYTMgyVgCDXKLTLgdtb2AANsRzr4kZ3dnAdGFI=;
 b=YaPzoQnXRz3Q1KbNSBJhovjxCFF0iSlTF2Uq6z8o2nMoXYViz6Z6ih/ynY3DOxjtwqqyePQDugMZGL+kL4bPbCCM6zEChd76llxtJDxBl+z0JInHDQHjhBrLueq9VmvJACLg8lAkX5V8aiO7Cl5HGIzEwXHvDIhZdkMjuTtjp1Q08nUVlaGk3FMMznqxfGdKkUm8JWWgXdXpLL8Hl4e/UciUORPpTgkmpBOkg4ntQ/Vn8+RIhrL9JPGOh6qo9dEer5X8GIdnLsHFIcTVChiVHHM74N+GPON8VAc9XYyM8zG+oWHlvNaI9wktUHpDHorrdQ8sDQZ7h7EhLzTdXzZkZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8C/AogYTMgyVgCDXKLTLgdtb2AANsRzr4kZ3dnAdGFI=;
 b=WgaID0gUhARpncSF3HNjpayBqLJGpt7INsAultmbCx0BqIS9m8ziEfChL+POsswiizTfUZhUNjLzxl3B8pQaybho5ReeoI3r1jBVy4FItZ0Ic/RQQGqUumanQx4PdF/HyU9nTYzF0/BwdkMjXqz7o30FpZtlOVYFRp4wB2aOx7E=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6342.namprd10.prod.outlook.com (2603:10b6:806:255::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 15:32:59 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 15:32:59 +0000
Message-ID: <94ca999f-b59a-aad3-3313-ed7c5b976d55@oracle.com>
Date:   Mon, 14 Aug 2023 23:32:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 7/7] btrfs: use btrfs_sb_metadata_uuid_or_null
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1690792823.git.anand.jain@oracle.com>
 <69a45acb12680df22a7c7052e788450e7f780d91.1690792823.git.anand.jain@oracle.com>
 <20230811154240.GT2420@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230811154240.GT2420@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::21)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: ebfda6d2-c941-422f-6569-08db9cdbbd4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ToFwC/Y+G7nGQXwvI2/362772u3ziT5O/QOLy85qRPZJVLXokhCC2Y2q6M8ZUHm3nrHtfZG36lZo3sRXd36Lsz8rXFnyqjDX9/Lk/YMv+GiMyj+ifaPEdM6pb5+fANznBQdBq0JWLV0DaHwcxAy6JE1Of3rLCsD3iWN57VBCw53/TGmF/AsxdfRQcgFBQkXZvBjR/ehX7wfjReHuxyylhF3RjeE61OZIWOnnEr19B37bPCCBW/A+Gl2I9AefeKqY0jGjzu0/+G6RHfoVfbriRt5iNENzF6cfE2ujRGTxTFJUW7bX0JOil7bH7It+6g4KNuZTup4SQk9/d01aRI2GrRRJJPEKrFPEEJIKh/Co8Wzx3xPrkOAXDeg4h8x/lsJ798DgdPMacZYJVcRscON3NvNBaoxNevXoTBVOmEz3YkC0YS4P/KibmtqdobH7xaLhwUZ24B8eEAwoVEJu02BLYEti0Xh0DLrQt3GC5OWS9lVQBqgdg1mqCU3r9nZ81a7ba5vD7fHPWUX33rZs4LHDurvASwLgyd43UtreqYkWgsRvW+StL8/ljvhSqCxksGEhMKIyVuWp1RWEx1OqsRmV8KaM6G4ibOJ6lbKteBqTV6e6GEv5ejkQqNPp0f0Wpmracu2Ya+S5l1OF0ygUSBjjUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(346002)(39860400002)(136003)(186006)(451199021)(1800799006)(4326008)(8936002)(6512007)(86362001)(478600001)(6506007)(6486002)(316002)(8676002)(66946007)(41300700001)(66556008)(6666004)(66476007)(53546011)(6916009)(5660300002)(44832011)(26005)(2616005)(31686004)(31696002)(36756003)(4744005)(83380400001)(2906002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekxlTmgzMVFCRjNNWmxyN2g5NzJtTGRCNk5BK3UvOEc5TGRzN21MOWZFRmdl?=
 =?utf-8?B?b09TSXFBU2hGdDltckRyWkpjT3BTL3ROY2VxUFZjN0l3WkY0MmxzcnROOHhB?=
 =?utf-8?B?R1dta1hSYWhFNi9MSkF5eVdoTkVXbzZvdEh5cjg0T2dWeUt5NnFGS28vKzFz?=
 =?utf-8?B?ak5KQUM3c2RCNFV4YXlIcitpdTJpRWFUVHBHTEFPMG43dEhYZnhSdVBWejNE?=
 =?utf-8?B?MEhUdmpDZUkwZDA3cTd4UmNmQ0JEL0dvRmhXbDdxSTJrTTZ3M2MrWHRmai94?=
 =?utf-8?B?RUoyMlB3NDUwUjl3UzBEdllRZUg0WW9kMk9jK2R4aGk1bjNQejNJYm03UTZS?=
 =?utf-8?B?MXhvOXI0cm92bUJJQ1JqSHdvVDJFUEFLMGFYOUhzV2cwTEZQSENId0Z1S1Zn?=
 =?utf-8?B?eGV6bVlzSVBWclliek1MWE1qL2ZobTg4UXhEcW1RWWgrZGZjVlpqSE1QSFJJ?=
 =?utf-8?B?a290NmNDYk42SmY1TDl3UFVjQnM3S2RBUnhUMnNjblFEdHFOQVRjNEl3UjVu?=
 =?utf-8?B?d2EyS1B3MDdSWEUrRncwcFMwZXE2VzIwZXN3Q0NzQ0F2VnIzeHlCZWprUFNJ?=
 =?utf-8?B?TCtYM1FNSHBpMytGT283Q0NrdVk5cDEwSUttc1FSeDJWTy9uNE9JeDRoT2No?=
 =?utf-8?B?QkxGeFI4NU1DMituRkRra1dxVjR6ejFGdFExRkswQzluNFZZNFV6RU00Uzhm?=
 =?utf-8?B?bnBzV3ViaTVTb0VURFRHSmpKNy96RVZ2Wm82L2hlUTE1dUI3UHBCYXFZNjRC?=
 =?utf-8?B?UDRJaWZhbGNOeGVjcGlUNHo4bi83TmJKOEVkcjRzVUZVcUFiaVFEWDlIUjRz?=
 =?utf-8?B?MEZObWFqUHA3VlZnZkgwWGplT1VGcTd5dGtDV3FtWWdTT05vblVJWDNUVTVX?=
 =?utf-8?B?b1F2cnhEemptby8xL2k4Y1E5amFXeWtUeWwwMmJtRDhDQVYwNXg4TjJseExs?=
 =?utf-8?B?dGE2cEhlRzNBeEU5c0o3NUR5VnFwWjNSTzBkd09taDdpV2RsYUp5a0RFZ0Fs?=
 =?utf-8?B?ZVFINkpxdUZnUnpVSy9zMm1HSXNEemVEbFNYMytSbWpXMC9YN1kwZFNacnU0?=
 =?utf-8?B?ckJCZHVtenI2V1FGeEhHVHhNNy9Oc0xMM3l4R0FPbHVXWUx2R3N6RDhNZG5q?=
 =?utf-8?B?QmlwcjY1WkxTVjZ2cGtwdVR6RCtMWUF3c3hxUVJyTEhPWTdRa3BLOTF5NzE4?=
 =?utf-8?B?Y00wUWhTL0d6SHh6M1dOcVpTS1NWamFxbVZYL0c0UzZpTVFKVkw2NFJqWHlz?=
 =?utf-8?B?bWo1Y3NYQ3JRTzdXTWZ0VUNzVUpybDhJd00wanBGRWUxVGNVMVByZGo5U2pv?=
 =?utf-8?B?dEtaSEk1Ulo0Q0pudnk2azI3eUIyT1FpT2dwOFhTdnYyUXJZZnkzMFVRV0Rk?=
 =?utf-8?B?M2p1VWZtWG5OMVUwMFpHTis2NldCNXBKZC9sN1JTU2tSZEp4b1E0bXQyVFFy?=
 =?utf-8?B?b1lxRzlIMlFuMGtLU1ZPVERlc2tPN21WTlVMb2NLOG5aR2Q4NU50bXYrMEhY?=
 =?utf-8?B?TmhzaTJFbzRjUzdqY0poVWthOGFVOW1YYmFocHprRDBsZmtCV01IN2NwOGdO?=
 =?utf-8?B?ZlFYSi9ObnNCeFQycjUzQWoxbDlya1VneVpkSWNid01ZN3RlUXppbzR2Rjc4?=
 =?utf-8?B?MUVEdkpuY3Btcm1ZSTVXRkRLUklvbURDOGVTbnNYTW9QaUdiMFVwMnA2Zm1w?=
 =?utf-8?B?dWZUUmVzbGhINGQwYzh0NjlreHpZd2x6M3JIdSthbkhNSzl3ZDhHczNqMWl1?=
 =?utf-8?B?TE0vRGpmcHorWGxvQVRCL0xlL0VDNlVaRjlPaktVc1dreXYrUXJjUHBmQXlF?=
 =?utf-8?B?NVFXUnhESVgwbUozcUY0VkUrWjBDYmxMQUJWQUpERVltNW5KUkxWcGVVZ2lP?=
 =?utf-8?B?Q2NVczNCbmcrS0JvQTFFa1M1NlE5MWlrK00xZEFjSytoR0pnbWt2K0VvM213?=
 =?utf-8?B?RHJuVzZlMFBZSjFaZDduOURMUy9mTk91MzhwUFEwamloS0NxT1hpQjJjQ1dE?=
 =?utf-8?B?OHB4aThtSUVWeS9IMWhuajlGRkFxOVdhbE9QVk1tQ29pMWdCNzAyckpod0Vi?=
 =?utf-8?B?eDM4RmZDZUtBa0c2QnB3dU81Z3AxckNrQi9vbEhjZHJ3V0plY1Z1TkwxQWNY?=
 =?utf-8?B?UFBLc1lHR0hzcjdYQjhzdDhKNVZGN0twYlN1NjVsekVYUUlQSmJZTTdPOElt?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KMKenrALanp1jmxBxxKgk0VpOG2qngdGTsyJ0NlfqyvDESJUyJE0/vP6aRe4C3Vf0aA71HQa4dPL6sTpmGlgvr8A5e3pOnsOrM8MsnFH13rsSm17sFThedpJvonGL9IprweRJHeF9vcGHreXal2KrO29X5RKKtKKIuN7R0lmbNy8AJeFZXTsCswSImr/jyVpU1BEtVQlh3dQvih3XzBSJcgMn6yIWp82pxwj7DG0Sf4rdFfKRwNKyZKQJF4xbBqcKKLfg5goWabzeWaxkA+YbvamUYp+CkRUqWteRIrTdUSqgUdIIb3Jjvk9JZi9HDlRBmPyyqT3t24UUAJwasskzxLeKGBzVUCLmvlFoR7GINMNkfEj7ASA43shO83Ha04dHF1RSpj0hyz4ur7+IlvNQH02JPKMLpuLbdCfzl6A2uv21Dq2mB273zMVN6edduk7aKqYQG+HBkzYoMqVzO5FKp3EjEnKWKO38M5apAoMWjprFnIAjzt5QmxzyO6MKIlSpRh2IZ6T8xvmwhe+LPtO/sR8aektQ/p1WKwDLXHlnn0i5r0t1w6k4NSExKIL5/8PxiAbILx5If7TND2p887W7neRjvc5J9eK3soTG6AyI4zazawkrm2VPXwyIQkjgm3z1VugSX8HWDuQhhKoU6SYdJjaSJvCkqMDvYsHj9ydimSAg4UkyHuX++RsPI+IysmFhrf7uh2AwrgB9CbweqnZ8iFykWclj5lkfHRMLf+ktbXs/RG2Sx+scqqtcrHF/6eVoH9WnleEzkYmEB2yb+UNElsApE45R1FXYJd0KFdX9Yc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebfda6d2-c941-422f-6569-08db9cdbbd4d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 15:32:59.3961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIxn2eQYSOweEhIri4YyRkTHqSAWSG/VXH9yDIJ9wspdXJ53D8YEurVb9S9VlpwsHWEI4sf+qZeo6SzLTWmDGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6342
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_12,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140145
X-Proofpoint-GUID: fiOI1p_sV2PahLEbZLTjEQBW092i3l93
X-Proofpoint-ORIG-GUID: fiOI1p_sV2PahLEbZLTjEQBW092i3l93
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11/08/2023 23:42, David Sterba wrote:
> On Mon, Jul 31, 2023 at 07:16:38PM +0800, Anand Jain wrote:
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/volumes.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 661dc69543eb..316839d2aecc 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -821,7 +821,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>>   
>>   	if (!fs_devices) {
>>   		fs_devices = alloc_fs_devices(disk_super->fsid,
>> -				has_metadata_uuid ? disk_super->metadata_uuid : NULL);
>> +				btrfs_sb_metadata_uuid_or_null(disk_super));
> 
> This is the only place that passes a non-NULL pointer to
> alloc_fs_devices, so it might be better to drop the 2nd argument
> completely and just set the metadata_uuid here, which is basically
> copying fsid to metadata_uuid.

  Oh right. I am sending v2. Thanks.
