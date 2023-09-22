Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798447AAFA3
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 12:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjIVKhl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 06:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbjIVKhh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 06:37:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27691A4
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 03:37:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBE4C433C8
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 10:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695379050;
        bh=J/yFMUkWDw70e6b3bAfXhcXdKrUP2Gav36Rzmip+rWU=;
        h=From:To:Subject:Date:From;
        b=HSZg6aGiMcj5aYD9FDpL+mzsWargPYoB++x+bnm3gE3p0mgIxMiQfzH9rMn/pMyhI
         ZeuJWNd2eXN7vzSFJdmjLlHwd1z3z7ogYvuVij1P1t6muz2dvevLBTafH5RZ2KB+SH
         oSnQ5obsPGlgVUQoejQCWjafbp5HpI8GEeVOET7UWdp38wS/Os5QXspOl5+sjmgTpd
         9hfvlvTb4RG4zIHMFBX4d/MeKUsBVbh9EYVIx9pcLdUI9EoO/v2i8XfKYkaV7Eck9k
         gHQp+x4S+IyG44AnpGzR/ckyjMGjtqvJV1VUbthyPzkBluDeOkYO6nVe1rNlSDLprX
         kSoYWirRi0nSg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/8] btrfs: some cleanups around inode update and helpers
Date:   Fri, 22 Sep 2023 11:37:18 +0100
Message-Id: <cover.1695333082.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Some cleanups mostly around btrfs_update_inode(), its helpers and some
callers, mostly to remove the redundant root argument, which can be taken
from the given inode. More details in the changelogs.

Filipe Manana (8):
  btrfs: simplify error check condition at btrfs_dirty_inode()
  btrfs: remove noline from btrfs_update_inode()
  btrfs: remove redundant root argument from btrfs_update_inode_fallback()
  btrfs: remove redundant root argument from btrfs_update_inode()
  btrfs: remove redundant root argument from btrfs_update_inode_item()
  btrfs: remove redundant root argument from btrfs_delayed_update_inode()
  btrfs: remove redundant root argument from maybe_insert_hole()
  btrfs: remove redundant root argument from fixup_inode_link_count()

 fs/btrfs/block-group.c      |  3 +-
 fs/btrfs/btrfs_inode.h      |  4 +--
 fs/btrfs/delayed-inode.c    |  2 +-
 fs/btrfs/delayed-inode.h    |  1 -
 fs/btrfs/file.c             |  8 ++---
 fs/btrfs/free-space-cache.c | 13 ++++----
 fs/btrfs/inode.c            | 66 ++++++++++++++++++-------------------
 fs/btrfs/ioctl.c            |  2 +-
 fs/btrfs/reflink.c          |  3 +-
 fs/btrfs/transaction.c      |  2 +-
 fs/btrfs/tree-log.c         | 32 +++++++++---------
 fs/btrfs/verity.c           |  4 +--
 fs/btrfs/xattr.c            |  4 +--
 13 files changed, 68 insertions(+), 76 deletions(-)

-- 
2.40.1

