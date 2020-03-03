Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C22821769EB
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 02:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgCCBSi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 20:18:38 -0500
Received: from mout.gmx.net ([212.227.15.19]:59805 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbgCCBSi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Mar 2020 20:18:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583198313;
        bh=0H84DvBNM2GKMtA3oCWSLG0w4wBh9kD2BQXFqvHiFNE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=eFcERDsfciRj6VTtBYSEiRlHKmRS+rLI8bTvvFENa1SAJMErCvSWQXI1hZTiHLQhn
         YSNBXaCTt5Y2Km1XWMZB8PnmCsfdB+DlzRzJiuJqrmCtVpkr1OR8bWTliWIqxZk3CC
         0aEvptFjRS6uirYxsBw/I50sQvhvlOw3QdC63Ai0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MrQIv-1jlWsJ26Zr-00oXsb; Tue, 03
 Mar 2020 02:18:33 +0100
Subject: Re: [PATCH 2/7] btrfs: unset reloc control if we fail to recover
To:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <20200302184757.44176-1-josef@toxicpanda.com>
 <20200302184757.44176-3-josef@toxicpanda.com>
 <27afa0d3-e030-b53a-0033-674f13199c68@gmx.com>
 <c6f1b946-6efd-83e9-7013-92f511cdf294@toxicpanda.com>
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
Message-ID: <f2027f8c-b940-9943-7bbd-58d51499bd3d@gmx.com>
Date:   Tue, 3 Mar 2020 09:18:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <c6f1b946-6efd-83e9-7013-92f511cdf294@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EqKbLSW2Q5HPcUueuwvPxm8D80u90kJ2D"
X-Provags-ID: V03:K1:p6SvC52g/6CHWwsQT/2p3D3Q88AU1mewZqAuYSh8B1j2lOGm3du
 iEWqsuI9XV/BDB5kT71uRY4iryN+7ZWETs0FYs4isDbvV5/gd+m09/4l5ml8FU0sTKeFrFI
 PQ0HbDfN5OGMeP+d9nnaJN+fZXIllbrIJlr5H60mzqFzyJY58WSE3t6aEm6Iswqwu5b0xKM
 C+OGPKmeHYu+ZiKzutCng==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0TmPlQ2sgGU=:pTzQFmnBXMOETK6eD2mwi0
 Gq7PuWamK0hQoJtJAlji/c/omCzouOu89mw+6J4Ez/kWLP09LUxtuESaLolpKyzzyfgwWbMXg
 hKFj393LKj8NyfJv9sGmiQV4SHWuaazs7sEuLIbU7OFP5LDmkw9lGnkgBt3wZ7cZac7Ik0nux
 vLspWckzFkVYLFWPKjc+7bPae7KuIAHtmr3WEmim0sGKc9fgBC6rosq/nmQ9W5RRR+cy2gWQx
 UhSDY7tHxDwKKEmRO/M67YJB9+UGIKLPCxcKEyl1JF6a6JrNhmyXhbBIn19EQCXhinI4WA60r
 45ighTuopZo+VL7+Bz8jkcwELAIJhIxMp4u7DvzSaO0yVzRChjUoZgN+8dUw4eNoKOojpKqGM
 mfPk61AJyaKYVVsIv597nUiybVWW1N1bp++8XjLtMbcAt7osOvJCRI/gaAGH4hMk7tczje1eg
 +vtodE3ydhUoh0sQQ1uueEakLr7KQF4F5jaNoVNwji2Q6Bo5f35hiTWUkQSCS+CRQFCCCsfHh
 nbuEm+I9ZUJG3yLcNlc21+EuaxhhGhLJHPOXOxGcBnEZBFhEu8Hj9zFccV6QU8PBAUHqkolPv
 FZxZtryUnjWZhkPeEp2CYA67Qns7//ZgvKQ2OP9XhtcvlxfPQO05znG+4a+CI9NlJpJBPm4p3
 vCXnk0cD+xggws9+oke1C4ztNK1smfsjAkylzLw4oSNNKf95uywCfEk7P/57XlrDQS44i72uQ
 k5XKK3BhNi/LtfU7H/i6g5A2lZ6Pa3CHLYVyYSFKH4s+YUn94cS1izOE5/A64gmTo5fkhu9oO
 aReQDi8ESwX5diYIVpsh0y1604ptCIApMLa5MaJxWVt+lZj34u9gRYCcTV6Sfquvk4RheohzK
 zaUvOXTkMouKuDTINKr+RpL9LcixwzRao/M02ddCde2kak+MNli0M0DH1M/cBXmdkQHKa1pMS
 paHrYQYW2VuYbDx9/7R/hqktVU3d1A1L64KIfaKg0G0SqqhVKklR9zIH/IauuPx+veLz5D4W1
 fGgKlEPtvebGrLjbbxPyJhKsWCHt6FEw6Ci0XGOVkBTteTQmcOkURqGxs8dZOdKmnQWB+Ry1y
 zTxUaM8xLnodqHjY4Nx3T4kT3xi+La2NqdjpxG9wiezOTcneu9H3AB64URx4onFdccShyFJIt
 26oimYESZAllEqVXUCM5scIBnhZDT+Rn2dFNhExkzHpQJASr8p5Vkacww73OHT2cGzSzL2XAd
 YUq0bH3889L+n08oW
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EqKbLSW2Q5HPcUueuwvPxm8D80u90kJ2D
Content-Type: multipart/mixed; boundary="r9UrvePtu6p9TuauZaiGh6hUE3dvmPnVX"

--r9UrvePtu6p9TuauZaiGh6hUE3dvmPnVX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/3 =E4=B8=8A=E5=8D=889:03, Josef Bacik wrote:
> On 3/2/20 7:58 PM, Qu Wenruo wrote:
>>
>>
>> On 2020/3/3 =E4=B8=8A=E5=8D=882:47, Josef Bacik wrote:
>>> If we fail to load an fs root, or fail to start a transaction we can
>>> bail without unsetting the reloc control, which leads to problems lat=
er
>>> when we free the reloc control but still have it attached to the file=

>>> system.
>>>
>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>> ---
>>> =C2=A0 fs/btrfs/relocation.c | 5 ++++-
>>> =C2=A0 1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>>> index 507361e99316..173fc7628235 100644
>>> --- a/fs/btrfs/relocation.c
>>> +++ b/fs/btrfs/relocation.c
>>> @@ -4678,6 +4678,7 @@ int btrfs_recover_relocation(struct btrfs_root
>>> *root)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_root =3D re=
ad_fs_root(fs_info, reloc_root->root_key.offset);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(fs_=
root)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 err =3D PTR_ERR(fs_root);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u=
nset_reloc_control(rc);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 list_add_tail(&reloc_root->root_list, &reloc_roots);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto out_free;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>>
>> Shouldn't the unset_reloc_control() also get called for all related
>> errors after set_reloc_control()?
>>
>> That includes btrfs_join_transaction() (the one after
>> set_reloc_contrl(), which looks missing), the read_fs_root() and the
>> commit transaction error you're addressing.
>>
>=20
> It's already doing unset in the join_transaction right after calling
> set.=C2=A0 These are the only two missing paths.=C2=A0 Thanks,
>=20
> Josef

My bad.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu


--r9UrvePtu6p9TuauZaiGh6hUE3dvmPnVX--

--EqKbLSW2Q5HPcUueuwvPxm8D80u90kJ2D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5dsGUACgkQwj2R86El
/qiEbQf+Pc4DJMMU28VtxO6CHep8i5tKEdvA19HQreGZo8dY2DcM2p9ftdzzCOi+
3EFX3jMptUk0zQfvL9EkhQ/98l3QwXUebuHEEwjiL+YxVVy0LY5unutABXOXXCOB
T8n5mTeWZBUcKRmH877GCYJNrQCqs/01gQTOEFRYtY2zr+k66a0WXmvwUQMaBinY
aSSwskVg1MDW5eeYTlrB37jINgg4TzQ/bbFcr3me6SnuaUwFYcTeiy3jqMD9wJh6
UqdA75Od3crKKdAOa4+YrLcrF4NB18CajEJ0ry7/uCcB5qIIioJ5cGH6519dHA+y
QBlwMej1hQsjO2ADvRjJvm1bNDV7/A==
=QTFZ
-----END PGP SIGNATURE-----

--EqKbLSW2Q5HPcUueuwvPxm8D80u90kJ2D--
