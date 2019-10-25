Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D98E0E4AC2
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2019 14:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502539AbfJYMIr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Oct 2019 08:08:47 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34220 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfJYMIr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Oct 2019 08:08:47 -0400
Received: by mail-qk1-f194.google.com with SMTP id f18so1498642qkm.1
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2019 05:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iNQ39le2WIeFaK6SS3LI73USPXP14jbwuiAN8J2wDlU=;
        b=OqB4TLnUI87TUmPLU/EAcdOLIdl96Hc5HHOvGJpaPANsdMqnYeySvrIrqFUpQVPISk
         Pi+5ZuGGxJNsrvooRVqD0+aPkc3R1brrqZ0273zbqnHYqclk7JcLW0M577iQ0OEs3gHg
         Z3B8T3o0fvt8iWKDLdXfL+1D7GlU2DumWt1L3pHn4xkcOEMtHCe80kVyE2Wd6FefLZ6f
         VOa0LKTWOVODLbCGL6/yHc0PC3yupsI6IEU3FuNgBalG2NE6jGxUE1DYQl5p9ixTHf89
         dN652uO/c0ZkvpqGrmWVkq7zoGQHElX+XoqtU0OqMPK6uzFB4XnEs9NAZp8wYGXsfjE8
         W/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iNQ39le2WIeFaK6SS3LI73USPXP14jbwuiAN8J2wDlU=;
        b=RIAVUjsBOHG5frJgqgWH86+4i9JtW1e49YnSlXhYDLbqVTcLIFFYR0/1Xk6PN/G5Er
         VBZZVSt8jIbcNky57ZDUXL4sTdiNwHNrgy4Nrc58RaT+z96zqHoDGxy8Ap1A3K4wq1rw
         TJkTPoTMc9/62nRG0X7kfuSM3cV9gsub6WKenlHf+bbg+w+dRmOE8DrAi1ZgrTgDMRbJ
         ODr7bbd/CPvbmmGD2klSF9n8vyn81mB5Gr7KbqrPTSviwnOLFR6qPu2yy+EhMxY+eMJK
         IH9LnBFPJox+2TG36mXUXPekqSkOJKCkVoJ0RulAgeZsY68wzWJTQJNnSi9q5PbcfJAt
         6M+g==
X-Gm-Message-State: APjAAAUK9wUJLtPbPWRVYqeqfOeI4uHx3fJfeGzfM//z8CEwZMxYvBqA
        Mh87ELMoOmLpMo5PUAVd6XuDTw==
X-Google-Smtp-Source: APXvYqydlkNl/4dq9U3ZpuHa2PRRvpPkawZA8Pe/8XeFgY6w5+/hQ7hcM26Om3MZIXAIN/siMDlBxQ==
X-Received: by 2002:a05:620a:2158:: with SMTP id m24mr2620834qkm.350.1572005326344;
        Fri, 25 Oct 2019 05:08:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::fad0])
        by smtp.gmail.com with ESMTPSA id w6sm1142494qki.49.2019.10.25.05.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 05:08:45 -0700 (PDT)
Date:   Fri, 25 Oct 2019 08:08:44 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: remove unnecessary delalloc mutex for inodes
Message-ID: <20191025120843.ujydwo3w3twmdl3o@MacBook-Pro-91.local>
References: <20191025095242.15996-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025095242.15996-1-fdmanana@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 25, 2019 at 10:52:42AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The inode delalloc mutex was added a long time ago by commit f248679e86fea
> ("Btrfs: add a delalloc mutex to inodes for delalloc reservations"), and
> the reason for its introduction is not very clear from the change log. It
> claims it solves bogus warnings from lockdep, however it lacks an example
> report/warning from lockdep, or any explanation.
> 
> Since we have enough concurrentcy protection from the locks of the space
> info and block reserve objects, and such lockdep warnings don't seem to
> exist anymore (at least on a 5.3 kernel I couldn't get them with fstests,
> ltp, fs_mark, etc), remove it, simplifying things a bit and decreasing
> the size of the btrfs_inode structure. With some quick fio tests doing
> direct IO and mmap writes I couldn't observe any significant performance
> increase either (direct IO writes that don't increase the file's size
> don't hold the inode's lock for their entire duration and mmap writes
> don't hold the inode's lock at all), which are the only type of writes
> that could see any performance gain due to less serialization.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

The problem was taking the i_mutex in mmap, which is how I was protecting
delalloc reservations originally.  The delalloc mutex didn't come with all of
the other dependencies.  That's what the lockdep messages were about, removing
the lock isn't going to make them appear again.

We _had_ to lock around this because we used to do tricks to keep from
over-reserving, and if we didn't serialize delalloc reservations we'd end up
with ugly accounting problems when we tried to clean things up.

However with my recentish changes this isn't the case anymore.  Every operation
is responsible for reserving its space, and then adding it to the inode.  Then
cleaning up is straightforward and can't be mucked up by other users.  So we no
longer need the delalloc mutex to safe us from ourselves.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
