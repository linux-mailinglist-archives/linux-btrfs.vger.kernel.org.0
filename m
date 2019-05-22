Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1BE26A59
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2019 21:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfEVTAT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 May 2019 15:00:19 -0400
Received: from frost.carfax.org.uk ([85.119.82.111]:58732 "EHLO
        frost.carfax.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbfEVTAT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 May 2019 15:00:19 -0400
Received: from hrm by frost.carfax.org.uk with local (Exim 4.80)
        (envelope-from <hrm@carfax.org.uk>)
        id 1hTWTJ-000676-0A; Wed, 22 May 2019 19:00:17 +0000
Date:   Wed, 22 May 2019 19:00:16 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Cerem Cem ASLAN <ceremcem@ceremcem.net>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Citation Needed: BTRFS Failure Resistance
Message-ID: <20190522190016.GA9329@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Cerem Cem ASLAN <ceremcem@ceremcem.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAN4oSBeEU+rmCS8+WwriGz0KoPR=Xa6KvjH=gGriFaxVNZHf6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <CAN4oSBeEU+rmCS8+WwriGz0KoPR=Xa6KvjH=gGriFaxVNZHf6Q@mail.gmail.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 22, 2019 at 09:46:42PM +0300, Cerem Cem ASLAN wrote:
> Could you confirm or disclaim the following explanation:
> https://unix.stackexchange.com/a/520063/65781

   Well, the quoted comment at the top is accurate (although I haven't
looked for the IRC conversation in question).

   However, there are some inaccuracies in the detailed comment
below. These aren't particularly relevant to the argument addressing
your question, but do detract somewhat from the authority of the
answer. :)

   Specifically: Btrfs doesn't use Merkle trees. It uses CoW-friendly
B-trees -- there's no csum of tree contents. It also doesn't make a
complete copy of the tree (that would take a long time). Instead,
it'll only update the blocks in the tree that need updating, which
will bubble the changes up through the tree node path to the top
level.

   There's a detailed description of the issues of broken hardware on
the btrfs wiki, here:

https://btrfs.wiki.kernel.org/index.php/FAQ#What_does_.22parent_transid_verify_failed.22_mean.3F

   Hugo.

-- 
Hugo Mills             | Why play all the notes, when you need only play the
hugo@... carfax.org.uk | most beautiful?
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                                           Miles Davis

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJc5ZxAAAoJEFheFHXiqx3k+e0QALoGO8YfeeMOvKceACTIM5fo
Su1nEBPgPVi++7a4RXTryuJaJ7rbVF9T4Bs4mz9nhwN7Nu4adw2wxRCienn9jcH3
TxWiu44kyIMvajYl88DToIHja8GotcWJj8s7xX3+LNilB2ERyIshsaF5YZDa6hkT
V5ODqSYaZ3pxbpISeA+1IrEZcVryvSEuH+mbpeKfcm1iWnuG/vcyuSqoC0wjg9lC
FmkTucSURWSw8nUrbHRhkhQc6bahWI9KizXlGvJzrVHYdAlnpgWbZkTw/t4cpp69
TkGiO2O7r/PrQ7pd6QWckIguF0CWm/GuQ/IeFjDR8xLtb9VIsP50+kYJi14caNLA
kNg2xUfEwsZT/mEJCrnAqytiftIAwzUDi/COIVlyTlrpEcfWm/1beknstWbQwImu
Zh/p2vXRmAPOXkgYvDeAM3HnJs9RttWqzuZXcsFtz1p4rAxPgTNRCuPhiFxO+1Xm
8Lon3uTCiG5kLJ6ylV68XmAaQpSpvOVQvshjRjIH/g9zHZIFBoevzqVYsDq/RqS5
+A3ugR+4ha6HOrMhKqioer0Q33m4aRy5tHT+fxyDIZUJohvxTJ6ZlJlNe9FvjXlY
Sf95GpgbSzW5sQ2jxpNDnKHIgkogChFtVW2Qt53YHro0gL2FRyzA3MxjjB0lmeja
v2/p4Dkkdqs5GjelZRPM
=OflW
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
