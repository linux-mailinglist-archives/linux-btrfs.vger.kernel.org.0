Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDED29AB95
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 13:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750891AbgJ0MQG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Oct 2020 08:16:06 -0400
Received: from mout.gmx.net ([212.227.17.21]:33243 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750780AbgJ0MQE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Oct 2020 08:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603800962;
        bh=x4Fe218FufALEw6QevIOVN3Q3B5oLzrOksb1nGQWfzU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=HbiXUedCZDA0KNzuvTVv9fBQdcG8HixWmIvlJykUIfpP+OAr+IcTlhoaNZWi8TbUK
         fc469uDiGyPEnb8xLIJHsmZoGVUEuaMfjntFcAiomBskiGioWQgqUD16spWwt1RlVj
         Fry7naEwpWMnDpbnbjX3RXXKuy9pC8d3UM2IBh1s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3siG-1kOpEn39zE-00zkdu; Tue, 27
 Oct 2020 13:16:02 +0100
Subject: Re: [PATCH v4 13/68] btrfs: extent_io: remove the
 extent_start/extent_len for end_bio_extent_readpage()
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20201021062554.68132-1-wqu@suse.com>
 <20201021062554.68132-14-wqu@suse.com> <20201027102944.GZ6756@twin.jikos.cz>
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
Message-ID: <f5f222af-8eb9-3a64-7b72-2c61e289eb33@gmx.com>
Date:   Tue, 27 Oct 2020 20:15:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201027102944.GZ6756@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XFMCyw1UdMbbmeS1KodZWin3g3kZ4AqZ5"
X-Provags-ID: V03:K1:C5wI0JukwDdcfRRKdLzp6s99OuF5nNBRYGHLh8V+qxsGVWt2Sxi
 zVc2fXyZ+3zt2Y7KqPl9+jJy3UVp5uehb+Yk6v557xf/gFprhz+ElqBfVFZGvts9d8ImNSI
 r/mnztencTshZSf6bN0O+7+sz1tgkVJCEcCmCnLP3h8BF07G4w0KudjZP+DlvDDU4Nv0Xfs
 uYB62AF0SSZ2aYf6LpYdA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cnRH3cb2D5c=:stSCzDWMEAiOcw9TVKuyCJ
 ZPq9d5dMLOhyB0lpQwdlpMrsKZTdoShRre18HAPlCMYwN2/gCJjWV7Xp5808Cbdr507MBC0Q5
 F5OAv/5P1kgxMXiq6/6kB9EgFq9aEIpWHjYptiNqn5h4U3XzxDl2EqevUg0TbD+GmrTKnfSOe
 mWaEuavEOnqCbsTnzUoKQ2fiVxeGe6sHPlZACNv/sT6l6LUaUO6U72TbTuy7Buko8DlLHoZOD
 W8wP9Xw/ecepeN1BHl5h/bXcdGww2auPvgVbLEXw80Pm5So/0wJzEjNQiNCvsMcmykwuOBuF9
 VqyOkLxsvCyLUGOa2vxGzkUFlZCUUVrnEn7kui540ISGBIJdz7/+krUI8/HTCb1nIB3gAI8jj
 i+vCREOO9F+yNBg+YXEJ52jqTIAOE8CRifWCGqIuu/1o1nTm6qNqxxM0V3JWoN6zKjYvt0VMi
 h827hlwnR+5fUpct/H/CmNtXYE2r/KYzUsMnyNwvUg4NUpaPzDPYseAfHahJ5pjBy7/TmWnkT
 shAUHKBp5K52OtE/XJCKvUYFLapu8EX46sA5ZqNQNYXGQaAqoAb3dlwsxm2OpaRAXizyQKvOl
 K7ynFkXmOnyU1XSvELhxBa6cHribb7PhrtlEGQ6fsJL4HjsGgki5iDoBdjmsXwVznf4ZEe1RD
 ALlTeTCoM9d4IDu9QKNyfFvtPsEEysCi5Ow+Hzprmxs7Kac1deJwvzPRozKTcTWYgg20O1Q1N
 GzBmTVuZyMHpHbRlzpOAYRKxFx0BniEscV9QgX74r6mEBNsfqwsc074XqOzo9m19JAiIuj+Hf
 l61hN4FuKmY2xoluPCXmNRbn0tR/124ejrE/V+gROHhugftFSPQP2BvPscOMF6J9xiDPYAUXr
 ol2iFJ6lXsenL8AbNylw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XFMCyw1UdMbbmeS1KodZWin3g3kZ4AqZ5
Content-Type: multipart/mixed; boundary="LFNYMlkFCmvEhPjFuKBe87Wl6tYT4P6CA"

--LFNYMlkFCmvEhPjFuKBe87Wl6tYT4P6CA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/27 =E4=B8=8B=E5=8D=886:29, David Sterba wrote:
> On Wed, Oct 21, 2020 at 02:24:59PM +0800, Qu Wenruo wrote:
>> In end_bio_extent_readpage() we had a strange dance around
>> extent_start/extent_len.
>>
>> The truth is, no matter what we're doing using those two variable, the=

>> end result is just the same, clear the EXTENT_LOCKED bit and if needed=

>> set the EXTENT_UPTODATE bit for the io_tree.
>>
>> This doesn't need the complex dance, we can do it pretty easily by jus=
t
>> calling endio_readpage_release_extent() for each bvec.
>>
>> This greatly streamlines the code.
>=20
> Yes it does, the old code is a series of conditions and new code is jus=
t
> one call but it's hard to see why this is correct. Can you please write=

> some guidance, what are the invariants or how does the logic simplify?
> What you write above is a summary but for review I'd need something to
> follow so I don't have to spend too much time reading just this patch.
> Thanks.
>=20
Sorry, I should add more explanation on that, would add that in next upda=
te.

Thanks,
Qu


--LFNYMlkFCmvEhPjFuKBe87Wl6tYT4P6CA--

--XFMCyw1UdMbbmeS1KodZWin3g3kZ4AqZ5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+YD34ACgkQwj2R86El
/qg3bggAnOHh2pv36deqIRCJKdilWVHb8x2xuKDH7SxMfHMF0rg97MJmKI4d1XU1
FDkw9xT3bYEeK2GCgK+C47dRl91+cYE43KGUyGM/SWrRaHRkFw1xmZiV7/7D0sHK
6BYXx2+JUizJZyQefcyiTmhzT6lnoA6ejDjRexbILPjyu8omVgvE5gwnMjuA7wCz
TuYPcAd4a+kBuXTa3NykJFGz1Z4Fq6nKZAQ7MZKNl/qTdWteylhdgXHGXsqvUMYo
ifmyzHEt9Wz2GOPL7mG4PFWh0kJVIzs1cIYIwXN8A2m+RZ13pfBlT4Rxmx4YMzE1
oa2fvkizrleiQefegmYAsyWkZH5TPA==
=2Obi
-----END PGP SIGNATURE-----

--XFMCyw1UdMbbmeS1KodZWin3g3kZ4AqZ5--
