Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89019705E78
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 May 2023 05:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjEQD6v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 May 2023 23:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjEQD6u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 May 2023 23:58:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077A0DC
        for <linux-btrfs@vger.kernel.org>; Tue, 16 May 2023 20:58:48 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GJxVxu007553;
        Wed, 17 May 2023 03:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=crwlWFqucaDL8hF8yss8Sb5R+VaJLBW8fqX8tcWb9vw=;
 b=XsZpvoFKFYPba8Fnzms1cqJ0eRCP4J7yrwfIIuqTID6+n0zbEpwyva9hhLLlqRjRwGMg
 p4uEUNOoU6/O87UBO1xkVGs8kRyKzWq43XAjWC/c2G/5QBcDefFGK8hoNWrgxwZhOT0u
 vOBB9X9wAjjTT74tb9cqQCWvbIYdDCt3B7nCVARHwRuE3p1Ol0eWM7jDZjuG5Z1c2awS
 SBskkxi3g9e9+IVKQeMU/g3DbnHm+/PXVBNdkK5b2C7Pcg942K1BxutKSiOX8iRC+6ZC
 A3zvdc+EXTA94j6ICQPDf8QI4+Ivl05qtHCdoEHOJ2790xZxQtsRkTNVc28xupoWo4Hu 6w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj33uvfp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 03:58:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34H1p50s032190;
        Wed, 17 May 2023 03:58:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10awqnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 03:58:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbAjwHeG2u765GdMLpf4OrmVzadPxhbyY3hGVYgrti9eS/cCVD5Z/+UGcG7gTZAVAALLDUJpgcJ6XsPQo9OYgfLrHfVlg8gAPH16dFsBxgTVcl3ikml4HjJ9yIzfCXtc4BsUduWdHpoOuLayrrSXgimWzvVOC9OEXbfpQVHki4qcBVXzzcsR6vNNQLJQhhvOWAn9rw0J/SryfgteR6TxOyUFqo06GtiEiRmPnhimHxT58tTuJ/z+RMVPy7l0rGLai9xf2dTmCGS85K0dZOK8ZXaLC+gCHdOz/MXzqej901Z3faV4I15aOqIIt8lvg79TmLuFmzGiEYTFcQWzgQghkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crwlWFqucaDL8hF8yss8Sb5R+VaJLBW8fqX8tcWb9vw=;
 b=m3TzvZ3n6OBFMgCG2JpTlZiSXtx/pB9ltaRhVb3oKUz/uiR8hD2w/RpppOrzk1K3ievSYrItxOBd/+uutcHHaAqOesAcEb/mMcEgHb5JXDz2k7k32NQuUCs4ReU2QKcdikcS6/kFNKHk7FJrddx1y2qCqhaP3XkInGAk+wRQNm2SwB4IINAZ2+IWuzAsLBb2GbkYAyuzQfgqOxyL87E71vWq8/lnNzw41VO5AOPEwsR8RLjyx8aKao2Uk6nrQFa81PwUd/h4jGFibZTfYtjJjiN5h77+oqSctvTRk/Fpg2oNUUdoVm4mfK882XiS83tg1DCA5eEkDkDGcemeP3FZ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crwlWFqucaDL8hF8yss8Sb5R+VaJLBW8fqX8tcWb9vw=;
 b=q+imMI+GUaZGT7gk2KJU3HotBKNvkx1NlR6Q6XYCezNNKN0BMsD6ociaAwInHxPBLSZWcX/yUMoBebuH0/eGoTInfaT5cOzzISWfCpEM78W2Q+hiNIzgxk2poDr6ISR7zg/GKbi9muNSrDwf9KEgjtyHTdGpIhQ8HOupcDB5ky8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB6904.namprd10.prod.outlook.com (2603:10b6:610:145::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.32; Wed, 17 May
 2023 03:58:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6387.030; Wed, 17 May 2023
 03:58:42 +0000
Message-ID: <4263b93e-8154-b4c2-56a0-095a26653f29@oracle.com>
Date:   Wed, 17 May 2023 11:58:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] btrfs-progs: dump-tree: skip tree-checker when dumpping
 tree blocks
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <a6b4198481004f1ddcdbac00f8559c787646557e.1684236530.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <a6b4198481004f1ddcdbac00f8559c787646557e.1684236530.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 43d8272e-e110-4ab6-c145-08db568b012c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MrBR6FYFJduTqrEt6HmDprBnNF0kAcwKrG9uosN4987tEfC/GBgU3uYiSYqGuZ+1m8qPgccRtpdcCDbTFa7lH41O8sKhvYKPIDrtaTuuOWhLYTdmlObs5DrFNfKhXbaaXpPlgWuY5hGanxZz3DiWx/b+lsELToLYdQ0aL7PKhd7OalnwWS8IzXvNF78yKyYWAtxVXKn9FGdvxluB6DOh1rKX/PyYIUt7SN4dPb92C6SgXczPcKAL3AweFUkLah6Msbbc9ehUWSlPYdLyR4HsSUtgT66qO7oJAswC13AxnTnzRKLGrbldurwyAHKdYvvhzg3S/96yP7RexwA2q1LMANxZdrqRVhD0rTjGHywpKHMBBsj861uzTwEnHzxMupShlu2wn3ateW1CEZsizC5RKbP/Rxv7fLG8iehk7S5hplapHbtqbIScpZe/TukgpOMMUDrkfjYN5pS8NwtHm4E/tHK8RKRy/R8lmAU1iVgMz8V3kPtD+GAic4wrHD879+8GbJG5y4x74ee1fEJL9eO5fecziNu+cMDpCbk/7HQrojPMuYLgf3jwi02VGre2w8m8hXKyQNhRJX3C2FYNM1/au7G/xB1EKFiaIXpTIR9DiLNFVGObmA+4teA1NemTwvWDfE8BEMV1Vxzg+RfG18MVTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199021)(31696002)(36756003)(86362001)(6486002)(316002)(66556008)(66946007)(66476007)(478600001)(6666004)(8936002)(44832011)(5660300002)(41300700001)(8676002)(2906002)(38100700002)(26005)(6506007)(6512007)(2616005)(83380400001)(186003)(53546011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tm1ZMkpiRUUvR2pRTCt2Q0ZYamExL0Ftam1ZSGM2YVkvbTUrb0QyQjBVcVkv?=
 =?utf-8?B?R1F5d3BJRDVRdHU3OWN3bkpRLytIY3huOHdscHo4am1Sb2Z2dEZyc1lSbEhZ?=
 =?utf-8?B?YUx4V0xHcmhON3pKQWdqQy9La2hWUm8rZDZSZk9tc0hoV0VmbFJ4eWpLMUxs?=
 =?utf-8?B?UlVDOFVKcWhZenlObWxyS05nRlRTV2lDTkNtMFZmSWErMU9nNm9BV1pKQzJT?=
 =?utf-8?B?QlFsdDJreEdiVWc0aWJKak1HRVBWeFdGQkZNVDNyNlp4cTdmb29wRjlJUm5y?=
 =?utf-8?B?czViMmFkblVDYjkwb0JIa25SdzJ5dGU2VW5qdzlxeVFTWUFOSk9ockQwazFN?=
 =?utf-8?B?UWtqazF2R1VPY2hCb3VodWpIb0ozZXpwMkRCV0ljbnNZZ0dIRDRNWGFGb2F2?=
 =?utf-8?B?em9yYWc1S1B2ZXdhSGpzMlppbnpXTm56MzJFYjBiR3YyUWJ0c0pnUDBVZW9u?=
 =?utf-8?B?SHp1dXZTQ0tBcG9ENG15RGlralNmZDBFci9xWndXR09VWXY0RXdZeHpzUnVn?=
 =?utf-8?B?R1pWQUFIcmVhMXd2L0xnUm1wdHBQby9uSmJud3NyTDMwc1Y4NzRyVW9pZVll?=
 =?utf-8?B?c2FQTGdVdmJLbnFscFVITXBmNUFUM0tpdU9oVldMWFdBbEVyaWN4Y3c4eitJ?=
 =?utf-8?B?Zlo1aGN4QUFzYmJvYkppNVJ4WndML1lmczYrRFg2RHRWZnJWdTRTZ0FkVEV5?=
 =?utf-8?B?ZHNLU3pUZWxqazRvRmNCdzZXWFJIMXR3eVliZmZOL2ZaRUpEV2JrdTZRLzhu?=
 =?utf-8?B?eEdHNysvSzJTdjdHK1pVbUdMQ2VlVTM2MTNFQXk5Sk9JeDEzWXFQZkNJSEhB?=
 =?utf-8?B?WmtWZmhVSEhock1ZRVNhRzh6NVFmMmkwa2VvMkYrTDRFdVlYMHo0U3pYeU1Y?=
 =?utf-8?B?L2F6RmhHY01EaSt3VzRyL2Q4NkFCSkdqb25GSG1vRzhYM29oMkNTVzZVTXJ5?=
 =?utf-8?B?dHJzZ2RkOC9DaVFjUHltSHl1VDRFL291S1hyT2NCTEJYUmZnQi9JYzFJUmxO?=
 =?utf-8?B?RVFuSmtsRnExUm9RRHo2Y1gzL0RtRURSTTREZk1UdW90blkzSzVtWTlWL3Jx?=
 =?utf-8?B?TExIUXNVSVRrRWhqa09OVC9Gb041RExLeUZEYjU0SlN0czBWUXlKbk9SUEJC?=
 =?utf-8?B?VzhBYWFkZmVaQURtb2I4cjdqdHVVd29kdzk0eS9XYzB0YmdyRTFGRFJ4Ti9u?=
 =?utf-8?B?ZU52SVhqQ0xDeHphZ2Q0blB0ZzJmL2J3Z2YzRHRpVjRzdWZ4YWJ3encwZzFX?=
 =?utf-8?B?MjE5aGVjU0RDVGVHbTNCUU5PTkx2b0xCejBkak0wSC9KaExGYVdSY2FTUlFn?=
 =?utf-8?B?SzJzSUd2dFN3ekMvb2ZqcS9CdHMxZ2RVdTc5ZjgzUzhIamFaY1E4aVhpaVd5?=
 =?utf-8?B?RXVYeW9rVTUzcXNYZHREaFMvNU9OOXpodTdSbnU2QjdodVFaL2UxMkdTc0VE?=
 =?utf-8?B?WkRaa21acVMyZGp5Z0I1bFFsM09ldlBrVzdRYXhRNU9BOXVDR2VLK25ScWRs?=
 =?utf-8?B?OWI1VFZnNUpXdGhJOFE0Z0R4UThpTkswa1paTmtEbUluMVFzeHRRM0szeVZL?=
 =?utf-8?B?RjM5aGIyQUhVVXc3TWpmalV1S2lEbUZWNmdoZ1V0ZWdXZStORXRvQ0MvOVc2?=
 =?utf-8?B?UTlVMUx0NGJOb1JoNk8ySFVDTDkycG5raHJtbmpPZkw2YStuRzA5MEpWRFl0?=
 =?utf-8?B?Sk1vOTZmUTlEaXRQbFpkM0JQMUdIc2ZySmRsKzJFM0RSSzhzUk13SjQ3MW5K?=
 =?utf-8?B?NU5xbnVPUU90YzZHWkpXVkYvRUFoRFFkeFIrekF1aXA1UWxYU2hFVDR3SE1U?=
 =?utf-8?B?NnZrZlVNekJvS056dFppcWU1SGlWMzZ1VkZtOUFjVmZpUUtpdUxYQi9pallM?=
 =?utf-8?B?eHZBbkhvS0pGRytFN0RiZmZtWTczMUp6ckoxeEdHaHZqY3FZTUFYQzlpckZr?=
 =?utf-8?B?cllLNUd0ZGtZL2Fla1FibndKak9WWk55R1BiU3lHb1k0UFoxQjA1WnJCS0Jk?=
 =?utf-8?B?dmwwSjc1eUFEeWN6MHViRUNHTDdReTY2Y2dCWlpRWlNicC8xTUprQmhlRTBL?=
 =?utf-8?B?aHE2S054L0F4a1A1aVl5S2VZTXhDbmZrTGRidXdDdzZoTTRleUVjQkVaSko3?=
 =?utf-8?Q?dLSyxWycmcPkkOKrIeDQjgbfs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GTVtmzADmacBDnufqVD8kO4IxtVMSRfxi7AwowuAI9F2m8JZgT3EdNrIpvGHy/8IaKjWmgqB8Rusm/6MfJuYnRbwd0rD5mop+3bFJM0U3dNbremGp3YSrHjAomlwbVKtigU+O9lrlI518FqAfCxXMxtaybwPrRgQDPXyKJUJNM4cPMCaVUsBVNFfeB8EWcrciG3Y9tKT9gDDy1Unkvxrw0Wp9Q+nhn5PwynmrFt8lnRJw6VZPhD1ih3ipEgRpt8xUjir8H8o+8a8O7WALFVCu7rehlGT1K5/FCr9qyIQwe2Iwq3RNKisVvHENyo7q0AinUwnVXwqgMUS5GpFWdhAByjLoqb8wvJWHzWvVTUu4xjQsoKONxz34dkmcYSskLiRXpFzhGxSbsk+3uekl2122gisERtQclpHeTiqrn34UVkvZoVl61eTUatPvppcbkZLWy4SO0gRwl0CrhiSdJjkP/iaRi8WaCEY2kAf9YASX2mNmul88X+zrxs7D9d5AO+5pkRuMJ/u0XeP3mbod5H8c9OF7abAJ/6PFFAlLGOXZC5bcRa+SRuPuaew4p480fm730RXOmsfazqb21ARNlXZTUnFV0tvdrZrc/U0XXidr851PEY8q2qUGNHm5/S3Y8kcuPpKhAUA875uEuZIe4nT6wAZyORzWf7cIEsJrzCiDHVgmnRbaioNgk2KUPy+6BSVsHANWM5s5FJ9xE6ll9+r5zVK/lwYa9Mt1lGBM6E9nD3+1fsxPCCM0q7/T3Q3u0D2RZLwSoGqMt1ctwsfm+1OCqfuAwdjxL7wA86F6d3D0Ac=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d8272e-e110-4ab6-c145-08db568b012c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 03:58:42.6266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pOcuDsxRdpeIAvz0ez4LeS8OqMVs/7twvfVklGxbTGfyVSyYx/1WJ7/qFUAoas1ua0WtgB2kVcAM+aN++K6n3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6904
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170032
X-Proofpoint-GUID: aUZexUGt1VJu1Ei-XKyTPvmp1yanhayY
X-Proofpoint-ORIG-GUID: aUZexUGt1VJu1Ei-XKyTPvmp1yanhayY
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16/5/23 19:28, Qu Wenruo wrote:
> Since commit c8593f65cbf3 ("btrfs-progs: sync tree-checker.[ch] from
> kernel"), btrfs-progs can do the kernel level tree block checks, which
> is not really sutiable for dump-tree.
> 
> Under a lot of cases, we're using dump-tree tool to debug to collect the
> details from end users.
> If it's a bitflip causing a rejection, we would be unable to determine
> the cause.
> 

  Yep. Agreed.

> So this patch would add OPEN_CTREE_SKIP_LEAF_ITEM_CHECKS for dump-tree.

  By default, it is a good idea to skip the tree checker for the
  dump-tree. Additionally, we may requires an option to dump the
  tree with the tree checker. However, I don't see any use case yet.

> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand
> ---
>   cmds/inspect-dump-tree.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
> index 7c524b04d6f7..bfc0fff148dd 100644
> --- a/cmds/inspect-dump-tree.c
> +++ b/cmds/inspect-dump-tree.c
> @@ -342,8 +342,12 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
>   	 * Use NO_BLOCK_GROUPS here could also speedup open_ctree() and allow us
>   	 * to inspect fs with corrupted extent tree blocks, and show as many good
>   	 * tree blocks as possible.
> +	 *
> +	 * And we want to avoid tree-checker, which can rejects the target tree
> +	 * block completely, while we may be debugging the problem.
>   	 */
> -	open_ctree_flags = OPEN_CTREE_PARTIAL | OPEN_CTREE_NO_BLOCK_GROUPS;
> +	open_ctree_flags = OPEN_CTREE_PARTIAL | OPEN_CTREE_NO_BLOCK_GROUPS |
> +			   OPEN_CTREE_SKIP_LEAF_ITEM_CHECKS;
>   	cache_tree_init(&block_root);
>   	optind = 0;
>   	while (1) {

