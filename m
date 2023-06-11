Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF3A72B198
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jun 2023 13:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjFKLOV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Jun 2023 07:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjFKLOT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Jun 2023 07:14:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6D435A3
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Jun 2023 04:13:50 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35B5n6g1012880;
        Sun, 11 Jun 2023 11:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=O5pwjFETIKicOi9ND409Z6YaJbM4oQXAb+fGnCnwT7A=;
 b=fd1ErZV+xXdZlA01iCu3aCkbghsICchncBbLO7E7deqfky1j+/wMCBUr0A8RGgaGg0Nq
 KZEY/TbxACIan/ZEIrVt3zkjXh0rxn/q9QpVNlSrogCHAUwSCyzQBWGNgHQB+yrcR/2T
 WrCCQbyZkl99xMT9frwI8NpyYCTU/TpovhA63zFxthnLoGJYbEGEhKIMctHygwHH/1U4
 lSwFVcAQxsxCBll28wl4AlLv4l13gnkITjJeBvmr3RZSy6eDOfSzXUB8zryLkObTvo5L
 SgEb9ml+g+8N6fmIU9oG2juC7i9nvo8j+Qw2mF3ffzG8W4/ZpIfWyRW3qmWYXlZdK7Xx 7Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fs1sad9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 11 Jun 2023 11:13:18 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35B8Ifqx021613;
        Sun, 11 Jun 2023 11:13:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm1urk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 11 Jun 2023 11:13:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQ77wR8b0stBM0G5fsJal2kK+VWa+sPirl5zmPiUnWkQQVxahIcVkqTX+jd84f8BMSCa+xzbBR0kSwwhMmPC6P+cSZKSl1yQIYpgAxbdR+h4JaWlGec5NKVp5tVnuhXJmgSPROegkbVTeiGadAI6Y3MjgxL/RNR+957175YESu+Z8AcZQlQbFe+PErxa7zk7aKupmTMLwpQ7pC5lc1h6V0tbw0qQV/nUzrPMBLxx53kVk/qRJ5ZJE17IS112e0Bjrc0/fW4HqRF+rGCpR9NrWbmYftgQyZ0fDLqP8TYX/Cs9WRBhc2BnecQQT2KMoUSlnQNKwaTJXOot/aNusfHIIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5pwjFETIKicOi9ND409Z6YaJbM4oQXAb+fGnCnwT7A=;
 b=H0t6Jx2QBQQ+Flyu7gl+cJ7O+OKUOiNnVS22zJRacBAtHcF+07GvDo7Yzz/HhCHRhjOblO+lyldozGYFu1WmWUhGeRUDk6ydd4jJ20+asvvrZqaCrBWO5zUKdSJ2XadZi0y4N9PfgvQzCmJCaoZC6UOJwij41RnE501XiERXMYZInGvzGvRHsy0woDuqRGxuEgHrVQa7x6BgJlnNEcEb22f9u3VttLv58nAjD80SYITidm8gClwA0epMEpP2VHT5FbDO/mNzM+1qKFqySWgx5wRU92SbpvLxCbqPskT8PCX5gqTV7sqvaDWP3F4f9BZZ7lqHbHTVcLkxLS5SWXTnfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5pwjFETIKicOi9ND409Z6YaJbM4oQXAb+fGnCnwT7A=;
 b=bXuko77uTFZt2HYwApBEh5Vg1pXrc9JWAJK0vy4CHnylT7hG0IbtxwDnVlkBOfeXVfa8RMcCCoBtRkxBmnTqXcv/FeEli0JCgzCEz2QnfqNKQ60xNEgI07UQ4SfYbY5Xc8EOa6Fn77rHspE5rl193EqtqT3cJeCZWTTU4+cYWAQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA0PR10MB7644.namprd10.prod.outlook.com (2603:10b6:208:492::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Sun, 11 Jun
 2023 11:13:01 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6477.028; Sun, 11 Jun 2023
 11:13:00 +0000
Message-ID: <851d4ca5-b9ee-1b3a-00ce-9c24058626a6@oracle.com>
Date:   Sun, 11 Jun 2023 19:12:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 5/7] btrfs-progs: btrfs_scan_one_device: drop local
 variable ret
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1686202417.git.anand.jain@oracle.com>
 <718713677855382e44cb57d1ad590063ca20d8f7.1686202417.git.anand.jain@oracle.com>
 <d7bd5351-f8be-525a-8c54-d320982c4ba0@gmx.com>
 <20230608124218.GH28933@twin.jikos.cz>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230608124218.GH28933@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:4:186::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA0PR10MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: 03ce83e6-dfff-473b-e591-08db6a6cd154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4hCqFXFP3yzoNu/DxMB4zPbzzGHDxR9zIm7J4+AgheZfeCzR0/sTjYNemlwi9c/zPwkbMY0volByV2vIzPd2WMGN3F2ejXHOykEPJ2/G24baaZl1Olk6X395JI5YELQQJCAbsYgCsZU18MbIkq0jZIwMuHGfsQgOvO4DKOQb28wJo+921od5jv0RgTM0lLHG+YO+XDb3/5OswX6EWS+JpVf6fAESKe+glVGeOMPEtL5S9JsAgfsKFHt2/yFzUQ21PYHsefyNz3JV4tWKnCsCQwpOsmuIfVIhANL7FMxY0tE4AkZBIPJHaEKW2iMmpnip6p/oXYtz+FV32ECjrDi8ICjoDs4ytXSh3A9F77rxvulHtvUuKcwGE2n9PwxdpKpZFnFcpC9PoP2xYoz+I20Blc8cVjHflkoT9yYhYTPbZisG1D9/1TTepSVSHLNCmu+2eLPaA2u4PVfZs41/ew7qxyVfmjseO8jRDpYh5KJ/puSgdeeOy2oTgs1CgcQW1M3Zrlilh3pk8VeUGIPFqy5KZ5zSypQr9J8CZq390RHwG0I1dOycru1xsmhutfsA6Yfwfs+/eBtdr2Q581KWtjmyAMDm6f7oLJNMW8jqJYHHYpg6GAKxHxA+unpvLbsfUdjP25VZG38aDsykF6+z+9C9eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(346002)(366004)(136003)(451199021)(83380400001)(44832011)(478600001)(8676002)(8936002)(38100700002)(316002)(41300700001)(66946007)(66476007)(66556008)(5660300002)(6916009)(86362001)(31696002)(4326008)(6486002)(36756003)(6666004)(2906002)(31686004)(6512007)(6506007)(26005)(53546011)(186003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1BkSkdKMExUVWtVYVZrN3A3Q1V4YjVwaDIzUUhWdENpMTZLWEROZjUrOEty?=
 =?utf-8?B?dkFrZlRaQW81cTJWcmROcThNT0RKNHV2ZlVncmVScWZJL2R3cXFvWTJDRlJk?=
 =?utf-8?B?Y2huMDhmS1BEa2dLQmdkcjJzTE4xQTlGUFRNcUhlaDNJbTlPazNjeVc2MGt3?=
 =?utf-8?B?M3lqUG5QdHNYai9PSldreEpVZ2tvVkVHaTlLWitoVDBnWWxha203MGhwbVNC?=
 =?utf-8?B?Z2VJWGZFRmkrQzdsaG1jZUZ2RXRPa3JsNmxodHB1OGd3NEYxSk9CZVp3Tnph?=
 =?utf-8?B?UVJZbFQzcmEyVWZnaVNKOE5Yc051SUJDYnRTblVPbjJCVjU1bTZWbkdQK1FQ?=
 =?utf-8?B?TXlPVnJNTkJjeGFCbEE4RXhTb2FJOEhZaUE4cTAwb1ErTVNCUW9SZnowVzRr?=
 =?utf-8?B?bzROcmlUbFZGTDAxei9TOW93T0hPb1czc0tPakg5OE5LZTBPandqN3dUZEtn?=
 =?utf-8?B?bThVbW0vRWp1OS9Bb3RMWVJRQ2VyV21ORlFqamZ5U0UrMjdyL2V4SlVtQVZS?=
 =?utf-8?B?UE1FeVIrWDZFNXppYUtjZUZ6czk4MTNRLzZPaTNBRXp5cVVuNEtsZzk4dFIx?=
 =?utf-8?B?SU1wWVpWNm1OL3I0b0F5blZvU250c2dRaGpqYmVleUdIL2JuSjVNL1Z1U09Q?=
 =?utf-8?B?VjlQYlBRV3Q0V0llUW1aU0J3R0t2S1F5cjFsYVpmamdHMlZ4NDkwVjRRcU9m?=
 =?utf-8?B?SGZzQjFnMGdvVUtocDM5RUU0dFFnblk1RjUrLzVHcUV5bll2a1JtKzJud0k4?=
 =?utf-8?B?aTI1OHdYVjNoNFdPV2Nscmg1MUdSbzZHSUxweVNuMzVXM2M3cUxLZGdHYnQv?=
 =?utf-8?B?M2U2cEk2NWVmU3VXYW9wTml3a0Nnb2VYWXcxZkE0VXV1ZG5nYkJEc1F5SEdh?=
 =?utf-8?B?UzFta3REYVNzM2h2aENSSUVJRytJVXdmZHZMRjF3SEM2UFBVTlFZNm83MnRt?=
 =?utf-8?B?Z1lYY083WUxuRTFCeThMbHUzVFVBd3prcDAyTDQ0NWIrTU1HYncyRjgwWXRL?=
 =?utf-8?B?RG5yS2NJLzY3bnk4cXVmV0poOHN2clJzTmF5akVLOFpNMWxDQnprQU55NlNk?=
 =?utf-8?B?YzBocTd5Q2ROcVRDRUttK3MwaHhzUVd5cXhvQVdRSElFVzd0OUEwV2V1YUhD?=
 =?utf-8?B?VnBEN0UwTGdwb2FYV2Y5MDUzKzRIb1NkcklicTZQbWhkVnhaQTc5azVabFZI?=
 =?utf-8?B?WHRlc1dGTU9mTFlqc2VaWUcwWlhiOVBjUHdKejdvRkRyclIvWkVhSmN1T0xB?=
 =?utf-8?B?M0U0OUlxNzhoMlVzdGhDQzJCZElROTVaRW4yY1N1elBQRDJMTmQ0dGdQczlQ?=
 =?utf-8?B?a2lXZXJqVE0yUmJRcnl1MWlBT3BWWUNaejFKQ1QxZFYycm42dE9zZ09WMWE3?=
 =?utf-8?B?R3duNFBOSjVIUURsRElacXR0ejk2ekFMYVR2NUpKdzZxdXJIYmpkZjZ4STNL?=
 =?utf-8?B?ZDF3REFJbklRZ1VEdS80SkR1eFdscEV2Wm11SmZWcVJ3NVRCeTNMSkdnelNI?=
 =?utf-8?B?L0Y0dEJHTmI3Ykc5aHN3M0tOckQxU01Xa2RaV2ZibUU0b0tpaEVSVlhXWW03?=
 =?utf-8?B?eCtIZGVCaHQ5bGE0M3cxSURmeUE1OTFYNFJBSkJIT3VncmNCQ0xxVTVzT2J1?=
 =?utf-8?B?aTlZTVNUbmxkT0J2WjhBTzFjK25EMno1Rk5aME90SERZUTdRU3c5TjVnSFpu?=
 =?utf-8?B?T2lpNWpvNUljOGF3Ri9CUzM3RHNpTmVEcEJxVVlXV0Vkcm4zZVI2MFJ3UFdV?=
 =?utf-8?B?eHAxbENZcTBPeC9CbGl0STUvczJ3bHN0bmorQUxJUGdkUUNnYytIZFJPNnZq?=
 =?utf-8?B?Z2k2eWVDa0w2dk5iWXNkSzFRbFU4VWlMTHBBU0Y4bG1zUTdQY3dsbGxJdGtW?=
 =?utf-8?B?RUx6dGFBOWxRakdmNkhjQjNtaXh4RGd0eGlDenp2ZVQ5dFRzT2hyY3JuckZF?=
 =?utf-8?B?eExsNHArQzJqWnVRckMzUkcwTGF2U2ZuQkd4MS9BRG5aazFTbnUyZnFWdExD?=
 =?utf-8?B?MGtjRjlHenNSK3l5MThRRGRVMWhUenJBWHN3V0pQOTBsMVNiR05rOFpYdjhY?=
 =?utf-8?B?NEZDUHJBelZhNXl5YVVWck9zUTZ3aFgvck4yZkdENDNUV0F2MDRYRlBXTGlu?=
 =?utf-8?Q?QApCs+qR7/gTjXCLQwKq5qJBB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: x+Scwa1N1hnbuNUmVHHs7XMeFUqSUNTepzB+gJVfB1qDghWcXuV1ax3+u3rHoqP/6/UBr2WhNgjB1hLeKLldgbO8e61oRnWENF9U0RYYojoBiDLrxZHRyPYHcjqu5LtOHTXUxDwrgI/9nRY7N/dOWfkETcCi2xGhE/qaf8pMf+wrBqScLToeF8ntO7ZOcO5b/llfkM2XHBEZg4vhGbxyvOHrjz1qnYBaZd9E+pk0vsS2RuATdU9LoYSBGztiSig/1FgLpAKffo36zW9jEC/gq9rESav77zsqddnPE/xVhgCAkh3prVQ0RJnAc+G61sft88Y8NYsGtIvqXLtZWtePx0XQq9TVc6wvL2b/+LzZns4WIqFHXRC+CvTrFtWs/pr7jA2GUUF/3eax7rlgmuLGp0ptmZBEzqu3TcHcJiLFKofNY9K1LF0HhXwCvQ77cSwCYis8iDQBQZjwJaUIBNybiamjU/r1flaW+qOvAfW9destbeTEsTMIlhXgBtFesYweXj5/aqdBeX8tRkv1zBuWgYWSnlNaYqDmcWA3ABQTDi6WF2l5gBDTTV/wTC8WvrQM8RGesVaztLt/pWkTjOLvG/Qb+DwDAGi9HrSWQYz+mscy1e+fQFWDZG576Hznl0Fq5wj3DtEUiRmu3D4vr4ENOH9wzlfLosj9tOmWJWnMuwgMUPtQyFvUlwVe6tFHaGyU5VKer16JOUoXKifj9oNBJk25W5QiB707CT4oUbnGz/g1hJtwp8x85OAXh14NV2mav+nV9L4/DQ2qcaIVuy4cbEQT0b/M/Cxnzd0Bwu65+018Tvbdoy6TYe5Ben4RT8UF
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ce83e6-dfff-473b-e591-08db6a6cd154
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2023 11:13:00.5182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nT7G+8EcjZRdmTdV6WehhD2BHS5gm0PattUiiso15+YrAcQkNyExPJml26ZCBYQOYhnW1+6Zid5F8Nf5Ir9Mbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7644
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-11_08,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306110102
X-Proofpoint-GUID: g2SQQp6Afcrbx2j8ewGrr3-MVk0DoGka
X-Proofpoint-ORIG-GUID: g2SQQp6Afcrbx2j8ewGrr3-MVk0DoGka
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 08/06/2023 20:42, David Sterba wrote:
> On Thu, Jun 08, 2023 at 02:22:35PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2023/6/8 14:01, Anand Jain wrote:
>>> Local variable int ret is unnecessary, drop it.
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>
>> I'm not sure if this change is really necessary.
>>
>> To me it's more nature to go "ret = what_ever();" then handling @ret.
>> And compiler is definitely clever enough for those optimization.
> 
> Yeah we do
> 
> 	ret = function(...)
> 	if (ret < 0)
> 		...
> 
> almost everywhere. I find it clear, there's something happening is
> on a separate line and the condtion check should have as little side
> effects as possible.


I noticed that the partner will leave the ret to stay.
I am okay with dropping this patch in the next reroll.

I assume you also meant the following is not needed?

@@ -556,9 +554,7 @@ int btrfs_scan_one_device(int fd, const char *path,
  	else
  		*total_devs = btrfs_super_num_devices(&disk_super);

-	ret = device_list_add(path, &disk_super, fs_devices_ret);
-
-	return ret;
+	return device_list_add(path, &disk_super, fs_devices_ret);


Thanks

