Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D606065CC
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 18:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiJTQ3q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 12:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJTQ3p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 12:29:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB17F3055D
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 09:29:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C632B22932;
        Thu, 20 Oct 2022 16:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666283381;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hdNu0KTKuSdrIazu5agMlgLMVxmMOMR43qUL+uHz5yQ=;
        b=ipn45GpOgZmwAvpQZvNVkkIGXFDyFgrr4XUnmEjL417a9xBctLgVPCzkXnlY6u1lVBH4qv
        G1DoA1/wMivr3e2zsVg66DaksQsuULQEM50Qa6w4+dX5m/d6ljxqDrhALXzPEQdGalQ9Xg
        GX8NlIQuCB2kTxXFJIfVhc6rpiSfvaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666283381;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hdNu0KTKuSdrIazu5agMlgLMVxmMOMR43qUL+uHz5yQ=;
        b=dp+1TQT3UevLp8eGVnHnMOM2KtfEyZsIul9Iu8RzeXtHZ2V12kXtaWtlWgbqgD56w+oMNw
        xfYfqMY2PwDNPaBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84D9713494;
        Thu, 20 Oct 2022 16:29:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TJ5XH3V3UWMfJgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 20 Oct 2022 16:29:41 +0000
Date:   Thu, 20 Oct 2022 18:29:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 00/15] btrfs: split out larger chunks of ctree.h
Message-ID: <20221020162930.GL13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1666190849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666190849.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 19, 2022 at 10:50:46AM -0400, Josef Bacik wrote:
> v2->v3:
> - Merged the moving of the printk helpers out of ctree.h and then moving some of
>   the larger helpers into their own c file into one patch.
> - Moved the assert helper patch to before the printk moving patch so I don't
>   move the code twice.
> - Adjusted the commit log to indicate I was un-inlining the btrfs_map_token_init
>   funciton.
> - Added some missing newlines at the end of headers.
> 
> v1->v2:
> - renamed btrfs-printk.h and item-accessors.* to messages.h and accessors.*.
> - I dropped "btrfs: push extra checks into __btrfs_abort_transaction" so the
>   WARN_ON would be where the abort happens.
> - I reworked the incompat/compat get helpers to be defines instead of inlines to
>   maintain the faster code instead of un-inlining the helper, and this way we
>   have a little better header cleanliness.
> - I gave up on my idea of having headers able to be included at any order at
>   this point and made sure everything was included in the proper order.  Once
>   things are completely split out we can go back through and try to make all the
>   header files as clean as possible.
> 
> --- Original email ---
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
> 
> Josef
> 
> Josef Bacik (15):
>   btrfs: move fs wide helpers out of ctree.h
>   btrfs: move assert helpers out of ctree.h
>   btrfs: move the printk helpers out of ctree.h
>   btrfs: push printk index code into their respective helpers
>   btrfs: move BTRFS_FS_STATE* defs and helpers to fs.h
>   btrfs: convert incompat and compat flag test helpers to defines
>   btrfs: move mount option definitions to fs.h
>   btrfs: move fs_info->flags enum to fs.h
>   btrfs: add a BTRFS_FS_NEED_TRANS_COMMIT flag
>   btrfs: remove fs_info::pending_changes and related code
>   btrfs: move the compat/incompat flag masks to fs.h
>   btrfs: rename struct-funcs.c -> accessors.c
>   btrfs: move btrfs_map_token to accessors
>   btrfs: move accessor helpers into accessors.h
>   btrfs: remove temporary btrfs_map_token declaration in ctree.h

Merged to misc-next with some minor fixups. This will likely lead to
some patch conflicts but let's say we do such broad changes at rc3 at
the latest so we have enough time left to rebase and test any
non-cleanup changes.
