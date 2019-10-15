Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 819B2D79FE
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 17:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfJOPlk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 11:41:40 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35536 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfJOPlk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 11:41:40 -0400
Received: by mail-qt1-f196.google.com with SMTP id m15so31249842qtq.2
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2019 08:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i76+j+xrK/8CbH1fZSq+U92Mtj5xQ3L79TTUTA2fsgg=;
        b=udl5f8ez8pMzi7OxlxHem9eJrjADYoRmiUa+5r5Y+zUmdlwH8YlqkWVpapxYM5XdBo
         CIVDeTztFgEl9L7xAkGfR2tpY7eXsP8TM8CuP+UwkY9cZIvzBiGJAKggq7gZh8SOVsTp
         +ObR1DBW3ZRbxi8L1+9OBSlvz68hc45GdoKfEGQLoI7TrUQo7sWK+GZPt6CaMthhEcu1
         8mc68LgmRwogaE3xuvdAMZCjyuQc08cgYrycG6mJJ2KQzpWUQFQV0aG3exxwcahmw+L9
         tqz/z8EPjg69ruSjhgUaG0JAtOeGyGQiPTGThbH4hTpTpIniKeZqKEwT/jR/5hPyV7D+
         9O8A==
X-Gm-Message-State: APjAAAWwH41LhugTjo4tAsZcTtJ0rcGIL+NbhUr8i81w8WZdfhaN3KQD
        SMvnF4ZBsyfn6g5BjfqZafY=
X-Google-Smtp-Source: APXvYqwjGtnCqd16ObkBmZOWMi0uWdmmqK+eie3Almy1UGqXrfWn49PHJRXxTO3yF/ebXgeMob9CzA==
X-Received: by 2002:ac8:73cf:: with SMTP id v15mr37954217qtp.310.1571154097380;
        Tue, 15 Oct 2019 08:41:37 -0700 (PDT)
Received: from dennisz-mbp ([2620:10d:c091:500::c97c])
        by smtp.gmail.com with ESMTPSA id n44sm14451147qtf.51.2019.10.15.08.41.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 08:41:36 -0700 (PDT)
Date:   Tue, 15 Oct 2019 11:41:33 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     Dennis Zhou <dennis@kernel.org>, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [RFC PATCH 00/19] btrfs: async discard support
Message-ID: <20191015154133.GA66037@dennisz-mbp>
References: <cover.1570479299.git.dennis@kernel.org>
 <20191015120831.GS2751@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015120831.GS2751@twin.jikos.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 15, 2019 at 02:08:31PM +0200, David Sterba wrote:
> Hi,
> 
> thanks for working on this. The plain -odiscard hasn't been recommended
> to users for a long time, even with the SATA 3.1 drives that allow
> queueing the requests.
> 
> The overall approach to async discard sounds good, the hard part is not
> shoot down the filesystem by trimming live data, and we had a bug like
> that in the pastlive data, and we had a bug like that in the past. For
> correctness reasons I understand the size of the patchset.
> 
> On Mon, Oct 07, 2019 at 04:17:31PM -0400, Dennis Zhou wrote:
> > I am currently working on tuning the rate at which it discards in the
> > background. I am doing this by evaluating other workloads and drives.
> > The iops and bps rate limits are fairly aggressive right now as my
> > basic survey of a few drives noted that the trim command itself is a
> > significant part of the overhead. So optimizing for larger trims is the
> > right thing to do.
> 
> We need a sane default behaviour, without the need for knobs and
> configuration, so it's great you can have a wide range of samples to
> tune it.
> 

Yeah I'm just not quite sure what that is yet. The tricky part is that
we don't really get burned by trims until well after we've issued the
trims. The feedback loop is not really transparent with reads and
writes.

> As trim is only a hint, a short delay in processing the requests or
> slight ineffectivity should be acceptable, to avoid complications in the
> code or interfering with other IO.
> 
> > Persistence isn't supported, so when we mount a filesystem, the block
> > groups are read in as dirty and background trim begins. This makes async
> > discard more useful for longer running mount points.
> 
> I think this is acceptable.
> 
> Regarding the code, I leave comments to the block group and trim
> structures to Josef and will focus more on the low-level and coding
> style or changelogs.

Sounds good. I'll hopefully post a v2 shortly so that we can get more of
that out of the way. Then hopefully a smaller incremental later to
figure out the configuration part.

Thanks,
Dennis
