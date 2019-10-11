Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1B5FD4662
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2019 19:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbfJKRPc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Oct 2019 13:15:32 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41392 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbfJKRPb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Oct 2019 13:15:31 -0400
Received: by mail-qt1-f196.google.com with SMTP id v52so14866077qtb.8
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2019 10:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5tl0RHhNCFZUxJnnQPpFBbh3cS310QvpZIpP1U0g0O0=;
        b=lVSDNGCwNssW3ByZ2JF5IQhFeLNOz740TMcm8tnIrxXVXgSrbj69RNCx/B4G1J85nv
         ZLtyTPnnXI39ydOhvaq4YNeRPSjjF+LTp1Z/KqZRBpz8Y1XNNBNN0+armsPWMR3OVoOh
         y21wfidCQyeEo8CCVyThfRYO/d0Kbn6NUBCxLXSd+KrKnlxL1c6olPxPA5n5svF9vmAD
         69leOCYyTjSDWCU7mbIeq3JSv4jVNwD/cwFYte3OvcfC3ZlQoV7ZuoViuGbITN8L4vvn
         Hb/KIoOfP1pJboeRuUnG15Q6sDY5rXD4a+fr8xMI9O8yXO3QPzr+OKGwocj0XER+l+YB
         sGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5tl0RHhNCFZUxJnnQPpFBbh3cS310QvpZIpP1U0g0O0=;
        b=TuH71A7wCHbeZ/T+tExE/A6SOdOCmydKF+6GO6eaUqga118p/ctlc8L0oex+YXjV1z
         ys6Y5isA/cbAkrq06+M7fjGRE6NQx9OVPFRlE7qMN/+hQjDjy6Laz0C1pFB/dY/NiybE
         tPOfqVV6mDm+JZgbLPnq9JjuPdXEeCrpiPB/zkJyKScNglZ8v0OFe3i/wgYILUp9Emn5
         WWxG9qAH0uAV63gOqHE7oPHnV0fBvph+eLZj0YsYA6tadqZS56aWcyLBFY3n+5Bqj7nU
         lqCk67xHHF8CZ8xtJFt9a8yZyNUJxkuR5RJdEFgVkHYWIYLV/Yaku+929RkLBR9IuBqW
         WYZA==
X-Gm-Message-State: APjAAAWB+O/yeII1yLbZYWQp5iTw76nXsN6TBiAeUgoQoNnX8GJz08Ej
        GupdbzKqPHlKVL4fM88dk4AWyQ==
X-Google-Smtp-Source: APXvYqyFZmMJr/SQI0Bf3hdDNpsBeZyuE42nOzXYlxfexxyXpsiefdd9nHOlMUwBpGXYbyu4olbQQQ==
X-Received: by 2002:a05:6214:370:: with SMTP id t16mr7699886qvu.245.1570814130641;
        Fri, 11 Oct 2019 10:15:30 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::d36])
        by smtp.gmail.com with ESMTPSA id c204sm5078639qkb.90.2019.10.11.10.15.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 10:15:30 -0700 (PDT)
Date:   Fri, 11 Oct 2019 13:15:28 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: save i_size in compress_file_range
Message-ID: <20191011171527.v4rdw6ex3fcnqzmw@macbook-pro-91.dhcp.thefacebook.com>
References: <20191011130354.8232-1-josef@toxicpanda.com>
 <CAL3q7H79yipNYZgO2Es-Zn0mBKbWoH07Zdv4P473C5NQv9fEqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H79yipNYZgO2Es-Zn0mBKbWoH07Zdv4P473C5NQv9fEqA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 11, 2019 at 04:28:28PM +0100, Filipe Manana wrote:
> On Fri, Oct 11, 2019 at 2:05 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > We hit a regression while rolling out 5.2 internally where we were
> > hitting the following panic
> >
> > kernel BUG at mm/page-writeback.c:2659!
> > RIP: 0010:clear_page_dirty_for_io+0xe6/0x1f0
> > Call Trace:
> >  __process_pages_contig+0x25a/0x350
> >  ? extent_clear_unlock_delalloc+0x43/0x70
> >  submit_compressed_extents+0x359/0x4d0
> >  normal_work_helper+0x15a/0x330
> >  process_one_work+0x1f5/0x3f0
> >  worker_thread+0x2d/0x3d0
> >  ? rescuer_thread+0x340/0x340
> >  kthread+0x111/0x130
> >  ? kthread_create_on_node+0x60/0x60
> >  ret_from_fork+0x1f/0x30
> >
> > this is happening because the page is not locked when doing
> > clear_page_dirty_for_io.  Looking at the core dump it was because our
> > async_extent had a ram_size of 24576 but our async_chunk range only
> > spanned 20480, so we had a whole extra page in our ram_size for our
> > async_extent.
> >
> > This happened because we try not to compress pages outside of our
> > i_size, however a cleanup patch changed us to do
> >
> > actual_end = min_t(u64, i_size_read(inode), end + 1);
> >
> > which is problematic because i_size_read() can evaluate to different
> > values in between checking and assigning.  So either a expanding
> > truncate or a fallocate could increase our i_size while we're doing
> 
> Well, not just those operations but a write starting at or beyond eof
> could also do it,
> since at writeback time we don't hold the inode's lock and the
> buffered write path doesn't lock the range if it starts at or past
> current i_size.
>

Yeah it was just for example.

> > writeout and actual_end would end up being past the range we have
> > locked.
> >
> > I confirmed this was what was happening by installing a debug kernel
> > that had
> >
> > actual_end = min_t(u64, i_size_read(inode), end + 1);
> > if (actual_end > end + 1) {
> >         printk(KERN_ERR "WE GOT FUCKED\n");
> 
> I think we coud be more polite on changelogs and mailing lists, or we
> could add a tag in the subjects warning about improper content like
> video games and music records :)
> 

Hah, well that's what I put, but we can change it for the changelog if it's a
problem.  Thanks,

Josef
