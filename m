Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B8C2FFDF0
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 09:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbhAVINg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 03:13:36 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:41078 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbhAVIMS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 03:12:18 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10M893Ax122722;
        Fri, 22 Jan 2021 08:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=q15c8K3UmCot44pF8WNDH86NbJQ4PcHcKar2tTk5HvE=;
 b=dFwT7Je7PuioV6UUMEvtxYF0tf/pTlMKTbiihae0NqMYbQA9aA98aeUo2mXiT8aquM8r
 oa9g9Bbxw3WcuVhFbyYet9IjtIJBzl3xCaO5TLhMIsB52nZhwMPDkHeng3bP681QLpv6
 1gvdwmwbHA2dCJJBZsf29LdFVJpJH0jd+AHANcQ3NdRAaB4p06FsbTu340a03Nq4M9Vu
 oR0iOQ2rNDigAsodG7OPA5M2cZmwnfXqZiuc02hevKkV2+IBThLokvjLAYrGvV2Rzvhb
 Cm7FpFGGTtrm2TKo5Ud6RLbYZfdP8UZjrNFQG9kB3tofUxHUMJhH8YCHHUiRBZG0WQyi 9Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 3668qrjuvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 08:11:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10M863vV189344;
        Fri, 22 Jan 2021 08:11:02 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by aserp3020.oracle.com with ESMTP id 3668rh4w5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 08:11:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWyhEx8BzicBu5l1SVLGrP4sUQPmKzIBQBBZppdXSDiPXP7vWBkbpt6z+tQkWzB6S+5MPmxhU21mL2TPR6NxJWY2Hj2sG+qDjUCeKC3uh5WUhCULzzJVnVoURfgffVemxxuK9t+FbaEJ6mTO1wVZStK0TWt89wv6yUI70AbA1TPWtKog6rJmBj4Vm8i4AHbwyKO996E2g+JBIgD5UT4oAK4MWtZwwR3ARgU7TFksr/GRMCVUDiDLbXNGlN3z/s9m6q2HYemnQPC4xnIcQF8yqsk6UgnjtzE++GC/xefCy9gi4XpQKJ2in2seMg0NcO62PRDhjJZ0mnaY48KfEtTYmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q15c8K3UmCot44pF8WNDH86NbJQ4PcHcKar2tTk5HvE=;
 b=B0abbmtQqoZm//L/s+m5++sNFrjlk8HJ0qKMgOuR6No2ERxd1VOztUXa2sRpWPPbtqIqYSMlm06FbxInvbT18oStlB6skSXTZgaaf62vdZbGQKY+CPmTlJSzTFhXtE1Sxs+poN7gMMWt9xVqDjG2utfZJcc+O93+BEVXWyi+mGUsjaJT/jMVZi/lCYql4Pr2LrccHIWVcpTNpMi+1uFEqZtNRLBSA5EC7QKbllADOkO0h6bVIRDFCKtjgXu2BUZByDwpdL46zNonRF2OL2uB987/AGQKqsN1YfYn/my1CHQVKQffgz5MyyLakl0HM1cPxCAd1DC7QRBE58uZ4skDgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q15c8K3UmCot44pF8WNDH86NbJQ4PcHcKar2tTk5HvE=;
 b=xxczscsYLoY86BqYXcyZv5V3WWpROipqcwE+VnRn5+TU8JzvhT0lzoz7wTmQa7fL5U67qUqRnChKtNbdECv+1/RXd1BHZVBCEGDPU4EBNz9rv/dWSZv3RjuhTIvM6KI7FUatd3BMM0je/biQKlnDU4dd2mV1RAW9RAAE/Gf7MoQ=
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
 by BN0PR10MB5336.namprd10.prod.outlook.com (2603:10b6:408:114::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Fri, 22 Jan
 2021 08:11:00 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a%3]) with mapi id 15.20.3784.012; Fri, 22 Jan 2021
 08:11:00 +0000
