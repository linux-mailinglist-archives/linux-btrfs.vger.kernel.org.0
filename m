Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA3962639F
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 22:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbiKKVaY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 16:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbiKKVaW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 16:30:22 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE9CE00E
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 13:30:21 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id x18so3767801qki.4
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 13:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FMY29uWvxB6k2FZ05xUKiUZ9bQV99BVoAVH/+6WpKDg=;
        b=3aTCsK7dVdBeIvEzhtwA/pNTsqDyXm0jaPxnuLdKsG/LNJOrPxJ9ZyBuf3nGM5xOD3
         TCmVpT+HiJwOvoKX2HVMPglpI8j5l4oX3Vhzld37zx4/DW5s8a1fmj8S8MyGEGdpd143
         c2uQ/NZyF3at4YvhevjDpmbuBCoQ31HNgXpgxpAbebYI+7sGFIr9HIBA5hL3UHseOkpN
         fAh+wkkTvccDLx1WQSoOhb7ILmrTF6zm7+hnz5cWQj0e3elyG8ydLqvJsrjTu1mqd/JD
         cmMajAoyPQnI0MQ1z3Fu38xNTZxflTO/knd3oRpcuxfY9SOJOzJGO5RvAtlUOoJQ6uCz
         6b+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMY29uWvxB6k2FZ05xUKiUZ9bQV99BVoAVH/+6WpKDg=;
        b=FUAAiQgtfcGSHM2FC5giFLervEJ1GoJ1NsBE8tJ5QNTXXy4nuhNX+o/0PBeycBu+ux
         rRNvKk30lJ5WYdXTuji+nmt/mKZ/ZYZyL0P2TOhMTTmA2p656BaQnSx03cUPk756Wb12
         GB/pEAv2w+q7WqcWeHiwSsZJnpqxZFU4u0Txt0N2ISIO3EI60fCozD/JMJV7UeBlZaEn
         8csYr4OEHw0F7VXW8mYOCWmV9akQb5Rb70UWHk0qLdbt1ZN+DZYJ21y56B2yjrO8wVPZ
         NItIgmSxQAHPU5G3Z33O8Tw9LNE7IZexrAQrF2VgCzgqXFkrkgkhvMfLnbSh1wWuGMXH
         fHvA==
X-Gm-Message-State: ANoB5pnJaievEiR22TUWh7YSdl3ZPermPdO24U7APbG83KIv8zY5v0hw
        07PXJY3MV8voxS0hYwIRGoxWuqK6xAPaKA==
X-Google-Smtp-Source: AA0mqf5MrAqDnPus8XY925RWbvs+nr+3DFAZxonkZC3sD3Psz5eQCfm0l4VhaOKQ28j93ssER4evLw==
X-Received: by 2002:a05:620a:1456:b0:6fa:2d2b:b80d with SMTP id i22-20020a05620a145600b006fa2d2bb80dmr2748165qkl.742.1668202220401;
        Fri, 11 Nov 2022 13:30:20 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id e12-20020ac8598c000000b0039cba52974fsm1839634qte.94.2022.11.11.13.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 13:30:20 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/14] btrfs-progs: properly test for send_stream_version
Date:   Fri, 11 Nov 2022 16:30:03 -0500
Message-Id: <e2742a8d9f88ccd7d46086dfff5d861579abfa0a.1668201935.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1668201935.git.josef@toxicpanda.com>
References: <cover.1668201935.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We want to notrun if this test fails, not if it succeeds.  Additionally
we want -s, as -q will still print an error if it gets ENOENT from the
file we're trying to grep.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/misc-tests/053-receive-write-encoded/test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/misc-tests/053-receive-write-encoded/test.sh b/tests/misc-tests/053-receive-write-encoded/test.sh
index a3e97a73..74b745ca 100755
--- a/tests/misc-tests/053-receive-write-encoded/test.sh
+++ b/tests/misc-tests/053-receive-write-encoded/test.sh
@@ -11,7 +11,7 @@ check_prereq btrfs
 setup_root_helper
 prepare_test_dev
 
-if grep -q '1$'  "/sys/fs/btrfs/features/send_stream_version"; then
+if ! grep -s '1$'  "/sys/fs/btrfs/features/send_stream_version"; then
 	_not_run "kernel does not support send stream >1"
 	exit
 fi
-- 
2.26.3

