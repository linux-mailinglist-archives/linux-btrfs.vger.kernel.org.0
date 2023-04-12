Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D01F6E0287
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Apr 2023 01:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjDLX1A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Apr 2023 19:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjDLX07 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Apr 2023 19:26:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738585B97;
        Wed, 12 Apr 2023 16:26:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FE6C633DE;
        Wed, 12 Apr 2023 23:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3801C433D2;
        Wed, 12 Apr 2023 23:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681342017;
        bh=Xw+lNaA+g/8MJoyIynxSpoRwkCeN5fHc84TR4pi49jw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iFoYwmtFp8yRSC3VWaYKQVWW4b0dRA+RUSWAzfPPMMXVqDeH9JNAvKfJwIDvFZZYl
         6SlcxaOT40siCjRVtw/xrEfyOslnsnVSe0uY2JGL8NJcM3R7AupSVmzOmrKS4ziOeh
         KbuzsQYc5rcyWG58nZd3nwschZWhZroltMPeiWrfdHAZatNheV/YQL5GNGWpJdyH9L
         MOHS9tAzFkvJSp3+YY0L4EBR7pwQRAUZQi9gS9Dgvxg+zXdRStmjNdlDQ3PTSEkk7M
         aJ7fqmjIqhqM6/jbP/RiOL8nTst3nUULMnxYsZityB3PHRoIcKDcikYR8q6FsYd/qt
         TRFJPRQue+zNQ==
Date:   Wed, 12 Apr 2023 16:26:54 -0700
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
Message-ID: <20230412232654.vggdl3g5nds64vdd@treble>
References: <cover.1680912057.git.jpoimboe@kernel.org>
 <cb5dab6038dfe5156f5d68424cf372f7eed1b934.1680912057.git.jpoimboe@kernel.org>
 <ZDcUvWuqv2VevITe@google.com>
 <20230412215755.bz3nzldqhhc4wjds@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230412215755.bz3nzldqhhc4wjds@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 12, 2023 at 02:57:57PM -0700, Josh Poimboeuf wrote:
> > It looks like perhaps the link to
> > https://lore.kernel.org/all/202302161142.K3ziREaj-lkp@intel.com/
> > on 2/11 was 0day testing the arch-cpu-idle-dead-noreturn branch of your
> > kernel tree
> > https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/log/?h=arch-cpu-idle-dead-noreturn
> > , which had 1/11 in it, IIUC?  Perhaps this link should go on 1/11
> > rather than 2/11?
> 
> Good catch, patch 1 does introduce the warning.  I think I'll just
> squash patches 1 and 2 so as not to break bisection.
> 
> > Looking back at 1/11, 3/11, 8/11 I noticed not all patches have links to 0day
> > reports.  Are you able to flesh out more info how/what/when such objtool
> > warnings are observed?  Are the warnings ever results of patches earlier
> > in the series?
> 
> Hopefully not, it's best to not introduce warnings even temporarily.  I
> was doing a lot of build testing at the time with various branches, so
> it's possible.  I'll see if I can figure out how I triggered those
> warnings and document that in the commit logs if possible.

On second thought I won't squash, keeping them separate is useful for
both patches 1 & 2 and patches 5-7.  The patch order goes up the call
stack, i.e. fix callees before callers.  The opposite order would
trigger actual compiler warnings rather than measly objtool warnings :-)

I agree some of the commit logs are indeed confusing and sometimes even
wrong.  I'll clarify the justifications, and remove references to build
bot warnings if they apply to previous patches in the set.

-- 
Josh
