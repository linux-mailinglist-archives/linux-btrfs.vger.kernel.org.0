Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3198B101AE3
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 09:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKSIFD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 03:05:03 -0500
Received: from mout.gmx.net ([212.227.17.22]:46461 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfKSIFC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 03:05:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574150611;
        bh=rIAOABse8RZlO7YBjseOBA3w0jet4XyPISmekqJkKqI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ESBS5+VIeJHY9iMjGpyBCj6nz2oDrLOObGKqf1l53cuPVKYfsO3xXwTMgGU/sSwHO
         A9pXNJovtmnU8X6heYmAiEMh7YdFiB9OuCRpE/8+3t5AYgud9NOEWLyHCs3/LwPKj6
         FMK4/qkAIEn/6sQKluHHWsEDbc1eEbWvDxwRhWYA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MIdeX-1icBYF3MCD-00EeFO; Tue, 19
 Nov 2019 09:03:31 +0100
Subject: Re: [PATCH] btrfs: resize: Allow user to shrink missing device
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Nathan Dehnel <ncdehnel@gmail.com>
References: <20191118070525.62844-1-wqu@suse.com>
 <18e6af7c-a9b0-9a9d-f91b-ade078c6b2c1@oracle.com>
 <a7dedb8c-f80c-8abb-8332-cbbc681e7a49@gmx.com>
 <9f35f91d-802f-9c93-11f5-fbdffe583a88@oracle.com>
 <70fe275c-5473-771d-3d3d-6aa8dbb94c39@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <0cf3963d-fe64-577b-95a7-b11777a91419@gmx.com>
Date:   Tue, 19 Nov 2019 16:03:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <70fe275c-5473-771d-3d3d-6aa8dbb94c39@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OE1XxWUOlMiEe1xRjx95ollizYntt4gT2"
X-Provags-ID: V03:K1:jAy/tI5yTrvQllLusJsHLUIPug2BVlZ5cGyNAWfgpLjS27Luah+
 ilECt4gUz8YHHYbCu1G5wboQHyNUFBFhRCPYHG4QNTEps6CPJ4++G3H1UKrFBbRUnzigHlr
 CjQ3g6qEcW/uLyCRbJ86RLDQqD8XGJAnlC6slcCTaFbJrefoNgIqf3YO117vdzRB84L0DxH
 aOdfqtrAZ8O1Ohp8tZuxA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:r7TNdukBTTA=:UrYPcYUPimbNgL3oQmyXsE
 y3f5zir6iRyV9Vvb6UDpAysZ94REBON7aBNw/ZbBrKU0/RpQXGDm5j04TnX6VByWuc1HPBbiz
 DC0p2ceQbNIqp3/u5SLFNRr36YlTnEYP8j1ewHYUbPUMO4WOvCqYNuRJP5buRfw8CfV94mep7
 mKLaW5dFePj4s0xkMKudV3AfqpXsvhz+pH5CoXcQW2DI7K1RcRVUIbQNCj+q30YX6IrxeFX7J
 SfxBZnm3MwPtobmZ+6u4AzOTg3xhQTtyANL/9t0o1Cinix/ELwu7nMwznt4NaJcOAgYpc9IS9
 HWRAIxI2ein7JhFBMehygsphNzhB2aZcOvOTR0ddoOzaK7dFtIWtysGKX9A+SuEL29qUG298d
 nsfj34BdI9AadcM2HEekqD0T7w/8kwKmdmq795JKBpsu+c0aJguiZBcZIg0ddFFrHbesbIXnx
 CmW3HkxbnAKWE9HO/rZMYeMxIJyPv15m9GbAyRFZZLXmRxhRBODePwHlM/plPnP+y4jwYARGE
 csDSfnbkQkk6cw7ivEect5Sp3s4U7+MonMj9xiNWaSr3VKsw3kB0ZnCDwU7CF8gv5KBJ8ZSQp
 cyUKLIZyNBAxMBeo+nGrlVpeNpUW10EMFxzZDR6TR2wyJy1yzkwUszo3WDGbG0I92j14kETPK
 d2F/NA1FfQzaDy6Wtm4zt4BZRsG5W+qEZC4Wr32SRjl5W2Dtk2anvvW3jfZy7pGzOvR95Lym7
 BT0eem34D8bBTrJ5e3OsvLR4i9C5khxwE9RNlVHJUTXzehq+azjoHqwEFgrR8P2p397oIp1Ej
 ype6+0YvnDvDt8dHChr0xO0GoHAZya2fRCtDI9WiDJDFA8vwr6B/RpPfkQ41VxqdkkVZb7B5/
 oGZWnmZt78oXF/LfSVi7rJmYr/FkpUOKFKFH/l5VF1QxgAcIkTDijajBcltOjO+sAR+Amt2PS
 TDMaCYszb9wM3pBecA3370+GvgjGYKoKPIGwzaAbm9BrqVm7N0aaQi4sxojdF3FzzBKyIDgJx
 Ws2WX0N1CUhetVF5Mr/fOvJE2L1s434nWeFPuZR0khQSVKK45bzO6TTZwcNtvUk8/TYHe8R7X
 F76ijRTkVuRBan+xuzFArwgybc3vJg5XQavvaBtylbnyGHEKllCg5zIBVDWzfcOfQPI+5dyxH
 PuvHHi8mAgxO+hP0jOC6M3S0LHDIRKRDQmj9fMibzfKNrN88w0fDb+rUD3wImA3ySrjSL3pss
 Evzid/Qa/PVZydNSrbBz+VqcHta3cKaU7M4VBq+nItkfBGwYGERsbAXmslto=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OE1XxWUOlMiEe1xRjx95ollizYntt4gT2
Content-Type: multipart/mixed; boundary="QSCjqLBY8yTcecS7d8PHyamqZdAxjB02R"

--QSCjqLBY8yTcecS7d8PHyamqZdAxjB02R
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/19 =E4=B8=8B=E5=8D=883:54, Qu Wenruo wrote:
>=20
>=20
> On 2019/11/19 =E4=B8=8B=E5=8D=883:40, Anand Jain wrote:
>>
>>
>> On 11/18/19 8:02 PM, Qu Wenruo wrote:
>>>
>>>
>>> On 2019/11/18 =E4=B8=8B=E5=8D=887:38, Anand Jain wrote:
>>>> On 18/11/19 3:05 PM, Qu Wenruo wrote:
>>>>> One user reported an use case where one device can't be replaced du=
e to
>>>>> tiny device size difference.
>>>>>
>>>>> Since it's a RAID10 fs, if we go regular "remove missing" it can ta=
ke a
>>>>> long time and even not be possible due to lack of space.
>>>>>
>>>>> So here we work around this situation by allowing user to shrink
>>>>> missing
>>>>> device.
>>>>> Then user can go shrink the device first, then replace it.
>>>>
>>>>
>>>> =C2=A0=C2=A0Why not introduce --resize option in the replace command=
=2E
>>>> =C2=A0=C2=A0Which shall allow replace command to resize the source-d=
evice
>>>> =C2=A0=C2=A0to the size of the replace target-device.
>>>
>>> Nope, it won't work for degraded mount.
>>
>> =C2=A0Umm.. Why?
>=20
> Try it.
>=20
> Mount a raid1 fs with missing devices, degraded,
> And then, try to resize the missing device, without this patch.
>=20
> I should have made this point pretty clear in both the title and the
> commit message.
>=20
> Thanks,
> Qu
>=20

And just in case you didn't get the point again why this is important,
search the reporter's name in the mail list and check the thread.

And just in case you can't find it:
https://www.spinics.net/lists/linux-btrfs/msg94533.html

>>
>> =C2=A0(IMHO reasoning adds clarity to the technical discussions. my 1c=
).
>>
>>> That's the root problem the patch is going to solve.
>>
>> =C2=A0IMO this patch does not the solve the root of the problem and it=
s
>> =C2=A0approach is wrong.
>>
>> =C2=A0The core problem as I see - currently we are determining the req=
uired
>> =C2=A0size for the replace-target by means of source-disk size, instea=
d it
>> =C2=A0should be calculated by the source-disk space consumption.
>> =C2=A0Also warn if target is smaller than source and fail if target is=

>> =C2=A0smaller than the consumption by the source-disk.
>>
>> =C2=A0IMO changing the size of the missing device is point less. What =
if
>> =C2=A0in between the resize and replace the missing device reappears
>> =C2=A0in the following unmount and mount.
>>
>> Thanks, Anand
>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> Thanks, Anand
>>>>
>>>>> Reported-by: Nathan Dehnel <ncdehnel@gmail.com>
>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>> ---
>>>>> =C2=A0=C2=A0 fs/btrfs/ioctl.c | 29 +++++++++++++++++++++++++----
>>>>> =C2=A0=C2=A0 1 file changed, 25 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>>>> index de730e56d3f5..ebd2f40aca6f 100644
>>>>> --- a/fs/btrfs/ioctl.c
>>>>> +++ b/fs/btrfs/ioctl.c
>>>>> @@ -1604,6 +1604,7 @@ static noinline int btrfs_ioctl_resize(struct=

>>>>> file *file,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *sizestr;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *retptr;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *devstr =3D NULL;
>>>>> +=C2=A0=C2=A0=C2=A0 bool missing;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int mod =3D 0;
>>>>> =C2=A0=C2=A0 @@ -1651,7 +1652,10 @@ static noinline int btrfs_ioctl=
_resize(struct
>>>>> file *file,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto o=
ut_free;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0 if (!test_bit(BTRFS_DEV_STATE_WRIT=
EABLE, &device->dev_state)) {
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 missing =3D test_bit(BTRFS_DEV_STATE_MISSING, &=
device->dev_state);
>>>>> +=C2=A0=C2=A0=C2=A0 if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &devic=
e->dev_state) &&
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !missing) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_=
info(fs_info,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "resizer unable to apply on readonly de=
vice %llu",
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid);
>>>>> @@ -1659,13 +1663,24 @@ static noinline int btrfs_ioctl_resize(stru=
ct
>>>>> file *file,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto o=
ut_free;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0 if (!strcmp(sizestr, "max"))
>>>>> +=C2=A0=C2=A0=C2=A0 if (!strcmp(sizestr, "max")) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (missing) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 btrfs_info(fs_info,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "'max' can't be used for missing device %llu",
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ret =3D -EPERM;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 goto out_free;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new_si=
ze =3D device->bdev->bd_inode->i_size;
>>>>> -=C2=A0=C2=A0=C2=A0 else {
>>>>> +=C2=A0=C2=A0=C2=A0 } else {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (si=
zestr[0] =3D=3D '-') {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 mod =3D -1;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sizestr++;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else=
 if (sizestr[0] =3D=3D '+') {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 if (missing)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_info(fs_info,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "'+size' can't be used for missing device %llu",=

>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid)=
;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 mod =3D 1;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sizestr++;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> @@ -1694,6 +1709,12 @@ static noinline int btrfs_ioctl_resize(struc=
t
>>>>> file *file,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ret =3D -ERANGE;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 goto out_free;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (missing) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ret =3D -EINVAL;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 btrfs_info(fs_info,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "can not increase device size for missing device %llu",
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new_si=
ze =3D old_size + new_size;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0 @@ -1701,7 +1722,7 @@ static noinline int btrfs_ioctl_=
resize(struct
>>>>> file *file,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D=
 -EINVAL;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto o=
ut_free;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> -=C2=A0=C2=A0=C2=A0 if (new_size > device->bdev->bd_inode->i_size) =
{
>>>>> +=C2=A0=C2=A0=C2=A0 if (!missing && new_size > device->bdev->bd_ino=
de->i_size) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D=
 -EFBIG;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto o=
ut_free;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>
>>>>
>>>
>=20


--QSCjqLBY8yTcecS7d8PHyamqZdAxjB02R--

--OE1XxWUOlMiEe1xRjx95ollizYntt4gT2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3TockXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qhFmwf/fq6xxEgl3UKiVXwTrKm2y5b/
KIyesmuPVm+s14Cbrfuilu233ovKv5ydVAmq5z/6cXvTvTqoBTEzEZw8qQQ4B5DP
l/67EiRR5dz7BC5EDN6EAoY3J5IhSqpZ7XZiSiG0pJd1G9/rWLc+FrJcB/XUjnDS
VmXEYjvRrzPS58OA0owOjEtI0uwKbYLyaIK4RVfL/8YTw9/st4wnjQL94T/v3y1K
F/KAyXe3DwSdMUZr4oiNh6WhRw4ZFNKROsCtAl9iOIRk82t2kfUrGomCgTlGBIIs
+CdZ3jrEzQ/aXdKzekm3cvdsYw8MbHY2Wo9IlmjFRRyuVLBexQkEr/CwuaudUQ==
=sOHs
-----END PGP SIGNATURE-----

--OE1XxWUOlMiEe1xRjx95ollizYntt4gT2--
