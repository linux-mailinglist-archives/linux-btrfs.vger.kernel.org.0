Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5412CA4EDB
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2019 07:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfIBFdi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Sep 2019 01:33:38 -0400
Received: from mout.gmx.net ([212.227.15.18]:53809 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbfIBFdh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Sep 2019 01:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567402412;
        bh=eJBlVVSGOiJSkGotFXUnkGW/qfMUKjhNvIW2Rst6hzo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=I9xFNemLGTmj2b1vdfTU27/WppCMxQM/Gxlci8VVSdGx6a9f6FlW1MCz7qltGg7MI
         WS5n4Pjb/1ULg1qY4GSfe1eRhYTbTfVWkkSt+BRjabVHvMef746NHatjJU83ZXODwN
         4nEksiWZ0QCwtqZbPXZAdHSXJDuuag9sTNqbSDQc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mk0JW-1iSg2V2bCy-00kQYk; Mon, 02
 Sep 2019 07:33:32 +0200
Subject: Re: block corruption
To:     Rann Bar-On <rann@math.duke.edu>,
        Chris Murphy <lists@colorremedies.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <bdd368bc2e910523525c54844c5c47dd877f1a0d.camel@math.duke.edu>
 <98252ab04af29eecf51b6c9ecb7f258df56c93ba.camel@math.duke.edu>
 <CAJCQCtQRDfMb6=RtT5rNDSj_QT_nJXYx3C-Zzi9baPykHTrDDA@mail.gmail.com>
 <cab4c26799caa8f4f9516124b5448840245a2811.camel@math.duke.edu>
 <b3ec20d5-e9b1-4688-297b-b102b5a8fa10@gmx.com>
 <b855969a3108e7ef9be2e758eb8bd2f3539e5af0.camel@math.duke.edu>
 <CAJCQCtR9feFgGtOZ0Wik2y1oQ69V5z5Q-voFtYPLtnbnbWo7TA@mail.gmail.com>
 <c608faa6a5dc9ec81b894d18c7761dac7a823ab7.camel@math.duke.edu>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <270df1b2-0564-53a6-3cb0-e8d4245c6ed6@gmx.com>
Date:   Mon, 2 Sep 2019 13:33:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c608faa6a5dc9ec81b894d18c7761dac7a823ab7.camel@math.duke.edu>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zXkESiiYEzixbz46qyIeyXb7E4ZMKuoGQ"
X-Provags-ID: V03:K1:aPg72ICp3tgkfpX8gYA6l7ylNMMAq80dCqCPwOg0GrOmcogdjhA
 caN9D9/JeeWLSolvRCYKGrOcDl6/NyQ0PqyEH9OZ5/qej7hv9igjwjWf2HzDdT7dMvx/NEz
 x3J8dbuserXIxqLJD8vFbeRWEtLoEc5/GlNsFiFdalW3XwZIwZA9sNoEeNzHa/4Zfkph39z
 WqvwiX0f4I1v1KjM/8njg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:caThLRAFzww=:L/OtRZvcCcdP9VZzRVQOIX
 ulW1/FkJqXNyledF5Anu6y8xL9S2/SK6vCxn3Db7aTtxPpjGVgE5Rl1yx/I/KlvxgUON+DSwk
 Q9grXhB1Qf+oEl8K9Yqcev7L1KTtaRVPXESQfVY2mRMxk4ygrQAENHsu7e3ymW10bNPatV/dL
 GLRxjTpZczIctvwSbycDNtgpvZlQvUTGIg9FrG8MHgcu8M0ZVenRqkLfA0kiLukB/GXSEehxm
 6stAjfy0oi3kGRke9GQJnKHrvrUe59G9IUGvJTBofzfkLHmd1UX/JtwhWBPvP0CKAok47idZC
 XiMjYZzf92xai7SjpwTKXyj33pdSf513kVdt2yybr0ep7LosbfuKHqbBQHas37w0wdvAGEx+I
 MbBGyi86nok7T3mxjg04CiCmVlQ8kJ5WX26YnTH6DBOrb96uNEM0E7oDmRaqCOfR9e2faLR5N
 4RHCGyU11ydAIFEPYlJKS8tkVHcGXuDWFXAL7qjF9/VNRqzEKFppDkvPRgwAmZj8cweJw+DmG
 VaUmcrQsKO1fgHqmgEw5HBmO1y4dkm50KpNZWxH1OLLOW6GAy33Gzz4DtN3UpET5XabEGU1vO
 11f61ofd60AZuV12CtgMfg0oOhFeGCNaSOnf6gwKj2jLR2rCv62DfVpb4r2w34iQ1tWafQ8D0
 l+125kv7aAAs1kOlcYJzyo4PZ8d0fiYryQ77w995EMSyqYzvlorpzXGxxnij91IL+iu4HRrGB
 Ceni86/NrU2+A7o17nMYg2KUKlpKcBlSg6L2Xhh3WHu8ZqpQ000tSKesQ0+qE+MaUg8CMUQjB
 DhDlXvWK4z0scZzWn4z2wm30LkpzN/l3bp+v5Ox67Wux6geXLMrWHl/pluAiTtCGAl0BapUC8
 enm6ud1RFfAS9YtGKysJeYIF4xrDmuPtvwoKGTaKy8q7FeC2/WdYlV89ezgYJOwzLOW9niQoH
 EtYdrjwFzh1f4BdOFP6iSngTiYH0xzJbuUhN9+DDuK60bDWIkVfhCpUHR9wog1LIEHsU+tmn8
 Y3rO21Lu61w3O2WUkIcj4onlUlFoxg+NbKZXwprJkRP2NLhGe3dZdXJsE+fvyjO0cFcgVDCa5
 F4RtZeBLAOiSgnPkBd5MVJWdUs4BAMGM67bCRrmbXtX77RjrpILfuIIZvFeCiH/fsTZ7YD7xw
 Q2OKb/92IVnCVtUaza1EZgo7siohnu3tecDZRFTC527dhT8w==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zXkESiiYEzixbz46qyIeyXb7E4ZMKuoGQ
Content-Type: multipart/mixed; boundary="XduRn5wwgBUBmxtyiSjmQFcNIACphZYTu";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Rann Bar-On <rann@math.duke.edu>, Chris Murphy <lists@colorremedies.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <270df1b2-0564-53a6-3cb0-e8d4245c6ed6@gmx.com>
Subject: Re: block corruption
References: <bdd368bc2e910523525c54844c5c47dd877f1a0d.camel@math.duke.edu>
 <98252ab04af29eecf51b6c9ecb7f258df56c93ba.camel@math.duke.edu>
 <CAJCQCtQRDfMb6=RtT5rNDSj_QT_nJXYx3C-Zzi9baPykHTrDDA@mail.gmail.com>
 <cab4c26799caa8f4f9516124b5448840245a2811.camel@math.duke.edu>
 <b3ec20d5-e9b1-4688-297b-b102b5a8fa10@gmx.com>
 <b855969a3108e7ef9be2e758eb8bd2f3539e5af0.camel@math.duke.edu>
 <CAJCQCtR9feFgGtOZ0Wik2y1oQ69V5z5Q-voFtYPLtnbnbWo7TA@mail.gmail.com>
 <c608faa6a5dc9ec81b894d18c7761dac7a823ab7.camel@math.duke.edu>
In-Reply-To: <c608faa6a5dc9ec81b894d18c7761dac7a823ab7.camel@math.duke.edu>

--XduRn5wwgBUBmxtyiSjmQFcNIACphZYTu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

[...]
>>
>> I'm curious if either 2 or 3 are permitted.
>>
>>
>=20
> Wish I could help, but I already deleted the file. If there's something=

> I can do to move this forward, I'd be glad to.
>=20

Maybe it's too late to mention, in fact "btrfs check" has the ability to
find such problem.

"btrfs check" has two modes, original mode (the default one) and lowmem
mode.
The latter is mostly written from scratch, thus it has more strict check
rules (not to mention it uses less memory while will be much slower as
it causes more IO).

If you're not sure if those inodes are the only offending ones, then you
can try "btrfs check --mode=3Dlowmem --readonly" to verify.

The support for original mode will come very soon.

Thanks,
Qu


--XduRn5wwgBUBmxtyiSjmQFcNIACphZYTu--

--zXkESiiYEzixbz46qyIeyXb7E4ZMKuoGQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1sqacACgkQwj2R86El
/qi5egf/RHTU42xZWM31aFO5EryvzvOPrwR7tSmH7B7oGEMhWqsO1xiShMS5KD/6
EU9OWaIGZaUWu1SYCFmJ5G46KLhMiDnAxVU1BAPfoRxOKS/ACwA+2Ra6+f9uBzgc
V5roFyG7dNvkCzPDSgJtcnetiAONJ6kovSA4piHo7NH52LRnpERMGhK7HpIaloDZ
bxd/zs+zmOLh+ioa1E4sXZVmydPUW55cXFE5gdB4RuMpOPCYezdjPI0ghF2aP/az
pJKnExKq6S5t42QipCgajQ66WmvLUouT7HZEC2qkXdrtZkv6AbnR+9NcBoxSGmUz
jLPiBrQ1D6c05E6ysJTvDbJkqbf9Hw==
=wY43
-----END PGP SIGNATURE-----

--zXkESiiYEzixbz46qyIeyXb7E4ZMKuoGQ--
