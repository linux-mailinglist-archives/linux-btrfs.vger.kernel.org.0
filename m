Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 851D310221E
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 11:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbfKSKbM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 05:31:12 -0500
Received: from mout.gmx.net ([212.227.17.21]:37895 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfKSKbM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 05:31:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574159394;
        bh=Hl4Sv2QPPasWuAIJYFYqtfvQYXee53Wm4L9hnVOiu/I=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ijfzPWIK3d3aNEocQGhkGNDaqYdHtXNa+rNFQjg4GGz/q1knyGiERJE8OsCy+8Kfi
         l4JIof7B4Qa1RPnEVbZukoqw3peONmiV80HJUs14d9AO0oMAnkITibiHiTETCij4rx
         JXgiB5Mf890VeLszmihgOLOZ7MrOG7PfI7hswhmw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtOGU-1hilX40V1K-00upzY; Tue, 19
 Nov 2019 11:29:54 +0100
Subject: Re: [PATCH 2/3] btrfs: volumes: Add btrfs_fs_devices::missing_list to
 collect missing devices
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191107062710.67964-1-wqu@suse.com>
 <20191107062710.67964-3-wqu@suse.com>
 <cf9c85fd-4d9f-43be-049c-a5694c0a25e1@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <0d4d78eb-eede-98c0-109a-c731ddffb5d7@gmx.com>
Date:   Tue, 19 Nov 2019 18:29:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <cf9c85fd-4d9f-43be-049c-a5694c0a25e1@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yzR53Z2cUYEFD8KVIyZZeGKYmghYwL1Ft"
X-Provags-ID: V03:K1:kCoSQmYM9WNRq40vTSibz1STnR6/nwgl44yHx3L6FzOr6EmL08N
 M3Fv0E01YeqhthT2F7AwiBEa6BqEKcdQpzGLfxHcheUfE3vNZ91aZUMZh6mCB1/DS93SXfV
 yZVZ33fKrF3e0P96U1ptGilp605TObUA6QDmq5gxa+m5lpz0n3qJlYpRNSs5/+gSdU0BXGT
 r4zDdN7fr5CUrIH6Oboew==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1tgLoTPES3s=:+ZozRw8ehrtGM2r38JuuHU
 qlr2SRGvkiqblDjKyTX6nVX1zgK9VuW0YwzpibSwk0xE0irBbq5VGNFFEmE+SE8ua5mFpN++2
 1GOG+ZD6MhcrDhz/KsjAFyHqDX4SvmlDyctI0Zo4NC8AmTKnKRwqdFOhz9++//kdWrtjicGZT
 duY4GAW2NnlKKyDsnVEX5neBtk6Q58gTOJCgfhqnDXdjF5ke94TLvZ5gQ1OKZAkkss+LMAylk
 yWuZv6pu8++6pIhsrSCmaE+i/vn7OZFyurnQdtZZ+Q2mBgb/XN7T7v/j56Zhc4s08sVHjsdnq
 pqHSOg12/rfZQ9SCCX/yXqB2vwHmLdUTQws+I5HaTSaOnbEe+28yfHNF+JE6TAXC1EPKVcQJr
 eoiSN7oV76OHamtJgAZ48NaaLUSRabnikqdVVhroyRDWAwWMcLvP9H6UEUmhofdh9b0Iu3RAm
 ly7xOF+1uOKZUSFnMcJpTb9NuRvm+BzK3EbWd36orpL1Uq31JDFyfPKI3rjgzJUV4ii6qw/Kj
 0JdZQrTqx6yiIwdscR4lmmAzeEt4XReLdHXxPIagt/Nknys3gGv3mVLmLnmQO9dE0/Sns/Daj
 emDp8qby/sicM7h5hfeypb7bTms6PWALlORpRnuyzQEm2b3WdMxP1fTZPE7Nxhk4riN7mTYAd
 zsU1ZilOCiubZOpOnJYVPsF6CcV+Pb6/vegPFxHEu5UjjF7GYC4PQVksNE3RRdnPd0WH6wOfH
 pbncku9lURJhRP45+OLsl8jDsIRQc9u14iOpWdNRaM1XglhD2vF69DcJfRYMdRQGF0r2HKVbo
 pReOYRjtYV628Sr4jKSS5IYQSGR/uti4z/U9WTMfiIgRf04b5p0gU+qiWZpnv9KnGCb/LQxOS
 iWrBJ+Fb7TBeFQh2zG0Zo4g7LxJhmbPv3eNChqyMhYXS/ECBQAfyEUkTrzaU9S6fPIB6KAIPV
 Eu/DMFr9/+S5NJve64Vir53C5mbU+M+0bNGwQfr6IJV4ye2v/ZnxbMdAo9ui4KGAsKVCj/SFq
 Pz+utm+uc1sPa6n+uqR+Fce8Ck9F3HbGlHMbLCCJYy/soOo7ijc0C2qc+6TvQ3mzZNaxKXph4
 ouQxrzfbFzjFC5P5i9/e5LHxDcJDYN5Tlo/ZmNdPfvO/PiDk9l6pXfJpt5lr/x+EeDUCl7rxc
 7DLvyNr7dvrKImoqxwsmVMQJNy37fiINgAp8zyWY1f0CFD3LUnieIS7zcdkYo96dj7/E7xiKY
 AAfEuFgw48KZG6naQ5XBFiJ42BlWodQZwR1KPd0bKdJH7R2pXiSNZI4kHlZ0=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yzR53Z2cUYEFD8KVIyZZeGKYmghYwL1Ft
Content-Type: multipart/mixed; boundary="9uKzkWvVZO6wJLL1v9Q8FQ2fFg5e849Tp"

--9uKzkWvVZO6wJLL1v9Q8FQ2fFg5e849Tp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/19 =E4=B8=8B=E5=8D=886:03, Anand Jain wrote:
> On 11/7/19 2:27 PM, Qu Wenruo wrote:
>> This enables btrfs to iterate missing devices separately, without
>> iterating all fs_devices.
>=20
> =C2=A0IMO.
> =C2=A0We don't need another list to maintain the missing device. We alr=
eady
> =C2=A0have good enough device lists.
> =C2=A0The way its been implemented is
> =C2=A0Allo_list is the only list from which we shall alloc the chunks.
> =C2=A0Missing is a state of the device.
> =C2=A0A device in the alloc list can be in the Missing state.

That would cause problem, especially when you only want to use missing
device as last resort method.

IIRC it's you mentioned this is a problem in my original design (which
put all missing deviecs into alloc_list). Or it's David?

