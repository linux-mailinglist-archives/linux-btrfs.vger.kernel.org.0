Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA3D2A8B12
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 01:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732396AbgKFAC1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 19:02:27 -0500
Received: from mout.gmx.net ([212.227.17.20]:57405 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732046AbgKFAC1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Nov 2020 19:02:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604620943;
        bh=4P0jejQA1mmdQ2wTNA+dnzG7i5DzGrq22xwVrV4y+h0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=TpQAV2bX77nnDMHQxS9GkW/Tskab2UvYu+FUq2adNVvfUgRmJu4jBRWa9JaMJDI53
         8RTRJNzbO3O28wagb5X8E4a+JhFjT7OQIAwUBuDSQZbfh1+YJp0WEbWKMJrFeJDNRi
         uNaEWP9z8DNUxgzkzN3ill3oqCBvM3cR5VWm7AeM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MG9kC-1kXYUk2Za8-00GWNB; Fri, 06
 Nov 2020 01:02:23 +0100
Subject: Re: [PATCH 00/32] btrfs: preparation patches for subpage support
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201103133108.148112-1-wqu@suse.com>
 <fd706714-c4ae-b1a7-44e8-68249b94bbde@toxicpanda.com>
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
Message-ID: <0d0530f4-a1a4-3d7c-b25d-4b786b4cc317@gmx.com>
Date:   Fri, 6 Nov 2020 08:02:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <fd706714-c4ae-b1a7-44e8-68249b94bbde@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Fffcb0ySHZszJxdSoMnh6Fnc3GDnleUd7"
X-Provags-ID: V03:K1:uqa1qXxEJx5qR4EG0eE/s/TjLKLrdHm2ZsneGKWPdgZmrdRolWB
 /hUyeW5XR+v7cePxiJA93jTzqEoppWQhLqqIbecXhZvbDgxYEKEQ+H1lGqVPkUlxhKQY6PV
 vABXBZ+wNurp5hcw1qAxKP5R3Ooddd44HVoZLR5rDbhtcHRuk1TM7wi16WJnpBSCQsa1RGp
 fXTHiMCRJa+T6huMRe+Tw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8fmwF1loDWA=:rczChuJLI5qKivsI96qrUL
 Rwzh4zrtGBuslSoaXFeKaGix2ub1mFXGnRg4EN8bLpWNY830V3XdQ1wdAAaNxFaT8UAQjatfJ
 f1lN7KT/knOPYsx/cj/FlvHMTeEjJGlCJLYVFhcAmJlZ+M+fKJARXfLqpBSyNf8kKjYIZzWSK
 3J19d8TiEVGOy6WHqTsi4HgVcEZpH1oe1AU8gDBJ506He54SB4NreCE4ZPvqHEgpTjziTFXVO
 2IiloFTlMCOSoVPqQcIb1Wml+z79byHzElVGTlB03WtcScbisgPzEIV+ciPt7/eel8cxPaert
 sp0j6vqlI17FLj29Q2dq1QcIRzFsvUroLIh7ujpjMAtsBogbTmEArbhMmQP0373ZG/0L52jay
 KQDPmPEoxfv43Qspy6/eikLGEZb67Rfl8xSDozjUFDTLDXa27Y0Anzgoo3mN169iILPiQG6uF
 MCJJm8DRHrYw+lVDUAbw0dHaK1jUNGVG6r3Xozshu5muyG8Q4hE6CfwNE0h5MBKyA3wgsaFsx
 yaGdgkQaOsREmT8C9nR6t11rDKpOSyrDaZn0qBmx0Wfdx3r3vZFaD6ug4l/XSDPN1lgKD7rTZ
 KZxZ2nhf57QBS5mW3G9RuX7IvMPqYvCe/oAoEy4eeSdyNZcTOUBJw/F1BUF7ivpcbGGYQ/VvT
 BBKbxQOWy8nPxwT2igENnP5oqqEzbObEEv0St+ZEuoxbkL569jgEPOGtULmLRnGg63g6ZRN35
 w4++YJnr2PYL2cZ8Ytej7d4PQ5JVJAayoAfDxWS0imhlgt3/X/peX/EuhZYXJxHHQxgJEfn6e
 xg7t4MYwr5DQVhgN5872BEYGk4wgp3XDj5FpP5z5fHXy/wF/Q9W3Ll8hko+bIdppOCpIXmuA2
 gWDYQkltTzGlr0OPAUnA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Fffcb0ySHZszJxdSoMnh6Fnc3GDnleUd7
Content-Type: multipart/mixed; boundary="hvtakySbqedaiIALyE4FqfzExRWEOIGgb"

--hvtakySbqedaiIALyE4FqfzExRWEOIGgb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/6 =E4=B8=8A=E5=8D=883:28, Josef Bacik wrote:
> On 11/3/20 8:30 AM, Qu Wenruo wrote:
>> This is the rebased preparation branch for all patches not yet merged
>> into
>> misc-next.
>> It can be fetched from github:
>> https://github.com/adam900710/linux/tree/subpage_prep_rebased
>>
>> This patchset includes all the unmerged preparation patches for subpag=
e
>> support.
>>
>> The patchset is sent without the main core for subpage support, as
>> myself has proven that, big patchset bombarding won't really make
>> reviewers happy, but only make the author happy (for a very short time=
).
>>
>> But we still got 32 patches for them, thus we still need a summary for=

>> the patchset:
>>
>> Patch 01~21:=C2=A0=C2=A0=C2=A0 Generic preparation patches.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Mostly pave the way for met=
adata and data read.
>>
>> Patch 22~24:=C2=A0=C2=A0=C2=A0 Recent btrfs_lookup_bio_sums() cleanup
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The most subpage unrelated =
patches, but still helps
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refactor related functions =
for incoming subpage support.
>>
>> Patch 25~32:=C2=A0=C2=A0=C2=A0 Scrub support for subpage.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Since scrub is completely u=
nrelated to regular data/meta
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 read write, the=
 scrub support for subpage can be
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 implemented independently a=
nd easily.
>=20
> Please use btrfs-setup-git-hooks in the btrfs-workflow tree, I made it =
2
> patches in before checkpatch blew up on something that really should be=

> fixed.

And something that checkpatch is the one to be fixed:

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#36: FILE: fs/btrfs/ctree.h:1504:
+       type *p =3D page_address(eb->pages[0]) + offset_in_page(eb->start=
); \

That script considering we're doing multiply, not declaration.

No, checkpatch should either be a soft requirement (only warns, not to
interrupt applying due to such stupid bug), or shouldn't be included
into the hook at all.

Yes, I know there are stupid format bugs, but just let me know and I
could do a run to filter out the real format errors, not being
interrupted for every stupid existing bugs, like usage of 'unsigned'.

To add more irony to this, my later patches will replace the 'unsigned'
with 'u32', and the damn checkpatch just won't let me continue.

Anyway, I have remove the checkpatch git hooks for now, only keeps the
codespell one, and will do a manual run on the patchset.

> Generally I'll just ignore silly failures, but for a series this
> large it really should cleanly apply and adhere to normal coding
> standards so I don't have to waste time addressing those sort of
> mistakes.=C2=A0 Thanks,

Yeah, but when a large set of patches touching tons of old codes, such
stubborn hook is really not the proper way to address problems.

Thanks,
Qu

>=20
> Josef


--hvtakySbqedaiIALyE4FqfzExRWEOIGgb--

--Fffcb0ySHZszJxdSoMnh6Fnc3GDnleUd7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+kkosACgkQwj2R86El
/qj5vwf8DSIQhl9dsLm58YQY0/KG72ywh0jzX4saA7mPhO/XMtNLkbJOuS7KSQF9
Qu0VJ+awmiIR/FRdkclaSys0tqA9J4Mx69LefXjLDLUyT1GoTuFKmmPedRB1m1l+
ZGtZlIoJttJ2KWJKOW7T5SflyKKFlSINsPfum8DSjjNCbqZ9B0ZknjL1Skzc1SqV
XTLjzZ/32HvhhgUGwApSHgzEkxkADaO1x344Rag0qWy0xEvrpdUo4Rjj8TsRZkoM
k8c79eL0WtCMa/tF7m1ZOCHAa5O257ngF6I60Chiw8kdSB3i5USEVH0D0mUYwzoE
QpEeCmTie1Domm1x2N8//l/uhTRNlg==
=At3E
-----END PGP SIGNATURE-----

--Fffcb0ySHZszJxdSoMnh6Fnc3GDnleUd7--
