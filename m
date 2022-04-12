Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F944FEA3C
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Apr 2022 01:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiDLXSH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Apr 2022 19:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiDLXSA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Apr 2022 19:18:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6037D223BE5
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 15:04:26 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EA94A2112B;
        Tue, 12 Apr 2022 20:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649796392;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YIVSvtt6H1jOaR0Z7YawJvNY9d2jjHFLhVX+UW1rnmY=;
        b=aDcVF2hNKQMTaUeqXJyIPVDKnbUMSssYT2sxLB1yK6RUuVJStUUUoWl7k2Eg3xQpBoisv7
        IJvV0OWB5BFUTl4IuB+z04nUc64GIqgWurKt0yzSyii/5FnrCF1yCJl4EZaBa/9fXq23LJ
        8zYpcqP+DGIS907HMb3lZn9PIoCv4xw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649796392;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YIVSvtt6H1jOaR0Z7YawJvNY9d2jjHFLhVX+UW1rnmY=;
        b=kzeQhE2AfcvO6l57GcP1N4CmTzB85kvW8/CvnUxjnoqAUPBZ7hphlN8wxt5EEbozkjfBII
        xTteoVvW60zRfmBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E21FAA3B82;
        Tue, 12 Apr 2022 20:46:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EA531DA7B0; Tue, 12 Apr 2022 22:42:27 +0200 (CEST)
Date:   Tue, 12 Apr 2022 22:42:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] btrfs: vairous bug fixes related to generic/475
 failure with subpage cases
Message-ID: <20220412204227.GB15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1649766550.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1649766550.git.wqu@suse.com>
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

On Tue, Apr 12, 2022 at 08:30:12PM +0800, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Make submit_one_bio() to return void just in the same patch
> 
> - Update the commit message the for 2nd patch
>   To mention remaining error path (which is not really possible to
>   trigger), to prove the first patch is already fixing all involved
>   error paths.
> 
> [DESCRIPTION]
> When testing my subpage raid56 support, generic/475 is always hanging
> with some data page unable to be unlocked.
> 
> It turns out that, the hang is not related to the raid56 subpage
> support (obviously, as the test case is not utilizing RAID56 at all),
> but a recent commit 1784b7d502a9 ("btrfs: handle csum lookup errors
> properly on reads") introduced a new error path, and it caught us by
> surprise.
> 
> The new error path is from btrfs_lookup_bio_sums(), which can now return
> error if the csum search failed.
> 
> This new error path exposed several problems:
> 
> - Double cleanup for submit_one_bio() and its callers
>   Bio submission hooks, btrfs_submit_data_bio() and
>   btrfs_submit_metadata_bio() will call endio to cleanup on errors.
> 
>   But those bio submission hooks will also return error, and
>   finally callers of submit_extent_page() will also try to do
>   cleanup.
> 
>   This will be fixed by the first patch, by always returning 0 for
>   submit_one_bio().
>   This fix is kept as minimal as possible, to make backport easier.
>   The proper conversion to return void will be done in the last patch.
> 
> - btrfs_do_readpage() can leave page locked on error
>   If submit_extent_page() failed in btrfs_do_readpage(), we only
>   cleanup the current range, and leaving the remaining subpage
>   range locked.
> 
>   This bug is subpage specific, and will not affect regular cases.
> 
>   Fix it by cleaning up all the remaining subpage range before
>   exiting.
> 
> - __extent_writepage_io() can return 0 even it hit some error
>   Although we continue writing the remaining ranges, we didn't save
>   the first error, causing @ret to be overwritten.
>  
>   This bug is subpage specific, as for regular cases we only have one
>   sector inside the page.
> 
>   Fix it by introducing @has_error and @saved_ret.
> 
> I manually checked all other submit_extent_page() callers, they all
> look fine and won't cause problems like the above.
> 
> Finally since submit_one_bio() will always return 0, the final patch
> will make it return void, which greatly makes our code cleaner.
> 
> But that patch is introducing quite some modifications, not a candidate
> for backport, unlike the first 3 patches.
> 
> Special thanks to Josef, as my initial bisection points to his patch and
> I have no clue why it can cause problems at all.
> His hints immediately solved all my questions, and lead to this
> patchset.
> 
> 
> Qu Wenruo (3):
>   btrfs: avoid double clean up when submit_one_bio() failed
>   btrfs: fix the error handling for submit_extent_page() for
>     btrfs_do_readpage()
>   btrfs: return correct error number for __extent_writepage_io()

Added as topic branch to for-next, thanks.
