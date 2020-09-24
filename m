Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020722764E1
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 02:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgIXAHL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Sep 2020 20:07:11 -0400
Received: from mout.gmx.net ([212.227.17.20]:50943 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbgIXAHK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Sep 2020 20:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600906025;
        bh=WRhbrDJqOF1yQN5pyupjT0Wv9t6Hivd8Ro17PpeCK8k=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=HtF71HGHUjRsuEpS7siiTVgpvi/kQn9WF/sgDywf83Hdp8avXdVEHMUrxibTyUn77
         13wzNJvVgGPxAQVqW/u56moMJZRlWUBu8Il2MSmvBlRK3IctmuMKaDkt7g94vcfZob
         AF0zpW7BHd1uNVHsuJTCJpsmfqpCgOlxwgJ8WVwo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3DJl-1kJsH71OBB-003aQj; Thu, 24
 Sep 2020 02:07:05 +0200
Subject: Re: [PATCH] btrfs: fix false alert caused by legacy btrfs root item
To:     Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
References: <20200922023701.32654-1-wqu@suse.com> <8998433.IpVEtotQbC@merkaba>
 <ec3a5769-a847-6b3d-d502-b96c053b070f@suse.com> <1952994.EpAzVLkqvi@merkaba>
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
Message-ID: <24c90ac7-a129-a20d-19fd-73fddc2fd73c@gmx.com>
Date:   Thu, 24 Sep 2020 08:07:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1952994.EpAzVLkqvi@merkaba>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8JxfQig6kdwP5ldL2FdJcOwGktxSCPEvt"
X-Provags-ID: V03:K1:PC9oM6eoEzHrAm4elFu6lJbufweR3l9vYcOF37uhXHmD/mUDWwO
 LQk+cl/eO8PLmEGuX61VcCwLYXBRt15pEkc11eH5OLqbfrQrAnBRFzcvWht0h/Y4eOdtPTJ
 OnHHavcvyrHuPlR5KeUzQ6WQNesvK4/wdHanQufO4TzyK38l+zMJ1ObJl8rZMR7miTFXWhJ
 ielMy+bm9yHiWVKA4Zrig==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ow8dtdNX52I=:uqZaqoG0tTKyNlOAdYk9Di
 R1LGdO7KZ/qG3CeSSlA1raNSJFeVRJydeUk/nhl2wl4jp2RphnugoRuOUTnVc9t2flS778Jkq
 ZK/Jbhx/tXTxNxnUuVSBnEcKMOP8BcWskwhmhacZBSysZIjF8Q+mm54RP1AV/tEaUG9OyG1Qk
 O2a9ZjrImsWDI4RNOAhan95ZXwxyJSSrqLORDiOoTh9qtOyTHmsA5oxbEMVzxoJf2DsoS3rX9
 syzemAhrMqhjEpwZ8Lk/gMJ/5KmKg8s4COgWGMuGIqdlkKDJHvMXzsnKQ2nhAzZPaa7k/XPBA
 P8TKZx/tf2apyrMouUm//GnTD47g7T+gY/pINf3g5eWHNUIfk2qTHbODIaXalo+wwij4LV5mG
 X8FR/vONvFX42LVUdpoFFZiG6+5oDCV0tsM8RSy3ECgVoYCDYmZhfKl1H3SmiHomkA5bP6my7
 uKm9LsZxWqPWbA6KauAY7YfKqO7ls+jTpwaag0U+q9AoUjBblTsIdSi+bzuZVFi2uYQgL+6o9
 JGjfONxDcOWyncom5vsyJSHN/sYIRsgIGiHWxyI+hmGPYM0CeROh3VpdvTK/0BUsU3rJAXDiG
 aBRjkoO3Ej7pxRwWFFwRXp1jtUdSsmG3WVn2gXTCWrH4RU68HOh0pMPNPILEYAlL510VkST+P
 HLy7ffzcmTVsEu5k9/rkwYZlBYJKSOgeMH0GT11Ns2TxDaxk1UPVCAh5/PfFtOkYmgPjDIaRR
 OVWr8c5gxXTtodR6Jo+KHNqYVRQL4C7/gsjWpV4WqFxrABkr4JumYzdCQ/SSK2TTfYzYQlQyX
 MxJMPL7+HSYWS+XOBzDScTk/SBtCWHWuFZs5vmeKW7CjFA7Zi4cG9UmgujcicUVsl0wAjKfN6
 TO02SYi2KboV9qEkU2D4FydkMSpTepMjso42SQaZUkz0J4IOPjKk0pmQR6wRdApxTfEzg7Ct6
 j4HivcPAzvT16xOPtg7vyO4+AbYFWyhJThW5YlzLn7YuJWpjhODCnlZw8NyF9PFFA6gWOWRvy
 reye9d9suaFLAU4sIzNqy4uLaiuLHC+8EzGuRdnRRzH7qjUWsyjr27LzwpS1wLPZ0AD2qKKHH
 FD1bLLq/tZjO9T7kc0MpdynKoBeqDa2F2J4F5o7uRex6uxzSztC59mHgU9fOFdo93GCs1R3gX
 ivgwUgwa1dbkD8ieWp17ePTpokWJoQrlRZkpBDR4XsCZWfOfqzp9YOADaRtQ+EMlrNEQQAlKH
 Gv+54Y76pP5H59cYdVwBrnAa0Rx5GkdeRPLFrXw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8JxfQig6kdwP5ldL2FdJcOwGktxSCPEvt
Content-Type: multipart/mixed; boundary="kXdMEO48Pgl4voKiHGvHFYGJ7iPeruEwc"

--kXdMEO48Pgl4voKiHGvHFYGJ7iPeruEwc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/24 =E4=B8=8A=E5=8D=883:41, Martin Steigerwald wrote:
> Qu Wenruo - 23.09.20, 01:17:01 CEST:
>> On 2020/9/22 =E4=B8=8B=E5=8D=8811:48, Martin Steigerwald wrote:
>>> Qu Wenruo - 22.09.20, 12:34:18 CEST:
>>>> On 2020/9/22 =E4=B8=8B=E5=8D=886:20, Martin Steigerwald wrote:
>>>>> Instead of the tool, can I also patch my kernel with the patch
>>>>> below
>>>>> to have it automatically fix it?
>>>>
>>>> Sure, this one is a little safer than the tool.
> [=E2=80=A6]
>>>>> If so, which approach would you prefer for testing?
>>>>> I can apply the patch as I compile kernels myself.
>>>>
>>>> That's great.
>>>>
>>>> That should solve the problem.
>>>>
>>>> And if you don't like the legacy root item, just do a balance (no
>>>> matter data or metadata), and that legacy root item will be
>>>> converted to current one, and even affected kernel won't report
>>>> any error any more.
>>>
>>> Can I get away with a minimal balance? Or does it need to be a full
>>> one?
>> Minimal is enough.
>> You just need to balance one chunk.
>>
>> You can confirm it with "btrfs ins dump-tree -t root <device>".
>> If DATA_RELOC_TREE item size is still 249, it's legacy one.
>> If it's 429, then it's the current one.
>=20
> Hmmm its 439. So is that good as well?

