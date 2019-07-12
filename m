Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F50E66F20
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2019 14:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfGLMre (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jul 2019 08:47:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55982 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfGLMre (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jul 2019 08:47:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6CCdSqh037133;
        Fri, 12 Jul 2019 12:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=HJ3wmZz0JqyJJXoIpTglzZn4+bsFbHFgaGLJzVzhxCc=;
 b=n3UzgFmqZruRK/Pbt0S1wGlnaXqz7pReOJYzT/z5k8FWEAK6R1XeG0okaw3c/zHGwUEz
 OEhgHPlTuu8Uz15RLhAs+xqAiOEDxmzMiLypRupUOqwjD2BufcEG+hxREI5s3dkMELxY
 oxyEje3P4SmVmgfCoZA7FXTr2r3P5LxBottP40g6+VgQRBprUCNop/bFuiZ1adTviA9d
 mk+ZZwuJnADG+CJzQUQd2UUvgEpTh1BJLyZCaMkn/rBnH/ayq2i2JYNjP0y1AlXnzYQV
 QWQKdc1jMYhfLBBmZ+d+v9SLXpmbauItYJ+mKk+oxudqzMw0/RqDjBzpg0EIoMdgJWOS UQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2tjm9r5dh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 12:47:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6CCgsSr181431;
        Fri, 12 Jul 2019 12:47:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2tpefd2urw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 12:47:14 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6CClAww007910;
        Fri, 12 Jul 2019 12:47:11 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Jul 2019 05:47:10 -0700
Subject: Re: "btrfs: harden agaist duplicate fsid" spams syslog
To:     Graham Cobb <g.btrfs@cobb.uk.net>, linux-btrfs@vger.kernel.org
References: <5d8baf80-4fb3-221f-5ab4-e98a838f63e1@cobb.uk.net>
 <c01ab9f6-c553-3625-5656-a8f61659de7d@oracle.com>
 <a3d6e202-acf4-c02e-430a-aef4a2ee4247@cobb.uk.net>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     calestyo@scientia.net
Message-ID: <7766d592-525e-67fa-5db0-bcfff17fbf83@oracle.com>
Date:   Fri, 12 Jul 2019 20:46:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a3d6e202-acf4-c02e-430a-aef4a2ee4247@cobb.uk.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907120138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120138
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



I am unable to reproduce, I have tried with/without dm-crypt on both
oraclelinux and opensuse (I am yet to try debian).

The patch in $subject is fair, but changing device path indicates
there is some problem in the system. However, I didn't expect
same device pointed by both /dev/dm-x and /dev/mapper/abc would
contended.

One fix for this is to make it a ratelimit print. But then the same
thing happens without notice. If you monitor /proc/self/mounts
probably you will notice that mount device changes every ~2mins.

I will be more keen to find the module which is causing this issue,
that is calling 'btrfs dev scan' every ~2mins or trying to mount
an unmounted device without understanding that its mapper is already
mounted.

Thanks, Anand



On 12/7/19 2:00 AM, Graham Cobb wrote:
> On 11/07/2019 03:46, Anand Jain wrote:
>> Now the question I am trying to understand, why same device is being
>> scanned every 2 mins, even though its already mount-ed. I am guessing
>> its toggling the same device paths trying to mount the device-path
>> which is not mounted. So autofs's check for the device mount seems to
>> be path based.
>>
>> Would you please provide your LVM configs and I believe you are using
>> dm-mapping too. What are the device paths used in the fstab and in grub.
>> And do you see these messages for all devices of
>> 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 or just devid 4? Would you please
>> provide more logs at least a complete cycle of the repeating logs.
> 
> My setup is quite complex, with three btrfs-over-LVM-over-LUKS
> filesystems, so I will explain it fully in a separate message in case it
> is important. Let me first answer your questions regarding
> 4d1ba5af-8b89-4cb5-96c6-55d1f028a202, which was the example I used in my
> initial log extract.
> 
> 4d1b...a202 is a filesystem with a main mount point of /mnt/backup2/:
> 
> black:~# btrfs fi show /mnt/backup2/
> Label: 'snap12tb'  uuid: 4d1ba5af-8b89-4cb5-96c6-55d1f028a202
>          Total devices 2 FS bytes used 10.97TiB
>          devid    1 size 10.82TiB used 10.82TiB path /dev/sdc3
>          devid    4 size 3.62TiB used 199.00GiB path
> /dev/mapper/cryptdata4tb--vg-backup
> 
> In this particular filesystem, it has two devices: one is a real disk
> partition (/dev/sdc3), the other is an LVM logical volume. It has also
> had other LVM devices added and removed at various times, but this is
> the current setup.
> 
> Note: when I added this LV, I used path /dev/mapper/cryptdata4tb--vg-backup.
> 
> black:~# lvdisplay /dev/cryptdata4tb-vg/backup
>    --- Logical volume ---
>    LV Path                /dev/cryptdata4tb-vg/backup
>    LV Name                backup
>    VG Name                cryptdata4tb-vg
>    LV UUID                TZaWfo-goG1-GsNV-GCZL-rpbz-IW0H-gNmXBf
>    LV Write Access        read/write
>    LV Creation host, time black, 2019-07-10 10:40:28 +0100
>    LV Status              available
>    # open                 1
>    LV Size                3.62 TiB
>    Current LE             949089
>    Segments               1
>    Allocation             inherit
>    Read ahead sectors     auto
>    - currently set to     256
>    Block device           254:13
> 
> The LVM logical volume is exposed as /dev/mapper/cryptdata4tb--vg-backup
> which is a symlink (set up by LVM, I believe) to /dev/dm-13.
> 
> For the 4d1b...a202 filesystem I currently only see the messages for
> devid 4. But I presume that is because devid 1 is a real device, which
> only appears in /dev once. I did, for a while, have two LV devices in
> this filesystem and, looking at the old logs, I can see that every 2
> minutes the swapping between /dev/mapper/whatever and /dev/dm-N was
> happening for both LV devids (but not for the physical device devid)
> 
> This particular device is not a root device and I do not believe it is
> referenced in grub or initramfs. It is mounted in /etc/fstab/:
> 
> LABEL=snap12tb  /mnt/backup2    btrfs
> defaults,subvolid=0,noatime,nodiratime,compress=lzo,skip_balance,space_cache=v2
>         0       3
> 
> Note that /dev/disk/by-label/snap12tb is a symlink to the dm-N alias of
> the LV device (set up by LVM or udev or something - not by me):
> 
> black:~# ls -l /dev/disk/by-label/snap12tb
> lrwxrwxrwx 1 root root 11 Jul 11 18:18 /dev/disk/by-label/snap12tb ->
> .../../dm-13
> 
> Here is a log extract of the cycling messages for the 4d1b...a202
> filesystem:
> 
> Jul 11 18:46:28 black kernel: [116657.825658] BTRFS info (device sdc3):
> device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
> old:/dev/mapper/cryptdata4tb--vg-backup new:/dev/dm-13
> Jul 11 18:46:28 black kernel: [116658.048042] BTRFS info (device sdc3):
> device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
> old:/dev/dm-13 new:/dev/mapper/cryptdata4tb--vg-backup
> Jul 11 18:46:29 black kernel: [116659.157392] BTRFS info (device sdc3):
> device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
> old:/dev/mapper/cryptdata4tb--vg-backup new:/dev/dm-13
> Jul 11 18:46:29 black kernel: [116659.337504] BTRFS info (device sdc3):
> device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
> old:/dev/dm-13 new:/dev/mapper/cryptdata4tb--vg-backup
> Jul 11 18:48:28 black kernel: [116777.727262] BTRFS info (device sdc3):
> device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
> old:/dev/mapper/cryptdata4tb--vg-backup new:/dev/dm-13
> Jul 11 18:48:28 black kernel: [116778.019874] BTRFS info (device sdc3):
> device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
> old:/dev/dm-13 new:/dev/mapper/cryptdata4tb--vg-backup
> Jul 11 18:48:29 black kernel: [116779.157038] BTRFS info (device sdc3):
> device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
> old:/dev/mapper/cryptdata4tb--vg-backup new:/dev/dm-13
> Jul 11 18:48:30 black kernel: [116779.364959] BTRFS info (device sdc3):
> device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
> old:/dev/dm-13 new:/dev/mapper/cryptdata4tb--vg-backup
> Jul 11 18:50:28 black kernel: [116897.705568] BTRFS info (device sdc3):
> device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
> old:/dev/mapper/cryptdata4tb--vg-backup new:/dev/dm-13
> Jul 11 18:50:28 black kernel: [116897.911805] BTRFS info (device sdc3):
> device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
> old:/dev/dm-13 new:/dev/mapper/cryptdata4tb--vg-backup
> Jul 11 18:50:29 black kernel: [116899.053046] BTRFS info (device sdc3):
> device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
> old:/dev/mapper/cryptdata4tb--vg-backup new:/dev/dm-13
> Jul 11 18:50:29 black kernel: [116899.213067] BTRFS info (device sdc3):
> device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
> old:/dev/dm-13 new:/dev/mapper/cryptdata4tb--vg-backup
> 
> 
> I will, later, provide more detailed configuration information,
> including the other filesystems and more logs. As that will be very long
> I plan to send it directly to you, Anand, rather than to the list.
> 
> Graham
> 

