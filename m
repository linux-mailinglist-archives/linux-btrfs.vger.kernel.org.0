Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA33AD907
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Sep 2019 14:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfIIM3v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Sep 2019 08:29:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:45385 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfIIM3v (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Sep 2019 08:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568032145;
        bh=lQx4ZhTrdp97aGauIf3C3IgX0szprpHiDY0pUDAgq0w=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=L6859bFnTMLv//+myw5XYwKbiEmeQe8wxZCe5AIkO8iw/K+j2IuwJCHKekchphTxp
         vLt4IfA3OuUqEpRTYGtviY4lBC0qOUAJCgnZic5oG/O9ECj8Q83EzTHJZAh8ImHVvs
         dznZGIHCXq0XXF3wKL5LdYAe1EvBnSSob+q9IJbE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N7i8O-1iBH3S14Wg-014guA; Mon, 09
 Sep 2019 14:29:05 +0200
Subject: Re: Feature requests: online backup - defrag - change RAID level
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     zedlryqc@server53.web-hosting.com, linux-btrfs@vger.kernel.org
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
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
Message-ID: <083a7b76-3c30-f311-1e23-606050cfc412@gmx.com>
Date:   Mon, 9 Sep 2019 20:28:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1GAplw03O5xsIACx3WRo5pCuRZhPU48IM"
X-Provags-ID: V03:K1:mCY1sC676ADfHFEY+NQuvjuXKI+pa8SV3EyBOTSY8qh8cukoDAj
 TlsrM1wa2e5duL6Wwh4Z/B80vRUeOzcbbYU5vyyJ6i9c5k6CHGSYYT9styiAMZmpmj7eYE9
 RLd1PLVE5/LFCF2iolMOj3mxnFXhZFlTNgBmyBugQGcuBt+S4Qgio61dnzG3+dpLqUb6wp7
 acH4WiXQkglS6+jinu2ZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hf9+inoX0Nk=:GGSQmsqmzA8IjEBXFSvKIL
 lXnJ1Mx4G2O/MQoF9rLhZRsZ9zPpgz9f+KjsPf6DAVd1RlpjG6mefzf5ZmhRnHsLbO8SLhARb
 cUxLB27T3TloQ9+cfBRbC1wbwcbkehVMHgtViqydy8j8DjF3neD2Dv3CkYB9jdmZ3ZLuNj49W
 pGn8y/p5LVTik714kvKJEA5IOJKvYoYmgqpCF+C83Q5cikYXPoGqSkPv2L7G9HFIlUD7jL6Yf
 cOMCD2AYWF9koWFxz0fekx2n4rX1UfH5WTXJnzGullApz0FCfqnrhVYVaHnGinWPIuOnZd7lM
 Qhl9Nr1+hhv2jTVUuRZ2+iSL6oPd6pm/H7WZ8bBE6ZDya30qJJH9vdGuhPmwEEwWpVkQsIG8h
 KhkMzf5umizqVJ3fu0L4YabhJAxK93ydYLVX7HnWHL9si1HGOC6YSOsYyUU317O3M0rAnDXOj
 coHdn3dea61ilsWHmTcrr7I6MCJwc7aFaCR3KbOTJFktKIm8/sr6hFSaQ8jowIFcKvuz6o8N8
 DhC9190WB6SU3rV5VVBLTZMWUI4YFcAeEQj9PRBFWFvNhH2uEMZ4dZEaD2f0cZbuChZ9dvnFE
 H14YRxsA/jrLYiSQsxB+OpymoKyBNcRSuEsIq2KuQCPFrvmvpNTD4koMmMOY7dLc3OY7Czp2I
 iumBUBmdYH3zCcvl/Ub5ZcBo12yWvmLerKjKCegpatU8wLm7xAnJse/XAX442liNXAD1+LYIP
 G4S99pdJI3nvacD2YUibGeacaTWyCR2E3haA/vKRX9DHxcd1Rf7nFj/XSMmtKDNs63mvPrDeV
 zr9z04zQ/J3HxznefFVo/UUrT03xIqTOuhTIieK9jcdxhj+JaE19ZHUau/ZsRqS9mSf2nEyfa
 6VhDMoOn4mVW6XQTmEAFbbWlAEeiJLvI8iUMygdksZkUP4HlnlA44NMUeeZ1jDfPD5ZmK6QYU
 ZJNky1HliJ1whkitaMEJBbpyqIIgTn0WhtrhYtOpCLEsFyBI562jNB/e+7KL2DJuniXh4wMnu
 oFhz0dkICSKEvnXG1UweC+4i+VnmpUGiYX+DylDuTehngfcuqpu7zfwOYZRHoZTJ2baP6USgV
 18ppnmODsKXN0JPTDAfhuxYg/GO5LjbNuHFQxKsyGn404v19+MUXDD9ryHu1GUzlQxq7Kq6f1
 KwLzWc22dtXflR8JTeLZlAcrsnoqA+bw3tWtYuWQFkXXXQGhxR2VSrnj4oLlJamBh5qaoLBTv
 ikUSfJ8GffaM4pmY/
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1GAplw03O5xsIACx3WRo5pCuRZhPU48IM
Content-Type: multipart/mixed; boundary="gR5zvtLDb7KMey3wGwLHjK1TXrJK2JcB4"

--gR5zvtLDb7KMey3wGwLHjK1TXrJK2JcB4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/9 =E4=B8=8B=E5=8D=888:18, Qu Wenruo wrote:
>=20
>=20
> On 2019/9/9 =E4=B8=8B=E5=8D=887:25, zedlryqc@server53.web-hosting.com w=
rote:
>>
>> Quoting Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>>> 1) Full online backup (or copy, whatever you want to call it)
>>>> btrfs backup <filesystem name> <partition name> [-f]
>>>> - backups a btrfs filesystem given by <filesystem name> to a partiti=
on
>>>> <partition name> (with all subvolumes).
>>>
>>> Why not just btrfs send?
>>>
>>> Or you want to keep the whole subvolume structures/layout?
>>
>> Yes, I want to keep the whole subvolume structures/layout. I want to
>> keep everything. Usually, when I want to backup a partition, I want to=

