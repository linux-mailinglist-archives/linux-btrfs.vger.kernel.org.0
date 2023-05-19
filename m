Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A29708F72
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 May 2023 07:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjESFcu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 May 2023 01:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjESFct (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 May 2023 01:32:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693E6E5A;
        Thu, 18 May 2023 22:32:48 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IIwvXx031088;
        Fri, 19 May 2023 05:32:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=KfGPj3VO6VkCq0Llnsn8XzBLrpwSiMG7uwtB1jExFhpxWjetKH5bkDrhUPFSiCUdPNaW
 d1a4uE2hEDy0Upr5x6PBJz0OReQiqQT98MbqBqpV8ETnFkkPDXbUW+4Y8iVICPSPK+sG
 AGFpomBMe1fk57Hi/CFHA5TkqX+bd73D1xp+P79QKVxYhoHx1FBcZs4GPO07wxXy3ZY9
 sdiQUFKiTdxAEIbrYA3AE+0oIE2kzpmTw/uk6z8qqe2pBUYQonIZ/91u9Skfxm+BUO7G
 gWIRGJnPViaKp9Elifow8qCq2A3wndaVtholvLsRM+OSO2jWdbKr5HnJjANfv+W8137v 2Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj0ye9amn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 05:32:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34J3C4Cf025033;
        Fri, 19 May 2023 05:32:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj107nw0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 05:32:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsVUf05DsDtnJ1NZodsDY082Yt3bbB2yhd5rEI9vPu/GB5Hp5Y/GeQ3yJdIFEpUY4IFLDt7jUuAdsWCHTIe9C1hs+T/5fjoezIgcKahfgzngI61AMVf+J6HXty+hw8xxn9jrpeIeIO95Sl3c/7ROPsDdt1mLrQ6hlYZWUnfKdN6/flY9Z2rrAJUS+x8QD1UFQvCHh7NBW3slOUk7pHbt1o+pkDqVqYPse1zmqI5YoWAvROFIYHRu7u4bWjHw4RGCKY88FRzdSZDSZ72X1EAf1yuJIp9cbtzhMLQpy+WT20M1OYgVjlQXZ7FNMu6ajMGYzi2pXpx/HXFLGJCxgUjXbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=N24hTwB+gguAoczoXB+XcY+zPFQmGX9Q8TAxVozmzcrlZ94MEltwvV90x+HI+rJJeTTpGyy+Rx5hHzk4cies5DizuQrn6TfQBdZPKHx//tNiSTjN4VLi+Vl1z5vlu5V1vdWPATPk4n4gGY6nCUglp08FHXI+uxBXl7mj9lxNLsnDZmNSTQCXwD6gOBrJeSugK+mq2YbWpFl5NRtG4oZ/UuCw1hjolzyXJl1fxbg+IBFnjQwPaJVZD3oJcoCSEzsbx0Ox957SiTq2pju4z7Q6e6+mH7CVJFsmlDxrJiKnmDY0mQ7IMxPh0QHtyqBWs4QauatxQzfTpeccfIHlvOoiyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=EYpfIiUeiCXelCVQSokpbGfIhNTPGp/zuKaoTWgzHLl46gLv3kDW2Y/pOTiLe9ZB4KinJ7rP6KhKRDagI83oO05NBtd1XlfxRDbNgFb8U0VVc76Xv9t2/wPshUXsQA4/E8wu6Rj47iUc5OHEs1+ciMsZ2xKCgxe54oIq9MyOsSs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4772.namprd10.prod.outlook.com (2603:10b6:303:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 05:32:40 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.017; Fri, 19 May 2023
 05:32:40 +0000
Message-ID: <58f5fff5-aa1c-7f60-73be-e6800368f860@oracle.com>
Date:   Fri, 19 May 2023 13:32:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] btrfs/213: add _fixed_by_kernel_commit tag and remove
 from dangerous group
