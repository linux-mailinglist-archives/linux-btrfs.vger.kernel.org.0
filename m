Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C76585207
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Jul 2022 17:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbiG2PEJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Jul 2022 11:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236674AbiG2PEI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Jul 2022 11:04:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCD180F5E
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Jul 2022 08:04:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 02BED344AE;
        Fri, 29 Jul 2022 15:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659107045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=l/ecFDtdKWmYt+L0KYdaqg1WEcF42w+mw2Aktwu0+FQ=;
        b=qYvV9cchgkKXvs8MQzCq4Y7ivRXWWkKhZlOtnVmPyCY3tO59hlpjtQT547a6jhxyCRkPpw
        7YXgcJTcireiIqlI0oDGGeoEACqfmWMf2n7so4ddSZOmoRaxfy8GP4A+oEtGogVwPejBKz
        EyU73K9OAA0BnJ4T4DbdYooyZnMjopU=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id EE8722C141;
        Fri, 29 Jul 2022 15:04:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B2004DA85A; Fri, 29 Jul 2022 16:59:06 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/4] Selectable checksum implementation
Date:   Fri, 29 Jul 2022 16:59:06 +0200
Message-Id: <cover.1659106597.git.dsterba@suse.com>
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

David Sterba (4):
  btrfs: prepare more slots for checksum shash
  btrfs: assign checksum shash slots on init
  btrfs: add checksum implementation selection after mount
  btrfs: sysfs: print all loaded csums implementations

 fs/btrfs/check-integrity.c |   4 +-
 fs/btrfs/compression.c     |   4 +-
 fs/btrfs/ctree.h           |  13 ++++-
 fs/btrfs/disk-io.c         |  30 +++++++----
 fs/btrfs/file-item.c       |   4 +-
 fs/btrfs/inode.c           |   4 +-
 fs/btrfs/scrub.c           |  12 ++---
 fs/btrfs/super.c           |   2 -
 fs/btrfs/sysfs.c           | 101 +++++++++++++++++++++++++++++++++++--
 9 files changed, 144 insertions(+), 30 deletions(-)

-- 
2.36.1

