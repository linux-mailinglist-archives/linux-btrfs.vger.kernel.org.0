Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B570911CF99
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 15:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbfLLOUF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 09:20:05 -0500
Received: from mout.gmx.net ([212.227.15.15]:40563 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729392AbfLLOUE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 09:20:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576160398;
        bh=NU1ORZZCsYzDIPHoCF/c+fX7n8YN3XgKpRcJ0tYLL/4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=fFTX5duOsSVq1cw4CcKF/N5vIB26b5mzc4666zIIX51S+YztneSUd/MvqiP+KPV7k
         lM38HltjIx0NY+TJAdmMVeangQPbso6jzy0mHZqCocYuPYiGPeoyionaqfKhKJBG81
         rg2iMzhgJoj+kobBzAQKZ4ccGQRwiKsQgYd5UT4Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.176] ([34.92.249.81]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MAONd-1iYYty0HSV-00BuOl; Thu, 12
 Dec 2019 15:19:57 +0100
Subject: Re: [PATCH 3/6] btrfs: split-brain case for scanned changing device
 with INCOMPAT_METADATA_UUID
To:     Nikolay Borisov <nborisov@suse.com>, damenly.su@gmail.com,
        linux-btrfs@vger.kernel.org
References: <20191212110132.11063-1-Damenly_Su@gmx.com>
 <20191212110132.11063-4-Damenly_Su@gmx.com>
 <b430d17b-a51f-dddf-377c-9a253a0d0e50@suse.com>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <3e475fea-32d3-dee6-fd0b-613cab20257e@gmx.com>
Date:   Thu, 12 Dec 2019 22:19:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <b430d17b-a51f-dddf-377c-9a253a0d0e50@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:keZM2DLlIh1vUoj1pza59J2cj33Fn2O6iYnHBvyQq9hEsJxDuTe
 Medm7zk4lXiK3elQgBskqXWCNKZf23ZAOKF/SB1Banubd+UjOmVHNOn407paJhBigJj82MD
 rdLQ5lzmEnLIU6kovF3utCA8D+GyBTE3wnQSh++9uaIy/F6NMNSAIdLrz8rT1dAIPvwCtPb
 Mf4qQG0bA7yEPM0YhasLg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NGYW6DgZ0Ko=:+vrGPqKl6CrwSn8FyE7Dm8
 tQv06GWhEvtogHDrUEqIGAwsaNPZfXhV4RooRxosN4RdO/pksDjZsNf6mZlkWA9ihSdXkvAwK
 kjYJrzQNL64+6gGkEqAPF09Xd0gfKwY02ygQfw7RUowBZ+dttZdzRuxzBADd7T+y2IkHHJlU4
 Kc0q/ELF3TlWEnCCKIIMeJpKSTaE9t3CXmjR1r4damhkD1xG5wuHMv2bQ80VZQTZzTBECB6uX
 MCdXx0Mu26aZyGdmk3H6oynfYcKSfTW1L/NUVaWmRUhBNeZ6y6/dVi+b29WX7be5sckcV/jl+
 AWgJq84KfMc920XRXFC7mJWgq+zNU2i807ezwEJqdNpb5QmtWrQ2LT5Vx+7Z+QF7fKsd2mURI
 swBJ5P7SWVAvq2X/r0wsRx2QB0cLoHMwcT1odcdMg12VO5lDRv+HlKBT3I58c46caw7MS7Xbg
 DVkAKCEMYb98Xdm5Do9fFhe1A8BEWvS6Je6IpApxF6xmFGDd1KlT4eTIXsoIb0GuGwVBmv7yt
 IlGoK6o89eFLgpC6n1Ns3YECqeFbNh/pzBLqGTI74VRhFh8/n1ImS7GFbg22fMn+2ZuaA4sho
 AzlIKxGVphxvtsX92pZXt6CUXnyKNdxX1ybpX7GA2G4kMVuS4FifantF4t0MGL7pyDeT8vlgj
 RXDCt6fDUcCi4TyDI6A7rD6osGl/vbwu6DIEQ9iHtZa2py3vCR4E9hjA2cGjHTWr7R/EjbbMz
 oNX29qcJgKm5+XeR3vnpS6eBBpLH9NQ79aYiG2sVyfWcTVz+N2oQBRVhSUf1wUvrTYNB1vxy5
 6QUUxokQRGjMQgB2ECLKRhuifinjODyBl7k9O5/V2ZkKHjIcYcWSy8z5NiEnUTiidQDgFW8xO
 Aa2Ec0O9eZjg8uwWg8KMw3hIzzAP55JKiigbUpJN5GbfdhSXc+7VtsNMEp4nWwq57SzHEQsnM
 k0XHE4jHg0Rinps+UQehaP23RI5hvovVuCVLCy6AVLqh9OxZSY/0SmhiYxqCUp1SNQGmOiLYw
 xf/pqKNItNr6sJ7ZFiB7ywhBojT5CxQvmxcaJvWusZ3mP4CF9BOL+dHviZ2i3FsdHjVMokLeZ
 pkgrjdnR7qsfscgsDaO6AomPjWxR/I2ZzNJ7aCqyYvFxZAjCVQf6i5M4nvP7Rl5i8a6LKjDrY
 N+WEZezPuPRUwWkDqysPmK1AFS842k6JBovw3UDf4GIedY4AFAGTa/OqlpCZv6B7GRjB89KCU
 4i4Qy2feHAtznTx/rPm55JSm87t4DML7Kv3bKYMCZY+2d03pRp336x6rwJNE=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019/12/12 9:34 PM, Nikolay Borisov wrote:
>
>
> On 12.12.19 =D0=B3. 13:01 =D1=87., damenly.su@gmail.com wrote:
>> From: Su Yue <Damenly_Su@gmx.com>
>>
>> This patch adds the case for scanned changing device with
>> INCOMPAT_METADATA_UUID.
>> For this situation, the origin code only handles the case
>> the devices already pulled into disk with INCOMPAT_METADATA_UUID set.
>> There is an another case that the successful changed devices synced
>> without INCOMPAT_METADATA_UUID.
>> So add the check of Heather fsid of scanned device equals
>> metadata_uuid of fs_devices which is with INCOMPAT_METADATA_UUID
>> feature.
>>
>
> This is hard for me to parse and correctly understand what you mean.
>

Sorry..

>> Signed-off-by: Su Yue <Damenly_Su@gmx.com>
>> ---
>>   fs/btrfs/volumes.c | 29 ++++++++++++++++++++++++++---
>>   1 file changed, 26 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index b08b06a89a77..61b4a107bb58 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -654,7 +654,6 @@ static struct btrfs_fs_devices *find_fsid_inprogres=
s(
>>   	return NULL;
>>   }
>>
>> -
>>   static struct btrfs_fs_devices *find_fsid_changed(
>>   					struct btrfs_super_block *disk_super)
>
>
> find_fsid_changed handles the case where a device belongs to a
> filesystem which had multiple successful fsid changed but it failed on
> the last one.
>
I go it while reading code. And "the last one" is the one where the
@disk_super read from. It has the metadata_uuid and FSID_CHANGING_V2.
Right?
What I want to express in changelog  is that those successful changed
devices *may*
not have the metadata_uuid feature. The code in btrfstune.c: line 141

         if (new_uuid && uuid_changed && memcmp(disk_super->metadata_uuid,
                                                new_fsid,
BTRFS_FSID_SIZE) =3D=3D 0) {
                 /*
                  * Changing fsid to be the same as metadata uuid, so just
                  * disable the flag
                  */
                 memcpy(disk_super->fsid, &new_fsid, BTRFS_FSID_SIZE);
                 incompat_flags &=3D ~BTRFS_FEATURE_INCOMPAT_METADATA_UUID=
;
                 btrfs_set_super_incompat_flags(disk_super, incompat_flags=
);
                 memset(disk_super->metadata_uuid, 0, BTRFS_FSID_SIZE);

The INCOMPAT_METADATA_UUID can be cleared if changing fsid is same with
the metadata_uuid in deivce.

>>   {
>> @@ -663,9 +662,14 @@ static struct btrfs_fs_devices *find_fsid_changed(
>>   	/*
>>   	 * Handles the case where scanned device is part of an fs that had
>>   	 * multiple successful changes of FSID but curently device didn't
>> -	 * observe it. Meaning our fsid will be different than theirs.
>> +	 * observe it.
>> +	 *
>> +	 * Case 1: the devices already changed still owns the feature, their
>> +	 * fsid must differ from the disk_super->fsid.
>
> What do you mean by device to still owns the feature? Has the bit set or
> something else?
>
The metadata_uuid feature.
>>   	 */
>>   	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
>> +		if (fs_devices->fsid_change)
>> +			continue;
>
> Why do you do this?

Just make cases separated.

>
>>   		if (memcmp(fs_devices->metadata_uuid, fs_devices->fsid,
>>   			   BTRFS_FSID_SIZE) !=3D 0 &&
>>   		    memcmp(fs_devices->metadata_uuid, disk_super->metadata_uuid,
>> @@ -676,7 +680,26 @@ static struct btrfs_fs_devices *find_fsid_changed(
>>   		}
>>   	}
>>
>> -	return NULL;
>> +	/*
>> +	 * Case 2: the synced devices doesn't have the metadata_uuid feature.
>> +	 * NOTE: the fs_devices has same metadata_uuid and fsid in memory, bu=
t
>> +	 * they differs in disk, because fs_id is copied to
>> +	 * fs_devices->metadata_id while alloc_fs_devices if no metadata
>
> It's not possible for the device to have metadata_uuid feature because
> this function is called from device_list_add iff the device has
> METADATA_UUID flag:
>

Get and agree what you mean. As the reply above, the fs_devices already
allocated there(not the device scanning) may not have METADATA_UUID flag.

> if (fsid_change_in_progress) {
>
> if (!has_metadata_uuid) {
> } else {
>   find_fsid_changed <-- here we are sure our device has METADATA_UUID se=
t.
> }
> }
>
>> +	 * feature.
>> +	 */
>> +	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
>> +		if (memcmp(fs_devices->metadata_uuid, fs_devices->fsid,
>> +			   BTRFS_FSID_SIZE) =3D=3D 0 &&
>> +		    memcmp(fs_devices->fsid, disk_super->metadata_uuid,
>> +			   BTRFS_FSID_SIZE) =3D=3D 0 && !fs_devices->fsid_change)
>> +			return fs_devices;
>> +	}
>> +
>> +	/*
>> +	 * Okay, can't found any fs_devices already synced, back to
>> +	 * search devices unchanged or changing like the device.
>> +	 */
>> +	return find_fsid(disk_super->fsid, disk_super->metadata_uuid);
>>   }
>>
>>   static struct btrfs_fs_devices *find_fsid_changing_metada_uuid(
>>

