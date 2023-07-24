Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3C275ECB1
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 09:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjGXHoH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 03:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjGXHoG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 03:44:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA61F9
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 00:44:05 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36O6o0j8007163;
        Mon, 24 Jul 2023 07:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=QSZ88jRbPgpMjhKxO/QGyy/k8A/kOQdzikx0xbsC0OA=;
 b=KrkZszP1kg0Y2OeyPzDnqJi05SlGWrFK5AJQFs5EC24XEduV/hj2cRc6tmZA416ucgoz
 rvgCPJqFlDlD8fWZ/9N/i57aNBcPhBF8XA8OtybcPvZ1an085L9ZHl/beBQ59n89WxPw
 eIEi6VaMgRS/Jd1coX1B4fu91Zb9f6sh3Z3IKXxqQFzHknRReExObogYlyu1liuO09ST
 SwazT7BFt2c41I/WA6TKNR+Q0BjoSI5zDI0idJ+4rFeHf4PhaeaaYmgcLdldDPUkNxFb
 /h05dJ7FD0+f3hoPzW+CmfGFVyZw1omMRPAVcv984v0sEW9aDKTxWafbNvp6mwVAaxgh ag== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s07nuj22g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 07:44:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36O7LssW028815;
        Mon, 24 Jul 2023 07:44:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j3b543-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 07:43:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jub9NfjTrfcqypwuxJcAFdnh2kztyaaV8ep2R3wnipN1fvVB3Yl16ubgc0LVZ3hscm6MUDWi02DE/xFXjXxt7l4s6Vae9oU89huK9HXgD7Bs7ocdzBFy8yxMC5eR1PJFaRCYM0g+M66DpDk929KEswd5eoKHRKQr+Lnb+LtCpCLAELRYVWnyr9h/zhxAfNt9vc7wC1L2RChVoRDPKHDrj2X3sCLtM8w8pVvN1dLXOomnGgthXdi6RYzOUeai8M2kv04hmir9BuXMXqz8kl1JspWrfqiH3BncxmexoeKH1Wf5mkJMZLB0X58oS7lJcXBSNgiqiKcycM9NNngy33tU0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSZ88jRbPgpMjhKxO/QGyy/k8A/kOQdzikx0xbsC0OA=;
 b=k+/Jbv84YGNtetRi9mMRqnakyeZoRo6/Ym2k1Beq/3knjmh7S1gSImDJU1DiIkNmrgJrOqdOF6fu8YILHmSDEdUVlAgDL/trbVnNrbu43TjwM6Kjxd+bRE+6YAfl87jTwAI57iGC7MQwOtctFs2RUserHQrLEfyIFCOmWh69jXJtLxt9GDAQWJ0+3dKxKz/GaoW613QR5jfrnX/c/I8Sa0q4O8dekX0B01ncUWey7Drl+LWp+G1Vkwqtk5m7hh+23hIvddlun7VKfjMyfZcIeYc4EE/im2hcC3FzscqVjPAC+M68SQzKIOKUUdDql0Gq2Z6Y7UcKkDqSP2m8mjLeMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSZ88jRbPgpMjhKxO/QGyy/k8A/kOQdzikx0xbsC0OA=;
 b=hnIpCk/h7WnBIvPmHB+QQKVf+Sg/3Vs2G8dAUhWJQ/dlrSuTeT+uRL/z7Fb/mudTDofyrECRYsw4ZpGHlkkAcaLNtLyrgR4KUle83nDxs5HCTt+YnDdKYbbxvNrr/8V8r2oHCkAP/Di51dP+5vXOkMdZ4PBIIv8tTg40fYBrd+0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB7298.namprd10.prod.outlook.com (2603:10b6:8:ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 07:43:45 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 07:43:45 +0000
Message-ID: <ec3b4494-2a76-9519-39b8-edb36477e677@oracle.com>
Date:   Mon, 24 Jul 2023 15:43:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] btrfs: warn on tree blocks which are not nodesize aligned
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <fee2c7df3d0a2e91e9b5e07a04242fcf28ade6bf.1690178924.git.wqu@suse.com>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <fee2c7df3d0a2e91e9b5e07a04242fcf28ade6bf.1690178924.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::27)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB7298:EE_
X-MS-Office365-Filtering-Correlation-Id: 22551bb4-cf65-4cad-9f16-08db8c19b559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z52xyc374tIVhrn+zhCggil/L/3Z8fV4hJVmBopqxVCcn3zvSiDVLy0GUOZGbnQrhQ/FEEQDmpnxZ/VsznsB/oMK7LNyYbgHc3JFkfJwlstfHu+hetr4gWJGhLYu8UXq2YVhZdkqbDHfp6UbpXT3SlRvCY3vsx4WKVENhVCjshZnD9ahnx9w9+D+l/9UGG0oBDrMpfQi/EVPVlmvab9OFcXcDQs4BPBIoZS1V5W3wS444sRzvgAL+1fveFGAw+fA1GkPG6RJfU5PsIJYgDMZ2qGne3WfvsoLcQgGjrXisbgJICi0t6e/7QegIH1vux7mQR7dfxjqUYrbC3Z90EOkKjGTdWyPinvGMIPaBlY+LSmzN9t08Zok9pWyYDId2z80m/vD7ve15JLxPPRrikIwnOBmcOPQ3yhlEK6FPY3gLfY4srNRJNHigBo6jrhPpXiBrR90CKOacZva70a+fFM7F8tx+P7U/2nzxtfq/G9+lisN22M7Q3nT0kMcvC4ouTVW7F0QgXdNKnSGFBx+lppj9iGUowWB/ylEodXdILZXp+QNFnHZs0ax6nTS37wjiSvzgYnfavkA0/iE4nJE9+p/qrM0izrY4oQ1o7x+cEGrKERLjzMFxfW7J/nnCbWcDvoWpaH3gpY6BAE13qO1GpS1Zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199021)(38100700002)(53546011)(2616005)(36756003)(83380400001)(44832011)(8936002)(8676002)(5660300002)(478600001)(66556008)(66476007)(316002)(66946007)(41300700001)(186003)(26005)(6506007)(6512007)(6486002)(6666004)(2906002)(31696002)(31686004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2JPRWljem14K1JIbWloR0NzQktTQlptMEZxMU9HQ3AzT1NKVmpBTisyeDFI?=
 =?utf-8?B?S25rYjFLVGkrZitVd0dWUVUwVENlV2YyNEUrcXB2ZlpIN0lXZW4wR1U0TUY5?=
 =?utf-8?B?Z2hwZks1YmpmZHd2VjA4VzBRMUViYUo1MjJMM3Yyb1cvcVJRb0ZYV09SSk9K?=
 =?utf-8?B?SEQxWlIvdDM3cjVOOGRqNTg5UlFMT0hwSFpaNkpFMHN2N010RTZ6bHhya2JU?=
 =?utf-8?B?OTh6NnFCdVNESFN6emNEMWVnbEtSZUtkTGVLcjJObzdwVjA5b2QrU2ZkT1ZF?=
 =?utf-8?B?VlRaZWIvMmZENC9SNThUclJYMEtwU0w3YzBVWG9sbzVxNUNabG1tRklGbHds?=
 =?utf-8?B?b1M0SDRJZ0gzNWsyMVhtU0wxUi8xdmFwamRpOTg0MDZLeHZNZEtpSmJjT2VH?=
 =?utf-8?B?OE8wem9mSjYxRVVTSkZnWksyZHA3RDRKdVl1Qm5TNitDL1ZVZW9jSUlDSHoz?=
 =?utf-8?B?UVpMcUV3citiNjA4OGdwY1hxQkdVRktvaUpkZlNrc0hZVUdiS0JveVZ0dE5o?=
 =?utf-8?B?RHY0Tm1xcHFQOFI5amV1dkhWVStQY0VacTk3OHZabTJWYjVuR2NPUmlJK2hL?=
 =?utf-8?B?ZnlzMVdZT1ViT1l0NUEvSUlXVUxJOEh4STdHMDNIWEE4ZnEySy9Edmx4NzRz?=
 =?utf-8?B?MlA1YmhHRGRwYm5yNnNaaHdSQzJvZzZ2M3R5QkxraWNwV3M3U0p6YnN3dDNr?=
 =?utf-8?B?OG5BNGRyVWw2WmtzRjcyQ0dFeGdzMWNySEhCb1N4Z0s1b3F0R0p1clN4Ti9X?=
 =?utf-8?B?NW44TTFXSlUvSzkxVFNzUXlrMjdmbmNhenpYV0p6VzFvYkNKQkd6TWRycHIy?=
 =?utf-8?B?dDQzenJFeldoRit5RndibFlGT2QvMjFCK2hySFdsLytRaDVNVDV6U1FOUHFZ?=
 =?utf-8?B?TU5IRWZ5UFFObDBOWXU0N04wZkJtamtFQXJWV1RxRnd0Um1NVU10T3dkaDRz?=
 =?utf-8?B?VFhmbGVCZk0vdWhEMVpYditaWDBLbjJwb2J4QXlDVnpaM1BEZnVlcGMzK2pE?=
 =?utf-8?B?am55Z0d5RHlkRlRQdmlEZ3VKaUFqZ1N5R0U3OTdDWXdjZFlGWXBtTE9qN1Uy?=
 =?utf-8?B?NzZERGJxalgwS2hGK3dIUmhuc1NYVmcvM2J5bHRydUJveDFBMmNKc1NCdGQy?=
 =?utf-8?B?Z1lvRDNFVmJ1U0xkejU2VE5hSjlGZ2lUZWJJc0NlQ1dCYmFtazRBdG9qYWpr?=
 =?utf-8?B?ZzI1REozODZWeldGY213bzN3Y3pGOEZGUE5TSkxDTi83OXVhSSsxWEkySEVq?=
 =?utf-8?B?Vm9uUm91MWVUQnc2dWVkSk9ZZ2V6ZlRncFBRaExjRDlwQkVhcFNwT2sxRkR4?=
 =?utf-8?B?TFV4QjhEayttbWMwOVJiclpkeHhFRlpuVldUSVBpS3Bzblh5amg0R3hNY2JJ?=
 =?utf-8?B?UWNpS3Q5cWQ0NEtkSnZiZzhoMkdZeS9oU0dURHdEeGF2bDRlYW41LzJJQnIy?=
 =?utf-8?B?RzJrbm1RM1Ztc09jZDZ0ZEVJdXpubHp0ZVZvU0luOC9sQzBhMHRqNVpzWk1Y?=
 =?utf-8?B?QVVZbjBET1VsYWpaTmdHaDRuRnFKSzV3UG9lZ3gvcFVGTW1oekF4bTV5azhL?=
 =?utf-8?B?RER3enRrbWI5MU52Skp0OXpZS3R0MWEzdGJYcCtJbkRWU21ROCtzb09oRGVS?=
 =?utf-8?B?UmdmNTAzR3djRUcxaEJiZ3k2dnlEbTJDWlJXNWs3cE44Ylg2b3gvaVdHTUky?=
 =?utf-8?B?THcrVkxydmNYdW10ZmthNGlnODBUQmt4NFI0TEJDWUprOW1qcmhhQUFyOVZ0?=
 =?utf-8?B?ZzRUbTNJc0E2WUwyVWUraExYdllNcmN5RE9vR05vckI5TlhKNHdES3dXVmJa?=
 =?utf-8?B?ZHQ3bmkrZTN2MTNhTXR0aWQ5NGdSM29JcEZzakY1cHoxRzVyV0ZVTzF6dDFR?=
 =?utf-8?B?SUg2SjcxT1lNT1FTWDc4bEhxb1F4VTZkcVRRTUppODF3MW1iRFo5NmRhQ29y?=
 =?utf-8?B?STRacGVOR24zZHVBQWN0SUxJNmNubDU3TWMyemFNV3J6dGxHdWhPeWpQQnBN?=
 =?utf-8?B?L002ek5CTEU5TjdIWUlqVVVVTDhzL05TL1UvT0diSXJXSVoycUtJMHAxV0lS?=
 =?utf-8?B?RHY1ZmpmTWhkL0VoRUN2NU9KTjdHWEtlb2tGY1J1bWlMYzdTNXVNMzcwMUdK?=
 =?utf-8?Q?AA1Gvm/Izx0cjO/p81X+FzzmF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 60yN3MAdxqcJfTpzmnHkj5E+HBQavXzNccCGmiv0ekgNuTjK5TCoDHMYwOn/wqs06SY2OcsJ+a9RVFVSmhdOvsdelru8e6vaQxnMAj1PmlYpiPTCqXfF1+E8eX9vA8yrnCRRLK5WGylaKJeduJd2bC47hGP8U26nJ5HHfkqfPCg2IhARraEVSEIwjcrY29IEMOU0D0YpFt71NqMPzwhzDxMPkS9brG2/n1fVVXT+vvoDwnS/fIVTlA99mucwYwlQghhk9Kx4bQNw69h+//9HmuUez81gUynhrQQ4tUKD3cvQfrKiLo3nYQBNo010Xe+nAlgVQ0GSAkWWGkJP373rJoRGWubFFR3cQLf4nNahH9+VOURqqz28ZYvAdbV8UU7ouiQAtAAZyDixaBAbwnKEPPI7rja1CpGlIiLl1cn5Va/8nugYof/pvjRsR6lYBDztS1Q81FSzQ6SwLoIFaOsBTVBgQKOrsACrM4eJpZr0IC2kJYx81M+ySReXuZEv+L4dhFRfl+pYPubfXLtqdAtN0ubBaQbjixDLdi9yRSqZQ7WyAEix70nN6AW4MFIsigN1ffgWMHk57Y2cuTM2CXVxukYcMMEhB5bBH7Aygmnz37XXMi/9xJHqTFo/f7vJIB6qHPoVwGZMh6WjehealhCTiLM119S6sdsKFQ0h/oWQI/mV8Mz5Mt9YG0L/1CfZOCJMg6oO5lsprINfXCazkwIjqYgwwHzHIfSLG/PxbppM4C3ljhy6nWvZPTGe1FMU3qlhVLEPiFrLtXnEGXD6TcoQADPUHQm8A8236FWUwsoX64I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22551bb4-cf65-4cad-9f16-08db8c19b559
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 07:43:45.1609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCc8OJylJSYqSJlJwEceQialTpYdiqYc0TRPe/NV2PTvb/bIP3bFYFDKDnP9wtvoC4JuS2ViuG/m5nw1RgPVFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7298
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_06,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240069
X-Proofpoint-ORIG-GUID: 62rqrdShE-pTd4zR3cE-ZXw5C0nkUMD0
X-Proofpoint-GUID: 62rqrdShE-pTd4zR3cE-ZXw5C0nkUMD0
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/7/23 14:09, Qu Wenruo wrote:
> A long time ago, we have some metadata chunks which starts at sector
> boundary but not aligned at nodesize boundary.
> 
> This led to some older fs which can have tree blocks only aligned to
> sectorsize, but not nodesize.
> 
> Later btrfs check gained the ability to detect and warn about such tree
> blocks, and kernel fixed the chunk allocation behavior, nowadays those
> tree blocks should be pretty rare.
> 
> But in the future, if we want to migrate metadata to folio, we can not
> have such tree blocks, as filemap_add_folio() requires the page index to
> be aligned with the folio number of pages.
> (AKA, such unaligned tree blocks can lead to VM_BUG_ON().)
> 
> So this patch adds extra warning for those unaligned tree blocks, as a
> preparation for the future folio migration.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/extent_io.c | 8 ++++++++
>   fs/btrfs/fs.h        | 7 +++++++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 65b01ec5bab1..0aa27a212d1e 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3518,6 +3518,14 @@ static int check_eb_alignment(struct btrfs_fs_info *fs_info, u64 start)
>   			  start, fs_info->nodesize);
>   		return -EINVAL;
>   	}
> +	if (!IS_ALIGNED(start, fs_info->nodesize) &&
> +	    !test_and_set_bit(BTRFS_FS_UNALIGNED_TREE_BLOCK,
> +			      &fs_info->flags)) {
> +		btrfs_warn(fs_info,
> +		"tree block not nodesize aligned, start %llu nodesize %u",
> +			      start, fs_info->nodesize);
> +		btrfs_warn(fs_info, "this can be solved by a full metadata balance");
> +	}

A btrfs_warn_rl() will be a safer option IMO.

Thanks.

>   	return 0;
>   }
>   
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 203d2a267828..2de3961aee44 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -141,6 +141,13 @@ enum {
>   	 */
>   	BTRFS_FS_FEATURE_CHANGED,
>   
> +	/*
> +	 * Indicate if we have tree block which is only aligned to sectorsize,
> +	 * but not to nodesize.
> +	 * This should be rare nowadays.
> +	 */
> +	BTRFS_FS_UNALIGNED_TREE_BLOCK,
> +
>   #if BITS_PER_LONG == 32
>   	/* Indicate if we have error/warn message printed on 32bit systems */
>   	BTRFS_FS_32BIT_ERROR,

