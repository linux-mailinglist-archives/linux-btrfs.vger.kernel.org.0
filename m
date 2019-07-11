Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A71726504A
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2019 04:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfGKCqw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jul 2019 22:46:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53192 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfGKCqv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jul 2019 22:46:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6B2j1vE052332;
        Thu, 11 Jul 2019 02:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2018-07-02;
 bh=Syl45W2udtnt0oqzJwDc9wL7rurdBPrT5RQ528Taqs8=;
 b=Xo/OFzJnz5deoVO0RJihkqAfrmjH9o6oqJKF6SySj7C4N1+p2xQI1R6sICybEhtZpPXs
 3Dp9yo1akpiqoh7LDaE16VfuR+Y40S5up8h1fiSRqcseNj8ANb0IYmAZEi+s3cgHLoB/
 fWlILnOxcah3hEoRwfGgTB+O0CsuGGqj3lVEYBLvWtYF8HZ89/CGnZe49gtKLlVV4cSE
 c8OfA1CZMgreMoMEOLfPqzL187o2q9NkyvdSVFgutGvnr/w+o6IEBGL0M0pXkHmHEMfJ
 YQZR1xa7kXM3k/B4EZW6yG1eNQVN2viHDIQaAXJF8vXOaTmU2vWaNRbkbaaO8rsHYk98 1g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2tjm9qwb2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Jul 2019 02:46:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6B2hL1c014528;
        Thu, 11 Jul 2019 02:46:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2tmmh3vp56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Jul 2019 02:46:43 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6B2kewH030979;
        Thu, 11 Jul 2019 02:46:42 GMT
Received: from [172.20.10.11] (/183.90.36.57)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Jul 2019 19:46:40 -0700
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: "btrfs: harden agaist duplicate fsid" spams syslog
To:     Graham Cobb <g.btrfs@cobb.uk.net>, linux-btrfs@vger.kernel.org
References: <5d8baf80-4fb3-221f-5ab4-e98a838f63e1@cobb.uk.net>
Message-ID: <c01ab9f6-c553-3625-5656-a8f61659de7d@oracle.com>
Date:   Thu, 11 Jul 2019 10:46:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5d8baf80-4fb3-221f-5ab4-e98a838f63e1@cobb.uk.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9314 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907110030
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9314 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907110030
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Right. It happened even without this patch but we just know it now.

In the original investigations of the patch, the moment you copy a
device image into another device, the autoscan would scan the new
device into the btrfs kernel and created a mess. Now with this patch
we won't replace the device path unless it's the same device (and we
have to let that happen).

Now the question I am trying to understand, why same device is being
scanned every 2 mins, even though its already mount-ed. I am guessing
its toggling the same device paths trying to mount the device-path
which is not mounted. So autofs's check for the device mount seems to
be path based.

Would you please provide your LVM configs and I believe you are using
dm-mapping too. What are the device paths used in the fstab and in grub.
And do you see these messages for all devices of
4d1ba5af-8b89-4cb5-96c6-55d1f028a202 or just devid 4? Would you please
provide more logs at least a complete cycle of the repeating logs.

-Anand


On 11/7/19 2:49 AM, Graham Cobb wrote:
> Anand's Nov 2018 patch "btrfs: harden agaist duplicate fsid" has
> recently percolated through to my Debian buster server system.
> 
> And it is spamming my log files.
> 
> Each of my btrfs filesystem devices logs 4 messages every 2 minutes.
> Here is an example of the 4 messages related to one device:
> 
> Jul 10 19:32:27 black kernel: [33017.407252] BTRFS info (device sdc3):
> device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
> old:/dev/mapper/cryptdata4tb--vg-backup new:/dev/dm-13
> Jul 10 19:32:27 black kernel: [33017.522242] BTRFS info (device sdc3):
> device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
> old:/dev/dm-13 new:/dev/mapper/cryptdata4tb--vg-backup
> Jul 10 19:32:29 black kernel: [33018.797161] BTRFS info (device sdc3):
> device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
> old:/dev/mapper/cryptdata4tb--vg-backup new:/dev/dm-13
> Jul 10 19:32:29 black kernel: [33019.061631] BTRFS info (device sdc3):
> device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
> old:/dev/dm-13 new:/dev/mapper/cryptdata4tb--vg-backup
> 
> What is happening here is that each device is actually an LVM logical
> volume, and it is known by a /dev/mapper name and a /dev/dm name. And
> every 2 minutes something cause btrfs to notice that there are two names
> for the same device and it swaps them around. Logging a message to say
> it has done so. And doing it 4 times.
> 
> I presume that the swapping doesn't cause any problem. I wonder slightly
> whether ordering guarantees and barriers all work correctly but I
> haven't noticed any problems.
> 
> I also assume it has been doing this for a while -- just silently before
> this patch came along.
> 
> Is btrfs noticing this itself or is something else (udev or systemd, for
> example) triggering it?
> 
> Should I worry about it?
> 
> Is there any way to not have my log files full of this?
> 
> Graham
> 
> [This started with a Debian testing kernel a couple of months ago.
> Current uname -a gives: Linux black 4.19.0-5-amd64 #1 SMP Debian
> 4.19.37-5 (2019-06-19) x86_64 GNU/Linux]
> 

