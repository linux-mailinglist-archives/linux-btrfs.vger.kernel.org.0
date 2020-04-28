Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA8C1BBA67
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Apr 2020 11:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgD1Jym (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Apr 2020 05:54:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:48493 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgD1Jyl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Apr 2020 05:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588067665;
        bh=X249P7Ht7J/+FMsZH5ubwZmceeMkdF+kvTqq153rHFk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=D19U/yGynr6kdt6FfC7myk9MW/Ztgf/v1eaPlm8RRtUo3B/k+f2W5HgdaZGRFykJT
         lQcgpDDSvXpCYFBixpnn7nemNTxapskKor8d9mM618Ndsf3LUPyyqBksK1tBSLAcyA
         vBxBbq6r2MlvBqpLq0eknm+jQfosAgbatDlo4GfY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0X8u-1jEqIO1Ly0-00wV0D; Tue, 28
 Apr 2020 11:54:24 +0200
Subject: Re: Balance loops: what we know so far
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <20200411211414.GP13306@hungrycats.org>
 <b3e80e75-5d27-ec58-19af-11ba5a20e08c@gmx.com>
 <20200428045500.GA10769@hungrycats.org>
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
Message-ID: <ea42b9cb-3754-3f47-8d3c-208760e1c2ac@gmx.com>
Date:   Tue, 28 Apr 2020 17:54:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428045500.GA10769@hungrycats.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EJxBSCGY7B0HYMRZL388McqKV1N0bHYa1"
X-Provags-ID: V03:K1:emH2aEtPwkH4+8Ygd3bmXHbZkEMSB9YMLlRj8GGQoDIgRib6TD6
 pk6lerC+wEEzLhq7CR8UrobDIhEm0jSXk1oc9/UdJ6CT9lC/d9oNId4a79LtNesFAr0NZzC
 0GZM9h+iqHHyYN7pxVtuhiHTCe7irykGd3h8sLCJuGg6mGlzZEw/xVI9ZBlx4bTAyLMu9OJ
 9eKxnGW5wlXKgk1Y2ipBg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1AO3ATaAhH0=:XiHgYx0eCjukCJsALR4Z98
 4qez7voXEqvafraY2xwB3fomNMnWp5MGYr+7JfCftLsWW0AIObufgr22MTL8SjB78P88cVIKu
 Qwmwm/1QPkaMDgIIKg04djSGM5ifWmvVyAkcqUmgR3xxc+/7YQJAVdJ6YowcQwp0ngK3dV36m
 GE/zRp5eMcEf1Dy8puQ5eKk/UBWmXWixUu3PKAgfGm95NUAFyOeskSjKwQN3ZWIyQKmf+mwFY
 CJSCb4efYgbHS+/NQWdqwnsCJvNsp56MR/qBDNPi6DjvzwPZRHdiYcOGI2w8C3P0PG/8DqzSZ
 scQEXmXc+P0BPSxXyr/ze2XmoVVD4UXpSUubnv+pCUa5+l2vp/zq96SmhOfu1pT92LEbcbo1u
 TDLTRCTvJLChiZt7d6IOufMqxhc3XSf2C8gEd43xxfRqKkbA4IhNCiUgd7EqjmRbGC8qFnnSS
 Nn52W5UgWoCFoi4qBP3j5otQoVmtk1p32HIiENNNJTxgJG5tFWCRia1V679KoPewFQwqNyZaZ
 h0nl8bMcRQ6BVcOTXB1CzBxteM62hBezfdqX7BSAK3sOzSOzhXI8LxjepQN0Av9KUz8OtvQNZ
 q2J7aPfGSg/DecAhW/fG2x8mbPCHjkmt7pBUTFhbRmxTs1pYA4j/uWdfSeKI1AenvAQ7fIUf5
 w8IPr0ht5Z8jonrCOxfw7SzSFcmtovk1WDxjau9FZivyVwQOV623XerVg867BVbdd0lg1p0Nf
 k0D4xAWN2phENw3aipb5LKRlgSTDAf1wnX/OsA0W3Rbo2Mcv6inQfEkPXQCoT/FDwUg581oaj
 iXp1N83L6urjBArBX547Mtd7t5acA3tyWR6LpCw5zuWzEJq9auFQTyVaz/bPxqCQp9an+2ZR0
 J31fYYhvLxo6JxwTlMV0DJn+vFyFdaJ9VQg/MV0tdKMeZx+ETxK0LDDLrbvZRDvlefLI7ZhiC
 5a9D0wqJMCyiM6wAI+DQKQ/DxfxT7OxDFwSCJBgkYs2Q74auQZNYk5pFkrzafJkoYCv6CI1XV
 oLQnxGBq+2O/Rv7sAMx72CsvY+SH/fBL4miat16XFshtfXYxFn4JYEzvXQ28s2o70fBwmqzx4
 o7Re/75EwXlHIH21SswGvDeiWUga/uHhURHf5v4Xqu+VITkp879IM0v0zoDrJQlMhKk3KpzMn
 a1tvA/fucni7J9nSLmNhE5tXuFzUkG4mIWTFmDyxcXkH86ciBor/Pd2SSw2Y5PfnuQfyccWUM
 u/pIEjDrMIvT53+qx
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EJxBSCGY7B0HYMRZL388McqKV1N0bHYa1
Content-Type: multipart/mixed; boundary="yQUgy9zMIEQ6P8irzw14jRwW6qNHL2pQJ"

--yQUgy9zMIEQ6P8irzw14jRwW6qNHL2pQJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/4/28 =E4=B8=8B=E5=8D=8812:55, Zygo Blaxell wrote:
> On Mon, Apr 27, 2020 at 03:07:29PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2020/4/12 =E4=B8=8A=E5=8D=885:14, Zygo Blaxell wrote:
>>> Since 5.1, btrfs has been prone to getting stuck in semi-infinite loo=
ps
>>> in balance and device shrink/remove:
>>>
>>> 	[Sat Apr 11 16:59:32 2020] BTRFS info (device dm-0): found 29 extent=
s, stage: update data pointers
>>> 	[Sat Apr 11 16:59:33 2020] BTRFS info (device dm-0): found 29 extent=
s, stage: update data pointers
>>> 	[Sat Apr 11 16:59:34 2020] BTRFS info (device dm-0): found 29 extent=
s, stage: update data pointers
>>> 	[Sat Apr 11 16:59:34 2020] BTRFS info (device dm-0): found 29 extent=
s, stage: update data pointers
>>> 	[Sat Apr 11 16:59:35 2020] BTRFS info (device dm-0): found 29 extent=
s, stage: update data pointers
>>>
>>> This is a block group while it's looping, as seen by python-btrfs:
>>>
>>> 	# share/python-btrfs/examples/show_block_group_contents.py 193491317=
5552 /media/testfs/
>>> 	block group vaddr 1934913175552 length 1073741824 flags DATA used 93=
9167744 used_pct 87
[...]
>>>
>>> All of the extent data backrefs are removed by the balance, but the
>>> loop keeps trying to get rid of the shared data backrefs.  It has
>>> no effect on them, but keeps trying anyway.
>>
>> I guess this shows a pretty good clue.
>>
>> I was always thinking about the reloc tree, but in your case, it's dat=
a
>> reloc tree owning them.
>=20
> In that case, yes.  Metadata balances loop too, in the "move data exten=
ts"
> stage while data balances loop in the "update data pointers" stage.

Would you please take an image dump of the fs when runaway balance happen=
ed?

Both metadata and data block group loop would greatly help.

>=20
>> In that case, data reloc tree is only cleaned up at the end of
>> btrfs_relocate_block_group().
>>
>> Thus it is never cleaned up until we exit the balance loop.
>>
>> I'm not sure why this is happening only after I extended the lifespan =
of
>> reloc tree (not data reloc tree).
>=20
> I have been poking around with printk to trace what it's doing in the
> looping and non-looping cases.  It seems to be very similar up to
> calling merge_reloc_root, merge_reloc_roots, unset_reloc_control,
> btrfs_block_rsv_release, btrfs_commit_transaction, clean_dirty_subvols,=

> btrfs_free_block_rsv.  In the looping cases, everything up to those
> functions seems the same on every loop except the first one.
>=20
> In the non-looping cases, those functions do something different than
> the looping cases:  the extents disappear in the next loop, and the
> balance finishes.
>=20
> I haven't figured out _what_ is different yet.  I need more cycles to
> look at it.
>=20
> Your extend-the-lifespan-of-reloc-tree patch moves one of the
> functions--clean_dirty_subvols (or btrfs_drop_snapshot)--to a different=

> place in the call sequence.  It was in merge_reloc_roots before the
> transaction commit, now it's in relocate_block_group after transaction
> commit.  My guess is that the problem lies somewhere in how the behavio=
r
> of these functions has been changed by calling them in a different
> sequence.
>=20
>> But anyway, would you like to give a try of the following patch?
>> https://patchwork.kernel.org/patch/11511241/
>=20
> I'm not sure how this patch could work.  We are hitting the found_exten=
ts
> counter every time through the loop.  It's returning thousands of exten=
ts
> each time.
>=20
>> It should make us exit the the balance so long as we have no extra
>> extent to relocate.
>=20
> The problem is not that we have no extents to relocate.  The problem is=

> that we don't successfully get rid of the extents we do find, so we kee=
p
> finding them over and over again.

That's very strange.

As you can see, for relocate_block_group(), it will cleanup reloc trees.

This means either we have reloc trees in use and not cleaned up, or some
tracing mechanism is not work properly.

Anyway, if image dump with the dead looping block group specified, it
would provide good hint to this long problem.

Thanks,
Qu

>=20
> In testing, the patch has no effect:
>=20
> 	[Mon Apr 27 23:36:15 2020] BTRFS info (device dm-0): found 4800 extent=
s, stage: update data pointers
> 	[Mon Apr 27 23:36:21 2020] BTRFS info (device dm-0): found 4800 extent=
s, stage: update data pointers
> 	[Mon Apr 27 23:36:27 2020] BTRFS info (device dm-0): found 4800 extent=
s, stage: update data pointers
> 	[Mon Apr 27 23:36:32 2020] BTRFS info (device dm-0): found 4800 extent=
s, stage: update data pointers
> 	[Mon Apr 27 23:36:38 2020] BTRFS info (device dm-0): found 4800 extent=
s, stage: update data pointers
> 	[Mon Apr 27 23:36:44 2020] BTRFS info (device dm-0): found 4800 extent=
s, stage: update data pointers
> 	[Mon Apr 27 23:36:50 2020] BTRFS info (device dm-0): found 4800 extent=
s, stage: update data pointers
> 	[Mon Apr 27 23:36:56 2020] BTRFS info (device dm-0): found 4800 extent=
s, stage: update data pointers
> 	[Mon Apr 27 23:37:01 2020] BTRFS info (device dm-0): found 4800 extent=
s, stage: update data pointers
> 	[Mon Apr 27 23:37:07 2020] BTRFS info (device dm-0): found 4800 extent=
s, stage: update data pointers
> 	[Mon Apr 27 23:37:13 2020] BTRFS info (device dm-0): found 4800 extent=
s, stage: update data pointers
> 	[Mon Apr 27 23:37:19 2020] BTRFS info (device dm-0): found 4800 extent=
s, stage: update data pointers
> 	[Mon Apr 27 23:37:24 2020] BTRFS info (device dm-0): found 4800 extent=
s, stage: update data pointers
> 	[Mon Apr 27 23:37:30 2020] BTRFS info (device dm-0): found 4800 extent=
s, stage: update data pointers
>=20
> The above is the tail end of 3320 loops on a single block group.
>=20
> I switched to a metadata block group and it's on the 9th loop:
>=20
> 	# btrfs balance start -mconvert=3Draid1 /media/testfs/
> 	[Tue Apr 28 00:09:47 2020] BTRFS info (device dm-0): found 34977 exten=
ts, stage: move data extents
> 	[Tue Apr 28 00:12:24 2020] BTRFS info (device dm-0): found 26475 exten=
ts, stage: move data extents
> 	[Tue Apr 28 00:18:46 2020] BTRFS info (device dm-0): found 26475 exten=
ts, stage: move data extents
> 	[Tue Apr 28 00:23:24 2020] BTRFS info (device dm-0): found 26475 exten=
ts, stage: move data extents
> 	[Tue Apr 28 00:25:54 2020] BTRFS info (device dm-0): found 26475 exten=
ts, stage: move data extents
> 	[Tue Apr 28 00:28:17 2020] BTRFS info (device dm-0): found 26475 exten=
ts, stage: move data extents
> 	[Tue Apr 28 00:30:35 2020] BTRFS info (device dm-0): found 26475 exten=
ts, stage: move data extents
> 	[Tue Apr 28 00:32:45 2020] BTRFS info (device dm-0): found 26475 exten=
ts, stage: move data extents
> 	[Tue Apr 28 00:37:01 2020] BTRFS info (device dm-0): found 26475 exten=
ts, stage: move data extents
>=20
>=20
>> Thanks,
>> Qu
>>
>>>
>>> This is "semi-infinite" because it is possible for the balance to
>>> terminate if something removes those 29 extents (e.g. by looking up t=
he
>>> extent vaddrs with 'btrfs ins log' then feeding the references to 'bt=
rfs
>>> fi defrag' will reduce the number of inline shared data backref objec=
ts.
>>> When it's reduced all the way to zero, balance starts up again, usual=
ly
>>> promptly getting stuck on the very next block group.  If the _only_
>>> thing running on the filesystem is balance, it will not stop looping.=

>>>
>>> Bisection points to commit d2311e698578 "btrfs: relocation: Delay rel=
oc
>>> tree deletion after merge_reloc_roots" as the first commit where the
>>> balance loops can be reproduced.
>>>
>>> I tested with commit 59b2c371052c "btrfs: check commit root generatio=
n
>>> in should_ignore_root" as well as the rest of misc-next, but the bala=
nce
>>> loops are still easier to reproduce than to avoid.
>>>
>>> Once it starts happening on a filesystem, it seems to happen very
>>> frequently.  It is not possible to reshape a RAID array of more than =
a
>>> few hundred GB on kernels after 5.0.  I can get maybe 50-100 block gr=
oups
>>> completed in a resize or balance after a fresh boot, then balance get=
s
>>> stuck in loops after that.  With the fast balance cancel patches it's=

>>> possibly to recover from the loop, but futile, since the next balance=

>>> will almost always also loop, even if it is passed a different block
>>> group.  I've had to downgrade to 5.0 or 4.19 to complete any RAID
>>> reshaping work.
>>>
>>
>=20
>=20
>=20


--yQUgy9zMIEQ6P8irzw14jRwW6qNHL2pQJ--

--EJxBSCGY7B0HYMRZL388McqKV1N0bHYa1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6n/U0ACgkQwj2R86El
/qgeqAf/SNqAHBLvABlqc8imZEEl1YoNEtX1ez/Zhr0S4LN3XDTOQUdsmnznCaOf
b/3Nh8V9Q8mNulSToAeYtz9XLuca1IU4EYrNBhOHyZ3oNWZxOPpw3erpW09HyQIA
EOmtBB1H2V8yUY86+htk4ICSRmONTq7YvT5VLRnu5mCORfNAPop9Tl3P08ezZMGW
wBDOcw+Wt9TSyt7CaJizelnCclr2cu+BourMqesvH2yoZQNHFEFk+qpazizzuacf
DX+jTk3F0qvkVvHMkBDDiQfDuedvczzGigyfJgRTs35E/TkrB5OBOXrMQd3WmBQL
SA/jCm8iRg0Yvzb1FnLuvoW928VD4Q==
=o5SM
-----END PGP SIGNATURE-----

--EJxBSCGY7B0HYMRZL388McqKV1N0bHYa1--
