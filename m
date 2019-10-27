Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 720EEE6020
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Oct 2019 02:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfJ0Aqs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Oct 2019 20:46:48 -0400
Received: from mout.gmx.net ([212.227.17.21]:59853 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbfJ0Aqs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Oct 2019 20:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572137205;
        bh=5r2vRHFrEvoblk/5ev1kaOazsVNdz12LxU3mAhFbJRY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dikNN+F0Vu7wzZndRIrkqkuI12FdQHNXIlQWA6oTuafQom+qC6576X9dl6OsDPbj6
         GHIxZvRuoZPXY21U7Qm3enhS0+vtC7GUVZRrCuojLKOzJuMJHovFGmCSsxd72cHxM5
         rtL0XXE2jxNZ6FFhLmheL028M9R8UOI72omc5oMk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbAci-1hrNkK2Gt6-00bexF; Sun, 27
 Oct 2019 02:46:45 +0200
Subject: Re: first it froze, now the (btrfs) root fs won't mount ...
To:     Christian Pernegger <pernegger@gmail.com>
Cc:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAKbQEqE7xN1q3byFL7-_pD=_pGJ0Vm9pj7d-g+rRgtONeH-GrA@mail.gmail.com>
 <CAKbQEqEuYqxO8pFk3sDQwEayTPiggLAFtCT8LmoNPF4Zc+-uzw@mail.gmail.com>
 <e0c57aba-9baf-b375-6ba3-1201131a2844@gmail.com>
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
Message-ID: <baf8bd65-6dee-1d49-6a8c-4b4845fe56c7@gmx.com>
Date:   Sun, 27 Oct 2019 08:46:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAKbQEqFccH9=WsGy23CcCu-KSVWYrwffF6faRADH3oauJhgkdA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JvrZIrrlaf08SmmTbRe1b8gXl16On8WGA"
X-Provags-ID: V03:K1:Hm4PNwKT3pFwwpsp7nD5j//7u33AjXUq6zhCEJPCkDGxRBLsrGr
 eRjPZ2tGPVLzP2uu0TTCtbj2Q5UsewQ32S0AC9VbUmApCzFj4THokKskU0f8EF8zVGDDocl
 jO7etxXEvKhS5qTG+5WIihQRI/OlC5tdwR3eE0+S05p8XDGiaJ/ejrESJOWshdAkGrBYRZj
 aFyGJhd5uwqEgRyLJfQnA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DUMcFkaXhwk=:s4iHFO7WL1j6OLjfESvzRi
 lvwoWLon9/l/E+9YPfmWA6BrqaDYKBzV/FbAjtoZsRf0I1U4XYoD2lWaqi2PTHLGg22pItnf+
 snwnDenjIeNqNoB5V63vp3OFIbwz67F8F+aBWLY8hRPqNmB6oNJ8SqmTPP26GZyghrxXmUYB+
 3hScohy3qyZxwT2O66loxShw+pUg9RTIUHouSPoy6pC2URubTAAe3F9oCn6rJnIa9q2bLPpLt
 p9SFGVp/zNpCibTtcTDrA4jwpIX++d4tf6OK2EMi1olNqDPwstnRb0nY/JpwMCp5HQY6XEtaH
 6W7ENRjnGX5Vy/wZZIFgOZ5FLqommliutSeZDVsKyJg4mjtuH7GNaTLajIqPxMvy9dTdByOfk
 lj0NxAslVYyDLLnL7H4fX6T3aPc+hrPxf3O8k/4SEjSooIuHcqGxZig/wEmNe0dvEsTl28ztO
 DIdm2mYn/X5cmJuQPI8lmgKL88c93GaTDRXCoX76rQJ/MEgfynMfUIAoLqfdwIVtQ1W5bJnQl
 VNtfY68ydrSX9qClNwG9/0VBKBjU1hrkK7/JDhU27SGU8vj4O3wzGUIWA+RXSJFTqSSTzsPOd
 95XPzZMs22qq4CPvmyil62Rnhl4m7DZMvgJp252UkbqR5J7IY74mWG25vtJEtR+pn6ujX+glw
 cpoYneAomHhUYwRGy5Cj2600s/WVY7jL2UEnkrFwWG/LNtcsfx+au3DLv9VPNpOD74D6ik/Yg
 8UO7tGlhzPLP4j5r05w9RAB6lFEsFJ+0mAk0HZVo8EtK5v/gu0c13tcFwy3b5Iz0zkhuEzEfZ
 WCySevMXKdDSy+qFHFBQl2mdg/nFKI/ItXfN038KMm7Nfv+6RSaIcSX9l3nUoQwFcl7AmqifT
 BIaNbBAEPSOCC+FpvK+ub27oxP+UWcFGbxK4QH9IhDRrH7wPBAn1P721Pr2EfQZx+dj4oT9Bf
 lcgeApu+2O8qZ0E8iwoXdYWq+Xfr0LRAN1mlCPTkDR3RCzQMZr3ySmzMhaitxoTwsTdUps0ii
 z74SqqzpSLudwK++aCajI+2duTXPWNMSiI7l+elebaDhRdCOqrhp3tYmmbD6EMVBncZEx8aKi
 hPoF90vIof+Xb4h7C88evdNqDyCtHLpGOO5E4tOCI/TUOiq3fFVlJ2zcBAMSCjBbwRGlYpgEE
 6R7yTvDHT6/h1idya66dOniOP8H2nsI3pLSLgsGgWyoSkjM+uWD96vAgiEXhDwCdKeGfn5yTn
 ewy3pGKfOwWI3I/X6MJJ195Dh+aAasMJ95HejLCoYtB1Oz9ACA2NVYhNNAfU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JvrZIrrlaf08SmmTbRe1b8gXl16On8WGA
Content-Type: multipart/mixed; boundary="5qu2Vs42euURnOV7RpNO1zuIo6C4MiW75"

--5qu2Vs42euURnOV7RpNO1zuIo6C4MiW75
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/27 =E4=B8=8A=E5=8D=8812:30, Christian Pernegger wrote:
> Am Sa., 26. Okt. 2019 um 16:07 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gm=
x.com>:
>> Mind to share the csum error log?
>=20
> Certainly. That is, you're welcome to it, if you tell me how to
> generate such a thing. Is there an elegant way to walk the entire
> filesystem, trigger csum calculations for everything and generate a
> log? Something like a poor man's read-only scrub?

The csum error can be seen in the kernel message.
So "dmesg" is enough to output them.

To find all csum error, there is the poor man's read-only scrub:
# find <mnt> -type f -exec cat {} > /dev/null \;

Thanks,
Qu

>=20
>> I'll fix the bug and update the patchset.
>> (Maybe also make btrfs falls back to skipbg by default)
>=20
> I appreciate it.
>=20
> Cheers,
> C.
>=20


--5qu2Vs42euURnOV7RpNO1zuIo6C4MiW75--

--JvrZIrrlaf08SmmTbRe1b8gXl16On8WGA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl206PAACgkQwj2R86El
/qjfoQgAgK90FAHlUS4ukf4T7MU0NG98Bg4XFKJs9BMidzTj7LnnLUO7wgdeNsYV
7W6tEtR2aw2uTJ7MVFrRGF6Y1mg5/oqxWdu5b9nQ4G5LI33Jq95SVHa67jgCOeQY
eh7u9UbtfjuarLmMy5cxgz0aa3m8y3Ojvadg0znFStPgOiphDS94qeMG0C/XUEYp
W6dioeoSDk78GdW/b3ZezcQTF61ct5g1VA/1Eq7UJODTPvbo9jdB+pukNwlSw0Re
0olx75t4T0vPCqlwXdm2RcJKcBtpfu0dI6PwtiHTfEmss3iGf4A/oLHIygecZmKv
/r5iU07Sehv10kpTUM6aUWotjnThbw==
=HQsO
-----END PGP SIGNATURE-----

--JvrZIrrlaf08SmmTbRe1b8gXl16On8WGA--
