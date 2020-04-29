Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42341BD406
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Apr 2020 07:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgD2FeY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Apr 2020 01:34:24 -0400
Received: from mout.gmx.net ([212.227.17.22]:43011 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgD2FeX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Apr 2020 01:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588138450;
        bh=b9XOyBlM72aaRMVePNY2POju555hYkr/pQCW2vgcME8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=MSHiE85O/niYHuNjeGfkO8xa3SzF4j3abASOe3YT3Amq7JvI/IcpgKIFOPWFDH6Ee
         9vsJr1gGxCtPP3CcHRzYOUhMDq7yqsm0YXHkkNlfHNCLGOwpjdDn/idDdjZdW1ikY9
         1CSB2SxFHGQv88+DFnbQwYMJ5wTd4NClOtpnJblE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJVHU-1jj8sT2g6y-00Juc3; Wed, 29
 Apr 2020 07:34:10 +0200
Subject: Re: Balance loops: what we know so far
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <20200411211414.GP13306@hungrycats.org>
 <b3e80e75-5d27-ec58-19af-11ba5a20e08c@gmx.com>
 <20200428045500.GA10769@hungrycats.org>
 <ea42b9cb-3754-3f47-8d3c-208760e1c2ac@gmx.com>
 <20200428145145.GB10796@hungrycats.org>
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
Message-ID: <b1e24eb6-a8ee-dd87-b8b7-0c0e95b2a060@gmx.com>
Date:   Wed, 29 Apr 2020 13:34:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428145145.GB10796@hungrycats.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="i6qv4U9z0ZkNxO1qEpkfALDwQORARne7X"
X-Provags-ID: V03:K1:Wepj3pI1yW0F0EO6IgQGRy9TeARGgPykNZNshr9TZlnMVnmsOGF
 XukPrMPYKzitbSSDUpXQOM5urjme4ab8SdegUD0f8RebS347ToaN9K2FSX9BQ5j6RVQsZJB
 zBy6/RXTiGNQnX7uOFS6+LoGBg5b70S9KFOwjmZcHd9HaVkst72bEuWevRhPyFjp3k4l6Ez
 dTkeUwFhf6h4nMp5nPPaA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0kwJpDtDFkE=:3fFDu4EIAcBXLYaL38Cf9g
 A6hfYmxWL1BgFnAolpmIKJxypeQ6nJVHXKJA4bQxsIdpDKhSd9LWmAHsZ8Ia8ge5VDgXvIgaG
 TyIBp9mWl0xaKJmTK/O7uNK4BgdvMmLy6cceoF6od9UEMbL/OUS42ZQVxtnSucHauD/XAMfVZ
 Yz6U/4EMMkf58kWfUswtmz31zSXgvzkqk1d21b8AdYGfbyRDbFoa550JKiLBWz04iiLDJzkuX
 o+ZxUxcjXmxzo9aBznwPYOz4KmoUK21M2FCZ6LQA9HM8KNB0Xara+ME2/PEotsGWdz5z4S8DD
 orvbagua0/TYrJgtoteFtUuhLPgvrJROtXLpV+Lj59BRUeeHHgrCAsmDdgf9yPt5OmkdUqtCZ
 ry0PSVeOFEc+H2PI3uJ1WCGt+6xrDS5Tm6Vr8LPY5Lb/WrZbInbfdqkATXd2TqBgO1//qxfRF
 aSrvy2wYASp0r/lqpMKVAlWpETQ5s9AZrZjQLvfNkeuKat0aFjVtCy71iIDwQtYj0HunisGhh
 DVBL6YbqCgQiX95R9pUCazXJ8VH8jSjUgKmWigVKHcKcIYE/+6auSn4U54sOCMI8DkUYU95rE
 xDntCv80jIE7L10J7ymrbEgmPjSA3sp8BFRegqhtdMViWcEX86eU1YNiX8FrXgE8rhruUB952
 1zf4GJwSTfX4V1Iix5IelkxLlyvpqGbeVQNIqTj+qM5NhF7uvK4cqMPwbNjPyHP8CBkOrKXMF
 3siJrex2gXFsUYLhCu+MjptoPeW4F4iaAm12u93+OZ9gaP83QrvbAu7qV0LK+xlQ43g6QGvUr
 9xadzZgFFBjpaZlAJ452CgUrQrd72pDzCfogfi3l2TKVbv+IVlbOi6GBVlSRgqAdIC04Lf+zI
 wrK1DOLdvGA96iI+hdBbCeXyWD2byQcK28AkG2LDy9pq10laMhNPH1s5KOIgBaDos5FNCAqPl
 aID1NQODRYb2pVDvz3tcyu1S4j90bfaV713ZaLzCMoX/ZtPixjAiUGXAR+rmzW6A92/2KvuBi
 gOWBYEL6etfmOyPLlQQYlmGRBJ2U0iIYZxNkW7HQhxkZ6WAvRxAdd310qrRc5UpwleTCsksW1
 wWy4WP1+AbZrCowx/4Y6f/Zx0bvJT+fJ6qQ3ips0aKWzKPvMxHpEnfjjIJI8vDqgddFx5xuTw
 lodx0jZRPrg511QqcJLWQIIAqb49vKstKLF1uC7aLSpvJ/sRhkLqTOmvyqikyIP/T/ZBsqnLR
 synMrv9/2v+L2DI3y
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i6qv4U9z0ZkNxO1qEpkfALDwQORARne7X
Content-Type: multipart/mixed; boundary="DMSswYPZajD2fCjIX8FTBHqV1yjzCkWN2"

--DMSswYPZajD2fCjIX8FTBHqV1yjzCkWN2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/4/28 =E4=B8=8B=E5=8D=8810:51, Zygo Blaxell wrote:
> On Tue, Apr 28, 2020 at 05:54:21PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2020/4/28 =E4=B8=8B=E5=8D=8812:55, Zygo Blaxell wrote:
>>> On Mon, Apr 27, 2020 at 03:07:29PM +0800, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2020/4/12 =E4=B8=8A=E5=8D=885:14, Zygo Blaxell wrote:
>>>>> Since 5.1, btrfs has been prone to getting stuck in semi-infinite l=
oops
>>>>> in balance and device shrink/remove:
>>>>>
>>>>> 	[Sat Apr 11 16:59:32 2020] BTRFS info (device dm-0): found 29 exte=
nts, stage: update data pointers
>>>>> 	[Sat Apr 11 16:59:33 2020] BTRFS info (device dm-0): found 29 exte=
nts, stage: update data pointers
>>>>> 	[Sat Apr 11 16:59:34 2020] BTRFS info (device dm-0): found 29 exte=
nts, stage: update data pointers
>>>>> 	[Sat Apr 11 16:59:34 2020] BTRFS info (device dm-0): found 29 exte=
nts, stage: update data pointers
>>>>> 	[Sat Apr 11 16:59:35 2020] BTRFS info (device dm-0): found 29 exte=
nts, stage: update data pointers
>>>>>
>>>>> This is a block group while it's looping, as seen by python-btrfs:
>>>>>
>>>>> 	# share/python-btrfs/examples/show_block_group_contents.py 1934913=
175552 /media/testfs/
>>>>> 	block group vaddr 1934913175552 length 1073741824 flags DATA used =
939167744 used_pct 87
>> [...]
>>>>>
>>>>> All of the extent data backrefs are removed by the balance, but the=

>>>>> loop keeps trying to get rid of the shared data backrefs.  It has
>>>>> no effect on them, but keeps trying anyway.
>>>>
>>>> I guess this shows a pretty good clue.
>>>>
>>>> I was always thinking about the reloc tree, but in your case, it's d=
ata
>>>> reloc tree owning them.
>>>
>>> In that case, yes.  Metadata balances loop too, in the "move data ext=
ents"
>>> stage while data balances loop in the "update data pointers" stage.
>>
>> Would you please take an image dump of the fs when runaway balance hap=
pened?
>>
>> Both metadata and data block group loop would greatly help.
>=20
> There's two problems with this:
>=20
> 	1) my smallest test filesystems have 29GB of metadata,
>=20
> 	2) the problem is not reproducible with an image.

