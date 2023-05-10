Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9155C6FD662
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 07:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjEJFuS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 May 2023 01:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjEJFuR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 May 2023 01:50:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B702F3ABA;
        Tue,  9 May 2023 22:50:16 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349Kr4g0005689;
        Wed, 10 May 2023 05:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=MQw/unzjYpFr/YwvGxpsg6bouZlpw+tS05RiW41hCDE=;
 b=bwWo3uzAZtuj9CskNA5lJWm0uECk6uXPz+dcmQBDne42asl27YaU9AMY1FfG1b5iOzZa
 nHQW9pesEJlYKPrs89vUc5aqN9iOb1DGXO6yov+GFsWb2bkftPnZl5mmYM9AWNGY+ZEU
 cVQjxGPek7fs3Zt9urb9oOUT+d7M2Xj2dxNY/R4bGu1Bcb+nPXwQOydpsa6MD4BiZbJ5
 3eOSZGKKoDgRsC/nBWxLqFzj2++szM96zb1mqse/f7A8/l7udxmTxCwdLzi4UR7fBqpM
 a6ZZvWtVmhnJglnuXGE16lYSKmIo7AwYO1yxqivoc6m4H3fHF8iatcJ6nTlACh6OwRYE nQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf7753fdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 May 2023 05:50:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34A41lB3022462;
        Wed, 10 May 2023 05:50:03 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf82wk0ft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 May 2023 05:50:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Br4syzDGB7dKtNXEa5bURMP6lnSx60J5rlRBwV6eZIcjpOilhmuPoJxV6ZMqHScxVsXvjmSV9hUKPWmmZKRxgx+d9G6RTQubMvyLyCFvuvlqJKetzqjEVXrIJAPKyxRLW1W6kZvEdWPndEKZXnI9iTKUmjArtNVMXKqxvdo8EjQeGNZMNbDWWYW1UkqmHu5Qe+9+KT0IZ/70zuj+ZOZrg2uuXcM7MV/fWLduz5JfB457sANug6g75jUw8d4/OpH/tNQfUlRIStjxPHBgZaW4M+piAc+UzIUs/8Fg/Zc1cLA8vVnPCbjNZ61/YdhOtAMllFGrhyKHG3NQoI7cmSFO1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQw/unzjYpFr/YwvGxpsg6bouZlpw+tS05RiW41hCDE=;
 b=fIMZSOrRA1iD07fPj55fSWJRAFFmU8hWAK1tlIk4bjrDmKzK2nhRmq1PvZ96f8zSDUonCHpvlrGBj2x8gxVFUVTYdLG6rAM+B9ydk964ULlVgm7mogzifFw6PAAWjqloE2EVPomhGsZ5znYaalE0MpRnOVY43rwMS4E7+D+JFb9F8KJhoCqGuQDRYFLoNUMh5as13k2PFg+/Z9YeBny8DFU/LyYmBayjyNHA99YyNjW3OMvMCBOc55GiO7946YC0a4sbYWMQQ50EYIzoZyPZswDgQJKFXIMy3NOc/tYjKlBzC3l3Tu4ba8rGLz4smRG/AST1irhqMjNkfKuYMJkMWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQw/unzjYpFr/YwvGxpsg6bouZlpw+tS05RiW41hCDE=;
 b=AqZDh06By+cbEgGSeKXTIyrcxI06C1tV1wmcJclBTg+16mpYSYLgNunYucg/BQ1srTQm3keISjQN6WYl9DYiwiZ4gnbiDb3SJ1kZ6+ibJ4DQOLLkanALG02DDUjimo7AdFaOPb1webMTCTogrPKEHKgty+4S0idKyWigiOZE5KY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB6791.namprd10.prod.outlook.com (2603:10b6:8:109::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 05:50:01 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 05:50:01 +0000
Message-ID: <e9bc6cae-a5cc-34f2-37f8-26c4ba4fb03f@oracle.com>
Date:   Wed, 10 May 2023 13:49:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/3] btrfs: add a test case for the logical to ino ioctl
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1683632565.git.fdmanana@suse.com>
 <928d682f857556ebfa30e2cfb333e96f6be6a1c1.1683632565.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <928d682f857556ebfa30e2cfb333e96f6be6a1c1.1683632565.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:3:18::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a6ddb5-febb-473f-75e4-08db511a64b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rFHV608SF8EspjDAqyWGAEQhojHz/JuvDq8rzgpvqAHHIb3QIjbZdetcemYYgs0tSWpM7HjbHt4dMKh7Sstp1ogpxHs9x9pRDOmeLUGQg6VOM6D2JK7SEfjKt9K2hJMuSeINbU8RIBY/hfjml2gN7NQAotfj64Rz4PPLPF8r/6IKQGRkr/lTxyo5z538jxVb9NQfUj5FKChfz9yTtR5SSGNwY4lUVfu9mgVEr96uiYjLPx6TX6Tb89vrFPrQlVTSeJ0epWMVF3zvY20RubUzaHudLBg9UZ6dFN2YDiUNLo7cPQTp4kHhdwgXLmO+K5TKkm0lr4YhEXWlWRgqOgAOL1zBBkSKNirw3D0xx0Cz6AQs3dShNXG6PEMggu6pWsAuhVxaqGG8QaOTEOr4gXBNzsxA37sD48vj7KvR0OCjIdw8dv40PznXZmgWSzK4/vXrCL/5ixRS/cDq7k+QzlMbp3dF6QGoqtkkAnzecDkr7pUH4buleAQMpxbUjsUuwgYnWhOArbeYMgSkfDbdVNWP/0KckodVpsYiHis6vYr8R06e81Obb3jwQxdFABQ5Z9xB34SIwyJ2PL2uVkQbbIjuiI0O+Q5C/tJMh9daoorMNVXXsFZy8di6Y3QzfnuvNTi0613v3bH9duRBOOU62NfvHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199021)(6506007)(6512007)(4326008)(66556008)(66476007)(66946007)(316002)(41300700001)(6486002)(478600001)(31686004)(26005)(6666004)(8936002)(8676002)(5660300002)(44832011)(31696002)(86362001)(186003)(2906002)(558084003)(2616005)(38100700002)(19618925003)(36756003)(4270600006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VklPYm1FWEpWTmVTM2IxM2drbFRxN3pjLzZuaXV1akx6aEZmQUtrZlhPTWlI?=
 =?utf-8?B?UTN2Q0tUeldpUWZXL3hobWlWOHBydVNqQUtqZ1VhbjNVOTk1WHZoRm1hN0JM?=
 =?utf-8?B?QlNFYUNtL1dETVB0d3RmM2pJeEVmZ1pKYWdCUUpXa0w4TFRBZi9zbHFIVU5F?=
 =?utf-8?B?dnJiOXJqNUdFYS8vUVBzQW5pZnZNSHdvT2pBNTV4MDFMQTcwckkyT1dXTkpq?=
 =?utf-8?B?VVZyYTdtUDVTT2tDd0VNMzVvcmVlSHFmUUx3Qi9yZFFzV1NRc0RUVTB4VkF5?=
 =?utf-8?B?clpFbHVqQW5xZmVxOHBrVXU2ejR1NC9OUHU2Vkx4SEV1emZqN1M4dm4zNnVw?=
 =?utf-8?B?MHhvVEVTNWxUMGNZdFg2bHJFMHJYcXlLazhiZWhydXV2TC90ZUNWUE9XQVlF?=
 =?utf-8?B?R3RQemdkOFBPa0oxbm5DOGtwMXVrU3d2eEtFN2JIbldma0MwZUxwUlV6STBX?=
 =?utf-8?B?cUhGRVlNMFJMY3N5bVNpRktLL0tuelgvL0JJVW8zWnBDVWNOcmZuRVJsZjJp?=
 =?utf-8?B?OENkOGNubFkzTlBFOWhTY05waHhuSDlLcjRIWDN5VlY4UnBoQUV6R2hIK1lQ?=
 =?utf-8?B?TUN4WnRXcnVocjJqVjhMY3JtNE9EQlBhWXg2bXZCSGVBeXVPUXM3Qm1PR0F5?=
 =?utf-8?B?TDZ6enlnTml4LzBZaUNmeENjdFpPUTBkZ2p4em1sWVppN0U2QVUrUGw3a0tV?=
 =?utf-8?B?amM5SjVXWTlrR043djhHdkFGVlNSV0NzMmV0VytSYlJKbEF0VmY5TDNyT2Fy?=
 =?utf-8?B?LzVmeU8zTThydlcyeEFibDhMM0E5ODB4YVd1ekhZT2dqcDVaNjI5cXkrc0g3?=
 =?utf-8?B?Mks0RDlTdUs1cWlZNFcxRTg0ZENoajZyaTYwaVNTRUFzT1JVQjdneGhQTlR5?=
 =?utf-8?B?ak5leldNR3ppRnhHdDcxSEE4V01iSHljMnV0NXYrM3lVTlZmVWRhbzhJSWtB?=
 =?utf-8?B?ZmhJWDYxbFJuWEZLMzhHVGI4SlRkUCtMQ0VrZ0FxQzR4OFlZc1hqVUJ2Yytt?=
 =?utf-8?B?cjg5WTFiLzV5RXYrWHZKOUphOStSSVppYUh3bUlGTUtBWFBlOSswZVA1NFNU?=
 =?utf-8?B?ODBPUW1xUFlkNmNlQVMyVDJNQndyMWFVVTJiRFBrMm9TZ0tPK3JlRW44RDl1?=
 =?utf-8?B?NmlnZXhUeUwwL3FQMy9QRlEvQU1ieXVwZ1IzNlNEdEJDbUU2U1BsaXE5d3dY?=
 =?utf-8?B?c0dXZ2Jad25hZ0k0d29DM2x2QjFlNEpLRVNNTnZRYnNwajZBLzhvWnZWNEtG?=
 =?utf-8?B?bmROVU9jdHMvdDUwWTQwc1ovTFRwRnRqeDhXMkdQejVFc3JMVE1BMC8vVGJt?=
 =?utf-8?B?ekxScDFTaUtIeG5zVklWMUk0MWdwbEhMM24zOVE2YVRkK2xTZUdZM1BkMkVS?=
 =?utf-8?B?UkVvdFAwTGZOMEluYXRSUWFKekE3elVseHQvY0JJc1hDVU0zQm5kS3JFeHNy?=
 =?utf-8?B?ZCtLbllWQkI1ZnFwbWZzTitZYU1CeDZqUEg3Z1Y0VHQxNnJpVTNqZXhOREU2?=
 =?utf-8?B?SjFyN0wwSjRNZjhHcENCb0NQTXlPbkxLdkd1LzltNm5GU3ZKUzBJVm5PRUk1?=
 =?utf-8?B?clFsYS9CV1ZNOWh1L2ltcUoyWnRYc04xNXZYbHl2aXJ2TWtIdmxmM3dkNS9n?=
 =?utf-8?B?OHhnZWNPSEJVenZDTitJMFlZbi9CNGc5cTlLYytnNEtsbWFSaGRZdExBSW4x?=
 =?utf-8?B?blp6RlorSmVvdzhhaHhhYzhNd3FzZ1VDc21ZZ1ZLSjlsckd2S1Z2aXkzdlUw?=
 =?utf-8?B?OWNuQy9rL1o2cStIRzBzRFUxVWkwaVJmRmhJMHRiOHRuVHVYRFpwZ2psa1V6?=
 =?utf-8?B?N3FRQlE5TmJGTm1wbDd5NnJKMXBqNWR0QUhUYWE3L2RXYkRVVkc1NzJtWS80?=
 =?utf-8?B?eUR2OVdJVzVEWko2Slp3QWluN0EvTWVkZFhrdGEvOEFmaDE0U1J6cGoxNHZS?=
 =?utf-8?B?SGdmZFFQUlJlZ3dDelJzcEV3R2hvdENpMTBCamNscTZCTmJjbE1xT0taVlpG?=
 =?utf-8?B?VnE2VGxEZ3BDWThrWGM2dHpJcTVlcUdKRDhxMTJVazVQM3Rva2owaUpQb0ZI?=
 =?utf-8?B?alNON2xtdzlQemthdGcwaVRDeXBvNXFId0dmaDNzNGZOeWxyWUROV3RFZjBq?=
 =?utf-8?Q?+POIaqBTpMDlb+24NSa7wNokj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: plkLO5bxWY16HY/WjiPY+H92+hwoDYSGWq84932kgUgF9ZYmNbTymSVwjzTIoPMsFy4jBe++wX7mAIKZSj+ta4ZUob4qJmI3SgIjxekbOF9eowODmyCoNzbyO1ylOWSuvsIy+luAyfurr7f4TfKURWM3g7j3StaD1osDr3aovnT3FG3D2yTJhgfYspoPhV0O83hdcdqQEM2ImE2RhCHqV73VyTLc1ajG80XI5AoJ4s7nd10uiGhssOYtENNJLXWXuHRZHba6yrC43WNRMSlP5++RW5YvwH/pVAYLSpzO3A6TF5QI+PEKLFGd7JlJtqKuEX/7c5Ea7zU99vyr+V0eTl7e2xaXvx3YzkG+B73SI6MGmC6B/Ecooo9DrzlkOhnAtY0i6SawAWrvxSvBzfnskosyIRR5kq3Ve+i/yzGs2MtGC5RJeeS5mXf+HJsAZEoTD8UmoBQEqjZMNTrn7SaCuu5v9ulsZCVlIBawA4al6r59G4tPIAL5E9TWo/sK4rJRPVKOR8uqCsZ3u9wLC/G33prpk/VieHZ1rvBGCaEoum/Hh6moOdGWoDtX41sV4tQ51xbtYlyKZIPl2GuXHXv5ktV7opnxEu5MJQdROQjJeYAlqKXt/8RY0tPVS3nYEEk9VT61fHY3nR7ho5W4KzoAFydnIRsMoLXhQbm2OUIhuk+maDUvnI7mbKGBGeo3kr8eo0a9UN6DDeQ1mYOf8KZbhpLpeGGTCHWWcqqgxBFfNJ3B3vkBmrEShAHaqSGqv9Ew3RCsZTfx9MZBXixXuR2doXj1Ivl8ZDpBLm5rtMcAU0aX1R9bbTHYRSyGrpWc37k7
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a6ddb5-febb-473f-75e4-08db511a64b3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 05:50:00.7224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XM+RyOPg/A0GtOU/tBsubRzqUFtHTojBnW3P1+Nab55q6FWzAQ4IWjQ1w/V0BnIm9QizSmO7EjWnVDDN9ov22w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6791
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_02,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305100045
X-Proofpoint-GUID: 3D7K1kXqYu2TyE3GIMed6dO_i3_ELvZ_
X-Proofpoint-ORIG-GUID: 3D7K1kXqYu2TyE3GIMed6dO_i3_ELvZ_
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

