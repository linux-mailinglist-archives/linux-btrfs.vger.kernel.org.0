Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0DF8049B
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Aug 2019 08:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfHCGRP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Aug 2019 02:17:15 -0400
Received: from mout.gmx.net ([212.227.17.22]:42855 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbfHCGRP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 3 Aug 2019 02:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564813032;
        bh=GA+kHxSGnibhSJqtU5ASiedHpMUQhKUtaH42l5wAf+o=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=a7KwRaimsyWhjm0HAf4nv0Us00OWJYEZVKWbuICCNcKvCeWBGr5VQti+w1ev2DuZX
         c1YLDiAb9kw9XINMnH7ns6EqMLYze1BHVngBc4j9v0OTFEjDiSKacEgRNh60PYC+8e
         cspwF0qM3X827dAGr91mClAJ6Ed/f7DQfiz6EDMI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1Ygt-1hwHG83GvL-0035RV; Sat, 03
 Aug 2019 08:17:12 +0200
Subject: Re: Non-existent qgroup in parent-child relation prevents makes
 qgroup commands fail
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <665ad51a-def8-b60a-8ea2-b76e46f306d2@gmail.com>
 <5dcb6a1b-42db-cc84-a403-288b30c2842b@gmx.com>
 <96f2509f-fd4b-ed5c-7e48-730d3a9875f5@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
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
Message-ID: <677ae3d7-10d8-9073-e5d3-e38de65da9ee@gmx.com>
Date:   Sat, 3 Aug 2019 14:17:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <96f2509f-fd4b-ed5c-7e48-730d3a9875f5@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9jpMnrYARjEOVgmPUARPMghwRbh3vdbR5"
X-Provags-ID: V03:K1:VMubs9ZCbvq37/rzIDrF4VxYTghbz4rplHhm2UK2wl4xoT2z4aw
 rdiCbS7hHzbzNny0dw/Yiz2GK+k63o1/8Rgd/S6j0Bco28dUL/dF8RjJivS7nTpsviNPiOQ
 LBFkSQTG0eBR6Knxg/0sDJ3q+gtadbYQeVdj/Xbj9wn5JfgrC/xEgZvxUoTebJqRlARWdKN
 FaMVxZgxiMp7/jRgOzZyw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:okOZZ/ywhlA=:02rxKxCmuEaMj22WdzCGwF
 0TzyeppEuzSFiTIuWFkOOpIYC5EMqVUzCHnIO5oSXCDzliJtx2hQIyTURlzALevYnzRSzxuD5
 BxPgrGuBujcKZ4fdseugvc0XkleMSvAYhtl4kH3bSa3nAT24uK6hNhKWGMU0cjNfH2nIyU66K
 4m18RhtSfuEC/NViCJFN/LrDm8OEGDD/IC0aakypNZhi6a1fb44vMx62T3rdEG0kNyWjmWytg
 1Qc7s6X05q2zUm1Gph2SU/mZQRJwUC8XplrAoQQInaqaArTsC5b+NG86Tgn3QU34U5dDPR9/d
 RU94TSprAsEHqwaWNPFXn55frViT2+YYvlWoVLUlOZWmZIhCTIrxpHWXZE0GhOtYN9nuyP1t2
 lgIR+FhhsAGFS/TfNZvTaVqkc8XBJIVa8z2rSJn2eb8pr2+ISzKZ662Ea5OJgzR/qR1jAz4NG
 II66hNilDZyLr6kKoV4c/oNXGuR+eJDISFRmQ0S0KOc+wzPYgIKgsUIah5FJAdpM7BFG0Bsx/
 uQEHaGu8Arvd9QLXQ3XPu4zg9wUU83hPlpxDEu02DL8u8/Io3eUeCMGUMFBTIAZeHzy2bk9fT
 spY+VuJG18lNLDETx4geikGtOmgu8hg9l+jjURPMLGw9v4vPMxHWnhd7FfzW3A0AqZfGDxy1M
 OB7fqfMrYsOysuuYh8NDpWNX869hgEuiexpVvKloVuioIaFC6qUUU+5UvnyVaGRpY4yXpq5cZ
 UFfGMPQ32fMcvQbrMIjnVrxv7qalYj7Kvr+SgWbzpXSZhswm+yXvgnMiG7gKUqJVku6rYIKDo
 SnoJaErrpCgCrzr75xp9Vxag8DSzln4iUMXJ0wZt9envK1/uGf4ZZ70UTbQmDnVBJTRyWdbgY
 kBtqfqCcStmSPAyXfWDTW4fEl3OSv14fOd1FRlpdv5DyhFgUtiJl4tsCy9jj/Q8MbXJxBCVBH
 DxfQZxx45zbemKGVj3xt4UzdwKXFs49HfzKlUg6dudbzPH5ZW37qeiSAnSd/NPW9Nlv1rSZWX
 gPHxmW/qeO+G+9rcQq5KCl+Tbn70R4TSUezkd7+XLqu1R0EuI26ww3L6ED4dK5mp4qfX5Q8ex
 aHcEDZO2ebR5ni1f1WHcQlhFJdlmcsJvs4DM7pmMNNbDGmG+PBqoDO1Lg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9jpMnrYARjEOVgmPUARPMghwRbh3vdbR5
Content-Type: multipart/mixed; boundary="9xHEdPkuCvuImMh69iWDrhlzFMD97G2mu";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Andrei Borzenkov <arvidjaar@gmail.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <677ae3d7-10d8-9073-e5d3-e38de65da9ee@gmx.com>
Subject: Re: Non-existent qgroup in parent-child relation prevents makes
 qgroup commands fail
References: <665ad51a-def8-b60a-8ea2-b76e46f306d2@gmail.com>
 <5dcb6a1b-42db-cc84-a403-288b30c2842b@gmx.com>
 <96f2509f-fd4b-ed5c-7e48-730d3a9875f5@gmail.com>
In-Reply-To: <96f2509f-fd4b-ed5c-7e48-730d3a9875f5@gmail.com>

--9xHEdPkuCvuImMh69iWDrhlzFMD97G2mu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/3 =E4=B8=8B=E5=8D=881:31, Andrei Borzenkov wrote:
> 03.08.2019 2:09, Qu Wenruo =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>>
>> On 2019/8/3 =E4=B8=8A=E5=8D=882:08, Andrei Borzenkov wrote:
>>> bor@tw:~> sudo btrfs qgroup show .
>>> ERROR: cannot find the qgroup 0/789
>>> bor@tw:~>
>>>
>>> Fine. This openSUSE with snapper which creates and automatically
>>> destroys snapshots and apparently either kernel or snapper now also
>>> remove corresponding qgroup. I played with snapshots and created seve=
ral
>>> top level qgroups that included snapshot qgroups existing at this tim=
e.
>>> Now these snapshots are gone, their qgroups are gone ...
>>
>> Kernel version please.
>>
>> IIRC latest upstream kernel doesn't remove the level 0 qgroup.
>=20
> Yes?
>=20
>> It may be the userspace doing it improperly.
>>
>=20
> Not sure what "improperly" means here. snapper removes qgroup after
> deleting snapshot. What is "improper" here?

Doing without using the qgroup ioctl, but some extra flag in snapshot
creation/deletion, which can also add relation at subv/snapshot creation
time.

>=20
> Snapper obviously does not track every parent-child relationship beyond=

> what it itself cares about (single summary qrgoup that includes all
> snapshots).
>=20
>>> and what can I
>>> do? I have no way to even know what is wrong because the very command=

>>> that shows it fails immediately.
>>>
>>> bor@tw:~/python-btrfs/examples> sudo ./show_tree_keys.py 8 . | grep 0=
/789
>>> (0/789 QGROUP_RELATION 2/792)
>>> (0/789 QGROUP_RELATION 2/793)
>>> (0/789 QGROUP_RELATION 2/795)
>>> (0/789 QGROUP_RELATION 2/799)
>>> (0/789 QGROUP_RELATION 2/800)
>>> (0/789 QGROUP_RELATION 2/803)
>>> (0/789 QGROUP_RELATION 2/804)
>>> (0/789 QGROUP_RELATION 2/805)
>>> (0/789 QGROUP_RELATION 2/806)
>>> (0/789 QGROUP_RELATION 2/807)
>>> (0/789 QGROUP_RELATION 2/808)
>>> (0/789 QGROUP_RELATION 2/809)
>>> (0/789 QGROUP_RELATION 2/814)
>>> (0/789 QGROUP_RELATION 2/818)
>>> (0/789 QGROUP_RELATION 2/819)
>>> (2/792 QGROUP_RELATION 0/789)
>>> (2/793 QGROUP_RELATION 0/789)
>>> (2/795 QGROUP_RELATION 0/789)
>>> (2/799 QGROUP_RELATION 0/789)
>>> (2/800 QGROUP_RELATION 0/789)
>>> (2/803 QGROUP_RELATION 0/789)
>>> (2/804 QGROUP_RELATION 0/789)
>>> (2/805 QGROUP_RELATION 0/789)
>>> (2/806 QGROUP_RELATION 0/789)
>>> (2/807 QGROUP_RELATION 0/789)
>>> (2/808 QGROUP_RELATION 0/789)
>>> (2/809 QGROUP_RELATION 0/789)
>>> (2/814 QGROUP_RELATION 0/789)
>>> (2/818 QGROUP_RELATION 0/789)
>>> (2/819 QGROUP_RELATION 0/789)
>>> bor@tw:~/python-btrfs/examples>
>>>
>>> And even if I find it out, I cannot fix it anyway
>>
>> Furthermore, latest kernel should automatically remove the relation wh=
en
>> deleting the qgroup.
>>
>=20
> Yes, seems to be the case now with 5.2.3.
>=20
>> Would you please provide the (minimal) script/reproducer causing the
>> situation and kernel version?
>>
>=20
> I cannot reproduce it on purpose with kernel 5.2.3 and btrfsprogs 5.1. =
I
> do not remember when I created the configuration in question, it
> probably was late 4.x or early 5.x. System was periodically updated
> since then and I noticed it only now.
>=20
> Actually kernel should be dropping parent-child relation when removing
> child since kernel 4.1 (commit
> f5a6b1c53bdd44f79e3904c0f5e59f956b49b2c8). May be there is (was) some
> other code path that skipped it.
>=20
> OTOH this is not atomic. First qgroup item itself is removed, then
> relation. If removing relation fails for whatever reason item itself is=

> already gone and we have situation above.

You're right about the removal, although the term is not "atomic".

For qgroup item deletion, we can return -ENOENT or other serious tree
corruption error from btrfs_search_slot()/btrfs_del_item().

But even for -ENOENT case, we still tries to delete the relation item.
So that part is OK.

The problem is the del_qgroup_relation part, where if we hit even
-ENOENT we abort deleting even if we may have extra items needs to delete=
=2E

We need a little more polish on the error handler.

So is the btrfs_del_qgroup_relation() where it doesn't delete all
relations, but only one.

I'll soon send out patches to address your bugs.

Thanks,
Qu

>=20
>> Thanks,
>> Qu
>>
>>>
>>> bor@tw:~/python-btrfs/examples> sudo btrfs qgroup remove 0/789 2/792 =
=2E
>>> ERROR: unable to assign quota group: Invalid argument
>>> bor@tw:~/python-btrfs/examples>
>>>
>>> I can remove parent qgroup, but it does not clean up parent-child
>>> relationship
>>>
>>> bor@tw:~/python-btrfs/examples> sudo btrfs qgroup destroy 2/792 .
>>> bor@tw:~/python-btrfs/examples> sudo ./show_tree_keys.py 8 . | grep 2=
/792
>>> (0/789 QGROUP_RELATION 2/792)
>>> (2/792 QGROUP_RELATION 0/789)
>>> bor@tw:~/python-btrfs/examples>
>>>
>>
>=20
>=20


--9xHEdPkuCvuImMh69iWDrhlzFMD97G2mu--

--9jpMnrYARjEOVgmPUARPMghwRbh3vdbR5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1FJuQACgkQwj2R86El
/qhkHQf/ZEu6wJOw6pHpTmYROLAZkv7qKwnOC8uCyG+6/t/jeu7Hj8y6KiUGKU1i
959cG+yYURSmOvowoCTQA+gP3mwQPGryc4Dg15/xP5HLX9dsTetw5/IKYByKqmNF
8Bg2JWV1l9TUWLUcyT6Z3vQYTCYYLT1FvIXplqq7LvY9bPByRBwCXmWpc9caNxcy
uW59cUY/E/oObzanOCqhXwvDiq5LLhxJo/Cd2WfBRD9uPKpzTF6JZj/mjuX/JOKV
zkHMflKfOcB/KR/z2SCap6zLF/S5BhKiDgnQqLJt7ZxaC9G7/gX4Jbd536M/2+7H
+z45UPU/ukzXXiOlTp/iuFnGELQyUg==
=MtPP
-----END PGP SIGNATURE-----

--9jpMnrYARjEOVgmPUARPMghwRbh3vdbR5--
