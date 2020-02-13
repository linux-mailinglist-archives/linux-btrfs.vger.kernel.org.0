Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 805C715B5D1
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 01:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbgBMA0a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 19:26:30 -0500
Received: from mout.gmx.net ([212.227.15.18]:60321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbgBMA0a (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 19:26:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581553586;
        bh=5Pa/3TMKhXgeoY7Gk+c4FKNng5QU1xlqj0KtoWt2/7s=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=gYKyicsdYVklAOBSyjP20O7WiTsJxsMwV5Q4a+YO1rpFAmTIKaH3dAIR8EMJCPVF4
         B+wJrX9DKZ9ZM9LnMW4R6LE55yGodUQZ5KzPz5yU45JJWNLD3VoLV88RucJzwU/WSx
         yYyeVgmKs7U0N8T++/iGRVkIBsFELD771K0ucMXA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N5VDE-1jZXTf2Nyc-016ugX; Thu, 13
 Feb 2020 01:26:26 +0100
Subject: Re: read time tree block corruption detected
To:     Samir Benmendil <me@rmz.io>, linux-btrfs@vger.kernel.org
References: <20200212215822.bcditmpiwuun6nxt@hactar>
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
Message-ID: <94cb47d7-625c-ab36-0087-504fd6efd7ef@gmx.com>
Date:   Thu, 13 Feb 2020 08:26:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200212215822.bcditmpiwuun6nxt@hactar>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jKRTIBlw3GZNOh2B7X3YI7m9L78Q2zBm4"
X-Provags-ID: V03:K1:HtwOyLbzpCTQxmctcpbwVoIqRjEugKBPX+sHhV45mxFBA+JbRmB
 bvO7MwyGtTHhhqM7Oa9Y0iwpUQCI5oaX5azBvrVgdaPZoe4SzSwUIUVbgnEitjV8cx2fAbM
 JbT6KcR+7xBnHGgAOkMjhefoxdIe4KFKnLhYzQkfj3OwnylRVBMGsPES/QD5Cixh1i6gYM0
 n85I7ctigPEIDIfRYPM7w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gRMSRyVBm8g=:aG1SLJop6cuEAYyQY2gDlr
 Fg7m1ixlZEXGKdfrXEHhUNADZiyx6mntLEnseXic/ahpW4Nuir1U/lLcFO6ETlcPnJxitmug9
 +K7p/eIi3BggnTQOk7PAyykSy4zl+DqJ3rxZp/pv2qGlG3m+OSlXq4+HZJHZDH281vVocutWQ
 vUf32Iw9U3rxivathAHwD9uE8lEk53BpSMtJBd0jLz7bhlpTXK1ri5080Sye7+53myRkDhraA
 5SK8473kD0tWU29RdzzPgA111C/CIsXuHq3gicdPX54e099o87GibhL4bnEEBOebSIlC67olo
 hNLtWaTfrCDxrMU2Mg3gaixLPI12hFTxpBLih64BnAns9PNi8n8TkcxcgYFEHbfHxCNO2sCXi
 Ioqckkl965h2MbDTRnHVSTMfxoopy9wmkMbCmGnxHc+T9ED/5C1UvUXIVnSJ+k3C9QmFpaOfl
 zNlvojXnFydkqKkSHPvRmxRTYl3ytr4b5jCewXv1LWrYOTfkVK9Rn0PY0VQ/kRY7A/gmXcsc8
 W7BpmjnuvyA8st2dFBREJLJnjQYOfMIonUDvRUYuANiaV5PUl/MK4xNtyTEjb43MrCH7RODDR
 MEybSKRJyXlopogOjoo7iHLXnJqq6/jvalU7FjBNAHEi+dyYG2BpLHQsqFeY1ALBDKoSsJRS2
 NI0I9D5tEIS2QM6/RO13Q6gOnrnxunIkE9inXKSgllRa/WiHHYftkbHnCDlqXB2W27vdGxkru
 KMl9jLUXB00etSA8PH6EpkDJf365IgvBvdOkpRCZRNPx9jsxGKyJjN8Bohguk28vg5NPzzjN/
 KDNFobrohzRwB6zCuIVVND60RmzweTvKOK0eUP+0538GpVFndn/Jg+dziQbdGdgTixChLJ2cQ
 g7aTIJOR/ZJrdydjvPkAHUdI1R2aJLKEjCe77PJwKKFY4qBH07GjpM4IJwKJawhGawY8ybnOs
 7yd0gQXnH5YEy7CIva3e6ZK/8tWMNqcwTLa7BbqQj7buNceepXEetY8UwjUxhBaURiU/RiAHC
 KClba8M9A+N0XAlja9Je1l9O5fG59Oj0JoJUWwe7VSYRlLX0nV4nk93OejPqowFeSsZ02U5z4
 c2wpH+Bc/pUNMrah4jkQeSkAl4a9RIE22xOQLx+XHk2IvE/hWUVd/8QdD3zlolkACdixcKDg+
 AepAhVKG/bJ8/vQo8xP6R2jX+jvDzo8u7qRrOXek60zhfsgpU46CvZivwZWJGSi3bZ/RYoIlD
 tb4J9Q7l6exe0htmx
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jKRTIBlw3GZNOh2B7X3YI7m9L78Q2zBm4
Content-Type: multipart/mixed; boundary="bpb1cv9hzIDwZT5N08rEDzL3IYUyfwfs0"

--bpb1cv9hzIDwZT5N08rEDzL3IYUyfwfs0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/13 =E4=B8=8A=E5=8D=885:58, Samir Benmendil wrote:
> Hello,
>=20
> I've been getting the following "BTRFS errors" for a while now, the wik=
i
> [0] advises to report such occurrences to this list.

Please provide the following dump:

# btrfs ins dump-tree -b 194756837376 /dev/sda2
# btrfs ins dump-tree -b 194347958272 /dev/sda2

Thanks,
Qu
>=20
> BTRFS critical (device sda2): corrupt leaf: root=3D466 block=3D19475683=
7376
> slot=3D72 ino=3D1359622 file_offset=3D475136, extent end overflow, have=
 file
> offset 475136 extent num bytes 18446744073709486080
> BTRFS error (device sda2): block=3D194756837376 read time tree block
> corruption detected
> BTRFS critical (device sda2): corrupt leaf: root=3D466 block=3D19475683=
7376
> slot=3D72 ino=3D1359622 file_offset=3D475136, extent end overflow, have=
 file
> offset 475136 extent num bytes 18446744073709486080
> BTRFS error (device sda2): block=3D194756837376 read time tree block
> corruption detected
> BTRFS critical (device sda2): corrupt leaf: root=3D466 block=3D19434795=
8272
> slot=3D131 ino=3D1357455 file_offset=3D1044480, extent end overflow, ha=
ve file
> offset 1044480 extent num bytes 18446744073708908544
> BTRFS error (device sda2): block=3D194347958272 read time tree block
> corruption detected
>=20
> I can reproduce these errors consistently by running `updatedb`, I
> suppose some tree block in one of the file it reads is corrupted.
>=20
> Thanks in advance for your help,
> Regards,
> Samir
>=20
> [0]
> https://btrfs.wiki.kernel.org/index.php/Tree-checker#How_to_handle_such=
_error
>=20


--bpb1cv9hzIDwZT5N08rEDzL3IYUyfwfs0--

--jKRTIBlw3GZNOh2B7X3YI7m9L78Q2zBm4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5El64ACgkQwj2R86El
/qj+mgf7BMVmlf9v3/khi0o88Q9T55JnF9M1AzC3n9YCmCwJadf5sHQiaP4ao9Tf
uqZ8nChYTiSrRFLwjD5aHkX5uyU6OUpFrvdKpyQsmzEecPuTMPNX9CjH/srhsy3I
bVct81ckyzrXUGLXsNWTBRQ8a8HfYA4g5/73N0Q6F78CvPf9WwroaApS2SAtiMZ6
/eCqOIxkYKalWZECeV8IU1qM7bZoGDixh98FwGk3oxb7npJ4spah3LtnXvmOR5fi
E0yq03RRRMNR8w7IfDO4acmFzLFp8ul1M2iXdhbeUcwc8zyAczXNtNxT8V//BxBM
s5WElXZVa5rqyiiTXaieamxo61aqPA==
=KYjD
-----END PGP SIGNATURE-----

--jKRTIBlw3GZNOh2B7X3YI7m9L78Q2zBm4--
