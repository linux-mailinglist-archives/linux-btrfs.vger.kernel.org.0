Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D222736C4
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 01:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgIUXsM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 19:48:12 -0400
Received: from mout.gmx.net ([212.227.15.18]:48755 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbgIUXsM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 19:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600732088;
        bh=H9E1UxozrNLmRvoeQQVvO0/LuL4Y1nUjWyUGmKkCpoQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=DiKLX+Iz63X0ZA+noPczY26u41NPLmNc2hg+Zs/QTZTpZ3jMLLbpmHKJeKkbs3ywW
         +7TNRHQIAU7M+CBEUPE71+G6VJGTZVyXjF2U3stM9UvoWymglwEqSuBkko4kS3eCzM
         Wc52cC36L9o/u7KkjOn0QJWkM6+5fl0ylAw5ZlXM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N3se2-1kTTjb1CRk-00zktR; Tue, 22
 Sep 2020 01:48:07 +0200
Subject: Re: external harddisk: bogus corrupt leaf error?
To:     Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org
References: <1978673.BsW9qxMyvF@merkaba> <4131924.Vjtf9Mc2VK@merkaba>
 <8d2987f8-e27e-eedb-164f-b05d74ad8f3b@gmx.com> <8020498.oVlb7o6SH1@merkaba>
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
Message-ID: <f0fd36fd-3ffa-ff02-e5d9-265fc64e38f3@gmx.com>
Date:   Tue, 22 Sep 2020 07:48:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <8020498.oVlb7o6SH1@merkaba>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OfePvZoNYmnQ97vALCoQb2W6e8TsPWXAT"
X-Provags-ID: V03:K1:dXWXJy6LoWTX4inLDpSd2DEGXunourMg4WuvSZxkldN5B0eq/P9
 9BbFlD8JNot4Xov9lMKC6Z5E/hSh22pgV/j/oBOP71JgugzkkDA91qKGQgNHVCU7W4OFlM5
 a/cxZM7yPNvUrl433Qoe9ybfXi9QcsNkP9mXfXQqVzeGEVKXkCSWFXy7Du59N3q4jCGsQL7
 GjufUHK32qucLjRekB7DA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BB1rtA8Yxq4=:/SRKQZ9oODo7U/jN4FM5Xl
 p6nA3x5jXO6iT2JTEG+2e9xpEIAXFtf+1H6PI3yNkNX+p7uUN9Y6s7oz6oqAXRmM+LXZgofAE
 J3UYwGBrXnvHNr4aHLiDYKm7xvyiN13AQ2VvdyREpaqiXnxvMq1VUd0U/jW1nEfkU/Tw4PZEb
 65HZMZT4jgANFxOzsYvR4siXjNcHTOE9/DX8PF/gNKEjra1g/DZVmXHqKk+yHFyUzX/yPrl+J
 md3gcadG9aC7wNQhdICKKF+hlcOqnBY5H27PaqoFTzyL7Zs+Ke+mva6hS7w5zXDjhNYuYGTOF
 TD665otPIHfapT/FpNGQEs2TBYAi65VAzu+hk5oHf10ycb/EJXUGmtHJRkPP9JVjKXY0qZKyj
 xp7r+hERKSZx5HgqyxtX/RHCsXOnp59lZWw9v28N/NzUZoETwUg05OKFbeask1ur5Yhb3KMnQ
 6Kui6YBbEeGmVgBSdkT1BIui/8ZHBlSZVGvyCb1q9tzzcO15+/lakR1r5wzhdUCoiCx5sidXL
 aooRARUT1eHnN50Xg0/Mn/nLdxGXACvBrW1x3T9VfDffld7nm2mpWYyLvadARnWkyRNXi1zGr
 m3+MGOYelZBlXLgU/EpIFuMw808Ty9hs82waOAgA3sU/UrH1NI1g8NJUwwvDM7U3eljWMS8aA
 LBI1qkcBmEfwkuGeYiof+jGnlSzwdUe7ZzK/Gu/jnO+ThY298ioCHJ4sV2obZEJc7UXbIku+7
 IU1lzXNqdUnt7zZwmbyoP/oVpn5Cu/8oBRuPPzlEAjNekjMJEJj4+VVRLNcYfv2crjpKns97x
 +5QiunS3AOx/6BhnEIIadBZx7FeEWXBoXi97rrzzmRtM4Ccm/+UDIgkX5QBqRML74A5896k3O
 afQwxn72aYj4nXnY88WQOd1fOnVqKKAa6ctcjnVXWBoDL9p9yNN5jgdC42hfA1VZnYYITGKsS
 NDY78Vz0plicCcWpptX1ilfkUkDN3wcSC0z3kOJxT6+rJuA50WjpidfxhoELXEXc+VGHHhiGw
 eIObOgPcHHrCJnfSB/1CdQQBm5AJ5k38e4+DCZTVvDtKPEtLq0JkbZWpBCr7eopp2zEH35PdE
 vcU8/r0ObZu/lqh8DHrU1ZRu+kqGIriDUnSQM/WbNCBwGQ5si2e6pp/CYu7EWDtThkXlzRbEv
 WbMjRL5RcuHJ9exUDTr8qgM9VcLU6l7/mCFV+d4BXv2nOsxRDCRb+kwMvEgE2g66IewAUJ/rF
 dxSKFPHGkV1z+XQi801d+Fcolk4/XFhpUuhAIiw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OfePvZoNYmnQ97vALCoQb2W6e8TsPWXAT
Content-Type: multipart/mixed; boundary="KUhvlqX2g183NFD4uNH3Wn6ZVx0FinCmc"

--KUhvlqX2g183NFD4uNH3Wn6ZVx0FinCmc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/21 =E4=B8=8B=E5=8D=887:46, Martin Steigerwald wrote:
> Qu Wenruo - 21.09.20, 13:14:05 CEST:
>>>> For the root cause, it should be some older kernel creating the
>>>> wrong
>>>> root item size.
>>>> I can't find the commit but it should be pretty old, as after v5.4
>>>> we
>>>> have mandatory write time tree checks, which will reject such write
>>>> directly.
>>>
>>> So eventually I would have to backup the disk and create FS from
>>> scratch to get rid of the error? Or can I, even if its no subvolume
>>> involved, find the item affected, copy it somewhere else and then
>>> write it to the disk again?
>> That's the theory.
>>
>> We can easily rebuild that data reloc tree, since it should be empty
>> if balance is not running.
>>
>> But we don't have it ready at hand in btrfs-progs...
>>
>> So you may either want to wait until some quick dirty fixer arrives,
>> or can start backup right now.
>> All the data/files shouldn't be affected at all.
>=20
> Hmmm, do you have an idea if and when such a quick dirty fixer would be=
=20
> available?

If you need, I guess in 24 hours.

>=20
> Also, is it still safe to write to the filesystem? I looked at the disk=
,=20
> cause I wanted to move some large files over to it to free up some spac=
e=20
> on my laptop's internal SSDs.

Yes. If you want to be extra safe, just don't utilize balance until it's
fixed.

Thanks,
Qu

>=20
> If its still safe to write to the filesystem, I may just wait. I will=20
> refresh the backup of the disk anyway. But if its not safe to write to =

> it anymore, I would redo the filesystem from scratch. Would give the=20
> added benefit of having everything zstd compressed and I could also go =

> for XXHASH or what one of the faster of the new checksum algorithms was=
=2E
>=20
> Best,
>=20


--KUhvlqX2g183NFD4uNH3Wn6ZVx0FinCmc--

--OfePvZoNYmnQ97vALCoQb2W6e8TsPWXAT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9pO7QACgkQwj2R86El
/qhEZwgAhRffnsNPIWs/Z7TpCGr0vVRzESpNpzsFJ14xZh/ApC0DAay0Fni9k4OA
/u5xfai2xMDcj037fcUQnXw8Lyk+jDvD43feVVmGesD6h3+lpbmX8oHLZ23j12Q9
81mZQC3MInqioQG2X734Ot6+xhls4veym28R/U/xb+kPp4dLNiMpCv4Fixm2930b
em3qHVi1Hdy+V32sxXT6PcdB4ZyIudVpsbUzgG10bIDCp+oC0GLitkdR0P0h6KIv
18zyY+03xeqbXd2lHfFBOxt06JsKKeITUwyUbbvhWG+nePZl7HOT+TxNJlCyJCp9
FdmZNWeao+Wo0zIVGEmU9eCL1p4Uhw==
=VwHv
-----END PGP SIGNATURE-----

--OfePvZoNYmnQ97vALCoQb2W6e8TsPWXAT--
