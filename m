Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD48D150FE2
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 19:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgBCSo0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 13:44:26 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:38928 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgBCSo0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 13:44:26 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 04BC85A7483; Mon,  3 Feb 2020 13:44:25 -0500 (EST)
Date:   Mon, 3 Feb 2020 13:44:25 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: KASAN splat during mount on 5.4.5, no reproducer
Message-ID: <20200203184425.GV13306@hungrycats.org>
References: <20191228200326.GD13306@hungrycats.org>
 <20200120194650.GO3929@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="iytlPraCFSCqrfnM"
Content-Disposition: inline
In-Reply-To: <20200120194650.GO3929@twin.jikos.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--iytlPraCFSCqrfnM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2020 at 08:46:50PM +0100, David Sterba wrote:
> On Sat, Dec 28, 2019 at 03:03:26PM -0500, Zygo Blaxell wrote:
> >=20
> > [...etc...it dumps the same stacks again in the BUG]
> >=20
> > The deepest level of fs/btrfs code is the list_del_init in
> > clean_dirty_subvols.
> >=20
> > After a reboot the next mount (and all subsequent mounts so far)
> > was successful.  I don't have a reproducer.
>=20
> For the record, this and other KASAN reports regarding reloc root, is
> going to be fixed in 5.4.14, "btrfs: relocation: fix reloc_root lifespan
> and access" (6282675e6708ec78). Thanks for the reports and debugging
> help.

Confirmed:  I have not seen this bug since applying the first versions of
the patch to my test kernels in 5.4.8.  I've been testing continuously
since then, replacing the early version with the final upstream version
in 5.4.14, and now running 5.4.16.  After applying "Btrfs: fix race
between adding and putting tree mod seq elements and nodes" I have seen
no crashing bugs _at all_ (no deadlock, BUG_ON or KASAN).

Thank you for all the fixes!  Much appreciated!

--iytlPraCFSCqrfnM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXjhqBgAKCRCB+YsaVrMb
nCmWAKDOLh4AoVI45FXAOCDOsqFeYD+T8gCfQaNzvn9jbqKJELyp7n6R2KxUMFo=
=T4ax
-----END PGP SIGNATURE-----

--iytlPraCFSCqrfnM--
