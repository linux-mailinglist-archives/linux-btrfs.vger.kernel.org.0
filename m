Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDBB296D9A
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Oct 2020 13:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462920AbgJWLZ2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Oct 2020 07:25:28 -0400
Received: from mout.gmx.net ([212.227.17.20]:59527 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S462680AbgJWLZ1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Oct 2020 07:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603452318;
        bh=tOHv9A+3Vj6naDDCxpKjYtX4YoAhChBihGDTs3XjyTE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HJhA810KP3SS8McVZhzIrRBvB/lfEg3bxs94Vo7DNibyfpgURV2xrcnPbE8JRCygA
         smyypp78RSJ6HMhMeHr1b76iy5GDyRpJci6uJIhizZhMnBU/sLGsqDyNtYtt9O2T8U
         5GTPotTk+1+HCQJdMGRGuVIjYx8KLPXp1JswK+Ac=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mlf4c-1k4nr50R98-00ilGG; Fri, 23
 Oct 2020 13:25:17 +0200
Subject: Re: [PATCH] btrfs: add ssd_metadata mode
To:     Adam Borowski <kilobyte@angband.pl>,
        Wang Yugui <wangyugui@e16-tech.com>
Cc:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org, Michael <mclaud@roznica.com.ua>,
        Hugo Mills <hugo@carfax.org.uk>,
        Martin Svec <martin.svec@zoner.cz>,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <20200405082636.18016-1-kreijack@libero.it>
 <20200405082636.18016-2-kreijack@libero.it>
 <20201023152329.E7FF.409509F4@e16-tech.com>
 <20201023101145.GB19860@angband.pl>
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
Message-ID: <d7ee1c25-ceea-0471-9702-0622a5ef4453@gmx.com>
Date:   Fri, 23 Oct 2020 19:25:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201023101145.GB19860@angband.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:58hWi3J8GDTAO41nSPOEZNMf0Pn2GWkGguIA1e8gEFa/ef48f7Q
 7zQJy+F5vE95PE36Kl3ZU0GUdHEBYEhEFoiRFLEH7kuPHCGVwmdCsZoNbPRHrPuRtAhutsI
 egGRh87xyezdkAXS5BDBnbuMEVP8gy2rkdlrra5VNYAfEA5mO6ojojJZsQtik8/ULYBTL1g
 VvmZJTCgsQ0fxCxizRzWA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ogT66B5vP/E=:+q81fRCFp6n1OOcdfC6I6J
 EzZtga/E7NjClKnRHN5Hxdj2YBQZVNASdKQ/z7+cOdS8jJGqa06Ah7igQ0ggiXE4wH3dYn+HX
 ussUwXj/OTAyhqt+qk+AVM89QKtZKPiWp/OnSDXmfYfR1wvLhKlXozl4DAX3KHZj8fkv25JEa
 KR+3GEleReoC6FYXwS9lY7zNmXLoRN5GGkIxFzJLIQRohgKbG7jaLGlfwAhSC0RJo0cuDxPVp
 rRCjEQJeeJurGXHUopbVQ5WL0PPZh0kIqo9RaAvyWLOdvtQ3bwoVXWeTUcCiB4iC8aePLSJs0
 q5uI/ZkeUH8qX/8OBeill/QTiyl/7qPgrJhPIO7nKleanOynQwAOGudLhM/FHLdnAT87Fhzkv
 R0c0VbzgLzBtc9d7RDk0p667WIUwnxrhGOs/tnoV61wA8KQqZ94Ndg9S44Ll6ZJXzgeknb/n6
 LQOaPZAiuImx4eCBB6kgFi233PvO7gy5Ow0DcwsU1SyfXNm761+SX3MHndGmdmx8DBBqHsgsD
 hzuRxpHibXiDvvvwQUvPLbU2BHnUrAqeD+gQAtOyr2L0bRt2jkMe+kGoQdtDuB0o3yMjoBkDk
 3dMEiXm0PBLXhkZyvjP3EFsE2z48OmPcYaSXENwplIGVYGoHSdQNiqiUSAluC3Wcma8NH34Vb
 PF1cy8HfmazjnvzMRSN+x1g2NJxlH5cvW6B5LVTOuC8wH0nnJqQv53glKaZ1rEfLuAiRVai8A
 vSqnMAJnZzDNzlSBpDrFfje5AfK7oq0q2GwLPL5bDfWjzBDty/c8Xae5vyevTqM0rcbh5tFbx
 KSUWvG4wpCWUMHE46M1b4IohH7X9c6dn5J0DTdnLpAmY1wbC1EnVmbsoGiYnoRTS/IDguVucN
 xkUkUS7EKwYqyczYGfGA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/10/23 =E4=B8=8B=E5=8D=886:11, Adam Borowski wrote:
> On Fri, Oct 23, 2020 at 03:23:30PM +0800, Wang Yugui wrote:
>> Hi, Goffredo Baroncelli
>>
>> We can move 'rotational of struct btrfs_device_info' to  'bool rotating
>> of struct btrfs_device'.
>>
>> 1, it will be more close to 'bool rotating of struct btrfs_fs_devices'.
>>
>> 2, it maybe used to enhance the path of '[PATCH] btrfs: balance RAID1/R=
AID10 mirror selection'.
>> https://lore.kernel.org/linux-btrfs/3bddd73e-cb60-b716-4e98-61ff24beb57=
0@oracle.com/T/#t
>
> I don't think it should be a bool -- or at least, turned into a bool
> late in the processing.
>
> There are many storage tiers; rotational applies only to one of the
> coldest.  In my use case, at least, I've added the following patchlet:
>
> -               devices_info[ndevs].rotational =3D !test_bit(QUEUE_FLAG_=
NONROT,
> +               devices_info[ndevs].rotational =3D !test_bit(QUEUE_FLAG_=
DAX,
>
> Or, you may want Optane NVMe vs legacy (ie, NAND) NVMe.

A little off topic here, btrfs in fact has a better ways to model a
storage, and definitely not simply rotational or not.

In btrfs_dev_item, we have bandwith and seek_speed to determine the
characteristic, although they're never really utilized.

So if we're really going to dig deeper into the rabbit hole, we need
more characteristic to describe a device.
=46rom basic bandwidth for large block size IO, to things like IOPS for
small random block size, and even possible multi-level performance
characteristic for cases like multi-level cache used in current NVME
ssds, and future SMR + CMR mixed devices.

Although computer is binary, the performance characteristic is never
binary. :)

Thanks,
Qu
>
> The tiers look like:
> * DIMM-connected Optane (dax=3D1)
> * NVMe-connected Optane
> * NVMe-connected flash
> * SATA-connected flash
> * SATA-connected spinning rust (rotational=3D1)
> * IDE-connected spinning rust (rotational=3D1)
> * SD cards
> * floppies?
>
> And even that is just for local storage only.
>
> Thus, please don't hardcode the notion of "rotational", what we want is
> "faster but smaller" vs "slower but bigger".
>
>>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>>
>>> When this mode is enabled, the allocation policy of the chunk
>>> is so modified:
>>> - allocation of metadata chunk: priority is given to ssd disk.
>>> - allocation of data chunk: priority is given to a rotational disk.
>>>
>>> When a striped profile is involved (like RAID0,5,6), the logic
>>> is a bit more complex. If there are enough disks, the data profiles
>>> are stored on the rotational disks only; instead the metadata profiles
>>> are stored on the non rotational disk only.
>>> If the disks are not enough, then the profiles is stored on all
>>> the disks.
>
> And, a newer version of Goffredo's patchset already had
> "preferred_metadata".  It did not assign the preference automatically,
> but if we want god defaults, they should be smarter than just rotational=
ity.
>
>
> Meow!
>
