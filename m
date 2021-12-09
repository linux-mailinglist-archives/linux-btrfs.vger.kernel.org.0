Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7FB46E2BA
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Dec 2021 07:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbhLIGpH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Dec 2021 01:45:07 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:18880 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229904AbhLIGpG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Dec 2021 01:45:06 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B95gtGD008040;
        Thu, 9 Dec 2021 06:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qtwdvHEWfHeTOI0kUHMqIFsE2jyIZAAX0AMMCCzzWdY=;
 b=f6/rTKTITyCZe7MjJDOq9p18W2p9D6l4rs2OS/AbUaZl/jgauMvPQ9nB0N3la8U4AHgR
 /IbGNNaw9pNgTX8xutwq+TZPrjqo1UnTUTqz2c8SWw4WBzjrVWkBGDfELqC3m9KvgCvR
 JBR6z0bEVxzVIeJuaz3FmcuwNXJEtfbvV5T5UTtIFgrJ4pRhIWRlva4YIOWvjQeZEsZy
 lV8W/fstfcHYlAafMm4QzgJQ7E0QayhI30ENq0BtitMNJ7bjSAg6K2Y8JESOTvgZh4NT
 vFMVFMQZS/oPeVgKVkqScGJFG9A+mgdRx0atok9J9QL4oM4rXT3ZzoPJfJeVNrT8y2SD VA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ctt9mtdxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Dec 2021 06:41:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B96fVjJ005838;
        Thu, 9 Dec 2021 06:41:31 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2044.outbound.protection.outlook.com [104.47.56.44])
        by aserp3030.oracle.com with ESMTP id 3csc4vtn0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Dec 2021 06:41:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIsdRemJVUIOxX6nbheGnlR/mnQISRdwP4qg9LrQA6bpgtzlj3BHxPnM6wEcPTPqPL95fPO+EBZDKbF5RnTOedyg+SPnW36jdRTwwfrspmyc1YUsdKLCoTJzfXLvHXsQOo8VsWLa8HVBwqhUPY3/9LmhME2NVZ9Rq5T3iHrQGTvKOFdqqwSqiugznU3gc/poUe5tWWIvVQLjd+bTucGJswlWC5TgXbLhwfHRWSKXPGEgjvT0gwmjXvBSKdX5quIhrPRxDyCg+XIR9pqNksF7RuWgeVvZRt17Ol4pTbNP8591WrVzfVpuklg3F7EFTqzynoMD7Sgv7GC9ORyhPU99dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtwdvHEWfHeTOI0kUHMqIFsE2jyIZAAX0AMMCCzzWdY=;
 b=XWCq4zOQtKMiX+eYHndwy5eEI0agm0Zc0EQ9JL40Yndc4JeQbiBCp2B/IsPtYvLIN0EK69k1tFXw53DbFR0Ln5dFm8hdxfVUmsXr0ZbynJfdqz9tNDfdi+uOLo7MS2ag10lMZ8S3z3qnL/U72CNBnP0ZeY8U04V0sUGP3KLlXU6zvZ14r64IysHbsw9Hl4D+IptzTENSTbu8CWrkQxyJvej9GMlH5bvlhk/WgcyOXTnslOIcPl7d0AhBZ3MzhUzr/6O0kB6v9Nyb+BhG2S2sAYDoVlltTJlex3RgyhB6D7642NITj07HePvYJHPeGCAj3kEPXnisWa+lapagjsF4bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtwdvHEWfHeTOI0kUHMqIFsE2jyIZAAX0AMMCCzzWdY=;
 b=sNF2nRw6MKqXQTqGLojOrh/wLWd7hboxC5Tnb+JFV76CbgrJmhrO+p49DgQEbFAehCk/Yhc/jEBof4GuuheAhrEb1beQez3k0uYhR+jOJ9gH6FHHvN7Xzj+7gmRCwUx3CY1fG3hbPikNSMjd5O8bV8VlD61pKY2oapFsiHklAtU=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4191.namprd10.prod.outlook.com (2603:10b6:208:1d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 06:41:30 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%5]) with mapi id 15.20.4755.025; Thu, 9 Dec 2021
 06:41:30 +0000
