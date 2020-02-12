Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72E26159FB7
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 05:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgBLEB4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 23:01:56 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:40460 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgBLEB4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 23:01:56 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id C63175BCC87; Tue, 11 Feb 2020 23:01:54 -0500 (EST)
Date:   Tue, 11 Feb 2020 23:01:54 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: some more information on multi-hour data rollbacks, fsync, and
 superblock updates or lack thereof
Message-ID: <20200212040154.GL13306@hungrycats.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yruHGtsrg8HLSUpe"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--yruHGtsrg8HLSUpe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

While trying to understand how btrfs rolls back data several hours on a
crash, I deployed some observation tools:  one to measure fsync latency,
and one to measure the interval between updates to the filesystem
superblock's generation (transid) field.  I wanted to see if this
phenomenon can be detected so I can figure out how to replicate it.
I put these tools on some test and production machines.

The results so far are somewhat disturbing:

5.0 can do multi-hour transactions too, in fact it's even easier to do
on 5.0 than on 5.4.  Not that I've figured out how to replicate this
behavior on demand yet, just that the data I've collected so far has more
and longer long transactions occurring "naturally" on 5.0 than on 5.4.

There is no obvious correlation between the running times of fsync,
superblock updates, and other metadata operations.  Without looking
directly at the superblock, there's no obvious sign of a problem:
applications are reading and writing and even calling fsync() normally,
but the superblock's generation field stubbornly does not update.
A machine that I previously thought had been healthy and performing
excellently turned out to be my example case of a trivially reproduced,
worst-case scenario.

Everything seems fine as long as a host _never_ runs fsync.  I had one
host that was up for days without incident with transactions updating
at reasonable intervals, until I started running the fsync test, and had
an immediate 45-minute transaction stall.  The 5-hour data loss event I
reported a few days ago and the 14-hour transaction event before that
also started almost immediately following fsync() calls.  Maybe not
a coincidence?

fsync returns ... well, not immediately, but almost always within 10
minutes or less, even at times when the filesystem's superblock generation
number is not updated for an hour.

The good news is that fsync does work.  I caught a machine in the middle
of one of these multi-hour transactions, made two files, fsynced one,
and forced a crash, with the result:

	# cat /proc/version
	Linux version 5.0.21-zb64-079f865c6d4d+ (root@waya) (gcc version 8.3.0 (Debian 8.3.0-6)) #1 SMP Wed Jan 22 12:06:32 EST 2020
	# cp /boot/vmlinuz test-no-fsync
	# cp /boot/vmlinuz test-fsync
	# sync test-fsync
	# ls -l
	total 16812
	-rw-r--r-- 1 root root  102458 Feb 11 22:09 fsync.log
	-rw------- 1 root root 8550048 Feb 11 22:09 test-fsync
	-rw------- 1 root root 8550048 Feb 11 22:09 test-no-fsync
	-rw-r--r-- 1 root root    3710 Feb 11 21:22 transid.log
	# echo b > /proc/sysrq-trigger

One reboot later:

	# ls -l
	total 8448
	-rw-r--r-- 1 root root   92256 Feb 11 20:56 fsync.log
	-rw------- 1 root root 8550048 Feb 11 22:09 test-fsync
	-rw-r--r-- 1 root root    3652 Feb 11 19:57 transid.log
	# cmp test-fsync /boot/vmlinuz
	#

So the file that was fsynced is complete and correct, but the file
that was not fsynced--and 73 minutes of other writes throughout the
filesystem--neatly disappeared.

This was the third of three consecutive hour-plus transactions on
this host:

        end of transaction timestamp   seconds with same transid
        2020-02-11-19-57-39 1581469059 4315.585493582
        2020-02-11-21-22-06 1581474126 5067.863739094
        [third transaction aborted by reboot 47 minutes later]

The timestamps don't quite line up here--there is data on the filesystem
after the last superblock update (at 21:22), but still far from current
(73 minutes lost).  Maybe btrfs is updating one superblock at a time,
so I only see one of every 3 transid updates with this method?  But the
transid increment is always 1, and I'd expect to see increments 3 at a
time if I was missing two thirds of them.

