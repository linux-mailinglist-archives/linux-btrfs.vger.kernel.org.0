Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1332C44BE3C
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 11:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhKJKHF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 05:07:05 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:65214 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229653AbhKJKG6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 05:06:58 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AA9Spg2032539;
        Wed, 10 Nov 2021 10:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=z2UBrULrWq5Bd0ZjjNDOxdVUm/5FiKK2bo9NfQCQyRc=;
 b=nXkznB8CLczcrQPoexS8Qy9YdEisYQbspA5xfg+1bqthjogb5hxKSyaBaNvov3iXnV2A
 pltlwvVdmcpvCRu1TBJeT5qX/lmsGXT1EDuGGAByFn89iCuK/McQlJHnGW6BUwS3Ru7C
 JsI0yJTta+YVy08XvPrnV69vW1bIVC7LL62Gk8XixzdsP/HqsFm4PAn4LGCjRM+Th7Eb
 gp4qqZyvLtaJc3Jbq8zfl6o+/E9uGX8aGsOMUco1/7Q07Z6u4XKTBVB8xadEAVmsPmpJ
 hGLFuLFeKumQEsHmrpp6aeIOYvkoZNHY1gNbRxfQJcp/ak6zXATENMYzh4iD5CCHv0rc 7g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c82vgakjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 10:04:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AA9u3ht154741;
        Wed, 10 Nov 2021 10:04:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by aserp3030.oracle.com with ESMTP id 3c5frfcfbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 10:04:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxzEPlKanGc73F6rXCn434yvmxbvx1bm+ffX8LRkIzPwAtUVh7n13eDoKeRQfF5c2QuqtHdWT7SmudTuswt2co5XOSvvnIbWEPURGL5THQSU0ixf8ykPa6xecDcXD4iJShjfgvf8cBilexIPwpdsHM5IQEJW6Ew5KyM1/kk+6AwBsCZW7+q+KGdG5La22w8bzdORTxmF0TbsPoFGYdGz3FIY10IxW2joQUQRnZqaXqOuDshqUXE2AURpknVcPHlb1GGmuBq+MvccQaI4v62vR4EiD1y1hSyULgO/yPp49box9uTu3G4fDu8TY+sInlvQZPk4hyxYW+pSLPCkXK04xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2UBrULrWq5Bd0ZjjNDOxdVUm/5FiKK2bo9NfQCQyRc=;
 b=YV8WdEdLcANjXinqP4FqGZSWvsASi30sAFpmggPlMUVEHir46An2kIAm7xgFpQVVCNjyl/h+2Gg1B3jbv+mor0ooNzTmh6PRMqYwj1pxggGH9ZyCHkFwHVg4JW8xiPWypMi2VabIjdgaaqGY+8wnij5OMtTbhZbYBQZr0+70YtpLsgWYdVmVYWuR9vWvhB1thXKGMs5Bys3+ZBPoDDZ7F/XUIIwky27mn+uPys1GbjFpQKLbwMO1fSFG/59y+8crHJ8GMJAReVLCn4VvNTHjJN0HenqrE9amiU1f11S1v23EvAfCUaZOpyp44AbBN6YQnO/+YUE6TwDWfuw1FCYJJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2UBrULrWq5Bd0ZjjNDOxdVUm/5FiKK2bo9NfQCQyRc=;
 b=UmaO1EoUESdlnPtjh5dESXq80D8SjECBdH64fTjNpMZeTn+wytsTmYozyt9g02u4mY3ZczHICS4PNilzYWlK3fkLLvSt9jrjOYyQzX9/SqeqtC6KDEb+nJALmfjLQcObKAMOJe5Be+apkD8WPihdhziVpnMX13RB+bCbme4xiGg=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5092.namprd10.prod.outlook.com (2603:10b6:208:326::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Wed, 10 Nov
 2021 10:04:04 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038%5]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 10:04:04 +0000
