Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4188783AB3
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Aug 2023 09:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjHVHRM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Aug 2023 03:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjHVHRF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Aug 2023 03:17:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2964F10DC
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Aug 2023 00:16:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ED721200EB
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Aug 2023 07:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692688522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=IRfwz1PiNmZq/dsiHBFHSXTqXonuwRtsw4kszItpqIo=;
        b=ejcclYDmKDYOpWVWlZCCfCzEwWuXEGqcG3E7VztKauNAFYrBr1cKrUbQ8Gq8Res1Moglhx
        7XASXAeJBWYsHFw8S2AOytCsg1t+w4g3QuJvd3FKmOskzCGiQqGZ2Aur5IKOgLXxpk+t41
        ClZxlMT/Ryr4qNQIOLlkiOI5f19dOxM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4F5B013919
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Aug 2023 07:15:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Vai8Bopg5GSDTwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Aug 2023 07:15:22 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: rely on "btrfstune --csum" to replace "btrfs check --init-csum-tree"
Date:   Tue, 22 Aug 2023 15:15:16 +0800
Message-ID: <cover.1692688214.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_PASS,
        T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We had a report that "btrfs check --init-csum-tree" corrupted a
seemingly fine btrfs (which can originally pass "btrfs check
--readonly").

The root cause is in how we rebuild the csum tree, in the btrfs check
code, we screw up the csum tree root, then rely on the extent tree
repair code to finish the damage we introduced.

This can lead to unexpected corner cases, if the fs is already fine,
there is no need for such risky move.

Considering there are valid ways to cause data csum mismatch (mostly
O_DIRECT and modifying the buffer when it's still under writeback), some
users expect to use "btrfs check --init-csum-tree" to fix the csum
mismatch, which can lead to the same corruption.

Instead this patchset would recommend the end users to go "btrfstune
--csum", as it is way less risky by its design, and no more damage to
the fs caused by ourselves.

I hope we can completely go that direction when the "btrfstune --csum"
option is moved out of experimental features.

Qu Wenruo (2):
  btrfs-progs: tune: allow --csum to rebuild csum tree
  btrfs-progs: check: add advice to avoid --init-csum-tree

 check/main.c       |  9 +++++++++
 tune/change-csum.c | 35 +++++++++++++++++++++++++----------
 tune/main.c        |  3 ++-
 3 files changed, 36 insertions(+), 11 deletions(-)

--
2.41.0

