Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2623017BC2F
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Mar 2020 12:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgCFLxd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Mar 2020 06:53:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:38858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgCFLxd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Mar 2020 06:53:33 -0500
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03A0E2073B;
        Fri,  6 Mar 2020 11:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583495612;
        bh=mgkugr4Q1oBLbBLSLuDbrC5GMhtaUsRREVmPEG+yhsU=;
        h=From:To:Cc:Subject:Date:From;
        b=J7dAe4upecDFSywdPc7wn7c7WUC76VaUFoUI7xME9avD7VKC0HrhnAHSgAiAhGbtG
         dy+5XQAKl+sXChOyAOsZTeM3PJCGvwsA9kBgds4G5Hlpvw/ulNrNMG42kEE5ceyHux
         kjVov9YiOQztR16+Lc+LpvirYaWsb79S6B1qou3U=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com
Subject: [PATCH 0/3] Btrfs: make ranged fsyncs always respect the given range
Date:   Fri,  6 Mar 2020 11:53:29 +0000
Message-Id: <20200306115329.16947-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Btrfs doesn't respect the given range for a fsync when the inode's has the
"need full sync" bit set - it treats the fsync as a full ranged one, operating
on the whole file, doing more IO and cpu work then needed.

That behaviour was needed to fix a corruption bug. Commit 0c713cbab6200b
("Btrfs: fix race between ranged fsync and writeback of adjacent ranges")
fixed that bug by turning the ranged fsync into a full one.

Later the hole detection code of fsync was simplified a lot in order to
fix another bug when using the NO_HOLES feature - done by commit
0e56315ca147b3 ("Btrfs: fix missing hole after hole punching and fsync when
using NO_HOLES").

That commit now makes it easy to avoid turning the ranged fsyncs into
non-ranged fsyncs. This patchset does that. The first two patches are
just cleanups to make the fix easier and less verbose.

A special note is that test generic/456 now fails as fsck reports a missing
file extent item due to an implicit hole (when not using the NO_HOLES feature).
This wasn't supposed to happen anymore after Josef's recent patches that
changes how we update the on disk i_size of an inode. That patchset was
supposed to fix all case of missing file extent items for holes, but there's
more cases which I uncovered while working on this. I'm moving the discussion
of those particular cases under the e-mail thread of Josef's patch that has
the subject:

 "btrfs: use the file extent tree infrastructure"

That has the following address on lore:

https://lore.kernel.org/linux-btrfs/CAL3q7H69_tEsV2WGu9Y6ZgB_1gy9WKPB5iR9XiWaUGiU6C871A@mail.gmail.com/T/#u

Thanks.

Filipe Manana (3):
  Btrfs: add helper to get the end offset of a file extent item
  Btrfs: factor out inode items copy loop from btrfs_log_inode()
  Btrfs: make ranged full fsyncs more efficient

 fs/btrfs/ctree.h     |   1 +
 fs/btrfs/file-item.c |  40 ++++--
 fs/btrfs/file.c      |  13 --
 fs/btrfs/inode.c     |  10 +-
 fs/btrfs/send.c      |  44 +-----
 fs/btrfs/tree-log.c  | 379 +++++++++++++++++++++++++++++----------------------
 6 files changed, 251 insertions(+), 236 deletions(-)

-- 
2.11.0

