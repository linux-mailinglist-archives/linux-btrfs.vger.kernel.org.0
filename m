Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB07F6CCED5
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Mar 2023 02:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjC2AfG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 20:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC2AfF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 20:35:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4BF1BCA
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 17:35:04 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SNiN7r026090;
        Wed, 29 Mar 2023 00:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=PREdAacV4qFSL4YA2papVy9zDrpOb9FuspLKzpQTQUc=;
 b=hNU6uf7eQ3e9LB2YPR1hwYoKzpmG7h716TETz3tyYeu3sJUeYrD/kL8vOwRaNiViCSge
 6XwjNSpt08TM6pLY8N3lRiBdGG/yatbhMytVCm5NuD/neSxd7t6QsNsmKQGcp2K13TdI
 uDf9nDm4wB+nnv3HypRNv0unThq+6EYwXjUCyZoz5cwaRV8170VqT42UndpHpr5cWnf3
 UuMX6GfYBQhZBIfTW2HnJDFHTqPewxA+beioCLqlX9SZGTlt5zkUOsJWeqSh+vyIgQtR
 nr2/Y1fx1tKI0PMx2p5FFZ8RtU4Hn3H2OSyfAM4+D+jDlodFi7tPbtZ/eb//pKkWUwx0 Vw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pma6001u7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Mar 2023 00:35:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32SLrTBj020399;
        Wed, 29 Mar 2023 00:30:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd7cdv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Mar 2023 00:30:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8W6u06sDhfAmSbz8TJqQY8D9B9MUd9SWvoz+jyi1SC47sTQ6oy2QVPpUwoFuBS1HgI0AXy2NTNbm4AOh9WsDzoLyv0/A6I4OlvqVKGi3vyqZhG9V9PjRQycfp4r3wcqqrgdYet5HYKHCauFXQ+fG5wkBgaWQfxNI4VTqrf7DBo5jnRqf4xqeqX3IkbjlxHXJ3lfJproeUzogPaIF+X2bUtLAIR95StZvCddRA7hYHY56+ZkXr3tiOWjKzXnQtj/Z+Fj2Y48Y9Ff1+ASn/kKHTUCToZrtqi+EA0LS/s2pfhS6rZGGKpiIMtLM804rpR5VADr2GyOgiBiwyVBYIesWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PREdAacV4qFSL4YA2papVy9zDrpOb9FuspLKzpQTQUc=;
 b=NS4UM/6MbE5pKbcvlKiKwfLad1AqhwAlIojEROgoSJYwm3egbNMI2xQ8jphl0VUX0evPTFxBDfUwpzvZP7jMTMNWpInC4/e8msu8VN/gqGpM3Xkn6MMU7YuX6JEQjnGQyfPJYZWv3kwTAtTWrGALcqU2x3RCeUxqGTmv46A6xG4vh0NmzSZjPkQO1CMYDmcBtwKqMJK9ay0Qf24ce8cjMctL+VE6g/U5Q5KD6tZJK8BmJbtHIFpdP9ysORw/QyyEqDpuW3JLgF2uaxJJUKTGr+tY0T66dj3b/GuVLwaD5FJNWfZNDpdKl4thbajhKZtrmzhclzU1RRX4pVP89mJacw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PREdAacV4qFSL4YA2papVy9zDrpOb9FuspLKzpQTQUc=;
 b=lrTJbat5zE7Cx6dEou+f5XPwBrN8tx1QIlY0ih44DQXXHiWQHwVO4YCdyjDd+yR6QOY1qewHHAAzy4aeQFG4UQeJxaBb0oAphDp0HLoEF7yQAN3vQ+OMRVR81xo2EPUKb6r1zZJi/91xcaM152ITec/Elgg7HekXpqlvXZXfcuA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5406.namprd10.prod.outlook.com (2603:10b6:a03:305::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.32; Wed, 29 Mar
 2023 00:29:58 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%6]) with mapi id 15.20.6178.041; Wed, 29 Mar 2023
 00:29:58 +0000
