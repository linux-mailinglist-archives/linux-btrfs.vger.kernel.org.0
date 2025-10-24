Return-Path: <linux-btrfs+bounces-18270-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F331C058D4
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 12:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 573E51A6447C
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 10:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E4530F934;
	Fri, 24 Oct 2025 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="Rmx4hp4h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B302F7AD3;
	Fri, 24 Oct 2025 10:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301350; cv=none; b=tFbykH5kQg7Xa+5ryRkeB0O1lxr4A8UbOzSohaQp9ieZ9zIbq9p2gP0h/xFlkN/Varddjzuona+wJo5hILQxWThvcJyDeRj9DVfeZ41JZOUwxaAAiaph5gtr0xMLkAPpwrfF/VG8eIC4GrszbXIvIrLcdK2H0jJJmg7Rhs9jzGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301350; c=relaxed/simple;
	bh=uSxG2kfkxS4D7RDb3G7PmLsPJpQXiXrxbyPXkRVrFCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qQ/9w+YNCOmuw4J+nFudrrHfXlztJH/kz1oLYyD6MvRCokoyd4zsmPSa2brR6js9HIfihEOK8S+Oj9efiUZTzMg5BEx8767777XgFJCNVjMMwp0/nxzjScS6Ge9x6fGIBjWuMjRPwsuwHkKW7RPm/5pQnBdVyex5ra7mNWkAksM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=Rmx4hp4h; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ctJqX5jbPz9t7d;
	Fri, 24 Oct 2025 12:22:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1761301336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DeC8ANxhccAXMO0XQ5liN3gGmOYUkYBvM58sH8TZw6U=;
	b=Rmx4hp4haL3smVoAGReu+PvLmwBOL7F2/2lIwKa2S137a6zroCsPNnq4nSaF6lpoQmIfQT
	fP1cbZ0RTNBk0qK/zLf4P2lGEgeToQrZLDfN4rcZlaXRPlWYVJbBufZJK6zoUgyp3LdlqO
	ZPjAsf/4chFAYC2iw3J7D5H+la4xbBila4NuGSYTD8r6tTaRihrTJa/npo/sJQRrx3gEXt
	BOJGADbqQ5phcE7sfijLmaLoKSwKf+HfXjUO5lowm1eKfAHzOoMGER5zUGLyhtWf0uwJh5
	8LnrUv8vc15E5QK73aqX47H28Wy0ArbIFmM/POcdHX13Z+lYqM8gTCE8gRBTow==
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	johannes.thumshirn@wdc.com,
	fdmanana@suse.com,
	boris@bur.io,
	wqu@suse.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
Subject: [PATCH v2 0/4] btrfs: define and apply the AUTO_K(V)FREE_PTR macros
Date: Fri, 24 Oct 2025 12:21:39 +0200
Message-ID: <20251024102143.236665-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes since v1:
  - Remove the _PTR suffix
  - Rename the ipath cleanup function to inode_fs_paths, so it's more
    explicit on the type.
  - Improve git message in patch 1.

This patchset introduces and applies throughout the btrfs tree two new
macros: AUTO_KFREE and AUTO_KVFREE. Each macro defines a pointer,
initializes it to NULL, and sets the kfree/kvfree cleanup attribute. It was
suggested by David Sterba in the review of a patch that I submitted here
[1].

I have not applied these macros blindly through the tree, but only when
using a cleanup attribute actually made things easier for
maintainers/developers, and didn't obfuscate things like lifetimes of
objects on a given function. So, I've mostly avoided applying this when:

- The object was being re-allocated in the middle of the function
  (e.g. object re-allocation in a loop).
- The ownership of the object was transferred between functions.
- The value of a given object might depend on functions returning ERR_PTR()
  et al.
- The cleanup section of a function was a bunch of labels with different
  exit paths with non-trivial cleanup code (or code that depended on things
  to go on a specific order).

To come up with this patchset I have glanced through the tree in order to
find where and how kfree()/kvfree() were being used, and while doing so I
have submitted [2], [3] and [4] separately as they were fixing memory
related issues. All in all, this patchset can be divided in three parts:

1. Patch 1: transforms free_ipath() to be defined via DEFINE_FREE(), which
   will be useful in order to further simplify some code in patch 3.
2. Patch 2 and 3: define and use the two macros.
3. Patch 4: removing some unneeded kfree() calls from qgroup.c as they were
   not needed. Since these occurrences weren't memory bugs, and it was a
   somewhat simple patch, I've refrained from sending this separately as I
   did in [2], [3] and [4]; but I'll gladly do it if you think it's better
   for the review.

Note that after these changes some 'return' statements could be made more
explicit, and I've also written an explicit 'return 0' whenever it would
make more explicit the "happy" path for a given branch, or whenever a 'ret'
variable could be avoided that way.

Last, checkpatch.pl script doesn't seem to like patches 2 and 3; but so far
it looks like false positives to me. But of course I might just be wrong :)

[1] https://lore.kernel.org/all/20250922103442.GM5333@twin.jikos.cz/
[2] https://lore.kernel.org/all/20250925184139.403156-1-mssola@mssola.com/
[3] https://lore.kernel.org/all/20250930130452.297576-1-mssola@mssola.com/
[4] https://lore.kernel.org/all/20251008121859.440161-1-mssola@mssola.com/

Miquel Sabaté Solà (4):
  btrfs: declare free_ipath() via DEFINE_FREE()
  btrfs: define the AUTO_K(V)FREE helper macros
  btrfs: apply the AUTO_K(V)FREE macros throughout the tree
  btrfs: add ASSERTs on prealloc in qgroup functions

 fs/btrfs/acl.c                    | 29 ++++++++----------
 fs/btrfs/backref.c                | 10 +------
 fs/btrfs/backref.h                |  7 ++++-
 fs/btrfs/delayed-inode.c          | 17 +++++------
 fs/btrfs/extent-tree.c            | 17 +++++------
 fs/btrfs/inode.c                  |  4 +--
 fs/btrfs/ioctl.c                  | 34 ++++++++-------------
 fs/btrfs/misc.h                   |  7 +++++
 fs/btrfs/qgroup.c                 | 30 +++++++++++++++----
 fs/btrfs/raid-stripe-tree.c       | 14 +++------
 fs/btrfs/reflink.c                |  7 ++---
 fs/btrfs/relocation.c             | 34 ++++++++-------------
 fs/btrfs/scrub.c                  |  4 +--
 fs/btrfs/send.c                   | 50 ++++++++++++-------------------
 fs/btrfs/super.c                  |  3 +-
 fs/btrfs/tests/extent-io-tests.c  |  3 +-
 fs/btrfs/tests/extent-map-tests.c |  6 ++--
 fs/btrfs/tree-log.c               | 46 +++++++++++-----------------
 fs/btrfs/volumes.c                | 28 +++++------------
 fs/btrfs/zoned.c                  |  3 +-
 20 files changed, 145 insertions(+), 208 deletions(-)

--
2.51.1

