Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C953172F0A
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2020 04:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbgB1DB0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Feb 2020 22:01:26 -0500
Received: from mout.gmx.net ([212.227.15.19]:40427 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730445AbgB1DB0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Feb 2020 22:01:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582858883;
        bh=v+v7Z7Dq9IkgXEJ+jEfxXtR/cbNAiOUz6wLL9hJdzd0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fa+ir472FZqZOUTEY0ywkqBKwDt4fVCK8V/dJXKh/EUVEeRdim9xLZMgfWRttlfPq
         5yXtEEb1weccSe4yozgHJ/ioYKWgg7i3SRfvxNgegqXEYeB/3zXmbIrixY8XqdfokD
         4dOlkqJNAl+l/iinm9wglocFQC/qqogTNXJRvR40=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mwwdl-1jJIGO0Sl9-00yQGg; Fri, 28
 Feb 2020 04:01:23 +0100
Subject: Re: corrupt leaf
To:     4e868df3 <4e868df3@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CADq=pg=g47zrfKiqGFUHOJg8=+bdSGQeawihKcVcp_BahzPT+Q@mail.gmail.com>
 <587446db-5168-d91d-c1fa-c7bef48959d9@gmx.com>
 <CADq=pgn3-4S3ErK0G+ajf-5M=8CSaE6iow25ASaBxCygedy=7g@mail.gmail.com>
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
Message-ID: <2ffbf268-437c-b90e-21f3-7ea44aa9e7e6@gmx.com>
Date:   Fri, 28 Feb 2020 11:01:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CADq=pgn3-4S3ErK0G+ajf-5M=8CSaE6iow25ASaBxCygedy=7g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HAHd3HpUOMsLuntoHov0FJqCZLRY808sL"
X-Provags-ID: V03:K1:EhMJ/yvmONFWk7BfYKPsDQvrCNpm/1cZs+fuZed6dSK5KFqV/h4
 QsvTmlUHwH880fuLNLHuS7BQYFYuhdBoR4KRn9/0j8F1l3nUqOggy8bqCF0arwvEuLdyVQ/
 1t7X9J0j7tGIy7qP4swUXKhQXRF4tvEYdJ2elKvyMjiE206l+KPc1VbDuAyzAIZkvODpq9m
 v/5zaF5V5/EzbU13WSK/w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RZZvKbxFfx8=:pdYvS70DR4FWj41m0bU5jD
 fkOOB9YKIMJmNt1fbxBNwvOIfB/0xHdynmaomxsv+joQaTFy3EqN2lL6t5QU8ESMEygpByYid
 pjs5miH7Zs0/OrzlxJ8yB8lzv66pi6ElZu92ZfE0iK1H5gBUT9UFYjZksHcxG4bZHjX23htk+
 wkLQVQT00VQZ9lV6IgdKG18YpEevSvREr3f8DyxNZjtyrRj5O/JGFOiE54OWJLtITH1ElRs1k
 hNBfjxFwe9P4F+nxjZPmUDDANU+zKJkkjJuOLTCcrJ4xpNdCx7Zd7Ze4EGaSuRMTnJjiMxNnR
 XBYoDwZ9RtOlnoOC+uHt19nnzf/KxW3VKctV05LhcW3uPwiJcZeQY8rKY7hDM5pKb3rPLQsJD
 qcOS23GMrHL42RwmCAAdIAeu77+dQs1kEV/q0jmhPu7F5HFbl6F1TM/CEa+LCFfYTXvrAUB+I
 qSM4bGTJRiAJcWhW76UeaVgrIHKrQBT5+osqZGS1bsy6fBoHodaso7ODzYRJKmAkxVonQE2fE
 Nydqm/6iZL1RoC1QMpQYpFutGbHCv5iTWb6LGb3TP8Q6DZavLFMkeYyHyXhpjb8VkfOkrPWNj
 PNUNfV4rFZitLjYOeDu7eWpx/yuuegWbHLzlrOHegCEBYP0GEuN09UXTMjWmRuCxriqea52EN
 H8zkPi1xgFfInsRG08C1/GY6OQbZEWzaDszlWfv7Lx/sWa6i474zpdrehmGaZJNSqoz5kw/zo
 Bho/Thj4F/6pZuVIPJ3aI1q3fpwkazDc96uQ0Tu6oWltmsn3MISskN9eAjTJgQB1qIMekbMAu
 hGHvyDNsVn1KPcaL2i5nacPdelMutiyB2qJWetF9Y+Wz91WKoXEARlPQUi0i8AlBYggRuphEs
 pczrJCCK229SH9Qw/ADLNKPYLyyvPHKANVTIgPfqG322wkMNKbTfIu2iD+8G/PBmQkp2YTmAy
 GLCgMbQhaL4b+7ZFGJy0zlwyodnCHs4PLVlzUUG5ON9mOYiMGLDJrMUm19lJ3lzfPW9PpPO62
 UnDllrE1jU0l+7h5abZcJuplY9gi3XSibScAQOEpEwEv+FksVPNCK6i24hm9/VRPnVfWLieBR
 qazQFccIorfQpuMWH57q/zEezNfQkLMB1lPD9XszR3oFQYY0ahzqcOmI68EEzpGjM/06wJ2TJ
 zaBAkh8WXy4axDvRvaV1ekP3/fvY4hLwDpfolTNh+fzOnRjobFs0Q/CuazzNr+xU/I2CHf2MP
 ZXGvjJ60rVBQwkHk7
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HAHd3HpUOMsLuntoHov0FJqCZLRY808sL
Content-Type: multipart/mixed; boundary="IxXNcliQUak9HuIOuxQIgsC3RSp3CBod7"

--IxXNcliQUak9HuIOuxQIgsC3RSp3CBod7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/28 =E4=B8=8A=E5=8D=8810:28, 4e868df3 wrote:
>> What are the details of the storage stack? What are the Btrfs devices =
backed by on the host? Physical partitions, or qcow2, or raw files? If th=
ey are files, is chattr +C set?
> 6x 2tb scsi drives. Raw physical partitions, working through LUKS.
> Proxmox passes the devices directly through to the VM without touching
> them.
>=20
>> btrfs ins dump-tree -b 2533706842112 /dev/dm-0
> btrfs-progs v5.4
> leaf 2533706842112 items 9 free space 5914 generation 360253 owner CSUM=
_TREE
> leaf 2533706842112 flags 0x1(WRITTEN) backref revision 1
> fs uuid 8c1dea88-fa40-4e6e-a1a1-214ea6bcdb00
> chunk uuid c3b187d2-64c1-46f0-a83f-d0aeb0e37fe4
>         item 0 key (EXTENT_CSUM EXTENT_CSUM 68754231296) itemoff 16279
> itemsize 4
>                 range start 68754231296 end 68754235392 length 4096
>         item 1 key (EXTENT_CSUM EXTENT_CSUM 68754235392) itemoff 13167
> itemsize 3112
>                 range start 68754235392 end 68757422080 length 3186688
>         item 2 key (EXTENT_CSUM EXTENT_CSUM 68757422080) itemoff 12891
> itemsize 276
>                 range start 68757422080 end 68757704704 length 282624
>         item 3 key (EXTENT_CSUM EXTENT_CSUM 68757819392) itemoff 12767
> itemsize 124
>                 range start 68757819392 end 68757946368 length 126976
>         item 4 key (EXTENT_CSUM EXTENT_CSUM 68757946368) itemoff 11359
> itemsize 1408
>                 range start 68757946368 end 68759388160 length 1441792
>         item 5 key (EXTENT_CSUM EXTENT_CSUM 68759388160) itemoff 9567
> itemsize 1792
>                 range start 68759388160 end 68761223168 length 1835008

This csum item is too large, overlapping the next item.
Doesn't looks like a bit flip, as the item size still matches.

>         item 6 key (EXTENT_CSUM EXTENT_CSUM 68761178112) itemoff 9363
> itemsize 204
>                 range start 68761178112 end 68761387008 length 208896
>         item 7 key (EXTENT_CSUM EXTENT_CSUM 68761387008) itemoff 7739
> itemsize 1624
>                 range start 68761387008 end 68763049984 length 1662976
>         item 8 key (EXTENT_CSUM EXTENT_CSUM 68763049984) itemoff 6139
> itemsize 1600
>                 range start 68763049984 end 68764688384 length 1638400
>=20
>> btrfs check --force /dev/mapper/luks0
> Opening filesystem to check...
> WARNING: filesystem mounted, continuing because of --force
> Checking filesystem on /dev/mapper/luks0
> UUID: 8c1dea88-fa40-4e6e-a1a1-214ea6bcdb00
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> there are no extents for csum range 68757573632-68757704704
> Right section didn't have a record
> there are no extents for csum range 68754427904-68757704704
> csum exists for 68750639104-68757704704 but there is no extent record
> there are no extents for csum range 68760719360-68761223168
> Right section didn't have a record
> there are no extents for csum range 68757819392-68761223168
> csum exists for 68757819392-68761223168 but there is no extent record
> there are no extents for csum range 68761362432-68761378816
> Right section didn't have a record
> there are no extents for csum range 68761178112-68836831232
> csum exists for 68761178112-68836831232 but there is no extent record
> there are no extents for csum range 1168638763008-1168638803968
> csum exists for 1168638763008-1168645861376 but there is no extent reco=
rd
> ERROR: errors found in csum tree

Since the csum error is the only error, you can fix it by
--init-csum-tree option from btrfs check.

Thanks,
Qu

> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 3165125918720 bytes used, error(s) found
> total csum bytes: 3085473228
> total tree bytes: 4791877632
> total fs tree bytes: 1177714688
> total extent tree bytes: 94617600
> btree space waste bytes: 492319296
> file data blocks allocated: 3160334041088
>  referenced 3157401378816
>=20


--IxXNcliQUak9HuIOuxQIgsC3RSp3CBod7--

--HAHd3HpUOMsLuntoHov0FJqCZLRY808sL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5YgoAACgkQwj2R86El
/qjkzAf/VdwVXFTd8FGmCVRHFF1fJtyCL9cLYAnDxA1k6cRWc6m9b/2QDLZIzwcF
wv+BX6Oiy5XG0kreCn9FnWnp60jYjDEbDddq1W/PzBskgHf+FBHGHPItSZ4IeXxD
Io0JE/GNKQbf9vTiyU4/72scxWUp7i3fj5e3vZStjnkOBWDaGx1fQ1QG1mf4ID1+
Nj9to+ZALpd6s9SN23b5KtpZT1CFFjpHbSQXrTDTeba7XvuRN+RftYaHHQThf2gL
rC9562ubEhesF5x145dsdJyEOpEsC3+h1WhDvc1kdp82blpD/23PtryWkEuAOqQ8
ihxEcoWqZ2tClJrSIpGidSuQLnjliA==
=k9O1
-----END PGP SIGNATURE-----

--HAHd3HpUOMsLuntoHov0FJqCZLRY808sL--
