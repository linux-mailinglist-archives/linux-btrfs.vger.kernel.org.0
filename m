Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACA82F2192
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 22:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbhAKVMa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 16:12:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:49504 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbhAKVM3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 16:12:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610399507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UZfTOTlI/9ojCFP5Snsu4a2nRYo71yHUjRX0aMyhfAc=;
        b=YVOoDyLn9c2TcxGZQXMSDkpiSUm7YduNbT0bx4H4FTUnJSrJIHOAhWgLFTB5GkuUh/klSu
        W43Wb97mN1/tdlwvWbrDgS0CzF/gQ2wELT+lxcfdDry0J5JsWTHcyzzJ4hwdQXqU7d3psB
        txVB14+JloGwG23h4HOp7Q4sN4twtGk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8828EB800;
        Mon, 11 Jan 2021 21:11:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 831E3DA701; Mon, 11 Jan 2021 22:09:55 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.11-rc4
Date:   Mon, 11 Jan 2021 22:09:55 +0100
Message-Id: <cover.1610386850.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

more material for stable trees. Please pull, thanks.

- tree-checker: check item end overflow

- fix false warning during relocation regarding extent type

- fix inode flushing logic, caused notable performance regression (since
  5.10)

- debugging fixups:
  - print correct offset for reloc tree key
  - pass reliable fs_info pointer to error reporting helper

----------------------------------------------------------------
The following changes since commit a8cc263eb58ca133617662a5a5e07131d0ebf299:

  btrfs: run delayed iputs when remounting RO to avoid leaking them (2020-12-18 15:00:08 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.11-rc3-tag

for you to fetch changes up to e076ab2a2ca70a0270232067cd49f76cd92efe64:

  btrfs: shrink delalloc pages instead of full inodes (2021-01-08 16:36:44 +0100)

----------------------------------------------------------------
Josef Bacik (2):
      btrfs: print the actual offset in btrfs_root_name
      btrfs: shrink delalloc pages instead of full inodes

Qu Wenruo (1):
      btrfs: reloc: fix wrong file extent type check to avoid false ENOENT

Su Yue (2):
      btrfs: prevent NULL pointer dereference in extent_io_tree_panic
      btrfs: tree-checker: check if chunk item end overflows

 fs/btrfs/disk-io.c      |  2 +-
 fs/btrfs/extent_io.c    |  4 +---
 fs/btrfs/inode.c        | 60 +++++++++++++++++++++++++++++++++++--------------
 fs/btrfs/print-tree.c   | 10 ++++-----
 fs/btrfs/print-tree.h   |  2 +-
 fs/btrfs/relocation.c   |  7 +++++-
 fs/btrfs/space-info.c   |  4 +++-
 fs/btrfs/tree-checker.c |  7 ++++++
 8 files changed, 67 insertions(+), 29 deletions(-)
