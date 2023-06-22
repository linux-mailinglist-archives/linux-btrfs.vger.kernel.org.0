Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB6473A206
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jun 2023 15:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjFVNkU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jun 2023 09:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjFVNkS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jun 2023 09:40:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592A71997
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 06:40:17 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35M7pkjJ015207;
        Thu, 22 Jun 2023 13:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=RHO5IQVfqKvcwIZaHFG6kP+T04uQPWdMEy84T17KsgE=;
 b=obWR0bw+6H4Nz7yY5TrDUJLpgiqFH9v2coCDs3HhHvlNOh6180Mi/G6ZrTFHM68LdzaP
 SzZliDSYIFksDqPsydOUbJmYUvQr8eNbe54qlXFxFqGGaix1yDdGs9PicbuQELUT5rBO
 05kRkKupbiGrWZ68G/NOwMb0bxzPiUhmqwt/WrZV0O1xFBHub6ddSMvMLGVw/pPf2key
 +/lfedCcC9vCoCalnvm5vX0jzJC5mJaqwY1u77rJPIw6mF/eXERlQazYo+vt6aBL46ta
 WFlpnsyzH7hfgR5jTCMWOe0vHp9Li+6THIRYl2OJXSYpCW/hjRMOoym9UNwFelD1MyyL RQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93rbsucv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 13:40:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35MDOHgt038627;
        Thu, 22 Jun 2023 13:40:12 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r9397jt0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 13:40:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGhToYsLtBVwkc26XYj0Iz4cZzngnifK+M5Xx2aeerSOfZj9ROytvkYKgq4Hmy4Z587/Pu/X5SIfqIR9Vta/HfxUtCex8gKAIvKalXPyAA+D/Mryrf2LalpVjzY7hHJPOJDIk5pEIHe1OlyPEGSyBZYMeuiK2ODxyVg8ReeuOZJpCoqMwSFAO89U0JkhnFmVSE6+mEwJfZv0p1FIshrIjQY73xe/aKVa9i6R3s0vacu5ad8a9wtek0mti3wrOBlITIBO3vI/8hG3ONhAG6Chh5Hzr76BDj1HPZ86Ca4WEB13AuIUBnFHTYnlBj3txBG2cLHJNgY4c2H5R7UcnXyBlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHO5IQVfqKvcwIZaHFG6kP+T04uQPWdMEy84T17KsgE=;
 b=BnACa/8ks2HN+eIPEdQ+p4ijyEhcs3jiPGFXIlFPCWBQPQOTom3ZWzHou8LmM94VfZe6LP/fTjQjT9LIoWeaVVWRL/PyougOhNEqpc+9j7D8RKh/iQ0sAOw5rWrrhztpBjJNpi0hRikjqL9w50Uxudwi8+KEUF4YeMm9Ar7XSvms98PkNdlDSzKTvoTklqF4fnVQGus0di0wLbJaQuzyCsV7QgKqh0dPVqnfbZap5WwVLbuQvB7BN8TZVROafo6zk7RplhirAP1lpqY+qbzulhxGyMCGBjfseX9lX71mfx/c/9unmFmt1M1/5nhLRKaiVJUVefnewPlZUA2409PRmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHO5IQVfqKvcwIZaHFG6kP+T04uQPWdMEy84T17KsgE=;
 b=NFhh8pvrSZXQCbOQ4KVsob7vaXXX7aV9+ZrjURn8h0MbVUrEf4AsQuQjoeaUbsXJLIOo+arPMB5F8M1G4BAkyfCNrYMHPWUYn75OlS/L9YrRczryWH7KJvJiKNehS2YzZnZOKqyFyNt04/IOZuIh1G13IMO9uIjd0jPT245nrsE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB7829.namprd10.prod.outlook.com (2603:10b6:806:3ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 13:40:11 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6500.036; Thu, 22 Jun 2023
 13:40:10 +0000
Message-ID: <888aaf70-f559-9e69-9b36-7a21ef2941bf@oracle.com>
Date:   Thu, 22 Jun 2023 21:40:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: sysfs: display ACL support
Content-Language: en-GB
To:     dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
References: <df5dfa3a329e7418519a5881311d776a50a118a2.1687250430.git.anand.jain@oracle.com>
 <1d62fb411a289807d8d12d6a76bdca867a56b591.1687248417.git.anand.jain@oracle.com>
 <20230620102500.GH16168@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230620102500.GH16168@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: ef814c91-6dc2-4232-a3a0-08db73263336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6DkRTxor4eg03T2KeaqwAcJVOZdbrMJuYLu8q3FXSmQTBUeCw4vbrxkxTx/NHlU8n21TRENxAiRmsPXSe85D901neC6LMd8iYU4+V+xdmvZZMMEKl4rQkliIy/ypgdRaXdp/E+GmPs5C/wOiuSznOqysAfV9V6UWJY54q1+3XJS+eYXe7jSfzSZkl7zwN/tRx7Y07cxnNA/GEyGKwo7A9UY2alvQGhFU5zd60cifgi+fLGKrLGzBfxSqePd4hRDZqiCG66JpT9YP7RknWaKB3RHp/b0GJHRZvYnCGrmJBtLOPSgEOykaD6+fPRYHnxX/t9ssEFXLwVqd6LtHaJlliUJg3vr6AAaacHWCGYdACe4bHOh293vnW0y+0QuMmMzdnKUaIo99mvdNVW/yOjzQWKkBuhV2pJKIzUrYhGXvc+2k/qPPdoEA/Ri68bWRqoaK2Zh5/Q5/78OcJOyUqBZ8/MBWjBwAbikuBFHEqI3KDbaZaMS5ReXdsGPQfiB3LFVGc7VBW/bohLtYEp1qllv8y62XGJ16BgzEWt2ctqW7v7Qiy88ZCk6XA2Li6UpS800CMtmsCJbixUp23NgFt10uvxAg90h8qIjUiqn1NqOPTvrGIdfT0r5tKPVBqc8HoB8wPh38vOU3o7bW0XJrQhV01A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199021)(5660300002)(36756003)(44832011)(6862004)(8936002)(8676002)(6200100001)(38100700002)(2906002)(478600001)(186003)(6486002)(6666004)(31696002)(37006003)(2616005)(86362001)(31686004)(53546011)(26005)(66476007)(6512007)(6506007)(66946007)(66556008)(316002)(41300700001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bThNNEVOUGsyTG1pcjdTVE4wN1FCQWZsVmpPbDZWZWV1QnV6aWZndEVHenFP?=
 =?utf-8?B?N0UzQ1BlMnB6b1lWQ051b0haMTZ4cXVRMGVBWTl0YXNoZkhVVkJXTFhBaTNN?=
 =?utf-8?B?OFNrb3VGUEVCS29nWnJzRWdFWGFJOUgvQTRuanFuOUY0VXpYZGtsN2l3Q2tS?=
 =?utf-8?B?ek8zbzlHMkE5ajQ5My9raTRDQTZvbTdWWStiRm4rQ2pnakpRUWRWY3c3NXdr?=
 =?utf-8?B?SlB5TmIzcjZHZFo0ZEJQUHRVaUw0bURkM2c2V2ZqVVVmWm1OU1FBUmxWeXdu?=
 =?utf-8?B?N0JDcmhVeXNPNFNSbTFlVCtKOWZqNmt1NGV6R3F4Nk50S2s4Mlp2cVJ6d20z?=
 =?utf-8?B?MU8vcnE3TWR2NHRqUnhKY3dJblUxSlMyb3Z6Y3NSYmdEY0dLWkVYTlVwQXIz?=
 =?utf-8?B?VHkrKzZJUTdNZzFlYVBCTFFQZ053cDBLbHRPUEtGL0xRdEFiZ09kbEVSSVJU?=
 =?utf-8?B?SDE5MkMwaDRnNFhvT2dHdmhKWUs2bUFhMUNJdjV3cU5rbExPakNaU2NtN1J1?=
 =?utf-8?B?UXhvQjdTU0hTK2lwVEh1bzFsYllnVkhwWmpkdEdnY01zSGdyOURJZDA3aEw2?=
 =?utf-8?B?YWxqQTFIS2hxVDI5K2ZqZjZBSWxuSjJWaGxXVGVPSEM4cld0ZmtkbFpSQitU?=
 =?utf-8?B?QUd1SmZJNnAvMi9FbjkwK0s4L3ppd2xBQytrSTZhUmp1d3d2ZDl2K2o5RzNq?=
 =?utf-8?B?R3ZrYzZPb1NzaTVhdEJWM2p0aGlYWlR4R0hjZWNWa1dLNytuNC9UWmljYStH?=
 =?utf-8?B?WjZzb25yMjdVUUpuYXpxS2pvdnRubytHMGVSMTJiZ1NCc2JUWFdnbW44VFM5?=
 =?utf-8?B?b1lPTEh6amRYT1VLaUhmZHFQNmliTUtmVDU4V01jaGt0cTNuT2NwQ204S2hr?=
 =?utf-8?B?dGhOT2RLbTFkQ01wMUZyZWQzamZZMm5HMXhiWnplMkJaK1lpVm9MNi9KNHVI?=
 =?utf-8?B?K1laNGhvMWNudEpyQXJsVWVKVFBrUlE1aWwvaVQ1NGVmb1JKWkVuT2FMb0Fr?=
 =?utf-8?B?aVNJK2twc0Z1bHdER0g1VVQ5UmJVQ3ErZnY5em5PeTBOZUY4Y3o0dUtDL0wr?=
 =?utf-8?B?eVg0YW9NcUQ2NzJQaUVUalBaK3FtaHVZK3R3N0lWY1Bsb09YbVdUT2xiaTZk?=
 =?utf-8?B?U1VHWHNpNTRzUFIyY1luaWRNa0h2c1hCSmNxUHBQcTRTK1cxb3U5K1diQllK?=
 =?utf-8?B?QzlEK2NTTkhKck4zSlhXNnl5KytDbGpUSVFTWDZkT1JRQlFBSVZIeTN2b3Iw?=
 =?utf-8?B?YjFZQUM3MElQOUhoVGNTTmYrdi8xTkQvL3U1RjdJTzMxNFkzUHBxbURUWUds?=
 =?utf-8?B?RGlVb25WS3ZtdmxvU0dFcU50ZmtEZExJMURobm9iTmJIREJ4YUdQRVdTU2Rx?=
 =?utf-8?B?VXFGQ1dZN0daakM3dUkxMTRpWWhTVUNLT2k2Z1YxUXBnZ2hjNDZLYnZGYnJS?=
 =?utf-8?B?cHNKVmhVQk4zTzJINktEWDk4aE1Fd0RHQ3hMb2hHb09VdStESVRGSi83WDVx?=
 =?utf-8?B?UXpGZkVXWjFCVXM2MmNHM0c5cFNsUFhTTTBnc01RdDRoWVpZNVFTT0xMQjlq?=
 =?utf-8?B?b0dUY3VIWXJySU5FMk1qTk9uMjZDeHJJN0g2d1ZBdi9yNkpnTUl4RWswK1l4?=
 =?utf-8?B?Vnh6bW9jTEEzRTZjVWFHUzZ6NFRVWisvWDZCL0JqdHBEbGFSRGNZZWZ4Ukl0?=
 =?utf-8?B?U1JUSTdQY0daRk9VQ2FhTTlKbEg1RGZ0ZWNQcDVSMWNBSlVxRWNsVEJxWU9u?=
 =?utf-8?B?SlhlTmtCUkxpS0g0MjlORjFIQkJXT21FUDZ0RnYyNklmUjNSNG1VV3B5ZGtQ?=
 =?utf-8?B?SnZidnhlVGJ3TVB0eG10TkpPNitmbGxONHh5WitMcG4zZWJGaEdFNEdlQVl4?=
 =?utf-8?B?TFRmajVxTVQ2V1dBSG1aRDlYVzJnNGFBbmVXRmxNaDZUWjRNbHVhNVFjT2Vt?=
 =?utf-8?B?RU9GTFV4YlVQcDRPZWU1YzB3cXlwRDdMTzdtY1lCOER5U3ZmWnNXcUhhSDFs?=
 =?utf-8?B?Rnh2dWF0ZVFWd0tsK3VBaldGbmNHZXVDL1lyN2VhZnlVbmxiSkxTQ1Nva29N?=
 =?utf-8?B?V0YvUnNPYnpHL2JyYSsvNmttRmxQR3JPK2RBQ1FOZnUvWkJuN1AyRTBGVVI3?=
 =?utf-8?B?ZGkwSUVQSUFWWDg1ZzN0S3pMZEJPL3NjTFkrYjFZZmhJMnVLRjg2cUJkVHVC?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9tb0RBoyN0inFrrkeB7YLhG4G2ohi4iQt2vRecoOZTx7uMZs7ABLREF81BOPg/PPLgAi5nnjZE33fpuxn6tVJbFHIM9jsc07irxVVvg4lSCMAWj/NTHstBJeEFaADwNRDxH/O1hAOsMbgrQGmu4xkeHWaGU3YOB2sU3LtOPf46FA/iDKjN95y1QbcmopzpdZieqGdshJwc6imOA4gblyq0zSHyhWaFbVSlpUnjiRV2Jrm8+XHRNP/LqWYkHImZ6LHgvNd0T4B0KdxAB1t6RHb6TnGJ5z0558qFTnksK5h31/PN+ydXLChmWQS+ijpsFI15LqB0FMLydADeAzqvq/qKdSWkst1byPhCuXv6X5K+XCbQMMBDtscQdHGkBjX7dgw7LSc7p92K2YNq44DBDGnz2OmpyEeA9qeC2e1ZRcdO79Bs/hOn+pEtzcE+HQux/mhIgMqurn5fTzNf+0dGiImsrcS+aGRX5Qap2HLP5zAr+IRpy1C302b90FD/1xUS3gb9PsvVjoCoxJwMeC2edky5ubZp47G2w8a6hOkGuXkKAgTjcGyqLdHVhjGqRpVJ5/RmE35w/GfPCtJJdwnyw6Yzea5QpwNiUBgKiY/PPEk4bgEK8+paJ6eFauC2NHqdtsNqZlCj4y4Xnfa2ogquWbsaUG3lrfIbdB2kqy+5RqtzKl1F23euBPfmNoNNXbfC2p2WAru+iiW6+YgC5I2dcRY3ODxWbhOHyicT9t8frw/huR8PIt+tvyjmpQfqcaXGcmdqlPsHcZsrIGu/gPttiYLk2OYIaK97yLF/n53CiQfak=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef814c91-6dc2-4232-a3a0-08db73263336
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 13:40:10.9308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7f1aP0cJtQVgs4Tgv8AE8jfWfcDBjfb48mtJcy9ru81XpLR9auIjlCzGMeijnPmwL7DFDpoNKsQmYi9Ty+OBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7829
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_09,2023-06-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306220115
X-Proofpoint-ORIG-GUID: lcsHXcQ9Ak73P1Wsp2R1vqA1IErJjVCp
X-Proofpoint-GUID: lcsHXcQ9Ak73P1Wsp2R1vqA1IErJjVCp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/20/23 18:25, David Sterba wrote:
> On Tue, Jun 20, 2023 at 04:55:09PM +0800, Anand Jain wrote:
>> ACL support is dependent on the compile-time configuration option
>> CONFIG_BTRFS_FS_POSIX_ACL. Prior to mounting a btrfs filesystem, it is not
>> possible to determine whether ACL support has been compiled in. To address
>> this, add a sysfs interface, /sys/fs/btrfs/features/acl, and check for ACL
>> support in the system's btrfs.
> 
> For completeness we could add it there but how many systems are there
> that don't compile in ACLs? Typically this is for embedded environments
> and it's probably global, not just for btrfs.
> 
> We can't drop CONFIG_BTRFS_FS_POSIX_ACL to make it unconditional as it
> depends on the VFS interface but at least we could somehow use
> CONFIG_FS_POSIX_ACL directly.


Directly using CONFIG_FS_POSIX_ACL is not recommended, as indicated
in fs/Kconfig file:

------
# Posix ACL utility routines
#
# Note: Posix ACLs can be implemented without these helpers.  Never use
# this symbol for ifdefs in core code.
#
config FS_POSIX_ACL
         def_bool n
------

There is no global switch for FS_POSIX_ACL, as it is selected by
individual modules (approximately 20) that enable ACL functionality
in it.

All file systems provide configurable ACLs, possibly for rare use cases.
IMO, providing a sysfs interface for better tool compatibility is a
good idea.





