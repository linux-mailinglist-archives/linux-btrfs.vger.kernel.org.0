Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5643CD37F
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jul 2021 13:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbhGSKaV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 06:30:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235905AbhGSKaU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 06:30:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49855610F7;
        Mon, 19 Jul 2021 11:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626693060;
        bh=BjGDtsO7KiNihfQvS7BcCqYXnN5QG9pRQMVoUKKXpSg=;
        h=From:To:Cc:Subject:Date:From;
        b=Hojxe1Fo9AwJL2TIO6DCL0PFoWfAYX501Ga63ogcn/IdtFnHeloUb8rfKbYCCVqb3
         Rv39Ccq64Ofsa//SM7VAK+Jj65NCwLOCybEGCSeT19pNdpRUJD6+UjNBCoLcoBj2oZ
         i3KNtuGLHB0NhJbC0eAD/0cb8q2YqyU8TC1bAo9eRXq2kL/OJ/1Rsqzz/o2AONgc7W
         5s7/k6GXKXvNJxgC1FBztm0WTXLYUO+9AJpBLIc0HIPRtbxpnF4c3ZCzzjCQ8uBsda
         gbyqBKL1e//2+DMpkvXMKimYYb/yF0C5gxsGTS4qbY8nrXVeTlE/oO+V+BRR8LWf5q
         bXyxrIAB8Om8A==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 00/21] btrfs: support idmapped mounts 
Date:   Mon, 19 Jul 2021 13:10:31 +0200
Message-Id: <20210719111052.1626299-1-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3944; h=from:subject; bh=xyn1KELSrmqAeE7Bs33B1zSfNqXLmrEviok8bhZi/B8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSR8jd08LULOS2qR4ladyGnHuAUi1jDafFwqkxqkEBHLyje7 UdWko5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCI9nxkZNpZMkzq65dq9e51zDzzrst 7bZjVNOEj1wUUzZWmOvvQJ/owM7zTkVXQCTDIX7Gy7xtb+0NhKgItnWeCpQwLb9D28O7k4AQ==
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Hey everyone,

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
ioctls.

The changeset has an associated new testsuite specific to btrfs. The
core vfs operations that btrfs implements are covered by the generic
idmapped mount testsuite. For the ioctls a new testsuite was added. It
is sent alongside this patchset for ease of review but will very likely
be merged independent of it.

All patches are based on v5.14-rc2.

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


base-commit: 2734d6c1b1a089fb593ef6a23d4b70903526fe0c
-- 
2.30.2

