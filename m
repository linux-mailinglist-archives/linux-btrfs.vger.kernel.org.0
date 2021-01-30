Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FEC309131
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Jan 2021 02:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhA3BO0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Jan 2021 20:14:26 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:40514 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbhA3BKC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Jan 2021 20:10:02 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10U18rr6020817;
        Sat, 30 Jan 2021 01:08:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=/IB82OA6fCwj5HPzE3/O0/5y3RaTZdUbkR6ON3Ef7+4=;
 b=xCeruK/C+CanIm9Qly/m0GUddYD+iEFVwli3oCtzTZCU2UTpoKHicseB/+5zBokv4Jkt
 UsSdbMVn3/Sw/d8lQyynUoX/tX9l3QXYuZY0rQXmTSxn+grHaDbxqUpI6+ImHcqVTpAu
 0JwwhuxAj7b3x889io52m7ENtSMlvn4GC2xJZkgxgOF6H60srBGAX6CBKptJ6CvLtzD3
 CeD+7b3lhmO80hN4BCluEN2fiHJOhWyLROUiDKs9ZryOdA8ePAVWztBwoa3CJ7qIxxfW
 r1mUozaLvaNJ2zVp/ZDidY6zXiEg8lelIKwhZUm1HJI3IykJ2GFkNtFsBC8n3XQNFn3p Ow== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 36cmf8a2vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Jan 2021 01:08:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10U0kHe1068435;
        Sat, 30 Jan 2021 01:08:52 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2059.outbound.protection.outlook.com [104.47.36.59])
        by userp3030.oracle.com with ESMTP id 36cvjr9wq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Jan 2021 01:08:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgFMD4YKf8dNec2Ip3R7IqtWjQ3+fHMCMHiMt0S9mIcedsgxHvupXEpj3jymdgAvGMr+2ylnF5Ch+JLUGUC+lLc66YoeJFtULGCenJLUiSEaDVxUmAMs0EARjq1ZWr3Ugo3Wlj0ejgNaaXLzEz+EcxNiXWGwUwqQZ0bMXLPMqVKnluHkMoPmGU9AeNz5Gbr7GV/j8nZd+FOQ/RncuPQbjZaXg1XSRN4WsSptCIGMw/pnGUnkWBMjAzaICxAJWa0eZGKpBNWljc/JAGs1zag3OqOzNObuyECnKC1ZksxHP4tmj9qluQ6wg9lMW7kCW8Hg4hxXP5TY0uKY56gRTBu6dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IB82OA6fCwj5HPzE3/O0/5y3RaTZdUbkR6ON3Ef7+4=;
 b=CZg2W9KdGMrA5AgyTOt1DlGA+dJPHInCT00MTFGeWbIDVkkWL76DM/Oyj5OR/Vfaoj4oek68qdfs3OTpxEFDDhHPtFepcuPE/6LruQOMLFbJ01YkLztjRwsXJmysxfTvRsjPB4mjF8F7401f125NaPbtnIZS5C+xtvLqbm6u1R4QeTR4PiHUe5epYh6Q4jcnr6fcdL6BT3hH1yfLPf2blv1m5FnvO/i15PwqBTWo6CQvEtTxdmlNHlKF2Ke5U01C2zBqK0M3/UZeVoI8+WogbtY9+IWzWhVz1Kugw5gSmx4GB8uIfa3Uxo6EYguQVtN9FfWiX9u6Zrv5vb0BoSc0cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IB82OA6fCwj5HPzE3/O0/5y3RaTZdUbkR6ON3Ef7+4=;
 b=tZ9BksUfeBAh0bY9TQQYyYQ+MeLhvtwiJ5p6mTtGFzvkrzDzjBgs9knb1Qipg4Yj/KSO9+iVVfGz4rfJAfR0Tfe+7arCuQlScukm6TKN2ExpTNK8AF3uiffAg9mAdVrIHe6WuYOJONf1VodtNOdgSMFtXEHlmesjDx4vZjxShMk=
