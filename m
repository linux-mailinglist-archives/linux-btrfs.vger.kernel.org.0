Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2D1311DFE5
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2019 09:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfLMIvC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Dec 2019 03:51:02 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:32966 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfLMIvC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Dec 2019 03:51:02 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBD8duEW097167;
        Fri, 13 Dec 2019 08:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=RAJYOxPJft6ezCgj9LDLV30ww9fIA908ekuq/cqF5Pk=;
 b=oYM9biZuuIGMe/9JqvW4x6H62Wv8ok4pwhan/bn+7GAtFsDgzan5Z3WEFEvMbRx3iCbJ
 ++m3ttDuXxkeLL21P6zBrdW9m7LwEucQpG/HY+qhT9hraeP1oDMOFO++QWIF1ZgnbPGy
 /fyJJ95inHslaHMGKd7zVhuS4K6l9c8sKgfgL/YmadIUt6ycsZM7iXCUbFfik2wPOdUT
 MNt/hlWaCt0N26qZzxEoqQkdTpYmrQHHvdGmaos201eB0bXdr4GSHEFIMhgAK6u9hAk1
 eVK/QvDRSwFGF4xGmpDTTnWPBsjyAHgFvXFAcOnm+rDfnmZIhsC2s/2UVlU88qeqQWzV QQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2wrw4nmkxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 08:50:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBD8nqUj021040;
        Fri, 13 Dec 2019 08:50:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2wumk7xrja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 08:50:51 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBD8ooZh027797;
        Fri, 13 Dec 2019 08:50:50 GMT
