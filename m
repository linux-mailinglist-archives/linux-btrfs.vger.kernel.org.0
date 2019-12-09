Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 301321164C9
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 02:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfLIBdY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Dec 2019 20:33:24 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:40960 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfLIBdY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 Dec 2019 20:33:24 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 9B8655161FE; Sun,  8 Dec 2019 20:33:22 -0500 (EST)
Date:   Sun, 8 Dec 2019 20:33:22 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Mike Gilbert <floppymaster@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Unable to remove directory entry
Message-ID: <20191209013322.GG22121@hungrycats.org>
References: <CAJ0EP41toGSPQwB4Ys4aNzGGJNDBS-NHgPOcGanBk6d6Nn_LWw@mail.gmail.com>
 <20191209001721.GF22121@hungrycats.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xt4oM5y0t/70YhQj"
Content-Disposition: inline
In-Reply-To: <20191209001721.GF22121@hungrycats.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--xt4oM5y0t/70YhQj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 08, 2019 at 07:17:21PM -0500, Zygo Blaxell wrote:
> On Sun, Dec 08, 2019 at 02:19:10PM -0500, Mike Gilbert wrote:
> > Hello,
> >=20
> > I have a directory entry that cannot be stat-ed or unlinked. This
> > issue persists across reboots, so it seems there is something wrong on
> > disk.
> >=20
> > % ls -l /var/cache/ccache.bad/2/c
> > ls: cannot access
> > '/var/cache/ccache.bad/2/c/0390cb341d248c589c419007da68b2-7351.manifest=
':
> > No such
> > file or directory
> > total 0
> > -????????? ? ? ? ?            ? 0390cb341d248c589c419007da68b2-7351.man=
ifest
>=20
> I have seen a bug similar to this some years ago.  It was present as
> far back as 4.5, and seems to still be present in 5.0.21.  I don't have
> detailed tracking information on it due to the low severity: not a crash
> or data corruption bug, and workarounds exist both to prevent the bug
> and to clean up its aftermath.
>=20
> The reproducer is something like:
>=20
> 	while (true) { // pseudocode
> 		int fd =3D create(tmp_name);
> 		write(fd, ...);
> 		fsync(fd);	// required, bug does not appear without this fsync
> 		close(fd);
> 		rename(tmp_name, regular_name);
> 	}
>=20
> and a crash, maybe with some heavy write load.  This is typical of
> applications like git and ccache, and in the wild, broken directory
> entries are often found in these applications' directories.
>=20
> Somewhere between 4.5 and 4.12 (a big range, I know), there was a change
> in behavior:  before, the broken directory entry could not be removed,
> renamed, or used for a new file, the only way to get rid of the broken
> directory entry was to delete the entire subvol.  After the behavior
> change, the broken directory entry could be removed by creating a new
> file and renaming it to the broken directory entry name.

I found a filesystem that currently has one of these broken dirents:

	root@tester24:/media/testfs/beeshome# ls -l
	ls: cannot access 'beesstats.txt.tmp': No such file or directory
	total 3446032
	-rw-r--r-- 1 root root      10313 Nov 22  2018 all-df-today.png
	-rw-r--r-- 1 root root    3297813 Nov 22  2018 all-df-today.txt
	-rw------- 1 root root    1048488 Dec  7 17:35 beescrawl.dat
	-rwx------ 1 root root 1073741824 Dec  8 20:19 beeshash.dat
	-????????? ? ?    ?             ?            ? beesstats.txt.tmp
	-rw-r--r-- 1 root root   16064406 Dec  3 00:13 df-2019-11-28.txt
	-rw-r--r-- 1 root root    4269887 Dec  5 00:52 df-2019-12-03.txt
	-rw-r--r-- 1 root root    6358158 Dec  7 16:44 df-2019-12-05.txt
	-rw-r--r-- 1 root root    3221101 Dec  8 20:18 df-2019-12-07.txt
	-rw-r--r-- 1 root root 2208475574 Dec  3 00:13 log-2019-11-28.txt
	-rw-r--r-- 1 root root   72372394 Dec  5 00:52 log-2019-12-03.txt
	-rw-r--r-- 1 root root   97472346 Dec  7 16:44 log-2019-12-05.txt
	-rw-r--r-- 1 root root   42378425 Dec  8 20:19 log-2019-12-07.txt
	lrwxrwxrwx 1 root root         18 Dec  7 17:35 log-today.txt -> log-2019-1=