Content-Language: en-US
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <85b3b1163e5ba55f1a253dc2eb74f570bec564fe.1684408127.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <85b3b1163e5ba55f1a253dc2eb74f570bec564fe.1684408127.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0165.apcprd04.prod.outlook.com (2603:1096:4::27)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4772:EE_
X-MS-Office365-Filtering-Correlation-Id: f7085e5b-c0db-4b30-eeea-08db582a7625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NRhz1eBdWveqn0KyQrYElszxKixFu7nS81LstuzmC56d+fJ9Y+l9FapN6F+7oD4E/BxjKgXou4+DoLuaFbDzxYSd2KoS6z9SzLGDRcRby0OAZo/ctGR/apks1iITDzLWVvg9DA3XEF6aetluuPOZHs3JjVI8wRvRxXk7jR3jcgEj9aJStGgLa7vMyuJwW30lu1+Rcb2iOAryuo28SrHWBKfP51RhIkZezR5XQvEHwyAkGtC+ED0LUd0dUxo/e430c1o5ZQv5FgS59HpZXsKEd6phsr+eZ1hrhdoBpNxxg0YMLvOPQyBhjWExYIbOU9zbULm6eWEF2e9zuA5/UyXy357hRtjm02819zygj4XSS60AOahb2zEHPxOC8UnaPuAiLzjFnqtyGgGWPuJ6dTEtFIoRJF4J1YmrCl7Zy4jtD+k+Wq5pPrXb29lXDwuobB1p4QBpJcCjZ4VmoHB3iBiPzmMi7mCvmPQTP88L6ZpzKXVgBkuKvWulqN4Z5OzjVk/U3ofogm8DyElatuCZKgYzO3nV/i+45mwmQ123bvvAFn8AlralrolgmXwvhkP+vf7LJaGoR1hFdSTRFdHoiA4ANDcBM2W7c1aDm/mJP068TzKjxKlSAXv79BfjP4zigtXlimFp0zegexpcsEvzVBtu/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(39860400002)(396003)(136003)(451199021)(36756003)(86362001)(558084003)(31696002)(316002)(4326008)(66946007)(66556008)(66476007)(478600001)(6486002)(6666004)(19618925003)(8936002)(8676002)(5660300002)(41300700001)(2906002)(44832011)(38100700002)(4270600006)(2616005)(6512007)(6506007)(26005)(186003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVd2c1N2TTVkTStUL0pWbHZUdmZTQ3FuZVZPbWIrKzUwQUFBdWpGQnRLRFc2?=
 =?utf-8?B?VjB6MjN1WExhWWlkRG9EQ3VXUE1OM2JnZmxuY3BhbTk1ditJZmlxNWFOOC9u?=
 =?utf-8?B?bjc1dzRzeXVUQkIxN2ZHcWpVMndEZTkwTjFxdDc0SlM5WERVcXBla0wveUJK?=
 =?utf-8?B?SW9UdlJMZ1pCVThwWTY1bjgxU1FLRU9CV2FYVVhDSkFkZHp0OU5kNFQ4ZWpx?=
 =?utf-8?B?UUNFOVVvditxVkhLSFBzaGdoL3R4UEYrcGxQeTlURTdqbVVHcytBNDlzU25J?=
 =?utf-8?B?OUcrODBQVWxYY0QxcUg2SkozVXYxd3BlWTRlMVNwcGx6R0M0S0wzUUxmMW1w?=
 =?utf-8?B?eERVenZMUktvYlBMdCsvM2JKdUNZWXVkeEpFTzByaFVTSDhjWENHNFFyREVU?=
 =?utf-8?B?MUJCWThrQUN1b0JGOWV6UUlEV3l1UXh2K3BIVjBkVnBQVGJTWGJTVWlpWWR0?=
 =?utf-8?B?QU8xRlBLUVpwRGRVZmtzYUtlQ1F4bFkyYzdkQzVaVXU5VXgrSG80MDhTNit4?=
 =?utf-8?B?SmQ0WW1FVkZhRHh6TzdQbDk0QUlWLzdzWW9vcnQ0NWwwOXp6N1RwK3JJRVJp?=
 =?utf-8?B?SnJMKy9JTC9zYVJOeUNDY1hTTm1vNmJuaHl3aURUb3ZDMWxUcUxnRXJyb1l0?=
 =?utf-8?B?emhMcWJjV2J2d1o3VFdMdWIxS2lnR0huaWxsK1FSTTMwYnRDVXQwQ2hXTWV6?=
 =?utf-8?B?a3dYbWZQRnVHNTFXbHF6aXRya3g0bXlnNlNIb096Wm05V2hGa2s0bHdrQUM2?=
 =?utf-8?B?RmhQeGhybGRFcDJva3k2Nk8xalUzd01TOEI0YzVpdlNXbCtaTUwwVExRTHkx?=
 =?utf-8?B?RmVwZytzNWRCSUNWb2VzcWtLcVRBb0QyQ3ZFbVNxNGlXVFZ6aVBueU5SWktj?=
 =?utf-8?B?eTNuSERrY0VhOUYwOWVSemlvbHhzdjR2b1BlL2Vib2JDQXdGUmpQWFA2Tjly?=
 =?utf-8?B?bjRHT3dsa2xvNzg3WmlEMENwYXJySVRPa3dBT3ZiUjdqQXNXVzNDbWhwR1Zv?=
 =?utf-8?B?RzI0VytJVitSM0p6SVRjVi9jYnNTVnB4d1VuSFl2VVRzSG9EV2puOE9QZDVh?=
 =?utf-8?B?QnhEVGlBQ2YxNTlyT3ZIemVxejdtck5XYjNGeloySThqTUVaWHBQenE3VHcz?=
 =?utf-8?B?Y2RYaGcwL0N3cmlLQTBXT0RYSDRaNFpvK05XNlB5Q2N5ZXVhTWp5MWdiMHdk?=
 =?utf-8?B?dWp3OW5OZjZEcGNqaHgzNm0xclBUUFBIKzczZlR3ZHdiTk1Ecjg4S3RhZnJE?=
 =?utf-8?B?K1JNMFA5NUMvc0xYU0RWMVRIQVZYWTZla1VoeFU1bTBmTFhCZTVycnhPKzdI?=
 =?utf-8?B?cVRJSkF2OWtDdjB0dHNtLzFwS1BZeWNROUNlQjBNckpIV3VyeEkySVhoM1V5?=
 =?utf-8?B?Zys2RDF1c3VrTDhEdy9GWDQ1RUFOdjd3WVd0OVJETWJJQTFmLytqUWNqQTRU?=
 =?utf-8?B?d2FGT2h3U3FsWkdHWGZwVS9tUSthUmVqdzhia0pSTVlHMjhMOXhuTGhMOVZQ?=
 =?utf-8?B?cjhyaFdwRjRqQzgvNXVpS0llTU1WZHR1NzdhOUVwSUNSdGRTTXRQd2ducTRI?=
 =?utf-8?B?ODFSb001RG1wRXNtdEFWQ3ptclV0MjN6Ti90M2R1OEF5UWJKWkZYanJDM1JQ?=
 =?utf-8?B?T1lnZkVabVdSVkQ0ZE1lTys2YzhPbE9DOFNkWnd0S0pheG1Qa3FWN0hGRVBG?=
 =?utf-8?B?U2xCN0N0aTg2dUlndUJmeGluSThVdXdkcXhqKzdiaWdGVmxsOHZvVGc0NFo5?=
 =?utf-8?B?bFJjc1pVMFNXcm5TVWJqSnVCTkVRY2RhdWhHWFNvcGJ4ek9QQVZyTGJmOUV1?=
 =?utf-8?B?L0Y2RU9qNVh4Z3E0U25jcC9hSXFlTGtXcnpUTVFPQ3U1cUh3aFVDbFlIWUFk?=
 =?utf-8?B?OStxRDM0cm1veWNUREdOanQ0cFd2QXN1K3d5Ri9DOGhYbzhZczdEMU1rV1VS?=
 =?utf-8?B?WEdEczJHQnZFaW9qeWIrcml5RWhQcnJkVmp5K3NhTWNudmVxWG1sN1VHVGRU?=
 =?utf-8?B?b29hVXNNcmhLZFB0TDQ0YWFITGN2OU5UOWRNMUxPUjNNRy9WRXR5SjJNQTFS?=
 =?utf-8?B?MUtRVG4ydFpxd3lqYkV4Und4MHl0ZzMyeGY4TjhkdkNObFBZMGYwOXlodkVh?=
 =?utf-8?Q?TJg/FVf27N1atUOE9EO/sOUKi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OmtIbT2qg/D43yPyUJoGRZBErhskOGSd2Bmnc78cnWkVMxvwWF57g0NZe/MxdXBIrKXi2fAWQmyP2NF0Qi5ErRSpd0s6ObGw4psFT/LYwnFUvQbbM9MecVOuEBUXS9CUUgksrE0XA5YEDMoh1D8/AfYayRMfJuZf3Ldsis1NWWQlDj6OYcALti253DaZaanrrLOc23dHyz+4zwVfMROwLHpH0ns3ONStaQG/DG+lq3taiEDr5GWHp5wJJFb26ozph5ldTO0Uc2gvG3IiwfedZGme6+qnef539Rm8FV0g1lmJmjI1DIu3XCxSKAk5ef6D+z3cg4W2LIVpCrZKR/Wb6IlH40umNQQc49zAniJJa3L2beP9wekRTsjahguokjguxI83BvWmDUq+AOcnL/CmhSE951oNt80YiecA50eFdljaYACzthLeHE0u/jcWk0BR7PMUiqaIvJx6kSWgA8QShtjLLHCO1xU0r/E1hvYdAZJMyKysCjHeDQeS7bbXDIHzsqEfTFalSKydzCLlhtHoiz8U+8arOO6Y5I2e09lCjHT1k1CMeK6SHeDJkN7AJIKBmBS5yYRrwibTo9MHmQKDZn/E8OS3RzyaT3TUHoGARu1MrcR9y7RAaX/SwJLc6vz+4mZTnDo4g1se7MvxkmqUS8h2AN0/5Tuh2c2/am5cHA/5Sybj2TpO3FQWsT8/DZYQdOKN2zqzVpQn8K0P7/jAU87pQmJ4EQENuubXq4Ct47QAHjnF0g2z7NduHXvIE/Ce8fmSBBDGPsYGx402D9MDtrt6QbDv6Nzlt7QQILLlJYthBeEWyuyij65IckSAagAy
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7085e5b-c0db-4b30-eeea-08db582a7625
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 05:32:40.1212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8oJ5E/k6VGY56ZKq+I2HIf6MLMr+AK9zrh5kUnwtR8u6TJGBi7w3DMHv2ug807+bGSjUjUUHScuDtV+OuTKiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4772
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305190047
X-Proofpoint-ORIG-GUID: RKa6-3eyEdmIXFD9znsrAWEKguE-YZZT
X-Proofpoint-GUID: RKa6-3eyEdmIXFD9znsrAWEKguE-YZZT
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>

