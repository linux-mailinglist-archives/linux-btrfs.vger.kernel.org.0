Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5123101A8F
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 08:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfKSH4S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 02:56:18 -0500
Received: from mout.gmx.net ([212.227.17.21]:44827 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbfKSH4S (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 02:56:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574150089;
        bh=D0w9pVq41jTnX4aghFdHeFin1Ees2Qhw0uy5zekvjsQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZI4yV0hGtEWgKA0yjbnBziIU4jEVjiYt/F414qeb/nMJvbPhTxln8hVVO78P8UUXz
         Ruuig4ECleWLumZ0zPi0meNT+cYBydgpmWKvUtINz6OaBszCrBOoM9ps33ns0dGWYB
         yUrmauJBRCS28fxJ2c5T462WFJRpUYQhzVYnobxg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6KYb-1hmRFJ1EW9-016bqr; Tue, 19
 Nov 2019 08:54:49 +0100
Subject: Re: [PATCH] btrfs: resize: Allow user to shrink missing device
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Nathan Dehnel <ncdehnel@gmail.com>
References: <20191118070525.62844-1-wqu@suse.com>
 <18e6af7c-a9b0-9a9d-f91b-ade078c6b2c1@oracle.com>
 <a7dedb8c-f80c-8abb-8332-cbbc681e7a49@gmx.com>
 <9f35f91d-802f-9c93-11f5-fbdffe583a88@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <70fe275c-5473-771d-3d3d-6aa8dbb94c39@gmx.com>
Date:   Tue, 19 Nov 2019 15:54:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <9f35f91d-802f-9c93-11f5-fbdffe583a88@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nhzlQJW2jRfEe34fB32blqpUpBmPHiYMO"
X-Provags-ID: V03:K1:c+HbifU6Pprict+O2vi5ZKztIMtbqM3y4SDFT9flLXfWi5z/gGY
 9gkCg21gudDrJ+yn1sIHXE9rUHQBu0MetKvrVVvrmP21EzJKWr3cZo696+fmFtwVTNaH2Ln
 UoUraGRP5wIMeAyxVS6MZk/ZGU7M+v1uv7TEvVM0fPlQuMiLNBrbhtdWmlMzDEz+luuVJ9I
 ufAkoVuZJa5WyJ7/QzCwQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bgwueSjHv5k=:l5I6uC8/XBZtDYhblJO+UJ
 6eB7HXvdDmg9A4jMxJnJ3tXqjmUZ26NwczBOdREX7SVXz+746/e1S4Vf8PsfX1bZlDrMcQ3nP
 PuObzwrQ9FpZInn6ui0z8ESgk+37rm2PhPTZYDCC7fSwGe0Y/+DTj7nBwDGMli+2/MxJWJHRd
 nnonutgJI5A6Iw5fe7y7DgPB+EJLl4arFjtNxle9/or3ZCRwOY7eYUa6f2Qe6gwzai9EI+bj/
 EIomevCIhBqNahUdrp5cbjTllAFMqPlxJQ/jHufeI6xiaVGjGbcONv6QSzrdbxojkJW38jdeB
 sjAknXt3n1qbGlqJILrK5ZeCHMN4wwOKP/3EwKWQaDkxOaZ9nYvZ0aVuHoC8K4KwWmxTMxJmj
 QrrzxlRfqP6h7dzsjRZ33CYMAdlz2iZeHL+/0LdHqx54oqiwyDGezSUxQ2/42mQbOpFUP3ocC
 bk1jn9SVc7ayE76ZAV1338wm8MktG5S+ErBdXCLFBoI0ygAVWwvqCdY0YLVY4d2zzj7zEhd6Z
 pxjhhLuS3eY1hGi862LHblOFvlW9mjqb+4f/+jMgOh6KhBpNTE0MfAt7h0rBitIhCls7hTJiD
 KCqk40+wWFPD/xRgz7a64QGa272u9QdUHf/udHE+KID1l5I7OfQ50tapLW+KDAL4wfo0EEajJ
 A+g9MzKFr10HuDa4CoXBGqYo2femofIc6an+h1ETN4h9DDDo+idcl6EJrrCwdHcVyXIqkVkRk
 +hTM2v695aaN2Km4eLA1vLI/rxw9SpyHwp00GWpjyNyv30nr9edy82cg1EuRfP1kGiSVD0T7v
 vNsLjSQy2jm4NLVLSWEk7p3ysk+3763b6mws9VaQzdvN/qWPY0uQ5YSIk94pbSkKXL/ODJEYJ
 K+bwI25YblwytBrt7gK0TBLhByGjkzywQEhB0Dx7F0H2l3cJ5S1lKUQP02FKlGw1YWP9yFuhG
 Dki8IJeqU+zXlqXTCOpgWyWTkfHIy4tNdqYTihFYHwOluE+9MsltZpJTJOoue1YXlWpr3Xn0r
 UnmmWypb+tuBGEbuNP4ipjxaSrR60f85PzoYY5oUTx4hwOkCOInMFlRr6m2faMV8WSzD00V0F
 T9gvBaMybqbpShLGpjS1nllbjzjUau+yVHQoA5cCAiSc1XW0JvBG7Z81JO+7xvYMXwoQstTvq
 UT4vrgCIGzIepFhua/RRE0Ld3P/cPmrt6SgDNEO/4rD6SIgu5aN/gRotTFOxzYK7oUlt/GjHr
 mfJxtQYTNfgF9y7emBzMZox60o3fTsNrVzTDP9/5DtBklOgacOb+NdbTywjQ=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nhzlQJW2jRfEe34fB32blqpUpBmPHiYMO
Content-Type: multipart/mixed; boundary="6KFtbsS1JdeCkE7fpIcXcBOru8fSdDOpB"

--6KFtbsS1JdeCkE7fpIcXcBOru8fSdDOpB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/19 =E4=B8=8B=E5=8D=883:40, Anand Jain wrote:
>=20
>=20
> On 11/18/19 8:02 PM, Qu Wenruo wrote:
>>
>>
>> On 2019/11/18 =E4=B8=8B=E5=8D=887:38, Anand Jain wrote:
>>> On 18/11/19 3:05 PM, Qu Wenruo wrote:
>>>> One user reported an use case where one device can't be replaced due=
 to
>>>> tiny device size difference.
>>>>
>>>> Since it's a RAID10 fs, if we go regular "remove missing" it can tak=
e a
>>>> long time and even not be possible due to lack of space.
>>>>
>>>> So here we work around this situation by allowing user to shrink
>>>> missing
>>>> device.
>>>> Then user can go shrink the device first, then replace it.
>>>
>>>
>>> =C2=A0=C2=A0Why not introduce --resize option in the replace command.=

>>> =C2=A0=C2=A0Which shall allow replace command to resize the source-de=
vice
>>> =C2=A0=C2=A0to the size of the replace target-device.
>>
>> Nope, it won't work for degraded mount.
>=20
> =C2=A0Umm.. Why?

Try it.

Mount a raid1 fs with missing devices, degraded,
And then, try to resize the missing device, without this patch.

I should have made this point pretty clear in both the title and the
commit message.

Thanks,
Qu

>=20
> =C2=A0(IMHO reasoning adds clarity to the technical discussions. my 1c)=
=2E
>=20
>> That's the root problem the patch is going to solve.
>=20
> =C2=A0IMO this patch does not the solve the root of the problem and its=

> =C2=A0approach is wrong.
>=20
> =C2=A0The core problem as I see - currently we are determining the requ=
ired
> =C2=A0size for the replace-target by means of source-disk size, instead=
 it
> =C2=A0should be calculated by the source-disk space consumption.
> =C2=A0Also warn if target is smaller than source and fail if target is
> =C2=A0smaller than the consumption by the source-disk.
>=20
> =C2=A0IMO changing the size of the missing device is point less. What i=
f
> =C2=A0in between the resize and replace the missing device reappears
> =C2=A0in the following unmount and mount.
>=20
> Thanks, Anand
>=20
>> Thanks,
>> Qu
>>
>>>
>>> Thanks, Anand
>>>
>>>> Reported-by: Nathan Dehnel <ncdehnel@gmail.com>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>> =C2=A0=C2=A0 fs/btrfs/ioctl.c | 29 +++++++++++++++++++++++++----
>>>> =C2=A0=C2=A0 1 file changed, 25 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>>> index de730e56d3f5..ebd2f40aca6f 100644
>>>> --- a/fs/btrfs/ioctl.c
>>>> +++ b/fs/btrfs/ioctl.c
>>>> @@ -1604,6 +1604,7 @@ static noinline int btrfs_ioctl_resize(struct
>>>> file *file,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *sizestr;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *retptr;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *devstr =3D NULL;
>>>> +=C2=A0=C2=A0=C2=A0 bool missing;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int mod =3D 0;
>>>> =C2=A0=C2=A0 @@ -1651,7 +1652,10 @@ static noinline int btrfs_ioctl_=
resize(struct
>>>> file *file,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto ou=
t_free;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0 if (!test_bit(BTRFS_DEV_STATE_WRITE=
ABLE, &device->dev_state)) {
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 missing =3D test_bit(BTRFS_DEV_STATE_MISSING, &d=
evice->dev_state);
>>>> +=C2=A0=C2=A0=C2=A0 if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device=
->dev_state) &&
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !missing) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_i=
nfo(fs_info,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "resizer unable to apply on readonly de=
vice %llu",
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid);
>>>> @@ -1659,13 +1663,24 @@ static noinline int btrfs_ioctl_resize(struc=
t
>>>> file *file,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto ou=
t_free;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0 if (!strcmp(sizestr, "max"))
>>>> +=C2=A0=C2=A0=C2=A0 if (!strcmp(sizestr, "max")) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (missing) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
btrfs_info(fs_info,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "'max' can't be used for missing device %llu",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
ret =3D -EPERM;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
goto out_free;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new_siz=
e =3D device->bdev->bd_inode->i_size;
>>>> -=C2=A0=C2=A0=C2=A0 else {
>>>> +=C2=A0=C2=A0=C2=A0 } else {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (siz=
estr[0] =3D=3D '-') {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 mod =3D -1;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sizestr++;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else =
if (sizestr[0] =3D=3D '+') {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (missing)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 btrfs_info(fs_info,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "'+size' can't be used for missing device %llu",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 mod =3D 1;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sizestr++;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> @@ -1694,6 +1709,12 @@ static noinline int btrfs_ioctl_resize(struct=

>>>> file *file,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ret =3D -ERANGE;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 goto out_free;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (missing) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
ret =3D -EINVAL;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
btrfs_info(fs_info,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
"can not increase device size for missing device %llu",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new_siz=
e =3D old_size + new_size;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0 @@ -1701,7 +1722,7 @@ static noinline int btrfs_ioctl_r=
esize(struct
>>>> file *file,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D=
 -EINVAL;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto ou=
t_free;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> -=C2=A0=C2=A0=C2=A0 if (new_size > device->bdev->bd_inode->i_size) {=

>>>> +=C2=A0=C2=A0=C2=A0 if (!missing && new_size > device->bdev->bd_inod=
e->i_size) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D=
 -EFBIG;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto ou=
t_free;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>
>>>
>>


--6KFtbsS1JdeCkE7fpIcXcBOru8fSdDOpB--

--nhzlQJW2jRfEe34fB32blqpUpBmPHiYMO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3Tn8MXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qgzpQf/XIyhMfizfggp15OekcceVoVd
QMAShX+Vnf2EViVGlR2Yhd5sR8eliMOklA1SD4SoD2h81hey0nSqTXzI64/wYQ8e
OcN6w+1yT7Mqmu0qkFbGGeE+LTUSSCPNLSIceWA2im5qe9NUq9yo5whIxMIEYvYg
ThCDr01RD4jKVUlVrab/2qjCjWyd6AddP843/5Y9XYW0zfMQJARlu4m1wHSKlkln
Ubbkqi6L8XDK8UlYaqByAHx3ilgUR7Zm/Vbe8UUtN8jTfKyGyF0j4j33K8GRI0Ar
Ld1hffBcilR0FayJIEK9Ed0FRs//acezH9JqlNj/jfn0RG0anq6Ixi+bVrRrQg==
=HCt4
-----END PGP SIGNATURE-----

--nhzlQJW2jRfEe34fB32blqpUpBmPHiYMO--
