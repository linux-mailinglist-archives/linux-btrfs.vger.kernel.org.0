Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7CDB133B40
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 06:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgAHFgv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jan 2020 00:36:51 -0500
Received: from mout.gmx.net ([212.227.17.20]:40799 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbgAHFgv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Jan 2020 00:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578461806;
        bh=xtPtPPeBfWKZ+2blNtuevmwVoK5dcPLTdkh1zGPMQxw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=XKBCjpYmWVPUeDpdzjyyByyWhPeYL0Y+US8RqJHarN9YQCKR7f4YroY9WWhak6kQR
         3sn1Djh0v6UnRUnqnQAj+yeYJgLltmZjvR0nfzW2TDJOkA+i+OZeT4zt0o2cuoANQK
         2PTavEuSwgWYXbn5tlSQ0NRzwt/9OqPbMnHQ8uxo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mwfac-1jeHnb2iLa-00y84R; Wed, 08
 Jan 2020 06:36:46 +0100
Subject: Re: [PATCH] btrfs: kill update_block_group_flags
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200106165015.18985-1-josef@toxicpanda.com>
 <4bc7e4f5-c370-4e0e-405c-5d3aa67f95b0@gmx.com>
 <5d39b16c-627a-1472-2d4e-d6861ec03c8f@toxicpanda.com>
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
Message-ID: <e834edd9-c9c6-54c7-e84e-bb26e510d7e0@gmx.com>
Date:   Wed, 8 Jan 2020 13:36:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <5d39b16c-627a-1472-2d4e-d6861ec03c8f@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BeCLzxNzoCrJRBx4X3gycP6OFZspj15Cz"
X-Provags-ID: V03:K1:VMGDJcxC+9lSyc/6p143YxMF8THL93cRcnbrLJoKPp4VT0CMcPd
 oZsFE3NPO0M34GW6GqXG48tw2jQBv1ID2cAs/YspyEeNZNFMFGWEZhh7il19xH79qMOLP8J
 vplD2Cem5wV8knhlgUCgvuBj2H/EYhD/EdeavqfSMGxBeTY/R0Lv+aFCp+X49Mhc3B3PMg4
 N/Bl6su0NwYLDlCX/kVww==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:obdCrco+OXE=:JuYNpJFY4Mih6UT3psNSIh
 IdpS8jEWmGWi/k7ipJrk0XFrXZokfM5AY7qNrnJU/NVWmNxROFdJDdFAN5KDNDh86ieKNtcXk
 0a02i++vDP4G+uOJPdZ6t0hkP8o9maVrbsc3toP4NU2bPDVVjMZlII/bOCXORlXefxn9zEgz6
 XJ+7VWQn5L8fYyBdd7fk09wqwm+1hQePPIS0S4XpwZ5MzSvRyItwFuH4+lgan5uZlH0DKnCU5
 x3L99tFE6+ZsDDlZ4IBcnqT1eaA+efvMPJBEXV+2NcCsBc7RspLsHhkMxoX7CUh5+0sPxU7wW
 9jEYBgLZn/8v11pX/rXd1TUmtO91sBX1HUoMjOaNpzlrKqkC/7BEqNjgACCb3ir3iJmN4F/tZ
 JdUgcJQSH3vC+saOfwsf2wUoyxrzumGLtq//yA0l0NAHO9kD/rJIWbd/Zd7nTaaZghCOqVDUz
 99Qjw0h9sRtr0dYJIOBw7lwevRWUiCOAxmTeFOoCo6sIWnkMmyMR2Mz5voaQOBP0h81MDd75q
 yj5kFwtK3ehtiTv9swl9hGxo7KtJB7CPw2Jb0gFmFnv7dNvvDFKvJl/3D7qxxylsyw8fERuHC
 CPOC5H9JQ0kI0uuyTJGrCmMvsNPEZZCRd4xW1M2SUPr8x9YovfNKmrSRrHl/YiIeESU+HLfVl
 xZLtP66E5Q66zTF/+YjR+vubx0mQHTqGer4ViT0ojE/c74fMCVv/CiLIrwNKZ+r6Wt/MK/c0b
 rH7dZpvh4cpqo3cKOPTNmQJCUv9zC9qS9UZEMmnJRg31aDel4pvaLSK9UTQ51Z0c8BfsBZX8B
 YAITXAaVca+ktY1ubKI5YpA60Nk7F1Hc4t9arvEaycgpAPqU16SrlQ2jACQio0nHUj/YscpW2
 ZaUoD/LVpdHAAHCfev35/CsCx8zcg+riqjl969yt2Pa/9AeEcAX9OikhRd9ijY0CC1Oj6kK61
 7eE/9rkiluom+tmEwlgfdJcixLFkL7NIwv5qB1rezoYzAfcVFjJr6YTLI5llWjo+iDVUq3PJz
 OZ28W4qZWrk5BoExfqhdpE0j7onqJ+TT7qoJ6sEQRSKxaCLGxoQZfVvKpERz89C0MHL9PtIIa
 GrzagHNNMI2l6hY2rDkL7bmSql1ysYAsC9UnBbNQzghPl/cUnX+JjjckO+P8t9VU7J9jYF8ef
 8jHNAMTD3rn/7QpZ632DiZv7am8QKOtrjW4Rf1VbTnbhJq+GRg0G+A7mU70kL8l4hXIyEz+5a
 +d6ytjAM3on7NG3jV+2Ty/3nbkgQGKnBXcOTABqPq63/pgGHRah/usNlOol4=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BeCLzxNzoCrJRBx4X3gycP6OFZspj15Cz
Content-Type: multipart/mixed; boundary="HwqEzqnSasKYTgfdPssGrMMEvTkokpvzX"

--HwqEzqnSasKYTgfdPssGrMMEvTkokpvzX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/7 =E4=B8=8B=E5=8D=8811:09, Josef Bacik wrote:
> On 1/7/20 6:08 AM, Qu Wenruo wrote:
>>
>>
>> On 2020/1/7 =E4=B8=8A=E5=8D=8812:50, Josef Bacik wrote:
>>> btrfs/061 has been failing consistently for me recently with a
>>> transaction abort.=C2=A0 We run out of space in the system chunk arra=
y, which
>>> means we've allocated way too many system chunks than we need.
>>
>> Isn't that caused by scrubbing creating unnecessary system chunks?
>>
>> IIRC I had a patch to address that problem by just simply not allocati=
ng
>> system chunks for scrub.
>> ("btrfs: scrub: Don't check free space before marking a block=C2=A0 gr=
oup RO")
>>
>=20
> This addresses the symptoms, not the root cause of the problem.=C2=A0 Y=
our
> fix is valid, because we probably shouldn't be doing that, but we also
> shouldn't be forcing restriping of block groups arbitrarily.
>=20
>> Although that doesn't address the whole problem, but it should at leas=
t
>> reduce the possibility.
>>
>>
>> Furthermore, with the newer over-commit behavior for inc_block_group_r=
o
>> ("btrfs: use btrfs_can_overcommit in inc_block_group_ro"), we won't
>> really allocate new system chunks anymore if we can over-commit.
>>
>> With those two patches, I guess we should have solved the problem.
>> Or did I miss something?
>>
> You are missing that we're getting forced to allocate a system chunk
> from this
>=20
> alloc_flags =3D update_block_group_flags(fs_info, cache->flags);
> if (alloc_flags !=3D cache->flags) {
> =C2=A0=C2=A0=C2=A0=C2=A0ret =3D btrfs_chunk_alloc(trans, alloc_flags, C=
HUNK_ALLOC_FORCE);
>=20
> which you move down in your patch, but will still get tripped by
> rebalance.=C2=A0 So you sort of paper over the real problem, we just do=
n't
> get bitten by it as hard with 061 because balance takes longer than
> scrub does.=C2=A0 If we let it run longer per fs type we'd still hit th=
e same
> problem.
>=20
> In short, your patches do make it better, and are definitely correct
> because we probably shouldn't be allocating new chunks for scrub, but
> they don't address the real cause of the problem.=C2=A0 All the patches=
 are
> needed.=C2=A0 Thanks,

Indeed.

Then the patch looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

And thanks again for fixing the missing piece of the unnecessary chunk
allocation.

Thanks,
Qu

>=20
> Josef


--HwqEzqnSasKYTgfdPssGrMMEvTkokpvzX--

--BeCLzxNzoCrJRBx4X3gycP6OFZspj15Cz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4VamoACgkQwj2R86El
/qhItwf/aBL9dmpIOS3Z3H4B+/fUWAyiFw6oKdSakWAlHb1lhBICxqPqBNeRUFP2
S+7XezwUucHnVHPY+r6YXHj8punXQiuGj62ZepqXbRtjIpKfcE4a2WawfQpeS5xl
oUZnpusElXCgQysJn967Ib9NZqz2owJKvtbmPjiT5U6ZQG3mnaGU2BrJ2CAirOpN
Lm7rRZ196+CzD8BApQYdsrcjBB3eRzVukGnQaIbAkwAGX9SOuWp78OcgIjRTCs58
jZgmD6Tr1lurKX6YDOceAupFUcf/ddku0653tgPFnuq4KLn1/gz9Wj7mxzu50M3I
+MWNp0Q8aBt3TMxjTmDlu9D8qU9ouA==
=bA9v
-----END PGP SIGNATURE-----

--BeCLzxNzoCrJRBx4X3gycP6OFZspj15Cz--
