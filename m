Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045FC205577
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jun 2020 17:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732906AbgFWPFg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jun 2020 11:05:36 -0400
Received: from lists.nic.cz ([217.31.204.67]:34888 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732845AbgFWPFg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jun 2020 11:05:36 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTPSA id 6C38A14060D;
        Tue, 23 Jun 2020 17:05:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1592924731; bh=fqn2/3PPtSs7qpwCrDROvxgG2n0NCcDhr5n9WitAx0A=;
        h=Date:From:To;
        b=bxdM/czPaik5GUcMB2y8Rvp7gCMnRB+hmmi3ey3DE4MDnXDTH/hcmvgyrkcfr+tqy
         LpCJGMF2E5D8lzok/trNgw7PTfRv3qBQneunmVw+X/g6AXgND0+uRsKLunlsVPnDkr
         OL20qkf6NQvsoErsI10Z1PFSHn3XNhsosz2Jy1U8=
Date:   Tue, 23 Jun 2020 17:05:29 +0200
From:   Marek =?ISO-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, u-boot@lists.denx.de
Subject: Re: [PATCH U-BOOT v2 00/30] fs: btrfs: Re-implement btrfs support
 using the more widely used extent buffer base code
Message-ID: <20200623170529.4bdc8388@dellmb.labs.office.nic.cz>
In-Reply-To: <b53fe949-204a-1141-2da0-0f72e60a19dc@suse.com>
References: <20200525063257.46757-1-wqu@suse.com>
        <b53fe949-204a-1141-2da0-0f72e60a19dc@suse.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,URIBL_BLOCKED,
        USER_IN_WHITELIST shortcircuit=ham autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

when applying whole series, there are several warning spewed by git:
trailing whitespaces, new lines at EOF, spaces before tab in indent.
It is possible that this is because the code is copypasted from
btrfs-progs and this issues come from there.

Also patches 26 and 27 have almost same subject line, and one contains
a typo (reolve instead of resolve).

Sometimes in commit messages you use the work "cross-port", sometimes
it is "crossport", sometimes "cross port".

I am going to do a bigger test on this series this week, and if the
new code works correctly on all tests, I shall resend your patches with
some changes to the commit messages, but I will keep you as author of
the commits, and I shall add my Reviewed-by.

Marek


On Tue, 23 Jun 2020 08:50:57 +0800
Qu Wenruo <wqu@suse.com> wrote:

> Gentle ping?
>=20
> Any updates?
> Hopes this won't block the incoming new features too long.
>=20
> Thanks,
> Qu
>=20
> On 2020/5/25 =E4=B8=8B=E5=8D=882:32, Qu Wenruo wrote:
> > The branch can be fetched from github:
> > https://github.com/adam900710/u-boot/tree/btrfs_rebuild
> >=20
> > The current btrfs code in U-boot is using a creative way to read
> > on-disk data.
> > It's pretty simple, involving the least amount of code, but pretty
> > different from btrfs-progs nor kernel, making it pretty hard to sync
> > code between different projects.
> >=20
> > This big patchset will rework the btrfs support, to use code mostly
> > from btrfs-progs, thus all existing btrfs developers will feel at
> > home.
> >=20
> > During the rework, the following new features are added:
> > - More hash algorithm support
> >   SHA256 and XXHASH support are added.
> >   BLAKE2 needs more backport, will happen in a separate patchset.
> >=20
> > - The ability to read degraded RAID1
> >   Although we still only support one device btrfs, the new code base
> >   can choose from different copies already.
> >   As long as new device scan interface is provided, multi-device
> > support is pretty simple.
> >=20
> > - More correct handling of compressed extents with offset
> >   For compressed extent with offset, we should read the whole
> > compressed extent, decompress them, then copy the referred part.
> >=20
> > There are some more features incoming, with the new code base it
> > would be much easier to implement:
> > - Data checksum support
> >   The check would happen in read_extent_data(), btrfs-progs has the
> >   needed facility to locate data csum.
> >=20
> > - BLAKE2 support
> >   Need BLAKE2 library cross ported.
> >   For btrfs it's just several lines of modification.
> >=20
> > - Multi-device support along wit degraded RAID support
> >   We only need an interface to scan one device without opening it.
> >   The infrastructure is already provided in this patchset.
> >=20
> > These new features would be submitted after the patchset get merged,
> > since the patchset is already large, I don't want to make it more
> > scary.
> >=20
> > Although this patchset look horribly large, most of them are code
> > copy from btrfs-progs.
> > E.g extent-cache.[ch], rbtree-utils.[ch], btrfs_btree.h.
> > And ctree.h has over 1000 lines copied just for various accessors.
> >=20
> > While for disk-io.[ch] and volumes-io.[ch], they have some small
> > modifications to adapt the interface of U-boot.
> > E.g. btrfs_device::fd is replace with blkdev_desc and
> > disk_partition_t.
> >=20
> > The new code for U-boot are related to the following functions:
> > - btrfs_readlink()
> > - btrfs_lookup_path()
> > - btrfs_read_extent_inline()
> > - btrfs_read_extent_reg()
> > - lookup_data_extent()
> > - btrfs_file_read()
> > - btrfs_list_subvols()
> >=20
> > Thus only the following 5 patches need extra review attention:
> > - Patch 0017
> > - Patch 0019
> > - Patch 0023
> > - Patch 0024
> > - Patch 0025~0028
> >=20
> > Changelog:
> > v2:
> > - Implement btrfs_list_subvols()
> >   In v1 it's completely removed thus would cause problem if
> > btrfsolume command is compiled in.
> >=20
> > - Rebased to latest master
> >   Only minor conflicts due to header changes.
> >=20
> > - Allow next_legnth() to return value > BTRFS_NAME_LEN
> >=20
> > Qu Wenruo (30):
> >   fs: btrfs: Sync btrfs_btree.h from kernel
> >   fs: btrfs: Add More checksum algorithm support to btrfs
> >   fs: btrfs: Cross-port btrfs_read_dev_super() from btrfs-progs
> >   fs: btrfs: Cross-port rbtree-utils from btrfs-progs
> >   fs: btrfs: Cross-port extent-cache.[ch] from btrfs-progs
> >   fs: btrfs: Cross-port extent-io.[ch] from btrfs-progs
> >   fs: btrfs: Cross port structure accessor into ctree.h
> >   fs: btrfs: Cross port volumes.[ch] from btrfs-progs
> >   fs: btrfs: Crossport read_tree_block() from btrfs-progs
> >   fs: btrfs: Rename struct btrfs_path to struct __btrfs_path
> >   fs: btrfs: Rename btrfs_root to __btrfs_root
> >   fs: btrfs: Cross port struct btrfs_root to ctree.h
> >   fs: btrfs: Crossport btrfs_search_slot() from btrfs-progs
> >   fs: btrfs: Crossport btrfs_read_sys_array() and
> >     btrfs_read_chunk_tree()
> >   fs: btrfs: Crossport open_ctree_fs_info()
> >   fs: btrfs: Rename path resolve related functions to avoid name
> >     conflicts
> >   fs: btrfs: Use btrfs_readlink() to implement __btrfs_readlink()
> >   fs: btrfs: inode: Allow next_length() to return value >
> > BTRFS_NAME_LEN fs: btrfs: Implement btrfs_lookup_path()
> >   fs: btrfs: Use btrfs_iter_dir() to replace btrfs_readdir()
> >   fs: btrfs: Use btrfs_lookup_path() to implement btrfs_exists() and
> >     btrfs_size()
> >   fs: btrfs: Rename btrfs_file_read() and its callees to avoid name
> >     conflicts
> >   fs: btrfs: Introduce btrfs_read_extent_inline() and
> >     btrfs_read_extent_reg()
> >   fs: btrfs: Introduce lookup_data_extent() for later use
> >   fs: btrfs: Implement btrfs_file_read()
> >   fs: btrfs: Introduce function to reolve path in one subvolume
> >   fs: btrfs: Introduce function to resolve the path of one subvolume
> >   fs: btrfs: Imeplement btrfs_list_subvols() using new
> > infrastructure fs: btrfs: Cleanup the old implementation
> >   MAINTAINERS: Add btrfs mail list
> >=20
> >  MAINTAINERS                         |    1 +
> >  fs/btrfs/Makefile                   |    5 +-
> >  fs/btrfs/btrfs.c                    |  319 +++---
> >  fs/btrfs/btrfs.h                    |   67 +-
> >  fs/btrfs/btrfs_tree.h               |  766 --------------
> >  fs/btrfs/chunk-map.c                |  178 ----
> >  fs/btrfs/common/rbtree-utils.c      |   83 ++
> >  fs/btrfs/common/rbtree-utils.h      |   53 +
> >  fs/btrfs/compat.h                   |   88 ++
> >  fs/btrfs/compression.c              |    2 +-
> >  fs/btrfs/crypto/hash.c              |   55 +
> >  fs/btrfs/crypto/hash.h              |   17 +
> >  fs/btrfs/ctree.c                    |  866 ++++++++++++----
> >  fs/btrfs/ctree.h                    | 1453
> > ++++++++++++++++++++++----- fs/btrfs/dir-item.c                 |
> > 192 ++-- fs/btrfs/disk-io.c                  | 1063
> > ++++++++++++++++++++ fs/btrfs/disk-io.h                  |   50 +
> >  fs/btrfs/extent-cache.c             |  318 ++++++
> >  fs/btrfs/extent-cache.h             |  104 ++
> >  fs/btrfs/extent-io.c                |  848 ++++++++++++++--
> >  fs/btrfs/extent-io.h                |  164 +++
> >  fs/btrfs/hash.c                     |   38 -
> >  fs/btrfs/inode.c                    |  892 +++++++++++-----
> >  fs/btrfs/kernel-shared/btrfs_tree.h | 1333 ++++++++++++++++++++++++
> >  fs/btrfs/root-tree.c                |   47 +
> >  fs/btrfs/root.c                     |   92 --
> >  fs/btrfs/subvolume.c                |  310 ++++--
> >  fs/btrfs/super.c                    |  257 -----
> >  fs/btrfs/volumes.c                  | 1173 +++++++++++++++++++++
> >  fs/btrfs/volumes.h                  |  204 ++++
> >  30 files changed, 8537 insertions(+), 2501 deletions(-)
> >  delete mode 100644 fs/btrfs/btrfs_tree.h
> >  delete mode 100644 fs/btrfs/chunk-map.c
> >  create mode 100644 fs/btrfs/common/rbtree-utils.c
> >  create mode 100644 fs/btrfs/common/rbtree-utils.h
> >  create mode 100644 fs/btrfs/compat.h
> >  create mode 100644 fs/btrfs/crypto/hash.c
> >  create mode 100644 fs/btrfs/crypto/hash.h
> >  create mode 100644 fs/btrfs/disk-io.c
> >  create mode 100644 fs/btrfs/disk-io.h
> >  create mode 100644 fs/btrfs/extent-cache.c
> >  create mode 100644 fs/btrfs/extent-cache.h
> >  create mode 100644 fs/btrfs/extent-io.h
> >  delete mode 100644 fs/btrfs/hash.c
> >  create mode 100644 fs/btrfs/kernel-shared/btrfs_tree.h
> >  create mode 100644 fs/btrfs/root-tree.c
> >  delete mode 100644 fs/btrfs/root.c
> >  delete mode 100644 fs/btrfs/super.c
> >  create mode 100644 fs/btrfs/volumes.c
> >  create mode 100644 fs/btrfs/volumes.h
> >  =20

