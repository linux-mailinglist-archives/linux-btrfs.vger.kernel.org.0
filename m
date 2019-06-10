Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 570FD3B7B7
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2019 16:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390216AbfFJOsN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jun 2019 10:48:13 -0400
Received: from frost.carfax.org.uk ([85.119.82.111]:54232 "EHLO
        frost.carfax.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389123AbfFJOsM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jun 2019 10:48:12 -0400
Received: from hrm by frost.carfax.org.uk with local (Exim 4.80)
        (envelope-from <hrm@carfax.org.uk>)
        id 1haLag-0000oq-GO; Mon, 10 Jun 2019 14:48:06 +0000
Date:   Mon, 10 Jun 2019 14:48:06 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/6] RAID1 with 3- and 4- copies
Message-ID: <20190610144806.GB21016@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>, dsterba@suse.cz,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1559917235.git.dsterba@suse.com>
 <20190610124226.GA21016@carfax.org.uk>
 <20190610140235.GF30187@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline
In-Reply-To: <20190610140235.GF30187@twin.jikos.cz>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 10, 2019 at 04:02:36PM +0200, David Sterba wrote:
> On Mon, Jun 10, 2019 at 12:42:26PM +0000, Hugo Mills wrote:
> >    Hi, David,
> > 
> > On Mon, Jun 10, 2019 at 02:29:40PM +0200, David Sterba wrote:
> > > this patchset brings the RAID1 with 3 and 4 copies as a separate
> > > feature as outlined in V1
> > > (https://lore.kernel.org/linux-btrfs/cover.1531503452.git.dsterba@suse.com/).
> > [...]
> > > Compatibility
> > > ~~~~~~~~~~~~~
> > > 
> > > The new block group types cost an incompatibility bit, so old kernel
> > > will refuse to mount filesystem with RAID1C3 feature, ie. any chunk on
> > > the filesystem with the new type.
> > > 
> > > To upgrade existing filesystems use the balance filters eg. from RAID6
> > > 
> > >   $ btrfs balance start -mconvert=raid1c3 /path
> > [...]
> > 
> >    If I do:
> > 
> > $ btrfs balance start -mprofiles=raid13c,convert=raid1 \
> >                       -dprofiles=raid13c,convert=raid6 /path
> > 
> > will that clear the incompatibility bit?
> 
> No the bit will stay, even though there are no chunks of the raid1c3
> type. Same for raid5/6.
> 
> Dropping the bit would need an extra pass trough all chunks after
> balance, which is feasible and I don't see usability surprises. That you
> ask means that the current behaviour is probably opposite to what users
> expect.

   We've had a couple of cases in the past where people have tried out
a new feature on a new kernel, then turned it off again and not been
able to go back to an earlier kernel. Particularly in this case, I can
see people being surprised at the trapdoor. "I don't have any RAID13C
on this filesystem: why can't I go back to 5.2?"

   Hugo.

-- 
Hugo Mills             | Great films about cricket: Forrest Stump
hugo@... carfax.org.uk |
http://carfax.org.uk/  |
PGP: E2AB1DE4          |

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJc/m2mAAoJEFheFHXiqx3k7LgP/3PLZlO4kVm3xI/RmWru0DaU
uPAZDMKReMNlYPS2bH570C2A8toYkL/sIeTwjaHWQOWXCflAC7OHD3HFQyQN/Ukk
/Au4q/osRd/1d4qKIeg7cRq0jf/hYM7hZSHNX37EJh1gfcwvnBxl2oNHhTyUb/MZ
Pw7DTbx7mFIPJvjMnAepNiWymAi/eLlVnlpeYgxN3v2752AwA6IpDSs2LApR02a8
3jAAJ9a2/rUMit4D4LRX03LUOC5kzZLiLf9BH6ehZmohTWb3q0Uwe0J+jkFgxDeu
TjSbjlmNESGufYZ2jBlqEBzeNN8BxzvPG2II93H2D/kZqDn+CA/Z0J85sNQfplDA
9YsaSW8YM1b6pg0T3iNK1Dc+s5LHMak5jaixwL3jvUlMacZNidxSwEboDJrEWOlW
+TEw2DllXvwYI79jen21vz8Jo+DazeqrGCSRMIO1sG8Z+STPWlcVNxLXutMGEqlD
bRY6OC8qViD6R+Bs6jWTFx6uXpyG4ZIz3DyNynHDT68rRw0Jyyq2Orn8PdI061u+
ukrK0HGItu7XGsc8CuySc1OPGl97L+2nsF7yXzKY5vLy6kZZfm6OmeQ2Ng5p/64Z
qPZ43MsZhdPSWQZQKX11+Q524hDO0IT5S19OCtVLEbn31mswaudBsSHwqvVrTm2m
oYSzpH0UXJXqQHEPAjmP
=av2L
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
