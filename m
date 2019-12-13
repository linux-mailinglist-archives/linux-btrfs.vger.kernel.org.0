Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8F5711DC1B
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2019 03:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731467AbfLMCap (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 21:30:45 -0500
Received: from mout.gmx.net ([212.227.15.18]:39269 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731330AbfLMCap (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 21:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576204237;
        bh=DXEzBWVXQNQNusMnsJgCt5mf8CmEDf+604sWoKoyCOE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=IZg3/CGXjvcsRTaY11eGHXCCdnWgAq1/ResxHPBtI0uBIvXsb5Lpv5rCzqg+gRYG4
         ROLuu8gtQu4b7U+4YKcZjIP5ivpNLRd+38hMdihbG+3npbg/K3bCmIcz/dGwI54SBY
         rl+lg2NH2nafZdQzs9cqdKX/NLonoIRGyywmGzjU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.176] ([34.92.249.81]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MMXQ5-1iOjzo2Zz5-00JX6S; Fri, 13
 Dec 2019 03:30:36 +0100
Subject: Re: [PATCH 1/6] btrfs: metadata_uuid: fix failed assertion due to
 unsuccessful device scan
To:     Nikolay Borisov <nborisov@suse.com>, damenly.su@gmail.com,
        linux-btrfs@vger.kernel.org
References: <20191212110132.11063-1-Damenly_Su@gmx.com>
 <20191212110132.11063-2-Damenly_Su@gmx.com>
 <78eab88a-a6be-f87b-34d7-13a1cffbf36b@suse.com>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <741b76b4-93fa-904b-13c8-3558fa314f21@gmx.com>
Date:   Fri, 13 Dec 2019 10:30:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <78eab88a-a6be-f87b-34d7-13a1cffbf36b@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2AMpZqkAJ7EeKQOypIeX76lemmMjd2R9oaebVOIcNmSZZpF+z9Q
 mvKoB2reVyiEvwu3VErRgdMqv0j6xnjVTpMQs8e1wrl/Kn4ZEti6JkDRxO4lcN0Y/LSjD/Z
 HmFD2aEkKPShbmWrtkQTh8ZYt6YjaS22FHBzyLV40YQNSW4+ctRlYKcCmqw3pGO+5hlcPts
 UeavC6XO+k72vKPMoB0gA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YcG5zEwkfUY=:KtCbOiHa71AfidF1cgcaKP
 vsHYXRsDEjOHpetLhKmyNAC7HgTBWc+2FN1Vluab6t3J1yKNGaafB6NS4xsSWkMFd0gUerNRL
 Ew9xYTpKnQJhHCaWdQlvx1fOP6eAWheoSsNstnRUZgzo1fJZWR8JzrrhyWHioZBsoTMgTLygp
 WjLWlNrXqdXZUOVtCB/6xKmvDMPWdNgCwVrGcIdNQLl/G4rczqJ35EwwT0Tth/yvq7RjcwsWU
 WAorrVjnQCpppyYqDks615r6/nXpewg9hzbKpLbKhp/GCFRwC4m/ZPl5lQlt0iQ2BFIW7bB/6
 k9avIxhhMM/fhySK4/JSQHPImhURygcPcM84hTT9hejFOr/vJ2khop3y+1uiAlGa9f5GutOqx
 5WHNQEcOVNQRc0fTz5Qqa1XPhv1Sv0CZjqPBGPMrDOA/euMaHZz3DLrP9I7N4+De6Ns8zbpEC
 2WizvZ3sxxo4BhZQQQYQYbk9IL4jtvqOGlwSfuNlER4Bnceey/nnFJ2Ob6q4iMj0RcspN8zNA
 cBdCDcBcHj8muHIF4SpJIwol2ABp58USalduKhrjzVZxQ4Fi71brdYfoNbz2wEJt4CRZyMNH+
 rD9mHtUxytsRaS/PShB3vaLEk8wwNzTfULrzHtP9WCN9dkPXWxs/SXoDXy26vS+fkuxfF6Gy2
 MNfHaOC6feFLWo2dy3DeB5fMfhTn2DdQPnECsTng5Zjj2UvJcJnHU2PBioXxbE1MR5Pw3YiS+
 DMfO+ZkVBhrE69bDrsGdjO0FZTS50Av3wQ91k0CtEiEaKe9aQfLT8b+JR6u0edDLMfOC8Y5Xo
 b2umB844on61f+s+3K3J5nhv3NFIVRtB7YPTZ9u15STAkR0GGxjq4vFb0tMRbg9cZRscAuKmd
 jqA8icNQ1J72fU1sqAaNrqx2xL4Ovp6xp8jZ5GztxIsSgjsLU1YunKbgL9JX/f0yKAYL/Kege
 lzErIdLOHsxrMdvzSfkXAj2L1P10fvezUNRSdUMhGAxC/a7Svpycx/wHnNAEn31EvxA3cuIRa
 86bOBHEZ9EBMwSvxFtDXP+g7wDiT2CvY3bcA5e26QfrGVbiWzB9oADRtWbo5JXNxa8a7RrmSA
 uiMp9IzAKOZAzqcFyN3ZlxHp6/5bpT0evypSePknv4Nisppeu/zNpPVx8mj1yZV5Izllpa/Nd
 Hn1mXgI3FTfVySHANiEI3vdjeClVpdqQEY2W4PvHSOtBAJaPSspGr2fux8M7sCr2kdqDgT9PN
 8dR1rKGEoYSmUkuoVh1MeviM8TAUhGFTVO27yXxCP9h3SJlasp1GllcLHdrA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019/12/12 10:15 PM, Nikolay Borisov wrote:
>
>
> On 12.12.19 =D0=B3. 13:01 =D1=87., damenly.su@gmail.com wrote:
>
> <snip>
>
>> Acutally, there are two devices in the fs. Device 2 with
>> FSID_CHANGING_V2 allocated a fs_devices. But, device 1 found the
>> fs_devices but failed to be added into since fs_devices->opened (
>  > It's not clear why device 1 wasn't able to be added to the fs_devices
> allocated by dev 2. Please elaborate?
>
Because fs_devices is opened.
For example.

$cat test.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
img1=3D"/tmp/test1.img"
img2=3D"/tmp/test2.img"

[ -f "$img1" ] || fallocate -l 300M "$img1"
[ -f "$img2" ] || fallocate -l 300M "$img2"

mkfs.btrfs -f $img1 $img2 2>&1 >/dev/null|| exit 1
losetup -D

dmesg -C
rmmod btrfs
modprobe btrfs

loop1=3D$(losetup --find --show "$img1")
loop2=3D$(losetup --find --show "$img2")

mount $loop1 /mnt || exit 1
umount /mnt
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

$dmesg
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  395.205221] BTRFS: device fsid 5090db22-5e48-4767-8fb7-d037c619c1ee
devid 1 transid 5 /dev/loop0 scanned by systemd-udevd (13620)
[  395.210773] !!!!!!!!fs_device opened
[  395.213875] BTRFS info (device loop0): disk space caching is enabled
[  395.214994] BTRFS info (device loop0): has skinny extents
[  395.215891] BTRFS info (device loop0): flagging fs with big metadata
feature
[  395.222639] BTRFS error (device loop0): devid 2 uuid
adcc8454-695f-4e1d-bde8-94041b7bf761 is missing
[  395.224147] BTRFS error (device loop0): failed to read the system
array: -2
[  395.246163] !!!!!!!!fs_device opened
[  395.338219] BTRFS error (device loop0): open_ctree failed
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The line "!!!!!!!!fs_device opened" is handy added by me in debug purpose.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -794,6 +794,7 @@ static noinline struct btrfs_device
*device_list_add(const char *path,

         if (!device) {
                 if (fs_devices->opened) {
+                       pr_info("!!!!!!!!fs_device opened\n");
                         mutex_unlock(&fs_devices->device_list_mutex);
                         return ERR_PTR(-EBUSY);
                 }
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

To make it more clear. The following is in metadata_uuid situation.
Device 1 is without FSID_CHANGING_V2 but has IMCOMPAT_METADATA_UUID.
(newer transid).

Device 2 is with FSID_CHANGING_V2 and IMCOMPAT_METADATA_UUID.(Older
transid).

The workflow in misc-tests/034 is

loop1=3D$(losetup --find --show "$device2")
loop2=3D$(losetup --find --show "$device1")

mount $loop1 /mnt ---> fails here

Assume the fs_devices was allocated by systemd-udevd through
btrfs_control_ioctl() path after finish of scanning of device2.

Then:

Thread *mounting device2*               Thread *scanning device1*


btrfs_mount_root			btrfs_control_ioctl

   mutex_lock(&uuid_mutex);

     btrfs_read_disk_super
     btrfs_scan_one_device
     --> there is only device2
	in the fs_devices

     btrfs_open_devices
       fs_devices->opened =3D 1
       fs_devices->latest_bdev =3D device2

   mutex_unlock(&uuid_mutex);
   -->Here, fs_devices->fsid is same
      as device2's fsid.
					mutex_lock(&uuid_mutex);
					btrfs_scan_one_device

					  btrfs_read_disk_super
					  device_list_add
					    found fs_devices
					      device =3D btrfs_find_device

					      rewrite fs_deivces->fsid

                                               if scanned device is newer
                                               --> Change fs_devices->fsi
                                                   d to device1->fsid

					    if (!device)
						if fs_devices->opened
						--> the device1 adding
						    aborts since
						    fs_devices
						    was opened
					mutex_unlock(&uuid_mutex);
   btrfs_fill_super
     open_ctree
        btrfs_read_dev_super(
        fs_devices->latest_bdev)
        --> the latest_bdev is device2

        assert fs_devices->fsid equals device2's fsid.
        --> fs_device->fsid was rewritten by the scanning thread

>
>> the thread is doing mount device 1). But device 1's fsid was copied
>> to fs_devices->fsid then the assertion failed.
>
>
> dev 1 fsid should be copied iff its transid is newer.
>
Even it was failed to be added into the fs_devices?
>>
>> The solution is that only if a new device was added into a existing
>> fs_device, then the fs_devices->fsid is allowed to be rewritten.
>
> fs_devices->fsid must be re-written by any device which is _newer_ w.r.t
> to the transid.

Then the assertion failed in above scenario. Just do not update the
fs_devices->fsid, let later btrfs_read_sys_array() report the device
missing then reject to mount.

Thanks
>
>>
>> Fixes: 7a62d0f07377 ("btrfs: Handle one more split-brain scenario durin=
g fsid change")
>> Signed-off-by: Su Yue <Damenly_Su@gmx.com>
>> ---
>>   fs/btrfs/volumes.c | 36 +++++++++++++++++++++---------------
>>   1 file changed, 21 insertions(+), 15 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index d8e5560db285..9efa4123c335 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -732,6 +732,9 @@ static noinline struct btrfs_device *device_list_ad=
d(const char *path,
>>   		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
>>   	bool fsid_change_in_progress =3D (btrfs_super_flags(disk_super) &
>>   					BTRFS_SUPER_FLAG_CHANGING_FSID_V2);
>> +	bool fs_devices_found =3D false;
>> +
>> +	*new_device_added =3D false;
>>
>>   	if (fsid_change_in_progress) {
>>   		if (!has_metadata_uuid) {
>> @@ -772,24 +775,11 @@ static noinline struct btrfs_device *device_list_=
add(const char *path,
>>
>>   		device =3D NULL;
>>   	} else {
>> +		fs_devices_found =3D true;
>> +
>>   		mutex_lock(&fs_devices->device_list_mutex);
>>   		device =3D btrfs_find_device(fs_devices, devid,
>>   				disk_super->dev_item.uuid, NULL, false);
>> -
>> -		/*
>> -		 * If this disk has been pulled into an fs devices created by
>> -		 * a device which had the CHANGING_FSID_V2 flag then replace the
>> -		 * metadata_uuid/fsid values of the fs_devices.
>> -		 */
>> -		if (has_metadata_uuid && fs_devices->fsid_change &&
>> -		    found_transid > fs_devices->latest_generation) {
>> -			memcpy(fs_devices->fsid, disk_super->fsid,
>> -					BTRFS_FSID_SIZE);
>> -			memcpy(fs_devices->metadata_uuid,
>> -					disk_super->metadata_uuid, BTRFS_FSID_SIZE);
>> -
>> -			fs_devices->fsid_change =3D false;
>> -		}
>>   	}
>>
>>   	if (!device) {
>> @@ -912,6 +902,22 @@ static noinline struct btrfs_device *device_list_a=
dd(const char *path,
>>   		}
>>   	}
>>
>> +	/*
>> +	 * If the new added disk has been pulled into an fs devices created b=
y
>> +	 * a device which had the CHANGING_FSID_V2 flag then replace the
>> +	 * metadata_uuid/fsid values of the fs_devices.
>> +	 */
>> +	if (*new_device_added && fs_devices_found &&
>> +	    has_metadata_uuid && fs_devices->fsid_change &&
>> +	    found_transid > fs_devices->latest_generation) {
>> +		memcpy(fs_devices->fsid, disk_super->fsid,
>> +		       BTRFS_FSID_SIZE);
>> +		memcpy(fs_devices->metadata_uuid,
>> +		       disk_super->metadata_uuid, BTRFS_FSID_SIZE);
>> +
>> +		fs_devices->fsid_change =3D false;
>> +	}
>> +
>>   	/*
>>   	 * Unmount does not free the btrfs_device struct but would zero
>>   	 * generation along with most of the other members. So just update
>>