OK, then when such loop happened, what we need is:
- Which block group is looping
  Obviously

- The extent tree dump of that block group
  You have done a pretty good job on that.

- Follow the backref to reach the root
  In balance case, the offending backref should always using parent
  bytenr, so you need to step by step to reach the root, which should
  have backref points back to itself.

- Root tree dump of the looping fs.
  To find out which reloc tree it belongs to.
  And show the ref number of that reloc tree.

>=20
> I've tried using VM snapshots to put a filesystem into a reproducible
> looping state.  A block group that loops on one boot doesn't repeatably=

> loop on another boot from the same initial state; however, once a
> booted system starts looping, it continues to loop even if the balance
> is cancelled, and I restart balance on the same block group or other
> random block groups.
>=20
> I have production filesystems with tens of thousands of block groups
> and almost all of them loop (as I said before, I cannot complete any
> RAID reshapes with 5.1+ kernels).  They can't _all_ be bad.
>=20
> Cancelling a balance (usually) doesn't recover.  Rebooting does.
> The change that triggered this changes the order of operations in
> the kernel.  That smells like a runtime thing to me.
>=20
>>>> In that case, data reloc tree is only cleaned up at the end of
>>>> btrfs_relocate_block_group().
>>>>
>>>> Thus it is never cleaned up until we exit the balance loop.
>>>>
>>>> I'm not sure why this is happening only after I extended the lifespa=
n of
>>>> reloc tree (not data reloc tree).
>>>
>>> I have been poking around with printk to trace what it's doing in the=