2-07.txt

It seems I can create a file with the same name, and then I get two:

	root@tester24:/media/testfs/beeshome# date > beesstats.txt.tmp
	root@tester24:/media/testfs/beeshome# ls -l
	total 3446044
	-rw-r--r-- 1 root root      10313 Nov 22  2018 all-df-today.png
	-rw-r--r-- 1 root root    3297813 Nov 22  2018 all-df-today.txt
	-rw------- 1 root root    1048488 Dec  7 17:35 beescrawl.dat
	-rwx------ 1 root root 1073741824 Dec  8 20:19 beeshash.dat
	-rw-r--r-- 1 root root         29 Dec  8 20:19 beesstats.txt.tmp
	-rw-r--r-- 1 root root         29 Dec  8 20:19 beesstats.txt.tmp
	-rw-r--r-- 1 root root   16064406 Dec  3 00:13 df-2019-11-28.txt
	-rw-r--r-- 1 root root    4269887 Dec  5 00:52 df-2019-12-03.txt
	-rw-r--r-- 1 root root    6358158 Dec  7 16:44 df-2019-12-05.txt
	-rw-r--r-- 1 root root    3221363 Dec  8 20:19 df-2019-12-07.txt
	-rw-r--r-- 1 root root 2208475574 Dec  3 00:13 log-2019-11-28.txt
	-rw-r--r-- 1 root root   72372394 Dec  5 00:52 log-2019-12-03.txt
	-rw-r--r-- 1 root root   97472346 Dec  7 16:44 log-2019-12-05.txt
	-rw-r--r-- 1 root root   42384027 Dec  8 20:19 log-2019-12-07.txt
	lrwxrwxrwx 1 root root         18 Dec  7 17:35 log-today.txt -> log-2019-1=
2-07.txt
	root@tester24:/media/testfs/beeshome# cat beesstats.txt.tmp=20
	Sun Dec  8 20:19:38 EST 2019

dump-tree sees both DIR_INDEX but only one DIR_ITEM:

        item 9 key (256 DIR_ITEM 2721875446) itemoff 15740 itemsize 47
                location key (133693 INODE_ITEM 0) type FILE
                transid 5002644 data_len 0 name_len 17
                name: beesstats.txt.tmp
        item 18 key (256 DIR_INDEX 22037) itemoff 15332 itemsize 47
                location key (11481 INODE_ITEM 0) type FILE
                transid 1876891 data_len 0 name_len 17
                name: beesstats.txt.tmp
        item 32 key (256 DIR_INDEX 264858) itemoff 14684 itemsize 47
                location key (133693 INODE_ITEM 0) type FILE
                transid 5002644 data_len 0 name_len 17
                name: beesstats.txt.tmp

but I can only delete DIR_ITEMs:

	root@tester24:/media/testfs/beeshome# rm beesstats.txt.tmp=20
	root@tester24:/media/testfs/beeshome# rm beesstats.txt.tmp=20
	rm: cannot remove 'beesstats.txt.tmp': No such file or directory
	root@tester24:/media/testfs/beeshome# ls -l
	ls: cannot access 'beesstats.txt.tmp': No such file or directory
	total 3446048
	-rw-r--r-- 1 root root      10313 Nov 22  2018 all-df-today.png
	-rw-r--r-- 1 root root    3297813 Nov 22  2018 all-df-today.txt
	-rw------- 1 root root    1048488 Dec  7 17:35 beescrawl.dat
	-rwx------ 1 root root 1073741824 Dec  8 20:20 beeshash.dat
	-????????? ? ?    ?             ?            ? beesstats.txt.tmp
	-rw-r--r-- 1 root root   16064406 Dec  3 00:13 df-2019-11-28.txt
	-rw-r--r-- 1 root root    4269887 Dec  5 00:52 df-2019-12-03.txt
	-rw-r--r-- 1 root root    6358158 Dec  7 16:44 df-2019-12-05.txt
	-rw-r--r-- 1 root root    3221494 Dec  8 20:19 df-2019-12-07.txt
	-rw-r--r-- 1 root root 2208475574 Dec  3 00:13 log-2019-11-28.txt
	-rw-r--r-- 1 root root   72372394 Dec  5 00:52 log-2019-12-03.txt
	-rw-r--r-- 1 root root   97472346 Dec  7 16:44 log-2019-12-05.txt
	-rw-r--r-- 1 root root   42396102 Dec  8 20:20 log-2019-12-07.txt
	lrwxrwxrwx 1 root root         18 Dec  7 17:35 log-today.txt -> log-2019-1=
