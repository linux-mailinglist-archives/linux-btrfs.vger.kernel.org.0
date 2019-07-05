Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9FCB60C06
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 22:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfGEUCT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 16:02:19 -0400
Received: from frost.carfax.org.uk ([85.119.82.111]:48417 "EHLO
        frost.carfax.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfGEUCT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Jul 2019 16:02:19 -0400
Received: from hrm by frost.carfax.org.uk with local (Exim 4.80)
        (envelope-from <hrm@carfax.org.uk>)
        id 1hjUPQ-0005ZH-US
        for linux-btrfs@vger.kernel.org; Fri, 05 Jul 2019 20:02:16 +0000
Date:   Fri, 5 Jul 2019 20:02:16 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     linux-btrfs@vger.kernel.org
Subject: Re: delete recursivly subvolumes?
Message-ID: <20190705200216.GR32479@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs@vger.kernel.org
References: <20190705193945.GB23600@tik.uni-stuttgart.de>
 <20190705194720.GC23600@tik.uni-stuttgart.de>
 <20190705195142.GQ32479@carfax.org.uk>
 <20190705195639.GD23600@tik.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="H2kTGx6mr3R59oXC"
Content-Disposition: inline
In-Reply-To: <20190705195639.GD23600@tik.uni-stuttgart.de>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--H2kTGx6mr3R59oXC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 05, 2019 at 09:56:39PM +0200, Ulli Horlacher wrote:
> On Fri 2019-07-05 (19:51), Hugo Mills wrote:
> 
> > > Is there a command/script/whatever to snapshot (copy) a subvolume which
> > > contains (somewhere) other subvolumes?
> > > 
> > > Example:
> > > 
> > > root@xerus:/test# btrfs_subvolume_list /test/ | grep /tmp
> > > /test/tmp
> > > /test/tmp/xx/ss1
> > > /test/tmp/xx/ss2
> > > /test/tmp/xx/ss3
> > > 
> > > I want to have (with one command):
> > > 
> > > /test/tmp --> /test/tmp2
> > > /test/tmp/xx/ss1 --> /test/tmp2/xx/ss1
> > > /test/tmp/xx/ss2 --> /test/tmp2/xx/ss2
> > > /test/tmp/xx/ss3 --> /test/tmp2/xx/ss3
> > 
> >    Remember that this isn't quite so useful, because you can't make
> > read-only snapshots in that structure.
> 
> ss1 ss2 and ss3 are indeed read-only snapshots!
> Of course they do not contain other subvolumes.

   What I'm saying is that you can't make a RO snapshot of test/tmp to
test/tmp2 and have your RO snapshots of ss1-3 in place within it.

   (OK, you could make the snapshot RW initially, snapshot the others
into place and then force it RO, but then you've just broken
send/receive on tmp2).

> >    Generally, I'd recommend not having nested subvols at all, but to
> > put every subvol independently, and mount them into the places you
> > want them to be. That avoids a lot of the issues of nested subvols,
> > such as the ones you're trying to deal with here.
> 
> *I* do it this way from the very beginning :-)
> But I have *users* with *strange* ideas :-}
> 
> I need to handle their data.

   That makes it more awkward. :(

   Hugo.

-- 
Hugo Mills             | "You know, the British have always been nice to mad
hugo@... carfax.org.uk | people."
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                         Laura Jesson, Brief Encounter

--H2kTGx6mr3R59oXC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJdH6zIAAoJEFheFHXiqx3kgN0P/RTSd3tCejFxS3isH9sO3Lfc
YJZVQqTh779B7arsWiS1CiAY7Ftvpe4aaq1zfb83g02Z37lt7KfndcsNluSFeo3j
g7z6HC/Xm73g672BC+xm7h9rHDUB8iXh5m8WZeIlS41PQE1kRuSfS0E2105Zi5f+
QqSidT/x+lUkR/mY2M8NgvGniGaNo8NfRbIOpYPd7ugZpNKl3NSJEwMwa2mZ7K56
pIIt2n3c5HhI4skX0h1wQ1qx3iBFHt7UmYAWCpGos9nAyTNzbjJBg1EJNXO55k/5
OKo3OE1qIkmufzSSMFd4rB1/efh4sxt0YDbmhxNnIaAwztCssGZmFItJEqgDd2vI
cKWt2NodiYtSUTDnalJwhHS8c7BB5a0QtlG24Nt0Y3wsYnXqzT/aANTUbyKZycgw
5iCECUikGPg437Wz7NV7XIrdLAfjeUQ2gEzGW2Uu5XlJHxDoycpIsNbwH/Qpfqc7
ClSsqc4ClRBU5HGvED2yhL/9C6VEvJCLe1JU8kDelRCWstyL08QFz9mTFNanxfac
q0bU6O/jyzrDTvfn1FWRRbF/HEW7mGHrm4kkH4V9F8DRNRIoL6Mux7tkQNVYTkGJ
802qO+0SQH5qXbejNMmYp1FF8mKWEH1lzOFXHSD+7s2p5PjdZ9hT/kN/fypODQVG
p1KPN43VYGXHHkZ2Do1B
=e9dp
-----END PGP SIGNATURE-----

--H2kTGx6mr3R59oXC--
