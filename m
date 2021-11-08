Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2903A449C4B
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 20:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbhKHTW0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 14:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236986AbhKHTWZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 14:22:25 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C87C061570
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Nov 2021 11:19:41 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id h14so14754334qtb.3
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Nov 2021 11:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5V7jwoT3lf1HRo7Oz/Q+7shnqeiPNIiox0NrCrbsNTc=;
        b=4A1s4WGQ/0NMloDU3WOMVAobYysiYNW1ysU6Rkuy4aFIlH7P+WOrQdqR5Ad2GPw3L+
         ROq2OoeKjlWn9E9cEjzbDilyaP7t93JVAm0HTNX0T5B2owtDxglbbQbUQhHiN1RdGh14
         qlnlqh2iXPaIFjxBtlFMRYzN/BKtARKDVajdBv3p2BLRGupBj9ILdaIE9nTCasbCWm30
         C6N3bjUVWYPkxeH8tuspDWnTDQR86EOFZAkM2Hro4dqj5lNyTOmAo+s8o3SHPScXZ96G
         W+EA9H67+GRDrNcTISHuoJH6Vhx1uW02Wy5OhCYaEXNemCUF2vxgXLz8k+pp8SNNx/6u
         dKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5V7jwoT3lf1HRo7Oz/Q+7shnqeiPNIiox0NrCrbsNTc=;
        b=FQnLqxRJBJezcBadBmhHkafA5nl8QoU1Cuk60Bw9tDD9qkuwBLqFxPKXNC4tEjGBYn
         p/hD2Fagf6hzboaIxEqiURdnL4XYop25v5FbEk373gUP/QVko+4zWQ6G4RNPbe1HLVTu
         II5SQSs9pzdXcGq//7pwBaRaL7q87Us/BvCWWT5qmuBzh+zD5vQbf3JISbpLkdNcrKJg
         QGXgQT8CXqBMBzo8q0FdyiDfbsmJCFhWHkWAxZhmtbW/TZHgfNDY22iV6Yjhq6O6jUt7
         4KVBEVRhbeGuoZlXZII/UZASXUridYypF9SypM9pJzZs6fYxHyn+85MKaHtK9HvR5777
         e4dQ==
X-Gm-Message-State: AOAM532OpdK0/KTUXI2HQwG4aPPULafF/LVZTF2RMKM0ERXo459ukfm5
        tiFjQVjTSPnmTAy5/OrVDZILaA==
X-Google-Smtp-Source: ABdhPJxScu1UImlNlH0osIkYqtkJgosF6Q8t02YBQ2h6JRkXbHS3vVgPu+cvlBddY7Vke7nq0Ra94w==
X-Received: by 2002:a05:622a:c2:: with SMTP id p2mr2102029qtw.258.1636399179992;
        Mon, 08 Nov 2021 11:19:39 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e15sm10882338qtp.94.2021.11.08.11.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 11:19:39 -0800 (PST)
Date:   Mon, 8 Nov 2021 14:19:38 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 07/20] btrfs-progs: stop accessing ->csum_root directly
Message-ID: <YYl4SrAlHE44Os7h@localhost.localdomain>
References: <cover.1636143924.git.josef@toxicpanda.com>
 <9785c0745f91699cb45ab398d6a32b44645ace39.1636143924.git.josef@toxicpanda.com>
 <8a4a9842-fbc4-f652-d4ca-842ff63b571f@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a4a9842-fbc4-f652-d4ca-842ff63b571f@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Nov 06, 2021 at 08:23:46AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/11/6 04:28, Josef Bacik wrote:
> > With extent tree v2 we will have per-block group checksums,
> 
> I guess you mean per block group checksum tree?
> 
> > so add a
> > helper to access the csum root and rename the fs_info csum_root to
> > _csum_root to catch all the places that are accessing it directly.
> > Convert everybody to use the helper except for internal things.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> Currently a lot of locations are still passing 0 to btrfs_csum_root(),
> which would need to be converted later.
> 
> Thus it doesn't look correct to be in the preparation patchset.
> 
> Mind to move this patch into the real extent-tree-v2 patchset?
> 

I explained this in another reply, but I wanted to talk about this specific
style of request here as well.

I did it this way because it's changing a lot of callsites to use a helper.
This is kind of a complex change as a whole, because I'm taking us from having a
fs_info->extent_root to having a rb tree with the extent root, csum root, and
free space tree root.

Once I get to the actual extent tree v2 stuff there's going to be a whole host
of more complicated changes.

So, in order to make it easier to review, I've put this relatively large concept
in the prep patches.  It's easier to look at because its a clear
s/->whatever_root/btrfs_whatever_root/ change.  It's easy to spot check and wrap
your head around.

Then I do the work to actually load it into the rb-tree, and then change the
helpers to access the rb-tree.  Those two changes are contained and easy to wrap
your head around.

Then in the extent-tree-v2 series I actually change the helpers to do the new
crazy stuff, and then go through the places where we do
btrfs_whatever_root(fs_info, 0) and convert those to be compatible with the new
world order.  I do that because each of those spots is it's own deal to convert,
so they need to be reasoned within their context.

I could probably move this around, but we're at like 20 patches per groups of
series, so I did it this way to keep the logical separation as clean as
possible, and drastically reduce the amount of complex things you guys are
needing to look at individually.  Thanks,

Josef
