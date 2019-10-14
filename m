Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56ADBD6B08
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2019 23:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732126AbfJNVFh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Oct 2019 17:05:37 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33905 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfJNVFg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Oct 2019 17:05:36 -0400
Received: by mail-qt1-f195.google.com with SMTP id 3so27464191qta.1
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2019 14:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TSgdH0WkJgR0nEmbq5XtgxsUFLmTtoYLDrT26dZeYIs=;
        b=fFjcDmVNzQU9F35+3P/8UrJVqRKhBBHByMmY5lqu2PqNKcPV1hvFTm/0wL8suZR85S
         3AjJ/8qQdRNDkT6fNs0bskXy015dDRwhBVpE3D8XRo6PhcAbOUS8rJ+ff8hZIRDLJ3z4
         pDqBOBqTXVbYlfmQ1hxYzc1e+NoTsCErr6w4KXxOSUbHTj8qphMOnLXlI/qaGp3E1raw
         IMl32Gnygb2tZji4YVeaXPFFes1nVxFXkHTcDV3qZXUxpVN1WYXS0FzXrIzo5i3osyfP
         gWD/12H1llZohMAvrfkQhNGNx5miWE2mnKd01o7JoUy9JBtDNdfxd4Lce91oC3P95xhq
         XTgw==
X-Gm-Message-State: APjAAAX4/NihySjLpA6+EEOwWbgGTqFKJ0vjzHUspsfzLrpPQ6coJn14
        fTW4++RW+KV4gq3PPvKfZuU=
X-Google-Smtp-Source: APXvYqxUxzsZluhrOJ9Oed7Xw3HoppqliOgXQUQyJhWyZEz6dOL/1AvksafnSe2ainPyd/APsV68kg==
X-Received: by 2002:a05:6214:304:: with SMTP id i4mr15732278qvu.147.1571087135940;
        Mon, 14 Oct 2019 14:05:35 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:500::2:b1f8])
        by smtp.gmail.com with ESMTPSA id j2sm8405251qki.15.2019.10.14.14.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2019 14:05:35 -0700 (PDT)
Date:   Mon, 14 Oct 2019 17:05:33 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Chris Mason <clm@fb.com>, Omar Sandoval <osandov@osandov.com>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [RFC PATCH 00/19] btrfs: async discard support
Message-ID: <20191014210533.GG40077@dennisz-mbp.dhcp.thefacebook.com>
References: <cover.1570479299.git.dennis@kernel.org>
 <a382d536-e836-dba5-a030-41504a2bd827@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a382d536-e836-dba5-a030-41504a2bd827@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 11, 2019 at 10:49:20AM +0300, Nikolay Borisov wrote:
> 
> 
> On 7.10.19 г. 23:17 ч., Dennis Zhou wrote:
> > Hello,
> > 
> 
> <snip>
> 
> > 
> > With async discard, we try to emphasize discarding larger regions
> > and reusing the lba (implicit discard). The first is done by using the
> > free space cache to maintain discard state and thus allows us to get
> > coalescing for fairly cheap. A background workqueue is used to scan over
> > an LRU kept list of the block groups. It then uses filters to determine
> > what to discard next hence giving priority to larger discards. While
> > reusing an lba isn't explicitly attempted, it happens implicitly via
> > find_free_extent() which if it happens to find a dirty extent, will
> > grant us reuse of the lba. Additionally, async discarding skips metadata
> 
> By 'dirty' I assume you mean not-discarded-yet-but-free extent?
> 

Yes.

> > block groups as these should see a fairly high turnover as btrfs is a
> > self-packing filesystem being stingy with allocating new block groups
> > until necessary.
> > 
> > Preliminary results seem promising as when a lot of freeing is going on,
> > the discarding is delayed allowing for reuse which translates to less
> > discarding (in addition to the slower discarding). This has shown a
> > reduction in p90 and p99 read latencies on a test on our webservers.
> > 
> > I am currently working on tuning the rate at which it discards in the
> > background. I am doing this by evaluating other workloads and drives.
> > The iops and bps rate limits are fairly aggressive right now as my
> > basic survey of a few drives noted that the trim command itself is a
> > significant part of the overhead. So optimizing for larger trims is the
> > right thing to do.
> 
> Do you intend on sharing performance results alongside the workloads
> used to obtain them? Since this is a performance improvement patch in
> its core that is of prime importance!
> 

I'll try and find some stuff to share for v2. As I'm just running this
on production machines, I don't intend to share any workloads. However,
there is an iocost workload that demonstrates the problem nicely that
might already be shared.

The win really is moving the work from transaction commit to completely
background work, effectively making discard a 2nd class citizen. On more
loaded machines, it's not great that discards are blocking transaction
commit. The other thing is it's very drive dependent. Some drives just
have really bad discard implementations and there will be a bigger win
than say on some high end nvme drive.

> > 
> 
> <snip>
> > 
> > Thanks,
> > Dennis
> > 
