Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93A281072CD
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Nov 2019 14:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfKVNKU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Nov 2019 08:10:20 -0500
Received: from mout.gmx.net ([212.227.15.19]:53421 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbfKVNKU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Nov 2019 08:10:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574428217;
        bh=1IzvqO3zWuE/fEd173Q7hC+pieDEyY1iBpCJ9U5gtJQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=BIPVUs2WIGu0Agz2E3kDd17yZsgOw7SY3rjJx8hB6MhxhSdJPVmdK64nfxQ/LIlOr
         oS/TIDPAbZM0chtv9R6p2du2hTDopviq/xjZcxQzEZ4EUUw/M4CPFv9/Qk7XdbSOnH
         dnhco7Y1kHZezL/OFo+nWPgLdOnStbiN1OZv6Feg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M59GA-1iX2El1MRg-001BEZ; Fri, 22
 Nov 2019 14:10:16 +0100
Subject: Re: Problems balancing BTRFS
To:     devel@roosoft.ltd.uk, linux-btrfs@vger.kernel.org
References: <65447748-9033-f105-8628-40a13c36f8ce@casa-di-locascio.net>
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
Message-ID: <1de2144f-361a-4657-662f-ac1f17c84b51@gmx.com>
Date:   Fri, 22 Nov 2019 21:10:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <65447748-9033-f105-8628-40a13c36f8ce@casa-di-locascio.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uxIKnbKPZIfNkCvCNMLoI6YnWGjaKHv99"
X-Provags-ID: V03:K1:7+kDsxD8w2bmdYlooSVypwFUTMO9AKHmBVbjELCZZ7tCu+4POjk
 EoTxdNyTLNTblsGRiRVIf/lP4S36OIUoXwlDMJVINOEiV6HDJFTQMSLZ8eAvjlznk0Lt7uF
 JEt5FLM/XcQJtOgBYuDzaaO7lR8r/ERS3Av1JcOLqvJItObNTv6zS6WJh6WBZmuy0/+IVjX
 W6mOyL6p+nk2gNETTp0hg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:D+ja61+slPA=:QDK4hsQzR7n8WK/qVNumDt
 o+6RFRTIeGOgWsaxrUE+AFEAUvghqJyFrEWpKzwAqQORMS468x4eFZXjOr+Mihg9v2p2Mux6n
 MPOdGhRWuK310UIGfWv798OaFusC53zDbwX81cxm+bSuQLlVwJAEthTael6OO33H7N5Kt8scm
 TlACxR96u+nsReDubW0Ra0cAu4GLU8TicxRZaW8AdOR0aK5GmrW1lwtM7mYcHKEhB9EdvLNbV
 r2QJQXCWBMfzszVHFkaT4L1ARftooZesnIcJ9e/oOwXe7SjsIQ0UcFzso0WkVDnPYJmYYWh5x
 tfDuMHOFDdD1yGyIXM0jM0McGHloLcmbVsKE3b4AMg5J5TNv2wXeNfxPzVB9kqGNSKWs30Q2I
 YgKOa9IkR8jnHPgrFtIL148Tb0CDyON7QvWtF36n5pmyzTxe+evqEMChohRS9vikbR06jMXKv
 09/+NrG4tnTtzNLnoTllSiqnyLwwhGGifAUUpBcCA+t4qdGbKctUH5DFKaQH0Qo+Htg0E2R+F
 lp2IFoAqSF6+//6lTw6w3I/K0JqlLocrIyi5i1MvckcO7b6iODcxf0byy4YZg5U2hRIi7zYnX
 Jk77pPxn2yUoEHeoDpRmkb7EUPmh8vFu8wIO1HGZVcwyYV7brlpvvAWQ/ZYqkwbFZJ261R2H+
 i5klxj+CwwRc1UcYOczM4SG8ottyth+YWpRHDS3D8aCbtUkV0dwfpnXR0V8WibYQcDp+P1Z2H
 RUaqSzy4iYUKtthEluhE6k3oIzGCLv/CS1OBlTmqzmWb/8kSC0s+8B6Xan5HALWyfWq0/MoLT
 3eChwkWtI8RzvyVXSAalqQ0lhPZlwYjMlESdlgKPTS6c8f5d6BX5/bgd2/XZ6wWQKl6CnU4TL
 CNITyc7cZbipmJJfM2tKyBzt4hWQ3bOB1GZJPZvOZGRZB9c9CW0oKdtf+ZVPH9ajtNcjGeyXR
 r7nwlxf1CzaDRPn+5/yM96f2jwesY6Unpt1kk2Sqcj6runTK5JC7Iahk5yay+1r5uVxWChjOD
 KwfwyNn6pnBKGStAR2gEE6khT2btz7v2alBAmC9T0aGMjA54mdQ9Fav919VKNoh8C4vDmhAiO
 3y9PwggJz97g5Io277unuZi7m5xmGHvuFXj3zwa+IEGRiIwZq/72vD2a56Prxw7TxyiQfWLTM
 sCHpFN20TyLBu4mJzHnGX6ONZ/LDJKeI/Ypis1uc1/KE45l34XrNlLZYrrLTUKH/TefMMZWir
 VUhvbQjdC/OtH23ckp2iRFru8NYeV8ZV8GmEmds5yoeTboSoi9jNWj4/vqlE=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uxIKnbKPZIfNkCvCNMLoI6YnWGjaKHv99
Content-Type: multipart/mixed; boundary="znDZv24fo3kj3W0dIDmuAaaXgpfu0Xt52"

--znDZv24fo3kj3W0dIDmuAaaXgpfu0Xt52
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/22 =E4=B8=8B=E5=8D=888:37, devel@roosoft.ltd.uk wrote:
> So been discussing this on IRC but looks like more sage advice is neede=
d.

You're not the only one hitting the bug. (Not sure if that makes you
feel a little better)
>=20
>=20
> So quick history. A BTRFS filesystem was initially created with 2x 6Tb
> and 2x1Tb drives. This was configure in a RAID 1 Meta/system=C2=A0=C2=A0=
 and RAID