>=20
> =C2=A0If there is missing_list that means the device in the missing lis=
t
> =C2=A0is also possible candidate for the alloc that's messy.

But when you want to avoid missing device, alloc_list and missing_list
makes sense.

E.g. 6 devices RAID5, with one missing device, we should *avoid* using
missing devices as we have enough (5) devices to allocate from.

> =C2=A0Also its not typical to have a larger number of missing devices
> =C2=A0to constitute its own list.

That's just for now.

If we're going to allow RAID10 to lost half of its devices, then it
would be a problem.

Thanks,
Qu

>=20
> Thanks, Anand
>=20
>=20
>> This provides the basis for later degraded chunk enhancement.
>>
>> The change includes:
>> - Add missing devices to btrfs_fs_devices::missing_list
>> =C2=A0=C2=A0 This happens at add_missing_dev() and other locations whe=
re
>> =C2=A0=C2=A0 missing_devices get increased.
>>
>> - Remove missing devices from btrfs_fs_devices::missing_list
>> =C2=A0=C2=A0 This needs to cover all locations where missing_devices g=
et decreased.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 fs/btrfs/volumes.c | 27 +++++++++++++++++++++------
>> =C2=A0 fs/btrfs/volumes.h |=C2=A0 6 ++++++
>> =C2=A0 2 files changed, 27 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index eee5fc1d11f0..a462d8de5d2a 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -324,6 +324,7 @@ static struct btrfs_fs_devices
>> *alloc_fs_devices(const u8 *fsid,
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_LIST_HEAD(&fs_devs->devices=
);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_LIST_HEAD(&fs_devs->alloc_list);
>> +=C2=A0=C2=A0=C2=A0 INIT_LIST_HEAD(&fs_devs->missing_list);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_LIST_HEAD(&fs_devs->fs_list);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (fsid)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(fs_devs-=
>fsid, fsid, BTRFS_FSID_SIZE);
>> @@ -1089,6 +1090,7 @@ static noinline struct btrfs_device
>> *device_list_add(const char *path,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (test_bit(BT=
RFS_DEV_STATE_MISSING, &device->dev_state)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 fs_devices->missing_devices--;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 clear_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 li=
st_del_init(&device->dev_alloc_list);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 @@ -1250,11 +1252,10 @@ static void btrfs_close_one_device(stru=
ct
>> btrfs_device *device)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (device->bdev)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_devices->ope=
n_devices--;
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 list_del_init(&device->dev_alloc_list);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (test_bit(BTRFS_DEV_STATE_WRITEABLE,=
 &device->dev_state) &&
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device->devid !=3D BTRFS_D=
EV_REPLACE_DEVID) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_del_init(&device->dev=
_alloc_list);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device->devid !=3D BTRFS_D=
EV_REPLACE_DEVID)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_devices->rw_=
devices--;
>> -=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (test_bit(BTRFS_DEV_STATE_MIS=
SING, &device->dev_state))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_devices->mis=
sing_devices--;
>> @@ -2140,6 +2141,12 @@ int btrfs_rm_device(struct btrfs_fs_info
>> *fs_info, const char *device_path,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device->fs_devi=
ces->rw_devices--;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&f=
s_info->chunk_mutex);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev=
_state)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&fs_info->chunk=
_mutex);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_del_init(&device->dev=
_alloc_list);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device->fs_devices->missin=
g_devices--;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&fs_info->chu=
nk_mutex);
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&uuid_mutex);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_shrink_device(device, 0);=

