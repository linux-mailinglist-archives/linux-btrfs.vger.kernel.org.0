Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE23F1F7D28
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jun 2020 20:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgFLSug (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jun 2020 14:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLSuf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jun 2020 14:50:35 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD191C03E96F
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Jun 2020 11:50:34 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id x16so4840381qvr.3
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Jun 2020 11:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Si0qazQYdEO6uA8nLWoVRLOqJeWmfV30NTAletvdjIQ=;
        b=E+JpO6YApT4lWQ3GWn6Sbvwn5+0BHXOya9Dr4gfw2r433n8exmnqwH2jUSEi0BYuKw
         jYg2tz+pj9JLKm73ArfytTyDpOdC2zSZMizKpl+DI5ev8tfRfa7vSjv1DAV+15SYD0G5
         tXsW4tnoStFLgTm+NNOi51wz6JwkuSwPDmoUDrFjJwts7wMVJRAfcJcJOrtcwxnTUEFJ
         2hSKAGq3a6R5nVRDytr+HX7L6LjYegq+x37WlXqFFF2tyrPmrWVzKjR4TmTQ6bBzXypC
         wgIhwG0GIQlK2Ygw81CSwCn7KBbPoywwWKpKZvBmhWyEoR8fS07bND0w9si4ZUAGH4Ho
         h25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Si0qazQYdEO6uA8nLWoVRLOqJeWmfV30NTAletvdjIQ=;
        b=j0S89Cx5L+IWf/RPeR2xqp6SbBrtIdxy4IDy/ZpOEDxz0xYZI412kXQyEIYXNl7CpI
         51PCr88H06KkE8tn66MRSskRd+9hw+BAkamqL3GuKsBSwgxFeuydBM+Xz8f59Lv0VqB2
         1rMQ6WZ1dhs0bd/fx1Ka+gQ6s8+5qdICCIZJjdB5nkpOpzv6hD4HAx1sZotFgvpXjv6q
         nebb7akT+qwRwVrJGrIBMGLCdr+79fR5wQK0M0LyiJBGapsi+YcZOeyxpRBEP7m/v4Vr
         EIgtxXvZdQod1n5KRgnM1cto+4veV+GYfkP30OS8pKwRxqsj2ASuwMFsgqmObRJM2wkS
         7rkQ==
X-Gm-Message-State: AOAM531TF1ZPpawlfuokoFgwrAORj9NLBB6w9mSI2VmRNOxB2n/nW1kj
        86nvL8LXzuEdATVfNb1bCLi0IB2moj5KCg==
X-Google-Smtp-Source: ABdhPJwm4ieQzdpSzgywf7kw2pNftGE7FOkVPAgFYCj73MRha/dQwyE26l6zGVvOTAvb4QV4OvfyUg==
X-Received: by 2002:a0c:f388:: with SMTP id i8mr12143296qvk.224.1591987832918;
        Fri, 12 Jun 2020 11:50:32 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e1::11c4? ([2620:10d:c091:480::1:487c])
        by smtp.gmail.com with ESMTPSA id h5sm5234478qkk.108.2020.06.12.11.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 11:50:32 -0700 (PDT)
Subject: Re: [PATCH v3 4/5] btrfs: change the timing for qgroup reserved space
 for ordered extents to fix reserved space leak
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200610010444.13583-1-wqu@suse.com>
 <20200610010444.13583-5-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <cfb3c257-daf9-96fe-0907-79bea42d7da3@toxicpanda.com>
Date:   Fri, 12 Jun 2020 14:50:31 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200610010444.13583-5-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/9/20 9:04 PM, Qu Wenruo wrote:
> [BUG]
> The following simple workload from fsstress can lead to qgroup reserved
> data space leakage:
>    0/0: creat f0 x:0 0 0
>    0/0: creat add id=0,parent=-1
>    0/1: write f0[259 1 0 0 0 0] [600030,27288] 0
>    0/4: dwrite - xfsctl(XFS_IOC_DIOINFO) f0[259 1 0 0 64 627318] return 25, fallback to stat()
>    0/4: dwrite f0[259 1 0 0 64 627318] [610304,106496] 0
> 
> This would cause btrfs qgroup to leak 20480 bytes for data reserved
> space.
> If btrfs qgroup limit is enabled, such leakage can lead to unexpected
> early EDQUOT and unusable space.
> 
> [CAUSE]
> When doing direct IO, kernel will try to writeback existing buffered
> page cache, then invalidate them:
>    iomap_dio_rw()
>    |- filemap_write_and_wait_range();
>    |- invalidate_inode_pages2_range();
> 
> However for btrfs, the bi_end_io hook doesn't finish all its heavy work
> right after bio ends.
> In fact, it delays its work further:
>    submit_extent_page(end_io_func=end_bio_extent_writepage);
>    end_bio_extent_writepage()
>    |- btrfs_writepage_endio_finish_ordered()
>       |- btrfs_init_work(finish_ordered_fn);
> 
>    <<< Work queue execution >>>
>    finish_ordered_fn()
>    |- btrfs_finish_ordered_io();
>       |- Clear qgroup bits
> 
> This means, when filemap_write_and_wait_range() returns,
> btrfs_finish_ordered_io() is not ensured to be executed, thus the
> qgroup bits for related range is not cleared.
> 
> Now into how the leakage happens, this will only focus on the
> overlapping part of buffered and direct IO part.
> 
> 1. After buffered write
>     The inode had the following range with QGROUP_RESERVED bit:
>     	596		616K
> 	|///////////////|
>     Qgroup reserved data space: 20K
> 
> 2. Writeback part for range [596K, 616K)
>     Write back finished, but btrfs_finish_ordered_io() not get called
>     yet.
>     So we still have:
>     	596K		616K
> 	|///////////////|
>     Qgroup reserved data space: 20K
> 
> 3. Pages for range [596K, 616K) get released
>     This will clear all qgroup bits, but don't update the reserved data
>     space.
>     So we have:
>     	596K		616K
> 	|		|
>     Qgroup reserved data space: 20K
>     That number doesn't match with the qgroup bit range anymore.
> 
> 4. Dio prepare space for range [596K, 700K)
>     Qgroup reserved data space for that range, we got:
>     	596K		616K			700K
> 	|///////////////|///////////////////////|
>     Qgroup reserved data space: 20K + 104K = 124K
> 
> 5. btrfs_finish_ordered_range() get executed for range [596K, 616K)
>     Qgroup free reserved space for that range, we got:
>     	596K		616K			700K
> 	|		|///////////////////////|
>     We need to free that range of reserved space.
>     Qgroup reserved data space: 124K - 20K = 104K
> 
> 6. btrfs_finish_ordered_range() get executed for range [596K, 700K)
>     However qgroup bit for range [596K, 616K) is already cleared in
>     previous step, so we only free 84K for qgroup reserved space.
>     	596K		616K			700K
> 	|		|			|
>     We need to free that range of reserved space.
>     Qgroup reserved data space: 104K - 84K = 20K
> 
>     Now there is no way to release that 20K unless disabling qgroup or
>     unmount the fs.
> 
> [FIX]
> This patch will change the timing when btrfs_qgroup_release/free_data()
> get called.
> Here uses buffered CoW write as an example.
> 
> 	The new timing			|	The old timing
> ----------------------------------------+---------------------------------------
>   btrfs_buffered_write()			| btrfs_buffered_write()
>   |- btrfs_qgroup_reserve_data() 	| |- btrfs_qgroup_reserve_data()
> 					|
>   btrfs_run_delalloc_range()		| btrfs_run_delalloc_range()
>   |- btrfs_add_ordered_extent()  	|
>      |- btrfs_qgroup_release_data()	|
>         The reserved is passed into	|
>         btrfs_ordered_extent structure	|
> 					|
>   btrfs_finish_ordered_io()		| btrfs_finish_ordered_io()
>   |- The reserved space is passed to 	| |- btrfs_qgroup_release_data()
>      btrfs_qgroup_record			|    The resereved space is passed
> 					|    to btrfs_qgroup_recrod
> 					|
>   btrfs_qgroup_account_extents()		| btrfs_qgroup_account_extents()
>   |- btrfs_qgroup_free_refroot()		| |- btrfs_qgroup_free_refroot()
> 
> The point of such change is to ensure, when ordered extents are
> submitted, the qgroup reserved space is already release, to keep the
> timing aligned with file_write_and_wait_range().
> 
> So that qgroup data reserved space is all bound to btrfs_ordered_extent
> and solve the timing mismatch.
> 
> Suggested-by: Josef Bacik <josef@toxicpanda.com>
> Fixes: f695fdcef83a ("btrfs: qgroup: Introduce functions to release/free qgroup reserve data space")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
