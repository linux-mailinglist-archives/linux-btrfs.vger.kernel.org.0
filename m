Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBB881305AF
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jan 2020 05:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgAEEZ4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Jan 2020 23:25:56 -0500
Received: from mout.gmx.net ([212.227.15.15]:55355 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbgAEEZ4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 4 Jan 2020 23:25:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578198341;
        bh=XSw22TSIHdIHyUQztiJYmZ+o1L4K2bJnAAmOvDEgHcs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=h57YFTM4DzcnuhyPN1iGlzUne9Kd91LH4F44fQ+TVnhcuoD0subV4Rnf3UX2xx3uX
         bq7I7pWuQ9Es/FdO5twzdQ3eIM7dtfGF/B5JuL2wB3UENG3C4m8ULiaf8XZUziJtdZ
         CtIKun3LaXZmOryBWFQvLlHidl2fLQnOjLnETGS0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MMGN2-1j78Uc2yUY-00JHjU; Sun, 05
 Jan 2020 05:25:41 +0100
Subject: Re: 12 TB btrfs file system on virtual machine broke again
To:     Christian Wimmer <telefonchris@icloud.com>
Cc:     Qu WenRuo <wqu@suse.com>, Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20191206034406.40167-1-wqu@suse.com>
 <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com>
 <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com>
 <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <9FB359ED-EAD4-41DD-B846-1422F2DC4242@icloud.com>
 <256D0504-6AEE-4A0E-9C62-CDF975FDE32D@icloud.com>
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
Message-ID: <e04d1937-d70c-c891-4eea-c6fb70a45ab5@gmx.com>
Date:   Sun, 5 Jan 2020 12:25:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <256D0504-6AEE-4A0E-9C62-CDF975FDE32D@icloud.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XYCCxGRvp7Lqkyj0AAwxtgmzRFyYSjMRg"
X-Provags-ID: V03:K1:E7UCrzIDAsUIMbr09py8z32Bpf3TkfLmGMZs0mKLi94oqljjP2H
 ob3yXn1f1L5CTU0Bm3KdOBYacRyPhFZON6wrQG4c7fvjfe8zSXfSbF2tmo2ac2fEAkp3QRQ
 WqVfgg4sIx4AF2EjVrcZW/vRdmFTCL8JavnJwqnbqdrE8A0WTku0om5+vMbsRWg6MBh738V
 Zm/bDT1VmhFCCKOSR5agQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NI+wY+cqZnk=:eB7EA2nJVcHZElR1qBl6yw
 rEKZElPfprWzaLRvS7EE/BHCLtPNdPHHjuVTopTe7VNJqkOyVtLKcFbASt3SuKgpJIni+rlEX
 1uqSd0GxBdK8VD/fJO6MHyIbD02TGpS/PGeyC8D4OwwKTcnYu7RYE+LUi/niHM3L+dEhEug+X
 mqrL6I2YDAoQnxhQ9xImWxE9rQOhpCY0DE/jJy/S5ZJ5qDi1pRWAK3DgN04smnlZ18Y42KAaN
 Ewf0UcfUQmvIQIbdqv/u4lOCllzGGR5NlEWDV8FaTZ5e3DEvuTl2I/4L0tZzOic29320EvBG0
 ic2ecwvrX96Ba1g/1/2sSPe3MfIM7rgjEgAPoz3HMrDe3gWaAsjVGFynDa7MojlQWxb/yYY+A
 mpEoOTtDDxTczvtB8vl6ZNAlR47DLufnWqNN5wnjBAQndLeBKR50H9exXOKqZhO+hYah0/9wd
 ezsUVADyvaURbFxPlzu0MmDxc3Rr7MOw/xxCICSdbp2XuJOWKZXN/oWN0uMAXGt7S8ZqVTN8y
 H6lmNq0hhbj/BcIhjrRZbOZ/ngkWIGhrB5kweuQh8Zd8ndeQtHG/FCGI/ps40rbiH0HebRu0C
 +GQdxTt6VlYaMku/RbdAjZn+w62k62wtrsfZBZdE2npwW++nQa/U3tviosFrFti42USxb19SJ
 zlxLQkkZ1PgRCDCp4pUrtss2Yo4JgTLuqDiCSIqIozkHG6kJA0EHIlNhm2xS3mz5yAzl8X4oF
 yduFqFeapGA39m11AFZ1r0XbRcf7+EMEM8sj/Xu5xG0ZzIT1F49cI9nXmmHVbmLN2P49dgoEc
 DoCFRWZa3zoRfgWzBf6a9ujuLArQbL+kBHrNQBzsXxxjj7LVPmXfnoayeGBjY6Ed309uVCyyR
 QGpAq7jeLXWxWasfRwwsAQRMU6Pnp2DzdZaA4GX125n7eCNWaqj2mJhFlXdEg/Yu42jbE8y+F
 ejX586xf2hZPEXGsL4DHaGg4d3ZKYMkgSAtaPyBv/z1vMkT37roILeW4H8RrEUbj8XVLVe3fz
 jwSr45TpiFXY9fmBLVOu4+xBpGsvePMCVIp08beYRWm7WECcUoAB6y6bXFALKEBG3EOMKpA4l
 PhhfgomyvwylmmG9pn9+MKuEP3150TzK0u46NLA3sofW9yL1h06EUAi2jdYgbuQNGNANzW9bd
 kbpuMFs7k7WBhRUJtVrgveTOYaTsi1qlb/jOOr2EkCs2Pn7FuArGxGPZp2iXWICBLQH4T1sVu
 PAV0J8D3tON7qztzO+9+qlIUsdPdpa/PS1eS/4RlHU9dEUE9x/eLfwTAwsR4=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XYCCxGRvp7Lqkyj0AAwxtgmzRFyYSjMRg
Content-Type: multipart/mixed; boundary="9kUy6V3PodFaHpKrChLVok32bjKybNTX6"

--9kUy6V3PodFaHpKrChLVok32bjKybNTX6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/5 =E4=B8=8A=E5=8D=881:07, Christian Wimmer wrote:
> Hi guys,=20
>=20
> I run again in a problem with my btrfs files system.
> I start wondering if this filesystem type is right for my needs.
> Could you please help me in recovering my 12TB partition?
>=20
> What happened?=20
> -> This time I was just rebooting normally my virtual machine. I discov=
ered during the past days that the system hangs for some seconds so I tho=
ught it would be a good idea to reboot my SUSE Linux after 14 days of wor=
king. The machine powered off normally but when starting it run into mess=
ages like the pasted ones.
>=20
> I immediately powered off again and started my Arch Linux where I have =
btrfs-progs version 5.4 installed.
> I tried one of the commands that you gave me in the past (restore) and =
I got following messages:
>=20
>=20
> btrfs-progs-5.4]# ./btrfs restore -l /dev/sdb1
> checksum verify failed on 3181912915968 found 000000A9 wanted 00000064
> checksum verify failed on 3181912915968 found 00000071 wanted 00000066
> checksum verify failed on 3181912915968 found 000000A9 wanted 00000064
> bad tree block 3181912915968, bytenr mismatch, want=3D3181912915968, ha=
ve=3D4908658797358025935

