Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67913652DAC
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Dec 2022 09:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbiLUIIy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Dec 2022 03:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiLUIIv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Dec 2022 03:08:51 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3AE62D7
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Dec 2022 00:08:50 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BL0i523030236;
        Wed, 21 Dec 2022 08:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=lb0a3za2xgDITRvSItPUMBpZYQ8y3P8rkOx4qUsI+L0=;
 b=oDEGnbGsUgcfa7ZIgDrVll0Zv+7hC2ZySoHWxErgIj+0VEBc7YJ2qu0JzpvNq8Uz53Rt
 e3zTAgV+avJ069VxgD5mLZp5FA9Lp0rTuvgg/5Kgdmt8oJ2uQ49OuV6ZXpuutwSUaFvW
 jrbXnOAbhPz56hxmuAzNZ89QNoJSarW1Zfcc+WGWMCWc5Yo6la+E9TXriexp1139SNsc
 gnzXvvWVIwOd8aoWwur94OdHHeGOJyw5rdgOekeI3ACyEgqksMGd6PTw+r3Hkj+0D7XI
 j39ULya51dK84w9mmCnY5+ASojVNQIZRs4+629GITAGxhRROkMuUEq+pS0BI/ht2Gjro lA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tt09kr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Dec 2022 08:08:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BL709NE004611;
        Wed, 21 Dec 2022 08:08:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mh47ck703-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Dec 2022 08:08:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUasHyp1zp8VWYhc+6OvmUF1MX9uPEUevm97dpuwF+FcLpuBFu6PYwcxgia/ZZjp8Fwx62zlvM8i4VVi44zkn+YMClEZj+N82n4GWTeT4htMiMrQlEM5V9G2OjD+qvlLP8kuIHqtYiJqbjIX+k/dvR9fRU0KQdvEmSLKxZj2GX9hSXljo79lsTuwHureImovTcy4WJA38GnRqVMMesglTdPGtZX1vr/9vITWEYyDD6ZGymniIPhTLF4HODY1xzANczr3XYvg9Gd4NfcuBnzHBkA2LZ7YhjOvctnlVWL/6RULgXyokmbXATpuKKdnEJdKc7HvaOFvOmQYdQjEvkqrrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lb0a3za2xgDITRvSItPUMBpZYQ8y3P8rkOx4qUsI+L0=;
 b=hurUBIo3COQ6kaxeJ78SOA3uR4XVRtrOGI3GAFpd4h1zqcKQZbeopzCiAdi7/AxzPN0DOsKP/WsrSBPg7yTW6CYMmDz+J7DLyLk1ibF7wGAI5XNs3fl5zgcJPBdnRLmh6M7GO0vHkUUf6cSBxhLgAWYGNJtpTsFsTiYU/8FzSNN4WZNMQl89drhE+1zyDVLNFeRwhkShhEKv/3QZLzAkcPr3gO3K/75YC6vR0raWJ509aZgGIRu9kVjrxDvZbq+AD6TLbn4076HWkA3/SSNX8VvpzQA6YhF4NdsmskCMvHNQIBBFboVR1iMZXi/jdy1JisJ9OZnyzoNPFwtn/uNmMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lb0a3za2xgDITRvSItPUMBpZYQ8y3P8rkOx4qUsI+L0=;
 b=OceMCRcYAbeKvF+mTzH0Aueuo6uJalq1h9GnOHwwOwXO35j3qnnvmUGwYPxs65znFymVeLaAroAxO/c2dfbgJCcyIPxYdb/LdaVrIwioDEfUwpVA280CUsBWQ2BQLTpHpefYiDnSRVT2ogCIjscj65QPd6r/yeKZsMeRjNvJJ70=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4734.namprd10.prod.outlook.com (2603:10b6:a03:2d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 08:08:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65%8]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 08:08:42 +0000
