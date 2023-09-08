Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06177989F5
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 17:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjIHP0h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 11:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbjIHP0g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 11:26:36 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B81A1FDE
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 08:26:16 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4121f006c30so13702171cf.2
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Sep 2023 08:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1694186775; x=1694791575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qJ4kw3AGqdgk9Yp9PP1QvPvj+Nhn+b6ZixbWFrFuKOA=;
        b=D03q/5N2JlzVSsq4rE43exXImFcBBGrJe/nRQ/W02ibzwwfa/KhCnkdCcO/JYZOXjB
         I3i6YXLU0PJve2eHPW4qVDntzUpshO0l6OK9qpDIoGnCz/HzwTIYs39gTPkmlBtSY+Te
         WLpEYGV4CWEEpa8nNh/XEeI8bAQB2VguA6HPl/vyU9BzaEjR5kGYF77Zyyofjl4Fb3BW
         9fpL+5eIEUNTkDldjNLJEXmioxbajNMYQMECiaVpT8w4F8oNSTLbgWe+NLC0f6lV9CCZ
         kDszSVNx2E+p3rFN6qOHx5tWi4QQUSG2vEX173F73zBj+FV+MQQ6cv9ibO4dQ7DPzO/6
         7BNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694186775; x=1694791575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJ4kw3AGqdgk9Yp9PP1QvPvj+Nhn+b6ZixbWFrFuKOA=;
        b=IZWGm1gsrIZ852HKBBlEoqXPHA3Bly/KlFsWW0G5wMTd9yNKsPiQH+i+tsVd+wE3kU
         3lUwrht7K0WETZQZ7/GZkrHMg1lRhxszXud3cwJlnhcbohodh/pUyfLuw9HBtdgARvkl
         2NIjMF7owjx+ZwzS4EsTN0W+BI3KYIvcnCBVOyuKJZ8+OnWvVJrXFkRkKHnXPEGyPOey
         nQScrcGyN2TejhWxQcHtQQOmY8XTJ/NmRuIcQ/Z/uCxC0GgdhLr9HQ/AwTB+tYPTVvdk
         zXkJZuANa65CU8j0di4Ge3D35m7nme+1IKXhpgYjmAND7GHGJIs8lXhZjWYRJgAepSRc
         H4qQ==
X-Gm-Message-State: AOJu0YxVYCy3bGVFu1+5eUKGNxvoU/jGfy0VSzFOr/nGQqm7h2Dwic+8
        UoDuJPP7imk1rUDQlSdbQnIoZpI+HfyMaJ8CMm9mVg==
X-Google-Smtp-Source: AGHT+IE843a3L5OzFJ6PHkSSjA/Bmi02sZ4EkSTWhIJ/I1O+3Itprl3MA32X62VTSjlf1YtJrT6iJw==
X-Received: by 2002:ac8:574a:0:b0:412:1ba6:32af with SMTP id 10-20020ac8574a000000b004121ba632afmr3348132qtx.19.1694186775207;
        Fri, 08 Sep 2023 08:26:15 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id iw9-20020a05622a6f8900b004109b0f06c3sm676513qtb.36.2023.09.08.08.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 08:26:14 -0700 (PDT)
Date:   Fri, 8 Sep 2023 11:26:14 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 20/21] btrfs: stop doing excessive space reservation for
 csum deletion
Message-ID: <20230908152614.GU1977092@perftesting>
References: <cover.1694174371.git.fdmanana@suse.com>
 <28529e4ffd497044150775d53395e50c0d48f0f4.1694174371.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28529e4ffd497044150775d53395e50c0d48f0f4.1694174371.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 08, 2023 at 01:09:22PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently when reserving space for deleting the csum items for a data
> extent, when adding or updating a delayed ref head, we determine how
> many leaves of csum items we can have and then pass that number to the
> helper btrfs_calc_delayed_ref_bytes(). This helper is used for calculating
> space for all tree modifications we need when running delayed references,
> however the amount of space it computes is excessive for deleting csum
> items because:
> 
> 1) It uses btrfs_calc_insert_metadata_size() which is excessive because
>    we only need to delete csum items from the csum tree, we don't need
>    to insert any items, so btrfs_calc_metadata_size() is all we need (as
>    it computes space needed to delete an item);
> 
> 2) If the free space tree is enabled, it doubles the amount of space,
>    which is pointless for csum deletion since we don't need to touch the
>    free space tree or any other tree other than the csum tree.
> 
> So improve on this by tracking how many csum deletions we have and using
> a new helper to calculate space for csum deletions (just a wrapper around
> btrfs_calc_metadata_size() with a comment). This reduces the amount of
> space we need to reserve for csum deletions by a factor of 4, and it helps
> reduce the number of times we have to block space reservations and have
> the reclaim task enter the space flushing algorihm (flush delayed items,
> flush delayed refs, etc) in order to satisfy tickets.
> 
> For example this results in a total time decrease when unlinking (or
> truncating) files with many extents, as we end up having to block on space
> metadata reservations less often. Example test:
> 
>   $ cat test.sh
>   #!/bin/bash
> 
>   DEV=/dev/nullb0
>   MNT=/mnt/test
> 
>   umount $DEV &> /dev/null
>   mkfs.btrfs -f $DEV
>   # Use compression to quickly create files with a lot of extents
>   # (each with a size of 128K).
>   mount -o compress=lzo $DEV $MNT
> 
>   # 100G gives at least 983040 extents with a size of 128K.
>   xfs_io -f -c "pwrite -S 0xab -b 1M 0 120G" $MNT/foobar
> 
>   # Flush all delalloc and clear all metadata from memory.
>   umount $MNT
>   mount -o compress=lzo $DEV $MNT
> 
>   start=$(date +%s%N)
>   rm -f $MNT/foobar
>   end=$(date +%s%N)
>   dur=$(( (end - start) / 1000000 ))
>   echo "rm took $dur milliseconds"
> 
>   umount $MNT
> 
> Before this change rm took: 7504 milliseconds
> After this change rm took:  6574 milliseconds  (-12.4%)
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
