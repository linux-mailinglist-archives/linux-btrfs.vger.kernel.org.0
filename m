Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 805BCD6C79
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 02:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfJOAco (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Oct 2019 20:32:44 -0400
Received: from mout.gmx.net ([212.227.15.15]:52195 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbfJOAco (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Oct 2019 20:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571099556;
        bh=2SNzmQvbK1iWcaZUn0opbPyuuGj4kvISm8lg6oobPyQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=d12fdLNChXBSByc4zzzQV8JvnXItrKcdHQ/xFeUfYP980f+g3yLlNm4YHJoXmqGkS
         a2ehnISImL7UbHyAjU6ZlL3zvbmwORsU3JT1A2GsvS06zUailyu8lNi8S20DQtq4I5
         J3pnwEPgQRD4rpLzM3P5CKrQn+/Ual45iKqopKUI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTiPv-1iTuc32cG5-00U11F; Tue, 15
 Oct 2019 02:32:36 +0200
Subject: Re: [PATCH v2 0/7] btrfs-progs: Support for BG_TREE feature
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191008044936.157873-1-wqu@suse.com>
 <20191014151723.GP2751@twin.jikos.cz>
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
Message-ID: <1d23e48d-8908-5e1c-0c56-7b6ccaef5d27@gmx.com>
Date:   Tue, 15 Oct 2019 08:32:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191014151723.GP2751@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QcnN2aQX9UR8HiSKFXctwXfRW2HoldEp9"
X-Provags-ID: V03:K1:ZUD2hVRu4I8KBsVKD9RSQRFHdOU+6NkrG94Cs1xkWusfSD6XiAm
 q+beUSEzQfrddN5RdthTU15J/1RUYvNmuwN1iI2IQ/xcwe0wvKBum7GT2FxFvnVu2OCIFBT
 TVN55ZJWl3fs2JuNgzkNK29Ss+YZRvBUDQDppJ/ihugVC6Q0OhUDAYROOJLLnlou1jsgsnb
 Jq9Q85c3xT2JrTOwBmVBw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:d4enux5ccSU=:f65/GacgJz7NUdmbuABe+b
 vctRHpcnsc9L6zaWcor1Fak2rwHFjvMoxsJ3/ssYHsInrGX5miBOHTMNB3oE+1lDFq52Uc910
 iSORiaa/Mh7BNOp9iCsB20zq4RoKzcrTYpgY+lGWViqJbbL77JQw4ZzZiZwPBgp+FCn90UnbM
 XcPmIxutwL0cgU6YHoXG3cA+10rXYhGA+4epRGlq5ZRGY6jW+awh1on5nbm0FrLxcla1fkorb
 UvYFIXAlcRrKxbZHGzLHNwKHsh2Zn+rHmdLbi3CA07KShgmMVVUzhA/NKZKwjjhUSslbeeEHc
 Oa8w2Ff5Cl5ySl+FDtWbqewdzc70xr9RF7D9s53FKk4GSgjTWKPtJpOiNWqm88l8pgdeLiTWj
 RvjRqDV0OuY0LS+nfPQAm56tWCJwcR7KPOuxQV2D3YKDcp2m3Z05wwn+NU2OgVVQ0Q40SoGGN
 NRcrHD/+U8T0HYPNLXXc73Pz11oPiXyOLYNYMqG5KbZyrb5uivdNXzN/Zk8/KmmGTNIZjE8QN
 KmqxNeMeb+CaYaFZZq+z3Vbwgn1RkOgVamL+LKB2cbipfu21LkKogUWWL1KJv9F30zwGBeTXB
 mJgL2t69rNYrVx2ovpSn9sl3lbKjXqSuzwrr9nhYgdhtuWqdnorReCebIsV8kZfryDUnvFcKE
 OfWRdQXxZimnV60BDS9WvrnMxEpk/y9ftHJEnUVNnImTHK61ARMFCX8FSK/mHhqjF32rTO7j5
 9cBal2veQuJqDel0PM6g+MdNRCqh9VZk8RshdsXi313N2EhlFtv1qWSXn0hfHdLUWwrgzX0v4
 8Ur660s/P9gTiPZlAVxQ+R8SDSo0RGxy4cj8qi835UxPr8hHqMILbYA63JRbsHYE/d1sph2ih
 VvYscRXtqPx7i0R1xLa9Y0AGEccwgKNoqE98lJdS0oA/v/GH9aOp18YxD7kFvJFzvP831tm0q
 +52hw6USBHn0Lvcwge7FoV1qg59ARPxO2O0duZKLMuIXQzTjqlQMffcTMve8+BFpPJ/bB6dT9
 25u8tRRHHawedMwBYyjVY65df7e7nk6VsrIWWePKMdUfkeuNYuY/8TXqaOzpiJEnHgH9z4pPb
 OoYTe+0A/fofF/VpP71BXrWAWlU843WTlmdEO9vFNYKf30kleKFU/Hm50zjVDCEBr3Bxw64su
 aQombgumEz/NuNivP6QrzZXkhbXfLDY+06H+mhtJswlPrb0USWHzpGrLGSjMZjyQ4XCvc9ih7
 Wyk54yJmmiAIMpmtppYlbbq1oB4ThUI9eOz7CM+6r69wSYfFJx8ySlOgP61I=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QcnN2aQX9UR8HiSKFXctwXfRW2HoldEp9
Content-Type: multipart/mixed; boundary="7nefkgncZdq1U0e1s8sKFQ7t8pBiHv4mU"

--7nefkgncZdq1U0e1s8sKFQ7t8pBiHv4mU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/14 =E4=B8=8B=E5=8D=8811:17, David Sterba wrote:
> On Tue, Oct 08, 2019 at 12:49:29PM +0800, Qu Wenruo wrote:
>> This patchset can be fetched from github:
>> https://github.com/adam900710/btrfs-progs/tree/bg_tree
>> Which is based on v5.2.2 tag.
>>
>> This patchset provides the needed user space infrastructure for BG_TRE=
E
>> feature.
>>
>> Since it's an new incompatible feature, unlike SKINNY_METADATA, btrfs-=
progs
>> is needed to convert existing fs (unmounted) to new format.
>>
>> Now btrfstune can convert regular extent tree fs to bg tree fs to
>> improve mount time.
>=20
> Have we settled the argument whether to use a new tree or key tricks fo=
r
> the blocgroup data? I think we have not and will read the previous
> discussions. For a feature like this I want to be sure we understand al=
l
> the pros and cons.
>=20
Yep, we haven't settled on the whether creating a new tree, or
re-organize the keys.

But as my last discussion said, I see no obvious pro using the existing
extent tree to hold the new block group item keys, even we can pack them
all together.

And for backup roots, indeed I forgot to add this feature.
But to me that's a minor point, not a show stopper.

The most important aspect to me is, to allow real world user of super
large fs to try this feature, to prove the usefulness of this design,
other than my on-paper analyse.

That's why I'm pushing the patchset, even it may not pass any review.
I just want to hold a up-to-date branch so that when some one needs, it
can grab and try them themselves.

Thanks,
Qu


--7nefkgncZdq1U0e1s8sKFQ7t8pBiHv4mU--

--QcnN2aQX9UR8HiSKFXctwXfRW2HoldEp9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2lE54ACgkQwj2R86El
/qj17QgAj3G/r4S90lwNeTWJ2IpMStWmhWmfKMhsVJAMVkLBROWbzudEEAn27qDy
6lwCEVd+yKfTMBtygWLoUX7SK3hJqEFskIwtE3Qht3n02qDwUZFbCZCUSwGQbuck
Q7xNsWDnZlA6o8N3rU6tXPVtO6Spj1mEQsYHC6oYpSoiFM+2R0sp6NA7kuAzYgH0
ZNCakbxhGhmfK+KXvtck0W5HuzKlwmjXoQhp36z5e6iNkjn6KFEeWjNZ8cKXvDH6
D4Ivfx7t3gcHluRKkE2Yd2dOtKiO1SrH+OrkYAtm1Pvzk4LdbzpVNlefR6hEOe4w
0MnGZGzg64st+ihNRLMAxeH4oooJvQ==
=IJQV
-----END PGP SIGNATURE-----

--QcnN2aQX9UR8HiSKFXctwXfRW2HoldEp9--
