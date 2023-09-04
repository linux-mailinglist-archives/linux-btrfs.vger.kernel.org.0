Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BA5791F91
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 00:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241562AbjIDWjn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Sep 2023 18:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbjIDWjm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Sep 2023 18:39:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769E89D
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Sep 2023 15:39:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2DBFC1F37C;
        Mon,  4 Sep 2023 22:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693867177;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5D1mTId2MJ7LMmbZGkTv9ZC+S4KuiwrQ+bJVVfwaYKY=;
        b=iEbCSrcl1mTXmaoXqvELiWXGJIAeRcZE4dDAUMQAjmsm7p1EDjFSTQDQ85JUDrw2ByWk0V
        VBKDKhlrGdcv7qUS7KfxwZD2srLO1T6uZd17hBUG8giJjCp1USXLRKS5fXa+fiMPk5VH8m
        kvVdMKLp8B0E9t1DSKVji83UoT+OXVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693867177;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5D1mTId2MJ7LMmbZGkTv9ZC+S4KuiwrQ+bJVVfwaYKY=;
        b=cP/wcYuvyX7ZhJpR3ErtzyXp6sdqiL6yOtYE1U2zyvhu+MQ4KWLG6uXciw/J0khL88HhGZ
        SksEpuxGxdCFejCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 00FF213585;
        Mon,  4 Sep 2023 22:39:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QeW6Oqhc9mQ/DgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 04 Sep 2023 22:39:36 +0000
Date:   Tue, 5 Sep 2023 00:32:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: do not block starts waiting on previous
 transaction commit
Message-ID: <20230904223257.GP14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <042d69d13a10b90a29b5e096db59b9669fac68d2.1692910751.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <042d69d13a10b90a29b5e096db59b9669fac68d2.1692910751.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 24, 2023 at 04:59:22PM -0400, Josef Bacik wrote:
> Internally I got a report of very long stalls on normal operations like
> creating a new file when auto relocation was running.  The reporter used
> the bpf offcputime tracer to show that we would get stuck in
> start_transaction for 5 to 30 seconds, and were always being woken up by
> the transaction commit.
> 
> Using my timing-everything script, which times how long a function takes
> and what percentage of that total time is taken up by its children, I
> saw several traces like this
> 
> 1083 took 32812902424 ns
>         29929002926 ns 91.2110% wait_for_commit_duration
>         25568 ns 7.7920e-05% commit_fs_roots_duration
>         1007751 ns 0.00307% commit_cowonly_roots_duration
>         446855602 ns 1.36182% btrfs_run_delayed_refs_duration
>         271980 ns 0.00082% btrfs_run_delayed_items_duration
>         2008 ns 6.1195e-06% btrfs_apply_pending_changes_duration
>         9656 ns 2.9427e-05% switch_commit_roots_duration
>         1598 ns 4.8700e-06% btrfs_commit_device_sizes_duration
>         4314 ns 1.3147e-05% btrfs_free_log_root_tree_duration
> 
> Here I was only tracing functions that happen where we are between
> START_COMMIT and UNBLOCKED in order to see what would be keeping us
> blocked for so long.  The wait_for_commit() we do is where we wait for a
> previous transaction that hasn't completed it's commit.  This can
> include all of the unpin work and other cleanups, which tends to be the
> longest part of our transaction commit.
> 
> There is no reason we should be blocking new things from entering the
> transaction at this point, it just adds to random latency spikes for no
> reason.
> 
> Fix this by adding a PREP stage.  This allows us to properly deal with
> multiple committers coming in at the same time, we retain the behavior
> that the winner waits on the previous transaction and the losers all
> wait for this transaction commit to occur.  Nothing else is blocked
> during the PREP stage, and then once the wait is complete we switch to
> COMMIT_START and all of the same behavior as before is maintained.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Interesting, so splitting the state to 2 makes N threads race for the
first half and the winner proceed, not to race with any of the other
while progressing in the transaction flow. This resembles the MCS
spinlocks, the state is split into the owner of the state and the other
threads that have queued to acquire it. The transaction state is a bit
different, heavier than a spin lock, but still there's an atomic switch
once the winner finishes the work and lets the other threads race again.

Added to misc-next, thanks. As this is changing the core mechanism of a
transaction I'd rather let it get tested for a longer time so
technically this is a fix will wait a bit.
