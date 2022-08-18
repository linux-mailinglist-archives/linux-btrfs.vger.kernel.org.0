Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320EE598198
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 12:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244023AbiHRKpE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Aug 2022 06:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbiHRKpD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Aug 2022 06:45:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84FA81691;
        Thu, 18 Aug 2022 03:45:01 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27IAia2x026991;
        Thu, 18 Aug 2022 10:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=kJu89o6d4cO0MEGWu7fTa/cdF9/2MxKb84YnMi8n2Q4=;
 b=Nxrtp121CNHEKfGDJwV10UDfaup42VtnESZBnVdSsJPZKbhpsx7kmMaBxD/7Ab4T9jrd
 j8xSrg5dfJ5US6b60N/Z7ukyOnPSQQnM8UtgfosL3IhVN1YfCOsZB//R2DK6APRapxpv
 ZdOgvIhAQAsyBLMuXLJTt5DrRypWC8rhz+8ZaPvnansFJg0Q5pgmzlzm27KJlwNW6O8P
 seYkk1QhlvqaQUi9W6zmQ5L810kFGNlQXOOvAIQiD3vkspSIrmAFG48hNWHID9yo8K6F
 byioO28OStjJRvqL4JXwpu3nXbPMO3CcyPkcIjktjKhnaH53u6qwrPtHtmj2jRE/2WPF qg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j1kka01s6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 10:44:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27IAXqX9015229;
        Thu, 18 Aug 2022 10:44:48 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j0c6e6c3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 10:44:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2fNe9tk21ZwsVQOm5f2f9MddMG5DvYKGCIlJtq3s1mGnD4AXNmFz9QZI9mP4Z6Hp3OTcMphOItms6+Ec0x+NoMXWz8lOops2DPR8zkcJQ/6gMkkAzmSI7/l3/DwD6qo2li6xGeiCT3nurhhGoqv7fhnbgw3fq5hov29o7PJN4H1xGDI9NyqgknG1NU9hsqenlXuF0xIXTki6wSmIecy/HP3dHESrdot3vwiyvAI/EPkQR8Qx4pNhS0+vyv4qG+fySK+uWnzQo21s74DpUiY74iG0WSAxf4F/LXyMs2JxrP2Q2q3wgfL9bmVwqAXyU0FU4uK7g61pXKSLeh+TgcLlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJu89o6d4cO0MEGWu7fTa/cdF9/2MxKb84YnMi8n2Q4=;
 b=WptBssjsQjas7rRR/GunPiHiLPFp4CzWVI8MG347Bq2mzjA0nrbHQ8eNy1Oio8qSC6n4nyxGSgxIwvpTHVQTYoS/n2BgCKNwxGSvOde21u0CtbJf4dGPtDmxJGZY7RHR66393pf4CQo+p8vrSFXDIqWcIV5146U5aC+ZfIhoJFJg68hnsh8M1Kz1mzm1IJ0n24mlEqshy6Uo1UuVsCR2rLjC8kJqGmKrBKcbCz3RoiNJK27nAcja+H8dDjQIP8QCDjGpwcH/eudZ800Kou/FaT4s6vowpxVyu99nIxr2gkkukButRygeccRSzRi9j/suBc4+5nkjPE/ZngW6mfP+1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJu89o6d4cO0MEGWu7fTa/cdF9/2MxKb84YnMi8n2Q4=;
 b=ElMJiwuABwzkcxRGtk0XZvRPsnfaTf9v4eogYEGKfn0aNzd7aKRFOHrHMjU6l9E/lPbY5HFSn7PWjHkvT+ChlzELNpnu0DE7nP+3Sgk+pdrp3DMtH+EYsoXP/iec6xRoCQH7SjWAjLjb6gWZtdfBAaxsnOYzfjn5UWm1S5Q6mW4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6145.namprd10.prod.outlook.com (2603:10b6:208:3ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.27; Thu, 18 Aug
 2022 10:44:46 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%9]) with mapi id 15.20.5546.016; Thu, 18 Aug 2022
 10:44:46 +0000
