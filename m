Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42225D6AAC
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2019 22:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732399AbfJNURu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Oct 2019 16:17:50 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46818 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729864AbfJNURu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Oct 2019 16:17:50 -0400
Received: by mail-qt1-f196.google.com with SMTP id u22so27178644qtq.13
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2019 13:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AFat7maPoeonpW29jRkqOmoMVg2arR3Dt4SaEQ4UCsY=;
        b=YhjHNkR70xpI1wr14pzhB2rBoMWpT0B4owtLVEEVaraEQfTzLbKJrE2IgNRKYjx8mp
         pz0momv6tASArjIurUgu2nb3gSOner+2jDYoIc9gIJSXF+ayRaPKiU3gj8dqjjbbh50X
         dosmeWgG970l7c2fmESHhBNjhtCK+kgdyiIdp7axrgerNb1uWufEoAY6ENT+u4cyvJFJ
         jDDLt2Udc05p5T5Hj2mY/jsxhvDutCf+rs8UFmntbPjF5EtwvtF5yp/bp5WWovUQXTz8
         rs8aqwJb+wCVKMJm6zZ7ulYE0l5uM3qkCsmdCWY76UXY3+M8ke3V4tQStQ1GoAZgUchH
         rSJA==
X-Gm-Message-State: APjAAAU7EGxt7aL+qXiejd19Z20968uCj+7/Cmus9XF2zfh8jcXUXQhl
        Tk8AbYeNItqseJDTDAVeZZOltFDf
X-Google-Smtp-Source: APXvYqwemO5Wy9lB3qwn9dOHe08Pq+XoDKAk4IKW7HQ0IknukD07kvKSu4NWMGW6sUE0prHDRT7BcA==
X-Received: by 2002:a0c:f8c1:: with SMTP id h1mr33526048qvo.194.1571084269444;
        Mon, 14 Oct 2019 13:17:49 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:500::2:b1f8])
        by smtp.gmail.com with ESMTPSA id e13sm8060896qkm.110.2019.10.14.13.17.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2019 13:17:48 -0700 (PDT)
Date:   Mon, 14 Oct 2019 16:17:46 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 15/19] btrfs: load block_groups into discard_list on mount
Message-ID: <20191014201746.GF40077@dennisz-mbp.dhcp.thefacebook.com>
References: <cover.1570479299.git.dennis@kernel.org>
 <31ce602fac88f25567a0b3e89037693ec962c1c7.1570479299.git.dennis@kernel.org>
 <20191010171137.xxuhjvmqzgifuixd@macbook-pro-91.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010171137.xxuhjvmqzgifuixd@macbook-pro-91.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 10, 2019 at 01:11:38PM -0400, Josef Bacik wrote:
> On Mon, Oct 07, 2019 at 04:17:46PM -0400, Dennis Zhou wrote:
> > Async discard doesn't remember the discard state of a block_group when
> > unmounting or when we crash. So, any block_group that is not fully used
> > may have undiscarded regions. However, free space caches are read in on
> > demand. Let the discard worker read in the free space cache so we can
> > proceed with discarding rather than wait for the block_group to be used.
> > This prevents us from indefinitely deferring discards until that
> > particular block_group is reused.
> > 
> > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> 
> What if we did completely discard the last time, now we're going back and
> discarding again?  I think by default we just assume we discarded everything.
> If we didn't then the user can always initiate a fitrim later.  Drop this one.
> Thanks,
> 

Yeah this is something I wasn't sure about.

It makes me a little uncomfortable to make the lack of persistence a
user problem. If in some extreme case where someone frees a large amount
of space and then unmounts. We can either make them wait on unmount to
discard everything or retrim the whole drive which in an ideal world
should just be a noop on already free lba space. If others are in favor
of just going the fitrim route for users, I'm happy to drop this patch,
but I do like the fact that this makes the whole system consistent
without user intervention. Does anyone else have an opinion?

On a side note, the find_free_extent() allocator tries pretty hard
before allocating subsequent block groups. So maybe it's right to just
deprioritize these block groups instead of just not loading them.

Thanks, 
Dennis
