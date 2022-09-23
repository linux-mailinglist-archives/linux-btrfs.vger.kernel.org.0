Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E145E8404
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Sep 2022 22:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiIWUeq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Sep 2022 16:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiIWUcj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Sep 2022 16:32:39 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603D514B851
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Sep 2022 13:28:32 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 3so1280694pga.1
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Sep 2022 13:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8ihjvmU6X32IA3g0n6Ob0CbMhk1X+mcnfaE/5Wfmhd8=;
        b=LPhVNeH7/j6XoYSyZU8Fbh//laqcTzvu//J4Iy04p1XS4de+UJKinl09GFu2JyMlZM
         OiqIFGFrD5z7VUB8De1Lo4L81RAcz4hJEUvZG4jbI7uvuCZ21WW6CkLOkKLLpki0ZPPj
         ptuTYFeO3yYhD48tSYI8BF3HO3FHnDA3HFKOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8ihjvmU6X32IA3g0n6Ob0CbMhk1X+mcnfaE/5Wfmhd8=;
        b=r4QgdhbG3MAJ+BKL2Sv3+p3CWtld1XmW4ZXJFx5IAN3CAlejfqeb0g6eAFk2zp0WCD
         bcS8HkE3rBRAI6wH4FhjAcdmIPfEvGfub6i+NNXPvnWv8EwIh6+4sed4N+Ie+UMEqC3O
         5vHbYY0T/ZBNGMJAsgar+ZX20zFQr4c8E8zo+jUzHc/IGtiENR3eM46Py8weuIUJFFDM
         U2mCsdqu6dIcQZsNmiW8JzKl1EdyqOVQ2FU8njSka3QvAff42ReZzzxVPCdcZsVXtOS5
         CZzccbSbfvpAkqo5KqvloC5NQGH4sLzHcCUOkLltmYb+6Oyk16dyp2MGIvRnUTTqbgRy
         Wh3g==
X-Gm-Message-State: ACrzQf2XOAOnvqla18OvCVZVWJDx4sZd6cA4nqF5sKPL/P0OmTa0sKWF
        foN2lYs6reN5RXZI7iNtILFBvw==
X-Google-Smtp-Source: AMsMyM7hhwlwgGRqkrSlb8k8bTqhsy6m3L3BTgcy2EFgVZwJvbZTev1f0ePX9YiutVAIEpKxIDEauA==
X-Received: by 2002:a05:6a00:2185:b0:520:7276:6570 with SMTP id h5-20020a056a00218500b0052072766570mr10823472pfi.84.1663964910977;
        Fri, 23 Sep 2022 13:28:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902710700b00176ae5c0f38sm6420511pll.178.2022.09.23.13.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 13:28:28 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org,
        "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alex Elder <elder@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Yonghong Song <yhs@fb.com>, Marco Elver <elver@google.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        intel-wired-lan@lists.osuosl.org, dev@openvswitch.org,
        x86@kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 09/16] coredump: Proactively round up to kmalloc bucket size
Date:   Fri, 23 Sep 2022 13:28:15 -0700
Message-Id: <20220923202822.2667581-10-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220923202822.2667581-1-keescook@chromium.org>
References: <20220923202822.2667581-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1167; h=from:subject; bh=pDNvsGLyQA8RpBfkkqJxHruRXSdA8gdZalovRqbX85w=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjLhbl/n4E1MQAIRbO7TQnliesxT9vRRUjnB997VqU NfNmMx2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYy4W5QAKCRCJcvTf3G3AJpnPD/ 9wQBqpy8w8j9Te2wEo0D0Hjxhxo55M1tuhtvCVgvJfQ/ry5sJ8eH8KM6rA1+i5+yyravM0DuBRah4g uhrc77nIoJb2kV7c8d7t1g4x8ALFz6XhAPkRpZqDiQcQBAvW8O9x3Cx08jWpK7nAg3/Y43225OKOB6 tVTYN27JCpBxTSSIqc4UFTMXN2IAlMQ5Ob/Zqv/+83XGkTWlJ6QhWxs83ZN6cbP38BNiVxIU8R4X4q w2vVsmNS7RSYF8P5DQihlKqCqmUoYEHbPbwmJ7+PuzAaQl9B925ePSW3sWLgeYKees47F1AL85pjZc FvVYlWbV8TxR5ah3RwNTZ38Wn7CZrVxE9cLyRCKZf3k1yiSPL97A/a4HIYBpAtaCVUIze1SOb44gG5 AeD/OBUhZfYjCqNQUMcrXaVEETtQEQyYObvDbWpjZMSgelJPeNBFTw4EHffM7FA71KwkU2YjesRYnu oDThnDhHv4KriQ3B5f+kESZJ2BjJePfLpOXMGt9bH1GXYnTKm2ZjNYVGmhOLx9jqiq7V9DNRZ8gtzJ iP1adulU4jNHuzcGVGv1REEmZUqTzrvgs4oy3VrE+j7gZBdT6IsTqQy5TPFC3tl2xHFdDR3KPEPqVf jCvjUcb44rcHyPLMelC6K/nXZ7kIHy17/M3xfiCKeCwJLqv86xQvXPgVl2QA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of discovering the kmalloc bucket size _after_ allocation, round
up proactively so the allocation is explicitly made for the full size,
allowing the compiler to correctly reason about the resulting size of
the buffer through the existing __alloc_size() hint.

Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/coredump.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 9f4aae202109..0894b2c35d98 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -68,7 +68,10 @@ struct core_name {
 
 static int expand_corename(struct core_name *cn, int size)
 {
-	char *corename = krealloc(cn->corename, size, GFP_KERNEL);
+	char *corename;
+
+	size = kmalloc_size_roundup(size);
+	corename = krealloc(cn->corename, size, GFP_KERNEL);
 
 	if (!corename)
 		return -ENOMEM;
@@ -76,7 +79,7 @@ static int expand_corename(struct core_name *cn, int size)
 	if (size > core_name_size) /* racy but harmless */
 		core_name_size = size;
 
-	cn->size = ksize(corename);
+	cn->size = size;
 	cn->corename = corename;
 	return 0;
 }
-- 
2.34.1

