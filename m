Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DE21CA3E7
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 08:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgEHGdj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 02:33:39 -0400
Received: from mout.gmx.net ([212.227.17.21]:35311 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgEHGdj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 8 May 2020 02:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588919614;
        bh=ZBCZX0fUUiQuWLw+Y9ZsVpos8GAUvFxtAMG/+GQzP7A=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=MGQCqk1RaEC1Dz4LsFW4mYWr5uNgye6Q+bANC05SipLFMhhHtcSfjQa1QbAJPfMHT
         xMNc9SGJiNnkci/qsn3AI132eCwX4alGC8NHU5TUXv9wJ7NPls7KyTuCYULGd+exye
         B1+v1jeKBoKZHRRUzMFLLypzsEnMziYXjETidelc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1ML9yc-1jp1gn2phS-00IAwW; Fri, 08
 May 2020 08:33:34 +0200
Subject: Re: Balance loops: what we know so far
To:     Andrea Gelmini <andrea.gelmini@gmail.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Linux BTRFS <linux-btrfs@vger.kernel.org>
References: <20200411211414.GP13306@hungrycats.org>
 <b3e80e75-5d27-ec58-19af-11ba5a20e08c@gmx.com>
 <20200428045500.GA10769@hungrycats.org>
 <ea42b9cb-3754-3f47-8d3c-208760e1c2ac@gmx.com>
 <CAK-xaQYvgXuUtX6DKpOZ2NrvkYBfW9qgGOvMUCovAjVBO2Ay7g@mail.gmail.com>
 <a7d16528-b5c2-0dcb-27fa-8eee455fee55@gmx.com>
 <CAK-xaQajcwVdwBZ6DhZ5EYax2FL28a6_+ZfsPjV7sqXeQ3RVKQ@mail.gmail.com>
 <628479cc-9cc2-ac05-9a0f-20f3987284f3@gmx.com>
 <CAK-xaQYTNCv8tA=_cR1H4u-ZCy80UFFNjP+CLM1=zuNhoU_x_Q@mail.gmail.com>
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
Message-ID: <8c82f8e9-297d-09a4-a3c1-f1cd87100f44@gmx.com>
Date:   Fri, 8 May 2020 14:33:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAK-xaQYTNCv8tA=_cR1H4u-ZCy80UFFNjP+CLM1=zuNhoU_x_Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="x1dIv1NQ371yGtFZlqsox4jAx0MGdYVHg"
X-Provags-ID: V03:K1:E3gakkPBH2Hd5UanyTI5G9L9uJ5RKoFI2G7vPTmWfhnjT3NDcHK
 RwprYNXblE7MFlB/+P09hSTiwvBRaxr89PskCv9KD8j+1aHjon8bwnKnmPKJECcgBj6Iqmg
 dVy+S27y+E1qDH4xJBuyPp9kdizFODHjtWQxsRicRE/h6al+ZzKE2mKYNqfLgIu1t3PKC2B
 v9Mzkzz2L/CBp9TPd1gaQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fJvJTA3YnFg=:rpx24LkpWPvzy8TKx8L/qL
 Vkm3dT75WY/RuGCi9kN9Nlcw56jtdx0gXNN54/CrRh6vbz10db4G2qC+ucns7fl234onk7O6T
 OwgcPB4Phde4OnsKyNIx2MmyvIoNGWiVuqFCM+MBN+4XYeZBNxkhtBifDNcKPPxOpbWM5b4gS
 qNfy8G6lsVwFQMq8hbFnesEDbztev++87XMuj10HrvQCVVU/zKEI9J1X+vdJ1K4Tv1E3nGK7g
 qLjtcSIaikzfInmRjFjcJlOS9HxaHQ7fASFBaKnzONHcQNucLucEWs1pZFIJQf1O/4EJKMWCE
 CrnnN+ZkkblGnmn4gVgPtBIMc2RT+9TdzPiQ4Kkelrxq/5PT5r7J7BgBVzeH8K4b5BYfHFe+d
 KiCoPxlpV2/iLLodlBN79HVPeIrpPuhCDXWUfQ8CQRVRbVUnWM3Tr2/MmizRftyPxNsPtJnAv
 lSErsrdLyGtt17nBXmrbabEumXkqCNb9dpU6BuYhYVw+kP3AQeqDf6kyKiY9EgqHiExlNjcqR
 lbOSgxLAgXvKKhNe4d4DzCn8zrn32FwAic/ydKpt47rALankwcuUWfwbUrkDWXIbr+ckV4kkc
 mIHZdbrpQBLcDw6iImAUJrWl5iCi1gSA4/ApNAjQIZ0Y58uOkIKHby/qi36bLD4ckqgPUq1V/
 IMpBVQYmMS9061mVEG3syJlBGke3+6zRjfx/AhqC9U5ILGEaAjb8XO94OjuOpKupuUsr71hze
 0rB8T3T0ZXjBLAgpi/qrHxwVRphCWZBS0fLfewXf4J2A/bjVFA3q2rJgRY/zBGFrTNS49x7j2
 /+FUSFJoLzbhjSymoAnDbMM+ZrQKtX3s5Irje/4UL9snvb2urSwYYRe+i71+sWOjKvuxATHW0
 apzMC5Cjyzg6WpCgO7PJauuKFYrgMKERfaePpg8ydBMsp44TBQT7fYwV72F3PkAzu2lVcvJuc
 NuSScqYkW7Q7FUV4DCPFGhmX3k30sMy2fUgsbxkvjQkv1rVJxcF2qXQpzvpIbymQY7wIAZXn0
 oYF/WY4SezktdfZXcllmQ8K8hm5fY86KFh3onVc+/FOQvMDWOUUwk29xX2kW6aIsxDnGzJ5dx
 dWYt9rjPjjKJtiWHyju7A6aTUI5iRufLxssxA99sc+ccvAn0JIHq53jJf4y8rM9hIPkCux7Ev
 RKbRpyYakpKHmzWskHG7qe5sO84ggRk9w9ncd4NiTTzupWs47xL9bv1DxxQawivXYbx3rL9kD
 i7/ozMpk4SVNXnT60
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--x1dIv1NQ371yGtFZlqsox4jAx0MGdYVHg
Content-Type: multipart/mixed; boundary="n9sFLX1y3qXDyCNfIEudoLlDjynpqGlII"

--n9sFLX1y3qXDyCNfIEudoLlDjynpqGlII
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/7 =E4=B8=8A=E5=8D=882:24, Andrea Gelmini wrote:
> Il giorno mer 6 mag 2020 alle ore 07:58 Qu Wenruo
> <quwenruo.btrfs@gmx.com> ha scritto:
>> Thanks for your dump.
>>
>> Do you still have the initial looping dmesg?
>=20
> Yeap, you can find the complete syslog here:
> http://mail.gelma.net/btrfs-vm/syslog.txt

This helps a lot!
>=20
>=20
>>   If we're looping on block group 12210667520, then it's possible that=

>=20
> Oh, well, from the syslog above:
> May  3 17:14:25 ubuntu kernel: [  586.735870] BTRFS info (device
> sda1): balance: start -musage=3D2 -susage=3D2
> May  3 17:14:25 ubuntu kernel: [  586.735974] BTRFS info (device
> sda1): relocating block group 12479102976 flags system|dup
> May  3 17:14:25 ubuntu kernel: [  586.833331] BTRFS info (device
> sda1): relocating block group 12210667520 flags metadata|dup
> May  3 17:14:25 ubuntu kernel: [  586.939172] BTRFS info (device
> sda1): found 26 extents
> May  3 17:14:25 ubuntu kernel: [  587.021568] BTRFS info (device
> sda1): found 1 extents
> (and then repeating lines like this)

Exactly, this proved my assumption, something strange is happening for
DATA RELOC TREE.

That last one tree block is from DATA_RELOC tree, normally we would
relocate it by creating reloc tree for it, and swap tree blocks.

But we don't need to be that complex for DATA_RELOC tree, as unlike
regular subvolume tree, no snapshot can be created for DATA_RELOC tree,
thus we can handle it just like extent trees.

Although I still don't understand why it doesn't work as usual, I'm
working on a POC patch to change the behaivor, hoping to solve the proble=
m.

During that time, if you hit similar case, the same dump would provide
great help to enhance btrfs.

Thanks,
Qu

>=20
>>   (Sorry, not sure if I could convert the vbox format to qcow2 nor how=

>>    to resume it to KVM/qemu, thus I still have to bother you to dump t=
he
>>    dmesg)
>=20
> I guess no way to migrate the saved state of VB to QEMU.
> Anyway, I have prepared a minimal Lubuntu 20.04. It starts up, run
> VirtualBox and let you to replicate what I see.
> It's ~40GB. If you cat it on /dev/usb-stick you can boot up  (no way
> to run it inside KVM because of VB need to access VT-x).
>=20
> I'm uploading it. It takes lot of hours. I tell you know when done.
>=20
>> If that's the case, it would be very interesting in how we're handling=

