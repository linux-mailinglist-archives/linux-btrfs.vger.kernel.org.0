Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBBCE6248
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Oct 2019 12:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfJ0LeL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Oct 2019 07:34:11 -0400
Received: from mout.gmx.net ([212.227.15.18]:37801 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbfJ0LeL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Oct 2019 07:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572176048;
        bh=urclbevJimnnS8XMLsOT+m+ov70FSL9wzTwxzOXccsE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BAoj/iQeHMHtyL59JwcaPFX7kjtbbuAznEY738q+qjn+oXChodgB0WlXKv0RvHT+d
         kXyp52kOwThVK+K6L7scfJPbiHQknjE45kT996++E2E586qF+xgK6ouXHQntmHh/Je
         gXWAC2veRV0jWRQaEec8DcxcbOVR8y63AoyfkvC0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWASe-1iVyDN11ti-00XZCR; Sun, 27
 Oct 2019 12:34:08 +0100
Subject: Re: BUG: btrfs send: Kernel's memory usage rises until OOM kernel
 panic after sending ~37GiB
To:     Atemu <atemu.main@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAE4GHg=W+a319=Ra_PNh3LV0hdD-Y12k-0N5ej72FSt=Fq520Q@mail.gmail.com>
 <cb5f9048-919f-0ff9-0765-d5a33e58afa7@gmx.com>
 <CAE4GHgmW2A-2SUUw8FzgafRhQ2BoViBx2DsLigwBrrbbp=oOsw@mail.gmail.com>
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
Message-ID: <b4673e3b-b9b2-e8e5-2783-4b5eac7f656d@gmx.com>
Date:   Sun, 27 Oct 2019 19:34:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAE4GHgmW2A-2SUUw8FzgafRhQ2BoViBx2DsLigwBrrbbp=oOsw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UndVxtOPujVv2XSwJlNNMCZb6pUdO7COF"
X-Provags-ID: V03:K1:jAGm+5KWv5875EuuKVGjsJSvv0Uthfh6fF/Xax6pIkmhsqGimXK
 UHFf98zfZhroozYW1D/QlPgOcgGCQ9oDeyi4n8gQgn9x5j373mgTdgor+slVrwLeEhGpkq4
 bMJSN175JJ6mfHr0qdJQBcZFfICpDdIuV97g+++7ICoxoXaxCQ79a+uwE0aCV4sTm+UgpIL
 zy7UkO2VWS8I6nJ36TKPg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gYS1p+KWOzI=:U0rwcC6lChKPAJnpGVhJyo
 pHEiS7+WuTOq6mmhR06Mq65QnfOD9cCXLkbRFQkkoFHyc+/G8jkUFQvJL2U0x7O+hZVEwGFZl
 SCo/1gQ/VPSt1Eg1oguotq/uFDFMhQfvcOUyYJIeoszlKZ4HPY0m+4EjCxzfTBHH2fE73aJh1
 aw4N9F74e1TK250Y/mE6krahMGFXpdbmP7ZYH82b2NQrP4hPSva1k2a+hCZJ7kwdWcTMdPutQ
 cfSAzi0feej8lzs7Fd5PuiACpAz4SNE23TDKQt/sUAmmEaww+9xIEeHjulGaQF2I25SFK4uUY
 Abfou9CTLkrxb44YPeAsyJPzLN9281Fx65ABjsJ6OAK992lAqN9ZanmugiaB6Q7LImqD0UpB0
 gzvmlEiANsU/binJXk+ybjN1C4Ndn/bP/r3IguRkoAKZCiL/NgKhOECT7IvNvGQTZOJtxIzKQ
 zOYakHi7U/fWu0TR3Ud34i6W8KkeWlzPlBsa7u5a3eiqY9WAxk3QnyM95rTBOw8O9YcAVQzoL
 TWr/j8QoPvFXfCbrd82Y0MRgzVqiV/uU8fD2MPhKTlleEz5EvK/WTg6E+wDE4p23hWI3E2i7G
 febYgdovmdLsJzd38sMWyc09Hq6kbmSDqrysHQWJdjZcbVT3UMV+vRVM0s+8D7MvUg6NQGvcX
 Utm+xIObdywtz8NVKjHMvvaL46z1jdr0Goa/flYJXu/+Z5y7+Z+OZgUukUPgJhPD7MV2ttvM6
 OHacz1gL7auMjy/de4AWzWob3LRSPEnNbu1lCUesD162A9rbGmlWagph5KRto3nuNEVN3V68P
 fDBxYXOtzvGrPx0sEv9JoP78AOxcp2HDrym346/HTWpKR2t+/6ftdyRHm9z9zN8n/mq2xVuej
 qEuH/MEHP/gJEbXgj/AsJ/AFX/YBq7FVtOedgMzvBDIvg3eY1Y21FyR4gsZ/i8o0juzD3Yxdd
 ahoWiKeihfLNLNhDq++QxHki+HNsD0yDws/kVY2IanH0OBNvU/SdOdspte4km0rfyw1fIiMPS
 TJbvLwX3XMiP20Tca/IBRxhn8/qEydxfb/zTYbUfDs0wyuMaTZx8X1FoD7lQcEKU8m2LAq+br
 WedDAMMkUbAL7W6QUPfbSJ3L7Y/yTEEKZszH4vu2ilfnvGtdns8MSjcagIoHUQ0A+0Pi2Q0tq
 pfnWK6q7FH/ky5j7m6RyjostL818U+UOmAcu7IJQoiyOgOhn7WMQBPPfuLuqjQrgUFMoGC7Xv
 CpaVuKN120NrBZ84G1ngA4CbFU/nRLqGOYs5dLaAcBIwWrn7Lpko61CUjt4Q=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UndVxtOPujVv2XSwJlNNMCZb6pUdO7COF
Content-Type: multipart/mixed; boundary="DK9XRfOvrmduhDGsKysGVVRx5yAsFfgGf"

--DK9XRfOvrmduhDGsKysGVVRx5yAsFfgGf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/27 =E4=B8=8B=E5=8D=886:33, Atemu wrote:
>> That's the problem.
>>
>> Deduped files caused heavy overload for backref walk.
>> And send has to do backref walk, and you see the problem...
>=20
> Interesting!
> But should it really be able to make btrfs send use up >15GiB of RAM
> and cause a kernel panic because of that? The btrfs doesn't even have
> that much metadata on-disk in total.

This depends on how shared one file extent is.

If one file extent is shared 10,000 times for one subvolume, and you
have 1000 snapshots of that subvolume, it will really go crazy.

>=20
>> I'm very interested how heavily deduped the file is.
>=20
> So am I, how could I get my hands on that information?
>=20
> Are that particular file's extents what causes btrfs send's memory
> usage to spiral out of control?

I can't say for 100% sure. We need more info on that.

Extent tree dump can provide per-subvolume level view of how shared one
extent is.
But as I mentioned, snapshot is another catalyst for such problem.

>=20
>> If it's just all 0 pages, hole punching is more effective than dedupe,=

>> and causes 0 backref overhead.
>=20
> I did punch holes into the disk images I have stored on it by mounting
> and fstrim'ing

That's trim (or discard), not hole punching.
Normally hole punching is done by ioctl fpunch(). Not sure if dupremove
does that too.

> them and the duperemove command I used has a flag that
> ignores all 0 pages (those get compressed down to next to nothing
> anyways) but it's likely that I ran duperememove once or twice before
> I knew about that flag.
>=20
> Is there a way to find such extents that could cause the backref walk
> to overload?

It's really hard to determine, you could try the following command to
determine:
# btrfs ins dump-tree -t extent --bfs /dev/nvme/btrfs |\
  grep "(.*_ITEM.*)" | awk '{print $4" "$5" "$6" size "$10}'

Then which key is the most shown one and its size.

If a key's objectid (the first value) shows up multiple times, it's a
kinda heavily shared extent.

Then search that objectid in the full extent tree dump, to find out how
it's shared.

You can see it's already complex...

Thanks,
Qu
>=20
> Thanks,
> Atemu
>=20


--DK9XRfOvrmduhDGsKysGVVRx5yAsFfgGf--

--UndVxtOPujVv2XSwJlNNMCZb6pUdO7COF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl21gKsACgkQwj2R86El
/qjdWwf/XXD3k3LdtDIpuAqaY6OtzRm29Vd5KS2u8NKpkFllRyQLRYCqyxdc6rbA
LrKNVboJRYQxB4FXADtMeyKWoAx7C1N27kztvyefFnppTbTv2bJpOEWTMjW6QJwQ
yh1BiA4ftseId/SFZtI2AGoINXJuUjKka0DZLu6ye2L92kD+AX6VNPHoOuh3iOKV
zxubS/A+D8XYjnRX2msaJJTxTMh/565sKJ9Q9znrTDUfZufEYnKsT5YD1W+HH4Ap
GZAegR670ilJQXLfogUJPbmODaBoZ9oXy7CZ8jPONxvnGi/NhGmoItLroBYRK/CS
EgxH25/BOtUU9CtyxzmV6f3FnZf/Nw==
=UYDn
-----END PGP SIGNATURE-----

--UndVxtOPujVv2XSwJlNNMCZb6pUdO7COF--
