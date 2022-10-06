Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579255F6A9F
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Oct 2022 17:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiJFPaj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Oct 2022 11:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiJFPai (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Oct 2022 11:30:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291618E0C5
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Oct 2022 08:30:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DC7D921A0E;
        Thu,  6 Oct 2022 15:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665070234;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5jSMKhe6n36ozYmcvqz/dBVcGYOhwgBTgnH0ucIAJvY=;
        b=Nuxec7rbGIDA/9DrGO4Iy65mJQoyEmen2gb/rW7wtWbzTtCHZopdclvhXaYLP2Ldp2Lty2
        b4PLBF07PdiA4jf2zKQSVAieYgWuOLqWEuNdng1pjZueYzOgS8TdpIi3Iew3W09VdMXjK7
        16KBY7Y3g+qjwJoRd9jKDa6btQdQAXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665070234;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5jSMKhe6n36ozYmcvqz/dBVcGYOhwgBTgnH0ucIAJvY=;
        b=0wCGqSeccu9CwBKUm87mWvAVRVU5WIkwyELJ/of6yjYikB9I+ngNmqtHo+p5dKsCqnvtIX
        uxJDmwzmU4nnxIDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC44A1376E;
        Thu,  6 Oct 2022 15:30:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ilXHKJr0PmNhCQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 06 Oct 2022 15:30:34 +0000
Date:   Thu, 6 Oct 2022 17:30:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs-progs: selftests fixes
Message-ID: <20221006153031.GP13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1664936628.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1664936628.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 05, 2022 at 10:25:11AM +0800, Qu Wenruo wrote:
> There are 3 bugs exposed during my tests for unified mkfs features, and
> they are all from the selftest itself:
> 
> - check_min_kernel_version() doesn't handle 6.x kernels at all
>   The original check never handles major number check properly.
>   And when we change major number, returns in correct number now.
> 
> - Missing a space between "!" and function call
>   This bug is there for a long time. 
> 
>   Without previous fix, one may incorrectly remove the "!" and cause
>   new problems.
> 
> - Convert/022 doesn't check if we have support for reiserfs
> 
> Qu Wenruo (3):
>   btrfs-progs: tests: fix the wrong kernel version check
>   btrfs-progs: mkfs-tests/025: fix the wrong function call
>   btrfs-progs: convert-tests/022: add reiserfs support check

I've foled patch 2 to the one that that introduced it so we don't have
broken tests. The other two merged to devel, thanks.
