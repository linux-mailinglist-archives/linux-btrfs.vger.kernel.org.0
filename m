Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1AF568687
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jul 2022 13:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbiGFLPf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jul 2022 07:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbiGFLPc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jul 2022 07:15:32 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A775B27CFF;
        Wed,  6 Jul 2022 04:15:31 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id cl1so21586920wrb.4;
        Wed, 06 Jul 2022 04:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/NoGihGglllHOrI9iplyTzbn10ta3Cg0gKoqCUXt7Pg=;
        b=jedl9OaLrhvlMSijCa3fqTIeRWDoSeNtzBf1lPOl9u36IyUunoaJyePUfdb6e9prZK
         HMuZzSTsQWfXhdfwr9pVwN0lSo+QUqs86Jwge4hS4gf3/DS6m0RqEONGeAg+ehldHcA5
         O3wEIIo05I/GF0kBJG8inlP+EQjdmhWiHkO8cHU1/4jYotUSSbiozooVa3zWr2nH9O9a
         iMyu+uJcVSTLF675I79osE8Tzn8SDUXVp0p/eLHF0G/iFSqynWC/QyAV9W8622rUdRbt
         m8gar2esyISHsZ8b21dOIgM/V1QQHfHXiCMlzwQN8dZkyThQeyxqMZSh/xULUhWQTPnO
         B1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/NoGihGglllHOrI9iplyTzbn10ta3Cg0gKoqCUXt7Pg=;
        b=z+OqwfuWMsshfuOAZ+rC/pWV8d/U3jsXuZPyFtDU1WF0b45ku7bdp0jX4B9yzUDdLm
         q6dtV9yXeOAdjx/s6x5KmwLoI9/HlQOw9QUEQhh+p2bMw5sZgtc9uLgffxxvwbekpDaK
         3QY4dwsAAr0hN4boDRUZ32DQ9MiKZezrgTVTJfhacOex126pIH4xhHsjWfHHiUcYiTRU
         qlmg7AGUI5WHrmFLFT0+NsrFCE/pjjSYMJlOYcn/e5snlMIjHM0/YUb3QUo8MplmYlgl
         5H+tS6NY0LZ+CY6pH5lmsYHMX5+ZhPjJZDW25HJOxwZ9IvUaSF9HpDvum4RJD3HEQzzK
         CiSg==
X-Gm-Message-State: AJIora8S6+XbkEXFis33UROi9mmzDu97Qh20DtaZJQ2PtXqGjZDafYRP
        lttgNlgBSOOPszFQlniG3rQ=
X-Google-Smtp-Source: AGRyM1vTkZWX4J5ZaynVafZzoUbGrWrFkQ4MDBLbLLn7b5Oh/yP+cm3dGSwX9NK7KBdxAE5QVRi4pQ==
X-Received: by 2002:a5d:584c:0:b0:21c:1395:f0c4 with SMTP id i12-20020a5d584c000000b0021c1395f0c4mr36548584wrf.24.1657106130188;
        Wed, 06 Jul 2022 04:15:30 -0700 (PDT)
Received: from localhost.localdomain (host-79-53-109-127.retail.telecomitalia.it. [79.53.109.127])
        by smtp.gmail.com with ESMTPSA id k1-20020adff5c1000000b0020d07d90b71sm34830696wrp.66.2022.07.06.04.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 04:15:28 -0700 (PDT)
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
Subject: [PATCH v6 1/2] highmem: Make __kunmap_{local,atomic}() take "const void *"
Date:   Wed,  6 Jul 2022 13:15:19 +0200
Message-Id: <20220706111520.12858-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220706111520.12858-1-fmdefrancesco@gmail.com>
References: <20220706111520.12858-1-fmdefrancesco@gmail.com>
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
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
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

