Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE725FDB58
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Oct 2022 15:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJMNqW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Oct 2022 09:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiJMNqV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Oct 2022 09:46:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5821311B2E6
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Oct 2022 06:46:19 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29DDguks004421;
        Thu, 13 Oct 2022 13:46:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=xxwNzTEP3tGWa94j/zx6ePvR1bwF1bkkBHuHRVyG7HM=;
 b=2X68IMhm+AGJ6ahpvk/HJtPRCAPJlvVQp0hRGA01bYPyb6Ze/eTmv+vz4Zuaslu/3EpN
 zHEkqSCPmcQpazmu9MGAa+h35N3H+yDPxde3JaF5sLsqyFDy6Ua6Lyz7/viXJV9mByvp
 4iS0hhwkVmO8O/+E+AGlMZb4vM0fy1Hlb60dKEIYEQ1hs1XYr6/wWwgDltQ292kybEXV
 WBNVOS9UK5a7jEl9z73imepEQlvYam54D8x+KHGimf0AgY8QNrjISVEToOit/thz9sSd
 TRZXdDkzWxdfuwQDf9UMNiEx1nJ8iXYFIm530DEPX2le4PpqFouV+J1uBh35/CkcX58C Cw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k31rtn8wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Oct 2022 13:46:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29DDC26Q033965;
        Thu, 13 Oct 2022 13:46:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn5rgw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Oct 2022 13:46:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kej8++uHx0SmSwL0NUyHtZWbEGMRiGi179XEisFBvweTJA51J+UzfCYWDMB6bcB0Sub7QPOd+BS9FB0HXHOcdiTPPAA74EGpi3RVZ9yGZbFpXDhCsyAopYouVcQasvmRX3yN/OwhcAlluchvdLjLYshKp7tbnXDS2mFDfTxTTA/PoKuoR2mv4A3ynSPGm5Ewr9V1ZQeYHn5fPIOfp0NfSHU5KDFFiTM4dZuzgqNtxewSm/VW2IUe83XSzdSvIvse1tJPqsUIscPS5vL8yL6e71hPAr8r4g+gATNMgLASdqG9bsnpfndrV56Uwu4ujSH6099Buzin9wXK+WC+xquXfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxwNzTEP3tGWa94j/zx6ePvR1bwF1bkkBHuHRVyG7HM=;
 b=jONg0GS79jwL9SuH/QCUgIxYhRZLQvtAn6bs6a/HGy0VG1ZHIJlfvRdGqIDHsK71wz2cTElpLU3bynAs/mXV1Zf+Py02pSPLdKSCuQ5kvQUFibl2mBoutD60CJix/VoO1Cp8uQLjCW4apCFH6bjkMnEasR+AhN0TRre2Ycl0nb/fFh/L/q2DwY5WkG6J7KAgJKD7O7VyWsU8wmumVxjtRRQ0tEg1Tw/AImZs7zWnhCAXvC5tUza1AWUA6ZkMAtl0BhbMHTXasTvLEx637vSOIPYOhnTCr1YQFLx3nRJV/UYEbdKG+Sq9dHqcvAAAKRSPLX2r5z37f1zQ1fWThu6z8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxwNzTEP3tGWa94j/zx6ePvR1bwF1bkkBHuHRVyG7HM=;
 b=uXMFsFN8z7MmE0AAT51lkVb4jmNClqxUG/mO1lZEyhIZOir43c5miWsIlNTnyGa+M7QtEOebjad0579iFG2Vnhv9vLBTzFb5UyfD8Y7w+KG5Rh8o2ZVsopIh2kpjgwn+UIZaXDCEqEIevYr9k65BRbHWW8YltSdAd8rDC3UQfOs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5976.namprd10.prod.outlook.com (2603:10b6:8:9c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.15; Thu, 13 Oct 2022 13:46:11 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a%6]) with mapi id 15.20.5723.026; Thu, 13 Oct 2022
 13:46:11 +0000
