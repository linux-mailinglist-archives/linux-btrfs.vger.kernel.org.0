Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7147E75F0EF
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 11:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjGXJyT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 05:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjGXJx6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 05:53:58 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB8A1FC6
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 02:50:02 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b867f9198dso8898565ad.0
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 02:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690192147; x=1690796947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CXd5cxT7BQDd98tt8oaC0MvbTuhoGV4WCiM7GrnKVE=;
        b=KQjtvrM5WCun+a4xOj456S6UuqGIkvzyD2jHH3TR9iY9a97Nt32MSSfeCXCmbM81Y3
         7CR481sQUeyCzPya4qTSPUgO2X/EhgaM7LuUX3zxeHldHQRKH0RrsI+JkYmanpIzppK4
         +abROecNMX11crshq9sHFZamNywEwoxtK8Vecu9T/ezkwCibUb1czEw6+JIKkmPyPcQg
         1hoEKHuQR39hivSCYtyLe70icTB0k15MuRyTV7pjq8M21zBZSftgM/Uwfo8RV8+TAK3Y
         pOSIhBz1N9cqbqrOLeJG0Mkh/NqdVj/Db67KzjXs12zF9HPMwZax5Fae+E8V7mgE4uk/
         /g5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690192147; x=1690796947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CXd5cxT7BQDd98tt8oaC0MvbTuhoGV4WCiM7GrnKVE=;
        b=iLWON62ZcTTtWvngWolbOIxeHFGAncXnTdK3N4yRYu3D38jYBnN+S531640sjurtaw
         orGGPxC1YHhsnFtDJDn0LhTWZlmJq11ikJBiPkQ0Ig1qdELEfxPr0pRLsoGJwcMfZLYg
         0GjB/tub18EbaILFicEHlRw9msjRGaAT95rOHK/mAq/rTCF9ABEw7yPq3Ki61UiTrMwu
         KhW5epQoDJ29TjAo4pE2OY122H2hBmDnSSIo/8y45gFCGdED87zdZvxU9y5YRpQNTkUV
         wZX0ZEMwxztJrmJ2ZzMpz4hTGHIxjMMxAbv6gRrTrT2jgiHFmXoXUMMRpdAYCZJC/nUn
         ZznA==
X-Gm-Message-State: ABy/qLZ5U/n3K4xaqBXH21jKUh0XrZOUunI1BJcMpMl6gJ285aQ7BYjm
        TnjUDbgIEjiPgGDyw9jtSSgTVA==
X-Google-Smtp-Source: APBJJlGIkgxKi3c8vlsRfvF8eC2AUaCtjB+PIQLMdMMArsufsHEWiltHfQyyqXBdYUy9SpebX4CtOg==
X-Received: by 2002:a17:902:e80a:b0:1b8:50a9:6874 with SMTP id u10-20020a170902e80a00b001b850a96874mr12324079plg.5.1690192146760;
        Mon, 24 Jul 2023 02:49:06 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001bb20380bf2sm8467233pld.13.2023.07.24.02.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:49:06 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 20/47] sunrpc: dynamically allocate the sunrpc_cred shrinker
Date:   Mon, 24 Jul 2023 17:43:27 +0800
Message-Id: <20230724094354.90817-21-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use new APIs to dynamically allocate the sunrpc_cred shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 net/sunrpc/auth.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
index 2f16f9d17966..74e40c8a512d 100644
--- a/net/sunrpc/auth.c
+++ b/net/sunrpc/auth.c
@@ -861,11 +861,7 @@ rpcauth_uptodatecred(struct rpc_task *task)
 		test_bit(RPCAUTH_CRED_UPTODATE, &cred->cr_flags) != 0;
 }
 
-static struct shrinker rpc_cred_shrinker = {
-	.count_objects = rpcauth_cache_shrink_count,
-	.scan_objects = rpcauth_cache_shrink_scan,
-	.seeks = DEFAULT_SEEKS,
-};
+static struct shrinker *rpc_cred_shrinker;
 
 int __init rpcauth_init_module(void)
 {
@@ -874,9 +870,16 @@ int __init rpcauth_init_module(void)
 	err = rpc_init_authunix();
 	if (err < 0)
 		goto out1;
-	err = register_shrinker(&rpc_cred_shrinker, "sunrpc_cred");
-	if (err < 0)
+	rpc_cred_shrinker = shrinker_alloc(0, "sunrpc_cred");
+	if (!rpc_cred_shrinker)
 		goto out2;
+
+	rpc_cred_shrinker->count_objects = rpcauth_cache_shrink_count;
+	rpc_cred_shrinker->scan_objects = rpcauth_cache_shrink_scan;
+	rpc_cred_shrinker->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(rpc_cred_shrinker);
+
 	return 0;
 out2:
 	rpc_destroy_authunix();
@@ -887,5 +890,5 @@ int __init rpcauth_init_module(void)
 void rpcauth_remove_module(void)
 {
 	rpc_destroy_authunix();
-	unregister_shrinker(&rpc_cred_shrinker);
+	shrinker_unregister(rpc_cred_shrinker);
 }
-- 
2.30.2

