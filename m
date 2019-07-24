Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03C0D73048
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2019 15:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfGXNxj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jul 2019 09:53:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:55172 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726422AbfGXNxi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jul 2019 09:53:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3EE53AFCD;
        Wed, 24 Jul 2019 13:53:37 +0000 (UTC)
Subject: Re: [PATCH 1/2] btrfs-progs: check: run delayed refs after writing
 out dirty block groups
To:     dsterba@suse.cz, Filipe Manana <fdmanana@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190402180956.28893-1-jeffm@suse.com>
 <CAL3q7H7O=ZqJdQUXYZjJRfZF04Or7kLgEVnRUGE97YRsV=3pMg@mail.gmail.com>
 <068957f9-c4cf-688d-3db7-7f519c21e4ea@suse.com>
 <20190515141605.GQ3138@twin.jikos.cz>
 <CAL3q7H45c8H91vbz=9yPmtPE95Ret1XLNW3kNT5XGs6L2-GAAw@mail.gmail.com>
 <20190517131246.GB3138@twin.jikos.cz>
From:   Jeff Mahoney <jeffm@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jeffm@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b0172639-ceaf-c220-dd3d-32e193ec8817@suse.com>
Date:   Wed, 24 Jul 2019 09:53:33 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190517131246.GB3138@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UALi12iEeCd7QcrKuIPWU9kk4D5ajQU7T"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UALi12iEeCd7QcrKuIPWU9kk4D5ajQU7T
Content-Type: multipart/mixed; boundary="xvvA06zaF46qhsBWw1fYqHEZKG3Fhcln2";
 protected-headers="v1"
From: Jeff Mahoney <jeffm@suse.com>
To: dsterba@suse.cz, Filipe Manana <fdmanana@gmail.com>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <b0172639-ceaf-c220-dd3d-32e193ec8817@suse.com>
Subject: Re: [PATCH 1/2] btrfs-progs: check: run delayed refs after writing
 out dirty block groups
References: <20190402180956.28893-1-jeffm@suse.com>
 <CAL3q7H7O=ZqJdQUXYZjJRfZF04Or7kLgEVnRUGE97YRsV=3pMg@mail.gmail.com>
 <068957f9-c4cf-688d-3db7-7f519c21e4ea@suse.com>
 <20190515141605.GQ3138@twin.jikos.cz>
 <CAL3q7H45c8H91vbz=9yPmtPE95Ret1XLNW3kNT5XGs6L2-GAAw@mail.gmail.com>
 <20190517131246.GB3138@twin.jikos.cz>
In-Reply-To: <20190517131246.GB3138@twin.jikos.cz>

--xvvA06zaF46qhsBWw1fYqHEZKG3Fhcln2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 5/17/19 9:12 AM, David Sterba wrote:
> On Wed, May 15, 2019 at 03:45:13PM +0100, Filipe Manana wrote:
>>>>> And running delayed refs can dirty more block groups as well.
>>>>> At this point shouldn't we loop running delayed refs until no more
>>>>> dirty block groups exist? Just like in the kernel.
>>>>
>>>> Right.  This is another argument for code sharing between the kernel=
 and
>>>> userspace.
>>>
>>> Sharing code in this function would be really hard, I've implemented =
the
>>> loop in commit in progs.
>>
>> Shouldn't the new patch version be sent to the list for review?
>> It doesn't seem to be a trivial change on first through.
>=20
> Ok, I've removed the patches from devel and will send them once the
> release is done.
>=20

Hi Dave -

Did this ever get revisited?

-Jeff

--=20
Jeff Mahoney
SUSE Labs


--xvvA06zaF46qhsBWw1fYqHEZKG3Fhcln2--

--UALi12iEeCd7QcrKuIPWU9kk4D5ajQU7T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE8wzgbmZ74SnKPwtDHntLYyF55bIFAl04Yt0ACgkQHntLYyF5
5bJIWg//eaYR4GqTr7XIBvyQqjtZ4rDmYTOMFvId+yJvegFMWG1d3zh3soJVNsfh
nRZgW87QHe3SU0FiuR3ZuVODcBiMdykwy4t/yuZAfcRs0Luh1mUvYJ/SZU/cSJCr
YeNC1ULNfP96ar0Tv/osJOiyy1v0TDbjMmf6YyWkwzW4jeSHnD1NHLPwZZ5/dwrS
9QM8v369yLcv5h2xJKvKukPBE2UtfYTqVjvWSC58dfYGSO3GEqumqrSF6FmHD430
k2VQH6ZQUufG8UNqPkZKfsrEBrhu7qxkwaFVH1duTzaoBe9s6kxCz9j3TYn8ANDk
GAXU/CTRIa73WoKMykGNHeADOl7AUDzWvkGSFgJ6l9Knoj68UYqdqNU6N0xvo8zK
qGrDG518/uXaGmvU2hm43m5/1SRaQwbKri5xPypSh78eH2BxynKX1OjAnso5U7a4
z6W0LNX/C0KSeiiv87hBk81I8dsT4YIHGXxpRc0ji9tvFJiEom3wKj5BMTnAI+3C
fUffBEIWnSqoNq6URPYpAtocxRy/75CcE0JabebxKqsXWaY3iA8KqDMHixYZJlfe
q5nCI2wJkaJFBSysYpG67Q0Iimp27faF1CJW2Aj5q0DhZYaDfgjPJXrUPH1FYMnp
8K1zCnTBd9LWBh7BjupEof5wsRcLL9gKrCfPXszJ8pjalqMbgr4=
=8+bK
-----END PGP SIGNATURE-----

--UALi12iEeCd7QcrKuIPWU9kk4D5ajQU7T--
