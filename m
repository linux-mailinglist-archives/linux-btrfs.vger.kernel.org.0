Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB67D273864
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 04:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbgIVCOk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 22:14:40 -0400
Received: from mout.gmx.net ([212.227.17.22]:58265 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729477AbgIVCOk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 22:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600740877;
        bh=J/scEJWEkagu/CiiVdoegLC95+ISgMx/W1e9yNrg12k=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=WhXVMQttGNfMrOWw+20MrzumxKXwbnAiSs3fsZZMVgaRsIx6AGs/y+rIwne/HF68M
         o/VXkpoKgtQax1WLt6NESJjrB02ciULF0b4kOWzbCnAqyTYHOBEi4x18sWjihsldtx
         P9tRwrmxj+wmt5iMB9iHALtAI0rqaQWzk5XMwyJE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N49lJ-1kTArM0VI9-0107nx; Tue, 22
 Sep 2020 04:14:37 +0200
Subject: Re: external harddisk: bogus corrupt leaf error?
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org
References: <1978673.BsW9qxMyvF@merkaba> <4131924.Vjtf9Mc2VK@merkaba>
 <8d2987f8-e27e-eedb-164f-b05d74ad8f3b@gmx.com> <8020498.oVlb7o6SH1@merkaba>
 <f0fd36fd-3ffa-ff02-e5d9-265fc64e38f3@gmx.com>
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
Message-ID: <6e508d1c-32fe-1162-f905-2e57022f8dc6@gmx.com>
Date:   Tue, 22 Sep 2020 10:14:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <f0fd36fd-3ffa-ff02-e5d9-265fc64e38f3@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5M3DvXBhKKwgFKQQGFupXtAuBhdiIzDAP"
X-Provags-ID: V03:K1:AcLFXCBhtqKR4llx5VU2FzRIU8FsZR1JP9S0Qzp9wATjb6o4QEQ
 ctXo+XdMbNllQ/N2rZPDH6u0YACsnEWt+dOnxBY4LvVOMot0QWS/sMpQaXht3qUbs6lF567
 YscDGJj08B5e5if9Zk/oXvgLyCMtKIVsd5pBh9o82evcqDokEBZqIA/LXgTsIeUmR2YQ3Ee
 tShtKMvCJtspkiQf3YZVw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IoEgI5WEN6U=:2WA190A20V9/VzEZZajz/M
 UDJMyDgF/NS2Iz8sRF3LaU41h6j234gfkP3ICDJB4myaPfy0A+u37S/Te0eSVnbK1QVpJhE/l
 2EX7xr6DdGJBgY9DIZcQfZBwbjsp7p3t2Vap2Csibo24QNQAZk2HGefczK29l2Q2hFY0/t/Jd
 /P9XXv2upsMEtEXTFAqn76Ry1SyY5ivUA8jIF8L6mqQc3tN3Kd3vcQ7jrnxoLKGSfxLxj48Dr
 Tptme7WjVkTaMHUtciB91yG4he/UeD92i0MSmSl9uBEpqh4FtFidu8neBWdFci/yNULdmN7k2
 uW8xniIpZZCBSUuT99BPayzM6yXYAdAMANc+UgqgoBFtx353QYROxqRNI80V4nF3ee2nqGKHd
 7eS3sOPfzndSqtbTQlKieB3744PuwonwaoaOqWScMw+szEY0wJX4Dy9ktewjh+SH4jge6Im33
 g+InbSGVreRMv3WToBPpoVe+cWqJoPuRUJcIJVAVBQK2PPLTTsjByww4orhyuiBswVAJMZbop
 iv67xARS5HqtKrbVZlYqsvGEent/w+nJZp+q33wG6IfQR36Og5ZmDXjdYKM/Ze6Iop7qAamV7
 ee3veueDHcVWWQJwICysGKV2hyTgSAY7dcCCBF1FRXZYCG9iH+PV3jBLGbuuEZWDsgDgcjqpW
 gcKbhG9Xq3sL9FdCICqrBc87QIU21hP/iRGJaJhi7mC/Uhav1odSE+TVtwnSh8Y1/GXftwm9f
 dVf3t7ALtF8aVAw1W+d74spzRYdnVc907N06fU+t35jBGWY8ChUzbWwc/ZqUzYM+ZmeM9dCfY
 dX579UNEEYiv8WuYO7+a243xP9KQQJu/ZbProWrIJHyioi3+iFeUK0Lz0w4C/dbwm80d3Kg9T
 LZzfMSzyTJb8Nc6YtR2LtCXsXs2C0wZnca68gy730j6Vsp8SL4SsJMmOY1G56Uj65dq2mZ9YO
 uHq4DTqxZ7kZIDJB1+czon+KrMOwq6344knBslWupQpSe0ycSe3fjzdfLBXhLtdqlb8dxx3s9
 0IDfbcFVhrwTmuRBp94QTRzXFQ/T2x7yXfhrukoYks48eboRqoJjvHHeokSFL1njSQHzhKKFw
 2sms9I5xHUYe3BZFKDejIix345y2ZHlLo9HACrXHPBhfHuy14CNFaDTXNxmmONEUCCtThI7gh
 tntg8tWDpov5jGVfdJ24C3no58yNyejMOi9kY15i/Rv9RUJNmP/JOHJIXc6Dn8yVOozHErr+A
 YkAl/RDAo3M2DNvPLoSLBnPT9ekqTdupZck9qLA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5M3DvXBhKKwgFKQQGFupXtAuBhdiIzDAP
Content-Type: multipart/mixed; boundary="eTPMRfTcBjJDJ86Sq30RZoNWEsp6K2Wp2"

--eTPMRfTcBjJDJ86Sq30RZoNWEsp6K2Wp2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/22 =E4=B8=8A=E5=8D=887:48, Qu Wenruo wrote:
>=20
>=20
> On 2020/9/21 =E4=B8=8B=E5=8D=887:46, Martin Steigerwald wrote:
>> Qu Wenruo - 21.09.20, 13:14:05 CEST:
>>>>> For the root cause, it should be some older kernel creating the
>>>>> wrong
>>>>> root item size.
>>>>> I can't find the commit but it should be pretty old, as after v5.4
>>>>> we
>>>>> have mandatory write time tree checks, which will reject such write=

>>>>> directly.
>>>>
>>>> So eventually I would have to backup the disk and create FS from
>>>> scratch to get rid of the error? Or can I, even if its no subvolume
>>>> involved, find the item affected, copy it somewhere else and then
>>>> write it to the disk again?
>>> That's the theory.
>>>
>>> We can easily rebuild that data reloc tree, since it should be empty
>>> if balance is not running.
>>>
>>> But we don't have it ready at hand in btrfs-progs...
>>>
>>> So you may either want to wait until some quick dirty fixer arrives,
>>> or can start backup right now.
>>> All the data/files shouldn't be affected at all.
>>
>> Hmmm, do you have an idea if and when such a quick dirty fixer would b=
e=20
>> available?
>=20
> If you need, I guess in 24 hours.

Here you go:
https://github.com/adam900710/btrfs-progs/tree/dirty_fix

You need to compile the btrfs-progs (in fact, you need to compile
btrfs-corrupt-block).
Then execute:
# ./btrfs-corrupt-block -X <device>

It should solve the problem.
If nothing is output, and no crash, then the repair is done.
Or you will see a crash with calltrace, and your on-disk data is untouche=
d.


The root problem turns out to be a false alert.

It's possible to have an old root item, which is smaller than current
root_item.
In that case, current kernel can handle it without problem.

I'll fix the problem in the kernel too to prevent further false alerts.

Thanks,
Qu

>=20
>>
>> Also, is it still safe to write to the filesystem? I looked at the dis=
k,=20
>> cause I wanted to move some large files over to it to free up some spa=
ce=20
>> on my laptop's internal SSDs.
>=20
> Yes. If you want to be extra safe, just don't utilize balance until it'=
s
> fixed.
>=20
> Thanks,
> Qu
>=20
>>
>> If its still safe to write to the filesystem, I may just wait. I will =

>> refresh the backup of the disk anyway. But if its not safe to write to=
=20
>> it anymore, I would redo the filesystem from scratch. Would give the=20
>> added benefit of having everything zstd compressed and I could also go=
=20
>> for XXHASH or what one of the faster of the new checksum algorithms wa=
s.
>>
>> Best,
>>
>=20


--eTPMRfTcBjJDJ86Sq30RZoNWEsp6K2Wp2--

--5M3DvXBhKKwgFKQQGFupXtAuBhdiIzDAP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9pXgoACgkQwj2R86El
/qhJAAgAkm6UiaaGo8WrpMD4+OHnBowrmDplK49/+qWVTs0Q+lCTTcRR98bevuPs
4jwz0E0B4GAA853No1MnN2Mr6Zp5MLbWj11OLkiERRu91sBZKfCgsIinYPulKY5W
apKUP3uJcC3duG0Q4glZghKDNz5Cs03rp6zozusIWXEZLQw9CWBq6P+/WgR6E/9r
1ZtzfanwEyj6Fa/SZ6nKQORwvNWvjHKUJxIfE9/bzKh9roe7WSijJj/Wct/nH6VQ
Hxy7WYkTT4M3uEULs76CZ1hUlWBJfTnv6NGqOtvEdivOTPBPrkZfN3MGUFfOb/rU
lfT0vbBbxeKd3g5IpUfwbxz+AR0tCw==
=isn3
-----END PGP SIGNATURE-----

--5M3DvXBhKKwgFKQQGFupXtAuBhdiIzDAP--
