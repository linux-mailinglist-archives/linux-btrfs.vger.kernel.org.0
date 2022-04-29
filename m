Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338185153B6
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 20:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380012AbiD2Se5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 14:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379450AbiD2Se4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 14:34:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038955D18D
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 11:31:36 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 17CBE1F892;
        Fri, 29 Apr 2022 18:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651257095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TKghrSquJu2re3OCEjiJcI2vsP59sGUq2ZWBNDFBGYw=;
        b=M1hjGK45I9q4p9USV1xT2e4XGChdxOb7xaxGUlqvG2VjQZQ0wWFXtyaRie4pPcDIgKAHoT
        IiaW8W2JQENLxKydWVEJosGoBh2GGFPED5I2NohhSIZHGnEvvs8PT1UU3ve4pF7vxh7EmJ
        pWX4IkejMNYnJHTZz1xGYNy8ecqnpTU=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0FA812C141;
        Fri, 29 Apr 2022 18:31:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 154BBDA7DE; Fri, 29 Apr 2022 20:27:26 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/9] Structre and parameter cleanups
Date:   Fri, 29 Apr 2022 20:27:26 +0200
Message-Id: <cover.1651255990.git.dsterba@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Simplify some argument passing, remove too-trivial helpers or unused
structure members.

David Sterba (9):
  btrfs: sink parameter is_data to btrfs_set_disk_extent_flags
  btrfs: remove btrfs_delayed_extent_op::is_data
  btrfs: remove unused parameter bio_flags from btrfs_wq_submit_bio
  btrfs: remove trivial helper update_nr_written
  btrfs: simplify handling of bio_ctrl::bio_flags
  btrfs: open code extent_set_compress_type helpers
  btrfs: rename io_failure_record::bio_flags to compress_type
  btrfs: rename bio_flags in parameters and switch type
  btrfs: rename bio_ctrl::bio_flags to compress_type

 fs/btrfs/ctree.c       |  2 +-
 fs/btrfs/ctree.h       |  5 ++-
 fs/btrfs/delayed-ref.c |  4 +--
 fs/btrfs/delayed-ref.h |  1 -
 fs/btrfs/disk-io.c     |  5 ++-
 fs/btrfs/disk-io.h     |  3 +-
 fs/btrfs/extent-tree.c | 10 +++---
 fs/btrfs/extent_io.c   | 73 ++++++++++++++++++------------------------
 fs/btrfs/extent_io.h   | 22 ++-----------
 fs/btrfs/inode.c       | 10 +++---
 10 files changed, 50 insertions(+), 85 deletions(-)

-- 
2.34.1

