Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4E9602E69
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 16:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbiJRO1l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 10:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiJRO1j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 10:27:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0285EC0985
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 07:27:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B33A322DB0;
        Tue, 18 Oct 2022 14:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666103257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ce/TfxCA7s9Wa3B83obwvvhV/5qd0/6vdyKikL+NlR4=;
        b=hP0UZPhUGgXBKGW3lkKwPMfET3y72tz9UX0evanMWbxaYJvJpnKtiyq8FG95JHhsPA87kn
        B+tsCM97sUkjy3fQDp38UrGnXZxWlCbC606+TL2MqOA4OL8imyjKET1K+xUapYS6SAmHYg
        cJKYKl7t2gHfzzjuDRYFwI/oBc1juLc=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A93112C141;
        Tue, 18 Oct 2022 14:27:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 40558DA79B; Tue, 18 Oct 2022 16:27:29 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/4] Parameter cleanup
Date:   Tue, 18 Oct 2022 16:27:29 +0200
Message-Id: <cover.1666103172.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A few more cases where value passed by parameter can be used directly.

David Sterba (4):
  btrfs: sink gfp_t parameter to btrfs_backref_iter_alloc
  btrfs: sink gfp_t parameter to btrfs_qgroup_trace_extent
  btrfs: switch GFP_NOFS to GFP_KERNEL in scrub_setup_recheck_block
  btrfs: sink gfp_t parameter to alloc_scrub_sector

 fs/btrfs/backref.c    |  5 ++---
 fs/btrfs/backref.h    |  3 +--
 fs/btrfs/qgroup.c     | 17 +++++++----------
 fs/btrfs/qgroup.h     |  2 +-
 fs/btrfs/relocation.c |  2 +-
 fs/btrfs/scrub.c      | 14 +++++++-------
 fs/btrfs/tree-log.c   |  3 +--
 7 files changed, 20 insertions(+), 26 deletions(-)

-- 
2.37.3

