Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D869D4CBE1C
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Mar 2022 13:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiCCMrr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Mar 2022 07:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiCCMrq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Mar 2022 07:47:46 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF2A184B55
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Mar 2022 04:47:01 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 223C1e7L009253;
        Thu, 3 Mar 2022 12:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=txdMcXWrTpuET75wGmTvKyr298JR0uEKrkCljqlRSew=;
 b=V7xnxXyfgBdVGyf+0PmP8aJGBGybOc1RUMuzkVhFd3Hhll7WAAWuO003R2mIsOSeui7n
 uKoljwEaLM6N1JZXS71gdzW3bKL+d/98qZdlBuHQduQa4gh2mT9YHCiyJK63y0cubRKv
 dGpBAySfe/yqbGCqhVH09hkgDRWpFwmV+Ew4MVr3DelV5LTeRj9KCgXlrWC0KovHg/mr
 R9PEd+2B0u+wfEfrBTSnxf3HnwCIRNlBBs/6luLMRqL7bbL0YgT2jQIp4oByP5e+9+gW
 v+BgjbtiRDNcdQOehsnSTERj5uL9Y+2BhGQbixKPKjq3vXhjXSjBLDnbdF/TBOX4z0qT Tw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehbk9f97f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 12:46:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 223CWLrM095271;
        Thu, 3 Mar 2022 12:46:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by userp3030.oracle.com with ESMTP id 3ef9b3a2jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 12:46:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnWHLxRtAQ4S5dF11A01GWP/Uc7grt5N1I/ahprdyp2TRQeLM6soyvQaroaas7t8+7SEAVY8ZHNNCcndgCdflavMQlmYIN0FySZmqq9C3YEMhmiWb+fkJopGGnUAv5E74RESO0lIr4HQ5xdFq9+sEO25fIue8zZ5VZmFV1LygeqwiJgbQDoKgIBbBWmgPDCU22cUX/rks4Hw3WJzgzdL9lzRE501zSzq89AZ8gMqDXg5/hGD9iiU7F/RCt/LRAzCu/dRxdVETlHVALaEh35s478bO/HuZU7Vnx0M+9zJf7tx7+oDFZUoTwx8sFxwpJvqXOB3WL8/TMlKwHFnDUWl8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txdMcXWrTpuET75wGmTvKyr298JR0uEKrkCljqlRSew=;
 b=cak8QM+sAa236x/YU4Wme/tATA4uzQP1mF4OnWdwTsIMgc8XfOS+P2Tqo2tWiJpJkXxwMXmsTQkQ10/Bo3MkeXBRC/W4sL6k4ik4AmRo0VPcwhWCkB/KbLOgJfyaMlyZn5EHH5Waf8aJTdrRH09EoHI5qWacVU3xWe6Ppk7Gt4NOyrJPOqF0MoqIfq0gPHiOhubDrMSPFL0lB9b9t15UZJtBJh+MGzDCMcps1/nGMcbGkNRSd3LIcF7uV+hDxVQifCF3eutUnOY1sbx0Hn+JEEFpNp+ObrOyqrBvA/koAm3p9KkBBAHVxVQZwHf5Qt+nArm8HPo7gDzRdTTIBgpRJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txdMcXWrTpuET75wGmTvKyr298JR0uEKrkCljqlRSew=;
 b=U0GJIHm07BsthijiRVDr2iBD+4zMdNIu3khMJ8Eg1wGI4OrPbRs63EUT1Jru7uKegcW1X5trFVMpY2MhqaUNqG/zdAtP34EpXwnIruh8xaeI3ndsiRTuWStalsWHUkOt8qDHBMGJ2OL6d2cdwlBzYV4yKA56bEk6tNHgy5elwSk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BL0PR10MB3075.namprd10.prod.outlook.com (2603:10b6:208:74::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Thu, 3 Mar
 2022 12:46:52 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f%6]) with mapi id 15.20.5038.015; Thu, 3 Mar 2022
 12:46:52 +0000
