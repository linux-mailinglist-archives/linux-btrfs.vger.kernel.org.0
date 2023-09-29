Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9537B2EA1
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Sep 2023 10:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjI2I5g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Sep 2023 04:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjI2I5f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Sep 2023 04:57:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD8E94;
        Fri, 29 Sep 2023 01:57:32 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK8mJe013122;
        Fri, 29 Sep 2023 08:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=GCjxdG7fpI67RGAe7y94qTOj9o8QNQursK/+DqO9TlQ=;
 b=WUuWzOXaXJOtuvGczuNWdMvoatjM9+sqx1NR/K7T+Fo3VTt3qMw4ewWZKfSjq/D9WZ59
 OWqkVaOBVasvCEA5QhpUn5/tzMY96zWGTtFcARDciL3ASKOvp7FLB2X250BTr903l9ON
 1mzpvNxeYngWzZTacYrmlugNukhQDQu9NOZ09bcnrEKXDUTp0MHcqYuSWVIUv/JSFr9o
 t35t5e4mKZaydUIfqGWg5iS+lpY8cU0nnt8DDUVFKMSSdL/f6Yj95FUWNCdG1UWzDyzy
 dGTKPYbKk93/nJrg1k5G6qN7Onoi3IVZTMpxUU5nQUoQGwUn3+ymxkRqkkfBGyu8dIAz Sw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qmupa1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 08:57:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38T7toQU025405;
        Fri, 29 Sep 2023 08:57:28 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfgyxjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 08:57:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3P/bDhRYUC5pD6YwuUOJYLXwAuE1O2xc8Ze/l3rpGWndcZ6CyAlkcibQU6hhr2rrgMv8PVnTs5caowa8XxamOjs1nLHK7gLy80YLomh+4W+0VDGugCBgPPtSVbPZ+u1Mdr/oX8rTcf3wRX9n23uAK8xFMcmBvAvzbGcO+U+Kq0L52t6zJSeOfSKZYKXRizhaEEx9wfwg7OOAQ+JgAnOH+I2noRgLLFJiTgTKLxot979zCyT9VcDI14gpOF3BkjbOvsD+jujEBfvYzkNSZq2Wlo/QfnJTjk527FrS+stesVP5sEdDgSIsIYAmGokxKS1ejmGVG+AmgJG5ALYf8i9YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCjxdG7fpI67RGAe7y94qTOj9o8QNQursK/+DqO9TlQ=;
 b=Tvm07tsrMwsb7lIjlTuhRnZerDqWKeB2BdEwOQXddEIgPFNs5sIF8oLbj1n17B05TXM2r6vwDeQlNO0u3SUFyDhJPptqhzCfH0B9VpSpu+B0mkSJPUTHUAyNjzX/72vcOujp1hbarHbLxDHc6mfKjvvyWaHhi2u0GpSRTHflAIV+Uz2gu6ThcuQySgq1zQuBrBrEFtV5S3cdCK9qD+G2RJWrZcemxYc/XnYxxte0EC+XxxLrv45HYewQ9CCDMe7h6FiC870X3+LixBL5+6lcx8GCpWOT+m9OtxpZvWZMz2YjoHV1JwTr2yiFHEadcPg+qAjplXfuAM0iqnfpU/1zvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCjxdG7fpI67RGAe7y94qTOj9o8QNQursK/+DqO9TlQ=;
 b=NCWoJyqBUpKXhSmb3gJizmGJmQpglJ9z2n+gwRid4J2toYq67gHSmhKiAo19j4YCG08QpJbfseeu/GYuj+3o4t6OyNhSvG6JKLs3G4aCmuErjdHMHcrAx2G++NgWQppWN9nZZMJwfWVTn3lxRGBr4fZXStMYY1GHW+kjGPkA9dM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB4175.namprd10.prod.outlook.com (2603:10b6:208:1d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 08:57:26 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Fri, 29 Sep 2023
 08:57:26 +0000
Message-ID: <2884e54c-9542-fdf7-9746-cfd7d56f5e19@oracle.com>
Date:   Fri, 29 Sep 2023 16:57:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 2/6] btrfs: quota mode helpers
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, fstests@vger.kernel.org
References: <cover.1695942727.git.boris@bur.io>
 <fd723f002c3019b79c515d3408f951f0897f414f.1695942727.git.boris@bur.io>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <fd723f002c3019b79c515d3408f951f0897f414f.1695942727.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:3:17::26) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN2PR10MB4175:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c3b541d-bb15-434c-f29f-08dbc0ca1a52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IZ2eOXc9/KsyLD/IiBLPNKg+wm8+D281lPcodlKveUVFWoQdxxGST41NReClsSQg7aFPi7Me7s3Yta3lwgqKIg+Myo7CZQqlUjWsXDW9sxuIuJTLv40yQT5YzuRH9SltvBIpwJHYfyvu0/o7PFR8DwZFMr6gIUI3A5IoUNq3/ZnxMHVtLJze00eKY/5E9B8QVQsXWvRkwt9JamY+k8pDRjYnW0pYmlU9s6Bvc0D46b/qBoC3JQrxB7XXYpku0j7BUn7GC1nmtwj3ewuLaSZX+35uGgZ1BstJNnwkQisy2TsrFIQrRCsXK0VfBpbBRlS8zgo5XSR+z64589SDhvDqWAdcwVBx0fIimqHo9TkngrjnIeO2GG9XeoWCyjLO7C4CELW6Jt0ZPGQwDLQW8CFNroKWCuCRA4aHGkIhkkUBYIDe8/8aACqjpFw/PhtGJvrTis+6gmJx8hljbtGyXwhvioJZ9flpHbTBUBO8RIgqTfUUYRv5jMABFF5sMzkZjqtE9Drh3iTqjqz1pBWUwLFjEfw0F1kVd9uZbqYlflHQ/TLOgGzKRm4U8RPE9yq/y8TDQnTYNI7WObZvtuAMvpOYyDYVvmuZpk6/4eVP5ian+RwrAM4wP3QOALbwW83k+it9fjM3QWkQ3DHdG5snNmnD0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39860400002)(346002)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6486002)(6506007)(5660300002)(66946007)(6666004)(15650500001)(83380400001)(316002)(38100700002)(6512007)(53546011)(66476007)(2616005)(44832011)(26005)(66556008)(41300700001)(8936002)(478600001)(8676002)(31696002)(86362001)(36756003)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0h2d2duc2NOK0ppRW1pVkFUUWhBb0pHY3greEQ5UFhhTjkxSzJxSmtWdEVx?=
 =?utf-8?B?SVJWOG0vZkROY1JXTDFiUm5ITWFhY2wyTDNqWE4wUGV0T3pIWExMbS9uSjFo?=
 =?utf-8?B?Wnl6ZThCb2tkZURIMm90clp6V2JJYVVLYzFNNWdMUWJnazlHSWNXSDluMER0?=
 =?utf-8?B?QUU1SVU0bHVvR2cyWE43RFRzUHVGN1U5NHJrMXFScllManFDMWNLSGlGdkk1?=
 =?utf-8?B?TTFTNGNHUjdvOWxpK1J3UUVnZ1V1Q1J1SkpvUTJSU3NMY3I4VjEwdDdKQk52?=
 =?utf-8?B?WXNhT0k2WDNucmN0UjIwTjUwVlo2d0oxaUJQU1FHUkNCOU9XcTJ0QzlPMEZx?=
 =?utf-8?B?TU4zTEJ3SWV1RVlHWUcyY2E3TlBKblNTbWlEcmM3TzF5YTRwSlJKOURqVXh1?=
 =?utf-8?B?SldCMU41TjJtUkZrMStlY3g2V216bVRmOVlORFZzUlJEMHR1Wk5xayt5eE1Z?=
 =?utf-8?B?NDhYYXZPTG53Q3hpdHlPMzBXMWpPb3dGV0o3MVZVNzg3aEJqbmJwdUZ5Zmgz?=
 =?utf-8?B?cVBLS0t1NkNXdlZGc3lRRTNQMFFCUXN0Y000c2o0bW1VeDFmejJTYldCeUpJ?=
 =?utf-8?B?NnhnUUNkbVRCdWpiN0JDc29jaU8xOWZmeHVraVdaeU1QY0N4UCtLVk9mWmpn?=
 =?utf-8?B?VlVXYXhuWGVoODdkcklhYjNFUllpY1ZjQm83b2tnTFYxSkNBYllRN2hGWWNM?=
 =?utf-8?B?SVc5ZDZvSlBjQ0pBTkg3MGtTR3NIU2FmQm9NU0tqbXhJekEwUjVaTmhUcXlk?=
 =?utf-8?B?UW9jZTBNQmtFeWRhYTB1Zzk1NlhLRFdsYk1XeHlLTHN4OVhOVHd0YldCQU1N?=
 =?utf-8?B?K2h1eGZORnI5L2YrSDhYclIvQ0oxd2dnbHRTT0s0UmVZNUxGTGFod21kSFF2?=
 =?utf-8?B?M0FQa1A3Vk91VDJoYnRGOFpOU3ZaK09ydlRBS3JqRXYreFN6YW1FRThac2lk?=
 =?utf-8?B?RUhpSUdJNkdqeGxkUFo5eTdNY1JlOWRsYUoxV1FLT1VOM3kya1JOWU5VUG5E?=
 =?utf-8?B?YXJIWXlsVlA1Y1QrSWpuNWxwY29LaEt0NERLeDRQZ2NGT05FZDU2QTNzZnln?=
 =?utf-8?B?N0dqZk5aTE1RQk93SHB6aW1LS1BSeDZBMW1zY1ppbE9WaGZiTG5YSzlqNEVi?=
 =?utf-8?B?TDFRM295SzcxRG5TUlpVSHdMQU9aWDRmbHZQcVV1elh5OEhkNmZNMkR0Z2Zz?=
 =?utf-8?B?bXBQSXpvSzlDRS9CL1VTNlFxRDhjMUNkZXFoN2ZOMWhrUHUzN2xYVlFOaUF2?=
 =?utf-8?B?Zm0rT2hjWUVuTE9BU3dnd3ZjNjNLUm51RXlWRk1ENlREMlN3RjFONlVYYzNN?=
 =?utf-8?B?SzRwWUxRWlU3VHorREJsamxDMVJBOTZQaC8xbFBrbXIyMVNUMFlVSVRGaTZy?=
 =?utf-8?B?UzJqWGVDNi94QTFCNTBmeUtIVXRIRGxFSGVpbXc1TmpIUXRHdnkyYksydngy?=
 =?utf-8?B?aXNhcUtoRWMyVTdWYWt5T3JEM09zbHlTdTVkUDczK3RhVkJSUUhNUXkwOUxH?=
 =?utf-8?B?V3h0WHA0Wmh3dURvQ0RYZXRNQVBxSXFscU53VThZcmRSSURmVDVZUDh2VWlM?=
 =?utf-8?B?UW1JZ2dRam10WVJRYzI1MkF3c1AwVUpFbDFXb2lFVWtLOVVmcnQwdnNMSm9H?=
 =?utf-8?B?SkFLTWZkL1kxUG1kWnFpUkRhUktBNk4vZFFseEk5TXRiS0cwbmZFSFJjNlh6?=
 =?utf-8?B?ZmlVZmdBZ3lPdWhTUjA2MmRVaFFZSXI1aVdHNzBxODVjZmZMSXNGU1A4SWpT?=
 =?utf-8?B?VmYrTHhmZitCR2V2c3djQ25KazRCL0tra1YyZUpwTVN6YTVTTG5kTzFKYWpz?=
 =?utf-8?B?dXBkZnNLRmpxTWJvVngyY1VtaVFoeDNxOXJzQlBUY3FkTDN2V1dGZFVLQVBq?=
 =?utf-8?B?M01iTThVNlJ2SDBDLzdHZ1dHTFB2WENzYVQ2eTJUYzE3VWd3U1NuUG51UXhD?=
 =?utf-8?B?SDNJZFg5a0d5K1RhVWcxS3hTUmgvWm95eGw1Y3lXK3RrUGJ4c1NGbVJMOFNp?=
 =?utf-8?B?cHFNd3BCcU5LUFduRXV0bmp2dEtFTGFCZGxoTzVDYWNBZzE2ZStUVnhQTDFr?=
 =?utf-8?B?ckRucE1xcHlzN1QvdU9IVW1MRWZtZW5YVHJkMzVadWhINDl6T1lMQkFJdTJj?=
 =?utf-8?B?R25JcloxbVVYRVo1Qk9SM2FlZkE3Vzl6R2Y0WjZ0RTA5ejdiMUZ6L1IvVmNj?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0tygEVqPTfo5zGQAltcOM8LDucg+VxaIikJqJhu6aN/eSa9xkjwhmy7qgbdRggYSJ7RE0rl6QGEI4AWxvVIQ5QduBSmOQekgGbOX8romvETGbaqqwQak67ZQKf36i5sFtvq0HbZf1lk2AxE04dB3s1Q1ZKJYC7yz+YOsFVwnExCVhsOLpwEAHvWncdejqisNAexq3VYqOGecWDKeR670Mb04sAA3RknjtIru2LotJlFYfjSONisiaOlNyX/PJfKD7F4TeKvHLOXr0UjwFwalYAMSjCsuCHuXVknuIMwMHfZXPiVzS3MYDe0YwMBnbsA6mmmjdPOU+Ve6hPWAprgVjMNkILv4AANaP3rg9xOqmxldfqaklqG4wFc9lHmnycMDuD7BNf7IzOG523mi+r2VOFAD6+MUSsXczldm8TlNyBojXRKMPzAZG3ikGeH+dbawkfzzbMYs2w1TEaFVMQvjbNC3eYEHqL4QxvD1Chqt6Dsq19Am8apHQ1+BBKSAmoUIhh9K9dcBPeJ44wvCGmbIu8w/+Qxlodwjc4fc91KEb0832D/BRp0gRuoFv0KBMlOT7/NzLFPUQK5wbNnaQJmwSuSkzL3YQYA5gjUqg8ruhbmY0Va27MI10YKfXJR8UetdBobAaOxatfqCnAymt84D4wg5y4n0wp8yDAtMO23HqszugqFvr9TWYl1Q9cUk0ahzLi/pd/u3ZiL0PKE1L3ZdwoHq6Iz0GGvxuYTYq9yGJuSi3SLeZE/kIIsTBCfUyk0ruRqHvEiH5CdduLvAww5Wdw27roTiLMeLtlVIvjYwBvM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3b541d-bb15-434c-f29f-08dbc0ca1a52
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 08:57:26.3755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uM9C7CXPBoqVkjwcDqyF7dIFb4RZqS1Rd7TIVABgbaJt7K67khw6IPuaPxG8eRSK2WjtSRY6Eu5r8fja/Ly3HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4175
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_07,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290076
X-Proofpoint-GUID: tw3UeFNiHuWc1RoxdgSnTlfyJPy9Z9S2
X-Proofpoint-ORIG-GUID: tw3UeFNiHuWc1RoxdgSnTlfyJPy9Z9S2
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/09/2023 07:16, Boris Burkov wrote:
> To facilitate skipping tests depending on the qgroup mode after mkfs,
> add support for figuring out the mode. This cannot just rely on the new
> sysfs file, since it might not be present on older kernels.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Anand Jain <anand.jain@oracle.com>


Nits Applied locally.

> +_require_scratch_qgroup()
> +{
> +	_scratch_mkfs >>$seqres.full 2>&1
> +	_scratch_mount
> +	_run_btrfs_util_prog quota enable $SCRATCH_MNT

Some time ago, we stopped using _run_btrfs_util_prog() in favor of
$BTRFS_UTIL_PROG. The idea is that any errors are printed to stdout,
which is good. However, $BTRFS_UTIL_PROG has a drawback: it doesn't
print the command used, as run_check() does.



> +	_check_regular_qgroup $SCRATCH_DEV || _notrun "not running normal qgroups"
> +	_scratch_unmount
> +}
> +
> +_require_scratch_enable_simple_quota()
> +{
> +	_scratch_mkfs >>$seqres.full 2>&1
> +	_scratch_mount
> +	_qgroup_mode $SCRATCH_DEV | grep 'squota' && _notrun "cannot enable simple quota; on by default"
> +	$BTRFS_UTIL_PROG quota enable --simple $SCRATCH_MNT || _notrun "simple quotas not available"
> +	_scratch_unmount
> +}

Fixed lines above 80 chars long.

Thanks, Anand
