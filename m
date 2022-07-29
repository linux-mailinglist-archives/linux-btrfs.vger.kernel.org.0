Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FBB5854B4
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Jul 2022 19:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238031AbiG2Rro (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Jul 2022 13:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237395AbiG2Rrm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Jul 2022 13:47:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E4F78221
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Jul 2022 10:47:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CBB085BE2A;
        Fri, 29 Jul 2022 17:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659116860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=0+O/0UNcvkohrFT6XGtfZEeCy1uuczdusPSzY9rTQsI=;
        b=F1obKr0Givjj3KxofgnN95jGwDsF6d51RurlwxUHzmfAka/1UZ/7e+JGSg6qxRV4jOCSNO
        31ovNWl9WeghgYG6Xks9R/vZWG05xx4nLBYgOSfKP/Y14TUWZ+SzAZLMqVXtoUspiR08cE
        xP9CVWwws+X3/Uu+XnNO3YPnsbI8Mkw=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C28102C141;
        Fri, 29 Jul 2022 17:47:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9A64FDA85A; Fri, 29 Jul 2022 19:42:42 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2 0/4] Selectable checksum implementation
Date:   Fri, 29 Jul 2022 19:42:42 +0200
Message-Id: <cover.1659116355.git.dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a possibility to load accelerated checksum implementation after a
filesystem has been mounted. Detailed description in patch 3.

v2: rebased on misc-next

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