Message-ID: <5864b5a8-7572-1f43-b217-761bb6e4bfce@oracle.com>
Date:   Thu, 9 Dec 2021 14:41:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] btrfs/254: test cleaning up of the stale device
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <c1c22a67c90f1b0b94ea3f99d6d6fd4a4d5d5473.1638953165.git.anand.jain@oracle.com>
 <YbDGIWHVD4cmdZz0@localhost.localdomain>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <YbDGIWHVD4cmdZz0@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0252.apcprd06.prod.outlook.com
 (2603:1096:4:ac::36) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR06CA0252.apcprd06.prod.outlook.com (2603:1096:4:ac::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend Transport; Thu, 9 Dec 2021 06:41:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d863aafc-6f47-4f75-3bc3-08d9badeee98
X-MS-TrafficTypeDiagnostic: MN2PR10MB4191:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB419104EFD4CE8CC93ECD1D4EE5709@MN2PR10MB4191.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /IXSa5Y+2ZgwSzttg0bdNl9KBH02/ba2ODu8v08iwDUI6PP48MCKg3xRba0SF86z31UvLIydh+Vc7fdlFU1VDXAmKKNRees0odSb/YCEBtRir24+xZaLquvLLDgt8fzLxkdhHKKioFNyq+mgvSljSND02RL+9Z4ufnVnQjduzFjoxIPnNEQF/TVl2Bgcs2DBUI2BAFwWjgp/Blv6+SNHoMFP/jRID2cGMQHzBa1frYpcSisBP+b/XPBR0O+iSfmjnVoeIMXeK8e+ATcMwaB1E6sKRKJRLxdhArJrHvG2znm2pu0VjO92Sw2ig4tgL7BirlOOC5/2hpbvMAZKEYHNGO80SqMeDsVUXHAttuOO+b9CNyq34GOLV4FSO3MLfaJnmp148A/xT0J0HvjV/yxWNot34Za3gzg2SMIZ8tqvVibqacL4WgkTMqylkU5X05rlTR7k4CXZ0d5u6bhVBPRoAcFN1pyZj8uxrzJw1LDeDoq/srT1g6GcmaRXWYsnXMQxbl79upXuBYmkNDBk2nymxYxXTSoVG4hf3yoVabLl4KLIytkklm/DQLAvvVOvu6ChvphORg42cH99quisgG6af8lP74vC8KaTBrBJOsodpxIyXEuFbVKCxLaji9njDyUIANCUU2QZ/vRhgBoelyiylgjee8u0nHmxUY9y6BW9iudnsDZUrL3pLrn7autsDrk4ocQQxsXL5WzT+EKtH6E0csMuewn49HH7Ejv91tTbASVsGMrUTm8nIc/7PGU2pCRI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(44832011)(316002)(6486002)(8936002)(26005)(2616005)(956004)(6666004)(66946007)(6916009)(36756003)(186003)(8676002)(53546011)(5660300002)(16576012)(66476007)(66556008)(86362001)(4326008)(31686004)(2906002)(508600001)(38100700002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0p1N2xOUjFlQUYzK0krbG1GVnAxUlJ5d1NyVGJsSXQwNDNYd293SnNEOGhQ?=
 =?utf-8?B?ZnJNL3duZVhLREY2ZmdLNWkrTzc0RHRHQUVsRVIrMzBjcE5GNnZuVjdkSXg5?=
 =?utf-8?B?KzBoY0RKOWlKbG96dE95dlBlUG45dWNhb2E0dUVuRUlWTGpQTGJkUHh5MUhy?=
 =?utf-8?B?aGpYTW1hZmpHbzlxZ1lURTNpZHVVaXVOTTlMd1lDYzBFL001YmczYlorbTZw?=
 =?utf-8?B?L1MvbUMzbHY5aWp5dXRzUW5HcVlpbDhLRUs2L1QxRFdqcThZckh3cVQ3M1Vm?=
 =?utf-8?B?UUI0SUMwUlJnTnY2Sm91YzluZmhGTEgyeWw0bmhOLzNhNUMyQlRQTVgxd3l2?=
 =?utf-8?B?dmlpaUtqYVp4cWFKNGE5VFdjVXZSR3Z1ZVNiOTFJWkMxWmlPYU5mWkx6SDhx?=
 =?utf-8?B?NXZzL2Y5UkxFSlh5dUNLS21NV2p1dmkyUmpubkUyTUhwMlphVVgwemkwbFho?=
 =?utf-8?B?cFZaekFwcitlOWJFUURSdjZOTUxacjR1d3U5T0tLd1V6b0VJakVheWdoOUVB?=
 =?utf-8?B?a2dVai9PcWFTWUtMRHRUOHNPajI4SCtId3NnWDZHSHNMUHBIZW9YeCtvWS9K?=
 =?utf-8?B?bG9ldTNCenFIVFZKQVBhNzBYNlBNeFYrSGZuZCtTSGEyT3BQRjFuZXR3SDFD?=
 =?utf-8?B?MC82ZGhjUXZUbXNLQ3lVS2tVK0cwd3E2dmNIL1QrZjBIUVk4TWFXZU1UUDZo?=
 =?utf-8?B?d1hpSTFVR2JPbGo3WlBRM1ZsaldIOFF6QTZCY1RWWS9rS0VBZ0l2MEszZmRI?=
 =?utf-8?B?RVYrSENPZ0dVSGg0QVZKWUJzSG9FMVg2aDRnTy9wUjVqT0xkbVpRb3UvUndl?=
 =?utf-8?B?VXFPeTNoNnJHeDljOWdWeTVMZy9aK0xoMjFLV3JmVGhXNXhuMGlBRlRndmZV?=
 =?utf-8?B?MHl4MFl6Zjh0UmxIa0ZHa3BGeUxTc2tNSzR0bmdrRVB3dko4b0ZDRDJXRjVP?=
 =?utf-8?B?aXlKYWlwQ0ZLb0RvTy90NGg0dHdKaStpYU8wLzQ3OXVLMEVhekNBUjhpN2Rz?=
 =?utf-8?B?dm9QdHR2SzJvTGMvNXZVNVlIcldsb2FiSk1HWFpaNCtMTHU2NUVjNUlITExy?=
 =?utf-8?B?Wm5NUjAvdGJ0SjZyN1NLNmJIdG1iTWtoQVpSbnlqRXFDcDI0RkRzZ0hjcXMr?=
 =?utf-8?B?Tzh5UjVwcndsUnRpeUR0VUFwTEo0bjE0NlFVUU9TSFBKL0daNGFwNC9KbFV3?=
 =?utf-8?B?K1ZCZDZIMjZGVVAxaHR0NE40UVl1UDhGZFJKT2FwMVRSMUgySXlvK2F1anVZ?=
 =?utf-8?B?ZGJpVzFVVzFjS1B0VGNCL2xyWlZKcVcxQTFjR3pWYXhDQkpVaFRoY3MxOEJN?=
 =?utf-8?B?bHVmUVNraEVSTmoyOGZleVlHRjJjOGN1RHVMM2ZmZkRFdGFPYStxRkFQR1Nn?=
 =?utf-8?B?UFFWWlpsaHJyQmc3Tm92eDFwWUdoTkhOOHd6VFNkVUhLQmxnQkpKVHpuV290?=
 =?utf-8?B?TGpnMDhiSFArZkFDMmlPdFV4akdJcEk0SUxmVHRkVWx4WVc1RHVweDk2alBY?=
 =?utf-8?B?TGV3K1c0ME1Vb01ES3lSQXVQYjlyVWRyaVdZa1d0YVdqeGpGL2kxY3F1K253?=
 =?utf-8?B?WThkOHRMczloZGl5UHVJdnBTcldkYUtGV2pKeEFhcGtpZ0ZkNDN4MDM3Q0hF?=
 =?utf-8?B?RXJQMjZjVG1xUEFJQnFreVczNXl1MUNETWdaandJdE1oSVduMXVmNlJtejRn?=
 =?utf-8?B?T2tRU3ArY2Fnb3lwQzRhc1pFaGpFNDY3YVNUdlY1dkN5ay9xREcyazVjaW95?=
 =?utf-8?B?V3dMaStUYWVuMnVsWGRCekx6UnJOWmRlTG5Uamg3Nk85WmRWRVFIRm8vMHgx?=
 =?utf-8?B?WkJ1aUUxYjFOU2N4Q2pqUmxVVndBdGFRSXNjQnZvbS9sMUtMZFBXbkxzY2ZQ?=
 =?utf-8?B?bXd1U1VJL2RkQThHUU1tSnBQL1l4Q0lvb3lnMHM2K1UvemZtYkNjRzJiWnhR?=
 =?utf-8?B?alhUSlZOSENoTDgzd1c3SFN3WmtVZ21hRWVWVWdZNlhFWlAxNEYyUHVtTkFr?=
 =?utf-8?B?Y3NCZDl2Mzh5MnozN3dvK3dvVGV0U0lGS011R2kzRU9ncit5dElBQ3FMR3NG?=
 =?utf-8?B?VDhPR1Z2K29DQnJlSDFoR21aNHJ5elArVmdZWWd5RTVwSHZXVFF3b3ZzNDE4?=
 =?utf-8?B?dmIwSEI3aHBRd095YlhHMUZYQnA4VTlmRThzZUZnQ2F0Lzlxc2xlbTdSZkZQ?=
 =?utf-8?Q?Jl8ePWvQ2UMpRkANmfT+Q5k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d863aafc-6f47-4f75-3bc3-08d9badeee98
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 06:41:30.1231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2DNYTSr9ycL0rw3rVgd3RVH4WINA7x5yoYKgADLMHBTiKjrn3V644f9BisNSCdVB2AVr2qKzT+KrbOlKcSn0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4191
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10192 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112090034
X-Proofpoint-GUID: 0sNTixeMBfnnaY3z5e0vRIJNhhHkjqEW
X-Proofpoint-ORIG-GUID: 0sNTixeMBfnnaY3z5e0vRIJNhhHkjqEW
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 08/12/2021 22:50, Josef Bacik wrote:
> On Wed, Dec 08, 2021 at 10:07:46PM +0800, Anand Jain wrote:
>> Recreating a new filesystem or adding a device to a mounted the filesystem
>> should remove the device entries under its previous fsid even when
>> confused with different device paths to the same device.
>>
>> Fixed by the kernel patch (in the ml):
>>    btrfs: harden identification of the stale device
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   tests/btrfs/254     | 110 ++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/254.out |   6 +++
>>   2 files changed, 116 insertions(+)
>>   create mode 100755 tests/btrfs/254
>>   create mode 100644 tests/btrfs/254.out
>>
>> diff --git a/tests/btrfs/254 b/tests/btrfs/254
>> new file mode 100755
>> index 000000000000..6c3414f73d15
>> --- /dev/null
>> +++ b/tests/btrfs/254
>> @@ -0,0 +1,110 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2021 Anand Jain. All Rights Reserved.
>> +# Copyright (c) 2021 Oracle. All Rights Reserved.
>> +#
>> +# FS QA Test No. 254
>> +#
>> +# Test if the kernel can free the stale device entries.
>> +#
> 
> Can you include the patch name here as well, it makes it easier when I'm
> rebasing our staging branch to figure out if I need to disable a new test for
> our overnight runs.
>   

  Ok. I will include.

>> +. ./common/preamble
>> +_begin_fstest auto quick
>> +
>> +# Override the default cleanup function.
>> +node=$seq-test
>> +cleanup_dmdev()
>> +{
>> +	_dmsetup_remove $node
>> +}
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -f $tmp.*
>> +	rm -rf $seq_mnt > /dev/null 2>&1
>> +	cleanup_dmdev
>> +}
>> +
>> +# Import common functions.
>> +. ./common/filter
>> +. ./common/filter.btrfs
>> +
>> +# real QA test starts here
>> +_supported_fs btrfs
>> +_require_scratch_dev_pool 3
>> +_require_block_device $SCRATCH_DEV
>> +_require_dm_target linear
>> +_require_btrfs_forget_or_module_loadable
>> +_require_scratch_nocheck
>> +_require_command "$WIPEFS_PROG" wipefs
>> +
>> +_scratch_dev_pool_get 3
>> +
>> +setup_dmdev()
>> +{
>> +	# Some small size.
>> +	size=$((1024 * 1024 * 1024))
>> +	size_in_sector=$((size / 512))
>> +
>> +	table="0 $size_in_sector linear $SCRATCH_DEV 0"
>> +	_dmsetup_create $node --table "$table" || \
>> +		_fail "setup dm device failed"
>> +}
>> +
>> +# Use a known it is much easier to debug.
>> +uuid="--uuid 12345678-1234-1234-1234-123456789abc"
>> +lvdev=/dev/mapper/$node
>> +
>> +seq_mnt=$TEST_DIR/$seq.mnt
>> +mkdir -p $seq_mnt
>> +
>> +test_forget()
>> +{
>> +	setup_dmdev
>> +	dmdev=$(realpath $lvdev)
>> +
>> +	_mkfs_dev $uuid $dmdev
>> +
>> +	# Check if we can un-scan using the mapper device path.
>> +	$BTRFS_UTIL_PROG device scan --forget $lvdev
>> +
>> +	# Cleanup
>> +	$WIPEFS_PROG -a $lvdev > /dev/null 2>&1
>> +	$BTRFS_UTIL_PROG device scan --forget
>> +
>> +	cleanup_dmdev
>> +}
>> +
>> +test_add_device()
>> +{
>> +	setup_dmdev
>> +	dmdev=$(realpath $lvdev)
>> +	scratch_dev2=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
>> +	scratch_dev3=$(echo $SCRATCH_DEV_POOL | awk '{print $3}')
>> +
>> +	_mkfs_dev $scratch_dev3
>> +	_mount $scratch_dev3 $seq_mnt
>> +
>> +	_mkfs_dev $uuid -draid1 -mraid1 $dmdev $scratch_dev2
>> +
>> +	# Add device should free the device under $uuid in the kernel.
>> +	$BTRFS_UTIL_PROG device add -f $lvdev $seq_mnt
>> +
> 
> You need to redirect this to /dev/null, otherwise we get the TRIM message with
> newer btrfs-progs.
> 

   Ok.


>> +	_mount -o degraded $scratch_dev2 $SCRATCH_MNT
>> +
>> +	# Check if the missing device is shown.
>> +	$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
>> +					_filter_btrfs_filesystem_show
>> +
>> +	$UMOUNT_PROG $seq_mnt
>> +	_scratch_unmount
>> +	cleanup_dmdev
>> +}
>> +
>> +test_forget
>> +test_add_device
>> +
>> +_scratch_dev_pool_put
>> +
>> +status=0
>> +exit
>> diff --git a/tests/btrfs/254.out b/tests/btrfs/254.out
>> new file mode 100644
>> index 000000000000..20819cf5140c
>> --- /dev/null
>> +++ b/tests/btrfs/254.out
>> @@ -0,0 +1,6 @@
>> +QA output created by 254
>> +Label: none  uuid: <UUID>
>> +	Total devices <NUM> FS bytes used <SIZE>
>> +	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
>> +	*** Some devices missing
> 
> I ran this on a box without your fix and I got this failure
> 
> [root@xfstests2 xfstests-dev]# cat /xfstests-dev/results//kdave/btrfs/254.out.bad
> QA output created by 254

> ERROR: cannot unregister device '/dev/mapper/254-test': No such file or directory

  Without the fix the error is expected.

> Label: none  uuid: <UUID>
>          Total devices <NUM> FS bytes used <SIZE>
>          devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
>          *** Some devices missing
> 
> Is this what you're expecting? 

  Hmm, no. Without the fix, we shouldn't see the missing here.

> I was expecting to not see the "*** Some devices
> missing" part as well, but I guess that's the racier part?

  Right. I am guessing race with udev auto scan?

> It does fail properly without the patch and pass with your patch, so as long as
> this is what you expect to see then I'm good with this part.  Thanks,

  Yeah, we shouldn't see missing device _without_ the fix.
  Could you please share your xfstests config?

Thanks, Anand

> 
> Josef

