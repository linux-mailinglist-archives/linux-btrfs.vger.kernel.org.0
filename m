Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2527B7D5F
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 12:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242152AbjJDKjC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Oct 2023 06:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242163AbjJDKjB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Oct 2023 06:39:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B25A6
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Oct 2023 03:38:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5707DC433C7
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Oct 2023 10:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696415936;
        bh=ZHCfmFHi2uA0xTRpUkDh09yvNr+SHB9P0ygloOe8aaM=;
        h=From:To:Subject:Date:From;
        b=iC5lJca+QVFoTqmDO8uXPxOZagJZeiwp4qQlntriYcBD+L5Owios4tStdVCHottQX
         QHdspHPYGhMqCFM35lU9uSRbudN/hjvCNjoSmeAmcIVzj+vFqrvh6pO3YiyE36og5+
         ZwB6AQ6qtrPktaD0e1pfsGAOxfy63v7l9ljC8d4dUjaGtu+6wHKonHdJ4WicpyMirO
         IcyauJGtlkqXZbjWQEwD4wkAvyb0rjT3VynJwLG1JmBdD85YnB4wdzbceuyp8rD5Fc
         CdLIraQFEy2xerMOUCsjmYyo0nVJ5s5g7Ae287YrvKb4Nr2bDHV7JUmtB+0sEK5YAB
         aNVWwsm/4+jIg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/6] btrfs: fix some data races during fsync and cleanups
Date:   Wed,  4 Oct 2023 11:38:47 +0100
Message-Id: <cover.1696415673.git.fdmanana@suse.com>
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

The following remove some data races affecting mostly fsync. In general
these are mostly harmless from a functional perspective, though there are
a few cases that could cause some unexpected results but should be very
rare to hit. There's also a couple cleanups here.
More details on the changelogs.

Filipe Manana (6):
  btrfs: add and use helpers for reading and writing last_log_commit
  btrfs: add and use helpers for reading and writing log_transid
  btrfs: add and use helpers for reading and writing fs_info->generation
  btrfs: add and use helpers for reading and writing last_trans_committed
  btrfs: remove pointless barrier from btrfs_sync_file()
  btrfs: update comment for struct btrfs_inode::lock

 fs/btrfs/btrfs_inode.h  | 34 +++++++++++++++++++---------------
 fs/btrfs/ctree.h        | 34 +++++++++++++++++++++++++++++++++-
 fs/btrfs/disk-io.c      | 17 +++++++++--------
 fs/btrfs/file.c         |  5 ++---
 fs/btrfs/fs.h           | 30 ++++++++++++++++++++++++++++++
 fs/btrfs/inode.c        |  4 ++--
 fs/btrfs/ioctl.c        |  4 ++--
 fs/btrfs/scrub.c        |  2 +-
 fs/btrfs/super.c        |  7 ++++---
 fs/btrfs/sysfs.c        |  2 +-
 fs/btrfs/transaction.c  |  8 ++++----
 fs/btrfs/transaction.h  |  2 +-
 fs/btrfs/tree-checker.c |  2 +-
 fs/btrfs/tree-log.c     |  6 +++---
 14 files changed, 112 insertions(+), 45 deletions(-)

-- 
2.40.1