Message-ID: <323fe2bf-2db9-ffcc-32e8-a1d80695e5fe@oracle.com>
Date:   Thu, 18 Aug 2022 18:44:38 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] btrfs: Test xattr changes for read-only btrfs property
To:     Filipe Manana <fdmanana@kernel.org>,
        Anand Jain <anand.jain@oracle.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20220816214051.wsw75y3mtjdsim6w@fiona>
 <143a26d6-9237-b745-ece6-ce37dc7dca9a@oracle.com>
 <CAL3q7H46y85Y4K14ud0Hv8bGS+6ikuRTj84CNYzg=hJwDSA95Q@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H46y85Y4K14ud0Hv8bGS+6ikuRTj84CNYzg=hJwDSA95Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0036.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a27a0ba5-705a-468a-936f-08da8106aafd
X-MS-TrafficTypeDiagnostic: IA1PR10MB6145:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZRwwRnqFZGustppo3lJwYAPCM3HoCyZa8lry5JRDL8KrSuVSwPw6YOgMGpTyOTsSNJHE4cT245mKaRxhFTwuiCtWbQ5awvl1lMO6CbDueoe6+6atPh4TRdLN8W/pU0If6JpmabaGSG5g6igq2MFh2XRC5RBvjC2tBJf+zm3wJ9v2bT9+3EJmgcDGEAbbLsdVqJ82J32x+bGYtySRPBVOBu3xfK5NZ1VmjnCv45a7egReRB8IcunLUjqFtzy3cwWpV9rXw5daJEDrsmjH3hDO4G0WSWc1C7TPuHkBbf+a8VSlPhK5CaTr7TLuQzWbUgq2ceHW9SYyxsKkPcw8dRi0stEAzI+uwx+USgbvqoXy/OqDxqkPkBDmkZBGfre3/aw38QZWu2JE7AM2zm+nxFLvPdZM+qPjV+fPdlATdqevYkleLeE1aISAKX2QjMcYXYppv6dm4KQmpFYGrR4fjnN5yCSDfDTQgGqN/6sZSGEyZemhbSGHC1Atcz9N+Vc3JBI1AWoXVQmF4X8lbLlj6GbAXvEggmgJI4qkKR9D1GgkJYbR9lPgjS1aGWCtgd6Lxn2ADYtuX/B4UMlg0sat5AeXHz0KpQKvPVU+5syb1HbGFSIcfYXnKocMk/VEuQlSsaJKTGmAFcqERaljqTn6GafvfvlHuwQ3cwH+57AWbCnf9vzZMn7KfrtK/Wlq6F+7POUCv20uduAq4BsSlxdkGS0Me2A+ufgxXv33IktwF1pji7iFyf8lNE/RjQtM4rgpvfDiBuSyCFTxfGPkguU7AVjgX303DUmzZhxljTxlmdFIGm0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(39860400002)(376002)(366004)(136003)(5660300002)(26005)(38100700002)(44832011)(41300700001)(2616005)(110136005)(6512007)(53546011)(83380400001)(2906002)(6666004)(6506007)(66476007)(316002)(86362001)(31696002)(31686004)(66946007)(6486002)(478600001)(8936002)(186003)(36756003)(8676002)(66556008)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXdMM2FVRkVLR3NXS29HSllkTW1KQXhZMVBTd014RUhsOU9zT1FFSTRZWlV5?=
 =?utf-8?B?RWJvbGZ1RCtTdyt3OXNsd2NvbmJTbHVzenFLOEY3V09aQkswNkh3aWZadCt3?=
 =?utf-8?B?akcyQmVzaTdYUTQ4S0dsNWhKL0hML3lTcVVLN2hYL2Rza0hHaEFqQU1kYUM3?=
 =?utf-8?B?NkVLNlVwRklaZExybDVSekVqUVBBSnpOR3Y2aEUwdXVrTGR1ZExKVFJRaDFs?=
 =?utf-8?B?dzdJa0svSXdzSmUvWFhMeXJETVVHWHREOHFGazRCNFc2WWZhbVNiSHpiT3dY?=
 =?utf-8?B?WllKTFVZTVU5eFVJRVh1THp1VzlWQkpBRVVJMU9OVkR0QndxNFdPZWIzNXhV?=
 =?utf-8?B?U09LSDRuaEVrSnpyMUwvVzFWSElSenVpQ1A2OUFRWUIxcDE5MlkwUnVMUXgz?=
 =?utf-8?B?N1lCbUdrbG43dEptZURsdlJqeWxpYzlnc3pKMHhEV0dlM2lvK0FsbzQyMm5Y?=
 =?utf-8?B?YVhNSWVub3RNbHI3dWsvRUgvZ2FWdWkycmpKTmJyUWQwUEZRbTlHMjlER0Fz?=
 =?utf-8?B?bWNBUGprMUFMVVZhUnlrS2Flb3hkMTRTK3lyT0V0WnBiczlDQU5Sd1RWZE53?=
 =?utf-8?B?eUpmRWROSzRyc0NoeEF6ME9oZDFHU0RNS2g5MHZUYi9vT0h1amt4cWUwK3Fj?=
 =?utf-8?B?MVVFQ1RlanFPRG5KV1lmOE5qZmk3U2d5RzNMSzMrUURrSUVPUjkwRElSTWI0?=
 =?utf-8?B?a0pBMkRVakJVSnBjeCt2dVRlVlVKeXp5Yi9RWVhYb1dSSktSVXNBVXlSaWUw?=
 =?utf-8?B?YXdLUTNmVEVURWQ2M2d3bXAxYkVSWXZMcjk5dnpqSlFNUUFYRldOQXdOWjFp?=
 =?utf-8?B?T2NINGdKSlFIbE1RZlR0dFJERFJOR0ZZTjMrbHJ5b0hxSGhMOVdnT25GWmFp?=
 =?utf-8?B?MmJWVXV3NEVMRlNwVzRPTVdnUmxrU0dNajBROXBoN3RjVHdaemtSanVoY09R?=
 =?utf-8?B?MGNmdUpHblhzV1A2enR0MU1CRzQrT0xKM2E3eVl3eitYK0s2ME92ZGJOZTRG?=
 =?utf-8?B?aGJDVStKd3dKN05kZUZrdzIyekdhQ0Z5VnlwMWFZVWZtaTdhaHZXYkxSSG5Z?=
 =?utf-8?B?MllQOE9KQTVReHc1SmdSVVhIc1MrQ3B5V3NGZjFTeFhlQ2lvQlZCQ1BuOUZV?=
 =?utf-8?B?S3loUHJoN055dy82VXdPbmoySzNaa21tdG9ZUllWR05lT1ljNXlxaEZVY1dI?=
 =?utf-8?B?UWMwTE9EK054Vzd1dEo0SnBJWktzZjFKdDlhSkNsaVBlZmh5TElWR05UVnFJ?=
 =?utf-8?B?ODVMei9jZ0s3bWI2MVNtSkZVNnIrenlrVDdzanNlbmw3bmVVdXZWb1BPVktn?=
 =?utf-8?B?MXk1UVZXNzBxSDlXemk3c1lZSi9vQXRydTVEY1JhQ2NmSy9ZWFMyN2gzWmVr?=
 =?utf-8?B?T3Q1cGtYa3h0WHVHNEx5S1I5Slg4OGZQaFJ0ZG9JTS90akN3TUFRMS9tQjZ2?=
 =?utf-8?B?bFd6MVpyeEVuR2N6Tm9laU9XM1h3SGpMejZRRDZkaFNCRWFPSDhwRm9vT0FR?=
 =?utf-8?B?K3ZZUXpsakNZU1piZldOaWVtSzh2dXZ2bkJjTmhXTktYWGExZ1Nlb1pqek9v?=
 =?utf-8?B?YmMvdjJheE9ZZ3RxaUVHYWEyZ3NiSCtWQlgvalhUZC8vVzZrMFBzMnlxV1Fl?=
 =?utf-8?B?bkduRUVGaUhadTZrbHp2dFZHMFBIc1U1R3VWcHJSK3drNWJic09UVHMyQVpu?=
 =?utf-8?B?cENtMWk2d01yS1p2NFBZVitwZjJubnBWVzhjZ1hVRlJFVnFUSjZ1VVM4UWYz?=
 =?utf-8?B?cUZyMzh4TDhLYVF0Tm9mUm12enpCRjRleGRlbXpjSjgxNGsxU2lDa3lHNXh6?=
 =?utf-8?B?Zlg3Q01INm1nbjA4OEx4TXNJbUFDQXdIMG1vK2ROOUtabloxalE5SjNuSGFX?=
 =?utf-8?B?QXplN1FqL0NYalhBRmVaelZoWEExMVBhRllkcWw0TU0xMGJjT2s4eVd5RHkv?=
 =?utf-8?B?eU0xYVBHUjh1c0xlVmRMdXVKbHlBdnVjbzA1OFlCZ0UxK2d5N0krdWVadHpH?=
 =?utf-8?B?bTYxR2tpbnl3SEJrTTc1T1Fhdys2eEdLdDdENXpqSWxZZXhscW9NVVBFcjcy?=
 =?utf-8?B?ZlNhUzRraVpkMTZnVG50eGcvNHhpWThsMjRESnExT2x5UkkwYkVPT1Jpa2Uy?=
 =?utf-8?Q?iZIuN6EjPUIOQlKbYZwNIRKBv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Mx4svbIt9/Jen0O53RN7aLVZ7QQxuLdDS2g+56smlLVPExsRvMPNEjWo0TgkSDY/img0LVqpUxawGMOMUWJTgYP8oOBpYfMKsiKm1MDlJLq7z7WkMENRezPP4hztQ5LVz/ULMv49qb9NUTB3lDxRrjZJEUyRm/UQjq+H6t2xGeJP16dkIZJVQ5ak/gmblYaqUNRpB6yI9wRHISiOOnvGsbNvT9mpe8A+7LJhM0mRIozemZK/5Qo/jUbikrNXj74ogwIfrMOF1AOByVGokWu3JTpYBTQ84Q26MTnj0MgOu5GEZKNoreRs9Nz4Z4Q0Kbw2RN60or0mW4CVoYarv/iM4phHAihaNU5D0M+pea5+AAUbRnX3z1nZDYFP6sjpeBI9iVmkn2yp5mLiiytZiGyXr1m8t7y3Fq7CB/6cM7rvSHpAqRERLQjyiTFCLW6Idns8Lzxoigll1AwXplqjkmsCOsYtXfdiIDH5kmE6yJ6ngpPAszDqjjO7JIjqSC+xgCTiXTilh0kHrY9k4yTJV5Pjl/csz7qZ5xgKlOKT82+FX4DVJkflRBfN72KkdfbydFQOEXdD44zoOmubyrx1V4wbeVW3xkyF10t5CYr00DfqsppaPD/qu/Xx8y/KMboM1uYw6W6faTRiAPMU0nVCPZ/3c2VJHiIPwkwvKFv+I4egOUs8WmoxKA4itTXXMadXlvw+DHvB4NnM7ox1gu/JVZrefiD15aqCuqu9oIpIjn0ZJHATHxOpkxw29uIcgPfTqP/9M5MWhD+Zscg6fQhoTHPOHGV1EmZb7qrP317dEyQnaYUruAOqakuhsyX7fSR56ZpBW+2N93++sP87IrX7USkm0t9aor9upTElfV54M7j7NSXhPAB9dvMiIi4OdIaRTo5x2UJMZXPHDKi94N7MiuPjFQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a27a0ba5-705a-468a-936f-08da8106aafd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 10:44:46.7861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: if//p9h3dYQDVwvhv9VoteiiJKEIU+Jpnv1+9wwfpTfEwrJyCqm6aKcbG1BPujwbnFy6nQduW4e1YFTNlph7jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6145
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_11,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180037
X-Proofpoint-GUID: s8jo6GPu4CTuMGdswJnJt4oIpNy4xcoC
X-Proofpoint-ORIG-GUID: s8jo6GPu4CTuMGdswJnJt4oIpNy4xcoC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/18/22 16:09, Filipe Manana wrote:
> On Thu, Aug 18, 2022 at 4:08 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>>
>>
>>
>> On 8/17/22 05:40, Goldwyn Rodrigues wrote:
>>> Test creation, modification and deletion of xattr for a BTRFS filesystem
>>> which has the read-only property set to true.
>>>
>>> Re-test the same after BTRFS read-only property is set to false.
>>>
>>> This tests the bug for "security.*" modifications which escape
>>> xattr_permission(), because security parameters are let through
>>> in xattr_permission(), without checks from
>>> inode_permission()->btrfs_permission(). There is no restriction on
>>> security.* from VFS and decision is left to the underlying filesystem.
>>>
>>> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
>>>
>>> diff --git a/tests/btrfs/273 b/tests/btrfs/273
>>> new file mode 100755
>>> index 00000000..ec7d264d
>>> --- /dev/null
>>> +++ b/tests/btrfs/273
>>> @@ -0,0 +1,78 @@
>>> +#! /bin/bash
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
>>> +#
>>> +# FS QA Test No. 273
>>> +#
>>> +# Test that no xattr can be changed once btrfs property is set to RO
>>> +#
>>> +. ./common/preamble
>>> +_begin_fstest auto quick attr
>>> +
>>> +# Import common functions.
>>> +#. ./common/filter
>>> +. ./common/attr
>>> +
>>> +# real QA test starts here
>>> +_supported_fs btrfs
>>> +_require_attrs
>>> +_require_btrfs_command "property"
>>> +_require_scratch
>>> +
>>> +_scratch_mkfs > /dev/null 2>&1 || _fail "mkfs failed"
>>> +_scratch_mount
>>> +
>>> +FILENAME=$SCRATCH_MNT/foo
>>> +
>>> +set_xattr() {
>>> +     local value=$1
>>> +     $SETFATTR_PROG -n "user.one" -v $value $FILENAME
>>> +     $SETFATTR_PROG -n "security.one" -v $value $FILENAME
>>> +     $SETFATTR_PROG -n "trusted.one" -v $value $FILENAME
>>> +}
>>> +
>>> +get_xattr() {
>>> +     $GETFATTR_PROG -n "user.one" $FILENAME
>>> +     $GETFATTR_PROG -n "security.one" $FILENAME
>>> +     $GETFATTR_PROG -n "trusted.one" $FILENAME
>>> +}
>>> +
>>> +del_xattr() {
>>> +     $SETFATTR_PROG -x "user.one" $FILENAME
>>> +     $SETFATTR_PROG -x "security.one" $FILENAME
>>> +     $SETFATTR_PROG -x "trusted.one" $FILENAME
>>> +}
>>> +
>>
>> This output contains mnt references that need to be filtered.
>> Filter _filter_scratch should help.
> 
> That was already pointed out in my previous review, wasn't it?

  Oh right. I missed it.

