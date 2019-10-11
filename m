Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2ECD411E
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2019 15:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfJKN1q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Oct 2019 09:27:46 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43021 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfJKN1q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Oct 2019 09:27:46 -0400
Received: by mail-qt1-f196.google.com with SMTP id t20so8486811qtr.10
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2019 06:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t2zFIvIesqyJ/wrPmPi9vCoiYfapR9CDMYp/cRglWb4=;
        b=dranrffOqx1gUNiXiABDdLViTzoDsNtkddAZ+//IYtb/91qml0grQCu3o83TyW7OqE
         BFBGUoPA6OwtUxENVhQgi7pC9pdbmFIMWMirrE55TuAGABii13Loz084aoGzEfgcdaeR
         KpRG1Vmz/R45DCWfpQV7Lzr4fdDPWkMSmDkWUMFhDFjzvEdFn6bOBA5NgBJvXRZqgGJi
         4YsPYM+yw+FeceE+wGD+6hIb5Xa8zozRF+mLjJYo5hlIO0i6W+AjgyUgE6w9cHDHqT7b
         lNcFQ4iQl1l7YKuQYblNscy+oBof4F2VTBsOYUQ4BRD6FDwaplEka+vF6FFA02vA/Gdx
         1/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t2zFIvIesqyJ/wrPmPi9vCoiYfapR9CDMYp/cRglWb4=;
        b=Fk9jDGNhsPJb/KtO/jdHa4oIrxHdh5UoEbszJsINmeL96FZBP08HUQBv+AL1u9agPn
         ODsLwaQUTbBWYkycCXMxcj+YnTUAX5Xnwv4Ax0Kzblv8ItE0ypTVvjpMtoFVLh744ZAq
         xHQYegmnvIewVFeshu9sNUa0llviF+i5k3j5m1TLm/rQJFCtl/S+YDajfIGSwmNkwedS
         w7MvGm7QZ4AlscJWcflvsXYbnMGmyNaFCdmWLfnRsPPpMz4YD1+DCxcE+yd+84yLtse5
         sWDOCn1RViWbl6XgnVDrbVzz4YLrO+NVsOryzsSMusygV+YGLhEWEojPmZHEirfAJSkD
         ZPtg==
X-Gm-Message-State: APjAAAXC+bTGuRz3A/IUKklSW1vSJpKp53Fj/94NxjRJBOcAQSr/ILQk
        ZCG2E11gXo11wHn1iGl7FJLXIA==
X-Google-Smtp-Source: APXvYqwXV5P9WQPwH9lAama4jmsKA/+238MMOKSnIg/aeVCKCg8+wUb2RC3tPt/dXC44vtp0lraLNw==
X-Received: by 2002:a0c:c58c:: with SMTP id a12mr16133627qvj.235.1570800464303;
        Fri, 11 Oct 2019 06:27:44 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id j4sm4240180qkf.116.2019.10.11.06.27.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 06:27:43 -0700 (PDT)
Date:   Fri, 11 Oct 2019 09:27:42 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix negative subv_writers counter and data space
 leak after buffered write
Message-ID: <20191011132741.6zrjhv22j4otl6jc@MacBook-Pro-91.local>
References: <20191009164422.7202-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009164422.7202-1-fdmanana@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 09, 2019 at 05:44:22PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When doing a buffered write it's possible to leave the subv_writers
> counter of the root, used for synchronization between buffered nocow
> writers and snapshotting. This happens in an exceptional case like the
> following:
> 
> 1) We fail to allocate data space for the write, since there's not
>    enough available data space nor enough unallocated space for allocating
>    a new data block group;
> 
> 2) Because of that failure, we try to go to NOCOW mode, which succeeds
>    and therefore we set the local variable 'only_release_metadata' to true
>    and set the root's sub_writers counter to 1 through the call to
>    btrfs_start_write_no_snapshotting() made by check_can_nocow();
> 
> 3) The call to btrfs_copy_from_user() returns zero, which is very unlikely
>    to happen but not impossible;
> 
> 4) No pages are copied because btrfs_copy_from_user() returned zero;
> 
> 5) We call btrfs_end_write_no_snapshotting() which decrements the root's
>    subv_writers counter to 0;
> 
> 6) We don't set 'only_release_metadata' back to 'false' because we do
>    it only if 'copied', the value returned by btrfs_copy_from_user(), is
>    greater than zero;
> 
> 7) On the next iteration of the while loop, which processes the same
>    page range, we are now able to allocate data space for the write (we
>    got enough data space released in the meanwhile);
> 
> 8) After this if we fail at btrfs_delalloc_reserve_metadata(), because
>    now there isn't enough free metadata space, or in some other place
>    further below (prepare_pages(), lock_and_cleanup_extent_if_need(),
>    btrfs_dirty_pages()), we break out of the while loop with
>    'only_release_metadata' having a value of 'true';
> 
> 9) Because 'only_release_metadata' is 'true' we end up decrementing the
>    root's subv_writers counter to -1, and we also end up not releasing the
>    data space previously reserved through btrfs_check_data_free_space().
>    As a consequence the mechanism for synchronizing NOCOW buffered writes
>    with snapshotting gets broken.
> 
> Fix this by always setting 'only_release_metadata' to false whenever it
> currently has a true value, independently of having been able to copy any
> data to the pages.

Can we accomplish the same thing by just doing

only_release_metadata = false;

at the start of the loop?  That way we only ever deal with it in its current
scope?  Thanks,

Josef
