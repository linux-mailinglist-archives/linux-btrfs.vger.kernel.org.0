Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462EF79AE9F
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 01:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355622AbjIKWBb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236455AbjIKKlD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 06:41:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A06E5F
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 03:40:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 62FE12185A
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 10:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694428856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hhAqB477ZX34d2b5Zk99+GOdX/Svz9FDHJqV4Godxro=;
        b=jyk555ZEyaonIBmBdeVgUDK9oMLSax0LNJ4XYJakaYl4Kekfj0GLx55O4AtUhAdAIB5bxG
        /NqpMjFsYgle4Z8VNGKRS3VAYDy5DT2r60K931HQLr5S6NH6fsTjnefEZp/+ID9XhFsyvN
        jc3EZrmE4J4i7yeW/tMx2VbuRwfYS+4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A77313780
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 10:40:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AJVtArfu/mQPTwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 10:40:55 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: pull in the full max/min/clamp implementation from kernel
Date:   Mon, 11 Sep 2023 20:10:32 +0930
Message-ID: <6492b29d21c7ac12eb52255ff577e4e6d7e10c0d.1694428549.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1694428549.git.wqu@suse.com>
References: <cover.1694428549.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The current implementation would introduce variable shadowing due to
both max() and min() are using the same __x and __y.

This may not be a big deal, but since kernel is already handling it
properly using __UNIQUE_ID() macro, and has more checks, we can
cross-port the kernel version to btrfs-progs.

There are some dependency needed, they are all small enough thus can be
put into the helper.

- __PASTE()
- __UNIQUE_ID()
- BUILD_BUG_ON_ZERO()
- __is_constexpr()

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/internal.h            | 147 +++++++++++++++++++++++++++++++----
 kernel-shared/async-thread.c |   2 +-
 2 files changed, 131 insertions(+), 18 deletions(-)

diff --git a/common/internal.h b/common/internal.h
index 81729964d3c7..33295a194dad 100644
--- a/common/internal.h
+++ b/common/internal.h
@@ -16,31 +16,144 @@
  * Boston, MA 021110-1307, USA.
  */
 
+/*
+ * All those macros are cross-ported from kernel's include/linux/minmax.h, with needed
+ * dependency put here directly.
+ */
+
 #ifndef __INTERNAL_H__
 #define __INTERNAL_H__
 
+/* Indirect macros required for expanded argument pasting, eg. __LINE__. */
+#define ___PASTE(a,b) a##b
+#define __PASTE(a,b) ___PASTE(a,b)
+
+/* Not-quite-unique ID. */
+#ifndef __UNIQUE_ID
+# define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __LINE__)
+#endif
+
+#ifdef __CHECKER__
+#define BUILD_BUG_ON_ZERO(e) (0)
+#else /* __CHECKER__ */
 /*
- * max/min macro
+ * Force a compilation error if condition is true, but also produce a
+ * result (of value 0 and type int), so the expression can be used
+ * e.g. in a structure initializer (or where-ever else comma expressions
+ * aren't permitted).
  */
-#define min(x,y) ({ \
-	typeof(x) _x = (x);	\
-	typeof(y) _y = (y);	\
-	(void) (&_x == &_y);		\
-	_x < _y ? _x : _y; })
+#define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
+#endif /* __CHECKER__ */
 
-#define max(x,y) ({ \
-	typeof(x) _x = (x);	\
-	typeof(y) _y = (y);	\
-	(void) (&_x == &_y);		\
-	_x > _y ? _x : _y; })
+/*
+ * This returns a constant expression while determining if an argument is
+ * a constant expression, most importantly without evaluating the argument.
+ * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
+ */
+#define __is_constexpr(x) \
+	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
 
