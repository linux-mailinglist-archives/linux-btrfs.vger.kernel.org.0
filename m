Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD781B981F
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Apr 2020 09:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgD0HHi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Apr 2020 03:07:38 -0400
Received: from mout.gmx.net ([212.227.15.18]:59795 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbgD0HHi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Apr 2020 03:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587971254;
        bh=3T3kUqnK/dd+89rH88Zuq/DELB96s4atNlPqzUl0Mc0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=XfzuBQSnbl96Sf5nGaT3pr0tjlZeeFvc5bibnhlq0IceINplL1t/RSzLhtdzWywD0
         pc9U4IagbBs3Se9uRgKAoUHyy29Ylm2YgowdogjZjyj75AFQNxZ6fWhk+Xl1ioAym6
         Z5ed3AhUdaO+f7Wjtxt/d+LEUmXkWoG6+Ypf8f6c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MD9X9-1jKTXI0dtp-0099mH; Mon, 27
 Apr 2020 09:07:33 +0200
Subject: Re: Balance loops: what we know so far
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
References: <20200411211414.GP13306@hungrycats.org>
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
Message-ID: <b3e80e75-5d27-ec58-19af-11ba5a20e08c@gmx.com>
Date:   Mon, 27 Apr 2020 15:07:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200411211414.GP13306@hungrycats.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8Rh3mrxOcXFuLUdM92sljHvG3uwAXoR9X"
X-Provags-ID: V03:K1:Jj5yYIAi590X+FYOFzaLVulpvja5eMBbjCNt9pnxNtWrHAQSgVt
 mg+YNyej3lrPBjy+DxLL3sGmainA96lngNe5gKkHXlipAzdMRIX4c5D7VeqIaLPQy/Bxrhq
 A9lgzGDoVzYev58Vp2crrUsy4FElGsU1gVvVDPYn5Frk6J31oy08BbEY1HI25byTySd6JY0
 m/8pTkE0eteLG4cw3uNPA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qpTZ0J5sEF4=:D8tPOIvKs1B76IeCY31AjO
 3r4v24qc6HXKrcC5O72pdgi0KtyedLSjK5Y4b0jkTWvAFGCarX9sD4TQjMWT1/YJk+V4hlApF
 70vGpDrZ8CG46d/7t9nAxH4Qec4CZ2CG9mJsQy8beN6IF0VGSbrkQ6PbWCHAzcaYlQAPetEKs
 xrF9Ib0AELGyfMbJipSkWtb11ouVLRvgrKdm0y17gz9qxYMB/6Vk/Knh8FYqoqNQ/pTAZbm3t
 ssxk9OiCxKGxqWM76UHq9jqg9nTUdWahs6pNmjMmpS/fT6pBwrV7zL0lduYOmWsa1EJinRlW2
 fc0tJDc9FH8YKzisH7GMrf5jria3NXxanR01BKnH3uaw3y91f8rJwXbEVslDINcqAHonheRGU
 0VKNvvAiyhmeyhXwS30VHspG56BUMaLJ3bcgA0fP0rdzSgxu97rmx3TSXz7pBclrLdMI8VE/N
 VSxl+U8lc5FgqQDs02+FkGIGq+5hhjhk8d0jVtRxOayadgqUP5kLNQ+e1kWZ6Hvx2TZwbmido
 28cbZVyis7PRsH3EuEn6LtXg83ZBOIxnnQ0HB9nmQHQNMg1Q7stuYMhQt0sbPOij5n40z86r0
 D3KxhLqEw30018FxpmZDVe7rCeSmnaN1nG5X2MoSOSbt2BJDZbKtsKku2AnKI29kXXNmeto9a
 QPueoa8wc8l5UnAPJmK9CR6sh6jSTCEvXhqT12sKv5xLfRnBR/RY5fkEq+06+FGe4jd+yHYA8
 4WZm8aBww0E4nYdMAhkWyiwC5I0+hH3uHFVAPF4gbIw3vJL+jSuaHF2lAe3DRx9mzRPWphQxw
 ETt28ulX+rK/VWXvdu0m7l/HHrhirTDZaK6RbsPIVVQ7fg7PJyh5kCg/c+ptcKDc7kBdfMIhn
 ABW3nULLRxdbZoJAS+n/lFfpFG6fMknz58PpBShKgqs4Ki+LOIyYGq73o/4kwpvFM1cb88O5z
 ScCW8Etpd9/uUt9b89uelXQ/nhAscS23RGjJUWEoXmY+Z4ATCnmohRXF7dXnjpw+ffuM4/fUf
 hYh7CU/P9xQG7ViTh7go5jX7IefcLk4WnXeLZn+Pj3hw5oeYBtU79AjujZH+Vu9ZZhIRlkUiy
 BN+EgTAK9z4KXXnxX+r5QbArU5raYrAJ0tPa/wUqM5e+hMpsAriYHX5dlVIhS6D9E4Xf2vdaL
 G5NO03hSonGLwlCd0F6nfA1PQ+n3yYqBMLqpiP2/V+tBFfQS0zYvM7XL5dvmloUhNY+uK7uiu
 0Z6ZcivALH3AfA3wU
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8Rh3mrxOcXFuLUdM92sljHvG3uwAXoR9X
Content-Type: multipart/mixed; boundary="a43yORhXBy8rnz4qDSJxvr4nxYcYIDtg0"

--a43yORhXBy8rnz4qDSJxvr4nxYcYIDtg0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/4/12 =E4=B8=8A=E5=8D=885:14, Zygo Blaxell wrote:
> Since 5.1, btrfs has been prone to getting stuck in semi-infinite loops=

> in balance and device shrink/remove:
>=20
> 	[Sat Apr 11 16:59:32 2020] BTRFS info (device dm-0): found 29 extents,=
 stage: update data pointers
> 	[Sat Apr 11 16:59:33 2020] BTRFS info (device dm-0): found 29 extents,=
 stage: update data pointers
> 	[Sat Apr 11 16:59:34 2020] BTRFS info (device dm-0): found 29 extents,=
 stage: update data pointers
> 	[Sat Apr 11 16:59:34 2020] BTRFS info (device dm-0): found 29 extents,=
 stage: update data pointers
> 	[Sat Apr 11 16:59:35 2020] BTRFS info (device dm-0): found 29 extents,=
 stage: update data pointers
>=20
> This is a block group while it's looping, as seen by python-btrfs:
>=20
> 	# share/python-btrfs/examples/show_block_group_contents.py 19349131755=
52 /media/testfs/
> 	block group vaddr 1934913175552 length 1073741824 flags DATA used 9391=
67744 used_pct 87
> 	extent vaddr 1934913175552 length 134217728 refs 1 gen 113299 flags DA=
TA
> 	    inline shared data backref parent 1585767972864 count 1
> 	extent vaddr 1935047393280 length 5591040 refs 1 gen 113299 flags DATA=

> 	    inline shared data backref parent 1585769349120 count 1
> 	extent vaddr 1935052984320 length 134217728 refs 1 gen 113299 flags DA=
TA
> 	    inline shared data backref parent 1585769349120 count 1
> 	extent vaddr 1935187202048 length 122064896 refs 1 gen 113299 flags DA=
TA
> 	    inline shared data backref parent 1585769349120 count 1
> 	extent vaddr 1935309266944 length 20414464 refs 1 gen 113299 flags DAT=
A
> 	    inline shared data backref parent 1585769365504 count 1
> 	extent vaddr 1935329681408 length 60555264 refs 1 gen 113299 flags DAT=
A
> 	    inline shared data backref parent 1585769365504 count 1
> 	extent vaddr 1935390236672 length 9605120 refs 1 gen 113299 flags DATA=

> 	    inline shared data backref parent 1585769381888 count 1
> 	extent vaddr 1935399841792 length 4538368 refs 1 gen 113299 flags DATA=

> 	    inline shared data backref parent 1585769381888 count 1
> 	extent vaddr 1935404380160 length 24829952 refs 1 gen 113299 flags DAT=
A
> 	    inline shared data backref parent 1585769381888 count 1
> 	extent vaddr 1935429210112 length 7999488 refs 1 gen 113299 flags DATA=

> 	    inline shared data backref parent 1585769398272 count 1
> 	extent vaddr 1935437209600 length 6426624 refs 1 gen 113299 flags DATA=

> 	    inline shared data backref parent 1585769627648 count 1
> 	extent vaddr 1935443636224 length 28676096 refs 1 gen 113299 flags DAT=
A
> 	    inline shared data backref parent 1585769644032 count 1
> 	extent vaddr 1935472312320 length 8101888 refs 1 gen 113299 flags DATA=

> 	    inline shared data backref parent 1585769644032 count 1
> 	extent vaddr 1935480414208 length 20455424 refs 1 gen 113299 flags DAT=
A
> 	    inline shared data backref parent 1585769644032 count 1
> 	extent vaddr 1935500869632 length 10215424 refs 1 gen 113299 flags DAT=
A
> 	    inline shared data backref parent 1585769660416 count 1
> 	extent vaddr 1935511085056 length 10792960 refs 1 gen 113299 flags DAT=
A
> 	    inline shared data backref parent 1585769676800 count 1
> 	extent vaddr 1935521878016 length 6066176 refs 1 gen 113299 flags DATA=

> 	    inline shared data backref parent 1585769709568 count 1
> 	extent vaddr 1935527944192 length 80896000 refs 1 gen 113299 flags DAT=
A
> 	    inline shared data backref parent 1585769725952 count 1
> 	extent vaddr 1935608840192 length 134217728 refs 1 gen 113299 flags DA=
TA
> 	    inline shared data backref parent 1585769742336 count 1
> 	extent vaddr 1935743057920 length 106102784 refs 1 gen 113299 flags DA=
TA
> 	    inline shared data backref parent 1585769742336 count 1
> 	extent vaddr 1935849160704 length 3125248 refs 1 gen 113299 flags DATA=

> 	    inline shared data backref parent 1585769742336 count 1
> 	extent vaddr 1935852285952 length 57344 refs 1 gen 113299 flags DATA
> 	    inline shared data backref parent 1585769742336 count 1
>=20
> All of the extent data backrefs are removed by the balance, but the
> loop keeps trying to get rid of the shared data backrefs.  It has
> no effect on them, but keeps trying anyway.

I guess this shows a pretty good clue.

I was always thinking about the reloc tree, but in your case, it's data
reloc tree owning them.

In that case, data reloc tree is only cleaned up at the end of
btrfs_relocate_block_group().

Thus it is never cleaned up until we exit the balance loop.

I'm not sure why this is happening only after I extended the lifespan of
reloc tree (not data reloc tree).

But anyway, would you like to give a try of the following patch?
https://patchwork.kernel.org/patch/11511241/

It should make us exit the the balance so long as we have no extra
extent to relocate.

Thanks,
Qu

>=20
> This is "semi-infinite" because it is possible for the balance to
> terminate if something removes those 29 extents (e.g. by looking up the=

> extent vaddrs with 'btrfs ins log' then feeding the references to 'btrf=
s
> fi defrag' will reduce the number of inline shared data backref objects=
=2E
> When it's reduced all the way to zero, balance starts up again, usually=

> promptly getting stuck on the very next block group.  If the _only_
> thing running on the filesystem is balance, it will not stop looping.
>=20
> Bisection points to commit d2311e698578 "btrfs: relocation: Delay reloc=

> tree deletion after merge_reloc_roots" as the first commit where the
> balance loops can be reproduced.
>=20
> I tested with commit 59b2c371052c "btrfs: check commit root generation
> in should_ignore_root" as well as the rest of misc-next, but the balanc=
e
> loops are still easier to reproduce than to avoid.
>=20
> Once it starts happening on a filesystem, it seems to happen very
> frequently.  It is not possible to reshape a RAID array of more than a
> few hundred GB on kernels after 5.0.  I can get maybe 50-100 block grou=
ps
> completed in a resize or balance after a fresh boot, then balance gets
> stuck in loops after that.  With the fast balance cancel patches it's
> possibly to recover from the loop, but futile, since the next balance
> will almost always also loop, even if it is passed a different block
> group.  I've had to downgrade to 5.0 or 4.19 to complete any RAID
> reshaping work.
>=20


--a43yORhXBy8rnz4qDSJxvr4nxYcYIDtg0--

--8Rh3mrxOcXFuLUdM92sljHvG3uwAXoR9X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6mhLEACgkQwj2R86El
/qhKtwgAgw5UCPwjawYNTOhCRWxnc3sxziRAtrP87FX9aIJ8CvaHTg5gGZNXUj5B
EJE7mJq8qd6QfhG9M6V7w/ha6vCu8nOuT4XnMYvtCIgCT4nI1woqaME3s/9kiyV2
En0OSPHJ02D1eKcH/BovIGIvANs7DoOD96p1uuwUZzcVMu+T8PV7gSWquIr3SmxF
vfqp34vNwrerKKp3tDFUDaT5ML2QITwByb9rl16Qt41a+1SpANNDuIXsC7NK5yKY
sLoyU18Y3pZ2d0mDggHLyuatl9rpq8fC/NUYAIqL2lznAhbnjRg4QfobRyrU7d1s
eVXFqCxZp7bwLIhHxNZubVbbbe+Exw==
=Wvw4
-----END PGP SIGNATURE-----

--8Rh3mrxOcXFuLUdM92sljHvG3uwAXoR9X--
