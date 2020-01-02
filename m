Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6C2B12E901
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 17:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgABQ5h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 11:57:37 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:33780 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728847AbgABQ5g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 11:57:36 -0500
Received: by mail-qv1-f68.google.com with SMTP id z3so15239427qvn.0
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 08:57:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oE57YWQpxhB8KxbcsvfbeP4c6czknQZnNzFlx1WhT2A=;
        b=GZ6isAiq18Dwmfa5Srqx84RRnWa+oau8rduQ1HBU88dIavlk4hDPojlB0nn4k4gw3o
         R58qopyt/kHkQ82ULzk9Dcwos0sGjKtKdsa/f0H7LuXrhYQ86putAJoz9QN199G0mtPH
         Xup0458Gx2IaBv7s2S7zTQqJDV4FU9pw2HWou+Q/1fa5P8zantW8NC5wCAVuj1MwdG/i
         3JzZt6bAlFPx1WxGVvboXzBPdiiooGMhlTUxcOYa4zd082OUViXkcZInW431ClG3xa8V
         BlJyUhCAypHYp5xQU6gr+TI9cTegYQpFg9VJjFzR+Gkj1LnKp1BOorgSTOOpwjSq7nkz
         KKnw==
X-Gm-Message-State: APjAAAVdopZG+Q/d1KyQvfd0IuYtxjeIKESsn5Xml1ZeTCs+TpbdlqCu
        c7tyRSONoO7z0xrepsynPrs=
X-Google-Smtp-Source: APXvYqzU73Hp3SjlnpdUWofWxyEXDESM/nkY/6OAdKM/AHleE+pqsK+pEZmfEO+kZpvKNv8iulGlOg==
X-Received: by 2002:a05:6214:1907:: with SMTP id er7mr64002382qvb.199.1577984255647;
        Thu, 02 Jan 2020 08:57:35 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:500::1:29bb])
        by smtp.gmail.com with ESMTPSA id t2sm16982119qtn.22.2020.01.02.08.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 08:57:34 -0800 (PST)
Date:   Thu, 2 Jan 2020 11:57:31 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 19/22] btrfs: keep track of discard reuse stats
Message-ID: <20200102165731.GF86832@dennisz-mbp.dhcp.thefacebook.com>
References: <cover.1576195673.git.dennis@kernel.org>
 <f5283c2dd8d15699456846bc89e9ee77cc56b049.1576195673.git.dennis@kernel.org>
 <20191230173352.GW3929@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230173352.GW3929@twin.jikos.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 30, 2019 at 06:33:52PM +0100, David Sterba wrote:
> On Fri, Dec 13, 2019 at 04:22:28PM -0800, Dennis Zhou wrote:
> > Keep track of how much we are discarding and how often we are reusing
> > with async discard.
> > 
> > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/ctree.h            |  3 +++
> >  fs/btrfs/discard.c          |  7 +++++++
> >  fs/btrfs/free-space-cache.c | 14 ++++++++++++++
> >  fs/btrfs/sysfs.c            | 36 ++++++++++++++++++++++++++++++++++++
> >  4 files changed, 60 insertions(+)
> > 
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index dddf51e27bed..edfbe6060e8d 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -474,6 +474,9 @@ struct btrfs_discard_ctl {
> >  	u32 delay;
> >  	u32 iops_limit;
> >  	u64 bps_limit;
> > +	u64 discard_extent_bytes;
> > +	u64 discard_bitmap_bytes;
> > +	atomic64_t discard_bytes_saved;
> >  };
> >  
> >  /* delayed seq elem */
> > diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> > index 55ad357e65f3..fe73814526ef 100644
> > --- a/fs/btrfs/discard.c
> > +++ b/fs/btrfs/discard.c
> > @@ -419,11 +419,15 @@ static void btrfs_discard_workfn(struct work_struct *work)
> >  				       block_group->discard_cursor,
> >  				       btrfs_block_group_end(block_group),
> >  				       minlen, maxlen, true);
> > +		WRITE_ONCE(discard_ctl->discard_bitmap_bytes,
> > +			   discard_ctl->discard_bitmap_bytes + trimmed);
> 
> The same argument is used for read and write, this does not seem to be a
> clear usage pattern for WRITE_ONCE, is there are cleaner way to do that?
> 

Yeah that doesn't really make any sense. I think we are okay here anyway
as btrfs_discard_workfn() provides synchronization by being a single
work item. So, I've removed the WRITE_ONCE.

> >  	} else {
> >  		btrfs_trim_block_group_extents(block_group, &trimmed,
> >  				       block_group->discard_cursor,
> >  				       btrfs_block_group_end(block_group),
> >  				       minlen, true);
> > +		WRITE_ONCE(discard_ctl->discard_extent_bytes,
> > +			   discard_ctl->discard_extent_bytes + trimmed);
