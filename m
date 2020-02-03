Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACCFB150815
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 15:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgBCOKi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 09:10:38 -0500
Received: from mout.gmx.net ([212.227.15.18]:47527 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbgBCOKi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Feb 2020 09:10:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580739034;
        bh=ZAs9LdfupM/XjNFxAcY2k/HO7rgS23OeLLEvfPGPAXE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=M2aH3dc+WC07Neml5HZm6s8N06De+8RXPPdyk4PEVd3/XO89M+0gOmsaRyNcEA4AC
         H5TGpS+htQ3Jl8u0Ku5hDxcfhD/H3rIVjGdX80wPC0Hli6G3/ruQRiK/pVHLA9Tg4y
         yl3aBjEf8pp20RJXsMXAFnBCOkYUnbyckeR6T7S4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MwQT9-1jr00K3yar-00sQSi; Mon, 03
 Feb 2020 15:10:34 +0100
Subject: Re: Root FS damaged
To:     Robert Klemme <shortcutter@googlemail.com>,
        linux-btrfs@vger.kernel.org
References: <CAM9pMnP7PJNMCSabvPtM5hQ776uNfejjqPUhEEkoJFSeLVK2PA@mail.gmail.com>
 <9cff72cb-ef8e-2d12-45ad-3a224e86b07a@gmx.com>
 <CAM9pMnOpSFnR9Dc_MyTyJevMRgiKBMPec-Y2W-iMbeyatTetog@mail.gmail.com>
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
Message-ID: <6f39d3a5-fdae-a0af-007a-5e95067b5921@gmx.com>
Date:   Mon, 3 Feb 2020 22:10:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAM9pMnOpSFnR9Dc_MyTyJevMRgiKBMPec-Y2W-iMbeyatTetog@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jNyvNhRKchhYOFLezsereVWEvgMuHshl2"
X-Provags-ID: V03:K1:FJyRbD7xieICBeb4lSp3BSdecSCoC2yKTLio6K0dGWUeh7h6Dov
 pS0KgA/+gT6zwveanagDUimhJiQWSNJ9JLr/vF7v35ajc3uTXep1akXRd55E5MW5f+AsSCU
 UpJpQbGgQ934QAU5FXxsJgv381+GnY2i0Uy8Va+nu1AvOotKd+6uZR7RGYm+yN3drfQsf9p
 moVp5cpTZXMc4+iOGmiAg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:koQ+u06Ord4=:6HWBvEkPbyE0UwkcnfI4Kg
 a2wsX2M9yB3jU2CU5PRZYuqL9cBnRkXLFzkuWAEcViNW16vg0Q9rV8NAx1KAlkEDTqz0NzQ7S
 w2AsjDgurRlUSO9TtyddPDLPoIQ/R8We9CZ4ua4PNvLHS1GAmQmDIaEn6Jv1e9OIAlJ4hnxiA
 DOfJWVGsmwrd3bQTTA2GPY3HCVY8qPBzBDxxl1IH+IAUh6PHgLZBca3qVE0LZfnW3ovzS/9gY
 XgxPLaPC4aoQ++fKYwv82WUy9z2MpnSknc/ibpB9mbYlu0NWrkuIFDzXNMhyf6TurKvWpqK8q
 KGRxtExdmC3qFkhlzSIqiTAjesFsuf/JdDbZRz5bGYaHqF22uJ4jmhDUVIEFaanC11A/DgCm8
 3eC0xdIeWtumnX+nwrPN+va8Qsnx54ZnHmbabrvQfTygNezmKxUwYqk+a6LCOa/yDDie3KATZ
 BAgbJqaBHjrnCXHkq4NBQyVdz8ICrK1elM0mQurxti3gm8R8UPm2O5sMX/BxNzWjOBBVacwlR
 Iv3ZtcgYZYDExW+/PM0/jIaIg8wuu1sp/Q3vTpm2D6z1bBteCuBzAyldZnb6MKFi9IgY5gMeQ
 UEnAlccdk31pkjAUGWgASrsx6EQ02zBqjTjh6yM2vAm+XmNgqIwWr/pezWXWMXc188VT5pDIr
 ka7E4qmyLJcjQEi/tsmknOGOUnisbGRQZfwh4Pm2PEQKm8uJmxgQn3Xjy9m5iAB3eN24Pnwji
 DLjeczfIIa83G9ZT5rGrWf36cVoEsEb5ofy/s2BrCjky3KbAkg2nqQLC9eUxQYparFwz6/gir
 HMDf9PRxQLt4qZTLapqQ1P862WJaJS1jpi25ml/TqmqEgSKFsPYgGSCgQ9uVYUrtTx/OgEOb3
 GjXx3RyDWspJdYkzymDq5/qWOEvSMmGBU1zdNn3/Xzo0bbguttLdv/AquXV0wbBisaxdGY9HX
 i60xPpjaGim02KXeacy8HvrvSK7u9qHdrnMcsHkrpsWfXy4JyyQrUf9TUSH0dVwCJrLfsD/Z8
 aSyDwRRBvWR7oDFvbpx0hj+er2MSHVPJe7RHa7VtpfTWi9YF3HUcUVI4waXG8BqNRXrmAygZP
 AhUavQ2/E3krp5/LVTvBINy3E33Sc3ESufHsTKGwnjloWc0NM9843OfxDATy1jsHwVD23skoi
 yfC1gRsi3D2mUSk474/FYDLkYdoAIdCj1IqJmmBGOLIVCfRz7kRXEwKr8/3LBpHS8uyCuYDgc
 y7TVfV40GulDtsXY9jhh0p27diMxSdEyZtWZ3l8V1eoLfsyVLhac4G/me7uyJ40EQza+AwNmj
 +RnxcgAc
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jNyvNhRKchhYOFLezsereVWEvgMuHshl2
Content-Type: multipart/mixed; boundary="rs0e6oD43wAJQkG8JzVqjMQM4KyaO3lsp"

--rs0e6oD43wAJQkG8JzVqjMQM4KyaO3lsp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/3 =E4=B8=8B=E5=8D=889:58, Robert Klemme wrote:
> Hey,
>=20
> thank you! That was quick! Some comments inline below.
>=20
> On Mon, Feb 3, 2020 at 2:44 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>> On 2020/2/3 =E4=B8=8B=E5=8D=889:33, Robert Klemme wrote:
>=20
>>> I have an issue with one of my desktop systems. Besides the usual
>>> information below I have attached output of btrfsck and dmesg. The
>>> system did not crash but was up for about a week.
>>>
>>> My questions:
>>> 1. And ideas what is wrong?
>>
>> One data extent lost its backref in extent tree.
>> So btrfs is unable to delete it, and will fallback to RO, to avoid
>> further corruption.
>>
>> I have no idea how this happened, but I'm pretty confident it's caused=

>> by btrfs itself, not some hardware nor disk problems.
>=20
> I would assume as much as there were no power outages or crashes. I
> read about a bug recently (probably on
> https://www.reddit.com/r/btrfs/) that had to do with btrfs on LUKS and
> / or LVM. Could this be an explanation?

No, it should only be some bug inside btrfs, nothing to do with lower sta=
ck.

>=20
>> Any history about the fs? It may be caused by some older btrfs bug.
>>
>>> 2. Should I file a bug
>>
>> If you have an idea how to reproduce such problem.
>=20
> Not at the moment as I did not observe any unusual circumstances.
> Having the system up and running for a while is probably not a useful
> test. :-)
>=20
>> Or we can only help you to fix the fs, not really to locate the cause.=

>=20
> OK, let's take that route.
>=20
>>> 3. can I safely repair with --repair or what else do I have to do to =
repair?
>>
>> Btrfs check --repair should be able to repair that, but not recommende=
d
>> for your btrfs-progs version.
>>
>> There is a bug that any power loss or transaction abort in btrfs-progs=

>> can further screw up your fs.
>=20
> That explains why a repair I recently attempted elsewhere did make
> things worse...
>=20
>> That bug is solved in v5.1 btrfs-progs.
>> I doubt it's backported for any btrfs-progs at all.
>>
>> So please use latest btrfs-progs to fix it.
>> A liveiso from some rolling distro would help.
>=20
> Is there a PPA? I could not find one so far.

For "some rolling distro", I mean Arch...

Since you're just going to repair the fs, no need to stick to Ubuntu.

Thanks,
Qu

>=20
> Thank you!
>=20
> robert
>=20
>>
>> Thanks,
>> Qu
>>
>>>
>>> Thank you!
>>>
>>> Kind regards
>>>
>>> robert
>>>
>>> This is a Xubuntu and I am using btrfs on top of lvm on top of LUKS.
>>>
>>> $ lsb_release -a
>>> No LSB modules are available.
>>> Distributor ID: Ubuntu
>>> Description:    Ubuntu 18.04.3 LTS
>>> Release:        18.04
>>> Codename:       bionic
>>> $ uname -a
>>> Linux robunt-01 4.15.0-76-generic #86-Ubuntu SMP Fri Jan 17 17:24:28
>>> UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
>>> $ btrfs --version
>>> btrfs-progs v4.15.1
>>> $ sudo btrfs fi show
>>> Label: none  uuid: 0da6c6f7-d42e-4096-8690-97daf14d70e7
>>>         Total devices 1 FS bytes used 12.64GiB
>>>         devid    1 size 30.00GiB used 15.54GiB path
>>> /dev/mapper/main--vg-main--root
>>>
>>> Label: 'home'  uuid: cfb8c776-0dab-4596-af5b-276f0db46f79
>>>         Total devices 1 FS bytes used 50.73GiB
>>>         devid    1 size 161.57GiB used 53.07GiB path
>>> /dev/mapper/main--vg-main--home
>>>
>>> $ sudo btrfs fi df /
>>> Data, single: total=3D14.01GiB, used=3D11.83GiB
>>> System, single: total=3D32.00MiB, used=3D16.00KiB
>>> Metadata, single: total=3D1.50GiB, used=3D820.30MiB
>>> GlobalReserve, single: total=3D39.19MiB, used=3D0.00B
>>>
>>
>=20
>=20


--rs0e6oD43wAJQkG8JzVqjMQM4KyaO3lsp--

--jNyvNhRKchhYOFLezsereVWEvgMuHshl2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl44KdUACgkQwj2R86El
/qhk8wf8DnqZ2baONKFDDU7es/iH8aR5OCmAZKJhwkQWuowVpXXa+wn4LYqr3ASL
9MNSo8HiMydUaHNvbZkd3ki6X6bK0DgWvi0Z0H9lxTaNWxrIR+bSOGE/PKZ1+jvb
GNza80jQFKBMXOuNs5JdebKKr2KBmrP3f0ukH2IJBmMB8Gemv6MR2l3yJVkP4DsB
JUZ79beVYcHVrT1oBIp4tgACx2QXS2AYIp8wmPnVIKu4VHsM7AZd5i118XE/EXZf
lyDPkcB25doaVU7NaGM9EqkPiz6p3BoGVGhVqQz3DboQ/vZcQvYU1xN1mq2MBekf
WDtGipCKN7vYhdDGRmRGHLwujHwQkg==
=qdg3
-----END PGP SIGNATURE-----

--jNyvNhRKchhYOFLezsereVWEvgMuHshl2--
