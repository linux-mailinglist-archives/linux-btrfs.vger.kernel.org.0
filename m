Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFCA7AF34B
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 20:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbjIZSvE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 14:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235601AbjIZSvC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 14:51:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C10EB
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 11:50:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A8A102185F;
        Tue, 26 Sep 2023 18:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695754253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=mKva6kf762UygOCJigAsGFuZqTx/siMN1jpWK4seLgc=;
        b=qyUNvgw0dOJ2pc1TICXRhn/TuwODPJswWQybOI/AzNamQfnnmdyt3874D72Geq2J6FBn7h
        kqZuEBsRc+ScyvwzzL2bDd2TW3kYphvjYKgRPzgsiJATGHn5RusRdNk/b/JJWygaKzgltS
        QeZCuDFWmNsEkkCw5Q7TiPrPv2hwfqc=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 80FB72C143;
        Tue, 26 Sep 2023 18:50:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 189A4DA832; Tue, 26 Sep 2023 20:44:15 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/2] Speed up test_range_bit()
Date:   Tue, 26 Sep 2023 20:44:15 +0200
Message-ID: <cover.1695753339.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
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

Split test_range_bit() to two helpers according to what callers need,
slightly improving the loops by avoiding conditionals.

David Sterba (2):
  btrfs: add specific helper for range bit test exists
  btrfs: change test_range_bit to scan the whole range

 fs/btrfs/defrag.c         |  4 +--
 fs/btrfs/extent-io-tree.c | 65 +++++++++++++++++++++++++++++----------
 fs/btrfs/extent-io-tree.h |  5 +--
 fs/btrfs/extent_io.c      | 10 +++---
 fs/btrfs/inode.c          |  8 ++---
 fs/btrfs/relocation.c     |  2 +-
 6 files changed, 62 insertions(+), 32 deletions(-)

-- 
2.41.0

