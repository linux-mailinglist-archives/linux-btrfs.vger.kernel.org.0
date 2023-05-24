Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B156670ED6C
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 07:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239537AbjEXFz4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 01:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239327AbjEXFzy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 01:55:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E6F1A8
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 22:55:49 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34O5nqEE008962;
        Wed, 24 May 2023 05:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=fqJ8DLu0TyXCrpk5xZwB7bzPDirtjF9EmXQvA4XjSCM=;
 b=mS+10fqaT7ya8M9s1jx+wX/4aij9llMWF9x08l8XRG5C9uQ5nj9QoHOm0ve8PSlXrlod
 J178Vh4yElTN8klwPnYmBH2BNZSAJqwWnDyWoIgb2z5kiri2gQKbwbqdZInfoeW+BT2W
 TuuOTvax67tDNdhaeqMSVqKqSGETjHOUUiwGL3tl56eyfynoaoKuZ50r2hcGwQyt06BZ
 bfWZWgUNKl/78jsLEFF43ze2/JYSBzTZbIWEk2hl1ihfeYHJ5UWzTlRL8p5RcuMF4rXb
 CPuowmwqDymFckS+F4MqgP1rc6kU9au6HRyM6TGHT3UJIt/E0+u3kVkZsLqy1d17rVrZ SQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qscs280ek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 05:55:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34O40S4j023634;
        Wed, 24 May 2023 05:55:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk8v9rqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 05:55:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwUKVzyPivvfV9at+MSyxmx/fbv+RRAg9trGaiC+byy5RHe7OEohwLo8XqqAZRMcOLmyqHajGPIVQ0mK5jaPPELca8NtKEnNFQnmB9mZGwIpg4CJtAwZMTqlyWqUbuQ60vgnNz0iyR8f5UO6I6qsuuppghZu6+yRjOSwCikHPBruc9aIwzKwzCgYwnieznylEyTUT6OYwJAmrORvh23KIN3IHSaMgOIUA3lhlZhgSgF5DfJdxlodYH2sGFRRzzV8m0ri9U+C05QQ0sZOwP3MOo2bQZlkzIf2Q0Xup9AnsnEc8Bh6yZmnxTtkilJzPRNLKF7U78OiCaG63i8I1pHRNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqJ8DLu0TyXCrpk5xZwB7bzPDirtjF9EmXQvA4XjSCM=;
 b=DnHZ1rHdPxdrPRlWoksJXzMHBieOEh/vNYbAjhiX98kGVYRp2kCcAzOiLivf7iEvSo6uJrpF0vhGe+XpEIaFDT8pUjjm1uxXFyMDySApbrFFcnD22lj4dp8b5lnVsia3V6rOrNQyyeJPwZr888YIm4Q6o/LUwpF6UXLDx3kSrUC5kJjNohIgdQpjegxQUNcrKizj0ULWDoicZ+s40b5gLu57KbhTIqNii80Qo4Ie7/dOsUlN9ik/j0D08mclYz2NObaJRyslr++pDbijwjoPyKjwF2bNHlsb8/sI/3bpOoLiSRljZbRNoRSmrs67A3bm1eqo9Z/aCZhh8Q5lfao3Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqJ8DLu0TyXCrpk5xZwB7bzPDirtjF9EmXQvA4XjSCM=;
 b=UDecZ0obBOhepxGtKub0VmOhvtY3sOMuoqMDAuWqV6NKUrwvzhcQMoXBZoAMaLz6Bqh3ZolNY6Y0JMfdSiZm29JTVCdT+6HyoF9e9FyTtWKzhA7wUdDTBzev1Qnuukh1ViJ+rZIKLP7HbncjnTDgXehY2fk6ErCJNyokHYHLnj8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB5855.namprd10.prod.outlook.com (2603:10b6:510:13f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 05:55:44 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 05:55:43 +0000
Message-ID: <c7771a23-e4af-3b5f-060b-d334f04c9d0d@oracle.com>
Date:   Wed, 24 May 2023 13:55:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 6/9] btrfs: refactor with memcmp_fsid_fs_devices helper
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1684826246.git.anand.jain@oracle.com>
 <fec5e2be6fd4c778966edc3c576f7df38cd0ad3d.1684826247.git.anand.jain@oracle.com>
 <20230523212334.GD32559@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230523212334.GD32559@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB5855:EE_
