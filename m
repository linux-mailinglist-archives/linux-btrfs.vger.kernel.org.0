Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E61E56831C
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jul 2022 11:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbiGFJNb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jul 2022 05:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbiGFJMi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jul 2022 05:12:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65B726ACA
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 02:09:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62B42B818BB
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 09:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907CFC3411C
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 09:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657098591;
        bh=V7uzTiQUxL0FGGUT+TwNPO4C3Sb1DT/LyP5Ht7soHhI=;
        h=From:To:Subject:Date:From;
        b=iJjmI+dcfwMf+88IG2HPztlfzNia7MZCZO+M6OtO/quLcUFwS6UbfOPpaoYnHOZ2f
         kCAPQm5V0fzlYPyVPEuuKafGJcX7KLPL54QJxRHk6Sey/J8pn/fkA+X98GYp7/xB93
         mk/lAhzTNjKJJ4dUsYS8Ub7ykwE059UcXQjfd35c+bNvBhJjIP5JoX/dPAN5qaMz5f
         OsqBAr7Lgq8zzSMce1FW/NoqiBA2ALcj9PZxaSNbi//H/HVNykhAQXiNfjFJAJ4H/n
         Dy8BqyeGbjGXAq4iF0yhAXTpVQj/Levf0pUjMz+EgFthqVL80+rNlnSdx7LNaq25Bh
         VgJbDHdNynQkQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: fix a couple sleeps while holding a spinlock
Date:   Wed,  6 Jul 2022 10:09:44 +0100
Message-Id: <cover.1657097693.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

After the recent conversions of a couple radix trees to XArrays, we now
can end up attempting to sleep while holding a spinlock. This happens
because if xa_insert() allocates memory (using GFP_NOFS) it may need to
sleep (more likely to happen when under memory pressure). In the old
code this did not happen because we had radix_tree_preload() called
before taking the spinlocks.

Filipe Manana (3):
  btrfs: fix sleep while under a spinlock when allocating delayed inode
  btrfs: fix sleep while under a spinlock when inserting a fs root
  btrfs: free qgroup metadata without holding the fs roots lock

 fs/btrfs/ctree.h         |  6 +++---
 fs/btrfs/delayed-inode.c | 24 ++++++++++++------------
 fs/btrfs/disk-io.c       | 38 +++++++++++++++++++-------------------
 fs/btrfs/inode.c         | 30 ++++++++++++++++--------------
 fs/btrfs/relocation.c    | 11 +++++++----
 fs/btrfs/transaction.c   | 14 +++++++-------
 6 files changed, 64 insertions(+), 59 deletions(-)

-- 
2.35.1

