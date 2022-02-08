Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A44A4AE117
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Feb 2022 19:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385167AbiBHSmd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Feb 2022 13:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385169AbiBHSm1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Feb 2022 13:42:27 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357C0C06157B;
        Tue,  8 Feb 2022 10:42:26 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id a11-20020a17090a740b00b001b8b506c42fso2884740pjg.0;
        Tue, 08 Feb 2022 10:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BAFCLl44fuoxxYIbM7z13GRiD2jvm+2v6+Mst7t4c6A=;
        b=BR0bLF6l0VyVosnd3r23R+nnmNHQOzJjnTJP4b1DFMSAnxYr/f0XSkrRmPozt/cnsS
         PT+x7cZh507gC/oRmrXsz8pbFFBn60Y5z4WPkbA6BX6LcCSiivZDWtGInLLlD3RIVszs
         /WwL9btwpc4N2tsFnk3jpOwMmdq7ztkBTAJ+2K3unppP4FcZkyINRG6QwW8+Z9oc+uox
         veQePbEt6ZZg2SNNkwoSpwNv8sISw91I7UdZwFd2L8Mfa8MBsDwv1R/cjy77ZZQgO6pD
         IgMRHEwaJqII6CA+sNvsykcHcObHxQc/vw7bY0cVBFoCC0GVGDl/kM3bf3J/Xs0Lcuyc
         lsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=BAFCLl44fuoxxYIbM7z13GRiD2jvm+2v6+Mst7t4c6A=;
        b=K+D/uCLX8kkzWaTyVhBC5MhP/Bu47+gMLMUmCmCfaJSWGbQdsVDL2rOIni0+ypms04
         2e9N+unYBdWvyRzwUxByylrYwI9NEJ1ndfMxL2MydfZs1cJ9H7sJm1P68XJXW1RUBxah
         bKOuCMODrilAw6dmcWS8JJOvaDtnyH8mJW7R76A+fVWJ9YdaFTRcRGouLN95ETDXHF0o
         MCoilH5oBgFB44F6uKzs45py6fbmm+DY9ntMTNDsoXg7+Z6Dd8/RQk4EpMy08EO6Y6NC
         muygCmBGlTdGCJSBxEQBcVIsveFHz5HdJvGfUTGL/Uv5jcuYzedijEqr915mz6ar/RM1
         KIdQ==
X-Gm-Message-State: AOAM533JDF9bDhJB6G7xe0oIDJ+0H/GePuQhtSVJufS20I4QrfQjLxM6
        Vmrw9KgsgglVQLVx4BRXJLE=
X-Google-Smtp-Source: ABdhPJzr/qYoYdcJ+93z4PimG/A6Ax5bD+A5VU9smm/HkouB79uvdewlBom8blFAcKvjJSRLH4cogw==
X-Received: by 2002:a17:903:24e:: with SMTP id j14mr1810437plh.10.1644345745682;
        Tue, 08 Feb 2022 10:42:25 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:347f:e607:176:4358])
        by smtp.gmail.com with ESMTPSA id l14sm3517027pjf.1.2022.02.08.10.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:42:25 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paul.mckenney@linaro.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 06/12] btrfs: change lockdep class size check using ks->names
Date:   Tue,  8 Feb 2022 10:42:02 -0800
Message-Id: <20220208184208.79303-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208184208.79303-1-namhyung@kernel.org>
References: <20220208184208.79303-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With upcoming lock tracepoints config, it'd allow some lockdep
annotation code without enabling CONFIG_LOCKDEP actually.  In that
config, size of the struct lock_class_key would be 0.

But it'd cause divide-by-zero in btrfs_set_buffer_lockdep_class() due
to ARRAY_SIZE macro.  Let's change it to use ks->names[] instead.  It
should have the same size as with ks->keys[].

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 fs/btrfs/disk-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 87a5addbedf6..be41e35bee92 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -190,7 +190,7 @@ void btrfs_set_buffer_lockdep_class(u64 objectid, struct extent_buffer *eb,
 {
 	struct btrfs_lockdep_keyset *ks;
 
-	BUG_ON(level >= ARRAY_SIZE(ks->keys));
+	BUG_ON(level >= ARRAY_SIZE(ks->names));
 
 	/* find the matching keyset, id 0 is the default entry */
 	for (ks = btrfs_lockdep_keysets; ks->id; ks++)
-- 
2.35.0.263.gb82422642f-goog

