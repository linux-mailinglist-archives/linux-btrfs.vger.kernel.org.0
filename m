Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB8C041C4E
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2019 08:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbfFLGhE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jun 2019 02:37:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:55582 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730957AbfFLGhD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jun 2019 02:37:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CF741AC40
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jun 2019 06:37:02 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/3] btrfs: Introduce new rescue= mount options
Date:   Wed, 12 Jun 2019 14:36:54 +0800
Message-Id: <20190612063657.21063-1-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset can be fetched from github:
https://github.com/adam900710/linux/tree/rescue_options

The basis HEAD is v5.2-rc2 tag.

There are quite a lot btrfs extent tree corruption report in the mail
list.
Since btrfs will do mount time block group item search, one corrupted
leaf containing block group item will prevent the whole fs to be
mounted.

This patchset will try to address the problem by introducing a new mount
option, "rescue=skip_bg", as a last-resort rescue.
Of course this option will have a lot of restriction to prevent further
screwing up the fs, including:
- Permanent RO
  No remount rw is allowed

- No dirty log
  Either clean the log or use rescue=no_log_replay mount option

This "rescue=skip_bg" has some advantage compared to user space tool
like "btrfs-restore":
- Unified recovery tool
  User can use any tool they're familiar with, as long as the kernel
  doesn't panic.

- More info for subvolume.
  "btrfs subv list" can work now!


Also move the following mount options to "rescue=" group:
- nologreplay
  to rescue=no_log_replay

- usebackuproot
  to rescue=use_backup_root

Old options are still available for compatibility purpose, but they are
deprecated in favor of new 'rescue=' super option.

Different rescue sub options can be separated by ':', like:
"rescue=no_log_replay:skip_bg:use_backup_root".
Or the traditional but longer way like:
"rescue=no_log_replay,rescue=skip_bg"

The separation character is chosen by:
- No conflicts with existing character
  Especially no conflict with ','.

- No extra escaping/quota
  Original plan is ';', but since it'll be interpreted by bash, it's
  changed to current ':'.

Changelog:
v2:
- Introduce 'rescue=' super option.
- Rename original 'usebackuproot' and 'nologreplay'.
  It at least makes my vim spell check happier.
- Remove 'recovery' mount option.
  As its successor is now deprecated, not need to keep the predecessor.

v2.1:
- Rebase to v5.1-rc4.
- Fix the typos in the cover letter.

v3:
- Rebased to v5.2-rc2.
- Update commit message to include an example for "rescue=" options.
- Remove unnecessary exclusion of super blocks spaces and block group
  ro.
  This seems to cause incorrect df output.

Qu Wenruo (3):
  btrfs: Remove "recovery" mount option
  btrfs: Introduce "rescue=" mount option
  btrfs: Introduce new mount option to skip block group items scan

 fs/btrfs/ctree.h       |  1 +
 fs/btrfs/disk-io.c     | 29 +++++++++++--
 fs/btrfs/extent-tree.c | 50 ++++++++++++++++++++++
 fs/btrfs/super.c       | 96 ++++++++++++++++++++++++++++++++++++------
 fs/btrfs/volumes.c     |  7 +++
 5 files changed, 167 insertions(+), 16 deletions(-)

-- 
2.22.0

