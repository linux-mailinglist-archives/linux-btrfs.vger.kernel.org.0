Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A57AAC4B3B
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2019 12:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfJBKT3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Oct 2019 06:19:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59670 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfJBKT3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Oct 2019 06:19:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x92AJ5u3084260;
        Wed, 2 Oct 2019 10:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=pV8o2w0NRbtq152zgrMLFhJbu3ELAWIlV22xm8nafDM=;
 b=hj8fEBF+fbRciqQfjyeFVZp4WyB8qj0MfywbPZEczgVwsMm7uKqpEQCrB5at7xo2ya/o
 YqpA5VdkI3/K7nWdKRCuDrX5sZER1VDLe/l02xOi+uoihm7h2KH80KOJUlKheik/2zpt
 VgJV1tUVn4/LbO/mo0Dxyol1iLwJg7GmCiaEDFVMNGDTbCRuGCJKUun6lOp0DfwWwYVV
 tvyxkQyIHdp5YPB/0+5nsR3JNTmCT6rh9Tkh4uA54nNS4cfF/5K2qRlJhz+lR/Qqou0Y
 nFiWNfwACqf7W6Eoj135rS7Dvf8+XdX8p7Lu+ecyDBhxjZPtkMF2DxkuFgA3F5f4RjjM ZQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2va05rv0b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Oct 2019 10:19:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x92AIZ36180222;
        Wed, 2 Oct 2019 10:19:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2vbsm3mua4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Oct 2019 10:19:25 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x92AJOu0013419;
        Wed, 2 Oct 2019 10:19:24 GMT
Received: from [10.186.52.87] (/10.186.52.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Oct 2019 03:19:24 -0700
Subject: Re: [bug] strange systemd-udevd scan for btrfs device
From:   Anand Jain <anand.jain@oracle.com>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     systemd-bugs@lists.freedesktop.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <9fe6ad9b-d53f-614c-5651-6de8bad93f1e@oracle.com>
 <CAA91j0UjpNycY0xhGVCzAkUJiwmrBPmk9PU6MpvW7mO0Zgki-g@mail.gmail.com>
 <c520c4f9-8d1c-41f9-0b80-fbff8fa966a3@oracle.com>
Message-ID: <7256e3a7-1336-9921-05af-dda48ba71375@oracle.com>
Date:   Wed, 2 Oct 2019 18:19:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c520c4f9-8d1c-41f9-0b80-fbff8fa966a3@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9397 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910020097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9397 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910020097
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10/2/19 6:02 PM, Anand Jain wrote:
> 
> 
> On 10/2/19 5:55 PM, Andrei Borzenkov wrote:
>> On Wed, Oct 2, 2019 at 12:27 PM Anand Jain <anand.jain@oracle.com> wrote:
>>>
>>>
>>>
>>> I am looking for systemd part of the answers to understand what
>>> is triggering a strange problem. Any help is appreciated.
>>>
>>> After mkfs.btrfs creates btrfs filesystem it scans to register the
>>> device in btrfs.ko.
>>> And we have 'btrfs dev scan --forget' command to undo the process of
>>> register.
>>>
>>> But the problem is - immediately after 'btrfs dev scan --forget' the
>>> systemd-udevd scans the device again, defeating the purpose of the
>>> forget as show below (scanned-by).
>>>
>>> mkfs.btrfs -fq /dev/sdc && btrfs dev scan --forget /dev/sdc
>>>
>>> -------------------
>>> kernel: BTRFS: device fsid 8ea20bb2-888a-4b3b-9f4c-1db9117dc219 devid 1
>>> transid 5 /dev/sdc scanned-by mkfs.btrfs
>>> kernel: BTRFS: device fsid 8ea20bb2-888a-4b3b-9f4c-1db9117dc219 devid 1
>>> transid 5 /dev/sdc scanned-by systemd-udevd
>>> -------------------
>>>
>>> And the problem does _not_ happen if there is a sleep of 3 secs after
>>> the mkfs.btrfs, as below.
>>>
>>> mkfs.btrfs -fq /dev/sdc && sleep 3 && btrfs dev scan --forget /dev/sdc
>>>
>>> ------------------
>>> kernel: BTRFS: device fsid 601bd01a-5e6b-488a-b020-0e7556c83087 devid 1
>>> transid 5 /dev/sdc scanned-by mkfs.btrfs
>>> ------------------
>>>
>>> Any idea what happening from the systemd point of view?
>>>
>>
>> run
>>
>> udevadm monitor -ku
>>
>> in both cases and post results. My educated guess is that udev scan is
>> in response to mkfs and you have unfortunate race condition here.
>>
> 
> 
> Looks like what is happening is ..
> 
>   . Change in fsid (by mkfs.btrfs) notifies and triggers systemd
>   . Systemd checks if the device is ready by using
>     BTRFS_IOC_DEVICES_READY.
>   . However BTRFS_IOC_DEVICES_READY from systemd races with forget
>     command and the result depends on who wins the race.
> 


I get this for the command mkfs.btrfs: (for /dev/sdc)

KERNEL[185263.634507] change 
/devices/pci0000:5d/0000:5d:02.0/0000:65:00.0/host0/target0:2:2/0:2:2:0/block/sdc 
(block)
UDEV  [185263.637870] change 
/devices/pci0000:5d/0000:5d:02.0/0000:65:00.0/host0/target0:2:2/0:2:2:0/block/sdc 
(block)
KERNEL[185263.640572] change 
/devices/pci0000:5d/0000:5d:02.0/0000:65:00.0/host0/target0:2:2/0:2:2:0/block/sdc 
(block)
KERNEL[185263.641552] change 
/devices/pci0000:5d/0000:5d:02.0/0000:65:00.0/host0/target0:2:2/0:2:2:0/block/sdc 
(block)
UDEV  [185263.644337] change 
/devices/pci0000:5d/0000:5d:02.0/0000:65:00.0/host0/target0:2:2/0:2:2:0/block/sdc 
(block)
UDEV  [185263.647656] change 
/devices/pci0000:5d/0000:5d:02.0/0000:65:00.0/host0/target0:2:2/0:2:2:0/block/sdc 
(block)

And no notification for mkfs.btrfs -fq /dev/sdb

Looks like there is some rules set. But I don't find any rules
in /etc/udev/rules.d specific to /dev/sdb can it be set somewhere
else?

Thanks, Anand
