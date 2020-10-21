Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3490C294BFF
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 13:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410906AbgJULuV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 07:50:21 -0400
Received: from mout.gmx.net ([212.227.17.21]:44111 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393437AbgJULuR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 07:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603281011;
        bh=zhfr6qVp5wc4tjNTtIizgSh5rt7wIJ6fWdkTTtYeDM8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=SNn31NGLUHw5X6uU2rZsPclaRpICQ+7ZcSOD91hul7XwWQpHFwHvCqE4+W84acXO7
         emviHnIHqCnaotxfyS+RYfRrXQfS8jBm7VLPaLdNuRIp1u3DmxNezB3UpXU+a70nHK
         C3BuPAF3CiYAa8GyDhf75umh6DiPn2hCLdkk3BP0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeU4y-1jxFO72UXU-00aYLh; Wed, 21
 Oct 2020 13:50:11 +0200
Subject: Re: [PATCH v4 00/68] btrfs: add basic rw support for subpage sector
 size
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201021062554.68132-1-wqu@suse.com>
 <20201021112235.GD6756@twin.jikos.cz>
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
Message-ID: <42131791-36f1-8a1d-e254-e8075c4c3866@gmx.com>
Date:   Wed, 21 Oct 2020 19:50:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201021112235.GD6756@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5n50Zk8QbTWdUYD6bk5hVbmJLMi0euEsc"
X-Provags-ID: V03:K1:RP5nYb5uD3uV2222VhfnRdS4tED8WY2EVQtivzRFdFkru2mgmgU
 2w0O67w7QImSa1GzntX+pDWU15G/Ugv2eTloqEB/ap8q2kjcpK2IuEFOQmtnRZZH7N05R0K
 SWnEJhHDLLn49QBDRHRChOLDXDRhtgr/K/MpPtPw30CJo5AIujobGNpuY+BAdmOcnG2KMtX
 gipBL9pcfkJL30rtVavrw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:h9B7u25x4PU=:WXO1TDHQWGDNUOMI2F4IEN
 kukaaGSbxae6s2AfiIalhjKf/vtJFaqBMzJzuHOzmKdjvaV/Fh2U1hNT/K0wDTktyDhBSM+Ad
 ns/Qrp9hTz0dpmkEIlk8Fk7eFqjLPT5aDpw93zQVH714WI1uITeXZ6e17M5CMwq0GHZ1Yqdmi
 RbsjjfvSSHziUnZcIbGlfMDYvap0gl4afXEKWPgcEYWwMByaMW5np9j2K39D7uFqW8DkuOnqs
 7NAyv6EcAZCrzSAX5VJ7OhwDXM0fUhxIjbzlb4bsdWBsfCXAkmNVjtYRNPHZzaQhtRGv+1GBV
 ++ZUfCibFQI95c7DAzqFYCdwHLwaID9gwJa2Te+HnL4jOC3izpDdu5asdt3T/agSmGQsu4VEK
 83HpWt1h8PbWbV399WB6Rc+DViDwSiqk1zeG2ImHpItX/9Qeqw767LXPfdTLAxdwlyl0VJggP
 6P5LrOIl/u6c6+kmNO2k86X6DNWRe+qtaUOCQ4JmIH72ff4nDid0bGzbGpeDPIS35Nbt+44A4
 /3PTzJSR0yb2G/njsYujXkQkwTKArcYXi0sNu//jqWBFNcgrEjvn4Qt1JJHYEHg3wSHIPKPUM
 G4syzenpSdyKm2E+m8npJZlICqPfuF8bIvEaYlD/7eqH1sY8VDboAvUnRqfsnqWMh00pNOA0Q
 ruqai/yRiQYHOEvdiieMpOs3jOxJmJ59vtFlCpMuueH8urtlOgcMKP76frBqsIRDkb7zxX1Dr
 sAtzY2Ipbb4tqgECbHwRqXLp9dygE1Qw9m9c2Cts39fBS6yBO26AbPutHv+NCSZtCPiE02iBx
 AIvvkPXJDEjDmlprwC61vvTvXO1MqMEfGY7kwE+tipmBapSxNF+NH6q3BC1i1UdDE60zNJSpe
 apKe1TkUVkbR0lMOQhow==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5n50Zk8QbTWdUYD6bk5hVbmJLMi0euEsc
Content-Type: multipart/mixed; boundary="VHOc0BaI2Bglnu6u3wyYNVbcheOrMfMOj"

--VHOc0BaI2Bglnu6u3wyYNVbcheOrMfMOj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/21 =E4=B8=8B=E5=8D=887:22, David Sterba wrote:
> On Wed, Oct 21, 2020 at 02:24:46PM +0800, Qu Wenruo wrote:
>> =3D=3D=3D Patchset structure =3D=3D=3D
>> Patch 01~03:	Small bug fixes
>> Patch 04~22:	Generic cleanup and refactors, which make sense without
>> 		subpage support
>> Patch 23~27:	Subpage specific cleanup and refactors.
>> Patch 28~42:	Enablement for subpage RO mount
>> Patch 43~52:	Enablement for subpage metadata write
>> Patch 53~68:	Enablement for subpage data write (although still in
>> 		page size)
>=20
> That's a sane grouping to merge it from the top, though it still could
> be some updates required. There are some pending patchsets for next and=

> I don't have an estimate for conflicts regarding the cleanups you have
> in this patchset so we'll see.  All up to 27 should be mergeable in thi=
s
> dev cycle.
>=20

That's great, if the conflicts are not manageable, feel free to ask me
to do the rebase.

The main conflicts I can guess is from the metadata readpage refactor
from Nik, but my current structure is already using a similar way to
call submit_extent_page() directly, so I guess it shouldn't be too
destructive.

Thanks,
Qu


--VHOc0BaI2Bglnu6u3wyYNVbcheOrMfMOj--

--5n50Zk8QbTWdUYD6bk5hVbmJLMi0euEsc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+QIGsACgkQwj2R86El
/qiEJwf/WNmuHPbgosyj2WhgekA2PNUMBak+krUSldJD35pRYD21JoRzDgNLv3Kg
/pZvAcMX9uVeUFhofNyMD8DJ/YEww4+IR/sKtn0RQGfSWoUDpw6TtEilUGLvunW2
dox2k7WuIkDukLdcRGoox8mcDGu9hTdzZJ1kWLiwUpyvo+T1pZ0q5vQc/q9w6AFI
E6wege/OTiaZpUB97LkbEdMmtJDCqWRvCtwbFQ40odqQiMYOMC8yFThTY8+wULNE
UggSOIgWR7CglSUZDghrP8fdzt8DUKIDBWxLq3lO9NQm2c/9srvrXjIcuinoESx1
83yMBtLCmlVc6Ts+tnUZdfR8wUGlEg==
=ltfa
-----END PGP SIGNATURE-----

--5n50Zk8QbTWdUYD6bk5hVbmJLMi0euEsc--
