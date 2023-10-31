Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5809C7DCE57
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Oct 2023 14:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344670AbjJaNyQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Oct 2023 09:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344661AbjJaNyP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Oct 2023 09:54:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DE8DE
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Oct 2023 06:54:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0274D1F460;
        Tue, 31 Oct 2023 13:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698760452;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nq3UyrmdKGWO243Cgc+ENrAaJPKgQiwXqr/OpU7RcKU=;
        b=BQNEzCIR0Jr/zHHTa0Lq2z1TttwMFIbNb/0glLIbTZi4si2DcDrRcVPYjCZ9xEfmNQURrm
        XYrcnUQZtx7Z6g7/l7hyVVH/jXQDQZFSLtHtAQBRvm19hRkZoH/SxZFXRfxyU1agVZiHKR
        cGzyz5VsXCwvsoaVkeq57BVI7idGm54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698760452;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nq3UyrmdKGWO243Cgc+ENrAaJPKgQiwXqr/OpU7RcKU=;
        b=ddap0Hb0xo8O+5hwhKFHBQyQ5BsU46LtfI/KxkJQaUbpWy2B3YvEUNuLv/UUCWtZQ8jHHD
        qHGKtY9FofedExCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C3E69138EF;
        Tue, 31 Oct 2023 13:54:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mzrxLgMHQWXOfgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 31 Oct 2023 13:54:11 +0000
Date:   Tue, 31 Oct 2023 14:47:14 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: make found_logical_ret parameter mandatory for
 function queue_scrub_stripe()
Message-ID: <20231031134714.GC11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <4da50284fed071fea6d629f09d318f70a4e42c47.1698461922.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4da50284fed071fea6d629f09d318f70a4e42c47.1698461922.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Oct 28, 2023 at 01:28:45PM +1030, Qu Wenruo wrote:
> [BUG]
> There is a compiling warning reported on commit ae76d8e3e135 ("btrfs:
> scrub: fix grouping of read IO"), where gcc (14.0.0 20231022 experimental)
> is reporting the following uninitialized variable:
> 
>   fs/btrfs/scrub.c: In function ‘scrub_simple_mirror.isra’:
>   fs/btrfs/scrub.c:2075:29: error: ‘found_logical’ may be used uninitialized [-Werror=maybe-uninitialized[https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wmaybe-uninitialized]]
>    2075 |                 cur_logical = found_logical + BTRFS_STRIPE_LEN;
>   fs/btrfs/scrub.c:2040:21: note: ‘found_logical’ was declared here
>    2040 |                 u64 found_logical;
>         |                     ^~~~~~~~~~~~~
> 
> [CAUSE]
> This is a false alert, as @found_logical is passed as parameter
> @found_logical_ret of function queue_scrub_stripe().
> 
> As long as queue_scrub_stripe() returned 0, we would update
> @found_logical_ret.
> And if queue_scrub_stripe() returned >0 or <0, the caller would not
> utilized @found_logical, thus there should be nothing wrong.
> 
> Although the triggering gcc is still experimental, it looks like the
> extra check on "if (found_logical_ret)" can sometimes confuse the
> compiler.
> 
> Meanwhile the only caller of queue_scrub_stripe() is always passing a
> valid pointer, there is no need for such check at all.
> 
> [FIX]
> Although the report itself is a false alert, we can still make it more
> explicit by:
> 
> - Replace the check for @found_logical_ret with ASSERT()
> 
> - Initialize @found_logical to U64_MAX
> 
> - Add one extra ASSERT() to make sure @found_logical got updated
> 
> Link: https://lore.kernel.org/linux-btrfs/87fs1x1p93.fsf@gentoo.org/
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
