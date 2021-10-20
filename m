Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA697434E6C
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Oct 2021 16:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbhJTPBk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Oct 2021 11:01:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:59396 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229570AbhJTPBj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Oct 2021 11:01:39 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KExNH2003717;
        Wed, 20 Oct 2021 14:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Jp1xpLam8xosuP2DvC7jy9Tql1rOJjaLl+mQL74gMPQ=;
 b=lJjKKueYCaIpUTXqml7dup7FRbuhGvEJ2Z6M45uLHWr1jVdvU2SLIcrvMJk5PLjECWQR
 w54RJKkSf3k9XsMUCHuCBTHTrDdYpPcAF9Odv4N05j504K3WhHV/aA2m5IbxvfKLRuPc
 QnbJfO2+z+Rda73ntU/elDA3MZiTaVeIRA/KmitozxwqM4PUQdm+qnIilRMnbyuF+sA6
 a321lU1cQAAulkVx2g/4wncRh8bC0tUs78g94jZJSy7t1L8E1PdA2wK/Co+AxGDp0iWe
 e5xleGujfn4EIsyema++T3W3EQLGW73i7WTRuDQf9znYoxjpgzgBVkK1KFcGdoz9L4Va Bw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bsr459knm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 14:59:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19KEurfo030057;
        Wed, 20 Oct 2021 14:59:06 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by aserp3030.oracle.com with ESMTP id 3bqmsgjufp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 14:59:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccnhNYHZBGjaddNfSM9Yv8HltFUCWIk7S664uB/Rk6r0598NJHKtfpnxqRGuzx6RdTUiagVTfI5eP8HLbHnu/5+mGQ0x6URJR3PxIbSmekT+3+9HUxlaAjUkDNvBvYCp4Qv3r18cldg2xQTeRZYLpTfdRbvBko1IfH1NpVEMpJ/AiCo6mjzSAqTsqgvCgk5CMOoxkaQrxv+4KTCZGC3Mdo4/ZE0rky/+ULygMIvMWlvtvt7FP357Y0gKki/jPEWDuSByI8P4TdWRCuKJWq5nJPg66AD+ustdAmq7yto9Q7WULRez5vSxj/v//H0TD8G8owWY842/LWogGxOIq6i4eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jp1xpLam8xosuP2DvC7jy9Tql1rOJjaLl+mQL74gMPQ=;
 b=IJbA5k39KVyAh7XJftG+zNhTelTWp/tCj4KSDCiREtF9LKHoY66hMGUwK03/iiGlz7LOE379fR3mTiSIaiej+kjLkV0crOcY6IUYOcPWtO3jPoMN2QrC2zuxK0GmixlHsaPkS5BRvvW69C8uTg5y4++6mX7NF2Y37RtCJrjLYpQivfTcct5NfRsSFu/aC6DFoq4BOHBOf80UFFo/NA6uhSBu6k6X3VBNx0pFudTcZGtCShPn+0y0sholEqfa0XLcH1lL1gozXaScR8xrgef1TvIUMGo0YUTyJkHQWu9+JyCLhsocdwk7kFJ6MJj8C8mEERRVQXQiEtBnlAgc4iMQfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jp1xpLam8xosuP2DvC7jy9Tql1rOJjaLl+mQL74gMPQ=;
 b=qCXu0kxHnehR1h+5/9DEzJMh4jIVeILYkv9J/lcrlm384qawrDYVilQxrbQZAjBz8QEDoOa/GuAYqryvlHa7f/RA84H7WkiZMq687qCavGgP/6xGCTjiBE0AmaZkL+rPSzPMmZ5d0ChP+ZAh1VV4JpGcaaZAD66xYhWLBwuhVl4=
Authentication-Results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4820.namprd10.prod.outlook.com (2603:10b6:208:30c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Wed, 20 Oct
 2021 14:59:04 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 14:59:04 +0000
Message-ID: <990d5851-5168-c51e-eb5d-f72eac2f327f@oracle.com>
Date:   Wed, 20 Oct 2021 22:58:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 3/3] btrfs/249: test btrfs filesystem usage command on
 missing seed device
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1634713680.git.anand.jain@oracle.com>
 <599618f8698efc64ef8e25e0cf1d97541927d8ac.1634713680.git.anand.jain@oracle.com>
 <YXAfRcmJ9oYj/kpe@localhost.localdomain>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <YXAfRcmJ9oYj/kpe@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::29)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SGXP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 14:59:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 215fe001-ab1a-4add-3603-08d993da2842
