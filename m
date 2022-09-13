Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7F65B688A
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Sep 2022 09:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiIMHT7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Sep 2022 03:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiIMHTr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Sep 2022 03:19:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B13C37
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 00:19:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E6AA05BEE3
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 07:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663053584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=CzWRwiWF//x0NqIrcRScS1zxe2O0tgjNPihvJLAZCFI=;
        b=hP5dKzPRxu7seay/UpffsAiwPMOireCJqsarcE6Ae3+yR+PR4V8DbTgUMbrGIFs4IegMfw
        Wwsd42nRypjvpQNVbAEGv2EqiI+x7jV+WNOvmhUxAQ5GMTWAs3M1J06HYIs03wcusGOLs/
        xdpQQ7FT8O7riidS2vdfj149ftdlDV0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 48FF513AB5
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 07:19:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HMp1BRAvIGMOfAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 07:19:44 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: make corrupt-block metadata geneartion corruption work again
Date:   Tue, 13 Sep 2022 15:19:24 +0800
Message-Id: <cover.1663053391.git.wqu@suse.com>
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

This is preparing for the incoming metadata validation refactor in
kernel, thus I need a way to corrupt transid reliably with correct
checksum.

The first patch is to unexport csum_tree_block() which also has a stale
definition .

The second patch is to fix the csum for metadata block with corrupted
generation.

Now btrfs-corrupt-block can properly corrupt the generation of a tree
block.

(But unfortunately it corrupts all copies, which is still not exactly
what I need, but is already good enough)

Qu Wenruo (2):
  btrfs-progs: unexport csum_tree_block()
  btrfs-progs: corrupt-block: re-generate the checksum for generation
    corruption

 btrfs-corrupt-block.c   | 2 ++
 common/utils.h          | 2 --
 kernel-shared/disk-io.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.37.3

