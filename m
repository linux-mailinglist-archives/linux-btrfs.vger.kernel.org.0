Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA10624C8B6
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Aug 2020 01:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbgHTXkF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 19:40:05 -0400
Received: from mout.gmx.net ([212.227.17.20]:57915 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728818AbgHTXkB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 19:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597966796;
        bh=TPK9VcLeanwwfqBwjZoWxQ7PAP2vrn1tTzwHKuzMmoc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=bsh7M+0bNNu/OAbbever3EfUmo7wiMGwThThwWDTPloDeOp4WkUzDuFMiafO3dVAa
         GVFMw9L58CtG6AO8QnDBetIiDV2AVnlUChip1jIP8DSgRBsO6F3jM47xCdzxQbk9gd
         hZ9N4nUAlDNUCdF80I480lSiny5qSaTq7kpZRbAo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MK3Vu-1kMiiT2Tew-00LYTq; Fri, 21
 Aug 2020 01:39:56 +0200
Subject: Re: [PATCH v5 1/4] btrfs: extent_io: do extra check for extent buffer
 read write functions
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20200819063550.62832-1-wqu@suse.com>
 <20200819063550.62832-2-wqu@suse.com> <20200819171159.GT2026@twin.jikos.cz>
 <66f629fa-e636-6ab5-eda8-5299d996b2f4@suse.com>
 <20200820095024.GX2026@twin.jikos.cz>
 <1507884d-ad39-8edf-03fd-42e1d10f50e1@suse.com>
 <20200820144647.GY2026@twin.jikos.cz>
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
Message-ID: <97893a6e-f14f-b425-cd64-b8282f416a0a@gmx.com>
Date:   Fri, 21 Aug 2020 07:39:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820144647.GY2026@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ijMwKKf0ItvOY5lUgX4Hm8AKRThR3oEkW"
X-Provags-ID: V03:K1:cnkq79wAk4iyx+4qu5pB6FFLjrJMnUWnIXGLR7qhzDQx8GLPV6P
 VwFEZqMMZn+Tp45t3pVi5oGQXdq1KpTYYYsriH3kIcZwwr7BD6CrlX7mMbwLqHVC1S+nza0
 RCV+3nUKLc6WcEe+9Mln+FKmkgilX6f1yVtZbbdj+q3n+fBjt61oPO256zDwGuBGHiTzrKz
 8eULLoHQwqlo6omWV6ulA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4nGragIUd1k=:w7lKKQgZqLHt0iNg73hyV8
 yiyWq3K1nVTW3M7jQO42wA1zjllw/WKYAhIpYv9FPCPrIONySbBNUyWOIvNg4Qri4f5Oj3ycT
 3XKAVC1Z5VwLboz7o1LT1ea7X452h42WKVfCLn5b6bOLgfl4/QvgEWPdLAMEoJHXWg0Gt2W4p
 /HwBT358zyLkCpi/HD/MhcgfRVtmZRUzDGD/3qqtTTUUTgSAGdfNADpwvzoh81ZJ8C2wMEwq8
 s9+lkGGkB5YGTmaQRsycZIBHxGNxN7/1XU6T7sTROFND4AaOl8Vmuat1m9LXnUJmxZJP0cpfO
 WZLX/JhFAqnPvr8AgskBRmX3OAfBa0MDHLEFMd1KDWAE0Cm4XrlHLdW/SFfkpgZx0cAdeKr3w
 LLjEYY/cTI/29cssGbPIu1ZMCeNHp2/6fX49YZUYOSB9fN0cggE1OcZsLzbenpuBerX9Scw5/
 lcu+QjIYT65cWURgJA3nTmQzS+ACKbjy6GEv/V94KsSd5XH22e3g+4OxxEuPASr/MAtGhbc3B
 waBq7Z6U+aBtrfCXumZyzBPIBXKyebVXFplfad2AQ2DYxlK+6Jehct1VcnUrMtlR3jiyWrTH0
 CyPrkdJabCoRpaAk15RQZB0Z1bTZuEQb80cSftPAXHHxxOyQ6nHR3Ht3sAwpKGk1XmixrUfod
 LxsSQVo36k3eYIdL6LqblpMqju/tvdeuiaX8XgxH2rmzbhiS9xVEbDOYWkPaaFhui/Bv9CUb0
 IP9DknuoFQlPQkfDSxesWmfvm5mRxEsB7lqDC2SGmkih3lFQYJcPEmHopoV39AgAVJSUqNo8c
 L/Cgv2gutuAXJtOq5P5GWWUzxUOjA6eUReN/OfFqCoBqvYa/NrSGTPVln9ErMY0nulQ1H/1h6
 DLM5k2dmQqeS/+VlTj3NYqdFKO3sProLiB2MmvRq1m5b2Eur1Wm5qkCQA/C6LmiLUydteOnke
 gfBWb6ulbVYkkDVea6G7NnBIsMiRteE8cf30bz+hGmUTkcaJrc5o6yph5scSDw5cmxX+p+/jW
 CvS9OuRcUL5Cz/vvxPQcaq/t2LWrr6r0mpSuhKpcfr3jBLYsQsgRrc5KrujYo9G2BlG0aDm/5
 cADVwvxbEbKTOVKHXs/OVkx3VxuE+I9VEa5mFzMeVOmk0oP7xae33FJIdBPrCrzlcMrx9TIGw
 ZRxRHbZ7RjuHAcJwRbzoBJ4C2S6JsvXqBP0RTPzbKvyBaO01LrsiGrNShDuBdlIE6Vc2+D/In
 yIkF3wwcI9jXuBxMF3DoGVA072Zbq7bg15YKHZA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ijMwKKf0ItvOY5lUgX4Hm8AKRThR3oEkW
Content-Type: multipart/mixed; boundary="2Pu6ek4vfpBFOSRZjXICyWCTnPwbax41E"

--2Pu6ek4vfpBFOSRZjXICyWCTnPwbax41E
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/20 =E4=B8=8B=E5=8D=8810:46, David Sterba wrote:
> On Thu, Aug 20, 2020 at 05:58:53PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2020/8/20 =E4=B8=8B=E5=8D=885:50, David Sterba wrote:
>>> On Thu, Aug 20, 2020 at 07:14:13AM +0800, Qu Wenruo wrote:
>>>>>> +static inline int check_eb_range(const struct extent_buffer *eb,
>>>>>> +				 unsigned long start, unsigned long len)
>>>>>> +{
>>>>>> +	/* start, start + len should not go beyond eb->len nor overflow =
*/
>>>>>> +	if (unlikely(start > eb->len || start + len > eb->len ||
>>>>>> +		     len > eb->len)) {
>>>>>
>>>>> Can the number of condition be reduced? If 'start + len' overflows,=
 then
>>>>> we don't need to check 'start > eb->len', and for the case where
>>>>> start =3D 1024 and len =3D -1024 the 'len > eb-len' would be enough=
=2E
>>>>
>>>> I'm afraid not.
>>>> Although 'start > eb->len || len > eb->len' is enough to detect over=
flow
>>>> case, it no longer detects cases like 'start =3D 2k, len =3D 3k' whi=
le
>>>> eb->len =3D=3D 4K case.
>>>>
>>>> So we still need all 3 checks.
>>>
>>> I was suggesting 'start + len > eb->len', not 'start > eb-len'.
>>>
>>> "start > eb->len" is implied by "start + len > eb->len".
>>
>> start > eb->len is not implied if (start + len) over flows.
>>
>> E.g. start =3D -2K, len =3D 2k, eb->len =3D 4K. We can still pass !(st=
art +
>> len > eb->len || len > eb->len).
>>
>> In short, if we want overflow check along with each one checked, we
>> really need 3 checks.
>=20
> So what if we add overflow check, that would catch negative start or
> negative length, and then do start + len > eb->len?
>=20
> The check_setget_bounds is different becasue the len is known at compil=
e
> time so the overflows can't happen in the same way as for the eb range,=

> so this this confused me first.
>=20
> 	check_add_overflow(start, len) || start + len > eb->len
>=20
Then it should be more or less the same as the existing 3 checks.

In fact, the 3 checks are just the overflow safe check for (start + len
> eb->len).

The difference between check_setget_bounds() and check_eb_range() is,
the size for check_setget_bounds() are fixed size, thus it will never be
negative, thus it can skip the (size > eb->len) check.

Thanks,
Qu


--2Pu6ek4vfpBFOSRZjXICyWCTnPwbax41E--

--ijMwKKf0ItvOY5lUgX4Hm8AKRThR3oEkW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8/CcgACgkQwj2R86El
/qh4Owf/e22qJmrIadNTg6H5+arbj5TI3pHBlxle9smx99WfJlyLnuR6KRJ45kW7
EUmQxkA54HK43m3z3RbqW8O9WwGOVF/DJwqdaGCFxmA5O71e1GanOc2eNeLR16wR
X+EYmT0Kw+7vyKu42Sb21ETzX2Hw+dIHBEEHX/L7dUX68sxZVEhnTYdNuAzrIInb
+M44w/Vf8hhTRhYa4vIfZ0zt26+SNDO+5YN7ON3vIC0PvFlMkEkmvNL/UXU5xyw1
hh7qdVlXY1egAVVGWizBsEv8iYpF42QD5ZVNumiuOq+WJmBnjpthMG1uR1fpj3jp
87QTlzmW8aEmckkPbIMTa6lwy9974g==
=D477
-----END PGP SIGNATURE-----

--ijMwKKf0ItvOY5lUgX4Hm8AKRThR3oEkW--