Subject: Re: [PATCH v4 1/3] btrfs: add read_policy latency
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com
References: <cover.1611114341.git.anand.jain@oracle.com>
 <63f6f00e2ecc741efd2200c3c87b5db52c6be2fd.1611114341.git.anand.jain@oracle.com>
 <20210120121416.GX6430@twin.jikos.cz>
 <e46000d9-c2e1-ec7c-d6b1-a3bd16aa05f4@oracle.com>
 <20210121175243.GF6430@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     anand.jain@oracle.com
Message-ID: <28b7ef3d-b5b9-f4a6-8d6f-1e6fc1103815@oracle.com>
Date:   Fri, 22 Jan 2021 16:10:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
In-Reply-To: <20210121175243.GF6430@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR04CA0151.apcprd04.prod.outlook.com (2603:1096:4::13)
 To BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR04CA0151.apcprd04.prod.outlook.com (2603:1096:4::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Fri, 22 Jan 2021 08:10:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46013cf5-8732-44f0-4e3b-08d8bead40df
X-MS-TrafficTypeDiagnostic: BN0PR10MB5336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN0PR10MB533611FA7A677F2D4DA44042E5A09@BN0PR10MB5336.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fF53xsaboGsTwGDs0c0zVbKFfBGgajN0gDIsmrohoB+N0rDxa/42g2FKge86iqNG9YgLTlmHN8Y9fTA+BfCfGo1Q1hWoqRv8sUuZP3wxZTiFkQOMdAGozQ0yUApIHxg7q9n6UwPrlciSKAwPzbt9xErGCfA4MiyR/cbsN/whwQaMGuCQrwXEWtvah1DvFVsQbS2IVOAOm1677yHUPEsAnGIuGIbH0XReJq4K/15ssi+Xc5FW4n1/XBL/TDtjAONQg56Ua75rCYWMM03PpnhsW31Ewl6uZAdhk+7R3W2NcijQh1reJE5HlIikx9z5+k+sLFkIqcdhnsjIkQkGm4ImwBTZS/aQDyQpl2+GM22peN3ImGaDv0X4ZesuUncxjxmUKdOsBVC09mKSNGxxav/eg4oHaA4z34SeGneaZm6248sGUOPKKE9mOsqeqSRFVtQmjnDA4vCqt9L2t0XARrH45p2IxT2lLVgbPZzfWUaOcso=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(366004)(136003)(376002)(316002)(16526019)(44832011)(508600001)(83380400001)(2616005)(956004)(107886003)(31696002)(36756003)(86362001)(16576012)(4326008)(26005)(6486002)(31686004)(19627235002)(2906002)(66946007)(66556008)(66476007)(5660300002)(8936002)(8676002)(53546011)(186003)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NTA4RXZld3IrcDhIZnVuK0NWYjZ2YXo2N2lvMEJWYlJQYTZ1Z3VGMGp0Smdt?=
 =?utf-8?B?LzZaNTZzYmFIZmkrd01NeWFoZkYwZkI0dlI2QXVUTHZod3hBWThBWVZYNG9P?=
 =?utf-8?B?OS9OWkJXVmhoQk9VRWYvZnlod21uaU5vK3FHVEoxaVF1Ly9WTFNidDhONkpN?=
 =?utf-8?B?R1hSYzNnZ3hnZzlIVFBLT2w1SFk3bzg0aC9QQTZWMk9BMXE0cG92NFpFRWRr?=
 =?utf-8?B?ZFF1QTY5cHBXbjkxMWplVjM3M1IyOE9ScWo5MjAvNzVFbDBkcEZoZkhhRGpn?=
 =?utf-8?B?L1pFZzAvZm5YYThodXRjbXJjbWMvUG4vL2FHMGNKK2FMc2lqOVJmdHpoaU9w?=
 =?utf-8?B?N1YvbEVXN09VSFpJVnJiNHhibkNUdDhrMTFadlJJN3JnemR4dmZRa3AzWDlw?=
 =?utf-8?B?cGo5MFRyemJ3QmpabzgxNlJ5Nlh1d3RxcmNiT1g5NEFERmxKU2VIbm1wU0ZT?=
 =?utf-8?B?aE1zMVh6ZzZYNDBZTnl1NDc3cnM3TVJyVTFrWjlrNDZGVGRKZXRVU3NzQk83?=
 =?utf-8?B?NGYraGsvS3EyM2Npa1EvREpLK1h5QkZwZi9laTduVFFUdVRxSGxoaXJnUUZ5?=
 =?utf-8?B?MEFrUUNSZ09DS3pVRWpmbkg5YWZqSVF4Vko2V1RlK1ZPNFAzMWRSaFdISGha?=
 =?utf-8?B?RDVpRzBIdTZlVjdoUFlFZlhyc09qaUl4T2ZmdmVVa3gySXJqSVVYeXpOdktZ?=
 =?utf-8?B?eGNZZ1NaamVpYWRpd1EwOGJzUCswRjVtSmprUStsRGhrclB1QkQrNFFxMitz?=
 =?utf-8?B?a0dBZERrMVk1MUovcHFlRERFaG5rOHZXclJKWTBtNjZ2cVNES2w1elFud0c3?=
 =?utf-8?B?NHA2SHRvVmtwT0VYR0Z5bVBnRUFtZnp1WG1ybzVtZlFVdHJXUytGTzZGL1ho?=
 =?utf-8?B?SW1lVVFSWVFMeFl0L3V4OVBHMjhNVXZOREdORmF2YXliVSs1U0JyMFMzNUlW?=
 =?utf-8?B?b2hKakNWSHM4MGdtQjNHM2dRejZVU0RPeno3dk5kVGpDVHB2U2dxNXlkS3VH?=
 =?utf-8?B?VjlJbkEvWHcvdVBQeFVZV1FyRGcxUzY1SnRKUmJOOVU5NVBta0Ura3BlQlRa?=
 =?utf-8?B?UjhnTHo4SHJ2MmI4Z1plWENCZ292dnQxdzFmRmlxSzBja2JETXlmNXpPdGZj?=
 =?utf-8?B?YnNZVHFweWdHejZWd3E2encycjJLTjJlbFUvNjlVeit5cmNNVmRYblNjaHB6?=
 =?utf-8?B?VmNBRE1yWlczUW94MzQwN1ozd2RIVlQvUmlLRHN5ZDY2MXRhL0dQNEZ3VUhR?=
 =?utf-8?B?TXJHQTZGdjFFZ2VHSGdUc2IrMk5sb0ttNkdXTXpJRHJFWEpDUlJnQm1PVFI0?=
 =?utf-8?Q?4R9tM3hndZDiCws2WPAVA0sGWQMnt4ABBy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46013cf5-8732-44f0-4e3b-08d8bead40df
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 08:11:00.1660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRNOAfYjcu8GyWcC5RhiQjnkA0mDSMpdnURMwmyM4SRbanYTyjwiMkeSdP8P2ubJHIVupX3vHOPbt+4Ie+U+zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5336
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9871 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101220042
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9871 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101220042
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22/1/21 1:52 am, David Sterba wrote:
> On Thu, Jan 21, 2021 at 06:10:36PM +0800, Anand Jain wrote:
>>
>>
>> On 20/1/21 8:14 pm, David Sterba wrote:
>>> On Tue, Jan 19, 2021 at 11:52:05PM -0800, Anand Jain wrote:
>>>> The read policy type latency routes the read IO based on the historical
>>>> average wait-time experienced by the read IOs through the individual
>>>> device. This patch obtains the historical read IO stats from the kernel
>>>> block layer and calculates its average.
>>>
>>> This does not say how the stripe is selected using the gathered numbers.
>>> Ie. what is the criteria like minimum average time, "based on" is too
>>> vague.
>>>
>>
>>
>> Could you please add the following in the change log. Hope this will
>> suffice.
>>
>> ----------
>> This patch adds new read policy Latency. This policy routes the read
>> I/Os based on the device's average wait time for read requests.
> 
> 'wait time' means the time from io submission to completion
> 
  Yes, at the block layer.

>> The average is calculated by dividing the total wait time for read
>> requests by the total read I/Os processed by the device.
> 
> So this is based on numbers from the entire lifetime of the device?

  No,  Kernel stats are in memory only, so it is since boot.

>  The
> numbers are IMHO not a reliable source. If unrelated writes increase the
> read wait time then the device will not be selected until the average
> is lower than of the other devices.

  I think it is fair. Because comparison is between the performance of

  1. disk-type-A   VS    disk-type-A

  OR

  2. disk-type-A    VS   disk-type-B

  In the scenario #1 above, it does not matter which disk, as both of
  them provides the same performance (theoretically), which is the most
  common config.

  In scenario 2# the user can check the read I/O on the devices, if it
  is _not_ going to the best performing device by theory, either a reboot
  or iostat-reset (which I think should be there) shall help.
  Or if they can't reboot or if iostat-reset is not available, then
  switching to the read-policy 'device' shall help until they
  reboot, which is a better alternative than PID, which is unpredictable.
  Unfortunately, this switching is not automatic (more below).

  There are drawbacks to this policy.
  At any point in time, momentarily, a device may get too busy due to 
_external factors_ such as - multiple partitions on
  the same device, multiple LUNs on the same HBA, OR if the IRQ is shared
  by the disk's HBA and the gigabit network card (which has better IRQ
  priority) so whenever the network is busy, the I/O on the disk slows
  down (I had an opportunity to investigate such an issue before).
  So now the latency policy shall switch to the better performing device
  at such a time. But if the theoretically better performing device is
  back to its normal speed, yes, unless the device gets the read I/O by
  some operation (for example, scrub), the policy won't know. This
  scenario is more crucial for the config type #2 (above).

  Also, there may be a better alternative to the average wait time (for
  example, another type of mean-values?) Which I think can be tweaked in
  the long term when we understand the usage of this policy better. If we
  account for the inflight commands, there will be more switching in
  config type #1 (above). More switching leads to fewer I/O mergers and
  higher cache misses (DMA and storage level) leading to poorer
  performance. So switching back and forth between devices is not good as
  well. So stay where they are helps until it performs worst than its
  mirrored device.


