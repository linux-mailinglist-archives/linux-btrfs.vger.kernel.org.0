Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228B979C29D
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 04:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbjILCTF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 22:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236630AbjILCSv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 22:18:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA40A67407
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 18:41:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E569F21836
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 23:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694475343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=qLyc/dgEF+tHVRZknsZ5GZTNdgTx2/JnhAJr9R5U3mY=;
        b=pbsZAODgfK7UorqvOZiq5MRjjcbOsezeHWb4YqTjL/ON8oW9SWw4b//7n950GlhgpRmxqE
        x9WOCrgRDxklwwKFI/GBHCBBXxbYQifCyHl2QpVdfKFjXVam1EXQDl4wptdpPF7HS6n7//
        CdsO1AR3kUhnExJ4nJMPewpMzuARC4o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1AE2A139CC
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 23:35:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XiZMMk6k/2SgPwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 23:35:42 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: fix all -Wshadow warnings and enable -Wshadow for default builds
Date:   Tue, 12 Sep 2023 09:05:22 +0930
Message-ID: <cover.1694428549.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Recently David fixes quite some errno usage in kernel code, to avoid
overwriting user space @errno variable.

This inspired me that, those problems can be detected by -Wshadow, thus
let's enable -Wshadow for default builds.

The biggest cause of -Wshadow warnings is min()/max() which all uses the
same __x and __y.
To fix that, pull the kernel version with the usage of __UNIQUE_ID() to
address the problem.

The remaining ones are mostly bad namings and harmless, but there is
still some bad ones, detailed in the 2nd patch.

Tested with both GCC 13.2.1 and Clang 16.0.6, the first one is fully
clean, the latter one has some unrelated warnings, but no -Wshadow
warnings.

Qu Wenruo (3):
  btrfs-progs: pull in the full max/min/clamp implementation from kernel
  btrfs-progs: fix all variable shadowing
  btrfs-progs: enable -Wshadow for default build

 Makefile                     |   3 +-
 Makefile.extrawarn           |   1 -
 check/main.c                 |   6 +-
 check/mode-lowmem.c          |   4 +-
 check/qgroup-verify.c        |  23 +++---
 check/repair.c               |   7 +-
 cmds/filesystem-usage.c      |   8 +-
 cmds/subvolume-list.c        |   2 +-
 common/internal.h            | 147 +++++++++++++++++++++++++++++++----
 image/image-restore.c        |  10 +--
 kernel-shared/async-thread.c |   2 +-
 kernel-shared/extent-tree.c  |   1 -
 tune/change-csum.c           |  10 +--
 13 files changed, 167 insertions(+), 57 deletions(-)

--
2.42.0

