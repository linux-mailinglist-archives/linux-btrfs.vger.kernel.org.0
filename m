Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD1A212216
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 13:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgGBLVt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 07:21:49 -0400
Received: from mout.gmx.net ([212.227.17.22]:40059 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728009AbgGBLVt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 07:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593688906;
        bh=b715yQY2hPAZtGQOkh07ADyXvzSLIwK+ckbh4Hi4MDU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=hCSD9J+vBZSVuJPEDTmBIaez945BnRLMRB5WdUiArqjJ30mBXpli+hiE4gGIW1VJO
         LfyNUDokHE/GfMLzs3ZsTf7q3kQ/2rZtzAdCiwAB4tpvoo/zISWaGPt9k5ipL8CQ6s
         yfa6zTIb1dGvC1/xWO0eSBFxkUpS/Ul8h6Ep1Xxk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJVHU-1jX6132XaS-00Jrjw; Thu, 02
 Jul 2020 13:21:46 +0200
Subject: Re: FIEMAP ioctl gets "wrong" address for the extent
To:     "Rebraca Dejan (BSOT/PJ-ES1-Bg)" <Dejan.Rebraca@rs.bosch.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cfd1d2842b4840b99539f00c34dc5701@rs.bosch.com>
 <1d41a247-a4f7-124a-4842-f7d886e9aa70@gmx.com>
 <c3b2c46ca5314285a79536cb3c233e1b@rs.bosch.com>
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
Message-ID: <a18bcf27-4c65-6033-0ea7-45da2b521864@gmx.com>
Date:   Thu, 2 Jul 2020 19:21:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <c3b2c46ca5314285a79536cb3c233e1b@rs.bosch.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6KYZ6aoDRAdCp3TPKfRsPQZgdwzfyTEht"
X-Provags-ID: V03:K1:L8SFSIvP9aWd2TEkRzYVh2GwejX/Wgb0PEvybvZMgaWqnDnJQN1
 Tu3dk1Zaos9yhxf2F1mJYVnIPYhJSyqLBSzSz0CCCAYT2d/z515865Yr+2tSQkiIGwdHE+n
 ivsu2e5MOgQUkJ38BsS8eMgHt5888sBXmHTVczcJcDABoHHgZ6SSypaR4Uecnr+dDc78aN+
 OcvdcenA5N35xY+stgypA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:icKkD043tnA=:J2nKCf3RWilnLpWuIdmZzt
 SnDiDSfKdz5hQCnjePsiQH5O/nHmtCDqh16KpHoFI4vkjGrsAmmFEVe6/0WNrX1XvQ6VRQIvI
 4sR0sdGCJMqODC8o6HzUDmrCxf3RZWO51xflTy9jTtlS7Q+nd3uWtrE2mCMtThWg9UKZ3oEdd
 tbjLvazLAxv/t7tSwIKg/QjMgMi7T/0diokeqVpIh/vJILwimfC1M2TjPNjKU8cFMonytQxiC
 BpZ8ZEZcASB0ri3uDYVgUWKOHQPWkwk0LEBJDIXkhACkH7jGvy3ZiVnh1CX9qrQaHB53LwYdE
 1sgo7OTzU/1QG4e+NJrGLwWtTK2vnWI+pxWbjnJ/wOYBHf+idG3gb+PP2IBcbyRjZpvRNwMry
 ACf1olvJE8hq+0VcVgE8deaW1f/s4vb0wKLCq0+xujUNLv5Grq/sHnT7GOOeKV8wK3WZzfya/
 wwQnzJOSGEkC9LTPep3LdXVBpzl8mPzqRZmxVJ8pNp/9ubU/KrJPet88AbOsGP0CtinygPm6d
 P4Jj3+HAGHKIf893zftHS/EesAwJzqk1VBRfCwZkfuaJImJ4NJKELZzq8r6L/6GlhNl7hLAAD
 fDbABRLgMQlDegYiHDlTbELbu+iFxJ8z7eMOk+TmtiobDQLhakSNZ6gRuN0ffn7TynZQsWFfI
 hx7cvkEpYFrQZuDEnXmtSGX0SMcqv0WI3gg3KREYBYwbiTaN+geeJG2xiPE2ml+1O6ZhcCppA
 25h3KOEqwxlCK2vTv4kyBrNQHnMo1Ma5DDuiXNdyY84jeXdgXBNZMr0jnAi1HJvZrfjv62kq3
 KAmYTKd5cAjfEO909OR/QJrsZD3i84lH1/Y0rKmoZnfqNeGGs0PLiJSNV8BOZicxualqzxD9M
 lLbSnq2gdHPslRiTDovw7jh1helFugdTYJI/nEyVYGvokECxG5x+B2PebrzJNBPnGNSIdDcL1
 IMHzjhiw0VbIpaUMu9UOb5bSJymbIQFLy9+nIVWAwZfKEzsq2j+gYUxGa8ptUxXJKarnAQs7s
 z4OjCF/9LsACwwkk7yoIncTvwQSY8M+i6mx2gfXbUeHl4gV3dYv2Do10wGXiNijVWoWIDYO4V
 1U7+V3LC4IhYcou30c2o49FmBiram7c74/cNGU8T7fJQWOxB0tFhkSh3he/YiM7YXlDYmR2Uh
 gDMLFG0VIGu7e0/uvmUsUddSpgnymN1AOcuanrGF3iENp5yoJa3M1dRjg7/V5FaGC3t8JUxf+
 9lcrp90O8haZ2ZGNT
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6KYZ6aoDRAdCp3TPKfRsPQZgdwzfyTEht
Content-Type: multipart/mixed; boundary="unoY3iflDqBjzhXIPnyibnPfApiEvw01s"

--unoY3iflDqBjzhXIPnyibnPfApiEvw01s
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/2 =E4=B8=8B=E5=8D=887:08, Rebraca Dejan (BSOT/PJ-ES1-Bg) wrote:=

> Hi Qu,
>=20
> I'm using this structure to get the address of file extent:
>=20
> struct fiemap_extent {
> 	__u64	fe_logical;  /* logical offset in bytes for the start of
> 			      * the extent */
> 	__u64	fe_physical; /* physical offset in bytes for the start
> 			      * of the extent */

fe_physical in btrfs is btrfs logical address.

> 	__u64	fe_length;   /* length in bytes for the extent */
> 	__u64	fe_reserved64[2];
> 	__u32	fe_flags;    /* FIEMAP_EXTENT_* flags for this extent */
> 	__u32	fe_reserved[3];
> };
>=20
> And using fe_physical field I verified that it really reflects the offs=
et in filesystem image - I can see that file content begins at this offse=
t.
> The problem is that I run into some specific case where file content do=
esn't begin at fe_physical, I rather have something else at this offset.

As said, there is no guarantee that btrfs logical address is mapped 1:1
on disk.
It's possible, but never guaranteed.

You need to pass that fe_physical number to btrfs-map-logical to find
the real on-disk offset.

Thanks,
Qu


>=20
> Thanks,
> Dejan
>=20
> -----Original Message-----
> From: Qu Wenruo <quwenruo.btrfs@gmx.com>=20
> Sent: =C4=8Detvrtak, 02. jul 2020. 12:19
> To: Rebraca Dejan (BSOT/PJ-ES1-Bg) <Dejan.Rebraca@rs.bosch.com>; linux-=
btrfs@vger.kernel.org
> Subject: Re: FIEMAP ioctl gets "wrong" address for the extent
>=20
>=20
>=20
> On 2020/7/2 =E4=B8=8B=E5=8D=885:11, Rebraca Dejan (BSOT/PJ-ES1-Bg) wrot=
e:
>> Hi all,
>>
>> I'm collecting file extents for our application from BtrFs filesystem =
image.
>> I've noticed that for some files a get the "wrong" physical offset for=
 start of the extent.
>=20
> First thing first, btrfs fiemap ioctl only returns btrfs logical addres=
s.
> That's an address space in [0, U64_MAX), thus it's not a physical offse=
t you can find in the device.
>=20
> For example, for a btrfs on a 10G disk, btrfs fiemap can return address=
 at 128G, which you can never find on that disk.
>=20
> This is not that strange, as btrfs can be a multi-device fs, thus we mu=
st have an internal address space, and then map part of the logical addre=
ss into physical disk space.
>=20
>> I verified it using hexdump of the filesystem image: when dump the con=
tent starting from the address returned from FIEMAP ioctl, I see that the=
 content is absolutely different from the content of the file itself. Als=
o, the FIEMAP ioctl reports regular extent, it is not inline.
>=20
> If you're using the logical address returned from disk directly, then y=
ou won't get the correct data obviously.
>=20
> What you need is to map the btrfs logical address to physical device of=
fset, that is done by referring to chunk tree.
> And even after the conversion, it's not always the case for all profile=
s.
> For SINGLE/DUP/RAID0/RAID1/RAID10/RAID1C*, you can find the data direct=
ly, but for RAID5/6, you need to bother the P/Q stripe.
>=20
> And furthermore, there are compressed data extents, which on-disk data =
is compressed, which also diffs from the uncompressed data.
>=20
>=20
> For the chunk mapping, you can verify the mapping of <logical address> =
to <physical address> using btrfs inspect dump-tree -t chunk <device>.
>=20
> The details of the btrfs_chunk on-disk format can be found here:
> https://btrfs.wiki.kernel.org/index.php/On-disk_Format#CHUNK_ITEM_.28e4=
=2E29
>=20
> Thanks,
> Qu
>=20
>>
>> Environment:
>> - 4.15.0-96-generic #97~16.04.1-Ubuntu SMP Wed Apr 1 03:03:31 UTC 2020=
=20
>> x86_64 x86_64 x86_64 GNU/Linux
>> - btrfs-progs v4.4
>>
>> Does anyone has any idea? I would appreciate your help on this one.
>> Tnx.
>>
>> Best regards,
>> Dejan
>>
>=20


--unoY3iflDqBjzhXIPnyibnPfApiEvw01s--

--6KYZ6aoDRAdCp3TPKfRsPQZgdwzfyTEht
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl79w0YACgkQwj2R86El
/qg2OAgAoZpk2+hB0Kv4h9ek+tBzskXJ5ASMIn2asBHNAMFzu/UE9cmtdFsRL1GJ
XcYvD7qAe5PTz960ZNIz5TdjBpyoHbmTUuQVghhIEDfYtqdfK5yv8C7nQ7Zns6no
mpLPL277GG19XRxsZglOkAM0HZ2OV+MD+2v6hNcc7t2UE1QtaLvRLXFk2+zVuJsb
TJag13YGfdHEgz5u/MWDXcgOKmdBMWrVtD+BQ8P77+ROp2wEOEU9HRRUtNloaZpA
vdRF7Mry2xvFqN8PF6qxMU9nEMUMTUf1ZUsSMFt897zA9jvrpX9VPWJ4Cgve4M0B
sJ1gTj5S3mS7NWkZrfvSrmji8cHCxQ==
=VzZq
-----END PGP SIGNATURE-----

--6KYZ6aoDRAdCp3TPKfRsPQZgdwzfyTEht--
