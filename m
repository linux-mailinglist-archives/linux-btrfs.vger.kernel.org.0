Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4D74CAAC5
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 17:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243525AbiCBQuw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Mar 2022 11:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243527AbiCBQuv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 11:50:51 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCEDCF382
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Mar 2022 08:50:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 90FF91F37E;
        Wed,  2 Mar 2022 16:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646239806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Cyxic+7R8ouNPfGJ2HaOmV2Bvbq4Wfx1Onnf7rnNfd0=;
        b=VuS2/I6bLsNOb7asHwghnPAwzLe8W1uHm5wszXHmbYZGC9/6U2aNcFxmIlkajEcoIgu0wE
        KZnDhL7WvkV1/aX/OYTu2883bhuFyc3ZZov9f2HK6TFde4Odzo57phac4+/cFO+nrwrB0i
        gL7XpXXeDIRN11aaq6r8txV+9RGx+7s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6778E13A93;
        Wed,  2 Mar 2022 16:50:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sVkGFz6gH2LdOwAAMHmgww
        (envelope-from <gniebler@suse.com>); Wed, 02 Mar 2022 16:50:06 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Gabriel Niebler <gniebler@suse.com>
Subject: [PATCH v3 0/14] btrfs: Introduce macro to iterate over slots
Date:   Wed,  2 Mar 2022 17:48:15 +0100
Message-Id: <20220302164829.17524-1-gniebler@suse.com>
X-Mailer: git-send-email 2.35.1
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

There is a common pattern when searching for a key in btrfs:

* Call btrfs_search_slot to find the slot for the key
* Enter an endless loop:
	* If the found slot is larger than the no. of items in the current leaf,
	  check the next leaf
	* If it's still not found in the next leaf, terminate the loop
	* Otherwise do something with the found key
	* Increment the current slot and continue

To reduce code duplication, we can replace this code pattern with an iterator
macro, similar to the existing for_each_X macros found elsewhere in the kernel.
This also makes the code easier to understand for newcomers by putting a name
to the encapsulated functionality.

This patchset survived a complete fstest run.

Changes from v2:
 * Rename btrfs_valid_slot to btrfs_get_next_valid_item (Nikolay)
 * Fix comment formatting (David)
 * Remove redundant parentheses and indentation in loop condition (David)
 * Remove redundant iter_ret var and reuse ret instead (Nikolay)
 * Make termination condition more consistent in btrfs_unlink_all_paths
   (Nikolay)
 * Improved patch organisation by splitting into one patch per function (David)
 * Improve doc comment for btrfs_get_next_valid_item (Gabriel)
 * Remove `out` label and assoc. gotos from id_create_dir (Gabriel)
 * Initialise `ret` in process_all_refs and process_all_new_xattrs (Gabriel)
 * Remove unneeded btrfs_item_key_to_cpu call from loop body in
   btrfs_read_chunk_tree (Gabriel)

Changes from v1:
 * Separate xattr changes from the macro introducing code (Johannes)

Changes from RFC:
 * Add documentation to btrfs_for_each_slot macro and btrfs_valid_slot function
   (David)
 * Add documentation about the ret variable used as a macro argument (David)
 * Match function argument from prototype and implementation (David)
 * Changed ({ }) block to only () in btrfs_for_each_slot macro (David)
 * Add more patches to show the code being reduced by using this approach
   (Nikolay)

Marcos Paulo de Souza (14):
  btrfs: Introduce btrfs_for_each_slot iterator macro
  btrfs: Use btrfs_for_each_slot in find_first_block_group
  btrfs: Use btrfs_for_each_slot in mark_block_group_to_copy
  btrfs: Use btrfs_for_each_slot in btrfs_search_dir_index_item
  btrfs: Use btrfs_for_each_slot in btrfs_real_readdir
  btrfs: Use btrfs_for_each_slot in did_create_dir
  btrfs: Use btrfs_for_each_slot in can_rmdir
  btrfs: Use btrfs_for_each_slot in is_ancestor
  btrfs: Use btrfs_for_each_slot in process_all_refs
  btrfs: Use btrfs_for_each_slot in process_all_new_xattrs
  btrfs: Use btrfs_for_each_slot in process_all_extents
  btrfs: Use btrfs_for_each_slot in btrfs_unlink_all_paths
  btrfs: Use btrfs_for_each_slot in btrfs_read_chunk_tree
  btrfs: Use btrfs_for_each_slot in btrfs_listxattr

 fs/btrfs/block-group.c |  26 +-----
 fs/btrfs/ctree.c       |  33 +++++++
 fs/btrfs/ctree.h       |  24 ++++++
 fs/btrfs/dev-replace.c |  41 ++-------
 fs/btrfs/dir-item.c    |  31 ++-----
 fs/btrfs/inode.c       |  35 +++-----
 fs/btrfs/send.c        | 229 ++++++++++++++-----------------------------------
 fs/btrfs/volumes.c     |  26 ++----
 fs/btrfs/xattr.c       |  41 +++------
 9 files changed, 168 insertions(+), 318 deletions(-)
