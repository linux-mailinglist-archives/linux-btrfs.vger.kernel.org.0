Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284457D20E3
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Oct 2023 05:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjJVDkg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Oct 2023 23:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJVDkf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Oct 2023 23:40:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8211114
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Oct 2023 20:40:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0E44F1FDC2
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Oct 2023 03:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697946028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=lAaCa1nD7MKgJwisi4XDz5JpauqMqs0hlxUShYmm2eo=;
        b=K9ahWw5GkbR0HSmi5a98mjBrtn3VmsKlcXb/JJSI2+qqZghp5Fh7Ngt5J+JgzieSKpnok0
        gSVQZx1DTPXjsSEVuhvKvKj5WjM88n0cA4HvAEm2ka4P7ClwnQGV6coPC3l2K/cHLTEpJr
        BVJJPIuZADMMQ5divH1bidqm7YNqBvY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C46C1348C
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Oct 2023 03:40:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vRkpO6qZNGVHZwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Oct 2023 03:40:26 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: follow-ups for issue #622
Date:   Sun, 22 Oct 2023 14:10:06 +1030
Message-ID: <cover.1697945679.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -1.73
X-Spamd-Result: default: False [-1.73 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         TO_DN_NONE(0.00)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
         RCPT_COUNT_ONE(0.00)[1];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-2.63)[98.38%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Issue #622 is a very interesting bug report, that ntfs2btrfs has a fixed
bug that it can generate out-of-order inline backref items.

This leads to kernel transaction abort, but btrfs-check failed to detect
it at all.

Although the fix for btrfs-progs is already merged in the latest v6.5.3
release, we still lacks the following thing:

- Better dump-tree support to show the weird inline backref order
  This is very weird, as we have the inline type in ascending order,
  but for the sequence number (hash for EXTENT_DATA_REF, offset for all
  other types) it is descending inside the same type.

  That's why the following output of one data extent item looks
  out-of-order:

	item 0 key (13631488 EXTENT_ITEM 4096) itemoff 16143 itemsize 140
		refs 4 gen 7 flags DATA
		extent data backref root FS_TREE objectid 258 offset 0 count 1
		extent data backref root FS_TREE objectid 257 offset 0 count 1
		extent data backref root FS_TREE objectid 260 offset 0 count 1
		extent data backref root FS_TREE objectid 259 offset 0 count 1

- Lowmem mode support to detect the error

- Test case to make sure we can detect the error

This series would address all the three points above.

Qu Wenruo (3):
  btrfs-progs: dump-tree: output the sequence number for inline
    references
  btrfs-progs: check/lowmem: verify the sequence of inline backref items
  btrfs-progs: fsck-tests: add test image of out-of-order inline backref
    items

 check/mode-lowmem.c                           |  31 ++++++++++++++++++
 check/mode-lowmem.h                           |   1 +
 kernel-shared/print-tree.c                    |  31 +++++++++++-------
 .../btrfs_image.xz                            | Bin 0 -> 2264 bytes
 .../061-out-of-order-inline-backref/test.sh   |  19 +++++++++++
 5 files changed, 70 insertions(+), 12 deletions(-)
 create mode 100644 tests/fsck-tests/061-out-of-order-inline-backref/btrfs_image.xz
 create mode 100755 tests/fsck-tests/061-out-of-order-inline-backref/test.sh

--
2.42.0

