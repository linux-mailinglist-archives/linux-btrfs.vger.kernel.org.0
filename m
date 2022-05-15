Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355F0527729
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 May 2022 12:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbiEOKzX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 May 2022 06:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbiEOKzW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 May 2022 06:55:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1731573F
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 03:55:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DDBEF1F8A3
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 10:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652612118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=e6Msa0Un3G8MuWNqDe7zey6Q2PNMNby5uWLlDeLdxqY=;
        b=UVG1HdsktsjJt8qh61EMNoidNGO/f1+Gmxkb3rU0n+pR8ihCcLrmfmIdoGawXQDrpiDlqK
        pnt3T8nmyBdNyDzmgZxErHJf+NfcnvUhuE742tfsaCNryOfgH9NIiYQ8mAmraenneMZzx9
        x8hJcMtlJwV3MXL+xjSfSTYzL7Djfrw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3DBBF13491
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 10:55:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Iw5pAhbcgGLsfQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 10:55:18 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/5] btrfs-progs: almost full support for RAID56J profiles
Date:   Sun, 15 May 2022 18:54:55 +0800
Message-Id: <cover.1652611957.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is the progs companion for the new RAID56J profiles.

Unlike kernel part, progs doesn't really need to implement the full
journal, thus the following basic features should be enough:

- Mkfs support
- Check support (both original and lowmem mode)
- Print tree support

The final patch is a fix for a leakage of path which is exposed during
kernel development.

Qu Wenruo (5):
  btrfs-progs: introduce the basic support for RAID56J feature
  btrfs-progs: mkfs: add support for RAID56J creation
  btrfs-progs: check: take per device reservation into consideration
  btrfs-progs: print-tree: add support for per_dev_reserved of chunk
    item
  btrfs-progs: check/lowmem: fix path leakage when dev extents are
    invalid

 check/common.h              |   7 ++-
 check/main.c                |  16 ++++--
 check/mode-lowmem.c         |  17 ++++--
 cmds/filesystem-usage.c     |   6 ++-
 cmds/rescue-chunk-recover.c |  13 +++--
 common/fsfeatures.c         |   9 ++++
 common/utils.c              |   6 ++-
 kernel-shared/ctree.h       |  42 +++++++++++++--
 kernel-shared/extent-tree.c |  18 +++++--
 kernel-shared/print-tree.c  |   5 +-
 kernel-shared/volumes.c     | 105 +++++++++++++++++++++++++++++++-----
 kernel-shared/volumes.h     |   2 +
 mkfs/main.c                 |   3 ++
 13 files changed, 205 insertions(+), 44 deletions(-)

-- 
2.36.1

