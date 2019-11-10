Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECEF7F671C
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Nov 2019 04:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfKJDmG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Nov 2019 22:42:06 -0500
Received: from mout.gmx.net ([212.227.15.19]:38769 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbfKJDmG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 9 Nov 2019 22:42:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573357324;
        bh=o5KsY8cVj7HcCTl2+PkeLBqJ0i93wkyk0b3C3qbSuwk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=KBFLh1cmDU8yg2LhGUjBAf6P+cuv5vD0EdnFfhHwjUqtgSfcQSefViP0c7xaGdUOA
         Bt4C/ozT2gdvAeyRPPpY2E+PpTRl+nVpPpBBvrXAdN815uBq6UZqdPTFdojQSvusZL
         NQFnwR9gj21FGNb+cSfV7YjknR4mw4Perx15KXSI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbzuH-1huaTU1p7P-00dY3c; Sun, 10
 Nov 2019 04:42:04 +0100
Subject: Re: Unable to delete device
To:     Alex Powell <alexj.powellalt@googlemail.com>,
        linux-btrfs@vger.kernel.org
References: <CAKGv6CrZ6bpMFtWJ5grJ8tsuV1GehEP07QaAmyZWkhj-ixTchw@mail.gmail.com>
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
Message-ID: <d6037684-d478-493a-d428-83458dc52be6@gmx.com>
Date:   Sun, 10 Nov 2019 11:41:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAKGv6CrZ6bpMFtWJ5grJ8tsuV1GehEP07QaAmyZWkhj-ixTchw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6jAqpsWgiwUnFnVszeRQIveNkrDFzW8O9"
X-Provags-ID: V03:K1:pCLz6CPWd0zB4pWQHJgOY4+gSHRjrTWoqYITIn4rszdarOWWwMK
 jj50G7W3UfbJxL8naItRyZWhA2W3L3fCXj5s9IKcf9ST0l8v2bmWj1n/JfH1yDeSKcAAtNK
 uPzvznNuZF7hvbSZrmxcao5+N7eWAw4xwbUAnQM5UTUh42RaC0n6s95V4zmf9xPRe8N7KlF
 YNutWq0GtjkZhj9STXKmg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jPjswNl1Mdk=:AT/58v2hhwZkJwSiuoaA3A
 qXeaMYhoGichBTy048xFrSdNtGLcoWllou1fY2QndCRZPet01fZvQ6rrmD93ytfTKE6G7hYLw
 fV4Gxc/tSRcxXIgyBxWy07Cq4AOzT6kyCLttpVa2xRJ+DbVUlzIRyRYMc8sKy5eX5UtWmXUUh
 KxqNE7M62bhL7tEt0pprHdTnby1udffjqNrp3PHe709lyRAQznZMFu1jxmsJDzk2/A1ONIk5e
 rP1+nBRtEGv9WgC8c5oKyxGMfL3g1sKPge3/Cmj3W+O8KvkNn8JyC7XQCul80YQr4dYPAP2Nn
 lE164KYheYMYFv4EVYJxz2hDII+9zBz6lnSjU/1CCEdhBlZjTVC0wZ8Pil9OXJOaUqohKjccq
 EIMrgYR21WrjUEdm0nSfVzab0DvqXixKu5hJV5vd13jGQc15OXI0YupB1Pcv1eV7ehlWZxpAG
 7hruw2U1VkFnSajm6SbB7o/j01KmgSnTCqp4ss6Or5KhS31XQ+ImneepwyqbVyCpID5olemgD
 0v4LBAuE5RvBlRgiOB/bVdlcj236AMfO8FFMHFmacPNzURxnf+cvhDIUTPm0TklTC/Xak/uhC
 pECsPxa7CYkc2zcotaIqqV1Ofe9xVOfYOKAQpAc/ezMbSXhcVzAFYXUYfsyIUxN2MLYfaNrQI
 ZR2lAveasBno1i1gkkK2mNI90AesWdcghaPjUSPuH/ca26UEiBge2zpoNHSGf/bp+lGlUFXOb
 LITGGralC3026eUXF5voJnksVMiFM/CL/InIyi5YlXN/YgVhlPJWsgeueV3OzInZfreumid62
 8KmQwVqAJBQt0JQLin3G8MwBPCVEc1Pa18fDD8HjN6b7Qxx8ZKMmNThowmk7MLu3AimfMb6oy
 I9HOFM+TM0mQ2KPgPJmeeaajUZRH1nNwCORmp6qb7HjSsZhr7437MiXZdkfh+3gogZXoRMJBD
 pRPDnITHmWts4eMXc1sFeehfnqtdtIqHlXgnWSKlvawJvCIUbjvu+xQnJETSzSamfdNNsQGfd
 on65UzvFPYMgZ+RigcZiU+qB7+rj8ZErUmdJ6PGxJ6dFZxmEcRUzq7ldKESs/B7JRY0QQ5s4h
 Ge3pk89C5VaZowCjr7WO3aIf3pmJn5qKYu4b/YqYgYMjDA31paZJI5Ut/8EKXSrjoj2H/B5IU
 Qp5VDHYP/qTZrozBm8DT9Z06AR4lEOuOaXXoRBGEnY+0EIiEzrDBbHhHHEWvzo3opz3no5XcF
 wNM3BuOH6Q0Ew0TVI/S8l9hmFLVmENBPKbH0Vk62hmu0NmuuMP5QkO8941AY=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6jAqpsWgiwUnFnVszeRQIveNkrDFzW8O9
Content-Type: multipart/mixed; boundary="u1jDF4SFaEa5G2bzE9OS7AKOSPwXCc5F3"

--u1jDF4SFaEa5G2bzE9OS7AKOSPwXCc5F3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/10 =E4=B8=8A=E5=8D=889:14, Alex Powell wrote:
> Hi all,
> I had a disk fail on my BTRFS RAID5 array. It is still mounting but
> there are bad sectors which will switch the array to read only mode
> when used.

Nope, regular sector shouldn't cause RO mount.

Dmesg please for the RO (transaction abort).

>=20
> I used "btrfs device delete /dev/sdd /mnt/data" to remove it from the
> array. However it seems that it is only partially removing it from the
> array and when it gets to the bad sectors it fails.
>=20
> localhost ~ # btrfs device delete /dev/sdd /mnt/data
> ERROR: error removing device '/dev/sdd': Input/output error

This is another different problem.
Dmesg please.

This can be caused by bad sector + failed to rebuild data.
Please keep in mind RAID5 of btrfs can't handle write hole yet, thus
it's not ensured to tolerant one corrupted disk.

Thanks,
Qu
>=20
> What is best practice for removing the drive from the array in this sit=
uation?
>=20
> Kind Regards,
> Alex Powell
>=20


--u1jDF4SFaEa5G2bzE9OS7AKOSPwXCc5F3--

--6jAqpsWgiwUnFnVszeRQIveNkrDFzW8O9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3HhwcACgkQwj2R86El
/qgYxAgAmzUOzdVtFvHp4Kro/uEFOGGDqdsksITFIYG4KanXG7be+k3q5gOlUZ5f
HpoWlf6hOdWfu93qa0O5EK4zCEQYoEJWgz89SNmjpp3y4ISV14Cpqp0ynqCGNaWf
Z/pku4tAS3u7JMC+r3apDh716cqueMdn0U5eXejPkEbV9BFXMwCI91v8C5bsgJaA
3eIhZ6Y/yKVfG8rNEKy70S34hnZ6Rl8R50FPJ3ZUVxtMwkWuHjzXutfgJ0VMw3rT
saCMN3jD8yx/utsXcOO79dyDZI/+TSNkKJFip3R/UAbtx4H+Pgh4xAcHLc0NmEa6
4HlstTYgCZMpJ6kZyI84Vs+UA8EL5Q==
=gDn2
-----END PGP SIGNATURE-----

--6jAqpsWgiwUnFnVszeRQIveNkrDFzW8O9--
