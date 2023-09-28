Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63027B1167
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 06:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjI1EG5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Sep 2023 00:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjI1EG4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Sep 2023 00:06:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0D210A
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 21:06:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4F24F1F88F
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Sep 2023 04:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695874013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=thjVCnu/oDmqvcwHUkO/5yYMeMOjCogIMnHKGFFgvK8=;
        b=JbJBB5SXVbkEV3J8jX6Bwwj6Hd6vShwKwH067orB/5wEo1vkfBp8+Z4xbRA5BhlvMQvBSZ
        XjANYNjCm6i2bw1IEK9zbviHJoeybUfddWIG8/Qr5GeqtBf3q6kR+hbYU2gNfb0Hyjs/yS
        CI6u+3JLRNBXeXXx2MNVGv5tBNJ3zOs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E3CC1377A
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Sep 2023 04:06:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zCQ7ENz7FGX1RQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Sep 2023 04:06:52 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: -Wshadow fixes
Date:   Thu, 28 Sep 2023 13:36:32 +0930
Message-ID: <cover.1695873867.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since -Wshadow is enabled recently, there are two new warnings:

- @e from cmd_inspect_list_chunks()
- @csum from print_header_info()
  This needs experimental features to be enabled

Just fix them all.

Qu Wenruo (2):
  btrfs-progs: remove variable e from cmd_inspect_list_chunks()
  btrfs-progs: fix a variable shadowing when enabling experimental
    features

 cmds/inspect.c             | 4 +---
 kernel-shared/print-tree.c | 4 ++--
 2 files changed, 3 insertions(+), 5 deletions(-)

--
2.42.0

