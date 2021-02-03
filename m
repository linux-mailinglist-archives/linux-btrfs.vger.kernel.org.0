Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B0630D85D
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Feb 2021 12:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbhBCLSg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Feb 2021 06:18:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:56516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233878AbhBCLSb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Feb 2021 06:18:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7224F64F61
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Feb 2021 11:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612351070;
        bh=dkb2APu9lTa6pco7G8JNg4XQAE6Hhy/2dB++B59CIBY=;
        h=From:To:Subject:Date:From;
        b=fpE2yFiUw0w0u62vzYMXwPVlYhc6X5M9uKMqkOMd3pGz4p95zz6GQ/ktGLmKFTIK8
         hX1fMKvBQ/j6OcD92QlucAEfMMeQqMxGeKIMbY8J3HfGa0Ndn7/AKMNeBuEm7bPTEC
         PlK7+eyllpONo7lY8nUeVzsA1yVjmOGufKb1A/NUu59pFaY/q4D4602tPS18KnfsUc
         A1TXbRLD+XNUqxAJcYGCtq0MxiDFSK+uehCuIYVoE/ELm6BjzxdW8Spn41Viq5NO0o
         GwlhLTHxImya4IERVGgtcCiF17eJ5k0+GrT2Q/C/9iW5FbqA1uo0dcOIUkMmyEwTtL
         eOOgBmTLf8v6Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: fix a couple swapfile support bugs 
Date:   Wed,  3 Feb 2021 11:17:43 +0000
Message-Id: <cover.1612350698.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The following patchset fixes 2 bugs with the swapfile support, where we can
end up falling back to COW when writing to an active swapfile. As a bonus,
it makes the NOCOW write patch, for both buffered and direct IO, more efficient
by avoiding doing repeated worked when checking if the target block group is
read-only.

Filipe Manana (4):
  btrfs: avoid checking for RO block group twice during nocow writeback
  btrfs: fix race between writes to swap files and scrub
  btrfs: remove no longer used function btrfs_extent_readonly()
  btrfs: fix race between swap file activation and snapshot creation

 fs/btrfs/block-group.c | 33 ++++++++++++++++++++++++++++-
 fs/btrfs/block-group.h |  9 ++++++++
 fs/btrfs/ctree.h       |  6 +++++-
 fs/btrfs/extent-tree.c | 13 ------------
 fs/btrfs/inode.c       | 47 ++++++++++++++++++++++++++++++++++--------
 fs/btrfs/scrub.c       |  9 +++++++-
 6 files changed, 92 insertions(+), 25 deletions(-)

-- 
2.28.0

