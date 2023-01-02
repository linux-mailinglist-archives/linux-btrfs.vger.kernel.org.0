Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90BC65B253
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jan 2023 13:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjABMsC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Jan 2023 07:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjABMsA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Jan 2023 07:48:00 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A53DF8;
        Mon,  2 Jan 2023 04:47:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 877B020F11;
        Mon,  2 Jan 2023 12:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672663678;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8MEMF1Di8T491Z7gpFZexJEbRO0goQfo2mNNC19Dwlw=;
        b=Bho7fl7+1m5PHrcpXO/NsKrbYso7mtiYVrhHG/e9MgYwZX6WDndeXrNDaiteUAZcQIlHMj
        //7SRtqVs7YllEIJemwJcBVtd3kduyIRNpLdqXrdfByrnUtPXpHPpjhmNLhTeG0KNN2WFZ
        OjPgYI7d+CY8agTHZW6WP/Phdgo6a30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672663678;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8MEMF1Di8T491Z7gpFZexJEbRO0goQfo2mNNC19Dwlw=;
        b=8xcIZgID6yyL8tso5U4W2aD4BOAiB5exlr0/ZLshKB9VhcA8NhPu0cpEPW7fgLIsabysDi
        xdB7+ETNMAqJgZDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3BFF613427;
        Mon,  2 Jan 2023 12:47:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Fo+0DX7SsmNQGgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 02 Jan 2023 12:47:58 +0000
Date:   Mon, 2 Jan 2023 13:42:28 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        llvm@lists.linux.dev, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 8/8] btrfs: turn on -Wmaybe-uninitialized
Message-ID: <20230102124228.GB11562@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1671221596.git.josef@toxicpanda.com>
 <1d9deaa274c13665eca60dee0ccbc4b56b506d06.1671221596.git.josef@toxicpanda.com>
 <Y6kgR4qnb23UdAEX@dev-arch.thelio-3990X>
 <CA+G9fYuhZzVfxXnVRMog_yv8F17NY4vHe_iafwgxpYCGfuaJqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuhZzVfxXnVRMog_yv8F17NY4vHe_iafwgxpYCGfuaJqQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 26, 2022 at 07:34:51PM +0530, Naresh Kamboju wrote:
> On Mon, 26 Dec 2022 at 09:47, Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Fri, Dec 16, 2022 at 03:15:58PM -0500, Josef Bacik wrote:
> > > We had a recent bug that would have been caught by a newer compiler with
> > > -Wmaybe-uninitialized and would have saved us a month of failing tests
> > > that I didn't have time to investigate.
> > >
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> >
> > This needs to be moved to the condflags section, as
> > -Wmaybe-uninitialized is a GCC only flag, so this breaks our builds with
> > clang on next-20221226:
> >
> >   error: unknown warning option '-Wmaybe-uninitialized'; did you mean '-Wuninitialized'? [-Werror,-Wunknown-warning-option]
> 
> LKFT test farm also noticed these build breaks with clang on next-20221226.

Fixed in our branch and for-next snapshot updated so the warnings will
be fixed once linux-next resumes.
