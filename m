Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E90414012C
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 01:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733284AbgAQA4R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jan 2020 19:56:17 -0500
Received: from mout.gmx.net ([212.227.17.22]:60671 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbgAQA4R (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jan 2020 19:56:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579222548;
        bh=zh3hmkRqbFZ+K3rxbZ20whLaQS46R3mMdELYQ8RLGuI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Dw64TmeAezi6y2SwN8xAEv1kFSfYIPKFTL55zZl40GmijdKeYWe+QpiGULXpH8cFb
         W10eyAlVxC5OEmpDZkiriwmJQBIYZlJOfg9lhA2rddHyQeCJXzGsdhsYu8Rsf6h9Wp
         KC4OXINOEGN6Y/Yg4gQzkpBSehZWi6uH+IvNy9OE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MA7GM-1imFOI018s-00BgNK; Fri, 17
 Jan 2020 01:55:48 +0100
Subject: Re: [PATCH v6 1/5] btrfs: Introduce per-profile available space
 facility
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200116060404.95200-1-wqu@suse.com>
 <20200116060404.95200-2-wqu@suse.com>
 <49727617-91d3-9cff-c772-19d7cd371b55@toxicpanda.com>
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
Message-ID: <3818d217-b64a-5f44-c80e-c49521bb3698@gmx.com>
Date:   Fri, 17 Jan 2020 08:55:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <49727617-91d3-9cff-c772-19d7cd371b55@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wtO20IL6u9u3HvLXRTGuuqhQjfHZoJIjI"
X-Provags-ID: V03:K1:JTqKRBo9tHB8YR/Ftx6m5mnbNFfKE39HUk1HuKB4kZy5VPFZVaa
 f9mRNzVfyUdxfccdgktnV7iTMP8goDdZYyoApSRxjSffW6rCbYluDDbl9LIPZ5SzWbEx9bq
 7AVWin1MzBQW2+uNDk8T/WmqCR3J55jQ4qH5aorrUgYTVKOyRvSLqNW8qhy/U1pqPJmGGbo
 08upnLz0giC2LTxdo9Vsg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UfyXf01Wpjs=:y4XaLv2+Td3jW9gEUJYh9V
 gsunl4P5mGuELU+SPFUg1oUL+lD8CtAdivfhBZ0UjUnobj4hY//IrxpBmLRpI7z5Fpehk2+O3
 8aCvFMAIhG6cjfYh5BXXMSNlH3na7vam1z6UywVJzXDhuSIOWsHG22mZzaWOL5p4hbsVwKeVe
 xU1qWC61JCg3YLK/WKVXXJLatUwFmA7+FX75PvaI9dQ99jwz53/DYvMGV89HkKpSmjH07jx6I
 DfXwP7EY0auAGxR9fZbb2eZmuysGimPoxabDoZMQiPysFghcdpK8YZApxY4oux8p6QPgaATtf
 pjNGArm/h2WLJY+u/+Wj1HAZ60yXcq9pAOTevD5tlByrPHIxxkJGBc6i3LZukbGihWMuYrd47
 5NBdQAjqti1HklgbVJN1A21OPxXOb/llpBV3wQEcaQdEMBIMQQIoJtv+rcQIimsmWzWzWxN3U
 wDDR14KCPdrIN2Ml5ZGlLUbk1hYMTHC36gOZvYfR/3h5rdo1LvhKTbXtHO0jvqplRDHkJb+S6
 IVa5F38i8c4/wd89Us0ac7+DWpGbHeWueQCAv8VMM2gvMLaQ3fw5qUeeBjlVRZZZgC+AT+1ud
 jYJfu7zH6vE+4EGYMcb0jV5ye9tmUq/ZjX2AB0FEwek4af6XCBB9wH8Raea3eyKMtHNzTz+7W
 TGh1OaFML6A0W382qRoMEI6JSny+w1vHwxZ5hl8IVx2j8XN7VU0gfsmz/lFNrDnnheErU8DUD
 CAeTkeKW/ikVzBemuZ/vOjiHJA9Hw9AsSog88Qf70WNEiNuOEF4fnzLj+QshFiqgxc1myt+L4
 vbS3Q7tsu45Wi985GEShwuwVxxXJvoWccLxNp8WBhV0ngAWMBkiJM3NW6QaBXskbyBtUr08Oz
 y3y/Ppa5zcbKf7QBkzwjTXZitBuPNaFfixVdm4Ag0N+LVOgmqKMw4+xQdq2XT3cmVHdRIVakN
 rRNw5jseuaqQMsXfluKb6NfPEUYOUxUsrkSOm14QZzZOjtwNA2Fctuy3uo0hhH5AmYaqZft3D
 qDr5ZvNgUZD+Ft4MuFM8EThQQwtVuOPtgDQ8cq4qq5mXK/BBTRZ714oM3Z/PYQwIg934+g3iN
 pBR9JxMOcGXMEPNBAyvvCUcd+p54AQYWipk8QHRAomvE8EyNRCuAJkcgarTc8UcJeTVax9XvX
 AleQrCQUYcn5Cl9VC1DVgcC+lUltIryjQzejWhW7MXLZsPjrf1eAcahYY4YDOE56eorsIKnwn
 WiNqg0KSeg3KnUHtyyr1YyAjsVP700l4ieg3O0DZr/mWvT9njc9BfO8LEeZ0=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wtO20IL6u9u3HvLXRTGuuqhQjfHZoJIjI
Content-Type: multipart/mixed; boundary="41owY9XmY8lOTjEGJq4Iow8zikXnrT8jz"

--41owY9XmY8lOTjEGJq4Iow8zikXnrT8jz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/17 =E4=B8=8A=E5=8D=8812:14, Josef Bacik wrote:
> On 1/16/20 1:04 AM, Qu Wenruo wrote:
[...]
>=20
> Instead of creating a weird error handling case why not just set the
> per_profile_avail to 0 on error?=C2=A0 This will simply disable overcom=
mit
> and we'll flush more.=C2=A0 This way we avoid making a weird situation
> weirder, and we don't have to worry about returning an error from
> calc_one_profile_avail().=C2=A0 Simply say "hey we got enomem, metadata=

> overcommit is going off" with a btrfs_err_ratelimited() and carry on.=C2=
=A0
> Maybe the next one will succeed and we'll get overcommit turned back
> on.=C2=A0 Thanks,

Then the next user statfs() get screwed up until next successful update.

Thanks,
Qu

>=20
> Josef


--41owY9XmY8lOTjEGJq4Iow8zikXnrT8jz--

--wtO20IL6u9u3HvLXRTGuuqhQjfHZoJIjI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4hBhAACgkQwj2R86El
/qivMAf8CHJpKkHb9ARxm8AUlOMYlw7iFxMl/l8/RREctXV1u/DZs/FM15F4NcIS
OLJW4B+lPgNGgGB6pBMMFvSNKqe3CnnJs/fr6+VdtlSnX1fC3EMY2qLRaFs1ai2/
nDaKEw3nX0OnQ1biCHdAlf5uOVWoKKjaZ33qjgSw+OtFfSuVUK0P45vcnQJH2ZQc
o3jBPkXbxBOCNCUvCOnUej/BEj5fuUl+o+GHuI2oFHL0fqvDt1Mz6DvLziM78T3p
gO7aGHRAsw3c22p7jY1chilOJDUL2UiCYkkb/4lH6FT0QwpcT2QoriyNnJnMFp3/
gLGTILAVVVicNKINfHAOO+NwRGpSKw==
=nmVe
-----END PGP SIGNATURE-----

--wtO20IL6u9u3HvLXRTGuuqhQjfHZoJIjI--
