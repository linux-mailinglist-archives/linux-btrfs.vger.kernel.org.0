Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6496F8045
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 May 2023 11:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjEEJog (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 May 2023 05:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjEEJoe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 May 2023 05:44:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317743C20
        for <linux-btrfs@vger.kernel.org>; Fri,  5 May 2023 02:44:32 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3456YXYh011389;
        Fri, 5 May 2023 09:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=SCCdixEvSWZoQv6sIEGfuTk2XXZEW16s0lJXr/2ZHIs=;
 b=bftd3f7GnIfsCbthVxNAnU5R52GZut1I6PY3/1U6EnX2ZMdDY5nvU4TJJ2r6XuvhZ5cA
 k0+n7PO+j1GYVif4pieiz/vQVKSxi69JAh3uQAVPOT8GA05EYim3F0H/i9uDbOkDpbMF
 ni4PEJWCWCGcLuyJY9MDHOnVumSMuSvp4kAl07/gg814Jo55jdRd1cXVS1yYAsjaiJ3S
 EDh1yxLzl+xeAaew+31tTxsvyVf8EVz+K3+Oy8MiFUWPzELI1qqFzTAP5kYlojLJASnd
 kryqybi/L2ZRzVUPJginA5Y0xyRb/Bw3SgHRgPd3S1p5h/93PLkQL6Yw7YUOzi7+6fte kg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t5fvbga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 09:44:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3457XhfU026877;
        Fri, 5 May 2023 09:44:14 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spfy8yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 09:44:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9zsHaDDSROHVKK6qpe3k6tvWT6esIe/d9m7QjNduZaj08VD74nUvLk9LHqxtAZExxJuND7lg416v6qND78ldfFYJAM5sOInNCFg7gX/98R6Evv7CgcEGJF9cG5bU9iAZiPBBmdr2m8fpYmeg4NvPGNGEYueCEpwn39O8mwF/dZeh1VVMCEhp54UJEe6TKqFFuE0DD8Qf7KEuV5/lMvIrZoy2gi1WDG1khCaMBT29ts53nLBiONJvlMflCEFIklbejDWvF8zGMnGM9+XT6v4OgKL3BW3S+Wz5V/h4v5tffw2bR+s+xUlrTtQNV40TfqES6InPWAIAmDt0s+Zr1pLKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCCdixEvSWZoQv6sIEGfuTk2XXZEW16s0lJXr/2ZHIs=;
 b=Y0HfGf/5dtyKOUxWV8S5FKKs7DzT0LBSi+DL+vmSdDRvCblDcOunbcULqc1KehkoTyCdTcSjVrnG9WFkPsURcxDTL+uqb6huTScDPFvt5e4/3LTt1R3Dq6J7GLfvFujmWsgcj3GCg2Qc4kTtZiGVHrBKh8fIxAy/kLrhAQq9RmM+Qau+jnqvalNVAMYN6+mlCgoO0dWvXrSNakWpC4yB43REuKirUmdGMsoqtXGWKswxcKuIRq0KsMqzlbh8RlYS2GRAj1HpiH+7wHNhP+ENJ5dyy+GUxxNZxoMHb8ERNwhawuzIXJ+FfboJkD0l3sgua1qIjSOX9nDkVR7H5eqtzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCCdixEvSWZoQv6sIEGfuTk2XXZEW16s0lJXr/2ZHIs=;
 b=FPYiU1HotP9uNo23X2ZOBTmWfVxi4F2Ovjlw/laT6VERmjqgp5JSPqCnLh1TUAIsdw/vJSp785E9NBGdcyQMR6PT11O9Lbdd53eOAgiW4PhkUnELeD3rVWpgDSKFsXyGQd1IWszXqs/sW02g1Iuy9vj5S0WIKd7J1i5bEVnA9TM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6097.namprd10.prod.outlook.com (2603:10b6:208:3ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Fri, 5 May
 2023 09:44:12 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 09:44:12 +0000
Message-ID: <ad5909ad-77d0-6f1b-b5a3-d4501bc62bf4@oracle.com>
Date:   Fri, 5 May 2023 17:44:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 7/9] btrfs: assert tree lock is held when searching for
 free space entries
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1683196407.git.fdmanana@suse.com>
 <524c29c4f899918f9597a6ea6af1e86d99117bc7.1683196407.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <524c29c4f899918f9597a6ea6af1e86d99117bc7.1683196407.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6097:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bab671c-9442-46dd-23b6-08db4d4d4806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8u8aOP7V8IHe6UkGPvAVtXhjExltrn4E+cnMzx8x/mgkPA03PTz7xWWX+R1x5GgftaNYidCcHLq7ZtA0Jb/3fAT7JFfahMqOFuH0tbkaJqPmM16OuhGqjvw5iv/Zle49/IV45WBRfZ9Tfk4kxPy9jlC5jas0yrfHtanOMFwEj459wKdmdLvZrLxLuq4dkhxZJexXUkZo8dFK+KxwHA9jitkKa147UIN85zYqShcDOLZwsZnDM8xQSJipyGmhnJBokPjyDDe9NgMOFQ753WB23KZYF6VCItw0KoThTYhf3DhW5Ld1TNRcJahf0qXHA/zE7ckB0RYJkJUgIkyRGaPuw142lBS5r6TA0ZsgFjlrFDDuWdtpaHunFNOv0vYu5C88HVBBid/V2VO2IV/9maVkBvqlotPz3cBOSy459zrsDOwwjzfxHmXwbDpCHPBy5vX748H+IB/bo0FMXZruEC1E9mNUuLQXlDCJ0H4rGtzzK/c9Yw9jmbrJYKWu4K6kpLEwyoblVfOVUOnHzDRUBcOvVz3mITj2H+y0C0ldnTWszefye+NdoRtZAJk2T8Zx8D7LsLDQVedTiMP+Hc9+O6xIvM8G3yhA+cwYvR97SbTO72zc93Asaxj3fej6PIlJDYZBTbvjOM+45H9dxwzlT/LzFJrkfy52c+VsUadbd3zod1r6gkacX5emTCqyel+oXvP1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(396003)(366004)(346002)(451199021)(44832011)(5660300002)(31686004)(2616005)(38100700002)(6506007)(6512007)(4270600006)(26005)(19618925003)(8676002)(8936002)(2906002)(186003)(6486002)(41300700001)(86362001)(31696002)(316002)(66476007)(66946007)(558084003)(6666004)(66556008)(478600001)(36756003)(51383001)(43740500002)(45980500001)(4533004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXgvL2duUnBRc2dqRjRUOUFGWjUzRG1wNy9yRlp6eXVPSlluamhHZlE0clRI?=
 =?utf-8?B?T0dsZlRQL3hOekhqU3NJSXZqQW5VZURlelNORkN5S0hpZTJYMlRkWnV1a1pn?=
 =?utf-8?B?MXY1clVSM2Zhcm0zQWxIUVQrSnUvNUFBNFlKNUJVNndEZG8xNmRlZjB6L2w5?=
 =?utf-8?B?UVMzNzllMjJoY2F4WkYxMFkyV1FQYndoYUdHdU91aC9oMEg3NHFRVnQ4Zjlw?=
 =?utf-8?B?MW1ETGFsNFpFTkVCNmVXQ01uZXlOT0RCZUZNa3FRVXNvNVp2TVhJTDFaaDBn?=
 =?utf-8?B?TmZmVlJxVDFLWG5NUzVUc1EyWE1IalVNR2NNS291bHRwQy9ZbUx6SkhvSHFG?=
 =?utf-8?B?LzJJR1kzZ01NcFRDOG55N280MkJjT2FNdnFrL2dWL0docTNwZ0EvdGpHc0JG?=
 =?utf-8?B?TTB0eEFOWm9ERmJpSGd6YUZ3L3FPNzJvaVRsSWNvZlpmWFFOdDc1Z2hJZnFW?=
 =?utf-8?B?R2YrOE1qb1BCNk11d3RjQ2ZaTkpwTUFWbmxJZGI2YzZUNzhQeFQrdDlvRFNr?=
 =?utf-8?B?aXBMMlRZQ3Qra3dPNC93Ry80WWJnSzNTSlR3WTJEYStha3ZraTg4RTQzcUc1?=
 =?utf-8?B?QXhQRTNNOWY3ZzNDaFM2RzJpWWJyeGx2bldGV240RS8yem83VjZUQ2VYdDU2?=
 =?utf-8?B?bkhPSUhFSHVMZENXMWNQUTBYTmpFaUpCQ1VLMFNRSnhaemplZXdSdk11ZFpN?=
 =?utf-8?B?SURaZGU1a3F5R0VsVGhHM1R5L25wSzFpQVZSdnBjSHpIVEV0aCtWTzF1Q0dM?=
 =?utf-8?B?UFR1TkxZbzVqNEMzQmhvY2RFWnhMV3k2WFhaL0F2dGhJbjdsRFdEN0x6UmFh?=
 =?utf-8?B?U0QwR1FYR3MxMVhEZWlpRzBhejNPWitpVVVFbXlrNzRZMDF4UVVhdmg1VzFT?=
 =?utf-8?B?NGR0NFRYWS81bHRmTTc4RHdRcE1LdmJaRlo0ZEpiZ203WEhLSytEYklQRUU1?=
 =?utf-8?B?bnNSb2JiQTZxQStFQWlwa0hXOHl4dTNZMnRBVXZaUG5aR1I3UXNEdWc5MDYr?=
 =?utf-8?B?bDE1UVJqNDlDem50Z2xJczBYV05zWUU3dWpOM2IrQUx4S3V5dm5aNzJCblJx?=
 =?utf-8?B?QXhjUTVGM3dYOVJUeElrQldYcG9KQnNyc0FHT1VZWklRTjhpNlpQUUJLdmU1?=
 =?utf-8?B?WEVBNDlCRTZCQU1qNVhrYzE2RGhmeDg1VXBON1hKNzhTak54YjJsMjNkRUlD?=
 =?utf-8?B?a0VGNlB6YUdJQ0lrTU80My9lVEdnUFNySEVRZmlNbWNMOC9yYnUvWVp2emdP?=
 =?utf-8?B?d1B6d1BGbEJNWVlxUmZkNVRxZEhKbmZKYjh2UUNHSTlqWW1HTTV2aE1wZEFm?=
 =?utf-8?B?emNsZkxwdFBlQ3ZzaEEvMzMwUHJ6Z3BkYndFbjQ1NE9QV3VBSnFSTDNrSVE5?=
 =?utf-8?B?aG1mSVFOM3MwYlRBLzBNTGlNVldZUDFDS1pWRjR1bzk4MG91MStqUUsrS1NN?=
 =?utf-8?B?SysyVU9uUDZ4YkRzVDJmRFN0NmlMczFnNGJZWmFIMCszK04zdnk0c012aDhr?=
 =?utf-8?B?c1hScW9oZ2lPN2lScDdLTlVwd0FoajZYclBBZlRpaDRyRkxYUXpuVHZ4ZWJD?=
 =?utf-8?B?TnliMWU1bGFWbktSWldQT21zYjVCNTdMU01STGUvcnZFRWcyd1BJVVNnTFNj?=
 =?utf-8?B?MnlHbmpzUXFpTE04SGpwanVXRTZLdVpPSXBWcXd1dEpPOVhwS05QWWRqb0sr?=
 =?utf-8?B?TTBtQk1TeGErWFNEenphdEpUUXhtQ2dnNnBGTm9ZVGgwZkdmbG1yNGwrbHhC?=
 =?utf-8?B?S01NemJJOE52SUd0NUFqUTZ2NUZsSHdDSkhNME04andBaU44QjUzMGtqeVlq?=
 =?utf-8?B?QzJTcnBxcmRLMDhTSUM3NmIzcm0xRXl5d1JCQWJpZ2gxSzl4TEJzZnRZL2hD?=
 =?utf-8?B?Q1htQUlVUTNPa2o3TUdwY2pYQlZPWTIwMVZrUENITXNTSlB1RjBFT0dUVGxn?=
 =?utf-8?B?ajVEOEtlbnNyejNESWd5a1NjckgwYmlHajE4djhTV1p1YU52WUNvdlRWRCtq?=
 =?utf-8?B?YWhXa0RxeGZwN2I3bTZJR0FVVjhGcm9HYUFwbkt3dDBscU1VOStPWTRYSXp5?=
 =?utf-8?B?K004M0xVMXBJdklwS2tSc0ptNE50QzV4YW1xU0pWMy9vdUo2L3VhdWRWNVB4?=
 =?utf-8?Q?baS4HmgE0kzBlUGwB50OOy2Pj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WfwxlU4Bc3PUGAIorCnaD+T/z2JvJSiGhu4lBLyEXNEqKeoknLFbs7voZBvvNbj9r4WRv3CDbpQGaNcsLRkIIPkh1QbRJ+YuKOrn4BOz/FhuAGozd2bCU2JApFI0Bh8ZtKn+1Yn0SGOUGKAATC6o028k5hNP6YGkGN9LcAKkdVC0MKQ4y8aG6LMBhx3m36T/WlBzW6QCUnQCnwG5CVg0vWnOFQ6DxQ8cmNRZLuV25Row32X747dgadYsh5Avv8f3nVchRqSMzufIh2YA1FJYxzD2e2Dyj6Ghe8UD1q8f9gW/T+Yv2KX2vcViD97fb6pWqusWLtMqoJJzUsdrz5dYa4elHm+fF/50JkmXXR5f+UyDgAWf44mxfM2kattPP/fH7mF3qY4E9eAAZmSra9rom+2em/pB4u6O0YRoXrlIdCfAYmJaq0fFK9KuZYX+lSnOg4pR5vFDL3Q2kKD3+oQWZpOymzgmmrwSf9AAaboyuSO5hCJpaIXuFRfN/EclC91VM+fUhnj0LQZLMCgjUB20ImU9rdznDUD2YV80reJ6B7z5UvPN3BBBEZskvjHaAFocVSAKm3HWs/cVZc7wtkKcYNoqOcqt13Glz92GWmkOanSMFYLjEBYc1ddzfndalVyaU1LTIiSKHdVbboH4bQ6HLBQBdopPJG6lxQy/MkIN2Cc2vEBc4A+PpKQrMMhO3jswHQm9NXnbO59znY2RVICHbMXgX8bbk//MyUgZGC5jhZtXQR9I9cCCTMuyy5L/M7XCpKxCK9JnsZ0gaWmBak0HmssXNdF4doDStl4MvrBWgzw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bab671c-9442-46dd-23b6-08db4d4d4806
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 09:44:12.3566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: moTe5GtfqMLjiV2uJqn2O4bL+GNqgnBppe7GYB5mXVWroU1Fgp9bdOvjAaBSdjx9SB2BZmIn136A2syS+HFmzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6097
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_16,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050080
X-Proofpoint-GUID: XaO7KZF8Cczifn71LI9-gjvDoYxtpvBJ
X-Proofpoint-ORIG-GUID: XaO7KZF8Cczifn71LI9-gjvDoYxtpvBJ
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
