Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1FC6DCFB9
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Apr 2023 04:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjDKCb2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Apr 2023 22:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDKCb2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Apr 2023 22:31:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D671982
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Apr 2023 19:31:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B61391FDBC
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 02:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681180284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=dLhG+TthDM5XyefUIaO5bT5IvmJ0Ez00gvoVB6McIms=;
        b=Tq/zSYD85TUzSU4vDcCBJyC4jVl33XTmzBEQiCB7x0XojgBsbiM/O68wJeGztCc3CvP9Mb
        ElYlVQvU3K4DKXhf8oz5qno6kueUMcGJscZAZ7d85BiOjo/eJbsvQ/xNBOF5PdTpXZpWU7
        1jaf5YDkU1QCO5FWE6gOpAuNbSkGddc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1DBF513638
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 02:31:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UfyLN3vGNGRWDgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 02:31:23 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: move block-group-tree out of experimental features
Date:   Tue, 11 Apr 2023 10:31:04 +0800
Message-Id: <cover.1681180159.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

People are complaining block-group-tree features are not accessible for
non-experimental builds.

So let's make it a stable feature.

Since we're here, it's also a good time to deprecate
-R|--runtime-features option.

Qu Wenruo (2):
  btrfs-progs: mkfs: make -R|--runtime-features option deprecated
  btrfs-progs: move block-group-tree out of experimental features

 Documentation/btrfs-man5.rst |  6 ++++++
 Documentation/btrfstune.rst  |  4 ++--
 Documentation/mkfs.btrfs.rst | 30 +++++++++---------------------
 common/fsfeatures.c          |  8 --------
 mkfs/main.c                  |  3 ++-
 tune/main.c                  | 18 ++++++++----------
 6 files changed, 27 insertions(+), 42 deletions(-)

-- 
2.39.2

