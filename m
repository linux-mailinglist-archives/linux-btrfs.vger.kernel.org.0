Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9AF31F151
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Feb 2021 21:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhBRUqy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Feb 2021 15:46:54 -0500
Received: from wilbur.contactoffice.com ([212.3.242.68]:48744 "EHLO
        wilbur.contactoffice.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhBRUqx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Feb 2021 15:46:53 -0500
Received: from smtpauth1.co-bxl (smtpauth1.co-bxl [10.2.0.15])
        by wilbur.contactoffice.com (Postfix) with ESMTP id 44964B71;
        Thu, 18 Feb 2021 21:46:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1613681166;
        s=20200308-xcrr; d=rmz.io; i=me@rmz.io;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        l=2760; bh=Z9TnRD1KyDgqaHFjfdSS3KPToxqxuHckqssbiiROjDw=;
        b=dwzFFiebnaChNvDadKMRFqRZNKaFI0aveI118rfn2YLD0adE4yenoMROBWNHc0cj
        5Ej6KbQKLBoB9LYl1zZlQpgYuRpt0NII6j4ZK7kr0PVtfxLyv+0lZPRtrS4I4r3kVd3
        /ctQ0sJ+xKQCwJzqBAaWvBsylIq7c38K1YDAeH26YMLy7FkEilsW1gGRH0WRgBAbljk
        6h0l7oG7vl63EWGQwS7KiPcxEQ51HmH6zqzQzjE27N2+AKpbJ7UFBOvW6r2N/K+GcrI
        UhBq+VF9MgB0huNCdw1JtA69Vyh5BHq1O0mINmCjoAcUw4vhpvV8fKKK+Fshmm5YxcS
        +ndzeW/x9A==
Received: by smtp.mailfence.com with ESMTPA ; Thu, 18 Feb 2021 21:46:03 +0100 (CET)
Date:   Thu, 18 Feb 2021 20:46:02 +0000
From:   Samir Benmendil <me@rmz.io>
To:     Hugo Mills <hugo@carfax.org.uk>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: BTRFS error (device dm-0): block=711870922752 write time tree
 block corruption detected
Message-ID: <20210218204602.d63ix6us3sp7fj3m@hactar>
X-Clacks-Overhead: GNU Terry Pratchett
References: <20210217132640.r44q7ccfz2fohvxy@hactar>
 <20210217134502.GU4090@savella.carfax.org.uk>
 <F222B7F7-84A4-4681-85FE-2EAA81446B21@rmz.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pemmclltms3ixk3e"
Content-Disposition: inline
In-Reply-To: <F222B7F7-84A4-4681-85FE-2EAA81446B21@rmz.io>
X-Spam-Flag: NO
X-Spam-Status: No, hits=-2.9 required=4.7 symbols=ALL_TRUSTED,BAYES_00 device=10.2.0.1
X-ContactOffice-Account: com:225813835
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--pemmclltms3ixk3e
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb 17, 2021 at 16:56, Samir Benmendil wrote:
> On 17 February 2021 13:45:02 GMT+00:00, Hugo Mills=20
> <hugo@carfax.org.uk> wrote:
>> On Wed, Feb 17, 2021 at 01:26:40PM +0000, Samir Benmendil wrote:
>>> Any advice on what to do next would be appreciated.
>>=20
>>   The first thing to do is run memtest for a while (I'd usually
>> recomment at least overnight) to identify your broken RAM module and
>> replace it. Don't try using the machine normally until you've done
>> that.
>=20
> Memtest just finished it's first pass with no errors, but printed a=20
> note regarding vulnerability to high freq row hammer bit flips.
>=20
> I'll keep it running for a while longer.

2nd pass flagged a few errors, removed one of the RAM module, tested=20
again and it passed. I then booted and ran `btrfs check --readonly` with=20
no errors.

     [root@hactar ~]# btrfs check --readonly /dev/mapper/home_ramsi
     Opening filesystem to check...
     Checking filesystem on /dev/mapper/home_ramsi
     UUID: 1e0fea36-a9c9-4634-ba82-1afc3fe711ea
     [1/7] checking root items
     [2/7] checking extents
     [3/7] checking free space cache
     [4/7] checking fs roots
     [5/7] checking only csums items (without verifying data)
     [6/7] checking root refs
     [7/7] checking quota groups skipped (not enabled on this FS)
     found 602514441102 bytes used, no error found
     total csum bytes: 513203560
     total tree bytes: 63535939584
     total fs tree bytes: 58347077632
     total extent tree bytes: 4500455424
     btree space waste bytes: 15290027113
     file data blocks allocated: 25262661455872
     referenced 4022677716992


Thanks again for your help Hugo.

Samir

--pemmclltms3ixk3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEO8iRpJat6BxHTtT0gmAAVevIWpMFAmAu0goACgkQgmAAVevI
WpNZpQ/+KIr7Vio/XC3UDIgHjKYMkQk7P5FM3qNMuy0sNcNj+HJTp3m0SRbJ0Fkm
WI9t6SuYCFENss4x/EjT/+NDaRHemxYiCyUYel71zgx4YEHTbx4HggxGihBGHxE0
8zzKVKCitZUxcxbth703WqBuLEsYlOKBVOgOLJoEoej4aGCkyiXy3zCFA7XVMpby
0HzytFTPhwtSRJR6C6JQa+TGYhsSPH2EL8teuBYUXI5zJXz9Xd5EVeu8/Zrjrtdj
WoGZeGth5awHXU6LQ4N7QB2XQ07w8mIGG98hzdYo5t2VA+9jhXUi7DudkFV196LK
9Y9eK8c5Twq5UFsG6uXnkJ0aN4NR4+4cTvKJMJ5gpFCBnLl56eq3NQgdBSpNLYPw
NM01rxCGbRXvbag6dbiBGFRJeOCmoR1rq4UN3DkiVwXGjqZxJorzfzmo9yXs79I4
AFUg3DYb8Bsta5lSsPNG/ScLjQa4UIiLMIbICMSHx7dqA9pOznwT3GDZEo0B5bGU
WpI9w95pIl9UJ8mGy8Pwun6LDTVopxP4Crq8oH9crFQJE9fRk820atB3Opyyweru
xof7FyTM3CK0VHhNGEayVs2RWBmqueLi0wD9CvhUxzSlfEN+sZDnvCDxf6HWpXYQ
cCKvQKck3PhiZNFI9KQCLkdqfD1xFn4i9Dl4AWOwiL0U4y/chuE=
=yrOw
-----END PGP SIGNATURE-----

--pemmclltms3ixk3e--
