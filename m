Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C78D38E8AD
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 May 2021 16:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbhEXO0D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 May 2021 10:26:03 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38288 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbhEXO0B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 May 2021 10:26:01 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14OEJH1X055595;
        Mon, 24 May 2021 14:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ujaBOLUrtEBgtMnLoXl4xUVsobiocn6Ljy5aLIICcuQ=;
 b=iKKRd1AF9biJoxhvtirB7+rIVVQydEpZ8w0Gs5qGAALghZay7BJII4ug7F/8a6yjT/G+
 zHyBqxmhbO7DVN+99Yx9rmxbfmodE7U128XaZLzpbCiL3QNFppUcBgbFIjQui9J0crGc
 YpkwD/OBgOhSEMnycnc4WIHqbwZiClArw5AuvMcH+h7cpPIPZ3cjumKTHEeRiVO85OfR
 VldYXS0yGIem9ZV4qZwU/h2qit5hhSwMWoFctVWkPRxC5YqPQGc9QyZFjWwx4ynuTh8p
 Caa5EI6vXBIIIhYWq9D4Le8v1b798CYIduKjANllLlpGTfFUMudOO+afh6KlFlNjyeaa cw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 38pswnb6sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 May 2021 14:24:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14OEG6XZ020316;
        Mon, 24 May 2021 14:24:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by userp3020.oracle.com with ESMTP id 38qbqr8v17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 May 2021 14:24:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDspqFUfx1e587H6R2bPoZ3i/HaTDxRbqp6nXVztPBp6CNmG2e13GchUmMVnNgv5wB9DdOQpqYh/moEQTAxGPl7JuI0jo6LU42JXUW2UKFKu2jCIV0/EuOvZVyF6T7n6UcKO3BOmwu5oLx3gtnKGmBcr4Zo/IhBplVCIaNaVqsFURlTFemrY3Og4wP33GCRdYpJnBYw3+su6Plo9I+WUuySlmaZuHp0vUEK4IQT/fuStXtcK58L59+DBCSpGzAGjMoOkBhmOeAntFqLzSbA89Corp8upxl6efm0hMpsT1MBR+qfv7Jj+SaVNJDe866hHoww0OYTieJXNrEBhCkW0VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujaBOLUrtEBgtMnLoXl4xUVsobiocn6Ljy5aLIICcuQ=;
 b=ZM0mCkjYJpo5XfMNPevFnyNUBsH2YqtIfXiOCv+vJWRQ31u8kkV/c0xhUBldyFmHHw6JkHsGEXzrg2hGf+s0uARw7rlzVAkrwbETWxSfuVuVFs9j305xuc59dMIPirohWNo8h2AkqtjwQa02LnwDiIMyTy7YSr7oMyWlo2BLm6Fu64HoVB27f2pHTNGvhfjOHxF3MCHDf6txV3vp/mlrtvLMB2CwHAPOgOrDexb+GVhrruNTjKUURDu7YeduLjMhD3WZHfeDRf8RSofmkz53y3qRKD7seKwsH1ZQYzyiXAhi9WBmiP4gm3iZ2yOFBq2gnJ+EqHHSmkdRYPNML51xEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujaBOLUrtEBgtMnLoXl4xUVsobiocn6Ljy5aLIICcuQ=;
 b=hC3lhqZ4hfGPrFVmeaFO63Fy7FKg6PvElW17pZ6ODTTjdzmbCCYP4Td1TyqawaCSeEv4XOswW9h+hKgILcuIXhn2+lWr/Iu5eAOIXQ6sRncstCmPk6t2oF4ahRihi582nqbquHSLvt3TurlVFM2U3f7M9OWXPTvevxP9GHLHGgk=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2803.namprd10.prod.outlook.com (2603:10b6:208:7f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 24 May
 2021 14:24:24 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%9]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 14:24:24 +0000
