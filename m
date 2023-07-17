Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2ADC755CD3
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jul 2023 09:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjGQH0i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jul 2023 03:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjGQH0h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jul 2023 03:26:37 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E4C171A
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jul 2023 00:26:30 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4D3D2hD3zBR5lN
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jul 2023 15:19:04 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689578344; x=1692170345; bh=O239JSFgzdSb/CBVs8BwUDeGXL+
        W5C+hIf4OcRSOd8k=; b=HBWde2l6AwAB9sEsc+o03uvZ6VwpadukxMrVTGhOSrT
        9wgHUXKUWZFaw2rsOypV8RJU6kzpYqN2323+IrE0t49Vz6KP3RFbWVoXnm6QzFW+
        I+lRQgeyVY0QIJnuajvTLjjTQZNoXwllHkQpcHEtFcNXrwoCWfFNCTl37CwcXH1o
        XAfizTNLxGTy1SBPPSrQAhmQ4hkF1YOYrxeBzSGE80Y85qu9VCln/4/cjXRHUQY+
        pyZTCoirLTNDo3lcuYUMl+PjFxKD29++cNEdsUj5LvFII1J9d0+9bVtRpqaU7uMY
        ysGu+kgs082TWvfEgU+NlMLPP5phO7rvMgZcrKkxGmw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ioBB6MRvQHZT for <linux-btrfs@vger.kernel.org>;
        Mon, 17 Jul 2023 15:19:04 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4D3D0YsTzBJR3x;
        Mon, 17 Jul 2023 15:19:04 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 15:19:04 +0800
From:   wuyonggang001@208suo.com
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, terrelln@fb.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: Modify format error
In-Reply-To: <20230717071645.45023-1-zhanglibing@cdjrlc.com>
References: <20230717071645.45023-1-zhanglibing@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <12728f5d0ca3c593da3b4f4017efd1e2@208suo.com>
X-Sender: wuyonggang001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fix the following checkpatch error(s):
ERROR: "foo* const bar" should be "foo * const bar"
ERROR: "foo* bar" should be "foo *bar"

Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
---
  fs/btrfs/compression.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 8818ed5c390f..4ba54a3bc552 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -39,9 +39,9 @@

  static struct bio_set btrfs_compressed_bioset;

-static const char* const btrfs_compress_types[] = { "", "zlib", "lzo", 
"zstd" };
+static const char * const btrfs_compress_types[] = { "", "zlib", "lzo", 
"zstd" };

-const char* btrfs_compress_type2str(enum btrfs_compression_type type)
+const char *btrfs_compress_type2str(enum btrfs_compression_type type)
  {
      switch (type) {
      case BTRFS_COMPRESS_ZLIB:
