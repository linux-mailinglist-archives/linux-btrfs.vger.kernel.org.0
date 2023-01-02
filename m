Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE6365B244
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jan 2023 13:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjABMo2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Jan 2023 07:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjABMo0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Jan 2023 07:44:26 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9765C49;
        Mon,  2 Jan 2023 04:44:25 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 92D0C340FA;
        Mon,  2 Jan 2023 12:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672663464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xgkIsshu5RdD+A9hbWoj474lcKYovh7IgcGgY6JA4kQ=;
        b=PQrDFa3A4h2oci4eX+/fl6TTwFOFX6xXGeXiZBeSdajZdFibqJZeNe79dYezzLKNlWGTa4
        OOyLncC7QqikOor38QIweMRtAXxsyCNVqoYoGk/hOBUjHidhA9VnZ/CATKXgL3lyXfrbVi
        GRTw6NZnXbR3EdfQSLOZbiQTf/GpXI8=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 86B072C141;
        Mon,  2 Jan 2023 12:44:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A7A65DA7A3; Mon,  2 Jan 2023 13:38:55 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.2-rc3
Date:   Mon,  2 Jan 2023 13:38:50 +0100
Message-Id: <cover.1672662506.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

first batch of regression and regular fixes. Please pull, thanks.

- regressions:
  - fix error handling after conversion to qstr for paths
  - fix raid56/scrub recovery caused by uninitialized variable after
    conversion to error bitmaps
  - restore qgroup backref lookup behaviour after recent refactoring
  - fix leak of device lists at module exit time

- fix resolving backrefs for inline extent followed by prealloc

- reset defrag ioctl buffer on memory allocation error

----------------------------------------------------------------
The following changes since commit b7af0635c87ff78d6bd523298ab7471f9ffd3ce5:

  btrfs: print transaction aborted messages with an error level (2022-12-05 18:00:59 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.2-rc2-tag

for you to fetch changes up to fee4c19937439693f2420a916169d08e88576e8e:

  btrfs: fix fscrypt name leak after failure to join log transaction (2022-12-20 19:43:47 +0100)

----------------------------------------------------------------
Boris Burkov (1):
      btrfs: fix resolving backrefs for inline extent followed by prealloc

Christophe JAILLET (2):
      btrfs: fix an error handling path in btrfs_rename()
      btrfs: fix an error handling path in btrfs_defrag_leaves()

Filipe Manana (2):
      btrfs: fix leak of fs devices after removing btrfs module
      btrfs: fix fscrypt name leak after failure to join log transaction

Josef Bacik (2):
      btrfs: restore BTRFS_SEQ_LAST when looking up qgroup backref lookup
      btrfs: scrub: fix uninitialized return value in recover_scrub_rbio

Naohiro Aota (1):
      btrfs: fix trace event name typo for FLUSH_DELAYED_REFS

 fs/btrfs/backref.c           | 4 ++++
 fs/btrfs/defrag.c            | 6 ++++--
 fs/btrfs/inode.c             | 6 ++++--
 fs/btrfs/qgroup.c            | 1 +
 fs/btrfs/raid56.c            | 2 +-
 fs/btrfs/super.c             | 1 +
 fs/btrfs/tree-log.c          | 5 ++++-
 include/trace/events/btrfs.h | 2 +-
 8 files changed, 20 insertions(+), 7 deletions(-)
