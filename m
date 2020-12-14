Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3992D9594
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Dec 2020 10:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbgLNJ5d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Dec 2020 04:57:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:58710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729399AbgLNJ5c (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Dec 2020 04:57:32 -0500
From:   fdmanana@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 0/2] btrfs: fix races between clone, fallocate and memory mapped writes
Date:   Mon, 14 Dec 2020 09:56:40 +0000
Message-Id: <cover.1607939569.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

For a very long time there's been a race between clone/dedupe and memory
mapped writes as well as between fallocate and memory mapped writes. For
both cases the consequence of the race is that it can makes us deadlock
when we are low on available metadata space, since clone/dedupe/fallocate
start a transaction while holding file ranges locked, and allocating the
metadata can result in the async reclaim task to flush the inodes being
used by clone/dedupe/fallocate, if a memory mapped write happened before
we locked the file ranges.

For the dedupe case, Josef's recent fix [1] ("btrfs: fix race between dedupe
and mmap") happens to fix this deadlock problem as well. The first patch
in this patchset fixes the issue for both clone and dedupe, as it's centered
on the shared extent locking function, and it is independent of Josef's fix
(works both with and without that fix).

[1] https://lore.kernel.org/linux-btrfs/afdc2109f83fff1a925d7a66a6a047d4400721d4.1607724668.git.josef@toxicpanda.com/

Filipe Manana (2):
  btrfs: fix race between cloning and memory mapped writes leading to
    deadlock
  btrfs: fix race between fallocate and memory mapped writes leading to
    deadlock

 fs/btrfs/extent_io.c    |  2 +-
 fs/btrfs/file.c         | 38 +++++---------------------------
 fs/btrfs/inode.c        |  4 ++--
 fs/btrfs/ordered-data.c | 48 ++++++++++++++++++++++++++++++++---------
 fs/btrfs/ordered-data.h |  6 +++---
 fs/btrfs/reflink.c      | 28 ++++++++++++++++++------
 6 files changed, 71 insertions(+), 55 deletions(-)

-- 
2.28.0

