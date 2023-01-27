Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE5367DD2B
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jan 2023 06:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjA0Flo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Jan 2023 00:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjA0Fll (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Jan 2023 00:41:41 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C4D728E8
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jan 2023 21:41:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B6B041FF5E
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 05:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674798096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=2gfzBv4dkax7IKm2njG+sjVrMy9tcRAzNv55ARCRF9w=;
        b=SGpF+GgTwvmbLS/D1miTmeIlaBlEy5ECl9pu70JoyC1hdrl2ovk2APhzFwvEzcq6sq0B2I
        x9KsY83wB10JnIkZXQ/fdAQbDwRu4zHHe3MXH1l+ngqWPxCDLz2HDnHJf/Vl2otU84nZU2
        ZXuCHChqnlwkrALYTLQkos84ogVSbCU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16C93134F5
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 05:41:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kQyUNA9k02OnLwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 05:41:35 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/5] btrfs-progs: minor fixes for clang warnings
Date:   Fri, 27 Jan 2023 13:41:13 +0800
Message-Id: <cover.1674797823.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Recently I'm migrating my default compiler from GCC to clang, mostly to
get short comiling time (especially important on my aarch64 machines).

Thus I hit those (mostly false alerts) warnings in btrfs-progs, and come
up with this patchset.

Unfortunately there is still libbtrfsutils causing warnings in
setuptools, as it's still using the default flags from gcc no matter
what.

Qu Wenruo (5):
  btrfs-progs: remove an unnecessary branch to silent the clang warning
  btrfs-progs: fix a false alert on an uninitialized variable when
    BUG_ON() is involved.
  btrfs-progs: fix fallthrough cases with proper attributes
  btrfs-progs: move a union with variable sized type to the end
  btrfs-progs: fix set but not used variables

 cmds/reflink.c              |  2 +-
 cmds/scrub.c                | 12 +++---
 common/format-output.c      |  2 +-
 common/parse-utils.c        | 12 +++---
 common/units.c              |  6 +--
 crypto/xxhash.c             | 73 +++++++++++++++++++------------------
 image/main.c                | 15 +++-----
 kerncompat.h                |  8 ++++
 kernel-shared/ctree.c       | 18 +++++----
 kernel-shared/extent-tree.c |  4 +-
 kernel-shared/print-tree.c  |  2 +-
 kernel-shared/volumes.c     |  3 +-
 kernel-shared/zoned.c       |  6 +--
 mkfs/main.c                 |  4 --
 14 files changed, 84 insertions(+), 83 deletions(-)

-- 
2.39.1

