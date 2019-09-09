Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94EE8AD262
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Sep 2019 05:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387895AbfIIDws (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Sep 2019 23:52:48 -0400
Received: from mout.gmx.net ([212.227.15.18]:47909 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfIIDws (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 8 Sep 2019 23:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568001122;
        bh=DUd7op19zb97sEn9jTpo31X9LMzfBrirO+yWeQhBQ2o=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=i4OR10bDWH1zK0NtGIEj/T2S1jW3pe1X+jgntLDcb3Q2LavO9QnLbQbp/YIV3t9VB
         AeqPBx3M+61H4L3Ls6107gkR4Qe1bWHDsqCe+8HRcbhI5T2atJaZe+K4lnGMPeCCS/
         qZmFYTtEb9SB5SAY6sicCJ65ycxrZnEXLUdNWFhA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MH0SI-1huZnM07fe-00DpQh; Mon, 09
 Sep 2019 05:52:02 +0200
Subject: Re: Feature requests: online backup - defrag - change RAID level
To:     zedlryqc@server53.web-hosting.com, linux-btrfs@vger.kernel.org
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
Message-ID: <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
Date:   Mon, 9 Sep 2019 11:51:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vNpmr4XbZd2qMqcwutABVub6aH9bX9nj6"
X-Provags-ID: V03:K1:ct7rDB/1FLInz0Pd9KoFTbCf/G5OvFndwmLweJhHCDt0IddQdb+
 XiGcthJOZgf0rZFT3MF8WhrJp8Y1YbBPOU4PWu1gKZHOW+wjYfF18P3CYq9qGnf8GRWJRS1
 QcO2llabRI17yltfRdn0rUf/dsv0/GONGI6jqjqKf13ifrHGQxBzTCgN5NGvjtc9sxh0MlN
 gjZShe3ud80F9O5By5bxg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:C7j1JY0DKPA=:wa9lhLLyuOtjZdXBl4qdNb
 QpA6HN+7KCUVB2MxZ8jVyugvLd6ZNZfQfcXX0ugPrDLbTUhl5FUwR+QilxydQ0mtRXwo3aAn9
 G6XwBwuFi7fpirOO3n2kvjMRrpTX9HgVrs0n7kB7cHmtgcj7SxrPjNz+I+EePoYhwLosSNtfN
 ECgGp13Dp850jsHVt3mP1lWnAH3lmbymLo4y9Y9ZERBd9U6BC490NYlt7NVeZsQXWRjKQgzDW
 IvjLJeFsZoIAW1ZhNsbzFkH7SBoKrNTlEhD4DZuTe4oWVmGl6c4lHmDQZzBxHb4aDpn+m6sj8
 ooubaFcS9rRMU3ABaikMToV7g7w8rR7U/1Zgn6o/U4+spx5ZELtuV6VLoT9NIODiFuOfADabX
 5M3vNLO5smP3liU4w2o576FznuWD5VSG+nzvI8+foiPwSNbVy2Br+8niOKgYFeKyHvR4Dt4U3
 YbIRkyFKFlF7HR4hZJtsospIGENsg/EJFMkjPje/1Vqcs22/WzJJc9KdeMzrpAmjbKlBXiVnP
 8CIHDrKtHTbXV6cJFUO32k3JOb++8qkqwdN9KncyUFCgLdylBd5ldd77tIF8l4QWgNKgSdnEW
 oFCMGsvlNZQTt6bgl6px58oqzp0jocAcSq85r1OA/wxFfoBYuIrBuWZb/eJ+HvlqAX29ZIEH0
 m1uVE5j5ziFM6iXeYc4fQ5QNrO2ofFA6o3E7XQnM5VMvh9O0Imz8P2OK0/FSiCq/NkRycXi/t
 AJhG3hlGWw72fMTjaqFX3LG63t+qkJ7ivVzGaddaEXJCWJ262duY3lCUsI9/mAbaVyuudUsJ8
 /TwdWXhhfxpKQuSUAG/9+CXBOux3yGWZ0I9ci/V+1PbVvuV9iGf+y//1/a7sAqghpUjlEsUnr
 e794IohhOcfzv+F5KyG21lEozJGLyauv9k1MU1yElmwaSdZKPHhwDwetDisrwzTeGj+5K3+8s
 54UAXd13yRrB8qdOHBRmF1avbUKnzdOBWR5eqMfXlS2NRGQhjZFxqW2ImvUWebLTK3SrDKzGL
 TeOl1kDpdGQcw4MbacF9RWNGanMPI1nkCqtnkikQrsb6aCmialPpjFOpMy/VcqHlZkmABjVe8
 BAQDeYndqeHfrtwoOlj1XUH4JdyX32xNPn6dqXIbb2v2C/goWpFTNHqKgD2Teyun9/EQFvta2
 ytD8HNkmo3lpwm1CySz0+87Arh5jEjT2O2RoyS67nrSzUz3PvZG1a5RI3baiHyC9i3HVpCuws
 phVJN2uVOzyjNTmw5
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vNpmr4XbZd2qMqcwutABVub6aH9bX9nj6
Content-Type: multipart/mixed; boundary="2oCjeLhXF0cRJNriNnH279ZQYmH1iARMP"

--2oCjeLhXF0cRJNriNnH279ZQYmH1iARMP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/9 =E4=B8=8A=E5=8D=8810:55, zedlryqc@server53.web-hosting.com wr=
ote:
> Hello everyone!
>=20
[...]
> =C2=A0
> 1) Full online backup (or copy, whatever you want to call it)
> btrfs backup <filesystem name> <partition name> [-f]
> - backups a btrfs filesystem given by <filesystem name> to a partition
> <partition name> (with all subvolumes).

Why not just btrfs send?

Or you want to keep the whole subvolume structures/layout?

> =C2=A0
> - To be performed by creating a new btrfs filesystem in the destination=

> partition <partition name>, with a new GUID.

I'd say current send/receive is more flex.
And you also needs to understand btrfs also integrates volume
management, thus it's not just <partition name>, you also needs RAID
level and things like that.


> - All data from the source filesystem <filesystem name> is than copied
> to the destination partition, similar to how RAID1 works.
> - The size of the destination partition must be sufficient to hold the
> used data from the source filesystem, otherwise the operation fails. Th=
e
> point is that the destination doesn't have to be as large as source,
> just sufficient to hold the data (of course, many details and concerns
> are skipped in this short proposal)

All can be done already by send/receive, although at subvolume level.

Please check if send/receive is suitable for your use case.

[...]
> =C2=A0
> 2) Sensible defrag
> The defrag is currently a joke. If you use defrag than you better not
> use subvolumes/snapshots. That's... very=E2=80=A6 hard to tolerate. Qui=
te a
> necessary feature. I mean, defrag is an operation that should be
> performed in many circumstances, and in many cases it is even
> automatically initiated. But, btrfs defrag is virtually unusable. And,
> it is unusable where it is most needed, as the presence of subvolumes
> will, predictably, increase fragmentation by quite a lot.
> =C2=A0
> How to do it:
> - The extents must not be unshared, but just shuffled a bit. Unsharing
> the extents is, in most situations, not tolerable.

I definitely see cases unsharing extents makes sense, so at least we
should let user to determine what they want.

> =C2=A0
> - The defrag should work by doing a full defrag of one 'selected
> subvolume' (which can be selected by user, or it can be guessed because=

> the user probably wants to defrag the currently mounted subvolume, or
> default subvolume). The other subvolumes should than share data (shared=

> extents) with the 'selected subvolume' (as much as possible).