> 
>>
>>
>>
>>> +# Create a test file.
>>> +echo "hello world" > $FILENAME
>>> +
>>> +set_xattr 1
>>> +
>>> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT ro true
>>> +$BTRFS_UTIL_PROG property get $SCRATCH_MNT ro
>>> +
>>> +# Attempt to change values of RO (property) filesystem
>>> +set_xattr 2
>>> +
>>> +# Check the values of RO (property) filesystem is not changed
>>> +get_xattr
>>> +
>>> +# Attempt to remove xattr from RO (property) filesystem
>>> +del_xattr
>>> +
>>> +# Change filesystem property RO to false
>>> +
>>> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT ro false
>>> +$BTRFS_UTIL_PROG property get $SCRATCH_MNT ro
>>> +
>>> +# Change the xattrs after RO is false
>>
>>> +set_xattr 2
>>> +
>>
>>    Nit:  We are reusing the value "2" and changing it to "3"  makes it
>>    unique and so the debugging easier.
> 
> That's a good idea. >
>>
>>
>>> +# Get the changed values
>>> +get_xattr
>>> +
>>> +# Remove xattr
>>> +del_xattr
>>> +
>>> +status=0
>>> +exit
>>> diff --git a/tests/btrfs/273.out b/tests/btrfs/273.out
>>> new file mode 100644
>>> index 00000000..f6fca029
>>> --- /dev/null
>>> +++ b/tests/btrfs/273.out
>>> @@ -0,0 +1,33 @@
>>> +QA output created by 273
>>> +ro=true
>>> +setfattr: /scratch/foo: Read-only file system
>>> +setfattr: /scratch/foo: Read-only file system
>>> +setfattr: /scratch/foo: Read-only file system
>>> +getfattr: Removing leading '/' from absolute path names
>>> +# file: scratch/foo
>>> +user.one="1"
>>> +
>>> +getfattr: Removing leading '/' from absolute path names
>>> +# file: scratch/foo
>>> +security.one="1"
>>> +
>>> +getfattr: Removing leading '/' from absolute path names
>>> +# file: scratch/foo
>>> +trusted.one="1"
>>> +
>>> +setfattr: /scratch/foo: Read-only file system
>>> +setfattr: /scratch/foo: Read-only file system
>>> +setfattr: /scratch/foo: Read-only file system
>>> +ro=false
>>> +getfattr: Removing leading '/' from absolute path names
>>> +# file: scratch/foo
>>> +user.one="2"
>>> +
>>> +getfattr: Removing leading '/' from absolute path names
>>> +# file: scratch/foo
>>> +security.one="2"
>>> +
>>> +getfattr: Removing leading '/' from absolute path names
>>> +# file: scratch/foo
>>> +trusted.one="2"
>>
>>
>>> +
>>
>> Nit: A whitespace.
> 
> It's needed, getfattr prints a blank line at the end.
> 

Ok.

Thanks.

>>
>> Thanks.
>>
>>

