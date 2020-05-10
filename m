Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C173A1CC5F2
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 May 2020 03:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgEJBUK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 May 2020 21:20:10 -0400
Received: from mout.gmx.net ([212.227.17.21]:45865 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgEJBUK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 9 May 2020 21:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589073608;
        bh=DlUEfcswyyC+k2bxLZtJBQEQVaq0ArxoF91zxtHhRoc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=TxEyCXrio0qLE2dikCyh68LbdO1n0V+FX5c3nrkZ1aPuay0B5S6BaQLQ61vhF4A/G
         fRVt6+PJYLXP7qHERVltCOD0AWt9KvlX0lZkWdK1aXsDiMZZ19RHMa7M5K2njovcXX
         +wLkw/e8W53C8HpmtQQrIO9GzRpgS6p1+wmMWOmQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNbox-1jm5M41Zv9-00P4wO; Sun, 10
 May 2020 03:20:08 +0200
Subject: Re: Exploring referenced extents
To:     Steven Davies <btrfs-list@steev.me.uk>, linux-btrfs@vger.kernel.org
References: <c9a53b726880c5d7dc8092c2078e23a5@steev.me.uk>
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
Message-ID: <13d76c35-fbbf-c5e1-20ee-70a9a716d11f@gmx.com>
Date:   Sun, 10 May 2020 09:20:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <c9a53b726880c5d7dc8092c2078e23a5@steev.me.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ilCzaWQy7M5i1tHuuPygmRVupZrlNOJEC"
X-Provags-ID: V03:K1:zWTwiDNubvnQkfHZhbDb7mqHkxmxA4y+2RS9zp4mGNVL+eh74dt
 +4syBRqN6nFYTKYTobgFsTS8BSMUmkS0lwoV+MpyESkvk54l0SNOfY9UsVLrqNH/sggbI05
 WJADQdkFD2IrtZkIa8X8/qAVXVF3ifw92urb6se4ZjGeVgw1fYJ62K1kY3v83jruo/iVqFl
 8nPBcrOtOeCnSvWrIQ2Sw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hZAusQWTycM=:HeZZ8DLXr31il0IZ46HLZq
 /kMjNt6yLDdJ3Fc3YmhAppac6iLaDvheRJAvHQeyYtfmEcNPvyyPxNhPbU/7yZ9LA1SDQ6dQ1
 ErfT+7Aq77zEtvUz2BoP1dEvc8hsowuXB+A36h5UVs+2tEd8oF1uwwCMCfEagh0fITPOgUbHI
 dgXliJpkcjyO4IbougMIArYTJRllKnT5xIWWnFb/NJVkdKKhy3ST3R0F66DMUwXyofnWFL8z9
 I1UZbjJR/BJZ/fehYjiOytzmaKleLi0LfynWgUlYDOlI3tzTwqndVt0YaUCkGaa/jD2GhyrVn
 tyH9SJMeqSpGfCxG3WeA4J4JLFpG32Ifkm55PauFq/ZxnDRuY/xKlFI7zF7CyRkI6zL4doWyJ
 /iDPVZIlQRjgXkrygF3mfkFkohCy8JGNeHnivEcKBLmVof4CVXguEBIOQWEd0ILbT5EdxPzHe
 zm+8Q13jF3TM88pRrQtNzFMUSCyACLGU1FLp8neUyjynxKapTLoouS6c2W9ne6Y91GRKU92AG
 YYai7TB3uHOh6lq1PwA4gLm9Pqc0SDzgy1E6csRhU+8VPyCt27c37XQmNndwsryexowgzZ5fC
 reh0g634+SVMkETSdbDB5F39Qvc2dU7eI7PqjksIFlxmSBNi4YGP5VqC1heLelAI2OEGTAnft
 JmdDg18GEQ4LjrfxmxWBhdXd6DU9TyZ0URKSED70WoaMS5MraWaGoPPbgS1djTdHRigw/xlTR
 eB39ZZgUWDrezmVpbY+dDEee+Fy8QF6fRlrTXgoYa7iUAUiS4Ha9uXJkWZ7gOTpVfPTT6Qdd8
 bKAqh0y1oqb38IKej5Reca0UiwYyzbJSUDB/0yQ3WZBgwa5dE4pj/z1bXhbRhMqDUTk3+fMvj
 dbH0fSwOj+tDXYkHTxkpXKHsCFS1DV0vv8bhOi+M3qP91EShlYGO2yXcvnupmZB8VYddHiAwA
 dNNrIlb4qNJxfYwcJ1SipKQONg4JgbfdoSTGWRHzmzZoP2qSH2wJr/gO86DtRvlszQ0Qsucl2
 orU1aLpzNTX2Ys//qNxAT67WV/su7Xn3vz0Rtg8SglhV8/yYsP7Za6pGwzMvLT9tblSHcOWER
 1Yt2GuA4sheFVVEOIjD1sexJAnh2/TSYxLp/2L+TOP34Oc5i3oyp/p57MjJ114rSCikwBOr6B
 5UXcJs/a+/i+E4iYWCUzGBQvUQ0VY91VHVAEdPe8JeWRO8d5d3ui/GEL1brCM2QsJjW5BxNsj
 LAX7p+ldSRuyfAC1B
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ilCzaWQy7M5i1tHuuPygmRVupZrlNOJEC
Content-Type: multipart/mixed; boundary="3IAcKCeRqP6LNCATv8pPjHYMsSKucNb6D"

--3IAcKCeRqP6LNCATv8pPjHYMsSKucNb6D
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/9 =E4=B8=8B=E5=8D=887:11, Steven Davies wrote:
> For curiosity I'm trying to write a tool which will show me the size of=

> data extents belonging to which files in a snapshot are exclusive to
> that snapshot as a way to show how much space would be freed if the
> snapshot were to be deleted,

Isn't that what btrfs qgroup doing?

> and which files in the snapshot are taking
> up the most space.

That would be interesting as qgroup only works at subvolume level.

>=20
> I'm working with Hans van Kranenburg's python-btrfs python library but
> my knowledge of the filesystem structures isn't good enough to allow me=

> to figure out which bits of data I need to be able to achieve this. I'd=

> be grateful if anyone could help me along with this.

You may want to look into the on-disk format first.

But spoiler alert, since qgroup has its performance impact (although
hugely reduced in recent releases), it's unavoidable.

So would be any similar methods.
In fact, in your particular case, you need more work than qgroup, thus
it would be slower than qgroup.
Considering how many extra ioctl and context switches needed, I won't be
surprised if it's way slower than qgroup.

>=20
> So far my idea is:
>=20
> for each OS file in a subvolume:

This can be done by ftw(), and don't cross subvolume boundary.

> =C2=A0 find its data extents

Fiemap.

> =C2=A0 for each extent:
> =C2=A0=C2=A0=C2=A0 find what files reference it #1

Btrfs tree search ioctl, to search extent tree, and do backref walk just
like what we did in qgroup code.

> =C2=A0=C2=A0=C2=A0 for each referencing file:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 determine which subvolumes it lives in #=
2

Unlike kernel, you also need to do this using btrfs tree search ioctl.

> =C2=A0=C2=A0=C2=A0 if all references are within this subvolume:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 record the OS file path and extents it r=
eferences
>=20
> for each recorded file path
> =C2=A0 find its data extents
> =C2=A0 output its path and the total number of bytes in all recorded ex=
tents
> (those which are not shared)
>=20
> #1 and #2 are where my understanding breaks down. How do I find which
> files reference an extent and which subvolume those files are in?

In short, you need the following skills (which would make you a btrfs
developer already):
- Basic btrfs tree search
  Things like how btrfs btree works, and how to iterate them.

- Basic user space file system interface understanding
  Know tools like fiemap().

- Btrfs extent tree understanding
  Know how to interpret inline/keyed data/metadata indirect/direct
  backref item.
  This is the key and the most complex thing.
  IIRC I have added some comments about this in recent backref.c code.

- Btrfs subvolume tree understanding
  Know how btrfs organize files/dirs in its subvolume trees.
  This is the key to locate which (subvolume, ino) owns a file extent.
  There are some pitfalls, like the backref item to file extent mapping.
  But should be easier than extent tree.

Thanks,
Qu

>=20
> Alternatively, if such a script already exists I would be happy to use =
it.
>=20
> Thanks for any pointers.


--3IAcKCeRqP6LNCATv8pPjHYMsSKucNb6D--

--ilCzaWQy7M5i1tHuuPygmRVupZrlNOJEC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl63VsQACgkQwj2R86El
/qhKAwgAlqAddiL1B/yaGkroZOp85DzDvq/gXGuB79DkCAlCIkRFU6qWxXdtgTCY
x4wLB7tueWj/bOby3CY+8LSEveYNLmrJeOer7WksRNo243/tUuvqpUy64GJ3J9+Q
Jms38JS7oTknWcWrZljtAXz2sA/7LmEXLvShp8V1IlDzskOl74WCop2HPKIye/IV
yjfLjDc5rzZnMq9ZWH0mkyLELjWepuf4NEgfOnsxG6TtQ90u+w7HLJr3e8cmnHnm
WPEujcwmTpZ20npnja88R5fM86ftpoGCtkjhsOc9ziLm9sZD2gSxIJeD20yohqoH
gFq+ZRh2hkgsO303EQRXLqxoezFLcg==
=4mW/
-----END PGP SIGNATURE-----

--ilCzaWQy7M5i1tHuuPygmRVupZrlNOJEC--
