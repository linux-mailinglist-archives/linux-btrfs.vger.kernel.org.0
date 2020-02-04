Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEA1715150C
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 05:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgBDEk4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 23:40:56 -0500
Received: from mout.gmx.net ([212.227.15.15]:54281 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbgBDEk4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Feb 2020 23:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580791250;
        bh=0e2CSHt9cfDoUqQCGxsTrqFSC3RB3d15jYl2tZMllxM=;
        h=X-UI-Sender-Class:From:Subject:To:References:Date:In-Reply-To;
        b=JsjBNxIAwWs2tZRPIhjuyec3huX1Qyq7neMOaXoM7aLBj0T9fkhJNl+EuG7xeaWTA
         dI+ulIkSMHFBZayGvQ0sFVNLKLY4LHQjI8S3LEJ3sly+Q1UI87OPEFf4oPSLYsvcFr
         ByMeQLnLTtT/D6TTec592qX9n5pjGPPor+BmOW6I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.111] ([104.199.231.176]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MFsUv-1ilJlO1zkl-00HLkZ; Tue, 04
 Feb 2020 05:40:50 +0100
From:   Su Yue <Damenly_Su@gmx.com>
Subject: Re: [PATCH 02/11] btrfs-progs: misc-tests/034: mount the second
 device if first device mount failed
To:     Nikolay Borisov <nborisov@suse.com>, damenly.su@gmail.com,
        linux-btrfs@vger.kernel.org
References: <20191212110204.11128-1-Damenly_Su@gmx.com>
 <20191212110204.11128-3-Damenly_Su@gmx.com>
 <2eba385b-1d75-ce1b-669f-f8722dc016fa@suse.com>
 <000a9744-a72d-88ff-51f1-2705be98bd75@gmx.com>
 <0145aaff-0e5f-af9d-4bc3-057c983ab52a@suse.com>
Message-ID: <7795cdb5-a17b-bea4-52ab-f4ab4e773bfd@gmx.com>
Date:   Tue, 4 Feb 2020 12:40:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <0145aaff-0e5f-af9d-4bc3-057c983ab52a@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OAv6cnlPkyrifRAFRbmI9nq326xyVvwIfwUelAGO5+RIciDW1j5
 EDlENwjnsA1Qt4vlJl0Y4vUG2rWajRKcjucNdL/lba821gM5nCqRbgHwPhT1UcgT/wpNJqH
 25qhLQ2MVK8k4b0/Thz/wkw1eFY2JUy9p/bk1q7D6Z5RBEiKJ6VALFXvR7Nv+CFVx0WH0N1
 Gm1Xlg3JRyG4oTnqvb08Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fOG49JMeBec=:rhSjPZQ7krDsH2JWyylJwW
 DR6YH+rQtlfRK6VJWFVQ2VXPB7SMaL1BOTAgb8JBa7N/Jqrww2bMho/GdiQ3dnWul9hpFbF58
 yzrub3Q3vIeC2/dz5lkpZTzXadZIXqftteBVKzDCcYidx+1W11A/JiUG7vd60egVJX4i1u0aL
 Wkb/UlZfwpd9F3Bxm+0tNNxY6QwBLq4o9tt6hxhk+0vQJ5/N/3Wb5fKMB7KL/8qIqyMTji55Q
 WQ+0zywymtbht1vT7MfDFIyZ37jniMwGQArs5OOf3YsuhcYrVkL7bWpWC+axzE9ZENFallawO
 7yYBYrWaIDcKWrkEQZJsz7RStg/w1Mc1VaBoNO++1l193iOvTWpnl472+UPRn4iWL7T5OGTwY
 AQrVegLbis4R0dM+elDvJMR1AJa3wvo8rFbspqZ1/ZQ6+fvXKSe9u/i3Ayng0y20FBbMWBIn6
 BkLLnk5gXo0K8SWyZT9PIl0l95r6qzw2nQNIwaR15ENRiqK1XwKVjJVd+8CSCTlEgB0G/vBJt
 6nbI0elraF5fBlVTth3hhgG8WJiW+sfxFOXnJz1e7GLz/02eVmsH4kaDhmAYoFGryCv3nXYT9
 v4jXdfEgD0X7I5+t2vZT2996HgDr12wLYOCTVpnXJg8gKA1C3qXeNTj/fPY39qaajDoC97anQ
 QwK1CSSZ99FcvLAqEJTNcxSVhamOVLQxlsoOgndtZ253691BTrAmvy0h2/75Ss5nsquZKNJVN
 BObvYnuvFLJcn5UeBvhWNTIYbJ3YeCvF+g9/6Y/0x/sNKEMPqJOTO4YAweOHciHh5m6fnJ3QM
 QTL/5u9qekVpZ5bePw0uu8x87FyRN2A6v68DoTf31L5E+rvVbIvaUjRGMiwbjaX5GfDoBFgxU
 dV0mkd6zB5WA+lQ4FjUwdHYFndyC5xiuD72A9M9xNmn+Lsh5CR2U6qqN7W9rdpyzPb3sp+hk1
 R7c2bqSREOS1ptTHE3blFIG283P6+CF5drGRS2SOzV636+TyyCkhwJhAfY5Oa00nSbhTZ8sb6
 nuB20/dqMd20ssePmellKwf9i3oJ02Nu3nWDF24p/w45Gb6Wkbiml5Q4xr7XFykWO2sB6Y1Gq
 3K2Nwlbi4mzvp33nmSmghhRHmt+YoXs9wNiakQ7he+cZUtgBBG0vF6SAbkJKgyEwshoS26fG5
 Vf7JakAjT0jqtGjXnjbkabNzWKOQ7g35WhzbvYKyIsWZYK21H9u9osg/LDEozQ10GSKqGMamF
 a/Ui0MDP5hiK1O3Ly
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020/1/31 8:47 PM, Nikolay Borisov wrote:
>
>
> On 31.01.20 =D0=B3. 12:01 =D1=87., Su Yue wrote:
>> On 2020/1/31 4:03 PM, Nikolay Borisov wrote:
>>>
>>>
>>> On 12.12.19 =D0=B3. 13:01 =D1=87., damenly.su@gmail.com wrote:
>>>> From: Su Yue <Damenly_Su@gmx.com>
>>>>
>>>> The 034 test may fail to mount, and dmesg says open_ctree() failed du=
e
>>>> to device missing.
>>>>
>>>> The partly work flow is
>>>> step1 loop1 =3D losetup image1
>>>> step2 loop2 =3D losetup image2
>>>> setp3 mount loop1
>>>>
>>>> The dmesg says the loop2 device is missing.
>>>> It's possible and known that while step3 is in open_ctree() and
>>>> fs_devices->opened is nonzero, loop2 device has not been added into t=
he
>>>
>>>
>>> Care to give more details how this can happen? I haven't observed such=
 a
>>> failure, meaning it's likely due to some race condition. More details
>>> are needed though. In your change log you say "it's known" but
>>> apparently only to you in this case.
>>>
>>
>> Sure. There's a device missing situation[1] if two
>> devices(raid 1/0) were caught by udev. Yes, it's
>> not related to the metadata fsid feature. It just
>> makes the mount operation due to the missing device then
>> the test fails.
>
> Ok but in those mail posts it says the problem occurs if we have a
> multi-device btrfs volume, in this case raid1, and one of the devices is
> missing. The pertinent question is why would any of the testing devices
> be missing? Did you actually experience such failure ? loop1 is acquired
> after running losetup --find --show, implying that after the command is
> finished the given loopback device is fully present to the system?
>
>
Yes, I did experience such failures. Although I'm not familiar with
udevd, found something for your questions.
My superficial answers blow after looking through loop device
and udevd codes. If found something wrong please correct me.

After "losetup --find --show", the loopback devices are full
present to the system. And userspace received uevents from
kernel. Losetup only handles the loopback device things but
not such fs things on the loopback device. It's udevd' work to
handle the uevent for the device by rules.

The issue is that udevd may be handling the uevent of one device while
doing mount the another device. For btrfs, udevd calls ioctls on
/dev/btrfs-control.


Thread *mounting device1*            Thread *scanning device2*


btrfs_mount_root                     btrfs_control_ioctl

   mutex_lock(&uuid_mutex);

     btrfs_read_disk_super
     btrfs_scan_one_device
     --> there is only device1
     in the fs_devices

     btrfs_open_devices
       fs_devices->opened =3D 1
     mutex_unlock(&uuid_mutex);

                                       mutex_lock(&uuid_mutex);
                                       btrfs_scan_one_device
                                         btrfs_read_disk_super

                                         device_list_add
                                           found fs_devices
                                             device =3D btrfs_find_device

                                           if (!device)
                                              if(fs_devices->opened)
                                                 return -EBUSY
                                              --> the device2 adding
                                                  aborts since
						 fs_devices was opened
                                       mutex_unlock(&uuid_mutex);
   btrfs_fill_super
     open_ctree
       btrfs_read_sys_array
         read_one_chunk
	--> error due to the
	    device2 missing


Then mount failed because of the missing device.


>
>>
>> In this script, $loop1 *may* be failed to be mounted because
>> $loop2 is "missing". Mounting $loop2 device can verify the
>> metadata fsid functionality but without the degraded option.
>>
>>
>> [1]: https://www.spinics.net/lists/linux-btrfs/msg96312.html