X-MS-TrafficTypeDiagnostic: BLAPR10MB4820:
X-Microsoft-Antispam-PRVS: <BLAPR10MB48205F55C3E1429B1472104CE5BE9@BLAPR10MB4820.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A3y1PQM3O1ghvdHE6n6fbfa/Rm7layPhvjGPc3tGOm/tgM783mEMZafMM85BMTs1xiYoAtYp79YQcN+FaWwIB5rHIOOF1ZUOsywOoj5UCxONmnErMt2Tg36cLgIZThO6O97rf8QbFFXapqyz+CuTgV9O84+9yMHbdJdeWPpNO1ZE122VMm8Ym7BEqKLICBXBR8RV6aPFpt1l8dnUvHa+sEEEZ6rKnpW9tewCRSap06/TFr2yROMXwma7LTeQ7SE3XduZIOXepbklhIcDLcIajSdTaOnNJXirzuq5CYk0y9ySviJJI83Glr8HINJf5uXQ2flDtkamXZHD8hk0rhaxOLjKRKFVkrYimJ59o+Id/Ul6CXot2yM5B7TMoaeO0mGBf0/FqNNqN7BKi7DXxkzkpieEn3QgRl1QXetKRkspISfVPvMlN2swU9uksV7Vh9K2aBoTSZ0X7ZanMnfAATbKDGMnlv7/D6JKYGma09g+DZk7qNc9k3f0iRMpvLPxH5H8ltqRSEMsss+cwoZ0zUdSFYsfreMhf2RunisGuBaZsv1EJEtaZFIjTzT/juVxGiH3Y070r3Y/c+gAHLy5rzc7dnkf03IxyJIeQi4PDKJuBNX2pBSK8ZpFgYLzC0+tFQGpj1zhRQ84u2QIOLPLnkqWWbKvSr0fPUeyumAGHijzs6BPIqCZgtXGG/Hncs+L+UaHt4Nk0z2SSEWv7YWkX5bv4JqDSG1v1m+/1kY44CypdW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(16576012)(44832011)(83380400001)(4326008)(8936002)(2906002)(31696002)(956004)(6916009)(6666004)(53546011)(8676002)(26005)(5660300002)(2616005)(508600001)(6486002)(186003)(38100700002)(86362001)(316002)(36756003)(66946007)(66556008)(66476007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHM4QWpHVU1pWjMvSFYwU2Z6ZG12bE5uQ1o5Q3UwODhSZGpBczBQZ2xCWGpi?=
 =?utf-8?B?akkyVFpNWWwxMDltTmZXV1dwN1BvaEpWaThrbnovb2Y0UkRTSkNhWncrNWJ5?=
 =?utf-8?B?dCs1d1J2WVVoY2NqWTNIS2FqUWZpWjh3R0J1ZWNuYi90TW9lSldYQU1BU1JB?=
 =?utf-8?B?VVAwcStCYzVCNk5scHl6d2pqVExIcmtEa2dGeldQQ2t0YUpMNnBBUUtjQ0M1?=
 =?utf-8?B?VVNlLzVhaFdXL0c3RTByWm4wbFEwUG1HcU1tTFZGTU9RME9MR1hMSk43TW45?=
 =?utf-8?B?Y0x3cmIwUkxBUXRTN2xYT3l1Y0NWbjR2clpuS1UzQThORGVEb3dsaENtbEtW?=
 =?utf-8?B?bmtJY0JVSHpieitLUmwzVUVZL3NwVUQ0eXR2RXd2UXZaRFVScmNvM1dOalFJ?=
 =?utf-8?B?MDVWTUMyYjFNN28wK3lSWWIwblRxQmJ1ZThlY1pnUkZPUEovSHVBNVZPc3Nn?=
 =?utf-8?B?OGJnd2MzdEU0b2YzOE9mTS80NEt1bmQ2a3ovMFFXTWp2L3RUN1ZxUjRyNHJp?=
 =?utf-8?B?U2gwT0tWbC9XZlJNWDVINVdsYUdGaDdYUjRpTGJqYTFhb3NEdm1RVmdyb0lV?=
 =?utf-8?B?V2U5T3JlOHBiTUk4M3piVUtGTUFFZ2p3VnEvZ29FQnBtOTVGUEtKdFNuTWtG?=
 =?utf-8?B?Smd4ckdCS0F2VlY2dVEyQy92V3RmYUpzdEZROXN3Uklzem53RWljZ2Z1ZkUw?=
 =?utf-8?B?cEhFN01FQnArdTNTY1VqWVR5S1BaQmpJWk5TdWRacE9zclNOSDMvR2JJRXZT?=
 =?utf-8?B?MStsYkZwY09KblZ5RjhNWS9OeFhTWjlPWGsvQVN1Y3hTRGF6aWRPVnprWmZQ?=
 =?utf-8?B?Nm50WUNoSlJYYkVjV0oybnNoS1lyc3BhUzJ3VUlkeWhQaXIxT3k2VnVDUTJO?=
 =?utf-8?B?YlpUaFpsS0loMlgwanJIRW9nZWNteUVvQVZLRHlkQU9JSHd0dlhsbHV4ZURQ?=
 =?utf-8?B?R1ZUWXdqNmdOU21EWEhWbUFseTE1RGRYV3VJbXpRZDd1N3VaZk9ialhmbHg5?=
 =?utf-8?B?S3Q5eEJ6SklCenQwbzh2Sk4yUFl0VVVOdWJHRFpHV3lTdHB4SzZvWkpWdjhn?=
 =?utf-8?B?ZzZhVFNyN0pPK3RIaldDdjZjMy85dnFwNVFsYjBJZ2RXMDNSL3kyYzFNVU40?=
 =?utf-8?B?aUdCUGliandYSlZ4ZDNRUDdINGRyV2tzczQyY2lVUW9FbTNteXYycXJVL3Ft?=
 =?utf-8?B?QWNlelBBWnlHenB0eGo3bGdlcCtNdERPcHRIM2tqSXFjcUxCc3lJSEVDV08y?=
 =?utf-8?B?MUFrK29NTWl6enBaUGVGLzRMaFI3Uk9uNXVpRE54d1UzVHBhL1ZBa0ZrbXVn?=
 =?utf-8?B?azFjVDFIUExMa2owVkpFVWtIZDZkOU5ZWkxCVk5yWE12a3lhK2grenlIdnlQ?=
 =?utf-8?B?YjV6VGhSYTlXS0NucHMwV2N3K00zNzZYMzgzRjRIdzE3MGNGTmt1SHBxYVJk?=
 =?utf-8?B?QUlSYktBZnF1UUVHVHI0S2h0djkzT1ZtUUR3STFPTG9qeTFkRnE1dENvdDNC?=
 =?utf-8?B?T1NNbkxKNTU2blh6SlhpSi9qZjBGdkpjSTVwa0xFZFYwaGQ0NVlpcFRic0tW?=
 =?utf-8?B?RHRaZ3VLcDRqbzB3VWQ3SXlORHMzOU9CeVJxY2pOWUpDSWpKQUdxaHl6MlYx?=
 =?utf-8?B?YUlXUlYycktGdjdpbGlBTHNDV2pSQTE2MWVFQVhTTEppYlJIbllOKzRKcmc2?=
 =?utf-8?B?S3hBblVGTEpwMDNVZjBaU0JqUXJJTkJ1QjEveHFyY2JRbGNtcmlYWXllTGE5?=
 =?utf-8?Q?Y+XnSbV35iEHvw7cBho8rUTy5xM/65K+EbLxg/i?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 215fe001-ab1a-4add-3603-08d993da2842
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 14:59:04.2912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anand.jain@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4820
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10143 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110200087
X-Proofpoint-ORIG-GUID: nciWwIKybgj8T2Huer4SaD0EoyYV4ti1
X-Proofpoint-GUID: nciWwIKybgj8T2Huer4SaD0EoyYV4ti1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 20/10/2021 21:53, Josef Bacik wrote:
> On Wed, Oct 20, 2021 at 03:16:44PM +0800, Anand Jain wrote:
>> If there is a missing seed device in a sprout, the btrfs filesystem usage
>> command fails, which is fixed by the following patches:
>>
>>    btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
>>    btrfs-progs: read fsid from the sysfs in device_is_seed
>>
>> Test if it works now after these patches in the kernel and in the
>> btrfs-progs respectively.
>>
>> Suggested-by: Josef Bacik <josef@toxicpanda.com>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> Shouldn't this use
> 
> 
> as well?  I wish there was a way to detect that btrfs-progs had support for
> reading it but I suppose this is a good enough gate.  Maybe add a

  _require_btrfs_sysfs_fsid ?

The problem is about the nonexistence of the sysfs interface to read 
fsid. Adding it will fail to reproduce the problem.

So if there is no sysfs interface, then btrfs-progs will fail back to 
the read-sb method, which shall expose it to fail.

> 
> 
>> ---
>>   tests/btrfs/249     | 67 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/249.out |  2 ++
>>   2 files changed, 69 insertions(+)
>>   create mode 100755 tests/btrfs/249
>>   create mode 100644 tests/btrfs/249.out
>>
>> diff --git a/tests/btrfs/249 b/tests/btrfs/249
>> new file mode 100755
>> index 000000000000..f8f2f07052c6
>> --- /dev/null
>> +++ b/tests/btrfs/249
>> @@ -0,0 +1,67 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2021 Anand Jain.  All Rights Reserved.
>> +# Copyright (c) 2021 Oracle.  All Rights Reserved.
>> +#
>> +# FS QA Test 249
>> +#
>> +# Validate if the command 'btrfs filesystem usage' works with missing seed
>> +# device
>> +# Steps:
>> +#  Create a degraded raid1 seed device
>> +#  Create a sprout filesystem (an rw device on top of a seed device)
>> +#  Dump 'btrfs filesystem usage', check it didn't fail
>> +#
>> +# Tests btrfs-progs bug fixed by the kernel patch and a btrfs-prog patch
>> +#   btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
>> +#   btrfs-progs: read fsid from the sysfs in device_is_seed
>> +
>> +. ./common/preamble
>> +_begin_fstest auto quick seed volume
>> +
>> +# Import common functions.
>> +# . ./common/filter
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs btrfs
>> +_require_scratch_dev_pool 3
>> +_require_command "$WIPEFS_PROG" wipefs
>> +_require_btrfs_forget_or_module_loadable
> 
> Need
> 
> _require_btrfs_sysfs_fsid
> 
> here I think.

  As above.

> 
>> +
>> +_scratch_dev_pool_get 2
>> +# use the scratch devices as seed devices
>> +seed_dev1=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{ print $1 }')
>> +seed_dev2=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{ print $2 }')
>> +
>> +# use the spare device as a sprout device
>> +_spare_dev_get
>> +sprout_dev=$SPARE_DEV
>> +
>> +# create raid1 seed filesystem
>> +_scratch_pool_mkfs "-draid1 -mraid1" >> $seqres.full 2>&1
>> +$BTRFS_TUNE_PROG -S 1 $seed_dev1
>> +$WIPEFS_PROG -a $seed_dev1 >> $seqres.full 2>&1
>> +_btrfs_forget_or_module_reload
>> +_mount -o degraded $seed_dev2 $SCRATCH_MNT >> $seqres.full 2>&1
>> +
>> +# create a sprout device
>> +$BTRFS_UTIL_PROG device add -f $SPARE_DEV $SCRATCH_MNT >> $seqres.full 2>&1
>> +
>> +# dump filesystem usage if it fails error goes to the bad.out file
>> +$BTRFS_UTIL_PROG filesystem usage $SCRATCH_MNT >> $seqres.full
>> +# also check for the error code
>> +ret=$?
>> +if [ $ret != 0 ]; then
>> +	_fail "FAILED: btrfs filesystem usage, ret $ret"
> 
> Can you add "check your btrfs-progs version" here or something?  In case I'm an
> idiot and forget to update btrfs-progs on the overnight xfstests boxes?  Thanks,
> 

  Sure.

Thanks, Anand


> Josef
> 
