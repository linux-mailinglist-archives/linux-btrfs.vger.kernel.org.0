Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B887A676510
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Jan 2023 09:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjAUIGe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Jan 2023 03:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjAUIGc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Jan 2023 03:06:32 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18F85AB57
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Jan 2023 00:06:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 94E075FEBF
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Jan 2023 08:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674288390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ZCXpcRJ36KZptNjzbf2RdtcBummPIuFznjv7LmPhANo=;
        b=ptJf6cTB4fWVDs1YLVfNnaCnvVEDGlA0Preavoc6dYXT4XRFyHJBhmEa9pP/OzfQ/L9wgl
        VJ/vfYtZdWlxa8WS9zK6xgWgKTLi4iwDrxJm3YUbnDm4TBXbj2Cfollh6r+oom0kH3ge7T
        /COLXgr7vl9FfsrwY3wjRxz7mKq/fvg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D0661357F
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Jan 2023 08:06:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UvA3NAWdy2OoPgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Jan 2023 08:06:29 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: raid56: concurrency fix and a very tiny optimization
Date:   Sat, 21 Jan 2023 16:06:10 +0800
Message-Id: <cover.1674285037.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have a unprotected concurrency updateing rbio::error_bitmap.
The first patch is going to fix it.

While we are at rbio_update_error_bitmap(), there is also a tiny
optimization we can do for calculating the bio size.
Since we only care about the size of the bio, bio_for_each_bvec_all() is
much better than bio_for_each_segment_all(), as the former one can
handle multi-page bvec directly to reduce the loop.

Changelog:
v2:
- Use set_bit() in a loop instead of an asymmetrical spinlock.
  Since only endio can have concurrency accessing the bitmap, while
  the main thread only access them in a single thread, we will have
  asymmetrical spinlock schema, which is not ideal.
  Instead go set_bit() in a loop.

- Add a tiny optimization to calculate bio length in
  rbio_update_error_bitmap()
  

Qu Wenruo (2):
  btrfs: raid56: make error_bitmap update atomic
  btrfs: raid56: reduce the overhead to calculate the bio length

 fs/btrfs/raid56.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

-- 
2.39.1