>> the data reloc tree.
>> It would be very worthy digging then.
>=20
> Good!
>=20
> Ciao,
> Gelma
>=20


--n9sFLX1y3qXDyCNfIEudoLlDjynpqGlII--

--x1dIv1NQ371yGtFZlqsox4jAx0MGdYVHg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl60/TgACgkQwj2R86El
/qi98gf9F3ha/GhJHBeobdDaB4pDXjaBhXjQ26aDBXpHRpIrmA08tkSg0DUgOW7l
kJ/AiMD0uixy+DJJ3F+LNyPa2Z0h+xcVxUxWcnghDSVF2+QvQ5OkEhyQIpJwC213
eUfp6lAPGUgSOV4mXgZs0gqW6ZmLKwsQ8Ucj8YasEJHiA3oeRSAQsoodxXLB55fn
xsqgdk0htCBE3SqNDYMCpN0dAjMRU0O31G0o0AL2MfC/SutggF6R0okIO2osyyIY
SagvvulpCn/X4GuWmYzrKRIqXxyq5TML0DJO7Y0at0Er00J5CNKRkk8jdzzw1mJx
NhD1D74vQDlTO1F80mQd+HbdvSyNpg==
=HQa4
-----END PGP SIGNATURE-----

--x1dIv1NQ371yGtFZlqsox4jAx0MGdYVHg--
