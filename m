Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1913714A8D7
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2020 18:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgA0RTi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jan 2020 12:19:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:57736 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgA0RTi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jan 2020 12:19:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 41ED7AC54;
        Mon, 27 Jan 2020 17:19:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 42268DA730; Mon, 27 Jan 2020 18:19:18 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: [GIT PULL] fs: Deduplication ioctl fix
Date:   Mon, 27 Jan 2020 18:19:15 +0100
Message-Id: <cover.1580142827.git.dsterba@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

this is a fix for deduplication bug, the last block of two files is
allowed to deduplicated. This got broken in 5.1 by lifting some generic
checks to VFS layer. The affected filesystems are btrfs and xfs.

As the report came from btrfs users, the patches go through my git repo.
The xfs maintainer is aware of the fix, I don't have ack from VFS
maintainers but given the scope of the fix I believe it's not strictly
necessary.

The branch was in linux-next only for a short time as I was not sure how
exactly it's going to be merged, nevertheless enough testing was done
on both filesystems.  The patches are marked for stable as the bug
decreases deduplication effectivity.

If there's something wrong about the pull request, please let me know. I
did what I felt was best to get the fix merged, patches that touch files
in fs/ but are not pure VFS are bit fuzzy regarding the process.

There are no merge conflicts (btrfs, vfs). Please pull, thanks.

----------------------------------------------------------------
The following changes since commit def9d2780727cec3313ed3522d0123158d87224d:

  Linux 5.5-rc7 (2020-01-19 16:02:49 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git fs-dedupe-last-block-tag

for you to fetch changes up to 831d2fa25ab8e27592b1b0268dae6f2dfaf7cc43:

  Btrfs: make deduplication with range including the last block work (2020-01-23 18:24:07 +0100)

----------------------------------------------------------------
Filipe Manana (2):
      fs: allow deduplication of eof block into the end of the destination file
      Btrfs: make deduplication with range including the last block work

 fs/btrfs/ioctl.c |  3 ++-
 fs/read_write.c  | 10 ++++------
 2 files changed, 6 insertions(+), 7 deletions(-)