Authentication-Results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
 by BN0PR10MB4840.namprd10.prod.outlook.com (2603:10b6:408:12b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Sat, 30 Jan
 2021 01:08:50 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a%3]) with mapi id 15.20.3784.019; Sat, 30 Jan 2021
 01:08:50 +0000
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v4 1/3] btrfs: add read_policy latency
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com
References: <cover.1611114341.git.anand.jain@oracle.com>
 <63f6f00e2ecc741efd2200c3c87b5db52c6be2fd.1611114341.git.anand.jain@oracle.com>
 <20210120121416.GX6430@twin.jikos.cz>
 <e46000d9-c2e1-ec7c-d6b1-a3bd16aa05f4@oracle.com>
 <20210121175243.GF6430@twin.jikos.cz>
 <28b7ef3d-b5b9-f4a6-8d6f-1e6fc1103815@oracle.com>
Message-ID: <9f406301-c16a-72a5-4ff3-d3bda127895e@oracle.com>
Date:   Sat, 30 Jan 2021 09:08:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <28b7ef3d-b5b9-f4a6-8d6f-1e6fc1103815@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:fc7c:d331:6af2:386f]
X-ClientProxiedBy: SG2PR06CA0138.apcprd06.prod.outlook.com
 (2603:1096:1:1f::16) To BN6PR10MB1683.namprd10.prod.outlook.com
 (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:fc7c:d331:6af2:386f] (2406:3003:2006:2288:fc7c:d331:6af2:386f) by SG2PR06CA0138.apcprd06.prod.outlook.com (2603:1096:1:1f::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Sat, 30 Jan 2021 01:08:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32e3d68c-50bc-421d-9960-08d8c4bb9aa7
X-MS-TrafficTypeDiagnostic: BN0PR10MB4840:
X-Microsoft-Antispam-PRVS: <BN0PR10MB48404C28B5DFE6F4C3AECF27E5B89@BN0PR10MB4840.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Td+8i+PXwXT5DWBl6rMEtIHpG/hhtYt1XHDtA+F9OjJezD2xVoXNXbYiCVgszCvOGWoBZ5sPsdQ8/6pgnVxIQrth/c+UPJXTUqGiNec03bqfgc9r1izXnPvHhIXVEyoV0j11T9kiIvEZbLJ9wj0xC5w/UgvW3Wakwim8FfTcnvVyp0vNpTWf+cQ6tNi6wawbyEEck04Jn/cfENsRFqsYpxmm/uwvF8BlJTj5Ykuv0gB9pEMjeJz1vWYVmV0jHmSpMAWqRdD9/VGIA0XqvzKiGlUMLmAgfwP5T91quRCOnzm2w7GPNNI3t13hMat2qIm+sSh5noY+ihqgS5Dv4wftmyJCuglsPLOhqbxvlszHEn6d6CedqGRvbvNV4rE+iBIeCzJFfeC/u1FJPAdQgNwaA9E3otNfhRzszc5R42ulAQmdYxwTXt2O7+2AU4UgRjXj9O5V72Cy2U/UshMTRMUPEI9nKHETK3PnBK8zCvykXjG6MwvoAT9Mv1vguYoH/R8Ww+JBzustv5CGhbjLw+tBZ57UKoQxIeCsVUV+wq8DlGKh9pnuo5tV0acEiXX2CubPqBswrxq0Y5F8iqGLln76wcOGrRI3PuBld3sWRbjRF6Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(39860400002)(346002)(396003)(5660300002)(6486002)(6666004)(66556008)(66476007)(8676002)(316002)(66946007)(2906002)(36756003)(2616005)(86362001)(8936002)(44832011)(186003)(31696002)(16526019)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eXJBVzZWM010UE1PNVd1cmFraGVyV0NmNjEwSTNmSFRWZWVpeHJrY2hwUm5F?=
 =?utf-8?B?d1ZyUlE0cW1KY3lDWEFWVlBCbzZWRmhWZDdkb3Fid25OdU40Q3ZqVUJPUG0v?=
 =?utf-8?B?VHNqVmQ4NFFKeE1HZUl1SU41ZXF6VjhOY2JhUFNGbEdIRDJkQ2F0RWhlVXFw?=
 =?utf-8?B?TUhTUWFueDFZTmI5OUY1Rm51dlZqcTBjc1doak5oaFdEZTJKL3ZkZFJpUjJH?=
 =?utf-8?B?NlJCeUN5bE0rTXJIV2ZFUWl5SlNmOGJwZGF4T1M3OXRpcTBaQ21uSlVTaEpR?=
 =?utf-8?B?aGRlZ2hURHEzelJFK1lMcC9HNG96T01aaHM5MkJFRjVQTERhV2ZBUTlFWFdC?=
 =?utf-8?B?UVovQVFyQWIwRXZ2TkFxQWVWNXprOXQ2dkFuRTEzVlRqbnZxbkpuSU1odDh1?=
 =?utf-8?B?ejFDM09mQzM4cHlyTEJtK2hTYm5xa1FEMUgzQ1NmSU9qcHNVRWFhNWFqa2Qr?=
 =?utf-8?B?NVIxYkE2eXAyaVNIRHFkTEd1Uit6eTY4cFRpbjlrbXU1UGVnN3pDSGNSeVMz?=
 =?utf-8?B?UkdCV2sxdllVak53U0NNRDBSZE02MDlNNVRrTkE2WGs2T1N1d1Rsd3F6RkV3?=
 =?utf-8?B?Q1R3a1c1RGhuRzRwWTZRRHRyRnNadnZIZDMzdVp6KzJrNnpmckMyV2hzNlVa?=
 =?utf-8?B?LzlnR2VReDVXUUtrYnFzL1RvWVM0SXNKVDJtSUJFUkZBOUdyaVk2eWk2ZEc3?=
 =?utf-8?B?VEF2T21QbUJLb0ZXbGsyWTNieThYUWthQTY0NHpDTUh3ZGc2eVFvK2o1ZjVi?=
 =?utf-8?B?c3NZZ29QTWJ0ejF3VjFLcXVwR3pndWFBN2NqK0IzeVBDTGhjdTR1MTRJZmlC?=
 =?utf-8?B?d3NYc0RSb0h2T1FGeFowQXlibEJKc0E4YUhRbjh0Q1BnUGkrYUV5YmdGNXRt?=
 =?utf-8?B?aDNsRkE5NjcrK0dLUUZGSEovNmxjL3dpOWVveUxvZ2dUSG5XQmIydzNkWGtr?=
 =?utf-8?B?OE5pRU02U0RHakYrUEZodFgzTVlaKzZ6MHdkRnpIYkFWWHN0QUxYVUgyR3I2?=
 =?utf-8?B?cDNWVjYxcmdOWldCMVVJT0YzaGVkSUR6d2hTemRmcmlCWC9lM1ZmbzBaWFBz?=
 =?utf-8?B?T3lmZCt6WjUrSVFQRlk0enFSYWdYc2xrR1F3N2RCQ2F0cFZ5TFMxZHJyakND?=
 =?utf-8?B?eklldk5lWnhDTnhUK3g3TFJXTTNMbjdLRFdFalFTc3JaWDMrcm5VdlBabXpY?=
 =?utf-8?B?cHBMUEk0R3A4OFRwbUk3TmsvKzBhK1JTcnBicTZYeXJnaVg0cUFUUzNqNnV1?=
 =?utf-8?B?YlRxa2l3Rjl0cUFyRVIzN2ZtOGNlV2lHMXlyeWdyRkM0QzRpc01wc2lzLy9r?=
 =?utf-8?B?N1BVUjlybjVRdnFCYUR2YVdMUmJGTU5PYzkzL1FYOHJpMWg4cHovdHlHaEgw?=
 =?utf-8?B?VnJjZFpqY3A2T3doazNsYkFPVnNUNnl1M2hMZ1hhcnZBSHpTOWM5bjR2S3lT?=
 =?utf-8?B?eEdVaW92T2JFcE0rNGhHWHVVdkY1KzhUcURsbW5nZXBIalZrNjRWd1FvYkdG?=
 =?utf-8?Q?lNY/RIxNyILlqbsORKT2hOTKis2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e3d68c-50bc-421d-9960-08d8c4bb9aa7
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2021 01:08:50.7008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gw67Mg5ttq0Dpfg9Ce3Uz4ejNIMIfwt3CqF9XznYpN1p+3zou7zfxV5gcFbWlT1gCmDn+vbqv0PB5VCxlAjlRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4840
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9879 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101300001
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9879 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101300002
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>> 500m is really small data size for such measurement

I reran the read policy tests with some changes in the fio command
options. Mainly to measure IOPS throughput and latency on the filesystem
with latency-policy and pid-policy.

Each of these tests was run for 3 iterations and the best and worst of
those 3 iterations are shown below.

These workloads are performing read-write which is the most commonly
used workload, on a single type of device (which is nvme here) and two
devices are configured for RAID1.

In all these read-write workloads, pid-policy performed ~25% better than
the latency-policy for both throughput and IOPS, and 3% better on the
latency parameter.

I haven't analyzed these read-write workloads on RAID1c3/RAID1c4 yet,
but RAID1 is more common than other types, IMO.

So I think pid-policy should remain as our default read policy.

However as shown before, pid-policy perform worst in the case of special
configs such as volumes with mixed types of devices. For those special
mixed types of devices, latency-policy performs better than pid-policy.
As tested before typically latency-policy provided ~175% better
throughput performance in the case of mixed types of devices (SSD and
nvme).

Feedbacks welcome.

Fio logs below.


IOPS focused readwrite workload:
fio --filename=/btrfs/foo --size=500GB --direct=1 --rw=randrw --bs=4k 
--ioengine=libaio --iodepth=256 --runtime=120 --numjobs=4 --time_based 
--group_reporting --name=iops-randomreadwrite --eta-newline=1

pid [latency] device roundrobin ( 00)
   read: IOPS=40.6k, BW=159MiB/s (166MB/s)(18.6GiB/120002msec)

[pid] latency device roundrobin ( 00)
   read: IOPS=50.7k, BW=198MiB/s (208MB/s)(23.2GiB/120001msec)

IOPS is 25% better with pid policy.


Throughput focused readwrite workload:
fio --filename=/btrfs/foo --size=500GB --direct=1 --rw=randrw --bs=64k 
--ioengine=libaio --iodepth=64 --runtime=120 --numjobs=4 --time_based 
--group_reporting --name=throughput-randomreadwrite --eta-newline=1

pid [latency] device roundrobin ( 00)
   read: IOPS=8525, BW=533MiB/s (559MB/s)(62.4GiB/120003msec)

[pid] latency device roundrobin ( 00)
   read: IOPS=10.7k, BW=670MiB/s (702MB/s)(78.5GiB/120005msec)

Throughput is 25% better with pid policy

Latency focused readwrite workload:
fio --filename=/btrfs/foo --size=500GB --direct=1 --rw=randrw --bs=4k 
--ioengine=libaio --iodepth=1 --runtime=120 --numjobs=4 --time_based 
--group_reporting --name=latency-randomreadwrite --eta-newline=1
pid [latency] device roundrobin ( 00)
   read: IOPS=59.8k, BW=234MiB/s (245MB/s)(27.4GiB/120003msec)
      lat (usec): min=68, max=826930, avg=1917.20, stdev=4210.90

[pid] latency device roundrobin ( 00)
   read: IOPS=61.9k, BW=242MiB/s (253MB/s)(28.3GiB/120001msec)
      lat (usec): min=64, max=751557, avg=1846.07, stdev=4082.97

Latency is 3% better with pid policy.
