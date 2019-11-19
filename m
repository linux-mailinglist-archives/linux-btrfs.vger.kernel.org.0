Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6BB1019DF
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 07:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfKSG66 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 01:58:58 -0500
Received: from mout.gmx.net ([212.227.17.21]:52989 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfKSG66 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 01:58:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574146689;
        bh=sAc1BrzLqjOlrQ5NOUhTMEtV1UlKWkXY+GHjHxasoYM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=GzK0CjIQZuKXQJl/56cpDWmOExwkv/0Rk2CK1eobZz0Mbq2s3KmbClhHMKpIdvrtQ
         PfuBQxR7Dq3/MUhBe1CZ8rEv5c3aBkKbuVGKQvqrrxRB6kTvv1DON7wSiEaQD2MRJN
         oBCWqCC1laURAOFF3152E79exxQ4WAEUps8wmECY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2wKq-1iaGqq3Mmi-003Qu3; Tue, 19
 Nov 2019 07:58:09 +0100
Subject: Re: RAID5 fails to correct correctable errors, makes them
 uncorrectable instead (sometimes). With reproducer for kernel 5.3.11
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
References: <20191119040827.GC22121@hungrycats.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <717f6e77-12f5-a8eb-8ef6-69d8c6cbb0f8@gmx.com>
Date:   Tue, 19 Nov 2019 14:58:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191119040827.GC22121@hungrycats.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HO6BIqVFjFXqoP6Ukn9CeTYFTEp4wr5QV"
X-Provags-ID: V03:K1:QYFkoPgqdtNI2EDvsLYYiAiw6Ju5TqxG7BKUNtIKDXA4UBLkf/T
 LtlU7paunNVoBbENwwc3kSEDSlNE0cUoZBg3F/NsyBMCulYcthz723HlQmYftGjSdyqWOyQ
 q9n8tL5Oi+1rsP3F4sCCklu5hW0B8iz1iozwzc6t/ONXFblqQHZ8F8cDga/ZTS6hCHaE5zU
 +4eCmLsUn6zg4HrHF34uw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aFBQQBReSMs=:5+oe4Vl6olfTLRdRe50KVb
 xL5j5iKwPnUTtKlp5S4U4/rxQjn/LitvjFXj6x1R5PN0jVlhvnoKjM2d0nqxCNJv1FpB94Xqz
 Wk2E72193d1LNU/1DGurKeBGKXP0EZGIJxN/J+KdsorY3qhz4LQugXbVIoR7nW3FflmmMwaiI
 q9O3ReuS76tZVFsca5XtdrDG6oSgcvf0Arwgb0X8aO168t8STCQAlrkw0x/G/WO2DBkjiudpe
 winQ69k0cXDDrykd73QHb18ZpyWJ0EJQ6C0BTVnpUPCvgPifm1nLcdlT2rycyRAa1VsbdC4kw
 0RYv1qtokU0akEVst7zWDfzPoENX/iraapDwMxin3MDOll9nY9mlyjFfzyrf4FJnnMLY01vGd
 N9+nlF54mQzBk1iY/rXIkI893CgdxONvxDpkNbuQ9nhk072yBJ64GD86lBAmG50oALp6DF9g/
 rIgE5/7GMibFLw4eEC+rxysItkCh22NEJzIz2BCiaVWFFfwTE+NnJIdwLp6vsNleuMFhD11JA
 CZVrfmHqEIbwMKQUueNrVpGnq2k9tbrFshA54DS0NLjZtoBhbU+62LxGnIIMWmvPoPzb5Dyoi
 +q7ZpUICNKYU6vTnEpof8fWUfqgLkULCltaSLj4qZi7MxEzksWgML9wPhJyZjuAsSCSBmiQFG
 4D6mCQ3G7gtrZpO/HHB6flta58phWSF0sLBtauiYB5U7O54z4sdTvC/LqweOZ35X1LAD9td1z
 mBrrBcxjC7Ff1Q06lF4BhO2xRXtFCFQo+PdTDSyrB5QXoP85u/LNCMSgBf4F8CUaLyXFJFKdc
 UwaAtHX0+hLfaViXJaWxU9zrkb5z0wJGOyi++jBjvnk4SwH1T3F/EKEkyxRiLFCclXdGi5TBP
 Ph5dY7BkG045S94bLWaRdZvCkXqxpsMuY3FabioqNoKjelLTdwXF2EeYdzfCj36SY9AygDNrk
 XVVhH5I5Zli66ic0Njk6uyFAxnI6qXky4eYhnKYvcHePU82pB4O4QAGCHBZ0ropbDnBodpWh7
 3Tm7ZpmmHa7OiBEFzC0AOsjkbKae2naEgJDpfJsEgEvQ/u9Z4ROgzrngm4hrGScszRpeBMch3
 7vN/3EJVsgJ9ZSJmylu7FDO/bIkcz6klkbUcQpPlNohgd+iTgvSypkZH44WMHT8v2WdlbtYAi
 PNlljJBszjOvXI+4CZiVF/Qb3zhVccrWtL5c7HTysSnOGQiXZMv8a8rJufFMxkZ5Y/T2oF8Aq
 v9z6AXMvNa+6bU1uaY0E1hLOnyBTL6pchzsrg6zHAfUBZNru7JjOwC17gGlM=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HO6BIqVFjFXqoP6Ukn9CeTYFTEp4wr5QV
Content-Type: multipart/mixed; boundary="TpNVjOlyq3BxCt123pI2W6yQbaFVWa44J"

--TpNVjOlyq3BxCt123pI2W6yQbaFVWa44J
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/19 =E4=B8=8B=E5=8D=8812:08, Zygo Blaxell wrote:
> Sometimes, btrfs raid5 not only fails to recover corrupt data with a
> parity stripe, it also copies bad data over good data.  This propagates=

> errors between drives and makes a correctable failure uncorrectable.
> Reproducer script at the end.
>=20
> This doesn't happen very often.  The repro script corrupts *every*
> data block on one of the RAID5 drives, and only a handful of blocks
> fail to be corrected--about 16 errors per 3GB of data, but sometimes
> half or double that rate.  It behaves more like a race condition than
> a boundary condition.  It can take a few tries to get a failure with a
> 16GB disk array.  It seems to happen more often on 2-disk raid5 than
> 5-disk raid5, but if you repeat the test enough times even a 5-disk
> raid5 will eventually fail.
>=20
> Kernels 4.16..5.3 all seem to behave similarly, so this is not a new bu=
g.
> I haven't tried this reproducer on kernels earlier than 4.16 due to
> other raid5 issues in earlier kernels.
>=20
> I found 16 corrupted files after one test with 3GB of data (multiple
> copies of /usr on a Debian vm).  I dumped out the files with 'btrfs
> restore'.  These are the differences between the restored files and the=

> original data:
>=20
> 	# find -type f -print | while read x; do ls -l "$x"; cmp -l /tmp/resto=
red/"$x" /usr/"${x#*/*/}"; done
> 	-rw-r--r-- 1 root root 4179 Nov 18 20:47 ./1574119549/share/perl/5.24.=
1/Archive/Tar/Constant.pm
> 	2532 253 147
> 	-rw-r--r-- 1 root root 18725 Nov 18 20:47 ./1574119549/share/perl/5.24=
=2E1/Archive/Tar/File.pm
> 	 2481  20 145
> 	 6481 270 145
> 	 8876   3 150
> 	13137 232  75
> 	16805 103  55
> 	-rw-r--r-- 1 root root 3421 Nov 18 20:47 ./1574119549/share/perl/5.24.=
1/App/Prove/State/Result/Test.pm
> 	2064   0 157
> 	-rw-r--r-- 1 root root 4948 Nov 18 20:47 ./1574119549/share/perl/5.24.=
1/App/Prove/State/Result.pm
> 	2262 226 145
> 	-rw-r--r-- 1 root root 11692 Nov 18 20:47 ./1574119549/share/perl/5.24=
=2E1/App/Prove/State.pm
> 	 7115 361 164
> 	 8333 330  12
> 	-rw-r--r-- 1 root root 316211 Nov 18 20:47 ./1574119549/share/perl/5.2=
4.1/perl5db.pl
> 	263868  35  40
> 	268307 143  40
> 	272168 370 154
> 	275138  25 145
> 	280076 125  40
> 	282683 310 136
> 	286949 132  44
> 	293453 176 163
> 	296803  40  52
> 	300719 307  40
> 	305953  77 174
> 	310419 124 161
> 	312922  47  40
> 	-rw-r--r-- 1 root root 11113 Nov 18 20:47 ./1574119549/share/perl/5.24=
=2E1/B/Debug.pm
> 	  787 323 102
> 	 6775 372 141
> 	-rw-r--r-- 1 root root 2346 Nov 18 20:47 ./1574119549/share/man/man1/g=
etconf.1.gz
> 	 484 262  41
> 	-rw-r--r-- 1 root root 3296 Nov 18 20:47 ./1574119549/share/man/man1/g=
enrsa.1ssl.gz
> 	2777 247 164
> 	-rw-r--r-- 1 root root 4815 Nov 18 20:47 ./1574119549/share/man/man1/g=
enpkey.1ssl.gz
> 	3128  22   6
> 	-rw-r--r-- 1 root root 6558 Nov 18 20:47 ./1574119553/share/perl/5.24.=
1/ExtUtils/MM_NW5.pm
> 	3378 253 146
> 	6224 162  42
> 	-rw-r--r-- 1 root root 75950 Nov 18 20:47 ./1574119553/share/perl/5.24=
=2E1/ExtUtils/MM_Any.pm
> 	68112   2 111
> 	73226 344 150
> 	75622  12  40
> 	-rw-r--r-- 1 root root 3873 Nov 18 20:47 ./1574119553/share/perl/5.24.=
1/ExtUtils/MM_OS2.pm
> 	1859 247  40
> 	-rw-r--r-- 1 root root 86458 Nov 18 20:47 ./1574119553/share/locale/zh=
_CN/LC_MESSAGES/gnupg2.mo
> 	66721 200 346
> 	72692 211 270
> 	74596 336 101
> 	79179 257   0
> 	85438 104 256
> 	-rw-r--r-- 1 root root 2528 Nov 18 20:47 ./1574119553/share/man/man1/g=
etent.1.gz
> 	1722 243 356
> 	-rw-r--r-- 1 root root 2346 Nov 18 20:47 ./1574119553/share/man/man1/g=
etconf.1.gz
> 	1062 212 267
>=20
> Note that the reproducer script will corrupt exactly one random byte pe=
r
> 4K block to guarantee the corruption is detected by the crc32c algorith=
m.
> In all cases the corrupted data is one byte per 4K block, as expected.
>=20
> I dumped out the files by reading the blocks directly from the file
> system.  Data and parity blocks from btrfs were identical and matched t=
he
> corrupted data from btrfs restore.  This is interesting because the rep=
ro
> script only corrupts one drive!  The only way blocks on both drives end=

> up corrupted identically (or at all) is if btrfs copies the bad data
> over the good.
>=20
> There is also some spatial clustering of the unrecoverable blocks.
> Here are the physical block addresses (in hex to make mod-4K and mod-64=
K
> easier to see):
>=20
> 	Extent bytenr start..end   Filename
> 	0xcc160000..0xcc176000 1574119553/share/locale/zh_CN/LC_MESSAGES/gnupg=
2.mo
> 	0xcd0f0000..0xcd0f2000 1574119549/share/man/man1/genpkey.1ssl.gz
> 	0xcd0f3000..0xcd0f4000 1574119549/share/man/man1/genrsa.1ssl.gz
> 	0xcd0f4000..0xcd0f5000 1574119549/share/man/man1/getconf.1.gz
> 	0xcd0fb000..0xcd0fc000 1574119553/share/man/man1/getconf.1.gz
> 	0xcd13f000..0xcd140000 1574119553/share/man/man1/getent.1.gz
> 	0xd0d70000..0xd0dbe000 1574119549/share/perl/5.24.1/perl5db.pl
> 	0xd0f8f000..0xd0f92000 1574119549/share/perl/5.24.1/App/Prove/State.pm=

> 	0xd0f92000..0xd0f94000 1574119549/share/perl/5.24.1/App/Prove/State/Re=
sult.pm
> 	0xd0f94000..0xd0f95000 1574119549/share/perl/5.24.1/App/Prove/State/Re=
sult/Test.pm
> 	0xd0fd6000..0xd0fd8000 1574119549/share/perl/5.24.1/Archive/Tar/Consta=
nt.pm
> 	0xd0fd8000..0xd0fdd000 1574119549/share/perl/5.24.1/Archive/Tar/File.p=
m
> 	0xd0fdd000..0xd0fe0000 1574119549/share/perl/5.24.1/B/Debug.pm
> 	0xd1540000..0xd1553000 1574119553/share/perl/5.24.1/ExtUtils/MM_Any.pm=

> 	0xd155c000..0xd155e000 1574119553/share/perl/5.24.1/ExtUtils/MM_NW5.pm=

> 	0xd155e000..0xd155f000 1574119553/share/perl/5.24.1/ExtUtils/MM_OS2.pm=

>=20
> Notice that 0xcd0f0000 to 0xcd0fb000 are in the same RAID5 strip (64K),=

> as are 0xd0f92000 to 0xd0fdd000, and 0xd155c000 to 0xd155e000.  The fil=
es
> gnupg2.mo and perl5db.pl also include multiple corrupted blocks within
> a single RAID strip.
>=20
> All files that had sha1sum failures also had EIO/csum failures, so btrf=
s
> did detect all the (now uncorrectable) corrupted blocks correctly.  Als=
o
> no problems have been seen with btrfs raid1 (metadata or data).
>=20
> Reproducer (runs in a qemu with test disks on /dev/vdb and /dev/vdc):
>=20
> 	#!/bin/bash
> 	set -x
>=20
> 	# Reset state
> 	umount /try
> 	mkdir -p /try
>=20
> 	# Create FS and mount.	Use raid1 metadata so the filesystem
> 	# has a fair chance of survival.
> 	mkfs.btrfs -draid5 -mraid1 -f /dev/vd[bc] || exit 1

Two devices raid5, that's just RAID1, but with all the RAID5 stripe
limitations.
But even two disks raid5 shouldn't be that unstable, so it looks like a b=
ug.

I'll try to make the reproducer smaller and take a look into the behavior=
=2E
To be honest, I didn't expect 2 disks raid5 nor the strange corruption.

BTW, I guess you also tried 3 disks raid5, what's the result?

Thanks,
Qu

> 	btrfs dev scan
> 	mount -onoatime /dev/vdb /try || exit 1
>=20
> 	# Must be on btrfs
> 	cd /try || exit 1
> 	btrfs sub list . || exit 1
>=20
> 	# Fill disk with files.  Increase seq for more test data
> 	# to increase the chance of finding corruption.
> 	for x in $(seq 0 3); do
> 		sync &
> 		rsync -axHSWI "/usr/." "/try/$(date +%s)" &
> 		sleep 2
> 	done
> 	wait
>=20
> 	# Remove half the files.  If you increased seq above, increase the
> 	# '-2' here as well.
> 	find /try/* -maxdepth 0 -type d -print | unsort | head -2 | while read=
 x; do
> 		sync &
> 		rm -fr "$x" &
> 		sleep 2
> 	done
> 	wait
>=20
> 	# Fill in some of the holes.  This is to get a good mix of
> 	# partially filled RAID stripes of various sizes.
> 	for x in $(seq 0 1); do
> 		sync &
> 		rsync -axHSWI "/usr/." "/try/$(date +%s)" &
> 		sleep 2
> 	done
> 	wait
>=20
> 	# Calculate hash we will use to verify data later
> 	find -type f -exec sha1sum {} + > /tmp/sha1sums.txt
>=20
> 	# Make sure it's all on the disk
> 	sync
> 	sysctl vm.drop_caches=3D3
>=20
> 	# See distribution of data across drives
> 	btrfs dev usage /try
> 	btrfs fi usage /try
>=20
> 	# Corrupt one byte of each of the first 4G on /dev/vdb,
> 	# so that the crc32c algorithm will always detect the corruption.
> 	# If you need a bigger test disk then increase the '4'.
> 	# Leave the first 16MB of the disk alone so we don't kill the superblo=
ck.
> 	perl -MFcntl -e '
> 		for my $x (0..(4 * 1024 * 1024 * 1024 / 4096)) {
> 			my $pos =3D int(rand(4096)) + 16777216 + ($x * 4096);
> 			sysseek(STDIN, $pos, SEEK_SET) or die "seek: $!";
> 			sysread(STDIN, $dat, 1) or die "read: $!";
> 			sysseek(STDOUT, $pos, SEEK_SET) or die "seek: $!";
> 			syswrite(STDOUT, chr(ord($dat) ^ int(rand(255) + 1)), 1) or die "wri=
te: $!";
> 		}
> 	' </dev/vdb >/dev/vdb
>=20
> 	# Make sure all that's on disk and our caches are empty
> 	sync
> 	sysctl vm.drop_caches=3D3
>=20
> 	# Before and after dev stat and read-only scrub to see what the damage=
 looks like.
> 	# This will produce some ratelimited kernel output.
> 	btrfs dev stat /try | grep -v ' 0$'
> 	btrfs scrub start -rBd /try
> 	btrfs dev stat /try | grep -v ' 0$'
>=20
> 	# Verify all the files are correctly restored transparently by btrfs.
> 	# btrfs repairs correctable blocks as a side-effect.
> 	sha1sum --quiet -c /tmp/sha1sums.txt
>=20
> 	# Do a scrub to clean up stray corrupted blocks (including superblocks=
)
> 	btrfs dev stat /try | grep -v ' 0$'
> 	btrfs scrub start -Bd /try
> 	btrfs dev stat /try | grep -v ' 0$'
>=20
> 	# This scrub should be clean, but sometimes is not.
> 	btrfs scrub start -Bd /try
> 	btrfs dev stat /try | grep -v ' 0$'
>=20
> 	# Verify that the scrub didn't corrupt anything.
> 	sha1sum --quiet -c /tmp/sha1sums.txt
>=20


--TpNVjOlyq3BxCt123pI2W6yQbaFVWa44J--

--HO6BIqVFjFXqoP6Ukn9CeTYFTEp4wr5QV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3TkngXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qibZAf/WJJOfN16Xipb4hbOD11iFXDJ
MAXyo81Psu9/IXbH98teFtEsx/3vq4jHnQQoHPrF0wU03H9Ia4MR5N1u1v6tPAv8
nQ6vc6wwGwN69DMvG859VP9uhF7bJF4+/qmc0XKIGa3aUIkXfjnGW7z42mt7uPnu
jsWT72X759GPiQmcNIqI+j7QpF4eKxMtpdlPhuiDUL9SxPvzuIj582zEvo8T48zJ
N4g4vhwpt6KTSDbWjNImXOPUre6ZTpiPndOchWdpGcmLGcPB6B7P80sO+J/gteBV
SR+B01IZ39Zyrh6cIglw+KBk6HQR1LcrOoi64/1blN/ZdV1v3vE6Ny777GI/fQ==
=eqCj
-----END PGP SIGNATURE-----

--HO6BIqVFjFXqoP6Ukn9CeTYFTEp4wr5QV--
