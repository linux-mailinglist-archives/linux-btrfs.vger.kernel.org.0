Return-Path: <linux-btrfs+bounces-6651-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 287DF939CB8
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jul 2024 10:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E6A1F228D0
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jul 2024 08:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945A714BF89;
	Tue, 23 Jul 2024 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cQx+gVTP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C1514AD3B
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Jul 2024 08:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721723587; cv=none; b=LZfLCVyKZrZS7Vo23Wd7KptiISHHNL0QDcifeF0kKvd0Ph8U4LIaKdv75YjwJ7uW+cUcRha4WEZn8Xw8IbtG/YnNnFVw7xxxQORdy0a0UHPrf5r2IKa1RmSHaMXz5c/sxvmixvZwmeg3I6L5uX/lbnTioASFngT+OjTo2q0axWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721723587; c=relaxed/simple;
	bh=16C3qOghK8TaOTax2+QAysgUWXWtYbusUjh2y2kiDPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BoBo1uFY58ibIItjcfnM/TksxJW8UaC3Wm/2vdbP0Jc7AsGU9hOLrzlciwHAiMVSrVU8t3BXfX7hFnZVQLJJoTPwy44KaU76ykcNXtlS+1oFSB4CoDZJ0FZZLZ9wEpyZbOx4rEYl8/cmLmtNxidEer3X54xy373fxL6tE80dQZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cQx+gVTP; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: arnd@arndb.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721723584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3VCZOZWRmGd8xL5SN+J0EY1zI5GAsbkGIgLsBKI32rY=;
	b=cQx+gVTPFpYaKvaHYXeReUXRhKDPTWx/sb5DeYOwR8gRsNRrwJFY99FHH1UzFuoA6giSAU
	/S7ZkQOGJ63xrCh96+rIE9S1wWbRPni1uyscrvGEAXhmVxohVvd7OpcuqyO8XTXotjZH2w
	UFvUkVqKYobrZYhSNeojetonj1chNhg=
X-Envelope-To: mcgrof@kernel.org
X-Envelope-To: clm@fb.com
X-Envelope-To: josef@toxicpanda.com
X-Envelope-To: dsterba@suse.com
X-Envelope-To: tytso@mit.edu
X-Envelope-To: adilger.kernel@dilger.ca
X-Envelope-To: jaegeuk@kernel.org
X-Envelope-To: chao@kernel.org
X-Envelope-To: hch@infradead.org
X-Envelope-To: linux-arch@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-modules@vger.kernel.org
X-Envelope-To: linux-btrfs@vger.kernel.org
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: linux-f2fs-devel@lists.sourceforge.net
X-Envelope-To: youling.tang@linux.dev
X-Envelope-To: tangyouling@kylinos.cn
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
To: Arnd Bergmann <arnd@arndb.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	tytso@mit.edu,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH 1/4] module: Add module_subinit{_noexit} and module_subeixt helper macros
Date: Tue, 23 Jul 2024 16:32:36 +0800
Message-Id: <20240723083239.41533-2-youling.tang@linux.dev>
In-Reply-To: <20240723083239.41533-1-youling.tang@linux.dev>
References: <20240723083239.41533-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

In theory init/exit should match their sequence, thus normally they should
look like this:
-------------------------+------------------------
    init_A();            |
    init_B();            |
    init_C();            |
                         |   exit_C();
                         |   exit_B();
                         |   exit_A();

Providing module_subinit{_noexit} and module_subeixt helps macros ensure
that modules init/exit match their order, while also simplifying the code.

The three macros are defined as follows:
- module_subinit(initfn, exitfn,rollback)
- module_subinit_noexit(initfn, rollback)
- module_subexit(rollback)

`initfn` is the initialization function and `exitfn` is the corresponding
exit function.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 include/asm-generic/vmlinux.lds.h |  5 +++
 include/linux/init.h              | 62 ++++++++++++++++++++++++++++++-
 include/linux/module.h            | 22 +++++++++++
 3 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 677315e51e54..48ccac7c6448 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -927,6 +927,10 @@
 		INIT_CALLS_LEVEL(7)					\
 		__initcall_end = .;
 
+#define SUBINIT_CALL							\
+		*(.subinitcall.init)					\
+		*(.subexitcall.exit)
+
 #define CON_INITCALL							\
 	BOUNDED_SECTION_POST_LABEL(.con_initcall.init, __con_initcall, _start, _end)
 
