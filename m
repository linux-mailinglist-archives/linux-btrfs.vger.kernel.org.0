Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95B06F804B
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 May 2023 11:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjEEJp5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 May 2023 05:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjEEJp4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 May 2023 05:45:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CDD3C20
        for <linux-btrfs@vger.kernel.org>; Fri,  5 May 2023 02:45:56 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3456YY2c020764;
        Fri, 5 May 2023 09:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=SCCdixEvSWZoQv6sIEGfuTk2XXZEW16s0lJXr/2ZHIs=;
 b=FZTLhsJFZfUUbMSFvM4DeTmjBhH+AthLx+Wr9ufjIT+azhE7yzZjKl493t+LZpX6+7i2
 gqYsiGqwga5GBIeeaIH6A9m+9x/VkUyhBnu4GU65tXD30qSee9TAPRPB0k/0UiV4+jlZ
 GQIG4cHUU4lDQVcsjyJsegAi4n+pUpkVN5eIMcy9gnmWjQRZvLTQK2nkQA4JUOjYDzQt
 QpuDrVcDrMvUcyKiU6ph+dVlCiMdkunV2+hBt8UMvs+wLaOEnTV/V2lNsJUSzht4E0Tn
 K9E0+7usopKJcRXIPwcT5k6ZhVuE1qnt3YJrPihxwcutGzZDhNSsPpyHij9fcR8DNkLp Xw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8usv498s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 09:45:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3458SeNY040436;
        Fri, 5 May 2023 09:45:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp9qcda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 09:45:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDZ6VxSkF5TuBEqxcBWrnTIM9ltm6e1gdWdq77jKeEO2YDhM8UVQ/BUxFinqZ36JqOilSORUtcP97cBC7iFiKWS2+Ag8tZEJJsHSzu76i2rc2gjh5QCEL/qewEe2aGef2QwRkRchi81Unagg5sJCjdrtwK+Ro1u7+rpVvXJp8/AW1jZO0l7I7O0mP6yk09EK2a+HFfP9WFp8POzdzPZ+s5q6fly8oNiRmKNjGMu/ntljAmkwcpZMYkdn3xpXFarMNnP00FRqTbXjzk/ImjbQX7T4+aamyqyatonBiBKrw4xzkA8LdyxDxpVjhCnO5ol89HUY1VYaW+mHzEIe4CaI2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCCdixEvSWZoQv6sIEGfuTk2XXZEW16s0lJXr/2ZHIs=;
 b=IhuUk1qLWm1ynZp9olV1OnG5cCLi/dLE+x7X1ivmcEHH4xWOb7GLKZPxnywiYiJsHnhTZoPBSG2juKB0P0dGIjR/18z3bJIDqyZC3nGimtBnzE4l0spIx/GbSiwbuQ3QsuQfK6h+hJRGb9UF2k2OuNPV3kKbo2XSDyX8wfu4Q/7z+0sMf0SZGt+x+Mu3DZ7uK+04NjGmd0rVJlY0Bx9ARuDD1i4ZAXSJQ2PxSMTJhI1qVMeofSPMyiXEMMUQmgtn89W7EtTNIkiqg2ghNZTJPac2ddOtL5FrpKyH7MwcA6HVXVDVSdndpDEQhrGe6pUWPjI2Lu3hU9C9Qv+Z3b+JjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCCdixEvSWZoQv6sIEGfuTk2XXZEW16s0lJXr/2ZHIs=;
 b=wic+5quX3NCLmUG+I/pQKmm6XNZ+w5NrCg7pxcUpT85fVKRdyuBizGArUFat5RuzAIbbCOS0hueoDZ7n2fjMvcyhe2zcr5cufADcP31vdPULhcTkjw0aHvLkctX/Awo7DaZjATkqTGk7jrLFLDfk5kLxW46XMc0Zp09EPYd9Gdg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4567.namprd10.prod.outlook.com (2603:10b6:510:33::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 09:45:44 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 09:45:44 +0000
Message-ID: <f435bc4a-8623-8c62-30da-5b08104d6026@oracle.com>
Date:   Fri, 5 May 2023 17:45:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 8/9] btrfs: assert tree lock is held when linking free
 space
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1683196407.git.fdmanana@suse.com>
 <018ffcab35457b341195411e85614029f3e25764.1683196407.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <018ffcab35457b341195411e85614029f3e25764.1683196407.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4567:EE_
