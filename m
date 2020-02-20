Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B029165DFC
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2020 13:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgBTM7x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Feb 2020 07:59:53 -0500
Received: from mout.gmx.net ([212.227.15.18]:60909 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbgBTM7w (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Feb 2020 07:59:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582203583;
        bh=ZaOvJ5g0U569vl7zFjnHi6uJXOc3Wv8qU4TE2nT4gKY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cUm4YJJmQdXk0GU2d+w0sGfHBcIPv+6Mmw/SkfPgbNmjfZEyMdAQaH/bvPvkeSkSV
         HDdCkncXVQfEpti7aeR79Jvp0R8/Dirp1kECgJX+RxilbdD6n11t3IRRPtcuh3wQT+
         AVMq5B5vShhFzlv4Ww8jo9P2ViT8/ZCtLfFNM7A0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MXp5a-1ixCJl3Bl6-00Y7lX; Thu, 20
 Feb 2020 13:59:42 +0100
Subject: Re: [PATCH v7 1/5] btrfs: Introduce per-profile available space
 facility
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
References: <20200211051153.19466-1-wqu@suse.com>
 <20200211051153.19466-2-wqu@suse.com>
 <329cf703-f3f2-4583-73bf-c90c9e001956@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <0f3b2eb2-1af4-13fb-8d9a-867dd7e68fb8@gmx.com>
Date:   Thu, 20 Feb 2020 20:59:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <329cf703-f3f2-4583-73bf-c90c9e001956@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BEf6IjCuoSOYQCQBziBHO38cTFfKAAGRMjZTdjveNI+vfysbbQq
 xl0eF2VslzoFh6AzcKdD0wXLcFU9bfl0HkbInjxXShz9JEeOLS1wVYCnFHBPDfWH3jiILtm
 uibxEd7+Z9pjlbRHE48EHYm9dLt8G+db59P92cUJ8lsDssR+TccxfFHVA+eo2CTEPbm5oV8
 iMO6AoYrRvJl9Fu8+zaqw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OcnVT92BUFU=:hP2uo/n2ZZ/U+gpSGDuh9k
 T+Gyt4I/Qu1ZnXKljwrZVNj3f8pdBnOFHIIWNHUcKB8ybvQqWI7mZ20JziInCSkWp2ta8Bg4R
 tk7oqzKg5KrErqUqqcPOUeIt2eMrAzuzvxNiOGLzM4cit/DmCNHCDwVCqcM5ET6MsyvnB1M5v
 0eYvYTAj02HjJb+vx9NC768AptLKLo7X504kUhyLy/GCTE6N8w99YspawQbsO62FeMKvjD/Qm
 CUPtEZZ3irbRIlfA01vbs5GIJO0l12iToEE83WLXurzy5ObdxS/cJQXggnr3ftdWVAkbwm+a5
 n8kuSdUepud5aEAkOaLKUMruSgmVf7qn9ZsJJRhuRuzWEWRKClUmTlnglZu2r37lBnlTyZ52T
 D5eRjigNMIdChrWZpDeDIyzhUhn33LB3HXd4BrMVB4+yeKzV6JY8K4OH1CEGpO3/e4f3yEpRk
 /VRwt6l83rG9xUMhl2EJRMSxx7+j0mpyHB813OZQMEFIMtcxZTZLcQluuOlVlm/+b5tAMquu/
 9d1Kyzj6R/NIves2yq86LOlYsmS04y+cOQ6dZJuDC5hHISlhyRkmO5Cwng0pwNC6STFAbeqYu
 xsyj5KpQJJ0sOd/EIoO8T5Y78edc/dLXfanjv/wsZjxvnmKBrqn8QvWG5yC5AzG22WrfBhSwT
 4E/XXyRhqwZX6gOkURXDxzXs/FHgss7qzTRKnbUk2YjhL9AqcvSbpgo9KS2oa7piF2ExVyCdA
 kJ4RuR8Kp7LUdp7YlLvAUu0UWde6Meg7UTFzFuOySIW2jeO4mkphvb04/MKB8Nj/5oPUOSu0A
 +Na4M9D+RBXpUQyqSpVE4tApUCJGMFEuQRwVuPMxsSj/Yp4JYg/OVKkWIMCyvt4tHZni1HYBX
 4yZanQmznzMd8HPZlNuHT5oohpNgzH61VXJa0AkBzhoiGtFEdgaRMivR5cVtFEt+v17IWvPK/
 2GydXJLGXAH/sq2Q6ZPTV71Nu0Dq4SyhAOda/qVeZT87VLZPyE6gSqBNDju7/FfewwhsYwO+3
 zmDOP/Ioop6LCK/c4jVTz8/7nCRHtTzvTiRNuqgLBpetUT5sRYJqgh9cYv26yN45vqbEAhD9d
 GRwwTI84qHDo4sJbZtvi4zQnOe8QlNYgr0i6epZ8GxtUbtdN7TS7r4gOPrD5fF8L9zMnG6AJX
 yi9nN2Qeb94dBjj9ZnU9RMCVwLF6L7td2KwGDFOV7nV1xbaxKygYx9rKk3Bwh9LLzamyREcr2
 Fa/Eubt6HO6DLlQWG
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/2/20 =E4=B8=8B=E5=8D=888:49, Nikolay Borisov wrote:
> <snip>
>
>>
>> Suggested-by: Josef Bacik <josef@toxicpanda.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/volumes.c | 216 ++++++++++++++++++++++++++++++++++++++++-----
>>  fs/btrfs/volumes.h |  11 +++
>>  2 files changed, 207 insertions(+), 20 deletions(-)
>>
>
> <snip>
>
>> +
>> +/*
>> + * Return 0 if we allocated any virtual(*) chunk, and restore the size=
 to
>> + * @allocated_size
>> + * Return -ENOSPC if we have no more space to allocate virtual chunk
>> + *
>> + * *: virtual chunk is a space holder for per-profile available space
>> + *    calculator.
>> + *    Such virtual chunks won't take on-disk space, thus called virtua=
l, and
>> + *    only affects per-profile available space calulation.
>> + */
>
> Document that the last parameter is an output value which contains the
> size of the allocated virtual chunk.
>
>> +static int alloc_virtual_chunk(struct btrfs_fs_info *fs_info,
>> +			       struct btrfs_device_info *devices_info,
>> +			       enum btrfs_raid_types type,
>> +			       u64 *allocated)
>> +{
>> +	const struct btrfs_raid_attr *raid_attr =3D &btrfs_raid_array[type];
>> +	struct btrfs_fs_devices *fs_devices =3D fs_info->fs_devices;
>> +	struct btrfs_device *device;
>> +	u64 stripe_size;
>> +	int i;
>> +	int ndevs =3D 0;
>> +
>> +	lockdep_assert_held(&fs_info->chunk_mutex);
>> +
>> +	/* Go through devices to collect their unallocated space */
>> +	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list) =
{
>> +		u64 avail;
>> +		if (!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA,
>> +					&device->dev_state) ||
>> +		    test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state))
>> +			continue;
>> +
>> +		if (device->total_bytes > device->bytes_used +
>> +				device->virtual_allocated)
>> +			avail =3D device->total_bytes - device->bytes_used -
>> +				device->virtual_allocated;
>> +		else
>> +			avail =3D 0;
>> +
>> +		/* And exclude the [0, 1M) reserved space */
>> +		if (avail > SZ_1M)
>> +			avail -=3D SZ_1M;
>> +		else
>> +			avail =3D 0;
>> +
>> +		if (avail < fs_info->sectorsize)
>> +			continue;
>> +		/*
>> +		 * Unlike chunk allocator, we don't care about stripe or hole
>> +		 * size, so here we use @avail directly
>> +		 */
>> +		devices_info[ndevs].dev_offset =3D 0;
>> +		devices_info[ndevs].total_avail =3D avail;
>> +		devices_info[ndevs].max_avail =3D avail;
>> +		devices_info[ndevs].dev =3D device;
>> +		++ndevs;
>> +	}
>> +	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
>> +	     btrfs_cmp_device_info, NULL);
>> +	ndevs -=3D ndevs % raid_attr->devs_increment;
>
> nit: ndevs =3D rounddown(ndevs, raid_attr->devs_increment);

