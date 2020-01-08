Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC049134531
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 15:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgAHOkW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jan 2020 09:40:22 -0500
Received: from mout.gmx.net ([212.227.15.15]:33039 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727313AbgAHOkW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Jan 2020 09:40:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578494411;
        bh=CkOoi516IJ7wdaxpcQyju+dhdQsO8ulDL7JGDxlSAyE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ha1EQdSqIpg//7Tpe0jnkpByfcAMzXbvq6AB5K7r5m6R5aPdyQdVFZUxKtBu91WrB
         tRvakv0QhzCDENXn+IyS5s4a51gcekfR5GDv+Vj1uc99oaLWxXzqr+YvomM8NS8f+g
         5sdOa3/nlg+LgKCkFnUbSFCTWURNQxwRs3yvjweQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MkHMZ-1jYwOB0szB-00khiB; Wed, 08
 Jan 2020 15:40:11 +0100
Subject: Re: [PATCH v4 3/3] btrfs: statfs: Use virtual chunk allocation to
 calculation available data space
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200108070509.25483-1-wqu@suse.com>
 <20200108070509.25483-4-wqu@suse.com>
 <81df707c-2286-0505-6f1b-2295e864238f@toxicpanda.com>
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
Message-ID: <0fcd7a9e-7c5d-f734-bf23-2dd13a7ac10a@gmx.com>
Date:   Wed, 8 Jan 2020 22:40:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <81df707c-2286-0505-6f1b-2295e864238f@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nQ7nWqWRdSeZqievGDOZTuFdec9P533b4"
X-Provags-ID: V03:K1:H6DrUxWoNnKdjposCZQSqUrydWfwAdOI71IUS07AZw+DvV8RYD9
 X/jBdo3cZVFsxtavEDlCklkv2+Y/Fm4eaYmz9r3yVWAOZNSLORCDj2DkoJ7GtS1ubwT4qUv
 S7k7QD+MG3i+1RTvs5RaxQfZ62uC3xUl46NO/DY/gVHC1K8mPmIPx6OE7AW0iNSYIViF6qe
 vgs6us5Kvg/p4dt9NIZ/w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9+hLpwYL59E=:xWnxcNaXiDPVyuO2xuhR4w
 Z0jCvFHVmeal+gXnJR3shVy4dD1kZXNFs1Ihre0Xc5fxifNXPjJVPwpVG8+g7+52AJb1eaAeX
 yMahiv92N61UPMULbk6XSDAUtl8DD53MyQddoFdDoAOKJSe7hKNpdBBIjfwl5TwOgvQ9bGnlP
 hdYTBTpDgHloixhXNZZN+0NJzWCqbQ0U4py6EkT5kQOVj/01a15CY9lMrTkv3jS4i0YzYlyw1
 PXUpE2nPv01XrhEtRrz8/fdDbtfKMBmOpPfUWWjqYrWwAW9Xnbay5t43GYdTVwGYSQIgomC8m
 QCCYvgKEhp+RziUdJF6ZWW9V7s6RGjjavRjHCRZ32qAxEyVYcxUTRH2p8OiPn4APRx/2RLvDK
 MdrpJHVWm7TwCDlr4XXgEgmgnGzX14puXwlolH8Crx4CAkb1m5ZL7bdBUp+MWXPhfRHwndR/X
 yLADyzOQiVqzHTwl8CURiZQ8ptRd4auNLZhRZQXTQJiloPHASsa2i8UtUA6U66aEwskLvMuQT
 01qI1QZDfYLXKWWBz7YQ0w6qULoGUC+qftgYqlp0tobDrXmochAgDIjn8aNQw8DvXk45+K0Xm
 L74pCm6O7y8gkRfeXCPjR+Ujb7dZKC65X4/RfEQ9WYXzUWldDo+r7o+daJ/qiDpnrrSLqVS+0
 EWsTUWrAsVv483Tg44VO/kb5utAni7lYJMmsRYFIbilAdIqc6NAeL/7zzyvCJrvSYc2ckZQx0
 saGF6w+v/2F1NG+UTLM+h7lB5IdxYLKob8bLNypQ5SiKOLlPXzrhOLj0wfEbbxj/qrYVnHNu7
 1zsdT7uNqMl1vYwFsNLDaBpsNHOyGtP091LRjoHt0KA8AIGwFzNKbywVKZhmWAWDdtozLKzbc
 MGtCOwyXoab24qZknJfYDfAHNUujEpwULAfNrgik3UGQfLzzzkU0Rs8x5QjcfdyZY3CDthllk
 SG2+6AwhzwV3+KW7w/5+VHdhEowOZ3i1/QFTH+5DTpdjOycauMUsy8b0Tr/4awy2InVLFnCkW
 rQ9Mp9yo87ibvz08PQasGrxJDpjl5xByyZKbOHd6OuDc4qS9tVjD5xei6CHjFIMtcQX1BAIyw
 cNM1JTHsEgLvieMQJXQqvdgYhHmDFytltoKV2KgYsQRkF8bfIRIbBJ/PDiFiorZWRUknwj6GM
 X3tsN6AJXsLqfCNj+CxQYL7V1Im9ElkpgyXQRDb5xJph9QoxOwJGgx/Wrt3A+76A/EHhtxFkz
 LOxUy6w9N2BWl2NXDK+iXa7X32/Atg8NcUT3d5HlRFNZL2Afg52XtZkuihSQ=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nQ7nWqWRdSeZqievGDOZTuFdec9P533b4
Content-Type: multipart/mixed; boundary="HQ1UCTC5Fmgg8Mrg6K4OWXv801tRrhZmx"

--HQ1UCTC5Fmgg8Mrg6K4OWXv801tRrhZmx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/8 =E4=B8=8B=E5=8D=8810:35, Josef Bacik wrote:
> On 1/8/20 2:05 AM, Qu Wenruo wrote:
>> Although btrfs_calc_avail_data_space() is trying to do an estimation
>> on how many data chunks it can allocate, the estimation is far from
>> perfect:
>>
>> - Metadata over-commit is not considered at all
>> - Chunk allocation doesn't take RAID5/6 into consideration
>>
>> This patch will change btrfs_calc_avail_data_space() to use
>> pre-calculated per-profile available space.
>>
>> This provides the following benefits:
>> - Accurate unallocated data space estimation, including RAID5/6
>> =C2=A0=C2=A0 It's as accurate as chunk allocator, and can handle RAID5=
/6.
>>
>> Although it still can't handle metadata over-commit that accurately, w=
e
>> still have fallback method for over-commit, by using factor based
>> estimation.
>>
>> The good news is, over-commit can only happen when we have enough
>> unallocated space, so even we may not report byte accurate result when=

>> the fs is empty, the result will get more and more accurate when
>> unallocated space is reducing.
>>
>> So the metadata over-commit shouldn't cause too many problem.
>>
>> Since we're keeping the old lock-free design, statfs should not
>> experience
>> any extra delay.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 fs/btrfs/super.c=C2=A0=C2=A0 | 174 +++++++++++-----------------=
-----------------
>> =C2=A0 fs/btrfs/volumes.h |=C2=A0=C2=A0 4 ++
>> =C2=A0 2 files changed, 47 insertions(+), 131 deletions(-)
>>
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index f452a94abdc3..ecca25c40637 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -1894,118 +1894,53 @@ static inline void
>> btrfs_descending_sort_devices(
>> =C2=A0=C2=A0 * The helper to calc the free space on the devices that c=
an be used
>> to store
>> =C2=A0=C2=A0 * file data.
>> =C2=A0=C2=A0 */
>> -static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info
>> *fs_info,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 u64 *free_bytes)
>> +static u64 btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,=

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 free_=
meta)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 struct btrfs_device_info *devices_info;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_fs_devices *fs_devices =3D=
 fs_info->fs_devices;