Subject: Re: [PATCH] btrfs: add test for multiple fsync with adjacent
 preallocated extents
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <4c3dd698cb68ea0c465ea5028d677b3443b8cf3c.1621852397.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <6df57e68-5e5a-58fb-d8b6-29f613dc38ef@oracle.com>
Date:   Mon, 24 May 2021 22:24:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
In-Reply-To: <4c3dd698cb68ea0c465ea5028d677b3443b8cf3c.1621852397.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR03CA0166.apcprd03.prod.outlook.com
 (2603:1096:4:c9::21) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR03CA0166.apcprd03.prod.outlook.com (2603:1096:4:c9::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.12 via Frontend Transport; Mon, 24 May 2021 14:24:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d89f23a9-d3f8-4bbf-214e-08d91ebfa118
X-MS-TrafficTypeDiagnostic: BL0PR10MB2803:
X-Microsoft-Antispam-PRVS: <BL0PR10MB280338D88CB6179CDD7DA3A6E5269@BL0PR10MB2803.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1NeYoMMLBop1eZID617aJ/DNWsshp8y9EUUQ3ez6XQhtmn1JQHgtR1X+Nsp7YIqv3CFpq5kNaC2ae6nsvGPOfPgepBy3H7F6YzeMOixCybRfFMcm29VHHIkgM5YRFIrGWDrQibVdt3JbGfKapAgEVy1JnCqFkaC2snaP9N3PFrH+MbYyg0aQpy08Es1LnJ9GOVFJFcR+UgKnlXTZLJmzjDCF4OxlXDKI5MJxV1eVm0rVBpQD+kIRo2/x2RJ3kEtnFUNSLR7XvLpb6n6vgIlk/AVt7zCT1JN4A2aKjyILRBvTvsVz/13Z26u86T8cDqyIgAspq47yASEfMUrIQ/3+kI0vfa8H1ioNSz9H8ryb+tLP2dnJsosAeVye+KkfFtJVZarnQrIFDkp2AiEIIeJN6EAwZfrgkKqPfCw0EMf1cRmKtohTETRqgs0ffMRIloiolyHEMxqIGkCO9cfESGO9cfjZdAoEeBi5i/sYgJCy1nf68KQzbVKs5PnLQ8BGddoG/JUh1sPZjMI75pD2oGoP2MudYKmnAtWbgfF31VFWyjTTrEEwpWVM7V10vUAR15Z9rwjqHceN80yJmHveVrTb54T+9Ff4n3u56JlLtg3UuETSlbY1Edx1nMP4uXXO3znuGGbIEyA+DvCLIz6oN7CXwbTbbNlG1kQyCBJbPJZh/Vw+NjeP82tUbUgY+UgeaH1eSVJPLpFqYEeOhi1z9jGGOHyCwGhIrsg6hpjYEJytMzs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(396003)(136003)(6486002)(956004)(478600001)(16526019)(316002)(66476007)(4326008)(2616005)(53546011)(186003)(38100700002)(66556008)(8936002)(5660300002)(16576012)(83380400001)(2906002)(8676002)(36756003)(31696002)(66946007)(31686004)(6666004)(86362001)(44832011)(26005)(21314003)(45980500001)(43740500002)(505234006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dVJ2MXNnMEkvL2hGcDJkSTNDeEVpM1BKdldNRlN3QTN3U3d1SldLY3NHc3h0?=
 =?utf-8?B?MDR4eWhwYXBxTnByTWphbWttRFZwSzRyaFArVUtWMkZoa1kvbGNjY1ZKUnVs?=
 =?utf-8?B?T2hGdkhrTEhkTmU3Vk9NZkxFNWgzS28rQXRBVnFqUkVacmNuRWFHRzRqWWtY?=
 =?utf-8?B?MnZJZE9CK1pEZGNqN1pIalJocVIxNVFsY1ZIMzJ1eVN3WnJUYk16M08rRXVL?=
 =?utf-8?B?SWdYb0dkZllWZUpZK3IxNlU5ME15MWNKWW9TaHcwWUpzbXRpSVF5bTEvajln?=
 =?utf-8?B?KzRSdFFyd1R1Sy8wUjJxdkVOMkZRVHBJMDFjem1YcTVyWkhGbEhQQzlFd3JH?=
 =?utf-8?B?UDFhYjE1eFJaVFlReVdQS2xzeDNrTGRxWVVkZ3hUUysvbjNSVkJ5YStmRXhx?=
 =?utf-8?B?MGFDQU52VVNtNHpucThEZWI1WmVYcEpJV040MlBnRW8wNlFwQmdKMjd0ME9W?=
 =?utf-8?B?T1c4UGJ0cGJrZWcyYU45MjZDc0M3TG5mdmVUa2tzZ1l5NHkwS0JqVUhQMm05?=
 =?utf-8?B?NWlOM0ZINFZQcXROWDFrMm1LUkZ5QlNSSk5GNWwvTHVVWG1hcksrU1RpUm4r?=
 =?utf-8?B?dW54UkZJN1Y2OXc4OTk5clMvMUxqeEhDd2s5N1RubXRXd3k4dEd2QjVCdllZ?=
 =?utf-8?B?aEJtZFRCM1Vqak9iWVVMK0xsMmdOUkVIeUc1WkZzRG9odi94QXNxK3lhSk5k?=
 =?utf-8?B?aVlqeEs4enArbUNWVkxoOVNKbm1HbmoxTDJzVlE4TERoYU44ZmRFYzV4YXNT?=
 =?utf-8?B?RGlBZ0k3SVFvbngvalR3bW13T29ackh1ektUL2ppR2VRSExpVTlzRm9iRW1W?=
 =?utf-8?B?WUtIWHZPcE1pdWs4NWpVU3hBRDU3WkRKdUVMQ2lER2s1TTdVQmtGVS9wYWwv?=
 =?utf-8?B?bm9jSE44aFgrZlY3eVRRV2FmNUFMUUxhWnlrU0ZoRWkyQmNlNkhGbjNCVG5j?=
 =?utf-8?B?RFRWYzBkM21JYS9VemxtcWtyaU1mZUNPTFd5a3h2V1hlNHQvYWRHaVAzek9T?=
 =?utf-8?B?S2NsUVdHejMrUFYyVTFtWmVqT01mVEh6dnlkYkt4Vnk2NXIvTEh2N3RnNUwx?=
 =?utf-8?B?dW4yYi9EYzF6aUdTVjhXWU5UU0NzVUFLeElyb3NKbzdaYTgvZExqNDlmb1Ba?=
 =?utf-8?B?YUhxN2llZzltNFVOSUxhTDBBeTdKTTBPRzVObGI1NU5Wdm5Hcmlkc3BZN1FK?=
 =?utf-8?B?V1pOOTE5QzZ5VytlNDErTFZhTlFleFJVd2tuMzNYdktEOHpWUWI0dXdEK1Fk?=
 =?utf-8?B?bWlvaktPOU1CL3huQy9GaXpTYnFOZCs3OUNXOGIvclM3WlBqM0xibEJKZFhB?=
 =?utf-8?B?M0JMWDZHRmE5anpTaG04MWliZnBpUThMRnVCSmUvbUpPWk5xei9oSk04a3A0?=
 =?utf-8?B?cXkvRUNpbGYvb3A3SURCNTh3RVVvamtVVEpScjhGVGVlNEpUYVlzSjIycCtu?=
 =?utf-8?B?a1QyYWtGaklkbGRpbTFNYWI4RURVcVpITTRpRnJyOXFQamVMN2RRWjBVRGw0?=
 =?utf-8?B?aXBYQ3NibDRDOExlc0tNdGJPUjlNNm4vbGs2cDhWZzJaUExEc3cwUjZjTXpX?=
 =?utf-8?B?WWFteEFsTFlTNzhyclduTXRmckxGUGhzaFZUajJCdUxlZzdsOTR6cWhGSWFp?=
 =?utf-8?B?TTdkYko0U2l1NTIzcUNVVFFYNmY1QUZwN1laUFZISnhzbkYxSE5ORGkzdUpD?=
 =?utf-8?B?NjRCeS9JZmJFeCsvV213SzNiTVoySnRIaVNxMXdkbzdLTUdTdnRwcFBPUVl3?=
 =?utf-8?Q?FISJsw66H8JbHGUxb15CMWIoSMtyZpUikIii6mL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d89f23a9-d3f8-4bbf-214e-08d91ebfa118
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2021 14:24:24.5152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KmXIJGGkQ25yhGLdVHvJ3lBFnyNHxvE+BjmS5lGik4hg99rjeRRk++gjTqVHWROuv1V/kjpjj/tes7MRU//ohQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2803
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9993 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105240090
X-Proofpoint-GUID: NTkFNIb4pEyM8cXm60Nf8NIYvOicnBHX
X-Proofpoint-ORIG-GUID: NTkFNIb4pEyM8cXm60Nf8NIYvOicnBHX
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9993 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 suspectscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105240090
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/5/21 6:37 pm, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test a scenario where we do several partial writes into multiple
> preallocated extents across two transactions and with several fsyncs
> in between. The goal is to check that the fsyncs succeed.
> 
> Currently the last fsync fails with an -EIO error, and it aborts the
> current transaction. This issue is fixed by a patch with the following
> subject:
> 
>    "btrfs: fix fsync failure and transaction abort after writes to prealloc extents"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Tested on aarch64 pagesize = 64K.

Thanks, Anand

> ---
>   tests/btrfs/240     | 173 ++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/240.out |  29 ++++++++
>   tests/btrfs/group   |   1 +
>   3 files changed, 203 insertions(+)
>   create mode 100755 tests/btrfs/240
>   create mode 100644 tests/btrfs/240.out
> 
> diff --git a/tests/btrfs/240 b/tests/btrfs/240
> new file mode 100755
> index 00000000..c799848f
> --- /dev/null
> +++ b/tests/btrfs/240
> @@ -0,0 +1,173 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FSQA Test No. 240
> +#
> +# Test a scenario where we do several partial writes into multiple preallocated
> +# extents across two transactions and with several fsyncs in between. The goal
> +# is to check that the fsyncs succeed. This scenario used to trigger an -EIO
> +# failure on the last fsync and turn the filesystem to RO mode because of a
> +# transaction abort.
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	_cleanup_flakey
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/dmflakey
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_require_scratch
> +_require_dm_target flakey
> +_require_xfs_io_command "falloc"
> +
> +rm -f $seqres.full
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_require_metadata_journaling $SCRATCH_DEV
> +_init_flakey
> +_mount_flakey
> +
> +
> +# Create our test file with 2 preallocated extents. Leave a 1M hole between them
> +# to ensure that we get two file extent items that will never be merged into a
> +# single one. The extents are contiguous on disk, which will later result in the
> +# checksums for their data to be merged into a single checksum item in the csums
> +# btree.
> +#
> +$XFS_IO_PROG -f \
> +	     -c "falloc 0 1M" \
> +	     -c "falloc 3M 3M" \
> +	     $SCRATCH_MNT/foobar
> +
> +# Now write to the second extent and leave only 1M of it as unwritten, which
> +# corresponds to the file range [4M, 5M[.
> +#
> +# Then fsync the file to flush delalloc and to clear full sync flag from the
> +# inode, so that a future fsync will use the fast code path.
> +#
> +# After the writeback triggered by the fsync we have 3 file extent items that
> +# point to the second extent we previously allocated with fallocate():
> +#
> +# 1) One file extent item of type BTRFS_FILE_EXTENT_REG that covers the file
> +#    range [3M, 4M[
> +#
> +# 2) One file extent item of type BTRFS_FILE_EXTENT_PREALLOC that covers the
> +#    file range [4M, 5M[
> +#
> +# 3) One file extent item of type BTRFS_FILE_EXTENT_REG that covers the file
> +#    range [5M, 6M[
> +#
> +# All these file extent items have a generation of 6, which is the ID of the
> +# transaction where they were created. The split of the original file extent
> +# item is done at btrfs_mark_extent_written() when ordered extents complete for
> +# the file ranges [3M, 4M[ and [5M, 6M[.
> +#
> +$XFS_IO_PROG -c "pwrite -S 0xab 3M 1M" \
> +	     -c "pwrite -S 0xef 5M 1M" \
> +	     -c "fsync" \
> +	     $SCRATCH_MNT/foobar | _filter_xfs_io
> +
> +# Commit the current transaction. This wipes out the log tree created by the
> +# previous fsync.
> +sync
> +
> +# Now write to the unwritten range of the second extent we allocated,
> +# corresponding to the file range [4M, 5M[, and fsync the file, which triggers
> +# the fast fsync code path.
> +#
> +# The fast fsync code path sees that there is a new extent map covering the file
> +# range [4M, 5M[ and therefore it will log a checksum item covering the range
> +# [1M, 2M[ of the second extent we allocated.
> +#
> +# Also, after the fsync finishes we no longer have the 3 file extent items that
> +# pointed to 3 sections of the second extent we allocated. Instead we end up
> +# with a single file extent item pointing to the whole extent, with a type of
> +# BTRFS_FILE_EXTENT_REG and a generation of 7 (the current transaction ID). This
> +# is due to the file extent item merging we do when completing ordered extents
> +# into ranges that point to unwritten (preallocated) extents. This merging is
> +# done at btrfs_mark_extent_written().
> +#
> +$XFS_IO_PROG -c "pwrite -S 0xcd 4M 1M" \
> +	     -c "fsync" \
> +	     $SCRATCH_MNT/foobar | _filter_xfs_io
> +
> +# Now do some write to our file outside the range of the second extent that we
> +# allocated with fallocate() and truncate the file size from 6M down to 5M.
> +#
> +# The truncate operation sets the full sync runtime flag on the inode, forcing
> +# the next fsync to use the slow code path. It also changes the length of the
> +# second file extent item so that it represents the file range [3M, 5M[ and not
> +# the range [3M, 6M[ anymore.
> +#
> +# Finally fsync the file. Since this is a fsync that triggers the slow code path,
> +# it will remove all items associated to the inode from the log tree and then it
> +# will scan for file extent items in the fs/subvolume tree that have a generation
> +# matching the current transaction ID, which is 7. This means it will log 2 file
> +# extent items:
> +#
> +# 1) One for the first extent we allocated, covering the file range [0, 1M[
> +#
> +# 2) Another for the first 2M of the second extent we allocated, covering the
> +#    file range [3M, 5M[
> +#
> +# When logging the first file extent item we log a single checksum item that has
> +# all the checksums for the entire extent.
> +#
> +# When logging the second file extent item, we also lookup for the checksums that
> +# are associated with the range [0, 2M[ of the second extent we allocated (file
> +# range [3M, 5M[), and then we log them with btrfs_csum_file_blocks(). However
> +# that results in ending up with a log that has two checksum items with ranges
> +# that overlap:
> +#
> +# 1) One for the range [1M, 2M[ of the second extent we allocated, corresponding
> +#    to the file range [4M, 5M[, which we logged in the previous fsync that used
> +#    the fast code path;
> +#
> +# 2) One for the ranges [0, 1M[ and [0, 2M[ of the first and second extents,
> +#    respectively, corresponding to the files ranges [0, 1M[ and [3M, 5M[.
> +#    This one was added during this last fsync that uses the slow code path
> +#    and overlaps with the previous one logged by the previous fast fsync.
> +#
> +# This happens because when logging the checksums for the second extent, we
> +# notice they start at an offset that matches the end of the checksums item that
> +# we logged for the first extent, and because both extents are contiguous on
> +# disk, btrfs_csum_file_blocks() decides to extend that existing checksums item
> +# and append the checksums for the second extent to this item. The end result is
> +# we end up with two checksum items in the log tree that have overlapping ranges,
> +# as listed before, resulting in the fsync to fail with -EIO and aborting the
> +# transaction, turning the filesystem into RO mode.
> +#
> +$XFS_IO_PROG -c "pwrite -S 0xff 0 1M" \
> +	     -c "truncate 5M" \
> +	     -c "fsync" \
> +	     $SCRATCH_MNT/foobar | _filter_xfs_io
> +
> +echo "File content before power failure:"
> +od -A d -t x1 $SCRATCH_MNT/foobar
> +
> +# Simulate a power failure and mount again the filesystem. The file content
> +# must be the same that we had before.
> +_flakey_drop_and_remount
> +
> +echo "File content before after failure:"
> +od -A d -t x1 $SCRATCH_MNT/foobar
> +
> +_unmount_flakey
> +
> +status=0
> +exit
> diff --git a/tests/btrfs/240.out b/tests/btrfs/240.out
> new file mode 100644
> index 00000000..ffd03ee6
> --- /dev/null
> +++ b/tests/btrfs/240.out
> @@ -0,0 +1,29 @@
> +QA output created by 240
> +wrote 1048576/1048576 bytes at offset 3145728
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 1048576/1048576 bytes at offset 5242880
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 1048576/1048576 bytes at offset 4194304
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 1048576/1048576 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +File content before power failure:
> +0000000 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> +*
> +1048576 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +*
> +3145728 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
> +*
> +4194304 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
> +*
> +5242880
> +File content before after failure:
> +0000000 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> +*
> +1048576 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +*
> +3145728 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
> +*
> +4194304 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
> +*
> +5242880
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index d7f2f3e5..ad59ed3e 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -242,3 +242,4 @@
>   237 auto quick zone balance
>   238 auto quick seed trim
>   239 auto quick log
> +240 auto quick prealloc log
> 

