Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF354AA558
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Feb 2022 02:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378814AbiBEBhA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 20:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiBEBg7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 20:36:59 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FC7C061346;
        Fri,  4 Feb 2022 17:36:57 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id z4so1078927lfg.5;
        Fri, 04 Feb 2022 17:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2+tbWAJq4dM6q/DqX2lwh/khP1tb+54dO8mMyWJJF/o=;
        b=CNJyN4/mjQe5DVMMvvEiDqNhV8765CoichdUs4/9gbBZYmgrsO0pSmsp25dTWz8WNj
         56YlV/R+3HoM/HCSuxSXtRSZUK8k6ixkj58yY73n2X51hxqQ+9ET4gHexpK1qa7aTZA0
         fy/xpdhesdgl1AtFR+Q5lb07kcxO2h5+457gTj3nkaWEvIP4L3+FVDEm9t/dE/Rg4vNX
         xHqTYfP/Qd4BOAkein1l7Qfns7NfPZqN5JdGfWg/RaSWffkikhoPatuxao7OF3Rhqf3i
         jbhUNbVTcLGn/xkhG7fcNslABS/y+NmnPMabvmlI7KK6hZy4/o95KriuFSS45VMLgd33
         R3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2+tbWAJq4dM6q/DqX2lwh/khP1tb+54dO8mMyWJJF/o=;
        b=BUzFFOcHONXMyyPLd9INq9eRVBs5GPwkbaQKMhO9xHnxRe5d8Jwot8/v0TvYzAO+6z
         /6x0B9NW9cCFjrCP6pfzcUGUpZUmOuzvUUggkG3GowNea+Co3yy0Z4fwIT8VZe1lySll
         gr/FzHP+tseKnroCnMesCeMuJF1sL4ReVfct7aqphi2sU5F99GNT3HwlTawA0VWpxaHC
         3AJPnFLvUX7Av4uUa3cycUZd4WSaAUnXpDUmJ2Hir7RdcCAuJ2LJDS1j8fmFfhXPr4LT
         eq+fXWWVDvMEwGSRnwtJfyINaj7l2m7xnG3DC7LliCixRBvRBgpiZv3u6cF0SAjUFG/J
         LQ1w==
X-Gm-Message-State: AOAM532ijE8yCrmNvFHvaEz0Z35YcaS2Ky0I7C5xorCfmI0RBjo5KdJd
        Nib3AHqYfKI+XoUvEkBbQLhiMhFg0OPBqjqyOJk=
X-Google-Smtp-Source: ABdhPJyXbTQ55b5WctfvOjGMz9Cyh8tOXRAXhz2rW7CxUqyZQOu/JWwANTNZo2AZxbrTjCLB6Vg2/Q==
X-Received: by 2002:a05:6512:3d0f:: with SMTP id d15mr1173884lfv.77.1644025015266;
        Fri, 04 Feb 2022 17:36:55 -0800 (PST)
Received: from ArchRescue.. ([81.198.232.185])
        by smtp.gmail.com with ESMTPSA id f11sm525662lfg.132.2022.02.04.17.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 17:36:54 -0800 (PST)
From:   =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
Subject: [PATCH v2] btrfs: send: in case of IO error log it
Date:   Sat,  5 Feb 2022 03:36:07 +0200
Message-Id: <20220205013606.532212-1-davispuh@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220202201437.7718-1-davispuh@gmail.com>
References: <20220202201437.7718-1-davispuh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently if we get IO error while doing send then we abort without
logging information about which file caused issue.
So log it to help with debugging.

Signed-off-by: Dāvis Mosāns <davispuh@gmail.com>
---
 fs/btrfs/send.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index d8ccb62aa7d2..a1fd449a5ecc 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5000,6 +5000,8 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
 			if (!PageUptodate(page)) {
 				unlock_page(page);
 				put_page(page);
+				btrfs_err(fs_info, "send: IO error at offset=%llu for inode=%llu root=%llu",
+					page_offset(page), sctx->cur_ino, sctx->send_root->root_key.objectid);
 				ret = -EIO;
 				break;
 			}
-- 
2.35.1