IIRC round_down() can only be used when the alignment is power of 2.

Don't forget we have RAID1C3 now.

> makes it more clear what's going on. Since you are working with at most
> int it's not a problem for 32bits.
>
>
>> +	if (ndevs < raid_attr->devs_min)
>> +		return -ENOSPC;
>> +	if (raid_attr->devs_max)
>> +		ndevs =3D min(ndevs, (int)raid_attr->devs_max);
>> +	else
>> +		ndevs =3D min(ndevs, (int)BTRFS_MAX_DEVS(fs_info));
>
> Instead of casting simply use min_t(int, ndevs, BTRFS_MAX_DEVS...)

That looks the same to me...

>
>> +
>> +	/*
>> +	 * Now allocate a virtual chunk using the unallocate space of the
>
> nit: missing d after 'unallocate'
>
>> +	 * device with the least unallocated space.
>> +	 */
>> +	stripe_size =3D round_down(devices_info[ndevs - 1].total_avail,
>> +				 fs_info->sectorsize);
>> +	if (stripe_size =3D=3D 0)
>> +		return -ENOSPC;
>
> Isn't this check redundant - in the loop where you iterate the devices
> you always ensure total_avail is at least a sector size, this guarantees
> that stripe_size cannot be 0 at this point.
>
>> +
>> +	for (i =3D 0; i < ndevs; i++)
>> +		devices_info[i].dev->virtual_allocated +=3D stripe_size;
>> +	*allocated =3D stripe_size * (ndevs - raid_attr->nparity) /
>> +		     raid_attr->ncopies;
>> +	return 0;
>> +}
>> +
>> +static int calc_one_profile_avail(struct btrfs_fs_info *fs_info,
>> +				  enum btrfs_raid_types type,
>> +				  u64 *result_ret)
>> +{
>> +	struct btrfs_device_info *devices_info =3D NULL;
>> +	struct btrfs_fs_devices *fs_devices =3D fs_info->fs_devices;
>> +	struct btrfs_device *device;
>> +	u64 allocated;
>> +	u64 result =3D 0;
>> +	int ret =3D 0;
>> +
>
> lockdep assert that chunk mutex is held since you access alloc_list.
>
>> +	ASSERT(type >=3D 0 && type < BTRFS_NR_RAID_TYPES);
>> +
>> +	/* Not enough devices, quick exit, just update the result */
>> +	if (fs_devices->rw_devices < btrfs_raid_array[type].devs_min)
>> +		goto out;
>
> You can directly return.
>
>> +
>> +	devices_info =3D kcalloc(fs_devices->rw_devices, sizeof(*devices_info=
),
>> +			       GFP_NOFS);
>> +	if (!devices_info) {
>> +		ret =3D -ENOMEM;
>> +		goto out;
>
> Same here.
>
>> +	}
>> +	/* Clear virtual chunk used space for each device */
>> +	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list)
>> +		device->virtual_allocated =3D 0;
>> +	while (ret =3D=3D 0) {
>> +		ret =3D alloc_virtual_chunk(fs_info, devices_info, type,
>> +					  &allocated);
> The 'allocated' variable is used only in this loop so declare it in the
> loop. Ideally we want variables to have the shortest possible lifecycle.
>
>> +		if (ret =3D=3D 0)
>> +			result +=3D allocated;
>> +	}
>
> Why do you need to call this in a loop calling alloc_virtual_chunk once
> simply calculate the available space for the given raid type.

