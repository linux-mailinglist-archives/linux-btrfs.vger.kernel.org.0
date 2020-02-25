Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3CEA16F401
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2020 00:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgBYX6m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Feb 2020 18:58:42 -0500
Received: from mout.gmx.net ([212.227.15.19]:48977 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbgBYX6m (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Feb 2020 18:58:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582675120;
        bh=TdHcLWnQFgBZV/vul3xSvG3Rw8kkAhc/DhQEyNuqQ68=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=hOMTLkI7afvKZVIPukqPflHlOouI6Lr2StVp3/L2XOM11fHUwoB1drSbOWKNX4HBn
         Pp7K287ATW4BguWGa8oS8onwm+6W3RWvJLabeSKb3CF1SRw8NDYp+qWl+dZ3WalHT8
         kuNmfI7emyOkD0KBfiOXBUSsAxwKHsGyUN5F3WAM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M26rD-1j8g2b0A7l-002YVZ; Wed, 26
 Feb 2020 00:58:40 +0100
Subject: Re: USB reset + raid6 = majority of files unreadable
To:     Jonathan H <pythonnut@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAAW2-ZfunSiUscob==s6Pj+SpDjO6irBcyDtoOYarrJH1ychMQ@mail.gmail.com>
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
Message-ID: <2fe5be2b-16ed-14b8-ef40-ee8c17b2021c@gmx.com>
Date:   Wed, 26 Feb 2020 07:58:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAAW2-ZfunSiUscob==s6Pj+SpDjO6irBcyDtoOYarrJH1ychMQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Xfr6ApcR8MI8GXqbW2X7Ip5bpDIW3KAqK"
X-Provags-ID: V03:K1:1Wii5f390pS3XQndnUPC+CQ9o1JRckqeP6CBPnG+YkvB3oD+8Y4
 hkn+1a9mJtvJNbk4KW7oe/Tiy1zRZYLsSyeu46bGMCX3M5zjKpTZ2KL/t5PmPqj5GZHPKBl
 uIgC4mquA7JdxuEVfzuRUOyJcB1YzD+FZhFKZZLJieYEcb+OqLTAb6YIJLoQxw+z8+Z+8U8
 nWczMGArXlXMP4Sp2Qd6Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ctqfC3OWJlU=:R1lMBwlESPbncaf51cH+Ce
 VNBSQAqiqI2xvRpXMMjmuayBNj0tmd8jouyWKJhuZr14Dvarqp0UOciUsBBNMadOL/LVnCzle
 XWGesisKDKdAtM+uscoOP8Ckoan+S6OZuKRjKL653lEJVe6NedXEx2n1k0e5LwBXSHyud+0Vy
 PjIisbgEtqlH44Ew04GkMbZVjvPbWUHFviYrSef2BPJ3lLUzD8slTkMDVqMHSxDhTSQVzsEQe
 7uly/vKpfTGN2Tvhn9wNgas/Fh/lO/HIFkXI9khJpQ9SGns8RpNKv1/swORol8KJCWaYUIA6R
 HzDVmQDczpKLS68DVdjlesJKHtWdQr+oY3xd+wzSgABYw9s8HFoySMBTNr/c30SvmcZTDdvZI
 3E2H980C1c9Ck3BS6ULvKdqfIZUUUwlkYr4PdA/WDvXKkZ/fLLgv+iYmycHU+3Z5/1ZH+qL0O
 YYiMlwpXalWt3AC6V7deChBBH804UkQPZRgoqj+d6XADPybH5iTgebNyEZelrZHKRU0KGNSl8
 XHbFEUt9IIJc7KF0N32ufCkdyVV2syLWqZDuU1JqMad2RzVfsFtfLg6dhIRVICBJkcW4B6gRp
 fUrfW/dalgwD50SnexVFBSsHG9nw8HUqBASZ6Xvzqct5/HGQIqXro36Qyv89ebsKS1nARYuTs
 +sSDCj6Hn1D5oL7ClBwptSIN2/KKTbSSLz0qVCORVulQb+V55LzzSthaWEFg8mOcVqCdZYl2a
 H1diKj/brFGjkJScepuY+NKIw3dv0M4cXaBwTLT3xrB8shKaXCc8ojSGfUYdWmumbtyQzXKHS
 SWijyB42J3hCUFfqQkPsTQnPx1M3fe91qoEuVxBDcWv95UToosJAb1p09kT7pns4XBH/DcUeR
 KCB+Cvo/RoL4xDBr2L6TQ+byP44FzhtckqsrfkDlAx90bJpppehiSkYMvm7xP6G9yfn7ttikA
 wX6+kHeg/uLKfXE4JEEu8fUfMrZbYWVqU0GAfNsMC02Ajjtkr2db1sJPZqNhGh771uDim34a+
 p9K6hJPq0v6ET5lbgkA1z/I+RnrL+MauZ8ib/Z9NQclibxh9PXBc/kaFSZV2APZ2IfhN3jtsw
 5/E+Jh4qHdN4xuRDC2lEx+VYVas27XgwHOEV008U7jBQbBOwMW/b3tuuwt3AiQBf0LgClTFEP
 HOAWSx0hib9h020PLckJOSPq5GVg4VD7yutJGdfW698RQwd/SmG7Z+P09JbbsB4bVL5uPDOAP
 sCQP+C74G6/3jBho3
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xfr6ApcR8MI8GXqbW2X7Ip5bpDIW3KAqK
Content-Type: multipart/mixed; boundary="ScErI3lawQw4bmTtXkxAQRpxy6vLru5Ef"

--ScErI3lawQw4bmTtXkxAQRpxy6vLru5Ef
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/26 =E4=B8=8A=E5=8D=884:39, Jonathan H wrote:
> Hello everyone,
>=20
> Previously, I was running an array with six disks all connected via
> USB. I am running raid1c3 for metadata and raid6 for data, kernel
> 5.5.4-arch1-1 and btrfs --version v5.4, and I use bees for
> deduplication. Four of the six drives are stored in a single four-bay
> enclosure. Due to my oversight, TLER was not enabled for any of the
> drives, so when one of them started failing, the enclosure was reset
> and all four drives were disconnected.
>=20
> After rebooting, the file system was still mountable. I saw some
> transid errors in dmesg,

This means the fs is already corrupted.
If btrfs check is run before mount, it may provide some pretty good
debugging info.

Also the exact message for the transid error and some context would help
us to determine how serious the corruption is.

> but I didn't really pay attention to them
> because I was trying to get rid of the now failed drive. I tried to
> "btrfs replace" the drive with a different one, but the replace
> stopped making progress because all reads to the dead drive in a
> certain location were failing (even with the "-r") flag. So I tried
> mounting degraded without the dead drive and doing "btrfs dev delete
> missing" instead. The deletion failed with the following kernel
> message:
>=20
> [  +2.697798] BTRFS warning (device sdb): csum failed root -9 ino 257
> off 2083160064 csum 0xd0a0b14c expected csum 0x7f3ec5ab mirror 1
> [  +0.003381] BTRFS warning (device sdb): csum failed root -9 ino 257
> off 2083160064 csum 0xd0a0b14c expected csum 0x7f3ec5ab mirror 2
> [  +0.002514] BTRFS warning (device sdb): csum failed root -9 ino 257
> off 2083160064 csum 0xd0a0b14c expected csum 0x7f3ec5ab mirror 4
> [  +0.000543] BTRFS warning (device sdb): csum failed root -9 ino 257
> off 2083160064 csum 0xd0a0b14c expected csum 0x7f3ec5ab mirror 1
> [  +0.001170] BTRFS warning (device sdb): csum failed root -9 ino 257
> off 2083160064 csum 0xd0a0b14c expected csum 0x7f3ec5ab mirror 2
> [  +0.001151] BTRFS warning (device sdb): csum failed root -9 ino 257
> off 2083160064 csum 0xd0a0b14c expected csum 0x7f3ec5ab mirror 4

This is a different error.
This means data reloc tree is corrupted.
This somewhat looks like an existing bug. especially when all rebuild
result the same csum.

>=20
> I noticed that almost all of the files give an I/O error when read,
> and similar kernel messages are generated, but with positive roots.

Please give the exact dmesg.
Including all the messages for the same bytenr.

> I
> also see "read error corrected" messages, but
> if I try to read the files again, I the exact same messages are
> printed again, which seems to suggest that the errors haven't really
> been corrected? (But maybe this is intended behavior.)
>=20
> I also attempted to use "btrfs restore" to recover the files, but
> almost all of the files produce "ERROR: zstd decompress failed Unknown
> frame descriptor" and the recovery does not succeed.
>=20
> Since, then, I have been scrubbing the file system. The first scrub
> produce lots of Uncorrectable read errors and several hundred csum
> errors. I'm assuming the read errors are due to the missing drive. The
> puzzling thing is, the scrub can "complete" (actually, it is aborted
> after it completes on all drives but the missing one) and I can delete
> all of the files with unrecoverable csum errors, but all of the issues
> above persist. I can then turn around scrub again, and the scrub will
> find new csum errors, which seems bizarre to me, since I would have
> expected them all to be fixed. However, all transid related errors
> have disappeared after the first scrub.
>=20
> I have also tried deleting the file referenced in the device deletion
> error and restarting the deletion. This seems to be working, but
> progress has been very slow and I fear I'll have to delete all of the
> I/O error-producing files above, which I would like to avoid if
> possible.
>=20
> What should I do in this situation and how can I avoid this in the futu=
re?

Although I don't believe it's the hardware to blame, but you can still
try to disable write cache on all related devices, as an experiment to
rule out bad disk flush/fua behavior.

Thanks,
Qu

>=20
> Thanks,
> Jonathan
>=20


--ScErI3lawQw4bmTtXkxAQRpxy6vLru5Ef--

--Xfr6ApcR8MI8GXqbW2X7Ip5bpDIW3KAqK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5VtK0ACgkQwj2R86El
/qgnnAgAh7QtFxKaO8ozVhsE3FYZFVApUOmeWTNBuZO7FeRb6XsJ58Adg8W/DfV0
zFu4pTcPIP7VARv7ZTyc4TvmiLkv84Uqx1SzcBfZ/hLr6kO7zrpWNAMQZPyVHRQG
sfPvhHlxeAgN/wTed6eNGQAerrdZfqDu4j1cp9JkWBaiwhD41xwFqluzO8PyBnaz
CywrLHGnSPWuExTinSPx0wF5OqjAbPo+M7BSEZ8eWuTJAdUkLhMplk2u6CzDvjuz
p8zemZrHxy6jb2ntXCmyMnEn7bj+KR7wTc3gCOPXD/F0xTSkn+yXayM8OhEKRF3K
5qlStALg4TbMB5p92Iakb1JM5hLbZw==
=xw8F
-----END PGP SIGNATURE-----

--Xfr6ApcR8MI8GXqbW2X7Ip5bpDIW3KAqK--
