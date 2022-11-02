Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D8E616225
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Nov 2022 12:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiKBLxN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Nov 2022 07:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKBLxM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Nov 2022 07:53:12 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D4928714;
        Wed,  2 Nov 2022 04:53:10 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 1D07781462;
        Wed,  2 Nov 2022 07:53:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1667389990; bh=sJNZ+wbWgGDYMUUpbP2oTYzuQ+XYPaaLmhGaZgWIAN4=;
        h=From:To:Cc:Subject:Date:From;
        b=YpP2uDWDOD1XDOa/IcLUH98YAER7UzsPULfDt7wAVlrBj+NAzRQfxINxB4utjdcd+
         KJ8sX9M9x5+/RlqumalSiX9pQYljFwqpn9k6BTygnwcg4dGQGgQn3BswWDqnMxdTEJ
         9kjE3njkkwBuTcrMfRhf582lj/mIczhS7dm8zGYfZXHrVz3N1dXydWfrhHyE8HHKe4
         lLfEzU6WjOGhBEz2y9+tJqdbDAm3zn3l/5hgL32dqZKYxWyGjCZvqBIHAJRPJM1aPe
         Io/7M/ezuVQ0UZdgJgeXB8wVRiqC3BSbYnezePL2mikc423/TOaxKu99s9EbkLXzxK
         njzwjf+WhxVMQ==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-fscrypt@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@meta.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v5 00/18] btrfs: add fscrypt integration
Date:   Wed,  2 Nov 2022 07:52:49 -0400
Message-Id: <cover.1667389115.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a changeset adding encryption to btrfs.

Last October, Omar Sandoval sent out a design document for having fscrypt
integration with btrfs [1]. In summary, it proposes btrfs storing its
own encryption IVs on a per-file-extent basis. fscrypt usually encrypts
files using an IV derived from per-inode information; this would prevent
snapshotting or reflinking or data relocation for btrfs. We have
refined this into a fscrypt extent context object, opaque to the
filesystem, which fscrypt uses to generate an IV associated with each
block in an extent. Thus, all the inodes sharing a particular
key and file extent may decrypt the extent.

This series implements this integration for non-inline extents and for
verity items.  Followup changes will allow encryption of inline extents,
which requires a few preliminary rearrangements, and will adjust tests.
This series should provide encryption, but this series should not be
used in production, as there are likely bugs.

This set hopefully reflects all of the feedback given on prior versions.

This patchset is based on kdave/misc-next as of a few minutes ago;
698dd8deb7c144616da2bcf2534808931a6bb8e2 .

[1]
https://lore.kernel.org/linux-btrfs/YXGyq+buM79A1S0L@relinquished.localdomain/

Changelog:
v5:
 - Added encrypting normal compressed extents.
 - Dropped the first few changes, around qstr/fscrypt_str usage, since
   they were taken; thanks!
 - Adjusted fscrypt_have_same_policy() to bubble up errors.
 - Stopped using division in create_io_em().
 - https://lore.kernel.org/linux-btrfs/cover.1667389115.git.sweettea-kernel@dorminy.me

v4:
 - Dropped the partial directory encryption trio of patches, as it's an
   easy and orthogonal followon.
 - fscrypt: Changed extent-based encryption to require a direct key policy.
 - fscrypt: Changed to allow direct key policies with mixed
   filename/contents encryption modes, to enable usage of existing AES
   modes with btrfs.
 - fscrypt: Changed terminology used for extent context contents to 'nonce'
   instead of 'IV', to match the nonces used in direct-key policies
   elsewhere.
 - fscrypt: Changed IV generation for extent-based encryption to generate
   16-byte IVs (if needed) from a 16-byte nonce plus extent offset, hopefully
   as discussed.
 - fscrypt: Updated documentation change to remove partial directory
   encryption.
 - fscrypt: Fixed another place to refer to 'inode-based' encryption
   instead of a more generic term.
 - btrfs: Factored btrfs_fscrypt_set_extent_context() as per Josef's
   feedback.
 - btrfs: Fixed a couple of style nits.
 - https://lore.kernel.org/linux-btrfs/cover.1666651724.git.sweettea-kernel@dorminy.me
  
v3: 
 - fscrypt: changed to generate extent contexts the same way as IVs are
   generated for inode-based encryption, allowing use of any existing
   policy and making the difference in encryption more minimal.
 - Changed to use qstr's, then fscrypt_strs, then fscrypt_names only
   where absolutely necessary, rather than fscrypt_names everywhere.
 - Reordered changes to put partially-encrypted directories, and no-key
   name handling, in their own sections at the end of the patchset.
 - Expanded on descriptions of how no-key name handling works.
 - Added encryption of verity items (but see notes in change about
   outstanding questions there)
 - Stylistic fixes
 - Renamed flags from FSCRYPT to ENCRYPT in multiple instances.
 - Made the incompat encrypt superblock flag be set the first time a
   directory is set to be encrypted, so there isn't a need for a mkfs
   option.
 - Hopefully addressed all other minor feedback points.
 - https://lore.kernel.org/linux-btrfs/cover.1666281276.git.sweettea-kernel@dorminy.me

