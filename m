Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934A867D718
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jan 2023 22:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjAZVBL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Jan 2023 16:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjAZVBK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Jan 2023 16:01:10 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834E04AA7E
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jan 2023 13:01:03 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id x4so3643256ybp.1
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jan 2023 13:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ul22dkf05DFIluXLGGRIGIp25flNE3wepPjQ64Q3IMo=;
        b=aMwfbAjasSmHa62iADZ1rT7cWH/+JZqZlJO921nd8Nka3SXbjUc5tkMe2fQ/Kubdyb
         B9wIktkvC9E67OnjKTuxzdsmidhDBHhmKmYee2AC0mWoGqE/wH6TpDdAoCOZzzL90iVN
         up2Qbax7QDXKbPh2dywrdF+Irwh2FUJlX5Uy1B7TIycZzA0+0x+erOlY/A1NnCVOCiEZ
         9kjnqQ3/2bb7KIEsETFhXTsJXY9GbMw//RA+jNWFaXy62QuOb3VlWiv4KMsEp97CyFy3
         NhtEUSKXiAeW1qVFaNKr3zggVTm4cfmyyiLGwIMYT0R21jBJO7U8IlgD5GHiMZjbhH6W
         Vz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ul22dkf05DFIluXLGGRIGIp25flNE3wepPjQ64Q3IMo=;
        b=5o9jN/PsaTicKr9QNKRZRQHyhtGNrBiZvZq2q5R487+QXRWhd5b9uWv0rGN29OcPpB
         LdlcgeGN+1PWndK4dzYd+0zgtMk5nEUxWp0TUVYMQr41uDHOG09yl+puGvnz3tDbth7/
         v4z0qYOxeuvUwspfoLkYVNv/BTpJJ3EsU7ApsEt1PCu2Uo1IYe8ctRL9CJ3H+bYuGuwF
         Goc4MDKc2pyqLQls/tC7Q0MW1bXmV2+7yobc94pXIK1jyoyUMun2sjIV0Zse8EmkU2ud
         UI+LdKA0Ibc/KnVYc6jrPPDCjVO003v0yTXmWot3EvM7Gn1Avp6CNRUE1JzU5If562XZ
         V8jA==
X-Gm-Message-State: AO0yUKWCRa/LbfvSh7swvxW0gyRzoeK5bH70j6kzgxTgCpO1cKqqg34t
        lUAHC5GRgPymmIKySSroSDign7hiyUh7f99kmgU=
X-Google-Smtp-Source: AK7set+vfbKBwj7Uol22URCfH6n2KIIW+tRFqSyq1hxQFsrTU5WqAgCDfAcnrVzs9yRBprokLvluRQ==
X-Received: by 2002:a25:74c5:0:b0:80b:9f92:c85e with SMTP id p188-20020a2574c5000000b0080b9f92c85emr5527137ybc.46.1674766862326;
        Thu, 26 Jan 2023 13:01:02 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id h22-20020a05620a285600b006faaf6dc55asm1603140qkp.22.2023.01.26.13.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 13:01:01 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 0/7] extent buffer dirty cleanups
Date:   Thu, 26 Jan 2023 16:00:53 -0500
Message-Id: <cover.1674766637.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v2->v3:
- Reworked the logic around clearing dirty on extent buffers not in our
  transaction.  We do need this for update_ref_for_cow in some cases that I
  didn't account for.  I've expanded the logic for this make it more idiot
  proof, and adjusted all of the patches accordingly.

v1->v2:
- Added "btrfs: do not call btrfs_clean_tree_block in update_ref_for_cow", Qu
  noticed some corruption with the original patchset, this turned out to be
  because we were clearing the extent buffer dirty at cow time, which doesn't
  make sense as we're not free'ing the current block in our current transaction.

--- Original email ---
Hello,

While sync'ing ctree.c to btrfs-progs I noticed we have some oddities when it
comes to how we deal with the extent buffer being dirty.  We have
btrfs_clean_tree_block, which is sort of meant to be run against extent buffers
we've modified in this transaction.  However we have some other places where
we've open coded the same work without the generation check.  This makes it kind
of confusing, and is inconsistent with how we deal with the
fs_info->dirty_metadata_bytes.

So clean this stuff up so we have one helper we use for setting the extent
buffer dirty (btrfs_mark_buffer_dirty) and one for clearing dirty
(btrfs_clear_buffer_dirty).  This makes everything more consistent and clean
across the board.  I've additionally cleaned up a random writeback thing we had
in tree-log that I noticed while doing these cleanups.  Thanks,

Josef

Josef Bacik (7):
  btrfs: always lock the block before calling btrfs_clean_tree_block
  btrfs: add trans argument to btrfs_clean_tree_block
  btrfs: replace clearing extent buffer dirty bit with btrfs_clean_block
  btrfs: do not increment dirty_metadata_bytes in set_btree_ioerr
  btrfs: rename btrfs_clean_tree_block => btrfs_clear_buffer_dirty
  btrfs: combine btrfs_clear_buffer_dirty and clear_extent_buffer_dirty
  btrfs: remove btrfs_wait_tree_block_writeback

 fs/btrfs/ctree.c           | 31 +++++++++++++++--------------
 fs/btrfs/disk-io.c         | 25 +++++-------------------
 fs/btrfs/disk-io.h         |  3 ++-
 fs/btrfs/extent-tree.c     |  9 ++++-----
 fs/btrfs/extent_io.c       | 23 ++++++++++++++--------
 fs/btrfs/extent_io.h       |  5 ++++-
 fs/btrfs/free-space-tree.c |  2 +-
 fs/btrfs/ioctl.c           |  2 +-
 fs/btrfs/qgroup.c          |  2 +-
 fs/btrfs/tree-log.c        | 40 ++++++++++++++------------------------
 10 files changed, 64 insertions(+), 78 deletions(-)

-- 
2.26.3

