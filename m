Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEF56C30C9
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 12:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjCULtD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 07:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjCULsy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 07:48:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DCC13DC6
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:48:50 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LBi7Nu032688;
        Tue, 21 Mar 2023 11:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=CEpLXwH1Y9VcXgglaypwtrbfKbyzAU2yeGjQNhEnzAoeH/c/BrxSeSXzRYQ2FAVaX9s3
 9+1RIGZfjzIfgWJ0m5sPqIW6avJ5n3LXNxE+dKKBdo/BH+Z08TzRop7FB+JGkQsQwxFt
 SmwdCWrJ5lTz7Ncq1961uzgQzxPJcLzzgaQ8IYeVBzrkUeq5YFseNCOiB6F90yv8tK7X
 /Gth8aX4gvo6q+sk7Xrtto7p4RM/4ade3165j2Jhu0MicceiXl4qYBXWDSTN+arh6LX+
 N13fbGxyxwM+niSXomuchHhESr036If//K97TtHn82xgyOPDDqDMXWnm3nAmstZBe/EJ aA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd5bce0sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 11:48:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32L9fk0a036875;
        Tue, 21 Mar 2023 11:48:46 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3peg5pmx20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 11:48:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YH5uF9TSJSyp2Co2sSl25VlTAgklDOvF9ek514GL1ebLymuc/hPxjodpwGaavzQe0RIBohWBLNP1YW1XbXeFtxiRRabtEahKfRziwHylFjPmE2rq1ni+Y518KHNoGBSYt12jkG/ay81mCW0dAuwvypBAO/ytBHeXzreILwS4xv2p9leZ4p4foG5eKaamD+xICbnWeGTfe/2T6AMV7qRjLkkzllEOVROsrYfGqHb3OEiyRUiRgJZrjjLb39BbzcAkAvuFTryuWH4pLYAVM+1k/v3fyryu/NsCVfdCIVXiq+fCrvZFYrTjr7CibV5oFQjtG3mq7q6XzAL2ucCPVd90vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=JToV7xEOv9VzYwTwKArNI3MJaX3rsX0vKg8PKpKlE3qvBZL1iEgSMkZQPNLbsoYqzq0AC1tiagSaw7fh2i7gkaovzfmf8/vtSzue81epQnDz6PWqwWcQ2NtvjdNiZ5KRv1vpqr0SFjKtTVmXVb/jw86OsDlq3pvjck5hYR3b7GJuCr0AzGi/LdGiwiys/CEwo1otHv4Q1VwXPPKG3ABxFok762i7pCUPrLvQ3S0sUcXNYwgK3R8UvExq5DT1876SC/PC5jQ3HCMO54m2URZkhPsE1f4xlxJ5rJZZ914NC4REkCqr+MF+kFRwUJGUbg0OXfHPxgFr2C/UC1gYhOV2Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=Ss9+tZ1ezs4Nc49dLMbGFW2SCnTflFztkxJwytB3peTrkRFAW26y5VTzKStgNfwuIEuUJWN33KCgm4x3Hi0zryGQzGZUOm8fR8r4r/R5mNa0MwDlJ+8r56CdFBxVEu4ANf7UIQhm/+JodZqeOHiEdQfbKgPxoWMqlu2/1ipURoc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5327.namprd10.prod.outlook.com (2603:10b6:5:3b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 11:48:44 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 11:48:43 +0000
Message-ID: <ca401f30-fba4-d68f-15c6-e8a5b4273100@oracle.com>
Date:   Tue, 21 Mar 2023 19:48:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 03/24] btrfs: remove check for NULL block reserve at
 btrfs_block_rsv_check()
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1679326426.git.fdmanana@suse.com>
 <8a7ecbeffe854a442aacb7c5c0c97b9f44528ebe.1679326430.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <8a7ecbeffe854a442aacb7c5c0c97b9f44528ebe.1679326430.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5327:EE_
