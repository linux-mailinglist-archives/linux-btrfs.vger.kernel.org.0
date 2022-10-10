Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB795FA634
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Oct 2022 22:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJJUaE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Oct 2022 16:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJJU3j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Oct 2022 16:29:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A7FB48A
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 13:28:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BC5051F8EE;
        Mon, 10 Oct 2022 20:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665433712;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dBc/6Z63Y1Q8C8oMeR/PxKuihK8ROzEkA8yw96mJ2mg=;
        b=zKPQNRL0wB8KBy9ugR/DLazB5dHeMxWMR7v2Szlj9JE1ip0uSWkRGqrHfiIRsUpLIL4zid
        lRjXDyKFS5rowcqcaR8/LpM4eeX6nOhPSxoQ54DaowgnSpgA0S02vqRWY872TEF1I5gwnu
        HGcvDhWseMThtupYYl8IJbSWpI/cH5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665433712;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dBc/6Z63Y1Q8C8oMeR/PxKuihK8ROzEkA8yw96mJ2mg=;
        b=bOMBU8TGEHDErWLWI2ZuH/r0OyDW6/XONo5eGGmysILpIDduJ6dIvMAfYhxdQvzzVbk/l+
        TGwZFo/dZWt9JaCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F21C13ACA;
        Mon, 10 Oct 2022 20:28:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b/z0HXCARGMbKgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 10 Oct 2022 20:28:32 +0000
Date:   Mon, 10 Oct 2022 22:28:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/16] btrfs: split out larger chunks of ctree.h
Message-ID: <20221010202827.GI13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1663175597.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1663175597.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 14, 2022 at 01:18:05PM -0400, Josef Bacik wrote:
> Hello,
> 
> This series is based on the series
> 
>   btrfs: initial ctree.h cleanups, simple stuff
> 
> which needs to be in place before applying these patches.
> 
> This is likely going to have the largest patch of the series, which bulk moves
> all of the struct funcs defines out of ctree.h into their own file.  This isn't
> really possible to do piecemeal like other changes because we're using macros
> instead of functions.  However the code is well organized so it allows for a
> bulk copy and paste, so is straightforward.
> 
> I've done my best with naming, but I'm open to suggestions.  My general plan is
> to have all fs wide definitions in fs.h, and then separate out individual things
> to their own headers.

The fs.h feels like another ctree.h but we have to start somewhere and
further moving stuff from fs.h sounds like a plan.
> 
> The biggest things I've done in this series are
> 
> 1. Move the printk helpers into their own files.
> 2. Move the main state flags and core fs helpers into their own files.
> 3. Moved the struct func definitions to their own files.
> 
> This is by no means complete, this is just the first big pass, but as you can
> see is already 17 patches long.  Subsequent patches will move more code and do
> more cleanups.  Thanks,

I'll try to merge such straightforward patchsets without much delay as
long as the changes are straightforward and reasonable assuming that
we'll reach perfection eventually. This series can be used as reference
for what is OK, with some minor fixups or renames. The name of
btrfs-printk.h stands out as it's using two subsystems while I'd expect
something more decriptive of what's inside like messages.h. For that a
resend is not necessary, just that we agree that a rename is fine.
