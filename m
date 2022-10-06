Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF115F6A85
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Oct 2022 17:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiJFPZo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Oct 2022 11:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiJFPZn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Oct 2022 11:25:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AADB2D9D
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Oct 2022 08:25:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DC4B821A12;
        Thu,  6 Oct 2022 15:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665069938;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xbwErTpF/BqcVLe04GRoZfc0NfBM6jlzo5Usw+vS27Q=;
        b=YLhqNgolr0yXKVkCi8swZstI73flWJCRzj7zvEXTT/bUPwJJuneQOlrLXnSwDEeyCIkNVL
        khK95lQpwqwvtEqo3RQVss2B7ArgKJWbd9GJQUclw+qN9/9dfxARiEXCID530eZKp8uRt/
        +nnPmz2+Qf7OVmeJQ2fboT82N71eQek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665069938;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xbwErTpF/BqcVLe04GRoZfc0NfBM6jlzo5Usw+vS27Q=;
        b=wRGDmBDaNRQg20GQNwEZ567+l7SEQsGZ0kNPHX17GiD/dwwC6XjUHtDZHXsE5KwiABCxFt
        a8NyOJPQpoF6yGCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A48B1376E;
        Thu,  6 Oct 2022 15:25:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MjayJHLzPmP6BgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 06 Oct 2022 15:25:38 +0000
Date:   Thu, 6 Oct 2022 17:25:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs-progs: tests: fix the wrong kernel version
 check
Message-ID: <20221006152535.GN13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1664936628.git.wqu@suse.com>
 <26571df609d06e0a484a800d424be3e22c0f9961.1664936628.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26571df609d06e0a484a800d424be3e22c0f9961.1664936628.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 05, 2022 at 10:25:12AM +0800, Qu Wenruo wrote:
> [BUG]
> After upgrading to kernel v6.0-rc, btrfs-progs selftest mkfs/001 no
> longer checks single device RAID0 and other new features introduced in
> v5.13:
> 
>   # make TEST=001\* test-mkfs
>     [TEST]   mkfs-tests.sh
>     [TEST/mkfs]   001-basic-profiles
>   $ grep -IR "RAID0\/1" tests/mkfs-tests-results.txt
>   ^^^ No output
> 
> [CAUSE]
> The existing check_min_kernel_version() is doing an incorrect check.
> 
> The old check looks like this:
> 
> 	[ "$unamemajor" -lt "$argmajor" ] || return 1
> 	[ "$unameminor" -lt "$argminor" ] || return 1
> 	return 0
> 
> For 6.0-rc kernels, we have the following values for mkfs/001
> 
>  $unamemajor = 6
>  $unameminor = 0
>  $argmajor   = 5
>  $argminor   = 12
> 
> The first check doesn't exit immediately, as 6 > 5.
> Then we check the minor, which is already incorrect.
> 
> If our major is larger than target major, we should exit immediate with
> 0.
> 
> [FIX]
> Fix the check and add extra comment.
> 
> Personally speaking I'm not a fan or short compare and return, thus all
> the checks will explicit "if []; then fi" checks.

Agreed the explicit if should be used in most cases, what is probably ok
a 'command || _fail' pattern for simple commands. I try to unify the
shell coding style in new patches but some bits may slip through.
