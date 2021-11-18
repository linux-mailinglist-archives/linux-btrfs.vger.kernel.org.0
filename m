Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54494564E6
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 22:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhKRVMG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 16:12:06 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:36586 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229774AbhKRVMG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 16:12:06 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 3AD2D880DC; Thu, 18 Nov 2021 16:09:05 -0500 (EST)
Date:   Thu, 18 Nov 2021 16:09:05 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: Ghost directory entries (previously "Unable to remove directory
 entry")
Message-ID: <20211118210905.GB17148@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is an old bug where btrfs leaves ghost entries in a btrfs directory
after a crash.  Recent instances have been observed on kernel 5.7, 5.10,
and 5.14.

The reproducer is something like:

	while (true) { // pseudocode for your favorite application
		int fd = create(tmp_name);
		write(fd, ...);
		fsync(fd);	// required, bug does not appear without this fsync
		close(fd);
		rename(tmp_name, regular_name);
	}

then while that's running, crash the system.  It's easier to reproduce
if the system is running a large unrelated write workload at the time,
something that generates a lot of delayed refs, e.g. many parallel
git checkouts.

On the following mount, the filesystem will have DIR_ITEMs that don't
have corresponding inodes or backrefs (or anything else, there are
only DIR_ITEMs).

If the fsync is removed from the application loop, this issue never
occurs.  This makes me think the issue is related to log tree, since
log tree is only used when fsync is called[citation needed] and the
bug is totally absent without fsync().

I have thousands of counterexamples of crashes (the bug has been present
since 2016) while running the above loop without one of fsync() or
rename(), and no ghost dentries occur.  Indeed, an effective workaround
for this bug is to always run applications under eatmydata, or remove
fsync() calls and recompile.

I recently caught this happening on a subvol with 31028760 total directory
entries.  After removing every dirent from the subvol that had an inode,
this is what is left over:

	btrfs-progs v5.14 
	file tree key (166258 ROOT_ITEM 7934444) 
	leaf 87631174418432 items 189 free space 3852 generation 7937485 owner 166258
	leaf 87631174418432 flags 0x1(WRITTEN) backref revision 1
	fs uuid 21806bec-39eb-4ef6-8258-fe1c9c9f0310
	chunk uuid f5ad05bf-8d8f-42bf-84c1-5935d963b0d3
		item 0 key (256 INODE_ITEM 0) itemoff 16123 itemsize 160
			generation 8 transid 7937485 size 20 nbytes 0
			block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
			sequence 3542067 flags 0x0(none)
			atime 1468817719.337826302 (2016-07-18 00:55:19)
			ctime 1637267141.710179785 (2021-11-18 15:25:41)
			mtime 1637267141.710179785 (2021-11-18 15:25:41)
			otime 1440041474.865575922 (2015-08-19 23:31:14)
		item 1 key (256 INODE_REF 256) itemoff 16111 itemsize 12
			index 0 namelen 2 name: ..
		item 2 key (256 DIR_ITEM 1799309257) itemoff 16076 itemsize 35
			location key (128860927 INODE_ITEM 0) type DIR
			transid 7937485 data_len 0 name_len 5
			name: repo2
		item 3 key (256 DIR_ITEM 2020586557) itemoff 16041 itemsize 35
			location key (128853607 INODE_ITEM 0) type DIR
			transid 7937484 data_len 0 name_len 5
			name: repo1
		item 4 key (256 DIR_INDEX 7) itemoff 16006 itemsize 35
			location key (128853607 INODE_ITEM 0) type DIR
			transid 7937484 data_len 0 name_len 5
			name: repo1
		item 5 key (256 DIR_INDEX 8) itemoff 15971 itemsize 35
			location key (128860927 INODE_ITEM 0) type DIR
			transid 7937485 data_len 0 name_len 5
			name: repo2
		item 6 key (128853607 INODE_ITEM 0) itemoff 15811 itemsize 160
			generation 3919396 transid 7937484 size 8 nbytes 0
			block group 0 mode 40755 links 1 uid 1000 gid 1000 rdev 0
			sequence 665 flags 0x0(none)
			atime 1562006299.87401964 (2019-07-01 14:38:19)
			ctime 1637267136.271154989 (2021-11-18 15:25:36)
			mtime 1637244363.335357854 (2021-11-18 09:06:03)
			otime 1562990419.485827259 (2019-07-13 00:00:19)
		item 7 key (128853607 INODE_REF 256) itemoff 15796 itemsize 15
			index 7 namelen 5 name: repo1
		item 8 key (128853607 DIR_ITEM 1694554592) itemoff 15762 itemsize 34
			location key (128853608 INODE_ITEM 0) type DIR
			transid 3919396 data_len 0 name_len 4
			name: .git
		item 9 key (128853607 DIR_INDEX 2) itemoff 15728 itemsize 34
			location key (128853608 INODE_ITEM 0) type DIR
			transid 3919396 data_len 0 name_len 4
			name: .git
		item 10 key (128853608 INODE_ITEM 0) itemoff 15568 itemsize 160
			generation 3919396 transid 7936933 size 0 nbytes 0
			block group 0 mode 40755 links 1 uid 1000 gid 1000 rdev 0
			sequence 188698 flags 0x0(none)
			atime 1562006299.287401961 (2019-07-01 14:38:19)
			ctime 1637247755.848804443 (2021-11-18 10:02:35)
			mtime 1637247755.848804443 (2021-11-18 10:02:35)
			otime 7953764182178924544.1936025699 (-1358315181-11-18 20:42:24)
		item 11 key (128853608 INODE_REF 128853607) itemoff 15554 itemsize 14
			index 2 namelen 4 name: .git
		item 12 key (128853608 DIR_INDEX 71216) itemoff 15516 itemsize 38
			location key (205369010 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 8
			name: MERGE_RR
		item 13 key (128853608 DIR_INDEX 71224) itemoff 15481 itemsize 35
			location key (205369050 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 14 key (128853608 DIR_INDEX 71226) itemoff 15447 itemsize 34
			location key (205369080 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 15 key (128853608 DIR_INDEX 71234) itemoff 15412 itemsize 35
			location key (205369091 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 16 key (128853608 DIR_INDEX 71241) itemoff 15378 itemsize 34
			location key (205369100 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 17 key (128853608 DIR_INDEX 71247) itemoff 15343 itemsize 35
			location key (205369109 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 18 key (128853608 DIR_INDEX 71249) itemoff 15304 itemsize 39
			location key (205369114 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 19 key (128853608 DIR_INDEX 71251) itemoff 15258 itemsize 46
			location key (205369115 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 20 key (128853608 DIR_INDEX 71254) itemoff 15224 itemsize 34
			location key (205369121 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 21 key (128853608 DIR_INDEX 71260) itemoff 15189 itemsize 35
			location key (205369129 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 22 key (128853608 DIR_INDEX 71262) itemoff 15150 itemsize 39
			location key (205369131 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 23 key (128853608 DIR_INDEX 71264) itemoff 15104 itemsize 46
			location key (205369132 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 24 key (128853608 DIR_INDEX 71267) itemoff 15070 itemsize 34
			location key (205369136 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 25 key (128853608 DIR_INDEX 71273) itemoff 15035 itemsize 35
			location key (205369144 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 26 key (128853608 DIR_INDEX 71275) itemoff 14996 itemsize 39
			location key (205369146 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 27 key (128853608 DIR_INDEX 71277) itemoff 14950 itemsize 46
			location key (205369147 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 28 key (128853608 DIR_INDEX 71280) itemoff 14916 itemsize 34
			location key (205369152 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 29 key (128853608 DIR_INDEX 71286) itemoff 14881 itemsize 35
			location key (205369160 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 30 key (128853608 DIR_INDEX 71288) itemoff 14842 itemsize 39
			location key (205369162 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 31 key (128853608 DIR_INDEX 71290) itemoff 14796 itemsize 46
			location key (205369163 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 32 key (128853608 DIR_INDEX 71293) itemoff 14762 itemsize 34
			location key (205369167 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 33 key (128853608 DIR_INDEX 71299) itemoff 14727 itemsize 35
			location key (205369175 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 34 key (128853608 DIR_INDEX 71301) itemoff 14688 itemsize 39
			location key (205369178 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 35 key (128853608 DIR_INDEX 71303) itemoff 14642 itemsize 46
			location key (205369179 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 36 key (128853608 DIR_INDEX 71306) itemoff 14608 itemsize 34
			location key (205369184 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 37 key (128853608 DIR_INDEX 71312) itemoff 14573 itemsize 35
			location key (205369192 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 38 key (128853608 DIR_INDEX 71314) itemoff 14534 itemsize 39
			location key (205369197 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 39 key (128853608 DIR_INDEX 71316) itemoff 14488 itemsize 46
			location key (205369198 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 40 key (128853608 DIR_INDEX 71319) itemoff 14454 itemsize 34
			location key (205369202 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 41 key (128853608 DIR_INDEX 71325) itemoff 14419 itemsize 35
			location key (205369210 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 42 key (128853608 DIR_INDEX 71327) itemoff 14380 itemsize 39
			location key (205369212 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 43 key (128853608 DIR_INDEX 71329) itemoff 14334 itemsize 46
			location key (205369213 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 44 key (128853608 DIR_INDEX 71332) itemoff 14300 itemsize 34
			location key (205369218 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 45 key (128853608 DIR_INDEX 71338) itemoff 14265 itemsize 35
			location key (205369226 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 46 key (128853608 DIR_INDEX 71340) itemoff 14226 itemsize 39
			location key (205369228 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 47 key (128853608 DIR_INDEX 71342) itemoff 14180 itemsize 46
			location key (205369229 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 48 key (128853608 DIR_INDEX 71345) itemoff 14146 itemsize 34
			location key (205369233 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 49 key (128853608 DIR_INDEX 71351) itemoff 14111 itemsize 35
			location key (205369241 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 50 key (128853608 DIR_INDEX 71353) itemoff 14072 itemsize 39
			location key (205369245 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 51 key (128853608 DIR_INDEX 71355) itemoff 14026 itemsize 46
			location key (205369246 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 52 key (128853608 DIR_INDEX 71358) itemoff 13992 itemsize 34
			location key (205369251 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 53 key (128853608 DIR_INDEX 71364) itemoff 13957 itemsize 35
			location key (205369259 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 54 key (128853608 DIR_INDEX 71366) itemoff 13918 itemsize 39
			location key (205369261 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 55 key (128853608 DIR_INDEX 71368) itemoff 13872 itemsize 46
			location key (205369262 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 56 key (128853608 DIR_INDEX 71371) itemoff 13838 itemsize 34
			location key (205369267 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 57 key (128853608 DIR_INDEX 71377) itemoff 13803 itemsize 35
			location key (205369275 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 58 key (128853608 DIR_INDEX 71379) itemoff 13764 itemsize 39
			location key (205369277 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 59 key (128853608 DIR_INDEX 71381) itemoff 13718 itemsize 46
			location key (205369278 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 60 key (128853608 DIR_INDEX 71384) itemoff 13684 itemsize 34
			location key (205369282 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 61 key (128853608 DIR_INDEX 71390) itemoff 13649 itemsize 35
			location key (205369290 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 62 key (128853608 DIR_INDEX 71392) itemoff 13610 itemsize 39
			location key (205369292 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 63 key (128853608 DIR_INDEX 71394) itemoff 13564 itemsize 46
			location key (205369293 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 64 key (128853608 DIR_INDEX 71397) itemoff 13530 itemsize 34
			location key (205369297 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 65 key (128853608 DIR_INDEX 71403) itemoff 13495 itemsize 35
			location key (205369305 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 66 key (128853608 DIR_INDEX 71405) itemoff 13456 itemsize 39
			location key (205369307 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 67 key (128853608 DIR_INDEX 71407) itemoff 13410 itemsize 46
			location key (205369308 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 68 key (128853608 DIR_INDEX 71410) itemoff 13376 itemsize 34
			location key (205369312 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 69 key (128853608 DIR_INDEX 71416) itemoff 13341 itemsize 35
			location key (205369320 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 70 key (128853608 DIR_INDEX 71418) itemoff 13302 itemsize 39
			location key (205369322 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 71 key (128853608 DIR_INDEX 71420) itemoff 13256 itemsize 46
			location key (205369323 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 72 key (128853608 DIR_INDEX 71423) itemoff 13222 itemsize 34
			location key (205369328 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 73 key (128853608 DIR_INDEX 71429) itemoff 13187 itemsize 35
			location key (205369336 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 74 key (128853608 DIR_INDEX 71431) itemoff 13148 itemsize 39
			location key (205369340 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 75 key (128853608 DIR_INDEX 71433) itemoff 13102 itemsize 46
			location key (205369341 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 76 key (128853608 DIR_INDEX 71436) itemoff 13068 itemsize 34
			location key (205369345 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 77 key (128853608 DIR_INDEX 71442) itemoff 13033 itemsize 35
			location key (205369353 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 78 key (128853608 DIR_INDEX 71444) itemoff 12994 itemsize 39
			location key (205369355 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 79 key (128853608 DIR_INDEX 71446) itemoff 12948 itemsize 46
			location key (205369356 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 80 key (128853608 DIR_INDEX 71449) itemoff 12914 itemsize 34
			location key (205369361 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 81 key (128853608 DIR_INDEX 71455) itemoff 12879 itemsize 35
			location key (205369369 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 82 key (128853608 DIR_INDEX 71457) itemoff 12840 itemsize 39
			location key (205369371 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 83 key (128853608 DIR_INDEX 71459) itemoff 12794 itemsize 46
			location key (205369372 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 84 key (128853608 DIR_INDEX 71462) itemoff 12760 itemsize 34
			location key (205369377 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 85 key (128853608 DIR_INDEX 71468) itemoff 12725 itemsize 35
			location key (205369385 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 86 key (128853608 DIR_INDEX 71470) itemoff 12686 itemsize 39
			location key (205369388 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 87 key (128853608 DIR_INDEX 71472) itemoff 12640 itemsize 46
			location key (205369389 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 88 key (128853608 DIR_INDEX 71475) itemoff 12606 itemsize 34
			location key (205369395 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 89 key (128853608 DIR_INDEX 71481) itemoff 12571 itemsize 35
			location key (205369403 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 90 key (128853608 DIR_INDEX 71483) itemoff 12532 itemsize 39
			location key (205369405 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 91 key (128853608 DIR_INDEX 71485) itemoff 12486 itemsize 46
			location key (205369406 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 92 key (128853608 DIR_INDEX 71488) itemoff 12452 itemsize 34
			location key (205369410 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 93 key (128853608 DIR_INDEX 71494) itemoff 12417 itemsize 35
			location key (205369418 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 94 key (128853608 DIR_INDEX 71498) itemoff 12382 itemsize 35
			location key (205369423 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 95 key (128853608 DIR_INDEX 71500) itemoff 12343 itemsize 39
			location key (205369427 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 96 key (128853608 DIR_INDEX 71502) itemoff 12297 itemsize 46
			location key (205369428 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 97 key (128853608 DIR_INDEX 71505) itemoff 12263 itemsize 34
			location key (205369432 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 98 key (128853608 DIR_INDEX 71511) itemoff 12228 itemsize 35
			location key (205369440 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 99 key (128853608 DIR_INDEX 71513) itemoff 12189 itemsize 39
			location key (205369445 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 100 key (128853608 DIR_INDEX 71515) itemoff 12143 itemsize 46
			location key (205369446 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 101 key (128853608 DIR_INDEX 71518) itemoff 12109 itemsize 34
			location key (205369450 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 102 key (128853608 DIR_INDEX 71524) itemoff 12074 itemsize 35
			location key (205369458 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 103 key (128853608 DIR_INDEX 71526) itemoff 12035 itemsize 39
			location key (205369460 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 104 key (128853608 DIR_INDEX 71528) itemoff 11989 itemsize 46
			location key (205369461 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 105 key (128853608 DIR_INDEX 71531) itemoff 11955 itemsize 34
			location key (205369465 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 106 key (128853608 DIR_INDEX 71537) itemoff 11920 itemsize 35
			location key (205369473 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 107 key (128853608 DIR_INDEX 71539) itemoff 11881 itemsize 39
			location key (205369477 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 108 key (128853608 DIR_INDEX 71541) itemoff 11835 itemsize 46
			location key (205369478 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 109 key (128853608 DIR_INDEX 71544) itemoff 11801 itemsize 34
			location key (205369482 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 110 key (128853608 DIR_INDEX 71550) itemoff 11766 itemsize 35
			location key (205369490 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 111 key (128853608 DIR_INDEX 71552) itemoff 11727 itemsize 39
			location key (205369493 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 112 key (128853608 DIR_INDEX 71554) itemoff 11681 itemsize 46
			location key (205369494 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 113 key (128853608 DIR_INDEX 71557) itemoff 11647 itemsize 34
			location key (205369499 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 114 key (128853608 DIR_INDEX 71563) itemoff 11612 itemsize 35
			location key (205369507 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 115 key (128853608 DIR_INDEX 71565) itemoff 11573 itemsize 39
			location key (205369512 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 116 key (128853608 DIR_INDEX 71567) itemoff 11527 itemsize 46
			location key (205369513 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 117 key (128853608 DIR_INDEX 71570) itemoff 11493 itemsize 34
			location key (205369518 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 118 key (128853608 DIR_INDEX 71576) itemoff 11458 itemsize 35
			location key (205369526 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 119 key (128853608 DIR_INDEX 71578) itemoff 11419 itemsize 39
			location key (205369529 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 120 key (128853608 DIR_INDEX 71580) itemoff 11373 itemsize 46
			location key (205369530 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 121 key (128853608 DIR_INDEX 71583) itemoff 11339 itemsize 34
			location key (205369535 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 122 key (128853608 DIR_INDEX 71589) itemoff 11304 itemsize 35
			location key (205369543 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 123 key (128853608 DIR_INDEX 71591) itemoff 11265 itemsize 39
			location key (205369546 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 124 key (128853608 DIR_INDEX 71593) itemoff 11219 itemsize 46
			location key (205369547 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 125 key (128853608 DIR_INDEX 71596) itemoff 11185 itemsize 34
			location key (205369552 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 126 key (128853608 DIR_INDEX 71602) itemoff 11150 itemsize 35
			location key (205369560 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 127 key (128853608 DIR_INDEX 71604) itemoff 11111 itemsize 39
			location key (205369563 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 128 key (128853608 DIR_INDEX 71606) itemoff 11065 itemsize 46
			location key (205369564 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 129 key (128853608 DIR_INDEX 71609) itemoff 11031 itemsize 34
			location key (205369569 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 130 key (128853608 DIR_INDEX 71615) itemoff 10996 itemsize 35
			location key (205369577 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 131 key (128853608 DIR_INDEX 71617) itemoff 10957 itemsize 39
			location key (205369580 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 132 key (128853608 DIR_INDEX 71619) itemoff 10911 itemsize 46
			location key (205369581 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 133 key (128853608 DIR_INDEX 71622) itemoff 10877 itemsize 34
			location key (205369586 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 134 key (128853608 DIR_INDEX 71628) itemoff 10842 itemsize 35
			location key (205369594 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 135 key (128853608 DIR_INDEX 71630) itemoff 10803 itemsize 39
			location key (205369597 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 136 key (128853608 DIR_INDEX 71632) itemoff 10757 itemsize 46
			location key (205369598 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 137 key (128853608 DIR_INDEX 71635) itemoff 10723 itemsize 34
			location key (205369602 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 138 key (128853608 DIR_INDEX 71641) itemoff 10688 itemsize 35
			location key (205369610 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 139 key (128853608 DIR_INDEX 71643) itemoff 10649 itemsize 39
			location key (205369612 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 140 key (128853608 DIR_INDEX 71645) itemoff 10603 itemsize 46
			location key (205369613 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 141 key (128853608 DIR_INDEX 71648) itemoff 10569 itemsize 34
			location key (205369618 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 142 key (128853608 DIR_INDEX 71654) itemoff 10534 itemsize 35
			location key (205369626 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 143 key (128853608 DIR_INDEX 71656) itemoff 10495 itemsize 39
			location key (205369629 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 144 key (128853608 DIR_INDEX 71658) itemoff 10449 itemsize 46
			location key (205369630 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 145 key (128853608 DIR_INDEX 71661) itemoff 10415 itemsize 34
			location key (205369635 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 146 key (128853608 DIR_INDEX 71667) itemoff 10380 itemsize 35
			location key (205369643 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 147 key (128853608 DIR_INDEX 71669) itemoff 10341 itemsize 39
			location key (205369646 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 148 key (128853608 DIR_INDEX 71671) itemoff 10295 itemsize 46
			location key (205369647 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 149 key (128853608 DIR_INDEX 71674) itemoff 10261 itemsize 34
			location key (205369651 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 150 key (128853608 DIR_INDEX 71680) itemoff 10226 itemsize 35
			location key (205369659 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 151 key (128853608 DIR_INDEX 71682) itemoff 10187 itemsize 39
			location key (205369663 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 152 key (128853608 DIR_INDEX 71684) itemoff 10141 itemsize 46
			location key (205369664 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 153 key (128853608 DIR_INDEX 71687) itemoff 10107 itemsize 34
			location key (205369668 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 154 key (128853608 DIR_INDEX 71693) itemoff 10072 itemsize 35
			location key (205369676 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 155 key (128853608 DIR_INDEX 71695) itemoff 10033 itemsize 39
			location key (205369679 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 156 key (128853608 DIR_INDEX 71697) itemoff 9987 itemsize 46
			location key (205369680 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 157 key (128853608 DIR_INDEX 71700) itemoff 9953 itemsize 34
			location key (205369684 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 158 key (128853608 DIR_INDEX 71706) itemoff 9918 itemsize 35
			location key (205369692 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 159 key (128853608 DIR_INDEX 71708) itemoff 9879 itemsize 39
			location key (205369695 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 160 key (128853608 DIR_INDEX 71710) itemoff 9833 itemsize 46
			location key (205369696 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 161 key (128853608 DIR_INDEX 71713) itemoff 9799 itemsize 34
			location key (205369700 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 162 key (128853608 DIR_INDEX 71719) itemoff 9764 itemsize 35
			location key (205369708 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 163 key (128853608 DIR_INDEX 71721) itemoff 9725 itemsize 39
			location key (205369711 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 164 key (128853608 DIR_INDEX 71723) itemoff 9679 itemsize 46
			location key (205369712 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 165 key (128853608 DIR_INDEX 71726) itemoff 9645 itemsize 34
			location key (205369716 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 166 key (128853608 DIR_INDEX 71732) itemoff 9610 itemsize 35
			location key (205369724 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 167 key (128853608 DIR_INDEX 71734) itemoff 9571 itemsize 39
			location key (205369726 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 168 key (128853608 DIR_INDEX 71736) itemoff 9525 itemsize 46
			location key (205369727 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 169 key (128853608 DIR_INDEX 71739) itemoff 9491 itemsize 34
			location key (205369732 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 170 key (128853608 DIR_INDEX 71745) itemoff 9456 itemsize 35
			location key (205369740 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 171 key (128853608 DIR_INDEX 71747) itemoff 9417 itemsize 39
			location key (205369747 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 172 key (128853608 DIR_INDEX 71749) itemoff 9371 itemsize 46
			location key (205369748 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 173 key (128853608 DIR_INDEX 71752) itemoff 9337 itemsize 34
			location key (205369752 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 174 key (128853608 DIR_INDEX 71758) itemoff 9302 itemsize 35
			location key (205369760 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 175 key (128853608 DIR_INDEX 71760) itemoff 9263 itemsize 39
			location key (205369762 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 176 key (128853608 DIR_INDEX 71762) itemoff 9217 itemsize 46
			location key (205369763 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 177 key (128853608 DIR_INDEX 71765) itemoff 9183 itemsize 34
			location key (205369767 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 178 key (128853608 DIR_INDEX 71771) itemoff 9148 itemsize 35
			location key (205369775 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
		item 179 key (128853608 DIR_INDEX 71773) itemoff 9109 itemsize 39
			location key (205369777 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 9
			name: MERGE_MSG
		item 180 key (128853608 DIR_INDEX 71775) itemoff 9063 itemsize 46
			location key (205369778 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 16
			name: CHERRY_PICK_HEAD
		item 181 key (128853608 DIR_INDEX 71778) itemoff 9029 itemsize 34
			location key (205369781 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 4
			name: HEAD
		item 182 key (128860927 INODE_ITEM 0) itemoff 8869 itemsize 160
			generation 3919396 transid 7937485 size 8 nbytes 0
			block group 0 mode 40775 links 1 uid 1000 gid 1000 rdev 0
			sequence 265 flags 0x0(none)
			atime 1562006335.537401474 (2019-07-01 14:38:55)
			ctime 1637267141.710179785 (2021-11-18 15:25:41)
			mtime 1637247755.848804443 (2021-11-18 10:02:35)
			otime 1562990425.396827463 (2019-07-13 00:00:25)
		item 183 key (128860927 INODE_REF 256) itemoff 8854 itemsize 15
			index 8 namelen 5 name: repo2
		item 184 key (128860927 DIR_ITEM 1694554592) itemoff 8820 itemsize 34
			location key (128860929 INODE_ITEM 0) type DIR
			transid 3919396 data_len 0 name_len 4
			name: .git
		item 185 key (128860927 DIR_INDEX 3) itemoff 8786 itemsize 34
			location key (128860929 INODE_ITEM 0) type DIR
			transid 3919396 data_len 0 name_len 4
			name: .git
		item 186 key (128860929 INODE_ITEM 0) itemoff 8626 itemsize 160
			generation 3919396 transid 7936933 size 0 nbytes 0
			block group 0 mode 40775 links 1 uid 1000 gid 1000 rdev 0
			sequence 120062 flags 0x0(none)
			atime 1562006335.966401468 (2019-07-01 14:38:55)
			ctime 1637247766.285851455 (2021-11-18 10:02:46)
			mtime 1637247766.285851455 (2021-11-18 10:02:46)
			otime 7953764182178924544.1936025699 (-1358315181-11-18 20:42:24)
		item 187 key (128860929 INODE_REF 128860927) itemoff 8612 itemsize 14
			index 3 namelen 4 name: .git
		item 188 key (128860929 DIR_INDEX 47625) itemoff 8577 itemsize 35
			location key (205369883 INODE_ITEM 0) type FILE
			transid 7934032 data_len 0 name_len 5
			name: index
	total bytes 45641256394752
	bytes used 22206031355904
	uuid 21806bec-39eb-4ef6-8258-fe1c9c9f0310

To 'find' it looks like this (note the duplicated directory entries):

	.
	./repo1
	./repo1/.git
	./repo1/.git/MERGE_RR
	./repo1/.git/index
	./repo1/.git/HEAD
	./repo1/.git/index
	./repo1/.git/HEAD
	./repo1/.git/index
	./repo1/.git/MERGE_MSG
	[...]
	./repo1/.git/MERGE_MSG
	./repo1/.git/CHERRY_PICK_HEAD
	./repo1/.git/HEAD
	./repo1/.git/index
	./repo1/.git/MERGE_MSG
	./repo1/.git/CHERRY_PICK_HEAD
	./repo1/.git/HEAD
	./repo1/.git/index
	./repo1/.git/MERGE_MSG
	./repo1/.git/CHERRY_PICK_HEAD
	./repo1/.git/HEAD
	./repo2
	./repo2/.git
	./repo2/.git/index

'find -ls' can't stat any of the directory entries because there are no
inodes behind them:

	      256      0 drwxr-xr-x   1 root     root           20 Nov 18 15:25 .
	128853607      0 drwxr-xr-x   1 zblaxell zblaxell        8 Nov 18 09:06 ./repo1
	128853608      0 drwxr-xr-x   1 zblaxell zblaxell        0 Nov 18 10:02 ./repo1/.git
	find: ‘./repo1/.git/MERGE_RR’: No such file or directory
	find: ‘./repo1/.git/index’: No such file or directory
	find: ‘./repo1/.git/HEAD’: No such file or directory
	find: ‘./repo1/.git/index’: No such file or directory
	find: ‘./repo1/.git/HEAD’: No such file or directory
	find: ‘./repo1/.git/index’: No such file or directory
	find: ‘./repo1/.git/MERGE_MSG’: No such file or directory
	[...]
	find: ‘./repo1/.git/CHERRY_PICK_HEAD’: No such file or directory
	find: ‘./repo1/.git/index’: No such file or directory
	find: ‘./repo1/.git/MERGE_MSG’: No such file or directory
	find: ‘./repo1/.git/CHERRY_PICK_HEAD’: No such file or directory
	find: ‘./repo1/.git/HEAD’: No such file or directory
	find: ‘./repo1/.git/index’: No such file or directory
	find: ‘./repo1/.git/MERGE_MSG’: No such file or directory
	find: ‘./repo1/.git/CHERRY_PICK_HEAD’: No such file or directory
	find: ‘./repo1/.git/HEAD’: No such file or directory
	128860927      0 drwxrwxr-x   1 zblaxell zblaxell        8 Nov 18 10:02 ./repo2
	128860929      0 drwxrwxr-x   1 zblaxell zblaxell        0 Nov 18 10:02 ./repo2/.git
	find: ‘./repo2/.git/index’: No such file or directory

Overall it's a mostly-harmless bug.  rmdir can remove a directory that
contains only DIR_INDEX items, so I can do something like this to clean
up the mess without having to resort to btrfs check --repair:

	cp -a --reflink dir dir.new
	mv dir dir.old
	mv dir.new dir
	rm -fr dir.old

Previously:

	https://lore.kernel.org/linux-btrfs/20191209001721.GF22121@hungrycats.org/
