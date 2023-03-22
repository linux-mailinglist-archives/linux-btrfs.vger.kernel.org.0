Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FF66C4795
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Mar 2023 11:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjCVK1s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Mar 2023 06:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjCVK1o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Mar 2023 06:27:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CED760D68
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 03:27:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AC29520C6C
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 10:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679480843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=sllq+v05JhcYygqJWx6y68B2NyXrHnYMJsuu/be8WpE=;
        b=abwAVKMmsFKYhAPYZ3yGN171LII3bRVZr0a8yJ0XROIsu5YvQKf3f1+y/lDPYKUlpppFnt
        tgr3v+xKRVdjcutEr3lPJ3QT0txg9vFm2d9OUjPmSYOR+TKX2/6R56YmoOCqkOvMiieohw
        pbkR75mQ00nb7xbHHSC7flYBUFqywrE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 19DEB138E9
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 10:27:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6pN5NgrYGmRyEgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 10:27:22 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: convert: follow default v2 cache setting
Date:   Wed, 22 Mar 2023 18:27:03 +0800
Message-Id: <cover.1679480445.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Although btrfs-convert has followed the new default setting in v5.15
release, it doesn't work.

The problem is the convert workflow itself (making an temporary btrfs
first, then sync the inodes) doesn't really create the free space tree
nor the needed super block flags.

And during the inodes sync phase, we generate v1 cache, causing the
result btrfs to be v1 cache populated, and cause test case failure for
subpage testing.


This patchset would fix the converted btrfs at the final stage, by
clearing the existing v1 cache first, then create and populate a valid
free space tree, with needed super block flags.


There seems to be a behavior change in mkfs.ext4 (e2fsprogs 1.47),
that would create an orphan inode (with fixed ino number 12), and
btrfs-convert would follow the ext4 to create an orphan in btrfs too,
causing btrfs check to complain.

So for now, I can not do convert testing due to the newly updated
e2fsprogs...

Qu Wenruo (2):
  btrfs-progs: make check/clear-cache.c to be separate from check/main.c
  btrfs-progs: convert: follow the default free space tree setting

 Makefile            |  2 +-
 check/clear-cache.c | 84 ++++++++++++++++++++++++---------------------
 check/clear-cache.h |  8 +++--
 check/main.c        |  6 ++--
 convert/main.c      | 23 +++++++++++++
 5 files changed, 76 insertions(+), 47 deletions(-)

-- 
2.39.2