Subject: Re: [PATCH v3] btrfs: Test proper interaction between skip_balance
 and paused balance
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20211108142901.1003352-1-nborisov@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <9a98623c-f34a-8a64-f211-18e3e3439078@oracle.com>
Date:   Wed, 10 Nov 2021 18:03:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20211108142901.1003352-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0118.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::22) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.137] (39.109.140.76) by SG2PR01CA0118.apcprd01.prod.exchangelabs.com (2603:1096:4:40::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16 via Frontend Transport; Wed, 10 Nov 2021 10:04:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99757fc5-f0db-4125-ebd3-08d9a4316cfd
X-MS-TrafficTypeDiagnostic: BLAPR10MB5092:
X-Microsoft-Antispam-PRVS: <BLAPR10MB5092C0963D12E25565D32AECE5939@BLAPR10MB5092.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1kAm65QuLNceg6Tf/dIqGIgrsgCvOD4kdELAgk335y7My3RwQ0Vr2X3fF843Gb8gMQgIZEyDgRN2ykcocQG7i/ychhAeMtUO84SX/EGfomJdcmlDpSz3YKtPMNZRO10b9XBCJFVRKxIQjoiRan+2PlxU0CAzbD11W8NZVKJeYCkwM3bF1FmcpX6/4sYAECb/Co+qybjCQi37Af6nU3yZGFlA+FrAGkVfHF1dtSZQc64FTCewgZAe+IMdbgK46dGw46tLDlkFxHq9zs33/DXDU2Pmi7WvpULwc8kyvNMYzkPKG/7XH5GEIN7dDWelnwSNNj0m5IEddFvhSQglyiBUmgKXFxK988aqfQf7yD56XmMrcNNl2SgszPV71lwaFospJXSQ3xpInDiwE4R4/b118BVSuWi0XRMaEnaCyzE1j6TRS33w8vxDQbSGbKx7ObL8tUWLXQvtHWDtM+Qg1oxkN7p3THh50DLALVX1loX+ct+5n9pb9UQxBqc1eJSGXOMs/Yve4cQdKZPWjvmMsH10cMiBw+JF5x3eDoEb0mwQr6i1TXCcyrBSOdqqIw8aIL6ygrJQRF7Pq99k4u5nbB2dvy/MjbgNwvwCaUinYlC1UJv0IxjYSbLuvnE7hb/CzQKZJ/g4xPGFJ7kdJWZiTheR6EksSBHfl/FfHzDV4PgAh53t72LzpkURdzbB/nkke7XvqlabjggxMCjtOgoD1lC5nA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(36756003)(5660300002)(44832011)(2906002)(316002)(8676002)(508600001)(2616005)(956004)(8936002)(186003)(31686004)(31696002)(83380400001)(26005)(66476007)(38100700002)(66556008)(53546011)(6486002)(66946007)(6666004)(16576012)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEpXWFF3YnhHdW9uYysrVkR0RkVjend3T2NoYzJwSE8rdWpjSWkrSTM3bGtY?=
 =?utf-8?B?SXBuc2pVY0p4K2ErZzRSZ0xFc2tOcW80eG1iV29zRHpPZHNKTENZMTlyZDky?=
 =?utf-8?B?NEZ3MW9PT2JxcGgzc011ZHpLQlgrTEVMUE9yUVBPMkxZMVpwTmNvVlQyYndn?=
 =?utf-8?B?WWQ4M3I0UEZFbmo3OWp5cWwrSnpPa0ExcXFTZm8zRmgyemt5bERTd1BWVklz?=
 =?utf-8?B?SWcvWFg1QXRUc3pjWlhMNjI3OTdDdGl4U280bHdnbGgwUHRPeGFQZlA1ZWVs?=
 =?utf-8?B?bUNpTDF0NXRCWEM0dXpCcGRmZGVNUWJjZktDTXQyb3I4Wnh2bVR0YkdXQkJX?=
 =?utf-8?B?ck1ZSS8zZlpPQW13YlQ4ZVJNcHZ2OXNLekpFbXNqNGUyMkpNb3VHQTJ5azBO?=
 =?utf-8?B?SWpBcVNJSUFaaTN1WndXb3NST3czaVBFaU0zd0lvYnBUUlhVZExKRVp5ZzlR?=
 =?utf-8?B?TnpoanFscExNcVNlNDQzUXRYcTV4enErTDFGQk9qSTBmbGtPZCtBOHpJNlFB?=
 =?utf-8?B?QWhTakY2MVljS3l3ZExSSS9FN2t2TnRsSEx0OURDZDM4VWFNaFNvZXZjaUx6?=
 =?utf-8?B?TzlGakFkSXpLTXA3UkhTeDJFbWQrNzBoa1d1OGlidWhuNUdQY1Y4ejNZU0tL?=
 =?utf-8?B?ZlpOOVFab3FRT0hCOTBvSUNKaHF0eUJhSlZudlE0WUt4czVDcVU4dUxvQjlh?=
 =?utf-8?B?UUh1aEpFc0tyaS9wMExhck9PN1BIWWUzaTVuYk1ib0NQd3JCYTVVRVpPSHEz?=
 =?utf-8?B?ODlvVm8wVHN3MnlEY2VUb0M3cU1rTE10TVQrSEVqWCtlZ1hkSTduU3JkbVpZ?=
 =?utf-8?B?RFRKa255L1BrMmNuWU5PN01NSGF1Y3d6Mkl5cEt2QVR0SmRvVFc4Q0REelVE?=
 =?utf-8?B?VWdGcUo4cVJhM2g2WWxyOGI4azA2WFBpQWdNaitxQytKdC9pcHB5K2U5S1Ix?=
 =?utf-8?B?WUtOaHI0d2lKSjNZWGl3aGRWa3NZenJxQTJnVUJmMkxqNUQ4eXBMdXYyK0tr?=
 =?utf-8?B?Wjd4U2lzbWQyYjVsTXdhaSs2YlFIanNjQ0d5YkhBL0dYOUorbFAwSGRPbTg4?=
 =?utf-8?B?a1p5eHpEdTE3TDRYV044OFRqWjBxd25iR2pZeTJOWXdrOEtqQTk3MUZ3U3JM?=
 =?utf-8?B?dEVHNWIrVW42a1llcXJVbXJBeFNqVUVqYlNpcVJEbFFiZEJIb0ZmMXBKNEVl?=
 =?utf-8?B?R3pxYlRlU2FjRTFmNFFCbU9vclc5N0ZLcTN4V29Yc0tzYzA0cENwUVIvK3NK?=
 =?utf-8?B?clF4SlpFaFFneFpjaDBvZGcwZDRRZmJIOWQ0RjE0OSs1Z2tTQURMd05YY3FI?=
 =?utf-8?B?MnVvVTF2bWRqVFptdkMzcElldGNXbERFNlM4YisrMy9uQW9MK1d0Wkc4d1R0?=
 =?utf-8?B?QktVZWNVMVkvcWJ5Rnd5TGJpeFMzNHNrWEkvS3hkdnBPVTBUYXZKWlJKSFdB?=
 =?utf-8?B?Ujhid3NNTG5xN3JEbmp6cEhNamhEdnFXUDF3S01CYlpCOGVaNmdoMHZ0MjJS?=
 =?utf-8?B?em5JbzJ5Vk5BVzhkU0Zra1pHWGVKdVlGdWpCWHBsLzN4Z0V5bEtzekE2Zktu?=
 =?utf-8?B?a1AwdmVoSC90dEo0b21nODF0YStFRXpUMi9QL0xrbXVxcDJEaFl3eUJyUmlQ?=
 =?utf-8?B?UVZMVmdRTzgya2VOeVQ4aWdoT3p5Z1JZbDEzTTNsaENWR2tRKzNxVjMxQy80?=
 =?utf-8?B?c0o1SE9KdWJSRkpTejVyOC8yTlM3S3RrcW1yMGRBMWsxanAvY0V0cWhYSkZt?=
 =?utf-8?B?YkxIemVsS1cxQ0VHZXFrWFo3amRjaHE1cXQvMGhMR1FZMWh1Z0d0L1locVpY?=
 =?utf-8?B?V3pFV0VQTUVvQ3Uva2ZFUHAvNGV3dkNJRG5mV1dOQzFGK1RwMXJjZUZMQk1u?=
 =?utf-8?B?OHE5THVyRUtxTDliRTZ6MkRnWndPVUxDOHBOQ09wWXJzQUtWVDgwcW5PSlB1?=
 =?utf-8?B?U1ZNd3MydXVnNkV5b25EMWtZRHJVbFdwbXUrOFdBazRTblVTaVZHam8yMDZk?=
 =?utf-8?B?cEtjTUJrRDg3OUlKQUwvYkROU29hZjVJWUpuUWozWjB2VUY2Rnp3NzlnN2Jh?=
 =?utf-8?B?RVJQbW5zYlB5RFJ5WTJwVE9qNzZLeGxPN0xXdG5BOXVCWGdFUWZjaks4K1Nn?=
 =?utf-8?B?MUNUbi96clBqY2V6c2JLT21KZDIzOHE2MUMzYWJobkxFc2U3UEpDNDhRMk85?=
 =?utf-8?Q?vX/VUlZfA15W7RXWXHuy2PU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99757fc5-f0db-4125-ebd3-08d9a4316cfd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 10:04:04.1496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1A+ZTN+JGAK08u+CHXQFYEuGA/7Eu6K63X8+hX+GA4Uj017PdlazGb30K4o8Ry93o1VvRw1V9vZYlhv3P6wKYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5092
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10163 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111100054
X-Proofpoint-ORIG-GUID: 6UoFHUlbSVoCBHmfrUp-DbdHFx2r5O2o
X-Proofpoint-GUID: 6UoFHUlbSVoCBHmfrUp-DbdHFx2r5O2o
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/11/21 10:29 pm, Nikolay Borisov wrote:
> Ensure a device can be added to a filesystem that has a paused balance
> operation and has been mounted with the 'skip_balance' mount option
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
> 
> V3:
>   * Added swapon to the list of exclusive ops
>   * Use _spare_dev_get
>   * Test balance resume via progs while balance is paused. I hit an assertion failure
>   outside of xfstest while doing this sequence of steps so let's add it to
>   ensure that's not regressed.
> 
>   tests/btrfs/049     | 92 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/049.out |  1 +
>   2 files changed, 93 insertions(+)
>   create mode 100755 tests/btrfs/049
> 
> diff --git a/tests/btrfs/049 b/tests/btrfs/049
> new file mode 100755
> index 000000000000..d01ef05e5ead
> --- /dev/null
> +++ b/tests/btrfs/049
> @@ -0,0 +1,92 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test 049
> +#
> +# Ensure that it's possible to add a device when we have a paused balance
> +# and the filesystem is mounted with skip_balance. The issue is fixed by a patch


> +# titled "btrfs: allow device add if balance is paused"

It is a new feature, not a bug fix? The kernel patch won't backport to
the stable kernels. Then on older kernels, this test has to exit with
_notrun().
Is there any way to achieve this? There isn't any sysfs interface that
will help and, so far we haven't used the kernel version to achieve
something like this.



> +#
> +. ./common/preamble
> +_begin_fstest quick balance auto
> +
> +# real QA test starts here
> +
> +_supported_fs btrfs
> +_require_scratch_swapfile
> +_require_scratch_dev_pool 3
> +
> +_scratch_dev_pool_get 2
> +_spare_dev_get
> +
> +swapfile="$SCRATCH_MNT/swap"
> +_scratch_pool_mkfs >/dev/null
> +_scratch_mount
> +_format_swapfile "$swapfile" $(($(get_page_size) * 10))
> +
> +check_exclusive_ops()
> +{
> +	$BTRFS_UTIL_PROG device remove 2 $SCRATCH_MNT &>/dev/null
> +	[ $? -ne 0 ] || _fail "Successfully removed device"
> +	$BTRFS_UTIL_PROG filesystem resize -5m $SCRATCH_MNT &> /dev/null
> +	[ $? -ne 0 ] || _fail "Successfully resized filesystem"
> +	$BTRFS_UTIL_PROG replace start -B 2 $SPARE_DEV $SCRATCH_MNT &> /dev/null
> +	[ $? -ne 0 ] || _fail "Successfully replaced device"
> +	swapon "$swapfile" &> /dev/null
> +	[ $? -ne 0 ] || _fail "Successfully enabled a swap file"
> +}
> +
> +uuid=$(findmnt -n -o UUID $SCRATCH_MNT)
> +
> +# Create some files on the so that balance doesn't complete instantly
> +args=`_scale_fsstress_args -z \
> +	-f write=10 -f creat=10 \
> +	-n 1000 -p 2 -d $SCRATCH_MNT/stress_dir`
> +echo "Run fsstress $args" >>$seqres.full
> +$FSSTRESS_PROG $args >/dev/null 2>&1
> +
> +# Start and pause balance to ensure it will be restored on remount
> +echo "Start balance" >>$seqres.full
> +_run_btrfs_balance_start --bg "$SCRATCH_MNT"
> +$BTRFS_UTIL_PROG balance pause "$SCRATCH_MNT"
> +$BTRFS_UTIL_PROG balance status "$SCRATCH_MNT" | grep -q paused
> +[ $? -eq 0 ] || _fail "Balance not paused"
> +
> +# Exclusive ops should be blocked on manual pause of balance
> +check_exclusive_ops
> +
> +# Balance is now placed in paused state during mount
> +_scratch_cycle_mount "skip_balance"
> +
> +# Exclusive ops should be blocked on balance pause due to 'skip_balance'
> +check_exclusive_ops
> +
> +# Device add is the only allowed operation
> +$BTRFS_UTIL_PROG device add -K -f $SPARE_DEV "$SCRATCH_MNT"
> +
> +# Exclusive ops should still be blocked on account that balance is still paused
> +check_exclusive_ops
> +
> +# Should be possible to resume balance after device add
> +$BTRFS_UTIL_PROG balance resume "$SCRATCH_MNT" &>/dev/null
> +[ $? -eq 0 ] || _fail "Couldn't resume balance after device add"
> +
> +# Add more files so that new balance won't fish immediately
> +$FSSTRESS_PROG $args >/dev/null 2>&1
> +
> +# Now pause->resume balance. This ensures balance paused is properly set in
> +# the kernel and won't trigger an assertion failure.
> +echo "Start balance" >>$seqres.full
> +_run_btrfs_balance_start --bg "$SCRATCH_MNT"
> +$BTRFS_UTIL_PROG balance pause "$SCRATCH_MNT"
> +$BTRFS_UTIL_PROG balance status "$SCRATCH_MNT" | grep -q paused
> +[ $? -eq 0 ] || _fail "Balance not paused"
> +$BTRFS_UTIL_PROG balance resume "$SCRATCH_MNT" &>/dev/null
> +[ $? -eq 0 ] || _fail "Balance can't be resumed via IOCTL"
> +
> +_spare_dev_put
> +_scratch_dev_pool_put
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/btrfs/049.out b/tests/btrfs/049.out
> index cb0061b33ff0..c69568ad9323 100644
> --- a/tests/btrfs/049.out
> +++ b/tests/btrfs/049.out
> @@ -1 +1,2 @@
>   QA output created by 049
> +Silence is golden
> --
> 2.17.1
> 

