Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885EB543EBB
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 23:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiFHVkd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 17:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236225AbiFHVkb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 17:40:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D562B45A5
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 14:40:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 508021FD42;
        Wed,  8 Jun 2022 21:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654724427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ZSj8d7WZNhGNVWQfU3VoVriUBT3cSK9jYrkpKaMp1zo=;
        b=jQHwiBWzMp9DqJCTsBincKKnijHiBU3KuV26q1DRVh1wOPT2czgGD0awURxVO0E/fQmBJf
        kAOAzMlf/zmlxYZJ46/lh2SBUyzdPdi1BRCtvmifoMvxGHlF7rEGe7AXKzqox2JEMPzLpC
        D/3rqwwe7wC805rUQbm16cVZCgU+9Ic=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 467532C141;
        Wed,  8 Jun 2022 21:40:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 47F99DA883; Wed,  8 Jun 2022 23:35:57 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/4] Remove indirect iterators for inode references
Date:   Wed,  8 Jun 2022 23:35:57 +0200
Message-Id: <cover.1654723641.git.dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's support for a generic iterator over inode references that is for
example used to resolve inode number to all paths but there's only one
such iterator implementation so it's not necessary, unless somebody has
an idea for more such iterators. There is a similar pattern used for
extent iterator utilizing the indirection, but I think we can remove it
for the inode refs.

David Sterba (4):
  btrfs: call inode_to_path directly and drop indirection
  btrfs: simplify parameters of backref iterators
  btrfs: sink iterator parameter to btrfs_ioctl_logical_to_ino
  btrfs: remove unused typedefs get_extent_t and btrfs_work_func_t

 fs/btrfs/async-thread.h |  1 -
 fs/btrfs/backref.c      | 88 +++++++++++++++++++++++------------------
 fs/btrfs/backref.h      |  3 +-
 fs/btrfs/extent_io.h    |  4 --
 fs/btrfs/ioctl.c        | 22 +----------
 5 files changed, 51 insertions(+), 67 deletions(-)

-- 
2.36.1

