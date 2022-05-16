Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C3652856B
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 15:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbiEPNbM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 May 2022 09:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiEPNbK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 May 2022 09:31:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69352CCA4;
        Mon, 16 May 2022 06:31:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41F336114C;
        Mon, 16 May 2022 13:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE183C385AA;
        Mon, 16 May 2022 13:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652707866;
        bh=ptJJdl6/90C/9ngs0R9TLu4hatZEKH+NyjqZBwan/o8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DZdQ9mfTQBflmQWi4epCej7EPYBxF8pZ7ebsvN/YIJF+sYxkmOOFEk2UPrsR8cEht
         3uUxwAXuxDSNr9DxG7VT5s0In462yrkGVBwDmjy5o3BYTodwXeF+/Aae318fGsFIdD
         i6z511NzSGuxWHwP1TkBEGg+0ZsPsSzYb/5QWego=
Date:   Mon, 16 May 2022 15:31:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Arnd Bergmann <arnd@kernel.org>, linux-kbuild@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>, llvm@lists.linux.dev,
        Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>, Hu Haowen <src.res@email.cn>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-btrfs@vger.kernel.org
Subject: Re: [greybus-dev] Re: [PATCH] [v2] Kbuild: move to -std=gnu11
Message-ID: <YoJSF8T5K9pPx3Ap@kroah.com>
References: <20220228103142.3301082-1-arnd@kernel.org>
 <20220516131023.GA2329080@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220516131023.GA2329080@roeck-us.net>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 16, 2022 at 06:10:23AM -0700, Guenter Roeck wrote:
> On Mon, Feb 28, 2022 at 11:27:43AM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > During a patch discussion, Linus brought up the option of changing
> > the C standard version from gnu89 to gnu99, which allows using variable
> > declaration inside of a for() loop. While the C99, C11 and later standards
> > introduce many other features, most of these are already available in
> > gnu89 as GNU extensions as well.
> 
> The downside is that backporting affected patches to older kernel branches
> now fails with error messages such as
> 
> mm/kfence/core.c: In function ‘kfence_init_pool’:
> mm/kfence/core.c:595:2: error: ‘for’ loop initial declarations are only allowed in C99 or C11 mode
> 
> Just something to keep in mind when writing patches.

I just ran across this very issue on this commit.  It's an easy fixup
for 5.17.y to make this work, so I did that in my tree.  If this gets to
be too much, we might need to reconsider adding c11 to older stable
kernels.

thanks,

greg k-h