X-MS-Office365-Filtering-Correlation-Id: db0a7e7b-a4c6-4d0b-32ac-08db5c1b82a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rOLurOcVqqnan3T3BXAu+bc8CmqY9O6c3LhbSs2bibL8Yd/G0E0IHshBaBPhcxccBtMcAEOgUAuUDRPIUTztkpsxC/skq5OUfmthLg6lN+MDlYIvIy7FhTV/RiKXE+Bkj3rQzqApeer4keD2rKknDxOuX75G8bow78ELbZMAPP0g+bnwdsYoQD69Gh1STXEMSUrBb5oeyTGW5dcohHRv8w4nkuaPatec6OljTDzSt5uqaNhBLTQ547M199j04zVhBcPGLdGXVqgz/4uBSAmsB0vF9G3ihskz0QFqIYOeCAab9H9f7okGEi341OzsJ7J+/BNgVFFABn4+1VfTmIBN1zg+BSq0J0mrHu00O/Cnd1BDWoLRU2k7iHfB7V5nHshjyMYKlgfY/nRrvd4c+M/xoZ+Vv+EXOHF7xjaUAs7BDr+E8q8Y8DAflnOShs1tks11DF3I1RBZr4lhzYTG8PxDFevLh4AHI8wmoJG/YhKZCksAu3lGKJQjXzGclI1oFDZpNa76KsmRB6n/umafjLiB44Ldo5CDAF+0FVG+0SWmEdol0jDRrLGavDdXA1UDDU8OBjtQyqlw3Oa1TM4wYuOqnl4ifY2if/sDZ5Od87WNcuQNebbOwV2oPuZ8uNbIediSSuNWZizNVroH5Lc46Rwbug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199021)(6666004)(478600001)(83380400001)(2616005)(38100700002)(86362001)(31696002)(6506007)(6512007)(26005)(36756003)(53546011)(186003)(41300700001)(8936002)(316002)(31686004)(6486002)(8676002)(5660300002)(2906002)(44832011)(66946007)(66556008)(66476007)(4326008)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTU0UDJ0bnpObHBzbWJmdmFmckowWStOZi9JOVp3TzI4RVJEMm02YkdNMFdZ?=
 =?utf-8?B?Vm1ScXlMNzBncTU4UTh2U2FOSGtZWm9XT2tsL1ZQR25CWkxpOHZESk1wRHg0?=
 =?utf-8?B?UFNrZkxoODFMbERWWnVzUFgxYkt5VFdqMXhFbG5tb1pTMjNFL2sxYWh4WUk4?=
 =?utf-8?B?WHNLWHBuUzNTL2RseUQwZmlranZaSjBPNGUrODhDK1BsYTFRTmF0VUtXd01S?=
 =?utf-8?B?bVpPek00SWgzbUhTTDlEWnZlYmcxY3diNnl0STlCdjNmUUtHaGxJaHJ6dGFs?=
 =?utf-8?B?azFIaFFLb3lTZ0QrTGwwb3pxMk50bjlWMDg0V3pqa1Uxa0Y5ODM4R0xlaUto?=
 =?utf-8?B?UzdGcUFzbEdSbjREZU1acCtKQ1pKYUJJM3paWHZpM0ZXTG9OTTFoL2M5Ykpk?=
 =?utf-8?B?dXlZNDMxUlV1RGJKZHVPb1I2Yzl5Y2FJZmRCVVZ5N2VuNGdxczB0ZE1QeUhl?=
 =?utf-8?B?K1pLdXd4eFJrWnJ1TTYzc05jRVlkUktYOEtPUTVzdi9FMUtYMlVDZ2lyWTFO?=
 =?utf-8?B?bTRnWmhXaGdEbWU2S1V3MEp3dFQvdHpzNnVhNmZlRVg3MmN4REI3cThPT0xB?=
 =?utf-8?B?bncwa0RrV0duMUdwd0l6V3RJUEloaXkwQkozbSs1UlNEdEhhU1Jzc0ppMm9o?=
 =?utf-8?B?S0w1NFN4Qm16UGZyMlJqRlNSNUFEWDd0SVBNbGZkVGFGZm9xMTVOUElKZ3NC?=
 =?utf-8?B?TTF1R1lFU2F2SVA0SHQwNzRvQksrdys5NUoxM3dEL2t6b1JCcllRMVJIV2o0?=
 =?utf-8?B?cml3b2l0NlhEaXBZekJhUzJyczZFeWhoRkZWcXJSd0E4ZFlnWENMMG10eVlJ?=
 =?utf-8?B?d2NNcHl2RVNpOHNiUFU3eHA1T29tekVNeHVCbVNFNUpNR2RHTE8xNjByaWdn?=
 =?utf-8?B?d3BBUm9UazJtbnFpaUtScER5dHBhMncyMTYyRzBVcGdwMnhQbk1WNUN3cHAz?=
 =?utf-8?B?Mk9NSXczNUo5UnhVbC9LOUZTZlhZSzlnS2lIbjNNUm80cWJXZUR6ejNLUFB3?=
 =?utf-8?B?Si9GV1N3RmlzbElxcUxIT3RjYisvY3RhL2pKYTRkN1AyUjdsenFpdC9aL0Zq?=
 =?utf-8?B?cWdmTlFMUGpxQnJOSlFIRllkSHEwMStZYkl3anprTFdZVTdTZVdCOXhOVXJ5?=
 =?utf-8?B?bUdPM0xZTVhOb3ZKbFlYSGgyQmJPVEwyNFRQc25SbHlobTJMYzNaMTN5ejBU?=
 =?utf-8?B?NmhQMnd3RmJJTHRJZGgrSWRTamVsRkpiaEJ2VVNleE1QeUhVT0xxcDZxMStB?=
 =?utf-8?B?M2E1SC84Um5TbmZSQzV1SzZPQ3NkRFFEbldBT2wrdnZ3cjRCZHhkNEt2SU1D?=
 =?utf-8?B?bStEakZZOXFSWmI3YXdhOW9FWmJyS3hSdFNIZXpYRkViSXROaGFHZlg2azR2?=
 =?utf-8?B?Zk84RGpzd0cyTzkvNWJDL1ozcExhS1pITDNNSk50aDVMUnpPOXUrNE9lM3NU?=
 =?utf-8?B?Q1p6MS85ZzlFbFhhREh5eE5OOXpiWkdMZFRsV1R0WVpBZXl4NFFJcnNZYmgw?=
 =?utf-8?B?aTV0RU5OWFp1YjNadVVSUkI2QjF2THI3L3NlZTE0M2FHM092VnZpVGxFeStI?=
 =?utf-8?B?cmlkSWhGMFBVYVpFYkpybDNqZjNEajZvMFB2bzdjM04rYTZ4KzhoSnErTkRw?=
 =?utf-8?B?b1hlOGlXSnQ3WktydTI0WXNRTkwwSjhDMTZvR09CQ2YwbDJwM0JGMk1VVENw?=
 =?utf-8?B?amNXOVFEdk54OWVhcmhrQi9MdEN4eTFMaWZpVHBFejdtdWlXZVNwa0JKT3kv?=
 =?utf-8?B?MmhzSzJPVDBodzBUbUowZ3NKV1EzQlg2aG1PcGhSQ2ppZHgrSFpLMzRwY09s?=
 =?utf-8?B?L1RUaER2bHJrQ28yaHpRem0zWnRLQXJrU3QvTzVWVytzTXhjVVhXMzArRjg5?=
 =?utf-8?B?anJzK1VMMEVBNk9XNjlMSno0ZUtkZEdqNDltUmhETjZudnllcnZoOFM2K25v?=
 =?utf-8?B?TWNQN1VRM1BDOVl1ZzlXVTlIalRBaWhvTkpkZ1VvOW56djlQcml4VTFuZFdM?=
 =?utf-8?B?RFdqYURDOXhLaEUyUWg0TTVrWG85b0FTRWNUSXdZWWFpYmRrVWFCbk1PQzcx?=
 =?utf-8?B?bW9JaWpkSjVVWTZscUFxMjBwOXNsYlFOUG5ZQnFTMDBzTStScmJHVEc1MDFn?=
 =?utf-8?Q?F5kjqV9mRB4vX0Xhf31Kc3xm5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: croL6XYO5ay7a1/bedwE/q3nM5nXQE4JcqmNzD6UZqzSErmZPXFLwhcRbacuVlCTo42uKVsmO5I2LsUecYUkQnweNsXQHKNMPx0O/W/4ohimkMDy2qEfnDscY4EE9D4mh0wRgK/BW04Yi9hKEf2AzkoFWwxtYtW0kFrW/jdm+Mq+FRtWryDWP3XikmNBkrWCcRvoLsl88O3TuiE/PykT20BDCfgqpwW6953LBs31nF6nyFy7LoCjMtzH7VFS8fT0fp9OXGWzHC+yaO92tMKmo1umdZjUmzswMKmZmaJEj/nTzFHnAX6VeWRZeix5iEp7sZObXOdZb1WhVdkjGhISMYZv81RGEWbTfxaipMLy/4b1tTjBIZHqTYYJEa/HMbhgoziIDEChWjiXT9XA0BfpuZzMeQZvOHSPjINp2KU0dOxYjTtLyYK/HTFkDCwXHUcA8Wk+eFwRnWaQSW90IG+cFZmYFbE4exBR+9vdIMb4x++6rHxWgqdYvbcqfQOOGSS/lL5CQEJ9WK0TFjyZxWzCquUMZl+Nh9f0ByTp5TcnYE2wKHnsW1F9WfWy3SxwgZBS8mfzD7uvnPFPG6YAuKOmeUwNzY8mfTZ0dx+zpz6eRkGMrq3tcL9Gh2Xjqbl4UsWFPczX9CERIKvL3gxxDE+3KJljdqh4OpCdnykyvJYkBqaFvDSaq0Jjo1TdazddE76pmS2yS309cN9vMcg6Fx4+Kq5DX05OxK9/zZDocXMXn4xrQ5AbUZ2wSS32QLJDDjCAT+PqhzpHSTGDTR1U8pT1pnv0ADVOva16IvFEpEKPagQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db0a7e7b-a4c6-4d0b-32ac-08db5c1b82a9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 05:55:43.2274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPfuxxoLyrPOW7Q97MlxtxO54PrtOVfcZPyF94Ir/9KejnBH690hfdXSLjSpyTKQcK7yVvnzHigHNu4gvaUnXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5855
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_02,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305240049
X-Proofpoint-ORIG-GUID: j1W7DLCVKbg31RsyhmIhZbHJv63MSvic
X-Proofpoint-GUID: j1W7DLCVKbg31RsyhmIhZbHJv63MSvic
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/5/23 05:23, David Sterba wrote:
> On Tue, May 23, 2023 at 06:03:21PM +0800, Anand Jain wrote:
>> Refactor the functions find_fsid() and find_fsid_with_metadata_uuid(), as
>> they currently share a common set of code to compare the fsid and
>> metadata_uuid. Create a common helper function,
>> memcmp_fsid_fs_devices().
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/volumes.c | 40 +++++++++++++++++++++++++---------------
>>   1 file changed, 25 insertions(+), 15 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 95b87e9a0a73..8738c8027421 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -427,6 +427,22 @@ void __exit btrfs_cleanup_fs_uuids(void)
>>   	}
>>   }
>>   
>> +static bool memcmp_fsid_fs_devices(struct btrfs_fs_devices *fs_devices,
>> +				   const u8 *fsid, const u8 *metadata_fsid)
> 
> It's confusing when function is named memcmp_* but does not have the
> same return value semantics as memcmp().
> 
> We could use "memeq_" prefix but I don't see it used in kernel so
> there's not a pattern to follow but for readability, either the helpers
> should be exactly memcmp() semantics or rename to something better
> reflecting that it's a equal or not.

Yeah, calling it "memcmp_" with different return semantic will be
confusing. I'll rename. Howabout, "match_"?

Thanks, Anand
