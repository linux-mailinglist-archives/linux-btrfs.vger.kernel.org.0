Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57AF2F0B7A
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 04:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbhAKDbA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Jan 2021 22:31:00 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50680 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbhAKDbA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Jan 2021 22:31:00 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10B3UG0U171011;
        Mon, 11 Jan 2021 03:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=wAo3TZORDohWuewdOmDQVwu6VgzBjrPZT62e1YbbrCs=;
 b=gI8OOMOHnT618qFTGbgX7+ftPHhPXDx4dwhHwry1yBOY0Fwm7zUjHxLX70nR4xpXs0zw
 Z/T246rL8thxrE4QXrP7vvkEIWdZpm3VPxCkJn3KBV9NNOKSjQSjk0TvMUcI2TYKpu0q
 TlPMRYQ/tMxIr2c5FzMpSEJo8moXNck8TUXkNBkGS8lzlWgM7HdjPoaR0msQNDm4oIzU
 Q2kk52/I0SCLBOT5NnTHEDjHdy56DlNlSh5YEDAIvft3OORrqy7xH54zb8CuBPIgFmPe
 2Pc3PmKEo6ndygnu+qlqVvwtDXhPDXHKvILasd+dsSR6w4gdhND5JsXjtFLJ0f8vYLh+ 4Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 35y3wqu14h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jan 2021 03:30:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10B3EcVV066641;
        Mon, 11 Jan 2021 03:30:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 35yp8pkm8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jan 2021 03:30:15 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10B3UEGv016807;
        Mon, 11 Jan 2021 03:30:14 GMT
Received: from [192.168.10.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 10 Jan 2021 19:30:14 -0800
Subject: Re: [bug] scrub on low disk space leads to Transaction aborted
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <0f061eb2-2192-da85-0f34-43faa4e2812f@oracle.com>
 <590a8b80-1ec2-e688-64de-b5afc82fd5c7@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <4eec5375-6594-968d-d45a-d408c32380f5@oracle.com>
Date:   Mon, 11 Jan 2021 11:30:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <590a8b80-1ec2-e688-64de-b5afc82fd5c7@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9860 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101110019
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9860 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101110020
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11/1/21 8:38 am, Qu Wenruo wrote:
> 
> 
> On 2021/1/9 下午4:53, Anand Jain wrote:
>>
>>   I ran scrub when disk space was low on a btrfs with some raid1 csum
>>   errors, on a system with kernel 5.11.0-rc2+. It lead to transaction
>>   aborted and rdonly FS.
>>
> 
> Would you please provide `btrfs fi usage` output?
> 
> There is a bug in recent kernel that global rsv is not increased
> properly so that we have a much higher chance to exhaust metadata space.
> 

Now I have made some space in the filesystem. So the usage below may not 
be relevant at the time of the problem.

# btrfs fi usage /Volumes/
Overall:
     Device size:		 154.97GiB
     Device allocated:		 153.12GiB
     Device unallocated:		   1.85GiB
     Device missing:		  76.56GiB
     Used:			 147.63GiB
     Free (estimated):		   3.35GiB	(min: 3.35GiB)
     Data ratio:			      2.00
     Metadata ratio:		      2.00
     Global reserve:		 181.56MiB	(used: 0.00B)

Data,RAID1: Size:75.53GiB, Used:73.11GiB (96.79%)
    /dev/sda6	  75.53GiB
    /dev/sdb2	  75.53GiB

Metadata,RAID1: Size:1.00GiB, Used:724.14MiB (70.72%)
    /dev/sda6	   1.00GiB
    /dev/sdb2	   1.00GiB

System,RAID1: Size:32.00MiB, Used:16.00KiB (0.05%)
    /dev/sda6	  32.00MiB
    /dev/sdb2	  32.00MiB

Unallocated:
    /dev/sda6	   1.85GiB
    /dev/sdb2	   1.00MiB



> Thanks,
> Qu
> 
>> [ 2365.314375] ------------[ cut here ]------------
>> [ 2365.314385] BTRFS: Transaction aborted (error -28)
>> [ 2365.314470] WARNING: CPU: 2 PID: 4672 at fs/btrfs/inode.c:2823
>> btrfs_finish_ordered_io+0x8e6/0x950 [btrfs]
>> <snap>
>> [ 2365.314921] CPU: 2 PID: 4672 Comm: kworker/u8:11 Not tainted
>> 5.11.0-rc2+ #3
>> [ 2365.314933] Hardware name: LENOVO 20FAS6PN00/20FAS6PN00, BIOS
>> N1CET47W (1.15 ) 08/08/2016
>> [ 2365.314939] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
>> [ 2365.315093] RIP: 0010:btrfs_finish_ordered_io+0x8e6/0x950 [btrfs]
>> <snap>
>> [ 2365.315290] Call Trace:
>> [ 2365.315309] BTRFS warning (device sda6):
>> btrfs_finish_ordered_io:2823: Aborting unused transaction(No space left).
>> [ 2365.315305]  finish_ordered_fn+0x15/0x20 [btrfs]
>> [ 2365.315532]  btrfs_work_helper+0xcc/0x2f0 [btrfs]
>> [ 2365.315763]  process_one_work+0x1ee/0x390
>> [ 2365.315781]  worker_thread+0x50/0x3d0
>> [ 2365.315797]  kthread+0x114/0x150
>> [ 2365.315811]  ? process_one_work+0x390/0x390
>> [ 2365.315824]  ? kthread_park+0x90/0x90
>> [ 2365.315836]  ret_from_fork+0x22/0x30
>> [ 2365.315861] ---[ end trace b0e289a2c3d424e8 ]---
>> [ 2365.315871] BTRFS warning (device sda6):
>> btrfs_finish_ordered_io:2823: Aborting unused transaction(No space left).
>> [ 2365.316713] BTRFS warning (device sda6):
>> btrfs_finish_ordered_io:2823: Aborting unused transaction(No space left).
>> [ 2365.316796] BTRFS warning (device sda6): Skipping commit of aborted
>> transaction.
>> [ 2365.316809] BTRFS: error (device sda6) in cleanup_transaction:1938:
>> errno=-30 Readonly filesystem
>> [ 2365.316824] BTRFS info (device sda6): forced readonly
>> [ 2365.359195] BTRFS info (device sda6): scrub: not finished on devid 2
>> with status: -125
