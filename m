Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457D1587C78
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 14:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbiHBMd0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 08:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiHBMd0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 08:33:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364013334F
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 05:33:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6514D37394;
        Tue,  2 Aug 2022 12:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659443600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xu0gcEiYZv7o6c1yGul2CF5XxHTuiGk5QJ9VsXzff80=;
        b=Jvb8XD7VpQOx3dWGw1LnhVZMjKD5FpuUBN3q4qqNBpFIXQSJzqWsRJ9pfgzPG1a53sCZUx
        GpVaTOUdJxRoOO2bYoYRH9K3sQPxn82gml6FfeBUVUHRDtz8nHYMYJJfroBgidJnPyKTvc
        cmdYlWD1mYzo2Zxci4qhv2+gbgndQpQ=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5832C2C141;
        Tue,  2 Aug 2022 12:33:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D9E7DDA85A; Tue,  2 Aug 2022 14:28:19 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2 0/4] Selectable checksum implementation
Date:   Tue,  2 Aug 2022 14:28:19 +0200
Message-Id: <cover.1659443199.git.dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a possibility to load accelerated checksum implementation after a
filesystem has been mounted. Detailed description in patch 3.

v2:
- fix initialization of default slot

David Sterba (4):
  btrfs: prepare more slots for checksum shash
  btrfs: assign checksum shash slots on init
  btrfs: add checksum implementation selection after mount
  btrfs: sysfs: print all loaded csums implementations

 fs/btrfs/check-integrity.c |   4 +-
 fs/btrfs/ctree.h           |  13 ++++-
 fs/btrfs/disk-io.c         |  30 +++++++----
 fs/btrfs/file-item.c       |   4 +-
 fs/btrfs/inode.c           |   2 +-
 fs/btrfs/scrub.c           |  12 ++---
 fs/btrfs/super.c           |   2 -
 fs/btrfs/sysfs.c           | 101 +++++++++++++++++++++++++++++++++++--
 8 files changed, 141 insertions(+), 27 deletions(-)

-- 
2.36.1

