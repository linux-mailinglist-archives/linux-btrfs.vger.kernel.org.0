Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD42103464
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2019 07:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfKTGpD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Nov 2019 01:45:03 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46886 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfKTGpD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Nov 2019 01:45:03 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAK6htAV177338;
        Wed, 20 Nov 2019 06:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=L/gVDSStcMBCx5RvUhLdXAjVSLuofkf3BoY0eu3ukh4=;
 b=gEJ9/dlN1h8O3VHzpXavAGZ8EPQ0KEgEJyFTgG7f1Gk90wpTFUui27IWfq7KrtTUzCGL
 6xLPcAClwX9nbQYY1CeXNsDYYRwZ4JeTBV9/r3hLzDjRypFRz0SMAXm8UgPPAaThUXsk
 JvDoyFOPR4DIqMPI4sAPs6N/tetAnUM4szOWTGSCn1Fr7oHnxD9hw6XbZZ9wuOUVv02Q
 vB3ahC9pUkwQsZ3t+JCWIqKMHt9ZqIkU8qDph5Ewajoh1jiBzFDK0rFGvUKgVUp8YHPg
 JifYfFNurOv7iuZiqFBD1HOXyXFo8iQXT1OAYwaiCWxjwSblGgX8fOHLCIwmVNwsQXeW xw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2wa8htuj8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 06:44:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAK6i4xk041329;
        Wed, 20 Nov 2019 06:44:58 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2wc09yqxq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 06:44:58 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAK6iu9D016160;
        Wed, 20 Nov 2019 06:44:56 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Nov 2019 22:44:56 -0800
Subject: Re: [PATCH 00/15] btrfs: sysfs, cleanups
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20191118084656.3089-1-anand.jain@oracle.com>
 <20191118154556.GJ3001@twin.jikos.cz>
 <99f5241a-bf39-3f12-dfce-29cfafdc5c42@oracle.com>
 <20191119123749.GR3001@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <516598e6-4968-4535-cf6b-12402518b7cc@oracle.com>
Date:   Wed, 20 Nov 2019 14:44:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191119123749.GR3001@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9446 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911200060
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9446 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911200060
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11/19/19 8:37 PM, David Sterba wrote:
> On Tue, Nov 19, 2019 at 02:44:10PM +0800, Anand Jain wrote:
>>
>>
>> On 11/18/19 11:45 PM, David Sterba wrote:
>>> On Mon, Nov 18, 2019 at 04:46:41PM +0800, Anand Jain wrote:
>>>> Mostly cleanups patches.
>>>>
>>>> Patches 1-7 are renames, code moves patches and there are no
>>>> functional changes.
>>>>
>>>> Patch 8 drops unused argument in the function btrfs_sysfs_add_fsid().
>>>> Patch 9 merges two small functions which is an extension of the other.
>>>>
>>>> Patches 10,11 and 13 removes unnecessary features in the functions,
>>>> originally it was planned to provide sysfs attributes for the scanned
>>>> and unmounted devices, as in the un-merged patch in the mailing list [1]
>>>>      [1] [PATCH] btrfs: Introduce device pool sysfs attributes
>>>
>>> We want something like that,
>>
>>    Oh.
>>
>>    Ok then I shall relook at these patches with a mind that we might
>>    introduce the sysfs for non mounted devices.
>>
>>> I don't recall all the past discussions,
>>
>>    No worries. There wasn't any discussions on this specific topic.
> 
> There were several patchsets sent adding device information exports, and
> commented, eg.
> 
> https://lore.kernel.org/linux-btrfs/1423439785-10260-1-git-send-email-anand.jain@oracle.com/t/#u
> https://lore.kernel.org/linux-btrfs/1416814173-16945-1-git-send-email-anand.jain@oracle.com/t/#u
> 
> and maybe followups.
> 

  Ah I missed those reply as I checked the much later patch.

 
https://lore.kernel.org/linux-btrfs/1ac04f0d-f33e-8161-4688-eebb42d51a54@oracle.com/

>>
>>> but a separate directory for all the new sysfs files should be
>>> introduced. Extending the existing /devices/ that contains just the
>>> sysfs device like should stay as is.
>>>
>>> /sys/fs/btrfs/UUID/
>>> 	devinfo/
>>> 		1/
>>> 			uuid
>>> 			state
>>> 			...
>>> 		2/
>>> 			...
>>>
>>
>>    umm how about..
>>
>> $ btrfs fi show
>> Label: none  uuid: 52ad6beb-524d-4cd8-8979-0890d0b74314
>> 	Total devices 4 FS bytes used 384.00KiB
>> 	devid    1 size 2.93GiB used 368.00MiB path /dev/sdb
>> 	devid    2 size 2.93GiB used 368.00MiB path /dev/sdc
>> 	devid    3 size 2.93GiB used 368.00MiB path /dev/sdd
>> 	devid    4 size 2.93GiB used 368.00MiB path /dev/sde
>>
>>
>> # ls -l /sys/fs/btrfs/52ad6beb-524d-4cd8-8979-0890d0b74314/devices/
>> total 0
>> drwxr-xr-x 2 root root 0 Nov 19 14:39 1_sdb
> 
> Something like that has been suggested in the patchsets, I disagree with
> the device id and name being glued together. The sysfs files should
> server scripting, the enumeration should be straightforward and not
> requiring parsing of the filenames.
> 

  Oh right point.

>> drwxr-xr-x 2 root root 0 Nov 19 14:39 2_sdc
>> drwxr-xr-x 2 root root 0 Nov 19 14:39 3_sdd
>> drwxr-xr-x 2 root root 0 Nov 19 14:39 4_sde
>> lrwxrwxrwx 1 root root 0 Nov 19 14:39 sdb ->
>> ../../../../devices/pci0000:00/0000:00:0d.0/ata2/host1/target1:0:0/1:0:0:0/block/sdb
>> lrwxrwxrwx 1 root root 0 Nov 19 14:39 sdc ->
>> ../../../../devices/pci0000:00/0000:00:0d.0/ata3/host2/target2:0:0/2:0:0:0/block/sdc
>> lrwxrwxrwx 1 root root 0 Nov 19 14:39 sdd ->
>> ../../../../devices/pci0000:00/0000:00:0d.0/ata4/host3/target3:0:0/3:0:0:0/block/sdd
>> lrwxrwxrwx 1 root root 0 Nov 19 14:39 sde ->
>> ../../../../devices/pci0000:00/0000:00:0d.0/ata5/host4/target4:0:0/4:0:0:0/block/sde
> 
> If you want to put the directories under /sys/fs/btrfs/UUID/deevices/
> then it's probably ok as long as there device node links are plain files
> and the directories represent the ids. But just the ids, the actual
> device name depends on the assignment by block layer. This is not
> persistent.
> 
> So two possible layouts:
> 
> fs/UUID/devices
> 	sda
> 	sdb
> 	sdc
> 	1/
> 		...
> 	2/
> 		...
> 	3/
> 		...

  Will use this layout.

Thanks, Anand

> Or the one suggested before, where devices by id are in a separate
> directory. This is modelled after /dev/disk/by-id and the like, but I
> don't think we need to make it granular like that.
> 




