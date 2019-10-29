Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1CBE7F68
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2019 06:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbfJ2FCu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Oct 2019 01:02:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:47596 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726708AbfJ2FCu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Oct 2019 01:02:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 60252B28E
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Oct 2019 05:02:48 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v5 0/2] btrfs: Introduce new rescue= mount options
Date:   Tue, 29 Oct 2019 13:02:35 +0800
Message-Id: <20191029050237.213038-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are quite a lot btrfs extent tree corruption report in the mail
list.
Since btrfs will do mount time block group item search, one corrupted
leaf containing block group item will prevent the whole fs to be
mounted.

This patchset will try to address the problem by introducing a new mount
option, "rescue=skipbg", as a last-resort rescue.
With "rescue=skipbg", the whole extent tree will be skipped if we hit
some problems at mount time.
This brings some side effect that for super large fs, the mount time can
be hugely reduced by this mount option.

Of course this option will have a lot of restrictions to prevent further
screwing up the fs, including:

- Permanent RO
  No remount rw is allowed

- No dirty log
  Either clean the log or use rescue=nologreplay mount option

This "rescue=skipbg" has some advantage compared to user space tool
like "btrfs-restore":
- Unified recovery tool
  User can use any tool they're familiar with, as long as the kernel
  doesn't panic.

- More info for subvolume.
  "btrfs subv list" can work now!


Also move the following mount options to "rescue=" group:
- nologreplay
  to rescue=nologreplay

- usebackuproot
  to rescue=usebackuproot

Old options are still available for compatibility purpose, but they are
deprecated in favor of new 'rescue=' super option.

Different rescue sub options can be separated by ':', like:
"rescue=nologreplay:skipbg:usebackuproot".
Or the traditional but longer way like:
"rescue=nologreplay,rescue=skipbg"

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

v4:
- Rebased to v5.3-rc7
  Minor conflicts due to some function name and structure change.
- Keep the old 'recovery' mount option
- Keep the old 'usebackuproot' and 'nologreplay' naming for 'rescue='
  mount options
  So just append 'rescue=' to existing mount option.

v5:
- Rebased to v5.4-rc1
  Minor conflicts caused by block-group.[ch] code movement.
- Fix a bug of wrong prompt and check for log tree
  It should prompt user and check nologreplay option, not notreelog.

Qu Wenruo (2):
  btrfs: Introduce "rescue=" mount option
  btrfs: Introduce new mount option to skip block group items scan

 fs/btrfs/block-group.c |  50 ++++++++++++++++++++
 fs/btrfs/ctree.h       |   1 +
 fs/btrfs/disk-io.c     |  29 ++++++++++--
 fs/btrfs/super.c       | 102 +++++++++++++++++++++++++++++++++++++----
 fs/btrfs/volumes.c     |   7 +++
 5 files changed, 177 insertions(+), 12 deletions(-)

-- 
2.23.0