Message-ID: <32810467-bf93-d9bd-86eb-1fc313962198@oracle.com>
Date:   Thu, 3 Mar 2022 20:46:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] btrfs: fix a NULL pointer dereference during device scan
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <f0a7cc9b024432855337990f471b91054504cc92.1646306515.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <f0a7cc9b024432855337990f471b91054504cc92.1646306515.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0192.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e91ae825-8a75-499a-25ec-08d9fd13e3d4
X-MS-TrafficTypeDiagnostic: BL0PR10MB3075:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB3075F2ADD1EFC4CEA087B54FE5049@BL0PR10MB3075.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +QDbv434sBI+n7FGe6EE9KBt7SWW8Km8fLbetK6zoYBFNEKwtxQhUPoMF5EOz+nSCnluBjZiH31dF7UtAwRZCkefLiJjgm7rNKNQ+uehqkqlVtisuclv3RvFcSC2H1nVXl5NWbr0R+U+gjn7nt/6fouVxm8vsti85jnuwXefwFuE2MgB5mb4GaK2BjUD5Bt4WvhP0kpej7Vkfm3JXJai2X3s3ABWb+Mu19TmKoUhZe66sh0Sv8mUTPQOJS5RFdzCFzB7e9ACvaUxq6k/TwDaLOmT1LffklBIjKwSpDGdqb5558ZMCk8A1Xo2Um0x1obknmePwUGRjK+lXGQxHXSwG3DigzvidQqv4xy2QtiXTuYWm2R42byDzBDFQ+5XcJN9cD1+fGSbJaw1dAZ5zeRm5+0xMU65gzuHL4pf3Z+6D31yIu7qhBPdMREjYo5wmKyFAR/f3t8jlsmruLyxwMeb93evTaW/DQOGfv/3UICWK8Kbzod1/6vZ5TjBuVGjAMZC+nl1ytTL8KMikohmye5aXEb2j71/xoPRcnctN04QX6mn/ZYXn44DqqM/nPxcIenFSUQKNbtwCxZbkuImbxkeBhWqSnKCXfj487MDcPeY28NmlzFWDJ+hRL2thHa4AHdZFrNgQviyj/SRIp2ZkBmBpragpP2YOPAnapTbWxMoDaOThIhG/5WOHh3Q/fYO8YItlbL4oV8xiiGxSBaFheT8nl4YQpEDD5lMjdlcjDGdVQE/eX6ul9scXQC9dX9L+zhaw6RR61YYNOSgPZSSA3fLvE7b/98dWcitPcAL2NV1IKVA7ynRoOceWEv97qDc+LDM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(38100700002)(26005)(186003)(5660300002)(36756003)(31686004)(2906002)(44832011)(8936002)(508600001)(66946007)(66556008)(31696002)(86362001)(6486002)(966005)(66476007)(6512007)(53546011)(2616005)(316002)(8676002)(6666004)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVVrcXRMOUFZekVVWlJOUHJ0NHB1NlN2dXU3RnNkWVRJUXRmc3RrODJ3UlJ4?=
 =?utf-8?B?ZTc1cy9LSW1sUlVVREE3NVVrb1hFaUU1dHQ5TDgySS9nQ29Ra0FwSk4vNk5z?=
 =?utf-8?B?cjYwOWpPd2EzRlphem44OVNDYVF4dllVWitYM1RpTnZmeDJZY3E1ekxKYWgw?=
 =?utf-8?B?L0d6Q2sya0NkdWgxZFlyOWVpRmI5bWwzSzJKUFpuRHY5enhDMUE0c05GL3ox?=
 =?utf-8?B?M2JLTTJTT0dVdXRkOGQrVVMvR29oWDh6NllZTlk0VkMzVXdjTCtrV29WU0R3?=
 =?utf-8?B?RGtZWEpSL05Xdm5pTmpzQ0Y1aE1tY0ovczVtVE42Q3k0bHlRNkNsc2NoamxK?=
 =?utf-8?B?QVBoeE5oWEtRejdHMUJZTCtDbmtUOU5YNVhPbituZS9sVnRlVjVNVCtZRGl2?=
 =?utf-8?B?RXdBQ1hNdVVwT2VTd2tKVjltZnpaNWxwTXRpWXJwNmpmVmRLSm5CaTh2bGMw?=
 =?utf-8?B?bjhSYnlIRnF5TmVzd01wMUxTODM3dTRybG5UNythVzAvTENWQm5ZaGJESkpr?=
 =?utf-8?B?MjBNay80UE5EK2ZuQ1dnbVBjc2FwWlYxZXFMU3pNbjJlQ08zNlRnSEFKeUUw?=
 =?utf-8?B?WGY5ZTNqTEhnOEh1ZzJtUmVwcXg1WGhrZm5zNlpSVXg2bnl1UWNQOExhbW9m?=
 =?utf-8?B?U3FEUGhHdVI4dnpRd2VYVEZLd3BiVFVMLzB2YlFDK1NyUGR6bE5Uclo1R0s0?=
 =?utf-8?B?VDR0c1AvbG1acS9RampFQ1hia1I4aElBbWtXeGhxSERtYnRHVkpOWGVlUEJS?=
 =?utf-8?B?Z1ptcDEwVUEwRGRpb1Erb0JKaUFtSitQbmgxaDJFcG5FeXk4dngvOWpxV280?=
 =?utf-8?B?UjhkcFkzWnYvcU9iaE1mdnR6dVNCcnBnK1FYOGdnckNLeVF6YkY2L2ZEN3RM?=
 =?utf-8?B?aTBITThkYzhyY3pMSXUwaW53VitSUndvU05LZEdTNkFaVjhLQnJsWmtVMkt6?=
 =?utf-8?B?ajUvQUV2L1VqNG8vVnMwREtTaEgzTlQrdnBTK1FXaUtmblhjSG5KVDlYdGxv?=
 =?utf-8?B?QVJCbmViZUtQZy9HRG5nbmVFeFl5ZmlhM1ZJMGhaUWlCU0I0SytDdlhZTDh5?=
 =?utf-8?B?ZjFkYlVjQ0RrenB5T1M2QjRqcE42Y1hMSURRUlZvL3dVcEo1Z0EvZjJLeHlJ?=
 =?utf-8?B?bG4yc054WFVtY3BqeDlCUXNWUkdVZzYwZW4wN0NJdW5tUTA5ZDZITnlhSUxm?=
 =?utf-8?B?SkhTNVlqR0FxYzdLRWdNNStKRnpWeVh0NnpUU0NYSXRtNHJtUWxpdWRvM2U5?=
 =?utf-8?B?Qmp1Y3JCcXRNcStYVzU0eURIVVJvVmRXczhXTzdycmE0ZmpDMlBSZlcxWXZi?=
 =?utf-8?B?dCtTYnYwd0FhVjNjME1Dak5ENFNIRTdwOXMxb01RTThmcVZEVjRscUJ3aXB5?=
 =?utf-8?B?TExMSjRGczdRZzRZTld6RGs1R0JQNXREQXNjeXBwQ05kT3JCbmswOStLa2xp?=
 =?utf-8?B?dHVMRVhVNnRuNTFZZmxzQ2FnTHM3enB3eE5oUHlwRkJlS0hmcWM5RFVTZ1RC?=
 =?utf-8?B?MXNhRDVwdEF4OCtRY1NXMDI1R3lrVk5qQjBTTENlakFYVHZta2ZKZW9CNTJL?=
 =?utf-8?B?d1ZZemZGeGVpMWRESm5DRmNQRlFXY3B3LzRTWWpmTUlhSDYvVWQwbDhCUllH?=
 =?utf-8?B?ZStCQi95YUVWWTZ2UFBIRnZvY091SnduZlVLZXVyL2ZiWkV6TmdqRGw0Ylhs?=
 =?utf-8?B?emV0VXpMbzcrNGRKVjI5cVhrM0NqQ3dtRmtvYlZIdG5lbi9LTDhvR0JPZk4y?=
 =?utf-8?B?c2RRZmdVcWY2SHdML0E3V0RpajJ5NmtIY092VktGYmszYVJmdVR2eHdDUE10?=
 =?utf-8?B?TjBsanJ2WjZuVXlyZmc4bzB5bGYwWHZNZ3dLRmt5Mk5IN1I0cFFVOGhsajlP?=
 =?utf-8?B?WTl1VU40U3Ewem05bE44cUZUZ1llQUJ0Z0JpV1hVWVpHbEcxRDFFYUdCZE8r?=
 =?utf-8?B?WDBnOW8rTmhsZlpkUUZsanVsT1ZMMjFSM1l1eVhVMEREVDBSQWg3K1dvend5?=
 =?utf-8?B?ZEhvZ01WbVlzQTdWM3RWUGJ0cHhCYkIyZjZ5ekZJbHlyN25aSzJ5b2ZIRnh5?=
 =?utf-8?B?SWlsWmRDZXJLN29DRThXbzQzQjgrSnZoRGRFV09mYVZGR0hPb1I1TlBDWjVt?=
 =?utf-8?B?SHZ4ZjUreUM3RVFkbkkwOUZQS1BLdS8vbURoUFlZRGRndTltTXRVTWRDaTNZ?=
 =?utf-8?Q?NfPCQJoTXD0eZ2MszAw3rsQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e91ae825-8a75-499a-25ec-08d9fd13e3d4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 12:46:52.1141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6T19LYnUMVvAfeVol+HoP0koBYPknrVx85izGiz5zd++ooqExYcJ7GOLu10ZbuNzcq6143u8SMiIKy1X6KqCEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3075
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10274 signatures=686787
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203030060
X-Proofpoint-GUID: bTWpog5ZTSkGW4s7aB5IhybTv3XsU6JF
X-Proofpoint-ORIG-GUID: bTWpog5ZTSkGW4s7aB5IhybTv3XsU6JF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03/03/2022 19:25, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At device_list_add(), we dereference a device's name inside a
> btrfs_info_in_rcu() that is executed in a branch that can be triggered
> when the device's name field is NULL, which obviously results in a NULL
> pointer dereference as rcu_str_deref() tries to access the ->str
> attribute of a NULL pointer to a struct rcu_string.


A few lines above check if the device has the bdev, which means the
device->name can not be null.

925 if (device->bdev) {

Any idea how the test case could able to reach this condition?

Thanks, Anand


> Fix that by not dereferencing the name if it's NULL, and instead print
> the string "<unknown>".
> 
> Link: https://lore.kernel.org/linux-btrfs/00000000000066b78e05d94df48b@google.com/




> Reported-by: syzbot+82650a4e0ed38f218363@syzkaller.appspotmail.com
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/volumes.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index fa7fee09e39b..f662423fbeb7 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -940,7 +940,9 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>   			}
>   			btrfs_info_in_rcu(device->fs_info,
>   	"devid %llu device path %s changed to %s scanned by %s (%d)",
> -					  devid, rcu_str_deref(device->name),
> +					  devid, device->name ?
> +					  rcu_str_deref(device->name) :
> +					  "<unknown>",
>   					  path, current->comm,
>   					  task_pid_nr(current));
>   		}

