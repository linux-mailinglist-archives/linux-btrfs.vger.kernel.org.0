Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63906BA1C4
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 23:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjCNWFn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 18:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCNWFm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 18:05:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB632B9F9
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 15:05:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2641221B54;
        Tue, 14 Mar 2023 22:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678831540;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ElR8pKBKL+7F7ATiZZYZBbN4l0PaI0eoqh0mNGebGjw=;
        b=ASFqSZIwk/+YExWlI6/vuywNTBqWbY8IMP3fMTOBFiswATT4JPykvwCN0np9Q6xsEYKR0g
        EuyF6iDcKyBuYjKgWBifW144p9MhvhTOWL+bG97NTF+v0aLRLNG/zXGhNeYqgnM21k1PfA
        Zsjpe5U6Y63ok/jmGbCBWKQWiWQtQE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678831540;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ElR8pKBKL+7F7ATiZZYZBbN4l0PaI0eoqh0mNGebGjw=;
        b=Ya6Kb/2UgdZ7CMRMZeP920p8RfK3yekE1yRjyb1hk/qoP8RIZJcek1jHx6k4hAMvxvv0bS
        harIhHlu6bF/5bCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF47F13A1B;
        Tue, 14 Mar 2023 22:05:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eZpnObPvEGSqCgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 14 Mar 2023 22:05:39 +0000
Date:   Tue, 14 Mar 2023 22:59:33 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 8/8] btrfs: turn on -Wmaybe-uninitialized
Message-ID: <20230314215933.GT10580@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1671221596.git.josef@toxicpanda.com>
 <1d9deaa274c13665eca60dee0ccbc4b56b506d06.1671221596.git.josef@toxicpanda.com>
 <20230222025918.GA1651385@roeck-us.net>
 <20230222163855.GU10580@twin.jikos.cz>
 <6c308ddc-60f8-1b4d-28da-898286ddb48d@roeck-us.net>
 <feb05eef-cc80-2fbe-f28a-b778de73b776@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <feb05eef-cc80-2fbe-f28a-b778de73b776@leemhuis.info>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 12, 2023 at 02:06:40PM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 22.02.23 18:18, Guenter Roeck wrote:
> > On 2/22/23 08:38, David Sterba wrote:
> >> On Tue, Feb 21, 2023 at 06:59:18PM -0800, Guenter Roeck wrote:
> >>> On Fri, Dec 16, 2022 at 03:15:58PM -0500, Josef Bacik wrote:
> This discussion seems to have stalled, but from a kernelci report it
> looks like above warning still happens:
> https://lore.kernel.org/all/640bceb7.a70a0220.af8cd.146b@mx.google.com/
> 
> @btrfs developers, do you still have it on your radar?

I'm aware of the warnings and that it's caused by enabling the
-Wmaybe-uninitialized warning. One has a patch, IIRC there are 2-3 more,
so either there's a fix or the commit enabling the warning will be
reverted before 6.3 final.
