Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D6F70EFA0
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 09:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239973AbjEXHly (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 03:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239935AbjEXHlw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 03:41:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D9A9D
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 00:41:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7A91B22435
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 07:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684914108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Afj5KjS1/SoBMFyZ5TXQbbYwXUu8NIBfk3bXfxBSuxs=;
        b=XHzpvYFGJv48HNzAdGsMqOVN0VsnqSup1YlU5fLGe9n/SERUz5V3O5cYByioozegxS9LnY
        RxS78Dgq06ajdd1ITHo7Dlb2eKJA2TWTdiHVAw7GGe9cqsndMfB1HzhMskZFsmxjvvb4am
        I9upPtUEZlZq0r3WUDz+mgltVv0Uy2s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D08C113425
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 07:41:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qPs/Jru/bWSiRQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 07:41:47 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/7] btrfs-progs: tune: add resume support for csum conversion
Date:   Wed, 24 May 2023 15:41:23 +0800
Message-Id: <cover.1684913599.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
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

[RESUME SUPPORT]
This patchset adds the resume support for "btrfstune --csum".

The main part is in resume for data csum change, as we have 4 different
status during data csum conversion.

Thankfully for data csum conversion, everything is protected by
metadata COW and we can detect the current status by the existence of
both old and new csum items, and their coverage.

For resume of metadata conversion, there is nothing we can really do but
go through all the tree blocks and verify them against both new and old
csum type.

[TESTING]
For the tests, currently errors are injected after every possible
transaction commit, and then resume from that interrupted status.
So far the patchset passes all above tests.

But I'm not sure what's the better way to craft the test case.

Should we go log-writes? Or use pre-built images?

[TODO]
- Test cases for resume

- Support for revert if errors are found
  If we hit data csum mismatch and can not repair from any copy, then
  we should revert back to the old csum.

- Support for pre-cautious metadata check
  We'd better read and very metadata before rewriting them.

- Performance tuning
  We want to take a balance between too frequent commit transaction
  and too large transaction.
  This is especially true for data csum objectid change and maybe
  old data csum deletion.

- UI enhancement
  A btrfs-convert like UI would be better.


Qu Wenruo (7):
  btrfs-progs: tune: implement resume support for metadata checksum
  btrfs-progs: tune: implement resume support for generating new data
    csum
  btrfs-progs: tune: implement resume support for csum tree without any
    new csum item
  btrfs-progs: tune: implement resume support for empty csum tree
  btrfs-progs: tune: implement resume support for half deleted old csums
  btrfs-progs: tune: implement resume support for data csum objectid
    change
  btrfs-progs: tune: reject csum change if the fs is already using the
    target csum type

 tune/change-csum.c | 461 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 418 insertions(+), 43 deletions(-)

-- 
2.40.1

