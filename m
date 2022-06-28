Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BEA55E820
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 18:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347203AbiF1OrN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jun 2022 10:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347198AbiF1OrK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jun 2022 10:47:10 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919D42FFDA;
        Tue, 28 Jun 2022 07:47:09 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id e40so17956375eda.2;
        Tue, 28 Jun 2022 07:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dIIRV/7xVavrFkkRlTpxT9AeMVsp3yCltb4nZgV8P1s=;
        b=qGNxf1bADOzY0oaDCwYwIYCbj/BRm3RniW/mZ+asrY9SGcUIcMECDpkK4UtWVHbbDI
         fCTlTo9PM5Z/rnNmijNug+wKrLQyZLBzoX6ybPKlvv43gbiny9BsSkAJIG3upIUx3x3W
         rarZFrRNv45vuEAlWH1gssTuA8V4/O+63QgL2FF6YHq3cOYHXojGzN62fWS6zjnePhMf
         GWzoVxdZxCyCaCLXwLF/m4vtuanQ+uS+EBRDgXpzvHKuyvDDeJ0ORlKtatCryLvUHrwf
         LCEsHG8WNgcZbd/SRgDj7+g/IAxFd7IZ1970+2Y7o6NR+QKuIQZrG65jEUzaNKD3jqwA
         G8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dIIRV/7xVavrFkkRlTpxT9AeMVsp3yCltb4nZgV8P1s=;
        b=o7uFoEQaPE9b5GCcBhjzT5Nya6GRALbn3ibxoSiSnGdh5nzwaHhAA0Ja8GE8920KBB
         UGQWk1g3qqoGn7SfwYlLqmW/UDYDhM+IgKnkZPFaL/p4F18whPHRxIDxciCT7gPI7Yr8
         pMPadUyk8syzKfmwpBIYxsPD7ouFEmiTT81lWMvlyWV8v8KQdflsKWE8QccOA5lcHBaV
         KDNg+GMXVifXPbGEJJwqU1WGFFp5s/vHUuE57rS1imsaYvmMe9/Q8nBFh0Or0HYosxzN
         4qMzkBykxF0zfqxB6nI7s6AsUndyftm8gSp603e4R9h9SU3BjKrJehJkZoI0xzxK3Sn6
         UYSA==
X-Gm-Message-State: AJIora/aWOc4xAX2RAab0L08+R1mKasKRwXmKyhTFjCxEUj3qbdyBvjW
        aVlyoNw+fkwhwVwAaZDED9o=
X-Google-Smtp-Source: AGRyM1s8agwP30emipXMea2Yd5kcSZn4HD82LY6PSp7nDUobBq+OMJE80ZA0m5S5w638nDjHfKOKQw==
X-Received: by 2002:a05:6402:320f:b0:435:7236:e312 with SMTP id g15-20020a056402320f00b004357236e312mr23890254eda.115.1656427627929;
        Tue, 28 Jun 2022 07:47:07 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-98-182.retail.telecomitalia.it. [87.6.98.182])
        by smtp.gmail.com with ESMTPSA id v10-20020a1709063bca00b006ffa19b7782sm6450420ejf.74.2022.06.28.07.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 07:47:06 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "James E. J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        linux-parisc@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        David Sterba <dsterba@suse.cz>
Subject: [RESEND PATCH v4 1/2] highmem: Make __kunmap_{local,atomic}() take "const void *"
Date:   Tue, 28 Jun 2022 16:46:49 +0200
Message-Id: <20220628144649.28046-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627111927.3ef94745aab4491901d43028@linux-foundation.org>
References: <20220627111927.3ef94745aab4491901d43028@linux-foundation.org>
MIME-Version: 1.0
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

__kunmap_ {local,atomic}() currently take pointers to void. However, this
is semantically incorrect, since these functions do not change the memory
their arguments point to.

Therefore, make this semantics explicit by modifying the
__kunmap_{local,atomic}() prototypes to take pointers to const void.

As a side effect, compilers will likely produce more efficient code.

Cc: Andrew Morton <akpm@linux-foundation.org>
Suggested-by: David Sterba <dsterba@suse.cz>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

This is a resend of the same patch CC'ed to linux-mm.

v3->v4: Cc Maintainers and mailing lists I had overlooked when I sent v3.

v2->v3: Fix compilation errors for ARCH=parisc.
        Reported-by: kernel test robot <lkp@intel.com>

v1->v2: Change the commit message to clearly explain why these functions
        should require pointers to const void. The fundamental argument
        behind the commit message changes is semantic correctness.
        Obviously, there are no changes to the code.
        Many thanks to David Sterba and Ira Weiny for suggestions and
        reviews.

 arch/parisc/include/asm/cacheflush.h |  6 +++---
 arch/parisc/kernel/cache.c           |  2 +-
 include/linux/highmem-internal.h     | 10 +++++-----
 mm/highmem.c                         |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/parisc/include/asm/cacheflush.h b/arch/parisc/include/asm/cacheflush.h