If you would like to play at home, the fsync latency testing tool is:

	#define _GNU_SOURCE 1

	#include <errno.h>
	#include <fcntl.h>
	#include <math.h>
	#include <stdbool.h>
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <sys/random.h>
	#include <time.h>
	#include <unistd.h>

	static char buf[128 * 1024 * 1024];

	void
	fillrandom(void *buf, size_t size, unsigned flags)
	{
		while (size) {
			const ssize_t rv = getrandom(buf, size, flags);
			if (rv < 0) {
				perror("getrandom");
				exit(1);
			}
			if ((size_t)rv > size) {
				fprintf(stderr, "WTF: rv %zd > size %zu\n", rv, size);
				exit(1);
			}
			buf += rv;
			size -= rv;
		}
	}

	int
	main(int argc, char **argv)
	{
		double sleep_time = 1;
		if (argc == 2) {
			sleep_time = atof(argv[1]);
		}
		const int fd = open(".", O_TMPFILE | O_RDWR, 0666);
		if (fd < 0) {
			perror("open");
			exit(1);
		}
		const struct timespec sleep_ts = {
			.tv_sec = sleep_time,
			.tv_nsec = 1000000000 * (sleep_time - floor(sleep_time)),
		};

		fprintf(stderr, "Waiting for random...");
		fflush(stderr);
		fillrandom(buf, sizeof(buf), 0);
		fprintf(stderr, "\n");
		fflush(stderr);

		struct timespec next_time;
		clock_gettime(CLOCK_MONOTONIC, &next_time);

		while (true) {

			struct timespec start;
			clock_gettime(CLOCK_MONOTONIC, &start);

			write(2, "w\b", 2);
			unsigned wr_pos = 0, wr_len = 256 * 1024;
			fillrandom(&wr_pos, sizeof(wr_pos), 0);
			fillrandom(&wr_len, sizeof(wr_len), 0);
			wr_pos %= sizeof(buf) * 8;
			wr_len %= sizeof(buf);
			const int rvw = pwrite(fd, buf, wr_len, wr_pos);
			if (rvw < 0) {
				perror("pwrite");
				exit(1);
			}

			write(2, "f\b", 2);
			const int rvf = fsync(fd);
			if (rvf) {
				perror("fsync");
				exit(1);
			}
			write(2, "s\b", 2);

			struct timespec end;
			clock_gettime(CLOCK_MONOTONIC, &end);
			char ft[1024];
			struct timespec now;
			clock_gettime(CLOCK_REALTIME, &now);
			const struct tm *const tm = localtime(&now.tv_sec);
			strftime(ft, sizeof(ft), "%Y-%m-%d-%H-%M-%S", tm);
			const double start_ts = start.tv_sec + (start.tv_nsec / 1000000000.0);
			const double end_ts = end.tv_sec + (end.tv_nsec / 1000000000.0);
			printf("%s %ld.%09ld %.3g\n", ft, now.tv_sec, now.tv_nsec, end_ts - start_ts);
			fflush(stdout);

			next_time.tv_sec += sleep_ts.tv_sec;
			next_time.tv_nsec += sleep_ts.tv_nsec;
			if (next_time.tv_nsec >= 1000000000) {
				next_time.tv_nsec -= 1000000000;
				++next_time.tv_sec;
			}
			clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &next_time, NULL);
		}
	}

Run it in any directory on the target filesystem, it will create a
temporary file, write data to it, fsync, repeat.  The first argument is
the number of seconds between write/fsync, e.g. to fsync every 1.5 seconds:

	fsync-log 1.5

The superblock generation monitoring tool is:

	#!/bin/sh
	devPath="$1"
	shift

	getTransid () {
		btrfs ins dump-super "$devPath" | sed -n 's/^generation *//p'
	}

	now () {
		date +%s.%N
	}

	lastTransTime="$(now)"
	lastTransid="$(getTransid)"

	while sleep 1; do
		nextTransid="$(getTransid)"
		nextTransTime="$(now)"
		if [ "$nextTransid" != "$lastTransid" ]; then
			echo "$(date +%Y-%m-%d-%H-%M-%S) $nextTransTime $(echo $nextTransTime - $lastTransTime | bc -l) $((nextTransid-lastTransid))"
			lastTransid="$nextTransid"
			lastTransTime="$nextTransTime"
		fi
	done

This one needs the name of a device in the btrfs filesystem as an argument,
and will call btrfs-progs to extract the generation field.  e.g.

	transid-log /dev/mapper/testfs

Both write a log like this (without the headers):

        timestamp           seconds-since-epoch  latency in seconds     number of txns
        2020-02-11-18-38-17 1581464297.795520161 53.726077219 1
        2020-02-11-18-39-11 1581464351.590758110 53.795237949 1
        2020-02-11-18-40-15 1581464415.425477144 63.834719034 1
        2020-02-11-18-45-43 1581464743.422229067 327.996751923 1
        2020-02-11-19-57-39 1581469059.007722649 4315.585493582 1
        2020-02-11-21-22-06 1581474126.871461743 5067.863739094 1

which can be fed to your favorite plotting program to make a horrifying
graph on which the area under the curve is the amount of data you'll
lose in a crash or power failure.

--yruHGtsrg8HLSUpe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXkN4rwAKCRCB+YsaVrMb
nMQpAJ9uqbQy3Olnc8STWTXv0Ph6d9mhFQCdGHXvdRTHY5fNbspE6rGTGUUuFmk=
=BsAr
-----END PGP SIGNATURE-----

--yruHGtsrg8HLSUpe--
