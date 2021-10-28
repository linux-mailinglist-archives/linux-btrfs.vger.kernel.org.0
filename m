Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B41043E274
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Oct 2021 15:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhJ1NqV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Oct 2021 09:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhJ1NqU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Oct 2021 09:46:20 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEB2C061570
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Oct 2021 06:43:53 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id bj31so5803860qkb.2
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Oct 2021 06:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JHrMrl2VQ76bFXeXmWT8b/Vk5mWVoY6LgxhCCp3MS5I=;
        b=YTyy+3+utmStJoQ5PFL+pV+Ib8ff/61nD/BFgc7ug47w4kVb8yHogYDTqZ55uuM87m
         8VxT2V0WF8f0cEU6AkxdqClSLh8dQZw61YpCjPGKddyA+yc8ndyD6dDPqLr4iSP4QlV4
         JesLnn04tdkuI/SQ1WcXFlE4/8yHNDXA8PBHXIrblqKRbfbMlod1Fcon8CI1GAIkLZ6c
         +4OZMjxHX5sKRusmaPcLRa1Vld+JUGZoaVpZYrzwtOf4XWFv0yxgsF6ge1cPLxIxVl5K
         U0ghuSnx4TJEDlFsbvxgmmz9Kf7SbnGCrxJXXEul68FGU28DtYFtuvjX1sClGRlsfNHl
         n10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JHrMrl2VQ76bFXeXmWT8b/Vk5mWVoY6LgxhCCp3MS5I=;
        b=xI/HK9utR0fWlElFfiyRrYPBIIovbZS1fJoNiinqXnbMMbV99x5UcVA5zPbbhDm7Yl
         VXFisNe0dtYisjGdbBHNcqj2GwlO/GW14GK+70mpB3mHU9AFqnpyNnpt5oRPO/s0T/8c
         Ji8oG+uus5dcvsfI4BNtoJULRM/NCrSIS4cj52Xig+OOqsQPwWTPr0WU9/kry3vc8cIa
         EiU8a8y0nRiCD2zmQgSRz1lbDp7nhw5Ruze0aJ7p7AM3oqZ28XsbSEdNaMB0NabvXni8
         VY6i1uUgtf+jcqSI2taS0gb5Wj8y7Hx1eQr1L3RFZLFjk5t7Ke+C3mOFk2YD3bLzyZ4A
         6PyQ==
X-Gm-Message-State: AOAM5327kAY2XIf4pn9Y1hWkcRPQReoBVBef97LNeygc+zic7Gq/hv/c
        aeMmj8NEQfS2tGRPcXsLJ8tXZA==
X-Google-Smtp-Source: ABdhPJyojvuWiBC6obrmSLZ02Y9PXUi4vaK5a/892fE8CcFZlA/VtB+Iv5IMCcAs1j7VQ0Ca//abow==
X-Received: by 2002:a37:2d87:: with SMTP id t129mr3616461qkh.88.1635428632240;
        Thu, 28 Oct 2021 06:43:52 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l3sm2006265qkj.18.2021.10.28.06.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 06:43:51 -0700 (PDT)
Date:   Thu, 28 Oct 2021 09:43:51 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Stefan Roesch <shr@fb.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 0/4] btrfs: sysfs: set / query btrfs stripe size
Message-ID: <YXqpFxiAVrC92io6@localhost.localdomain>
References: <20211027201441.3813178-1-shr@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027201441.3813178-1-shr@fb.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 27, 2021 at 01:14:37PM -0700, Stefan Roesch wrote:
> Motivation:
> The btrfs allocator is currently not ideal for all workloads. It tends
> to suffer from overallocating data block groups and underallocating
> metadata block groups. This results in filesystems becoming read-only
> even though there is plenty of "free" space.
> 
> This is naturally confusing and distressing to users.
> 
> Patches:
> 1) Store the stripe and chunk size in the btrfs_space_info structure
> 2) Add a sysfs entry to expose the above information
> 3) Add a sysfs entry to force a space allocation
> 4) Increase the default size of the metadata chunk allocation to 5GB
>    for volumes greater than 50GB.
> 
> Testing:
>   A new test is being added to the xfstest suite. For reference the
>   corresponding patch has the title:
>     [PATCH] btrfs: Test chunk allocation with different sizes
> 
>   In addition also manual testing has been performed.
>     - Run xfstests with the changes and the new test. It does not
>       show new diffs.
>     - Test with storage devices 10G, 20G, 30G, 50G, 60G
>       - Default allocation
>       - Increase of chunk size
>       - If the stripe size is > the free space, it allocates
>         free space - 1MB. The 1MB is left as free space.
>       - If the device has a storage size > 50G, it uses a 5GB
>         chunk size for new allocations.
> 
> Stefan Roesch (4):
>   btrfs: store stripe size and chunk size in space-info struct.
>   btrfs: expose stripe and chunk size in sysfs.
>   btrfs: add force_chunk_alloc sysfs entry to force allocation
>   btrfs: increase metadata alloc size to 5GB for volumes > 50GB
>

Sorry, I had this thought previously but it got lost when I started doing the
actual code review.

We have conflated stripe size and chunk size here, and unfortunately "stripe
size" means different things to different people.  What you are actually trying
to do here is to allow us to allocate a larger logical chunk size.

In terms of how this works out in the code you are changing the correct thing,
generally the stripe_size is what dictates the actual block group chunk size we
end up with at the end.

But this is sort of confusing when it comes to the interface, because people are
going to think it means something different.

Instead we should name the sysfs file chunk_size, and then keep the code you
have the way it is, just with the new name.  That way it's clear to the user
that they're changing how large of a chunk we're allocating at any given time.

Make that change, and I have a few other code comments, and then that should be
good.  Thanks,

Josef 