Message-ID: <a54879d4-a1e3-32f6-fd6b-6b76fc8f0192@oracle.com>
Date:   Wed, 21 Dec 2022 16:08:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] btrfs: fix compat_ro checks against remount
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Chung-Chiang Cheng <shepjeng@gmail.com>
References: <8ab95b9b1469cf773928e720a9d787316dfb44bc.1671577140.git.wqu@suse.com>
 <aba9f83d-76f2-48fe-1819-bc405cb7efdc@oracle.com>
 <a0618e92-ba6b-d598-fa46-29b6f8115b46@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <a0618e92-ba6b-d598-fa46-29b6f8115b46@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4734:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e12d98b-0b99-4084-1f64-08dae32a932d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IXdPLfom2U7ELGU8b2rdW0auMQT6Ediy2l9RGyM3Qw+4jZD3ayI8kUOzZnKQREacVEnrYaI+SJMXg8FYcasTp6jd6scBmu4GaPfGqftghdmkQ80BAL/uusTyNGl/o9lGe47r369vbRQbMOQIv9C/tgVpaRiClF672PFKM/Ybq0PGRc5Xu1++DL8ItpT/3KsRZIfQJ99S9ZeDN6RcUnlKVE5EI2vFia7U2CPv6XyzkuPBvuurcZlcT19OsTuhkca2Mt0zA4679J0BUqMrGND3ZtF/q8vfLs6EpM+y1Yspk0DbIG0L3FDIA+XdeEiAszGx/QQVjZNUrCPDr77Q/KWef+5O9j0FBQQpx3Ig76GiiYy40L1qawKB1hqWaeO3aLQRgLxOecTc/mrD+UBnoEW7a6GNbfzUA4iuivjEQBhXIpbYH3fstJN+Pq7fwF1I+vMZ6cKxxLKky6/KE56Z6MddIw2mbyOm6Cail8cQvANhAuy967L4kNFm87Yli6aNS8t9igDM9GhXLQiIzn+DuL5gAH+5PvN4ELZ+piDjfu83389R0y17OBqIngiB3IBsOg1dMvI1RmQSu5Nmih+qb5h3qGC+VlDRf+F5eaDVOQ+ll5AngBhvjKxZ0NTL4z8qYLsfBJrJuZN0pgd0OGtoGw/9cy8V6D0enn5E1DbeTvZcH/WxXrCnCz3nSFzMHqPfmVHUKrXhXd0Y1yDLJpM+qNJfJoII58YK03QG786rqYmwow0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199015)(36756003)(316002)(6666004)(53546011)(86362001)(31696002)(110136005)(478600001)(6486002)(8936002)(5660300002)(66556008)(8676002)(66476007)(66946007)(4326008)(41300700001)(2906002)(44832011)(2616005)(186003)(38100700002)(83380400001)(6512007)(26005)(6506007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2NISCtMOWEwRlNncUNVVSsyaUZTWFFmMXRCOGdlSEVhTmc4T3hUbXIwcXNL?=
 =?utf-8?B?bzBjNzE4V3BmRG54ZE1hN1lBekJDelBxU29Za1Y2cndlSGdhc05MVG1SbVdv?=
 =?utf-8?B?b0RUY1ZDVWlCbXNTODdrbVdNR2J2UHcyM1lmdE1aUFU4L2tuNklzZVBLU3Vp?=
 =?utf-8?B?N0loUUVZSXo3REMvMVFaQlBRWEQ4ZzV2U2hQZ0sreHdxUTdaTmFqUkRrQUU4?=
 =?utf-8?B?c2o1dHBmaXcycWdzdVFtcGxBYi91aCs2YWFUU0VKVWIxZmFKSXhDNGIvR290?=
 =?utf-8?B?cU4yUU5GOXJIajM0ckZKM0FFcmppZFhoSE9qREJWTmxrcW5ySTlJaC9rL3pB?=
 =?utf-8?B?SGJkTzViTUxVZlVHb3FCNWpuTW5YNkxyZCtIbU1NM3ByQlU4TGhxNTFweDQx?=
 =?utf-8?B?NitiU2d0cE90MWdIY2FYUmREem5FK3Y5RWZtM1V1WVNZUHNUeUs3cVdxUUJY?=
 =?utf-8?B?UjNIRk9tYkN3VWxIVXlQQ3BRU1RLUnBmd3hCdS9pVzE2RFFLTkVNQUZuMVli?=
 =?utf-8?B?ZkQvcnNKRU5QZ0VDN1FGUWJUZEY3aEw5dEFjd2hUQjB6NFc0czJJd21QZWJh?=
 =?utf-8?B?cWR4eFJKVzlrc2M0dVlKWU1qT2JCQXdqbXNmVi80VUJWMk9LVW0vYmFjSlhK?=
 =?utf-8?B?ZkFYNFdFN0RIRkcwOW42SDlSK29pblhBd0xpWURFSXBVWFQ4OTlXU2Vna1dr?=
 =?utf-8?B?N3dqNGIySVgxaTgzNjRsVTB2R3F4bmlmTHRMYkphMXlVNWhrUUhoK3VneFlt?=
 =?utf-8?B?bEtsSUJhTFVKOE5mMXdFT2JnWDg5ZnBoVmxjaUhESXVSSVl1Y3NPYmhWbURt?=
 =?utf-8?B?MXhQekIxMmlPNU1FLzN0MFp6YS9XcVp0WFpkc2NDdGc4RzA2SmJ6SVA1OWpw?=
 =?utf-8?B?VzdDWWVmajhmWDdPWG1qZWtQeEdLVW9NRVpHa2FOT2c3WS9UWXcrTlMyWk5Q?=
 =?utf-8?B?YmdUS3FCZENWOG5XcU91enYzYnhpUXJvL1N2anpyS0svd1lRbG9sTForck1q?=
 =?utf-8?B?Q1lwUUVERkQ1VGloSEQ1emlBSlhudFpyd0E4Tm9PNTJDSzNtMkIzd1kvOEYr?=
 =?utf-8?B?ZnFoZ3BGOFNTMEEwWHBISHJIYXRTeWlzOWJodExuU2NJbWxCbHIydWdPWmJH?=
 =?utf-8?B?NGF4ZFI2TkRSTm5ZcFFLV3oxVC9LblFRa3NYTzlMUC9NZUNFWURVbzFLWERS?=
 =?utf-8?B?bUVTR0pNaUsvUmJ1aENLNkRRdVNtclRUNGpoczRuMU9yVjdjWnZ1U2hnN1JE?=
 =?utf-8?B?RlBYWEYwVTlBT2NOUElHZG1HcXAvSW1NLzdOek5WZ0R1b0Fqd2tMTUsvMDRz?=
 =?utf-8?B?MStIVnlBZVNSOHMzSkZBeUNkTTZHZ011UmFHSktPdmdjT2pTZHFiMi9Za1kv?=
 =?utf-8?B?R3daR2pHeDJMOTRvd3NGd2t6cWhKekw0VmpYZUJyUDFXZnR5MnpibkNzaUho?=
 =?utf-8?B?NklRdHFNbks2UE8wUWcyVGl5Q2tVRk8xWDRwU3M4bnJFNHlZb2p5REI5QUI1?=
 =?utf-8?B?d2VWSXlnS2VzUjlqb212dEhnb2xTRmk3SVhOMWhrY3k0a2lOU2I5dFpEQVAv?=
 =?utf-8?B?RmxXN1h0S2hlSHRyaklIeGw5M3NURnlJSnl2a0hzZ2FoS1dhMzUyOEVqSUs0?=
 =?utf-8?B?TWNSZ1NaWk5qejR3K2NSRERaeFlCZU5DNVUxZUZ1Ylpnc2FmQmk0VzJVazJu?=
 =?utf-8?B?MXFCc09ENXZOdlJ1dWhSZDhyYWRmYzNKcFBSYSt0eHcvbUFqVEtKZHhZUjlB?=
 =?utf-8?B?RVBydGxuNUl6b0hPL0k4TWtyaUZTTE1tbFBKRjJYaGp4RnVzVUtRVlhsdGRi?=
 =?utf-8?B?OUVhcGwwTjMrTW5oY2R1VkkzSWZtM2YrNUIrVzJ0VnM2ak5qTHUrb0xabkhm?=
 =?utf-8?B?UUxnVFBrMzlzSDZBN3pQc2tyS0d2SjhWQ3JweXlKbHBrWjh5OHdvcGcycjhZ?=
 =?utf-8?B?M3FwYjdPVXpOdkxKeUV4RjNjbWdqaGcxMFRKcDMzMFRkb0xDTG5KK29vdU9h?=
 =?utf-8?B?U210emFHb1pUU21NUFhXcHVYc0laeEdMRFBxZHZPcHRtOWV3cExVY1Ayek56?=
 =?utf-8?B?M0tPbkZlbHpyVTI3OEhCNHRKNnRjM1VPNEYwSmp3cGNRVVpCNGlzbml3d1F2?=
 =?utf-8?Q?O1Ox5IFpybXZJxenXOgtiZAEs?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e12d98b-0b99-4084-1f64-08dae32a932d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 08:08:42.6653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivOnlzigs0nq5iO7c6SIX4CpWM9JrFBcvdmzURtMcx8QIvAjhlnq3qJjTTG3ByKi2GeglrgcmPAmZSZ+soLA2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4734
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_03,2022-12-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212210063
X-Proofpoint-ORIG-GUID: JvT3VBjG4KlBjdN335HRsdtdnpRIrg3E
X-Proofpoint-GUID: JvT3VBjG4KlBjdN335HRsdtdnpRIrg3E
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12/21/22 15:59, Qu Wenruo wrote:
> 
> 
> On 2022/12/21 15:56, Anand Jain wrote:
>> On 12/21/22 07:16, Qu Wenruo wrote:
>>> [BUG]
>>> Even with commit 81d5d61454c3 ("btrfs: enhance unsupported compat RO
>>> flags handling"), btrfs can still mount a fs with unsupported compat_ro
>>> flags read-only, then remount it RW:
>>>
>>>    # btrfs ins dump-super /dev/loop0 | grep compat_ro_flags -A 3
>>>    compat_ro_flags        0x403
>>>             ( FREE_SPACE_TREE |
>>>               FREE_SPACE_TREE_VALID |
>>>               unknown flag: 0x400 )
>>
>>
>> I am trying to understand how the value 'unknown flag: 0x400' was
>> obtained for the 'compat_ro_flags' variable. A crafted 'sb'?
> 
> Yes, crafted super block.
> 
>>
>>
>>>
>>>    # mount /dev/loop0 /mnt/btrfs
>>>    mount: /mnt/btrfs: wrong fs type, bad option, bad superblock on 
>>> /dev/loop0, missing codepage or helper program, or other error.
>>>           dmesg(1) may have more information after failed mount 
>>> system call.
>>>    ^^^ RW mount failed as expected ^^^
>>>
>>>    # dmesg -t | tail -n5
>>>    loop0: detected capacity change from 0 to 1048576
>>>    BTRFS: device fsid cb5b82f5-0fdd-4d81-9b4b-78533c324afa devid 1 
>>> transid 7 /dev/loop0 scanned by mount (1146)
>>>    BTRFS info (device loop0): using crc32c (crc32c-intel) checksum 
>>> algorithm
>>>    BTRFS info (device loop0): using free space tree
>>>    BTRFS error (device loop0): cannot mount read-write because of 
>>> unknown compat_ro features (0x403)
>>>    BTRFS error (device loop0): open_ctree failed
>>>
>>>    # mount /dev/loop0 -o ro /mnt/btrfs
>>>    # mount -o remount,rw /mnt/btrfs
>>>    ^^^ RW remount succeeded unexpectedly ^^^
>>>
>>> [CAUSE]
>>> Currently we use btrfs_check_features() to check compat_ro flags against
>>> our current moount flags.
>>>
>>> That function get reused between open_ctree() and btrfs_remount().
>>>
>>> But for btrfs_remount(), the super block we passed in still has the old
>>> mount flags, thus btrfs_check_features() still believes we're mounting
>>> read-only.
>>>
>>> [FIX]
>>> Introduce a new argument, *new_flags, to indicate the new mount flags.
>>> That argument can be NULL for the open_ctree() call site.
>>>
>>> With that new argument, call site at btrfs_remount() can properly pass
>>> the new super flags, and we can reject the RW remount correctly.
>>>
>>> Reported-by: Chung-Chiang Cheng <shepjeng@gmail.com>
>>> Fixes: 81d5d61454c3 ("btrfs: enhance unsupported compat RO flags 
>>> handling")
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>   fs/btrfs/disk-io.c | 9 ++++++---
>>>   fs/btrfs/disk-io.h | 3 ++-
>>>   fs/btrfs/super.c   | 2 +-
>>>   3 files changed, 9 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>> index 0888d484df80..210363db3e2d 100644
>>> --- a/fs/btrfs/disk-io.c
>>> +++ b/fs/btrfs/disk-io.c
>>> @@ -3391,12 +3391,15 @@ int btrfs_start_pre_rw_mount(struct 
>>> btrfs_fs_info *fs_info)
>>>    * (space cache related) can modify on-disk format like free space 
>>> tree and
>>>    * screw up certain feature dependencies.
>>>    */
>>> -int btrfs_check_features(struct btrfs_fs_info *fs_info, struct 
>>> super_block *sb)
>>> +int btrfs_check_features(struct btrfs_fs_info *fs_info, struct 
>>> super_block *sb,
>>> +             int *new_flags)
>>>   {
>>>       struct btrfs_super_block *disk_super = fs_info->super_copy;
>>>       u64 incompat = btrfs_super_incompat_flags(disk_super);
>>>       const u64 compat_ro = btrfs_super_compat_ro_flags(disk_super);
>>>       const u64 compat_ro_unsupp = (compat_ro & 
>>> ~BTRFS_FEATURE_COMPAT_RO_SUPP);
>>
>>
>>> +    bool rw_mount = (!sb_rdonly(sb) ||
>>> +             (new_flags && !(*new_flags & SB_RDONLY)));
>>
>> The remount is used to change the state of a mount point from
>> read-only (ro) to read-write (rw), or vice versa. In both of these
>> transitions, the %rw_mount variable remains true. So it is not clear
>> to me, what the intended purpose of this is.
> 
> If rw_mount is already true, the fs doesn't has unsupported compat_flag 
> anyway, thus we don't really need to bother the unsupported flags.
> 

> The only case rw_mount is true and we care is, RO->RW remount.

  Have you tested the value of %rw_mount in the secnarios RO->RW
  and RW->RW? I did. I find %rw_mount is true in both the cases.



>> -Anand
>>
>>>       if (incompat & ~BTRFS_FEATURE_INCOMPAT_SUPP) {
>>>           btrfs_err(fs_info,
>>> @@ -3430,7 +3433,7 @@ int btrfs_check_features(struct btrfs_fs_info 
>>> *fs_info, struct super_block *sb)
>>>       if (btrfs_super_nodesize(disk_super) > PAGE_SIZE)
>>>           incompat |= BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
>>> -    if (compat_ro_unsupp && !sb_rdonly(sb)) {
>>> +    if (compat_ro_unsupp && rw_mount) {
>>>           btrfs_err(fs_info,
>>>       "cannot mount read-write because of unknown compat_ro features 
>>> (0x%llx)",
>>>                  compat_ro);
>>> @@ -3633,7 +3636,7 @@ int __cold open_ctree(struct super_block *sb, 
>>> struct btrfs_fs_devices *fs_device
>>>           goto fail_alloc;
>>>       }
>>> -    ret = btrfs_check_features(fs_info, sb);
>>> +    ret = btrfs_check_features(fs_info, sb, NULL);
>>>       if (ret < 0) {
>>>           err = ret;
>>>           goto fail_alloc;
>>> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
>>> index 363935cfc084..e83453c7c429 100644
>>> --- a/fs/btrfs/disk-io.h
>>> +++ b/fs/btrfs/disk-io.h
>>> @@ -50,7 +50,8 @@ int __cold open_ctree(struct super_block *sb,
>>>   void __cold close_ctree(struct btrfs_fs_info *fs_info);
>>>   int btrfs_validate_super(struct btrfs_fs_info *fs_info,
>>>                struct btrfs_super_block *sb, int mirror_num);
>>> -int btrfs_check_features(struct btrfs_fs_info *fs_info, struct 
>>> super_block *sb);
>>> +int btrfs_check_features(struct btrfs_fs_info *fs_info, struct 
>>> super_block *sb,
>>> +             int *new_flags);
>>>   int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors);
>>>   struct btrfs_super_block *btrfs_read_dev_super(struct block_device 
>>> *bdev);
>>>   struct btrfs_super_block *btrfs_read_dev_one_super(struct 
>>> block_device *bdev,
>>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>>> index d5de18d6517e..bc2094aa9a40 100644
>>> --- a/fs/btrfs/super.c
>>> +++ b/fs/btrfs/super.c
>>> @@ -1705,7 +1705,7 @@ static int btrfs_remount(struct super_block 
>>> *sb, int *flags, char *data)
>>>       if (ret)
>>>           goto restore;
>>> -    ret = btrfs_check_features(fs_info, sb);
>>> +    ret = btrfs_check_features(fs_info, sb, flags);
>>>       if (ret < 0)
>>>           goto restore;
>>
