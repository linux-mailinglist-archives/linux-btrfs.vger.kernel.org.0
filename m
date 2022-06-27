Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A6055CE24
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 15:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239813AbiF0RCi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jun 2022 13:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239161AbiF0RCh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jun 2022 13:02:37 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0026C12090;
        Mon, 27 Jun 2022 10:02:35 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id o10so13998607edi.1;
        Mon, 27 Jun 2022 10:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b4uPhYJvFz/g+C9k3Fn9GcbJYJZ+36h5lm4GFR6WiWY=;
        b=IgHa3PsH8zSKyhq7Rwmb2RqR1Ery52etIx/5ocY0OJEbWFAGfhL30zVAIYauycb4Vb
         7X2USgJQxUzrfCQXLbtCFOEERQ8nWg7Z+ogn8TYROX8bQa0KhoW+wVFwHNpdZCINyGDj
         5zLBu6di+2fFaXuBBxHR9IdBRSVVTHw9pPKw99zMDZ+wU5QZnrgGwCa2BqrK11j06QIZ
         qLDNKh2GHYvCf71//7CgXraVCNLnn0sfYk2izL3LAF03EttvPlQAHVkt8d6jiDzE06U7
         65s85RbCPDizS/rerF9Dy6Yc71+xXki4aNQ2o3Yh8XvyrCBnYQfiEPTcRLlK79FGdmFF
         5N3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b4uPhYJvFz/g+C9k3Fn9GcbJYJZ+36h5lm4GFR6WiWY=;
        b=6lRly51qNIZgBaBsBZq/HPZKtKrTLbVPljhhAXM6b2uPJf/N27+bN9vZQGaHPQ50qd
         K0vCfIav2MfefjjbgStOviFRwwYtc+FKA84H7tIg+QneeM33UsGdezn4tLHkzP7Ih/PV
         F0byOVobypUPzb/t8+hXcZ6OB86aFyHPY/2x05ScshJi+2XjDZvsBgAZ9SZmSDzMPKfc
         Vedb/2e11+nOQfo3lIOyTptic5ZUPY0RSHzvHXgtYkLKjQIU75y7iOnlw17sy8p2jHOo
         mzCqxC85TQaHSSn5BL2GnesDBK6+9cI17KKncunWzfkvMg7PLmj7gnpht4dXthSY7gZD
         1y0A==
X-Gm-Message-State: AJIora+u4IRrj0alinArqDd6mDnozCMIkzVbK0qbT9k6l4uPkLkpdZDi
        81nYRO+GA59p++W7eV8GKc8=
X-Google-Smtp-Source: AGRyM1vAeotP6mrOtJ7asAIflldAIm1WxyGeOvIIOVbqET1+NOoONwOIBuOwPNPGG+xRrvTRJw63ag==
X-Received: by 2002:a05:6402:1459:b0:437:9282:2076 with SMTP id d25-20020a056402145900b0043792822076mr7617213edx.6.1656349354543;
        Mon, 27 Jun 2022 10:02:34 -0700 (PDT)
Received: from opensuse.localnet (host-87-6-98-182.retail.telecomitalia.it. [87.6.98.182])
        by smtp.gmail.com with ESMTPSA id co6-20020a0564020c0600b0042dd022787esm7927777edb.6.2022.06.27.10.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 10:02:32 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     David Sterba <dsterba@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        linux-parisc@vger.kernel.org, David Sterba <dsterba@suse.cz>
Subject: Re: [RESEND PATCH v4 1/2] highmem: Make __kunmap_{local,atomic}() take "const void *"
Date:   Mon, 27 Jun 2022 19:02:31 +0200
Message-ID: <2192593.iZASKD2KPV@opensuse>
In-Reply-To: <20220616210037.7060-2-fmdefrancesco@gmail.com>
References: <20220616210037.7060-1-fmdefrancesco@gmail.com> <20220616210037.7060-2-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On gioved=C3=AC 16 giugno 2022 23:00:35 CEST Fabio M. De Francesco wrote:
> __kunmap_ {local,atomic}() currently take pointers to void. However, this
> is semantically incorrect, since these functions do not change the memory
> their arguments point to.
>=20
> Therefore, make this semantics explicit by modifying the prototypes of
> __kunmap_{local,atomic}() to take pointers to const void.
>=20
> As a side effect, compilers will likely produce more efficient code.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Suggested-by: David Sterba <dsterba@suse.cz>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>=20
> v3->v4: Cc Maintainers and mailing lists I had overlooked when I sent v3.
>=20
> v2->v3: Fix compilation errors for ARCH=3Dparisc.
>         Reported-by: kernel test robot <lkp@intel.com>
>=20
> v1->v2: Change the commit message to clearly explain why these functions
>         should require pointers to const void. The fundamental argument
>         behind the commit message changes is semantic correctness.
>         Obviously, there are no changes to the code.
>         Many thanks to David Sterba and Ira Weiny for suggestions and
>         reviews.
>
>  arch/parisc/include/asm/cacheflush.h |  6 +++---
>  arch/parisc/kernel/cache.c           |  2 +-
>  include/linux/highmem-internal.h     | 10 +++++-----
>  mm/highmem.c                         |  2 +-
>  4 files changed, 10 insertions(+), 10 deletions(-)

@Andrew:

Ira Weiny asked David Sterba for taking this patch through his tree because=
=20
it is a pre-requisite for a patch to fs/btrfs. He agreed with the above-
mentioned suggestion, however I suppose that an ACK by you is needed.

