Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BD3798282
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 08:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbjIHGml (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 02:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbjIHGmk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 02:42:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF2B1BD8
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 23:42:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4063D2166E
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 06:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694155355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=NAfh+TG44pKj7KAIIyEStcLQOPvIbLH+Umm7jPtcBiM=;
        b=EKYEq6aRCga+jjtYYu7IkoW67emEWOcZ7XGdSrb3EHNnTyZ8piEZntilYP69GbpiZuWgj2
        +noADRWzOCUtSzdyl5t3/gY3P4JC8L9yyL/5G4ZGm2zIPAr6TOWJB6XSsaMyX4mW7+mq2p
        +tZik6998sBzkEW1dk1NScFT+rhufOc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A690E131FD
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 06:42:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id x8VzHVrC+mQZeQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Sep 2023 06:42:34 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: remove check-integrity functionality
Date:   Fri,  8 Sep 2023 14:42:13 +0800
Message-ID: <cover.1694154699.git.wqu@suse.com>
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

Check-integrity is already marked deprecated, and is going to be removed
in v6.7.

Since we're already at v6.6 cycle, let's finish the cleanup.

This patchset can be fetched from github repo, just in case some patches
are too large for the mailing list.

The removal is based on the 3 entrance functions, and the final one to
cleanup the remaining pieces.
The entrance functions removal is large, but doesn't touch other files.

The last one is the complete opposite, it touches quite some files but
nothing to do with check-integrity.[ch].

Qu Wenruo (4):
  btrfs: remove btrfsic_check_bio() function
  btrfs: remove btrfsic_mount() function
  btrfs: remove btrfsic_unmount() function
  btrfs: remove CONFIG_BTRFS_FS_CHECK_INTEGRITY macro

 fs/btrfs/Kconfig           |   21 -
 fs/btrfs/Makefile          |    1 -
 fs/btrfs/bio.c             |    5 -
 fs/btrfs/check-integrity.c | 2871 ------------------------------------
 fs/btrfs/check-integrity.h |   20 -
 fs/btrfs/dev-replace.c     |    1 -
 fs/btrfs/disk-io.c         |   50 -
 fs/btrfs/extent_io.c       |    1 -
 fs/btrfs/fs.h              |   27 +-
 fs/btrfs/scrub.c           |    1 -
 fs/btrfs/super.c           |   56 -
 11 files changed, 11 insertions(+), 3043 deletions(-)
 delete mode 100644 fs/btrfs/check-integrity.c
 delete mode 100644 fs/btrfs/check-integrity.h

-- 
2.42.0

