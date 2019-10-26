Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1323E5D96
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Oct 2019 16:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfJZOHE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Oct 2019 10:07:04 -0400
Received: from mout.gmx.net ([212.227.17.21]:60017 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfJZOHE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Oct 2019 10:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572098821;
        bh=M7/r0pVYggV4wxwmMRI3m++q36gKj1Se6h9nL0+JlSg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XLugvGixQj6mMzW4JbLI46AqoZEGcBa4KlgXu9wFxqkwEXJRZNHOAT4IdVQF45WnS
         DHQgXLq3v9xJsswzM5E8e4cz9azHbC1CgkdK/HUFYKy0ZD1vG5exwEAvphzXN6D9Kg
         RDLfQD0DG6msEPTWCn4E9A7AfH+/+K+aPMzLk+28=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9o21-1iJ7vb228j-005tEI; Sat, 26
 Oct 2019 16:07:00 +0200
Subject: Re: first it froze, now the (btrfs) root fs won't mount ...
To:     Christian Pernegger <pernegger@gmail.com>
Cc:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAKbQEqE7xN1q3byFL7-_pD=_pGJ0Vm9pj7d-g+rRgtONeH-GrA@mail.gmail.com>
 <CAKbQEqGwYCB1N+MQVYLNVm5o10acOFAa_JyO8NefGZfVtdyVBQ@mail.gmail.com>
 <fe882b36-0f7b-5ad5-e62e-06def50acd30@gmx.com>
 <CAKbQEqEuYqxO8pFk3sDQwEayTPiggLAFtCT8LmoNPF4Zc+-uzw@mail.gmail.com>
 <e0c57aba-9baf-b375-6ba3-1201131a2844@gmail.com>
 <CAKbQEqFdY8hSko2jW=3BzpiZ6H4EV9yhncozoy=Kzroh3KfD5g@mail.gmail.com>
 <20f660ea-d659-7ad5-a84d-83d8bfa3d019@gmx.com>
 <CAKbQEqGPY0qwrSLMT03H=s5Tg=C-UCscyUMXK-oLrt5+YjFMqQ@mail.gmail.com>
 <0d6683ee-4a2c-f2ab-857b-c7cd44442dce@gmail.com>
 <CAKbQEqGoiGbV+Q=LVfSbKLxYeQ5XmLFMMBdq_yxSR7XE3SwsmA@mail.gmail.com>
 <043c2d26-a067-fd03-4c98-7ff76b081fed@gmail.com>
 <CAKbQEqHbh0pjT1+hPNuo_fKti0v9Mi-=gOUqm90v_tju1xSaxA@mail.gmail.com>
 <503118ac-877f-989c-50f2-5e2a3d0b58d8@gmx.com>
 <CAKbQEqFWiGdgJNSWOwvHkHGjrXu=2x0zAK-n9T-oza7qexwz7g@mail.gmail.com>
 <4a329da3-81ba-3240-8d76-6509dbe2983a@gmx.com>
 <CAKbQEqGOJjNAFMitAU=coVboaat9pi5b-6DxFg4SOON+6bfJ0g@mail.gmail.com>
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
Message-ID: <0d48803b-b8f0-2ab7-dade-d92067b91202@gmx.com>
Date:   Sat, 26 Oct 2019 22:06:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAKbQEqGOJjNAFMitAU=coVboaat9pi5b-6DxFg4SOON+6bfJ0g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kzbcNpm1xUrFiS28S90tx9g7tixKOz3TJ"
X-Provags-ID: V03:K1:GDwzisVzqn/DVXmJWDgSi9vcpNSQXTVjqOR3Jk1V3fgWdGd4KHO
 1Oc7GRw95m2Ed7cIjIZTyX38G1IJwbhhVZBDih2oCPB5win2pZmXk9d77JoZyUIoOuwcVOE
 7BNs41FYMEL1u+FRPNw8SBCy7fhXmYmY3hMjl2QDCH7RvcuKcuZ3LR4vxSgnP1cxY17k4a/
 g0BO5JV7tGJY3ueSxo/OA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tF+dwe/9HPc=:N6/ZGESuYXB5KkT2lHEyTy
 jfJ6CxuAibU+eKiZVmdI/TIVBi7pThJaf6PVx5zrVWyj55BGo21vD6FtIpbRLkEhwuh9QIDWw
 a++DwWPHJYWMBoZdG+3FS6X1sW9iqf9J0/x8B8VlmTBLOTrulxseW1KEKubaQFsyIznN2i2CS
 LWMZ4kvxiYCn1c3j8MbSTnCylgO91hdUB4q2k5B/VeyPKOJvlTuj+0Qa/rRQLlGFY3Zd+FQVv
 niQEmVvHPDkRNJ2zyK2qQVsZssizYF+C4bcb2XD+15XvZ202qi7Z/giRn5K5uXqpddVSdBglI
 so1uJfDoFRukULzQVR8L/6xR6kHIErd/sZmc51sPYt1SDV1ftaVdhmCTOmWQuF8+ANSATlqH6
 kWQsUGqEAwqaTjom9Y1UNAMErtGp3cjyxvUTTXX8sz+fu2eFj4KYYIORCCgQ555zbhNTtSCbQ
 sWOk7IYx1I11eJXU+f4rG6dYaw3kQd5jPtfJmy13iYsnC4xpgebx7SMYZalnjZKXR+1ECdChQ
 AUMr3y6xxiwRuDISqEH1o8Fp3+WvdL5HAPvfit6304uHzqUnD7WRkuTRcimrdilv/CyA+HXWK
 Q9ftFQe1wsxveAONl9X8u/yzdi3IBM0IAyaBWm+69mRSPkfdQw2UvAIASnZcZAtzMRQYlAort
 m0+Wtc+otVoOQ56rLeyTk9+OaBuVTWcZ8vS16j274t4dkaB5jB9nPN69OMrVkPf9m9G154r3g
 qyD3HepzPczcyh6XFVVHa94EigF31roDIop4LpfPiimWVc7zKERCDKUFkLkMzE33jBEvOP8Jf
 7WTVVjmNtieY+b96S+DlJBdiPQOjs+2HOcMHdYXdWLT2kZE6y0QNKbeiR0w6m49/vgaW32L8c
 Nrj0JT6KTxqdrcEneL8uGSdl2ld4bAFDJZiJxAw1FQZCgEMGG98MRqI4Powty2AuVa3lP9IWZ
 pKNNUkY0iAciXXCAPe1OVZn6lTXDmukdqcShKeUEswxpvZg6IbW5Lbv/gqJJgvoLh1d/VqYXP
 5ENnb7erImYwW6MoHtehzfr5khVzddGQwC1OhsZJanTCtBEM9PPU7mmWqLAqkAuP8uElVJf6L
 VKXCqCl26O4fmFzMmIGzVQdLbvCwcUWc1uU7Rotetde+AnlgZTEzUyWFCzRdoFt+75jYpP9mZ
 M1vj3qJPrC65jrFTTZvOmEeiaOq5TB6UF503iON9M5fqj9pPQ+7IT1FAkLDej9+DtK/4lTHW/
 affyTiqpRUkb93dSK+pWmuxMF48pou923F8mC3KKrddKJ1Cw6KhczhGhN5fA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kzbcNpm1xUrFiS28S90tx9g7tixKOz3TJ
Content-Type: multipart/mixed; boundary="7H7sbw2i66TxCP0k5VzBY4JNg1gDbQXCY"

--7H7sbw2i66TxCP0k5VzBY4JNg1gDbQXCY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/26 =E4=B8=8B=E5=8D=889:52, Christian Pernegger wrote:
> Am Sa., 26. Okt. 2019 um 11:41 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gm=
x.com>:
>> Thus I put a log tree check in skipbg mount option, and if it detects
>> log tree, it refuse to mount and output kernel message to require
>> nologreplay.
>=20
> No, it doesn't, it asks for notreelog (quoted from a few e-mails back):=


Exposed a bug!
My bad!

>=20
>>> [ 1350.402586] BTRFS info (device dm-1): skip mount time block group =
searching
>>> [ 1350.402588] BTRFS info (device dm-1): disk space caching is enable=
d
>>> [ 1350.402589] BTRFS info (device dm-1): has skinny extents
>>> [ 1350.402590] BTRFS error (device dm-1): skip_bg must be used with
>>> notreelog mount option for dirty log
>>> [ 1350.419849] BTRFS error (device dm-1): open_ctree failed
>>>
>>> Fine by me, let's add "notreelog" as well. Note that "skip_bg" is
>>> actually written with an underscore above.
>=20
>> Then you can try btrfs-mod-sb, [...]
>=20
> Yep, that did the trick. Can mount the fs ro now, access files and it
> even reports checksum errors for a couple of them. Promising.

Mind to share the csum error log?
As you may already find out, certain CRC32 means all zero, and can
indicate more trim error for data.

Otherwise, indeed looks promising.

I'll fix the bug and update the patchset.
(Maybe also make btrfs falls back to skipbg by default)

Thanks,
Qu

>=20
> Cheers,
> C.
>=20


--7H7sbw2i66TxCP0k5VzBY4JNg1gDbQXCY--

--kzbcNpm1xUrFiS28S90tx9g7tixKOz3TJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl20UvwACgkQwj2R86El
/qjCMAgAqZsK6XdwJH8yyyDLyUxDMHAcb1gzy5KEJGpXRyXw24R/UfBHKNnIigkn
GSJNkz6bKYShqY93rpC4cYVwRVc9chdvXoEhyFCy1a8FzzCSz0nzJkVMLxjAxS7t
lXas/xgrgTlUrBS4Anjp4VMq5h/aiP5WFcRGvCem8B3WBuXbvLh5uDYk2oJD/+TC
hTcdYU2sFj7Z3+1fXUhgY4RkvPmvHgm/J+8GO7F8TBB5vIo5kRB3t6Hm9SzIRQrJ
qvIGFkzeUgL34LnINaRWF7xFkCuTJoyA/z09toEE3bkkJUVyCbvUcurlZ3tifLgo
pVuaKr4WwbeFfmpYJowflZP4RwoSUA==
=GxV+
-----END PGP SIGNATURE-----

--kzbcNpm1xUrFiS28S90tx9g7tixKOz3TJ--
