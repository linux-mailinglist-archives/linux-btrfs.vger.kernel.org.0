Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440826F0595
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Apr 2023 14:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243518AbjD0MRQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Apr 2023 08:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243386AbjD0MRP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Apr 2023 08:17:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9BD527B
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 05:16:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8D63621B01
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 12:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682597806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ZWXJUzFh0vZrCqw4fxzvyw6P6ywunEnwh0njR05Ha2o=;
        b=cm94rkmD9iCeLR2cE9KOWP37UXAMrrpYWyZV4OUCm2MCe9wPDto6s9SxBbDtxypV6VhHJD
        7D5zZnqKHFJDK8iakXXQQf23AJGFTk0WUiUmbWhVhlQeBagYibaNhapZHgrD6CatpJ+CC3
        M+BjCdVSLzJDH4EHvef6BdMiFi1fG9I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F20F513910
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 12:16:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pffVL61nSmQOUAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 12:16:45 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: small improvement to leaf dump
Date:   Thu, 27 Apr 2023 20:16:26 +0800
Message-Id: <cover.1682597619.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The first patch is just constify the tree dump infrastructure, exposed
during the development.

The second patch is the main dish, inspired by a report that turns out
to be bitflip in extent tree.
However the leaf dump in dmesg is pretty large (100+ slots), needs to
manually search the leaf using the bytenr from the error messages.

Thus if we can output the slot number, it would be much easier to locate
the problem, just like what we did in tree-checker.

Qu Wenruo (2):
  btrfs: print-tree: accept const extent buffer pointer
  btrfs: improve leaf dump and error handling

 fs/btrfs/ctree.c       |   8 +--
 fs/btrfs/ctree.h       |   2 +-
 fs/btrfs/extent-tree.c | 125 +++++++++++++++++++----------------------
 fs/btrfs/print-tree.c  |  16 +++---
 fs/btrfs/print-tree.h  |   4 +-
 5 files changed, 73 insertions(+), 82 deletions(-)

-- 
2.39.2

