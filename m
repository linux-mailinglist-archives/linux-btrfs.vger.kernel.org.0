Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E4E4FBDE7
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 15:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346793AbiDKN6D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Apr 2022 09:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346812AbiDKN6C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Apr 2022 09:58:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CB521266;
        Mon, 11 Apr 2022 06:55:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7EE7D1F38D;
        Mon, 11 Apr 2022 13:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649685341;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jvZneIfxjRcQNcfnf0BL0BqjsNa/YtuGQgAtBxUt7x4=;
        b=WsTZTZAhI1CWBJF1IFXNYX+jawIqOs6VInW0XC/ooLvJyCyJTEiVdgDJMXley1SFUhavum
        TKY+7RxXhJuXfBjvRS9X64iOtB9PqcHHYD7GVugjQdheTazn0ZmDG1R0AzcfqL2Jq09mK5
        +4oKfD/74Xi4lO33LZeMFMT5X/drwc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649685341;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jvZneIfxjRcQNcfnf0BL0BqjsNa/YtuGQgAtBxUt7x4=;
        b=7KelmgT2O9nBRze2q8H41Z0itF/hOYujFvQV/SWzqSqcS86nxwYWS//undgsd0zVXII5zD
        EnF7qWEtg7ZjnyBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 74B26A3B87;
        Mon, 11 Apr 2022 13:55:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1C25CDA7DA; Mon, 11 Apr 2022 15:51:37 +0200 (CEST)
Date:   Mon, 11 Apr 2022 15:51:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Schspa Shi <schspa@gmail.com>
Cc:     clm@fb.com, Josef Bacik <josef@toxicpanda.com>, dsterba@suse.com,
        terrelln@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: zstd: use spin_lock in timer function
Message-ID: <20220411135136.GG15609@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Schspa Shi <schspa@gmail.com>,
        clm@fb.com, Josef Bacik <josef@toxicpanda.com>, dsterba@suse.com,
        terrelln@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220408181523.92322-1-schspa@gmail.com>
 <20220408184449.GB15609@twin.jikos.cz>
 <CAMA88Tp26+AWtcgU5yN=3Q5B8MSxqWMt=BpigQ3XADRJdOrpiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMA88Tp26+AWtcgU5yN=3Q5B8MSxqWMt=BpigQ3XADRJdOrpiA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 09, 2022 at 03:36:54PM +0800, Schspa Shi wrote:
> David Sterba <dsterba@suse.cz> writes:
> 
> > On Sat, Apr 09, 2022 at 02:15:23AM +0800, Schspa Shi wrote:
> >> timer callback was running on bh, and there is no need to disable bh again.
> >
> > Why do you think so? There was a specific fix fee13fe96529 ("btrfs:
> > correct zstd workspace manager lock to use spin_lock_bh()") that
> > actually added the _bh, so either you need to explain why exactly it's
> > not needed anymore and verify that the reported lockdep warning from the
> > fix does not happen.
> 
> Yes, I've seen this fix, and wsm.lru_list is protected by wsm.lock.
> This patch will not remove all changes that were fixed. Just a little
> improvement
> to remove the unnecessary bh disabling. Like
> static inline void red_adaptative_timer(struct timer_list *t)
> in net/sched/sch_red.c.
> 
> Because the critical section is only used by the process context and
> the softirq context,
> it is safe to remove bh_disable in the softirq context since it will
> not be preempted by the softirq.

So why haven't you written that as a proper explanation the first time,
you apparenly analyzed the correctness. Please update the changelog and
also please try to rephrase it so it's more readable, I kind of
understand what you mean but it still leaves some things to hard to
read. Thanks.
