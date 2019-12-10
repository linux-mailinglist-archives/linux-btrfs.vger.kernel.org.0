Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93954118FBA
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2019 19:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfLJSYd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 13:24:33 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40194 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbfLJSYd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 13:24:33 -0500
Received: by mail-pj1-f67.google.com with SMTP id s35so7713633pjb.7
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2019 10:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yCeac0CNfp1GFgKqY9ENG4DzKcRDASsuwKQ52V+q5HY=;
        b=YdEXGXnzDZLgdZf6Qxe+DAVC9/jbnvZqAtbj1zC3Xr71vxuNMPHfErwdbHwqyygwWR
         yUY2jEy2bJaOKtj70hozIvC4kVOFwDw6CnLsr1c9nuyAzQiA7Jucx8ZksSryX8G5WnHz
         7jAHF670sJ1ZBVNYDvwWYhSepK7MJ5nv/ocPSC3Sguw9UfyN+vjTrj0Dm5SpYMgbs5YT
         uvu7LlD5UuP6p94Onmc3j0ieaStls4dBhzGoO7ysNeHjKUyRw7P2Gub8RNWa1gfqvWVj
         +beLJuF1oF9uG/XsgeDLzFgK1thaR3LqACx+swZ4XbO+AWWOau85FBEC9BSjk/0Slfwu
         j6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yCeac0CNfp1GFgKqY9ENG4DzKcRDASsuwKQ52V+q5HY=;
        b=Y+J3cNjgUhcz6fx8VX/myQ2z7e+tIuTYHaLr8rU/5e5xCjRJBVB+plRWKxMybDxF64
         kFGbX1EaAxg2Z3MqzbK6PeqLBlXRe19HWliopHBnpDBcVDf5OB5mkRaZTqdveho/DryK
         /orEHvoWZ+owl7WocZTUXt3SzSvObkoQP5n5/k6vnFv27pzEGD/e2IyyyKOj+N0rppDo
         Gusci8Jy4OgvVEetulY8w78oRc9/3gag95NS4r26E8NSSC+cY/8J5spH61d6jDyTvVFT
         4jALw5FQ8+9MG6tzrLoBpHocL/U6reVh5iz5ADJCbPBga6h3XRBC35kePJSWqPDbL4Bo
         o4Bw==
X-Gm-Message-State: APjAAAWvd4Yd4JTnmq1764rcP7G8/vQ7TvXliqjISSx+aU7JCYNzhEEO
        BdwKD/E0Ry/K+zuA+e2/GepoDA==
X-Google-Smtp-Source: APXvYqyHD1Qqs3k1fIMF24CXFyaqc2PwZnbHs9tatv27oURLZH0Dd1UHSgyvMQf6xtib67vvrW4kBA==
X-Received: by 2002:a17:902:694a:: with SMTP id k10mr37081078plt.304.1576002271946;
        Tue, 10 Dec 2019 10:24:31 -0800 (PST)
Received: from vader ([2620:10d:c090:200::1:c519])
        by smtp.gmail.com with ESMTPSA id m27sm4390186pff.179.2019.12.10.10.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 10:24:31 -0800 (PST)
Date:   Tue, 10 Dec 2019 10:24:30 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 1/9] btrfs: get rid of trivial __btrfs_lookup_bio_sums()
 wrappers
Message-ID: <20191210182430.GA204474@vader>
References: <cover.1575336815.git.osandov@fb.com>
 <af5aefd84186419ead73107895ddd6aba02ef8b6.1575336815.git.osandov@fb.com>
 <20191210171210.GC3929@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210171210.GC3929@twin.jikos.cz>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 10, 2019 at 06:12:10PM +0100, David Sterba wrote:
> On Mon, Dec 02, 2019 at 05:34:17PM -0800, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > Currently, we have two wrappers for __btrfs_lookup_bio_sums():
> > btrfs_lookup_bio_sums_dio(), which is used for direct I/O, and
> > btrfs_lookup_bio_sums(), which is used everywhere else. The only
> > difference is that the _dio variant looks up csums starting at the given
> > offset instead of using the page index, which isn't actually direct
> > I/O-specific. Let's clean up the signature and return value of
> > __btrfs_lookup_bio_sums(), rename it to btrfs_lookup_bio_sums(), and get
> > rid of the trivial helpers.
> > 
> >  				ret = btrfs_lookup_bio_sums(inode, comp_bio,
> > -							    sums);
> > +							    false, 0, sums);
> 
> > -		ret = btrfs_lookup_bio_sums(inode, comp_bio, sums);
> > +		ret = btrfs_lookup_bio_sums(inode, comp_bio, false, 0, sums);
> 
> > -			ret = btrfs_lookup_bio_sums(inode, bio, NULL);
> > +			ret = btrfs_lookup_bio_sums(inode, bio, false, 0, NULL);
> 
> > -		ret = btrfs_lookup_bio_sums_dio(inode, dip->orig_bio,
> > -						file_offset);
> > +		ret = btrfs_lookup_bio_sums(inode, dip->orig_bio, true,
> > +					    file_offset, NULL);
> 
> Can't we also get rid of the at_offset parameter? Encoding that into
> file_offset itself where at_offset=true would be some special
> placeholder like (u64)-1 that can never be a valid file offset.

Yeah Nikolay mentioned this as well but I was on the fence about whether
it would look any nicer. I'll go ahead and make that change.
