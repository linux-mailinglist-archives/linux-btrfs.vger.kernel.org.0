Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E73D012FFF0
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Jan 2020 02:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgADB0g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 20:26:36 -0500
Received: from mout.gmx.net ([212.227.17.20]:48329 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbgADB0g (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jan 2020 20:26:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578101189;
        bh=yL1aX/+WGf9rjI8guXGFGT0A+NbVe3WMmdAsUYerBP4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=JLL0qd0QK22aepSC3csAfKeQa9zL2o7V6C4Ie1O1jmVmTmVtbkArOfAXcqOxJmNNM
         HSbFEhWP6/WqEDMXB6ZLNZjo/m12Z8P2Hj+u+mO7bSBf5l6SbL/6NHUpkZcYilUENX
         LadpFClUtRj5IMKLAO3j6iO/7oABjT8BG91VRCR4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAONX-1itHeJ3qxf-00BsiB; Sat, 04
 Jan 2020 02:26:29 +0100
Subject: Re: [PATCH 0/6] btrfs-progs: Fixes for github issues
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191218011942.9830-1-wqu@suse.com>
 <20200102171056.GM3929@twin.jikos.cz>
 <e8398282-264a-3ef7-43d5-63f1ac0c7c19@gmx.com>
 <20200103152719.GZ3929@twin.jikos.cz>
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
Message-ID: <d9c1ba8c-cf39-883a-5c84-4d1da81c243a@gmx.com>
Date:   Sat, 4 Jan 2020 09:26:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200103152719.GZ3929@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ePMAqzKkzdhJhOAivbG5hjQGDPvTNN0Nq"
X-Provags-ID: V03:K1:g/EZw74Inrofjrp8dRwnqyOuALxCZ5YfYqrAUdjZq/WcQrrDcyW
 ldx80luauBFXu7WmHIg9te81j0pGN28AMq6m2/k/WM/LbnqEh2SEJkSlqp1+aN4SZRWuQs5
 +N7MwHBcPQLFgsoKCBvisdGGguu3Eg4GS3DVpz/fr6JAvY8DVorSjbRXgK2mWLoVxzgRAYS
 dqCJl/DAu7YGSs9eOCPpg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8s1SI3Ceduo=:4WBcyHcMyqW3FeMAlsDQtq
 NYhF76KWSjkprgwJE0G1SmOFcuONegmXNQ9UON3RSNZxjjbYD7EBa1PpReHaPStVHesXl5ygj
 cGQjK+EcnYBgDhbMe3mDNAm6fd1ud4xfh7yHyZBsOhjn2vGsR6bkt0JgPYOOUmUGXySWMEIkk
 SsCalVCY5/aTIwWVCi2DtAWI96BWz0NQK4CfCJnxonAEjydz83xLstfnE4nyBovaf5DdLTdp1
 HMOdTC4vU/qLocy0ivro8L3vzPsLUV8IWwr6tPV8/oqwjbf1q6nm8eG6zgcuFwZDhoB87ESmj
 /ukqwsmhyl/nDdxpqsu43XnQ4RjiaG6AnmG8OM9/2rpeUID+pchKlKHJuZVbPWm+j9Lj0yILj
 Wa9fIU1yjR0/wwM/2fzsNxNUh53ChIl7maHUlwWi5bLXQ2rJUyUYiBxoFOCu4hqRbm/UXiy+X
 7Jhb+aW+XMa+SK9PZSoNa2wfHN/AWzQDS+u66cgCnB7KA4S8JUhPDN5+7Kbcjv/m7bGVMefB4
 5ruGAhzh4Pw3XZneLWm1FEk8b0YqvZ1l/7avOUvdrbXdYa1iEn2UEEv7HTSiVadpUiI1uZyB8
 b5MfGXmKjhU0O40CtPVXwUHnBaSA4GJEufQXHzSJ6hrn2c4nR/XjQBTtOzf1oX1Q4yN6KwMGM
 Zkpv3XqUSZnqjeo14byj1AQusN0eE2nffVbCW6UH8QjRylBJwxvzgf5UzqbvjgjnNGA2oMCAE
 ItRlb7RCGQqD8JWTys0HBfc45c0xqkDTCxXcbC9mdFj+XST4MHokPBkQJhV45XEk3QIHWVwgd
 HxUpqzCIe18xeaLdfwED+3PRL1fXXMdDh2BBFVXg6iKAWPl4yUVfuK5n+mDHAcVqc2Gvkv3wd
 jsNM3iLblL+YkaRl5Q2s0iJqp9Dfh7YXGAM6lUr0jDFU+rA0V0VZWn//ntvBxQoeBafqAP4FZ
 sJEmJEWos2S8ZqRZxm6HWjfy28KmW/NdW1yvAMftbTD4pYrPPS4WMMTgfsRK0crgwUlNXEtPm
 6avMpRxkKnHA0fDE9FAQNlIYC/v2kNYPt0JgGhCm0y81UpdD05KL44NHMCr0QGGhchP4UubsJ
 sp6OtwnAuzj6wcbzY02PPjbhU3zkzzumc1aAzolH4Gnt5qeiJkmHRVtGLxu78YSJ6luFAzyKw
 bWR94Qg9hYi4UoX/h9b8XIME4FOZG1pIKa6r12d0IJqA/IQdmq9/4HVf3+4j/1pX7+Rp5k4cl
 4gc/Ax1qwgcBu9nVZAuaTLqRnlb0tYSqWpZzij5lXKZv6OA92Sx/jfESHsaI=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ePMAqzKkzdhJhOAivbG5hjQGDPvTNN0Nq
Content-Type: multipart/mixed; boundary="weExc4yTZvAa1E4Ssa4Kk9dYIJ5SgQWsD"

--weExc4yTZvAa1E4Ssa4Kk9dYIJ5SgQWsD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/3 =E4=B8=8B=E5=8D=8811:27, David Sterba wrote:
> On Fri, Jan 03, 2020 at 08:43:01AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2020/1/3 =E4=B8=8A=E5=8D=881:10, David Sterba wrote:
>>> On Wed, Dec 18, 2019 at 09:19:36AM +0800, Qu Wenruo wrote:
>>>> There are a new batch of fuzzed images for btrfs-progs. They are all=

>>>> reported by Ruud van Asseldonk from github.
>>>>
>>>> Patch 1 will make QA life easier by remove the extra 300s wait time.=

>>>> Patch 2~5 are all the meat for the fuzzed images.
>>>>
>>>> Just a kind reminder, mkfs/020 test will fail due to tons of problem=
s:
>>>> - Undefined $csum variable
>>>> - Undefined $dev1 variable
>>>
>>> These are fixed in devel now.
>>>
>>>> - Bad kernel probe for support csum
>>>>   E.g. if Blake2 not compiled, it still shows up in supported csum a=
lgo,
>>>>   but will fail to mount.
>>>
>>> The list of supported is from the point of view of the filesystem.
>>> Providing the module is up to the user.
>>
>> IIRC, doing such probe at btrfs module load time would be more user
>> friendly though.
>=20
> I don't understand how you think this could be improved. The list of
> algorithms is provided by the filesystem, the implementations are
> provided by the crypto subsystem (either compiled in or as modules). Tw=
o
> different things.
>=20
> So you mean that at btrfs module load time, all hash algorithms are
> probed?

Yes, that's why I mean.

> What if some of them gets unloaded, or loaded later (so modprobe
> won't see it at btrfs load time). This would require keeping the state
> up to date and this is out of scope what filesystem should do.
>=20
Isn't there any mechanism to load the module when necessary?

Like loopback, it's only loaded when we first setup loopback device.

Thanks,
Qu


--weExc4yTZvAa1E4Ssa4Kk9dYIJ5SgQWsD--

--ePMAqzKkzdhJhOAivbG5hjQGDPvTNN0Nq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4P6cEACgkQwj2R86El
/qhE9wf9HZpeum2nHtl0qDnojYBfAj7cb4eV9CSiSqdbHdrU9w6qaDjQtARASPZs
9W4CTXIxyT0cZX9l1t8Gr5Wv7eBnMB8gVFzb1KbOPRXTTcSOAjB0vjML7ET/qsc8
vGd7vHk5tJ4bGiJgON4XMe1e5zE2OD/pkoMLMBK3w0qw6xegwVgHHteXI+yniL5f
/dOW9VfDia7XhYu8AMmDcN6QurIGoPDQV3RptzAk7EZKQcQDzC/vD7cz0jJdXdOu
PPEODyGXnYPLzpEIov4D08JKIYLh0Sw2fJWNngiAybRTha8IIUpO3TPBApq72TKD
LRmdnktlm2n/hCaDJhTbBqcoPs58eQ==
=2IWR
-----END PGP SIGNATURE-----

--ePMAqzKkzdhJhOAivbG5hjQGDPvTNN0Nq--
