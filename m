Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA225AE93B
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Sep 2022 15:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240090AbiIFNR3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Sep 2022 09:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbiIFNR2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Sep 2022 09:17:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542F94F1A2
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Sep 2022 06:17:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D052D1F8B3;
        Tue,  6 Sep 2022 13:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662470243;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TX6I2O5EhDSm01wZTFyseXdD+CiiT9aypru/TOUvsbo=;
        b=i6srVq4wiWY6gyhbc4pDuUzAFvVD1s/lfeP6NtiJAQ/Z37xS+ijP7aZw97uiADMIiaU0ck
        o/4KuIWspZVuT+ha25FDYNb3kubuMr0X0YsBUbgq7ZG5VwiMaLjUgzgbtsL9Bl7Gkj4mhT
        qgmsLU/gz2ABZ8w0lSFuqaTaoFru9xI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662470243;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TX6I2O5EhDSm01wZTFyseXdD+CiiT9aypru/TOUvsbo=;
        b=GYylBoqPhrgeQVF4ROBOfcqvxiP13AnWSC2fhvXEscL1eIvIQOFNwOQnHoEiE1YbBd23Dc
        p4SaOH/tdyPoAhBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A00413A19;
        Tue,  6 Sep 2022 13:17:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kyWnJGNIF2NWWgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 06 Sep 2022 13:17:23 +0000
Date:   Tue, 6 Sep 2022 15:12:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: btrfs I/O completion cleanup and single device I/O optimizations
 v2
Message-ID: <20220906131201.GM13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20220713061359.1980118-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713061359.1980118-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 13, 2022 at 08:13:48AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series cleans up the btrfs_bio API, most prominently by splitting
> the end_io handler for the highlevel bio from the low-level bio
> bi_end_io, which are really confusingly coupled in the current code.
> Once that is done it then optimizes the bio submission to not allocate
> a btrfs_io_context for I/Os tht just go to a single device.
> 
> This series sits on top of the for-next tree that has the "fix read
> repair on compressed extents v2" series included.  To make everyones life
> easier a git tree is also available:
> 
>     git://git.infradead.org/users/hch/misc.git btrfs-bio-api-cleanup
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-bio-api-cleanup
> 
> Note that I've picked up the reviews and tested tags from the last
> posting for the patches that are relatively unchainged or just split,
> so they might appear a little inconsistent.
> 
> Changes since v1:
>  - add two previously submitted patches skipped from an earlier
>    series
>  - merged one of those patches with one from this series
>  - split one of the patches in this series into three
>  - improve various commit logs

This patchset has been merged a few weeks back, I wanted to reply
regarding a few things. The changes touch critical code, there are
cleanups but doing functional changes but the changelogs are IMHO
insufficient.  The code is not touched often and the changelog is the
only thing left that's supposed to hold some code documentation,
explanations and descriptions of new logic. I'm not counting the obvious
and fairly straightfowrad changes.

Let me point out one example, the 5/11 "btrfs: remove
bioc->stripes_pending". The subject gives a false idea what's going on.
There was a member removed, yes but the whole logic regarding bios is
changed, it's now using the bio chaining, as mentioned in the first
paragraph at least. Other patches state in words what the code does, not
explaining why.

Each such patch requires a more thorough review and rewriting or
updating the changelog. I do that for free for irregular contributors,
otherwise I'd rather see we're on the same page.

I'm also worried when none of the Reviewed-by come with a comment
regarding the changelogs. Any code can be understood after enough time,
but we need to track that so we can refer to it in the future.
