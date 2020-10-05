Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607B6283653
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Oct 2020 15:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgJENNB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Oct 2020 09:13:01 -0400
Received: from mout.gmx.net ([212.227.17.21]:60271 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgJENNA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Oct 2020 09:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601903576;
        bh=IQz55Vu5YnRa6sENuhwMeZNoKPh48zSXhDgWDtkO3oc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=j8eso6csyvtNU3R++TMw1jh2ne9tnsXqfuuyON+FekRMcP4oK+n4KqTIN1+Qk4/W2
         7udou2bhpbKZotcQVD2Xnsv9ZYf14rP6F9GHOOgU7mGtuYcCElG/RrO5cKurOzIjVL
         w6pfcjMjwdoWnsXQHaoTzL/iVUIKR/ia49tnpUoo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MuUjC-1kgfvu03Zy-00rZF5; Mon, 05
 Oct 2020 15:12:56 +0200
Subject: Re: [PATCH] btrfs: workaround the over-confident over-commit
 available space calculation
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <20200930120151.121203-1-wqu@suse.com>
 <54c0fa16-ed85-50bb-2267-0aff6276b4e2@toxicpanda.com>
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
Message-ID: <47f06711-bbd3-9796-2934-ef0572f500cf@gmx.com>
Date:   Mon, 5 Oct 2020 21:12:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <54c0fa16-ed85-50bb-2267-0aff6276b4e2@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FTxVubMMi5pOMuM7jdlk484gneBSugsxw"
X-Provags-ID: V03:K1:3KL5CIWxPb8A4a0SQDQK+UCp97oxWlwop0Iba5RtF630ooF5UMT
 YfK3zJ2/BBkJW/ReH6FrM8Sfr9Vs9tqibTFKMmip+U/qXYETb96ME7WY+KWbFGXOo8fuKKr
 ojLSCPsIj8/vQo8lOgRWvfVqJ24a8MYAc0TJKKp+JSAvtZHXR3n6HXAT7jA7RjZ1hpV1Q9s
 JFdhN+Dv2eVDtLQgitKRw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wB4M482m21A=:JCk4Zb5QnEzPGQN+UEsrIw
 5a9TGEigN8gJ58BKwRItEeDAphRP+5jZPp+r6JDeNuE6oh4epUzwKRyySruJ3Tx10/aFQ9Fio
 RVJhNWUvwgaKobOOQ5JW6D7sWcieCZUmPXHGtgj67+MM5iTw1TjUZt6ahFID+Go9GDHWqLwdw
 9rAfWsF96XPcYz611DUkkoEEWZiTENsvHiA/lNrvkTTLsr+gXtUXgV8z303jcZGTLp0JVC3hP
 ZSTLrw4PPMEPO0zCClknoaJAczkpthyEqlAuo8pB1ACqIl6zq3omHeP/YRZwp6fP0/JsU/aS9
 YurgzlL+ZFih8wGZ/dDB4WorZC1JE1aBW1DNQjmD0TxMzYlY1/5XNSnL+kz3NrnL2SvI6GCp5
 bVnEderSgbnOrR0TCZizD0n11+ihwHw2RPqA/vJ14hqBkiK/cyi5jk5v0l6oex8uZNVcbvBkD
 mxvuQwZcu+/RJOreNJwhzObBd3FC4L88kAWLPRVfhU7iU2+X6U2DJQdeyb68xQrEktJ95rPp/
 MMhkehluDdc6mmQpizaszlkR01EQpKquXxQkgX6PgiwjE90gb6RaWk/a5wkOom2AhXg3TsOPe
 sYXNEm8aw3tE3C5aAOpNalSHzia0BGP+5MchM4ibc4schxBnokk6/i64CaGBvb6AYaZsSdURM
 a73Gz7M2sP3wmTfrzGP89JK+ilsxj6v5HvMHQMb0mZktUYmW7VNnXi83Q/u2yEQ0gWe7qQQ/+
 CYb8re/dB+UOpvTiiv2dQrDhAQyoeG3LaOhzEqc+ScZoX2CkMgx/6kkiLLvUS/ZZ7E8azGbfX
 fD4CtdfukM85lFI9JRb16h4FYZrQIjfX/a1FSJjz8/P5KhpMRKzwm/0TV39KpabDjHabqgznt
 0IKHb4rWEHeWHfsmrXVHtiviZf1cMoSGyGCZxB4B1pIJRpB6WGGAE5Le/FYiT1EvByuel1qtB
 Iq2OBkdr7vBzUwlyFgv9s3EvoRDyL7fENxhmaiQmRomUadCOPjIplMzLIefUo85vIGwyTRDB9
 IpAAc5+nU0RgenZVgNxznmNUL1tlptW8OEVr/rkNvXV0Uj5mz3YzE+nd+q5Ak/SUW9bnLMwSR
 9QXjtWE8J+4QWA1C5/QTC2ZBuD9QptaHG5pxhZru3oaY2P4foln6ZDUi43+QJHE9IPdWIgLfr
 uk7UQx4gZK7/brSB3jy5ttGX2rgouzJCRIHO2IgGFrj98rZwewpy6/sPO9LU1B7CEHM2HqSmw
 vyU1RGtLiJRdipRXHgytY26DQWepsl2evrUJxgA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FTxVubMMi5pOMuM7jdlk484gneBSugsxw
Content-Type: multipart/mixed; boundary="L6AORRMiyklG5IkarKBzr9rTyK90RIRAv"

--L6AORRMiyklG5IkarKBzr9rTyK90RIRAv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/5 =E4=B8=8B=E5=8D=889:05, Josef Bacik wrote:
> On 9/30/20 8:01 AM, Qu Wenruo wrote:
>> [BUG]
>> There are quite some bug reports of btrfs falling into a ENOSPC trap,
>> where btrfs can't even start a transaction to add new devices.
>>
>> [CAUSE]
>> Most of the reports are utilize multi-device profiles, like
>> RAID1/RAID10/RAID5/RAID6, and the involved disks have very unbalanced
>> sizes.
>>
>> It turns out that, the overcommit calculation in btrfs_can_overcommit(=
)
>> is just a factor based calculation, which can't check if devices can
>> really fulfill the requirement for the desired profile.
>>
>> This makes btrfs_can_overcommit() to be always over-confident about
>> usable space, and when we can't allocate any new metadata chunk but
>> still allow new metadata operations, we fall into the ENOSPC trap and
>> have no way to exit it.
>>
>> [WORKAROUND]
>> The root fix needs a device layout aware, chunk allocator like availab=
le
>> space calculation.
>>
>> There used to be such patchset submitted to the mail list, but the ext=
ra
>> failure mode is tricky to handle for chunk allocation, thus that
>> patchset needs more time to mature.
>>
>> Meanwhile to prevent such problems reaching more users, workaround the=

>> problem by:
>> - Half the over-commit available space reported
>> =C2=A0=C2=A0 So that we won't always be that over-confident.
>> =C2=A0=C2=A0 But this won't really help if we have extremely unbalance=
d disk size.
>>
>> - Don't over-commit if the space info is already full
>> =C2=A0=C2=A0 This may already be too late, but still better than doing=
 nothing and
>> =C2=A0=C2=A0 believe the over-commit values.
>>
>=20
> I just had a thought, what if we simply cap the free_chunk_space to the=

> min of the free space of all the devices.

Sure, reducing the number will never be a problem.

> Simply walk through all the
> devices on mount, and we do the initial set of whatever the smallest on=
e
> is.=C2=A0 The rest of the math would work out fine, and the rest of the=

> modifications would work fine.

But I still prefer to do the minimal device size update at the timing of
my per-profile available space, so we don't have any chance to
over-estimate.

> =C2=A0The only "tricky" part would be when we
> do a shrink or grow, we'd have to re-calculate the sizes for everybody,=

> but that's not a big deal.=C2=A0 Thanks,

As long as we don't over-estimate, everything will be fine, just how
many extra metadata flushing is needed (thus extra overhead).

The rest is just a spectrum between "I don't really like over-commit at
all and let's make it really hard to do any overcommit" and "I'm a super
smart guy and here is the best algorithm to estimate how many space we
really have for over-commit".

Thanks,
Qu

>=20
> Josef
>=20


--L6AORRMiyklG5IkarKBzr9rTyK90RIRAv--

--FTxVubMMi5pOMuM7jdlk484gneBSugsxw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl97G9UACgkQwj2R86El
/qhQ1wf7BRK0pILid0ZUEwZBuVGOhpbN3HkQ2VMEuKJcvYFshZFoaLBP6AXezIKH
5KxRN6hGdfy15V+H3zbvfVPYdXZbHcnuGNhqRBmBkVbIGylde4pJLxt1sIrUavLw
26MX4xBe9ZQ8mn9mVTdv3kJooJRayvxRMDvjAj3dpG+1jPYeef6o0Trv4kVNRv65
rPCVnYrzbBah4YDvsuoGA/Id6biun/I5jT6ox+BX2xtaEFs6jF++bdN3y+Q3DfGI
eTFYYstvGnsyb07Xz+loRdRVAcio36hO7jaEza+jbtemyi+lLGdrqyoKqDcX8a7x
pc98cjuvGUYlZupgfMaw7VdSjYz0MQ==
=C3lI
-----END PGP SIGNATURE-----

--FTxVubMMi5pOMuM7jdlk484gneBSugsxw--
