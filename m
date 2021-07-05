Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7136F3BBB26
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jul 2021 12:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhGEKXl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jul 2021 06:23:41 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:16842 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230355AbhGEKXk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Jul 2021 06:23:40 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 165AHKHv028406;
        Mon, 5 Jul 2021 10:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=J/gcXB5Qp95bex/MZ9eqLcVLBu2ErRj2j4ZRn3kBgzk=;
 b=sONLjqWsB4Q6Hg8Tv0UF+rKKlLdVbcOg1sIBWg9fMf4FjXUN4Hll5AGfdFZkAotn4wcg
 BYhOJu4k0rAJ2EAuL/Q789XFM4quu0YzuGiThcMyp/xdRaPgmShISwzlrlcWvUCBZSOZ
 52omh9Zf0i634XHOBqnFSqn6y8XUNu0QTavsmX1YWv2e4KTglUR3d/kXYHVEZcSWQQV5
 8oHIDUdc/xuhadOuKy9mNOtCADHKtHM89fQKUXNdh4BeEQwiP/B+CvLpg0bqj6sLbFBb
 /kHiC4PXJF3PWCFyG0cpypJ7JatKm4lb6Jdz7Ao6S4waO/560e5mLUKlnZeGbA/WzpiS aw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39kq8e8st6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 10:21:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 165AG1jw013385;
        Mon, 5 Jul 2021 10:21:01 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by userp3030.oracle.com with ESMTP id 39jd0y7fpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 10:21:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWZSFiMFpxXPjq+yZEE1QfzZ54TsCcId+CbsaQHXQ83Q4zKvQkyaX0G6Fy/FaAPCIzNSai9RLxPxHaTJuxnFPNgjlKq+u5WQ9pKesluJAYLy03tV4Fee3JemADpyjsQUJjKLqA5JIK7pCEta/xJg3r8FFGkGZOL7mudjnx1KlMmW59kV+CVAJbNC/jwXbM/21TGfV3Q09inn4GWR67LCUD2ErJPCbpgqtktxfn1JRbg5HmjDdk8uuLJ5CTtY8Xd5SX9I271qoas9M2fOtvtlE5Ca94R2lXfTuI6Ta1ChAN4TymrukoRJ87WkY/1PCA2iUtuEJdBQw+fSHh2Im0zRgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/gcXB5Qp95bex/MZ9eqLcVLBu2ErRj2j4ZRn3kBgzk=;
 b=VG359cR9DFdPrdQBKnPELgonXeRrq2sp919VyXCwBygQi3eA+Yh4sdqp2kAw0gL8xhqoeQ15tOsrUnrJNz7kl2JeQT+ljPTvsPWHPSPAblO5xQE8jo4M/MkWoVc3OxHnLOtpf5Af0VfosBVvdItpwlINg9slyJySv062DUIUemgYCuItQEuOhedOP5uVmZJS2YiORZhQr74tLy3dA8ZpfWKHw89GsC0LAnDTmBui8U1V62r/Cy0S9qDFDn5X/q8JYgNHKdO2CQ8ia8YDj68aTHkHCsnJQqmAXMQDlLH2radd3nQCkgySDJp6YhouOiaakLJrfTJhO0GhcbPhGQp+ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/gcXB5Qp95bex/MZ9eqLcVLBu2ErRj2j4ZRn3kBgzk=;
 b=ROZkJzM7XA74CjYOZN8mDapqtGDoGhhJ6AAz/Am4mkr3GmFYNJgHPjkgMm6hEgsC6SG7SjCwiGpw6CgLYv/BSS6hf/rJ88ZlH23xqpo3ha48jTZi3ZUEievAmgyflbRoEL+R72cO9aqFPObk4Q5JoJLCEPSCvWSzy33xMSRuhkg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4238.namprd10.prod.outlook.com (2603:10b6:208:1d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Mon, 5 Jul
 2021 10:20:59 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%4]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 10:20:59 +0000
