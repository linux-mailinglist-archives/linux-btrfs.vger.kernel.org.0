Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD98B49F4FA
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 09:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347218AbiA1INS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 03:13:18 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42728 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236744AbiA1INR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 03:13:17 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F29361F3AD
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jan 2022 08:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643357596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=nVXE7xeExOmjS2e9D8d331pf285s60sv7bKy4OTU8Os=;
        b=eLPGroCvezxcp/kggXiG3O4Zb8koLVlgtajUe3CZhkzfQmfLqCZddAnpW5EACEwPWKPce1
        Bl+Z+VES8Ttk5vMuzUTyBtRojvLjq0mgLJuJ60Z2aztSJBKFyFD97cWadnxTY1yilY1rWl
        l/ZyMASYq9tkN+gNFG3Lsa8kinOATe0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55805139C4
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jan 2022 08:13:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kauACJyl82FjVQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jan 2022 08:13:16 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: defrag: don't waste CPU time on non-target extent
Date:   Fri, 28 Jan 2022 16:12:54 +0800
Message-Id: <cover.1643357469.git.wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the rework of btrfs_defrag_file() one core idea is to defrag cluster
by cluster, thus we can have a better layered code structure, just like
what we have now:

btrfs_defrag_file()
|- defrag_one_cluster()
   |- defrag_one_range()
      |- defrag_one_locked_range()

But there is a catch, btrfs_defrag_file() just moves the cluster to the
next cluster, never considering cases like the current extent is already
too large, we can skip to its end directly.

This increases CPU usage on very large but not fragmented files.

Fix the behavior in defrag_one_cluster() that, defrag_collect_targets()
will reports where next search should start from.

If the current extent is not a target at all, then we can jump to the
end of that non-target extent to save time.

To get the missing optimization, also introduce a new structure,
btrfs_defrag_ctrl, so we don't need to pass things like @newer_than and
@max_to_defrag around.

This also remove weird behaviors like reusing range::start for next
search location.

And since we need to convert old btrfs_ioctl_defrag_range_args to newer
btrfs_defrag_ctrl, also do extra sanity check in the converting
function.

Such cleanup will also bring us closer to expose these extra policy
parameters in future enhanced defrag ioctl interface.
(Unfortunately, the reserved space of the existing defrag ioctl is not
large enough to contain them all)

Qu Wenruo (4):
  btrfs: uapi: introduce BTRFS_DEFRAG_RANGE_MASK for later sanity check
  btrfs: defrag: introduce btrfs_defrag_ctrl structure for later usage
  btrfs: defrag: use btrfs_defrag_ctrl to replace
    btrfs_ioctl_defrag_range_args for btrfs_defrag_file()
  btrfs: defrag: allow defrag_one_cluster() to large extent which is not
    a target

 fs/btrfs/ctree.h           |  22 +++-
 fs/btrfs/file.c            |  17 ++--
 fs/btrfs/ioctl.c           | 199 ++++++++++++++++++++++---------------
 include/uapi/linux/btrfs.h |   6 +-
 4 files changed, 152 insertions(+), 92 deletions(-)

-- 
2.34.1