X-MS-Office365-Filtering-Correlation-Id: a28ffc27-15f4-4940-a450-08db2a0238bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: meyGqY4Bfle30w/gT9gKlPHlwADJH3AaQB0RzD/WSRBBSYhmZXsPirdNAFHDFFHHN3dAIBywl4QePW7pe4adbUUvDPgzlHuRwGsnx66jhqC8Nd+NjMiiowMSVu/6zZ9hnN77ZU5E221oYIMK2qj+UpNujnJLVwYM36ayHGgviTt6Se+E2eocNt8pUeeB4jOqFydl0jmkHWl7wr5DzOo0MMQN0ODmfcrq31fvM14mRPgXfhIFBuQigFQNHUnfc/hjFqfiNWpZRQz+fOTjutiyqEHbE+Q3/1Zb824wYvom/c4WdfoRWsAFRgefaKLEF0jHEOIvtxMqRKzFFzHEpevj//yNJ8UeAZ/WG2NkH6mlPRoyFEbP/05ZQxIJZCCEXDmzwEUhxMHsu3yNKs/dWoVSfgHtc/UiTud8v+1t3v34ziaT0kFqGk222V5oGIK0QIKA1rbHxBfOpSuoi8AEUsJhJTUovNDfrYIlT86ThHGR8bnZcprkFcdd/H1iksYO2zjW66gZ4YY2yiyBcnAwZhRyBMNCZ/97AJQ1AklcML8Hx9fbHkaYRicdNpxfiK6un5u88vn1k9PtAhoWm0Ka6fjaQKTbRp14NwegSDAIBrsdtETz7Hbq31HSTEEqCWut4sxdmtJhxhAfRODtXaRrvVwziLxcGB0aBHd2Oa0ZiYuwXsDQlQYNczUX/FowXwrI4RVFS1PhmcSm+tRmaJSDStr+9UvVK1enQ22z3fTIiInHmGE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199018)(5660300002)(8936002)(41300700001)(44832011)(36756003)(558084003)(86362001)(31696002)(19618925003)(38100700002)(2906002)(26005)(6512007)(6506007)(31686004)(478600001)(6666004)(186003)(6486002)(66556008)(66476007)(66946007)(4270600006)(316002)(8676002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEk4aGpWazFwTEFDSzN5K2VjMUlaU01NUVpHelZBeGtDeDFSOW1hMDJXcVVG?=
 =?utf-8?B?MmlTMFRkbUhmUlJNRUR1NEFXcHZYeXNzdUtxbXAyYVM5aG1xeC9YZXBTOGZl?=
 =?utf-8?B?V2NOUVJ5enI3RlNWMUdxa0dCeVBFalM4U1dqaEFjRkV0TEdJOTQzWWtOQ2R4?=
 =?utf-8?B?Wm5FVTU2b1B2dFh6NHRpcmhRTThlTFFBUENrQUYyTi9iVEl4RDB0Znlkc0w2?=
 =?utf-8?B?K2NUUGxZV2RieFBJbFQ2Y1hmQm45TVpsVFZTNCtibG90ZDJrQU1ud01ITldw?=
 =?utf-8?B?emZWNGM2Zlg4L1c4TXVPK0FaRlB4MHhyWmVjNFFoMTNCbndBZkxLOXpnNDlp?=
 =?utf-8?B?cVk3VnEyTGJZc0JFQk9KVDd4QjFqdFlKaCtaVVZDM01ocGJQbFN0TXFGQlZn?=
 =?utf-8?B?emxqamxNUHZJeEhFRzVWSWRFbUNGZC83dHdCWlA5dHlKQzVWQldpSGx4VDhz?=
 =?utf-8?B?Z0M5aXJ4YWdEMmdJVER2dHBndXp3K3VHQllzUDB6YlhydDkzMjlkdkw3RVFQ?=
 =?utf-8?B?bndnNlVxbEJKMm5qUUhNY1k5V3VHblkxM21KSVpoZmxnVUxJWW5MWmhFY1FF?=
 =?utf-8?B?dE5GTjVKS09OOWVkZEVNbUt5SjBDVHZsT2VJNitjK2tSclowVjJRRjRONjhk?=
 =?utf-8?B?Vlk3K083M09INWI1UldsUU9rTGJQTlVGVDRKcFdDQnBKMVdDNGl0OXJPY2pk?=
 =?utf-8?B?Q1h6K0FrTTJ2c3ErbEpXaUdGdXdqWE5wMHN5eklTSVRvWG00OWsyOUN0SFJk?=
 =?utf-8?B?OTkvTS9kUlEyUmtBR1lUZ3BBMnZUdjJjZS9yL2tMcXhvSjJPdVVybDl4OGVr?=
 =?utf-8?B?K1dYZkFSdXdMSWVRa0lQMDliY1hFSGNMV2hRRG02V0FXZFRFNnMyaDhGMW9i?=
 =?utf-8?B?em9LY0pmdnFWYnB3WEtmNVdUajhncjk0MWRBWnFJYkFTbHp6RFU5dTJlb21x?=
 =?utf-8?B?ZnJYR1VNU0hOdXh6UjR3SldzU2xmU2Q3bC9oY2xDSXdkbFNQTjlhZUZSSHIy?=
 =?utf-8?B?Rng1c0VJS1BzejlLcHVxVU56bjRUNkI0bUpmNjJLdHlKa2FKdnpveDl4M252?=
 =?utf-8?B?cHNKRmFsNkxtSlFDSHk3NmNmSUVBaHQxbGdJVXpjb2F0Zk5GN1dtc1NBeEJE?=
 =?utf-8?B?SnlJRzdsV0xneXdwc20zQXpFWDFLRjBnS3RuYk51UE9MdWxyd1hjQnVjOWor?=
 =?utf-8?B?SXM0dmhudm1uUStGRmhHdGtLY0hGRmNSN1ZqalltN3krN0ZnQm9jQnc0Tlpj?=
 =?utf-8?B?Zk1ldE5MN1hJdnlOUmJuWGFxWlg4MllLQ0hycURsRitBM0F1Ums3cTN1bzVG?=
 =?utf-8?B?RmpuTmlsSWZXa3BqaThYV2hqTGJmdml5ZWlKd0RMeVMzd1lVTW9GOXo4Rmhy?=
 =?utf-8?B?L3hhMjBvNjFXak1lS3AyMVlUTXZJaUorOGplRi9TcU0xZHh0czh0YnJ3WXUx?=
 =?utf-8?B?bGtUaEhTYmN6YWhqS2RrNXUyaHJ3WldLeVdJS25KL2RXbmk3RlFaOCtRbUww?=
 =?utf-8?B?Smp2Nk9oRS9yZjhwV1Q2OE96N3VzUFh4VGxRb2R4cE83UktMVUkreWQ4NXlr?=
 =?utf-8?B?ZkFpZVhFbkhUZ3ZVeklnalc5bXlxQlZYN0trMXkyNEN2cUJuMk1JSndKVEU1?=
 =?utf-8?B?aVRrbVpPYUNWSFVvcmpBR0daWUlvSUxHR0xoWXlnU2VYV0hQSVVOUmdNL2Nv?=
 =?utf-8?B?SkphSFRtYWc3TzhJN2hNWjJxOWFQWDZZL3hZS29PcG5NOTF3TEZnZVd6cmFn?=
 =?utf-8?B?eHY2ZFhmM1FSUktuWDZlTkZZK0hDNVl2ak9UMHhKZkJqQmxsbGQvS3JWMGNh?=
 =?utf-8?B?U0xmLytHQmcyQ1hZQmUzMkRyUFRpQ29DSFdrL08yNGpyOGNVWjZsSDFISVRa?=
 =?utf-8?B?QW9mN1Z5eVBLTUcwdTcvV1d3VjZIN1A2UUdQQ3JneHRJVERkRDVuNG9KRVo2?=
 =?utf-8?B?RGZETXNVUFE0SWRUcWgyZWtZbzlRNzhhRStSN1o3N1R2SW1TTWh3aERhc2FD?=
 =?utf-8?B?Y001ZEFXVGJQVFhDN3NETlhqc0VxM0MySzY4S2ZJYWtJd0VMR0VocXBDYU95?=
 =?utf-8?B?NUxMK1RRM3d3THRDR2JjN0Jrcll4bnJQaG93S1JvZytsN0wvcGttSFhKeFhN?=
 =?utf-8?Q?N25c7D6awd8QxSoUXgsfaLLcp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 43y0z26YM7IdwzSbmvHfkcL/NFFgrfef7MpFFvSFXvbJe9vJvsMah31CnGhetoBA1gAGDRBLngifzfHSu6dzQie/myUjTGMYuD+c5ukZOjctqSe1w/vkjNiea0mfJBTjSkW9L9Ql6eN1VkFfv5xQTKr3aHLdJIrpNRn2ErmGLU29FhzV3ga9VlF6OqV/kX+N+cc93tdoE0RnDOBSIbj61iI6/BqxH3195XTaecMRE+NUQIIzIrWHN8SAknwsJsVUNG72vNG5YhwDOF9H3sJVssCQEhvfWAsSEqiHd3vCAG2N1/CRI3AcNRhXvQ7qYhGIyixd6FUm4+p1pJs3K5GxGe7ZWxbfS+srOAd1TFvdOuwpXPbdgNuIEQfyegM7GsyEZduE9AIrTe3zrzWF18RCkeiuKjyQjObBm+lGyk6jyWoxtTY5/qs6qTc6I75rcWq3B6TpEv0um4LueF1L/DLqDkLc6XXHAPZpXs+yfgoleYF+d7suclSjfAgsxyBJSVVwZEQRMhjTIcaZYj8+rA8UgI2D74z7EtlSDkKyhYNIg97c6pryzSGRQMALgBkwEdxoZTuYnEPu7ccbBqHqAor/CzKQ+uokZxBgzAmGEdzHy9v8nEdtMvojkxIx8XyG40MQbL9x7I8oqDx7dchCSKceRVzvWOQ7DeNgmTuJ+5RoroHNlxQsyQ6ekMiY9WSHNrmy5aJHuRcRD3vaNeDqSb7fsa2fGxAbUSaflUGlj5NcCw0xO/O8jRSIv0eMEB5CD0iDqgsO5KD+0sz9W/5KfbMLsctp8+VaTm16UGrsYVyrNTY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a28ffc27-15f4-4940-a450-08db2a0238bc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 11:48:43.7789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3hr9625LI4pYvMF3pg7oX06K2PZbt9OaMEYJU4uCVtAjqvWDNBxDYi3+rgEn55El8O9eNeaO8Iflml5VZHjkCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5327
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_08,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303210092
X-Proofpoint-ORIG-GUID: ELsJY_x1Ig1EXtZh6UTWE1nTzmPS37DZ
X-Proofpoint-GUID: ELsJY_x1Ig1EXtZh6UTWE1nTzmPS37DZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>
