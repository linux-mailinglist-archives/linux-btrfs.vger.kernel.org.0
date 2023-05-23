Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2782B70CFB7
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 02:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbjEWApz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 May 2023 20:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbjEWApJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 20:45:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F8C4C26
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 17:37:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 80EEA2236D
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 00:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684802251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ul7/2UM+EHaybYA7ooPx10NR7QfU6z293U/TD1acy3I=;
        b=j4BzyMHgCkFKORdLzYIv8hE1eK/VCzsAJYPRgQD5Y+fde9AkLYdC7Rpbp2qQz5ca4rA2CL
        9TjzcbYsR1c4uRP/lH3B/vVSNw6rxm7CRZKScJ+CCksjhTq1jNDJHoVe+/abUCjWxPo43r
        99gv8wtwPsJr5jrBudQjeVbgAHtYCEM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CC98A13588
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 00:37:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tko/JcoKbGTIIgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 00:37:30 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: tune: fix the leftover csum change item and add a test case for it
Date:   Tue, 23 May 2023 08:37:11 +0800
Message-Id: <cover.1684802060.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

David's cyclic csum change tests exposed a bug even with the latest csum
change code, that I'm a total idiot and forgot to delete the csum change
item.

This results a bug that if we have run multiple csum changes to the same
target csum type (e.g. CRC32C->SHA256->CRC32C->SHA256), the second
conversion to the same type would fail due to the left over csum change items.

This series would do the fix and add a test case to cover this bug.

Qu Wenruo (2):
  btrfs-progs: tune: delete the csum change item after converting the fs
  btrfs-progs: tests/misc: add a test case for csum change

 .../058-btrfstune-csum-change/test.sh         | 26 ++++++++++++
 tune/change-csum.c                            | 42 +++++++++++++++++--
 2 files changed, 64 insertions(+), 4 deletions(-)
 create mode 100755 tests/misc-tests/058-btrfstune-csum-change/test.sh

-- 
2.40.1

