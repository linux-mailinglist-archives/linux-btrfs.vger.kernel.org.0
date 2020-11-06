Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02BF2A9450
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 11:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgKFK2H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 05:28:07 -0500
Received: from mout.gmx.net ([212.227.15.19]:52523 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbgKFK2G (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Nov 2020 05:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604658478;
        bh=9ClhbrcriufpwVl36AGNTigR6Vn2qHY1lruSX9xQZXA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=B5xhKtHVkGk/FQ76AUhGxjz4C2GEmAF8ZWKZteg5q9VUHThY7x/hKb2cZrs5NqOut
         OyQrQz64Pa1mRyBcB8oCc/lcI4kiy8KyyICa/On6MG2XGUGEpo5CoiBgPXJ6P6vZ89
         rR3rUmDn0vSoWhcJ/03adVMjxe+oDq5psBQ2VGDQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MfpOd-1k8Gvc2Ikz-00gI4i; Fri, 06
 Nov 2020 11:27:58 +0100
Subject: Re: Fwd: Read time tree block corruption detected
To:     Ferry Toth <fntoth@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Tyler Richmond <t.d.richmond@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
 <CAJheHN1+AQR-irSbaH8f7HGj=rDN4+uUCyqjvtezGewQkQoDpg@mail.gmail.com>
 <5346c4af-c73e-84b3-ec4f-8f169c0a732a@gmx.com>
 <CAJheHN0NmgVoGF+AsnUNQkQnEJ46JCmpg4o5nwAkqi+VoGMjfw@mail.gmail.com>
 <e04680b4-f4c0-254f-24ba-f2053e4ad8b3@gmx.com>
 <CAJheHN0THhKcqKY3cGtJqUGaub=E0tuCmi6wuNeCGBxyAHmecQ@mail.gmail.com>
 <e2c8eaaf-6adb-374f-4005-a1edcbcb8f79@gmx.com>
 <CAJheHN1U4j1KsD96oFuCVwP+6RVP6V6oAZP-aGOTtfm7tDL3BA@mail.gmail.com>
 <CAJheHN3pTj-6dOQZVKqA_r38F+WVNrjVO6-Z_hFeq96uTNK5zw@mail.gmail.com>
 <1f26ff53-f7c7-c497-b69f-8a3e5d8ce959@gmx.com>
 <b7383762-4a86-fdb9-12f3-89470808f4e6@gmail.com>
 <0d6a0602-897a-b170-f1a2-007cff1f23fb@gmx.com>
 <134e61b5-ecf7-bc1a-e16b-c95b14876e6e@gmail.com>
 <5b757c2b-6dbf-cbec-6c66-e4b14897f53c@gmx.com>
 <838490cf-fc40-0008-88bb-eeede1e8d873@gmail.com>
 <50e0ef4d-061e-d02d-9dbf-61f83dfa7b3e@suse.com>
 <117797ff-c28b-c755-da17-fb7ce3169f0f@gmail.com>
 <51578ec7-f2e5-a09a-520e-f0577300d5ce@gmx.com>
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
Message-ID: <d8d1f615-bc9f-90c2-d851-9497348af284@gmx.com>
Date:   Fri, 6 Nov 2020 18:27:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <51578ec7-f2e5-a09a-520e-f0577300d5ce@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="suyIBHXRgdLlasL07mB7D4FQedQddgJkV"
X-Provags-ID: V03:K1:A9wu0TWxEmM7G+l7YEK3h/Ai4OPm0YsiXC0MHtdhWD0lqOK2RUz
 Uc+SbmwkCmZ/uMES7llq/fcE+QXTyQa/h+TgzKgSdllnQNN8ZXAgiyPfBzUFKZbm/J7UENY
 e22DpnKRjFAOWF/KPbdFsMs6FEmp5F+zesZACWk1N5mhl27KZRztDwzWJmmLV3vOjFU3rnT
 gbdZ82WX1GVxNXdx7k+vw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JBOq8JgS6Gk=:QwHCl3Vwx+sgC5ThNZ01Em
 bHXQjAFBC2yEbhsovbUgYTCuAT2BGw1aOFwdcXxeMhuxhIrUaqFEEceKidZUsAiW14bF0M2m3
 NWiXVfoCFxnHMLca6nwThZqQWi0JpgJVMLK0vUS7Z/Elt4rS3vtkcdcny040FzXqTQ+0sbXTw
 Ej8cL3LHhcdG095IRhnKtlwiRa+cd4MxsLLJdZR34Eq7XIi+GYwu6UCRR29RNfnoh4extYxLt
 EgolHfguOBHxkPwylb5z5uRXzKipRphT5078D+UyKmVbayVd9jrfdXT2Y1bwLLDm3XAlK7FTl
 sgRVb6lnRO15QZ3y29n/U7OoD4b10z11Ow9+fQl+L7OgAKa1ppLXLsFCz8dtx3MFoQIYhajmL
 qXen9RheSmhtLys8JXtvjPDqCynvYGRdL0CXqXaLr8UBXlJdrNQapBSjrB4KCjOP1Y4P/DOwn
 Y7bUQotrG+9yd2KX7v8e/IypKGn0m1XHefHHa67bVX0K1TnMzn1RKTfYV1CRMd/XbqasnlFlG
 qXo4t/4HnXvivOyphvsHu8m0cJZHZF4O/U1yIOgkMBcMsly0iF2jhNIVCkRW4r9q5ctK8jUg5
 G38Rr3/B8SsPpsom8SlgJ4h47pogR27AiYRZ6qYGaJnsIyyehLBhvOR66XQAjCnjRZkqrLxHA
 GvGHntwarIPYxwScTda4UzpZ5H13GMAux2NYaE6oxpRVLRMrWjyNK31bI/S7PEBt8lbGUpIxF
 qCvrxe4GSpTQKi/sS1wxwsm7SAhWT3nipEyE6o4YwWvYEUClIeE8ew3NL6YbEWclb+CXIZAQO
 PTcs/GuNpZCIjd/qEJhL+WkS3eh5tbyz8w2ZDEmEKZ3oYRy/hchrY0uDhlaSzRfFlD7ZDqtRB
 jOZTZjJdB0mgl92GjY9Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--suyIBHXRgdLlasL07mB7D4FQedQddgJkV
Content-Type: multipart/mixed; boundary="ZavhvyGWzjrDS2dGsmQQBsLaliXYleEbO"

--ZavhvyGWzjrDS2dGsmQQBsLaliXYleEbO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable


>> BTRFS critical (device sda2): corrupt leaf: root=3D294 block=3D1169152=
675840
>> slot=3D1 ino=3D915987, invalid inode generation: has 18446744073709551=
492
>> expect [0, 5852829]
>> BTRFS error (device sda2): block=3D1169152675840 read time tree block
>> corruption detected
>>
>> So how do I repair this? Am I doing something wrong?
>=20
> Please provide the following dump:
> btrfs ins dump-tree -b 1169152675840 /dev/sda2
>=20
> Feel free to remove the filenames in the dump.
>=20
> And 'btrfs check /dev/sda2' output after the repair.
>=20
> As a workaround, you can use older kernel (v5.2 at most) to temporary
> ignore the problem.
>=20
> Thanks,
> Qu
>=20
>>
>>>>> THanks,
>>>>> Qu
>>>>>>> Thanks,
>>>>>>> Qu
>>>>>>>
>>>>>>>> Linux =3D 5.6.0-1032-oem

Wait, it's just v5.6??

Then that means, the error message can be wrong. Both transid and inode
generation error could be output as "inode generation error".

And to repair inode transid, the repair ability is not yet merged into
upstream btrfs-progs.

You can use the out-of-tree branch to repair it:
https://github.com/adam900710/btrfs-progs/tree/inode_transid

I'm afraid you have to build the btrfs-progs in liveUSB environment to
repair it...

I need to re-push the branch to make it into upstream.

Thanks,
Qu


--ZavhvyGWzjrDS2dGsmQQBsLaliXYleEbO--

--suyIBHXRgdLlasL07mB7D4FQedQddgJkV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+lJSkACgkQwj2R86El
/qhGegf6AwAEU8qtydIVF3WGeMVd0m5Fqb/yGQjkQrdpkFbJfl4bg67edtUF8CDs
tr3aN/7v3e8r6HSfPuufCIoZinLnWEkq96L6fl2XgYlAGFM1E/g14L3a6Xswxirg
J+ITmDzUUBFekbFvgeNM7tt0SIAbJ+VdGOX/NGkKXVaX/W7LlPmegpPyPnWslrxo
409/UCord0gC2EZWcN6yyh8kLJa8LqJ9U3ZS/xcMNiXHszN2OtGzh+iW6juEzsgs
vfyr2KkJf4A6D9M+tBXHsF9SUrp8vonwjDI9xm9hAVd4pzg4eWVr+pSZvYt6CxqG
s9F/F0KqZ1Ddg8Et1Ybf1V5P0TYh4Q==
=USe5
-----END PGP SIGNATURE-----

--suyIBHXRgdLlasL07mB7D4FQedQddgJkV--