>>> looping and non-looping cases.  It seems to be very similar up to
>>> calling merge_reloc_root, merge_reloc_roots, unset_reloc_control,
>>> btrfs_block_rsv_release, btrfs_commit_transaction, clean_dirty_subvol=
s,
>>> btrfs_free_block_rsv.  In the looping cases, everything up to those
>>> functions seems the same on every loop except the first one.
>>>
>>> In the non-looping cases, those functions do something different than=

>>> the looping cases:  the extents disappear in the next loop, and the
>>> balance finishes.
>>>
>>> I haven't figured out _what_ is different yet.  I need more cycles to=

>>> look at it.
>>>
>>> Your extend-the-lifespan-of-reloc-tree patch moves one of the
>>> functions--clean_dirty_subvols (or btrfs_drop_snapshot)--to a differe=
nt
>>> place in the call sequence.  It was in merge_reloc_roots before the
>>> transaction commit, now it's in relocate_block_group after transactio=
n
>>> commit.  My guess is that the problem lies somewhere in how the behav=
ior
>>> of these functions has been changed by calling them in a different
>>> sequence.
>>>
>>>> But anyway, would you like to give a try of the following patch?
>>>> https://patchwork.kernel.org/patch/11511241/
>>>
>>> I'm not sure how this patch could work.  We are hitting the found_ext=
ents
>>> counter every time through the loop.  It's returning thousands of ext=
ents
>>> each time.
>>>
>>>> It should make us exit the the balance so long as we have no extra
>>>> extent to relocate.
>>>
>>> The problem is not that we have no extents to relocate.  The problem =
is
>>> that we don't successfully get rid of the extents we do find, so we k=
eep
>>> finding them over and over again.
>>
>> That's very strange.
>>
>> As you can see, for relocate_block_group(), it will cleanup reloc tree=
s.
>>
>> This means either we have reloc trees in use and not cleaned up, or so=
me
>> tracing mechanism is not work properly.
>=20
> Can you point out where in the kernel that happens?  If we throw some
> printks at it we might see something.

The merge happens at merge_reloc_roots().
The cleanup happens at clean_dirty_subvols().

In theory, all reloc trees will either marked as orphan (due to new
changes in original subvolume) or merged in merge_reloc_roots(), and
queued for cleanup.
Then in clean_dirty_subvolumes() reloc trees all get cleaned up.

If there are any reloc tree remaining after clean_dirty_subvolumes()
then it could be the cause of such loop.