What's wrong with current file based defrag?
If you want to defrag a subvolume, just iterate through all files.

> =C2=A0
> - I think it would be wrong to use a general deduplication algorithm fo=
r
> this. Instead, the information about the shared extents should be
> analyzed given the starting state of the filesystem, and than the
> algorithm should produce an optimal solution based on the currently
> shared extents.

Please be more specific, like giving an example for it.

> =C2=A0
> Deduplication is a different task.
> =C2=A0
> 3) Downgrade to 'single' or 'DUP' (also, general easy way to switch
> between RAID levels)
> =C2=A0
> Currently, as much as I gather, user has to do a "btrfs balance start
> -dconvert=3Dsingle -mconvert=3Dsingle
> ", than delete a drive, which is a bit ridiculous sequence of operation=
s.
> =C2=A0
> Can you do something like "btrfs delete", but such that it also
> simultaneously converts to 'single', or some other chosen RAID level?

That's a shortcut for chunk profile change.
My first idea of this is, it could cause more problem than benefit.
(It only benefits profile downgrade, thus only makes sense for
RAID1->SINGLE, DUP->SINGLE, and RAID10->RAID0, nothing else)

I still prefer the safer allocate-new-chunk way to convert chunks, even
at a cost of extra IO.

Thanks,
Qu

> =C2=A0
> ## I hope that you will consider my suggestions, I hope that I'm helpfu=
l
> (although, I guess, the short time I spent working with btrfs and
> writing this mail can not compare with the amount of work you are
> putting into it). Perhaps, teams sometimes need a different perspective=
,
> outsiders perspective, in order to better understand the situation.
> =C2=A0
> So long!
>=20


--2oCjeLhXF0cRJNriNnH279ZQYmH1iARMP--

--vNpmr4XbZd2qMqcwutABVub6aH9bX9nj6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl11zF4ACgkQwj2R86El
/qio9Qf+Pulc5LsGm7P2+f5A1TXP98sZEVS8W2pJgHCiD+nhCQs/tHh420ADCdij
BXxzSooTk/CpTQ998a+dnG/bkMbwC1JEWQY6wS9n2oleM/jBzWily1mJMSNY/9p2
gkcpXhYCRLe4GpWAqPh73TF3nX6UT2LvzbnwxrL9qbu8y72Szb8yRZbz635bqWou
CR/dj4zUsxsHa/C0CloJVKXJMSFZlf9yxAja1fE2y67V8c8FHSqtJ9wXihw4AQzp
h3JUPjiEsDQIJcd5PyYUqK+KA7xGNYNp6HdTfrWBhOhSQeclgRP15Ae4CLSyO08q
hkLdnOgWDEoedwLVBZGXJr6MER5UDg==
=ViiQ
-----END PGP SIGNATURE-----

--vNpmr4XbZd2qMqcwutABVub6aH9bX9nj6--
