Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58378F6718
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Nov 2019 04:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfKJDii (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Nov 2019 22:38:38 -0500
Received: from mout.gmx.net ([212.227.17.20]:48293 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbfKJDii (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 9 Nov 2019 22:38:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573357106;
        bh=ZnduHHXyIj3oubQx/gYuhgaHBshwpAhhxewD0xWXask=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=QaBIp5wZUlh5cWIlNXEn/7RKCO4wGA0zB3w1UQXiOkGvz/BmzQnWaLyATVME34vye
         b4BpMgFwaI+brCklqDTwYGOZxzpsE/6s9iKzMNjSjU9LzcFcjt5ZenSFsUA8FTfjAA
         IXpEfGvWxbeBrtmzOXZ2kgpeh3DTEOB9GjOw8Wdg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBDj4-1id1yh0xHa-00CjwO; Sun, 10
 Nov 2019 04:38:25 +0100
Subject: Re: Unusual crash -- data rolled back ~2 weeks?
To:     Timothy Pearson <tpearson@raptorengineering.com>,
        linux-btrfs@vger.kernel.org
References: <344827358.67114.1573338809278.JavaMail.zimbra@raptorengineeringinc.com>
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
Message-ID: <5d2a48c3-b0ea-1da8-bf53-fb27de45b3c6@gmx.com>
Date:   Sun, 10 Nov 2019 11:38:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <344827358.67114.1573338809278.JavaMail.zimbra@raptorengineeringinc.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XmyUA7GO9B55YbzlRybVgTQ7zoJ1gSwVO"
X-Provags-ID: V03:K1:+/h/puFjAnerevoZVsaZs/rnX5v6MWR/YYMyFCg/PT6g8tpJZ4T
 ccKWYxxZ97Hs3LIAs5I160ngt88shYZI9vglQgZ2TQFOQnMVysBzuTIMQf+vZ5kf/2J/CB5
 DgokSsU0LZiXxDxZXaap472ywwKrbsRj+UveO53icZEkuf98+gKTBRc5JtelmvQVCWFkIz7
 wReyPkmUnGkqTpLXZ4Gdg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:C4W+YB8TAi4=:LzLiufx6ihSFuiEoZRTMIz
 FwUn47c0EslfXJZ3c6Leso6dBQ3HGlEnLnfBC6dLadv7T2egPob5CCZX2yKjrikg57t3UWrO7
 jugRj4PIf1YCE+fQ+/FcNjTqdT0S0aSzICWv57w4kL4U1tTaXZKF1P6FQldea7EDTL3phTxqo
 g1YFZ8bSMIdF0yw/CbniABkRwI4nXG7M03DZQr3aKUbPnwhfbPC6S1OQTyN6VqYq8YkMEgHA1
 OHTgOvfEEn4XOBvPypwcED7g5l734lzK0wmZQqKf+2nwgypsW9x0ElNeYbz20RUMVT4vOf7wU
 39MO6uILsWA7aROSIZgQysnmpWs0Xt4bBibwaHLkjUt7gz5UxLPgKsMqiN/2XbNn8vXFeLMRy
 r93BYmXOt+N4IANuH154ER6l7sus29CJeWX2IGTFtldjqFzu+Vbq1coC70rNTrbIo8MY7CKuc
 DEtMv/1vpje65yEghpDFkmGYXJ9qDp1FrMFauC0fu07s6HG1+1U3p7kBybIIJJk6legN0Xu9S
 JtadK9eTxwsxcmdidDU/wRy4BrOTkxWMti7FDZI0Q7eqpHUHplXRcY+xwZ6UQnV96KrAjtx++
 pDh6a4Tf4zg1RBEYG/oHnlYwEKExjSqBnOUxdIvfSkCeICNybSoQofl5ck1F7X8uetdb+w7rj
 Lb0WWYL0VuQF3yIdagBAb110DV9pKXAGz8JKJn6XTcjUSr9Mp9hGNwabQeOwRklkckOwksVTI
 r3xJBszwlfvMw2WfLrhVRJBj4Ckj+ACco4d2QCC3DKmVd0IWPxBQttaJfsPk5Oe6Waojm83Xr
 iQyD7mDTVE6I6F2HkzsQu2a8cAzaRU5B4y7M2rAY1uemVwca/6nIqCGeZAFfeyqw6egbmFzu/
 6pN4ILccxzQsTA+fW1UpBuJE7YTdEKl2fuNGG0z17oZBKr4Sk/gFVrInENdKCD7S3Vx8/kocp
 /Ao/2/bbdyUpMui7NA4nR5fmlkIYCq/FXyvzjzu+jEijdBJciFg6GvypDsCUF2niOvS7bqNwT
 ZCZmebVwt6LBddDfeOOfSxN6tZbfL/R3KakY5KqU5X/ZDk2L6+QhXHL5/30LgIcOTbp9prITg
 aGMqIB3hZBztuuKCTGeFRn7ksdto+V0PvcErgSUaqMvKF+eSBY1AWP2o0DjCWlCuP89JZt/WU
 McZpwseT23JpvwlhWHkHoy7znNVBlwX+R7SZexO49HH5rUek981pV1JDIDrsYXaDU4NYpyKrM
 yFTtPRETIx+PJL+I5yFPTyqTWkUZgRfsg7nv6aH8KTXr09jF0eFpb7CMRK9M=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XmyUA7GO9B55YbzlRybVgTQ7zoJ1gSwVO
Content-Type: multipart/mixed; boundary="jCkAixAYdsDjOPWxJSJuzofy1YwhFF422"

--jCkAixAYdsDjOPWxJSJuzofy1YwhFF422
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/10 =E4=B8=8A=E5=8D=886:33, Timothy Pearson wrote:
> We just experienced a very unusual crash on a Linux 5.3 file server usi=
ng NFS to serve a BTRFS filesystem.  NFS went into deadlock (D wait) with=
 no apparent underlying disk subsystem problems, and when the server was =
hard rebooted to clear the D wait the BTRFS filesystem remounted itself i=
n the state that it was in approximately two weeks earlier (!).

This means during two weeks, the btrfs is not committed.

>  There was also significant corruption of certain files (e.g. LDAP MDB =
and MySQL InnoDB) noted -- we restored from backup for those files, but a=
re concerned about the status of the entire filesystem at this point.

Btrfs check is needed to ensure no metadata corruption.

Also, we need sysrq+w output to determine where we are deadlocking.
Otherwise, it's really hard to find any clue from the report.

Thanks,
Qu

>=20
> We do not use subvolumes, snapshots, or any of the advanced features of=
 BTRFS beyond the data checksumming.  I am at a loss as to how BTRFS coul=
d suddenly just "forget" about the past two weeks of written data and (mo=
stly) cleanly roll back on the next mount without even throwing any warni=
ngs in dmesg.
>=20
> Any thoughts on how this is possible, and if there is any chance of get=
ting the lost couple weeks of data back, would be appreciated.
>=20
> Thank you!
>=20


--jCkAixAYdsDjOPWxJSJuzofy1YwhFF422--

--XmyUA7GO9B55YbzlRybVgTQ7zoJ1gSwVO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3Hhi0ACgkQwj2R86El
/qii7gf/WEPaUGu942WV2ZQDOf97N//gGdWVidmVKfatD8MwYuBppPaAFo8BGOwo
OepxMWVYaZ7ldtDG3g78hQf8N5rTlKninQaFtppfUwCJpvdJk5VlGOFmdrYbLXwm
kE/QgEZebqwQshl9Zbs0a8meaFMloXSCvxClGKq3DSfgTb+Y8iYz3qz3ce/0BHPW
ngEkb9eHJJnMazsNxdU0y7uRbCD8yW9QjXlyeuHOwjgvmSyzovFyO13Ewzm9pLfo
5o4zQRO75YRrMReEVWbZGgBJn1/2Cr6k2eodJ05MVnTvr7vEgtZTj0ClxAIiZ8RW
t3AqvUrqTiFmWOOhRtaX6q7AjIM6Vw==
=xyi/
-----END PGP SIGNATURE-----

--XmyUA7GO9B55YbzlRybVgTQ7zoJ1gSwVO--
