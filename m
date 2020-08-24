Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8662506EF
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 19:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgHXRxA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 13:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgHXRw6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 13:52:58 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8590CC061573
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 10:52:57 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g1so1115920pgm.9
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 10:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ExK6h875XRkPE90KxNaGMmtXIM7ebA5ZK9qq6tdNI7E=;
        b=W43gIjy2iVlSFE6s/rsvlXc+XkxM1ufu/lrnaTka+pmKF/VDGR18Q8r5pgolvAqzgu
         x+x6SOfoKwGphXpxAJxzcv19qXP0smiLO3ccT74HMxduC33/P6lKHdBupUeO43RDoPip
         7kTwv6SL9rffuOVvgbcv9PIW93tfyBnUrjQOPChDekONI8f8DHeQLTGIXK/23FWgksay
         UTY3fqulv+PcEhniR/VyB1UYVNr+0igiFDW2fHoq+2Z1U42pyB1+fgwH2WAw5eNNCLKy
         u6uUJo3NjUpEj6vcMEy1qzhJp/RM+8p0xxHQA4jTKMFwDHiExHlTVeuH+La3mjFypAdn
         x4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ExK6h875XRkPE90KxNaGMmtXIM7ebA5ZK9qq6tdNI7E=;
        b=eiVVqEkgXCxcgyzQkknazgjhE/U42L+6XCI3tUbqHTdy62eOfrhS31XjRsmWA2g35+
         smUbXKr3qzGI3TbOJrAwkXTqubrQQymkGbySJAMxQyfMLgohcsFzVUZ8fhrI1zwGPpi8
         qHcX7XC0F4HJoyFSYPUeUkG3uqfZY1EuN4xkwwmYy0radVA5mOBTBNUnMFKYjyxeaqaw
         crSz/u5QlRV/CguVHzEeZ84j1PJS/G6feKgsInlFDhZzK/m0xrB32kugGV4JpLcy4oO8
         WM97Y4l+TZf7ZHGmRnTKblthhVfB0vm0locUry7l/UaHxoZ4YzsdeBN/Qn53Ow79fAVP
         yfJQ==
X-Gm-Message-State: AOAM53162le9HW7f5MoRunjGVTaL7P8miPn9NoGGGXfZaEJHqr3RbVK7
        mnFcrkbvBTBtcnJnpB3bZEzWoQ==
X-Google-Smtp-Source: ABdhPJwEbYlmxku/QCzk4/iWMYilwIp2WWbTZoLYX6nMUnKNWofS8oumMhTEsNGRcLUDwbzKjn/E6Q==
X-Received: by 2002:a62:7d0b:: with SMTP id y11mr4638199pfc.262.1598291575550;
        Mon, 24 Aug 2020 10:52:55 -0700 (PDT)
Received: from exodia.localdomain ([2601:602:8b80:8e0::c6ee])
        by smtp.gmail.com with ESMTPSA id y4sm12485207pff.44.2020.08.24.10.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 10:52:54 -0700 (PDT)
Date:   Mon, 24 Aug 2020 10:52:53 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 8/9] btrfs: send: send compressed extents with encoded
 writes
Message-ID: <20200824175253.GA193404@exodia.localdomain>
References: <cover.1597994106.git.osandov@osandov.com>
 <8eeed3db43c3c31f4596051897578e481d6cda17.1597994106.git.osandov@osandov.com>
 <6585ccb9-3528-e451-bb31-ffdd186b13ec@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6585ccb9-3528-e451-bb31-ffdd186b13ec@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 24, 2020 at 01:32:47PM -0400, Josef Bacik wrote:
> On 8/21/20 3:39 AM, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > Now that all of the pieces are in place, we can use the ENCODED_WRITE
> > command to send compressed extents when appropriate.
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> 
> This one doesn't apply cleanly to misc-next, the ctree.h and inode.c chunks
> all fail, and the last hunk of the send stuff doesn't apply.  Thanks,
> 
> Josef

Looks like a few patches just went in that conflict with this. I'll
rebase for the next version, but I also have this in a git branch in the
meantime: https://github.com/osandov/linux/tree/btrfs-send-encoded-v1
