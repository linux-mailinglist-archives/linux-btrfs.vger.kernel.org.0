Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28B4710185
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 01:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjEXXK3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 19:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjEXXK3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 19:10:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C66299
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 16:10:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4CC451FE36;
        Wed, 24 May 2023 23:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684969826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=H622lC5e18DL2FfA7k4rubE5QcYhDS2G7lMDKG3ySlk=;
        b=DyxQoAbHbfTT1sG4qCFDH7cjLwh35c0ngkPDgGkBMvc7mjsjJMf960BBZPPJnJMQO1TKNM
        LTUwv8EWlzRswPoWrWiitAyrPFt7UPCG0OLAjch39AjUwI45rvDPQtT3B869pfsmpT3Nqo
        lWxdaNKnHvIeQoo4+oD1QBnd6r+YKls=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3CE252C141;
        Wed, 24 May 2023 23:10:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9F866DA85B; Thu, 25 May 2023 01:04:19 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/9] Parameter cleanups in extent state helpers
Date:   Thu, 25 May 2023 01:04:19 +0200
Message-Id: <cover.1684967923.git.dsterba@suse.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is motivated by the gfp parameter passed to all the helpers and how
to get rid of it. Most of the values are GFP_NOFS with some exceptions.
One of them (GFP_NOFAIL) can be removed the other one (GFP_NOWAIT) is
transformed to existing parameters.

Module code size is lower for the whole series and stack is reduced in
about 50 functions by 8 bytes.

David Sterba (9):
  btrfs: open code set_extent_defrag
  btrfs: open code set_extent_delalloc
  btrfs: open code set_extent_new
  btrfs: open code set_extent_dirty
  btrfs: open code set_extent_bits_nowait
  btrfs: open code set_extent_bits
  btrfs: drop NOFAIL from set_extent_bit allocation masks
  btrfs: pass NOWAIT for set/clear extent bits as another bit
  btrfs: drop gfp from parameter extent state helpers

 fs/btrfs/block-group.c           |  6 ++--
 fs/btrfs/defrag.c                |  3 +-
 fs/btrfs/dev-replace.c           |  4 +--
 fs/btrfs/extent-io-tree.c        | 37 ++++++++++++-------
 fs/btrfs/extent-io-tree.h        | 62 ++++++++------------------------
 fs/btrfs/extent-tree.c           | 27 +++++++-------
 fs/btrfs/extent_io.c             |  3 +-
 fs/btrfs/extent_map.c            | 10 +++---
 fs/btrfs/file-item.c             | 10 +++---
 fs/btrfs/inode.c                 |  9 +++--
 fs/btrfs/relocation.c            | 10 +++---
 fs/btrfs/tests/extent-io-tests.c | 16 ++++-----
 fs/btrfs/zoned.c                 |  4 +--
 13 files changed, 91 insertions(+), 110 deletions(-)

-- 
2.40.0

