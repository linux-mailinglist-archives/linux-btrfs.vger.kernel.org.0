Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37C8A100547
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 13:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfKRMEJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 07:04:09 -0500
Received: from mout.gmx.net ([212.227.15.18]:58995 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfKRMEJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 07:04:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574078565;
        bh=WxTFUiL0d7JcebOXnF7JwAt8SRXBhUspyJV36HkWnJQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AfR61ceoG/H3v9J9aNuYjvFenHchEDq47zmsLPYQSbIrMM3FRoG4mfTmYmzJSLKUn
         IFxACESiymSTwlsPZLavUkzwbDoXd+8no5eBd59AQ0sklYXIfy7ayTOkQZA7gnRC/w
         GGD9EN+EZ29/+FMlKw6JEoZ4GMbAlZOLldi07GMs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MD9T1-1ifmXl1Azx-009Cn7; Mon, 18
 Nov 2019 13:02:45 +0100
Subject: Re: [PATCH] btrfs: resize: Allow user to shrink missing device
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Nathan Dehnel <ncdehnel@gmail.com>
References: <20191118070525.62844-1-wqu@suse.com>
 <18e6af7c-a9b0-9a9d-f91b-ade078c6b2c1@oracle.com>
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
Message-ID: <a7dedb8c-f80c-8abb-8332-cbbc681e7a49@gmx.com>
Date:   Mon, 18 Nov 2019 20:02:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <18e6af7c-a9b0-9a9d-f91b-ade078c6b2c1@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kevFvEOJjbLzRMMX43FDS5ghEoqUabpPs"
X-Provags-ID: V03:K1:qhIB6e/daoN7f7aMxi3XGMUaMbKMPof8Ho4/T/LRyYwfFPhkopB
 bEy/zXUZqkIf11v34i2P2VtMpvluDzJhXJLd8/jvUgFfjk+2RsxXCq8CThNTNzQ92htLAGD
 TI9qV9swFUghFp20mJLt4gqjdfH8bdaRDJWylBehQI4MTkKM5OnsiJGXLmD34cZMtydFtnc
 iu3mrv3FMqLN1W/hYQtyA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:I9WstczLJYE=:PIivvrna064YnFUJEX2ekN
 yMOIof1h1rDcvb9NHTY+6eVGjBq1p1wDDi3rcZ53xTIREhGkXaS1t64ZrKNaTkBgjBIFpzPKF
 CQ3rcXxLkJRmb4CWeo84xyTk3T0+yYJR9cvlDarhBJvQcOevPxCE69fSUIkbftGhc+yJf4s6P
 RXNp4UZovAEoE46nzLnbJb1jppkEU9RXIgHD9M2Jw3+Vl13Dwgy/dIcbQbYDiORjLyI1Sz9Or
 v3OySMMr1+RIKD8lxCvatmgBxVAYwWhhbii1xnbpPWJouUsGhd8U2vbCqxII6v82Lisr2lO8f
 3lyrVkqI02kjGFuYKMsqNey3wQQzpMN5v5QpUJ/GU9TayA/ZzrPqfqtbJtYlEnye7z5WOysk/
 aD/sobVChHLw95Kk872+C9F+XUovxgCGS9pZjgjGvR0R2br8RlkiapufztFPAfsWEprwFxGHW
 pt7tqdwnhWsBs6moS3Jx9+YNDAp7zFfa3SbxoBCGmXW5vgHlNsM+U155JCpBVHHZIGq6QOYsN
 Ju2YHVJS3mewR37vDhBYTvfSv9zuhORsFPQSp15D5cdAp/ql8VyHdixzZy7q5pJPQMLYlBS43
 K6z0WKTUwGQg1d93DGVAec+R3eFSW5TeFTE35ZjcmPhwxyh/CikR7HfUOwgTrf6yoYrND5aVA
 vgKsFAfbPzBBqEHuFj/yY1AJB3bawR858IIg/V9Bh9dd9ElwMDLwqt9yv+su74/totnFK1WgD
 URn8gUQOgYtJxzxC04tTJp89VH941UvlDeJmXDi58/qOeWxqFLi80v8r8Eyy7rNmoSbDOxkbX
 Z2vqei/liqKMOjckwGMsG0ZYFdedbgSKsZlx9kc7L+qabzaQSPjWGTpg4PTOoaX1sW5bAHYli
 34x1NN9VAi1ytDA7GZcW+IWG/ycOlRu8w0B2bxWxTxlGEHSu2JEpJfMhUqPuNS6QifmOUtK3u
 74v4/9PQJqd4TPlYAanCUiYNJK2yrdHj6bb8ijTFGygESxcjY+ZX1j+zYleK80qgQlQFsPHrg
 HR8uK8tDebx5rvc3OhADR1TDpkd4nLkQpxvSugZmOMZ0gBfdxtfLc5KKclQorqvjeXDVAE6TC
 kLCKXz5qnIzb92jWjiArv0FWuQqbbrJLv3F4I28wC4G0dmxrc3nDUsnSk7K1O/ZrjvkEgZChC
 VfHoBjD8LfKd9vv8lyfKwn5cBWM+3kqxOGu2xlx1pTqVoqIQWCIAILRfjCka2pNXsBrfEoxFO
 ACTcIP0XRUoL99KehANMW8PxY2KBW0XCWPWdfzYq6TtLgJ0/7SWicXfG0LL0=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kevFvEOJjbLzRMMX43FDS5ghEoqUabpPs
Content-Type: multipart/mixed; boundary="nN4L3Q4T9lTKx2JtQxIyb07m5DcOdgU11"

--nN4L3Q4T9lTKx2JtQxIyb07m5DcOdgU11
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/18 =E4=B8=8B=E5=8D=887:38, Anand Jain wrote:
> On 18/11/19 3:05 PM, Qu Wenruo wrote:
>> One user reported an use case where one device can't be replaced due t=
o
>> tiny device size difference.
>>
>> Since it's a RAID10 fs, if we go regular "remove missing" it can take =
a
>> long time and even not be possible due to lack of space.
>>
>> So here we work around this situation by allowing user to shrink missi=
ng
>> device.
>> Then user can go shrink the device first, then replace it.
>=20
>=20
> =C2=A0Why not introduce --resize option in the replace command.
> =C2=A0Which shall allow replace command to resize the source-device
> =C2=A0to the size of the replace target-device.

Nope, it won't work for degraded mount.

That's the root problem the patch is going to solve.

Thanks,
Qu

>=20
> Thanks, Anand
>=20
>> Reported-by: Nathan Dehnel <ncdehnel@gmail.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 fs/btrfs/ioctl.c | 29 +++++++++++++++++++++++++----
>> =C2=A0 1 file changed, 25 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index de730e56d3f5..ebd2f40aca6f 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -1604,6 +1604,7 @@ static noinline int btrfs_ioctl_resize(struct
>> file *file,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *sizestr;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *retptr;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *devstr =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 bool missing;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int mod =3D 0;
>> =C2=A0 @@ -1651,7 +1652,10 @@ static noinline int btrfs_ioctl_resize(s=
truct
>> file *file,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_free;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &d=
evice->dev_state)) {
>> +
>> +=C2=A0=C2=A0=C2=A0 missing =3D test_bit(BTRFS_DEV_STATE_MISSING, &dev=
ice->dev_state);
>> +=C2=A0=C2=A0=C2=A0 if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->=
dev_state) &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !missing) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_info(fs_i=
nfo,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "resizer unable to apply on readonly device %llu=
",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 devid);
>> @@ -1659,13 +1663,24 @@ static noinline int btrfs_ioctl_resize(struct
>> file *file,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_free;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (!strcmp(sizestr, "max"))
>> +=C2=A0=C2=A0=C2=A0 if (!strcmp(sizestr, "max")) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (missing) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bt=
rfs_info(fs_info,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "'max' can't be used for missing device %llu",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t =3D -EPERM;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to out_free;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new_size =3D de=
vice->bdev->bd_inode->i_size;
>> -=C2=A0=C2=A0=C2=A0 else {
>> +=C2=A0=C2=A0=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (sizestr[0] =
=3D=3D '-') {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 mod =3D -1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 sizestr++;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (size=
str[0] =3D=3D '+') {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (missing)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 btrfs_info(fs_info,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "'+size' can't be used for missing device %llu",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 mod =3D 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 sizestr++;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> @@ -1694,6 +1709,12 @@ static noinline int btrfs_ioctl_resize(struct
>> file *file,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ret =3D -ERANGE;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto out_free;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (missing) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t =3D -EINVAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bt=
rfs_info(fs_info,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "c=
an not increase device size for missing device %llu",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new_size =3D ol=
d_size + new_size;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 @@ -1701,7 +1722,7 @@ static noinline int btrfs_ioctl_resize(st=
ruct
>> file *file,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_free;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 if (new_size > device->bdev->bd_inode->i_size) {
>> +=C2=A0=C2=A0=C2=A0 if (!missing && new_size > device->bdev->bd_inode-=
>i_size) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EFBIG;=

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_free;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>=20


--nN4L3Q4T9lTKx2JtQxIyb07m5DcOdgU11--

--kevFvEOJjbLzRMMX43FDS5ghEoqUabpPs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3SiF0ACgkQwj2R86El
/qiThQgAjekjh0905wiNqylBfT5aGFH2CDRkNFcuWdNlrZxys6+CKE8HeirLK92Y
VX7nNdYKDfbzddVio6P2N5XZTF7fQx8WV4pacf8O8k9aimhWEuZdgzClXXUWlQvi
VT0etvOEAClQ/TijzwLJC45++yWG9blfDTzPXPpH5h1YbqefjpMGvjzNIIpO/Vou
n4EYOIsknR29DxgRVoBlmZbTgYnm3lApn0sVgbcd0BvNvwopCdP088ywzwlyFOUq
byH7nX/wzT/OAQ2AUBwY+0XSfvFWVuVZI/xOBHL+kEmmtkLN3kAcyj4vUOQRGwpB
4DpvzI173EJOfMoU5EBkr46qjr/gCg==
=ofVc
-----END PGP SIGNATURE-----

--kevFvEOJjbLzRMMX43FDS5ghEoqUabpPs--
