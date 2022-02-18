Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9BA4BBDF5
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 18:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238133AbiBRRB3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 12:01:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbiBRRBZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 12:01:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38152B2C6A
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 09:01:08 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B14B61F37F;
        Fri, 18 Feb 2022 17:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645203667;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HDxVcZZdDJLM+SiXX1ofXjhhnLe1Q8bMjhQmFFJN1z4=;
        b=sJzPjVNgiXRlVDzf8rXtfqioh3EsKHbg548XVm+Lc17x/5HIJ3tLypzBvz8EIQACS/sx1M
        vpRw6c/VwIsi/k9TXuz8xpfs1fK11MP6qMAwMZZb9TUDg7aJijxwBIt0tnIH//zoTL0U9v
        NbEH2+CSixGFvY6TZQd08Kp6OEdoXiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645203667;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HDxVcZZdDJLM+SiXX1ofXjhhnLe1Q8bMjhQmFFJN1z4=;
        b=d9vNSuRmNya8KtQbJJCc04miMmxPIdQTdFwDlfb+OMMltIhlAkVWeERvVpOAHnAzH1MWiA
        UkFOXmMjaJTb3+Bw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id AA9B9A3B88;
        Fri, 18 Feb 2022 17:01:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0DD1BDA829; Fri, 18 Feb 2022 17:57:22 +0100 (CET)
Date:   Fri, 18 Feb 2022 17:57:21 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: subpage: fix a wrong check on subpage->writers
Message-ID: <20220218165721.GD12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <486801f8e45849c882c2531fe72b6a120429be07.1645150277.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <486801f8e45849c882c2531fe72b6a120429be07.1645150277.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 18, 2022 at 10:13:00AM +0800, Qu Wenruo wrote:
> [BUG]
> When looping btrfs/074 with 64K page size and 4K sectorsize, there is a low
> chance (1/50~1/100) to crash with the following ASSERT() triggered in
> btrfs_subpage_start_writer():
> 
> 	ret = atomic_add_return(nbits, &subpage->writers);
> 	ASSERT(ret == nbits); <<< This one <<<
> 
> [CAUSE]
> With more debugging output on the parameters of
> btrfs_subpage_start_writer(), it shows a very concerning error:
> 
>   ret=29 nbits=13 start=393216 len=53248
> 
> For @nbits it's correct, but @ret which is the returned value from
> atomic_add_return(), it's not only larger than nbits, but also larger
> than max sectors per page value (for 64K page size and 4K sector size,
> it's 16).
> 
> This indicates that some call sites are not properly decreasing the value.
> 
> And that's exactly the case, in btrfs_page_unlock_writer(), due to the
> fact that we can have page locked either by lock_page() or
> process_one_page(), we have to check if the subpage has any writer.
> 
> If no writers, it's locked by lock_page() and we only need to unlock it.
> 
> But unfortunately the check for the writers are completely opposite:
> 
> 	if (atomic_read(&subpage->writers))
> 		/* No writers, locked by plain lock_page() */
> 		return unlock_page(page);
> 
> We directly unlock the page if it has writers, which is the completely
> opposite what we want.
> 
> Thankfully the affected call site is only limited to
> extent_write_locked_range(), so it's mostly affecting compressed write.
> 
> [FIX]
> Just fix the wrong check condition to fix the bug.
> 
> Fixes: e55a0de18572 ("btrfs: rework page locking in __extent_writepage()")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to msic-next. Do we want this for stable? I think not as the
subpage support is not complete.
