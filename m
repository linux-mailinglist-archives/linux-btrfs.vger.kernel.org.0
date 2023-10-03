Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527ED7B62CD
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Oct 2023 09:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjJCHtr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Oct 2023 03:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjJCHtq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Oct 2023 03:49:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1A0A9
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Oct 2023 00:49:43 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3930jRjG028533;
        Tue, 3 Oct 2023 07:49:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ojkkB9AAYhWlW5LENN/RnLAk2jNmfhWKE+pmMqIj4sU=;
 b=JsJA7RW45nWzsh2ytVH9r3aKAVMfok2Ee0mXsa2e9TKXJ7LO8y2rTvE6sZSNg+GHItOd
 xQdE8EbFvqGSzy09EDsqSH2PLQnNXh+kSNRDfCzNE22NxqCdy525K1Ax5SRI5YwpCugs
 NoJujr0SowVZ4akkX/t7Hy5nKbqUr6ySMMg/5UNZmfaeeSq+F+M/gBy91UAhBZphB3Xo
 m6vJ7QVPQOJSpg/BHaE+Vkv79ou0qDra73/VZtufc41w+gA3f2YXktKu1DA+oQUM0/io
 69Xk4tt6SVuVEMK0zbQLckdSXSu3xJqVGf939tHeJ+YUoCX5bXf+PvmJYN958L6g+zqU yg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tec7vc1fu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 07:49:39 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3937lPft003140;
        Tue, 3 Oct 2023 07:49:38 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea45k6yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 07:49:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atJM6jPqLILk6RSPeBDn/JzCa4T9tILrbzbE5zn84rwzPL4kDSXVhK/dPZHkJMYPgrxOb4asr9509DYd9+KnJHNzeervl0ukFvCs/rs+8M+ys2e1h0ettS0LAqdkH8Jjw3tFDkaMOrX/S2TxwKKVkbYDTjI39mTuAt7DuCGxebh/1GxGGS4VhVkISYvm16+j32rE7XMKXSx4KBlFfj7G03QpFLMxD54Otx8VENO7p3QxJmjH8sfmGzozC/lPKC/dv5KsqtgErhhZaIatGHHCliNteaQMOzUNGaMUluDTmCaG5jEPJZz75STIXYsqdMscp2s/sBzbcyzMXLO16bN/iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojkkB9AAYhWlW5LENN/RnLAk2jNmfhWKE+pmMqIj4sU=;
 b=MPj70KzgdIlKA5AgwPlLmsFLOZ7tPPDmiXvO/OMC4C1kO44WHehQE+ZDjJZnYU0tVmKAnvywW8l+VosakQIu3SYNr8QJG3uuTM0YDyptLUgKTVMsTQVSqSWHPsd2Gv8CGoTNxwPt77c+ETugAGgDq06V97EzXzWtYS7Dt+VHxoHkacD+n0cMx/YldVBytECGIn1IPXlCpws5a9+QRyM6tf414dUmNRghH6Zy/ydEQk86hL06JzI7QansGRxpeaFqZdL83gd0Erb7NcFCwntYxZWDpeGEsXGyTd8iBrVM3dAdhbyzkJP2V7s2oe47VQR9x68F1dyUUUDtLMBxZ4U17w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojkkB9AAYhWlW5LENN/RnLAk2jNmfhWKE+pmMqIj4sU=;
 b=N4joDbHJ3xwn9JiYCYoGj5gOykQtde7uqryQCq9vGiprMNnUsEbLMtCFJAP/hwJVtFwyUN4b8EewSXNwtH3eoADVh+NGM6D8kZFKKR15euPvnxU9uyqxxpS91VNVP7h+rz8dBF6kst1Y9C4/s504lzSM3fEEIoLhWJmdNyEY010=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB7288.namprd10.prod.outlook.com (2603:10b6:208:3fc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Tue, 3 Oct
 2023 07:49:35 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Tue, 3 Oct 2023
 07:49:16 +0000
Message-ID: <d433f793-3277-f07f-3bdf-2a60301aa234@oracle.com>
Date:   Tue, 3 Oct 2023 15:49:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] btrfs-progs: misc-tests/034-metadata-uuid remove kernel
 support
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <c4d569b4e92cbc6ca2a7bd87e0bc0df1758bbba8.1694525360.git.anand.jain@oracle.com>
 <20231002171050.GW13697@twin.jikos.cz>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20231002171050.GW13697@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0125.apcprd03.prod.outlook.com
 (2603:1096:4:91::29) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d313c8-8037-4dea-0595-08dbc3e53e02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ulgLy9hSe2IB+Ee0Y5HLdr3V6+lPKW2ZeQlGqi70uY8LvT69lka3Q7tiGKAauJ4EH2LxS859bH0gbcCgGYmyoss7wuIYwRM7ARga/66QgBpQPunxsPnQ5GxSvx/0LVIn+p2Qt0EFwcvPuYnMGj1B1KVPgwYTnxEhXODwzqzF8K7vSzjx8zZeGge7sOjWLGyNV6mR757/FIatJdminW/FVoour1qOqqyAC1tt79XFb0DpLd1axEGhrNg6Hk0wQsqgjvhCWBh61e7pp66/A6BXfBgXZ8m9I4HBImoJ14ttVKwHbYFi5C9Kze/dTdm57IV+8FYxydUdHMIfee2+X/5kgw2GuHLb9y66VA1y/aw+Tg0/HXK6fcs5KjHETS7zHiUFRapgRnfD1FphCqk7wvR24s7JXyfWCUECuVJWR5hxZt2n/XCMctpgZJGivAMRR3vFNTzvY7TlxkUE08wg65CGyfA/sVFqmN2VT9uKrStp8BIWBdjD1Nu6AnPdspZUHYggPVY5jMgz+2gwGKO6EZyDH6addCPgw6cCuup9iGAlNn+wYPJkcX5DIBAJHOrzZK7b84AM6XlgRJh5+iteE5MxtOPijeG0O1JvbmmQ+wPPXto1MVVzIvotRGuMFD4vu7ARamzT42I25qQTC1xaXE0sbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(396003)(346002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(31686004)(53546011)(6486002)(478600001)(6666004)(6506007)(26005)(38100700002)(31696002)(86362001)(66556008)(6916009)(83380400001)(2616005)(6512007)(41300700001)(36756003)(2906002)(66476007)(5660300002)(44832011)(316002)(66946007)(4326008)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUpkSkRnUGFmVDdLV21XbWlGeHpXblFBS2YxSjVXN2Q1NzQ3SkVob09HMnFl?=
 =?utf-8?B?QU5mbHd4VVkxVGJEOEJnVGRkZk1IWFp1SmQ3WGJ2SCtZMTVROEsyclhRY05G?=
 =?utf-8?B?dUlCNW9kVHQwTjZqZS9pNlFQSVhIVTZVSVB2SmwxRDNpUlpGRFlLbnl6UjVF?=
 =?utf-8?B?RS9scWhPR3JrRUo5WC8wZ2RpVmtnMnhudzhzOWV1S3VXNlljeVRqcXlKNkNX?=
 =?utf-8?B?b1FWVnl5QllSZXg5Y01iVDk5K1hLbk1QcXFPR2RLa01lQ0tlbUhDZkhKdmhr?=
 =?utf-8?B?dG5MR0VyRWhtRUp4M0RTTVp2ZWI2bEU2dWNKaXNNTGZvbXpkN2NpcU5uaW1J?=
 =?utf-8?B?b3A1bWNBVDNTeWxKNmkyaDhnaitKakVKN2Z4TFEzY3V4L0hCWXowNVZmQWxk?=
 =?utf-8?B?REROL2ViRmhQZU5DcHYzZUlpR1QxOGpmSmJjWUxHWmtzU1dZcWM0RmNmK3pk?=
 =?utf-8?B?U1dBeVUyejdQRUg1TGt3dGZhaTFUWGUwYXY5MXpMN2kvVG4yeThRYzVRT3Fa?=
 =?utf-8?B?OVFCVjVHdklQcktycGpqcnZDbmJSNUZWdHJQbU1oUStiM2JOeUg2TGdscjhU?=
 =?utf-8?B?ZzNDMTFyZXRjYkZjelRKaDdSaEdvOVgzYjBJekJWVysrV3E0cFlDUjFCQ3kr?=
 =?utf-8?B?bVJKemxWUXh3OFRWaGcwamtQcVUxTy8yM1ZOeFc4RFBoNjVvTFZpYlg5OVNp?=
 =?utf-8?B?NzBTcFR3b1RPYWNCbGdxRTFsSVl0ZW1XWjZJakJUcmpqWXMvakxoQlFXM1FY?=
 =?utf-8?B?MWFJcklackxFSUJLanJpRThtWkEvaFZqa2VqWnhNQUJudXY5c2E0aVQ1UXEx?=
 =?utf-8?B?cVdOY2xCcjZWYmp5S1VZczdhMWI0N1ZnOWRscU5VUXZsdGR5czJ0Y3lMVTFM?=
 =?utf-8?B?dGpFb1Q0L1dBam1FYXFmdWlnZHMraktlYkJ5SVk4ZU93ZEpycWdkL3A1YnJ6?=
 =?utf-8?B?enRVNzlwVE5wenJjZWtCSSs0VG5GTUJsYUtKeUxKbjdLdWwzQzl2aVJUVG9w?=
 =?utf-8?B?RWpySWo5dklXSnhtaWlHdUpPenh3eU54bzlmNnVoVHdlUEdEV1FzeDdHVnhx?=
 =?utf-8?B?S29EMXRBVVl6MFNUVnpGTkhvSkwxNlJDZ1pZTVBXTWJWTTNwYXlGTi9BRlZm?=
 =?utf-8?B?aVNFSjdqM3U2bytmcG1nRnJ4MGNsakdmK2RyUVplS1NOVmliVldETzNBVVJI?=
 =?utf-8?B?Z2VrVFVQdE54NDU2MzZLeENLcU53ZSs4dmEvcXEyNFJGYzF3SmZMOUVsOWpu?=
 =?utf-8?B?cHdQZytTMmFwYllCR1UrQUJaV0tyaFh3bFdpbzlTZEdoVWc4dCt3MFVFZ3Iz?=
 =?utf-8?B?dVI3RWtYbHZ1dVdaY2JPd2VPblkxWlpiWnJoaTNrRTlvdHVTdExhdnJJdVc5?=
 =?utf-8?B?ZG5EbVJtSmhPa2U4aTYxdTFJdXRNTDl1Y05kZ0dQcHB4UHQ2aW1sb0pCUzYv?=
 =?utf-8?B?Q3JvcTc0YmRvanRXM3dCY2Y0L2dmc1NjZ1Iwd09zTHUyUHNISWo5cjlMb1Vx?=
 =?utf-8?B?Zm03a3BiNFdlVjJGU20rUDMwc1hxS21xZVpEaFNJZnpYUDkrTmhMNzIzalJN?=
 =?utf-8?B?SFA5Y0ZkMVA1OHNxU29Vais4SGZpTVhwSll3NHpTSmVQM0lTOElxUzBpRFNm?=
 =?utf-8?B?S3prQUhuUlVkOHBLd2hHbjc1QWhnTDFIekpGM2NMend3ckRpS1BPNzdET0lU?=
 =?utf-8?B?RWNkc2N0S1RaTzY1YWtEZ3Qyd1FQdmVoZ0JhWkt1TjBuTVlpRG9DVjdNaTgr?=
 =?utf-8?B?SmxKU2ZadGF5cURNWEU0RHVLSVN1RTdTK2x0UTdFT05rS3lyUFlLd0JYRDZV?=
 =?utf-8?B?OEszQjdpVExHejVuUDQ1ZkdOVVdOUjRFSFNJMnJrV3JuWFpIdnZjNmlYTzho?=
 =?utf-8?B?ZTJ1c05CelZGLzJjWkNvWjJWSWdUOTZ6Z1o4UERjTHVSWGRFYlZqM0NTV0ZZ?=
 =?utf-8?B?TlE0ZkxWVnI0TmFVakQ0S3k1YWVGT01mQ25UUlpJMlJnbkREUlpIQ0hjWGtl?=
 =?utf-8?B?Nkh4c1JsdUZQVEtMdkVnY0wxbHB1aGM0U1ZLcDdlRUZTTWJTWVpRQjB6R1p5?=
 =?utf-8?B?cWhzUXNvMlAzSmxmMkVaMm9UODdyVVhseTN1dnhXZStvcFdpL2NLak9ZZ2VE?=
 =?utf-8?Q?fQyASucfkcljToiKaD2OYMRV2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VXJhV1psdOJ4BUxWlQ4jb7qUtwAhsZ1BC8DxK0OfsN7tvf7YbFtHZoUu9PpuGx88YDSBVXzBGt5V66vZvO/i5lb/5H/DvOr/4quIC+oXdx7VSORLaWK8Rk8uQmS/jy0ChMFm8irjuL/VMVjf1jRLqWg+rnoC/jVVcuKavIlXodmjEp64ZWL/qxZhF/bI49xw8cFWaGa7Scm+4rhEqAuLTzKC1mUqhtHU3wGWbUlFGKBQGRWFxhUU9weWZIlHKVs7c20X3lVCr0p6a+p39IKOP+ZcSQZETKBespE4n3aTw40wRCm8Eu6grZAaASUP5hzq+LbwTcqlp6gNL21Qk1/3YvHJvsHV/ywLB46V0BzCc7Sikv/5S3QUoCgNlv2KJKh5VITe6ePcTqIcIkR0hQhw/BxuWEJggYW11IrE7tmJRoLOw1ZLZQ+0AhsRTEbYW2jX6O0UGeuKI9UBsz3u3wGw8GqCh3fYNY46KPatg5SkU/2DQfMUKoLPpOywud0Y8Zx1T7NPoU8q9FBkeE97lA5Dbfyxf4nLYfrHjal31e05MY68CybA0U6mFf/B54cJWmJ3gh0FsRg5XWMsCrTnqsZOVe+fzqA61IKyf7q++op4J+mZDkWnlCjiMHF21uBpGbsNwWJFEQ6ttqODEw0c16YLakq5bW/qnxp1wYg31WZVmjMqp+2oBFCZezTvzorUlcwE2jqI8Zpv5sC6xz36HCB39j/HPZF/Q7JzEq6oF9AyQGC4bD7TnEUPq6smTgqgoI85RbHyTx4j1zEnYTGv7NexBSJKZ7rq2+mHbAypFe2L+xU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d313c8-8037-4dea-0595-08dbc3e53e02
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 07:49:16.1894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Ob+/L5JqdDh7cJkVOGFB8cqHruKs7pXQQ0SOLoeL/QyO407cTE7NJHDZDcTCu+k02Bhxik9hhiavNaQFCj9HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7288
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_05,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030056
X-Proofpoint-ORIG-GUID: K-OJ4Z1g5EZsNQeoS6ZnJ_-4mKRn2nl6
X-Proofpoint-GUID: K-OJ4Z1g5EZsNQeoS6ZnJ_-4mKRn2nl6
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

-reload_btrfs() {
-       run_check $SUDO_HELPER rmmod btrfs
-       run_check $SUDO_HELPER modprobe btrfs

On 3/10/23 01:10, David Sterba wrote:
> On Thu, Sep 21, 2023 at 06:35:10AM +0800, Anand Jain wrote:
>> The kernel patch, ("btrfs: reject device with CHANGING_FSID_V2 flag"),
>> removes kernel support for the CHANGING_FSID_V2 flag. So, drop its
>> related testcase.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> Apply this on top of
>>
>>   [PATCH 0/4 v4] btrfs-progs: recover from failed metadata_uuid port kernel
>>      btrfs-progs: tune use the latest bdev in fs_devices for super_copy
>>      btrfs-progs: add support to fix superblock with CHANGING_FSID_V2 flag
>>      btrfs-progs: recover from the failed btrfstune -m|M
>>      btrfs-progs: test btrfstune -m|M ability to fix previous failures
> 
> The above patches are now in devel but the test still fails because you
> haven't removed the check for builtin/module status of btrfs.

It was removed. From your devel branch.

$ git log -p 86b1e47c80d62519975eae95b39ea053a220abec
commit 86b1e47c80d62519975eae95b39ea053a220abec
Author: Anand Jain <anand.jain@oracle.com>
Date:   Thu Sep 21 06:35:10 2023 +0800

     btrfs-progs: test: misc/034 remove kernel support

::

-reload_btrfs() {
-       run_check $SUDO_HELPER rmmod btrfs
-       run_check $SUDO_HELPER modprobe btrfs
  }