Subject: Re: [PATCH] btrfs/242: test case to fstrim on a degraded filesystem
To:     fdmanana@gmail.com
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <a70c9f6b4e45d9bcdc5c2f19182f89ef8e22c074.1625237782.git.anand.jain@oracle.com>
 <CAL3q7H6YZa6JLFhHbJB_FScD2wdm3NWEEDsE9C3EwVmoKMMkJQ@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <4558f476-3721-b0af-c7bf-34d0e6488a78@oracle.com>
Date:   Mon, 5 Jul 2021 18:20:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CAL3q7H6YZa6JLFhHbJB_FScD2wdm3NWEEDsE9C3EwVmoKMMkJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) To
 MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.2 via Frontend Transport; Mon, 5 Jul 2021 10:20:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f155e7a4-1bcc-46fc-7a35-08d93f9e951b
X-MS-TrafficTypeDiagnostic: MN2PR10MB4238:
X-Microsoft-Antispam-PRVS: <MN2PR10MB42383C7CF9E4CAD792CC71B8E51C9@MN2PR10MB4238.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8EI3vsWCYm1Mpd/U66We6JAJj6Q4ADKkVtS2MlVTqYp4F5d01yytPd0fh+P2QVEmlTsG30aXJ3De4/knhzTB0/c60c3T5RC+E9yv0s7TCUtS58OMHoeffgSGzqf2W317ZeE2NjMnhwnVJpLYcp2Ld3nLu2foy8MAmn8mMypbEHu4B8C2A7LA6Gu2NtwREHkh400nKM4t/OFVVOjJiF94pWjNcMW+MTGhzHptzjw45h+r06dgAw6O1AbiyvYqpKOoKq9U9IvD9JDM0cceQJaUmrtA8wDIdtwRpVfcs8OAamGk0eIb0IF5Cqz58x63Pdw8UIoCyDx2BziqHp8GcLv6CFs6uu6xqeuNnQ+wj25Gr828jkddBFxg47cvP5twzb8n0qLMRV+HpRiEBTplaQyzuSVHqZqkE/ILY+uUjVUbAvGaucjfsmiiCvpYrkTFymdqzyD7kZAuRhr8YyE6dZ4SA4Fi5LM4BgcdhB/IF1eYL2s38UVnzs7OBRczwAfFJqAWhjVGBG6PQkOKLTaP07L9x4+iQ9x9CFN8bdWDaXv4LvlBpWg2cjF9rjAy/omxo7Jcqk/AcTxAlWpGSJ9EA76DAoM1em2/SL2KWA5a8UL+RXhbIEc392bt20PQo/W05lya/Fr6PuFFPRS7FvBPMP073J2zqgC3oWuGeFSoyIyOEbMrggJxds13yDEEc8xHWjCEaMVtGgt6uIER0YjhOU/qxXfh004ikL5oZwR7KmMYL3I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(366004)(376002)(136003)(36756003)(956004)(2616005)(6486002)(16576012)(8676002)(6666004)(316002)(54906003)(8936002)(44832011)(4326008)(31686004)(66476007)(5660300002)(31696002)(16526019)(26005)(2906002)(66946007)(86362001)(186003)(6916009)(66556008)(53546011)(478600001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTRQSkRMd3BpcnRBcUJPRldrS3NiVXN4Q1B5SkMxQmJrUHFiZ0tvSFpNTVhs?=
 =?utf-8?B?alRIek1OTUwrejlEZWxuTlBFMGRqaHBjRFRJZHFVb3JoVEw3MUh0UjZMOVU4?=
 =?utf-8?B?bXQrcHNJalozT0VwODczY2NyWC84Z2RxdEZLSy9NZ2J4bThmYlZGam5CRnov?=
 =?utf-8?B?VmdLV3FTckZTaVNqa3RDODFMcVkvTm1CR2NLUzlCcVpFcS9jVGJQeVhLNC9X?=
 =?utf-8?B?WWtzTlVWb0FPajNIdTJtdkYxcnBUT3NCZVo2elNkSFJBL2g1M2RwSlh2dGdH?=
 =?utf-8?B?aVFoTTBmcEJMNHhLaHZBb1dVNVRNV0dNazR4ZGJydmZIMHV3YjF2Yi8xVUt4?=
 =?utf-8?B?YnM1K3lML1hZMCtsOXpYSkhIMldLSFZmb1ptTXFzOFlCdTQ1Vit0QnpmdWFT?=
 =?utf-8?B?WnUxdWFhMjFqUW10TlJIbXFKUWQ3TEM1YXV3TXJZRWcrZndSbElzUWZNbjBX?=
 =?utf-8?B?NTR6RFM5aGx3OWpqNEpNWE1QK29ocFZiS3pubjEvUFBpWitWYjErSjlST2tp?=
 =?utf-8?B?L1lQQnc4ZmNxMkt2cUNaYitXMHFydnAyYlVKS3UwUUZ1c1pIKytXZ2hOajZP?=
 =?utf-8?B?eVhtdE9ibEdJekNjK0MvTlBLQWJ1d1RwWUIyVUN4cTRudE8rM09odE1oSmhE?=
 =?utf-8?B?REJkL3hVenZyY0twaDZzbDcwQ0wzdjdwRDBaRDBOY0E3OWM2cFN3TXFna0pn?=
 =?utf-8?B?elRkeldrRXVUZHUza2lKc0lIT0tUeXlHVHlQbnhTRDc3Tk9yTVFEbVpQMGdk?=
 =?utf-8?B?d2FGZFNweVdaTE9scjdsR0xpdXVCK2JleC9xUWIwWEFLN2V4WkhPeHIzVUxL?=
 =?utf-8?B?bVJNWW9DekU3OUVTYUw3aEdtd0tFM2kwK1pQRk1jNXpPU3VlM1NuZWpOaURZ?=
 =?utf-8?B?ZjVCMGFjYlFYQUxkRFFzUmE0RHlGbjNQMGNUTnZ2UVVCQWFXYjM1WDYvL2dD?=
 =?utf-8?B?T1dxOENxb1l4dHVHVzlFZWM1cUZyOWFsZDdYWHJSVk9aQWtUMTljVVJseU1y?=
 =?utf-8?B?WnpoZmN5SE1PZnphS05CNDdibExvV3RKK09XdWZCVnVld1BGN0FsUDBNSXdJ?=
 =?utf-8?B?M0Ntb0Z4UVRKMUdNVUlmN0Z2cEJYb3Q0OU5yMG14MGt6dldmelNqOHJJNUNH?=
 =?utf-8?B?ZTIyQmJSS3Q4ZGNWZENJcXBwYVZRQnhsYmo3K2x3eXU5MFJFQWp3NFhpUzYx?=
 =?utf-8?B?VE9DNnlhTm16b2E4bGNnK2xMNXFFYW5LYnpZa1VDeTBaOVZXRFNuQjZ2Y1dO?=
 =?utf-8?B?dFdzUitlMzVzenBwSkZORytaT3pENTgxS1FDZUY2SEZWNlJLbkQ2eEpTWjJq?=
 =?utf-8?B?cWVxKzJ2VGFPeWJGdDVwcnBjMlcvYU5jaTh6cUVqRkpMSVlQM3dpOVZ0b2dR?=
 =?utf-8?B?TTRrZTdpVy9mUUR2RFdPK1BSdHVFemJMLzFvYjZXUnd2WG91anpzRnhJOWR6?=
 =?utf-8?B?RDVSMVFsRFY2OHVibnR2RGhNSG9jaUU3ZnNXdEp3TSsxUlZuTlNtdi94Tmhj?=
 =?utf-8?B?aWxLN29PU3krVzk4a0JWQlN0TmNzL0V5cnBUSG9lSTJXaWFwZ3U5TE92VklU?=
 =?utf-8?B?a0JFZEd5UEJZWDZXM05OUEVxM0E0OFB5bEZCdnIyWitTUmpjUTFyNDVHQm5j?=
 =?utf-8?B?VGpPUVVWVTdSWVNiUmNkd0dyR2t0dWZteFFucTd1bmo0dW1IQVFBYk9XdnFH?=
 =?utf-8?B?cysweUNaTU5MMS9jMnJ4SW9LbmwyQmtCQi82dDF3bVVzd3hDdkdGZlR5OE5M?=
 =?utf-8?Q?PoMxoBbJkN+/2wN2NK3tTkEr84PIs5MgqCGKVJY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f155e7a4-1bcc-46fc-7a35-08d93f9e951b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 10:20:58.9470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDR0zb9IVrufoi18F6K7JRORrUUhj1FCglFDu1cQn8zyM81b9vVLjp9cnfxATtygF21Yg1+eTBTe9UpJJDZ8OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4238
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10035 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107050055
X-Proofpoint-GUID: Sm8VChmKYmKjLJuIW7ZNyEcWCXjqwlEV
X-Proofpoint-ORIG-GUID: Sm8VChmKYmKjLJuIW7ZNyEcWCXjqwlEV
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/07/2021 16:45, Filipe Manana wrote:
> On Sun, Jul 4, 2021 at 12:24 PM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> Create a degraded btrfs filesystem and run fstrim on it.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   tests/btrfs/242     | 49 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/242.out |  2 ++
>>   2 files changed, 51 insertions(+)
>>   create mode 100755 tests/btrfs/242
>>   create mode 100644 tests/btrfs/242.out
>>
>> diff --git a/tests/btrfs/242 b/tests/btrfs/242
>> new file mode 100755
>> index 000000000000..e946ee6ac7c2
>> --- /dev/null
>> +++ b/tests/btrfs/242
>> @@ -0,0 +1,49 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2021 Oracle. All Rights Reserved.
>> +#
>> +# FS QA Test 242
>> +#
>> +# Test that fstrim can run on the degraded filesystem
>> +#   Kernel requires fix for the null pointer deref in btrfs_trim_fs()
>> +#     [patch] btrfs: check for missing device in btrfs_trim_fs
>> +
>> +
>> +. ./common/preamble
>> +_begin_fstest auto quick replace trim
>> +
>> +# Import common functions.
>> +. ./common/filter
>> +
>> +# real QA test starts here
>> +_supported_fs btrfs
>> +_require_btrfs_forget_or_module_loadable
>> +_require_scratch_dev_pool 2
>> +#_require_command "$WIPEFS_PROG" wipefs
>> +
>> +_scratch_dev_pool_get 2
>> +dev1=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{ print $1 }')
>> +
>> +_scratch_pool_mkfs "-m raid1 -d raid1"
>> +_scratch_mount
>> +_require_batched_discard $SCRATCH_MNT
>> +
>> +# Add a test file with some data.
>> +$XFS_IO_PROG -f -c "pwrite -S 0xab 0 10M" $SCRATCH_MNT/foo > /dev/null
> 
> What's the point of adding this file (which you copied exactly from
> btrfs/223) if it's not needed to trigger the bug and it's not used
> anywhere in the test?
> Or at the very least, check that reading it after the fstrim returns
> the correct data, as it might help prevent some regression in the
> future.

There is no need for data to trigger the bug. I wanted some data as 
practically it is. I like the idea to prevent some regression in the 
future- I will add code to check if data is correct after fstrim.

Thanks, Anand

> 
> Thanks.
> 
>> +
>> +# Unmount the filesystem.
>> +_scratch_unmount
>> +
>> +# Mount the filesystem in degraded mode
>> +_btrfs_forget_or_module_reload
>> +_mount -o degraded $dev1 $SCRATCH_MNT
>> +
>> +# Run fstrim
>> +$FSTRIM_PROG $SCRATCH_MNT
>> +
>> +_scratch_dev_pool_put
>> +
>> +echo Silence is golden
>> +
>> +status=0
>> +exit
>> diff --git a/tests/btrfs/242.out b/tests/btrfs/242.out
>> new file mode 100644
>> index 000000000000..a46d77702f23
>> --- /dev/null
>> +++ b/tests/btrfs/242.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 242
>> +Silence is golden
>> --
>> 2.27.0
>>
> 
> 

