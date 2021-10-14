Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F37042DBE8
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 16:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhJNOnZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 10:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhJNOnY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 10:43:24 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1883CC061570
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 07:41:20 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id n12so3850073qvk.3
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 07:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fz5DrS6fNXDIcSgCahyp5jAGJLlsiSu5E781WFHdpto=;
        b=AxV/3ObKUEN04a71+LNlW1OR2HW1G6MBWR8oj4M8AwTdSG3HensF+n3vczofiClp1W
         EXQBkgG9TcTh+HmKdpFOV1JMv7xPtRLB093oB6ni8/tHVaUXrXCnL2Sh6LJV9SLVg+N3
         pgnjPnLFGJ5nOOWqGcrmF0AQZ/TPlGl8XuKn7wWPabcce22Jhc0GZwSgvI2HA6NzxOaP
         VFfoopQ8fSLkDLF8fmCMG+WL6RkVOi2RhdpPEAi99o/Uwl5hDaN+fMSS7OwTAk7FCm6N
         aED+BwrxpTCnq+9W81+KedQAtADpkwgQrepYpR1id0ocA5+KMzVqIIO4lEVPvx3ikV5h
         jNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fz5DrS6fNXDIcSgCahyp5jAGJLlsiSu5E781WFHdpto=;
        b=Ix9C/QfXPt/X7xm03WIQ1A82zVJULsSn5fPLoYbPmPzZTWKgw2GbkRiyP77Z3luNTb
         0tLe5HDrocXte8kfkv/07M6WRqEP0MYWR0wC2w0FpMtU/TzoZqQKeuUc2/aKFfMAdq0w
         P8FO0lK/0XQ2DiL5f4fXQ+xN1BhCeMFxqgcolRKEC0dA1pjUjWCoqyhfycm+Hqm2h7pf
         ghv/uH03Usi8zZg+UHv3HLY7O9rnqjXB6KJvgIxUg2Nba0ZIYgNlvUxTroOVH2m96naY
         EpP45V0U7xjzdvg9XC74arxpl38F7AdoCYR5z+sVsGl5mD5pZPl+FRE0xG1wQFamLHyV
         s90w==
X-Gm-Message-State: AOAM5303naks0XJhHZ8AcvAazUG7wYnZdKE6pHsu7oedQXbxAKVL+MZn
        nE3hatbroTtEN8ZOQMVES/NsvmVGHfKQcw==
X-Google-Smtp-Source: ABdhPJwKA1AKg9/B6ZDi8AcvNH+ot4SfcwqD5V+bkhBxX5Au2tIdsdcz0aWT22A1b5rmOSTt5kuEpQ==
X-Received: by 2002:a05:6214:144c:: with SMTP id b12mr5560454qvy.56.1634222479052;
        Thu, 14 Oct 2021 07:41:19 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u10sm1521379qkp.58.2021.10.14.07.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 07:41:18 -0700 (PDT)
Date:   Thu, 14 Oct 2021 10:41:17 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix a triggered ASSERT() for generic/029 when
 executed with compression
Message-ID: <YWhBjf64v2Q0h8uM@localhost.localdomain>
References: <20211014071634.29738-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014071634.29738-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 14, 2021 at 03:16:34PM +0800, Qu Wenruo wrote:
> [BUG]
> When running generic/029 test with "-o compress" mount option, it will
> crash with the following ASSERT() triggered:
> 
>   assertion failed: PageLocked(page), in fs/btrfs/extent_io.c:5150
>   ------------[ cut here ]------------
>   kernel BUG at fs/btrfs/ctree.h:3495!
>   RIP: 0010:assertfail.constprop.0+0x18/0x1a [btrfs]
>   Call Trace:
>    extent_write_locked_range.cold+0x11/0x44 [btrfs]
>    submit_compressed_extents+0x42f/0x440 [btrfs]
>    async_cow_submit+0x37/0x90 [btrfs]
>    btrfs_work_helper+0x132/0x3e0 [btrfs]
>    process_one_work+0x294/0x5d0
>    worker_thread+0x55/0x3c0
>    kthread+0x140/0x170
>    ret_from_fork+0x22/0x30
>   ---[ end trace 32cf9a3b0c96a939 ]---
> 
> [CAUSE]
> Function extent_write_locked_range() expects all its pages being locked
> since btrfs_run_delalloc_range().
> Thus the ASSERT() in it is doing the correct check.
> 
> The problem is in submit_uncompressed_range(), which calls
> cow_file_range() to create ordered extent for it.
> 
> But since cow_file_range() can inline the data, callers must check if
> cow_file_range() created an inline extent, and handle it properly.
> 
> Unfortunately commit c12036efa894 ("btrfs: factor uncompressed async
> extent submission code into a new helper") did a wrong refactor, which
> uses "ret > 0" to check if cow_file_range() created an inline extent.
> 
> The correct check should be "page_start".
> 
> This causes submit_compressed_extents() always call
> extent_write_locked_range() even we have created an inline extent.
> 
> And when an inline extent is created, the page is unlocked and dirty bit
> cleared, which will trigger the new ASSERT() in
> extent_write_locked_range().
> 
> [FIX]
> Use the proper condition to check if cow_file_range() created an inline
> extent.
> 
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> 
> This commit can be fixed into the offending refactor.
> It looks like I can't escape the recent destiny that refactors are
> introducing more bugs.

This is what our continual testing is meant to catch, be happy the process is
working!

I do hate the return value here makes it a bit tricky to figure out what's going
on, looks like we just eat the ret == 1 value in cow_file_range(), so we're one
unfortunate refactor away from accidentally returning 1 from cow_file_range.  We
should probably rework that so it's less confusing and less error prone.

But that's for another day, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to this, thanks,

Josef