> The average can only decrease after there are some fast reads, which is
> not guaranted to happen and there's no good estimate how long it could
> take to happen.

  True. Also, there isn't any kernel part-stat reset. Not sure if the
  block layer will entertain such a patch, but worth a try IMO. What
  What do you think?

  However, even if I reset, it's not guaranteed that temporary bad stats
  can not happen again. Also it's a bit uncertain how to know when will
  the theoretically better performing device will be back to its good
  performance.


> The tests we all probably do are on a fresh mkfs and with a small
> workload but the mirror selection logic must work long term.
> 

  I totally agree. So I am not yet recommending this policy for the
  default. But ut does solve some of the problems very well.

> The part_stat numbers could be used but must reflect the time factor,
> ie. it needs to be some a rolling average or collecting a sample for
> last N seconds.

  But, I think the problem here is to know when will the
  theoretically better performing device will be back to its good
  performance. So for that purpose, the theoretically better performing
  device must be probed periodically. And there will be cost.

> 
> Bear in mind that this is only a heuristic and we don't need perfect
> results nor we want to replace io scheduling, so the amont of collected
> data or the logic should be straightforward.
> 
  Yeah. If part_stat can provide stat only for past N-mins or so, it will
  be simpler. During this patch, I looked into the part_stat code it is
  not straightforward.


