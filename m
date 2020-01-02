Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C500212E8E0
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 17:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbgABQqm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 11:46:42 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38937 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbgABQqm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 11:46:42 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so35050606qtm.6
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 08:46:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VjzGPXQrffyiY9H7CG7a7Qf43d+SeYrXGXhY2ewL1kY=;
        b=kXQZfE58xmtnJ90BESFjF59jZDY+YCLxgV5EzEsH8l0SPqF/0D+CsCXN78Yso2x3+k
         2yRGADPgpMo0oLNAAEOBN5L9cd/zqwvh7gvk5FDhwU6xoupqS5Rn3nCSm39Kn+p1SGzf
         /Bmuq8enbHL2CBTsWIt+fb2YdiTxzKV8Dtjoskd5gjgAVpVtO6nxaQQLuRPN2YmGuOr5
         XpQvVvRCdqeAZFJljOgf+vJYtQyE/cHycKZHIssubpA8jlH5yJs/AxB35R1YHHV/lRl6
         jWbZRc/jniO1RMS4/cWVbEk9V+cZWZfS7z2H34BaspNFUCBpFkpKnsTeyTrTlf9zYyTU
         SKDA==
X-Gm-Message-State: APjAAAWMriHfeDTqOxDgOjcccKS/a8rnavBm/is+Pb6klORB+zSgAuuD
        h2wD2M+mnXecpmXi34aIa9A6KQ4p
X-Google-Smtp-Source: APXvYqzm5ORXn/UINsMPng5GRvbqS0Z+CCJ5Suw1d6W/vuZbTmmNf6Cg7gd3hbrYPk8r8yUV69yEcQ==
X-Received: by 2002:aed:2465:: with SMTP id s34mr60316980qtc.158.1577983601640;
        Thu, 02 Jan 2020 08:46:41 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:500::1:29bb])
        by smtp.gmail.com with ESMTPSA id r80sm15278849qke.134.2020.01.02.08.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 08:46:41 -0800 (PST)
Date:   Thu, 2 Jan 2020 11:46:38 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 14/22] btrfs: add bps discard rate limit
Message-ID: <20200102164638.GB86832@dennisz-mbp.dhcp.thefacebook.com>
References: <cover.1576195673.git.dennis@kernel.org>
 <42ac06bc7e0689f5cbd1778770b7177d2562140b.1576195673.git.dennis@kernel.org>
 <20191230175846.GY3929@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230175846.GY3929@twin.jikos.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 30, 2019 at 06:58:47PM +0100, David Sterba wrote:
> On Fri, Dec 13, 2019 at 04:22:23PM -0800, Dennis Zhou wrote:
> > Provide an ability to rate limit based on mbps in addition to the iops
> > delay calculated from number of discardable extents.
> > 
> > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > ---
> >  fs/btrfs/ctree.h   |  2 ++
> >  fs/btrfs/discard.c | 18 ++++++++++++++++++
> >  fs/btrfs/sysfs.c   | 31 +++++++++++++++++++++++++++++++
> >  3 files changed, 51 insertions(+)
> > 
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index 98979566e281..1b2dae5962de 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -467,10 +467,12 @@ struct btrfs_discard_ctl {
> >  	spinlock_t lock;
> >  	struct btrfs_block_group *block_group;
> >  	struct list_head discard_list[BTRFS_NR_DISCARD_LISTS];
> > +	u64 prev_discard;
> >  	atomic_t discardable_extents;
> >  	atomic64_t discardable_bytes;
> >  	u32 delay;
> >  	u32 iops_limit;
> > +	u64 bps_limit;
> 
> I think this could be u32, which makes it 4G per second. Byte
> granularity is IMO not necessary so it could be KiB/sec instead and it
> would be future safe with maximum limit of 4TiB/sec.

Sounds good, done.
