Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA0D110483B
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Nov 2019 02:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfKUBve (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Nov 2019 20:51:34 -0500
Received: from mout.gmx.net ([212.227.17.20]:33477 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfKUBvd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Nov 2019 20:51:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574301091;
        bh=HvgsuwLGKrhkFDxpHIy8SpBrR1IySnIjne/2GUX4gs8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=f4zWxhkcCBArBDGQREJ34JeeTa9duC17vwfOj34cca3l9whleZfUW/v6R+2G4zcMB
         b7ejZCp/SHTfCYYyuhIxcKmk1H7R7A3bndTaXDW86BWSiZflnr6AdmcYMhbHbnsx4B
         uRInOnmHi6LWDPezi2UlaZZyoTaxt/wOmsTBzGvU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MpDJX-1i412T327T-00qmzZ; Thu, 21
 Nov 2019 02:51:31 +0100
Subject: Re: freezes during snapshot creation/deletion -- to be expected?
 (Was: Re: btrfs based backup?)
To:     Christian Pernegger <pernegger@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20191112183425.GA1257@tik.uni-stuttgart.de>
 <7f628741-b32e-24dc-629f-97338fde3d16@googlemail.com>
 <CAKbQEqGOXNhHUSdHQyjQDijh3ezVK-QZgg7dK5LJJNUNqRiHpg@mail.gmail.com>
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
Message-ID: <3e5cd446-3527-17ef-9ab8-d6ad01d740d0@gmx.com>
Date:   Thu, 21 Nov 2019 09:51:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAKbQEqGOXNhHUSdHQyjQDijh3ezVK-QZgg7dK5LJJNUNqRiHpg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="z17Ov8C1sqjzhPJ9kFI9oGxMRJOTO8ZgQ"
X-Provags-ID: V03:K1:n0tw9N2SticFHbjUEiwyemVvaVK3c03MGEgm9EfMt1uZedgsjOn
 5930r+oFpSiWjKCUMb7iNBSShMSkcZntbkPyDaemffkA85+Z/UKAGmhTCgL2wBlG4CdJfDu
 yU0ivtrFhZv6+P+uLhzWP1hQPK8vDAKu28hgENhx49AcIo1zac8GozpxHlzxrbbipLxQKRz
 a6L3i0XJ6cG/Ggww3GOTA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ABUhbPb3JpU=:8KPdrTKfTYQNrX/KChKYHe
 RhSWfc9X2TXqxr6FK1zKmyE3xgFIJ1VxAYE89GyILh1r2UI8UL9K8eDyak4CIR3MzErAZuG8x
 bQmlcyIW+YlQNKznao2wdBgCMC9znnmv/YzqKhg4dDjfR9PXu2JC5fzP0QEdq3cl3aE4w2/bJ
 4SCV0C6lU5/l2+Cda4GLNJL7y9lbba3kiIU4GBkA42t7tPHUdmJgXxz3U6yW+dzDeIuFAqv8Z
 wlj0fHxWt2eGT0zaperHZEtkzDg0ek8SJnqll7T97h9hDDmHqvM/rChPEin/IJHeyW04fuG0u
 dZgqIIiIYfgzl4uMSshs6LMTGtANvQ3nxc+8fdxu3qwUferx77kK13wKb6Wn+RUz4GrVEFfFZ
 ccdb8w3n3NhK8q2z+H6rxGbYMxiC1XnuBHxyyi+wdtFuRb7RHpVvv80I5SjFLXShLRcF/eNVV
 zwFJcq3cPrxR02gg1MGpDQWO1w4OJH09DhGh0acSwDfNkFeZ5iMFPnEsGmUUe8npN7qKEKP0T
 JLmINkrDEzjVTQTibCr3j0iElKvkSS+XTbxAsDLQ4GQyDZWbTRxNh/z/lCfuH0HKo/corhOTH
 6W5jas0m3oUB7PH1YcO4hCbtD6G1dChzJa9sL8xUPu1eRAkiT0BkSsHGPex1cRgFQsiRdSd8L
 hgG73IaGMj5gCVJb+q1DPL2igxPBRMGsGpbF67HpCdhlHTmhblOIpFSxDEPGocY+1kqOxxGZ/
 X5dwBZtHgDM7vZQLzrk3pM3R3JTAS9tc3PyehnsyKoNvLmlu7rkKgkHEw/zLudPBVszDma1Uj
 7JSUqd3szNEC+wqPXodv6vRsBG/6bDwEY8oewXzNWsh6FR6e1HpmwddeS961xPXSVb59ijImd
 b17L+29pe6fPz7vlWw0Jshw4Pw0bbtOKq7xeE5kTUi7fvu0BDZ8q+FxVa+ILPOO6zoU9XBKoH
 eDnjM02YbAg+/LMIzS80wSHVY+2km/59ulwAyLCLp1Jw4uTd6DQGWElTPk3MmL1CnxtgtxQnk
 0IXvRr1Z/1mknqqHoT2JSpJBJXqt7OdpFjNp11+utgEsAXyqS0UDxrzYNh9ZL4pKdMKelv7Ci
 lcz4aXceM3tTXT4lNu/i+EpXQWH9PHEE73tdzT+36LZLKjY1GfByoPe0C/jY0F0QbpeKR5JuU
 ajTkPsl5CybcPvjExrI+73bQAMDRCIcJYUb02d5pKoLLcHYAWDTe3HwkrNTuxNqADuEjzgmiP
 PfG+yBiS7v4E+sAD7LXHmY0xZqxksq9bHCLP8dF8eigHreybn1zyPjIhSGRU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--z17Ov8C1sqjzhPJ9kFI9oGxMRJOTO8ZgQ
Content-Type: multipart/mixed; boundary="1zS7lcwe1UTBMmy64vzvIan2e0uoASz7D"

--1zS7lcwe1UTBMmy64vzvIan2e0uoASz7D
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/21 =E4=B8=8A=E5=8D=8812:36, Christian Pernegger wrote:
> Hello,
>=20
> I've decided to go with a snapshot-based backup solution for our new
> Linux desktops -- thank you for the timely thread --, namely btrbk.
> A couple of subvolumes for different stuff, with hourly snapshots that
> regularly go to another machine. Brilliant in theory, less so in
> practice, because every time btrbk runs, the box'll freeze for a few
> seconds, as in, Firefox and LibreOffice, for instance, become entirely
> unresponsive, games hang and so on. (AFAICT, all it does is snapshot
> each subvolume and delete ones that are out of the retention period.)
>=20
> I'm aware that having many snapshots can impact performance of some
> operations, but I didn't think that "many" <=3D 200, "impact" =3D stop
> dead and "some operations" =3D light desktop use. These are decently
> specced, after all (Zen 2 8/12 core, 32 GB RAM, Samsung 970 Evo Plus).
> What I'm asking is, is this to be expected, does it just need tuning,
> is the hardware buggy, the kernel version (Ubuntu 18.04.3 HWE, their
> 5.0 series) a stinker, something else awry ...?

Are you using qgroup?

With qgroup, snapshot deleting is still a problem though.
(But not for snapshot creation, that shouldn't cause any slow down,
unless you're using multi-level qgroups)

Thanks,
Qu

>=20
> Cheers,
> C.
>=20


--1zS7lcwe1UTBMmy64vzvIan2e0uoASz7D--

--z17Ov8C1sqjzhPJ9kFI9oGxMRJOTO8ZgQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3V7Z4ACgkQwj2R86El
/qgunwf+JzpL19RmwVHCBLoCMUXRux3tg8GkL1SPB1ejb0mgpNoRTS/kpgmVi0Dm
nHU2CjgNgU7PfIKD7KBymBvLKkAcU15aDPe6QzjbwBTXgHYc1TFRMF5jKEl+tLsp
JktFX7Eh3M4mUYI+WLUqd3k/VDuZ8RZl1AnH5TTQSWvwO0KB/OKhm6ct9S9ppbX5
kdgkCE8ALR9Dz9US7r3l2dMaqYj/SGszVdIMqKuzRa+rX9AoOZf2sBbf5SjrsASR
evLUgybjvY4h1NPQHlDzCiDULkRLxlk/QGugrMFpWdP57uhLyz60QXbDP1zP5Hjv
TWxiJSr+Ytcs2MLkC4e2E4oEFEfrsg==
=ty7f
-----END PGP SIGNATURE-----

--z17Ov8C1sqjzhPJ9kFI9oGxMRJOTO8ZgQ--