>> -=C2=A0=C2=A0=C2=A0 struct btrfs_device *device;
>> -=C2=A0=C2=A0=C2=A0 u64 type;
>> -=C2=A0=C2=A0=C2=A0 u64 avail_space;
>> -=C2=A0=C2=A0=C2=A0 u64 min_stripe_size;
>> -=C2=A0=C2=A0=C2=A0 int num_stripes =3D 1;
>> -=C2=A0=C2=A0=C2=A0 int i =3D 0, nr_devices;
>> -=C2=A0=C2=A0=C2=A0 const struct btrfs_raid_attr *rattr;
>> +=C2=A0=C2=A0=C2=A0 enum btrfs_raid_types data_type;
>> +=C2=A0=C2=A0=C2=A0 u64 data_profile =3D btrfs_data_alloc_profile(fs_i=
nfo);
>> +=C2=A0=C2=A0=C2=A0 u64 data_avail;
>> +=C2=A0=C2=A0=C2=A0 u64 meta_rsv;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 /*
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * We aren't under the device list lock, so t=
his is racy-ish, but
>> good
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * enough for our purposes.
>> -=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0 nr_devices =3D fs_info->fs_devices->open_devices;
>> -=C2=A0=C2=A0=C2=A0 if (!nr_devices) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smp_mb();
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nr_devices =3D fs_info->fs=
_devices->open_devices;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASSERT(nr_devices);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!nr_devices) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *f=
ree_bytes =3D 0;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn 0;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 }
>> -
>> -=C2=A0=C2=A0=C2=A0 devices_info =3D kmalloc_array(nr_devices, sizeof(=
*devices_info),
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
>> -=C2=A0=C2=A0=C2=A0 if (!devices_info)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> -
>> -=C2=A0=C2=A0=C2=A0 /* calc min stripe number for data space allocatio=
n */
>> -=C2=A0=C2=A0=C2=A0 type =3D btrfs_data_alloc_profile(fs_info);
>> -=C2=A0=C2=A0=C2=A0 rattr =3D &btrfs_raid_array[btrfs_bg_flags_to_raid=
_index(type)];
>> -
>> -=C2=A0=C2=A0=C2=A0 if (type & BTRFS_BLOCK_GROUP_RAID0)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_stripes =3D nr_devices=
;
>> -=C2=A0=C2=A0=C2=A0 else if (type & BTRFS_BLOCK_GROUP_RAID1)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_stripes =3D 2;
>> -=C2=A0=C2=A0=C2=A0 else if (type & BTRFS_BLOCK_GROUP_RAID1C3)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_stripes =3D 3;
>> -=C2=A0=C2=A0=C2=A0 else if (type & BTRFS_BLOCK_GROUP_RAID1C4)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_stripes =3D 4;
>> -=C2=A0=C2=A0=C2=A0 else if (type & BTRFS_BLOCK_GROUP_RAID10)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_stripes =3D 4;
>> +=C2=A0=C2=A0=C2=A0 spin_lock(&fs_info->global_block_rsv.lock);
>> +=C2=A0=C2=A0=C2=A0 meta_rsv =3D fs_info->global_block_rsv.size;
>> +=C2=A0=C2=A0=C2=A0 spin_unlock(&fs_info->global_block_rsv.lock);
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 /* Adjust for more than 1 stripe per device=
 */
