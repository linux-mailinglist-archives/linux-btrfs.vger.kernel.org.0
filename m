Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11A5AD4655
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2019 19:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbfJKROT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Oct 2019 13:14:19 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46188 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbfJKROS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Oct 2019 13:14:18 -0400
Received: by mail-qk1-f196.google.com with SMTP id 201so9511917qkd.13
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2019 10:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8IJACd3tVzAqqB1KwbQ9hXxNFncZGTf3pOcNlernr30=;
        b=L5FN3KBRpX5R3dWxStUyXK4uBouBc4ANe4ZjOnoYjJ/R6xLOokaSaCnUtEvqwm5ypT
         7kg0OQDljZWXzUHLyolgOS+rQDn7gRpVlZDoHcyxQo5eyI+imdRXHsOTMH+UsjxRhPjx
         lWZocU3q2vyzpZ71u1rGxHq0uT5R/XErP/ahnELFFCa5TOOzlJo4n73fYHp4dQZbWzFm
         vCSOvkLFPuqfi6G5naKYMR8BH7+Dg2nUtM8l3o5HxEfQINmFETZFJFQjG3ZG48GGtz1P
         NdBQTJYV2D7k2zPKX3CH7QfmEA2p6um7E53fQTYGA0mKBlDG5ZgFeIuSkuZl31yaGAGR
         T3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8IJACd3tVzAqqB1KwbQ9hXxNFncZGTf3pOcNlernr30=;
        b=fZOizKxNzwjZshwhr8AWzgJtY7ElNFi0kS4HoJ90qWZopFeoKPzWEtcuZiEZThQ47u
         qGri5u7Gz5rlj54Z8ezf13guSyzUCIYl0O/mnSrE5LGtmKcp8Gf5mW1i+NDzZcIPnWmw
         3ThqlzbIUq3XJlinP8BgkwACUDBWyuDNX0ogGtF2TBgo3qp6sUj9Hx1v/r+L9xW0Wq6v
         9fg7eEaL+DWBoGjiaMOlFreKEMHi4eUqEP1zlPq0n/dpguCLcgQnEpwbaL1MPriNbH8A
         GthmG3XupOdtOtdpwjXqMvyopJA/uzrNRbI8SEtnryjF6BkCRbHXh7oCo8GTjmda69MF
         1MQg==
X-Gm-Message-State: APjAAAUCpEYE81qbG2LI360wedKXCEhJDUaotGXxHaG9FYGgIGpW+a5x
        JmMdTSDWYoqXaw756hurw36c6oRTiv3DSA==
X-Google-Smtp-Source: APXvYqwftOCuEsrOv9s+NjAwnw2353nyVHinTtjiOyWROmCXZx/SozUiUZccjUPPlIRZSCul5l52cQ==
X-Received: by 2002:a05:620a:2f3:: with SMTP id a19mr16938286qko.501.1570814056151;
        Fri, 11 Oct 2019 10:14:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::d36])
        by smtp.gmail.com with ESMTPSA id v13sm3827568qtp.61.2019.10.11.10.14.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 10:14:15 -0700 (PDT)
Date:   Fri, 11 Oct 2019 13:14:14 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] Btrfs: fix negative subv_writers counter and data
 space leak after buffered write
Message-ID: <20191011171412.v4kjfrbxruj7owp7@macbook-pro-91.dhcp.thefacebook.com>
References: <20191009164422.7202-1-fdmanana@kernel.org>
 <20191011154120.5547-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011154120.5547-1-fdmanana@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 11, 2019 at 04:41:20PM +0100, fdmanana@kernel.org wrote:
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
>    root's subv_writers counter to -1 (through a call to
>    btrfs_end_write_no_snapshotting()), and we also end up not releasing the
>    data space previously reserved through btrfs_check_data_free_space().
>    As a consequence the mechanism for synchronizing NOCOW buffered writes
>    with snapshotting gets broken.
> 
> Fix this by always setting 'only_release_metadata' to false at the start
> of each iteration.
> 
> Fixes: 8257b2dc3c1a10 ("Btrfs: introduce btrfs_{start, end}_nocow_write() for each subvolume")
> Fixes: 7ee9e4405f264e ("Btrfs: check if we can nocow if we don't have data space")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
