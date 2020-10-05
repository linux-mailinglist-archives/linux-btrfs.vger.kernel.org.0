Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CBB2830BC
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Oct 2020 09:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgJEHOz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Oct 2020 03:14:55 -0400
Received: from mout.gmx.net ([212.227.15.18]:57733 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgJEHOy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Oct 2020 03:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601882092;
        bh=kVhZgqL51GBp6hEqb2/SmD0vH384kW+6gyGRdMbK36U=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=fgub7wxXALkWmhudHjx639ZeVCPFxylaY+XqJ0EcpxbufC9tcSkshJhTzxRE0QJCO
         /iY0Ilz/GU2Z7PkThYBt48nGrSze2HiTaW5SMeTlTb94dONd64hML1j8ey9FPuKQGF
         qQNuMWXFHPTIof69FHMM9jZuRpsMrpacWnp2sz1k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M7Jza-1kJr432TRk-007oJ2; Mon, 05
 Oct 2020 09:14:52 +0200
Subject: Re: ERROR... please contact btrfs developers
To:     Eric Levy <ericlevy@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CA++hEgx2x=HjjUR=o2=PFHdQSFSqquNffePTVUqMNs19sj_wcQ@mail.gmail.com>
 <c2d13609-564d-1e3b-482a-0af65532b42b@gmx.com>
 <CA++hEgwsLH=9-PCpkR4X2MEqSwwK6ZMhpb+YEB=ze-kOJ8cwaQ@mail.gmail.com>
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
Message-ID: <c65b1e8b-c05d-7547-cb01-d12e8ab83cb3@gmx.com>
Date:   Mon, 5 Oct 2020 15:14:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CA++hEgwsLH=9-PCpkR4X2MEqSwwK6ZMhpb+YEB=ze-kOJ8cwaQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="j545DQ6zMKdBdZMr6AzHerF2LrVemLOnj"
X-Provags-ID: V03:K1:vksWOLHT6buE88p9qPACgkUwTaUxhGII1phdUUNeu+lhVCPsbXZ
 etG7JpOhL4AfwRMNs1wZaCkH+Pihpm+hQ1KP0l14TS2iSl431e04wVfoMKbKXG0YVCYLsu7
 xuyrOFe9aVFlBFfs1TZESFuLLBmgtNSkGn80CIK1w/uFk2JcRiBERKEb5KOoKumFSSLKTGw
 Nq8hqxwq2TMf4nw335qAA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9f8CZyPQl1c=:ooO40levHTBrVqPCtHIJ20
 N6xX/zeUVGyboqW1Q4rXgNiTg+rS0+v2mxYPWSN1qIP84c82TwAklnVpEnhIHb+lwPZjn0DDD
 LlGwYGdvpq+HIC7jqPyoq+PPjT5ZAw1Eg+kqe4D98y6QaZAjIGyl96ziTQ70/HLCrlaI7MXqJ
 GbazyRpQn7tMYwGj+ueprIyt0ZXVFZLw1E2LQlgiGXo+SQTuC0k0pn+rWSraRqNSsoIH7ymBM
 FV3DhZCGUkk/DazK0qXWu9Lh75Aa01bYnmK/kOZPmi4RZxJUNjcz2KI3BQdD6+veSdLv98Rb0
 M/nRBrg2zHDtffZAAcOnZtgUD79iObBnkm0RHRcrGis/IIarUB59vRxPUAifVNiaQ2pdjQwo0
 1PAD7Dc0zXSrEts7x8UvSqJdfBds2ZpxiwACH/Q0d0aN1xQ0q21HmQNrc2uD5fQylrao7uqNy
 2QVZL7I8QFmCR3+yiT8PtDNYLHaDYBclF6a4/+y+AuA+6CjpUYuXDTFK2w43dRmn3YxWUjZ/8
 ULJuEB3XjCakg6qO6zhsR+N3Iib8xCPhRIG9ypnySZrAQZg9ZnVeQ2kGTA+AUf3dBGF08DbGE
 sU12BjRlzMN+wmNAHNm18pyQhXfS4Jh7NcPAvTg71UndLUepPVusazsxwP7jrsvqzcJ+hUT8h
 Oxxbs2bkydtbRyY9Gu/ziQr67MM9JE+BNt6HYrnv7PuC2U16iiG2BQu6jsSeebOIPlel+SwfZ
 W+RHf2Km3tJ8MfpE4TXStYbznwVzCDZ5O9qa+hz1J1nDGDfOzRDh65AluQjS6GrCDzf/T00/K
 CcuzVNFLjO6wJyt1teJ7IqCVznglPzrzG99vgIwJGcUHtU59p4xDjFryfI2hQuV8WH8wetZER
 hZZeKMA/1TkBytyc0rLGKvPF6IRVtgz9mgmkU6h6dNSljVBpKmRWbdabQ7BNrt7SW0NFF5M07
 gw54BuphnhkZ1er+PiNgSFg6eOql8vEHiq5/yoIFINDVcG9kcTlOXAMgYBa+NSe3Mh7rrEfb4
 zppfkz+TKL/XQcdof5C7caHyWaaMKtcSaBInuiqhAI/+K7yXMOSYWUqW30Ba1+Mf015M33qQv
 glA6ow8O5pu69QF2dgPyBeuUeSiqlaVXWd/eU9Wr271bbpzdyse4Ov3tbK9Ql9bm7xVyndFqw
 j+0AhGBBDUsEqA7alyN3BJTwdp0+gKUW68shYeYTUAukhYb1/4KRqqAlf32Txxmkr5OyDnTSs
 5QDM6c3nB5fiFCFo0jWTX+G5eCVpDW+fhO4wKMA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j545DQ6zMKdBdZMr6AzHerF2LrVemLOnj
Content-Type: multipart/mixed; boundary="VBAa3RXI0eH6gZ8oTOlnI0tYFs3M9s0AV"

--VBAa3RXI0eH6gZ8oTOlnI0tYFs3M9s0AV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/5 =E4=B8=8A=E5=8D=8811:35, Eric Levy wrote:
>> There is an off-tree branch to do the repair:
>> https://github.com/adam900710/btrfs-progs/tree/extent_gen_repair
>=20
> Ok. I was able to build and run. Part of the earlier confusion was
> from reading the documentation in the wrong branch of the repository.
>=20
> I ran the repair, and now the check passes in both the stock and
> forked version of the utility.
>=20
> However, the file system is still behaving badly. It reverts to RO
> mode after several minutes of use.

Would you provide the dmesg of when the RO happens?

It should be another problem.

Thanks,
Qu
>=20
> Even a scrub operation fails ('aborted" result was not from a manual
> intervention).
>=20
> $ btrfs check /dev/sda5
> Opening filesystem to check...
> Checking filesystem on /dev/sda5
> UUID: 9a4da0b6-7e39-4a5f-85eb-74acd11f5b94
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups
> Rescan hasn't been initialized, a difference in qgroup accounting is ex=
pected
> Qgroup are marked as inconsistent.
> found 399944884224 bytes used, no error found
> total csum bytes: 349626220
> total tree bytes: 6007685120
> total fs tree bytes: 4510924800
> total extent tree bytes: 881704960
> btree space waste bytes: 1148459015
> file data blocks allocated: 570546290688
>  referenced 530623602688
>=20
> $ sudo btrfs scrub start -B /mnt/custom
> ERROR: scrubbing /mnt/custom failed for device id 1: ret=3D-1, errno=3D=
5
> (Input/output error)
> scrub canceled for 9a4da0b6-7e39-4a5f-85eb-74acd11f5b94
> Scrub started:    Sun Oct  4 23:25:22 2020
> Status:           aborted
> Duration:         0:01:41
> Total to scrub:   378.04GiB
> Rate:             0.00B/s
> Error summary:    no errors found
>=20


--VBAa3RXI0eH6gZ8oTOlnI0tYFs3M9s0AV--

--j545DQ6zMKdBdZMr6AzHerF2LrVemLOnj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl96x+kACgkQwj2R86El
/qjeGQf/c64S+9kuVT+4AVrzoOMj6uyzHD88N3mEQ0gRbJfVdwfN5DyetM+d4p2W
nKc64l+DFNCXM7PZSFr2JENWos/+i97Bmqw5L5UqO5cd8SbKjhrt7clsoJGtlrhj
iGLXGRcMtRhpfjF0bCM7wYFJyYMB3L5gQMeb/n3A93ac+PMpgkBuNSDxZGsJYhU1
Skq+LDVDMUJhuuJkBi8UtycqB8s3fNuUqA1CiG9TD0WJJBv7RmP6/3hBvBFIK35Y
E267l9IE8hTR/+Lm0JBezch+cZLQ9j2Xaj+0M92OKjkKBnHoHewGlBNUlFPiMmar
E87IGw3Pcq9e7Q+X3oAa3gkMedL0pw==
=NFDS
-----END PGP SIGNATURE-----

--j545DQ6zMKdBdZMr6AzHerF2LrVemLOnj--