Thanks,
Qu
>=20
>> Anyway, if image dump with the dead looping block group specified, it
>> would provide good hint to this long problem.
>>
>> Thanks,
>> Qu
>>
>>>
>>> In testing, the patch has no effect:
>>>
>>> 	[Mon Apr 27 23:36:15 2020] BTRFS info (device dm-0): found 4800 exte=
nts, stage: update data pointers
>>> 	[Mon Apr 27 23:36:21 2020] BTRFS info (device dm-0): found 4800 exte=
nts, stage: update data pointers
>>> 	[Mon Apr 27 23:36:27 2020] BTRFS info (device dm-0): found 4800 exte=
nts, stage: update data pointers
>>> 	[Mon Apr 27 23:36:32 2020] BTRFS info (device dm-0): found 4800 exte=
nts, stage: update data pointers
>>> 	[Mon Apr 27 23:36:38 2020] BTRFS info (device dm-0): found 4800 exte=
nts, stage: update data pointers
>>> 	[Mon Apr 27 23:36:44 2020] BTRFS info (device dm-0): found 4800 exte=
nts, stage: update data pointers
>>> 	[Mon Apr 27 23:36:50 2020] BTRFS info (device dm-0): found 4800 exte=
nts, stage: update data pointers
>>> 	[Mon Apr 27 23:36:56 2020] BTRFS info (device dm-0): found 4800 exte=
nts, stage: update data pointers
>>> 	[Mon Apr 27 23:37:01 2020] BTRFS info (device dm-0): found 4800 exte=
nts, stage: update data pointers
>>> 	[Mon Apr 27 23:37:07 2020] BTRFS info (device dm-0): found 4800 exte=
nts, stage: update data pointers
>>> 	[Mon Apr 27 23:37:13 2020] BTRFS info (device dm-0): found 4800 exte=
nts, stage: update data pointers
>>> 	[Mon Apr 27 23:37:19 2020] BTRFS info (device dm-0): found 4800 exte=
nts, stage: update data pointers
>>> 	[Mon Apr 27 23:37:24 2020] BTRFS info (device dm-0): found 4800 exte=
nts, stage: update data pointers
>>> 	[Mon Apr 27 23:37:30 2020] BTRFS info (device dm-0): found 4800 exte=
nts, stage: update data pointers
>>>
>>> The above is the tail end of 3320 loops on a single block group.
>>>
>>> I switched to a metadata block group and it's on the 9th loop:
>>>
>>> 	# btrfs balance start -mconvert=3Draid1 /media/testfs/
>>> 	[Tue Apr 28 00:09:47 2020] BTRFS info (device dm-0): found 34977 ext=
ents, stage: move data extents
>>> 	[Tue Apr 28 00:12:24 2020] BTRFS info (device dm-0): found 26475 ext=
ents, stage: move data extents
>>> 	[Tue Apr 28 00:18:46 2020] BTRFS info (device dm-0): found 26475 ext=
ents, stage: move data extents
>>> 	[Tue Apr 28 00:23:24 2020] BTRFS info (device dm-0): found 26475 ext=
ents, stage: move data extents
>>> 	[Tue Apr 28 00:25:54 2020] BTRFS info (device dm-0): found 26475 ext=
ents, stage: move data extents
>>> 	[Tue Apr 28 00:28:17 2020] BTRFS info (device dm-0): found 26475 ext=
ents, stage: move data extents
>>> 	[Tue Apr 28 00:30:35 2020] BTRFS info (device dm-0): found 26475 ext=
ents, stage: move data extents
>>> 	[Tue Apr 28 00:32:45 2020] BTRFS info (device dm-0): found 26475 ext=
ents, stage: move data extents
>>> 	[Tue Apr 28 00:37:01 2020] BTRFS info (device dm-0): found 26475 ext=
ents, stage: move data extents
>>>
>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> This is "semi-infinite" because it is possible for the balance to
>>>>> terminate if something removes those 29 extents (e.g. by looking up=
 the
>>>>> extent vaddrs with 'btrfs ins log' then feeding the references to '=
btrfs
>>>>> fi defrag' will reduce the number of inline shared data backref obj=
ects.
>>>>> When it's reduced all the way to zero, balance starts up again, usu=
ally
>>>>> promptly getting stuck on the very next block group.  If the _only_=

>>>>> thing running on the filesystem is balance, it will not stop loopin=
g.
>>>>>
>>>>> Bisection points to commit d2311e698578 "btrfs: relocation: Delay r=
eloc
>>>>> tree deletion after merge_reloc_roots" as the first commit where th=
e
>>>>> balance loops can be reproduced.
>>>>>
>>>>> I tested with commit 59b2c371052c "btrfs: check commit root generat=
ion
>>>>> in should_ignore_root" as well as the rest of misc-next, but the ba=
lance
>>>>> loops are still easier to reproduce than to avoid.
>>>>>
>>>>> Once it starts happening on a filesystem, it seems to happen very
>>>>> frequently.  It is not possible to reshape a RAID array of more tha=
n a
>>>>> few hundred GB on kernels after 5.0.  I can get maybe 50-100 block =
groups
>>>>> completed in a resize or balance after a fresh boot, then balance g=
ets
>>>>> stuck in loops after that.  With the fast balance cancel patches it=
's
>>>>> possibly to recover from the loop, but futile, since the next balan=
ce
>>>>> will almost always also loop, even if it is passed a different bloc=
k
>>>>> group.  I've had to downgrade to 5.0 or 4.19 to complete any RAID
>>>>> reshaping work.
>>>>>
>>>>
>>>
>>>
>>>
>>
>=20
>=20
>=20


--DMSswYPZajD2fCjIX8FTBHqV1yjzCkWN2--

--i6qv4U9z0ZkNxO1qEpkfALDwQORARne7X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6pEc4ACgkQwj2R86El
/qjpXwf/RRrXH1IOfwvOgLXqd8v2H1UejraToxFfpEqtNiUdVjwzASG/QCA7iSqP
WXe36n+RFrJ3nlmOvyM/Z58FirksOWs/ZeO+i++QXuky8hK+HmAus1sHo6A0MHnq
Y1d0qn8DFFHpJvOeqQppTpZJCpzwpLAgR12FPkTAm+vVtLmBaiR7MqOuqHdIIfpM
QvfJxuwmsEkY308h0Pytot4cvYc+pmU0QW4a6W2+XO+SKSw52CO1xqef03BWQFPp
KI3YDGsr0hFdOG/uzaU+OmUh99jbcOP6yuNTzF0WycAMuzPKhg2BVLVPHe9NrH62
0yig59hfMHIykOXEvA1mFfaD9wEqZw==
=Uxoo
-----END PGP SIGNATURE-----

--i6qv4U9z0ZkNxO1qEpkfALDwQORARne7X--
