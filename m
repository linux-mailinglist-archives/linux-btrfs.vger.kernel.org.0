Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB52F4194
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2019 09:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfKHIBb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Nov 2019 03:01:31 -0500
Received: from mout.gmx.net ([212.227.15.19]:42319 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfKHIBa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 8 Nov 2019 03:01:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573200081;
        bh=6TLqb6BoNobX3n8k/YIrBN6FWJvRwODiLXKxCL5Ezz8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZC36LA+aWyG0nAUzYZWuUz0USXaMZdaPdLAqqXOcbxlC3P2TRkwTEwSDEwVHDTUbA
         2rIbjgFn2fC0lnCJ6l1T6uWGPWTo4CbPns73O45z9XWxMvYEqMdKfU1xGj4wwvaQpr
         TZSbujis0A63kNK0+TAA4mpDssNA8Cq9R87wTNnY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N5mKP-1hs4163KBP-017CbM; Fri, 08
 Nov 2019 09:01:21 +0100
Subject: Re: Defragmenting to recover wasted space
To:     Nate Eldredge <nate@thatsmathematics.com>,
        Remi Gauvin <remi@georgianit.com>
Cc:     linux-btrfs@vger.kernel.org
References: <alpine.DEB.2.21.1911070814430.3492@moneta>
 <cc5fba8b-baf3-f984-c99d-c5be9ce3a2d9@georgianit.com>
 <alpine.DEB.2.21.1911071419570.3492@moneta>
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
Message-ID: <c5458fb8-7df9-9e27-4208-fdbb3b4d731f@gmx.com>
Date:   Fri, 8 Nov 2019 16:01:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911071419570.3492@moneta>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="y4J24WjV6zzNhsNKglIU7BGUrtPSJRBe6"
X-Provags-ID: V03:K1:4UFdbpQ/vOY6AmHpipjINbF5JJ3NVkzzoTLUFD7vqMo3f/PrEm3
 Zh+Fc2ylceHpPdI5Ro0TojpfaU5nEEt+8Dwey7JwQH6djsJvGLB3LPgm7IOx69KRcdARJT2
 kk+Ip8XhQGapD0rXPG1YQshCG3RqXJ4JqNmaClKawLWkATPCdjjE5NZhqw7hUlzpz+C1Fnn
 jAsAixt/AfFSKNajISOlg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:r1vqYjVGUd8=:uYXheDacTrkUKPH9t1FMVK
 EFjM/0hbQ000Xp8+VP5GEO8297DnII1zopKi/kcuqoopB5txDFSjaZ4/E9lOlaleZTCMBiMEu
 yCdsV4QSFMj5WiroJ4oZS8FiUJSotmV5Aw3kklUlTtYhgAbv5To33BDvcZSvwlDyo70ljEbnE
 sNa2STiwARh7ZsB3VQvPdrE3jXFbF9PZ1q7vqB43baT90LZffoH/mX8uGv3rYHVUUp4PevCtb
 bnUKiKRlKj8bpt7g8OyX04I2W4MwQ2uQwfdZj701m4Er7XIJ8wEUkXGXex7Fh+IFSn9qPXryr
 brQ90R4fX+duZhKo+lPNnVipRyUvSpod3+llPdo27hZJCg+2oazTtEATvsi/Ni2URHhd9/jDF
 SAc3O/sArji4CE0itfH6zTpzkzNrV/TLA7Yjoc8CR+xlOhveYH4WsGz8VLzONJvTomJ9/HFd7
 Miq/zpujW0whU384epPaauNw64qINvsLj57T/fhHHPRio+F6uzVbmp1DV+kW29FQgCVJ+rBQN
 5ADI21ypc3X10iioQeYBHh6QHoknF19MPmWCiPP8UOhahfw4p+zUTlcE+dspaUV4non/02DRJ
 HERpAm2JKXQAjckXME3oE2znnhP8ItlkodwIC02DsLpxnG0VanrmwUZc0cEyWqQuUABt79gb8
 FNzKDj42BeaUmsOk2dyFq/R9fqVsvoUFHzggxsNlLfpRRWUiD8MPJa2w2wQaX/91HF27YRfKY
 rMG2i6UPQRwMi0HIqKXmRfxkDDUIMyE9Ynzsz14MN0jzuwuJkkjHyIRzYXmG5Geqt208G0aoi
 K832zQQW7fPnw65p6f4knNh2g8b3Oe3F4cowOHupB18QT6j3sCdQn6zG1pD6hW7jGcthx91qu
 BckC0buDOKVOuVZxAWaWO5BABr0xY4fxIYl5QuwMv+Le/13PVEDZgX+KJVXYq7/WV2VFsyBhX
 4Ez8asIZkCwcNSyF55pZaUAUtk4sSEUoz0/TBb5zDYz0H40NePGLbLiMcwVv+B/B+j2UPJJJH
 GGwUAZp4f3h92Ow+1RFayoQYHDzDp+qvDbaa96rK9jVkiKre7MEvo7Eau98SdT3n8iHq17Ce3
 mnFn3OEJDBx6SVLKCogygNus2m/lwJioMcJ2R03xvBa9zstYjioFj++pMA4M3qhhRBYo981SU
 IXPy8SJ/uAt3Gn6he1Ph2MFIQHq2UA0E5ZJ7vJxah4vzdWUffaFLmLr13sbgeWEOnuXm4dBnP
 PselYZizz9caXr3S6Ul1I1dqfpwOTpMumBkrvI6q+Pes3a2u4vlzIssmbuRA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--y4J24WjV6zzNhsNKglIU7BGUrtPSJRBe6
Content-Type: multipart/mixed; boundary="e31ENkLgIgXmUmAgYjNaFNsWTfHspELPN"

--e31ENkLgIgXmUmAgYjNaFNsWTfHspELPN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/8 =E4=B8=8A=E5=8D=883:41, Nate Eldredge wrote:
> On Thu, 7 Nov 2019, Remi Gauvin wrote:
>=20
>> On 2019-11-07 9:03 a.m., Nate Eldredge wrote:
>>
>>> 1. What causes this?=C2=A0 I saw some references to "unused extents" =
but it
>>> wasn't clear how that happens, or why they wouldn't be freed through
>>> normal operation.=C2=A0 Are there certain usage patterns that exacerb=
ate it?
>>
>> Virtual Box Image files are subject to many, many small writes... (jus=
t
>> booting windows, for example, can create well over 5000 file fragments=
=2E)
>> When the image file is new, the extents will be very large.=C2=A0 In B=
TRFS,
>> the extents are immutable. When a small write creates a new 4K COW
>> extent, the old 4k remains as part of the old extent as well.=C2=A0 Th=
is
>> situation will remain until all the data in the old extent is
>> re-written.. when none of that data is referenced anymore, the extent
>> will be freed.
>=20
> Thanks, Remi.=C2=A0 This is very helpful in understanding what is going=
 on.=C2=A0
> In particular, I didn't realize that extents are immutable even when
> there is only one reference to them (I have no snapshots or reflinks to=

> these files).
>=20
> I guess this also means that in the worst case, if I want to overwrite
> the entire file "in place" in a random order, I actually need additiona=
l
> free space equal to the file's size, until I get around to defragging.=C2=
=A0
> That's rather counterintuitive for somebody used to traditional
> filesystems.
>=20
>>> 5. Is there a better way to detect this kind of wastage, to distingui=
sh
>>> it from more mundane causes (deleted files still open, etc) and see h=
ow
>>> much space could be recovered? In particular, is there a way to tell
>>> which files are most affected, so that I can just defragment those?
>>
>> Generally speaking, files that are subject to many random writes are
>> few, and you should be well aware of the larger ones where this might =
be
>> an issues,, (virtual image files, large databases, etc.)=C2=A0 These f=
iles
>> should be defragmented frequently.=C2=A0 I don't see any reason not ru=
n
>> defrag over the whole subvolume, but if you want to search for files
>> with absurd fragments, you can always use the find command to search f=
or
>> files, run the filefrag command on them, then use whatever tools you
>> like to search the output for files with thousands of fragments.
>=20
> Okay.=C2=A0 Defragmenting is kind of inconvenient, though, and I suppos=
e it
> involves some extra wear on the SSD since data is really being moved.
> There's also the issue, as I understand it, that defragmenting will
> break up existing reflinks, which in some other situations I may really=

> want to keep.
>=20
> In fact, it seems that somehow what I really want is for the file to be=

> *completely* fragmented, so that every write replaces an extent and
> frees the old one.=C2=A0 On an SSD I don't really care if the data bloc=
ks are
> actually contiguous.=C2=A0 It seems perverse, but even if there is more=

> overhead, it might be worth it when I don't have a lot of free space to=

> spare.=C2=A0 I don't suppose there is any way to arrange that?

In fact, you can just go nodatacow.
Furthermore, nodatacow attr can be applied to a directory so that any
newer file will just inherit the nodatacow attr.

In that case, any overwrite will not be COWed (as long as there is no
snapshot for it), thus no space wasted.

Thanks,
Qu

>=20
> Thanks again!
>=20


--e31ENkLgIgXmUmAgYjNaFNsWTfHspELPN--

--y4J24WjV6zzNhsNKglIU7BGUrtPSJRBe6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3FIMoACgkQwj2R86El
/qjijAf/cxBiFmh7l3N8eYILEUhP7SCpGVeJmMTpEwVqv++D7R+gQG2zLSF2anP6
fozTJPKu9qTVgw5W/Y6ltqTIUUqrZ5wdVTQDRE3ckmeg7p/XBbN5vxx0cXJ4G/B4
bnq4jQUh7oYOA0825H79IyBoWNTmKwo2MwfJN8KGnALzI2H5O3Zz5xLrOANqGNZr
FuS9joj+aue8fK3sSVddKqe/ZBldsRDNxytFGAXM+CEC3r8knhRBB7o3VRD9JEjM
HLLRQJ5lxf+d56Iq8zK3aC/ovvSxyHROsG4oUUX0S4LfajUqvJ7y92mS7qZWqMBB
mUotxNzXh3yBOm3kYfKSjD/Vw93TuQ==
=cu7C
-----END PGP SIGNATURE-----

--y4J24WjV6zzNhsNKglIU7BGUrtPSJRBe6--
