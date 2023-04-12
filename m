Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3122F6E0145
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Apr 2023 23:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjDLV6A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Apr 2023 17:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDLV57 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Apr 2023 17:57:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B78C0;
        Wed, 12 Apr 2023 14:57:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9D21635B0;
        Wed, 12 Apr 2023 21:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6524C433EF;
        Wed, 12 Apr 2023 21:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681336677;
        bh=JLhNcNRIDdMTedwvdop2oDKxJIi5sh4ynsleihJQULo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iLEDJCDdixRPsXIXZEKB9y9Eakj5UvdZQM2mpD6QBXioGLyUqnIB53egfbbhxIb5F
         bD6GXYFiFOZSfghDOh1T6TY4enu1/jfzC4ZeS4dcK2TFu99OUGPB9W9fRcMLje/eJj
         3YaurQz2EzOgUbXiVq92j9U3g5TLNY2cqvqDIDGJVbbKk1X/TulQQZMdMDBtKhPAgh
         MPVgq5i3N2sN8oYoWUGIFe73ojPUfDOhKnOWynMz2cOQwAiJAyS2BjUVLaqYetkTfc
         Fi2c7zoGvZuj58qkUyfgYPT7afD3Z3WYKbEs6mKIQw14mluQ5qfwL2jS5N1mQqhCz+
         BJoC6/3Q61XZg==
Date:   Wed, 12 Apr 2023 14:57:55 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, linux-btrfs@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Michael Kelley <mikelley@microsoft.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 02/11] init: Mark start_kernel() __noreturn
Message-ID: <20230412215755.bz3nzldqhhc4wjds@treble>
References: <cover.1680912057.git.jpoimboe@kernel.org>
 <cb5dab6038dfe5156f5d68424cf372f7eed1b934.1680912057.git.jpoimboe@kernel.org>
 <ZDcUvWuqv2VevITe@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZDcUvWuqv2VevITe@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 12, 2023 at 01:29:49PM -0700, Nick Desaulniers wrote:
> On Fri, Apr 07, 2023 at 05:09:55PM -0700, Josh Poimboeuf wrote:
> > Fixes the following warning:
> > 
> >   vmlinux.o: warning: objtool: x86_64_start_reservations+0x28: unreachable instruction
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Link: https://lore.kernel.org/r/202302161142.K3ziREaj-lkp@intel.com/
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Ah, I just realized that my series will conflict with this.
> https://lore.kernel.org/llvm/20230412-no_stackp-v1-1-46a69b507a4b@google.com/
> Perhaps if my series gets positive feedback; I can rebase it on top of
> this and it can become part of your series?

Sure, I can take these on top.

> For this patch,
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks!

> Though I'm curious, it does look like it's necessary because of 01/11 in
> the series? Any idea how the 0day bot report happened before 1/11
> existed?
>
> 
> (Surely gcc isn't assuming a weak function is implicitly noreturn and
> make optimizations based on that (that's one hazard I'm worried about)?)

As far as I can tell, GCC has been doing the right thing here, and it's
instead been objtool getting confused by weak noreturns.  That gets
fixed later in patch 9.

> It looks like perhaps the link to
> https://lore.kernel.org/all/202302161142.K3ziREaj-lkp@intel.com/
> on 2/11 was 0day testing the arch-cpu-idle-dead-noreturn branch of your
> kernel tree
> https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/log/?h=arch-cpu-idle-dead-noreturn
> , which had 1/11 in it, IIUC?  Perhaps this link should go on 1/11
> rather than 2/11?

Good catch, patch 1 does introduce the warning.  I think I'll just
squash patches 1 and 2 so as not to break bisection.

> Looking back at 1/11, 3/11, 8/11 I noticed not all patches have links to 0day
> reports.  Are you able to flesh out more info how/what/when such objtool
> warnings are observed?  Are the warnings ever results of patches earlier
> in the series?

Hopefully not, it's best to not introduce warnings even temporarily.  I
was doing a lot of build testing at the time with various branches, so
it's possible.  I'll see if I can figure out how I triggered those
warnings and document that in the commit logs if possible.

-- 
Josh
