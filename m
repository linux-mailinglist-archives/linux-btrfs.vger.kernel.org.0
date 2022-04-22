Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2E650C199
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Apr 2022 00:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiDVV6Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Apr 2022 17:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiDVV52 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Apr 2022 17:57:28 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43401404AD5
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Apr 2022 13:41:02 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nhzSt-0003Pj-8k by authid <merlin>; Fri, 22 Apr 2022 13:01:15 -0700
Date:   Fri, 22 Apr 2022 13:01:15 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220422200115.GV11868@merlins.org>
References: <20220405200805.GD28707@merlins.org>
 <CAEzrpqf0Gz=UuJ83woXOsRvcdC7vhH-b2UphuG-1+dUOiRc2Kw@mail.gmail.com>
 <YkzWAZtf7rcY/d+7@hungrycats.org>
 <20220406000844.GK28707@merlins.org>
 <Ykzvoz47Rvknw7aH@hungrycats.org>
 <20220406040913.GE3307770@merlins.org>
 <Yk3W88Eyh0pSm9mQ@hungrycats.org>
 <20220406191317.GC14804@merlins.org>
 <20220422184850.GX13115@merlins.org>
 <CAEzrpqfhCHL=pWXvQK9rYftQFe+Z6CyQPwRYxgCaX1w6JaqOTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqfhCHL=pWXvQK9rYftQFe+Z6CyQPwRYxgCaX1w6JaqOTA@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 22, 2022 at 03:46:08PM -0400, Josef Bacik wrote:
> We're doing the --init-extent-tree thing, which deletes the whole
> extent tree and rebuilds it.  This isn't the fast path, 3 days is
> super shitty tho.  I don't want to stop it and try and make it faster
> because once it's done you should just be golden.  It looks scary, but
> that's because it just clears the extent tree and then lets the normal
> repair thing do its thing, so it yells loudly about all the messed up
> references and then fixes it.
 
Got it.

> Now if we get to Monday and it's still running I can take a crack at
> making it faster.  I was hoping it would only take a day or two, but
> we're balancing me trying to make it better and possibly fucking it up
> with letting it take the rest of our lives but be correct.  Thanks,

Makes sense. I don't need faster, and it may not be able to go faster
anyway, it's a lot of data. Just wanted to make sure the output and
relative slow results were expected. 
And I'll go with slower but likely to work vs faster but very
experimental :)

That said, as Ted T'so said once, "anything with a progress bar is
faster".
So if it's possible in the future to add some completion percent, even
if approximate, that will help when it can take multiple days (or week+)
to run.

Happy to wait in the meantime, thanks.
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
