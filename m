Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A9E273D9C
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 10:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgIVIoc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 04:44:32 -0400
Received: from mout.gmx.net ([212.227.17.22]:50703 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbgIVIoc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 04:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600764269;
        bh=N7qD5BB998/ijim8XT88cF4+m3cFGdubAnDQMWd3CGI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=DK9crQlyuGF+YxawnGqI1+wIhFdGoPO6SUX1z0116q9D5tbNHMHbAloq/YAI0L8PR
         GgZROFbJIbReJhbs6ocV63riAZkXRmT4gpHjDotoniN0EYsrzVmmHxMYRuq8xM69fe
         Ofa1OPbYRZdJe3J1V90SDLn5qYPwIM6r1S5YNHrM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeCpb-1kv5Fz0Vjb-00bGId; Tue, 22
 Sep 2020 10:44:28 +0200
Subject: Re: external harddisk: bogus corrupt leaf error?
To:     Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org
References: <1978673.BsW9qxMyvF@merkaba>
 <f0fd36fd-3ffa-ff02-e5d9-265fc64e38f3@gmx.com>
 <6e508d1c-32fe-1162-f905-2e57022f8dc6@gmx.com> <4501761.uZMkQUx0QA@merkaba>
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
Message-ID: <312a23f3-ac58-2e05-05f7-74849872d2be@gmx.com>
Date:   Tue, 22 Sep 2020 16:44:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <4501761.uZMkQUx0QA@merkaba>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iHcOBCXQpjD6o69B0QQLszu2Pz8GmiRq5"
X-Provags-ID: V03:K1:VCOsdRQPDm/7AXZYL4OLRPFzOrppJxuwwbmCZok1YLAIrymIx4h
 vIgZOJzOPDWUwy9oY4q+kcw7FO4ZkaFEdgvAKIaLVg1UO4QO4KvqbwvkvU3hOc/w4jIfHOq
 TzG2N08VBUig8QLIUTAABlMS0CDnCBlNpJVVKJtidfWipCdmtkXZhY7YwmYK8WBtdkBD7GE
 i+r/s9n5srZwSEGh5OvRw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EuzZBAvAO8Q=:mDbhl+8uGc8+grHpwkrBgK
 XDK7BbALi0UwMclsVF1td/kE6bYgdlpcmY02srQf3apQPafSZ+0iuRwA+ZKEBb4LBMvj5AlbS
 A9Ehj2js/kQKY8O4lSAOU4hAfD6OQfYqxGMkPp3f069iZpe+Pd3rlz9KHCL0dQ0oTzfurBnuk
 TcvTAGnnvSyK1Ife7Ek4sc/nNY7vKXDqdK4Jib5JNiJ00hOvQVAHhZrmoC2XrqIQM1krTLVKA
 JwDw7sczd9aQNdpyh+G7HECHXfes6zT1sc3VCVvEbx9D4EAFIwhYYnHSvX9uss9GCHyBgNLyh
 Uj/ba7B1qF2OtMDRz/yKYNe49RlzrC3wXgPejBPGxjqq+rLLOwNVa2tLc/WjbY72NVL0jrKRe
 kguOgl4+7gE+VeT0MoWCTRzqV5GWQAbGKKoIGUAnbNp51QJaJAOfWcXjiH990SRI//OJe1CWz
 O4z2Joqk9RUVyY75DuJKBHjCNq3XpE1KUbz2/QMkm0cr7xJ0zhgghHJ6eL2gWkDcIMJOAJaUH
 1CnC0AsU6pe3w5IKud0tCPz4HXtRa6Zg8gVjMW4QVTTkMarMwjipwnLKh6ub0euEcR1a+e5ZZ
 236kG6/B4jFzAw37iSJJCsFE47R15hVaBfRjuKTkmtMgr/dg5eJgM+OQdT0axM7G32ly3m8bu
 UPMPaJXkK+PwvGyK9U/09FAcuRD8YK5J5+N/shDZJAsnPknRf47/PAZYY2gp6DKrDZE0IVcXM
 dhbvcmI4FmB08j2EDcruDMrkWih8AdBTKEG6E+sX/0uFtY7Ky1dcercY1b5uh3fdO0mMQqDvs
 NZs5mmSIGZOWkMsXU1S3XpPO0nLy/s5zTWFz1nnQhgHDWgNURqMtCgZ5ILnL3m1JLG1lbXQKM
 kg9kTbDk+aIcU5TpRVhQWbdch49K/upIbqRJhzKHkHfg3kXpipyVMA/hqijmGEwrTNg2gLUJ1
 V9sY5DDBGmkkx17h/BxRwAGLh5JhhUwcMDjGIzSzPbVRpLyZtuU+plSwXL0tYmFZuXD2JKk/Z
 lKlLIyXSlLuppgypt3O8b1S/ZIgXTMdc7Q1pODBsm5No2M1j4Lugvi/d3A10u6Kkir761xC1t
 EstQt1zWMHs1Z5hpLJGq2Dc+z93UXXuVtxTipRUUEPQLMu/xWPdOqSzSPW3b2UG27qaXNm700
 xYw2WJSCoXJQ+ofhZMNIso7Bn+mEcYCG1uxys/9gjzAff0fhadAy1uTV2arkFdmGAG3FEAFmX
 6+ebZE0z0ZE55G/gIl9KEFIp0/r8OcPn08HgOMQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iHcOBCXQpjD6o69B0QQLszu2Pz8GmiRq5
Content-Type: multipart/mixed; boundary="kPrpEhzrjaatCMjniN7OE3NFHmkT848BK"

--kPrpEhzrjaatCMjniN7OE3NFHmkT848BK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/22 =E4=B8=8B=E5=8D=884:40, Martin Steigerwald wrote:
> Qu Wenruo - 22.09.20, 04:14:34 CEST:
>> On 2020/9/22 =E4=B8=8A=E5=8D=887:48, Qu Wenruo wrote:
>>> On 2020/9/21 =E4=B8=8B=E5=8D=887:46, Martin Steigerwald wrote:
>>>> Qu Wenruo - 21.09.20, 13:14:05 CEST:
>>>>>>> For the root cause, it should be some older kernel creating the
>>>>>>> wrong
>>>>>>> root item size.
>>>>>>> I can't find the commit but it should be pretty old, as after
>>>>>>> v5.4
>>>>>>> we
>>>>>>> have mandatory write time tree checks, which will reject such
>>>>>>> write
>>>>>>> directly.
>>>>>>
>>>>>> So eventually I would have to backup the disk and create FS from
>>>>>> scratch to get rid of the error? Or can I, even if its no
>>>>>> subvolume
>>>>>> involved, find the item affected, copy it somewhere else and then
>>>>>> write it to the disk again?
>>>>>
>>>>> That's the theory.
>>>>>
>>>>> We can easily rebuild that data reloc tree, since it should be
>>>>> empty
>>>>> if balance is not running.
>>>>>
>>>>> But we don't have it ready at hand in btrfs-progs...
>>>>>
>>>>> So you may either want to wait until some quick dirty fixer
>>>>> arrives,
>>>>> or can start backup right now.
>>>>> All the data/files shouldn't be affected at all.
>>>>
>>>> Hmmm, do you have an idea if and when such a quick dirty fixer
>>>> would be available?
>>>
>>> If you need, I guess in 24 hours.
>>
>> Here you go:
>> https://github.com/adam900710/btrfs-progs/tree/dirty_fix
>>
>> You need to compile the btrfs-progs (in fact, you need to compile
>> btrfs-corrupt-block).
>> Then execute:
>> # ./btrfs-corrupt-block -X <device>
>>
>> It should solve the problem.
>> If nothing is output, and no crash, then the repair is done.
>> Or you will see a crash with calltrace, and your on-disk data is
>> untouched.
>=20
> Thank you very much for the prompt delivery of that tool.
>=20
> No, in case its safe enough to write it would have not been that urgent=
=2E

Since I have manually crafted an image with the same situation, and
tested, it should be OK.
>=20
> I hope to find time to try it out this evening. Currently in a training=
=2E

Another solution is waiting for the kernel patch to arrive.
That one should be 100% safe.

I hope that one can be merged in v5.9-rc cycle.

Thanks,
Qu

>=20
> Ciao,
>=20


--kPrpEhzrjaatCMjniN7OE3NFHmkT848BK--

--iHcOBCXQpjD6o69B0QQLszu2Pz8GmiRq5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9puWcACgkQwj2R86El
/qgsywf+Jf9ffVzFnXfm5gmQNMIVqyuCcA29C93vs84CU24tf3X+GXhuU/+sZrRy
wSVv663oOXmcaTmUvIR84sP+4qpVfIRKxjgNkUf22kDopfGWnAaAMh2p2lEAANHW
AV9jcWI5nlKriH6zilPWv7kxTDWP6pF95J5Qwi+kevPfpQjeYmLTfqudnlOZG51H
LtMNS+4f/o+stouz+aEXNwgaKts3J3fIm/EAd4QrdJeoRAPNB/v5gjslBKAIQ/5f
nNBxhlOUjrp/3m0hXpg51/2l7C/niQr+G9kKY09skVjKYpLC15fBrIJqy/q2+9Ro
psHPPFKH8LRKhhFnPimemBuYjR8gqw==
=TS+K
-----END PGP SIGNATURE-----

--iHcOBCXQpjD6o69B0QQLszu2Pz8GmiRq5--
