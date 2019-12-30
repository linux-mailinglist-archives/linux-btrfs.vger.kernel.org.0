Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B82912D388
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 19:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfL3Ste (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Dec 2019 13:49:34 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41336 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfL3Ste (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 13:49:34 -0500
Received: by mail-qk1-f194.google.com with SMTP id x129so26868325qke.8
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Dec 2019 10:49:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7inNwzDPs7UwRAKAWJja/EJVhaQmUrjrupNjU4knubE=;
        b=sSk3clVnmYeajJfLPvvPagA8gkxW7JDSZHHbST4ZQwtnrzjCmguBm9CMBtUDARY43O
         mmp26QqBXk0clAmMVI6M2vPVnYEWsLk/obswq51wZq70gzOFVro/u8nVhp9nK0NZjcCp
         Pi80DeHQJOnxDJoQDNddQwcqH5e72u2XNzgSqtKaz5ps8EpOPy+7xALwIIVdTYZHa0bk
         yjfzJKdzKEOfTs9+p1j4yhltH4K/rRyrfq7sLKACi9a4d05XnuA25YJEQlfy2n0iwOlx
         x9bw1DxwfkaarRJNR2thPzbpnu0ue6ycgnqLkaPZiQtyCKzN4Ph9OJAZIV0ddeF+79vn
         w/zQ==
X-Gm-Message-State: APjAAAXZF0VSZ84nvfWvfA7HyiYqVOMQYsXykuVwY8q1w2WPDKRZB5PT
        FSJGyGlh9ZXJw+kWJBEWHoY=
X-Google-Smtp-Source: APXvYqw13ON0QbjT0//NPl78d5Ue0ww/XeakmiiNJdsCoehAW6QhPQsTORUefqiBxJAh8vSoJ1VzKw==
X-Received: by 2002:a37:a656:: with SMTP id p83mr54180844qke.306.1577731773104;
        Mon, 30 Dec 2019 10:49:33 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:500::c8b0])
        by smtp.gmail.com with ESMTPSA id d1sm13990653qto.97.2019.12.30.10.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 10:49:32 -0800 (PST)
Date:   Mon, 30 Dec 2019 13:49:30 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     Dennis Zhou <dennis@kernel.org>, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v6 00/22] btrfs: async discard support
Message-ID: <20191230184930.GA61432@dennisz-mbp.dhcp.thefacebook.com>
References: <cover.1576195673.git.dennis@kernel.org>
 <20191230181318.GC3929@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230181318.GC3929@twin.jikos.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 30, 2019 at 07:13:18PM +0100, David Sterba wrote:
> On Fri, Dec 13, 2019 at 04:22:09PM -0800, Dennis Zhou wrote:
> > Hello,
> > 
> > Dave reported a lockdep issue [1]. I'm a bit surprised as I can't repro
> > it, but it obviously is right. I believe I fixed the issue by moving the
> > fully trimmed check outside of the block_group lock.  I mistakingly
> > thought the btrfs_block_group lock subsumed btrfs_free_space_ctl
> > tree_lock. This clearly isn't the case.
> > 
> > Changes in v6:
> >  - Move the fully trimmed check outside of the block_group lock.
> > 
> > v5 is available here: [2].
> > 
> > This series is on top of btrfs-devel#misc-next 7ee98bb808e2 + [3] and
> > [4].
> > 
> > [1] https://lore.kernel.org/linux-btrfs/20191210140438.GU2734@twin.jikos.cz/
> > [2] https://lore.kernel.org/linux-btrfs/cover.1575919745.git.dennis@kernel.org/
> > [3] https://lore.kernel.org/linux-btrfs/d934383ea528d920a95b6107daad6023b516f0f4.1576109087.git.dennis@kernel.org/
> > [4] https://lore.kernel.org/linux-btrfs/20191209193846.18162-1-dennis@kernel.org/
> > 
> > Dennis Zhou (22):
> >   bitmap: genericize percpu bitmap region iterators
> >   btrfs: rename DISCARD opt to DISCARD_SYNC
> >   btrfs: keep track of which extents have been discarded
> >   btrfs: keep track of cleanliness of the bitmap
> >   btrfs: add the beginning of async discard, discard workqueue
> >   btrfs: handle empty block_group removal
> >   btrfs: discard one region at a time in async discard
> >   btrfs: add removal calls for sysfs debug/
> >   btrfs: make UUID/debug have its own kobject
> >   btrfs: add discard sysfs directory
> >   btrfs: track discardable extents for async discard
> >   btrfs: keep track of discardable_bytes
> >   btrfs: calculate discard delay based on number of extents
> >   btrfs: add bps discard rate limit
> >   btrfs: limit max discard size for async discard
> >   btrfs: make max async discard size tunable
> >   btrfs: have multiple discard lists
> >   btrfs: only keep track of data extents for async discard
> >   btrfs: keep track of discard reuse stats
> >   btrfs: add async discard header
> >   btrfs: increase the metadata allowance for the free_space_cache
> >   btrfs: make smaller extents more likely to go into bitmaps
> 
> Patches 1-12 merged to a temporary misc-next but I haven't pushed it as
> misc-next yet (it's misc-next-with-discard-v6 in my github repo). There
> are some comments to patch 13 and up so please send them either as
> replies or as a shorter series. Thanks.

Great! Thanks for taking another pass at it all. Would you prefer a pull
request or just another series? I'll throw on top a couple patches to
hopefully address the -1 (I'm still not fully sure how it can happen).

Thanks,
Dennis
