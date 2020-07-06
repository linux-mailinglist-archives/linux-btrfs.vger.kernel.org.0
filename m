Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE6A215916
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jul 2020 16:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgGFOFo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jul 2020 10:05:44 -0400
Received: from mout.gmx.net ([212.227.17.20]:60493 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728940AbgGFOFo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jul 2020 10:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594044339;
        bh=E7HldAxzy0MOyKqjsj+KSJXsZivUCDVlpSlLrTIpm2U=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EpcX/91Am40Hup1c89/HBRnd/K9tr+GqhgoCXoEIuJPHmQ4LvZEFZRxPoN0jvD7QV
         KiCqFRV4uMyVjdkh+NLrrchBE64IrThaziaC5xRGuCAL1tjzvsIVFLVTVQ3CEow86+
         o//Yp32BLbStiVSClVZt3dR5XQPFcMrnAB6bpZVQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJVDM-1kCJ0v01Hc-00JtVV; Mon, 06
 Jul 2020 16:05:39 +0200
Subject: Re: [PATCH RFC 2/2] btrfs: space-info: Don't allow signal to
 interrupt ticket waiting
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Hans van Kranenburg <hans@knorrie.org>
References: <20200706074435.52356-1-wqu@suse.com>
 <20200706074435.52356-3-wqu@suse.com>
 <9ca1e526-6149-c5f2-402f-6e7331ac02ea@toxicpanda.com>
 <8f742315-6f47-771e-234e-98d7428c2f5b@suse.com>
 <d01c2c4a-0c3e-c599-fd64-715c000ad31f@toxicpanda.com>
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
Message-ID: <13f7d3b6-e555-38cc-b73c-817bab70924c@gmx.com>
Date:   Mon, 6 Jul 2020 22:05:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <d01c2c4a-0c3e-c599-fd64-715c000ad31f@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="salIfjxMaBXUBemXGoGtaFS2u96FrmOdh"
X-Provags-ID: V03:K1:kxhy912+qza7PuXTa2Q1Hoo+OWusdP0aQlkbX+tJaLf/5Duslnq
 D4qqPXfw+STHboJqCHs+idgoWVVyDyzYEkv7JEYnqk42cwe1FBq0pNm4cvcDWvZOX8YMrlJ
 m9B2AfcaSPrpCCmofusGlVyqgEPxuRpUqUCnd5di4YtZJj5P55s69nbDnLoKQ0LFn9vNHOm
 BQVCPnxLnrAvIs94Oub+A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:o7jBvUUy4RI=:k67nH94ocM4dsWNSyaEN9X
 c4mMyLAr08dNos2n4QkoCJJW/XSJawGxMwJZsGGH+gyZTSo5D1SK7ATNuZQqCStqrYqKcsLvA
 q+NyB1h6ymidw4I0hVg9dkMkOZsQvaH+5MiJ4uuHwNslF9U5+nh812RFNo18rspJHxwSwR0cd
 T/WWQjXJFtibUfhWvOvLf3TjhARIFT2zaLoFnD3P5VL06u/O4rb1MrgQU+6DY+FH689OWMbMJ
 hQD1yqQ2okV2cdKPD9l0+9dDi/Y/J9fmRKaqOTkM07J0CZ9g9yc7mz1ZEaXiqh98prztRC+Vk
 LW7COfEUD4MhGgL3/iXNKG1Az0PWgCkyvL9qdEoLAwDeXopzEnD/TM9hb6OO7U+Ix3rbnekqu
 trIvZUN0yJaHGOBIGxOdxqsrr9sc/pWo2eKoR30Pu2jAsSW/Yr2aYX45JlHnrpNxEdrFkZUGN
 PBe9hkSkBSTNZbx0xljVIgzsVXzI0fOq2iNDIlFc+goZtgviGPG8uyVEL7GlnROYuFnAwR77+
 mjfVO+hKXxkXs5jzQZ9JFpzBS8dxZ9nY1HGHdd7aC3BiEsvG9TIQQFCpLAtffySQwszEqm9Ek
 xJi2kxylHXLaUuHg/0zN83gOvvJ49oN8fe4BkEWnbLv/PPUwXQlrZ1rzcv4bInhAyCEkNnV7A
 2W6G3iRzKO2y+ZOLZirkHPlrlwK+n+E1s323pf2/s9lwoZaMQA9VHVF+sNgoqdHOhTKsCd8bZ
 UTcSk9+DEMCfTtUI2Ak9k8RQc4ZXq3a8z/zjJj7kKKfR3S3ZmfR7RYXCI7JUOUZqdyCz3I22L
 hEdtPCszDnwn+DIxXi3fOskYwsw2ZjxMiRdCqZeE7eHM6+VrrEy3OrEkwJwP8P+zxeLbbXoJ0
 +gMry+D0Z/XGCCmXYcaga1IBPgoc2Hsuus7FnMd20Gzqxr1uHfiidi5voT4c+atzN+taYc0UX
 zUquHwOyPbsx6HNHjuIpaclhQ+kZHfaXLs76WMaryQS3vTUAglYSVlX+LSsWFN0h1MyQbeZU2
 fmzO6FdjCzZlio0ZPPJPeyqW7ftps6nqj4GzzGU+kWltWG1X5MS2LS0Luad6UvsWGMc8Q2JP/
 Ysnw1RvTAjvwPbp8gcVu3+WQql1ApTGQzvNKdLKVukavygjnHhC0ljH7mnYOfPsHrCHI2A9lf
 b1tgrT10atczMqvLuCjLt4PAIMa07DKwwmx+aynMlniyPnwxOTegE98ZYw7O6TsXP1PhBv1aE
 h78m8Vf7JO1j25VFl4VajykGHRo3E534hgn8BOA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--salIfjxMaBXUBemXGoGtaFS2u96FrmOdh
Content-Type: multipart/mixed; boundary="uUMFrxUvjSKxusMxFlJOvTJSyyre7Lkhm"

--uUMFrxUvjSKxusMxFlJOvTJSyyre7Lkhm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/6 =E4=B8=8B=E5=8D=889:53, Josef Bacik wrote:
> On 7/6/20 9:50 AM, Qu Wenruo wrote:
>>
>>
>> On 2020/7/6 =E4=B8=8B=E5=8D=889:45, Josef Bacik wrote:
>>> On 7/6/20 3:44 AM, Qu Wenruo wrote:
>>>> [BUG]
>>>> When balance receive a fatal signal, it can make the fs to read-only=

>>>> mode if the timing is unlucky enough:
>>>>
>>>> =C2=A0=C2=A0=C2=A0 BTRFS info (device xvdb): balance: start -d -m -s=

>>>> =C2=A0=C2=A0=C2=A0 BTRFS info (device xvdb): relocating block group =
73001861120 flags
>>>> metadata
>>>> =C2=A0=C2=A0=C2=A0 BTRFS info (device xvdb): found 12236 extents, st=
age: move data
>>>> extents
>>>> =C2=A0=C2=A0=C2=A0 BTRFS info (device xvdb): relocating block group =
71928119296 flags
>>>> data
>>>> =C2=A0=C2=A0=C2=A0 BTRFS info (device xvdb): found 3 extents, stage:=
 move data extents
>>>> =C2=A0=C2=A0=C2=A0 BTRFS info (device xvdb): found 3 extents, stage:=
 update data
>>>> pointers
>>>> =C2=A0=C2=A0=C2=A0 BTRFS info (device xvdb): relocating block group =
60922265600 flags
>>>> metadata
>>>> =C2=A0=C2=A0=C2=A0 BTRFS: error (device xvdb) in btrfs_drop_snapshot=
:5505: errno=3D-4
>>>> unknown
>>>> =C2=A0=C2=A0=C2=A0 BTRFS info (device xvdb): forced readonly
>>>> =C2=A0=C2=A0=C2=A0 BTRFS info (device xvdb): balance: ended with sta=
tus: -4
>>>>
>>>> [CAUSE]
>>>> This is caused by the fact that btrfs ticketing space system can be
>>>> interrupted, and cause all kind of -EINTR returned to various critic=
al
>>>> section, where we never thought of -EINTR at all.
>>>>
>>>> Even for things like btrfs_start_transaction() can be affected by
>>>> signal:
>>>> =C2=A0=C2=A0 btrfs_start_transaction()
>>>> =C2=A0=C2=A0 |- start_transaction(flush =3D FLUSH_ALL)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- btrfs_block_rsv_add()
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- btrfs_reserve_me=
tadata_bytes()
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
- __reserve_metadata_bytes()
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |- handle_reserve_ticket()
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- wait_reserve_ticket()
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- prepare_to_wait_ev=
ent(TASK_KILLABLE)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- ticket->error =3D =
-EINTR;
>>>>
>>>> And all related callers get -EINTR error.
>>>>
>>>> In fact, there are really very limited call sites can really handle
>>>> that
>>>> -EINTR properly, above btrfs_drop_snapshot() is one case.
>>>>
>>>> [FIX]
>>>> Things like metadata allocation is really a critical section for btr=
fs,
>>>> we don't really want it to be that killable by some impatient users.=

>>>>
>>>> In fact, for really long duration calls, it should have their own
>>>> checks
>>>> on signal, like balance, reflink, generic fiemap calls.
>>>>
>>>> So this patch will make ticket waiting uninterruptible, relying on e=
ach
>>>> long duration calls to handle their signals more properly.
>>>>
>>>
>>> Nope, everybody that calls start_transaction() should be able to hand=
le
>>> -EINTR, so we need to find those callsites and fix them, not make it =
so
>>> we hang the box because we don't like fixing error paths.=C2=A0 Thank=
s,
>>
>> Then we also need to handle btrfs_delalloc_reserve_metadata(),
>> btrfs_block_rsv_refill(), btrfs_use_block_rsv(), btrfs_block_rsv_add()=
=2E
>>
>=20
> This only needs to be handled for FLUSH_ALL and FLUSH_STEAL.=C2=A0 Anyb=
ody
> doing btrfs_start_transaction() should be able to fail with -EINTR,
> because they should be close to the syscall path.=C2=A0 Balance needs t=
o be
> fixed to deal with it, and I assume there might be a few other places,
> but by-in-large none of these places should flip read only.=C2=A0 Thank=
s,

There are already ones existing, for btrfs_drop_snapshot().

This is mostly caused by btrfs_delalloc_reserve_metadata(), which always
use FLUSH_ALL unless there is a running trans or its space cache inode.

But still, for a lot of relocation code, we don't really want to bother
the EINTR and just want uninterruptible at least for now.

Any idea for that?
Or just rework how we handle errors in a lot of places?

It doesn't look correct for such a low level mechanism to return -EINTR
while most of callers doesn't really want to bother.

Thanks,
Qu

>=20
> Josef


--uUMFrxUvjSKxusMxFlJOvTJSyyre7Lkhm--

--salIfjxMaBXUBemXGoGtaFS2u96FrmOdh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8DL6kACgkQwj2R86El
/qjrUwf/VXBDI/cNNo1L5jtFBoAMfF8LsZ54Y9LBm2f51aqVFVurZrHw3Q4vmUPO
8fqE2S8gV9RWJxNgANI8tRpNxNaFlPrrqmfa/4ZRcNT+U3qBcozuhKlcWCVlKt6T
kzLSxtUuUvRbSE2NJyrwAFvJgeBM4vdZ8MoWl78n3Ht1fjPK0xpXduXhStUkV716
vHMn4TrMqtF9H4WB1uY6W/jxgYcaFDqP0wvj6xbQT/sP2tUchCCgFE2lqxexMbn1
x/MnL86CE1i5D7W0EhDSx5x9mXBkjspPH2ZiwFs2Tws3ylxXsqydvQ0rjFYiYeaE
ZlP4h0WrAFrlYr0tfXA53xNd2uLtaQ==
=C+5b
-----END PGP SIGNATURE-----

--salIfjxMaBXUBemXGoGtaFS2u96FrmOdh--
