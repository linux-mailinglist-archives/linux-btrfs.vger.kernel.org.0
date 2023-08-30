Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0902178DA4E
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Aug 2023 20:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjH3SgB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Aug 2023 14:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243289AbjH3Kht (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Aug 2023 06:37:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E743B9
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Aug 2023 03:37:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 62F941F45F
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Aug 2023 10:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693391865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=qohgiNSWQBKmuIXc/y5LLmz5xDPs8vxMN3Z2dTKowuQ=;
        b=a2dsuLNw8MqnADletzNRLz3kIFeQ/gIw0ybC293vc0vXcW67TLwTi977v4hmhe7Eo852RE
        XQTrcV+4isL23plA4K/4KLacpy0MkuoCxnEPlMJ6Lu2V2QGDN1coA5mIeSJvzRB9eaalv2
        0d2Oey7AxJwm8p4rNToMLSNjYpSy++g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B46721353E
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Aug 2023 10:37:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fYrmHvgb72SKcAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Aug 2023 10:37:44 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/5] btrfs: qgroup: reduce GFP_ATOMIC usage for ulist
Date:   Wed, 30 Aug 2023 18:37:22 +0800
Message-ID: <cover.1693391268.git.wqu@suse.com>
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

Qu Wenruo (5):
  btrfs: qgroup: iterate qgroups without memory allocation for
    qgroup_reserve()
  btrfs: qgroup: use qgroup_iterator facility for
    btrfs_qgroup_free_refroot()
  btrfs: qgroup: use qgroup_iterator facility for qgroup_convert_meta()
  btrfs: qgroup: use qgroup_iterator facility for
    __qgroup_excl_accounting()
  btrfs: qgroup: use qgroup_iterator facility to replace @tmp ulist of
    qgroup_update_refcnt()

 fs/btrfs/qgroup.c | 252 ++++++++++++++++------------------------------
 fs/btrfs/qgroup.h |   9 ++
 2 files changed, 94 insertions(+), 167 deletions(-)

-- 
2.41.0

