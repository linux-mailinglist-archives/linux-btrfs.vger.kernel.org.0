Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C855B5486
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 08:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiILG3I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Sep 2022 02:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiILG3A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 02:29:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6054239
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Sep 2022 23:28:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8CF1F21BFF
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 06:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662964137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Wm4E/rk8hxKtxqgwsA7WbqCYvv2eaVQwhTuVVNLtcYU=;
        b=FIpMUHxPGq5sAyQ7UmOEgi0KwHkD5JwTjnblZeNF2IWJXbC9xxIiG3fNSTFjViM9HShgWf
        UtHKL+q5OBTycI2ZEdSYMgNyHkFH2TSQhtk/OZ0HUZ69EG7KoMOhas057fi+f+OJIiDiPe
        x0sim7Ye3nxw91JpVUtK3PvpdnIz8b8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9A66139E0
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 06:28:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WTKqI6jRHmMAdgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 06:28:56 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: optimize the argument list for submit_extent_page()
Date:   Mon, 12 Sep 2022 14:28:37 +0800
Message-Id: <cover.1662963954.git.wqu@suse.com>
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

The argument list of submit_extent_page() is already a little long.

Although we have things like page, pg_len, pg_off which can not be saved
anyway, we can still improve the situation by:

- Make sure @page, @pg_len, @pg_off are always batched together
  Just like bio_add_page().

  This is done by the first page, just switching the position between
  @page and @disk_bytenr.

- Move @end_io_func arugment into btrfs_bio_ctrl structure.

Qu Wenruo (2):
  btrfs: switch the page and disk_bytenr argument position for
    submit_extent_page()
  btrfs: move end_io_func argument to btrfs_bio_ctrl structure

 fs/btrfs/extent_io.c | 55 +++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

-- 
2.37.3

