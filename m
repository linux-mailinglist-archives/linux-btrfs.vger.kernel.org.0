Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40350116503
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 03:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfLICXU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Dec 2019 21:23:20 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:45270 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfLICXT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 Dec 2019 21:23:19 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id F172A5162EA; Sun,  8 Dec 2019 21:23:18 -0500 (EST)
Date:   Sun, 8 Dec 2019 21:23:18 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Mike Gilbert <floppymaster@gmail.com>, linux-btrfs@vger.kernel.org
Subject: Re: Unable to remove directory entry
Message-ID: <20191209022318.GI22121@hungrycats.org>
References: <CAJ0EP41toGSPQwB4Ys4aNzGGJNDBS-NHgPOcGanBk6d6Nn_LWw@mail.gmail.com>
 <20191209001721.GF22121@hungrycats.org>
 <20191209013322.GG22121@hungrycats.org>
 <0a0ae513-0993-e732-57e4-af0fa93bb2c3@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KNVwDSkw2BjFUkD8"
Content-Disposition: inline
In-Reply-To: <0a0ae513-0993-e732-57e4-af0fa93bb2c3@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--KNVwDSkw2BjFUkD8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2019 at 09:52:54AM +0800, Qu Wenruo wrote:
>=20
>=20
> On 2019/12/9 =E4=B8=8A=E5=8D=889:33, Zygo Blaxell wrote:
> > On Sun, Dec 08, 2019 at 07:17:21PM -0500, Zygo Blaxell wrote:
> >> On Sun, Dec 08, 2019 at 02:19:10PM -0500, Mike Gilbert wrote:
> >>> Hello,
> >>>
> >>> I have a directory entry that cannot be stat-ed or unlinked. This
> >>> issue persists across reboots, so it seems there is something wrong on
> >>> disk.
> >>>
> >>> % ls -l /var/cache/ccache.bad/2/c
> >>> ls: cannot access
> >>> '/var/cache/ccache.bad/2/c/0390cb341d248c589c419007da68b2-7351.manife=
st':
> >>> No such
> >>> file or directory
> >>> total 0
> >>> -????????? ? ? ? ?            ? 0390cb341d248c589c419007da68b2-7351.m=
anifest
> >>
> >> I have seen a bug similar to this some years ago.  It was present as
> >> far back as 4.5, and seems to still be present in 5.0.21.  I don't have
> >> detailed tracking information on it due to the low severity: not a cra=
sh
> >> or data corruption bug, and workarounds exist both to prevent the bug
> >> and to clean up its aftermath.
> >>
> >> The reproducer is something like:
> >>
> >> 	while (true) { // pseudocode
> >> 		int fd =3D create(tmp_name);
> >> 		write(fd, ...);
> >> 		fsync(fd);	// required, bug does not appear without this fsync
> >> 		close(fd);
> >> 		rename(tmp_name, regular_name);
> >> 	}
> >>
> >> and a crash, maybe with some heavy write load.  This is typical of
> >> applications like git and ccache, and in the wild, broken directory
> >> entries are often found in these applications' directories.
> >>
> >> Somewhere between 4.5 and 4.12 (a big range, I know), there was a chan=
ge
> >> in behavior:  before, the broken directory entry could not be removed,
> >> renamed, or used for a new file, the only way to get rid of the broken
> >> directory entry was to delete the entire subvol.  After the behavior
> >> change, the broken directory entry could be removed by creating a new
> >> file and renaming it to the broken directory entry name.
> >=20
> > I found a filesystem that currently has one of these broken dirents:
> >=20
> > 	root@tester24:/media/testfs/beeshome# ls -l
> > 	ls: cannot access 'beesstats.txt.tmp': No such file or directory
> > 	total 3446032
> > 	-rw-r--r-- 1 root root      10313 Nov 22  2018 all-df-today.png
> > 	-rw-r--r-- 1 root root    3297813 Nov 22  2018 all-df-today.txt
> > 	-rw------- 1 root root    1048488 Dec  7 17:35 beescrawl.dat
> > 	-rwx------ 1 root root 1073741824 Dec  8 20:19 beeshash.dat
> > 	-????????? ? ?    ?             ?            ? beesstats.txt.tmp
> > 	-rw-r--r-- 1 root root   16064406 Dec  3 00:13 df-2019-11-28.txt
> > 	-rw-r--r-- 1 root root    4269887 Dec  5 00:52 df-2019-12-03.txt
> > 	-rw-r--r-- 1 root root    6358158 Dec  7 16:44 df-2019-12-05.txt
> > 	-rw-r--r-- 1 root root    3221101 Dec  8 20:18 df-2019-12-07.txt
> > 	-rw-r--r-- 1 root root 2208475574 Dec  3 00:13 log-2019-11-28.txt
> > 	-rw-r--r-- 1 root root   72372394 Dec  5 00:52 log-2019-12-03.txt
> > 	-rw-r--r-- 1 root root   97472346 Dec  7 16:44 log-2019-12-05.txt
> > 	-rw-r--r-- 1 root root   42378425 Dec  8 20:19 log-2019-12-07.txt
> > 	lrwxrwxrwx 1 root root         18 Dec  7 17:35 log-today.txt -> log-20=
19-12-07.txt
> >=20
> > It seems I can create a file with the same name, and then I get two:
> >=20
> > 	root@tester24:/media/testfs/beeshome# date > beesstats.txt.tmp
> > 	root@tester24:/media/testfs/beeshome# ls -l
> > 	total 3446044
> > 	-rw-r--r-- 1 root root      10313 Nov 22  2018 all-df-today.png
> > 	-rw-r--r-- 1 root root    3297813 Nov 22  2018 all-df-today.txt
> > 	-rw------- 1 root root    1048488 Dec  7 17:35 beescrawl.dat
> > 	-rwx------ 1 root root 1073741824 Dec  8 20:19 beeshash.dat
> > 	-rw-r--r-- 1 root root         29 Dec  8 20:19 beesstats.txt.tmp
> > 	-rw-r--r-- 1 root root         29 Dec  8 20:19 beesstats.txt.tmp
> > 	-rw-r--r-- 1 root root   16064406 Dec  3 00:13 df-2019-11-28.txt
> > 	-rw-r--r-- 1 root root    4269887 Dec  5 00:52 df-2019-12-03.txt
> > 	-rw-r--r-- 1 root root    6358158 Dec  7 16:44 df-2019-12-05.txt
> > 	-rw-r--r-- 1 root root    3221363 Dec  8 20:19 df-2019-12-07.txt
> > 	-rw-r--r-- 1 root root 2208475574 Dec  3 00:13 log-2019-11-28.txt
> > 	-rw-r--r-- 1 root root   72372394 Dec  5 00:52 log-2019-12-03.txt
> > 	-rw-r--r-- 1 root root   97472346 Dec  7 16:44 log-2019-12-05.txt
> > 	-rw-r--r-- 1 root root   42384027 Dec  8 20:19 log-2019-12-07.txt
> > 	lrwxrwxrwx 1 root root         18 Dec  7 17:35 log-today.txt -> log-20=
19-12-07.txt
> > 	root@tester24:/media/testfs/beeshome# cat beesstats.txt.tmp=20
> > 	Sun Dec  8 20:19:38 EST 2019
> >=20
> > dump-tree sees both DIR_INDEX but only one DIR_ITEM:
> >=20
> >         item 9 key (256 DIR_ITEM 2721875446) itemoff 15740 itemsize 47
> >                 location key (133693 INODE_ITEM 0) type FILE
> >                 transid 5002644 data_len 0 name_len 17
> >                 name: beesstats.txt.tmp
> >         item 18 key (256 DIR_INDEX 22037) itemoff 15332 itemsize 47
> >                 location key (11481 INODE_ITEM 0) type FILE
> >                 transid 1876891 data_len 0 name_len 17
> >                 name: beesstats.txt.tmp
> >         item 32 key (256 DIR_INDEX 264858) itemoff 14684 itemsize 47
> >                 location key (133693 INODE_ITEM 0) type FILE
> >                 transid 5002644 data_len 0 name_len 17
> >                 name: beesstats.txt.tmp
> >=20
> > but I can only delete DIR_ITEMs:
> >=20
> > 	root@tester24:/media/testfs/beeshome# rm beesstats.txt.tmp=20
> > 	root@tester24:/media/testfs/beeshome# rm beesstats.txt.tmp=20
> > 	rm: cannot remove 'beesstats.txt.tmp': No such file or directory
> > 	root@tester24:/media/testfs/beeshome# ls -l
> > 	ls: cannot access 'beesstats.txt.tmp': No such file or directory
> > 	total 3446048
> > 	-rw-r--r-- 1 root root      10313 Nov 22  2018 all-df-today.png
> > 	-rw-r--r-- 1 root root    3297813 Nov 22  2018 all-df-today.txt
> > 	-rw------- 1 root root    1048488 Dec  7 17:35 beescrawl.dat
> > 	-rwx------ 1 root root 1073741824 Dec  8 20:20 beeshash.dat
> > 	-????????? ? ?    ?             ?            ? beesstats.txt.tmp
> > 	-rw-r--r-- 1 root root   16064406 Dec  3 00:13 df-2019-11-28.txt
> > 	-rw-r--r-- 1 root root    4269887 Dec  5 00:52 df-2019-12-03.txt
> > 	-rw-r--r-- 1 root root    6358158 Dec  7 16:44 df-2019-12-05.txt
> > 	-rw-r--r-- 1 root root    3221494 Dec  8 20:19 df-2019-12-07.txt
> > 	-rw-r--r-- 1 root root 2208475574 Dec  3 00:13 log-2019-11-28.txt
> > 	-rw-r--r-- 1 root root   72372394 Dec  5 00:52 log-2019-12-03.txt
> > 	-rw-r--r-- 1 root root   97472346 Dec  7 16:44 log-2019-12-05.txt
> > 	-rw-r--r-- 1 root root   42396102 Dec  8 20:20 log-2019-12-07.txt
> > 	lrwxrwxrwx 1 root root         18 Dec  7 17:35 log-today.txt -> log-20=
19-12-07.txt
> >=20
> > leaving the first DIR_INDEX behind:
> >=20
> >         item 17 key (256 DIR_INDEX 22037) itemoff 15379 itemsize 47
> >                 location key (11481 INODE_ITEM 0) type FILE
> >                 transid 1876891 data_len 0 name_len 17
> >                 name: beesstats.txt.tmp
>=20
> This looks like a older kernel bug (hopes so).
>=20
> So there is an orphan DIR_INDEX left, but never cleaned up properly.
>=20
> In that case, btrfs-progs should be able to repair it.
> But strangely, why original mode check didn't report it?

