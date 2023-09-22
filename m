Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C6C7AB04A
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 13:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbjIVLNz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 07:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjIVLNx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 07:13:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C75FB
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 04:13:47 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6254621A56;
        Fri, 22 Sep 2023 11:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695381226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Ee0anq1GhWGWYxsR/S6XGGnTNIjWDiUgqxxvYrJN1DY=;
        b=KDPk2qpSyc0Ut8bpdnEKmE9pbiGP0ltJ3WZV//Umt1zxzc/IT+6bXRIl3qzbT+CCBXaWYd
        2lf6Q9SLj7Ssqsqozp7wl/xXWzwAHS0bQIeQ3SlUNieyLQTYPAmVXf4VGI9Mg59FB0f4Ni
        vEbzXpWeOP0qAiFPQb8XXwwjvGgplLk=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 476F52C142;
        Fri, 22 Sep 2023 11:13:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 44A15DA832; Fri, 22 Sep 2023 13:07:12 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/8] Minor cleanups in relocation.c
Date:   Fri, 22 Sep 2023 13:07:12 +0200
Message-ID: <cover.1695380646.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Various type cleanups in relocation.c, on-stack variable to replace
frequent allocation in build_backref_tree().

David Sterba (8):
  btrfs: relocation: use more natural types for tree_block bitfields
  btrfs: relocation: use enum for stages
  btrfs: relocation: switch bitfields to bool in reloc_control
  btrfs: relocation: open code mapping_tree_init
  btrfs: switch btrfs_backref_cache::is_reloc to bool
  btrfs: relocation: return bool from btrfs_should_ignore_reloc_root
  btrfs: relocation: use on-stack iterator in build_backref_tree
  btrfs: relocation: constify parameters where possible

 fs/btrfs/backref.c    |  28 ++++-----
 fs/btrfs/backref.h    |  15 ++---
 fs/btrfs/relocation.c | 139 ++++++++++++++++++++----------------------
 fs/btrfs/relocation.h |   9 +--
 4 files changed, 87 insertions(+), 104 deletions(-)

-- 
2.41.0

