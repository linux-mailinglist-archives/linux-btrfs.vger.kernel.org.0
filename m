Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE0E0AD8C8
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Sep 2019 14:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387548AbfIIMTC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Sep 2019 08:19:02 -0400
Received: from mout.gmx.net ([212.227.15.19]:33207 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfIIMTB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Sep 2019 08:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568031495;
        bh=qa284vhU2yPy5+/Vl85aSz5z0hY/XA/eknGgZ9530gw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=X0g8LogfWzj4+1zHv5M8Y7wPZJiheZfrUPqTIwtyp2swG0CFp6QRCXT2qa6hHGb5b
         FykWcfbeXk4P3vcO3A5yLFq5H7eoXKpazf5cFYkq7tBW+ZStSWt/GY7uxu4X2twqPN
         zcPXmaw9p5Mk1f+e9otr1HXmpzm2M13JLYwDFYdc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MiacH-1iasXx23J1-00fm2w; Mon, 09
 Sep 2019 14:18:15 +0200
Subject: Re: Feature requests: online backup - defrag - change RAID level
To:     zedlryqc@server53.web-hosting.com, linux-btrfs@vger.kernel.org
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
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
Message-ID: <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
Date:   Mon, 9 Sep 2019 20:18:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JI3IIm0hXzzIud5IIxiGC00woe0dFs5l7"
X-Provags-ID: V03:K1:yA0lMff1a53INhdXR+2X94NuguzngAm5ylZ3aGny4kX4Y1F/4t5
 EZWBDQsXWoRuRp9SK5FsYqZ1BkklH/N6o5urxZQK7D/G3RH1JcOT0eMmIwfM0wY2nixVMbm
 QIKnaRkVCiAtkpVwWa4PuTjKss5NoD+RGiEAxxeh+Ei11cI8QjwCfOcDyqYiZXEN78+hdUf
 71Snp9PDnaKlZ/OjvxpkQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gab+6YKDfa4=:sZNWVgWqefep6GZTQrEcPE
 P69iEEifPpMNMbiIpft98K2nixbGPr8TBADQXDgAW95+bzRAjoOuOeKD7Ryvqxa0YhQFbk4DU
 /fY0HFnJq7XNz/qqokfxgx3fubOC31NYIUMSVML/xN1ODc7CoP1LPzRgEcwIRXkPzcZYiYLo6
 FVslPXg1Dk92aJLh4EKr9/YbtnomPK7Lg/oHyklAn8Ek9o4V0pz3/AA0Hqvpb6O1NLbx6VybA
 Wv9fZvTko6IZMAXM2RH/kBfpgzDZ6kwncs5X1Y5cupQhSnLDhXOzwSOW6tcYp9hwyiB7ZUmWa
 LUbrBtCJeyOCRP2X9/GBb1RgzMJ01kEDX8ByYgMnNJkU8gyyS5Qx5QkSIowFzgRko/ONomurj
 IfmxWCXiZhti2f0btrx3QRpUGXox6sCiqNCF4pFYFDV+JJA6xAhkYTjwo74+3VZsYEWX071yS
 j85k1dT/I9Pk6SpLMK7joqRCkP8aOKg2G2rELkhyWBFPPDVZEA7O9NE2SsKgM/lOWaQNissbz
 eujNS9XyCqW5BXELVPyoxYGnqtcNlXIqdEugyOhTW6KShhatWtFwUo/6vVeXnGZPsrI1ychVi
 VxZ/mNSxGvKpswe+qYVjznzPJEPSN9P8zf3DVagfWeHNJd6/csvZSr8AMcHzgIvukAJMaX/6s
 8liyMrBB5F+jmXPoOK1QllwXE4st3XT+zoNyb3Z9FIO6MhnMu4ccp0U1oGF6lJPpYkD2gEiwy
 EDEyqvWOmwWCUsJWFojMJi3mtGpv6hsCD7qTsjvlUkjsWDIXktxHScpgxgatqyqPMaiWjVwIn
 cZN2G+sZAxJbYFsIdKooaMMcKu8p8FAtmQMpIug/4prOEzwSJUp4OA10Iz5EVITDBHR/BKyDx
 Cn/uO4OyPN6B9eLDkbSYqKNc8Y2zus6sepU1gkm9PUTdj1AXrQLpXo/7EAICd9w6uabmRmdDj
 lBX5LNszGWO0oxxTZchIWrdrZeUZVqT2XpuJafv3qvoWBRQBXGkeWzac/oGodhNr6F63p/qzq
 Y04fmeqDC59TDLA4bhWanEQYgIDYx+8G3GCdPPJ0OIRsMkqww37dsNEyBFZD0jbWq8F0fyhry
 IqJhjjjygDZ+JqyzyiszsLLbGjyQA0so7hxIaDtwqaV9HPUmExY91BnjGewAgpFKnyLUxfZbo
 mHoFcgCWNtbEj172FcPmCpUtrOP7ceZyCA+rDk2T5FCiaW4XeNHlILbX6reNg7jrBwF1LGpNB
 xj6i2w6G8K3mD1Z3g
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JI3IIm0hXzzIud5IIxiGC00woe0dFs5l7
Content-Type: multipart/mixed; boundary="RpQ72WfRdzyL0VDVxabd6uxvFxqCoCKOk"

--RpQ72WfRdzyL0VDVxabd6uxvFxqCoCKOk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/9 =E4=B8=8B=E5=8D=887:25, zedlryqc@server53.web-hosting.com wro=
te:
>=20
> Quoting Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>> 1) Full online backup (or copy, whatever you want to call it)
>>> btrfs backup <filesystem name> <partition name> [-f]
>>> - backups a btrfs filesystem given by <filesystem name> to a partitio=
n
>>> <partition name> (with all subvolumes).
>>
>> Why not just btrfs send?
>>
>> Or you want to keep the whole subvolume structures/layout?
>=20
> Yes, I want to keep the whole subvolume structures/layout. I want to
> keep everything. Usually, when I want to backup a partition, I want to
> keep everything, and I suppose most other people have a similar idea.
>=20
>> I'd say current send/receive is more flex.
>=20
> Um, 'flexibility' has nothing to do with it. Send/receive is a
> completely different use case.
> So, each one has some benefits and some drawbacks, but 'send/receive'
> cannot replace 'full online backup'
>=20
> Here is where send/receive is lacking:
> =C2=A0=C2=A0=C2=A0=C2=A0- too complicated to do if many subvolumes are =
involved
> =C2=A0=C2=A0=C2=A0=C2=A0- may require recursive subvolume enumeration i=
n order to emulate
> 'full online backup'
> =C2=A0=C2=A0=C2=A0=C2=A0- may require extra storage space
> =C2=A0=C2=A0=C2=A0=C2=A0- is not mountable, not easy to browse the back=
up contents
> =C2=A0=C2=A0=C2=A0=C2=A0- not easy to recover just a few selected files=
 from backup
