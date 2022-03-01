Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5464C8F67
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Mar 2022 16:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbiCAPs0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Mar 2022 10:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235899AbiCAPsZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Mar 2022 10:48:25 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AC251E78
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Mar 2022 07:47:43 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A62502110B;
        Tue,  1 Mar 2022 15:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646149662;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L0eAkgBlQsr8HYgnerdJEz8u5DJYhAoJ/CJeSTz50/A=;
        b=TJkjmBh7YDV6ZLL6gfZj9LqnlIbbk/Dn9Vm3tdvZ7alv6OyjDBJo3QZp/8cTTFQrJl9w5b
        o1RuNyeujOmzR9QgDPlmsOT+FBUH+9AAUkJMBvNUKGDybVN8gsuLxJm2d1W6CHus7+A1Wc
        pAzg1hlxDD9koFw9Myv3b8irxiliDWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646149662;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L0eAkgBlQsr8HYgnerdJEz8u5DJYhAoJ/CJeSTz50/A=;
        b=oIIP934LN5RbKv8XqM4RZ0xR8AH+o3J2NQJcKh7BtACCrUP9DoGoxTpXK52czBzSLgEpOf
        aHZkWvp+T6ZSFqCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A0493A3B89;
        Tue,  1 Mar 2022 15:47:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 32B43DA80E; Tue,  1 Mar 2022 16:43:51 +0100 (CET)
Date:   Tue, 1 Mar 2022 16:43:50 +0100
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: remove redundant check in up
 check_setget_bounds
Message-ID: <20220301154350.GP12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <ea59f1a0b66e214ec12864931711b764605fbacb.1645794094.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea59f1a0b66e214ec12864931711b764605fbacb.1645794094.git.dsterba@suse.com>
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

On Fri, Feb 25, 2022 at 02:17:14PM +0100, David Sterba wrote:
> There are two separate checks in the bounds checker, the first one being
> a special case of the second. As this function is performance critical
> due to checking access to any eb member, reducing the size can slightly
> improve performance.
> 
> On a release build on x86_64 the helper is completely inlined so the
> function call overhead is also gone.
> 
> There was a report of 5% performance drop on metadata heavy workload,
> that disappeared after disabling asserts. The most significant part of
> that is the bounds checker.
> 
> https://lore.kernel.org/linux-btrfs/20200724164147.39925-1-josef@toxicpanda.com/
> 
> After the analysis, the optimized code removes the worst overhead which
> is the function call and the performance was restored.
> 
> https://lore.kernel.org/linux-btrfs/20200730110943.GE3703@twin.jikos.cz/
> 
> 1. baseline, asserts on, setget check on
> 
> run time:		46s
> run time with perf:	48s
> 
> 2. asserts on, comment out setget check
> 
> run time:		44s
> run time with perf:	47s
> 
> So this is confirms the 5% difference
> 
> 3. asserts on, optimized seget check
> 
> run time:		44s
> run time with perf:	47s
> 
> The optimizations are reducing the number of ifs to 1 and inlining the
> hot path. Low-level stuff, gets the performance back. Patch below.
> 
> 4. asserts off, no setget check
> 
> run time:		44s
> run time with perf:	45s
> 
> This verifies that asserts other than the setget check have negligible
> impact on performance and it's not harmful to keep them on.
> 
> Analysis where the performance is lost:
> 
> * check_setget_bounds is short function, but it's still a function call,
>   changing the flow of instructions and given how many times it's
>   called the overhead adds up
> 
> * there are two conditions, one to check if the range is
>   completely outside (member_offset > eb->len) or partially inside
>   (member_offset + size > eb->len)
> 
> CC: stable@vger.kernel.org # 5.10+
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: David Sterba <dsterba@suse.com>

I still see some tests failed and don't have time to investigate, so
postponing it.
