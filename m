Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2ED71271F
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 May 2023 14:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243461AbjEZM6Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 May 2023 08:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjEZM6P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 May 2023 08:58:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11EF114;
        Fri, 26 May 2023 05:58:13 -0700 (PDT)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6A2FA21B38;
        Fri, 26 May 2023 12:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685105892;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CpDq1pEfvg+8XPmzv2uGKWtOfWpZEnVao4Y2FaBvNdM=;
        b=YG7Y03GVSMFb8q+Rg9XvSvo0mxcRYM+dU3uIw9PH9ZqThWYg3B+EczCjikkCWC4kujTYnb
        6gVef3hKq0LAmCK+pXea7PRXfSrv5BCrAvFiW2roPa+OBTwSJIbL3nAJY+DCLvAuM7vdMx
        +ynLi3q42MQVvCy8v3bZ4jO36YV7shE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685105892;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CpDq1pEfvg+8XPmzv2uGKWtOfWpZEnVao4Y2FaBvNdM=;
        b=hPceyvtQa2/Lf0ouJIMCpNaAMz5QTN9fZMjhDJcDTXh9oHvgI5ccWu8ylX7gm1LDWKBe6w
        sGsYZ0dSQCcgj/Bg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1FCF013684;
        Fri, 26 May 2023 12:58:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 29dDBuSscGTiXgAAGKfGzw
        (envelope-from <dsterba@suse.cz>); Fri, 26 May 2023 12:58:12 +0000
Date:   Fri, 26 May 2023 14:52:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Wang Yugui <wangyugui@e16-tech.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 08/13] btrfs: Use alloc_ordered_workqueue() to create
 ordered workqueues
Message-ID: <20230526125203.GA14830@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230509015032.3768622-1-tj@kernel.org>
 <20230509015032.3768622-9-tj@kernel.org>
 <20230509145332.GA32559@twin.jikos.cz>
 <ZFptXG44WVoWE0s4@slm.duckdns.org>
 <20230509233620.GN32559@twin.jikos.cz>
 <ZFrbiAyCiZ2aIZ4_@slm.duckdns.org>
 <ZG_wNJc_vGExt7m3@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG_wNJc_vGExt7m3@slm.duckdns.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 25, 2023 at 01:33:08PM -1000, Tejun Heo wrote:
> BACKGROUND
> ==========
> 
> When multiple work items are queued to a workqueue, their execution order
> doesn't match the queueing order. They may get executed in any order and
> simultaneously. When fully serialized execution - one by one in the queueing
> order - is needed, an ordered workqueue should be used which can be created
> with alloc_ordered_workqueue().
> 
> However, alloc_ordered_workqueue() was a later addition. Before it, an
> ordered workqueue could be obtained by creating an UNBOUND workqueue with
> @max_active==1. This originally was an implementation side-effect which was
> broken by 4c16bd327c74 ("workqueue: restore WQ_UNBOUND/max_active==1 to be
> ordered"). Because there were users that depended on the ordered execution,
> 5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1 to be ordered")
> made workqueue allocation path to implicitly promote UNBOUND workqueues w/
> @max_active==1 to ordered workqueues.
> 
> While this has worked okay, overloading the UNBOUND allocation interface
> this way creates other issues. It's difficult to tell whether a given
> workqueue actually needs to be ordered and users that legitimately want a
> min concurrency level wq unexpectedly gets an ordered one instead. With
> planned UNBOUND workqueue updates to improve execution locality and more
> prevalence of chiplet designs which can benefit from such improvements, this
> isn't a state we wanna be in forever.
> 
> This patch series audits all callsites that create an UNBOUND workqueue w/
> @max_active==1 and converts them to alloc_ordered_workqueue() as necessary.
> 
> BTRFS
> =====
> 
> * fs_info->scrub_workers initialized in scrub_workers_get() was setting
>   @max_active to 1 when @is_dev_replace is set and it seems that the
>   workqueue actually needs to be ordered if @is_dev_replace. Update the code
>   so that alloc_ordered_workqueue() is used if @is_dev_replace.
> 
> * fs_info->discard_ctl.discard_workers initialized in
>   btrfs_init_workqueues() was directly using alloc_workqueue() w/
>   @max_active==1. Converted to alloc_ordered_workqueue().
> 
> * fs_info->fixup_workers and fs_info->qgroup_rescan_workers initialized in
>   btrfs_queue_work() use the btrfs's workqueue wrapper, btrfs_workqueue,
>   which are allocated with btrfs_alloc_workqueue().
> 
>   btrfs_workqueue implements automatic @max_active adjustment which is
>   disabled when the specified max limix is below a certain threshold, so
>   calling btrfs_alloc_workqueue() with @limit_active==1 yields an ordered
>   workqueue whose @max_active won't be changed as the auto-tuning is
>   disabled.
> 
>   This is rather brittle in that nothing clearly indicates that the two
>   workqueues should be ordered or btrfs_alloc_workqueue() must disable
>   auto-tuning when @limit_active==1.
> 
>   This patch factors out the common btrfs_workqueue init code into
>   btrfs_init_workqueue() and add explicit btrfs_alloc_ordered_workqueue().
>   The two workqueues are converted to use the new ordered allocation
>   interface.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Wang Yugui <wangyugui@e16-tech.com>
> Cc: Chris Mason <clm@fb.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: David Sterba <dsterba@suse.com>
> Cc: linux-btrfs@vger.kernel.org
> ---
> Hello,
> 
> David, I think this is a bit too invasive to carry through workqueue tree.
> If this looks okay, can you plase apply route it through the btrfs tree?

Yesd and I actually prefer to take such patches via btrfs tree unless
there's a strong dependency on other patches from another subsystem.
Thanks.