> 5 data configuration
>=20
> Recently 2 more 6Tb drives were used to replace the 2 1Tb ones. One was=

> Added to the filesystem and then the original 1Tb was deleted, the othe=
r
> was just a direct replace.
>=20
>=20
> The filesystem was then expanded to fill the new space with
>=20
>=20
>> =C2=A0=C2=A0 btrfs fi resize 4:max /mnt/media/
>=20
>=20
> The filesystem was very unbalanced and currently looks like this after
> an attempt to rebalance it failed.
>=20
>=20
> btrfs fi show
> Label: none=C2=A0 uuid: 6abaa68a-2670-4d8b-8d2a-fd7321df9242
> =C2=A0=C2=A0=C2=A0 Total devices 4 FS bytes used 2.80TiB
> =C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 size 5.46TiB used 1.20TiB =
path /dev/sdb
> =C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 2 size 5.46TiB used 1.20TiB =
path /dev/sdc
> =C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 4 size 5.46TiB used 826.03Gi=
B path /dev/sde
> =C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 5 size 5.46TiB used 826.03Gi=
B path /dev/sdd
>=20
>=20
> btrfs fi usage=C2=A0 /mnt/media/
> WARNING: RAID56 detected, not implemented
> Overall:
> =C2=A0=C2=A0=C2=A0 Device size:=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0 21.83TiB
> =C2=A0=C2=A0=C2=A0 Device allocated:=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=
 =C2=A0=C2=A0 8.06GiB
> =C2=A0=C2=A0=C2=A0 Device unallocated:=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0 21.82TiB
> =C2=A0=C2=A0=C2=A0 Device missing:=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=
 =C2=A0=C2=A0=C2=A0=C2=A0 0.00B
