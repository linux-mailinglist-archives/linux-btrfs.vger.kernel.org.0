Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0B65B6761
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Sep 2022 07:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiIMFbj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Sep 2022 01:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiIMFbh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Sep 2022 01:31:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF5854CAD
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 22:31:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 23B6C339B6
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 05:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663047093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=N4TGdmwh/YcEO61f3EwBHngcBLvF6JyhNkHgr79dq/s=;
        b=PoV4EyoDWApJcgpooQPQHlaU01rl5VFKSqa2XuVmPG/6IJQBmIiadVIp0yYqzUmlubIMTM
        SuK4YK7EJ1B65Kfi99gU8pxmVVB0KuYHLTC5OKxehF4KeRqzxzCJY77QDxwJAUq06tJpgK
        qrJ2xt0MbeM6BHL2qip3jeODQeheDeM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6ADF513A86
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 05:31:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GrBYDLQVIGO5VwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 05:31:32 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs: optimize the argument list for submit_extent_page()
Date:   Tue, 13 Sep 2022 13:31:11 +0800
Message-Id: <cover.1663046855.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[Changelog]
v2:
- Add a patch to remove stale argument from the comments of
  submit_extent_page()

- Update the comment of submit_extent_page() to reflect the new arugment
  list

The argument list of submit_extent_page() is already a little long.

Although we have things like page, pg_len, pg_off which can not be saved
anyway, we can still improve the situation by:

- Update the stale comment of submit_extent_page()
  Done by the first patch.

- Make sure @page, @pg_len, @pg_off are always batched together
  Just like bio_add_page().

  This is done by the second page, just switching the position between
  @page and @disk_bytenr.

- Move @end_io_func arugment into btrfs_bio_ctrl structure.

Qu Wenruo (3):
  btrfs: update the comment for submit_extent_page()
  btrfs: switch the page and disk_bytenr argument position for
    submit_extent_page()
  btrfs: move end_io_func argument to btrfs_bio_ctrl structure

 fs/btrfs/extent_io.c | 66 +++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 29 deletions(-)

-- 
2.37.3