>> -=C2=A0=C2=A0=C2=A0 min_stripe_size =3D rattr->dev_stripes * BTRFS_STR=
IPE_LEN;
>> +=C2=A0=C2=A0=C2=A0 data_type =3D btrfs_bg_flags_to_raid_index(data_pr=
ofile);
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 rcu_read_lock();
>> -=C2=A0=C2=A0=C2=A0 list_for_each_entry_rcu(device, &fs_devices->devic=
es, dev_list) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!test_bit(BTRFS_DEV_ST=
ATE_IN_FS_METADATA,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &de=
vice->dev_state) ||
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !d=
evice->bdev ||
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 te=
st_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
ntinue;
>> +=C2=A0=C2=A0=C2=A0 spin_lock(&fs_devices->per_profile_lock);
>> +=C2=A0=C2=A0=C2=A0 data_avail =3D fs_devices->per_profile_avail[data_=
type];
>> +=C2=A0=C2=A0=C2=A0 spin_unlock(&fs_devices->per_profile_lock);
>> =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (i >=3D nr_devic=
es)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 avail_space =3D device->to=
tal_bytes - device->bytes_used;
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* align with stripe_len *=
/
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 avail_space =3D rounddown(=
avail_space, BTRFS_STRIPE_LEN);
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * In order to avoid =
overwriting the superblock on the drive,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * btrfs starts at an=
 offset of at least 1MB when doing chunk
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * allocation.
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This ensures we ha=
ve at least min_stripe_size free space
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * after excluding 1M=
B.
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (avail_space <=3D SZ_1M=
 + min_stripe_size)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
ntinue;
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 avail_space -=3D SZ_1M;
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devices_info[i].dev =3D de=
vice;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devices_info[i].max_avail =
=3D avail_space;
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i++;
>> -=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 rcu_read_unlock();
>> -
>> -=C2=A0=C2=A0=C2=A0 nr_devices =3D i;
>> -
>> -=C2=A0=C2=A0=C2=A0 btrfs_descending_sort_devices(devices_info, nr_dev=
ices);
>> -
>> -=C2=A0=C2=A0=C2=A0 i =3D nr_devices - 1;
>> -=C2=A0=C2=A0=C2=A0 avail_space =3D 0;
>> -=C2=A0=C2=A0=C2=A0 while (nr_devices >=3D rattr->devs_min) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_stripes =3D min(num_st=
ripes, nr_devices);
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (devices_info[i].max_av=
ail >=3D min_stripe_size) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in=
t j;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u6=
4 alloc_size;
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 av=
ail_space +=3D devices_info[i].max_avail * num_stripes;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 al=
loc_size =3D devices_info[i].max_avail;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fo=
r (j =3D i + 1 - num_stripes; j <=3D i; j++)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 devices_info[j].max_avail -=3D alloc_size;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i--;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nr_devices--;
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * We have meta over-committed, do some wild =
guess using factor.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * To get an accurate result, we should alloc=
ate a metadata virtual
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * chunk first, then allocate data virtual ch=
unks to get real
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * estimation.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * But that needs chunk_mutex, which could be=
 very slow to accquire.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * So here we trade for non-blocking statfs. =
