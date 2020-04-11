Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 246DF1A53C7
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Apr 2020 23:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgDKVOW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Apr 2020 17:14:22 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:46328 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgDKVOW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Apr 2020 17:14:22 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 5E7C0665223; Sat, 11 Apr 2020 17:14:22 -0400 (EDT)
Date:   Sat, 11 Apr 2020 17:14:21 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: Balance loops: what we know so far
Message-ID: <20200411211414.GP13306@hungrycats.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8S8xwCNhfXjuHwS7"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--8S8xwCNhfXjuHwS7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Since 5.1, btrfs has been prone to getting stuck in semi-infinite loops
in balance and device shrink/remove:

	[Sat Apr 11 16:59:32 2020] BTRFS info (device dm-0): found 29 extents, stage: update data pointers
	[Sat Apr 11 16:59:33 2020] BTRFS info (device dm-0): found 29 extents, stage: update data pointers
	[Sat Apr 11 16:59:34 2020] BTRFS info (device dm-0): found 29 extents, stage: update data pointers
	[Sat Apr 11 16:59:34 2020] BTRFS info (device dm-0): found 29 extents, stage: update data pointers
	[Sat Apr 11 16:59:35 2020] BTRFS info (device dm-0): found 29 extents, stage: update data pointers

This is a block group while it's looping, as seen by python-btrfs:

	# share/python-btrfs/examples/show_block_group_contents.py 1934913175552 /media/testfs/
	block group vaddr 1934913175552 length 1073741824 flags DATA used 939167744 used_pct 87
	extent vaddr 1934913175552 length 134217728 refs 1 gen 113299 flags DATA
	    inline shared data backref parent 1585767972864 count 1
	extent vaddr 1935047393280 length 5591040 refs 1 gen 113299 flags DATA
	    inline shared data backref parent 1585769349120 count 1
	extent vaddr 1935052984320 length 134217728 refs 1 gen 113299 flags DATA
	    inline shared data backref parent 1585769349120 count 1
	extent vaddr 1935187202048 length 122064896 refs 1 gen 113299 flags DATA
	    inline shared data backref parent 1585769349120 count 1
	extent vaddr 1935309266944 length 20414464 refs 1 gen 113299 flags DATA
	    inline shared data backref parent 1585769365504 count 1
	extent vaddr 1935329681408 length 60555264 refs 1 gen 113299 flags DATA
	    inline shared data backref parent 1585769365504 count 1
	extent vaddr 1935390236672 length 9605120 refs 1 gen 113299 flags DATA
	    inline shared data backref parent 1585769381888 count 1
	extent vaddr 1935399841792 length 4538368 refs 1 gen 113299 flags DATA
	    inline shared data backref parent 1585769381888 count 1
	extent vaddr 1935404380160 length 24829952 refs 1 gen 113299 flags DATA
	    inline shared data backref parent 1585769381888 count 1
	extent vaddr 1935429210112 length 7999488 refs 1 gen 113299 flags DATA
	    inline shared data backref parent 1585769398272 count 1
	extent vaddr 1935437209600 length 6426624 refs 1 gen 113299 flags DATA
	    inline shared data backref parent 1585769627648 count 1
	extent vaddr 1935443636224 length 28676096 refs 1 gen 113299 flags DATA
	    inline shared data backref parent 1585769644032 count 1
	extent vaddr 1935472312320 length 8101888 refs 1 gen 113299 flags DATA
	    inline shared data backref parent 1585769644032 count 1
	extent vaddr 1935480414208 length 20455424 refs 1 gen 113299 flags DATA
	    inline shared data backref parent 1585769644032 count 1
	extent vaddr 1935500869632 length 10215424 refs 1 gen 113299 flags DATA
	    inline shared data backref parent 1585769660416 count 1
	extent vaddr 1935511085056 length 10792960 refs 1 gen 113299 flags DATA
	    inline shared data backref parent 1585769676800 count 1
	extent vaddr 1935521878016 length 6066176 refs 1 gen 113299 flags DATA
	    inline shared data backref parent 1585769709568 count 1
	extent vaddr 1935527944192 length 80896000 refs 1 gen 113299 flags DATA
	    inline shared data backref parent 1585769725952 count 1
	extent vaddr 1935608840192 length 134217728 refs 1 gen 113299 flags DATA
	    inline shared data backref parent 1585769742336 count 1
	extent vaddr 1935743057920 length 106102784 refs 1 gen 113299 flags DATA
	    inline shared data backref parent 1585769742336 count 1
	extent vaddr 1935849160704 length 3125248 refs 1 gen 113299 flags DATA
	    inline shared data backref parent 1585769742336 count 1
	extent vaddr 1935852285952 length 57344 refs 1 gen 113299 flags DATA
	    inline shared data backref parent 1585769742336 count 1

All of the extent data backrefs are removed by the balance, but the
loop keeps trying to get rid of the shared data backrefs.  It has
no effect on them, but keeps trying anyway.

This is "semi-infinite" because it is possible for the balance to
terminate if something removes those 29 extents (e.g. by looking up the
extent vaddrs with 'btrfs ins log' then feeding the references to 'btrfs
fi defrag' will reduce the number of inline shared data backref objects.
When it's reduced all the way to zero, balance starts up again, usually
promptly getting stuck on the very next block group.  If the _only_
thing running on the filesystem is balance, it will not stop looping.

Bisection points to commit d2311e698578 "btrfs: relocation: Delay reloc
tree deletion after merge_reloc_roots" as the first commit where the
balance loops can be reproduced.

I tested with commit 59b2c371052c "btrfs: check commit root generation
in should_ignore_root" as well as the rest of misc-next, but the balance
loops are still easier to reproduce than to avoid.

Once it starts happening on a filesystem, it seems to happen very
frequently.  It is not possible to reshape a RAID array of more than a
few hundred GB on kernels after 5.0.  I can get maybe 50-100 block groups
completed in a resize or balance after a fresh boot, then balance gets
stuck in loops after that.  With the fast balance cancel patches it's
possibly to recover from the loop, but futile, since the next balance
will almost always also loop, even if it is passed a different block
group.  I've had to downgrade to 5.0 or 4.19 to complete any RAID
reshaping work.

--8S8xwCNhfXjuHwS7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXpIzIQAKCRCB+YsaVrMb
nJYPAJ4tbSrlIXJRkrCyfvegNQimTULJ2wCgrXx1elHMt22pxtkqo/c2mp0yj20=
=BFz4
-----END PGP SIGNATURE-----

--8S8xwCNhfXjuHwS7--
