Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E21C6D849C
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 19:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjDERMI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 13:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjDERMH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 13:12:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA046198
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 10:11:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4DC74202E3;
        Wed,  5 Apr 2023 17:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680714712;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bRZ3ZiGNgSiIw18RmQVs34XZAt6qUoNFSz2+fJzF2TU=;
        b=ELiXz8tjtj2a5qhTR7bdMyjDPnG+puhoA5189EMbD6dtYScqhqXwtneU0l4rduCn9uOEf5
        XvOUgEosp+8zLaYSYkgIwkER4eDfMXQNQsQKvJRVXJs1I0uuV03vJ6AAFGDP1WQbcnqeaJ
        b1qxYGHyE7tJX2SehsV4b1hT3Q3pOjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680714712;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bRZ3ZiGNgSiIw18RmQVs34XZAt6qUoNFSz2+fJzF2TU=;
        b=WFrKGUQNGPjx87tH76T8lggXGwk5LMfIJ9NFEvupZXYzefKPJ4KUJ5xh2IAf6wNgBz3P6n
        vbC6T8zOJqclPsBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 20DB013A10;
        Wed,  5 Apr 2023 17:11:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4PjtBtirLWT5YAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 05 Apr 2023 17:11:52 +0000
Date:   Wed, 5 Apr 2023 19:11:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v8 00/12] btrfs: scrub: use a more reader friendly code
 to implement scrub_simple_mirror()
Message-ID: <20230405171149.GL19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1680225140.git.wqu@suse.com>
 <20230331161716.GV10580@twin.jikos.cz>
 <25f1df54-9abd-d4e0-7dba-9b341bc4ad6e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25f1df54-9abd-d4e0-7dba-9b341bc4ad6e@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 04, 2023 at 09:08:31AM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/4/1 00:17, David Sterba wrote:
> > On Fri, Mar 31, 2023 at 09:20:03AM +0800, Qu Wenruo wrote:
> >> This series can be found in my github repo:
> >>
> >> https://github.com/adam900710/linux/tree/scrub_stripe
> > 
> > This also includes the cleanup branch so I'll use this as topic branch
> > in for-next.
> 
> Thanks for that.
> 
> Just some questions inspired by the series.
> 
> [WAY TO CLEANUP]
> Just want to ask what's the proper way to do the cleanup.
> 
> Christoph mentioned in other subsystems they accept huge cleanup as long 
> as it's only deleting code, while in my series I did the split to try 
> keep each cleanup small.

I've just finished final pass through the scrub series so I can give you
a fresh answer. The split was great and thank you for taking the time to
do it. I don't treat deleting code differently than adding code.
Deleting also affects functionality, we've seen a recent example when
deleting code broke the thread_pool mount option. The review question is
"does it still work as expected when this code is gone?". As an extreme
example imagine deleting a mutex, it will make things faster but also
wrong.

If there are other subsystems where deleting code is not taken seriously
the same way new code is then I have my doubts about the review quality.

> But the split itself sometimes introduced dead code which is only going 
> to be removed later, and most of the time, such new code makes no sense 
> other than for patch split.

The reason I ask for split is to let me maintain focus on what's being
changed, and with too many deleted lines it's easy to overlook something
or sipmly fatigue.  Which means the review would be useless.
The removal patches are over 3000 lines in total, separately a few
hundreds each and logically grouped.

Adding a few lines to avoid warnings or to making it compile is a small
cost and as you did it with the comments it's quite clear where it is
and why.

> So I'm wondering what's the proper way to do huge cleanup in btrfs.

As you did it in the scrub series is a great example to follow for next
time.

> [FUTURE SCRUB UPDATE]
> There are still something I may want to do improving scrub.
> 
> One such objective is to enhance RAID56 scrubbing.
> 
> In that case, what branch should I base my code on?
> Normally I would go misc-next, but the new scrub is only in for-next.

I'll move it to misc-next so you can start there.