Message-ID: <65b15910-fe1a-b6d7-2431-4badcfa0b134@oracle.com>
Date:   Thu, 13 Oct 2022 21:46:04 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH v2] btrfs: make btrfs module init/exit match their
 sequence
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <679d22de5f137a32e97ffa5e7d5f5961f7a2b782.1665566176.git.wqu@suse.com>
 <63038e02-81fc-92b7-4e33-0a2c6c356698@oracle.com>
 <a2633456-dd2f-534c-6505-fa4c8121f3e5@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <a2633456-dd2f-534c-6505-fa4c8121f3e5@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d88801-cf5c-4093-cc15-08daad2149c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KAJISXJqbWt7TSAhymoNdRlkePakvwqsldTTwhz06yFnGLD3qsqDJuRFd+NaoYxDeQKfqC3PzWa/pqCkZLEbf2bZpmQ9SxAaEeVGxR/0+lD+dBsA6uO5E93hEqZAjIex0SdtoKTsTliALHeg1aQ0SN6WyppL/PLYQtSwNi4BjqQUe9dG2DvLibX8maEhPBglX5l+vPZVV8bzzsMbpCiwSWWiN1VRtBy+djAcPSumy+hXGHZT08nn0hsJJuwLh8Wmleh/c7J0pF29Uc9zvRRojNclllSafIG+0/zkgLNoFkLA4lB/cWAmabDm8vSODcPXJqIrHfwWVXY1k/HtLoaY837LOQuqep7KBqhVIZthfaxlMYCKisYMHSMkt66TQ6ILw0yla3Y0RkwP7Yv4Ad0xWe/MsPMaz3klhOaZ8EJuAfR24qPKqCpPN5964bdQ537rGga8OIrVcyia+LDMRMYUaPWnN0YXh7+qWImXYwoDYw3Sp9HAcV+Bl1XUjdMLK0bMn+y5SFlWKlCACJJh+k1Na1Ug0PBE1RQo9aflCx/HC0N101Hp8MnHs69zEASUOrkbWDqE4vmKuhib2DJM50fdec7triChRD5x5QTnr82EkE/ApMOOVT+Ji5ln8n148qefhNhNvjHkPNv5l8LM4t2XB55hGk2XuZeb9WAaZ7NuH/jNba7We/PV/LaB75j7+0Hon5x1ON7bHJNg3Oyb73cZ6sYzfpyguv6NUBKg4oGGn9M5AqlHrtCWxgPn3+hupMlkCQv5DTvpTr1PEOM6f8/Z6D2kH7mm5KC9YwqQEh9VxLE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199015)(478600001)(31686004)(53546011)(2906002)(6486002)(110136005)(6512007)(83380400001)(6666004)(26005)(316002)(44832011)(31696002)(36756003)(2616005)(86362001)(66946007)(5660300002)(186003)(8676002)(38100700002)(66476007)(66556008)(41300700001)(8936002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2VGUER0czJwRnZkRUZwd1hyRUdxRnhtZC9pVlJpTFJlNThsakxQVzNIMmN5?=
 =?utf-8?B?T2dQU3NhN0FLTHRDTUQ1d1JkcGNXUEg1RnlZUll1akN2eXFwVVlUV21ISGRY?=
 =?utf-8?B?TnhrVnZPWkg2UnIydkt4enhndWRvMU9vcWU5VWQ5S1BYY3FiU2V0c0NUVytj?=
 =?utf-8?B?NVcwdjFuSzVmcDdiQmZyYWM3dmRXalJUUWdVTnF6TGJDcDJnZm80QnJZMGtu?=
 =?utf-8?B?eFF1VGJqY0pIM2k0OFN6eTNIaUljV3NLZTlEc1BWSDZQS3E3cXpDZlE0aDNv?=
 =?utf-8?B?YTRzR0RDUEJYYzdBczZJZ0pBSEcraXRUbGVXMXJsT3hkaTFKN1kxMndwbFda?=
 =?utf-8?B?SHpXN244WWJpTnVEYytXZE1NNVNuTUYvZ1NySVJldzNncks0QWwrVkVMb2lM?=
 =?utf-8?B?eE01ZXVmSkhmcnd2dWw5QXVRc0NJakhMeXFHZXFuYXdYT2t6dERmK0hnYVJL?=
 =?utf-8?B?Zk51ZC9nTFA0Rm1DOTllcDFMOUU4NDQwSWpGOTFnMmR2YldlV2FsREVUVmJq?=
 =?utf-8?B?bGRJQVVqNFE4U1haN0p0UVB2Z0ZNWE02cC9QT3RoTnk0eXdNTENTWkJMWWlO?=
 =?utf-8?B?WHhGcC9KNDVYSi9keTMyVzBKWGlvUmhBMkdYb0ZPUnk0ZXJxcnNGRWtMNkZs?=
 =?utf-8?B?R0lBVHBkckdoc2ZXR3EybGlKaGhOa3IxS2F4NUxpWERSbEJhQng5NVlpdzcz?=
 =?utf-8?B?Z1kxT1F4MElGOWE4aEU5Q1NSTGpRTUtITm1Kcis3Q3hwYnB3cjlZUTRtQmpR?=
 =?utf-8?B?WG5IeGxweS91OFhjNjJHSHFVSThzRFRFUUNjclE5dVFRSFNzMkpYM2JzdENs?=
 =?utf-8?B?MCtUTy9rVVhLSFd6bHZEOCtKenVvUkZXTzVjWUovMVczaDJwUFNnakdxZVYz?=
 =?utf-8?B?N1BySS9zKzdJNHVGTG1pbVFPYmUybWIvdnBrWS9FTFVzYkhDbDlxcmJIdVc4?=
 =?utf-8?B?RFRYWnJCcC9Ga1pzcXhTNmxtY2VlV2R2cUcwa2gxN25rQytWaklOSnNsUjhL?=
 =?utf-8?B?QWliWVRDMVNrZjZ5VmRibFMyRXhpNW9Pb3BZdVBPVTdaVDExSmtyL1pkRmdh?=
 =?utf-8?B?L1Z4WllXK3luTkE2SU1IZzZUSEJCZGVSdzRmTFpIVFZma29VcDVBQzBnRkFm?=
 =?utf-8?B?VkVkRFJrV0N6WC9oOGtYaEgrK01mSzdqOTIyTFFtN0puNmJpd3NST3ZZWkdY?=
 =?utf-8?B?V25HWVdMS3lnR1Nyb05YZm5uRkE0amlIamJ3anhFUXFFRmM0eUZLM3NsUmtV?=
 =?utf-8?B?dDVZZFE3SHlBaG16QXBxSnNYVkxUd3d6YS85T3dra094STRiU0FYdURoYjJJ?=
 =?utf-8?B?ckJJYU9PSlBUcG55YkJXTlN6cGx5blRqVDN3MmRPUjk1NGs5elR4V0lzZlZq?=
 =?utf-8?B?SjMxZElWNjl1aXN3cEpNcGZsU0pnL3o3SnM4SzJKV2IyTkdQaVZPbHJVSSto?=
 =?utf-8?B?Vmoya2dSOFg2UlpFcHN2RUg1TVhCNWFXVW1BNEtzcXVYcC9qQW1yckwwS1FF?=
 =?utf-8?B?M1RIaUxvdWEvUE5wbnlVVmkwcGZZZEJUUjZSSjJWN1NtOG00c0tqQlh2djl5?=
 =?utf-8?B?QWN1TEJYZVFPQWpiK0RUaWNZK0pOTm4zK0pORm1sYUZnOTM4RXlWbEx3R0g1?=
 =?utf-8?B?ZXVmVWx0WWcvYStoR1c1TkVGMFFwVjAzc2RaemxtN2p2ZHZHaGZxbi92d3dH?=
 =?utf-8?B?MlMwT004Mk81RnJ3VE9KWU9yT3diWmV6VUVMVjIycmFsV1hoTWI0OGIrbGlE?=
 =?utf-8?B?M0FhYTBXSkN2dnFiR05oODdVOTRQWUtWd3M1N3NzajdGUStPYjJKU2RUN21N?=
 =?utf-8?B?OTJjOEIraXFybzk1ZEFXdm4ybmg5bklZL3dkWDBiOVU1Y0YxWDN4VEJoRTNr?=
 =?utf-8?B?Ti9nSk82R0xxa2VLcXU0MU9aYkdpN2VnaTQwUEw1VGoyZzZnZ0VDTFR1WCtW?=
 =?utf-8?B?MmpONjk4V3FVaUp6U2pUY3hXTklndFppZzZUd1NQa2RzMGFpcmZNU3k0SVhw?=
 =?utf-8?B?S2lManVRQUllaC8ycmxISkxOZ0pCa1BNWHlPUVVaNnVnYU1iOFdCd2RoY0Vn?=
 =?utf-8?B?SStSaDBTaVc3eTRzSUFTU3lPN1hnSXdaTVhZMFMxVTdtMGNsdktyaDBMOEo4?=
 =?utf-8?Q?y++bHH6CeOib8MC3ZUfNGlERJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d88801-cf5c-4093-cc15-08daad2149c1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 13:46:11.2762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HsPZ89z2n10GiyzpF/uDlC2lXhid7Kl1R8wXCZdnqmqQFyKpKcClALO3c9bdUVyy+RdsyPGMqLuFJZXJAskhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5976
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_08,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210130082
X-Proofpoint-GUID: 8bAB_gGTz5rG9S4kZ19PXxNsTI_fxtd6
X-Proofpoint-ORIG-GUID: 8bAB_gGTz5rG9S4kZ19PXxNsTI_fxtd6
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10/13/22 14:44, Qu Wenruo wrote:
> 
> 
> On 2022/10/13 14:03, Anand Jain wrote:
>>
>>> With this patch, init_btrfs_fs()/exit_btrfs_fs() will be much easier to
>>> expand and will always follow the strict order.
>>>
>>
>> Nice idea.
>>
>>
>>> -    btrfs_print_mod_info();
>> ::
>>> -    err = btrfs_run_sanity_tests();
>>
>> ::
>>
>>> +    }, {
>>> +        .init_func = btrfs_run_sanity_tests,
>>> +        .exit_func = NULL,
>>> +    }, {
>>> +        .init_func = btrfs_print_mod_info,
>>> +        .exit_func = NULL,
>>> +    }, {
>>
>>
>>   Is there any special reason to switch the order of calling for
>> sanity_tests() and mod_info()?
> 
> Mentioned in the commit message:
> 
> 
>    Only one modification in the order, now we call btrfs_print_mod_info()
>    after sanity checks.
>    As it makes no sense to print the mod into, and fail the sanity tests.

Oh got it. My bad missed it.

> 
>>> +static bool mod_init_result[ARRAY_SIZE(mod_init_seq)];
>>
>>   Why not move bool mod_init_result into the (non-const) struct
>> init_sequence?

Any comment on this suggestion?

>>
>>> +    /*
>>> +     * If we call exit_btrfs_fs() it would cause section mismatch.
>>> +     * As init_btrfs_fs() belongs to .init.text, while exit_btrfs_fs()
>>> +     * belongs to .exit.text.
>>> +     */
>>   Why not move it into a helper that can be called at both exit and init?
> 
> IIRC the last time I went the helper path, it caused section mismatch
> again, as all __init/__exit functions can only call functions inside
> .init/.exit.text.
> 
> Thus the helper way won't solve it.

Really? Maybe it was something else because, I see it as working.
As below.

---------------------------------------
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 2356b744828d..0c48bf562aa8 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2791,7 +2791,7 @@ static const struct init_sequence mod_init_seq[] = {

  static bool mod_init_result[ARRAY_SIZE(mod_init_seq)];

-static void __exit exit_btrfs_fs(void)
+static void btrfs_exit_btrfs_fs(void)
  {
         int i;

@@ -2804,6 +2804,11 @@ static void __exit exit_btrfs_fs(void)
         }
  }

+static void __exit exit_btrfs_fs(void)
+{
+       btrfs_exit_btrfs_fs();
+}
+
  static int __init init_btrfs_fs(void)
  {
         int ret;
@@ -2812,26 +2817,13 @@ static int __init init_btrfs_fs(void)
         for (i = 0; i < ARRAY_SIZE(mod_init_seq); i++) {
                 ASSERT(!mod_init_result[i]);
                 ret = mod_init_seq[i].init_func();
-               if (ret < 0)
-                       goto error;
+               if (ret < 0) {
+                       btrfs_exit_btrfs_fs();
+                       return ret;
+               }
                 mod_init_result[i] = true;
         }
         return 0;
-
---------------------------------------
