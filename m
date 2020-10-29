Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D4B29E4B4
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 08:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732974AbgJ2HpC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 03:45:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60548 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732929AbgJ2HpA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 03:45:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09T7dOi2123915;
        Thu, 29 Oct 2020 07:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=gbu5ZBKxWLoxcXeHNDhrUJqg29RsgLQqREY7Qb1Xkp8=;
 b=mKeJYuOTBkksZlAPik0gvIbJO6n8tqVrVz9n8B+VtuQTzFpcMV4EK1P6zYrc0ol8sOu/
 /X1hY03S6KV7H+fmp7JVrsZDyITnEJw/W9hi3gDVco372F60rAcxldmKUFeCjGrvXIF7
 Ct/s0LLNoa5bIK14uURRHej6SKrFc1yjXN4NtUPyMbH2kwxEVCrRx5+8N6FgguYyc1E0
 StS3QtS87KFuqjfCeb3fud6IqPlmPFBABjFyQBViCcnyHJXkJIcqLbOL5Bf/ZZ5KD/Eh
 jIWp1cyMH0jTUhRArej+vAKk5hEBqXX7mhs0JhrPLAL28TcFyJ+2az/2F+wQoZ1aH42f qQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 34dgm48up1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 07:44:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09T7eNHI155897;
        Thu, 29 Oct 2020 07:44:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 34cx1swsv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Oct 2020 07:44:54 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09T7isU5028505;
        Thu, 29 Oct 2020 07:44:54 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Oct 2020 00:44:53 -0700
Subject: Re: [PATCH v1 0/4] btrfs: read_policy types latency, device and
 round-robin
From:   Anand Jain <anand.jain@oracle.com>
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <cover.1603884539.git.anand.jain@oracle.com>
 <ac428935-c20c-d02d-6678-d88cc5eb4b63@toxicpanda.com>
 <da5c6fc8-95ef-6272-ea2a-4929fc32c69c@oracle.com>
Message-ID: <b45deeac-dd13-3a38-4bdf-190cfd16fe83@oracle.com>
Date:   Thu, 29 Oct 2020 15:44:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <da5c6fc8-95ef-6272-ea2a-4929fc32c69c@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290054
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290054
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 29/10/20 9:08 am, Anand Jain wrote:
> 
> 
> On 28/10/20 10:32 pm, Josef Bacik wrote:
>> On 10/28/20 9:25 AM, Anand Jain wrote:
>>> Based on misc-next
>>>
>>> Depends on the following 3 patches in the mailing list.
>>>    btrfs: add btrfs_strmatch helper
>>>    btrfs: create read policy framework
>>>    btrfs: create read policy sysfs attribute, pid
>>>
>>> v1:
>>> Drop tracing patch
>>> Drop factoring inflight command
>>>    Here below is the performance differences, when inflight is used, 
>>> it pushed
>>>    few commands to the other device, so losing the potential merges.
>>>
>>>    with inflight:
>>>     READ: bw=195MiB/s (204MB/s), 195MiB/s-195MiB/s (204MB/s-204MB/s), 
>>> io=15.6GiB (16.8GB), run=82203-82203msec
>>> sda 256054
>>> sdc 20
>>>
>>>    without inflight:
>>>     READ: bw=192MiB/s (202MB/s), 192MiB/s-192MiB/s (202MB/s-202MB/s), 
>>> io=15.6GiB (16.8GB), run=83231-83231msec
>>> sda 141006
>>> sdc 0
>>>
>>
>> What's the baseline?  I think 3mib/s is not that big of a tradeoff for 
>> complexity, but if baseline is like 190mib/s then maybe its worth it. 
>> If baseline is 90mib/s then I say it's not worth the inflight.  Thanks,
> 
>   Oh no I have to rerun the test cases here. As far as I remember
>   without inflight was better than with inflight. Because with
>   inflight there were fewer merges leading to more read IOs.
> 
>   Will rerun and send the data.
> 

<raid1>

With inflight: (the inflight patches were in the RFC patchset):
pid [latency] device roundrobin ( 00)
    READ: bw=40.3MiB/s (42.3MB/s), 40.3MiB/s-40.3MiB/s 
(42.3MB/s-42.3MB/s), io=15.6GiB (16.8GB), run=396546-396546msec
vdb 363575
sda 200771


Without inflight:
pid [latency] device roundrobin ( 00)
    READ: bw=41.7MiB/s (43.8MB/s), 41.7MiB/s-41.7MiB/s 
(43.8MB/s-43.8MB/s), io=15.6GiB (16.8GB), run=383274-383274msec
vdb 256238
sda 0

Without inflight is better due to lesser IO.

Thanks, Anand

> Thanks, Anand
> 
>>
>> Josef
