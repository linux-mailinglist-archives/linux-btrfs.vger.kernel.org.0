Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8D8708F61
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 May 2023 07:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjESFYl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 May 2023 01:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjESFYM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 May 2023 01:24:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C9C19AF;
        Thu, 18 May 2023 22:23:26 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IIwuka018357;
        Fri, 19 May 2023 05:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=rKWC5OYhbcBfetLcTr9J/sxzsds2gUwBIKFYp6WFB5Q=;
 b=Jm31RDh4IydKf7pufiVgwXImQ9NDE+h3E1SS4x2L6KtMgegibBMTkc1FwCuvZQx1VOZJ
 EcSDeMayZVQ+KSsLDLU4NKIwLUDk/xaTyeywnIPEHdwKApb00Ms5ufLfoPKVfS0+lYgh
 1jGsA3lq6Q0ixScu5jAx1a4XHy6715hXs2bDvyGpbHzwlfFqRV0H0ZGPZijagDx7iEAw
 Q/rMMN/LZLTj3gdzAvbitSBFBrHQXzybhauOjKSTLm9DM86KH15YgU3YGFTuGGN2LI1Z
 lCDY+j1JZ/VZXjmTMQK00chbW/nmzoIrzd1ftOJjxzkP0wNwd2puC/wlezMu58RgEzFs yg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdst0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 05:23:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34J4r1KL025051;
        Fri, 19 May 2023 05:23:20 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj107nn6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 05:23:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i275KkpjDDUb2CjQ9TLTs4kvoPsq9cUg5VP4MEdLZgmTsTFip8NbTt3h2FqNqavYC+1twNOT4ej4FYxm8dM2dHyqc72rGKfdiiI2zEZt32EDaG0hAtBwjMe+fZ5qH984d6DPc85ZX60EX1phZIJCoM0o8MzlDVoiytP8JuSYQISDRS6VIlAHo+3uHudtFjiMd032XmTLJ4+3FO3d6iRaD5Ziv3RazpSErMhCvcqCcOg781wbba0Td0jx4FB6fnOqv3lfUk5oMDz7PNCz/X2XNn/ra83UP8Dm0cv5213cYHELbmmIjuKIkmOhDdHWvg+MIjOEPgZ0zKvfXEgpyfucvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKWC5OYhbcBfetLcTr9J/sxzsds2gUwBIKFYp6WFB5Q=;
 b=U5RTk32NM/T4rGbU+QoV9Wc56mzKOCQoRBgGhJee17AJKWfq6G1aGm7mcjUeEVC/aGpPMPce3WFsRtNoOAkD0kTl2+JwDoQQ1+LMdJ+BiXZgX8gXrGK1WJxYvHWaQ38LWjevSD/7Z/oV7d+ipzKtck/z6QDPGT+zC4QOCo/oBH/rhGBXpDL0p7usDD28/7KtkyMkYE3ZhNEdBtZIUNSmdfNNnNJnxA9CbhVyly9eM2+BUnCh3Im5qY9i3SWiMBPTx8SwH/h1i963z4w6SK/4OuZa836jJ0CWxv6ySItD86gxM1X3hVoI13rZ0aFICMj05ZGQlDDtkMq9HBg3i9O4Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKWC5OYhbcBfetLcTr9J/sxzsds2gUwBIKFYp6WFB5Q=;
 b=E1nXn8VaeegsTTFjVJD6wNaQV0teCHSOKfBg+84iXAsqv8dsIUoUjxLDsVKHREGyYlcQA0X/jEWjdw/bdUJCE7n5i/f5vYRN+/NKDs5TbeAHJT48lgqvCOi3XbfPNIQBsfVSZNn0Q5j2CVSGAkoZ/W8XCmDyHC5K5d/2rtaZcxs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4772.namprd10.prod.outlook.com (2603:10b6:303:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 05:23:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.017; Fri, 19 May 2023
 05:23:17 +0000
Message-ID: <9f1c6ecb-3cab-c3ba-8a43-15b73e5f2ec3@oracle.com>
Date:   Fri, 19 May 2023 13:23:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] generic/708: fix commit subject and add its git hash
Content-Language: en-US
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <5f0b10c063fd6297c470dcc26cf2f3eaf412a943.1684407930.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <5f0b10c063fd6297c470dcc26cf2f3eaf412a943.1684407930.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:4:186::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4772:EE_
X-MS-Office365-Filtering-Correlation-Id: c8cb0415-e82c-4b3f-843c-08db582926b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o8Ygn8hI/IKZ4q9OlZfxIKdXwIhbWkQlYRLx9HRk2ramlEIiCNa26PIJYRXTljmXvO0srAG73up06Ur4KIZJg1PZLeCegbJGD6S68Gn2076TTB4sv3Qjk1/DtkKQbkEqzm4F0q2G8NYEP8cARZZCQqUBmWufumeb1h8fS6EeNxNvHR0QNAhgFbiWDPN/zdBpVoejSbfsVh2iW4nGghck2K737Uc5G4h1sYqRFzLlbIhYNeplbLViGZwYq+ZKcVsf0S+4IlyPwjkT6KtjAAYQFp0TrRxb3Gocq2WBcHvvalAExpzbnyKqasZ8m42Vax+buJY1Su3xYgz3xCn+MZSQEmssiPMpFot0GxqsOwUb2pnMenVcrR62NgMj3gYAKPfDoCYuODAhtAteHEEIOivyCayZq38k+Ih1mt4rBWcyvSD+2AY9e4w5BxamVXNirzqgXuvzyguDOQiecoY+OSoup/vDx7zIrTLxJJmMoTR6jPBu+6UoCuXEIAnIA8Df7Q96VGEXVqSwq4b7NGnRDnAftRrh2hNzJx0zJz/tYHVV3KNPv4+mFQ52nZ4+pvIsS25MEdXW+/IPjj2VGT0nx6UU4InR64l1fs0CjUgr+lZejhEyvEZ8fl3AsYAt3Cmddeej5iVstU7xyqbZRkAP+yW4p+H0mEmh2SjeeuM3PbwTk8w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(39860400002)(396003)(136003)(451199021)(36756003)(86362001)(31696002)(316002)(4326008)(66946007)(66556008)(66476007)(478600001)(6486002)(6666004)(8936002)(8676002)(5660300002)(41300700001)(2906002)(44832011)(38100700002)(2616005)(6512007)(6506007)(26005)(186003)(53546011)(83380400001)(31686004)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0ZiRG54eEpzYk02cnJnc3lZdlI4S0NIQ3k1VHkwNGxZNk1lWWlyL3Y4K1dz?=
 =?utf-8?B?QnVUenI0UTN3REFxSVN3YTk1VTQwRlByWlNrbVkwRjd3SEUwNjJCUWtYMXFW?=
 =?utf-8?B?NFV1by8xbFZ6RlBPaUVtL1g2UVRTM05CMGpMMnlGeWM1em1tRXJJSVZIOGxE?=
 =?utf-8?B?MTdCU25jMWozYktyWHo1eTkwUjZTV2s5UVAxcWdUZ05aNmpMaXBFNVlIOTh5?=
 =?utf-8?B?VEdKK2NNQXp4SE5ibi95ZWhGNDBSZnhzMUlhSFZkWFJqTnM0OWlza0p2bHVr?=
 =?utf-8?B?Yll4em1XbFpzM0hJQjl1dnIwanZqTmxtMmN2MHRhRXV4NEpHeGlzMWowSHNn?=
 =?utf-8?B?UGpnaHhneVlBcmthYkdoOVVDVUJYR050TENmamNKOXZzT05QMVJwQ3F1cTVw?=
 =?utf-8?B?bE5iaFE0QXFrZU84djBFN1AzMjNGc3dLQWdxU01wZzlpckphamZzZHNoR3Aw?=
 =?utf-8?B?c1hJd3JZaDlEblc3QzNHd1YrWTE4ZUExeDEyc3JFVlpDOUNBeWpHMHNrNS9l?=
 =?utf-8?B?OTBmRExNbG1GM09waUlmTFgrOGZ1aFlTUkEyT2sxYVR6NHBiVE5wcFZ1aWZl?=
 =?utf-8?B?Zjc5ekdWVTBnZGw1MzcwS1JST0ZpcUhiL25ZZkpxdmF4Rm9sVjhzVnlZQytY?=
 =?utf-8?B?TTJNUlFka3FudUF4S1g4cDBkbmwvR2Q3NGx6Qm1UK2ZCZENia3hEenZzRFlw?=
 =?utf-8?B?R3hnL3NUdUltUC80MGlqU0p3NVFNODR0clgxWEVialFibjBWMC85OFNjK3k2?=
 =?utf-8?B?SmYyVkx5SXF0SDhuS0RCWXBzYmFoV09BelluWVlWVVA2UGpRSkYwcHl1YVd3?=
 =?utf-8?B?b3BlWnBVOTR3aWM4OW1xaEFtd0Fmc3BIMWRDWVhhK2lodXF6c2VjaEYraEsz?=
 =?utf-8?B?c0lLUHBHaEQwcmx4S2VIRG1OTWp1bURvZXpLV1VPcDVOQ2ZwYUlaVEk3ODR3?=
 =?utf-8?B?ZUZ3aWI5KzFwMXJKS3ErVm1kejdqbUwrQktFS1JoVGRseFpydWJzeXpVNWxi?=
 =?utf-8?B?dXVJNUdMRlpKcVU0Qnpzd3J1MFJzL3k2S2V1bkdFQ3o1Q0xGUENuRzZmT0tX?=
 =?utf-8?B?d04vODhFcXdHY3paYlJ5amdPVjdRNHUxc296ZVZtZHNJTm5YZ2tnSTE4TW05?=
 =?utf-8?B?U2pPVUFrQnNuNXRHcHBJcUVQTGJaeWRydGFYZ1ZMbWJhNzMwbmJEa3ZYd2hl?=
 =?utf-8?B?aWxFcW9mMklYTWJXY0pGNjd6cVpDcWZhRDA0bEE4QTdENnlEbE9Pc3QzWXBO?=
 =?utf-8?B?T1MwVjNzT2Q4cmlDeS9tODBPWFpuUjdzV1FrdTZyZ1VJa1E3RVhob2pVdmd1?=
 =?utf-8?B?WjJ1SWxOY0p1cTY2Qm5Sd1laQWd5M0dWTk1GeTZZZzFmWWlFNEt1ekUxSkZw?=
 =?utf-8?B?cTNSbWF5U1VFMEFSOUxHNkR2cFoxRmNiOGdPZ2ZreEx3Z29OQnkyUnRsZVBq?=
 =?utf-8?B?QUVWWVlUbHlWcXRRWVo4MmtqUi80azhFaVU5ejJSdUZ1UGhxVzlLSzJTY2E5?=
 =?utf-8?B?MkUxZ1pDYkpzV0lIWXVrSWptRDBBc0NDZ3RkU0dFNXhYdllmZUxJOW5VYVd6?=
 =?utf-8?B?YmcxUmx0akJWc1JrcGV2T1JTZzNBSHk5Nks0UUprd2p4c29yNmg5MDRaNDhV?=
 =?utf-8?B?QjdpamE5ak84cndicTAyVm40WDJBdmVxSFI1ZG5tejJyN2l0UjkwQXdBMmd4?=
 =?utf-8?B?Zkpzcko0Uks0bjVMZlVBYWNLQlFTZ3JvNlRRVStKbHBqQWMvNWFFdmlsNzZJ?=
 =?utf-8?B?U3I0d2QyU0MrMXV6bUtkSTBFQ0cvM3IyNFJSTThOYXV3TkRyRGFLaEhadWYv?=
 =?utf-8?B?SmlNS1lxcWJnYWhSeUg1L2F6VUlpYnBycWxXMzJRSkxudlpWRUkzRzlKR3VG?=
 =?utf-8?B?TGxrejFNMWdVemRQNVFKZzFCbEpaYUtQcnFIMElHam9jc1JERXRTOWJNVjBO?=
 =?utf-8?B?L041R2ZycVlva2R5Rkx0MlVxVVpMemV5cVI5SzNTUnkzSDZQdnR6dGh3eVlS?=
 =?utf-8?B?SzE2cFd4RXpzaUNpODdMWHBwVVJnbXRnMkwrWnZIcUNjNTgvdjN1Z2I1aVlM?=
 =?utf-8?B?dUl4c0JpLy9meHB6UktXbGhRbWJoU3RaNWtQQzd3YnlHTHQ3cURqNVJUS1l2?=
 =?utf-8?Q?v+XkQBrSXFWhe4O2GP76+lSAc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yRXjq3Exjzp+D+JMkG+MHApQ5el3tFoaoEq7SRWwb/I7HjHY/tE+2gFdhh4khD9CCG5D1FoZhoSbtqr/DOZZ5CCw3BbA9ZBmvbcIk+hSh/QDqU48PTnRXvjvHtPSWOvj/Nj9wpVTuIEzTNkX2deodX8okFQ1B3pbDdsiZdTzzC7c/QZMRTlw88oj5WfNJvR3wgr7rlECir7adrD94ZohNn9gPYHGOF1RKt7y5WdGxShvc6UAV1RgxbaiJFHxyoTwecFYlJQmcslJ9439SUrqzRk0o1It+MzTX3ZHigCTqGxJVF6Ry0Nq4A+KbEI5IbqN+2kbjQpr7hH0CzmdYrAZ1xHUXdzwYlFidEL2IJLnc3dsInxV1vn5D/FrIyLEvB8hyOmdLUv+m5o28+PYE4HYagw+7bPiKQlB+Td3NE+WXZZmVnmOcTKwyaSxexAcRCNc3Wtu5RwighZtPkNakqNGPSximZ8bGjlxP+geX5rIRtVn/PQPcfhJLL7Wmx0npqhc2MsD9RtlmjuHvtss7fPTsX9qAe4sVhx9E3Bu4CqVtbATw4VF5i3teg0iZozqisEItTGV1XA+Z2wpGb2HxPlSJEPOUVPNfEbgyyIq18UP1Gz7+L406BrN1h9qvXbkizdn/kotisKzPm02kaKgBPdtMCPHuZj8GZr5aLIXDMyTVLoL79mJZiEtnE5cGErWxX0nvq5AAGfdWgjhSExAGQL8nWQ3SaR/YJQ/xj4mMU2jPIzfdVCEl0PYgMUcWkK6+h2uZ8BzUDhSr8IXVpsk7S3hIDz7vIsYQ7rhalbFoV+DbyDJpeDKHg2aIU+M2vCAmIAB
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8cb0415-e82c-4b3f-843c-08db582926b4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 05:23:17.2629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IzgZeduShQR3q5SmQjJtbfyX0TdfJx/pU0ovEdbW1hRmTKsFBn+9FzrgPXeOqzKfBQmLoHcJ7yYX98tOWYzrEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4772
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305190046
X-Proofpoint-GUID: GWlqefmcb1KbDP3sAaeyko_sfTIsKGlv
X-Proofpoint-ORIG-GUID: GWlqefmcb1KbDP3sAaeyko_sfTIsKGlv
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/5/23 19:05, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The test refers to a patch that ended up not committed to Linus' tree, as
> the fix evolved through several patchset versions. The up to date fix
> landed on kernel 6.4-rc1 and is the following:
> 
>      b73a6fd1b1ef "btrfs: split partial dio bios before submit"
> 
> So updated the test to point to that.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   tests/generic/708 | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/708 b/tests/generic/708
> index 1f0843c7..6809a50c 100755
> --- a/tests/generic/708
> +++ b/tests/generic/708
> @@ -14,7 +14,8 @@
>   . ./common/preamble
>   _begin_fstest quick auto
>   [ $FSTYP == "btrfs" ] && \
> -	_fixed_by_kernel_commit XXXX 'btrfs: fix dio continue after short write due to buffer page fault'
> +	_fixed_by_kernel_commit b73a6fd1b1ef \
> +		"btrfs: split partial dio bios before submit"


Reviewed-by: Anand Jain <anand.jain@oracle.com>


>   
>   # real QA test starts here
>   _supported_fs generic