Sorry, 439 is the correct size.

>=20
>         item 178 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 8546 itemsiz=
e 439
>                 generation 13246 root_dirid 256 bytenr 896876544 level =
0 refs 1
>                 lastsnap 0 byte_limit 0 bytes_used 16384 flags 0x0(none=
)
>                 uuid [=E2=80=A6]
>                 drop key (0 UNKNOWN.0 0) level 0
>=20
> What is this tree used for by the way?

Used as a tree storing the new relocated chunk data.

>=20
> If you like I can test with unpatched kernel whether warning goes away,=
 but
> I bet it may not be needed.

It should be safe now.

Thanks,
Qu

>=20
> [=E2=80=A6]
>=20


--kXdMEO48Pgl4voKiHGvHFYGJ7iPeruEwc--

--8JxfQig6kdwP5ldL2FdJcOwGktxSCPEvt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9r4yUACgkQwj2R86El
/qi/nQf+K+IXOuggWk6h9/TQ+wGboG3oY4gF7sTGn/c0yiAWqG6B/icbKw7OjAPU
tFX2SQw75VQ7ZY8rdLTAbS2V6LgmYtEGx3FztMos9I80pj4PyCJ171W0JwtdGuJN
R50GcUf9x8DKG3x3qmpphbhfN9E9TuLqM7Y2t/93sYiVxePtR1KkNq110T55H35p
MewDP1XPFsQu5nCOGmyLRMOlKo0+avlun6UgBbvkIlkyS0QZsh4TDYBzG/+Y1X2e
t3BI9nwBFG6un9qXYXZJ7xeuppxjVZhwvc5t8t790r+dVfz9PkheiupBGLIQqkdY
cSmxDGeR9OSp5TElUymUxQzGeS0ZIA==
=DER7
-----END PGP SIGNATURE-----

--8JxfQig6kdwP5ldL2FdJcOwGktxSCPEvt--
