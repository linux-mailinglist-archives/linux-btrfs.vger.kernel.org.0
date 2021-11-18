Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF0145635E
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 20:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhKRTWn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 14:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhKRTWm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 14:22:42 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0C2C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Nov 2021 11:19:42 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id x131so7001002pfc.12
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Nov 2021 11:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r/KCuEUuq7HzUmnTa9vj1McLqk0uyhbLn1CfNmt60cQ=;
        b=jfXtz1Y1XN8nbrgy00oy1MwWhtkc2qIsXeS3Dtw2B3fzHGRQ56+xM2e1BBNduKUD7E
         4jY2J40/ZxOChAEf5oVQukT1sGJUWk2YqqdOexqqrJjytpys+L/LqcQbENa0Y9Wdhy2K
         /TNownk5/0dWnP1Cv7I2cgQR1/bvf3rAtzhN7XdxA1vVZJDDCNYsau55Zb9UD57ksSj5
         Q/XugRU9NtEUiYm3ZPKK59HDsfXcP2cvzS2jra1AKKzhje4osNfmECbbEghnIswFQ1Y4
         4BonuIZw+XSF35CtGD9V+EsPeujSJ8U9Ra25LbUc0xcGUVUJYQDZfYfcw1T2gaNUTeuV
         VW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r/KCuEUuq7HzUmnTa9vj1McLqk0uyhbLn1CfNmt60cQ=;
        b=LD/oQ2/jfAkIC9D0ewpM7UkuiqZ4hSNRmUdAPqMKv1rbvapcYkXOzb1+XvzlJWT23D
         YoI/q20C2g+H8F/Dxe+4YnW/D7flh4nTDQkMmjV3DA57w+4XqvdXS2KSDCvuJAEAB4v+
         gmpbW45xz6IJinJIzK3RW7ISvjywbREDuCIZCbZrcWncRIUOGzGgpaUYnOBOScAfW9Fr
         pK/L+N8V3rI5ZdVf2PAl3xXjv0sOLrXgrXQfCC/z+eMTDX4eonK4+siuNqKeKAM0rYq1
         rOEtAYpQNrL9QwjrLRnZgIwaQdehoYjhBXUsDRaDEzGA6alz/dTiaT4pR8p1LWq5IXe0
         rW1g==
X-Gm-Message-State: AOAM53387EDjVj+vbVZfhRhdD7LN8zLOd2nLT5EZ9ekp7wyFeOA9M267
        NY1gj86KbKirkU0bSQKYP5wXTzlVru2REw==
X-Google-Smtp-Source: ABdhPJwRma8uUjJdafphLfaYQlBBCX12xP60toVWSBoYNSwsoZu/VeA3khvxwwWwjNRWHmOmDIWWUg==
X-Received: by 2002:a63:d80c:: with SMTP id b12mr12980196pgh.331.1637263181350;
        Thu, 18 Nov 2021 11:19:41 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:174e])
        by smtp.gmail.com with ESMTPSA id oc10sm9862283pjb.26.2021.11.18.11.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 11:19:40 -0800 (PST)
Date:   Thu, 18 Nov 2021 11:19:39 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v11 01/14] fs: export rw_verify_area()
Message-ID: <YZanS89YcCeN9i3y@relinquished.localdomain>
References: <cover.1630514529.git.osandov@fb.com>
 <9cd494dbd55c46a22f07c56ca42a399af78accd1.1630514529.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cd494dbd55c46a22f07c56ca42a399af78accd1.1630514529.git.osandov@fb.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 01, 2021 at 10:00:56AM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> I'm adding Btrfs ioctls to read and write compressed data, and rather
> than duplicating the checks in rw_verify_area(), let's just export it.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  fs/internal.h      | 5 -----
>  fs/read_write.c    | 1 +
>  include/linux/fs.h | 1 +
>  3 files changed, 2 insertions(+), 5 deletions(-)

Could I please get an ack from the VFS side on this patch and "fs:
export variant of generic_write_checks without iov_iter"? We're going
the route of doing this as a Btrfs ioctl since we couldn't agree on a
generic interface, so this is all I need from the VFS.
