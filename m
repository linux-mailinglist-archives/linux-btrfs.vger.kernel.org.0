Return-Path: <linux-btrfs+bounces-781-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B0380B614
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Dec 2023 20:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4511F2115E
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Dec 2023 19:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17681CF83;
	Sat,  9 Dec 2023 19:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b="eJA2d2xG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.tiscali.it (michael.mail.tiscali.it [213.205.33.246])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00C8C137
	for <linux-btrfs@vger.kernel.org>; Sat,  9 Dec 2023 11:27:25 -0800 (PST)
Received: from venice.bhome ([84.220.171.3])
	by michael.mail.tiscali.it with 
	id LKTN2B00x04l9eU01KTNYM; Sat, 09 Dec 2023 19:27:22 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: 0
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From: Goffredo Baroncelli <kreijack@tiscali.it>
To: linux-btrfs@vger.kernel.org
Cc: Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 0/9][btrfs-progs] Remove unused dirstream variable
Date: Sat,  9 Dec 2023 19:53:20 +0100
Message-ID: <cover.1702148009.git.kreijack@inwind.it>
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
	t=1702150042; bh=BcM0igVkFhVrY9loV5TGfCI8BiWsvEF9YCS25PjeuQA=;
	h=From:To:Cc:Subject:Date:Reply-To;
	b=eJA2d2xGAoJ+9UYruEjwpsbo+5wYde+iEM0Ds6Hxhi7vNMjovXowOKuBD3diDTB+4
	 IqsPT06LKrWWneDFUiEffotANe0OCE/5EsJy7UHk+6ruBujBYyIX82U4TJ/ZJzWz/l
	 OBJTNT+/JFg+vzcerrh/ViE5rxbcaNgfz5QbPClc=

From: Goffredo Baroncelli <kreijack@inwind.it>

For historical reason, the helpers [btrfs_]open_[file_or_]dir() work with
directory returning the 'fd' and a 'dirstream' variable returned by
opendir(3).

If the path is a file, the 'fd' is computed from open(2) and
dirstream is set to NULL.
If the path is a directory, first the directory is opened by opendir(3), then
the 'fd' is computed using dirfd(3).
However the 'dirstream' returned by opendir(3) is left open until 'fd'
is not needed anymore.

In near every case the 'dirstream' variable is not used. Only 'fd' is
used.

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
- removed 100 lines
- removed 43 occurrences of an unused 'dirstream' variable.

BR
G.Baroncelli

*** BLURB HERE ***

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
 cmds/device.c           |  26 ++++----
 cmds/filesystem-du.c    |  18 +++++-
 cmds/filesystem-usage.c |   5 +-
 cmds/filesystem.c       |  26 ++++----
 cmds/inspect.c          |  35 +++++------
 cmds/property.c         |   5 +-
 cmds/qgroup.c           |  29 ++++-----
 cmds/quota.c            |  16 +++--
 cmds/replace.c          |  17 +++---
 cmds/scrub.c            |  15 ++---
 cmds/subvolume-list.c   |   5 +-
 cmds/subvolume.c        |  44 ++++++--------
 common/device-scan.c    |   6 +-
 common/device-scan.h    |   4 +-
 common/open-utils.c     | 127 ++++++++++++----------------------------
 common/open-utils.h     |  13 ++--
 common/utils.c          |   5 +-
 18 files changed, 164 insertions(+), 259 deletions(-)

-- 
2.43.0


