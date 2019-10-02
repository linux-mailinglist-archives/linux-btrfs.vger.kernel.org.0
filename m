Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 163C6C4AF0
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2019 12:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfJBKB4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Oct 2019 06:01:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49328 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfJBKB4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Oct 2019 06:01:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x929upxH069725;
        Wed, 2 Oct 2019 10:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=99/ght6jVxKTWLc5bMMSjr07K2eimJghp8gJOqQPFYY=;
 b=F9Kuw/jAUcI+lCTLeSnLxtPaITWdIxoJUaiLc7g0kHjxMIty4AyA/iIAXpq9WefoM5Gn
 UNvhYg3KJlCHnd1YVEGgeKSYFoN3BZr+Z0UFOF9ZtCHzppRd7WtAi8pUBdCKRs5I6Knn
 WX5NuvkSduQxRFQVZp3noiN6wZkMcTuVxjbZGv6aIdK68/bqb4l63twAJDVndciY+v6t
 rn70KpxTG76jicYzpzJJLONWDgR+TnMd+yswLHHipOnzWNLiLn/nK5cUWxTXnTKotzOr
 NhLe8gb/jMV3W3i4XqbuLKfKkonklgwKBBcX9xR86Z73x/LyL1RZ1CQuQK89Rz0CggQq Yg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2v9xxuv1hf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Oct 2019 10:01:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x929neTb012922;
        Wed, 2 Oct 2019 10:01:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2vc9dk5kj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Oct 2019 10:01:53 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x92A1qhc005080;
        Wed, 2 Oct 2019 10:01:52 GMT
Received: from [10.186.52.87] (/10.186.52.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Oct 2019 03:01:52 -0700
Subject: Re: [bug] strange systemd-udevd scan for btrfs device
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     systemd-bugs@lists.freedesktop.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <9fe6ad9b-d53f-614c-5651-6de8bad93f1e@oracle.com>
 <CAA91j0UjpNycY0xhGVCzAkUJiwmrBPmk9PU6MpvW7mO0Zgki-g@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <c520c4f9-8d1c-41f9-0b80-fbff8fa966a3@oracle.com>
Date:   Wed, 2 Oct 2019 18:02:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAA91j0UjpNycY0xhGVCzAkUJiwmrBPmk9PU6MpvW7mO0Zgki-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9397 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910020093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9397 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910020093
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10/2/19 5:55 PM, Andrei Borzenkov wrote:
> On Wed, Oct 2, 2019 at 12:27 PM Anand Jain <anand.jain@oracle.com> wrote:
>>
>>
>>
>> I am looking for systemd part of the answers to understand what
>> is triggering a strange problem. Any help is appreciated.
>>
>> After mkfs.btrfs creates btrfs filesystem it scans to register the
>> device in btrfs.ko.
>> And we have 'btrfs dev scan --forget' command to undo the process of
>> register.
>>
>> But the problem is - immediately after 'btrfs dev scan --forget' the
>> systemd-udevd scans the device again, defeating the purpose of the
>> forget as show below (scanned-by).
>>
>> mkfs.btrfs -fq /dev/sdc && btrfs dev scan --forget /dev/sdc
>>
>> -------------------
>> kernel: BTRFS: device fsid 8ea20bb2-888a-4b3b-9f4c-1db9117dc219 devid 1
>> transid 5 /dev/sdc scanned-by mkfs.btrfs
>> kernel: BTRFS: device fsid 8ea20bb2-888a-4b3b-9f4c-1db9117dc219 devid 1
>> transid 5 /dev/sdc scanned-by systemd-udevd
>> -------------------
>>
>> And the problem does _not_ happen if there is a sleep of 3 secs after
>> the mkfs.btrfs, as below.
>>
>> mkfs.btrfs -fq /dev/sdc && sleep 3 && btrfs dev scan --forget /dev/sdc
>>
>> ------------------
>> kernel: BTRFS: device fsid 601bd01a-5e6b-488a-b020-0e7556c83087 devid 1
>> transid 5 /dev/sdc scanned-by mkfs.btrfs
>> ------------------
>>
>> Any idea what happening from the systemd point of view?
>>
> 
> run
> 
> udevadm monitor -ku
> 
> in both cases and post results. My educated guess is that udev scan is
> in response to mkfs and you have unfortunate race condition here.
> 


Looks like what is happening is ..

  . Change in fsid (by mkfs.btrfs) notifies and triggers systemd
  . Systemd checks if the device is ready by using
    BTRFS_IOC_DEVICES_READY.
  . However BTRFS_IOC_DEVICES_READY from systemd races with forget
    command and the result depends on who wins the race.

