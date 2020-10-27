Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF72C29A1E1
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 01:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409947AbgJ0AqE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Oct 2020 20:46:04 -0400
Received: from mout.gmx.net ([212.227.15.15]:46309 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442760AbgJ0Aoj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Oct 2020 20:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603759474;
        bh=R0XeE+GEoN/Jt3Yy8NpC/5/muzNijmEFVfECRKOlq0M=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=B9Omoc3K8jq8p90ZqiyAVs5ojfvNJOX0+JzUvzhP2gAia2+TtIfbfxsULSv+0/bxi
         h9NKIFgbi92ejkdjbUD1mcTJu9IWHQ8Xv1lV8izeIUWJL+lK5ACZl8bVIxTKLTsRXR
         cTItAb0TMeRT/jioeehbmEl5Ba9kYH5NXv9/FG3k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mq2nA-1k1z8d3srS-00nBUY; Tue, 27
 Oct 2020 01:44:34 +0100
Subject: Re: [PATCH v4 01/68] btrfs: extent-io-tests: remove invalid tests
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201021062554.68132-1-wqu@suse.com>
 <20201021062554.68132-2-wqu@suse.com> <20201026232602.GV6756@twin.jikos.cz>
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
Message-ID: <96747194-25f9-d774-3a54-a5d49c108919@gmx.com>
Date:   Tue, 27 Oct 2020 08:44:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201026232602.GV6756@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="j0H4VUlAuvFyTJz1iHnctSTA6zwpJdVJY"
X-Provags-ID: V03:K1:yOa4PkM9zlFE5KXwAXTl8GVFKh29cHonzpnvlMgv/jbxD+09K2Z
 lCuUyW54SwPenXV3Y+QG8bn9/3a64/YhklAN1/Tuy+ZWBAxHak9FmZdLyh705fA8GVDHuCr
 Xoum3wexc4KncPv//7ZGSwhO4lfwsPO95eA2tmgp7z00D690akR+482ZXRjPVSKkhuDSKoe
 JeD87ZmIE+8oai6kU0h8A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mpcc4a+muGk=:pF1sXX/iG6Y4doBpnUWMgg
 XoJ6R9h1NXRnsfB6MoFGEjE6sr6SaH8F1EH/unWRm64OIQ1hMaUDRWKdPNuHqPNTx4G/ss6XB
 u+52poiHQuqvGGE6NNIHjO+f9mhJK0VAoL49uFWlY4t8BJUg/RR84D3gQASxgSCPRAT/aSD7u
 wcyIMsAXjYn60/7nQ+0RqIsalgbixXjD1ImWkEbKlXK1OwxQiMRhYCwDdJ5My6HU9yiWXRkJF
 P5rCwOrvdSNNPXTf8t8HhzaX3yWa4GBW5wczqZL5CKwVHzKFstF6rV4IVoafWGN7FIl2vXRBL
 I1YZrVgmsH39JF71r0HTOy8khNP4PCEyxGkNXPdMsDIEe/pcgX52OAZOHvmIUpLW+YhnKmMpp
 nTH2+9getHFblt8bL9/+UjQoIyt7Viet9LkBOinKWW0EPwUC4LjvNmEIXmkk0X8JWW9rZ8zXb
 ixHfVl0kInbEal0iS2szsLB+L22FK4MDH231i8pgZoyu+jL+qn4WCgfauSxCJdAHNAtcvYy8T
 0kU9Ws7KHrFmiL/pByUeo55KJr8exD+xqJoA/HzUg6DIW6gUvLPOoovbEUL9RhJ6gefpfjxSD
 5wpf9Yjlvu4WoiVyqwzvSNd+MHHA5b8QmK/KdIT4+lfXh6FFwcGSiDONenJZ150fnNwoIYaby
 iaYhsoha3Vrs6lyHcQWoXX9Pq5H30yBS5SSuROI38ZufWsOpBVYqqVbSPrdKIYroRpvXfsybe
 IPl31w3hrJXMLOnpEKJwm/HproEnNFH52+1XigIZQw28SxHElRQXMQW5pCxJTF9vFG3d9wnau
 vL/UjIIktyWPEV0BWXeIy23YfUiAACn+u1jqgQxFSQdV18wQTz9w+aQ3ns1f2a2iotqx9E/9u
 bqv3AIkT4poefiXzD1zQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j0H4VUlAuvFyTJz1iHnctSTA6zwpJdVJY
Content-Type: multipart/mixed; boundary="khyJy9pcUB6OxA1llpPX98hbizfcUr8w1"

--khyJy9pcUB6OxA1llpPX98hbizfcUr8w1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/27 =E4=B8=8A=E5=8D=887:26, David Sterba wrote:
> On Wed, Oct 21, 2020 at 02:24:47PM +0800, Qu Wenruo wrote:
>> In extent-io-test, there are two invalid tests:
>> - Invalid nodesize for test_eb_bitmaps()
>>   Instead of the sectorsize and nodesize combination passed in, we're
>>   always using hand-crafted nodesize.
>>   Although it has some extra check for 64K page size, we can still hit=

>>   a case where PAGE_SIZE =3D=3D 32K, then we got 128K nodesize which i=
s
>>   larger than max valid node size.
>>
>>   Thankfully most machines are either 4K or 64K page size, thus we
>>   haven't yet hit such case.
>>
>> - Invalid extent buffer bytenr
>>   For 64K page size, the only combination we're going to test is
>>   sectorsize =3D nodesize =3D 64K.
>>   In that case, we'll try to create an extent buffer with 32K bytenr,
>>   which is not aligned to sectorsize thus invalid.
>>
>> This patch will fix both problems by:
>> - Honor the sectorsize/nodesize combination
>>   Now we won't bother to hand-craft a strange length and use it as
>>   nodesize.
>>
>> - Use sectorsize as the 2nd run extent buffer start
>>   This would test the case where extent buffer is aligned to sectorsiz=
e
>>   but not always aligned to nodesize.
>=20
> The code has evolved since it was added in 0f3312295d3ce1d823 ("Btrfs:
> add extent buffer bitmap sanity tests") and "page * 4" is intentional t=
o
> provide buffer where the shifted bitmap is tested. The logic has not
> changed, only the ppc64 case was added.
>=20
> And I remember that tweaking this code tended to break on a real machin=
e
> so there are a few things that bother me:
>=20
> - the test does something and I'm not sure it's invalid (I think it's
>   not)

Sector is the minimal unit that every tree block/data should follow (the
only exception is superblock).
Thus a sector starts in half of the sector size is definitely invalid.

> - test on a real 64k page machine is needed

Every time I inserted the btrfs kernel for my RK3399 board with 64K page
size it's tested already.

> - you reduce the scope of the test to fewer combinations

Well, removing invalid cases would definitely lead to fewer combinations
anyway.

>=20
> If there are combinations that would make it hard for the subpage then
> it would be better to add it as an exception but otherwise the main
> usecase is for 4K page and this allows more combinations to test.
>=20
No, there isn't anything special related to subpage.

Just the things related to "sector" are broken in this test cases.

Thanks,
Qu


--khyJy9pcUB6OxA1llpPX98hbizfcUr8w1--

--j0H4VUlAuvFyTJz1iHnctSTA6zwpJdVJY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+XbW4ACgkQwj2R86El
/qj2WAf/RLZjKTpHuKpyQG67bSnxxfHulcOcUE74vo653/FJAuhirD4Z7MuImZo4
3D6iObJ08wf8wo7J51wpT1+D4vnuArGxmSQTQS3Km5USXVZ5Wc7Zntyp+OfGioVz
iKhyEZK+pg628Q+jOSCqN6NL/LypVdwuyNDgoobfBAt8Gv564KMyF/Gmzzwu/TSD
cJaCyuwq/hapTaTQruBoPjzedKl0BqjhGtYpLAweR7/UpFI/58bIsUpUKkjU5aVP
g7+Jvu35/i7muhBWpaMFf0HzQqTj2+PL7Q/pvrY41EYsCkhhqHmi1t2B/PpAeNcN
zUFpQFq2sen0dNB/AtXu2cbODMKZjA==
=HIWV
-----END PGP SIGNATURE-----

--j0H4VUlAuvFyTJz1iHnctSTA6zwpJdVJY--