>> keep everything, and I suppose most other people have a similar idea.
>>
>>> I'd say current send/receive is more flex.
>>
>> Um, 'flexibility' has nothing to do with it. Send/receive is a
>> completely different use case.
>> So, each one has some benefits and some drawbacks, but 'send/receive'
>> cannot replace 'full online backup'
>>
>> Here is where send/receive is lacking:
>> =C2=A0=C2=A0=C2=A0=C2=A0- too complicated to do if many subvolumes are=
 involved
>> =C2=A0=C2=A0=C2=A0=C2=A0- may require recursive subvolume enumeration =
in order to emulate
>> 'full online backup'
>> =C2=A0=C2=A0=C2=A0=C2=A0- may require extra storage space
>> =C2=A0=C2=A0=C2=A0=C2=A0- is not mountable, not easy to browse the bac=
kup contents
>> =C2=A0=C2=A0=C2=A0=C2=A0- not easy to recover just a few selected file=
s from backup
>> There's probably more things where send/receive is lacking, but I thin=
k
>> I have given sufficient number of important differences which show tha=
t
>> send/receive cannot successfully replace the functionality of 'full
>> online backup'.

Forgot to mention this part.

If your primary objective is to migrate your data to another device
online (mounted, without unmount any of the fs).

Then I could say, you can still add a new device, then remove the old
device to do that.

That would be even more efficient than LVM (not thin provisioned one),
as we only move used space.

If your objective is to create a full copy as backup, then I'd say my
new patchset of btrfs-image data dump may be your best choice.

The only down side is, you need to at least mount the source fs to RO mod=
e.

The true on-line backup is not that easy, especially any write can screw
up your backup process, so it must be done unmounted.

Even btrfs send handles this by forcing the source subvolume to be RO,
so I can't find an easy solution to address that.

Thanks,
Qu

>>
>>> And you also needs to understand btrfs also integrates volume
>>> management, thus it's not just <partition name>, you also needs RAID
>>> level and things like that.
>>
>> This is a minor point. So, please, let's not get into too many
>> irrelevant details here.
>>
>> There can be a sensible default to 'single data, DUP metadata', and a
>> way for a user to override this default, but that feature is
>> not-so-important. If the user wants to change the RAID level, he can
>> easily do it later by mounting the backup.
>>
>>>
>>> All can be done already by send/receive, although at subvolume level.=

