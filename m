Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7841011CE58
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 14:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbfLLNcT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 08:32:19 -0500
Received: from mout.gmx.net ([212.227.15.18]:54817 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729302AbfLLNcT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 08:32:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576157530;
        bh=PppY73b0PMlufMp9TgmyuPUe0eq//yUUt7NR6+xiR9Q=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=CP2GoziRUt8HQj4bMGpcZ1c0HJQ/VpUqiOjriwlLN4Xkr0A/HF5B1FhesGhzdOEOl
         liHhBSWUtkd2vQgqUukWV0nvHuZEY/k2aoPh7kuNpBJMXUQ5ITsO6BeZA1vfAePPHH
         /VIkUTjIFnQ7yGEpdL5FqxjOvxxBq4lwqPX4wkIE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.176] ([34.92.249.81]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MBUmD-1iZfYE0TeB-00D1js; Thu, 12
 Dec 2019 14:32:10 +0100
Subject: Re: [PATCH 2/6] btrfs: metadata_uuid: move split-brain handling from
 fs_id() to new function
To:     Nikolay Borisov <nborisov@suse.com>, damenly.su@gmail.com,
        linux-btrfs@vger.kernel.org
References: <20191212110132.11063-1-Damenly_Su@gmx.com>
 <20191212110132.11063-3-Damenly_Su@gmx.com>
 <c510f446-67a6-edb7-72a4-0617288a3c52@suse.com>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <151b6348-8556-5da2-1d44-610654fee4a8@gmx.com>
Date:   Thu, 12 Dec 2019 21:32:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <c510f446-67a6-edb7-72a4-0617288a3c52@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wKuzucJRF/zLS4Mv9Jo08gjaKMGRT/XrjwzHp9jK4wd6SW1yH4H
 k6cxJ/JhwhvMts5zaJpRyDywMdqSbs7zNdjD97yQ9JTaJ5oWc2/3MGyRf91nTR4FmKXF/Wz
 UAvbO5Bpn8UGU2fCahMxDSbjLCAFdKwXYiLqAdRP3DwLd7P9cJ8qwCEtWFqkju7d8w2cJML
 wFXBR23a/Yx2Inimk7CBw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WWpyiPi/KQs=:t7IB49OZMmFKhH2amqWNLK
 hfLlrQnLd++5vk6HHcNaTwuvakgwTvmUyK/CMmot5Jrj5/om/itQtMBjFF5+VgfVunmTUXzkO
 NN82kuabMl4ylZivRDPH0n3sx1mDkXIyt+5v0ZTdvSR1T70X7Ks6mnUjubEtD6y+JMhyZiq4K
 B3BLc65lx7dFoDrVBBSLsU/dvkGO62Eu/wFNdi1tLNIc3p7cBZlEuatmS3QATBlbQofpZiFCk
 Xm9DEVR5Ttj+YrUMAAdn8PzSzylWEPmAdtGFbTh5TKig/UL3eZghjtil1+uIiFYJITen3u8WY
 3q3SvhjcOrLn1/Nu8r4HZDUvxySG8tGZZnxxvUUoSeYCRSyK5jtUp4tioD9HRfr0VC56InhwA
 VWZ3KAcVx8woDGCL0iLnqsyrbY4ix5sPuUk01QfYCGk9OG6+eBVZlTmgE9kbCq2usfzG7HLQx
 wNAMZ0urQTNoqCf53Tc0OtfZ4jwfe4m+xKVgBDgW4f5qub6hug+8eQwxWnC82fYrPGaG/L8EV
 U7f9uT8pgNCYMvbRRK5mrkN1Y+x2empbENcBX8BB7ILBDe24cK4eK38COVkvXyPa4EIkCZrxi
 i4h0ovEFyJAlsuGBuLqI4fdo4O+rwezpuojmbA3XKAjH580y+ZXTqBOWjBUzd6rlMW6Fs0us+
 98Yd/Kmgb5QMp9jJpLmQJvj/ExwR57SsjqOBVgkUS7roxCFuog+VXR+kw//yKPYyHr/0hrvxN
 /ZvtaYxC2tLjSASxPQqIRWlGZ426COlZd2C7kSphZhdU7kYC8PvEEHWEI88BDB9RuoAp8VrnV
 bqtC9uMP/trRm0ZsNUIJlj9yvYPsCwx/bvrBYQ5oL/llbOB13EeObx0xBW0Cmhn/aOmp5pWRa
 l+y8Exotyx9WvJ0nf7sFpUhnJCWqq6zzrmTLQl4ZCIRoJXS93sYdxFy1eaduKJf6ozfT6UoQz
 Ytql3iiYvuP85OHf9J9cu2owqf54tZcSAugo4OdGGQRSLQ4QIOlmoD1a+H8WC42kd8nUbqL9B
 0L9eJFEcSlKfC4tZFAwUWDKXHkRpCAeTy4w6C41EHjZKe3EZjF9+RFUE8qrwm0MoLwz8KKHX5
 /76FW9a2/gsEODX/3dMV0Q7/mDijtf30e28oWMnTUMUOXZi2rQ2twXBme6BEKRhEvqwYGEcSK
 C5uiF7pvvf5nFARgXF+VIQaEWs4oprcIKjGQinpzAO867lc9NkrpUup/w6ZHXU/MWm7wIhFV0
 llotfUwKu8nfMZ4wkY4w6f06p+rNK2ufwMu0lFX14dsgK5odus6Q7msW5xig=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019/12/12 9:05 PM, Nikolay Borisov wrote:
>
>
> On 12.12.19 =D0=B3. 13:01 =D1=87., damenly.su@gmail.com wrote:
>> From: Su Yue <Damenly_Su@gmx.com>
>>
>> The parameter @metadata_fsid of fs_id() is not NULL while scanned devic=
e
>> has metadata_uuid but not changing. Obviously, the cases handling part
>> in fs_id() is for this situation. Move the logic into new function
>> find_fsid_changing_metadata_uuid().
>
> I think the following changelog might sound better.
>
> metadata_fsid parameter of find_fsid is non-null in once specific case
> in device_list_add. Factor the code out of find_fsid to a dedicated
> function to improve readability.
>

Thanks for the changelog! will replace.
>
>>
>> Signed-off-by: Su Yue <Damenly_Su@gmx.com>
>> ---
>>   fs/btrfs/volumes.c | 78 ++++++++++++++++++++++++---------------------=
-
>>   1 file changed, 41 insertions(+), 37 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 9efa4123c335..b08b06a89a77 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -438,40 +438,6 @@ static noinline struct btrfs_fs_devices *find_fsid=
(
>>
>>   	ASSERT(fsid);
>>
>> -	if (metadata_fsid) {
>> -		/*
>> -		 * Handle scanned device having completed its fsid change but
>> -		 * belonging to a fs_devices that was created by first scanning
>> -		 * a device which didn't have its fsid/metadata_uuid changed
>> -		 * at all and the CHANGING_FSID_V2 flag set.
>> -		 */
>> -		list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
>> -			if (fs_devices->fsid_change &&
>> -			    memcmp(metadata_fsid, fs_devices->fsid,
>> -				   BTRFS_FSID_SIZE) =3D=3D 0 &&
>> -			    memcmp(fs_devices->fsid, fs_devices->metadata_uuid,
>> -				   BTRFS_FSID_SIZE) =3D=3D 0) {
>> -				return fs_devices;
>> -			}
>> -		}
>> -		/*
>> -		 * Handle scanned device having completed its fsid change but
>> -		 * belonging to a fs_devices that was created by a device that
>> -		 * has an outdated pair of fsid/metadata_uuid and
>> -		 * CHANGING_FSID_V2 flag set.
>> -		 */
>> -		list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
>> -			if (fs_devices->fsid_change &&
>> -			    memcmp(fs_devices->metadata_uuid,
>> -				   fs_devices->fsid, BTRFS_FSID_SIZE) !=3D 0 &&
>> -			    memcmp(metadata_fsid, fs_devices->metadata_uuid,
>> -				   BTRFS_FSID_SIZE) =3D=3D 0) {
>> -				return fs_devices;
>> -			}
>> -		}
>> -	}
>> -
>> -	/* Handle non-split brain cases */
>>   	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
>>   		if (metadata_fsid) {
>>   			if (memcmp(fsid, fs_devices->fsid, BTRFS_FSID_SIZE) =3D=3D 0
>> @@ -712,6 +678,46 @@ static struct btrfs_fs_devices *find_fsid_changed(
>>
>>   	return NULL;
>>   }
>> +
>> +static struct btrfs_fs_devices *find_fsid_changing_metada_uuid(
>
> That function name is long (and contains a typo). More like something li=
ke:
>
> find_fsid_with_metadata_uuid.

Fine. Naming is so hard to me.

Thanks.
>
>> +					struct btrfs_super_block *disk_super)
>> +{
>> +	struct btrfs_fs_devices *fs_devices;
>> +
>> +	/*
>> +	 * Handle scanned device having completed its fsid change but
>> +	 * belonging to a fs_devices that was created by first scanning
>> +	 * a device which didn't have its fsid/metadata_uuid changed
>> +	 * at all and the CHANGING_FSID_V2 flag set.
>> +	 */
>> +	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
>> +		if (fs_devices->fsid_change &&
>> +		    memcmp(disk_super->metadata_uuid, fs_devices->fsid,
>> +			   BTRFS_FSID_SIZE) =3D=3D 0 &&
>> +		    memcmp(fs_devices->fsid, fs_devices->metadata_uuid,
>> +			   BTRFS_FSID_SIZE) =3D=3D 0) {
>> +			return fs_devices;
>> +		}
>> +	}
>> +	/*
>> +	 * Handle scanned device having completed its fsid change but
>> +	 * belonging to a fs_devices that was created by a device that
>> +	 * has an outdated pair of fsid/metadata_uuid and
>> +	 * CHANGING_FSID_V2 flag set.
>> +	 */
>> +	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
>> +		if (fs_devices->fsid_change &&
>> +		    memcmp(fs_devices->metadata_uuid,
>> +			   fs_devices->fsid, BTRFS_FSID_SIZE) !=3D 0 &&
>> +		    memcmp(disk_super->metadata_uuid, fs_devices->metadata_uuid,
>> +			   BTRFS_FSID_SIZE) =3D=3D 0) {
>> +			return fs_devices;
>> +		}
>> +	}
>> +
>> +	return find_fsid(disk_super->fsid, disk_super->metadata_uuid);
>> +}
>> +
>>   /*
>>    * Add new device to list of registered devices
>>    *
>> @@ -751,13 +757,11 @@ static noinline struct btrfs_device *device_list_=
add(const char *path,
>>   			fs_devices =3D find_fsid_changed(disk_super);
>>   		}
>>   	} else if (has_metadata_uuid) {
>> -		fs_devices =3D find_fsid(disk_super->fsid,
>> -				       disk_super->metadata_uuid);
>> +		fs_devices =3D find_fsid_changing_metada_uuid(disk_super);
>>   	} else {
>>   		fs_devices =3D find_fsid(disk_super->fsid, NULL);
>>   	}
>>
>> -
>>   	if (!fs_devices) {
>>   		if (has_metadata_uuid)
>>   			fs_devices =3D alloc_fs_devices(disk_super->fsid,
>>

