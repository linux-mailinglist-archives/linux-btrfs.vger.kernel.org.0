Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 903D7E62AF
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Oct 2019 14:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfJ0NiM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Oct 2019 09:38:12 -0400
Received: from mout.gmx.net ([212.227.17.20]:39809 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbfJ0NiM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Oct 2019 09:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572183487;
        bh=aOx9b2s952g8ScQ120CkEKZhM7XdpFRQ7OpwzFKUxZU=;
        h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
        b=JeYsoLuEKpYFOcYBLR18yTsruTwyzJDBE5U8qrIesdh9mEyjv+pQBW/1GfEQHlTmS
         qrGUvGUOKmU5OLoZJeuSesL5Fa9WfjuQyz2pVYneSMoNHGcoI4y41feekYEMOrcGGy
         7IT/a/RK//8R33OgcAVBe1F85Bq4yvxC0vm0YhRs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3DNt-1iPX1P2Vm1-003hbz; Sun, 27
 Oct 2019 14:38:07 +0100
Subject: Re: first it froze, now the (btrfs) root fs won't mount ...
To:     Christian Pernegger <pernegger@gmail.com>
References: <CAKbQEqE7xN1q3byFL7-_pD=_pGJ0Vm9pj7d-g+rRgtONeH-GrA@mail.gmail.com>
 <CAKbQEqFdY8hSko2jW=3BzpiZ6H4EV9yhncozoy=Kzroh3KfD5g@mail.gmail.com>
 <20f660ea-d659-7ad5-a84d-83d8bfa3d019@gmx.com>
 <CAKbQEqGPY0qwrSLMT03H=s5Tg=C-UCscyUMXK-oLrt5+YjFMqQ@mail.gmail.com>
 <0d6683ee-4a2c-f2ab-857b-c7cd44442dce@gmail.com>
 <CAKbQEqGoiGbV+Q=LVfSbKLxYeQ5XmLFMMBdq_yxSR7XE3SwsmA@mail.gmail.com>
 <043c2d26-a067-fd03-4c98-7ff76b081fed@gmail.com>
 <CAKbQEqHbh0pjT1+hPNuo_fKti0v9Mi-=gOUqm90v_tju1xSaxA@mail.gmail.com>
 <503118ac-877f-989c-50f2-5e2a3d0b58d8@gmx.com>
 <CAKbQEqFWiGdgJNSWOwvHkHGjrXu=2x0zAK-n9T-oza7qexwz7g@mail.gmail.com>
 <4a329da3-81ba-3240-8d76-6509dbe2983a@gmx.com>
 <CAKbQEqGOJjNAFMitAU=coVboaat9pi5b-6DxFg4SOON+6bfJ0g@mail.gmail.com>
 <0d48803b-b8f0-2ab7-dade-d92067b91202@gmx.com>
 <CAKbQEqFccH9=WsGy23CcCu-KSVWYrwffF6faRADH3oauJhgkdA@mail.gmail.com>
 <baf8bd65-6dee-1d49-6a8c-4b4845fe56c7@gmx.com>
 <CAKbQEqFne8eohE3gvCMm8LqA-KimFrwwvE5pUBTn-h-VBhJq1A@mail.gmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
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
Message-ID: <5c1bac32-8925-5925-5c86-8efa46d11738@gmx.com>
Date:   Sun, 27 Oct 2019 21:38:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAKbQEqFne8eohE3gvCMm8LqA-KimFrwwvE5pUBTn-h-VBhJq1A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XLH5CttmgluAkWxE7xp0ejKVukmDzQaaw"
X-Provags-ID: V03:K1:coFYizbR6lEpG9NkAc+5ThrlMm3QM2EXwjFTWo7l6ae3TXxpfQx
 65Pg4zgjH/6ar/0gDQBOP4txnx7fbwkOJMhQDzqdOs0XBMc/4dQiA6Hrf7BGGAiRIAAP+R6
 jp2XFNQUq6lEJnLvxGF+1wBxREpjzTcbgMqmUFLIbtrCtL/mAgkRlZdxLEM6xiUlU0rqg+R
 8G06w4uXdpup7YW/FWwAA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5QECnWqbfdY=:vKwbEgifljWlD1SUqFee6d
 H5faEXdsyJ6fWn1k7qPMtj7eStC7a1NJoueMGXnICWgzcJOYa0ekxbQVJ0fZqyKHXsoc5O+yn
 Vk4P6MQRBwjMVbgl+UgD1Tf5S0BsyuRQsiP8SPH8iQW7g6NOh/eF2Dvh5YWgVByev7lH1T5h7
 AFaCFxJ+8lYuZ5aXzjMkNhADKpC/V9nwe1B3vNXTNfqqADimjTw5Qer3HcKjDWp2KfR/IwuZa
 Biu2MiXyD2inbOr74OfwDyHB8+a3k20AQpMIxDTbm4AQun3wR/8A3EWf44uqiJCEeMVIrizTV
 VISR/gW0wlobJuO9v8Gy7yiVp0erN2cOX7kyhndaDipU2yZy3MuBfjj65NE1hlcLSM4LF2mB8
 HyDGXL+ISU7uKb0rcYdX+F05AEFNwutorOVmFndBjia/NSTxt4HqohXY6OUHcSrpeGDAwN0IR
 66HEdgDrUTUW+UNq+nIt0CXDNNYlNO/JunTs83LEfD5be1HJNrH7ioo11ObckasBcjclaroLe
 on1EaRNbOSB5c8USIsbeEyW2JB6x4YjRmQyqWHB45UegJCMroCXgPZhHLRvy/VvABYLNnHrVx
 9KRYnMW52CT7gTpayh0quftd/AEG7jS7RKl5f8pgcskewvIMR36L1FklCC1tzmzNEQPbnYE7/
 B+Be71vym1/YuZ80lUrIoAyovZMDb40hVAmyvFucTYE1LaPSQdizVRLDNTF/zoPIRDNtU+XHr
 SmDzE345k0/xxfjXUlidK/SLORyNNCk6jTpxKwr16+ndv+zIy5ko9FLgimh3tJLUDPqRDpG92
 OWw9vii1yLxwH1m3euR+frNd2EAVA8vJwhqwlGPSCDFyR8m0icPHi4oiiQcTefI5XL+sfBSK3
 xxnDTzZoof2aRZyRmtdhoCPGbX+SO3+RofOJXQWCiKtVWVLAi4iiqZ4EiUGiin43uXwYcEK2G
 36PyvJ7X/1Xils/k6HAqnJNICsjNSujM4ApISNhtRta5WY976urKdyytx0v/eQpxgsGS9p+My
 UTV8nVwofM/LehOy7mYS6LfDdHoz6/pPCDSx5Ec+/GoSJMxgn5OCdpL5gFAoXHm9XJODgEkZj
 NA0Y6NHTJ5e79MLJpVeDwzEleZIXF6+WsIKJNy8umI8gb0Za8gTbwBRaXAErLLKm3a6gmhiVh
 iiNZZUv9glMtcyJ+lGV4tOopWzyfNS9if85lnc1hg+BauGoD9vRmuaZHmCBMHr+Y0VOpaL5RW
 +xJsGWc46z3TDpRF9048aGK5CCPSRxVO+CgFehSYoF7raVzC2mo9Ux+IIyrI=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XLH5CttmgluAkWxE7xp0ejKVukmDzQaaw
Content-Type: multipart/mixed; boundary="59b539NVb6OfQi5nN8H8w7k6Cub9xRpsl"

--59b539NVb6OfQi5nN8H8w7k6Cub9xRpsl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/27 =E4=B8=8B=E5=8D=888:41, Christian Pernegger wrote:
> [Replying off-list. There shouldn't be anything private in there, but
> you never know, and it does have filenames. I'd appreciate it if you
> were to delete the data once you're sure you've gotten everything you
> can from it.]

Sure.

BTW, this use case reminds me to add an option to censor the filenames...=


>=20
> Am So., 27. Okt. 2019 um 02:46 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gm=
x.com>:
>> So "dmesg" is enough to output them.
>>
>> To find all csum error, there is the poor man's read-only scrub:
>> # find <mnt> -type f -exec cat {} > /dev/null \;
>=20
> I ended up diffing the files that were either in the data restored by
> btrfs restore or the ro-mount courtesy of rescue_branch, in order to
> read all files, expose files that were restored differently [1] or
> missing in one copy [just pipes & such]. Note that this is just for
> @home.

Considering you have log tree populated, it may have something to do
with log tree.

If you want to be extra safe, notreelog (yes, this time I didn't screw
up the mount option name) could make it a little safer, while make
fsync() a little slower.

Furthermore, according to your kernel log, it's not your data corrupted,
but the csum tree corrupted, thus btrfs fails to read out the csum, then
report -EIO.
It's possible that your data is just fine.

Maybe I can also enhance that part for btrfs...

Thanks,
Qu
>=20
> Cheers,
> C.
>=20


--59b539NVb6OfQi5nN8H8w7k6Cub9xRpsl--

--XLH5CttmgluAkWxE7xp0ejKVukmDzQaaw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl21nbgACgkQwj2R86El
/qil3gf+IJkatZ6gtf2kHUbNkdTfbklAfybswM9G17mV/vzmJwxNSJEROyWRtLOn
8Dc35I/1DubG+0zisOFq2B3T0Cp1dB6Wv/E8HrwgbHmT0sMnS0uO/Ul9FLM0U9Ah
q5cX7CLRlJyA0n15QiyBZBFZVac7DV7x7C2MflVjJzYd00SIyHsjHM/YQMqYP7tz
pNI/xyIll4PBGzTlr8r/chdm5TBlOmGeupTQ3rHa/+0S4aPqDCkMA0XJJ8SdPsU1
8BeCO0rjd6LxWxi4sxrIkJfct+kLpktQ98rlokt7KR8R+5ODtPa7RY9s5KgMDBXx
f8D5UBxJB4EDaiWmM5HF9BmRFEsHCQ==
=a/dS
-----END PGP SIGNATURE-----

--XLH5CttmgluAkWxE7xp0ejKVukmDzQaaw--