>>
>> Yeah, maybe I should manually type it all for all subvolumes, one by
>> one. Also must be carefull to do it in the correct order if I want it
>> not to consume extra space.
>> And the backup is not mountable.
>>
>> This proposal (workaround) of yours appears to me as too complicated,
>> too error prone,
>> missing important features.
>>
>> But, I just thought, you can actually emulate 'full online backup' wit=
h
>> this send/receive. Here is how.
>> You do a script which does the following:
>> =C2=A0=C2=A0=C2=A0=C2=A0- makes a temporary snapshot of every subvolum=
e
>> =C2=A0=C2=A0=C2=A0=C2=A0- use 'btrfs send' to send all the temporary s=
napshots, on-the-fly
>> (maybe via pipe), in the correct order, to a proces running a 'brtfs
>> receive', which should then immediately write it all to the destinatio=
n
>> partition. All the buffers can stay in-memory.
>> =C2=A0=C2=A0=C2=A0=C2=A0- when all the snapshots are received and writ=
ten to destination,
>> fix subvol IDs
>> =C2=A0=C2=A0=C2=A0=C2=A0- delete temporary snapshots from source
>> Of course, this script should then be a part of standard btrfs tools.
>>
>>> Please check if send/receive is suitable for your use case.
>>
>> No. Absolutely not.
>>
>>
>>>> 2) Sensible defrag
>>>> The defrag is currently a joke.
>>
>>>> How to do it:
>>>> - The extents must not be unshared, but just shuffled a bit. Unshari=
ng
>>>> the extents is, in most situations, not tolerable.
>>
>>> I definitely see cases unsharing extents makes sense, so at least we
>>> should let user to determine what they want.
>>
>> Maybe there are such cases, but I would say that a vast majority of
>> users (99,99%) in a vast majority of cases (99,99%) don't want the
>> defrag operation to reduce free disk space.
>>
>>> What's wrong with current file based defrag?
>>> If you want to defrag a subvolume, just iterate through all files.
>>
>> I repeat: The defrag should not decrease free space. That's the 'norma=
l'
>> expectation.
>=20
> Since you're talking about btrfs, it's going to do CoW for metadata not=

> matter whatever, as long as you're going to change anything, btrfs will=