2-07.txt

leaving the first DIR_INDEX behind:

        item 17 key (256 DIR_INDEX 22037) itemoff 15379 itemsize 47
                location key (11481 INODE_ITEM 0) type FILE
                transid 1876891 data_len 0 name_len 17
                name: beesstats.txt.tmp

So the btrfs read side is fine, it's the writing side that is putting bad
metadata on the disk.

> Another workaround is to remove the fsync by running the application
> under eatmydata.  btrfs performs a flush in the rename() operation when
> an existing file is replaced, so the fsync that triggers the bug was
> not necessary in the first place.  Note this only works when replacing
> an existing file, so the flushoncommit mount option is required to make
> this work in other cases.
>=20
> > % uname -a
> > Linux naomi 4.19.67 #4 SMP Sun Aug 18 14:35:39 EDT 2019 x86_64 AMD
> > Phenom(tm) II X6 1055T Processor
> > AuthenticAMD GNU/Linux
> >=20
> > % btrfs --version
> > btrfs-progs v5.4
> >=20
> > I have tried running btrfs check, and I get differing results based on
> > the --mode switch:
> >=20
> > # btrfs check --readonly /dev/sda3
> > [1/7] checking root items
> > [2/7] checking extents
> > [3/7] checking free space cache
> > [4/7] checking fs roots
> > [5/7] checking only csums items (without verifying data)
> > [6/7] checking root refs
> > [7/7] checking quota groups
> > Opening filesystem to check...
> > Checking filesystem on /dev/sda3
> > UUID: 5e9dcab6-036d-40f1-8b40-24ab4c062bf6
> > found 284337733632 bytes used, no error found
> > total csum bytes: 267182280
> > total tree bytes: 4498915328
> > total fs tree bytes: 3972464640
> > total extent tree bytes: 199819264
> > btree space waste bytes: 776711635
> > file data blocks allocated: 313928671232
> >  referenced 279141621760
> >=20
> > # btrfs check --readonly --mode=3Dlowmem /dev/sda3
> > [1/7] checking root items
> > [2/7] checking extents
> > [3/7] checking free space cache
> > [4/7] checking fs roots
> > ERROR: root 5 INODE_ITEM[4065004] index 18446744073709551615 name
> > 0390cb341d248c589c419007da68b2-7351.manifest filetype 1 missing
> > ERROR: root 5 DIR ITEM[486836 13905] name
> > 0390cb341d248c589c419007da68b2-7351.manifest filetype 1 mismath
> > ERROR: root 5 DIR ITEM[486836 2543451757] mismatch name
> > 0390cb341d248c589c419007da68b2-7351.manifest filetype 1
> > ERROR: errors found in fs roots
> > Opening filesystem to check...
> > Checking filesystem on /dev/sda3
> > UUID: 5e9dcab6-036d-40f1-8b40-24ab4c062bf6
> > found 284337733632 bytes used, error(s) found
> > total csum bytes: 267182280
> > total tree bytes: 4498915328
> > total fs tree bytes: 3972464640
> > total extent tree bytes: 199819264
> > btree space waste bytes: 776711635
> > file data blocks allocated: 313928671232
> >  referenced 279141621760
> >=20
> > Please advise on possible next steps to diagnose and fix this.



--xt4oM5y0t/70YhQj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXe2kXwAKCRCB+YsaVrMb
nBr4AKDkYTf0m9IdzJZZdwKucnhJKiaDygCgjfL+qOW96TZgJEsNwb5FmuM1mFY=
=sXfw
-----END PGP SIGNATURE-----

--xt4oM5y0t/70YhQj--