Received: from [10.186.52.87] (/10.186.52.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Dec 2019 00:50:49 -0800
Subject: Re: [PATCH 1/6] btrfs: metadata_uuid: fix failed assertion due to
 unsuccessful device scan (reformatted)
To:     Su Yue <Damenly_Su@gmx.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, damenly.su@gmail.com,
        linux-btrfs@vger.kernel.org
References: <20191212110132.11063-1-Damenly_Su@gmx.com>
 <20191212110132.11063-2-Damenly_Su@gmx.com>
 <78eab88a-a6be-f87b-34d7-13a1cffbf36b@suse.com>
 <07e99b04-ec0c-f027-079e-b0d3c1e54970@gmx.com>
 <d0da81b4-801d-cb90-6e15-66905f190930@oracle.com>
 <d972b667-83a6-34a1-0b91-e7c6c7a80bad@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <e0f92849-dd6b-6e07-dcc6-66f681778cbc@oracle.com>
Date:   Fri, 13 Dec 2019 16:51:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <d972b667-83a6-34a1-0b91-e7c6c7a80bad@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912130071
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912130069
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12/13/19 3:15 PM, Su Yue wrote:
> On 2019/12/13 1:36 PM, Anand Jain wrote:
>>
>>
>>   metadata_uuid code is too confusing, a lot of if and if-nots
>>   it should be have been better.
>>
> 
> Agreed. It costed much brain power of mine.
> 
>>   more below.
>>
> 
> Willing to answer from my understanding.
> If something wrong, please point at.
> 
>> On 13/12/19 10:46 AM, Su Yue wrote:
>>> On 2019/12/12 10:15 PM, Nikolay Borisov wrote:
>>>>
>>>>
>>>> On 12.12.19 г. 13:01 ч., damenly.su@gmail.com wrote:
>>>>
>>>> <snip>
>>>>
>>>>> Acutally, there are two devices in the fs. Device 2 with
>>>>> FSID_CHANGING_V2 allocated a fs_devices. But, device 1 found the
>>>>> fs_devices but failed to be added into since fs_devices->opened (
>>>>
>>>> It's not clear why device 1 wasn't able to be added to the fs_devices
>>>> allocated by dev 2. Please elaborate?
>>>>
>>>>
>>> Sure, of course.
>>>
>>> For example.
>>>
>>> $cat test.sh
>>> ====================================================================
>>> img1="/tmp/test1.img"
>>> img2="/tmp/test2.img"
>>>
>>> [ -f "$img1" ] || fallocate -l 300M "$img1"
>>> [ -f "$img2" ] || fallocate -l 300M "$img2"
>>>
>>> mkfs.btrfs -f $img1 $img2 2>&1 >/dev/null|| exit 1
>>> losetup -D
>>>
>>> dmesg -C
>>> rmmod btrfs
>>> modprobe btrfs
>>>
>>> loop1=$(losetup --find --show "$img1")
>>> loop2=$(losetup --find --show "$img2")
>>
>>   Can you explicitly show what devices should be scanned to make the
>>   device mount (below) successful. Fist you can cleanup the
>>   device list using
>>
>>     btrfs device --forget
>>
> 
> Thanks for the tip.
> The purpose of simple script is to show that there
> may be uncompleted/unsuccessful device(s) scanning due to
> fs_devices->opened. Is the issue already known?


Do you mean at line 803.

-----------
  729 static noinline struct btrfs_device *device_list_add(const char *path,
  730                            struct btrfs_super_block *disk_super,
  731                            bool *new_device_added)
  732 {

::

  802         if (!device) {
  803                 if (fs_devices->opened) {
  804                       mutex_unlock(&fs_devices->device_list_mutex);
  805                       return ERR_PTR(-EBUSY);
  806                 }
------------

fs_devices->opened indicates mounted state of the device.

If there is a missing device, the %device will still be there,
we create a dummy %device with the dev_state set to
BTRFS_DEV_STATE_MISSING.

So its wrong if we encounter device == NULL for a given fsid
which is mounted. So by error and return we keep the mounted
fs safe and fail the hijacking attack.


>>> mount $loop1 /mnt || exit 1
>>> umount /mnt
>>> ====================================================================
>>>
>>> $dmesg
>>> ====================================================================
>>> [  395.205221] BTRFS: device fsid 5090db22-5e48-4767-8fb7-d037c619c1ee
>>> devid 1 transid 5 /dev/loop0 scanned by systemd-udevd (13620)
>>> [  395.210773] !!!!!!!!fs_device opened
>>> [  395.213875] BTRFS info (device loop0): disk space caching is enabled
>>> [  395.214994] BTRFS info (device loop0): has skinny extents
>>> [  395.215891] BTRFS info (device loop0): flagging fs with big metadata
>>> feature
>>> [  395.222639] BTRFS error (device loop0): devid 2 uuid
>>> adcc8454-695f-4e1d-bde8-94041b7bf761 is missing
>>> [  395.224147] BTRFS error (device loop0): failed to read the system
>>> array: -2
>>> [  395.246163] !!!!!!!!fs_device opened
>>> [  395.338219] BTRFS error (device loop0): open_ctree failed
>>> =====================================================================
>>>
>>> The line "!!!!!!!!fs_device opened" is handy added by me in debug 
>>> purpose.
>>>
>>> =====================================================================
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -794,6 +794,7 @@ static noinline struct btrfs_device
>>> *device_list_add(const char *path,
>>>
>>>          if (!device) {
>>>                  if (fs_devices->opened) {
>>> +                       pr_info("!!!!!!!!fs_device opened\n");
>>>                          mutex_unlock(&fs_devices->device_list_mutex);
>>>                          return ERR_PTR(-EBUSY);
>>>                  }
>>> =====================================================================
>>>
>>> To make it more clear. The following is in metadata_uuid situation.
>>> Device 1 is without FSID_CHANGING_V2 but has IMCOMPAT_METADATA_UUID.
>>> (newer transid).
>>>
>>> Device 2 is with FSID_CHANGING_V2 and IMCOMPAT_METADATA_UUID.(Older
>>> transid).
>>
>> How were you able to set FSID_CHANGING_V2

  Sorry typo, it should be BTRFS_SUPER_FLAG_CHANGING_FSID_V2.

>> and BTRFS_FEATURE_INCOMPAT_METADATA_UUID on only devid 2 ?
>>
>>
> The device2 is simulated to be the device failed to sync due
> to some expected reason (power loss).

  Ah. power loss before FSID_CHANGING_V2 is cleared. ok.

> mkfs on two devices, use v5.4 progs/btrfstune -m $device.
> Then both two devices both have the BTRFS_FEATURE_INCOMPAT_METADATA_UUID.
> Play some tricks in btrfstune.c to avoid final super block
> write on one deivce. Like the ugly code to delete the device:
> ========================================================================
> diff --git a/btrfstune.c b/btrfstune.c
> index afa3aae3..f678b978 100644
> --- a/btrfstune.c
> +++ b/btrfstune.c
> @@ -101,12 +101,14 @@ static int set_metadata_uuid(struct btrfs_root 
> *root, const char *uuid_string)
>          struct btrfs_super_block *disk_super;
>          uuid_t new_fsid, unused1, unused2;
>          struct btrfs_trans_handle *trans;
> +       struct btrfs_device *dev, *next;
>          bool new_uuid = true;
>          u64 incompat_flags;
>          bool uuid_changed;
>          u64 super_flags;
>          int ret;
> 
>          disk_super = root->fs_info->super_copy;
>          super_flags = btrfs_super_flags(disk_super);
>          incompat_flags = btrfs_super_incompat_flags(disk_super);
> @@ -170,6 +172,14 @@ static int set_metadata_uuid(struct btrfs_root 
> *root, const char *uuid_string)
>                  return 0;
>          }
> 
> +       list_for_each_entry_safe(dev, next, 
> &root->fs_info->fs_devices->devices,
> +                                dev_list) {
> +               if (dev->devid == 2) {
> +                       fsync(dev->fd);
> +                       list_del_init(&dev->dev_list);
> +               }
> +       }
> +==================================================================
> 

  Not like this. If you want to simulate failed write to the
  disk its better to do it with IO failing tools / mechanism outside
  of the btrfs-progs which probably can be a real fstests test case
  as well.

> Compile again. call btrfstune -m again.
> Then we get a device with
> BTRFS_FEATURE_INCOMPAT_METADATA_UUID and FSID_CHANGING_V2.
> 
>>> The workflow in misc-tests/034 is
>>>
>>> loop1=$(losetup --find --show "$device2")
>>> loop2=$(losetup --find --show "$device1")
>>>
>>> mount $loop1 /mnt ---> fails here
>>>
>>> Assume the fs_devices was allocated by systemd-udevd through
>>> btrfs_control_ioctl() path after finish of scanning of device2.
>>>
>>> Then:
>>>
>>
>> In the two threads which are in race (below), the mount thread can't 
>> be successful unless -o degraded is used, if it does it means the devid 1 
> 
> Right.. The dmesg reports the device 1 is missing.

  But then if you aren't using -o degraded then the mount shouldn't
  be successful. Are you using -o degraded?

> 
>> is already scanned and for that btrfs_device to be in the
>> btrfs_fs_devices list the fsid has to match (does not matter 
>> metadata_uuid).
> 
> Sorry, I doesn't make much clear what you mean. In similar but no 
> metadata_uuid situation, mount will fail too but the assertion won't
> fail of course. The device1 was scanned but not added into the
> fs_devices(already found) since the fs_devices was opened by the
> mounting thread.

  That's correct. But your test case with -o degraded and metadata_uuid
  is not clearly understood, is it possible to write a real fstests
  test case? you can use dmerror you will have control when to fail
  the IO.


>>
>>> Thread *mounting device2*            Thread *scanning device1*
>>>
>>>
>>> btrfs_mount_root                     btrfs_control_ioctl
>>>
>>>    mutex_lock(&uuid_mutex);
>>>
>>>      btrfs_read_disk_super
>>>      btrfs_scan_one_device
>>>      --> there is only device2
>>>      in the fs_devices
>>>
>>>      btrfs_open_devices
>>>        fs_devices->opened = 1
>>>        fs_devices->latest_bdev = device2
>>>
>>>      mutex_unlock(&uuid_mutex);
>>>
>>>                                        mutex_lock(&uuid_mutex);
>>>                                        btrfs_scan_one_device
>>>                                          btrfs_read_disk_super
>>>
>>>                                          device_list_add
>>>                                            found fs_devices
>>>                                              device = btrfs_find_device
>>>
>>>                                              rewrite fs_deivces->fsid if
>>>                                              scanned device1 is newer
>>>                                               --> Change fs_devices->fsi
>>>                                                    d to device1->fsid
>>>
>>>                                            if (!device)
>>>                                               if(fs_devices->opened)
>>>                           return -EBUSY
>>>                                               --> the device1 adding
>>>                                                   aborts since
>>>                                                   fs_devices was opened
>>>                                        mutex_unlock(&uuid_mutex);
>>>    btrfs_fill_super
>>>      open_ctree
>>>         btrfs_read_dev_super(
>>>         fs_devices->latest_bdev)
>>>         --> the latest_bdev is device2
>>>
>>>         assert fs_devices->fsid equals
>>>         device2's fsid.
>>>         --> fs_device->fsid was rewritten by
>>>             the scanning thread
>>>
>>> The result is fs_device->fsid is from device1 but super->fsid is from
>>> the lastest device2.
>>>
>>
>>   Oops that's not good. However still not able to image various devices
>>   and its fsid to achieve that condition. Is it possible to write a test
>>   case? It would help.
>>
> It did happened in my test environment.. You can try misc-tests/034 
> about 20 times on v5.4 progs and v5.5-rc1 kernel. As for the test case,
> will give a try.

Let me try.

Thanks, Anand


> Thanks
>> Thanks, Anand
>>
>>>>> the thread is doing mount device 1). But device 1's fsid was copied
>>>>> to fs_devices->fsid then the assertion failed.
>>>>
>>>>
>>>> dev 1 fsid should be copied iff its transid is newer.
>>>>
>>>
>>> Even it was failed to be added into the fs_devices?
>>>
>>>>>
>>>>> The solution is that only if a new device was added into a existing
>>>>> fs_device, then the fs_devices->fsid is allowed to be rewritten.
>>>>
>>>> fs_devices->fsid must be re-written by any device which is _newer_ 
>>>> w.r.t
>>>> to the transid.
>>>>
>>>
>>> Then the assertion failed in above scenario. Just do not update the
>>> fs_devices->fsid, let later btrfs_read_sys_array() report the device
>>> missing then reject to mount.
>>>
>>> Thanks
>>>
>>>>>
>>>>> Fixes: 7a62d0f07377 ("btrfs: Handle one more split-brain scenario 
>>>>> during fsid change")
>>>>> Signed-off-by: Su Yue <Damenly_Su@gmx.com>
>>>>> ---
>>>>>   fs/btrfs/volumes.c | 36 +++++++++++++++++++++---------------
>>>>>   1 file changed, 21 insertions(+), 15 deletions(-)
>>>>>
>>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>>> index d8e5560db285..9efa4123c335 100644
>>>>> --- a/fs/btrfs/volumes.c
>>>>> +++ b/fs/btrfs/volumes.c
>>>>> @@ -732,6 +732,9 @@ static noinline struct btrfs_device 
>>>>> *device_list_add(const char *path,
>>>>>           BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
>>>>>       bool fsid_change_in_progress = (btrfs_super_flags(disk_super) &
>>>>>                       BTRFS_SUPER_FLAG_CHANGING_FSID_V2);
>>>>> +    bool fs_devices_found = false;
>>>>> +
>>>>> +    *new_device_added = false;
>>>>>
>>>>>       if (fsid_change_in_progress) {
>>>>>           if (!has_metadata_uuid) {
>>>>> @@ -772,24 +775,11 @@ static noinline struct btrfs_device 
>>>>> *device_list_add(const char *path,
>>>>>
>>>>>           device = NULL;
>>>>>       } else {
>>>>> +        fs_devices_found = true;
>>>>> +
>>>>>           mutex_lock(&fs_devices->device_list_mutex);
>>>>>           device = btrfs_find_device(fs_devices, devid,
>>>>>                   disk_super->dev_item.uuid, NULL, false);
>>>>> -
>>>>> -        /*
>>>>> -         * If this disk has been pulled into an fs devices created by
>>>>> -         * a device which had the CHANGING_FSID_V2 flag then 
>>>>> replace the
>>>>> -         * metadata_uuid/fsid values of the fs_devices.
>>>>> -         */
>>>>> -        if (has_metadata_uuid && fs_devices->fsid_change &&
>>>>> -            found_transid > fs_devices->latest_generation) {
>>>>> -            memcpy(fs_devices->fsid, disk_super->fsid,
>>>>> -                    BTRFS_FSID_SIZE);
>>>>> -            memcpy(fs_devices->metadata_uuid,
>>>>> -                    disk_super->metadata_uuid, BTRFS_FSID_SIZE);
>>>>> -
>>>>> -            fs_devices->fsid_change = false;
>>>>> -        }
>>>>>       }
>>>>>
>>>>>       if (!device) {
>>>>> @@ -912,6 +902,22 @@ static noinline struct btrfs_device 
>>>>> *device_list_add(const char *path,
>>>>>           }
>>>>>       }
>>>>>
>>>>> +    /*
>>>>> +     * If the new added disk has been pulled into an fs devices 
>>>>> created by
>>>>> +     * a device which had the CHANGING_FSID_V2 flag then replace the
>>>>> +     * metadata_uuid/fsid values of the fs_devices.
>>>>> +     */
>>>>> +    if (*new_device_added && fs_devices_found &&
>>>>> +        has_metadata_uuid && fs_devices->fsid_change &&
>>>>> +        found_transid > fs_devices->latest_generation) {
>>>>> +        memcpy(fs_devices->fsid, disk_super->fsid,
>>>>> +               BTRFS_FSID_SIZE);
>>>>> +        memcpy(fs_devices->metadata_uuid,
>>>>> +               disk_super->metadata_uuid, BTRFS_FSID_SIZE);
>>>>> +
>>>>> +        fs_devices->fsid_change = false;
>>>>> +    }
>>>>> +
>>>>>       /*
>>>>>        * Unmount does not free the btrfs_device struct but would zero
>>>>>        * generation along with most of the other members. So just 
>>>>> update
>>>>>
>>>
>>
> 