All these tree blocks are garbage. This doesn't look good at all.

The weird found csum pattern make no sense at all.

Are you using fstrim or discard mount option? If so, there could be some
old bug causing the problem.

SUSE Kernel version please.

Thanks,
Qu

> checksum verify failed on 2688520683520 found 000000D5 wanted FFFFFFA9
> checksum verify failed on 2688520683520 found 000000EE wanted FFFFFFEB
> checksum verify failed on 2688520683520 found 000000D5 wanted FFFFFFA9
> bad tree block 2688520683520, bytenr mismatch, want=3D2688520683520, ha=
ve=3D10123237912294
> Could not open root, trying backup super
> checksum verify failed on 3181912915968 found 000000A9 wanted 00000064
> checksum verify failed on 3181912915968 found 00000071 wanted 00000066
> checksum verify failed on 3181912915968 found 000000A9 wanted 00000064
> bad tree block 3181912915968, bytenr mismatch, want=3D3181912915968, ha=
ve=3D4908658797358025935
> checksum verify failed on 2688520683520 found 000000D5 wanted FFFFFFA9
> checksum verify failed on 2688520683520 found 000000EE wanted FFFFFFEB
> checksum verify failed on 2688520683520 found 000000D5 wanted FFFFFFA9
> bad tree block 2688520683520, bytenr mismatch, want=3D2688520683520, ha=
ve=3D10123237912294
> Could not open root, trying backup super
> checksum verify failed on 3181912915968 found 000000A9 wanted 00000064
> checksum verify failed on 3181912915968 found 00000071 wanted 00000066
> checksum verify failed on 3181912915968 found 000000A9 wanted 00000064
> bad tree block 3181912915968, bytenr mismatch, want=3D3181912915968, ha=
ve=3D4908658797358025935
> checksum verify failed on 2688520683520 found 000000D5 wanted FFFFFFA9
> checksum verify failed on 2688520683520 found 000000EE wanted FFFFFFEB
> checksum verify failed on 2688520683520 found 000000D5 wanted FFFFFFA9
> bad tree block 2688520683520, bytenr mismatch, want=3D2688520683520, ha=
ve=3D10123237912294
> Could not open root, trying backup super
> btrfs-progs-5.4]#=20
>=20
>=20
>=20
> What can I do now to recover files?
>=20
> Please help me.
>=20
> Thanks,
>=20
> Chris
>=20
>=20


--9kUy6V3PodFaHpKrChLVok32bjKybNTX6--

--XYCCxGRvp7Lqkyj0AAwxtgmzRFyYSjMRg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4RZUAACgkQwj2R86El
/qil4Qf+Ns2WWV9UdVyKPD9mpnYwVHF7k0wm53VnyijIwHXYfnrSiCSYEDtoPftm
jGvOLHYm7HWnRdV+EmGXsxX7vkLA85Zkcn4wsZjLLigQl2Pkf4WQcYv6aSxUucMr
3/VyP1HOxgo/c/N/9QO7uzl87mqqNE+yEysv/ql1+F6C/eWiRvEihYT7f7KhgP7H
wzasGnNY4Un6CNk49kq/Ui17zcHXjzWLXKwFQ5sDLw8Rg42SS6r3ZuvO4j5mp7i5
D6VQDrURjpQTJ2w3ta/FF1lea14OBHUiH6f+u8bmf7onO7bpd5HlpogfWwZhNem6
4FkqH8Gm0Mp6/B5FdnlozLBnXUUGgg==
=ZE/y
-----END PGP SIGNATURE-----

--XYCCxGRvp7Lqkyj0AAwxtgmzRFyYSjMRg--
