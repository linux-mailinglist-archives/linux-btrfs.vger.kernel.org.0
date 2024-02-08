Return-Path: <linux-btrfs+bounces-2260-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C67D784E9B8
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 21:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0590C1C25C64
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 20:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78C4482FB;
	Thu,  8 Feb 2024 20:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b="XHnv2FGo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.tiscali.it (santino.mail.tiscali.it [213.205.33.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487883F9F1
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Feb 2024 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.205.33.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707424253; cv=none; b=e26kdbS1+abZxBbeFGRQIqO/zw9EJ2So48pDeNOiR46XB+EdMH/pIsXAcETp1rfRDpDlUjmqPLqTTGFYimLJh6/9k18SOj+HK9iWUutqvjcrbA75b/jaV/XxFlwkRhb9gHxPkjDS3eS2hy1TVmJY50iWCYjyTauyB2vsS6mc4WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707424253; c=relaxed/simple;
	bh=NACO1wwfigAoo4Onw8bI35u6RyEta5lEwMmbM7fYpvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V+GUuRoABzk62d1qyMFzXZA2yDJlin+snRwdEuUFWFahuHjfH7SEZVB7fbeLEjHuBcX55tlN0ypIIGGFsXe/FtYORbY81HovxRqqXbO8hzamEFwny8rdCWQQPptU0q6VHuRIiEOic55RqDHGnEbbdb6Wvw0n5VL36btyANd+AeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tiscali.it; spf=pass smtp.mailfrom=tiscali.it; dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b=XHnv2FGo; arc=none smtp.client-ip=213.205.33.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tiscali.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tiscali.it
Received: from venice.bhome ([84.220.171.3])
	by santino.mail.tiscali.it with 
	id kkVe2B00g04l9eU01kVenq; Thu, 08 Feb 2024 20:29:38 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: 0
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From: Goffredo Baroncelli <kreijack@tiscali.it>
To: linux-btrfs@vger.kernel.org
Cc: Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 0/9][V2][btrfs-progs] Remove unused dirstream variable
Date: Thu,  8 Feb 2024 21:19:18 +0100
Message-ID: <cover.1707423567.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.43.0
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
	t=1707424178; bh=X++1sQmg16u9btua5oIetdYLRvLlOGxGU9iP0iG2tVY=;
	h=From:To:Cc:Subject:Date:Reply-To;
	b=XHnv2FGoIBeVmSFFjmuKYoYw3GKI7rWyx+CtoWoi9Cc+vUiNntL1jSEBI23WfQnt7
	 OM5rBUSG5RxfonldoevJpJYyF8hp/7/Oi7h9RUk8Ea9KNfDdiaPQOi/O5YcTWLELOX
	 iR53ODqxU8ZGHcNNibGbxh169pi3w3cTqgslxflg=

From: Goffredo Baroncelli <kreijack@inwind.it>

For historical reason, the helpers [btrfs_]open_[file_or_]dir() work with
directory returning the 'fd' and a 'dirstream' variable returned by
opendir(3).

If the path is a file, the 'fd' is computed from open(2) and dirstream is 
set to NULL. If the path is a directory, first the directory is opened by 
opendir(3), then the 'fd' is computed using dirfd(3).
However the 'dirstream' returned by opendir(3) is left open until 'fd'
is not needed anymore.

In near every case the 'dirstream' variable is not used. Only 'fd' is used.

A call to close_file_or_dir() freed both 'fd' and 'dirstream'.

Aim of this patch set is to getrid of this complexity; when the path of
a directory is passed, the fd is get directly using open(path, O_RDONLY):
so we don't need to use readdir(3) and to maintain the not used variable
'dirstream'.

So each call of a legacy [btrfs_]open_[file_or_]dir() helper is
replaced by a call to the new btrfs_open_[file_or_]dir_fd() functions.
These functions return only the file descriptor.

Also close_file_or_dir() is not needed anymore.

The first patch, introduces the new helpers; the last patch removed the
unused older helpers. The intermediate patches updated the code.

The 3rd patch updated also the add_seen_fsid() function. Before it
stored the dirstream variable. But now it is not needed anymore.
So we removed a parameter of the functions and a field in the structure.

In the 8th patch, the only occurrences where 'dirstream' is used was
corrected: the dirstream is computed using fdopendir(3), and the cleanup
is updated according.

The results is:
- removed 7 functions
- add 4 new functions
- removed ~100 lines
- removed 44 occurrences of an unused 'dirstream' variable.


Changelog:

09/dec/2023: V1: first issue
08/feb/2024: V2
	- rebased over 6.7
	- swapped the tests order inside the btrfs_open_fd2() function
	  to prevent the failure of the test 003-fi-resize-args
	- removed two new occurences of open_file_or_dir() inside
	  cmd_scrub_limit() (introduced after V1 pateches set)


BR
G.Baroncelli


Goffredo Baroncelli (9):
  Killing dirstream: add helpers
  Killing dirstream: replace btrfs_open_dir with btrfs_open_dir_fd
  Killing dirstream: replace btrfs_open_dir with btrfs_open_dir_fd
  Killing dirstream: replace open_path_or_dev_mnt with btrfs_open_mnt_fd
  Killing dirstream: replace open_file_or_dir3 with btrfs_open_fd2
  Killing dirstream: replace btrfs_open_file_or_dir with
    btrfs_open_file_or_dir_fd
  Killing dirstream: replace open_file_or_dir with btrfs_open_fd2
  Killing dirstream: remove open_file_or_dir3 from du_add_file
  Killing dirstream: remove unused functions

 cmds/balance.c          |  27 ++++-----
 cmds/device.c           |  26 ++++-----
 cmds/filesystem-du.c    |  18 +++++-
 cmds/filesystem-usage.c |   5 +-
 cmds/filesystem.c       |  26 ++++-----
 cmds/inspect.c          |  35 +++++-------
 cmds/property.c         |   5 +-
 cmds/qgroup.c           |  29 ++++------
 cmds/quota.c            |  16 +++---
 cmds/replace.c          |  17 +++---
 cmds/scrub.c            |  20 +++----
 cmds/subvolume-list.c   |   5 +-
 cmds/subvolume.c        |  44 ++++++---------
 common/device-scan.c    |   6 +-
 common/device-scan.h    |   4 +-
 common/open-utils.c     | 118 +++++++++++-----------------------------
 common/open-utils.h     |  13 ++---
 common/utils.c          |   5 +-
 18 files changed, 162 insertions(+), 257 deletions(-)

-- 
2.43.0