X-MS-Office365-Filtering-Correlation-Id: 37dd5c7f-7fff-4441-4b35-08db4d4d7ef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eh1wV9fg+ivCy50A+EBDF8O0lbDerNwdaKJfTZAEVsmNhi9d9V6fQE8NovE2+2EbL9v2+ngevVcxXGvmpoELo5UyLJrUA9H5YZQnM++OnYoxp9TKp0w5baXOBieELnsVpp+aIrzXz8sPhuwqdvlAgh12XiSBdJ2cXNt6uNz4VN5T7fBHPHEoFmbkbIl67HNq1ZUT+x7X5Ve/wIZQs1gj0/cakHgceh79/OEwS0PF8B2OGu1xkh78yjpoMuBTDNvaHCxB50LpRhdExr/8Q10vInhadqWOYOXlRIyi4LmzfuUaVM+QwhILTjWjEucKAbQgPzk+lALnAdRCLCg8vjWwD6zeyaxGlcN5sWzRu4gXhPDX+R0PEc6K5mVjOifWqSPXQpV6YTba1bSDIrVCvuiaAsgqAo2JLJUYKaM2vZ5vViISep0+ZYJkAN2yLha9EmwFl8xH1Yr58Rq7lOVoOL8PparsqeC5ZIFbK098u2OZiV5yZ+DCTyYJACkRsBvsYmnSn3U58VdlxnBnZ+MAKLoHudl/RW+oY8dEFbV4JmdfKAdVUSb6ZV6ApPJlP7JvbtolXD4gqklRMQ/IcoJRMfEV+RY32+vVRi90No4raxBa8H3ZgNPl5QufBHMH0RdVWqWctHzydW9nsBSr9JmNpRx+Ag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(31696002)(86362001)(558084003)(36756003)(316002)(66946007)(66556008)(66476007)(478600001)(6486002)(6666004)(41300700001)(19618925003)(8676002)(5660300002)(8936002)(2906002)(44832011)(38100700002)(4270600006)(186003)(2616005)(6512007)(6506007)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czdGVVZiVzE3dXZ0Y1VKK0FyajhORDl5SjAxQ2cveGFsTzhub1AwY0gxaEFM?=
 =?utf-8?B?SWphM2ozNlBBSlRWWG9RU0tXTVMzZHUzZ3RGYVBIbklnZHZ0cWZiaXBKTFR6?=
 =?utf-8?B?SU8yNGR0eEMrZmMwZGxwOUM1QTZYWjMyZlVZT295ekRLaWZtQTM2L0pMVm5x?=
 =?utf-8?B?Vml4YlI4clBVZUVHREdLT21nMWplMDh3N0JPV1FZcjdFTnVYeDdZQVBSak1V?=
 =?utf-8?B?R2ZkeDRsTFVxNjBrQ0FNa0l4TzRSYWtSWk1jVVBNUDMwQjlvcWJwb29QQjhP?=
 =?utf-8?B?WnJycWoxZER0NnBxWXlCZFZPYWZsRVJXMWpmQ1lubExVODdYM09zazhWRXBk?=
 =?utf-8?B?V3Q0a2hHNDVZcWhGRCtsbXpES2R5VUs5SnpRUnVlSGhRRHd2a0FCaVdWUzlV?=
 =?utf-8?B?SDNEQmo1WUJVNmRMeVR1Q3pPM0kzSGlYU3kvWXlUZjI5TU11Z0E4eWNSUWpF?=
 =?utf-8?B?WlpoSFBZWGRXajZQRDdVUk1FR3ZGeFFIdHJkS1puWE5WU2w2YUhscDlucW1y?=
 =?utf-8?B?ZjhZYnd6TTY4Y2JaeFZYc05qRTh0VUdqRHFMQjliM2h3Y0VIMWo4L2pSdVRj?=
 =?utf-8?B?OGhEOGdsbTlEMFkvNVNjdFMzTkZ3Y1Rqb2Z3aW4xU2tEQXduU0ZrblBZYlRS?=
 =?utf-8?B?d2cxTnhETDNITG9BVUJtOG9iYWlJZkpYSG91UXRZYklPWk5pS2s3UlNITjlR?=
 =?utf-8?B?a2FQVnc4WVN6Z0JJc2hXQ2xOWFRWNlRVZjRyeGlNaVFsaklMSGhnY2hzMjlC?=
 =?utf-8?B?b0dRY3g1bzdaSEpqTzVmQXlZNUNFQWVHVTEyM2F5N2UxWUYxOG9pV0xKb0hB?=
 =?utf-8?B?cFlOMXZCRWdyb3RhY3dtVUZKQ1dyOVlxbzZJMkIzOTdwYkt2b0Nyc2k0MUVt?=
 =?utf-8?B?UERaT2RUdGxyS1J6b2xNWXY5VzBxZXRqSitYZDk3dzVGYUtMMVNoeHplOTRp?=
 =?utf-8?B?bG9DMm50WTZBRUxYc2xjb3Yyc2dQSDZHc2tyaUUxNjhyWlBSWHpOV0VtSHVN?=
 =?utf-8?B?RTdsT1krU0M5a1lSTVRnZTV2S0o3T0ZpMWhVWXAwSk5qcGl6WDk2VDMyL0NW?=
 =?utf-8?B?QzR4bGlJTHlkb1dIZTU3RGFhMjQ0UVFGTUhMYWNWb0JKSS9kV0grQUpMd0N6?=
 =?utf-8?B?dGV6Tmg0UmFXbkVpV0JtUFhyS2RRNnVuUDh1YTM2a3N3Szd3Zi9tandkQkx2?=
 =?utf-8?B?aExocUJnaXVQNWg3Wm92N25Jc2loSE1adGMvNUV5OU5qanN1VWhUNndRUXEr?=
 =?utf-8?B?VFFrTGtOa2FwYzI4QTA3SFVHQ0g0azBMV1dNalFzS0dSc1ZMQVRRKzZLcUly?=
 =?utf-8?B?VzhzTzNNeWRGem9VZFp0dkVWQjdSTGp4OUxVRUI5TkdhRC9wbnZDUXdIc0tS?=
 =?utf-8?B?RGJRSVIxTSsxV1pYK3VJYXFUZlJWTENncEJPVGwvWk5JdU1OSExlcjNHdDdL?=
 =?utf-8?B?ZkYxVmR4dkg3V0hPem1JZWNySmNhMnJJUFZKWk1JaGxNNXlFL0tCWnRFck1R?=
 =?utf-8?B?b04vWWg0L05WNXIzYXJWMkErZEI5aGVsRjdFa1NselJQS2xIbzROaEJHUFBV?=
 =?utf-8?B?YUx1QTdUQ1ZvNUdKL2ZZN096MGg5Qkd0ejh4VklxMFVRVXhrVE4yaVFEcXhW?=
 =?utf-8?B?UlE1TWtZOGdTUVlZQkR2UVNiV2MrRERPS3dUUlB3VkNaSXp0RkU3QkdSODhE?=
 =?utf-8?B?VU5mdXppVXUxY0x5ZUIzbG1pNDhtV2lEUjlmZno2ejNkaHhISG8rVVpUNmo1?=
 =?utf-8?B?Wk5YaS9ZKzMxZzQ5UVNqaFdsck40MFdGSGVydTRsZFZsMTZyS3h3RHVlUEdo?=
 =?utf-8?B?bW9NM3ovendGMkl0UWhYaHhPbFZiNTloTkczWUdLcFhxOUdXY256Q0Vva1Bv?=
 =?utf-8?B?YTJHVVlyUi9WY3BGNTEyU3VJdXFZQTdZdGlrZ2p0WXI5dGp3eEs0aFlNY0Yv?=
 =?utf-8?B?VFhPcCsydlVNQXJsLy9MSk1wZmpSbzNHbnM1cnJRMkVSOFpXODFvZlZxK0JF?=
 =?utf-8?B?Z2U3TkFvUEkvdUlHejZpU2lNdnhyOWhQSlVFSmxtWStqM2JNd08zcW5obU5W?=
 =?utf-8?B?WUh2SlVSc0l1NTlLdys1anVzbkk1Y2xBQ0pJbUtOWjZ4WGhwT0J0aVRIWmR0?=
 =?utf-8?Q?CKM0Du5ppbnYQTQsENadAtsfy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5qGXjPxhVly8F6BczwFoZLYqWsyXNTo/1ICKq0jhedlare3Z2baLZOLFKlZlZ7CfQ0QXVlBMREuqzxPiLsVIvrWeLsZYCacSKnkL4OQTBd6ArdHBREJISkU8TyAPa22MWxW+McaHZVCmPEzMZ7gHLxPJj01dHupkSgxOn9WCBHnMhbTLTZ8bBGgNfFnXVOSrKCkz+CVWwboV9D7QwADLSWdRLSBTZVrzcuw07p5+uZuGYNxiNjFSQwEK5A5qlKG/5732mc5Ix8k2d8HDAlAznZH9L+ftxBbUhePXPsOiE0jJ51huoNM7QSzzWOMw/H2goRDCZ/KSTdEh+e1H5Aitm1IzZzrPibrWaT43KYCk8iu1XYxKfvy76P+wgGZTjB6gkmjr1niOUpriSDPyNHEbcfudZ/RVhvrhi/JQWW8XvnKzU2IFRuSS/rGtkIXUpbCp1ZRiJYqhsDsw0vwcxenOu2L4aAU2UkSCTDFA3LfIptafbbRWRYgNU2ipXUWZLwvdduEKBQk5LNbpbsaPLsgQLSR8nPwtDFqSV5XuFfPVjT1hnqio5NPEEErWQ/xxn1YHgW5TGiDZy/6KH5tTHSWUErQX6J66aII++xeMZyBkcSmKzQ7aSXWK7yXnVW2pV866AAh+nZebsB/AwMwswkHDihErq0bwfD/FqK3xfa6MiPOvBMgKBdGu1SE8bD5NNsF0ANXnc/UGu9LUbdouVZuYnp+Uv7MjZUAWzsQFWxT0xkwi8N70x/YbEZAPpKqFScAEey+CtuVKAAGyyCTnL85LFgio0a+VV+jX/InbzD58YcU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37dd5c7f-7fff-4441-4b35-08db4d4d7ef1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 09:45:44.4022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRo/erxZ+vpnUCjbHYqTdQcXm5LYHcBWolCKSbHyNQqIOB4Rkks2XjUmLf1GB7li0F9L1ypw8JkR7HvcptlIBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4567
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_16,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050080
X-Proofpoint-ORIG-GUID: 1K46gfGvhddUV3zKSwskYObi7GHr_bxm
X-Proofpoint-GUID: 1K46gfGvhddUV3zKSwskYObi7GHr_bxm
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
