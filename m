Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C29281153F9
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 16:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfLFPMB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 10:12:01 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37636 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfLFPMB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 10:12:01 -0500
Received: by mail-qk1-f193.google.com with SMTP id m188so6751555qkc.4
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 07:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EGd10Njepmagp4YZPNbjMMMXHfUsQ2toCuaG4wEUCGU=;
        b=Jfm4C27T0irqHAreu9j7KddREYR/bofkHVS3k6w8LEMQoHl9vI6xB4aXqV5r+dzJ1Y
         V1eCSti/cgdxvzmy+zE9HC1i6IyefLLfWHE6yr62hYMb27WEh/Y87rFJWIi5Tc+SdDRe
         3cVTrab1575yySqZDaiA9AxTZBgW2zNoizzvTBNWyWzeiJIL1Fm+sfeMqXDRTZ/wTtAZ
         zZLtWwwuTtG1WxC7sv+SrtcbUWDAqEJ8vaEUgIwLQQ4F04/xrxryJvFFjiWZzri2hkM4
         0rphhBlHI5IZ35YJJfVe0XVkHUd7Kc4teKuzUZxnFJh60g89oSipAywWSxZ4aXb+C6YA
         53Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EGd10Njepmagp4YZPNbjMMMXHfUsQ2toCuaG4wEUCGU=;
        b=Bp43BvMETmOZcERE99v++zrm7DJhI4xiWttmVKKQQxO//s68nFxHF7H6GRKKC+k/m4
         Y7NN3eiSm88RLCZJIg+aB55QtrwyjF+7gNFGZzuGUyAS3jP2w0DiXdd3cFmmYJKID4mH
         uPAEoxzGMw+toos9u5wohQmSAHHazzHrHabUyEkWmDdHk/dhz7gQKyTLQo92uVAkgEPO
         B+axQkYOWkLCHKfBmhD3rCyBFDUx5JXmgUI3DJgpE/OszpO5Obe4eMczDNov8S4lISN5
         nm1FtaQARo7hUmooDqfHDNO1lb0kGVEdrKAK9Q3ZdMwkq1YnWEIjhfYF0hUBBRnFHv76
         MU4A==
X-Gm-Message-State: APjAAAVi+428scx5BHXE8PiDnx/ddM9SmxAlorWMeDTwEE1sUnSt/b7H
        ViqvvGpXBZUTnYjEJutshZ3CeA==
X-Google-Smtp-Source: APXvYqzPzpFaCQ+qhCJVpb2Fau9lkiijvTjzHJ59mm6uUSBQNXQcUjxR4Aw31RmZW+58i2BDxBDYAw==
X-Received: by 2002:ae9:c108:: with SMTP id z8mr14356759qki.457.1575645120432;
        Fri, 06 Dec 2019 07:12:00 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 62sm6024123qkm.121.2019.12.06.07.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 07:11:59 -0800 (PST)
Date:   Fri, 6 Dec 2019 10:11:58 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix hole extent items with a zero size after
 range cloning
Message-ID: <20191206151158.zicb54hmrsa7af5t@jbacik-mbp>
References: <20191205165841.18524-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205165841.18524-1-fdmanana@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 05, 2019 at 04:58:41PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Normally when cloning a file range if we find an implicit hole at the end
> of the range we assume it is because the NO_HOLES feature is enabled.
> However that is not always the case. One well known case [1] is when we
> have a power failure after mixing buffered and direct IO writes against
> the same file.
> 
> In such cases we need to punch a hole in the destination file, and if
> the NO_HOLES feature is not enabled, we need to insert explicit file
> extent items to represent the hole. After commit 690a5dbfc51315
> ("Btrfs: fix ENOSPC errors, leading to transaction aborts, when cloning
> extents"), we started to insert file extent items representing the hole
> with an item size of 0, which is invalid and should be 53 bytes (the size
> of a btrfs_file_extent_item structure), resulting in all sorts of
> corruptions and invalid memory accesses. This is detected by the tree
> checker when we attempt to write a leaf to disk.
> 
> The problem can be sporadically triggered by test case generic/561 from
> fstests. That test case does not exercise power failure and creates a new
> filesystem when it starts, so it does not use a filesystem created by any
> previous test that tests power failure. However the test does both
> buffered and direct IO writes (through fsstress) and it's precisely that
> which is creating the implicit holes in files. That happens even before
> the commit mentioned earlier. I need to investigate why we get those
> implicit holes to check if there is a real problem or not. For now this
> change fixes the regression of introducing file extent items with an item
> size of 0 bytes.
> 
> Fix the issue by calling btrfs_punch_hole_range() without passing a
> btrfs_clone_extent_info structure, which ensures file extent items are
> inserted to represent the hole with a correct item size. We were passing
> a btrfs_clone_extent_info with a value of 0 for its 'item_size' field,
> which was causing the insertion of file extent items with an item size
> of 0.
> 
> [1] https://www.spinics.net/lists/linux-btrfs/msg75350.html
> 
> Fixes: 690a5dbfc51315 ("Btrfs: fix ENOSPC errors, leading to transaction aborts, when cloning extents")
> Reported-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
