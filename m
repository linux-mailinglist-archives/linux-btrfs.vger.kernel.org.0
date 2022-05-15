Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD232527728
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 May 2022 12:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbiEOKzb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 May 2022 06:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236467AbiEOKz1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 May 2022 06:55:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADC015812
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 03:55:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1C1C31F8A4
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 10:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652612125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q2uPcFdOIVui838Yd0YM5ncaxLgkTV7/nuL9L1jt/Kg=;
        b=F7A+t2BdE3li2/Jd9gv0l1j0wDtoB6QGWSjBoAmka2MHui6zidntKFFo+MoGoX0FARvKvO
        NL3+yoIpdyhUpKKDJVfxQyrhE55hdY2AIzfqWe2P2Rlf/xekWOSFUGTsBrWxQjYkQXHqGk
        z9QnMVWFe4l/dYHFoc0sjIQK+vISK+s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 65FC613491
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 10:55:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UE9yDBzcgGLsfQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 10:55:24 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/5] btrfs-progs: check/lowmem: fix path leakage when dev extents are invalid
Date:   Sun, 15 May 2022 18:55:00 +0800
Message-Id: <4c3548e63a9e42482cbc2c277b15cf3eeae700bd.1652611958.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1652611957.git.wqu@suse.com>
References: <cover.1652611957.git.wqu@suse.com>
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

[BUG]
When testing my new RAID56J code, there is a bug causing dev extents
overlapping.

Although both modes can detect the problem, lowmem has leaked some
extent buffers:

  $ btrfs check --mode=lowmem /dev/test/scratch1
  Opening filesystem to check...
  Checking filesystem on /dev/test/scratch1
  UUID: 65775ce9-bb9d-4f61-a210-beea52eef090
  [1/7] checking root items
  [2/7] checking extents
  ERROR: dev extent devid 1 offset 1095761920 len 1073741824 overlap with previous dev extent end 1096810496
  ERROR: dev extent devid 2 offset 1351614464 len 1073741824 overlap with previous dev extent end 1352663040
  ERROR: dev extent devid 3 offset 1351614464 len 1073741824 overlap with previous dev extent end 1352663040
  ERROR: errors found in extent allocation tree or chunk allocation
  [3/7] checking free space tree
  [4/7] checking fs roots
  [5/7] checking only csums items (without verifying data)
  [6/7] checking root refs done with fs roots in lowmem mode, skipping
  [7/7] checking quota groups skipped (not enabled on this FS)
  found 3221372928 bytes used, error(s) found
  total csum bytes: 0
  total tree bytes: 147456
  total fs tree bytes: 32768
  total extent tree bytes: 16384
  btree space waste bytes: 136231
  file data blocks allocated: 3221225472
   referenced 3221225472
  extent buffer leak: start 30752768 len 16384
  extent buffer leak: start 30752768 len 16384
  extent buffer leak: start 30752768 len 16384

[CAUSE]
In the function check_dev_item(), we iterate through all the dev
extents, but when we found overlapping extents, we exit without
releasing the path, causing extent buffer leakage.

[FIX]
Just release the path before we exit the function.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/mode-lowmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 63f9343ba2ff..7dd61e0af0b6 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -4561,6 +4561,7 @@ static int check_dev_item(struct extent_buffer *eb, int slot,
 "dev extent devid %llu offset %llu len %llu overlap with previous dev extent end %llu",
 			      devid, physical_offset, physical_len,
 			      prev_dev_ext_end);
+			btrfs_release_path(&path);
 			return ACCOUNTING_MISMATCH;
 		}
 		if (physical_offset + physical_len > total_bytes) {
@@ -4568,6 +4569,7 @@ static int check_dev_item(struct extent_buffer *eb, int slot,
 "dev extent devid %llu offset %llu len %llu is beyond device boundary %llu",
 			      devid, physical_offset, physical_len,
 			      total_bytes);
+			btrfs_release_path(&path);
 			return ACCOUNTING_MISMATCH;
 		}
 		prev_devid = devid;
-- 
2.36.1

