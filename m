Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCDC12E8F9
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 17:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgABQ4D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 11:56:03 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41642 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728847AbgABQ4D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 11:56:03 -0500
Received: by mail-qk1-f193.google.com with SMTP id x129so31794526qke.8
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 08:56:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PrvoBtggfGOPi9SZuOm97CHt2qEDAHFKK7swGJ2xMiw=;
        b=dRfLRR3v0zxIC06gqWIm3UyQO9PNVeyp4hhim8sSjlqNtlzqMLY6TSSH2PBhMVPyth
         jN+oqpaes5UhIFdyARTHt7x3cMtFnKb/upT+KIK9e9pcjWaaEdWlLIR/mssEkXOQGL/J
         0o2SeB7RB5GB5RjapYSXDWbzx3qs9jnvutBkQ8s2mt2tk0wNXgslo4mX3de3OQNk/sNJ
         vkBUL76scn/CCZnNFx+BF4JMhej9QR97Nb5dzNGpuvgfVKDK552s6AGE+K+3EzF6gbqy
         q8x7CZ3P4zAcGAWu4pMqmpEC0gertFAt+35+MFg6MAQ/zsZi1ADVJ7b3unnlAkRM6hBq
         6M/Q==
X-Gm-Message-State: APjAAAUZCFZa69zMDWX0fJ0Mhd7g4iU2wzRBX8Au96ilEZQcOxfjl5F6
        dLfSFWyqgE0IvnYFp40yrLk=
X-Google-Smtp-Source: APXvYqwdQvv+Wnofel0RyRGrDQjifS2z4du6vgNNst3joM5jHCgtEjzBBs+eRUav5zKEUclAWds3Yw==
X-Received: by 2002:a05:620a:14bc:: with SMTP id x28mr66622775qkj.494.1577984161952;
        Thu, 02 Jan 2020 08:56:01 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:500::1:29bb])
        by smtp.gmail.com with ESMTPSA id t42sm17410720qtt.84.2020.01.02.08.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 08:56:01 -0800 (PST)
Date:   Thu, 2 Jan 2020 11:55:59 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 18/22] btrfs: only keep track of data extents for async
 discard
Message-ID: <20200102165559.GE86832@dennisz-mbp.dhcp.thefacebook.com>
References: <cover.1576195673.git.dennis@kernel.org>
 <7dbf1733c917f37122c630d392622d70021cdbdb.1576195673.git.dennis@kernel.org>
 <20191230173954.GX3929@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230173954.GX3929@twin.jikos.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 30, 2019 at 06:39:54PM +0100, David Sterba wrote:
> On Fri, Dec 13, 2019 at 04:22:27PM -0800, Dennis Zhou wrote:
> > As mentioned earlier, discarding data can be done either by issuing an
> > explicit discard or implicitly by reusing the LBA. Metadata chunks see
> > much more frequent reuse due to well it being metadata. So instead of
> > explicitly discarding metadata blocks, just leave them be and let the
> > latter implicit discarding be done for them.
> > 
> > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/block-group.h |  6 ++++++
> >  fs/btrfs/discard.c     | 11 +++++++++--
> >  2 files changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> > index 601e1d217e22..ee8441439a56 100644
> > --- a/fs/btrfs/block-group.h
> > +++ b/fs/btrfs/block-group.h
> > @@ -182,6 +182,12 @@ static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
> >  	return (block_group->start + block_group->length);
> >  }
> >  
> > +static inline bool btrfs_is_block_group_data(
> > +					struct btrfs_block_group *block_group)
> > +{
> > +	return (block_group->flags & BTRFS_BLOCK_GROUP_DATA);
> 
> What happens for mixed data and metadata block groups? As this is a
> special mode that will likely lead to fragmented block groups I think
> that async discard won't be able to help much.
> 
> I'd suggest to make the test explicit only for the separate block group
> types and comment that mixed bg's are not supported.

Yeah it probably wouldn't do the system much good. I've renamed the test
to btrfs_is_block_group_data_only() and added a comment in the async
discard header patch to state that mixed block_groups aren't supported.
