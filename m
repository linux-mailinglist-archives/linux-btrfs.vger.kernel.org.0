Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D746E78E3FA
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Aug 2023 02:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344966AbjHaAbH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Aug 2023 20:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344921AbjHaAbG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Aug 2023 20:31:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1634BE
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Aug 2023 17:31:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AC99621857
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Aug 2023 00:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693441855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=84UAJXz9lBNK4vrP6SWAQZ+hXMRhqjq/QZjXaUY3c7c=;
        b=O9jGlcnn9EROSD44rWs6G2KANYV9nIc9EUKpyYmwZyQxIN475HgzxduI3vdmci6DnksLf4
        4fAI93BF087OoUq9ANRzPf2LIMgJ4Il1lfpBypanD84mkdl2q+eXWRzCL3527av6WQPbv3
        +eLRQMy4L+RWJWirtd/7TXg24ccUoy4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D05713441
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Aug 2023 00:30:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id p0ZnNz7f72RcKQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Aug 2023 00:30:54 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/6]  btrfs: qgroup: remove GFP_ATOMIC usage for ulist
Date:   Thu, 31 Aug 2023 08:30:31 +0800
Message-ID: <cover.1693441298.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
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

[CHANGELOG]
v2:
- Remove the final GFP_ATOMIC ulist usage
  This is done by introducing a new list_head, btrfs_qgroup::iterator2,
  allowing us to do nested iteration.

  This extra nested facility is needed as even if we move the qgroups
  collection into one dedicated function, we're reusing the list for
  iteration which can lead to unnecessary re-visit of the same qgroup.

  Thus we have to support one level of nested iteration.

- Add reviewed by tags from Boris

[REPO]
https://github.com/adam900710/linux/tree/qgroup_mutex

Yep, the branch name shows my previous failed attempt to solve the
problem.

[PROBLEM]
There are quite some GFP_ATOMIC usage for btrfs qgroups, most of them
are for ulists.

Those ulists are just used as a temporary memory to trace the involved
qgroups.

[ENHANCEMENT]
This patchset would address the problem by adding a new list_head called
iterator for btrfs_qgroup.

And all call sites but one of ulist allocation can be migrated to use
the new qgroup_iterator facility to iterate qgroups without any memory
allocation.

The only remaining ulist call site is @qgroups ulist utilized inside
btrfs_qgroup_account_extent(), which is utilized to get all involved
qgroups for both old and new roots.

I tried to extract the qgroups collection code into a dedicate loop
out of qgroup_update_refcnt(), but it would lead to test case failure of
btrfs/028 (accounts underflow).

Thus for now only the safe part is sent to the list.

And BTW since we can skip quite some memory allocation failure handling
(since there is no memory allocation), we also save some lines of code.

Qu Wenruo (6):
  btrfs: qgroup: iterate qgroups without memory allocation for
    qgroup_reserve()
  btrfs: qgroup: use qgroup_iterator facility for
    btrfs_qgroup_free_refroot()
  btrfs: qgroup: use qgroup_iterator facility for qgroup_convert_meta()
  btrfs: qgroup: use qgroup_iterator facility for
    __qgroup_excl_accounting()
  btrfs: qgroup: use qgroup_iterator facility to replace @tmp ulist of
    qgroup_update_refcnt()
  btrfs: qgroup: use qgroup_iterator2 facility to replace @qgroups ulist
    of qgroup_update_refcnt()

 fs/btrfs/qgroup.c | 325 +++++++++++++++++-----------------------------
 fs/btrfs/qgroup.h |  12 ++
 2 files changed, 130 insertions(+), 207 deletions(-)

-- 
2.41.0

