Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3551012BC14
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Dec 2019 02:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfL1BJ5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Dec 2019 20:09:57 -0500
Received: from mout.gmx.net ([212.227.17.21]:53249 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbfL1BJ4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Dec 2019 20:09:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577495389;
        bh=JV9rTEdYSG7ZumkYkldA0JOoJ6vuOMTbTV8tgUAEmF0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=T6VBf887HkVQWJCs2wEXd5Fyp2F3ub5XztGghaoZ9sgaZ7biTTV30iKlj0chJrx2y
         fANu2uAiy/iuq14zr4vTaK7X9Ise+B81aRoxIcEeE6eQFxPOXic3l8yIxYg+bZ19tE
         l8iJwtqYmWFkYMH4oP7xdx2o8WTyGWd0XaKSTaeo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MDysm-1isg7k15TI-009xyr; Sat, 28
 Dec 2019 02:09:49 +0100
Subject: Re: [PATCH RFC 0/3] Introduce per-profile available space array to
 avoid over-confident can_overcommit()
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191225133938.115733-1-wqu@suse.com>
 <34e46810-085e-e79e-c0f3-e6310baa3216@toxicpanda.com>
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
Message-ID: <0a71a88b-9942-ca8e-5478-d6ea48356daf@gmx.com>
Date:   Sat, 28 Dec 2019 09:09:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <34e46810-085e-e79e-c0f3-e6310baa3216@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IKeasXXyTrDBZUPcGNMeUoecBpzPfTlDE"
X-Provags-ID: V03:K1:1iP15Uaj3HqQiX+Qr7Hbi+OY3lZRFLjeiSAxjz+x6wx4Qs1Gzi5
 rODJoOlJIU/8zX3wRAfxjP+r7bmjDaHUUheH4m1r7VgKu00iFqY5sJQbABT5hexQqGCtBDZ
 9cUSh2lkvIkoX5mPyaPmPRNvsXuS8Aox+Uql0Qn3gbTOLCHnQGfAToeqcIl794B7gy6EWs2
 mN+NlZp5YYAdb9T36jp0A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pPo6PYwS7pk=:iKh1WiWPg8S8gjbzw8b1aX
 lHWRqW+p0EEv8Eig/ZwG+3JjeBgWD0w7DpK/u9OZTcciUmt0d8+Mscwgbaw6eJvfaMX0TerhV
 SKte4p+Q8WQX34ixC5ZQyq7q0Rc2Dt9/wKh6NpntaQ2N0ekaaUvHMb/YXITJNvoYqvGj078XK
 13PGHnJMoD2nUeDpLIuuwgkXyEkkM3yB+pM3yRVqgBjoAl8hWNMxFhiRtkE8WcaO+T+kYqLnC
 +MUlO1oP8XawgLXecJqb3sXx8LqN5Bz1y34NTy+mfxahha8xMSAYUQoESa6vVNNJ/XAfkY8S/
 1QpWIZ7kzBIPgSfZLD0CmmhP0LDHMRHHHg3o2x6XfOiQbSRTvqtcMD6qGkBoHe2D3AnGpUX/O
 Vkkle4kjSyND6E1JNr+ZPmyUMAQ/OB4TQEUcQule5TpydChkIMeZFwxRIZ9MON1eUAEmyBW87
 jWvfxculT2+u/cTjTO4ktoNqIuZbLN0Cu7gojmwDmqUSrlwxv7i06H7BVFZ8D1Uty6kgz8a/E
 1ZoLnbAhbEmmHE8QsWYyRvDON/I8zwVJvIpc3LFcbgY98qvsyB5i7iKMm22lrGAHUdOthTjB9
 nMddrCKUPEV0JscEstCo2YmCbgIEV5mt3PVyrmMjouMvVRmYhfyuXqqke3ptR2hPNlGdplAxL
 4wwf3PM4Zpubzhn9h0JTOoC1lUWzvrsOsDqkwmOJKlv36/bYLjXZK6S1+8c9/ZmtJqUzkEc/J
 y89SFzrJJiFzXlLczsG5MmZwewmsURClPKmm7qITr36UuDX40YqvlLFwi03Js8BFlpOzBdgvI
 rkwDNvdW37pOJDTAO/ydcdimXtGgAh7PEOIvv6hJt7CVTjbHR/I7PLufTXh44vMbcNwgy/mkB
 nFnAiz4tZMIDjLfBTE/QEhaFJSeihHOYc4jLrWvUtrendsJTZ790NbrJSMDY+OBFIxukKK9Zj
 HJLWj2arPgSFNaYg93aeg9BFTnV5kd1PUY45M8FKESfT5effDKJJPly62/E6lx38DEY9o8NOf
 w48BJzHY1cm28qIrg10fTHc5czN9ScwRahTGFAwCadCsHUB7ilTSAJzXzkLhpiwVfpHFoMG7t
 8MmtnrlpOXlbh3U5P+d07Ev3NBkw2+/YCezQf6OvhypjaVULZeBa8f9+/Ukm8ebaggfRct216
 vZh7a39lqNGkUCc8ADZLLIDORwD4yWDowoy0Fbs6vgyK+vvPn9v0TUFLtC503NW4jCQgUeEjO
 Rod1uv70Qnm5Q8LuneJIAC0Nl8Hc9EE+MrgBbUU5blGZP7gLGQ/8FErVSerw=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IKeasXXyTrDBZUPcGNMeUoecBpzPfTlDE
Content-Type: multipart/mixed; boundary="5xpqlltxxAPG3QOUIaCi6rm9eCd6Z2Ti7"

--5xpqlltxxAPG3QOUIaCi6rm9eCd6Z2Ti7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/28 =E4=B8=8A=E5=8D=882:32, Josef Bacik wrote:
> On 12/25/19 8:39 AM, Qu Wenruo wrote:
>> There are several bug reports of ENOSPC error in
>> btrfs_run_delalloc_range().
>>
>> With some extra info from one reporter, it turns out that
>> can_overcommit() is using a wrong way to calculate allocatable metadat=
a
>> space.
>>
>> The most typical case would look like:
>> =C2=A0=C2=A0 devid 1 unallocated:=C2=A0=C2=A0=C2=A0 1G
>> =C2=A0=C2=A0 devid 2 unallocated:=C2=A0 10G
>> =C2=A0=C2=A0 metadata profile:=C2=A0=C2=A0=C2=A0 RAID1
>>
>> In above case, we can at most allocate 1G chunk for metadata, due to
>> unbalanced disk free space.
>> But current can_overcommit() uses factor based calculation, which neve=
r
>> consider the disk free space balance.
>>
>>
>> To address this problem, here comes the per-profile available space
>> array, which gets updated every time a chunk get allocated/removed or =
a
>> device get grown or shrunk.
>>
>> This provides a quick way for hotter place like can_overcommit() to gr=
ab
>> an estimation on how many bytes it can over-commit.
>>
>> The per-profile available space calculation tries to keep the behavior=

>> of chunk allocator, thus it can handle uneven disks pretty well.
>>
>> The RFC tag is here because I'm not yet confident enough about the
>> implementation.
>> I'm not sure this is the proper to go, or just a over-engineered mess.=

>>
>=20
> In general I like the approach, however re-doing the whole calculation
> once we add or remove a chunk seems like overkill.=C2=A0 Can we get awa=
y with
> just doing the big expensive calculation on mount, and then adjust
> available up and down as we add and remove chunks?

That looks good on a quick glance, but in practice it may not work as
expected, mostly due to the small difference in sort.

Current chunk allocator works by sorting the max hole size as primary
sort index, thus it may cause difference on some corner case.
Without proper re-calculation, the difference may drift larger and larger=
=2E

Thus I prefer to be a little safer to do extra calculation each time
chunk get allocated/remove.
And that calculation is not that heavy, it just iterate the device lists
several times, and all access are in-memory without sleep, it should be
pretty fast.

Thanks,
Qu

>=C2=A0 We know the chunk
> allocator is not going to allow us to allocate more chunks than our
> smallest device, so we can be sure we're never going to go negative, an=
d
> removing chunks is easy again because of the same reason.
>=20
> Other than that the approach seems sound to me.=C2=A0 Thanks,
>=20
> Josef


--5xpqlltxxAPG3QOUIaCi6rm9eCd6Z2Ti7--

--IKeasXXyTrDBZUPcGNMeUoecBpzPfTlDE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4Gq1gACgkQwj2R86El
/qixGQgAih92zvqtoWwJ9VtztuqCrLr8OaTj9Swrc5pA/hfXu4CJ3/Rajng2kSlB
3kWE8e4+2y6AhfAWPilPaJM7gCvFmFlQzk5s8xgccFvnPywgXkg2VY1PZ27PbXbm
48rxqjt8U4akbSzJ2gUzPKdXZww8TsY74dQjKMMvnbzP5cwf1jXaC6O4wZsHnuNd
uJ8h1JHEFhAH7dEOHo/tZZQGWk+xqLinzqzJUIR4PViFOIa2r/Cj/LZN3cnFEY4i
UVybeEvfXyK9RGBxVVbsgM6QZRvLXGAJ+DaLgbMiq1LmY2BsFM2I/RWnTl+dVRPD
sGWJpy9H8gHrhgEY0AsIAFC3K5YDgQ==
=eMi9
-----END PGP SIGNATURE-----

--IKeasXXyTrDBZUPcGNMeUoecBpzPfTlDE--
