Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5593EFD0A
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 08:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238515AbhHRGpW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 02:45:22 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57266 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238080AbhHRGo6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 02:44:58 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9AF8A20057
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 06:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629269063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=rlgjcbhTe0Djf03PpcccKX5OsJc6UfZE5LPSZfarZhM=;
        b=Olp20B/BhcU1jenVbn+b1FpxktgrJWW+goDKXpg/vNeyK3lbYYjd03k54LxyjfMENWqAU1
        pB26x5DvTNpfDSsQrM+23sBL7yPK3ooOBSAqHOyMVYkLXLU/9mdynAMSeAwP9wg0xj/+cU
        qgphqZIm6vZl7jzoxuXflgX5BWjLjRw=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D1A52134B1
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 06:44:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 3LwLJEasHGH4dAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 06:44:22 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: make subpage warnings more strict
Date:   Wed, 18 Aug 2021 14:44:17 +0800
Message-Id: <20210818064420.866803-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For the incoming support of more page sizes for subpage RW mount, we
will require tree blocks to be nodesize aligned.

This patch prepare such restrict warnings for btrfs-check and update
self-tests to handle them.

Currently all convert/fsck/misc can pass except one unrelated
regression, fsck/025, which is caused by "btrfs-progs: Drop the type
check in init_alloc_chunk_ctl_policy_regular".

All fsck images except fsck/018 are newer enough to have all their tree
blocks nodesize aligned, so they won't cause any new warnings.
But still, for read-only tests, we will skip the subpage warnings as we
only want to ensure our writes from btrfs-progs won't cause new subpage
warnings.

Qu Wenruo (3):
  btrfs-progs: tests: also check subpage warning for type 2 test cases
  btrfs-progs: tests: don't check subpage related warnings for fsck type
    1 tests
  btrfs-progs: require full nodesize alignement for subpage support

 check/main.c        |  3 ++-
 check/mode-common.h | 22 +++++++++++++---------
 check/mode-lowmem.c |  3 ++-
 tests/common        | 16 +++++++++++++---
 tests/fsck-tests.sh |  9 ++++++++-
 5 files changed, 38 insertions(+), 15 deletions(-)

-- 
2.32.0