> =C2=A0=C2=A0=C2=A0 Used:=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0 6.26GiB
> =C2=A0=C2=A0=C2=A0 Free (estimated):=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=
 =C2=A0=C2=A0=C2=A0=C2=A0 0.00B=C2=A0=C2=A0=C2=A0 (min: 8.00EiB)
> =C2=A0=C2=A0=C2=A0 Data ratio:=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00
> =C2=A0=C2=A0=C2=A0 Metadata ratio:=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.00
> =C2=A0=C2=A0=C2=A0 Global reserve:=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=
 =C2=A0512.00MiB=C2=A0=C2=A0=C2=A0 (used: 0.00B)
>=20
> Data,RAID5: Size:2.80TiB, Used:2.80TiB
> =C2=A0=C2=A0 /dev/sdb=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 1.20TiB
> =C2=A0=C2=A0 /dev/sdc=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 1.20TiB
> =C2=A0=C2=A0 /dev/sdd=C2=A0=C2=A0=C2=A0 =C2=A0822.00GiB
> =C2=A0=C2=A0 /dev/sde=C2=A0=C2=A0=C2=A0 =C2=A0822.00GiB
>=20
> Metadata,RAID1: Size:4.00GiB, Used:3.13GiB
> =C2=A0=C2=A0 /dev/sdd=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 4.00GiB
> =C2=A0=C2=A0 /dev/sde=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 4.00GiB
>=20
> System,RAID1: Size:32.00MiB, Used:256.00KiB
> =C2=A0=C2=A0 /dev/sdd=C2=A0=C2=A0=C2=A0 =C2=A0 32.00MiB
> =C2=A0=C2=A0 /dev/sde=C2=A0=C2=A0=C2=A0 =C2=A0 32.00MiB
>=20
> Unallocated:
> =C2=A0=C2=A0 /dev/sdb=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 4.26TiB
> =C2=A0=C2=A0 /dev/sdc=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 4.26TiB
> =C2=A0=C2=A0 /dev/sdd=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 4.65TiB
> =C2=A0=C2=A0 /dev/sde=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 4.65TiB
>=20
>=20
> A scrub is clean
>=20
> btrfs scrub status /mnt/media/
> UUID:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 6abaa68a-2670-4d8b-8d2a-fd7321df9242
> Scrub started:=C2=A0=C2=A0=C2=A0 Thu Nov 21 11:30:49 2019
> Status:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fin=
ished
> Duration:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 17:20:11
> Total to scrub:=C2=A0=C2=A0 2.80TiB
> Rate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 47.10MiB/s
> Error summary:=C2=A0=C2=A0=C2=A0 no errors found
>=20
>=20
> A readonly fs check is clean
>=20
>=20
> Opening filesystem to check...
> WARNING: filesystem mounted, continuing because of --force
> Checking filesystem on /dev/sdb
> UUID: 6abaa68a-2670-4d8b-8d2a-fd7321df9242
> [1/7] checking root items=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 (0:00:13 elapsed, 373111
> items checked)
> [2/7] checking extents=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (0:04:18 elapsed, 205334
> items checked)
> [3/7] checking free space cache=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0:00:37 elapsed, 1233
> items checked)
> [4/7] checking fs roots=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 (0:00:10 elapsed, 10714
> items checked)
> [5/7] checking csums (without verifying data)=C2=A0 (0:00:02 elapsed, 4=
14138
> items checked)
> [6/7] checking root refs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (0:00:00 elapsed, 90
> items checked)
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 3079343529984 bytes used, no error found
> total csum bytes: 3003340776
> total tree bytes: 3362635776
> total fs tree bytes: 177717248
> total extent tree bytes: 35635200
> btree space waste bytes: 153780830
> file data blocks allocated: 3077709344768
> =C2=A0referenced 3077349277696
>=20
>=20
>=20
> A full balance is now failing
>=20
>=20
>=20
> [Fri Nov 22 11:31:27 2019] BTRFS info (device sdb): relocating block
> group 8808400289792 flags data|raid5
> [Fri Nov 22 11:32:07 2019] BTRFS info (device sdb): found 74 extents
> [Fri Nov 22 11:32:24 2019] BTRFS info (device sdb): found 74 extents
> [Fri Nov 22 11:32:43 2019] BTRFS info (device sdb): relocating block
> group 8805179064320 flags data|raid5
> [Fri Nov 22 11:33:24 2019] BTRFS info (device sdb): found 61 extents
> [Fri Nov 22 11:33:44 2019] BTRFS info (device sdb): found 61 extents
> [Fri Nov 22 11:33:52 2019] BTRFS info (device sdb): relocating block
> group 8801957838848 flags data|raid5
> [Fri Nov 22 11:33:54 2019] BTRFS warning (device sdb): csum failed root=

