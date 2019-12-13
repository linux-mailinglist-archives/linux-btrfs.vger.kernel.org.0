Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D67C11DC35
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2019 03:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731628AbfLMCrF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 21:47:05 -0500
Received: from mout.gmx.net ([212.227.15.18]:37833 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731353AbfLMCrF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 21:47:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576205218;
        bh=gt/IyJGCHi66Le3G525Y+SBXW/YGWrblb8crxa4usI8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=MVAXXpBQ0gqzifCg9ZwkNzE+J+KlFQPBpw1OpDEqojXoli8Wfyl8OhBNpgBgnNSsc
         o0xwRyqBT4bZX06LudNXKn2UBCJ7NQPRl3nHy1+u9jtoZPw1eHS8r7+utTu1G3Rx11
         E8UNaxLmh19jYG3L9H17e7XJkrkJsT0XNH5GwPgE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.176] ([34.92.249.81]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MxDp4-1hmMnp2NdQ-00xYa1; Fri, 13
 Dec 2019 03:46:58 +0100
Subject: Re: [PATCH 1/6] btrfs: metadata_uuid: fix failed assertion due to
 unsuccessful device scan (reformatted)
To:     Nikolay Borisov <nborisov@suse.com>, damenly.su@gmail.com,
        linux-btrfs@vger.kernel.org
References: <20191212110132.11063-1-Damenly_Su@gmx.com>
 <20191212110132.11063-2-Damenly_Su@gmx.com>
 <78eab88a-a6be-f87b-34d7-13a1cffbf36b@suse.com>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <07e99b04-ec0c-f027-079e-b0d3c1e54970@gmx.com>
Date:   Fri, 13 Dec 2019 10:46:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <78eab88a-a6be-f87b-34d7-13a1cffbf36b@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dYG7EdGlD/uGVCvFGo+A7wEUKTBoamMfOKZKXIwtU0wJ+ENIxWb
 BGoH37wHYcZI1wMrbLvK23XJ77NX1ok7MklDxAGBa0hfloII17QNGjsgl11I15A/JNMOQQY
 XkdkDB+pqPyn4S+BBerqkdozJtDXEf0ygUtWtUBDTxVAFpYtxoeQOi8rC/WvkEmC3a2/P1r
 9OsaJ3KO/C/fb7rIdx93w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:84o/CbDYjtI=:DOew8Yn7rmSDRSmxMeqxvj
 o3cEbXynrT5bP3uEVfEW7vEH0kM1xC05xrO/GiVrsks3WC3La/IsZm/rgStXQ5CFUUsVGbj8F
 BhOySKECQWu+zfJMT7ixd5jZUKNkQlEB6Qb+LTiteYM6o6i3+ixqJiDtbm6sTrrxTXUBNbBFh
 0MV3dzLHHYbnRAPVSmeuYKCjvz1/HcBaSpLSSTLfs3A0l/zoX0XXc3h1/eytn0xyUNg2a2Lyi
 ODQ9uI9yBWO5lDwpzvIDVw/WPEo9onaYuKQgAC0O8/dDWKc92TPezL9Q9E6lJlFvGiSuviTtX
 LuNuvkR03zKfUokGDwTFjTYXwXZlDfAwaiSwZXZfELVQ6y/FN72wVJQiZS3qsJ5+PhLsJCcJ6
 twyMMpyHS0fc3OpR2JCPK6uNYKSwrAj9JamJS0FZ1nbl+OpOELzSUMC0ToKgKhYM5JXolhNXm
 4ZST4RvI+X2HrYRZzRUZye9x3tlp89eC+MiUR3Dd2Ba+YKL8W718NOCEsAuVcD7qSfT2SLXEl
 fUGhqmaNIwXfO5/qDj9BFLNx0W9WIYJYw/1M9oc4H6/f2w64WZYqBwE6xMMv8IFVtiFTRh41D
 UpHVZj6miRlAsDDMhcDDdyEGwJJ6ubt+0qIwk2sJb77U60uyyk04CEOZ0OKBnun3NQ3KE9DZU
 kugvBPLMsWZ7hGybNm7jpTMpMCjKlBx+L1HgVDbD1q0+YYwJryqJ8BZj03f5e9qqaMOGqgEgO
 BWSDH1GT7I++O5Hg/1A91bBpiACe4G8FoIW7kXOhfBjbjV6YMKCpMAFof2Ewyy4lniJNcZWeP
 dCV/YhOXRwG3PcouGmQ/6dkzgmJj947Xk25Oi5elHxWP1psSqvC8OUJXDfYYG/cSsB2txyHdG
 rPiNCFhjmWM1hxbKdexutfX1NOz2Y75L7USF3uXoVAAwnmDwbtB46RKoW2LAKhvdhD5bbs85d
 77bPs16T3T7HUA+0xoTVUsS9PxzgPwxQotg9uY5NHRYpv6hMFcIpFPKCi3Meq9prNPcDPCDYP
 DRxbW8RALwS4CtYKaLmus2ifCO9HIBdVSLVlDyohchxHUbOqmPxZPYB4ioX65C5qAC6EGyzyE
 19DcRScdB2UcU5bdplmlBQlUYrvFByUrVJ+s/ZibXpHTsXDxDCeTsNChJO+xHrgnWMlWXFPL9
 /aInCKBWDD7gU3lgVb46Z4HqWcC6t6irrcODo3W2qCRFFbfbvkbJ2GCkp9247LizrACRCyivp
 TbklDGY561p4wghvjDkLZNGLDYOUnzHvCTXa3U2v2ddQKkhbx4n0JF4i0yhY=
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
>
> It's not clear why device 1 wasn't able to be added to the fs_devices
> allocated by dev 2. Please elaborate?
>
>
Sure, of course.

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

Thread *mounting device2*            Thread *scanning device1*


btrfs_mount_root                     btrfs_control_ioctl

   mutex_lock(&uuid_mutex);

     btrfs_read_disk_super
     btrfs_scan_one_device
     --> there is only device2
     in the fs_devices

     btrfs_open_devices
       fs_devices->opened =3D 1
       fs_devices->latest_bdev =3D device2

     mutex_unlock(&uuid_mutex);

                                       mutex_lock(&uuid_mutex);
                                       btrfs_scan_one_device
                                         btrfs_read_disk_super

                                         device_list_add
                                           found fs_devices
                                             device =3D btrfs_find_device

                                             rewrite fs_deivces->fsid if
                                             scanned device1 is newer
                                              --> Change fs_devices->fsi
                                                   d to device1->fsid

                                           if (!device)
                                              if(fs_devices->opened)
						 return -EBUSY
                                              --> the device1 adding
                                                  aborts since
                                                  fs_devices was opened
                                       mutex_unlock(&uuid_mutex);
   btrfs_fill_super
     open_ctree
        btrfs_read_dev_super(
        fs_devices->latest_bdev)
        --> the latest_bdev is device2

        assert fs_devices->fsid equals
        device2's fsid.
        --> fs_device->fsid was rewritten by
            the scanning thread

The result is fs_device->fsid is from device1 but super->fsid is from
the lastest device2.

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
>

Then the assertion failed in above scenario. Just do not update the
fs_devices->fsid, let later btrfs_read_sys_array() report the device
missing then reject to mount.

Thanks

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