-#define min_t(type,x,y) \
-	({ type __x = (x); type __y = (y); __x < __y ? __x: __y; })
-#define max_t(type,x,y) \
-	({ type __x = (x); type __y = (y); __x > __y ? __x: __y; })
+/*
+ * min()/max()/clamp() macros must accomplish three things:
+ *
+ * - avoid multiple evaluations of the arguments (so side-effects like
+ *   "x++" happen only once) when non-constant.
+ * - perform strict type-checking (to generate warnings instead of
+ *   nasty runtime surprises). See the "unnecessary" pointer comparison
+ *   in __typecheck().
+ * - retain result as a constant expressions when called with only
+ *   constant expressions (to avoid tripping VLA warnings in stack
+ *   allocation usage).
+ */
+#define __typecheck(x, y) \
+	(!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
 
-#define clamp_t(type, val, lo, hi) min_t(type, max_t(type, val, lo), hi)
+#define __no_side_effects(x, y) \
+		(__is_constexpr(x) && __is_constexpr(y))
 
-#define clamp_val(val, lo, hi) clamp_t(typeof(val), val, lo, hi)
+#define __safe_cmp(x, y) \
+		(__typecheck(x, y) && __no_side_effects(x, y))
+
+#define __cmp(x, y, op)	((x) op (y) ? (x) : (y))
+
+#define __cmp_once(x, y, unique_x, unique_y, op) ({	\
+		typeof(x) unique_x = (x);		\
+		typeof(y) unique_y = (y);		\
+		__cmp(unique_x, unique_y, op); })
+
+#define __careful_cmp(x, y, op) \
+	__builtin_choose_expr(__safe_cmp(x, y), \
+		__cmp(x, y, op), \
+		__cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
+
+#define __clamp(val, lo, hi)	\
+	((val) >= (hi) ? (hi) : ((val) <= (lo) ? (lo) : (val)))
+
+#define __clamp_once(val, lo, hi, unique_val, unique_lo, unique_hi) ({	\
+		typeof(val) unique_val = (val);				\
+		typeof(lo) unique_lo = (lo);				\
+		typeof(hi) unique_hi = (hi);				\
+		__clamp(unique_val, unique_lo, unique_hi); })
+
+#define __clamp_input_check(lo, hi)					\
+        (BUILD_BUG_ON_ZERO(__builtin_choose_expr(			\
+                __is_constexpr((lo) > (hi)), (lo) > (hi), false)))
+
+#define __careful_clamp(val, lo, hi) ({					\
+	__clamp_input_check(lo, hi) +					\
+	__builtin_choose_expr(__typecheck(val, lo) && __typecheck(val, hi) && \
+			      __typecheck(hi, lo) && __is_constexpr(val) && \
+			      __is_constexpr(lo) && __is_constexpr(hi),	\
+		__clamp(val, lo, hi),					\
+		__clamp_once(val, lo, hi, __UNIQUE_ID(__val),		\
+			     __UNIQUE_ID(__lo), __UNIQUE_ID(__hi))); })
+
+/**
+ * min - return minimum of two values of the same or compatible types
+ * @x: first value
+ * @y: second value
+ */
+#define min(x, y)	__careful_cmp(x, y, <)
+
+/**
+ * max - return maximum of two values of the same or compatible types
+ * @x: first value
+ * @y: second value
+ */
+#define max(x, y)	__careful_cmp(x, y, >)
+
+/**
+ * clamp - return a value clamped to a given range with strict typechecking
+ * @val: current value
+ * @lo: lowest allowable value
+ * @hi: highest allowable value
+ *
+ * This macro does strict typechecking of @lo/@hi to make sure they are of the
+ * same type as @val.  See the unnecessary pointer comparisons.
+ */
+#define clamp(val, lo, hi) __careful_clamp(val, lo, hi)
+
+/*
+ * ..and if you can't take the strict
+ * types, you can specify one yourself.
+ *
+ * Or not use min/max/clamp at all, of course.
+ */
+
+/**
+ * min_t - return minimum of two values, using the specified type
+ * @type: data type to use
+ * @x: first value
+ * @y: second value
+ */
+#define min_t(type, x, y)	__careful_cmp((type)(x), (type)(y), <)
+
+/**
+ * max_t - return maximum of two values, using the specified type
+ * @type: data type to use
+ * @x: first value
+ * @y: second value
+ */
+#define max_t(type, x, y)	__careful_cmp((type)(x), (type)(y), >)
 
 #endif
diff --git a/kernel-shared/async-thread.c b/kernel-shared/async-thread.c
index ed235afdf215..db8870f9ae11 100644
--- a/kernel-shared/async-thread.c
+++ b/kernel-shared/async-thread.c
@@ -159,7 +159,7 @@ static inline void thresh_exec_hook(struct btrfs_workqueue *wq)
 		new_current_active++;
 	if (pending < wq->thresh / 2)
 		new_current_active--;
-	new_current_active = clamp_val(new_current_active, 1, wq->limit_active);
+	new_current_active = clamp(new_current_active, 1, wq->limit_active);
 	if (new_current_active != wq->current_active)  {
 		need_change = 1;
 		wq->current_active = new_current_active;
-- 
2.42.0

