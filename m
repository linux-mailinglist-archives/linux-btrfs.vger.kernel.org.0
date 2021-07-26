Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C9A3D5779
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 12:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhGZJsW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 05:48:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231421AbhGZJsV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 05:48:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87F6660F55;
        Mon, 26 Jul 2021 10:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627295330;
        bh=btW6BrQtdiy2BGfAtYgtO3mdDJAwuJZx3t47oTAwnTk=;
        h=From:To:Cc:Subject:Date:From;
        b=f/7Tynxw0dc+aTsE3bUo1N6cHVNZhErAWWa7FkpVRfz5jkx+TEoMBc25Do+9O+aX/
         wBPcBMfz61Umrq0R7khVfl7B+xFDCjTdc3VJG9Z4hM4mhv2rC+vID5r8/G9Xc2/5ye
         Bjtbmo7sTac/vN/B9r5l9iQ3/PbqFcBbA/xXNw1k2PxMvzTH9SSfU4gmDencJeEkWs
         yU0FOy47iT4v7952Z3/pKzzPfhxlx9nVkudXUrnv/QurKIJwUB3a/AYo2k+Kf8TUtv
         8LbHOSkS4g7tpcjTYE5pDt2IEHawIzvFIN7yyqDjaHqEzHfAzMdz/4g3zCp7dyg4AT
         YNaRC9Jhau76A==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 00/21] btrfs: support idmapped mounts
Date:   Mon, 26 Jul 2021 12:27:55 +0200
Message-Id: <20210726102816.612434-1-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4284; h=from:subject; bh=qtZhh5mEZComnykB4yzWVyhJZ4CRIeDrJjmJF7pMG9w=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST86zPY8fvtb4fVjXVTdc+VlEUopVf9eCG8yvr9VhYn41ue mYIpHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNZWczwh2dZRu88Nfb/pde/m/7Ntp x43OvctZ+SSlMOMikePV4sZ8nIcCHoW2lTVF7blicH30gWbH+4vfjI5O1ZNl6H/Fp3HduwgB8A
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Hey everyone,

/* v3 */
- base: v5.14-rc3
- Added Josef's Reviewed-by's (Thank you!)
- Switched subvolume/snapshot deletion error code (David)
But please see individual patches for changelogs.

This series enables the creation of idmapped mounts on btrfs. On the list of
filesystems btrfs was pretty high-up and requested quite often from userspace
(cf. [1]). This series requires just a few changes to the vfs for specific
lookup helpers that btrfs relies on to perform permission checking when looking
up an inode. The changes are required to port some other filesystem as well.

The conversion of the necessary btrfs internals was fairly straightforward. No
invasive changes were needed. I've decided to split up the patchset into very
small individual patches. This hopefully makes the series more readable and
fairly easy to review. The overall changeset is quite small.

All non-filesystem wide ioctls that peform permission checking based on inodes
can be supported on idmapped mounts. There are really just a few restrictions.
This should really only affect the deletion of subvolumes by subvolume id which
can be used to delete any subvolume in the filesystem even though the caller
might not even be able to see the subvolume under their mount. Other than that
behavior on idmapped and non-idmapped mounts is identical for all enabled
ioctls. People interested in idmappings on idmapped mounts should read [2].

The changeset has an associated new testsuite specific to btrfs. The
core vfs operations that btrfs implements are covered by the generic
idmapped mount testsuite. For the ioctls a new testsuite was added. It
is sent alongside this patchset for ease of review but will very likely
be merged independent of it.

All patches are based on v5.14-rc3.

The series can be pulled from:
https://git.kernel.org/brauner/h/fs.idmapped.btrfs
https://github.com/brauner/linux/tree/fs.idmapped.btrfs

The xfstests can be pulled from:
https://git.kernel.org/brauner/xfstests-dev/h/fs.idmapped.btrfs
https://github.com/brauner/xfstests/tree/fs.idmapped.btrfs

Note, the new btrfs xfstests patch is on top of a branch of mine
containing a few more preliminary patches. So if you want to run the
tests, please simply pull the branch and build from there.

The series has been tested with xfstests including the newly added btrfs
specific test. All tests pass.
There were three unrelated failures that I observed: btrfs/219,
btrfs/2020 and btrfs/235. All three also fail on earlier kernels
without the patch series applied.

Thanks!
Christian

[1]: https://github.com/systemd/systemd/pull/19438#discussion_r622807165
[2]: https://lore.kernel.org/linux-fsdevel/20210723125150.334206-1-brauner@kernel.org

Christian Brauner (20):
  namei: add mapping aware lookup helper
  btrfs/inode: handle idmaps in btrfs_new_inode()
  btrfs/inode: allow idmapped rename iop
  btrfs/inode: allow idmapped getattr iop
  btrfs/inode: allow idmapped mknod iop
  btrfs/inode: allow idmapped create iop
  btrfs/inode: allow idmapped mkdir iop
  btrfs/inode: allow idmapped symlink iop
  btrfs/inode: allow idmapped tmpfile iop
  btrfs/inode: allow idmapped setattr iop
  btrfs/inode: allow idmapped permission iop
  btrfs/ioctl: check whether fs{g,u}id are mapped during subvolume
    creation
  btrfs/inode: allow idmapped BTRFS_IOC_{SNAP,SUBVOL}_CREATE{_V2} ioctl
  btrfs/ioctl: allow idmapped BTRFS_IOC_SNAP_DESTROY{_V2} ioctl
  btrfs/ioctl: relax restrictions for BTRFS_IOC_SNAP_DESTROY_V2 with
    subvolids
  btrfs/ioctl: allow idmapped BTRFS_IOC_SET_RECEIVED_SUBVOL{_32} ioctl
  btrfs/ioctl: allow idmapped BTRFS_IOC_SUBVOL_SETFLAGS ioctl
  btrfs/ioctl: allow idmapped BTRFS_IOC_INO_LOOKUP_USER ioctl
  btrfs/acl: handle idmapped mounts
  btrfs/super: allow idmapped btrfs

 fs/btrfs/acl.c        | 11 ++---
 fs/btrfs/ctree.h      |  3 +-
 fs/btrfs/inode.c      | 62 ++++++++++++++++------------
 fs/btrfs/ioctl.c      | 96 ++++++++++++++++++++++++++++---------------
 fs/btrfs/super.c      |  2 +-
 fs/namei.c            | 44 +++++++++++++++++---
 include/linux/namei.h |  2 +
 7 files changed, 148 insertions(+), 72 deletions(-)


base-commit: ff1176468d368232b684f75e82563369208bc371
-- 
2.30.2

