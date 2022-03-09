Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79A74D3077
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 14:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbiCINwG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 08:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbiCINwG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 08:52:06 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2E217C417
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 05:51:04 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0C46C1F381;
        Wed,  9 Mar 2022 13:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646833863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WterRU+SR6Fh/oyRWgEh/v+xbVaYhfNNdmNIBPo0gjM=;
        b=RVfAjDA90xHAeCIna5bnvIdXZQtqWzJx0/TvdoaY+KaUSS7XY8tO1rYitDLwNVH6UEMp3n
        2doMeGw2ECG7UuXs0cPEpXhN+2+vkoRumhPQludd6FkOhuGGKTVdPsezt9IkBMPmhRCDlk
        sS0U4haRdSIXNdPZ9kwrF8QPnCWUTE0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6B5F13D7A;
        Wed,  9 Mar 2022 13:51:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TTnHMsawKGL1LQAAMHmgww
        (envelope-from <gniebler@suse.com>); Wed, 09 Mar 2022 13:51:02 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Gabriel Niebler <gniebler@suse.com>
Subject: [PATCH v4 0/14] btrfs: Introduce macro to iterate over slots
Date:   Wed,  9 Mar 2022 14:50:37 +0100
Message-Id: <20220309135051.5738-1-gniebler@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Changes from v3:
 * Surround arguments with (…) in iterator macro definition (David)
 * Fix btrfs_unlink_all_paths after key/found_key confusion broke btrfs/168
   (Josef)
 * Various stylistic improvements (David)
 
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
 fs/btrfs/ctree.c       |  35 ++++++++
 fs/btrfs/ctree.h       |  25 ++++++
 fs/btrfs/dev-replace.c |  40 ++-------
 fs/btrfs/dir-item.c    |  31 ++-----
 fs/btrfs/inode.c       |  35 +++-----
 fs/btrfs/send.c        | 229 +++++++++++++------------------------------------
 fs/btrfs/volumes.c     |  25 ++----
 fs/btrfs/xattr.c       |  40 +++------
 9 files changed, 167 insertions(+), 319 deletions(-)
