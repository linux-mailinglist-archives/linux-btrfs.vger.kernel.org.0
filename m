Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20490655EF1
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Dec 2022 02:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiLZBBH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Dec 2022 20:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiLZBBF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Dec 2022 20:01:05 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85359C2C
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Dec 2022 17:01:00 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 66CC34D952
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Dec 2022 01:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672016458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Dsj6usBDgiEW9Jdh/oUnHusosQ9VlPb74RhOAZtjh8s=;
        b=KNAdqRCDFh2iTXItoNqSrVQ8Ih3NrbkyRVyB5StjgKPBTIsE1SxmZ0LwnnLPcH9dT6z+XX
        1Urxkw997u2o5RGBvw2SwyuTfPwM//KtAhGDk8ge9TDkHHXnHZLIchqRTa7Z7ZRfT6Xifd
        mJCsdg89cIXTLRS0GHA/07nRjVsZlKU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D0C97138F2
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Dec 2022 01:00:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dc04KEnyqGNFaQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Dec 2022 01:00:57 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: add error reports for possible run_one_delayed_ref()
Date:   Mon, 26 Dec 2022 09:00:38 +0800
Message-Id: <cover.1672016104.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.0
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

There is a bug report that one can cause error in run_one_delayed_ref()
and make the fs RO.

But there is only two lines of dmesg:

 BTRFS: error (device nvme0n1p3: state A) in btrfs_run_delayed_refs:2147: errno=-5 IO failure
 BTRFS info (device nvme0n1p3: state EA): forced readonly

Which is not really helpful.

This patch will add two error reports which should help us to debug:

- Add the missing level check errors in validate_extent_buffer()
  Failed level checks didn't cause any error message, which is very
  different compared to the other checks.

- Add error report for failed run_one_delayed_ref()
  This will include extra info for each node.

The remaining branches are either calling btrfs_abort_transaction(),
which should provide function and line number, or have extra error
message like alloc_reserved_extent(), or should trigger error messages
from validate_extent_buffer() when failed, like btrfs_insert_empty_item().

Thus this two patches should cover most of the error cases.

Qu Wenruo (2):
  btrfs: add extra error message for tree block level mismatch
  btrfs: always report error for run_one_delayed_ref()

 fs/btrfs/disk-io.c     | 4 ++++
 fs/btrfs/extent-tree.c | 7 +++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.39.0