v2:
 - Amended the fscrypt side to generically add extent contexts,
   hopefully as per Eric Biggers' past comments. IVs are now entirely
   abstracted within an extent context, and there is no longer a new
   encryption policy, as DIRECT_KEY sufficiently encapsulates the
   needs of extent-based encryption. Documented its usage in btrfs
   briefly in the documentation. 
 - Adjusted the btrfs side to deal in opaque extent contexts. Improved
   optimization to skip storing inode contexts if they are the same as
   the inode's root item's inode context.
 - Combined 'add fscrypt operation table to superblock' into 'start
   using fscrypt hooks'.
 - https://lore.kernel.org/linux-btrfs/cover.1662420176.git.sweettea-kernel@dorminy.me
 - progs: https://lore.kernel.org/linux-btrfs/cover.1662417859.git.sweettea-kernel@dorminy.me
 - tests: https://lore.kernel.org/linux-btrfs/cover.1662417905.git.sweettea-kernel@dorminy.me
v1:
 - Recombined the fscrypt changes back into this patchset.
 - Fixed several races and incorrectly ordered operations.
 - Improved IV retrieval to correctly distinguish between
   filename/symlink encryption and encryption of block 0 of a file.
 - https://lore.kernel.org/linux-btrfs/cover.1660744500.git.sweettea-kernel@dorminy.me
 - progs: https://lore.kernel.org/linux-btrfs/cover.1660729916.git.sweettea-kernel@dorminy.me
 - tests: https://lore.kernel.org/linux-btrfs/cover.1660729861.git.sweettea-kernel@dorminy.me

RFC v2: 
 - Fixed all warnings and known incorrectnesses.
 - Split fscrypt changes into their own patchset:
    https://lore.kernel.org/linux-fscrypt/cover.1658623235.git.sweettea-kernel@dorminy.me
 - Combined and reordered changes so that enabling fscrypt is the last change.
 - Removed unnecessary factoring.
 - Split a cleanup change off.
 - https://lore.kernel.org/linux-btrfs/cover.1658623319.git.sweettea-kernel@dorminy.me 

RFC v1:
 - https://lore.kernel.org/linux-btrfs/cover.1657707686.git.sweettea-kernel@dorminy.me

Omar Sandoval (10):
  fscrypt: expose fscrypt_nokey_name
  fscrypt: add fscrypt_have_same_policy() to check inode compatibility
  btrfs: disable various operations on encrypted inodes
  btrfs: start using fscrypt hooks
  btrfs: add fscrypt_context items
  btrfs: translate btrfs encryption flags and encrypted inode flag
  btrfs: encrypt normal file extent data if appropriate
  btrfs: Add new FEATURE_INCOMPAT_ENCRYPT feature flag.
  btrfs: implement fscrypt ioctls
  btrfs: permit searching for nokey names for removal

Sweet Tea Dorminy (8):
  fscrypt: allow fscrypt_generate_iv() to distinguish filenames
  fscrypt: add extent-based encryption
  fscrypt: extent direct key policies for extent-based encryption
  fscrypt: document btrfs' fscrypt quirks.
  btrfs: store a fscrypt extent context per normal file extent
  btrfs: use correct name hash for nokey names
  btrfs: encrypt verity items
  btrfs: allow encrypting compressed extents

 Documentation/filesystems/fscrypt.rst |  31 ++-
 fs/btrfs/Makefile                     |   1 +
 fs/btrfs/accessors.h                  |  29 +++
 fs/btrfs/btrfs_inode.h                |   3 +-
 fs/btrfs/compression.c                |  23 ++
 fs/btrfs/ctree.h                      |   4 +
 fs/btrfs/delayed-inode.c              |  30 ++-
 fs/btrfs/delayed-inode.h              |   4 +-
 fs/btrfs/dir-item.c                   |  81 +++++-
 fs/btrfs/dir-item.h                   |  13 +-
 fs/btrfs/extent_io.c                  |  94 ++++++-
 fs/btrfs/extent_io.h                  |   3 +
 fs/btrfs/extent_map.c                 |   7 +
 fs/btrfs/extent_map.h                 |   4 +
 fs/btrfs/file-item.c                  |  25 +-
 fs/btrfs/file.c                       |  11 +-
 fs/btrfs/fs.h                         |   5 +-
 fs/btrfs/fscrypt.c                    | 289 +++++++++++++++++++++
 fs/btrfs/fscrypt.h                    |  64 +++++
 fs/btrfs/inode.c                      | 358 ++++++++++++++++++++------
 fs/btrfs/ioctl.c                      |  48 +++-
 fs/btrfs/ordered-data.c               |  11 +-
 fs/btrfs/ordered-data.h               |   4 +-
 fs/btrfs/reflink.c                    |  11 +
 fs/btrfs/root-tree.c                  |   8 +-
 fs/btrfs/root-tree.h                  |   2 +-
 fs/btrfs/super.c                      |   7 +
 fs/btrfs/tree-checker.c               |  49 +++-
 fs/btrfs/tree-log.c                   |  16 +-
 fs/btrfs/verity.c                     | 124 +++++++--
 fs/crypto/crypto.c                    |  40 ++-
 fs/crypto/fname.c                     |  43 +---
 fs/crypto/fscrypt_private.h           |  23 +-
 fs/crypto/inline_crypt.c              |  28 +-
 fs/crypto/policy.c                    | 105 ++++++++
 include/linux/fscrypt.h               |  92 +++++++
 include/uapi/linux/btrfs.h            |   1 +
 include/uapi/linux/btrfs_tree.h       |  21 ++
 38 files changed, 1509 insertions(+), 203 deletions(-)
 create mode 100644 fs/btrfs/fscrypt.c
 create mode 100644 fs/btrfs/fscrypt.h


base-commit: 698dd8deb7c144616da2bcf2534808931a6bb8e2
-- 
2.37.3

