Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBFB120DBD
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2019 19:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfEPRM2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 May 2019 13:12:28 -0400
Received: from frost.carfax.org.uk ([85.119.82.111]:33235 "EHLO
        frost.carfax.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfEPRM2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 May 2019 13:12:28 -0400
Received: from hrm by frost.carfax.org.uk with local (Exim 4.80)
        (envelope-from <hrm@carfax.org.uk>)
        id 1hRJvd-0001DN-NG; Thu, 16 May 2019 17:12:25 +0000
Date:   Thu, 16 May 2019 17:12:25 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Axel Burri <axel@tty0.ch>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Used disk size of a received subvolume?
Message-ID: <20190516171225.GH1667@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Axel Burri <axel@tty0.ch>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <c79df692-cc5d-5a3a-1123-e376e8c94eb3@tty0.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2xzXx3ruJf7hsAzo"
Content-Disposition: inline
In-Reply-To: <c79df692-cc5d-5a3a-1123-e376e8c94eb3@tty0.ch>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--2xzXx3ruJf7hsAzo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 16, 2019 at 04:54:42PM +0200, Axel Burri wrote:
> Trying to get the size of a subvolume created using "btrfs receive",
> I've come with a cute little script:
> 
>    SUBVOL=/path/to/subvolume
>    CGEN=$(btrfs subvolume show "$SUBVOL" \
>      | sed -n 's/\s*Gen at creation:\s*//p')
>    btrfs subvolume find-new "$SUBVOL" $((CGEN+1)) \
>      | cut -d' ' -f7 \
>      | tr '\n' '+' \
>      | sed 's/\+\+$/\n/' \
>      | bc
> 
> This simply sums up the "len" field from all modified files since the
> creation of the subvolume. Works fine, as btrfs-receive first makes a
> snapshot of the parent subvolume, then adds the files according to the
> send-stream.
> 
> Now this rises some questions:
> 
> 1. How accurate is this? AFAIK "btrfs find-new" prints real length, not
> compressed length.
> 
> 2. If there are clone-sources in the send-stream, the cloned files
> probably also appear in the list.
> 
> 3. Is there a better way? It would be nice to have a btrfs command for
> this. It would be straight-forward to have a "--summary" option in
> "btrfs find-new", another approach would be to calculate and dump the
> size in either "btrfs send" or "btrfs receive".

   btrfs find-new also doesn't tell you about deleted files (fairly
obviously), so if anything's been removed, you'll be overestimating
the overall change in size.

> Any thoughts? I'm willing to implement such a feature in btrfs-progs if
> this sounds reasonable to you.

   If you're looking for the incremental usage of the subvolume, why
not just use the "exclusive" value from btrfs fi du? That's exactly
that information. (And note that it changes over time, as other
subvols it shares with are deleted).

   Hugo.

-- 
Hugo Mills             | Your problem is that you've got too much taste to be
hugo@... carfax.org.uk | a web developer.
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                                          Steve Harris

--2xzXx3ruJf7hsAzo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJc3Zn5AAoJEFheFHXiqx3k8pAP/ikFbUbNmvkHsQH0whRVFnAx
+OoEDZlN/6EP9qZ2yUQj47yY9+o1A5yz1eoEZJA8OPp5X4+RGRSgkrwoC4OtU6eh
uL40zyaEQNqbv1i8FlaJ898TI9Pn9cWbxApNILuMqEZBFjvBB9k9oIWVswkPM5cJ
yF5B8Mvab9VWd43AeH9eqMrQhdMkTR0hqmgfRdTrBFwrIy1B5hYLZaaSQCKGnTPP
xm4rhuv+ca2hypl144PBHyl0jqQlKS6W7H33bELrUzD70YdjdmK/xaH4H+y0CYJ9
/bDzPpVmpDLEbUNJ5RcBPkl5FfZSTjfGXjhzuu6iqQwPVAJvjMQ8mNm1ogJX0gbF
hmlQp+IWjudy5/2mAmKS+Y2C1t/k5qjOTtxKst6OJmXDMYGa4ojo60bz/88v1Mlw
jOK6oRhMyEivDdKW8gQBIAyfuYP6RG63w88FVDpS44K6An1F4C2WV28OyFnXhFxG
fSWloLWd97xHiue3p70vavEdYNk1cVYZkeMm4njLNpZHGEooJRIPUAwQWG+DMEmU
KJWfw2X0yF3O8m7PmAs/hvBVThyR7PNfR57bIQ2N+g795QJkI61QOilf189dN+wH
mfhltzybmao9sJS7Pno8BruEwfEKaJhpoorqxS14nIJYuBCF7eFEFZ5KgmM7ZUPO
29H6oUKZglL/ijbDGOw+
=BL6J
-----END PGP SIGNATURE-----

--2xzXx3ruJf7hsAzo--
