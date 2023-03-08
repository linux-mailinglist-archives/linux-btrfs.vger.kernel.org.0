Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5A76B0072
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Mar 2023 09:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjCHIEY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Mar 2023 03:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjCHIEW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Mar 2023 03:04:22 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4587C95BDF;
        Wed,  8 Mar 2023 00:04:20 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3287qbpZ018512;
        Wed, 8 Mar 2023 08:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Uw3D1wk0BHcqo23KfznwuZA55s2OZQPyHYJE/q2GdSs=;
 b=Opy/F22xmKyTEVZsasI3q96FO3CHGgE5ul32ULLH3m88eQvv/jL+amp8YNHOeCWUK+F4
 IJ21bSffzpc5/bQ2RbeUf6oHFu1g2U5kzkmbgWn349rl7X/lCcUkQOZjoJ4s5FxmbL+k
 ojFrwhH1bspjPIxdiNl3qv98cfebVlaxve2WGr15E6RuVIKijLTvQ8PEFVgiv/BAkTm7
 HTI97YzmU3ue9J3YAX1h+jxnyjYkvwKRF+UbTwEjwEEYVau+U8O7/6cwpNCW5oHKdhLr
 4RwDEG3L/7R02whMgIpK3Br7PsVxPHG6G/nrBcnhjn52NVlw82a2f3PxfKgfo2o1Z0wS Zw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p415hyj7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 08:04:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32880Hwx015632;
        Wed, 8 Mar 2023 08:04:08 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fekwyuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 08:04:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1utz7T4g5mZkUoP38mPYtChQhM9EVhA7Bz03zK3MK7UMardWMs7h08uXs9IOx+zpWFihnCsBJrufs7H6vUmycixWugRqiaEIffkRW/WNc7EHeIHgJ0SbFp2qeieW+Q4UIhHZgvzqt3VXEmGWBVLeh5Qa4v/btbhcMmYxWHhrduJDPVqZVGgoAJw7uwwtHcU/mJc4evinszQywg+pKf8GbiCoSV7aZmJpbtRCRclELEsZVAUfVd4ArdHaVm+4TWqvp2Q4ICaO4YQRHgEl9ekzPf7WGCqiU812IOWus3vus1sIUmSmrnQlGkicKkTiLlIKNy4nMYo2R6wdAxmIuntzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uw3D1wk0BHcqo23KfznwuZA55s2OZQPyHYJE/q2GdSs=;
 b=U/vEOnXlGqY0Qn7zESExhgxHb2QWRZzaM8XwEAfVoisi3mXWP6Bmbv2f3rLykOOXnnIBpDR+ILociXeU33fAdcZKQhfwVvrLIp2U01RSAvFb1spQAffgOzaXGVvlJ+IJZ6PADMYGTfhjMMAlY3A37C+DksaVlUTfVMl4KddVQWlRFgZUkFIVR9fwnLlu6cvCQIaNMltzkLmG0bsZlAmDgB9YB890Od28RVF3KAXuc2P1ThO5bpjLe2zrXTLfa/BYf9EW3mYzP8VQH52gdFS4E7SkxoJ9lUb7BF8Z2sJzysAMkSnGEnuwVhtGK3nLtbfSqt0NJqo7v4r08Lh+ihIcgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uw3D1wk0BHcqo23KfznwuZA55s2OZQPyHYJE/q2GdSs=;
 b=SHO4hE/DiYJBwuUsqt93nodLsfB3ehReJPJXkOduyXTm+SJpEF895C5eyFmPvdZBt58xYmmUBgvjoaB4bUjA/Ji5GFFAc6FxTz0H3+X+o1FbUs2+OL88pBlvxUNKH7H/Y6JzR3aZn/EG9wsVX6yG5+zm+YWxc9vGojsFVcwqNDM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6197.namprd10.prod.outlook.com (2603:10b6:8:c3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.16; Wed, 8 Mar 2023 08:04:06 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6156.026; Wed, 8 Mar 2023
 08:04:06 +0000
Message-ID: <5a542a82-b47b-ced3-97d6-a38b6e926522@oracle.com>
Date:   Wed, 8 Mar 2023 16:03:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] btrfs/284: list a couple btrfs-progs git commits
Content-Language: en-US
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <7be1169e950b807f24e4b2ac33177e44fc13e434.1678189053.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <7be1169e950b807f24e4b2ac33177e44fc13e434.1678189053.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0186.apcprd04.prod.outlook.com
 (2603:1096:4:14::24) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: 86ff40fa-2c52-478b-6303-08db1fabafe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ZC0Nm11UmFuJE9kz3k73JR1tfSDjYWbaYbmPLdTvNAVqJ75S/NaCJggM95EemWxeppneyiburYFxRbj2G/E8EeQMrkLxEUDQ3ubAq90ymaWca63laVUFXlLRM8U0ncrEj8zL05lIUX4epKxrdXAc2/eThtqBHaW5w49b0tSQWxTI3HIGhRorcGbAQYnuEJpnCbMPZjHrH6vLCAbPwYy7at6WVhquDgs6Z1NKy9NRWUWVAHXVC/B9NfG4Clxaj2IivTAgqOetcJQsCJkGZpMZTiutY8FunXJyT/KRjYzLXrJF+Q1pUOSszO1lW1nnlHLV6FW5y3b1hd2yIrQHKxRqh2EfbHGZNeOm2g5rA938aCrX/ZBhrlFuIWUok6yFddYvjKZdocY2zUEeledtPyOeDyMptlk+Dr4y4rpoAQ1BriKI7+A77/oIJcCexcNu03kbEwDsbVgWa/WEcWpJCfqZQ1h3PLPT9n5FOqduLpdcb6eDMlP/eqHC9Nc40kC1ggZ8sltQB/M5pi7hagm63YV+dt+AzkmB5diUtqc4w8hELNw+exqyRG8wXhszU+4RYY5FYMQzdGtWoGrUkcOvgH/mQLwcKysp88abWLfkY4i2eZB0KgyP2zpeznRsgBmbcDfqdwWyJAjX7REq3HFBdEk4PenBr6vYXeixq7hTl+XRvH1oHVTyQKGTSbXalvwbFs0VRgzyZc7aPUmWGRlwsO5gD9Mw8gbV9+2/Yxpft454CU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(136003)(396003)(366004)(346002)(451199018)(478600001)(6486002)(6666004)(53546011)(6506007)(31686004)(316002)(2616005)(6512007)(186003)(26005)(66556008)(66946007)(8676002)(38100700002)(8936002)(66476007)(44832011)(5660300002)(4326008)(41300700001)(2906002)(36756003)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3NncURnakQ1dzlLTEY1c2krTGtUZlZNWnFiMWQ5eTlnbjRCeWg3MDhwcmFs?=
 =?utf-8?B?QUQ3YUhvcUM5YUFWd0pUOEZUTlVtWGlkSUdWSmNCWW5lQ2xHMGQyKzFGbHdF?=
 =?utf-8?B?Q1FsVkxqdDFJQS9IMFlYVmVGRmIzS1hMeENpUnlITG9xQ01ibVJuZkxrRE1h?=
 =?utf-8?B?ZjQyYVZaZlRyOHlpcllNMWFTK2ZkWUFnYVZZN0ZteXBoVkNvNW43Qm5Wb0ty?=
 =?utf-8?B?bWdaSHB5UkVjWFlFNjkvUVNsMVlvSVBTVUxSekhvVndnVEhQZks2YjdiQTQv?=
 =?utf-8?B?bEUzVGRaYjVEYUtkOFBxaHBtK0plZXJQdklLaUVIR1p4UWJ1T0FPSXI4QnJn?=
 =?utf-8?B?N1dvMTc2TFFRUWEyYngxTlJBa1NBTVlxZnlsYlFPY2JWM3p5VXZaV1RhWHF2?=
 =?utf-8?B?MHd0cVd5SEM5V0FTUHlGTDJ2Tm5zUTZwaGZrVzFEbFJJN3VzUEZ2b1VZTU9P?=
 =?utf-8?B?aGtnME13NWRoVlZwYXUzT1d0bk92N2hCS01IUGhPYllCUCtDL1BlSXFqNkJL?=
 =?utf-8?B?OG1ZTjBmYlc5alNiZFFNUU9mVlBod1pWZU8wK1lLb2lIOEFrMnNFYTZVWFBu?=
 =?utf-8?B?Rnd0RUtJSTlYaTVoQWpvUTBaWUpNMW1GOHJQUzRpQWJuemFHc3J5bitITGNq?=
 =?utf-8?B?dG5yVXRxYWxpQXkwYXM3cWhXemhoQXJxaFhUT2ZoWm5VejBkcEZnb2lrRFE3?=
 =?utf-8?B?ZTJSMVlWTUxpUGpSanI3V1Z0YVBaRHd3YTQ5c2hBMVNqU0k1SVhFakg0dXA3?=
 =?utf-8?B?SDYxdGUyQTBOemRyWkYycXdnblk1RmdvUmlpVUFhbVdjYkRXUHBvbC9wMlNw?=
 =?utf-8?B?aU02NmRuZFRBbHZITUNJNXlHWTNXQVhPNjkyc3BmNllPcStRVVRKRnhSWmEw?=
 =?utf-8?B?K0Z4aTNIUVh5S3JzaVZiM0ZTZEU1UElEQnNaODBkYUxPbWszVnhXS051UTBs?=
 =?utf-8?B?OFhSdXJVTW1hdXQ4VmtvbGtlMHVESWY2MU9ERDgrVFpFWTBWSjdKL3FNVWh6?=
 =?utf-8?B?NTZwVUxKM1pRUGFNVUlMd3pmbW5kRGIvSGkwZjNLbENJdFZXejhpK21Wb1Bn?=
 =?utf-8?B?NW5aVnp2WmtoYlRMNlgxYmo0elBUOVB1MTN5VXB2ZUlpR0MxOFBqdEx4VXNN?=
 =?utf-8?B?alpOWTFvRzJkS3BsaWhxYzRqeVkzQ1hTaXpLdHpkZXpQaDdESTNqNUlyRDFh?=
 =?utf-8?B?M0krK1FOaTFaRzEyamUwNHc2U3dSRzFPZEpNSDEzWk1Xb1pKK0NVamhnL0pI?=
 =?utf-8?B?THh1VFhuczZrMGlTdnVtNXNiUURXdGVzc0UyS3RhOWpubm00Zml1TklrZ0lI?=
 =?utf-8?B?UGJqSlpnSHI5VEhrZXJuaDNIR1R5b3BFRitOMGtVRVZxWmNycHhOMG1XTHFl?=
 =?utf-8?B?UUMwRTFGQWY1QkhzTlg2aGVuYkNIaTNRK044MEpueEtmVnh2UENjbjVUZ24w?=
 =?utf-8?B?bnk1Yjc0cmFZMUZENWVjSmxhQWZDU29FWDk5dDlPN1YzQ3hTempocUZmNlgv?=
 =?utf-8?B?SEJpVW5kOHRCNm9NMy9xTFlOQUVIZitVTFhWTElRVW1mU1R6YlN2U2N0Tks0?=
 =?utf-8?B?aHpJRUVxTndqNng1MmpKUkltRFN6U2t0bHR2OE1vV01XUjM0am9VaVBnNE5q?=
 =?utf-8?B?TlI5Tng1RlQ0a3V4aGFxcHZTQzBobVpGNFVhUzhwQ0Zzbk9uaXBIWTFDUGpO?=
 =?utf-8?B?K0JCeFFKTDJZbjRNNnUxRE1NeDIxUGRvOFFiZlZGWFFSSW9YUzJUUEM5V2pw?=
 =?utf-8?B?OVRnZ21DK0xSSXZKSUxuT2xZaXpsL1VYUUVaZUpNR2NhUzFJc3NZdU5PbHJR?=
 =?utf-8?B?VDE2ZUhPN2JMZzFBVkZaRWY5UkhpV3N0Mi9NK25zQllWakNGM2RMK0JrcnFE?=
 =?utf-8?B?SjBFenpKK2p0dXRtNTI3KytsejJaRTVTWGNselBIS01Jd1ZoTkRUN3E1K25I?=
 =?utf-8?B?NStGdmtybmFmVGxBL1JxNXhoRmVFWnd1WjFNaHdKNTN6c3ovWjlLdG9vRk9m?=
 =?utf-8?B?aGdzQWtPcCtQWUdJYzdGcUVkZEswLys4bmVkWEg4RHlHNWNTTmNTNndLc08y?=
 =?utf-8?B?STkvM3VCenYrRHlUajB2eHZqVGtMQzVFUHFTaDVxNmVYVmZZWFphSCtlRHRQ?=
 =?utf-8?Q?qBPKoX+jrJ9iFrD+gXMv3yb+8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pdhjdrpIKAQYFsqINyJdE01sQ0bm5c3nzR0FbqNPf0fyTxLRymY3DA47hvM09Z6Usr8z1gfQjfaFxQQU7YP++ME2x4AOY5KqaJVA4F9X3nR+34Y+WW98mfYFd4nsKUYKZwqtqJ2moyb8Dvn3bsB6ClP5vnFsd9C720sQ7LfQitkZNBqBZpAQuikbaWzWt7dC7Fgoc2L39oKQar51gmXI9Yuf+AxEfo5cxMqGtLmnbnCrNlwB2iXpDvpNSs/uCMkek+HeYAHpxaHPZkIINO+Kx3BMAoqWqAKPNduRXffnt/vQk6Y/WS3N0RSVkwS/l1gqlDlkm+7kJEuumcrQcjOm1WZua7dDXAk0A8y0wSgbrhn5VkbiBWGEs7KJc25zr4AuhexCjQZ+pEIP4Tjh85yLUqM6grOzB9ehE3Le66pj/eIaRIAgQzfP5NUaHVMwL6hRCzspVXr8BLA+tAYvGCzZzZKazyj9gHyIpkgldRCm2FOrfznmt35uzMhGyrZykKIJy+ziSoX4cFK8AzCFg7qzqQ97s1/jO3HU/tOvYGMrn1WHGF9yDCy9Qk7Ct5O2lPUp0egzuDQElGhrrreKBavJadWPkCugLSAr3o6qHcLJW3I5ZX4gvBmHjLVR/k/au+E0IKVv4+k3S1NMBUiewIr+IeGDwGEhyDAmGuGgyxld7mVIHzvcUjYDA/XUBxk56xYN9XPwLYFXhei/YG/RuSLQcRC+OL8EERQQ39b/3O0oXP4x4d1KUWECViTszToUiqjugSE9ByRiOHdNUDd9c46jg7I0dCQ4AYgLioyLFtP/B/LzujcTiwWFHPq029ADL8XZ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ff40fa-2c52-478b-6303-08db1fabafe1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 08:04:05.9169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6nkuDNS2sTpK6tDMdhAUtINiXfcRGSOnccfkNPyEE8qioToFynCQccSWi76FfLCDdJ1jnYeywbEaWc0qQqybw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6197
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_04,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080068
X-Proofpoint-GUID: HNOlRTgVTi7RXRkrMlb2vZtrDUPZjs1W
X-Proofpoint-ORIG-GUID: HNOlRTgVTi7RXRkrMlb2vZtrDUPZjs1W
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07/03/2023 19:38, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This test may often fail when running with btrfs-progs versions not very
> recent. The corresponding git commits in btrfs-progs that fix issues
> uncovered by this test are:
> 
> 1) 6f4a51886b37 ("btrfs-progs: receive: fix silent data loss after fall back from encoded write")
>     Introduced in btrfs-progs v6.0.2;
> 
> 2) e3209f8792f4 ("btrfs-progs: receive: fix a corruption when decompressing zstd extents"")
>     Introduced in btrfs-progs v6.2.
> 
> So add the corresponding _fixed_by_git_commit calls to the test.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   tests/btrfs/284 | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/tests/btrfs/284 b/tests/btrfs/284
> index 0d31e5d9..c6692668 100755
> --- a/tests/btrfs/284
> +++ b/tests/btrfs/284
> @@ -20,6 +20,11 @@ _require_test
>   _require_scratch_size $(($LOAD_FACTOR * 1 * 1024 * 1024))
>   _require_fssum
>   
> +_fixed_by_git_commit btrfs-progs e3209f8792f4 \
> +	"btrfs-progs: receive: fix a corruption when decompressing zstd extents"
> +_fixed_by_git_commit btrfs-progs 6f4a51886b37 \
> +	"btrfs-progs: receive: fix silent data loss after fall back from encoded write"
> +
>   send_files_dir=$TEST_DIR/btrfs-test-$seq
>   
>   rm -fr $send_files_dir


Along with this, why not check the btrfs-progs version using
'btrfs --version' and call _not_run()?

Thanks, Anand
