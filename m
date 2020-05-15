Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F24F1D5813
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 May 2020 19:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgEORgr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 May 2020 13:36:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:50492 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgEORgq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 May 2020 13:36:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9512DAA7C;
        Fri, 15 May 2020 17:36:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 13243DA732; Fri, 15 May 2020 19:35:52 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/3] Tree and inode lookup cleanups
Date:   Fri, 15 May 2020 19:35:52 +0200
Message-Id: <cover.1589563951.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Simplify functions that take struct key for lookup but don't use all the
members. Reduces size of .ko by about 1.2K and stack consumption is
reduced by 450 bytes in total.

David Sterba (3):
  btrfs: simplify root lookup by id
  btrfs: open code read_fs_root
  btrfs: simplify iget helpers

 fs/btrfs/backref.c          | 13 ++---------
 fs/btrfs/ctree.h            |  5 ++--
 fs/btrfs/disk-io.c          | 35 +++++++++++++---------------
 fs/btrfs/disk-io.h          |  3 +--
 fs/btrfs/export.c           | 17 +++-----------
 fs/btrfs/file.c             | 12 ++--------
 fs/btrfs/free-space-cache.c |  2 +-
 fs/btrfs/inode.c            | 42 +++++++++++++++++----------------
 fs/btrfs/ioctl.c            | 30 ++++++------------------
 fs/btrfs/props.c            |  9 ++------
 fs/btrfs/relocation.c       | 46 +++++++++++--------------------------
 fs/btrfs/root-tree.c        | 12 ++++------
 fs/btrfs/scrub.c            |  6 +----
 fs/btrfs/send.c             | 22 ++++--------------
 fs/btrfs/super.c            | 11 ++-------
 fs/btrfs/transaction.c      |  2 +-
 fs/btrfs/tree-log.c         | 32 ++++++++++----------------
 fs/btrfs/uuid-tree.c        |  6 +----
 18 files changed, 99 insertions(+), 206 deletions(-)

-- 
2.25.0

