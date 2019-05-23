Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3C728437
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2019 18:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbfEWQtC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 May 2019 12:49:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:53696 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730899AbfEWQtC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 May 2019 12:49:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1670CACE5;
        Thu, 23 May 2019 16:49:00 +0000 (UTC)
Subject: Re: Citation Needed: BTRFS Failure Resistance
To:     Hugo Mills <hugo@carfax.org.uk>,
        Cerem Cem ASLAN <ceremcem@ceremcem.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAN4oSBeEU+rmCS8+WwriGz0KoPR=Xa6KvjH=gGriFaxVNZHf6Q@mail.gmail.com>
 <20190522190016.GA9329@carfax.org.uk>
Cc:     Johannes Thumshirn <jthumshirn@suse.com>
From:   Jeff Mahoney <jeffm@suse.com>
Message-ID: <1910f8aa-69c2-ff37-3957-1e649023f060@suse.com>
Date:   Thu, 23 May 2019 12:48:56 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:67.0)
 Gecko/20100101 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190522190016.GA9329@carfax.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TkDRkvnqgUVdg3yMKFiB4R55rFAOHjbBJ"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TkDRkvnqgUVdg3yMKFiB4R55rFAOHjbBJ
Content-Type: multipart/mixed; boundary="1GHM2ujdcOrKEhkA5wAFp2XWXWqOGnKne";
 protected-headers="v1"
From: Jeff Mahoney <jeffm@suse.com>
To: Hugo Mills <hugo@carfax.org.uk>, Cerem Cem ASLAN <ceremcem@ceremcem.net>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc: Johannes Thumshirn <jthumshirn@suse.com>
Message-ID: <1910f8aa-69c2-ff37-3957-1e649023f060@suse.com>
Subject: Re: Citation Needed: BTRFS Failure Resistance
References: <CAN4oSBeEU+rmCS8+WwriGz0KoPR=Xa6KvjH=gGriFaxVNZHf6Q@mail.gmail.com>
 <20190522190016.GA9329@carfax.org.uk>
In-Reply-To: <20190522190016.GA9329@carfax.org.uk>

--1GHM2ujdcOrKEhkA5wAFp2XWXWqOGnKne
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 5/22/19 3:00 PM, Hugo Mills wrote:
> On Wed, May 22, 2019 at 09:46:42PM +0300, Cerem Cem ASLAN wrote:
>> Could you confirm or disclaim the following explanation:
>> https://unix.stackexchange.com/a/520063/65781
>=20
>    Well, the quoted comment at the top is accurate (although I haven't
> looked for the IRC conversation in question).
>=20
>    However, there are some inaccuracies in the detailed comment
> below. These aren't particularly relevant to the argument addressing
> your question, but do detract somewhat from the authority of the
> answer. :)
>=20
>    Specifically: Btrfs doesn't use Merkle trees. It uses CoW-friendly
> B-trees -- there's no csum of tree contents. It also doesn't make a
> complete copy of the tree (that would take a long time). Instead,
> it'll only update the blocks in the tree that need updating, which
> will bubble the changes up through the tree node path to the top
> level.

There are csums of tree contents -- they're part of the header for every
tree node and leaf.  It doesn't currently function as a merkle tree,
though, since there is no external reference to verify it.  There are
two potential solutions to this:

1) Change the tree nodes to contain checksums for each of the next blocks=
=2E
2) Use an hmac in each tree node and leaf, where the signature functions
as the external reference.

Either solution requires checksums be added to the superblock for the
tree root, the chunk root, and the log tree root.

-Jeff

--=20
Jeff Mahoney
SUSE Labs


--1GHM2ujdcOrKEhkA5wAFp2XWXWqOGnKne--

--TkDRkvnqgUVdg3yMKFiB4R55rFAOHjbBJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE8wzgbmZ74SnKPwtDHntLYyF55bIFAlzmzvgACgkQHntLYyF5
5bJMlg//QMxc1+Tsw2EP2hroga3JUm8uFGD8Myte8d7YnaGMXZ7qSlSWXIJBhbM8
By2Dv2jyzej7+LsRzBt/pjN1e8gNOb4Rv55d5neHQMVtBC8lDzazTIm7e/1PivAh
hDoI7fKr4/N1jfnRgUD0wzdMSHScoDCsTqjX3ODH0XzlFTb5jDNOzT9+bmG0FjFm
2BzubqOC/djM3OlWleccWJ8agr/QhbkiMhzKD3K7NaC4jdJAJoPPvjWAzeh6CZRy
+Vlp01A/6+Zgi+AjawOmGWUDfETURo4F/nmIU9dqFgi2F3Wau2rnDSYuxz4vQAUz
Y9ayHjRYPcr963iV0Tm0r+Xt8GsEzKr1umKtUfO6Bgbrp3ZWnsJIs+QlpFcupO/v
ev1hlmYT6vqrpMoHUos2k/isJZ5SUNqkoe8HKC84E5On7PhnTr6J2p3shuwK76yH
1P2umsZMJIiNbgFMM4uTcUbSaahNj7JQsdIqGwbmMxeVpyv3dTLHYKxPuxOHmFTY
oKL7gqJDOS2Vd/GhomhQNO2Yl6B/StfiuIoIvEwyT6WD9eQL5Vd+tKrctvQBq08h
qIyhE5KM3qsG2Fwl6HiIWYHflSsJvyXL5sgsCC5fdsGzwR1U9+NClrtZ7RcIRKVZ
1no0bTcnaLSeRx6V7k64gZ0gkn7DtAWlRt6QpeCGMB2dHLM0gMo=
=uYrV
-----END PGP SIGNATURE-----

--TkDRkvnqgUVdg3yMKFiB4R55rFAOHjbBJ--