>> This policy uses kernel disk stat to calculate the average, so it needs
>> the kernel stat to be enabled.
> 
> What is needed to enable it? I see it's always compiled in in
> block/blk-core.c.
> 

  It is enabled by default. But the user may disable part_stat
  collection at the run time.

    echo 0 > /sys/block/sdx/queue/iostat


>> If in case the kernel stat is disabled
>> the policy uses the stripe 0.
>> This policy can be set through the read_policy sysfs interface as shown
>> below.
>>
>>       $ echo latency > /sys/fs/btrfs/<uuid>/read_policy
>>       $ cat /sys/fs/btrfs/<uuid>/read_policy
>>            pid [latency] device roundrobin
>>
>> This policy won't persist across reboot or mount unmount recycle as of
>> now.
>>
>> Here below are few performance test results with latency compared with
>> pid policy.
>>
>> raid1 fio read 500m
> 
> 500m is really small data size for such measurement
> 

  Pls see below about this.

>> -----------------------------------------------------
>> dev types   | nvme+ssd  nvme+ssd   all-nvme  all-nvme
>> read type   | random    sequential random    sequential
>> ------------+------------------------------------------
>> pid         | 744MiB/s  809MiB/s  2225MiB/s 2155MiB/s
>> latency     | 2072MiB/s 2008MiB/s  1999MiB/s 1961MiB/s
> 
> Namely when the device bandwidth is 4x higher. The data size should be
> scaled up so the whole run takes at least 30 seconds if not a few
> minutes.
> > Other missing information about the load is the number of threads and if
> it's buffered or direct io.
> 

  The cover letter has the fio command used. The output from the guest VM
  is there. From it, I notice the I/Os performed were ~16.8G. I can run
  the scripts again. Pls, do share with me if you have any ideas for
  testing.

  READ: bw=87.0MiB/s (91.2MB/s), 87.0MiB/s-87.0MiB/s 
