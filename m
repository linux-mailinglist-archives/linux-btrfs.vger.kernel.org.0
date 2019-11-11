Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6ABAF6DC9
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2019 06:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfKKFUA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Nov 2019 00:20:00 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:60532 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfKKFUA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Nov 2019 00:20:00 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAB5JCLx066305;
        Mon, 11 Nov 2019 05:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=j8Zv53uyfxzMm4Ln6RLQbMCtAXLaGpi2ESYAlMcAR0k=;
 b=LJfVElB7F9TDpa8tI2h7F0xBP92JHCpvAJtBHCJPh+kWR//g3YSeok5U9m9YgpQhra5E
 hQwPOfgyuvFnE5JOUs35mx2heeFCVxjQ0KSryZ64w1PKcZXccws9kid1/vMjqoXED5PN
 J174JFn33N8uVTFzEBssVyWWv49ypgw6/MDD7VqJ4b3wfIJtY97zWZlmXmgsez8Yn5bl
 eyzFLs9XIEYSnjWqaApEYNodHUBNQAGOg+81NhjrdDlj2CqAMOA2CWOJYMFpmHDQeGWo
 q3FAmg1tWgK2bTkCmj0ylAXrN+xnxvqJyE1mlQCe7f2++VGB797zVuxGzzOFvswNC7Ep EQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2w5ndpvr33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Nov 2019 05:19:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAB5I1V7059661;
        Mon, 11 Nov 2019 05:19:55 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2w66yuvhk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Nov 2019 05:19:55 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAB5JsN5018835;
        Mon, 11 Nov 2019 05:19:55 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 10 Nov 2019 21:19:54 -0800
Subject: Re: dd does it again!
To:     Paul Monsour <boulos@gmx.com>, linux-btrfs@vger.kernel.org
References: <trinity-9b5e3549-dd52-48e7-98f1-9f8bfd1a358a-1573440280042@3c-app-mailcom-bs04>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <0c77436e-1347-dcfd-ec2f-bbca8c55827d@oracle.com>
Date:   Mon, 11 Nov 2019 13:19:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <trinity-9b5e3549-dd52-48e7-98f1-9f8bfd1a358a-1573440280042@3c-app-mailcom-bs04>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9437 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911110051
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9437 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911110051
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/11/19 10:44 AM, Paul Monsour wrote:
> Hi,
> 
> I did it; I used dd and accidentally zapped all of my personal files, which were under the /home directory. This was a btrfs raid0 setup with /dev/sdc1 and /dev/sdd1. I aborted the command after it had started but before it had completed. Neither directory is now mountable, but btrfs fi show produced the following output:
> 
> [root@sysresccd /]# btrfs fi show
> Label: none  uuid: 9819165f-fade-471a-9f93-86f36523e58a
>      Total devices 1 FS bytes used 28.81GiB
>      devid    1 size 48.82GiB used 32.02GiB path /dev/sdb1
> warning, device 2 is missing
> Label: none  uuid: 9985ee11-bc6d-4f06-ab15-3156457ba29c
>      Total devices 1 FS bytes used 32.75GiB
>      devid    1 size 58.59GiB used 45.06GiB path /dev/sdb5
> Label: none  uuid: 073f1926-d84d-4150-9498-4239b5383272
>      Total devices 2 FS bytes used 629.10GiB
>      devid    1 size 2.73TiB used 646.12GiB path /dev/sdc1
>      *** Some devices missing
> 
> parted -l produced:
> 
> Model: ATA ST3000DM008-2DM1 (scsi)
> Disk /dev/sdc: 3001GB
> Sector size (logical/physical): 512B/4096B
> Partition Table: gpt
> Disk Flags:
> Number  Start   End     Size    File system  Name  Flags
>   1      1049kB  3001GB  3001GB  btrfs        Home
> 
> Model: ATA ST3000DM008-2DM1 (scsi)
> Disk /dev/sdd: 3001GB
> Sector size (logical/physical): 512B/4096B
> Partition Table: msdos
> Disk Flags:
> Number  Start  End     Size    Type     File system  Flags
>   2      119kB  1593kB  1475kB  primary               esp
> 
> The portion of the dd command that wrecked the files was "of=/dev/sdd1"

  btrfs keeps 2 or 3 copies of superblock depending on the disk size,
  you could try recover superblock from the backup superblock, but
  first try to read all the superblocks using the command..
    btrfs inspect-internal dump-super -a <dev>
  And if there is any superblock copy which is still not overwritten.
  you can recover using..
    btrfs rescue super-recover [options] <device>

  But depending on the extent of the accidental overwrite on the
  RAID0, there is slim chances to recover the data and metadata.

HTH.

Thanks, Anand


> 
> btrfs restore produced just:
> 
> drwxr-xr-x 1 root root   0 Nov 10 12:43 ftp
> drwxr-xr-x 1 root root 362 Nov 10 12:51 palsor
> 
> However, I was (perhaps optimistically) heartened by what "btrfs-find-root /dev/sdc1" produced:
> 
> # btrfs-find-root /dev/sdc1
> warning, device 2 is missing
> Superblock thinks the generation is 322292
> Superblock thinks the level is 1
> Found tree root at 649710272512 gen 322292 level 1
> 
> How do I use this information? Is there reason to be optimistic?
> 
> Thanks in advance for your help.
> 
> Paul Monsour
> 
> 
> 
> 