> There's probably more things where send/receive is lacking, but I think=

> I have given sufficient number of important differences which show that=

> send/receive cannot successfully replace the functionality of 'full
> online backup'.
>=20
>> And you also needs to understand btrfs also integrates volume
>> management, thus it's not just <partition name>, you also needs RAID
>> level and things like that.
>=20
> This is a minor point. So, please, let's not get into too many
> irrelevant details here.
>=20
> There can be a sensible default to 'single data, DUP metadata', and a
> way for a user to override this default, but that feature is
> not-so-important. If the user wants to change the RAID level, he can
> easily do it later by mounting the backup.
>=20
>>
>> All can be done already by send/receive, although at subvolume level.
>=20
> Yeah, maybe I should manually type it all for all subvolumes, one by
> one. Also must be carefull to do it in the correct order if I want it
> not to consume extra space.
> And the backup is not mountable.
>=20
> This proposal (workaround) of yours appears to me as too complicated,
> too error prone,
> missing important features.
>=20
> But, I just thought, you can actually emulate 'full online backup' with=

> this send/receive. Here is how.
> You do a script which does the following:
> =C2=A0=C2=A0=C2=A0=C2=A0- makes a temporary snapshot of every subvolume=

> =C2=A0=C2=A0=C2=A0=C2=A0- use 'btrfs send' to send all the temporary sn=
apshots, on-the-fly
> (maybe via pipe), in the correct order, to a proces running a 'brtfs
> receive', which should then immediately write it all to the destination=

> partition. All the buffers can stay in-memory.
> =C2=A0=C2=A0=C2=A0=C2=A0- when all the snapshots are received and writt=
en to destination,
> fix subvol IDs
> =C2=A0=C2=A0=C2=A0=C2=A0- delete temporary snapshots from source
> Of course, this script should then be a part of standard btrfs tools.
>=20
>> Please check if send/receive is suitable for your use case.
>=20
> No. Absolutely not.
>=20
>=20
>>> 2) Sensible defrag
>>> The defrag is currently a joke.
>=20
>>> How to do it:
>>> - The extents must not be unshared, but just shuffled a bit. Unsharin=
g
>>> the extents is, in most situations, not tolerable.
>=20
>> I definitely see cases unsharing extents makes sense, so at least we
>> should let user to determine what they want.
>=20
> Maybe there are such cases, but I would say that a vast majority of
> users (99,99%) in a vast majority of cases (99,99%) don't want the
> defrag operation to reduce free disk space.
>=20
>> What's wrong with current file based defrag?
>> If you want to defrag a subvolume, just iterate through all files.
>=20
> I repeat: The defrag should not decrease free space. That's the 'normal=
'
> expectation.

