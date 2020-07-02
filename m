Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D842116FF
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 02:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgGBAC7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jul 2020 20:02:59 -0400
Received: from mout.gmx.net ([212.227.17.22]:42557 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbgGBAC7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Jul 2020 20:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593648175;
        bh=JuMYDQ/jHy7fdRSMiubkFbszf1Cl164GoWiH80oNnPE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dUOYgVleidGtSXoNbf5zt9PAZ2j9HH/D+F8WnvEsU2NeEQ0AJ+kJGp1OLQtGFLe6W
         yRe1o9rqyxvIG3LOyWInMfzUQb08/pY4TzMJr4JtY4OvKxMzNtGsnHx4O6LZnOBko/
         VM/t4hoRCjzo1YV8BbCTFE1qatSiiVNmzkfNTmCU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOREc-1jS8250A98-00PxgK; Thu, 02
 Jul 2020 02:02:55 +0200
Subject: Re: first mount(s) after unclean shutdown always fail
To:     Marc Lehmann <schmorp@schmorp.de>
Cc:     linux-btrfs@vger.kernel.org
References: <20200701005116.GA5478@schmorp.de>
 <36fcfc97-ce4c-cce8-ee96-b723a1b68ec7@gmx.com>
 <20200701201419.GB1889@schmorp.de>
 <cc42d4dc-b46f-7868-6a05-187949136eae@gmx.com>
 <20200701235512.GA3231@schmorp.de>
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
Message-ID: <25e94ec6-842c-310f-e105-6d8f1e6dfdce@gmx.com>
Date:   Thu, 2 Jul 2020 08:02:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200701235512.GA3231@schmorp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ErmmCO3i50H85GcrD3qFSvmcb6yPE4gjP"
X-Provags-ID: V03:K1:IXzWCFw+YORAnd5wjBNg9JQtmV1l2fDHPg+Nw8JOxD/KFIetBye
 ehJbtvenNZat1YoARy4OnU5coTmDfLdRB//J1Gi2u+kxM/NDVmh0Qi90n1sc6uiEeayW7nT
 1aEAG57W4bdMoi1qo4jWUNAcVA3408gJMxILICUKiWwR3AUQkTfN/tF59lCkSWr6lrlaK4q
 tESOfxSW91Zzu7U/thQUQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fp3Zq7JEOcw=:ffVUSVYHFRK+kXtGdCixTq
 4uSdevvP19aiInyjIjp/xkvL7lzHryQ7NVXTW0CAcngGkidE15u5kXKYyLhA4ZG6cUyO/V3iI
 ryD5hSwE3R9BTO283RmySwwtc+fw+q1KUEDnja7zX+we7FzR0b1GkIRqPkw7u5/Z8qxM8WFOq
 RXX05bTJFET7+goILnv9D7VzQ+fm24/fUrn/nEKpXVM0luQIOE5faUbGpPq20pVN3RuTiuKyC
 FMrk/rM+4+LMG41ggbuzdJGJj5uZ59boopqqXXYN2QYiXy76ljuXlnTHvfsgsELmuM0OTIArq
 /bD2MQKlynQjNpLzOMGmkX6PR7iy0NqJVGArgTEJcWezpnrW0QcVDUbbpLeB2K6kbGgf6PeY4
 IzOGTP6vJ1jPaJzNGKE0L3SEhAsqk4v/bWpWIlv7J8BKXFgf9VSgJIval1aTgWwpXASINjfPg
 qhGvS0edkgbVVQ8WmZ8KLdP3Fdq+sLeDG5L6SWgISlCKRHPebwK3IZJTipaOXJc3V3jBMtK01
 Vn7jWCvlJgnk+KJupdw+/b9ifejxLMX788v0Y/Dor9v7y+G9EQrLEajbP0DhfCHvtQoRi2ICU
 Z0e1L1DTPo2v1Kt1T6Ee4hxTbjNBHK7yN2W68DP6C/Io7AppJcQrBB6kfE9r7o2XFX36JH20M
 WFD3Rd3294Hmf5P6b+LZ5TY5qQSfJe1b4n9shB+dAf1ssUd149ZsoMUZw7mFT9iw9SDfggtrS
 ju7XW0ZZtv45eln4lDOqtj9+IBUfvi65oNaA/SG7bUsZ/1xJPDrYAuEznsWEqy2qJ+8HfCr7x
 YN9KVNxv0S680vRyLGif1kfevz++94OXpsKL3WFoyaPgT+sC8Rz1unVfSn8aS02RfMlETT1Zr
 WKWwnhNXKNBwlr6fVND188zh7JU9Ynw1NfdFvxw27OGRbqDqMYicVpKIVQGUIbXfaa1j328gK
 nQ279ES/iKeq6J6uQm4PVwwYPFTV2UH+/r028JAQro9KPxpMGRTPnWPg8s0zdzWnuMD6pozpn
 RWvhn0QqKRFRRBHi1FgFlWY7zA03Vy8FCOdUq8wuK7X/+MQPEzWGbPPO/OF64yA+xob5fwVtX
 GIariMn56e0R1n09pl314ibajWrlMsF70f8f9ASNjrj+BdW3jpWW2FrOFdgRT6DMZfi2ZJ7iL
 JTqXDfd+dVoSDcAKgRvM3dUfqL5U5SZt9fWlR7CQHh22iHWGzitqj4FyTvYHwJqV7uiO9aTCZ
 xjPEyLSadUJ4WDKMT
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ErmmCO3i50H85GcrD3qFSvmcb6yPE4gjP
Content-Type: multipart/mixed; boundary="dAXEW7nCeMNPBv8V1ZuBfJkvFUmxWtoFk"

--dAXEW7nCeMNPBv8V1ZuBfJkvFUmxWtoFk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/2 =E4=B8=8A=E5=8D=887:55, Marc Lehmann wrote:
> On Thu, Jul 02, 2020 at 07:45:07AM +0800, Qu Wenruo <quwenruo.btrfs@gmx=
=2Ecom> wrote:
>> On 2020/7/2 =E4=B8=8A=E5=8D=884:14, Marc Lehmann wrote:
>>> On Wed, Jul 01, 2020 at 09:30:25AM +0800, Qu Wenruo <quwenruo.btrfs@g=
mx.com> wrote:
>>>> This looks like an old fs with some bad accounting numbers.
>>>
>>> Yeah, but it's not.
>>>
>>>> Have you tried btrfs rescue fix-device-size?
>>>
>>> Why would I want to try this?
>>
>> Read the man page of "btrfs-rescue".
>=20
> Well, nothing in there explains why I should use it in my situation, or=

> what it has to do with the problem I reported, so again, why would I wa=
nt
> to do this?

Well, if you want to go this way, let me show the code here.

=46rom fs/btrfs/volumes.c:btrfs_read_chunk_tree():

        if (btrfs_super_total_bytes(fs_info->super_copy) <
            fs_info->fs_devices->total_rw_bytes) {
                btrfs_err(fs_info,
        "super_total_bytes %llu mismatch with fs_devices total_rw_bytes
%llu",
                          btrfs_super_total_bytes(fs_info->super_copy),
                          fs_info->fs_devices->total_rw_bytes);
                ret =3D -EINVAL;
                goto error;
        }

Doesn't this explain why we abort the mount?

>=20
> Also, shouldn't btrfs be fixed instead? I was under the impression that=

> one of the goals of btrfs is to be safe w.r.t. crashes.

That's why we provide the btrfs rescue fix-device-size.

We don't want to spend too complex logic on some already screwed
accounting numbers.

Furthermore, a btrfs check run without --repair may expose more problems.=


>=20
> The bug I reported has very little or nothing to with strict checking.
>=20

I have provide the code to prove why it's related.
Whether you believe is your problem then.

Thanks,
Qu


--dAXEW7nCeMNPBv8V1ZuBfJkvFUmxWtoFk--

--ErmmCO3i50H85GcrD3qFSvmcb6yPE4gjP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl79JCwACgkQwj2R86El
/qjt9Af/Z08X3JFLVpBdcDKCjC4lGBAqIrz1TUHi4Rkbmo41Z6MYhCQLB4qrN0kZ
ZfRCWk8ZBymo9Bx5iCvzxC+9rSjo+KiCA3t0Cf0OPDj6AhDRbHQ0MdDnTUbzStb3
1rx/1xrP3fwbVUIBY+PbPAYvkJw6fHeRsffNjcABhlHKMXn3R3K7WQ9k9TEu9a1U
uQf1zDGxdjkocaKn+vKO0ZusLxD0vKH12Qem8y6NeZyHU7zkz3CZgxTX+wZlylON
QTBodQGiYHtndEtSLDh0y+fiwDr3va1aJ42VSLCSgsKiKnqMK09nFD0p+09UaHCy
8VYVgCs45U6KPwH76ESLC0XbRpTfyw==
=ZC27
-----END PGP SIGNATURE-----

--ErmmCO3i50H85GcrD3qFSvmcb6yPE4gjP--
