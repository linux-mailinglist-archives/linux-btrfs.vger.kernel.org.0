Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A687065FC
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 May 2023 13:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjEQLDn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 May 2023 07:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjEQLDm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 May 2023 07:03:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5528C26AA
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 04:03:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D715C6358E
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 11:02:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEAAC433D2
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 11:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684321346;
        bh=pH9KI0+psvP3k3zMfK/8mL6301r+klr61NxWVXceaNg=;
        h=From:To:Subject:Date:From;
        b=krajRhuFFHXYZO8FBO8cVqQXrDows89JRyxp6kk9r22qAOhzb4R6H/NeeQazlDIdK
         MlGYwSP5ASfHQjCnfu61j9F9Vos+YZjnb7pvusYwhkZz+h4u0XD9fnZJH65lyL5r3P
         1NVYdMca2iuxVAn5hXQrocEcyTpyfqdxhL3ZaUCSgwtb8iDXck4463hFm1aquep4JZ
         9wJ87yiqOzVkLA2uV9BjaQshOEmhrxdcoRO7QZyRkscaJWq4skhvyhzQUUOX3sDPhA
         Os8L1ADOxQVwZe2VAC7Cp+5qxSQAlhpoZiCcAKC8tapi9mMjAtubkdc9UHKdRy188F
         KODazHzDJ5XnQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/5] btrfs: some minor log tree updates
Date:   Wed, 17 May 2023 12:02:11 +0100
Message-Id: <cover.1684320689.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Add two optimizations to avoid falling back to transaction commits after
an inode is evicted and some cleanups. More details on the changelogs.

Filipe Manana (5):
  btrfs: use inode_logged() at need_log_inode()
  btrfs: use inode_logged() at btrfs_record_unlink_dir()
  btrfs: update comments at btrfs_record_unlink_dir() to be more clear
  btrfs: remove pointless label and goto at btrfs_record_unlink_dir()
  btrfs: change for_rename argument of btrfs_record_unlink_dir() to bool

 fs/btrfs/inode.c    |  8 ++++----
 fs/btrfs/tree-log.c | 34 +++++++++++++++++-----------------
 fs/btrfs/tree-log.h |  2 +-
 3 files changed, 22 insertions(+), 22 deletions(-)

-- 
2.34.1

