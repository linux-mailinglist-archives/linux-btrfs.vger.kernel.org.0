Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C1054EBD3
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 23:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378874AbiFPVBE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jun 2022 17:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378853AbiFPVA6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jun 2022 17:00:58 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858486006D;
        Thu, 16 Jun 2022 14:00:57 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q9so3334345wrd.8;
        Thu, 16 Jun 2022 14:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ctsqZuUzxRCwxqBgZBzx2nceNY0pnJin6UVVoxtwPI=;
        b=TFuAhc2wHssi4VbHmuNIWACAc6PVJKDke0ZcB0HlJda2s/NWstByXVggMXwaI5IVmV
         sfej9qCWbl3PTsOyuqBq5KptYREndUjusqNjcGnd5UQ5wm5Hz4ltVKzYp4yoVh1S2Q6k
         eEZYk15Km6mjLRUVQVP60zQ7X0ch78qpfwAYqFA1nsL74H5a3OPwYdqHePwBIHokP5RK
         p+9/zhmZIVHiYxFWVhcZ7ETF3omadMgrc+HZzrtIEGUxRWVBY0VbzNQ4jy+iBsvTm2Uz
         Wp4aqpraCnVKn673HDw3NfAPf1PAULTOGEkmiMwFJuYeM1RR6RpI08WaKNBOdBUsb25f
         +vBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ctsqZuUzxRCwxqBgZBzx2nceNY0pnJin6UVVoxtwPI=;
        b=j2l1o3OD6bu2cG/1/WouFQ2X0AYJDzTxrDhgTKCtptkSoUsr9yl3R6n2bQKPUPJNDt
         8T8FN2/oRDqCWRzzLHGVTCFKPn4nKBLT1AIvve0m+Oad00wilcvfCp/zGtgnaS8X5e2I
         oHeowayAOUSWTwTwtPb3Dl2HuPYb+k3bvqmDZLpEBbYODi82Vc68LhkeA5qXnmow1uFN
         3Wq0dXJM4fF+/fBQAzs9L/cA9JclzBFAe0SD0OZTNqqCBMHqxOi7D/UFUSDv3qrY3LPH
         eloUbfJBE0XqChd+NqdCloaQofbZLpqA+coaz9fZjGT43vzq4jSlDBtbo2wMWlvSXGnH
         Ac6A==
X-Gm-Message-State: AJIora8KDMkRzGAizZpC7lSx72ccyUEN4ARmIY1IbqdpuLv2r1kKlcKq
        Mujll19OHVMAziAPurVuKz4=
X-Google-Smtp-Source: AGRyM1ta7Ymwb82cxivEWtpT2Hev3g1A0ZThnWm4Ak6ZqFxCeL5reYDpWA0FAOhadFTQ3DYORM5niQ==
X-Received: by 2002:a05:6000:1110:b0:210:3e7f:6776 with SMTP id z16-20020a056000111000b002103e7f6776mr6077806wrw.597.1655413256024;
        Thu, 16 Jun 2022 14:00:56 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-98-182.retail.telecomitalia.it. [87.6.98.182])
        by smtp.gmail.com with ESMTPSA id bt28-20020a056000081c00b0020fcc655e4asm2658043wrb.5.2022.06.16.14.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 14:00:54 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        linux-parisc@vger.kernel.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        David Sterba <dsterba@suse.cz>
Subject: [RESEND PATCH v4 1/2] highmem: Make __kunmap_{local,atomic}() take "const void *"
Date:   Thu, 16 Jun 2022 23:00:35 +0200
Message-Id: <20220616210037.7060-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220616210037.7060-1-fmdefrancesco@gmail.com>
References: <20220616210037.7060-1-fmdefrancesco@gmail.com>
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

Therefore, make this semantics explicit by modifying the prototypes of
__kunmap_{local,atomic}() to take pointers to const void.

As a side effect, compilers will likely produce more efficient code.

Cc: Andrew Morton <akpm@linux-foundation.org>
Suggested-by: David Sterba <dsterba@suse.cz>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

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
index c8a11fcecf4c..824064cafd61 100644
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

