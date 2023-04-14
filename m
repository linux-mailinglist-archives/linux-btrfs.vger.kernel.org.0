Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926B06E25CE
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Apr 2023 16:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjDNOck (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Apr 2023 10:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjDNOci (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Apr 2023 10:32:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56B1BC;
        Fri, 14 Apr 2023 07:32:33 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 87B181FD9F;
        Fri, 14 Apr 2023 14:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681482751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+2bJ2CDuzKgRDleC5QFa89hSVX8wMNuFKrzbNXKA+J0=;
        b=KpggDlsCb8TvDf5jIHfQV87cGQJbmVXRVuaeUhIwsYxPqDVDB+MmMOiZiD2Kd9WPcN6vCN
        J4o6vwen0NUZuruK+WC3Fj1llq7KqPZQ9/v6TeKJ46OU2msIe1p0iD3pe+iE8b0aaHLo4J
        yifoN87zLsUcPCX1cYvU6xbILcxaycI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681482751;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+2bJ2CDuzKgRDleC5QFa89hSVX8wMNuFKrzbNXKA+J0=;
        b=VsOY+QudtAh46N4cxi61iAktwoWceCn0R0HL2afVTWHB2Ei1BFIx2OOULLlyb6Y9UKDize
        /oZJM52bhJqqMyAg==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C5D1D2C15A;
        Fri, 14 Apr 2023 14:32:30 +0000 (UTC)
Date:   Fri, 14 Apr 2023 16:32:30 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-btrfs@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 07/11] objtool: Include weak functions in global_noreturns
 check
In-Reply-To: <ede3460d63f4a65d282c86f1175bd2662c2286ba.1681342859.git.jpoimboe@kernel.org>
Message-ID: <alpine.LSU.2.21.2304141631490.4426@pobox.suse.cz>
References: <cover.1681342859.git.jpoimboe@kernel.org> <ede3460d63f4a65d282c86f1175bd2662c2286ba.1681342859.git.jpoimboe@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 12 Apr 2023, Josh Poimboeuf wrote:

> If a global function doesn't return, and its prototype has the
> __noreturn attribute, its weak counterpart must also not return so that
> it matches the prototype and meets call site expectations.
> 
> To properly follow the compiled control flow at the call sites, change
> the global_noreturns check to include both global and weak functions.
> 
> On the other hand, if a weak function isn't in global_noreturns, assume
> the prototype doesn't have __noreturn.  Even if the weak function
> doesn't return, call sites treat it like a returnable function.
> 
> Fixes the following warning:
> 
>   kernel/sched/build_policy.o: warning: objtool: do_idle() falls through to next function play_idle_precise()
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202304090346.erhqxnlt-lkp@intel.com/
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

The rest of the patch set looks good to me too.

M
