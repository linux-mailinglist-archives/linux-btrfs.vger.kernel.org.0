Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68B10F2373
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Nov 2019 01:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732771AbfKGAol (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Nov 2019 19:44:41 -0500
Received: from mout.gmx.net ([212.227.15.15]:38251 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732730AbfKGAok (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 Nov 2019 19:44:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573087478;
        bh=fiViW2nCR4doEY5WE47JhiRaUb9exe6Mn2rNF5/Q0xk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NO1gERFLCSYDsGzJTbqCk59BoaEnCHz8rxti1fbIBomAa2HwcOr8fucI5z/3npZr7
         jHG30VWqXnsdcTWo+3u3SqeBJ2oM4T0m6QF/5cpmXuCjIZ8gWmB2EhApSmyB/dK+RC
         gfAspEREp/Ls7Nn7B5Xg6n0IaR+1rb/SN8bGZG5s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MsYv3-1hd9eI2Npb-00tzCS; Thu, 07
 Nov 2019 01:44:38 +0100
Subject: Re: fix for ERROR: cannot read chunk root
To:     Sergiu Cozma <lssjbrolli@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAJjG=74frVNMRaUabyBckJcJwHYk33EQnFRZRa+dE3g-Wqp5Bg@mail.gmail.com>
 <187ab271-f2be-9e96-e73a-0f6f3e97655a@gmx.com>
 <CAJjG=77Csw5P4q1sPeinoT=y=9Gy=FUr88NK2mJH72OBExnHgQ@mail.gmail.com>
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
Message-ID: <1e600b1e-f61b-ab7a-85bc-8bd1710c2ea9@gmx.com>
Date:   Thu, 7 Nov 2019 08:44:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAJjG=77Csw5P4q1sPeinoT=y=9Gy=FUr88NK2mJH72OBExnHgQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="011q8K551voEroMLyyhcGKco5a4QlfLcn"
X-Provags-ID: V03:K1:e2e+lQc/4WvQSG6DKXcFj8dR16y28/QEO4KHQnCm9rvbTH464Kt
 xxc+N4m+rfOE9M7mz1GPeHikgIC0D+mEDBjeTwnTFZFVsVgw/bRX0rs/TlNOctdgjMWbpLw
 KEmiq0CQNrOpOpXjGIWXGTBUp6Is6MrR9tL8SO3wacD/dZYFwyZcIaYnq+ausxnqPJOwZoM
 XFDRgEXnyzaKLi064CKKQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:llx6jIGWXdY=:INnHFcks1yK9yNEis1mJ2J
 UKX2wau4PY/j1vj/o3deDvOT/BicqQon5UjbOdAzAZ+Cw2+xwKhgr97R5fZDvgF51qRhBBBnI
 4JPBXvOgYVIUO/q3xrgBSofzxkQdUrMJRb7fddjvxoZ1RjcZdAtMT3UHISslOyoxb8+8HfmbO
 dMRPmRk1EmoJsc0Rgo4wwiaZg36vFCfoVYKE63ssrDtNS8hTVSqKxpOnLa7UwnMwyTLvaXVEW
 UY1n5tZb5cfMuOIh7idjkOU1hUAdC9lqVNKh/SJwNZ9RQaxdLnmgrBZrb+QqgLYBN4oSBLclh
 W0OZMjvwAJxr7JbzTeuILD4TyV7m2Jrh3mlOvp3Ra6hiNGWiZq6GP9Yolbw+JWiii9kBtz02Z
 S+KoB6N/gWjGy5HUEfI/6XTqVA4FnapoUOFQLuZc2wUKsGt03b7tBL2dYoU3w6wre9hC2+vZK
 o+L1Kpo/Rdf04s6fU/wKia81VOmCMnTahPE5OAeyE99qtJb2cniN1wzc0upWo7kWF/D536z6a
 MfKbddACDMMLFqD37QvFlgVwu3e275hIej7paCr9eBP/jmgFyvfPwOM0dxvVD2epno6PvY2JY
 9NbnMDlHHVpyN6F4FIfvi+GMoOf0/cGEpW9Txlz3AlOw50KDacY66YKN7vutaTtNrZ2NWRpRB
 96aQXOGeTESX5C2+J0J/kwEtrUBcQTXfTRG3Y1Ws+M5AR//2vjxmxYGZNN5+yhLyUWbehOyuB
 G4SD3ANNmfoCBIZNuCuBgieotqqNCioXPaSXMsPuO28bik9Qand1d3EQXxcKVAiy3MyS9I+AT
 fxKeVSMz+u6JOPvoJ+Sm/3SHNLG5CEdZHHkZAC4x5cOAI+xYaXVGfkZz4SLlT2168xIhRkZXv
 QdyyFrMOWq4TFWKrNzywe4FFHDNF7aBXSpr2OWpP5ngapc4AUC3R/TMprMiAwp3ed91Tjcm4R
 oqz+RISjuHiobgeGLjR8Xe0LW5dcss0jqcorxQ8l+cKaGK5cZC3x4X8GuISSsNSfFUsG8h7z/
 Ss9GjKUpHlFTfOkfRNWEpBzPdFuY9qnw+AV2b569GXYcx8AEql8O7uZ0y4OPX9FOG9P069uhr
 p+usNuZouCbFN8fA3fpGjqnb3lt+sjPHbc1jV3s7KmRADXIulWirrJ5HC1rEv7IDWgiv4vwGt
 KRwZc5kuCSbmwWadikb98F7rqk0elzVzL7Iq2I0dWiHoKp17u1WhrG56t3ms6dTQnCJCJL3B1
 1nthUOyU8OJAHrmHXeCdGQ3u0yCTDD1vRw4AV5bk0pZ5qmI4lWwO0i3LcKSY=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--011q8K551voEroMLyyhcGKco5a4QlfLcn
Content-Type: multipart/mixed; boundary="oBskfc0IKKUSn3lAMI8L9caaFQsWu1Ppa"

--oBskfc0IKKUSn3lAMI8L9caaFQsWu1Ppa
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/6 =E4=B8=8B=E5=8D=8811:52, Sergiu Cozma wrote:
> Hi, thanks for taking the time to help me out with this.
>=20
> The history is kinda bad, I tried to resize the partition but gparted
> failed saying that the the fs has errors and after throwing some
> commands found on the internet at it now I'm here :(

Not sure how gparted handle resize, but I guess it should use
btrfs-progs to do the resize?

>=20
> Any chance to recover or rebuild the chunk tree?

I don't think so. Since it's wiped, there is no guarantee that only
chunk tree is wiped.

THanks,
Qu


>=20
>=20
> On Wed, Nov 6, 2019, 13:34 Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> On 2019/11/5 =E4=B8=8B=E5=8D=8811:04, Sergiu Cozma wrote:
>>> hi, i need some help to recover a btrfs partition
>>> i use btrfs-progs v5.3.1
>>>
>>> btrfs rescue super-recover https://pastebin.com/mGEp6vjV
>>> btrfs inspect-internal dump-super -a https://pastebin.com/S4WrPQm1
>>> btrfs inspect-internal dump-tree https://pastebin.com/yX1zUDxa
>>>
>>> can't mount the partition with
>>> BTRFS error (device sdb4): bad tree block start, want 856119312384 ha=
ve 0
>>
>> Something wiped your fs on-disk data.
>> And the wiped one belongs to one of the most essential tree, chunk tre=
e.
>>
>> What's the history of the fs?
>> It doesn't look like a bug in btrfs, but some external thing wiped it.=

>>
>> Thanks,
>> Qu
>>
>>> [ 2295.237145] BTRFS error (device sdb4): failed to read chunk root
>>> [ 2295.301067] BTRFS error (device sdb4): open_ctree failed
>>>
>>


--oBskfc0IKKUSn3lAMI8L9caaFQsWu1Ppa--

--011q8K551voEroMLyyhcGKco5a4QlfLcn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3DaPIACgkQwj2R86El
/qjd1gf/W5zi8Tqob5WRQaqtU0uBnYHHEiKAy2EWA2J52irsK7H3M/3kLn0H+qur
Ng03OtKWgS8eeUa1DKMczezfvglr+eWnMTNY4wqal0CJnPpmX1cH0300tbSEcVOU
hnsiZpJtci5HrPP51RslrqZy0f9l6WaI5zCbW5K/6I7t6BXpkorfu0ERcalJgbQJ
4nODziu73fPsJRQF1YEYnDb0/WD7ilSnqiReB61G6Ff+YCEHBl2+Ba/hmg3lVN8G
4RtyxswMpcsqQ86tmHkxBHB7HpnZHvL76zg4xxulU2X3DlaUbmh9Lhzm+rWPp8fy
IQCI2GOcznf4PtfgtjC5DwFdQYHw9w==
=4tUs
-----END PGP SIGNATURE-----

--011q8K551voEroMLyyhcGKco5a4QlfLcn--
