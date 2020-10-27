Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8067029A1E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 01:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440740AbgJ0AuW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Oct 2020 20:50:22 -0400
Received: from mout.gmx.net ([212.227.17.21]:34819 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409936AbgJ0AuV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Oct 2020 20:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603759818;
        bh=+HnbA5q95GFXYtKVW6QFaPWgq6JUBA7xakD/yrUqBqk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=MKdUOl5PkqFzwxHhHRjPxOxKA9d4ekXC35hLZc08pFwenZi5z6r+ufwlnh/KSEdbo
         GK9p7rQhOjaYkiWpJrXdMevM2iOfSvN/A+2BC39yqBYbiurjHbn2GrlxNxvaWAh9MG
         nG7ad5OPU+K/ZhL/8uK9ggOAxR3UQDwzTT9GVTyU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQMyf-1kk5LU31gv-00MIwk; Tue, 27
 Oct 2020 01:50:18 +0100
Subject: Re: [PATCH v4 10/68] btrfs: extent_io: remove the forward declaration
 and rename __process_pages_contig
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20201021062554.68132-1-wqu@suse.com>
 <20201021062554.68132-11-wqu@suse.com> <20201027002812.GY6756@twin.jikos.cz>
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
Message-ID: <6ec61a07-1263-cd39-0e0c-6709e23abc82@gmx.com>
Date:   Tue, 27 Oct 2020 08:50:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201027002812.GY6756@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Py0MlZsLUquhhzuQRE2CtWK0cCDHefaiJ"
X-Provags-ID: V03:K1:BOgn6yu/GZlOk0umJ9CSLhoH7zFSQv1n09AxuslpjpefwWcG8W2
 h0zi65HuLR1koTBpyGr9knPgZLoh10vZl/r+1cRqq6MJqTh4JcFam4l/biVUTM9o8AWf4cv
 0qF0ze9C6fRM+OQl0Bb+KPmhOub7kg/ABsFD05EXGsAOYE+vBIN9SBBGTAxvpRVc+s6aaha
 mkiS84zkEeezuwvSl6lOA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JqsDPuiTOQg=:o2KitEU3pPn6MTAeaH3veL
 zdsEHTPwmDWFV7yck+QYOuGjpx4UofGyw9K1LJkAR/P0fkBogZCVotLxzoSHX7PiRkIKXqEM1
 kUcTBk8TOb4gSNalU/jU0Aq+gcQtBJhHMSna7vWURmikGnvVs4M5aGtoOTVX7S44KTFGHqS9v
 E8NNqjv5eREs4saJ0zm8tsqj3ZrDWPP7ILYGTMRwwHs7n2Sr5X2wogvhxSG9BLsrygy4mwBgB
 3lpnIO7zYA74CSnh31CEeUirbqqTatBpRjPHlgEvBXmifbdOLOVpUJKlj9fjaOMx47z4oRQlr
 tzJKCGpaVXZ/W6o4HzJb98aTDVZgXwW/agSLVnz5RR4ndXwItfn32PVTUkS99jl/r1whW6CEA
 mWGsGX8BKBqJeDlWLx+uum8e8zO5EeFf3oT4ExfUSYUPN08UKaNyHEnXgudxjwu2DIqs52nST
 8M+PZRsw4u9aOorMjFZGmasIpd/rxLTM6tDQNQoxdvGQlkZ3uAWiMwOkIn5HGO8ENpvkSesyG
 W1vQdotSPQOav/UQtUZPuKm1MYRaSmZXeIhJbwmtmqIWBW4JQhzkP1qeXxqSXgI1gGx/kmzoS
 PoEbELrR7oGHaeGYiMIOwHh2p2lQC6XdwUyuQ30FBlQPfG01fqPiT4cJIoNih0E8YN+nOXb9B
 +JYs3bw+tdmFz1b8ukIkUHFQlosAkKEpuhCgWaNuOty5Gc0VBAmYYL1MbXGFJejDthNAwwAwO
 q9S7lSDq/8cejBsBNVKO97KWTFtd+kAin39KHtEtptZU+OyCGbtV38xWStBRfbHEofsym6tmG
 olbKMP5DfXLMv12uk4+T1vMqsAbpjXNwkHnq8tZh3dP7rg+h9nJtsVV+2aaxyvkcYpJYaSzcp
 gMFj4/rzjthnNfza2kjw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Py0MlZsLUquhhzuQRE2CtWK0cCDHefaiJ
Content-Type: multipart/mixed; boundary="D6tviRHVpML8xVmWm6Fy48MoJvBkSGFj2"

--D6tviRHVpML8xVmWm6Fy48MoJvBkSGFj2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/27 =E4=B8=8A=E5=8D=888:28, David Sterba wrote:
> On Wed, Oct 21, 2020 at 02:24:56PM +0800, Qu Wenruo wrote:
>> There is no need to do forward declaration for __process_pages_contig(=
),
>> so move it before it get first called.
>=20
> But without other good reason than prototype removal we don't want to
> move the code.
>=20
>> Since we are here, also remove the "__" prefix since there is no speci=
al
>> meaning for it.
>=20
> Renaming and adding the comment is fine on itself but does not justify
> moving the chunk of code.
>=20
I thought the forward declaration should be something we clean up during
development.

But it looks like it's no longer the case or my memory is just blurry.

Anyway, I can definitely keep the forward declaration and just keep the
renaming and new comments.

Thanks,
Qu


--D6tviRHVpML8xVmWm6Fy48MoJvBkSGFj2--

--Py0MlZsLUquhhzuQRE2CtWK0cCDHefaiJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+XbscACgkQwj2R86El
/qgpYwgAj8zO2pnUJ0pQNrsTZgnVT1m6Xa8QlRVQN1zL8hg0ZiKLpkpky1ZaIBh+
g2Bxx9h8YXpkzMze1vnjVpMJGcXgdVgFcb1BYXLlx/nNyvVJNhQ+BSMYmhOENDT5
C1WSnlhUPyAuDVqvp0z8p7gOkn+BQAErGtjgd/phC2F+Z+vQ31FBoY4V6YxZlj38
sfeb4OT/HjZxsn6HuyF4zATr9ncyM5g2ZGzuiW3AapFNJuBr8pHzJfeukQSHG3Kn
IUsX5PIUr2SQXwfX22Mg/zkPujdHOz9ERoVIrsNVzExL8mafsgENSW6uM6wxSfjw
GYNue6KRZ4K+pSZfO/9g68GgP5EeUw==
=H/z1
-----END PGP SIGNATURE-----

--Py0MlZsLUquhhzuQRE2CtWK0cCDHefaiJ--
