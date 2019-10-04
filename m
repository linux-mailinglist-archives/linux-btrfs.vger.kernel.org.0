Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF0EDCB77F
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2019 11:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388271AbfJDJly (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Oct 2019 05:41:54 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57094 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388266AbfJDJly (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Oct 2019 05:41:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x949YKM1154505;
        Fri, 4 Oct 2019 09:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=O1MwdjHwQB62ZdeIHD12UdEtKBn9IsSrLuOk/X6qiNY=;
 b=PXf26yd/Xn8+93PcyUyOUDeivynjbLUsdjtuc9e88Ahrjvv2JEqq+nTPIbmj9tSteBtu
 ffowOPgULbFSGqn3iWQA74kTKM/T3pa3iob9T2uWOXHnnNa3lgqkoX2UaLIuzv1xtuvu
 opZ/M16mwMsqSI09yPNAIe2PEbNF8Noy21tBHY32TML5+oOcfO+wrUi/66nF6x/LysF5
 pyYwf2SHDsGT8SRJfZ9bMQUT27s8AStiutIh7ma7taRHTyNsa9h6r7HrK7W/9mNORhjy
 dSfBY5YugpuLGbSrV1Vej4EViqcS+VypPJaQqT1L/fFl5hrQtM20AdpPm3Ap/vN+m6aw vg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2v9yfqt4sr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Oct 2019 09:41:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x949dUcq172723;
        Fri, 4 Oct 2019 09:41:49 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2vdk0u5ev0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Oct 2019 09:41:49 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x949flS9006081;
        Fri, 4 Oct 2019 09:41:47 GMT
Received: from [10.186.52.87] (/10.186.52.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Oct 2019 02:41:47 -0700
Subject: Re: [bug] strange systemd-udevd scan for btrfs device
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        systemd-devel@lists.freedesktop.org
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <9fe6ad9b-d53f-614c-5651-6de8bad93f1e@oracle.com>
 <CAA91j0UjpNycY0xhGVCzAkUJiwmrBPmk9PU6MpvW7mO0Zgki-g@mail.gmail.com>
 <c520c4f9-8d1c-41f9-0b80-fbff8fa966a3@oracle.com>
 <7256e3a7-1336-9921-05af-dda48ba71375@oracle.com>
 <CAA91j0VbpOE=g0ao4aYJkMje+ri1c+ZhvMghv0MTyW-GLdLYhQ@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <0cb80d02-8ad6-0a2b-d1f5-e503ca528238@oracle.com>
Date:   Fri, 4 Oct 2019 17:42:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAA91j0VbpOE=g0ao4aYJkMje+ri1c+ZhvMghv0MTyW-GLdLYhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9399 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910040089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9399 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910040089
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


use appropriate ml for systemd bugs
-systemd-bugs@lists.freedesktop.org
+systemd-devel@lists.freedesktop.org

inline below..

On 10/2/19 9:33 PM, Andrei Borzenkov wrote:
> On Wed, Oct 2, 2019 at 1:19 PM Anand Jain <anand.jain@oracle.com> wrote:
>>
>>
>>
>> On 10/2/19 6:02 PM, Anand Jain wrote:
>>>
>>>
>>> On 10/2/19 5:55 PM, Andrei Borzenkov wrote:
>>>> On Wed, Oct 2, 2019 at 12:27 PM Anand Jain <anand.jain@oracle.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> I am looking for systemd part of the answers to understand what
>>>>> is triggering a strange problem. Any help is appreciated.
>>>>>
>>>>> After mkfs.btrfs creates btrfs filesystem it scans to register the
>>>>> device in btrfs.ko.
>>>>> And we have 'btrfs dev scan --forget' command to undo the process of
>>>>> register.
>>>>>
>>>>> But the problem is - immediately after 'btrfs dev scan --forget' the
>>>>> systemd-udevd scans the device again, defeating the purpose of the
>>>>> forget as show below (scanned-by).
>>>>>
>>>>> mkfs.btrfs -fq /dev/sdc && btrfs dev scan --forget /dev/sdc
>>>>>
>>>>> -------------------
>>>>> kernel: BTRFS: device fsid 8ea20bb2-888a-4b3b-9f4c-1db9117dc219 devid 1
>>>>> transid 5 /dev/sdc scanned-by mkfs.btrfs
>>>>> kernel: BTRFS: device fsid 8ea20bb2-888a-4b3b-9f4c-1db9117dc219 devid 1
>>>>> transid 5 /dev/sdc scanned-by systemd-udevd
>>>>> -------------------
>>>>>
>>>>> And the problem does _not_ happen if there is a sleep of 3 secs after
>>>>> the mkfs.btrfs, as below.
>>>>>
>>>>> mkfs.btrfs -fq /dev/sdc && sleep 3 && btrfs dev scan --forget /dev/sdc
>>>>>
>>>>> ------------------
>>>>> kernel: BTRFS: device fsid 601bd01a-5e6b-488a-b020-0e7556c83087 devid 1
>>>>> transid 5 /dev/sdc scanned-by mkfs.btrfs
>>>>> ------------------
>>>>>
>>>>> Any idea what happening from the systemd point of view?
>>>>>
>>>>
>>>> run
>>>>
>>>> udevadm monitor -ku
>>>>
>>>> in both cases and post results. My educated guess is that udev scan is
>>>> in response to mkfs and you have unfortunate race condition here.
>>>>
>>>
>>>
>>> Looks like what is happening is ..
>>>
>>>    . Change in fsid (by mkfs.btrfs) notifies and triggers systemd
>>>    . Systemd checks if the device is ready by using
>>>      BTRFS_IOC_DEVICES_READY.
>>>    . However BTRFS_IOC_DEVICES_READY from systemd races with forget
>>>      command and the result depends on who wins the race.
>>>
>>
>>
>> I get this for the command mkfs.btrfs: (for /dev/sdc)
>>
>> KERNEL[185263.634507] change
>> /devices/pci0000:5d/0000:5d:02.0/0000:65:00.0/host0/target0:2:2/0:2:2:0/block/sdc
>> (block)
>> UDEV  [185263.637870] change
>> /devices/pci0000:5d/0000:5d:02.0/0000:65:00.0/host0/target0:2:2/0:2:2:0/block/sdc
>> (block)
>> KERNEL[185263.640572] change
>> /devices/pci0000:5d/0000:5d:02.0/0000:65:00.0/host0/target0:2:2/0:2:2:0/block/sdc
>> (block)
>> KERNEL[185263.641552] change
>> /devices/pci0000:5d/0000:5d:02.0/0000:65:00.0/host0/target0:2:2/0:2:2:0/block/sdc
>> (block)
>> UDEV  [185263.644337] change
>> /devices/pci0000:5d/0000:5d:02.0/0000:65:00.0/host0/target0:2:2/0:2:2:0/block/sdc
>> (block)
>> UDEV  [185263.647656] change
>> /devices/pci0000:5d/0000:5d:02.0/0000:65:00.0/host0/target0:2:2/0:2:2:0/block/sdc
>> (block)
>>
>> And no notification for mkfs.btrfs -fq /dev/sdb
>>
>> Looks like there is some rules set. But I don't find any rules
>> in /etc/udev/rules.d specific to /dev/sdb can it be set somewhere
>> else?
>>
> 
> 
> Default rules are in /usr/lib/udev, but rules can only block udev
> events (if at all), they have no impact on what kernel does. I guess
> util-linux would be a better place to ask about mkfs behavior.
> 



In the event of a mkfs.btrfs on a device the udev action to scan
the device into the btrfs kernel is redundant !. because mkfs.btrfs
is already doing it.

/usr/lib/udev has quite a lot of rules.
Now how do I find why udev has an rule for sdc and not for sdb.
There isn't any obvious things I found in /usr/lib/udev for sdc/sdb.

Thanks, Anand
