Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB667166EE3
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2020 06:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgBUFQk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 00:16:40 -0500
Received: from mout.gmx.net ([212.227.15.15]:43087 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbgBUFQj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 00:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582262191;
        bh=0Co4HGcsUODPF6Ib6hQoZn+loua1i+QEM2uTVJBLl4E=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Vwdd6TTM8VxiMyIJ2FgHd0V78YVCQBabIULPXFV7NHSmreOoQNVqJIQIw1b3H3kYF
         muZeJq+Sctn9oPIQ6IBkgqmjcNw2dDW9F32R4RK3oMynuIGJLBz3i+exCdbebLlG18
         d8VDoJ3yf4Sqd/cok9G/Irb2qKg5UYqA4z5f3KZY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M59GA-1j3uDD05C8-001AZ7; Fri, 21
 Feb 2020 06:16:31 +0100
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
Message-ID: <9da38175-637b-b758-0c09-518123c796d5@gmx.com>
Date:   Fri, 21 Feb 2020 13:16:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <329cf703-f3f2-4583-73bf-c90c9e001956@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZSBa0MGhQEuw6AbltM5b5tjuWHk11t8Uey9ogPmJ+jhucYW4I7X
 vmXHrisEwxXQZzauklioN6kLa5xIGv2W/C+2axOQ/RQ+RuD0ofqASgsnoBG1ym55CStLRmK
 EcEPAlAYSNfyinihxqXirZhr+rqkO/7o0Gu2AWehF8pWIoHREbxdo+faPptDkKFM6IxBOZM
 anxfIf0nErowy3/MfDP8Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PIwzcelhZsg=:QlMpQqE5gThJ/8nOwfpqy3
 lfV1NhSZLt/c6TOp2wJUwhfEX0umbQPUQgpZeZ74fDNF5yx9JeO0Cy5LNWbFYqiJ9Y+ZWQdHj
 dc68KA6kmpHHc342rW2ECawTWusPJoFNlpUlDkbW19p/vmOziy4/fAfELDMLdrI+2ryRucfDa
 /xo6JHWkBos3M1JveQXaPPaZEtKSlsy2YmHidvV4ERk/Q99HfjfZonxNFn9S3nspAYJ3CQv11
 mlZdAqr8c2qGjuqZAiJuAGlFgmWARCm3og0m7bmPbOL/LDyYdve2Ms53S1+RfLXMCInEJE/tB
 Esgj2fK/Mzf6Qdps2/Btoh0h5wKZfLhvYWSUzsH6bmfdGcO6Wy7jhVGILiTaN1FGc2M+BeR0J
 EmpQAP7ZxeudtXh6yZSP9qsO9p2M2jQC3+rumGsor1u621m9VC3tOo6f/Ssx6rDZg1nw4yNGg
 hVzHDZMVp8FWWTIAba8yJG351y65J1l/olEOfOPv9neeH4i8H+emXOd6PCpWClFMAmqi+WP6z
 4h3b5w7Q9OLk0pr1m7NgHMhqs81FmZiy9c7PN1DinJhJuV79eakt4a1fsmKQl26bz0d9pfLwB
 uH6f0ehF1g/QR7XbL96fnPIlC3/eAICLL9HHZfyMkf5NDWQv+AxYvTPgsfUv8CuVfTPLGUgIw
 h0njOAYHhHbcgebBOv6/h3PmgPZep0fJ0QJQsT3YcCfElH+lKg7f7LTDyTlfGtifbwfXnE1YP
 2wYKhR2cF0BTO+5+4Qa8v/oMme5mvAlMjAveaz1wUKjDGrCaCchaCT4yUJEM/umjmve7eE1bi
 qff3RrPcIfAPOHPP31PHyIk8hRwpN/Fat+VzJjtxXBg5rcKZgOFHpct42qCZx+6goyMGoCZ80
 AhBea8Dc1KcN578cuj9TKrEVSX5/vLRH9T8OUQZxVw/zZRNcqK85BXLM4u4rL/aVThBOrOsrU
 fJ/+KQlk56dYy91SJO9o1hqF+bxvHemfqT+QJQJiQamSq5KYerLUIJmPNv444z22q3CXhCAUG
 6c8QscO3Fa4OhHXfPPY091F3p6TgPMiFOIHJRjppnh8nFrAC3cvTCYDFFbFl/sqdbzNY0t/hM
 d45+CQXZoI4xAif7YYK7j0+FF8JZAY1kYzUqiEpgAD/1w7QG4LnA9boWzyfDPRlqE91O3XceA
 q/jQQnVh6x0U9sOFd7GXgzT8wK6ydq5vxYZYNrrRPvdhu9FqCWu0qalYLLpPlzNIVg+htvcIk
 Ddmo+UMhYefO4RaLx
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

Isn't that mentioned in the 3rd line of the comment? (Although the
parameter name doesn't match after some updates).

...
> lockdep assert that chunk mutex is held since you access alloc_list.
>
>> +	ASSERT(type >=3D 0 && type < BTRFS_NR_RAID_TYPES);
>> +
>> +	/* Not enough devices, quick exit, just update the result */
>> +	if (fs_devices->rw_devices < btrfs_raid_array[type].devs_min)
>> +		goto out;
>
> You can directly return.

Then you won't update the @result_ret.
And don't forget that, @result_ret is from an uninitialized local array.
Thus we must go out tag.

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

Same as above.

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

Then your new while() loop idea will still need @allocated declared at
at the beginning of the function.

Thanks,
Qu

>
>> +		if (ret =3D=3D 0)
>> +			result +=3D allocated;
>> +	}
>
> Why do you need to call this in a loop calling alloc_virtual_chunk once
> simply calculate the available space for the given raid type.
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
>
>>  };
>>
>>  #define BTRFS_BIO_INLINE_CSUM_SIZE	64
>>