index 8d03b3b26229..0bdee6724132 100644
--- a/arch/parisc/include/asm/cacheflush.h
+++ b/arch/parisc/include/asm/cacheflush.h
@@ -22,7 +22,7 @@ void flush_kernel_icache_range_asm(unsigned long, unsigned long);
 void flush_user_dcache_range_asm(unsigned long, unsigned long);
 void flush_kernel_dcache_range_asm(unsigned long, unsigned long);
 void purge_kernel_dcache_range_asm(unsigned long, unsigned long);
-void flush_kernel_dcache_page_asm(void *);
+void flush_kernel_dcache_page_asm(const void *addr);
 void flush_kernel_icache_page(void *);
 
 /* Cache flush operations */
@@ -31,7 +31,7 @@ void flush_cache_all_local(void);
 void flush_cache_all(void);
 void flush_cache_mm(struct mm_struct *mm);
 
-void flush_kernel_dcache_page_addr(void *addr);
+void flush_kernel_dcache_page_addr(const void *addr);
 
 #define flush_kernel_dcache_range(start,size) \
 	flush_kernel_dcache_range_asm((start), (start)+(size));
@@ -75,7 +75,7 @@ void flush_dcache_page_asm(unsigned long phys_addr, unsigned long vaddr);
 void flush_anon_page(struct vm_area_struct *vma, struct page *page, unsigned long vmaddr);
 
 #define ARCH_HAS_FLUSH_ON_KUNMAP
-static inline void kunmap_flush_on_unmap(void *addr)
+static inline void kunmap_flush_on_unmap(const void *addr)
 {
 	flush_kernel_dcache_page_addr(addr);
 }
diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index a9bc578e4c52..993999a65e54 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -549,7 +549,7 @@ extern void purge_kernel_dcache_page_asm(unsigned long);
 extern void clear_user_page_asm(void *, unsigned long);
 extern void copy_user_page_asm(void *, void *, unsigned long);
 
-void flush_kernel_dcache_page_addr(void *addr)
+void flush_kernel_dcache_page_addr(const void *addr)
 {
 	unsigned long flags;
 
diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
index cddb42ff0473..034b1106d022 100644
--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -8,7 +8,7 @@
 #ifdef CONFIG_KMAP_LOCAL
 void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot);
 void *__kmap_local_page_prot(struct page *page, pgprot_t prot);
-void kunmap_local_indexed(void *vaddr);
+void kunmap_local_indexed(const void *vaddr);
 void kmap_local_fork(struct task_struct *tsk);
 void __kmap_local_sched_out(void);
 void __kmap_local_sched_in(void);
@@ -89,7 +89,7 @@ static inline void *kmap_local_pfn(unsigned long pfn)
 	return __kmap_local_pfn_prot(pfn, kmap_prot);
 }
 
-static inline void __kunmap_local(void *vaddr)
+static inline void __kunmap_local(const void *vaddr)
 {
 	kunmap_local_indexed(vaddr);
 }
@@ -121,7 +121,7 @@ static inline void *kmap_atomic_pfn(unsigned long pfn)
 	return __kmap_local_pfn_prot(pfn, kmap_prot);
 }
 
-static inline void __kunmap_atomic(void *addr)
+static inline void __kunmap_atomic(const void *addr)
 {
 	kunmap_local_indexed(addr);
 	pagefault_enable();
@@ -197,7 +197,7 @@ static inline void *kmap_local_pfn(unsigned long pfn)
 	return kmap_local_page(pfn_to_page(pfn));
 }
 
-static inline void __kunmap_local(void *addr)
+static inline void __kunmap_local(const void *addr)
 {
 #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
 	kunmap_flush_on_unmap(addr);
@@ -224,7 +224,7 @@ static inline void *kmap_atomic_pfn(unsigned long pfn)
 	return kmap_atomic(pfn_to_page(pfn));
 }
 
-static inline void __kunmap_atomic(void *addr)
+static inline void __kunmap_atomic(const void *addr)
 {
 #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
 	kunmap_flush_on_unmap(addr);
diff --git a/mm/highmem.c b/mm/highmem.c
index 1a692997fac4..e32083e4ce0d 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -561,7 +561,7 @@ void *__kmap_local_page_prot(struct page *page, pgprot_t prot)
 }
 EXPORT_SYMBOL(__kmap_local_page_prot);
 
-void kunmap_local_indexed(void *vaddr)
+void kunmap_local_indexed(const void *vaddr)
 {
 	unsigned long addr = (unsigned long) vaddr & PAGE_MASK;
 	pte_t *kmap_pte;
-- 
2.36.1