@@ -1155,6 +1159,7 @@
 		INIT_DATA						\
 		INIT_SETUP(initsetup_align)				\
 		INIT_CALLS						\
+		SUBINIT_CALL						\
 		CON_INITCALL						\
 		INIT_RAM_FS						\
 	}
diff --git a/include/linux/init.h b/include/linux/init.h
index ee1309473bc6..e8689ff2cb6c 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -55,6 +55,9 @@
 #define __exitdata	__section(".exit.data")
 #define __exit_call	__used __section(".exitcall.exit")
 
+#define __subinit_call	__used __section(".subinitcall.init")
+#define __subexit_call	__used __section(".subexitcall.exit")
+
 /*
  * modpost check for section mismatches during the kernel build.
  * A section mismatch happens when there are references from a
@@ -115,6 +118,9 @@
 typedef int (*initcall_t)(void);
 typedef void (*exitcall_t)(void);
 
+typedef int (*subinitcall_t)(void);
+typedef void (*subexitcall_t)(void);
+
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
 typedef int initcall_entry_t;
 
@@ -183,7 +189,61 @@ extern struct module __this_module;
 #endif
 
 #endif
-  
+
+#ifndef __ASSEMBLY__
+struct subexitcall_rollback {
+	/*
+	 * Records the address of the first sub-initialization function in the
+	 * ".subexitcall.exit" section
+	 */
+	unsigned long first_addr;
+	int ncalls;
+};
+
+static inline void __subexitcall_rollback(struct subexitcall_rollback *r)
+{
+	unsigned long addr = r->first_addr - sizeof(r->first_addr) * (r->ncalls - 1);
+
+	for (; r->ncalls--; addr += sizeof(r->first_addr)) {
+		unsigned long *tmp = (void *)addr;
+		subexitcall_t fn = (subexitcall_t)*tmp;
+		fn();
+	}
+}
+
+static inline void set_rollback_ncalls(struct subexitcall_rollback *r)
+{
+	r->ncalls++;
+}
+
+static inline void set_rollback_first_addr(struct subexitcall_rollback *rollback,
+					   unsigned long addr)
+{
+	if (!rollback->first_addr)
+		rollback->first_addr = addr;
+}
+
+#define __subinitcall_noexit(initfn, rollback)					\
+do {										\
+	static subinitcall_t __subinitcall_##initfn __subinit_call = initfn;	\
+	int _ret;								\
+	_ret = initfn();							\
+	if (_ret < 0) {								\
+		__subexitcall_rollback(rollback);				\
+		return _ret;							\
+	}									\
+} while (0)
+
+#define __subinitcall(initfn, exitfn, rollback)						\
+do {											\
+	static subexitcall_t __subexitcall_##exitfn __subexit_call = exitfn;		\
+	set_rollback_first_addr(rollback, (unsigned long)&__subexitcall_##exitfn);	\
+	__subinitcall_noexit(initfn, rollback);						\
+	set_rollback_ncalls(rollback);							\
+} while (0)
+
+#endif /* !__ASSEMBLY__ */
+
 #ifndef MODULE
 
 #ifndef __ASSEMBLY__
diff --git a/include/linux/module.h b/include/linux/module.h
index 4213d8993cd8..95f7c60dede9 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -76,6 +76,28 @@ extern struct module_attribute module_uevent;
 extern int init_module(void);
 extern void cleanup_module(void);
 
+/*
+ * module_subinit() - Called when the driver is subinitialized
+ * @initfn: The subinitialization function that is called
+ * @exitfn: Corresponding exit function
+ * @rollback: Record information when the subinitialization failed
+ *            or the driver was removed
+ *
+ * Use module_subinit_noexit() when there is only an subinitialization
+ * function but no corresponding exit function.
+ */
+#define module_subinit(initfn, exitfn, rollback)	\
+	__subinitcall(initfn, exitfn, rollback);
+
+#define module_subinit_noexit(initfn, rollback)		\
+	__subinitcall_noexit(initfn, rollback);
+
+/*
+ * module_subexit() - Called when the driver exits
+ */
+#define module_subexit(rollback)			\
+	__subexitcall_rollback(rollback);
+
 #ifndef MODULE
 /**
  * module_init() - driver initialization entry point
-- 
2.34.1