Message-ID: <57b47012-2649-227c-6bf5-695cbe166513@oracle.com>
Date:   Wed, 29 Mar 2023 08:29:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH v7 01/13] btrfs: scrub: use dedicated super block
 verification function to scrub one super block
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
References: <cover.1680047473.git.wqu@suse.com>
 <7e5544dfc26a6d0673dde60e07b1ef3bc91b98a3.1680047473.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <7e5544dfc26a6d0673dde60e07b1ef3bc91b98a3.1680047473.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0229.apcprd06.prod.outlook.com
 (2603:1096:4:ac::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5406:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d5d4d91-30e7-46ce-8c6c-08db2fecb9c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TQs63VzvsRuzS7pGwdBtZBbjJjIHL+MGE4UTVWrbbuVG0wvyYQjRzm8FYnYK4Njl3MQUBNQZeCL4VMcYZmC2IQaQjckHJqgBfiUZ9EZ+iZF0423jlR+xG49tswg+dlb6PGw1LcKBu4+STZxTldyM4eL92g/z1K8PeLMU1zJFipjHKnEAPOsRN1sEwpXpdrVnZvVpyFquef4XbVs4qwregTEkTuyEDyZFEknK/6r1ZsU5/vcDQNGNiLT/ZIDCIR4E7GHNisgNtGLQW5fQOoSR1z5HCV23vKvMOicgt0ctRcaTKZn7y0R++QnHsUHyr6OUZ5D9YhHyQLwFlVgP8ld7EPx9P67xYUoxdMo9JGMmTxPVmZoxXLw2hfdjkcrLENxWZx21EbYiL9koKub1yy0tB+k5BVVIGSRKWwVMgVwazkVamz+jrUhlYiIcM3MuxmhrLZwlCC9GSJpIFll7DbHJiZ/VJidTPRzcpJZRylXA/QLbzrWNx0oN5fgL2e6nKXeSVAW4KznP6rQ4+ivOsvw01RCBe5SPAAwYyiUUTTnZgFLrQCkMmFZ7I8JqJ1JSZUsjmtMgdLE4lwV9RELoVJDj/cBJ7cq8CKMjAmf55gJWFIY/0RqO6rjvv1nsEUatHcDbQS/Cha1qb3rUnu2PN5/J2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199021)(8936002)(5660300002)(6512007)(558084003)(36756003)(186003)(26005)(6506007)(2906002)(31696002)(86362001)(6666004)(2616005)(44832011)(6486002)(38100700002)(41300700001)(66556008)(316002)(478600001)(66946007)(4326008)(8676002)(66476007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEZaMVZUSWo0WkwzMnlvRmorN3l6ZnE2WGVoVk1OQ1RZcWhPSHNRNjlUcHF1?=
 =?utf-8?B?S2tRZll1Y1RobmRWQ3Q2blM1M2VmRnFnVFkzRVFXUVYva1Y5WmEwejVHcVBV?=
 =?utf-8?B?d0l3TUR2R1BvMUl0NnpTbmdRM0FMYm5WWktES3o1MVlyK3ZYeWF2UmxIeURN?=
 =?utf-8?B?OW9HbjJZVzkxcnpHVzRvK1dEWTN6YURMR0pmUGx3UEZTb2lMbDFzZVpxbzlx?=
 =?utf-8?B?THVUa2phcVRjMGJXaER1NmhHYWMxKzV4OEdtU0s0RmNMTUd5UUtoRmw5S3pJ?=
 =?utf-8?B?N2xVOXBoT3U2NCs4VFVnMXBkS1VlWHRHRVRLR1I4UGNnU3FSeVBjeWZuOXVk?=
 =?utf-8?B?Mnk5TWRNQXBGUnRDU1hlTXpCYU1zYU05VGlwSUtobHV2N3ptZmFacnpjRHFp?=
 =?utf-8?B?M0xCNndVSG42QVJIblp0NEpiOStpQkVLMTBhQ2IrOWVuaW84NVUxT29PZ0pC?=
 =?utf-8?B?Z0tza0NQZnBXL1JuOXNVMGNQZVVUanR5OGEyOW5JMlhXaTdkVzdpYVB1Yk13?=
 =?utf-8?B?dzR2QktEM0l6YmhqTFYwcldqQmZXeCtqV3RLTE0xOWFWdWFBRklWbWZ2MkRU?=
 =?utf-8?B?cytWcUFEV3BkMWFzYjhBdVlMSlh4OVhXSFNLZ083MzZyYng5aEZuNU50N2cv?=
 =?utf-8?B?NHNLSUhiM3pvaWJOcnVqR2FzZU5YUGgxbXZ4RC9PeE1QOXZhaTBzd1Boc1Nw?=
 =?utf-8?B?UnQ3ellXdUpnWlBROXk0cEh1RDF4ZlVNSmRIdTJJM2E5cDJ1R0ZUYUNCd1da?=
 =?utf-8?B?aDZ5dkI5a1JqU1N6dm1USDVDTnE5N0pMRVZMSGVpSmRzcFdRSmlMaVFpUVVr?=
 =?utf-8?B?UFNiL3J0N3pRRjF6TVYzbVY4U2Y3cHNjby9td3Fla1JOOHBYSkVXWTlqdXZH?=
 =?utf-8?B?SlRMTmQ1VTEyZ1JZeVgvL2Y0c0ZpL3FiOVJBSGdWYXY0d3Y5SGxqSHErcXN5?=
 =?utf-8?B?dE1jdmVSQjM5Sk9wNXB0YUIrRWlvVVhwSnhON1NRbzh1UHd3L0I5dzgrZmo3?=
 =?utf-8?B?OUczNS81UWc0R2R5cTRscmEvNmpQRVBTYWVYYnRFRHdHY2YzSFBFQ21KR2pu?=
 =?utf-8?B?WVloQk1JdEtjckloYjl5ZzltYmc3Yzk4cnY4cXdmcm43ckg2RWlTamZiQVhV?=
 =?utf-8?B?UEpEdDZkK2twaFc2VklBVCtVUk5zTUNCcEFBOS96YjdaZlZEOXF3T1NSS3BK?=
 =?utf-8?B?a21rMkkxeUdKMDBUNUFISEpRcVgxNXMzbTZ4Z1hoZm43OUJCWkg1cTlXNVRP?=
 =?utf-8?B?ZThoMnhRMG41b3Mrekt3SnlKbGpRUnZKenJROXBpMUNjK01SdG5SU21CbXk1?=
 =?utf-8?B?YTZldklxY0RiY09oWWdxclc4b0hXeWI1Z1Y4bWV2YlB1dm5QZlB0R1ZybGN4?=
 =?utf-8?B?RHFGMUhzQzlmSThrOGpuV2FCeWdZSWllS2tGMXY1eGdpVHc4RksvREppR1Yx?=
 =?utf-8?B?QnFNZktCYUwrUUVMaU5PaE5YaTJZektOQ2hLdUMzZ01qdUxwUUhONWdCUUxQ?=
 =?utf-8?B?TG9ESkcyNkNyRzF2S1MxYU9nQnV2Zmd0bkhHbU5oYlZkc3BhSTlCNGJJRSsy?=
 =?utf-8?B?cWl3VHF1K3NCRjc2MU1zTlpDTE1FRnBHdk5YYXJUeUpIcTFFNW9TREVhclRL?=
 =?utf-8?B?NUVqTjRpcm5paFEvbGpUek0wU3dueWJ5a3F2SHNWRHVKRnp3dVVndTlRT3FP?=
 =?utf-8?B?WkI4byt4dVpYanIvRVZna0VFWVFicDBjUnduL2hNb1JUNzd1UGFrQk4vcEps?=
 =?utf-8?B?TGU2Q3FUZGZVUk5aYVpXYyt0MURQcFozeEFBbW1JMDhidmtqcTFueUV5VUNF?=
 =?utf-8?B?UCsxZFRRMUxWbWJCRDR2YWo5M0o4OHlHVjRVUUFVY291Z3VrMkg4Si8rbVlv?=
 =?utf-8?B?VDNrSUxmbDBqeTc4N2xzdzFQcEh6U3lpQnE2MnNuODNUN0Rab1IvSTJSSjZv?=
 =?utf-8?B?ckh6SmxOamkrVVcwTXIycjRuZllPLzQwYnpKV0xWZ2FsZDg3a0lCY2RiVXBm?=
 =?utf-8?B?cTkyaE5PU3g1YjlTd0l4QUxGRTlFbEM5R09NSzBCaGVSRVdUWlh6ZVpFNE1s?=
 =?utf-8?B?Vzg1ODlWOTJWeUFHK2E4Q0xmSWJmWHN2bm42Vk5LcC81QkNodmdRUXdBaDhj?=
 =?utf-8?Q?OeMsx4S+WDydMykX88ReK0dxO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bxNL8IYUL3K9NniiJNUgh6xChTIWja/DtQwRttEfQY6P5xVYDoUzjk69nYKgFSriL7gpr21qEbhQFueKvtbr8QlxdjfG26hkoj8D8uOI+y93LwqVH4xGZvw2jLzXdRAwpkePLIvzorhyTYArOxIbsqJTJJtcE0BboETcaDtaxL8o3HS7as4r9Qy4/HF8SZubNzjmYmaY3Ln5kvZx+QsajzoEjpdQonxQOVb3ejqZF/dsPoIiQBBGTHdh24i2f0yAWCCxEV5i1iJNmtjtgd/aES11hkW2Qd8/2Hvo3+3iZNvRuYAicPU1zxNY0ruuPU3PogHkob4c6p9wwGYHb0ATiVPWUtmVtgV2XiIIShuDw9Ll3YL628FoKPdgR/GOO6vqXCUmaFm0jmzIOUDaPxQ5xdjtlKvk7KYovdsUztaxR3ghdFZ2ZWmWOiIeGiYtjGRthdZsvOoIaPWiyFfH9PIbUVLbnb3fZgO2RuscOCISIZt2rf7krvLZdT1L7Q9xxAowU8hVoiriIxbCyfCm3/u51fcBq3jaI9mhUMwLMoxWDhJfvG+GpUL88dlIYeBQYRBOr5defr1+5w5UHk4QhOG0GzF0rqs6zr+f0O7Dma8y04iO54gO/n50LCxcwSvOzQhbFkfHrTtENGuVlGjkWOHIMw7cuF4QXGXNjfGgTaal1acN87O7nX4UoQsSwESbIpkhhNlffRC3yRsHs5DjAPdlXJJNo4I0eI8WguApIs2BJ2Lki9p/QjKhVQhaxJCl6a91wip8QoUZmt9yYdvH16Cf7IM3bt9JSlJ/L/LxjzFREzo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5d4d91-30e7-46ce-8c6c-08db2fecb9c4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 00:29:58.4147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmuF7jrRNvUOnkUZVqGtYWy6vIbtjtewUi8bMEFXlw/Dun96p/PWFMkoIdumHDn565lMWCNTE7ORdNg7Ln0qxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5406
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=929 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303290002
X-Proofpoint-ORIG-GUID: 1lDNM_jXYVPiL7SQLoDMV7OucQz_txRW
X-Proofpoint-GUID: 1lDNM_jXYVPiL7SQLoDMV7OucQz_txRW
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


This patch remains the same as v3, which was reviewed.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


