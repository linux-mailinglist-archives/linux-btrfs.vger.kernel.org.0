Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2AF4334AF
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 13:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhJSLb6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 07:31:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42970 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhJSLb5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 07:31:57 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E77FB1FCB4
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 11:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634642983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+SjfUkzx0LHfQoGCyrgLKV15SwIsgYZ9eF9JYyLvjog=;
        b=PDylZaNLs8L3H54X9iJNex0oMp6E4Ddz5thVgsokvWTSqO5FAx1AfwuSKZ5nFSOF4s1xcN
        Z3AskfdT42t/ohJRXliVNwu41kpf7vfdviBZakyPzRdVhCRQLLcFvw/hFPIeW7TQUcWv4O
        /+1Xj6k3kX514zWMUzDKnKvybfAsiZs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 47E3113E5F
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 11:29:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id geL1BCesbmGmcAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 11:29:43 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: cleanup on btrfs_super_block definition
Date:   Tue, 19 Oct 2021 19:29:23 +0800
Message-Id: <20211019112925.71920-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch is to enhance the definition of btrfs_super_block by:

- Unify sizeof(struct btrfs_super_block) and BTRFS_SUPER_INFO_SIZE
  In kernel, it's just 3 location allocating BTRFS_SUPER_INFO_SIZE
  (one of them is for selftest), so such change is not doing much
  difference.
  But for btrfs-progs, it would remove call sites like:

        char tmp[BTRFS_SUPER_INFO_SIZE];
        struct btrfs_super_block *buf = (struct btrfs_super_block *)tmp;
 
- Move btrfs_super_block definition to uapi/linux/btrfs_tree.h.
  Due to BTRFS_IOC_TREE_SEARCH ioctl, we're almost exposing all on-disk
  formats to the user space.
  Thus it's almost a perfect location to contain all on-disk schema.

Qu Wenruo (2):
  btrfs: make sizeof(struct btrfs_super_block) to match
    BTRFS_SUPER_INFO_SIZE
  btrfs: move btrfs_super_block to uapi/linux/btrfs_tree.h

 fs/btrfs/ctree.h                | 136 --------------------------------
 fs/btrfs/super.c                |   2 +
 include/uapi/linux/btrfs_tree.h | 135 +++++++++++++++++++++++++++++++
 3 files changed, 137 insertions(+), 136 deletions(-)

-- 
2.33.0