> -9 ino 307 off 131760128 csum 0x07436c62 expected csum 0x0001cbde mirro=
r 1
> [Fri Nov 22 11:33:54 2019] BTRFS warning (device sdb): csum failed root=

> -9 ino 307 off 131764224 csum 0xd009e874 expected csum 0x00000000 mirro=
r 1
> [Fri Nov 22 11:33:54 2019] BTRFS warning (device sdb): csum failed root=

> -9 ino 307 off 131760128 csum 0x07436c62 expected csum 0x0001cbde mirro=
r 2
> [Fri Nov 22 11:33:54 2019] BTRFS warning (device sdb): csum failed root=

> -9 ino 307 off 131764224 csum 0xd009e874 expected csum 0x00000000 mirro=
r 2
> [Fri Nov 22 11:33:54 2019] BTRFS warning (device sdb): csum failed root=

> -9 ino 307 off 131760128 csum 0x07436c62 expected csum 0x0001cbde mirro=
r 1
> [Fri Nov 22 11:33:54 2019] BTRFS warning (device sdb): csum failed root=

> -9 ino 307 off 131760128 csum 0x07436c62 expected csum 0x0001cbde mirro=
r 2
> [Fri Nov 22 11:34:02 2019] BTRFS info (device sdb): balance: ended with=

> status: -5

The csum error is from data reloc tree, which is a tree to record the
new (relocated) data.
So the good news is, your old data is not corrupted, and since we hit
EIO before switching tree blocks, the corrupted data is just deleted.

And I have also seen the bug just using single device, with DUP meta and
SINGLE data, so I believe there is something wrong with the data reloc tr=
ee.
The problem here is, I can't find a way to reproduce it, so it will take
us a longer time to debug.


Despite that, have you seen any other problem? Especially ENOSPC (needs
enospc_debug mount option).
The only time I hit it, I was debugging ENOSPC bug of relocation.

Thanks,
Qu

>=20
>=20
> Any idea how to proceed from here? The drives are relatively new and
> there were no issues in the 2x6Tb+ 2x1Tb
>=20
>=20
> Thanks in advance.
>=20
>=20


--znDZv24fo3kj3W0dIDmuAaaXgpfu0Xt52--

--uxIKnbKPZIfNkCvCNMLoI6YnWGjaKHv99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3X3jIACgkQwj2R86El
/qgNjAf7BfWg1GCMJGyUXUjf0ChLr7CM7Hrvw1WZGVUgYbcx52aeOhvCADbiAtfb
8YfpJlaiiK5R1eUwlmOIMTCkMK9HQxWhq5qYDHKlBYV9i4CzkGk1MFgpAoRj6zxv
wiACAfCkUcJDJcEsIZjF64FuwRPkqlKeNO73YzoiUkjjcMv5lDaRPUZYIuR421G1
m5zm4EsqlGttQCVh2WXvmv7nx416iDmnFbYwTHizr9orRrVf7wR9YIkeNQKJuoe7
5RlZrWPfPOIl343y6hkaVE5N/JjU7a0qid01eq0U2JHmtMfE6s2O2kP/5yhoGj/v
KtyhLLSKY9W7YdeE8Fv/wDZHzsdXIQ==
=yKUY
-----END PGP SIGNATURE-----

--uxIKnbKPZIfNkCvCNMLoI6YnWGjaKHv99--
