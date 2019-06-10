Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B42A23B529
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2019 14:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389601AbfFJMma (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jun 2019 08:42:30 -0400
Received: from frost.carfax.org.uk ([85.119.82.111]:53946 "EHLO
        frost.carfax.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389194AbfFJMma (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jun 2019 08:42:30 -0400
Received: from hrm by frost.carfax.org.uk with local (Exim 4.80)
        (envelope-from <hrm@carfax.org.uk>)
        id 1haJd4-0000IP-RI; Mon, 10 Jun 2019 12:42:26 +0000
Date:   Mon, 10 Jun 2019 12:42:26 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/6] RAID1 with 3- and 4- copies
Message-ID: <20190610124226.GA21016@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1559917235.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <cover.1559917235.git.dsterba@suse.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

   Hi, David,

On Mon, Jun 10, 2019 at 02:29:40PM +0200, David Sterba wrote:
> this patchset brings the RAID1 with 3 and 4 copies as a separate
> feature as outlined in V1
> (https://lore.kernel.org/linux-btrfs/cover.1531503452.git.dsterba@suse.com/).
[...]
> Compatibility
> ~~~~~~~~~~~~~
> 
> The new block group types cost an incompatibility bit, so old kernel
> will refuse to mount filesystem with RAID1C3 feature, ie. any chunk on
> the filesystem with the new type.
> 
> To upgrade existing filesystems use the balance filters eg. from RAID6
> 
>   $ btrfs balance start -mconvert=raid1c3 /path
[...]

   If I do:

$ btrfs balance start -mprofiles=raid13c,convert=raid1 \
                      -dprofiles=raid13c,convert=raid6 /path

will that clear the incompatibility bit?

(I'm not sure if profiles= and convert= work together, but let's
assume that they do for the purposes of this question).

   Hugo.

-- 
Hugo Mills             | The enemy have elected for Death by Powerpoint.
hugo@... carfax.org.uk | That's what they shall get.
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                                                   gdb

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJc/lAyAAoJEFheFHXiqx3kLzAP/iHhR/eQyDcZgKdOAaoWPrvi
vn8AQhEqHOTLSu8Ft6ZQ1biHmlv/+GKMM+v7/Pd4Q2PGXLR5qSOgduSRQ6U9EYBp
gbr47eog7HxGEkjMveo9JQsKpjE87zi4hIKYoqDboQyy740BA9L+lWdSPCKTlvPE
ytT27vg2O8DLQddbQ1j86LCvK9VAyi76n58Rdph1g3A9EPxR+qJEJm9XO/RgenMs
rLKOJdnDd3BEmDV3oSdAkmluf9Eypr7/PLgyezPN1BpeXE6qgSynVi9t9jYdKtG3
2+sDBmJmg88na6fy4FCpcfyaMmHn1jdbBhq5BkOSVF0RyT7O32iurHzdzeDmZBAq
4Cnz3hr2Cx60g/v+0sR3DoKHE3tQUy/anH1y5fkwFcO+OZ06RyFSNLERE+NNhSko
6+6D5IEHc0vW//Oq5zAIT2aTHqe6+avFAqdu34PPiWqHKEFcnZNYruSiwc4KVU+3
3+1KyJ4DKp8/yJoffrLlTROvtwAosfuhq+RU4F8Yz/xNyE3tYC03UIfiEI6bEkOA
Z/4D4hwt+uSYxoi1GAvspMGfZZHTVHRJtSt/XaP7RBHZixQ1GcmJcoo9lxfs+Zzm
ACmKkIDZgLgIN6tshRLy8qmRdTODyjSxMcTMY3V8UDShUEd3v+xEjcSkaZE5BP8p
ZMvdwIy1TyyCutvsk2mX
=gcbU
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
