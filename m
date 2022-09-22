Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E6F5E56EA
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 02:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiIVAG7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Sep 2022 20:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiIVAG6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Sep 2022 20:06:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6259E0F6
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Sep 2022 17:06:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5161621A78;
        Thu, 22 Sep 2022 00:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663805216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=mLPV5Te0Jo6m/QSusKS94lBDIxp8682CEhsrCSQxm+0=;
        b=l5F8z+Gf2PixuLufu6Dp3iCEL+e5HXYlAsZMAqg9wCgIXZna1cFRpMteoptodFOLGQD6Pm
        W4lauKvBTZSXwfJo5Ej53KtIO1XP1auYhq15gbM6uAk0ES5PWNeqEJt/o62/HNZz6h+xWY
        8UxTyjJWFk5ps1YEhTE7MtBW61mjUqA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A3ECE139EF;
        Thu, 22 Sep 2022 00:06:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1tprGB2nK2O1LwAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 22 Sep 2022 00:06:53 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
Subject: [PATCH 00/16] btrfs: make open_ctree() init/exit sequence strictly matched
Date:   Thu, 22 Sep 2022 08:06:17 +0800
Message-Id: <cover.1663804335.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
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

To David:

This serious is going to conflict with the regression fix on block group
tree ("btrfs: loosen the block-group-tree feature dependency check"),
please let me rebase before merging.

To Johannes:

Not 100% sure about the zoned code, thus some review/advice would be very
appreciated.

Maybe I can further extract all the zoned code into an init/exit pair?

Qu Wenruo (16):
  btrfs: make btrfs module init/exit match their sequence
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

 fs/btrfs/compression.c |   3 +-
 fs/btrfs/compression.h |   2 +-
 fs/btrfs/ctree.h       |   7 +
 fs/btrfs/disk-io.c     | 660 ++++++++++++++++++++++++++---------------
 fs/btrfs/disk-io.h     |   4 +-
 fs/btrfs/props.c       |   3 +-
 fs/btrfs/props.h       |   2 +-
 fs/btrfs/super.c       | 229 +++++++-------
 8 files changed, 557 insertions(+), 353 deletions(-)

-- 
2.37.3