Since you're talking about btrfs, it's going to do CoW for metadata not
matter whatever, as long as you're going to change anything, btrfs will
cause extra space usage.
(Although the final result may not cause extra used disk space as freed
space is as large as newly allocated space, but to maintain CoW, newly
allocated space can't overlap with old data)

Further more, talking about snapshots with space wasted by extent
booking, it's definitely possible user want to break the shared extents:

Subvol 257, inode 257 has the following file extents:
(257 EXTENT_DATA 0)
disk bytenr X len 16M
offset 0 num_bytes 4k  << Only 4k is referred in the whole 16M extent.

Subvol 258, inode 257 has the following file extents:
(257 EXTENT_DATA 0)
disk bytenr X len 16M
offset 0 num_bytes 4K  << Shared with that one in subv 257
(257 EXTENT_DATA 4K)
disk bytenr Y len 16M
offset 0 num_bytes 4K  << Similar case, only 4K of 16M is used.

In that case, user definitely want to defrag file in subvol 258, as if
that extent at bytenr Y can be freed, we can free up 16M, and allocate a
new 8K extent for subvol 258, ino 257.
(And will also want to defrag the extent in subvol 257 ino 257 too)

That's why knowledge in btrfs tech details can make a difference.
Sometimes you may find some ideas are brilliant and why btrfs is not
implementing it, but if you understand btrfs to some extent, you will
know the answer by yourself.


>=20
>>> - I think it would be wrong to use a general deduplication algorithm =
for
>>> this. Instead, the information about the shared extents should be
>>> analyzed given the starting state of the filesystem, and than the
>>> algorithm should produce an optimal solution based on the currently
>>> shared extents.
>>
>> Please be more specific, like giving an example for it.
>=20
> Let's say that there is a file FFF with extents e11, e12, e13, e22, e23=
,
> e33, e34
> - in subvolA the file FFF consists of e11, e12, e13
> - in subvolB the file FFF consists of e11, e22, e23
> - in subvolC the file FFF consists of e11, e22, e33, e34
>=20
> After defrag, where 'selected subvolume' is subvolC, the extents are
> ordered on disk as follows:
>=20
> e11,e22,e33,e34 - e23 - e12,e13

Inode FFF in different subvolumes are different inodes. They have no
knowledge of other inodes in other subvolumes.

If FFF in subvol C is e11, e22, e33, e34, then that's it.
I didn't see the point still.

And what's the on-disk bytenr of all these extents? Which has larger
bytenr and length?

Please provide a better description like xfs_io -c "fiemap -v" output
before and after.

>=20
> In the list above, the comma denotes neighbouring extents, the dash
> indicates that there can be a possible gap.
> As you can see in the list, the file FFF is fully defragmented in
> subvolC, since its extents are occupying neighbouring disk sectors.
>=20
>=20
>>> 3) Downgrade to 'single' or 'DUP' (also, general easy way to switch
>>> between RAID levels)
>>> =C2=A0Currently, as much as I gather, user has to do a "btrfs balance=
 start
>>> -dconvert=3Dsingle -mconvert=3Dsingle
>>> ", than delete a drive, which is a bit ridiculous sequence of
>>> operations.
>=20
>> That's a shortcut for chunk profile change.
>> My first idea of this is, it could cause more problem than benefit.
>> (It only benefits profile downgrade, thus only makes sense for
>> RAID1->SINGLE, DUP->SINGLE, and RAID10->RAID0, nothing else)
>=20
> Those listed cases are exactly the ones I judge to be most important.
> Three important cases.

I'd argue it's downgrade, not that important. As most users want to
replace the missing/bad device and maintain the raid profile.

>=20
>> I still prefer the safer allocate-new-chunk way to convert chunks, eve=
n
>> at a cost of extra IO.
>=20
> I don't mind whether it allocates new chunks or not. It is better, in m=
y
> opinion, if new chunks are not allocated, but both ways are essentially=
 OK.
>=20
> What I am complaining about is that at one point in time, after issuing=

> the command:
> =C2=A0=C2=A0=C2=A0=C2=A0btrfs balance start -dconvert=3Dsingle -mconver=
t=3Dsingle
> and before issuing the 'btrfs delete', the system could be in a too
> fragile state, with extents unnecesarily spread out over two drives,
> which is both a completely unnecessary operation, and it also seems to
> me that it could be dangerous in some situations involving potentially
> malfunctioning drives.

In that case, you just need to replace that malfunctioning device other
than fall back to SINGLE.

Thanks,
Qu

>=20
> Please reconsider.
>=20
>=20


--RpQ72WfRdzyL0VDVxabd6uxvFxqCoCKOk--

--JI3IIm0hXzzIud5IIxiGC00woe0dFs5l7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl12QwIACgkQwj2R86El
/qh+sAgAlJk7MH7MtnmvLpqWlGH3EqVrzu1sOgDZ/tJ5SyQpJSLK+OEdi/WnlQf/
iXkhFmUsrRR5vq57bqh2IBMcrrrR4pxNh0QRBk1Usu34EzzERE9RA2XBFQ9ptrar
4H+MAZwtQX44mEycvt6GM8o46XhrgduU6Nh/8xHkSD75yqVhQ1xIiqK1OnLM/tGU
vpIJc8htr5wKesB/+nbYEVj+ZARTXK5c76oI/4Tm/xtVt3V/yZcr4pdtLzbm8B/u
CYt15TF0gmjASDxwytUqUcLGUNRHP7TGVeYyrV0jw0YtrxsIMiL+54bE8BaP9DXn
BcX39BQ92SijakJdPbGWVzM61nS+LQ==
=1jB7
-----END PGP SIGNATURE-----

--JI3IIm0hXzzIud5IIxiGC00woe0dFs5l7--
