Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B76F101981
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 07:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfKSGoT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 01:44:19 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58322 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfKSGoT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 01:44:19 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ6iF8N179955;
        Tue, 19 Nov 2019 06:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=+ge2f7Mzm5tNA15aLyus0A+R9H7GwI37nW6oP6LxeI0=;
 b=ccLdx0hJjgJ2l7lMf0Lug6JfFGhjZ7DrOO+mu3+E/4DhEH1U5vknXCQciKK4bhLJz2qr
 yr13As+6nwM17tTAR9ft0y8SPOa7e6+TsBj763widO8DG7rx8FAnomwGIlLdXvjSLmlR
 o1BldXRoML0KmlF5V6XG9x9p9vg4SY5I6Q9YXNaZAF/JHxsDqNgIJbB7gnYduKpBQaKG
 9wESaw8x0w4jlLsw1NUKwg4DQxzzMT9sJszwRpJwitF2Ognpx6VFDD2Fgynmwqvwt7zY
 BhlIxZmKCnlA6xL3Wm+krQzMveIzmy458MQSVrXuzAKK2KBTJPhn4GS3xhY7TVT3Lx5G 9w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wa92pmtf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 06:44:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ6huRM153810;
        Tue, 19 Nov 2019 06:44:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2wbxgegubg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 06:44:14 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAJ6iDht009186;
        Tue, 19 Nov 2019 06:44:13 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 22:44:12 -0800
Subject: Re: [PATCH 00/15] btrfs: sysfs, cleanups
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20191118084656.3089-1-anand.jain@oracle.com>
 <20191118154556.GJ3001@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <99f5241a-bf39-3f12-dfce-29cfafdc5c42@oracle.com>
Date:   Tue, 19 Nov 2019 14:44:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191118154556.GJ3001@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911190061
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911190061
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11/18/19 11:45 PM, David Sterba wrote:
> On Mon, Nov 18, 2019 at 04:46:41PM +0800, Anand Jain wrote:
>> Mostly cleanups patches.
>>
>> Patches 1-7 are renames, code moves patches and there are no
>> functional changes.
>>
>> Patch 8 drops unused argument in the function btrfs_sysfs_add_fsid().
>> Patch 9 merges two small functions which is an extension of the other.
>>
>> Patches 10,11 and 13 removes unnecessary features in the functions,
>> originally it was planned to provide sysfs attributes for the scanned
>> and unmounted devices, as in the un-merged patch in the mailing list [1]
>>     [1] [PATCH] btrfs: Introduce device pool sysfs attributes
> 
> We want something like that,

  Oh.

  Ok then I shall relook at these patches with a mind that we might
  introduce the sysfs for non mounted devices.

> I don't recall all the past discussions,

  No worries. There wasn't any discussions on this specific topic.

> but a separate directory for all the new sysfs files should be
> introduced. Extending the existing /devices/ that contains just the
> sysfs device like should stay as is.
> 
> /sys/fs/btrfs/UUID/
> 	devinfo/
> 		1/
> 			uuid
> 			state
> 			...
> 		2/
> 			...
> 

  umm how about..

$ btrfs fi show
Label: none  uuid: 52ad6beb-524d-4cd8-8979-0890d0b74314
	Total devices 4 FS bytes used 384.00KiB
	devid    1 size 2.93GiB used 368.00MiB path /dev/sdb
	devid    2 size 2.93GiB used 368.00MiB path /dev/sdc
	devid    3 size 2.93GiB used 368.00MiB path /dev/sdd
	devid    4 size 2.93GiB used 368.00MiB path /dev/sde


# ls -l /sys/fs/btrfs/52ad6beb-524d-4cd8-8979-0890d0b74314/devices/
total 0
drwxr-xr-x 2 root root 0 Nov 19 14:39 1_sdb
drwxr-xr-x 2 root root 0 Nov 19 14:39 2_sdc
drwxr-xr-x 2 root root 0 Nov 19 14:39 3_sdd
drwxr-xr-x 2 root root 0 Nov 19 14:39 4_sde
lrwxrwxrwx 1 root root 0 Nov 19 14:39 sdb -> 
../../../../devices/pci0000:00/0000:00:0d.0/ata2/host1/target1:0:0/1:0:0:0/block/sdb
lrwxrwxrwx 1 root root 0 Nov 19 14:39 sdc -> 
../../../../devices/pci0000:00/0000:00:0d.0/ata3/host2/target2:0:0/2:0:0:0/block/sdc
lrwxrwxrwx 1 root root 0 Nov 19 14:39 sdd -> 
../../../../devices/pci0000:00/0000:00:0d.0/ata4/host3/target3:0:0/3:0:0:0/block/sdd
lrwxrwxrwx 1 root root 0 Nov 19 14:39 sde -> 
../../../../devices/pci0000:00/0000:00:0d.0/ata5/host4/target4:0:0/4:0:0:0/block/sde

# cd /sys/fs/btrfs/52ad6beb-524d-4cd8-8979-0890d0b74314/devices/1_sdb
# ls -l
dev_state

(Currently its been coded to support only dev_state (patches under tests 
with me)).

Thanks, Anand