I'm not sure what you mean by "original mode check".

I can't run btrfs check on this filesystem (97GB of metadata, too
big for either regular or lowmem to handle in reasonable time).

There used to be a stat check on the missing inode, which would fail
in older kernels, and make the filename permanently unusable (until the
subvol was deleted).  That broke a lot of applications.  The stat check
was removed at some point, which is much better.

> BTW, does that 11481 inode still exist?

Nope, the only '11481' in the entire subvol's dump-tree output is that
DIR_INDEX item.

> Thanks,
> Qu
> >=20
> > So the btrfs read side is fine, it's the writing side that is putting b=
ad
> > metadata on the disk.
> >=20
> >> Another workaround is to remove the fsync by running the application
> >> under eatmydata.  btrfs performs a flush in the rename() operation when
> >> an existing file is replaced, so the fsync that triggers the bug was
> >> not necessary in the first place.  Note this only works when replacing
> >> an existing file, so the flushoncommit mount option is required to make
> >> this work in other cases.
> >>
> >>> % uname -a
> >>> Linux naomi 4.19.67 #4 SMP Sun Aug 18 14:35:39 EDT 2019 x86_64 AMD
> >>> Phenom(tm) II X6 1055T Processor
> >>> AuthenticAMD GNU/Linux
> >>>
> >>> % btrfs --version
> >>> btrfs-progs v5.4
> >>>
> >>> I have tried running btrfs check, and I get differing results based on
> >>> the --mode switch:
> >>>
> >>> # btrfs check --readonly /dev/sda3
> >>> [1/7] checking root items
> >>> [2/7] checking extents
> >>> [3/7] checking free space cache
> >>> [4/7] checking fs roots
> >>> [5/7] checking only csums items (without verifying data)
> >>> [6/7] checking root refs
> >>> [7/7] checking quota groups
> >>> Opening filesystem to check...
> >>> Checking filesystem on /dev/sda3
> >>> UUID: 5e9dcab6-036d-40f1-8b40-24ab4c062bf6
> >>> found 284337733632 bytes used, no error found
> >>> total csum bytes: 267182280
> >>> total tree bytes: 4498915328
> >>> total fs tree bytes: 3972464640
> >>> total extent tree bytes: 199819264
> >>> btree space waste bytes: 776711635
> >>> file data blocks allocated: 313928671232
> >>>  referenced 279141621760
> >>>
> >>> # btrfs check --readonly --mode=3Dlowmem /dev/sda3
> >>> [1/7] checking root items
> >>> [2/7] checking extents
> >>> [3/7] checking free space cache
> >>> [4/7] checking fs roots
> >>> ERROR: root 5 INODE_ITEM[4065004] index 18446744073709551615 name
> >>> 0390cb341d248c589c419007da68b2-7351.manifest filetype 1 missing
> >>> ERROR: root 5 DIR ITEM[486836 13905] name
> >>> 0390cb341d248c589c419007da68b2-7351.manifest filetype 1 mismath
> >>> ERROR: root 5 DIR ITEM[486836 2543451757] mismatch name
> >>> 0390cb341d248c589c419007da68b2-7351.manifest filetype 1
> >>> ERROR: errors found in fs roots
> >>> Opening filesystem to check...
> >>> Checking filesystem on /dev/sda3
> >>> UUID: 5e9dcab6-036d-40f1-8b40-24ab4c062bf6
> >>> found 284337733632 bytes used, error(s) found
> >>> total csum bytes: 267182280
> >>> total tree bytes: 4498915328
> >>> total fs tree bytes: 3972464640
> >>> total extent tree bytes: 199819264
> >>> btree space waste bytes: 776711635
> >>> file data blocks allocated: 313928671232
> >>>  referenced 279141621760
> >>>
> >>> Please advise on possible next steps to diagnose and fix this.
> >=20
> >=20
>=20




--KNVwDSkw2BjFUkD8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXe2wFgAKCRCB+YsaVrMb
nAh6AJwJzRI4DUxsh9i1Dcxkw8E7ywIWGgCeIOGQJjGcgFDBhWiy2m23w909aXc=
=eq/A
-----END PGP SIGNATURE-----

--KNVwDSkw2BjFUkD8--