>> @@ -2184,9 +2191,6 @@ int btrfs_rm_device(struct btrfs_fs_info
>> *fs_info, const char *device_path,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cur_devices !=3D fs_devices)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_devices->tot=
al_devices--;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (test_bit(BTRFS_DEV_STATE_MISSING, &devi=
ce->dev_state))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur_devices->missing_devic=
es--;
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_assign_next_active_device(device,=
 NULL);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (device->bdev) {
>> @@ -2236,6 +2240,13 @@ int btrfs_rm_device(struct btrfs_fs_info
>> *fs_info, const char *device_path,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device->fs_devi=
ces->rw_devices++;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&f=
s_info->chunk_mutex);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev=
_state)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&fs_info->chunk=
_mutex);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_add(&device->dev_allo=
c_list,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 &fs_devices->missing_list);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device->fs_devices->missin=
g_devices++;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&fs_info->chu=
nk_mutex);
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>> =C2=A0 }
>> =C2=A0 @@ -2438,6 +2449,7 @@ static int btrfs_prepare_sprout(struct
>> btrfs_fs_info *fs_info)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seed_devices->opened =3D 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_LIST_HEAD(&seed_devices->devices);=

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_LIST_HEAD(&seed_devices->alloc_lis=
t);
>> +=C2=A0=C2=A0=C2=A0 INIT_LIST_HEAD(&seed_devices->missing_list);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_init(&seed_devices->device_list_m=
utex);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&fs_devices->device_l=
ist_mutex);
>> @@ -6640,6 +6652,7 @@ static struct btrfs_device
>> *add_missing_dev(struct btrfs_fs_devices *fs_devices,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_devices->num_devices++;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_bit(BTRFS_DEV_STATE_MISSING,=
 &device->dev_state);
>> +=C2=A0=C2=A0=C2=A0 list_add(&device->dev_alloc_list, &fs_devices->mis=
sing_list);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_devices->missing_devices++;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return device;
>> @@ -6979,6 +6992,7 @@ static int read_one_dev(struct extent_buffer *le=
af,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 device->fs_devices->missing_devices++;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 set_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 li=
st_add(&device->dev_alloc_list,
>> &fs_devices->missing_list);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Move =
the device to its own fs_devices */
>> @@ -6992,6 +7006,7 @@ static int read_one_dev(struct extent_buffer *le=
af,
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 device->fs_devices->missing_devices--;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 fs_devices->missing_devices++;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 li=
st_move(&device->dev_alloc_list,
>> &fs_devices->missing_list);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 device->fs_devices =3D fs_devices;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>> index a7da1f3e3627..9cef4dc4b5be 100644
>> --- a/fs/btrfs/volumes.h
>> +++ b/fs/btrfs/volumes.h
>> @@ -253,6 +253,12 @@ struct btrfs_fs_devices {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head alloc_list;
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Devices which can't be found. Projected by=
 chunk_mutex.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * This acts as a fallback allocation list fo=
r certain degraded
>> mount.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 struct list_head missing_list;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_fs_devices *seed;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int seeding;
>> =C2=A0
>=20


--9uKzkWvVZO6wJLL1v9Q8FQ2fFg5e849Tp--

--yzR53Z2cUYEFD8KVIyZZeGKYmghYwL1Ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3TxBsXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qgJIAgAg2uqN6ykW9a1b21vOOHasHGi
dpFrV5yQJlpAWIcw4RzZunl4vtt2MfKtOL6xkRasBjnTruQjjpkafstsvq0EUq2J
bG1r+Ulbq7pH2ZSsT1RzpsDEgXTOS6Ec1JNKdSyMdbuErX+fa/GLnydpR16aCqcc
3Ov5nxywB2rmxaRmCscopvyo0nALEwmVk1WubGlaEvRNs1EzOxoJzXWuwARCc95N
IoEl2ngoy5bu0jplqmXyniyGdJvfeL/le4d11E8Ur2Ap38mMVyHWwUAmQ4ABl0Wt
uGKaiceyTTajPn/EclLxfUnmueAUH5w17JgzdolZusflM45SDeJk3wGX8wHeWg==
=xWr0
-----END PGP SIGNATURE-----

--yzR53Z2cUYEFD8KVIyZZeGKYmghYwL1Ft--
