Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F243A1434A7
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2020 01:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgAUAKO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jan 2020 19:10:14 -0500
Received: from mout.gmx.net ([212.227.15.18]:55381 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbgAUAKO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jan 2020 19:10:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579565411;
        bh=zRX202gdSHWKiNvRWPfrDyM1vnKcGpdnrahj6YYE0Po=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=KyyjXUW5dDIMASZQJciAuw6w0Y4zer3yz9pFaocyojvwZ71anbqrT8WTqcXYzIGh8
         5V3IX7V5SOaZ7xFaBMajhAUhFy2b37ViYjX1DuEtsuNaV9AAs89uO4cKLBgmbdQHo1
         j6hvRFeqVLSaGv63pokpCi6ZeFmttieyHc0EpFSQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MDQeK-1ijHnZ1XF8-00AUsY; Tue, 21
 Jan 2020 01:10:04 +0100
Subject: Re: BTRFS failure after resume from hibernate
To:     Robbie Smith <zoqaeski@gmail.com>, linux-btrfs@vger.kernel.org
References: <CACurcBus8d2RYTtVOheAvJcohY5jmP=akKUw1hen5seccfGihA@mail.gmail.com>
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
Message-ID: <91be9396-4142-94ba-ea79-0baf8dc4800a@gmx.com>
Date:   Tue, 21 Jan 2020 08:10:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CACurcBus8d2RYTtVOheAvJcohY5jmP=akKUw1hen5seccfGihA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XVHqJHzEN9KEtR35WNLhnRvJJbXvs0AEp"
X-Provags-ID: V03:K1:a3OjmHFVcAhcM1hI+V7+9S+tbM9+RWxRE4j0rU/jz0bXYmtflm/
 ze4OvkEQ7dCy+2q1dcNR300wr6zU/ReXbL6ZgcuCwRvCu1ThsoddRchEYZjkdEzv14CGQWf
 Wsj8lFpirGGybG7p+Gw0hwDdxUtTrBhsZGm3/NSz6QvlnfI2s5RFVOtUY40pYzWVInjT6m1
 57Q6TYjGLy2c6odfg0U4g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3XWtYbU9R6s=:iedih5aZL6AtMlxTzW99Yv
 EJadF9vYPzWiPYXxc0Xj769wCFq3Hn/DHD/yNGPUF9i/pq47D6F/8nDYN+uc/P4otxVVikXzz
 BwwLfXz0i9VkdHyWI/9GxKQO3V+2o1wmMs7H8tq2V2OH/BQ6VOoOusgA/YU/3K+4rdW8ykoTC
 cf5SgrxknBAjR7WlvbB+PCH+T5cnd3wUOQhMf9bmSxVDQeVxhHYOQLa3YM1kqcnUZuB55229N
 p66EhflkQvA9VXNdtqXkhF7qClCR4roX3eppiDktvk/JV+2A14GXTAoTA97fhAXF4RuSZrOA5
 oc85HWvv8U25qTNTLad6lLFA4khysx3tw5r+Y1LHbqqsZNkrSalLDLuavB2Xc6Z3Eb7mrpCkL
 9GGAkmVFFKzKeprjBaKmPB5rTgp6Fm/d7eu07X6mH8eLQ6P7/ImBzSXCxx/gnGXPDLdSvAiX+
 8JYI1KKMfvK375dsrUyPjwZ6E2fMSQ4cK9bApEaRpIfkjZdKQ6vCNLi0ucVRJp6jA8iTvLbec
 4enER91t0u8rK0MiE5ZK9temqlEuoalz9qALNiBPmTCvr8iM93P/v8q0RuZBu4E2RYyUCkA5b
 4Cf5DjiMi/0NWLOVn6cNnVrHYRSQLvlW0rGNU759S1It3lzJq6pG1z+7F0qXrGssaOH1QTjyW
 fli/c+GIk+DfMG8mMsEZjO1kNWO1Ojl/0oxh7X0oAxoWu1FUV6KGaPwog5JfGwLYTdCE9zDNo
 Q8PZa1WCKZKOOr+XB2/BWtxSRU9yajcZcGh5AENm70iuM+2JkCWVxFP+/X7Pb8R+1zjXvSdxa
 4O7o8II6g8KLgal4GXGQz3Mlxvpp4b+Zttj3QB04LpA3p5gfmMagBkBI9w2cadv10ea6fvMpD
 f071JxqU7pzaM3wGoiv5tclcZU4IOo7Ay4hV/FmvsnKOpAqKS8G6Yji09QXJ54CXOkBfeixY7
 ju6bViu839izgiTx8hsuaHsWqjIqxWZltxDmBwqbamB4D1XmiOUeS8v9eHFgzw+rEog6rg6N9
 45NepF6hIzRQhF+92ducuj3evMet0h4PrzfpV/SOJX2a6YmDMv6FfxGqHYNl8RE2Wfb0pRyaD
 P1bM7hhd7X+ZDT7UdNxWLmzqDC6HNJZ3OHqKNZal4oB2R2aJAbS1ERMVSKx/HE0Oeo4LVhYQc
 sbxh4gALSQ03hT23SBMPQ0mP1G7iVgTZGOAMDB91MTFRgQ9LAYhDoOD3smhtH3HBxRX0oJ7kY
 NztbMlqdLEeNFu6MBz7JevsIHkG1CK+gUICJykp/oJERNt/+UzmCE3xGvLXw=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XVHqJHzEN9KEtR35WNLhnRvJJbXvs0AEp
Content-Type: multipart/mixed; boundary="HppIeSNhw3G3kOZQdXXn68398HRIFxDBn"

--HppIeSNhw3G3kOZQdXXn68398HRIFxDBn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/20 =E4=B8=8B=E5=8D=8810:45, Robbie Smith wrote:
> I put my laptop into hibernation mode for a few days so I could boot
> up into Windows 10 to do some things, and upon waking up BTRFS has
> borked itself, spitting out errors and locking itself into read-only
> mode. Is there any up-to-date information on how to fix it, short of
> wiping the partition and reinstalling (which is what I ended up
> resorting to last time after none of the attempts to fix it worked)?
> The error messages in my journal are:
>=20
> BTRFS error (device dm-0): parent transid verify failed on
> 223458705408 wanted 144360 found 144376

The fs is already corrupted at this point.

> BTRFS critical (device dm-0): corrupt leaf: block=3D223455346688 slot=3D=
23
> extent bytenr=3D223451267072 len=3D16384 invalid generation, have 14437=
6
> expect (0, 144375]

This is one newer tree-checker added in latest kernel.

It can be fixed with btrfs check in this branch:
https://github.com/adam900710/btrfs-progs/tree/extent_gen_repair

But that transid error can't be repair, so it doesn't make much sense.

> BTRFS error (device dm-0): block=3D223455346688 read time tree block
> corruption detected
> BTRFS error (device dm-0): error loading props for ino 1032412 (root 25=
8): -5
>=20
> The parent transid messages are repeated a few times. There's nothing
> fancy about my BTRFS setup: subvolumes are used to emulate my root and
> home partition. No RAID, no compression, though the partition does sit
> beneath a dm-crypt layer using LUKS. Hibernation is done onto a
> separate swap partion on the same drive.

Please provide the output of "btrfs check" and kernel version.

Thanks,
Qu

>=20
> This is the second time in six months this has happened on this
> laptop. The only other thing I can think of is that the laptop BIOS
> reported that the charger wasn't supplying the correct wattage, and I
> have no idea why it would do that=E2=80=94both laptop and charger are n=
early
> brand-new, less than a year old. The laptop model is a Lenovo Thinkpad
> T470.
>=20
> I've got backups, but reinstalling is a nuisance and I really don't
> want to spend a couple of days getting the laptop working again. I
> don't have a conveniently large drive lying around to mirror this one
> onto.
>=20
> Robbie
>=20


--HppIeSNhw3G3kOZQdXXn68398HRIFxDBn--

--XVHqJHzEN9KEtR35WNLhnRvJJbXvs0AEp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4mQVgACgkQwj2R86El
/qjDigf+McV7in0LlOmMGF0xsUOddfX876rSEjjZKxHQ837nXN2vgv7L7WsulcxG
ZgG8XVbma4oJrZPm57RP/lK/2QPyB7H3KJ29/R0AjO1C6+yCcgJRlKYALwVlphpv
o96K6ilpth1a7mnRS138NLv8v/6TVhe4IWD5TComV8oUCAMfxUk9/G4R0NT2LKLY
GUaW4wUjAEKu0eiNmPaXjYY6Rulf90wa+23mg5ersJSsFyAybz8n6+mKPZlXlzjT
nqLJ1faK+INC2zY8WwMsClR4AqNrVX1cYlj6GsSwGz/OvAr1vWSmtXQdmNyYWaR6
KxUAmYNIGoOwhW1zNc5GfliWQCFdtA==
=ZDnw
-----END PGP SIGNATURE-----

--XVHqJHzEN9KEtR35WNLhnRvJJbXvs0AEp--