And meta
>> over-committing is
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * less a problem because:
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * - Meta over-commit only happens when we ha=
ve unallocated space
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 So no over-commit if we're low=
 on available space.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * This may not be as accurate as virtual chu=
nk based one, but it
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * should be good enough for statfs usage.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (free_meta < meta_rsv) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 meta_needed =3D meta_r=
sv - free_meta;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int data_factor =3D btrfs_=
bg_type_to_factor(data_profile);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int meta_factor =3D btrfs_=
bg_type_to_factor(
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 btrfs_metadata_alloc_profile(fs_info));
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (data_avail < meta_need=
ed * meta_factor / data_factor)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 da=
ta_avail =3D 0;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 da=
ta_avail -=3D meta_needed * meta_factor / data_factor;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -
>> -=C2=A0=C2=A0=C2=A0 kfree(devices_info);
>> -=C2=A0=C2=A0=C2=A0 *free_bytes =3D avail_space;
>> -=C2=A0=C2=A0=C2=A0 return 0;
>> +=C2=A0=C2=A0=C2=A0 return data_avail;
>> =C2=A0 }
>> =C2=A0 =C2=A0 /*
>> @@ -2033,8 +1968,6 @@ static int btrfs_statfs(struct dentry *dentry,
>> struct kstatfs *buf)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __be32 *fsid =3D (__be32 *)fs_info->fs_=
devices->fsid;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned factor =3D 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_block_rsv *block_rsv =3D &=
fs_info->global_block_rsv;
>> -=C2=A0=C2=A0=C2=A0 int ret;
>> -=C2=A0=C2=A0=C2=A0 u64 thresh =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int mixed =3D 0;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rcu_read_lock();
>> @@ -2082,31 +2015,10 @@ static int btrfs_statfs(struct dentry *dentry,=

>> struct kstatfs *buf)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buf->f_bfree =3D=
 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&block_rsv->lock);
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 buf->f_bavail =3D div_u64(total_free_data, =
factor);
>> -=C2=A0=C2=A0=C2=A0 ret =3D btrfs_calc_avail_data_space(fs_info, &tota=
l_free_data);
>> -=C2=A0=C2=A0=C2=A0 if (ret)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> -=C2=A0=C2=A0=C2=A0 buf->f_bavail +=3D div_u64(total_free_data, factor=
);
>> +=C2=A0=C2=A0=C2=A0 buf->f_bavail =3D btrfs_calc_avail_data_space(fs_i=
nfo,
>> total_free_meta);
>> +=C2=A0=C2=A0=C2=A0 if (buf->f_bavail > 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buf->f_bavail +=3D total_f=
ree_data;
>=20
> I'm not sure I understand this, we're only including the free space of
> already allocated data extents _if_ we have free data chunks?=C2=A0 Tha=
t
> doesn't seem right, shouldn't we always have buf->f_bavail =3D
> total_free_data and then we add whatever comes from
> btrfs_calc_avail_data_space()?=C2=A0 Thanks,

Oh, you're right, it should be before the call.

Thanks,
Qu

>=20
> Josef


--HQ1UCTC5Fmgg8Mrg6K4OWXv801tRrhZmx--

--nQ7nWqWRdSeZqievGDOZTuFdec9P533b4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4V6cYACgkQwj2R86El
/qjwgAf+PwLRIHs4aieA9JHqzkknNI8X9c+kyYl1qBfntk8u+QeFN3V+cu2DhMtH
FLXvzyZm4g9gOXOMRo9XrbPNVFTlU9ODMEC2mF+rWnkhCR2cSZGPCfRQtqWJ/Zoi
uPQBqSxr/fXfUIwibaPdeUbkFfl7wyy3icdNB3tIGyqwgrtir4nl04M8Hf8k6OaR
IcUz38BCSu5QpBwGrFGr8SJXn8mUInSk313VzJjR1afstFRdzR+bILI8MZIgXKk/
oo3VDMo/UMBSdI55GNKXhBMY0fKre0k7EiNitXXEMS/qPR3rhd09U47AyFW+4Luc
vMxFtZKYhJXHN7Ae8xXWgd9tPGrvaA==
=q9sU
-----END PGP SIGNATURE-----

--nQ7nWqWRdSeZqievGDOZTuFdec9P533b4--