Can you please take a look at this patch and say what you think about it?

Thanks,

=46abio

>=20
> diff --git a/arch/parisc/include/asm/cacheflush.h b/arch/parisc/include/
asm/cacheflush.h
> index 8d03b3b26229..0bdee6724132 100644
> --- a/arch/parisc/include/asm/cacheflush.h
> +++ b/arch/parisc/include/asm/cacheflush.h
> @@ -22,7 +22,7 @@ void flush_kernel_icache_range_asm(unsigned long,=20
unsigned long);
>  void flush_user_dcache_range_asm(unsigned long, unsigned long);
>  void flush_kernel_dcache_range_asm(unsigned long, unsigned long);
>  void purge_kernel_dcache_range_asm(unsigned long, unsigned long);
> -void flush_kernel_dcache_page_asm(void *);
> +void flush_kernel_dcache_page_asm(const void *addr);
>  void flush_kernel_icache_page(void *);
> =20
>  /* Cache flush operations */
> @@ -31,7 +31,7 @@ void flush_cache_all_local(void);
>  void flush_cache_all(void);
>  void flush_cache_mm(struct mm_struct *mm);
> =20
> -void flush_kernel_dcache_page_addr(void *addr);
> +void flush_kernel_dcache_page_addr(const void *addr);
> =20
>  #define flush_kernel_dcache_range(start,size) \
>  	flush_kernel_dcache_range_asm((start), (start)+(size));
> @@ -75,7 +75,7 @@ void flush_dcache_page_asm(unsigned long phys_addr,=20
unsigned long vaddr);
>  void flush_anon_page(struct vm_area_struct *vma, struct page *page,=20
unsigned long vmaddr);
> =20
>  #define ARCH_HAS_FLUSH_ON_KUNMAP
> -static inline void kunmap_flush_on_unmap(void *addr)
> +static inline void kunmap_flush_on_unmap(const void *addr)
>  {
>  	flush_kernel_dcache_page_addr(addr);
>  }
> diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
> index c8a11fcecf4c..824064cafd61 100644
> --- a/arch/parisc/kernel/cache.c
> +++ b/arch/parisc/kernel/cache.c
> @@ -549,7 +549,7 @@ extern void purge_kernel_dcache_page_asm(unsigned=20
long);
>  extern void clear_user_page_asm(void *, unsigned long);
>  extern void copy_user_page_asm(void *, void *, unsigned long);
> =20
> -void flush_kernel_dcache_page_addr(void *addr)
> +void flush_kernel_dcache_page_addr(const void *addr)
>  {
>  	unsigned long flags;
> =20
> diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-
internal.h
> index cddb42ff0473..034b1106d022 100644
> --- a/include/linux/highmem-internal.h
> +++ b/include/linux/highmem-internal.h
> @@ -8,7 +8,7 @@
>  #ifdef CONFIG_KMAP_LOCAL
>  void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot);
>  void *__kmap_local_page_prot(struct page *page, pgprot_t prot);
> -void kunmap_local_indexed(void *vaddr);
> +void kunmap_local_indexed(const void *vaddr);
>  void kmap_local_fork(struct task_struct *tsk);
>  void __kmap_local_sched_out(void);
>  void __kmap_local_sched_in(void);
> @@ -89,7 +89,7 @@ static inline void *kmap_local_pfn(unsigned long pfn)
>  	return __kmap_local_pfn_prot(pfn, kmap_prot);
>  }
> =20
> -static inline void __kunmap_local(void *vaddr)
> +static inline void __kunmap_local(const void *vaddr)
>  {
>  	kunmap_local_indexed(vaddr);
>  }
> @@ -121,7 +121,7 @@ static inline void *kmap_atomic_pfn(unsigned long=20
pfn)
>  	return __kmap_local_pfn_prot(pfn, kmap_prot);
>  }
> =20
> -static inline void __kunmap_atomic(void *addr)
> +static inline void __kunmap_atomic(const void *addr)
>  {
>  	kunmap_local_indexed(addr);
>  	pagefault_enable();
> @@ -197,7 +197,7 @@ static inline void *kmap_local_pfn(unsigned long pfn)
>  	return kmap_local_page(pfn_to_page(pfn));
>  }
> =20
> -static inline void __kunmap_local(void *addr)
> +static inline void __kunmap_local(const void *addr)
>  {
>  #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
>  	kunmap_flush_on_unmap(addr);
> @@ -224,7 +224,7 @@ static inline void *kmap_atomic_pfn(unsigned long=20
pfn)
>  	return kmap_atomic(pfn_to_page(pfn));
>  }
> =20
> -static inline void __kunmap_atomic(void *addr)
> +static inline void __kunmap_atomic(const void *addr)
>  {
>  #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
>  	kunmap_flush_on_unmap(addr);
> diff --git a/mm/highmem.c b/mm/highmem.c
> index 1a692997fac4..e32083e4ce0d 100644
> --- a/mm/highmem.c
> +++ b/mm/highmem.c
> @@ -561,7 +561,7 @@ void *__kmap_local_page_prot(struct page *page,=20
pgprot_t prot)
>  }
>  EXPORT_SYMBOL(__kmap_local_page_prot);
> =20
> -void kunmap_local_indexed(void *vaddr)
> +void kunmap_local_indexed(const void *vaddr)
>  {
>  	unsigned long addr =3D (unsigned long) vaddr & PAGE_MASK;
>  	pte_t *kmap_pte;
> --=20
> 2.36.1
>=20
>=20




