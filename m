Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9039E597197
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 16:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240248AbiHQOnQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 10:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240064AbiHQOnP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 10:43:15 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6692A2724
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 07:43:12 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id BDEBC80A9D;
        Wed, 17 Aug 2022 10:43:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1660747392; bh=DlR+xlXg7gg2t67kOrPQr6CIQemLStOFL+zWDUpPKdQ=;
        h=From:To:Cc:Subject:Date:From;
        b=mAKQJprumt/hbSnv23M5JvwaQP3Zj+/MUPFEXH8OTWf0Mzk99D8ooLcYOCrf5CcRH
         WhWRR3OpGQ0vUJFEWOfngcbFpMrC+DUxaOqBWDGNixNd2ADWa4vEyNU2gt5jwSNbWT
         nJXkM2M6JzYTRUFPhvrCXA+iTO01HLXXWJoGMHCtGkxgtgwCteYy/+KdJ13G5x6KPJ
         AnalVPtJUI+wwd8i/JfXZThWkentK1B9yHMHrqKT2WV4JK3k49PopZ7qLuhGrJatJI
         6j+PT86IoxYLI0WGGWPaYO5m4EMa65RsMJnfw2C8P3nzrWDMuniyYe+NJnBcr7Z4MR
         m3drXejC0500g==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 0/6] btrfs-progs: add encryption support
Date:   Wed, 17 Aug 2022 10:42:53 -0400
Message-Id: <cover.1660729916.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This changeset is a minimal set of changes to adapt to the kernel-side changes for encryption in [1].

While the kernel-shared files could be updated to use fscrypt_names in
closer analogue to the kernel versions of the files, that is planned as
a followup.

[1] https://lore.kernel.org/linux-btrfs/cover.1660744500.git.sweettea-kernel@dorminy.me

Sweet Tea Dorminy (6):
  btrfs-progs: add fscrypt feature flag.
  btrfs-progs: adjust for new dir flag.
  btrfs-progs: interpret encrypted file extents.
  btrfs-progs: handle fscrypt context items
  btrfs-progs: escape unprintable characters in names
  btrfs-progs: update inline extent length checking

 check/main.c               | 32 ++++++++++---------
 check/mode-common.c        |  4 +--
 check/mode-lowmem.c        |  6 ++--
 cmds/restore.c             |  2 +-
 common/fsfeatures.c        | 10 ++++++
 kernel-shared/ctree.h      | 48 +++++++++++++++++++++++++---
 kernel-shared/dir-item.c   |  8 ++---
 kernel-shared/fscrypt.h    | 32 +++++++++++++++++++
 kernel-shared/inode.c      |  4 ++-
 kernel-shared/print-tree.c | 64 +++++++++++++++++++++++++++++++++++---
 libbtrfsutil/btrfs.h       |  2 ++
 libbtrfsutil/btrfs_tree.h  |  3 ++
 12 files changed, 181 insertions(+), 34 deletions(-)
 create mode 100644 kernel-shared/fscrypt.h

-- 
2.35.1

