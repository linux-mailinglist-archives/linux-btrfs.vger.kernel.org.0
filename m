Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE965FC2BA
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Oct 2022 11:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiJLJNd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Oct 2022 05:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJLJNc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Oct 2022 05:13:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81002140F0
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 02:13:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 163741F381
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665566009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=wkBEWoQduLn67TyxVs3VyJb48Avin5W7hzfbU/3wYZ8=;
        b=PHw0BQowozGhoCi8OXtsdZMM7gVsMU2Sv312HUXEQ62BmbrSLXODUbjD2T1pACL+goehkh
        XidELi2MRs7+hPPDXkklBztX1FcLzRt5mbaYkBQaaK7vm4iUZo+j1g6rNW8qATY2vho4QY
        8sE+VnJ5ViabAc4x0jjmHR6HhD5hpwQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6529D13A5C
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FVDvCziFRmPKcQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:28 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 00/15] btrfs: make open_ctree() init/exit sequence strictly matched
Date:   Wed, 12 Oct 2022 17:12:56 +0800
Message-Id: <cover.1665565866.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[Changelog]
v2:
- Rebased to latest misc-next
  Most conflicts comes from the new function btrfs_check_features().


Just like init_btrfs_fs(), open_ctree() also has tons of different
labels for its error handling.

And unsurprisingly the error handling labels are not matched correctly,
e.g. we always call btrfs_mapping_tree_free() even we didn't reach
sys chunk array read.

And every time we need to add some new function, it will be a disaster
just to understand where the new function should be put and how the
error handling should be done.

This patchset will follow the init_btrfs_fs() method, by introducing
an open_ctree_seq[] array, which contains the following sections:

- btree_inode init/exit
- super block read and verification
- mount options and features check
- workqueues init/exit
- chunk tree init/exit
- tree roots init/exit
- mount time check and various item load
- sysfs init/exit
- block group tree init/exit
- subvolume trees init/exit
- kthread init/exit
- qgroup init/exit

The remaining part of open_ctree() is only less than 50 lines, and are
all related to the very end of the mount progress, including log-replay,
uuid tree check.

Also to do better testing, for DEBUG build there will be a new mount
option, "fail_mount=%u" to allow open_ctree() to fail at certain stage
of open_ctree_seq[].

Unfortunately since that mount option can only be parsed in
open_ctree_features_init(), this means we can only fail after stage 2.
But this should still provide much better testing coverage.

Qu Wenruo (15):
  btrfs: initialize fs_info->sb at the very beginning of open_ctree()
  btrfs: remove @fs_devices argument from open_ctree()
  btrfs: extract btree inode init code into its own init/exit helpers
  btrfs: extract super block read code into its own init helper
  btrfs: extract mount options and features init code into its own init
    helper
  btrfs: move btrfs_init_workqueus() and btrfs_stop_all_workers() into
    open_ctree_seq[]
  btrfs: extract chunk tree read code into its own init/exit helpers
  btrfs: extract tree roots and zone info initialization into init/exit
    helpers
  btrfs: extract mount time checks and items load code into its init
    helper
  btrfs: extract sysfs init into its own helper
  btrfs: extra block groups read code into its own init/exit helpers
  btrfs: move the fs root related code into its own init/exit helpers
  btrfs: extract kthread code into its own init/exit helpers
  btrfs: move qgroup init/exit code into open_ctree_seq[] array
  btrfs: introduce a debug mount option to do error injection for each
    stage of open_ctree()

 fs/btrfs/ctree.h   |   7 +
 fs/btrfs/disk-io.c | 611 +++++++++++++++++++++++++++++----------------
 fs/btrfs/disk-io.h |   4 +-
 fs/btrfs/super.c   |  18 +-
 4 files changed, 418 insertions(+), 222 deletions(-)

-- 
2.37.3

