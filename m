Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3345816F688
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2020 05:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgBZEhx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Feb 2020 23:37:53 -0500
Received: from mout.gmx.net ([212.227.15.18]:57249 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgBZEhw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Feb 2020 23:37:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582691870;
        bh=kk9WGJJFNJ7oqfY5By5531zQ75ipsB4Di7EKQpzHmr4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AwJUXdqWQw4mEyE/HOlS1Xx1OWZUwR7jQajHaKuE+Gtag4pDzSsiz0eBlL93b32K4
         d8XyrskI5v7hmDQ+r5e/OL9y+Qr4b+D03+HLrUvwhs2SDrc4jsvP1QhfsrFZYybhq8
         qbtvFku9NsV6YjKrvJ/IEGTAKx2HnWWh2VP1C9eU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Msq6M-1jQPll1goC-00t9DM; Wed, 26
 Feb 2020 05:37:50 +0100
Subject: Re: USB reset + raid6 = majority of files unreadable
To:     Jonathan H <pythonnut@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAAW2-ZfunSiUscob==s6Pj+SpDjO6irBcyDtoOYarrJH1ychMQ@mail.gmail.com>
 <2fe5be2b-16ed-14b8-ef40-ee8c17b2021c@gmx.com>
 <CAAW2-Zfz8goOBCLovDpA7EtBwOsqKOAP5Ta_iS6KfDFDDmn47g@mail.gmail.com>
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
Message-ID: <60fba046-0aef-3b25-1e7d-7e39f4884ffe@gmx.com>
Date:   Wed, 26 Feb 2020 12:37:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAAW2-Zfz8goOBCLovDpA7EtBwOsqKOAP5Ta_iS6KfDFDDmn47g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NXTPiWcAeMzpMVtgV05ywRtcFpQrSODTY"
X-Provags-ID: V03:K1:wJ4EtMk+hX9vf6Qv/4q84FVqgtZR0MkHqy4mREWLhOYPJsh+G3T
 WzsLGCcBh7UYrXqcJc2w+ySLexxjybXtdMOsRxaBFsS5TPYEJOX0lJeCl9StDA4ALAWSGKU
 0mjZ8EPBfJJ0NnXtx35pQVWHAEjl9OdNyC2Eoa6u88mYM8u5V6O/aBEeaoeQaGvA5SFkj/W
 9ZqJsetUmUrtvTlnjlgFw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qDxhsx2er+0=:WSNYZ7JN3mG6+lwUc7YXf3
 Dgs9iTgwXbjUHVu80ixuV3diXNOLRXSSr//ApWiO0XEggNm1RQvn+O0VkHhEosMSgJ1numZc9
 SuJrSoyCG3ZERuR5PexGwt7jJ3d4sMupIfo1ZfH3gv72SXAziK/R785Vg4fFcyA6ZNxuK0Z5h
 lx78WRaY8eJALRXaVgxQpNI8Yhf4ytWA7fpSolipc2xjReuj+GjqUcm6xK8kb6bzqCzxBjmF4
 rj34jA8MeP3XB4FJS07+HyujGVZck9U4rCYvW5btcbqsHhyr93NfVOYg8te4xJTwMySoJ1RlD
 Y9vKJFSd9uXdUVt5yREGokh+XrDyaDJdtncao5w2I1IAWckSLcsE2G3g8ytJ8K6CVNuKmP2iZ
 l3IMZmnim5DHn9PQ2Nzae4u2tjx+mcf35uhMz+3BRhPM9ENFTIITtRc3/1omsIB7OCES+XhdY
 w8xelfU+sM9zKcz0wVmd7gr8XqqpZWvMADu52PMkY4PGiQkBMBMdQ1L9t2DjqISURywdmzRqv
 SIXLX1BgLsnyDk3nGsKBLLgpCVVGdaWIEcJUKrnfW0BI4ROUYrcxCKU9fPyub0pmqr+QvEzsu
 vTxu14WidrluUofX3tBWrfnKxsUIPiQGWqiqh1wyl6zVyg1zrHqgchQKyQlvsWkkeOF0Sk0ly
 cv1vBCXAl7nM1Lj3i4Yf0rVhNxIongmntFLpSspSnk4hrKGqlRpW0RO56CuC4QTT7dLdwcVcf
 NWTTUAPRqyZ7wfRSAw3OQlSTtQKUa2TXl5qgEFxG6gl+p3ObC5Mpvs1nCA7Q+GT+mhpypxnI2
 u0Bgh7QOpVMmAR1rkB+xbT0LuU1qtQhHKdbAw3+2aPldEqdvWuQCkt5lkJyh/aM+K49iR1Adm
 2KJlZbB0P//zLrdy6I09cOthYllO38s9TeTHkwDB8E/+5YRsx0elRVm2aiu667Hpg8WXkD9NI
 71EvuF7noVwUZzH1kmuJKwtyx1Z9bUGHEqtUbdW1QEihpBitGFVKbyAeDh4xc3Rkqo0UrHPlE
 3cAkB8zR9g3lBM+BKoj0PYn9ow8YYmTBkp8Umj+5Ej9fIu7sJY6MlEjEJsNDBKW3xt3ebG5SO
 0MOvFMoJB8JMZBqJHRkrSTpFktfIQyNrKhNt8XLKcZlCvJMeh0t4oEu1yEjwhA7oHsWHI0qbK
 /CCh6zUvDrHA16tT6xDHZdfL96n/DCnx+hELKkvywDARo9Vh0v7xYCx7x6OufhdZqZtzuiwBx
 7dXWISBvAFXygRpAq
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NXTPiWcAeMzpMVtgV05ywRtcFpQrSODTY
Content-Type: multipart/mixed; boundary="b4p0zdAl9TPmCcmybJKjaGqL3esnPOtTd"

--b4p0zdAl9TPmCcmybJKjaGqL3esnPOtTd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/26 =E4=B8=8A=E5=8D=8811:38, Jonathan H wrote:
> On Tue, Feb 25, 2020 at 3:58 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>
>>
>>
>> On 2020/2/26 =E4=B8=8A=E5=8D=884:39, Jonathan H wrote:
>>> Hello everyone,
>>>
>>> Previously, I was running an array with six disks all connected via
>>> USB. I am running raid1c3 for metadata and raid6 for data, kernel
>>> 5.5.4-arch1-1 and btrfs --version v5.4, and I use bees for
>>> deduplication. Four of the six drives are stored in a single four-bay=

>>> enclosure. Due to my oversight, TLER was not enabled for any of the
>>> drives, so when one of them started failing, the enclosure was reset
>>> and all four drives were disconnected.
>>>
>>> After rebooting, the file system was still mountable. I saw some
>>> transid errors in dmesg,
>>
>> This means the fs is already corrupted.
>> If btrfs check is run before mount, it may provide some pretty good
>> debugging
>=20
> Here is the output from "btrfs check --check-data-csum": http://ix.io/2=
cH7

It's great that your metadata is safe.

>=20
>> Also the exact message for the transid error and some context would he=
lp
>> us to determine how serious the corruption is.
>=20
> Unfortunately, I can't reproduce the transid errors, since they seem
> to have been fixed. However, I do recall that the wanted and found
> generations numbers differed by less than a hundred?

So your previous transid may be a bad copy on your failing disk and
btrfs found it way to get next good copy.

The biggest concern is no longer a concern now.

>=20
>>> I noticed that almost all of the files give an I/O error when read,
>>> and similar kernel messages are generated, but with positive roots.
>>
>> Please give the exact dmesg.
>> Including all the messages for the same bytenr.
>=20
> Here is the dmesg: http://ix.io/2cH7

More context would be welcomed.

Anyway, even with more context, it may still lack the needed info as
such csum failure message is rate limited.

The mirror num 2 means it's the first rebuild try failed.

Since only the first rebuild try failed, and there are some corrected
data read, it looks btrfs can still rebuild the data.

Since you have already observed some EIO, it looks like write hole is
involved, screwing up the rebuild process.
But it's still very strange, as I'm expecting more mirror number other
than 2.
For your 6 disks with 1 bad disk, we still have 5 ways to rebuild data,
only showing mirror num 2 doesn't look correct to me.

>=20
>> Although I don't believe it's the hardware to blame, but you can still=

>> try to disable write cache on all related devices, as an experiment to=

>> rule out bad disk flush/fua behavior.
>=20
> I've disabled the write cashes for now.
>=20
BTW, since your free space cache is already corrupted, it's recommended
to clear the space cache.

For now, since it looks like write hole is involved, the only way to
solve the problem is to remove all offending files (including a super
large file in root 5).

You can use `btrfs inspect logical-resolve <bytenr> <mnt>" to see all
the involved files.

The full <bytenr> are the bytenr shown in btrfs check --check-data-csum
output.

Thanks,
Qu


--b4p0zdAl9TPmCcmybJKjaGqL3esnPOtTd--

--NXTPiWcAeMzpMVtgV05ywRtcFpQrSODTY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5V9hoACgkQwj2R86El
/qhUaggApY9bdvtcBmK5NYqJ9glWAQ4NZ62l4tjugNfHdaGX/8iVIWDN2f2BROiD
ttZF2/8vCvKu8v0kpsiO3dKGZV6BGBn8VN0mThMnkGf6HPNBoCkblLR1wGqoFteg
Hf6r5u7sG6rPnwYT6DWT07EWUHbVTsa7ygod7niTtwSEah13AZqdG/82nJplhQ2j
etu+J8EWWRbbb1cbQPRaW0fAns3lNe8opCpFwrYYie+RQT6w9cVAcOv+qGmxeiem
PY9b0uiJ27/7X33p+u+Be+S09bj1Z2Dk/BwMHxUR0+7nxBM6ev58KYueVzuGdAHz
xa74skyaqT6sJnh/Ll2P2qSGWnXDMw==
=XCjc
-----END PGP SIGNATURE-----

--NXTPiWcAeMzpMVtgV05ywRtcFpQrSODTY--
