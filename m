Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9846E820C
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 21:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjDSTpc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 15:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjDSTpb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 15:45:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712461FC3
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 12:45:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1C74F1FDBC;
        Wed, 19 Apr 2023 19:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681933529;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ZUJpkT1sgN8hu65NlC1zszUUagj6REkDAWMDWzA3KA=;
        b=NK/6TWxpF+EdNRyJqLv+DuKb/p1uC4iTqyn/si0bxoumINNRaUTl9FiJ2j+GHq7/JNmT1p
        pd8TjW223HCa3QT4er/yDa+R7Ai0W5Ejlo6eCtE5OV0jxuDe91JfGU/CtT75BlbzHzBfUQ
        cYrAqzvk+Bhss7ukJCyA6ByAQHXRSrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681933529;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ZUJpkT1sgN8hu65NlC1zszUUagj6REkDAWMDWzA3KA=;
        b=inZVjFIucxOsGg1geSbcewzkqe7Iy5LXhFJtwpcqZHhx/wQejwzkQ4DENzs1H8TFji6Zdi
        LmpsjcErwYuqVxDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E4DA71390E;
        Wed, 19 Apr 2023 19:45:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id w5n+NthEQGQoEwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 19 Apr 2023 19:45:28 +0000
Date:   Wed, 19 Apr 2023 21:45:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: fix race window during mkfs
Message-ID: <20230419194519.GV19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <eda4915edce8006a1578082817733a9af74a9b97.1678860378.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eda4915edce8006a1578082817733a9af74a9b97.1678860378.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 15, 2023 at 02:06:54PM +0800, Qu Wenruo wrote:
> [BUG]
> There is an internal bug report that, after mkfs.btrfs there is a chance
> that no /dev/disk/by-uuid/<uuid> soft link is not created at all.
> 
> [CAUSE]
> That uuid soft link is created by udev, which listens inotify
> IN_CLOSE_WRITE events from all block devices.
> 
> After such IN_CLOSE_WRITE event is triggered, udev would *disable*
> inotify for that block device, and do a blkid scan on it.
> After the blkid scan is done, re-enable the inotify listening.
> 
> This means normally mkfs tools should open the fd, do all the writes,
> and close the fd after everything is done.
> 
> But unfortunately for mkfs.btrfs, it's not the case, we have a lot of
> phases seperated by different close() calls:
> 
>   open_ctree() would open fds of each involved device
>   and close them at close_ctree()
>   Only after close_ctree() we have a valid superblock -\
>                                                        |
> |<------- A -------->|<--------- B --------->|<------- C ------->|
>           |                      |
>           |                      `- open a new fd for make_btrfs()
>           |                         and close it before open_ctree()
>           |                         The device contains invalid sb.
>           |
>           `- open a new fd for each device, then call
>              btrfs_prepare_device(), then close the fd.
>              The device would contain no valid superblock.
> 
> If at the close() of phase A udev event is triggered, while doing udev
> scan we go into phase C (but before the new valid super blocks written),
> udev would only see no superblock or invalid superblock.
> 
> Then phase C finished, udev resume its inotify listening, but at this
> timing mkfs is finished, while udev only see the premature data from
> phase A, and missed the IN_CLOSE_WRITE events from phase C.
> 
> [FIX]
> Instead of open and close a new fd for each device, re-use the fd opened
> during prepare_one_device(), and close all the fds until close_ctree()
> is called.
> 
> By this, although we may still have race between close_ctree() and
> explicit close() calls, at least udev can always see the properly
> written super blocks.
> 
> To compensate the change, some extra cleanups are made:
> 
> - Do not touch @device_count
>   Which makes later prepare_ctx iteration much easier.
> 
> - Remove top-level @fd variable
>   Instead go with prepare_ctx[i].fd.
> 
> - Do not open with O_RDWR in test_dev_for_mkfs()
>   as test_dev_for_mkfs() would close the fd, if we go O_RDWR, it can
>   cause the udev race.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Fix the call site in test_dev_for_mkfs()

Added to devel. Thanks for writing down the analysis, the interactions
between udev and open/close are tricky.
