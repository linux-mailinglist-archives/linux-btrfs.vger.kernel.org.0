Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2F2E191DE8
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Mar 2020 01:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgCYAMO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Mar 2020 20:12:14 -0400
Received: from mout.gmx.net ([212.227.15.18]:41225 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbgCYAMN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Mar 2020 20:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585095131;
        bh=pVZ2xnC3aud0tAC4naVea2RunZ69rgA13ud5tIZt22c=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=EpfaEiOuyiGdFy9WtE7cgu+V2yN9p1lFphpScwwgqSBTPe5Mzs/Vd7qWKrGcVGgYB
         svEMX4O4Ur+g2Z503AdYDgAATN7pIVuv2n6X/LXaDUd6CtRohmUUz5L8Qo2Tv4SxK6
         Ye/iX3lQN8afHMYRbAKPRRVocGJOtSIr5KV++9SI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MPGRz-1iuAdD3EHV-00Ph17; Wed, 25
 Mar 2020 01:12:11 +0100
Subject: Re: extent generation_id
To:     Ganesh Sangle <sayganesha@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAJiQAnAJS-mSvQcC+8BActs53TZ6id+rc-CCO+DMWD9yJ810Ug@mail.gmail.com>
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
Message-ID: <5b73f866-3917-ee20-1787-7f410d27fa23@gmx.com>
Date:   Wed, 25 Mar 2020 08:12:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAJiQAnAJS-mSvQcC+8BActs53TZ6id+rc-CCO+DMWD9yJ810Ug@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vPo2EKX54oMYVg45HluMz3q2OwkXMcAy6"
X-Provags-ID: V03:K1:VB7Nc6jKbtvKctHpoY6klWUNZTpOb3o4NSd/RJmyD9kfXw5JG+3
 o++6+x50dX7TwvDyl/yFO+k1vXJmkapxmPjbLgEzFXWxl8Y3SLcTrrCKQZ/kH0FjUKV8kMq
 a5He94JovB7CXYcftGUJX6vv3sspU16+Kf6l0ajfQmEWrM2GqhEcDTnEIgybbfiQO2BXBsL
 BsZHU3DZoKf4sej5EN4eA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:G1pZ2QrOCaE=:cgrY1lr3NN5ChQWxqjzHcb
 My+QUgwrx8TvU6PyAkf+mEnSucLb1ptDo1o258S+rGys48fv7wUPYAU6VKDCxYnuFHYjqlgj3
 vri/2nASjhGTjO91qFkAGy4B67A63Vu6WrlU6F/VDb8UEnPxTZCgtq16fEIc1LWNuY6KwP/sw
 wUvtWByNTWsS/I6/VNHk2UrRrM6baCF8ULB9MJa4jNR9QYdJ58+iBk9vrB1/a90E5mbhQH1El
 hLZclN1L1ee+Nph09EIyh6E5ftui/Y7/tRA9xcKihc9JVRDuvjS8bhAxYvrzHwrBDgaU4gEnv
 k8eFvYLK8KiPM0R9+CqmqKcfw0nUQb1zHLz7Cq+aPePKOj7m62u1sol9Ys3ylgQZXRtSa1+6W
 beIBLq+Exrop1s38fpk5ShOOR/f2nUDyNdqvMVKPhJ6fWuUK+Z5C4U07i10zqETLc//8KwwcV
 AxZPJMZBHWFCbQIX4Poh8aFwx7ktpVtQXVkGJDnm2BsU62NIESZXWSm0ooDvZBG/pUTuI2uyS
 rjh5KhQfY/gcb4d1D99xW3p3ykti97mQWIVUv3a7NJIrb7JXO04HqogwdDC8eKf8LdYLiNk+k
 faUuSg41sLq3zz70YSPgsU3sxzFiH7txnb7OEWxvJQfk7cBs/gXPJG7R+TWjVrsKUqvXCWptc
 jP//fCkJ2Y+UrO7nMzeF29FnIj1PhznUIfhxxKDbwVSPbg6PQvS6m2WnzzrTlKmO54mP4ZnJj
 YsdM8cdygme+A+sqOnErZ3/H5PZ0Eg3sCdYSDnqLiuTtV/NOYTsiYyjG/L5Lx0T6ZcjOD1WGn
 WHOZvCu95K+QiDoSiDTONqO3nlenaODbv4BB6yJuOkOsa9cL59MHu/lh1IjvUePnXVfUZW6Fk
 r/Ctk+Zsj93zztyfLP2wImj0GF3Lqbe94JMCjEEtzChW9Iw5NyW6m5H6pJXNrv4FnJBN2VyLC
 3xKxF87mGmQ5jDN8E8dPfWLjfgCtHCDzCobDNdQHIdIE4hO2os60nDizTWiYB7UXvZuTRUb1d
 GBQHx4gL0QuHBaMgSgsB3Z5LERxuQA8X5Hz1P3ci+jYTaEgJZ2dRXwO8QqG7vwtBpajjXG5Kx
 bZamRFixlebH4oTknB6aMjTrhp4aVd3rP3SLOsW9ylM8Ze6CD+wKxRa460tJLrp+dO/xymVsU
 aIXjmfQejlPmFoZtkunS9gCcjWhQhjHxPL6ZFX6dOF6XEOGMMWeHTkusCpOSYVTbIm9myW9fj
 Io49F3XgFbqnA5PkY
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vPo2EKX54oMYVg45HluMz3q2OwkXMcAy6
Content-Type: multipart/mixed; boundary="2nQxJ6IkgKpKPL9tbaB3ZQQ5vQ1PsHeHA"

--2nQxJ6IkgKpKPL9tbaB3ZQQ5vQ1PsHeHA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/25 =E4=B8=8A=E5=8D=887:01, Ganesh Sangle wrote:
> hi,
> i am new to the email list - and i have a question. Please let me know
> if this is not the right forum for this question.
>=20
> While iterating the extents for a subvolume, btrfs_file_extent_item
> returns a generation_id - which is the "transaction id that created
> this extent".
> Is it safe to assume that every pwrite syscall will endup a generating
> new generation id for an extent, regardless if it is over-writing an
> existing extent (offset) or writing to a new never written (offset) ?

For data cow (the default behavior), all data writes, no matter buffered
(including pwrite) or direct IO, will lead to new extents, thus a new
generation.

Furthermore, even if we overwrite the whole existing extent, we won't
write directly into the existing extent, we will keep the existing
extent until current transaction is committed.
This is proper COW behavior, to ensure even we had a power loss, we will
either see the old data (and metadata) or new data (and metadata)

For no data cow case, overwriting existing extent won't update the
extent item, thus not update the generation (which skips some metadata
IO, and improves performance).

But no data cow case is limited in btrfs, even a file has NODATACOW bit
set, if there is a snapshot referring to that file, we will still do COW.=


> In other words, can we assume that if we have generation id associated
> with all extents of a snapshot (S1) of a volume, then we delete this
> snapshot, and then do some i/o(write/discard) to the volume and create
> a new snapshot (S2) from this volume, if we iterate over the extents
> of this new snapshot (S2) we will see a different generation id
> (compared to the one we got from the snapshot (S1)) if the i/o
> (write/discard) happened at an offset in that extent ?

Since the write happens after S1 is deleted, there is no guarantee that
CoW will still happen for NODATACOW files.
Thus we can overwrite existing extents, thus it's possible that no new
generation id generated.

Thanks,
Qu

>=20
> Thanks for the help !
>=20


--2nQxJ6IkgKpKPL9tbaB3ZQQ5vQ1PsHeHA--

--vPo2EKX54oMYVg45HluMz3q2OwkXMcAy6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl56odgACgkQwj2R86El
/qiOFAf/YTJMVq/4iYwM8LnkGPbNklk0iNBDUdXtfcRk/HkIJZCrkHAjvrvodBDF
VGHXoZJNXjoW+oZP/SOZrm7CHPhrwl6zFUoynBf96s/IyTS5moMl6lAPb0pOH4v0
hHpYRLJA4WZR763ZfGfYzajqglzRs32o69a27ci5bL/8ww7BSXcKfqtZaycpM4nf
GDjmyQQ4BybceJDGt0JHGepXmRWLSSHyS32RxI5U03ek+YykMR7ZKuOACBBleaMN
sF8hg3zdW2h3+EWIg76Ro1/VbVF9TG/HmRHj7WVBSWRHj5jw2Uoyuy52s5TFSMSS
iAdDkVRTw9tgUyA26p/pSqjwslymqA==
=Z59R
-----END PGP SIGNATURE-----

--vPo2EKX54oMYVg45HluMz3q2OwkXMcAy6--
