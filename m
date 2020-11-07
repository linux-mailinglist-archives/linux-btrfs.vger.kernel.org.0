Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D3B2AA4B3
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Nov 2020 12:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgKGLfY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Nov 2020 06:35:24 -0500
Received: from mout.gmx.net ([212.227.17.22]:35941 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727298AbgKGLfV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 7 Nov 2020 06:35:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604748916;
        bh=Q/AM0hz4ZXyxa1KsoqqiPblfR5wkrpbwv4i+VXFbC0o=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=J1aw14qz8gZ7FMEON4+wQB/u+BqdYJ7i6mIhEp8y8JtOo7Pt7pv9EKI5xmXamIsiu
         Gmk1MDMDA5a0ORjcc2f5BQlowHYh1IpoTcZYxv4X9GgNoGm1AAt5C0JAS4TVdcea4g
         nacPEes1LrNCq7xi2rHipIwDuS3wVX0p8Wn873Ks=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBDnC-1kT9I52qpK-00CebF; Sat, 07
 Nov 2020 12:35:16 +0100
Subject: Re: Fwd: Read time tree block corruption detected
To:     Ferry Toth <fntoth@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Tyler Richmond <t.d.richmond@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
 <e04680b4-f4c0-254f-24ba-f2053e4ad8b3@gmx.com>
 <CAJheHN0THhKcqKY3cGtJqUGaub=E0tuCmi6wuNeCGBxyAHmecQ@mail.gmail.com>
 <e2c8eaaf-6adb-374f-4005-a1edcbcb8f79@gmx.com>
 <CAJheHN1U4j1KsD96oFuCVwP+6RVP6V6oAZP-aGOTtfm7tDL3BA@mail.gmail.com>
 <CAJheHN3pTj-6dOQZVKqA_r38F+WVNrjVO6-Z_hFeq96uTNK5zw@mail.gmail.com>
 <1f26ff53-f7c7-c497-b69f-8a3e5d8ce959@gmx.com>
 <b7383762-4a86-fdb9-12f3-89470808f4e6@gmail.com>
 <0d6a0602-897a-b170-f1a2-007cff1f23fb@gmx.com>
 <134e61b5-ecf7-bc1a-e16b-c95b14876e6e@gmail.com>
 <5b757c2b-6dbf-cbec-6c66-e4b14897f53c@gmx.com>
 <838490cf-fc40-0008-88bb-eeede1e8d873@gmail.com>
 <50e0ef4d-061e-d02d-9dbf-61f83dfa7b3e@suse.com>
 <117797ff-c28b-c755-da17-fb7ce3169f0f@gmail.com>
 <51578ec7-f2e5-a09a-520e-f0577300d5ce@gmx.com>
 <ca811ad9-5ae4-602e-98a4-5d4d6c860a1c@gmail.com>
 <0acac733-233c-0c71-b9bc-c4bee1c724ba@suse.com>
 <4dd24fde-6d7f-202f-5d2f-b4478d797a93@gmail.com>
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
Message-ID: <fcd272a5-a437-e918-8102-3813a608574c@gmx.com>
Date:   Sat, 7 Nov 2020 19:35:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <4dd24fde-6d7f-202f-5d2f-b4478d797a93@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="n5gxK4fG8hKoo5AHg0FK3jKyzZ9MGfsg4"
X-Provags-ID: V03:K1:YfLUJzpoQI5Vb2y8sPwee21hYcAa2UFL2z0Q3h6nsxbkh2g7kOS
 z8hUCA3jgtK/iQDRHR0acvcBj+7XUUeIpgTSk47E9801ZO/TrIOgDnZGUUQINCqNG4ufboP
 btE0K0rFhn3QP3pnqLl2cFx0db3RNBSKNYZ/cj/9qRVjCYGfPXsKYjMMbmyrDlUOfcaUwS6
 FYm6f9qY/yAgOOsxMENtg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bKOYuR+nzwQ=:vtI2+yM8oy26oYVgp1jKAc
 p8sunnPdUeHsZiZqkjn7qTfU/NNScH3X5PGnPGkavvmfZAUKmMJom3Ie+65R0pkwskD8iri7F
 UXwzpQ+aiUNnjG9vbjEeo+atUYANqPB6zV9E14iqx1uIvcviLXzrFTqOTdUO6fJjaIgQbEt+X
 Kw78tRP6zy00GsokCj5h59DmdLXFALKQJHTY8bF7tDwE3gcOpro6IJl7V3dXFYRPECc0SYsgn
 6Xm2ENCGr3IXCt9TrSRWGQ1cx48fWq6WAg3ElwUV0kh5kWg6PF/ZPkhlAWNSVoX0+qbSMl62q
 KzzpQ9JutJhms/w70zpgitcBYOmNu23wcWxqdUhG2uj7dEwPdS6JBIEB+4L6FcNawoxOZktk8
 Lct+bkoElq0sGWZvsvdnNl0bb5HzJSr6DZIYFgfigAJI+H3PyuNGTSFgN8f6YJzuQcT50CWNz
 yJSDYr9e2/cqKbskpS+xKFQDoyz6by0GedxW2QqyS171MD7ug7w4vT1l2/Iv7zsjgPasvLk2e
 uPRIalcIWmUCsIZGsL83CnelszaCWdGE550aqs6sZItTTgvvazbdvAvlbYk6D6iGcHqTbIdjR
 lj5N7bWheVd772uapJpy7czOiAFR1GUEyD77RaIdaWq0tSqjYzHkrmN6r9phkl8xafvP3YR4P
 6ACYO5Xv/fL5+36Jka3wYZaSiSMkhtGIoYBZ6IvO/D6dsSw8E7EXjut99AvC9ZyTNh72Qqf2s
 phLxjClZqe23KnVnGNQXCcQ25ZWmQxyu9/N1bqkcI3UcXKp7/gLyPO8DnZV6m6yfYL7Df3QIp
 S9jE6+E9ZpmSdQgcvdUyZfxor5fjEqVmU717oYCGT4ZPB+aGCfeTc2UCj75RcCdd28rQB2C3V
 3nl9iPqFtJdRPBL3wiDQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n5gxK4fG8hKoo5AHg0FK3jKyzZ9MGfsg4
Content-Type: multipart/mixed; boundary="0a65kET2V5rnFw88e7lEpCi8XZewHHvK6"

--0a65kET2V5rnFw88e7lEpCi8XZewHHvK6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/7 =E4=B8=8B=E5=8D=887:18, Ferry Toth wrote:
> Op 06-11-2020 om 11:32 schreef Qu Wenruo:
>>
>>
>> On 2020/11/6 =E4=B8=8B=E5=8D=886:30, Ferry Toth wrote:
>>> Hi
>>>
>>> Op 06-11-2020 om 11:24 schreef Qu Wenruo:
>>>>
>>>> On 2020/11/6 =E4=B8=8B=E5=8D=886:09, Ferry Toth wrote:
>>>>> Hi Qu
>>>>>
>>>>> Op 06-11-2020 om 00:40 schreef Qu Wenruo:
>>>>>> On 2020/11/6 =E4=B8=8A=E5=8D=887:37, Ferry Toth wrote:
>>>>>>> Hi
>>>>>>>
>>>>>>> Op 06-11-2020 om 00:32 schreef Qu Wenruo:
>>>>>>>> On 2020/11/6 =E4=B8=8A=E5=8D=887:12, Ferry Toth wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> Op 06-11-2020 om 00:00 schreef Qu Wenruo:
>>>>>>>>>> On 2020/11/6 =E4=B8=8A=E5=8D=884:08, Ferry Toth wrote:
>>>>>>>>>>> I am in a similar spot, during updating my distro (Kubuntu),
>>>>>>>>>>> I am
>>>>>>>>>>> unable
>>>>>>>>>>> to update a certain package. I know which file it is:
>>>>>>>>>>>
>>>>>>>>>>> ~$ ls -l /usr/share/doc/libatk1.0-data
>>>>>>>>>>> ls: kan geen toegang krijgen tot
>>>>>>>>>>> '/usr/share/doc/libatk1.0-data':
>>>>>>>>>>> Invoer-/uitvoerfout
>>>>>>>>>>>
>>>>>>>>>>> This creates the following in journal:
>>>>>>>>>>>
>>>>>>>>>>> kernel: BTRFS critical (device sda2): corrupt leaf: root=3D29=
4
>>>>>>>>>>> block=3D1169152675840 slot=3D1 ino=3D915987, invalid inode
>>>>>>>>>>> generation: has
>>>>>>>>>>> 18446744073709551492 expect [0, 5851353]
>>>>>>>>>>> kernel: BTRFS error (device sda2): block=3D1169152675840 read=
 time
>>>>>>>>>>> tree
>>>>>>>>>>> block corruption detected
>>>>>>>>>>>
>>>>>>>>>>> Now, the problem: this file is on my rootfs, which is
>>>>>>>>>>> mounted. apt
>>>>>>>>>>> (distribution updated) installed all packages but can't conti=
nue
>>>>>>>>>>> configuring, because libatk is a dependancy. I can't delete t=
he
>>>>>>>>>>> file
>>>>>>>>>>> because of the I/O error. And btrfs check complains (I tried
>>>>>>>>>>> running RO)
>>>>>>>>>>> because the file system is mounted.
>>>>>>>>>>>
>>>>>>>>>>> But, on the sunny side, the file system is not RO.
>>>>>>>>>>>
>>>>>>>>>>> Is there any way to forcefully remove the file? Or do you hav=
e a
>>>>>>>>>>> recommendation how to proceed?
>>>>>>>>>> Newer kernel will reject to even read the item, thus will not =
be
>>>>>>>>>> able to
>>>>>>>>>> remove it.
>>>>>>>>> That's already the case. (input / output error)
>>>>>>>>>> I guess you have to use some distro ISO to fix the fs.
>>>>>>>>> And then? btrfs check --repair the disk offline?
>>>>>>>> Yep.
>>>>>>>>
>>>>>>>> You would want the latest btrfs-progs though.
>>>>>>> Groovy has 5.7. Would that be good enough? Otherwise will be
>>>>>>> difficult
>>>>>>> to build on/for live usb image.
>>>>>> For your particular case, the fix are already in btrfs-progs v5.4.=

>>>>>>
>>>>>> Although newer is always better, just in case you have extent item=

>>>>>> generation corruption, you may want v5.4.1.
>>>>>>
>>>>>> So your v5.7 should be good enough.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>> I made a live usb and performed:
>>>>>
>>>>> btrfs check --repair /dev/sda2
>>>>>
>>>>> It found errors and fixed them. However, it did not fix the corrupt=

>>>>> leaf. The file is actually a directory:
>>>>>
>>>>> ~$ stat /usr/share/doc/libatk1.0-data
>>>>> stat: cannot statx '/usr/share/doc/libatk1.0-data':
>>>>> Invoer-/uitvoerfout
>>>>>
>>>>> in journal:
>>>>>
>>>>> BTRFS critical (device sda2): corrupt leaf: root=3D294
>>>>> block=3D1169152675840
>>>>> slot=3D1 ino=3D915987, invalid inode generation: has 18446744073709=
551492
>>>>> expect [0, 5852829]
>>>>> BTRFS error (device sda2): block=3D1169152675840 read time tree blo=
ck
>>>>> corruption detected
>>>>>
>>>>> So how do I repair this? Am I doing something wrong?
>>>> Please provide the following dump:
>>>> btrfs ins dump-tree -b 1169152675840 /dev/sda2
>>>>
>>>> Feel free to remove the filenames in the dump.
>>> sudo btrfs ins dump-tree -b 1169152675840 /dev/sda2
>>> btrfs-progs v5.3-rc1
>>> leaf 1169152675840 items 36 free space 966 generation 5431733 owner 2=
94
>>> leaf 1169152675840 flags 0x1(WRITTEN) backref revision 1
>>> fs uuid 27155120-9ef8-47fb-b248-eaac2b7c8375
>>> chunk uuid 5704f1ba-08fd-4f6b-9117-0e080b4e9ef0
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 0 key (915986 D=
IR_INDEX 2) itemoff 3957 itemsize 38
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 location key (915987 INODE_ITEM 0) type FILE
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 transid 7782235549259005952 data_len 0 name_l=
en 8
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: smb.conf
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 1 key (915987 I=
NODE_ITEM 0) itemoff 3797 itemsize 160
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 generation 1 transid 18446744073709551492 siz=
e 12464
>>> nbytes 16384
>> Yeah, corrupted transid.
>>
>> The v5.6 kernel doesn't get the fix backported...
>>
>> Now you have to use either the out-of-tree branch, or David's devel
>> branch to build a btrfs-progs which is able to repair the transid erro=
r.
>>
>> Thanks,
>> Qu
>>
> Just be to be clear, I tried to repair with the Kubuntu Groovy Live usb=
,
> which has linux 5.8 and btrfs-progs 5.7.
>=20
> I didn't fix the above transid, above was taken after booting normally
> again (linux 5.8), unfortunately with btrfs-progs v5.3-rc1 (that I buil=
t
> a year ago). See the other post for the result with btrfs-progs 5.7.
>=20
>=20
As I said already, you need either the devel branch to do the fix.
Current release btrfs-progs hasn't the repair ability merged.


--0a65kET2V5rnFw88e7lEpCi8XZewHHvK6--

--n5gxK4fG8hKoo5AHg0FK3jKyzZ9MGfsg4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+mhm8ACgkQwj2R86El
/qgZLgf/SNZoCRKyUE+Wj10uvr+62GpOZFc6cdwuE3yM1bytHTQcH4R+Mjl3vmlU
78lta3mjyAMD1GTp0reoSrjy2fXpa5lXXvpqjJnsDmTfkMZTmcRrNcUyIwKfWpY/
yVlhAMIuHHgEtmdgcEqTML7S2ANRlwQuEWgHvfBpXrWDcfYqhmjfjqDQAr8traPY
Y9dn2g5s0wd9r1rmjI3Y4NXekx3+emdGsq1jgg7wewcPekQV5IlHefviEq7sKUop
XYKzX3NyGHt6CxRzulR0c6Ae1xttxC1cqqFTC5JrPrgAfJuFMy+SDYqOQjHKqZPe
5bf4ob747BEBYTMdcg+uZ6Nb8YTp4A==
=GMKO
-----END PGP SIGNATURE-----

--n5gxK4fG8hKoo5AHg0FK3jKyzZ9MGfsg4--
