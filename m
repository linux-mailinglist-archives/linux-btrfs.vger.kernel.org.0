Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90492211882
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 03:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgGBB2v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jul 2020 21:28:51 -0400
Received: from mout.gmx.net ([212.227.17.21]:38151 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728485AbgGBB2q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Jul 2020 21:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593653322;
        bh=TwGTYECJWWDiekS6yLatADuOnL5GVRatBDQvcRQZo8o=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=arefQEjbU6tveyxScwhEGrBgSjC6pxuXQDOugD7KqHrO1pKjv8ZzrIjBizN4+/lUO
         O/I9SXQ8ggGp+0i+RIG4l73/eCMtoHIVtwqQH9Rlk2GcLQ0eIh0xN9hlINTO3919bp
         1UeQbtP+wC4Ey5JIwvONXZTAD+wLGizmyUa2aVt4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Ma24y-1jKvgT27gy-00VzgX; Thu, 02
 Jul 2020 03:28:42 +0200
Subject: Re: first mount(s) after unclean shutdown always fail
To:     Marc Lehmann <schmorp@schmorp.de>
Cc:     linux-btrfs@vger.kernel.org
References: <20200701005116.GA5478@schmorp.de>
 <36fcfc97-ce4c-cce8-ee96-b723a1b68ec7@gmx.com>
 <20200701201419.GB1889@schmorp.de>
 <cc42d4dc-b46f-7868-6a05-187949136eae@gmx.com>
 <20200701235512.GA3231@schmorp.de>
 <25e94ec6-842c-310f-e105-6d8f1e6dfdce@gmx.com>
 <20200702011134.GA5037@schmorp.de>
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
Message-ID: <b0618fd7-e45f-a73b-a618-cd65cfa042df@gmx.com>
Date:   Thu, 2 Jul 2020 09:28:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702011134.GA5037@schmorp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OkefdnTeImzJs9eEOV2JfsgxGjegGrLuR"
X-Provags-ID: V03:K1:xv698zcaklSMqhlrjE95JPkby2WUADIYqWagjChVbuHxAVTLH39
 6sOeSI+rm+A9fCRZgkZ5B9GulJ68rhaKIQZUMunmarw5aOEibYOvXN62rBgjVtq8a6Cn0DY
 yeNK0Jc273CVperYHyPycG37apu4u27FyGZksTchPKihNLmsvfc+T4a2eJ5mAXRG2C5Bij+
 WJBawjX4+qpfaBDb5Mk7g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WJNi5wwKjUg=:aWBWHgq+Lw5/AsdKzpRzRE
 nKwLxGN4hLhc4teB2E7DytOsFO7uLV6tOvK3WZHefNo582DHf+CKE8luc/ObCds+yU2IzU8rk
 jMQA74yow5EyzhkzgkB96iEzhHmM2WlL5ijH6sAyhDXeeF9wT64qcIMYnji5Q0p+nI7OU31hP
 qx36R6uiXziKie708DJ7t6bYag/9PzATxf74Lb2qTy27ktTx9ExA/EOzrM2BbziCXu9+O0bTo
 2qxAXZKCU1tiV2f05Nr7hX2t/MiUf2odVh4ush3moQuVDZdl7VyrIwPZBZvlFUH2rFIFaf/sL
 RQqpKHTGDiInggCpWF+2V9+odR+xuCpXM9sfCOclJcK9fnVXqwLpNtaZm5cNkrSlAfvccMkyb
 etDoK76JTCsO2qDS2ERMUu3DxsObaE7Q1UXHQl8d75/sco1Cd5cJuOBSchOh3O9LaADGI41GV
 CEizMZ/cNViLQMGhF+2bzRddTGMCdxYZwve21P/PA4b8Gh10ssKCFDp7LySaPkNbk/3D7GUMs
 IVTHjV7iXghKOEj/RSBMLvSzf9vLypirayphXIEhBnxjRMsh5dQyc5B64iggPx+sglIUtweFB
 jyfjGItScaNAo/FvtK+k3a13hg7pTXBbytI9UfDLdIMI9bh8Xs6AxHR1gR+KIArXXo5PusdG7
 Wwz4hPHbyt4ycEn0cDpctd/rD4/LsIyUD3GFO+NFol+/tJzBCM2k19i3O7TvctHvk36GI9e8Q
 mgIQnS1N9Z0UOq4TPV6bLdD6R+r0WjFgUiesExqml1cvsrlKeFMqU/lGEt0aijrvGE0BCSweK
 Gf1JND8bgk9LcHVr04gJceq6p5T7CcBAeyoQfdDrSQvA9JVs6knULm/cmypQ5YZ+vuboMtE4/
 rdVEvElK3mZbKjuh4SpmA2J66GponfCvH7Eq1VYQEgcajnO0jHuRmuUhK1jVXRHHjXTxgT/BG
 eJWsh7dHp1u1ghBhS5/H4zit+c1Z1kO4kRMLk0g74oDDMwsTHrmv1OfMROnEC0iA9lQM1gqRu
 QCyts/Q5gLlTATaMO8jiyrPN1eB7mli33f6APjiYXSXhJt7jEcZwOi/1x16BqyanrQ5gA3Edh
 DXdMwr5vAPo5L49xQKhU5mM3swjClfjl++xq+nZNSa/QJ4gxVnIHAiBCjXRpJ+rmba6wV4P/V
 mrBzGGvqNW6agtTGVKCeTjF0NwnGDAojqqg9lk+cEOQ/WCqKVf0k6HAZ72//W4WKC/9O1Ypfr
 WNDp9hnmeD8y5w85O
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OkefdnTeImzJs9eEOV2JfsgxGjegGrLuR
Content-Type: multipart/mixed; boundary="R2XwauAAFxW8Cwxv1BDmtU0gCTLRA5JKX"

--R2XwauAAFxW8Cwxv1BDmtU0gCTLRA5JKX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/2 =E4=B8=8A=E5=8D=889:11, Marc Lehmann wrote:
> On Thu, Jul 02, 2020 at 08:02:52AM +0800, Qu Wenruo <quwenruo.btrfs@gmx=
=2Ecom> wrote:
>> Well, if you want to go this way, let me show the code here.
>>
>> From fs/btrfs/volumes.c:btrfs_read_chunk_tree():
>>
>>         if (btrfs_super_total_bytes(fs_info->super_copy) <
>>             fs_info->fs_devices->total_rw_bytes) {
>>                 btrfs_err(fs_info,
>>         "super_total_bytes %llu mismatch with fs_devices total_rw_byte=
s
>> %llu",
>>                           btrfs_super_total_bytes(fs_info->super_copy)=
,
>>                           fs_info->fs_devices->total_rw_bytes);
>>                 ret =3D -EINVAL;
>>                 goto error;
>>         }
>>
>> Doesn't this explain why we abort the mount?
>=20
> I wouldn't see how, especially if the code doesn't do anything _unless_=
 it
> also prints the message.
>=20
> When it doesn't produce the message, all it does is compare two numbers=

> (unless btrfs_super_total_bytes does something very funny) - how does t=
his
> explain that the mount fails, then succeeds, in the cases where the mes=
sage
> is _not_ logged, as reported?

When the error is logged, this snippet get triggered and abort mount.

And you have reported this at least happened once.

Then for that case, you should go btrfs rescue fix-device-size.

>=20
>>> Also, shouldn't btrfs be fixed instead? I was under the impression th=
at
>>> one of the goals of btrfs is to be safe w.r.t. crashes.
>>
>> That's why we provide the btrfs rescue fix-device-size.
>=20
> Not sure how that follows - there is a bug in the kernel filesystem and=

> you provide a userspace tool that should be run on every crash, to what=

> end?

Nope, it get executed once and that specific problem will be gone.

As said, that's caused by some older kernel, newer kernel has extra safe
net to ensure the accounting numbers are safe.

>=20
> Spurious mount failures are a bug in the btrfs kernel driver.

Then report them as separate bugs.

The bugs of that message is well known and we have solution for a while.

>=20
>>> The bug I reported has very little or nothing to with strict checking=
=2E
>>
>> I have provide the code to prove why it's related.
>=20
> The code proves only that you are wrong - the code _always_ prints the
> message. Unless btrfs_super_total_bytes does more than just read some
> data, it cannot explain the bug I reported, simply because the message =
is
> not always produced, and the mount is not always aborted.

Solve one problem and go on to solve the next one.

If you don't even bother the solution to that specific problem, you
won't bother any debug procedure provided by any developer.

>=20
>> Whether you believe is your problem then.
>=20
> No, it's not, simply because I don't have a problem...
>=20
> btrfs has problems, and I reported one, that's all that has happened.

You reported several problem without proper reproducer.

You can reproduce it on your system is not a proper reproducer.
I provided one solution to one of your problems, you ignored and that's
your problem.

I don't see any point to debug any bugs reported by the one who doesn't
even want to try a known solution but insists on whatever he believe is
correct.

>=20
> I slowly get the distinct feeling that reporting bugs in btrfs us a fut=
ile
> exercise, though.
>=20


--R2XwauAAFxW8Cwxv1BDmtU0gCTLRA5JKX--

--OkefdnTeImzJs9eEOV2JfsgxGjegGrLuR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl79OEcACgkQwj2R86El
/qhkOgf+KRpBBFJe2VVCyxpHE0cX9D2LLzMRow1+my4RAhbAuQ+QkL1L38M7hJjW
OGJF03Pj5mlwBEE1FFNHFYxrVPIt0bguqdQpZSIY/Bb1aGJYkH7yIXEWIRqEWkkq
JKsGPnJlbXRVrJVQMVnz+4kQncQQmEAWWhuDBLVVOwCtVegewqWn3FF/B3+y+g5F
40KCPP55yVTaiTxL/rwxVeY2j5jAuMazmcPfsnM3+dFPaFtzL3FDR/xieW4leqDy
GLt3ZjGfQWlBpsh8qGC9N+L5PiblDD8mWDsEZBO5LUNnrTz1ee3oDS/yvAoVA3Hp
cK693FRYckbc6VOarnZNZ/LplMubMg==
=+c5c
-----END PGP SIGNATURE-----

--OkefdnTeImzJs9eEOV2JfsgxGjegGrLuR--
