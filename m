Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4D76DFFDA
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Apr 2023 22:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjDLUaJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Apr 2023 16:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjDLUaE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Apr 2023 16:30:04 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDBF76BF
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Apr 2023 13:29:55 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id q2so17583342pll.7
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Apr 2023 13:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681331395; x=1683923395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MPIZuP0MZByRyC+/nU9qhHjtfr1zaG8eGgVe3FKVcpE=;
        b=4i1ZGWC7T0vcawyANuqheZxC4oYpBwN5406UaN8TmvzhIkKY1UYMwB5AqBeg95Q6GM
         S1UvZvmMB505K6ozQ2XtKaplTM/0klq52c430fSTqKBOONVXzpVOEIxiGPbl5DHCjzzp
         Mg1TO0DaLWiULgIhhPHBLXpfTquxUtgxOjikd1FpVrUYwAmdTEt1xE+CEY/HqwDybLZV
         kj01pGMvuC3zgWQ3FW9tjp1woTn24MteocGWzJkZb+4hp6ViZo1mSMOwhq3HD1Dict86
         MzwjpBrVWBojdTL2ZHnpXY4RDOFRTYh2/IhZGgvyNDiljfX7psrugiJxafIzLMYucoeA
         mgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681331395; x=1683923395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPIZuP0MZByRyC+/nU9qhHjtfr1zaG8eGgVe3FKVcpE=;
        b=VbqGuDBCfaplGWnKwPbVQjI1LxUz2u4ZdIEk3vRGHZA6MCZYerGY0WmtwIFtP5pb9b
         59dxCrXADE7wnaIlJbLC4cCkp9hmD1ZVv/g2nIIc2q/iMX61gEvqt4F0SeyZvhCn0QiE
         OZsGcUm4E6nedR1andhcFiAvxwuzYsRKTtLaDyfpXo1Mi6IFCH9Ny6nISIBXExJGR50/
         AAajdxi6t5kg5zfcd8Uq2thzWBIkJlVZ1PZhrUg5EILO8n1/AMSTybTca4Cj/ePYIAZW
         tsTKhnAjHE3j1kTnfn0qJNBVQRlRDXp8OhSGID5lOC5vuEPFMoFKBEg6Xex5+/+6R3OF
         0oTw==
X-Gm-Message-State: AAQBX9ee7ZQ9gzVqHTXXzicHTOf8y0HMPmoA1jHKQ3Sp8HujcBXTN+hp
        YoBnJabmFtM/0NNmGHrn3HDy5w==
X-Google-Smtp-Source: AKy350YrZ02ScWTgT8jhEbD53S2CWz6oXdOXMzAXXLbV3fv9KVIYZsKPbbGjmkiIUKkubXaaP3P2VQ==
X-Received: by 2002:a17:902:e749:b0:1a6:6b9c:48ae with SMTP id p9-20020a170902e74900b001a66b9c48aemr67912plf.52.1681331395062;
        Wed, 12 Apr 2023 13:29:55 -0700 (PDT)
Received: from google.com ([2620:15c:2d1:203:4a4a:51a1:19b:61ab])
        by smtp.gmail.com with ESMTPSA id g24-20020a63e618000000b00502f20aa4desm4115pgh.70.2023.04.12.13.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 13:29:54 -0700 (PDT)
Date:   Wed, 12 Apr 2023 13:29:49 -0700
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, linux-btrfs@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Michael Kelley <mikelley@microsoft.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 02/11] init: Mark start_kernel() __noreturn
Message-ID: <ZDcUvWuqv2VevITe@google.com>
References: <cover.1680912057.git.jpoimboe@kernel.org>
 <cb5dab6038dfe5156f5d68424cf372f7eed1b934.1680912057.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb5dab6038dfe5156f5d68424cf372f7eed1b934.1680912057.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 07, 2023 at 05:09:55PM -0700, Josh Poimboeuf wrote:
> Fixes the following warning:
> 
>   vmlinux.o: warning: objtool: x86_64_start_reservations+0x28: unreachable instruction
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/r/202302161142.K3ziREaj-lkp@intel.com/
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Ah, I just realized that my series will conflict with this.
https://lore.kernel.org/llvm/20230412-no_stackp-v1-1-46a69b507a4b@google.com/
Perhaps if my series gets positive feedback; I can rebase it on top of
this and it can become part of your series?

For this patch,
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Though I'm curious, it does look like it's necessary because of 01/11 in
the series? Any idea how the 0day bot report happened before 1/11
existed?

(Surely gcc isn't assuming a weak function is implicitly noreturn and
make optimizations based on that (that's one hazard I'm worried about)?)

It looks like perhaps the link to
https://lore.kernel.org/all/202302161142.K3ziREaj-lkp@intel.com/
on 2/11 was 0day testing the arch-cpu-idle-dead-noreturn branch of your
kernel tree
https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/log/?h=arch-cpu-idle-dead-noreturn
, which had 1/11 in it, IIUC?  Perhaps this link should go on 1/11
rather than 2/11?

Looking back at 1/11, 3/11, 8/11 I noticed not all patches have links to 0day
reports.  Are you able to flesh out more info how/what/when such objtool
warnings are observed?  Are the warnings ever results of patches earlier
in the series?
