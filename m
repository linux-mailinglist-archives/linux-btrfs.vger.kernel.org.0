Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4719212D89C
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Dec 2019 13:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfLaM0B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Dec 2019 07:26:01 -0500
Received: from mout.gmx.net ([212.227.15.19]:36211 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfLaM0B (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Dec 2019 07:26:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577795157;
        bh=oTR+WzSCGBa2CXz8yYKl8dOYaPvrfIAGzXmnEcFfigg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=SAt7yzsaYCbunRSMltEcgcwuuxzTkgZ0vGQcsJ3aO1liAkKQgqKwV3gXU0XF665os
         jNGGWszfFglHWTwAXzsDHlzwH78PNT/kcs9TEz4AEgBov/+8elOWGfNpWvBMGLAhOv
         AAXRiqGXmCI5zaxagZctxbPf+jFxwQ8ZEiq8cT7w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mz9Yv-1jgpHz0yG3-00wDV3; Tue, 31
 Dec 2019 13:25:56 +0100
Subject: Re: [RFC][PATCH 0/5] btrfs: fix hole corruption issue with !NO_HOLES
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20191230213118.7532-1-josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <d47f690d-6c3a-c69b-bcf7-dd1062c2692d@gmx.com>
Date:   Tue, 31 Dec 2019 20:25:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191230213118.7532-1-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DzaYmQCeK8ud8ywKxWZfGjc3sQxjvWiYm"
X-Provags-ID: V03:K1:djAaPvUx0mgBSzzZVDUolnIPs8h5i9TjbctLRNzPIJlEf/YGYZO
 6GjJwBO0clCiJb8GaewCrpxUK5RsXoa0jpxM0X+d/HjUtq8LrWLMf4J6IZnHF/b87y+SkQ1
 CfYlTRHlB3NwTdS32NMNwB3YWRWJQnq5wJFlKxE65eMEL1zkC8VK+qoyN0CeFwaYbvGL3V6
 aNcYZkuE44fT/vRDdKdkA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VYOsk+gTE1o=:o4HyCFh+I/w7DJayGw1Iv/
 TukDrF34lMD3hFwf7bUdJWAPcyJLnAGhcPNCfqaxmbDUSiQOR99XxC6MLEdDRnsO96C0a7D5D
 q9lZWoEmj3wRYwjuspkuCsjj4uPYDY+aQBa4pJkcFaQSfwo769Y5B/KIA6VRyNmcCEbRAjnTR
 MfQr19C6y5LhzHKeX5xKLUayi1YiS28DOEJYeYQdooZBDfAshyXkz3Wj+91gHwjm7EWPicg+c
 ixqWiNYZyzxLHCPeyZSP3MAaU8Dnqee8vwI8Rf8zIsujG9hhV0CC5YqbajHwMlcBB+tLXmx7L
 LIbJ3A8B4gufE+v3ecIlH5LcPv5Ajq5+D3b4JB9HkrG6NAIj0TlP4b9qzfhhA/zphZtsP+b97
 G+Dk99ArghppMlUrPuIZ9uLwWEfoYi9Cg2YgwksJEDpyxw1LC0jO2e389VhFabq/s/WpmSw8v
 FffwHzXAtumfmECCY5WvLPmsdIzU+HENx/sWWebv81uz5jhLidD8rP4E5soUBwn2ibKqgXX7T
 bNflPwFb+W3IJNi3QJhH39SawwXZmLhlPUCYPFvRbc5coRfUn/vqpaUe538+QFqvOnUIDcyEM
 /iC1pYdAXbkbxv0ClfX73b2VfcfYIpg6yi6A/TIF22leBisIvTC9u7dI2+51ks84fNH9/dYrD
 Wy+r5Ao+gAkFJfmfekqa0e/L27Ippq9NfB6izNfPlZRtuySrIrXJ5hwOleocMBPYevhRO1dpU
 EOUesINwO0bLZuFy+4UL7lA7N4INEi24R5sc5+HK8HR76VZyYKXaQRg8R9VzdVhIUSo10CI0S
 Lx8MxZYEMlPbqOMVUfFb0+SSqiuSWT3nqjle7k6M7dFoLoei5+Bxo7QemQRNZJLXBrp4B+eFM
 o6UUPMFV2ku0Y4d/nVVu+ioE+pjV2OHOZv8335tz8oNWrk2RDSAKXM90qr4FMn5FDJRKry129
 52E02smeRiJ3xApAPB54EeP51/QgQW3FEDMWiYjqN71eRadqE/KqruwaCL1rWN+6zoQy478Xi
 Ytng4QPSyJ/lnxpquBhajLLO2S5fvmd6yIaGZfX5ODfB9JJYMPgCfAGxkRsxaeTun+Cyut2qM
 gzWG/CVVf/bH4XwXy6ss5NCECzGjuK7JWfLLOt8j4bq6FMGzP8QYObpdj9F0gfiu5MlD++hvX
 0jU0gVv1aR9OrkfaOPAVlJ1JeF0e7xl9llrbCEmJp4fQQLOBjZ/oUAP1ji/JIaRQaAwz9P96o
 dicG64UPKe9MYOFQV0wlbaSJdlJ8oZccjwSkaHKr8zX3mx0P55chWyh2kMNg=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DzaYmQCeK8ud8ywKxWZfGjc3sQxjvWiYm
Content-Type: multipart/mixed; boundary="TDCbduBS8no5kQVIV1UjaCC3XHefsIjJY"

--TDCbduBS8no5kQVIV1UjaCC3XHefsIjJY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/31 =E4=B8=8A=E5=8D=885:31, Josef Bacik wrote:
> We've historically had this problem where you could flush a targeted se=
ction of
> an inode and end up with a hole between extents without a hole extent i=
tem.
> This of course makes fsck complain because this is not ok for a file sy=
stem that
> doesn't have NO_HOLES set.  Because this is a well understood problem I=
 and
> others have been ignoring fsck failures during certain xfstests (generi=
c/475 for
> example) because they would regularly trigger this edge case.
>=20
> However this isn't a great behavior to have, we should really be taking=
 all fsck
> failures seriously, and we could potentially ignore fsck legitimate fsc=
k errors
> because we expect it to be this particular failure.
>=20
> In order to fix this we need to keep track of where we have valid exten=
t items,
> and only update i_size to encompass that area.  This unfortunately mean=
s we need
> a new per-inode extent_io_tree to keep track of the valid ranges.  This=
 is
> relatively straightforward in practice, and helpers have been added to =
manage
> this so that in the case of a NO_HOLES file system we just simply skip =
this work
> altogether.

Not an expert of this problem, but AFAIK this is caused by mixing
buffered and direct IO, right?

Since that deadly mix is not recommended anyway, can we make things
simpler by just block any buffered IO if the same inode is under going
any direct IO?

Thanks,
Qu

>=20
> I've been hammering on this for a week now and I'm pretty sure its ok, =
but I'd
> really like Filipe to take a look and I still have some longer running =
tests
> going on the series.  All of our boxes internally are btrfs and the box=
 I was
> testing on ended up with a weird RPM db corruption that was likely from=
 an
> earlier, broken version of the patch.  However I cannot be 100% sure th=
at was
> the case, so I'm giving it a few more days of testing before I'm satisf=
ied
> there's not some weird thing that RPM does that xfstests doesn't cover.=

>=20
> This has gone through several iterations of xfstests already, including=
 many
> loops of generic/475 for validation to make sure it was no longer faili=
ng.  So
> far so good, but for something like this wider testing will definitely =
be
> necessary.  Thanks,
>=20
> Josef
>=20


--TDCbduBS8no5kQVIV1UjaCC3XHefsIjJY--

--DzaYmQCeK8ud8ywKxWZfGjc3sQxjvWiYm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4LPlAXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qh54QgAg0qgmqNgQk5h5MzsyjuF7n9k
HJm+EZvq/7IxCHNGGpRvUvPIooYA2iur0EuhwZbAY6OuXn+6InLdTyQlmJHRJtKD
7oP/7oqAf/1NV0OH5Uv8kO/8xYalGVwzDFMa5Y7oZuKXSu3wDcbCtTUFf9casimq
5EKVco2fo7akTo8S205gUpMvCXcIN+8VNs0rKebJqa+WJMC1ekE4OwXxyjrV/ZVA
R8k4xZ5Qd5smhBQB9mOdMevIZmtzet7NjWUSdQLoEAnrANwZ7MfxxxfCoWFsNGYv
V97EVrntQtRwognpMm31ZcfYw5UkrFezz+Jmj7D5qcc7byYO5kYT5oAO7pc7EA==
=1HZW
-----END PGP SIGNATURE-----

--DzaYmQCeK8ud8ywKxWZfGjc3sQxjvWiYm--