For this case, we must go several loops:
Dev1: 10G
Dev2: 5G
Dev3: 5G
Type: RAID1.

The first loop will use 5G from dev1, 5G from dev2.
Then the 2nd loop will use the remaining 5G from dev1, 5G from dev3.

And that's the core problem per-profile available space system want to
address.

>
>> +	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list)
>> +		device->virtual_allocated =3D 0;
>> +out:
>> +	kfree(devices_info);
>> +	if (ret < 0 && ret !=3D -ENOSPC)
>> +		return ret;
>> +	*result_ret =3D result;
>> +	return 0;
>> +}
>
> <snip>
>
>> @@ -259,6 +266,10 @@ struct btrfs_fs_devices {
>>  	struct kobject fsid_kobj;
>>  	struct kobject *devices_kobj;
>>  	struct completion kobj_unregister;
>> +
>> +	/* Records per-type available space */
>> +	spinlock_t per_profile_lock;
>> +	u64 per_profile_avail[BTRFS_NR_RAID_TYPES];
>
> Since every avail quantity is independent of any other, can you turn
> this into an array of atomic64 values and get rid of the spinlock? My
> head spins how many locks we have in btrfs.

OK, that won't hurt, since they are updated separately, there is indeed
no need for a spinlock.

Thanks,
Qu
>
>>  };
>>
>>  #define BTRFS_BIO_INLINE_CSUM_SIZE	64
>>
