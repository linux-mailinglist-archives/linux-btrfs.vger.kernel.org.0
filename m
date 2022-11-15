Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A47629EF7
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 17:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238214AbiKOQZd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 11:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238601AbiKOQZc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 11:25:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3419FCE26
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 08:25:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C359D618EA
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 16:25:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6715C433C1
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 16:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668529530;
        bh=/oIe1HMXR30NY77gJbQmtax6Xj6w4CQoqvZD9XX2abQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QT8uXOATKXYALZCUkK4ahG34vBO1ln25wPAS9WbloeKbfIlIuMg8phCaxfkAso7yD
         LrJgDDRXmAVs92KE8YBOZsCDQs3z/1PFie9oddtw+SKm7rBN3qG5fCzq5s/hIwWk+E
         t6JQf2TPo0uGRqqN/mL1uPwz1qTYQ8fKEHArjgkY538y6bsrWeBz6ySS3E5aaHqjqm
         4qCdVquqa1G53b9DS3PtK0nkGezLWDbv5kOYueo2ym96/9KA0HoEYYudX1cAQokw+H
         TSqIpTozt59QppUMDgyFwpEbyHtZLoc5zs7cMSuyRL5ucicltaTreqF/Hdnqok/Mf4
         mRj5DlB6LfKuw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: receive: add debug messages when processing encoded writes
Date:   Tue, 15 Nov 2022 16:25:24 +0000
Message-Id: <90290fe5047d688d8eecdc1357e9379252ae5352.1668529099.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1668529099.git.fdmanana@suse.com>
References: <cover.1668529099.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Unlike for commands from the v1 stream, we have no debug messages logged
when processing encoded write commands, which makes it harder to debug
issues.

So add log messages, when the log verbosity level is >= 3, for encoded
write commands, mentioning the value of all fields and also log when we
fallback from an encoded write to the decompress and write approach.

The log messages look like this:

  encoded_write f3 - offset=33792, len=4096, unencoded_offset=33792, unencoded_file_len=31744, unencoded_len=65536, compression=1, encryption=0
  encoded_write f3 - falling back to decompress and write due to errno 22 ("Invalid argument")

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 cmds/receive.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/cmds/receive.c b/cmds/receive.c
index 6f475544..b75a5634 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -1246,6 +1246,13 @@ static int process_encoded_write(const char *path, const void *data, u64 offset,
 		.encryption = encryption,
 	};
 
+	if (bconf.verbose >= 3)
+		fprintf(stderr,
+"encoded_write %s - offset=%llu, len=%llu, unencoded_offset=%llu, unencoded_file_len=%llu, unencoded_len=%llu, compression=%u, encryption=%u\n",
+			path, offset, len, unencoded_offset, unencoded_file_len,
+			unencoded_len, compression, encryption);
+
+
 	if (encryption) {
 		error("encoded_write: encryption not supported");
 		return -EOPNOTSUPP;
@@ -1271,6 +1278,10 @@ static int process_encoded_write(const char *path, const void *data, u64 offset,
 			error("encoded_write: writing to %s failed: %m", path);
 			return ret;
 		}
+		if (bconf.verbose >= 3)
+			fprintf(stderr,
+"encoded_write %s - falling back to decompress and write due to errno %d (\"%m\")\n",
+				path, errno);
 	}
 
 	return decompress_and_write(rctx, data, offset, len, unencoded_file_len,
-- 
2.35.1

