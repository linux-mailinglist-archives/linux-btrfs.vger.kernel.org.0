Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31293F1533
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2019 12:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfKFLe5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Nov 2019 06:34:57 -0500
Received: from mout.gmx.net ([212.227.17.21]:34899 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfKFLe5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 Nov 2019 06:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573040095;
        bh=bT4B4/ZOdIoeTcbbGJFPa8JB6wbkiD4DQWiuAOEXLUA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=RAPrVRqxymAArXnp/y0bV7KM4imsnJaXPVrr4zdW1CM6uDaqHZcdIcmVu9ZICqfWv
         tvYVVQ1dhYg8DPGvDQQiroq9R46Jr/SfUnbmIAn0HoR5XEF1tUWTbF7h6oLRjOhOs0
         4M9L/cGrWzCH/1oQ+X6EFV0WW8lNx1+ApBDyBGJY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M59C8-1iTPVx3HzI-001Efu; Wed, 06
 Nov 2019 12:34:55 +0100
Subject: Re: fix for ERROR: cannot read chunk root
To:     Sergiu Cozma <lssjbrolli@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAJjG=74frVNMRaUabyBckJcJwHYk33EQnFRZRa+dE3g-Wqp5Bg@mail.gmail.com>
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
Message-ID: <187ab271-f2be-9e96-e73a-0f6f3e97655a@gmx.com>
Date:   Wed, 6 Nov 2019 19:34:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAJjG=74frVNMRaUabyBckJcJwHYk33EQnFRZRa+dE3g-Wqp5Bg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xuz0TwVCN9bagc8CYC23HRXC8Ws71jM3f"
X-Provags-ID: V03:K1:BtvToFk7UoY1vNyWnymvp3AsyJ0p9L09qMVzsHqcK8zQJqmlrx1
 G31Y28e7BJqGgPltx+HweCjn0BFjMRfkHjLi78K71UVkTgk4wotu1qBlT1Yjur9YtYDtWaD
 SgZpmppGNn03cBEOcSwTw8Omu886M9+B+LJIytzTbZmyHiaOl7PHxfjirmYBCb6RIp//PvT
 0ck94E5hzyy3nKAO3Nzuw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4fic9liIFew=:PblMhx4xN8YHK/U9JQ7Xwz
 /XiXxEOmI4PDQH+LvTdvYC8BUSiZyTzmXsE35MC2l339SDk4fmq4BGXu1ZCAzaSI1rkqARM4o
 i0onryLDiRH5SixNE+qk1ALFowHIwa/zbjnq4QVZMWuxjFAjYhn0A01yy4Suh/Y+RJu+kw9LB
 Wz1j8JudfTfsGIPh2ccKprgBq2RUM+KuvpcO/0uqTBA/J4Oyx6CILlUIYfVk5PFaYSjBp/0dh
 TReAsL4UMRzNbdY7ZWIjN2v2YjoniXbWOGkdjyO9+oXzbVdpIdxtO1nhMIo6mG7ivj0XAn0Wd
 v9AS0qUzHInwA1tEcQBqhWCpYaf91+DuVT+1LKI+8E9Ay+wGB+0BtRbZHWdt5CTTFibnMIynw
 hIk4TYW5lAV9OlvQIw0gM+ObL9I/B/lTKssNyVzc5Qv/fggohazbe8Ofr/oLwYK0IOXz771Yh
 CDt01glY9R+X387t/vuNH7zJN7LY0bgurr0dgopXQj/fheHN1HvQ30oRDdDHrE6QEPBO1cCis
 VmGSCjSQybFK0yo0b0qbUr8z6zuJACxjxAF03PjPkB91C0cRScVx6KAN79RyA8Ne2RL9plNJj
 B41yLWN9D7HHzHY/VoenZfmafYJ/ZkEBUmsqb9wWUh5HT2NZUh1BLddlGrhsSFZ+rkstd/QNj
 e2f7m4IRdCMOGstx8g6fOXm2b/mVJMJ4aD7UDhas52GA89f2ABrU21uCI0oceN3+N7V82ObBM
 /iLhj+PragQytIVqnbDntiDzfgV+F8LMZCwkePASdX2Xa1rV+o44gHIl7xYCr7mWFWyOAFYpt
 cQXjxF6F7yV6JjHrk6OYm5PYWbivf3kmDZ4wHAL0fnoZ/DVFVCHvjwoSAFTXAxkIxl0zrqeKy
 N4ZM51DJ/HpIvJgG4aQY+6meZMUI2qXIaTq9DdkrZH5c0gOyUO+Z6Kam4TPecPtCyHnSKS6qZ
 l15Qx860gHvVSrOzrlAezYqQhA5SJVz3r+9FsEQAEg3QlbX07yxC7JwM8iNisTysnq74gDn4q
 6yYh974QywthcOK3pRDoN3O6S6F6IPSgjnWqBrUYe8ZgSaPOeeoqFSmZftFaWVAdeLiL4de7f
 TGvJT+5hg/muzMyvX+lPR79SqiIEE13Ty9DlUG4pel0DwirLi1x7l/SZqkOrHJWGC7Qn6gFT1
 wJU+JFlGa4ypOdCtshBcYJQ8HWiiHzZwzm0v1IPC7VBUSxdPFfSEP2DOM9eLpGJ+VYifeLPJe
 bWcTEvFxia6tuu/IyJzbuvTRhwFUpX/iNlfE3+KsUDE8fxoqaKBxyqzuW4K8=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xuz0TwVCN9bagc8CYC23HRXC8Ws71jM3f
Content-Type: multipart/mixed; boundary="GwH9u187xPblKS0yaCHZHdKiRRiPruGve"

--GwH9u187xPblKS0yaCHZHdKiRRiPruGve
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/5 =E4=B8=8B=E5=8D=8811:04, Sergiu Cozma wrote:
> hi, i need some help to recover a btrfs partition
> i use btrfs-progs v5.3.1
>=20
> btrfs rescue super-recover https://pastebin.com/mGEp6vjV
> btrfs inspect-internal dump-super -a https://pastebin.com/S4WrPQm1
> btrfs inspect-internal dump-tree https://pastebin.com/yX1zUDxa
>=20
> can't mount the partition with
> BTRFS error (device sdb4): bad tree block start, want 856119312384 have=
 0

Something wiped your fs on-disk data.
And the wiped one belongs to one of the most essential tree, chunk tree.

What's the history of the fs?
It doesn't look like a bug in btrfs, but some external thing wiped it.

Thanks,
Qu

> [ 2295.237145] BTRFS error (device sdb4): failed to read chunk root
> [ 2295.301067] BTRFS error (device sdb4): open_ctree failed
>=20


--GwH9u187xPblKS0yaCHZHdKiRRiPruGve--

--xuz0TwVCN9bagc8CYC23HRXC8Ws71jM3f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3Cr9cACgkQwj2R86El
/qjHMwf9HXxcTpBv9WAXoHUxWSLNZw6kdYT+1r/O/pTEHBXPCeqxvlezJXorc9BN
BW5zCe6n5QGPGa0XNlBJ0ZSlQOpeiWrqvPuEbQz1yTRZNHrvGOG/T7oPKOVAIgNi
Otxe45Sc6dQt2hIUeuuI0vRw88SK2h0lCueZCiWhqP1nIM8hR8Ge0EDHhplvC+ie
DK0AXjPXB7xuiUezcZK9Jn2q4TTmS/mjXDI/i8oli7mZW8c8ofiaZa7m+kenCiLa
cBDO2GJrs9eq0gQ5+SL1BkVkBmqnuEcU5tsGqP/JQXlZ2zJvaVKytYdZL617d4h6
FwMUfjwZeRHJ4uwy2zwL6iLR7AYbiQ==
=ms+l
-----END PGP SIGNATURE-----

--xuz0TwVCN9bagc8CYC23HRXC8Ws71jM3f--
