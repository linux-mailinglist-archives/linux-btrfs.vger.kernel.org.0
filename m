Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0F15F6A98
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Oct 2022 17:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiJFP3a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Oct 2022 11:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiJFP3a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Oct 2022 11:29:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A21B2D9F
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Oct 2022 08:29:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0D59721A1B;
        Thu,  6 Oct 2022 15:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665070167;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8CF8KeaIrTW8fc0LAU42+vfBLwJduGn/BoXgUQBi5ZQ=;
        b=teASZXT6JLypQCilwUs9dK9+wBrnOjejfO1nRcKbIkxhNdzjQSMGWdu3HtfdmEOwlgD6PS
        6XLddlyPuPMUt2Lh1UDAWNiFeTL+Ju6MdrI0fenhtHRKnUXbWr7lCa8HDo1r2C7PQa/ewX
        msUiFe6QQfFSt5kVocfCy2R6KlUDIWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665070167;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8CF8KeaIrTW8fc0LAU42+vfBLwJduGn/BoXgUQBi5ZQ=;
        b=0HtEQ1a8BYeHPFSdTA8lgyFm45+D/rINFWKOMMdIh3ulpHCec8NRKAwKzibE1gIXg/U81W
        V6PHlfJDfdFjGQAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1D721376E;
        Thu,  6 Oct 2022 15:29:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8GMpNlb0PmOdCAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 06 Oct 2022 15:29:26 +0000
Date:   Thu, 6 Oct 2022 17:29:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs-progs: convert-tests/022: add reiserfs support
 check
Message-ID: <20221006152924.GO13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1664936628.git.wqu@suse.com>
 <feae908d2bfe2e92efc26f4cef5d8ddf186c7114.1664936628.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <feae908d2bfe2e92efc26f4cef5d8ddf186c7114.1664936628.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 05, 2022 at 10:25:14AM +0800, Qu Wenruo wrote:
> [BUG]
> Btrfs-progs test case convert/022 will fail if the system doesn't have
> reiserfs support nor reiserfs user space tools:
> 
>   # make TEST=022\* test-convert
>     [TEST]   convert-tests.sh
>   WARNING: reiserfs filesystem not listed in /proc/filesystems, some tests might be skipped
>     [TEST/conv]   022-reiserfs-parent-ref
>   Failed system wide prerequisities: mkreiserfs
>   test failed for case 022-reiserfs-parent-ref
>   make: *** [Makefile:443: test-convert] Error 1
> 
> [CAUSE]
> Unlike other test cases, convert/022 doesn't even check if we have
> kernel support for it.
> 
> [FIX]
> Add the proper check before doing system wide prerequisities checks.

I've moved it before the mkreiserfs check, I'd like to keep the
setup_root_helper and prepare_test_dev first in the list for
consistency.
