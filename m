Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B99214C56
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jul 2020 14:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgGEMKi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jul 2020 08:10:38 -0400
Received: from mout.gmx.net ([212.227.17.22]:54871 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgGEMKh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 Jul 2020 08:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593951035;
        bh=drjCcEGSJCJlHSo1wzlL7UKNXpJQDi4k+6bYq03cWfU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=V2jbzPjTHCm9fhdZBIu9LAeChpEDofLXO8/hp4HqlTcM3OdIZ1cxj7rgTzMb6dPN/
         2jOTkv5X7rb0RoZUrOILQoLDD+jxYiZf4QWyJgqbA1FHBdf5LhUkEFT4Ay0HR6H+Sh
         uUGVNe7zBarPly/G3MSviFOUQxbcp4vQo3gJZDig=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MC30P-1k3vR13EbN-00CSdk; Sun, 05
 Jul 2020 14:10:35 +0200
Subject: Re: Growing number of "invalid tree nritems" errors
To:     Thilo-Alexander Ginkel <thilo@ginkel.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CANvSZQ_5p4JD4v79gFkSRBBvehCDh_Q5bBKeyNi912tr0biNLg@mail.gmail.com>
 <90c7edc7-9b1d-294f-5996-9353698cedbe@gmx.com>
 <CANvSZQ_HDZ=54MW+dSAP1A_zUiaGR_PLkV7anQj5K+qNds0QsQ@mail.gmail.com>
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
Message-ID: <2483ed80-90ae-765d-e3d3-15042503841c@gmx.com>
Date:   Sun, 5 Jul 2020 20:10:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CANvSZQ_HDZ=54MW+dSAP1A_zUiaGR_PLkV7anQj5K+qNds0QsQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6Q9nEavkZBbsmx64JKgQZvT4NSY8KvygV"
X-Provags-ID: V03:K1:q1/Z/IPdARhnVhdS8XPqL977xAvricqHacq+RjPnCNOr4Rvffxh
 eHbUzg2AHSVlsaTc0IXM5N/lS9Ah7FquDrYA1wO0plsSZnhVSLDLzddGBlNl6czx63PdDgd
 zdDkSFoQbGzoufHOggWtFd7UgGXjv96vqgNjEA1E4dsyalYlwfo9Kazlso6c0opg2hVzdc1
 PzkrgJrXkSZh7eCdFStNQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wcNfYADANdI=:aFSTMEv3SwQu4Njlo8s+U/
 yPBZpD6834jqf8kiAi+GEkA2ogEZETNkR1z9hM7mrZi53zpwLZymA3tGqcK74vULlM8HpguHx
 /nZWvdz9DSmRauwoNV9isANpFB/ToJ/jnTeJIQ2kOBegVYlzJjAZVR/wmICBS88XlXcjmJhMW
 t9stOVAl4IJIM6WwfLG6gt/D22nOaF+rMgDcaWln7qVknfmaSobY0vHHWKg5dumeziwltj8tj
 PpVQjeoDm/18Gdk4BQ2gZgxPBsKbeO8kuq2jhfdDKNb+kXXhpaO15JlGEr6QS/DXHbGjLcPZG
 ++kqfGo0ZLN6wLo7xrT1Angw9cyx4v/jwSFKSQzrlPp8AAOInVF4z3SRFywcyqJS4BC/47Yl5
 vi5cwPIH9A+mIMF/XAO0/x3SeahgTgv5Vce2jSlWRqKoMJdKEHOKZLun70HoUqQqcENjlD/3W
 Tg3rL6/WIh0Py8PJ/Ae0drzGjeJlQOInBS/BjDDj7xylYZdsCH7l6FzBZYywm6M51jCRAIZEA
 +zpeK82lx6kJBtB/MefWLdoHF9xZJdqEQIMHIjBWqxJ2QOdjM4kcvHFDz/qP1zKlRc369KCVs
 hbVyZYTs1duvqliy9QXrcLjpxxg2nIKfobNK3hfFJPLpH2wbDPdXmoYEPGaodUsop3trEJl0e
 AuNsoJ4zfVBmbdhi/2Qkwc4xoiq6MrhiwyPifGCqH8SEIgS4VxwEdghQMMCFFbzq+XdJ7ye6W
 qauxa2QVdSGIodXGZptVrT0mnKD++e7UXEMo2yPw4OGjQh96HWSWZjSLHzwKJsut+qr/tTkf9
 eDFjdEIMMlrzdNtYEjkjfCdE6Bs67lxci5FRAx7foZB3BSr+Sdvi/oHImYGvATcVgp3hsFlsB
 n9Prq3LFyL07iUfmno/AQ+vM+Box0aBssjiw2kT+sOByVPE3gJLj8kbPJik1JikRIBmugH/6l
 pHd2iZA+TUXD+NX4E9nah03gzgOAvU+JGognikBOQ+fz7GoUG+f5zKle3glF1EGNaGy7zMX8C
 m9skr7pFtrIR7exTZD3VQmcGiYveNUVzFXbCAxYtRL2PAKs5a5FsuYgDg6nBMi/FHPf5cuCl1
 FwiF7POgrxSHeCn1IMxD3soIYehZ/CEHbHX+HTdi/tBUcZAr+6jvnBeqz73JrQyYVGj9mCrnI
 TNgI5vWN0OAhBKNEgrj5o3xrVFucoPRb29iAw2vLb8s9zo+HdTDJ9mpKMBhv9R33FXv4wrClK
 /7gzDaRe+/WSUJNVV
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6Q9nEavkZBbsmx64JKgQZvT4NSY8KvygV
Content-Type: multipart/mixed; boundary="e0hAj9liRGImHQ0ETKjDwoCI6xdXUnKKJ"

--e0hAj9liRGImHQ0ETKjDwoCI6xdXUnKKJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/5 =E4=B8=8B=E5=8D=886:30, Thilo-Alexander Ginkel wrote:
> On Sun, Jul 5, 2020 at 11:53 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>> How producible is this?
>=20
> I did some log analysis: The problem started showing up on two of
> three servers starting July 3rd, 2020. This coincides with an applied
> Ubuntu Linux kernel update to 4.15.0-109-generic whose changelog shows
> plenty of btrfs changes:
> https://launchpad.net/ubuntu/+source/linux/4.15.0-109.110

So it backported all these restrict self check of recent kernels.

That's great to expose any unexpected metadata.
Although sometimes backport itself may introduce new bugs (very rare),
especially for heavy backported kernels.

So if it's possible, try upstream kernel can also be an alternative to
test if it's really something wrong.

Another factor involved is btrfs-progs version, which normally gets less
backports, while upstream normally have more strict checks overall.
So trying upstream btrfs-check would also be a good idea if possible.

>=20
> Server #2 (still online) shows 16 error messages in its log since
> 2020-07-03 whereas server #3 shows 310 error messages.

Then it shouldn't be a hardware problem unless all servers have the same
problem.

In such cases, I would recommend to try upstream kernels first,
especially when the heavily backported kernels are involved.

If you can reproduce it with upstream kernel, then I strongly recommend
to use that mentioned diff to provide more info to debug, as it would be
a false alert.

>=20
> On thing special about server #3 is that its btrfs file system has a
> huge metadata section (probably due to it hosting many [~ 50 Mio]
> small files), which doesn't seem too healthy:
>=20
> # btrfs filesystem usage /mnt
> Overall:
>     Device size:                 476.30GiB
>     Device allocated:            372.02GiB
>     Device unallocated:          104.28GiB
>     Device missing:                  0.00B
>     Used:                        272.16GiB
>     Free (estimated):            194.49GiB      (min: 194.49GiB)
>     Data ratio:                       1.00
>     Metadata ratio:                   1.00
>     Global reserve:              512.00MiB      (used: 0.00B)
>=20
> Data,single: Size:284.01GiB, Used:193.80GiB
>    /dev/mapper/luks      284.01GiB
>=20
> Metadata,single: Size:88.01GiB, Used:78.36GiB
>    /dev/mapper/luks       88.01GiB

In fact, your metadata is not that unhealthy.

>=20
> System,single: Size:4.00MiB, Used:80.00KiB
>    /dev/mapper/luks        4.00MiB
>=20
> Unallocated:
>    /dev/mapper/luks      104.28GiB

And there are plenty unallocated space, so your fs looks pretty healthy
instead.

Thanks,
Qu
>=20
>> If it still shows the same symptom after verifying the RAM, would you
>> please apply this small debug diff on your kernel?
>=20
> I'll see what I can do.
>=20
> Thanks,
> Thilo
>=20


--e0hAj9liRGImHQ0ETKjDwoCI6xdXUnKKJ--

--6Q9nEavkZBbsmx64JKgQZvT4NSY8KvygV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8BwzgACgkQwj2R86El
/qjpsAf/euEfh5bDEE9MxUCzw3gzms4s3pNhN5xF3JbHPksGwAK4KHjTlGKnXIyN
WOLuPNNUAL3FLE4SanbNgbJV8QMrNsL5TZk63OJwuet7mglqw1fKWssKr5+1Bwvo
cKSwjG5FLLQRJ715f2radRwHGJJF8rHMQvaO8xecPbKKW2qNDnBkFUo+0Jr5SRyJ
NnqPs5aIDB8X2fZhBWGS5tQXPf4L+Mq3KDJKq9q52NexAatZLPuaa05bk4hcwixA
zU728xhEb2hbWsJ5KDc88kzgYhGSPdq2pkR0kLGkZliwher7DB9zkTjxhxYYy6et
QvHSRCF0cmjHfQ5337nUi+c+EYuPCQ==
=j793
-----END PGP SIGNATURE-----

--6Q9nEavkZBbsmx64JKgQZvT4NSY8KvygV--
