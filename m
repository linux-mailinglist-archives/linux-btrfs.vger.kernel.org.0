Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA81179046C
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Sep 2023 02:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239105AbjIBAOX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Sep 2023 20:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjIBAOW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Sep 2023 20:14:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF591A8
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Sep 2023 17:14:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 088DE21865
        for <linux-btrfs@vger.kernel.org>; Sat,  2 Sep 2023 00:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693613658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=j1HYLlUs0Sg2CvHZGa74JoinwTj5uLCKQhTJ5T7F1LY=;
        b=pZla0ve2QBAp8jNomTcCATaS61ZAxtMnxBzryHS2uAq28B59HwOqFTf5uN33Bsytb0tovy
        LLWKc2xankXI4bDWreJwkaTONkqZc7gdYHj5orh3ON34bzVqWimRHrzeEPh6ztw05WZSuz
        cSZmQ4yTetGpno6G2ZUdn2IKzZMLbKU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4DC2B13587
        for <linux-btrfs@vger.kernel.org>; Sat,  2 Sep 2023 00:14:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CPYFI1h+8mSzUgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 02 Sep 2023 00:14:16 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/6] btrfs: qgroup: remove GFP_ATOMIC usage for ulist
Date:   Sat,  2 Sep 2023 08:13:51 +0800
Message-ID: <cover.1693613265.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
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

[CHANGELOG]
v3:
- Remove the no longer utilized memalloc_nofs_save() calls
- Remove the "@" prefix of variables in the subject line
- Rename iterator2 to nested_iterator and enhance the comments of it

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

There is a special call site in btrfs_qgroup_account_extent() that it
wants to do nested qgroups iteration, thus a nested version is
introduced for this particular call site.

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
  btrfs: qgroup: use qgroup_iterator facility to replace tmp ulist of
    qgroup_update_refcnt()
  btrfs: qgroup: use qgroup_iterator_nested facility to replace qgroups
    ulist of qgroup_update_refcnt()

 fs/btrfs/qgroup.c | 337 +++++++++++++++++-----------------------------
 fs/btrfs/qgroup.h |  27 ++++
 2 files changed, 148 insertions(+), 216 deletions(-)

-- 
2.41.0

