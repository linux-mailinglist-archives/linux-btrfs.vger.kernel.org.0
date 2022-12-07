Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EAA645312
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Dec 2022 05:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiLGEfY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Dec 2022 23:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiLGEfV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Dec 2022 23:35:21 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076B856D6E
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 20:35:20 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ACAB921B4C
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Dec 2022 04:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670387719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=v9dKi8qA2JeeIpcgsoNK7ZiW4t6+QucHSjFCKb7a0L0=;
        b=ADObDJ5eUlO90Ik1SW5VFJsm3wtt37bIB0kn/q1KfLZ29tcVf439Odu11mJfvWvvtRo1fn
        m3J9ACfyAA9TOBwXv9F8Ula2bFrQtRefVdpZ5oIMA4SjuUr1ws3wAHrSFoJZQcfXwSbweD
        kReWRSIPkUkc377Xoz6jlt3HKUdKO6w=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 0C56E134CD
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Dec 2022 04:35:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id Ku71MQYYkGNQdwAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Dec 2022 04:35:18 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: corrupt-block: fix the mismatch in --root and -r options
Date:   Wed,  7 Dec 2022 12:35:01 +0800
Message-Id: <45593abf29f76663fa9b18c5ddc52556df5464f6.1670387695.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
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

[BUG]

The following command will crash:

 $ btrfs-corrupt-block --value 4308598784 --root 5 --inode 256 --file-extent 0 \
	-f disk_bytenr ~/test.img

[CAUSE]
The backtrace is at the following code:

			case 'r':
				root_objectid = arg_strtou64(optarg);
				break;

And @optarg is NULL.

The root cause is, for short option "-r" it indeed requires an argument.
But unfortunately for the longer version, it goes:

			{ "root", no_argument, NULL, 'r'},

Thus it gave @optarg as NULL if we go the longer option and crash.

[FIX]
Just fix the argument requirement for "--root" option.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 btrfs-corrupt-block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index 6cf5dc520d8b..b4e2b06efa43 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -1346,7 +1346,7 @@ int main(int argc, char **argv)
 			{ "item", no_argument, NULL, 'I'},
 			{ "dir-item", no_argument, NULL, 'D'},
 			{ "delete", no_argument, NULL, 'd'},
-			{ "root", no_argument, NULL, 'r'},
+			{ "root", required_argument, NULL, 'r'},
 			{ "csum", required_argument, NULL, 'C'},
 			{ "block-group", required_argument, NULL, GETOPT_VAL_BLOCK_GROUP},
 			{ "value", required_argument, NULL, GETOPT_VAL_VALUE},
-- 
2.38.1

