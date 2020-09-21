Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D1327250B
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 15:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbgIUNNj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 09:13:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726471AbgIUNNd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 09:13:33 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B0FF21789
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 13:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600694013;
        bh=s03I3UOdvEk/9wdZ+z0w+AVvdEoexbTMa8Mx9YuH61c=;
        h=From:To:Subject:Date:From;
        b=gUc8OMeH2yLjadysAH1ON7d2E8HQgwKXZtuSKDya2gKt+uKxTfVf6Zh+1UiH++OVA
         oKB3+QZ8Id2XDWesJ5sYctWUWT10w+VeWg2wGb2AIH4ZiVUBa+FVJEVT5oJ2EY7FKv
         FinPDE4tI52DD7FxiP5c4KNRbMIgCrp4p3JZpgjQ=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: send, fix some failures due to commands with wrong paths
Date:   Mon, 21 Sep 2020 14:13:28 +0100
Message-Id: <cover.1600693246.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Incremental send operations can often fail at the receiver due to a wrong
path in some command. This small patchset fixes a few more cases where
such problems happen. There are sporadic reports of this type of failures,
such as [1] and [2] for example, and many similar issues were fixed in a
more distant past. Without having the full directory trees of the parent
and send snapshots, with inode numbers, it's hard to tell if this patchset
fixes exactly those reported cases, but the cases fixed by this patchset
are all I could find in the last two weeks.

[1] https://lore.kernel.org/linux-btrfs/57021127-01ea-6533-6de6-56c4f22c4a5b@gmail.com/
[2] https://lore.kernel.org/linux-btrfs/87a7obowwn.fsf@lausen.nl/


Filipe Manana (2):
  btrfs: send, orphanize first all conflicting inodes when processing
    references
  btrfs: send, recompute reference path after orphanization of a
    directory

 fs/btrfs/send.c | 200 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 160 insertions(+), 40 deletions(-)

-- 
2.26.2