> cause extra space usage.
> (Although the final result may not cause extra used disk space as freed=

> space is as large as newly allocated space, but to maintain CoW, newly
> allocated space can't overlap with old data)
>=20
> Further more, talking about snapshots with space wasted by extent
> booking, it's definitely possible user want to break the shared extents=
:
>=20
> Subvol 257, inode 257 has the following file extents:
> (257 EXTENT_DATA 0)
> disk bytenr X len 16M
> offset 0 num_bytes 4k  << Only 4k is referred in the whole 16M extent.
>=20
> Subvol 258, inode 257 has the following file extents:
> (257 EXTENT_DATA 0)
> disk bytenr X len 16M
> offset 0 num_bytes 4K  << Shared with that one in subv 257
> (257 EXTENT_DATA 4K)
> disk bytenr Y len 16M
> offset 0 num_bytes 4K  << Similar case, only 4K of 16M is used.
>=20
> In that case, user definitely want to defrag file in subvol 258, as if
> that extent at bytenr Y can be freed, we can free up 16M, and allocate =
a
> new 8K extent for subvol 258, ino 257.
> (And will also want to defrag the extent in subvol 257 ino 257 too)
>=20
> That's why knowledge in btrfs tech details can make a difference.
> Sometimes you may find some ideas are brilliant and why btrfs is not
> implementing it, but if you understand btrfs to some extent, you will
> know the answer by yourself.
>=20
>=20
>>
>>>> - I think it would be wrong to use a general deduplication algorithm=
 for
>>>> this. Instead, the information about the shared extents should be
>>>> analyzed given the starting state of the filesystem, and than the
>>>> algorithm should produce an optimal solution based on the currently
>>>> shared extents.
>>>
>>> Please be more specific, like giving an example for it.
>>
>> Let's say that there is a file FFF with extents e11, e12, e13, e22, e2=
3,
>> e33, e34
>> - in subvolA the file FFF consists of e11, e12, e13
>> - in subvolB the file FFF consists of e11, e22, e23
>> - in subvolC the file FFF consists of e11, e22, e33, e34
>>
>> After defrag, where 'selected subvolume' is subvolC, the extents are
>> ordered on disk as follows:
>>
>> e11,e22,e33,e34 - e23 - e12,e13
>=20
> Inode FFF in different subvolumes are different inodes. They have no
> knowledge of other inodes in other subvolumes.
>=20
> If FFF in subvol C is e11, e22, e33, e34, then that's it.
> I didn't see the point still.
>=20
> And what's the on-disk bytenr of all these extents? Which has larger
> bytenr and length?
>=20
> Please provide a better description like xfs_io -c "fiemap -v" output
> before and after.
>=20
>>
>> In the list above, the comma denotes neighbouring extents, the dash
>> indicates that there can be a possible gap.
>> As you can see in the list, the file FFF is fully defragmented in
>> subvolC, since its extents are occupying neighbouring disk sectors.
>>
>>
>>>> 3) Downgrade to 'single' or 'DUP' (also, general easy way to switch
>>>> between RAID levels)
>>>> =C2=A0Currently, as much as I gather, user has to do a "btrfs balanc=
e start
>>>> -dconvert=3Dsingle -mconvert=3Dsingle
>>>> ", than delete a drive, which is a bit ridiculous sequence of
>>>> operations.
>>
>>> That's a shortcut for chunk profile change.
>>> My first idea of this is, it could cause more problem than benefit.
>>> (It only benefits profile downgrade, thus only makes sense for
>>> RAID1->SINGLE, DUP->SINGLE, and RAID10->RAID0, nothing else)
>>
>> Those listed cases are exactly the ones I judge to be most important.
>> Three important cases.
>=20
> I'd argue it's downgrade, not that important. As most users want to
> replace the missing/bad device and maintain the raid profile.
>=20
>>
>>> I still prefer the safer allocate-new-chunk way to convert chunks, ev=
en
>>> at a cost of extra IO.
>>
>> I don't mind whether it allocates new chunks or not. It is better, in =
my
>> opinion, if new chunks are not allocated, but both ways are essentiall=
y OK.
>>
>> What I am complaining about is that at one point in time, after issuin=
g
>> the command:
>> =C2=A0=C2=A0=C2=A0=C2=A0btrfs balance start -dconvert=3Dsingle -mconve=
rt=3Dsingle
>> and before issuing the 'btrfs delete', the system could be in a too
>> fragile state, with extents unnecesarily spread out over two drives,
>> which is both a completely unnecessary operation, and it also seems to=

>> me that it could be dangerous in some situations involving potentially=

>> malfunctioning drives.
>=20
> In that case, you just need to replace that malfunctioning device other=

> than fall back to SINGLE.
>=20
> Thanks,
> Qu
>=20
>>
>> Please reconsider.
>>
>>
>=20


--gR5zvtLDb7KMey3wGwLHjK1TXrJK2JcB4--

--1GAplw03O5xsIACx3WRo5pCuRZhPU48IM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl12RYsACgkQwj2R86El
/qjyUAf+KZ7hkMz0stfdh20QqLR61sUn0t9Dw0DFWcyVabU0JjARKcAzAPzVaYg/
P2FZvMGVTzUqQ+QyBpwfpsAiTTcmNr6alnftBBSyVaUVV3UVjfyzSKh9C0Dn7wsb
oA9KLzkXIguR4ilmHyQz20cTmKfZBLD/TTULBGhy9ALO0Wn3GY/LZFWBvE1a0nOD
woIz3yZ3dpyDeo6vHfRGMHX+cmg5kNRJ2uqzQT4+V1+7ElatO3tiLxb5kvz4mM8L
4VTan1VjcZZufznYNUFyFfefSRqdiKhuiOFZ74WnOCCODNcesCgzYO5ncpO5AvXX
EE6tuN0z7e/UFpbzvbdbmYu6fwp48g==
=bKsh
-----END PGP SIGNATURE-----

--1GAplw03O5xsIACx3WRo5pCuRZhPU48IM--