(91.2MB/s-91.2MB/s), io=15.6GiB (16.8GB), run=183884-183884msec


>> raid10 fio read 500m
>> -----------------------------------------------------
>> dev types   | nvme+ssd  nvme+ssd   all-nvme  all-nvme
>> read type   | random    sequential random    sequential
>> ------------+------------------------------------------
>> pid         | 1282MiB/s 1427MiB/s 2152MiB/s 1969MiB/s
>> latency     | 2073MiB/s 1871MiB/s 1975MiB/s 1984MiB/s
>>
>>
>> raid1c3 fio read 500m
>> -----------------------------------------------------
>> dev types   | nvme+ssd  nvme+ssd   all-nvme  all-nvme
>> read type   | random    sequential random    sequential
>> ------------+------------------------------------------
>> pid         |  973MiB/s  955MiB/s 2144MiB/s 1962MiB/s
>> latency     | 2005MiB/s 1924MiB/s 2083MiB/s 1980MiB/s
>>
>>
>> raid1c4 fio read 500m
>> -----------------------------------------------------
>> dev types   | nvme+ssd  nvme+ssd   all-nvme  all-nvme
>> read type   | random    sequential random    sequential
>> ------------+------------------------------------------
>> pid         | 1204MiB/s 1221MiB/s 2065MiB/s 1878MiB/s
>> latency     | 1990MiB/s 1920MiB/s 1945MiB/s 1865MiB/s
>>
>>
>> In the given fio I/O workload above, it is found that there are fewer
>> I/O merges in case of latency as compared to pid. So in the case of all
>> homogeneous devices pid performance little better.
> 
> Yeah switching the device in the middle of a contiguous range could slow
> it down but as long as it's not "too much", then it's ok.
> 

  Yep.

> The pid selection is good for multiple threads workload but we also want
> to make it work with single thread reads, like a simple 'cp'.
> 
> I tested this policy and with 2G file 'cat file' utilizes only one
> device, so this is no improvement to the pid policy.
> 
  In the 'cat file' test case above, all the read IOs will go to a
  single stripe id. But, it does not mean that it will go to the same
  device. As of now, our chunk allocation is based on the device's free
  size. So the better thing to do is to have raid 1 on disks of
  different sizes like, for example, 50G and 100G. Then it guarantees
  that stripe 0 will be always on the 100G disk. Then it is fair to
  measure the pid policy.

  And still, pid policy may perform better, as reading from a single disk
  is not a bad idea. The read_policy type 'device' proved it.

  All the policy depends on the workload, so is pid policy. But on top
  of it the pid policy is non-deterministic which makes it hard to say
  how it shall be in a known workload.

> A policy based on read latency makes sense but the current
> implementation does not cover enough workloads.
> 

  Yeah. The performances of any policy here (including PID and round-
  robin) are workload-dependent. IMHO it can't be like one-size-fits
  and meant to be tuned.

Thanks, Anand


