Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 375A5BE804
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2019 00:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfIYWDt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 18:03:49 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36966 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbfIYWDt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 18:03:49 -0400
Received: by mail-io1-f68.google.com with SMTP id b19so1032243iob.4
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2019 15:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pallissard.net; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w8wTKwBd5AzQ2+Jxe0JWVphWHUVMbBskgQiXMaUf0O8=;
        b=eVrkBQ6JIaNA0HuEcu0DNDi8F+ubFXkWCguRMGl2v8kmM94eOPtsAU0silqs9oSMdK
         b3AX8DxmWTG8mDddgOzAXmqiNR6gr/iHvULoKISOy3ET2vnkwEcvRcHIxDwpMfKhVD5v
         Ytw2lUxZmrv+HzknB0Dtb/kHwZvE9B5OVnahH4b0EvgaXTj5LDjtq+TCcwXofFTgw2it
         lic3Thwj0KVOFKTxaKI06FqOxGnfRELHTdVMHpnmOll1XCORXL9ENfYzCS3ur48kbnvC
         5yM53OXcmp9xWeOvdgdFBvs8x+Ln7REShiTStM7+hozMKOHW92O82r8hmAigTb4FImIO
         ex7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w8wTKwBd5AzQ2+Jxe0JWVphWHUVMbBskgQiXMaUf0O8=;
        b=Q0uIf1nB9Bf0hnPKDInxYlEehXp2a7r0ln2fr20zt1+kFpse0/I6MtFweY+eo/Sdwq
         Uw6O4/MXi+zwXK2naXuHtBCv8wITE0+nVz60lb2U0SvP9IOVF4Nt3q8HVa7tWS0CXa1a
         AH8C82HNl+Rev5cEuCW1W/VKqIXC1AfKyyMAVQtWjazEgYIyBkRWFnZ1UVVWU41nQjHS
         kYVyPBvksz0F/KKTbqH/3wBzNINxJ0LLBLR29nQjKu8SfmmVrQV2COMUXz2q9N/9b/3W
         ZouZt6leobcU3mBJdkniAelSRuPNnhjM+BtxP4Gv1Xcu5+5LDIfygyIEDNlSKzR3NbGY
         +X3Q==
X-Gm-Message-State: APjAAAW30Cl3OqcDYEVpM0Xzvth8u/REcutTkQV9HtfPwyCBQLImTDOm
        DSPup+fQueL5T93H8tidHpVT7AGrNcg=
X-Google-Smtp-Source: APXvYqyITwSTNTLcPeTrW1H8IPkYs0VzG6ZwqO8G/1Itjyoh8eFgkrHEk0uKEXWnxy4b/TYGrSS30g==
X-Received: by 2002:a5d:8a0f:: with SMTP id w15mr170317iod.239.1569449026224;
        Wed, 25 Sep 2019 15:03:46 -0700 (PDT)
Received: from mail.matt.pallissard.net (149.174.239.35.bc.googleusercontent.com. [35.239.174.149])
        by smtp.gmail.com with ESMTPSA id g4sm793722iof.56.2019.09.25.15.03.45
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 15:03:45 -0700 (PDT)
Date:   Wed, 25 Sep 2019 15:03:42 -0700
From:   "Pallissard, Matthew" <matt@pallissard.net>
To:     linux-btrfs@vger.kernel.org
Subject: Re: errors found in extent allocation tree or chunk allocation after
 power failure
Message-ID: <20190925220341.5djrsjke6fu426lu@matt-laptop-p01>
References: <20190925144959.p4xyyhn2d2sajxjj@matt-laptop-p01>
 <CAJCQCtQwHRVs+XwnnUcktGcaRabZGG-UxS4o=g9y_MCiD4yG9Q@mail.gmail.com>
 <20190925193434.ieyj4oo6vkxmjtnw@matt-laptop-p01>
 <CAJCQCtQKypCbxksq5+XCwRy8enPkfZBaOgzS0SN2un+A1GELtA@mail.gmail.com>
 <20190925213231.kaqlq4ph3kgfgs5q@matt-laptop-p01>
 <CAJCQCtTyxZA6Lf+q16mkbzHdP7B1p07u8RnLdTEFsQRRLjAmcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="faiyiurrswhprki4"
Content-Disposition: inline
In-Reply-To: <CAJCQCtTyxZA6Lf+q16mkbzHdP7B1p07u8RnLdTEFsQRRLjAmcQ@mail.gmail.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--faiyiurrswhprki4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-25T15:56:54, Chris Murphy wrote:
> On Wed, Sep 25, 2019 at 3:32 PM Pallissard, Matthew <matt@pallissard.net>=
 wrote:
> >
> > On 2019-09-25T15:05:44, Chris Murphy wrote:
> > > Definitely deal with the timing issue first. If by chance there are b=
ad sectors on any of the drives, they must be properly reported by the driv=
e with a discrete read error in order for Btrfs to do a proper fixup. If th=
e times are mismatched, then Linux can get tired waiting, and do a link res=
et on the drive before the read error happens. And now the whole command qu=
eue is lost and the problem isn't fixed.
> >
> > Good to know, that seems like a critical piece of information.  A few s=
earches turned up this page, https://wiki.debian.org/Btrfs#FAQ.
> >
> > Should this be noted on the 'gotchas' or 'getting started page as well?=
  I'd be happy to make edits should the powers that be allow it.
>=20
> Should what be noted as a gotcha? The timing stuff? That's not Btrfs
> specific. It's just a default that's become shitty because if the
> crazy amount of time consumer drives can take doing "deep recovery"
> for bad sectors that can exceed a minute. It's incredible how slow
> that is and how many attempts are being made. But I guess on rare
> occasion this does cause a recovery, while also making your computer
> slow as balls. Anyway, this 30 second timer is obsolete but kernel
> developers so far refuse to change it, arguing every distribution that
> cares about desktop users, and users who use consumer drives for data
> storage, should change the timer default for their users using a udev
> rule. Except no distro I know of does that. This affects everyone with
> consumer drives that have deep recoveries, mostly common with hard
> drives. But it's especially negative on large data storage stacks
> using any kind of RAID. You'll find this problem all over the
> linux-raid@ achive, it comes up all the time. Still.
>=20
> https://raid.wiki.kernel.org/index.php/Timeout_Mismatch

Thanks for the link.

Also, reading that made me smile.  I appreciate your perspective.


Matt Pallissard

--faiyiurrswhprki4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTvIUMPApUGn6YFkXl1uof+t048SQUCXYvkOgAKCRB1uof+t048
SaT9AP4imogtNy6ripcyZpSYBX4HxapXXN3PXzHneYPgVMaT/gEA6aUXNytHrwte
MLaoQ+1fzV6MJo9eaUU5sbAHO+hk2gE=
=l8pg
-----END PGP SIGNATURE-----

--faiyiurrswhprki4--
