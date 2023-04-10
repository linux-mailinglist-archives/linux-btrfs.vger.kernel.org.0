Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1186DCBFE
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Apr 2023 22:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjDJUCv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Apr 2023 16:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjDJUCu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Apr 2023 16:02:50 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8871FCA
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Apr 2023 13:02:48 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id c10-20020a17090abf0a00b0023d1bbd9f9eso8551410pjs.0
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Apr 2023 13:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681156968; x=1683748968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HpioAPXxW+v4Q4xUafxth5Qioe7sUCWQU1eCRcCSF4E=;
        b=OpSVB2xGYnoW5ZPOAmBnJFAuzcl4KWcOCssIXXoleg7BMgFiMKR6onztmHu2iPTwqV
         nlirkxgXvfjkEPyH+/Rw9CqIAFpt6o0d5KXy01HdZ4VSxoR8Cdr5bJ+/wtCvtRInRhlp
         Du9/tQ0WN8TytZHVtzCSsUEzJdQ4lnRPIeo8cTdnVr9SKRvHR4szvHAHahSq7IipAsLL
         l3fiTUSzkx8hBk08XSdL2o0DNbEAqNUDwG56S6yWXYvoXxal+x23wrDXYtE7d3NAUMLw
         Co11Qx7Q8VwF5wDNnGhH4ztFDGFLUNRgyq4wkQ2HewgSRwUVhVPkscfkT420mVaj04Ub
         ejqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681156968; x=1683748968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpioAPXxW+v4Q4xUafxth5Qioe7sUCWQU1eCRcCSF4E=;
        b=2KfyAo/O6ECILQYrs/q7VCwyP5SJ/tJbUUagvX3uCJofn0+EjVYuxvBTwOKaG/xYp7
         3RXZNLWmNEi13isI3L2TJVB677aa9VXZuoMpqAMchWdoz3fL4/5dMs/EdvOzC1ef1Wxv
         bUqenNOFw+eWh9IqGd56Jq2ChIfAsYVBHOqZ+MUxYEDRRf9lYvNULZLvFopn7M+WuIaA
         mNFElf9YljdEy8+VW1A9BpwNs+/NrLtzWvD+522rl7ySu1StZFegETLffObbiXXE0zxe
         qJ27Nn3qeSBwbfyMYbrIxg17NvFzIEOGFt6Xe4Yno646mXhKQMsSBxhlkWwZHM8fW61u
         ldbA==
X-Gm-Message-State: AAQBX9fyQs8rYNx42zc99fNJXKGzqGcs2MCckndr88MTdVH5diLqN2UO
        uwucQJJzoCW5IjqiyBvNx1fdeA==
X-Google-Smtp-Source: AKy350b82capCtNuSEsvxElVHvbtJETNgyp2B+atrv+RlVkQiQyDeGAflx7JoQTMQzRsKIJ+MsvcRg==
X-Received: by 2002:a17:902:c404:b0:1a2:7356:1ecd with SMTP id k4-20020a170902c40400b001a273561ecdmr17301528plk.5.1681156967766;
        Mon, 10 Apr 2023 13:02:47 -0700 (PDT)
Received: from google.com ([2620:15c:2d1:203:8e63:90de:efab:9bf6])
        by smtp.gmail.com with ESMTPSA id r19-20020a170902be1300b001a072aedec7sm8201345pls.75.2023.04.10.13.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 13:02:47 -0700 (PDT)
Date:   Mon, 10 Apr 2023 13:02:35 -0700
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, linux-btrfs@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Michael Kelley <mikelley@microsoft.com>, nathan@kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH 01/11] init: Mark [arch_call_]rest_init() __noreturn
Message-ID: <ZDRrW9+FrGxgw6Ok@google.com>
References: <cover.1680912057.git.jpoimboe@kernel.org>
 <b24a972397061a67d46ff5a98657e352040f427a.1680912057.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b24a972397061a67d46ff5a98657e352040f427a.1680912057.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 07, 2023 at 05:09:54PM -0700, Josh Poimboeuf wrote:
> Fixes the following warning:
> 
>   init/main.o: warning: objtool: start_kernel+0x4ad: unreachable instruction
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Ha! I was just looking into this, by coincidence.
https://github.com/ClangBuiltLinux/linux/issues/1815#issuecomment-1489113303

Generally, the compiler can infer when a function does not return, but
it's not safe to do so when the definition is weak, since the strong
definition may not be, so the caller must not make optimizations based
on such an assumption.

https://reviews.llvm.org/D147177 (abandoned, but has more info)

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

(I agree with the first two patches, since those are ones I was just
looking at.  Unfortunately, some security embargo just lifted on
https://bugs.chromium.org/p/llvm/issues/detail?id=30 which a clang-16
change is causing the stack canaries to be set+checked again in
start_kernel. I'm about to meet with LLVM folks at Intel in 30 minutes
to discuss walking back some of the changes since I strongly disagree
with them.  But merging this series will cause boot failures with
clang-16, and I would appreciate some time to sort this out before this
series is merged. It's my top priority.)

> ---
>  arch/s390/kernel/setup.c     | 2 +-
>  include/linux/start_kernel.h | 4 ++--
>  init/main.c                  | 4 ++--
>  tools/objtool/check.c        | 2 ++
>  4 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index 8ec5cdf9dadc..4259b6c50516 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -396,7 +396,7 @@ int __init arch_early_irq_init(void)
>  	return 0;
>  }
>  
> -void __init arch_call_rest_init(void)
> +void __init __noreturn arch_call_rest_init(void)
>  {
>  	unsigned long stack;
>  
> diff --git a/include/linux/start_kernel.h b/include/linux/start_kernel.h
> index 8b369a41c03c..864921e54c92 100644
> --- a/include/linux/start_kernel.h
> +++ b/include/linux/start_kernel.h
> @@ -9,7 +9,7 @@
>     up something else. */
>  
>  extern asmlinkage void __init start_kernel(void);
> -extern void __init arch_call_rest_init(void);
> -extern void __ref rest_init(void);
> +extern void __init __noreturn arch_call_rest_init(void);
> +extern void __ref __noreturn rest_init(void);
>  
>  #endif /* _LINUX_START_KERNEL_H */
> diff --git a/init/main.c b/init/main.c
> index 4425d1783d5c..161ed956d738 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -683,7 +683,7 @@ static void __init setup_command_line(char *command_line)
>  
>  static __initdata DECLARE_COMPLETION(kthreadd_done);
>  
> -noinline void __ref rest_init(void)
> +noinline void __ref __noreturn rest_init(void)
>  {
>  	struct task_struct *tsk;
>  	int pid;
> @@ -889,7 +889,7 @@ static int __init early_randomize_kstack_offset(char *buf)
>  early_param("randomize_kstack_offset", early_randomize_kstack_offset);
>  #endif
>  
> -void __init __weak arch_call_rest_init(void)
> +void __init __weak __noreturn arch_call_rest_init(void)
>  {
>  	rest_init();
>  }
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index cae6ac6ff246..e7442e7ad676 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -202,6 +202,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
>  		"__reiserfs_panic",
>  		"__stack_chk_fail",
>  		"__ubsan_handle_builtin_unreachable",
> +		"arch_call_rest_init",
>  		"arch_cpu_idle_dead",
>  		"cpu_bringup_and_idle",
>  		"cpu_startup_entry",
> @@ -217,6 +218,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
>  		"machine_real_restart",
>  		"make_task_dead",
>  		"panic",
> +		"rest_init",
>  		"rewind_stack_and_make_dead",
>  		"sev_es_terminate",
>  		"snp_abort",
> -- 
> 2.39.2
> 
> 
