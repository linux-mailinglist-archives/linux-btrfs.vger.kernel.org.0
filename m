Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9BC2189DC
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 16:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbgGHOKy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 10:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbgGHOKy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jul 2020 10:10:54 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF75C061A0B
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jul 2020 07:10:53 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id r22so41562643qke.13
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jul 2020 07:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=e7SZaQUP6jQpntHJKTbGl27kEqFqd4PO7M28OCjSyuA=;
        b=CV2MUSuYYWAic8kWCQe/iv6Jl9is8AYeDYD/P/4/19L+nv2B51WRUjmfBZYWF/aXD/
         YS6cXbztHxnnfwasrcXzdtE59oYEg3WH4OYq46WrVoBxXUeC/3+7eg6m5HRcbEU7lq2/
         oiVmNrHpTMX3uYplzpokm82JJN/RHIpvBDzDpiQm3qUthrxefdfL/67bWjFSXyh0r8hG
         kbgdcRYkY5cPcJLWVJRnJxHPbkBd2CQq4v93gWWgme0KtDm5bCBckYYQj+L6B89d74b2
         j37hH2w8MdfhDF6ViT3nRkP6Z7CdgJrhButCy/gsn2zo3Gd8c4U+AbVI/KnqsvWR1W1X
         7Zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e7SZaQUP6jQpntHJKTbGl27kEqFqd4PO7M28OCjSyuA=;
        b=eRrf4rphjgdBwqA1FhWULjil7dOPkWvmN6c5VBYD+st66V92uaXS9AQcJHlr4V0Lfh
         MfP1bXb06SvMVCO15SB2Hxj51P6VeuiEPJAKpClX3kxnBfXZHfuPIgj7JHrtHi7qbLro
         x0iPKjzBVNOqO0tQ2KiUS14RxKrygeT03d926CcCJModc1WIA3Hk8oqJ7zo2C2tVqOcz
         iNQertpHg4fxRpjvpuI0usu9a1edwsyQExKbMcp8kSsjP1U4HkYwRDfYttx0AleRmI0E
         tBlD03iaOvX5mt7NbDgJkwxhmBO/RrWTqD+oUijawGZULPQoqeertadPF3zTKaO9M5Sx
         RLFA==
X-Gm-Message-State: AOAM533KQa8VQP4YEXSY3bCosGsJNIOL47rtoQfs3x8bckWoMqi4UHrg
        AhiX28+9OpTayAkaDmOUAQAO5CXN//1Mhg==
X-Google-Smtp-Source: ABdhPJxqW8OR03I8E8ZyAnR19JwYTGrl+gLTROX8RCva84ujA7fls4I4DIYf90r6ws2EUkZwEBnoQg==
X-Received: by 2002:a05:620a:1587:: with SMTP id d7mr49025129qkk.228.1594217452749;
        Wed, 08 Jul 2020 07:10:52 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t48sm32124431qtb.50.2020.07.08.07.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 07:10:52 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] btrfs: qgroup: try to flush qgroup space when we
 get -EDQUOT
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200708062447.81341-1-wqu@suse.com>
 <20200708062447.81341-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <dbecbea5-b723-57b7-3a1a-3509d0ddbd0b@toxicpanda.com>
Date:   Wed, 8 Jul 2020 10:10:51 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708062447.81341-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/8/20 2:24 AM, Qu Wenruo wrote:
> [PROBLEM]
> There are known problem related to how btrfs handles qgroup reserved
> space.
> One of the most obvious case is the the test case btrfs/153, which do
> fallocate, then write into the preallocated range.
> 
>    btrfs/153 1s ... - output mismatch (see xfstests-dev/results//btrfs/153.out.bad)
>        --- tests/btrfs/153.out     2019-10-22 15:18:14.068965341 +0800
>        +++ xfstests-dev/results//btrfs/153.out.bad      2020-07-01 20:24:40.730000089 +0800
>        @@ -1,2 +1,5 @@
>         QA output created by 153
>        +pwrite: Disk quota exceeded
>        +/mnt/scratch/testfile2: Disk quota exceeded
>        +/mnt/scratch/testfile2: Disk quota exceeded
>         Silence is golden
>        ...
>        (Run 'diff -u xfstests-dev/tests/btrfs/153.out xfstests-dev/results//btrfs/153.out.bad'  to see the entire diff)
> 
> [CAUSE]
> Since commit c6887cd11149 ("Btrfs: don't do nocow check unless we have to"),
> we always reserve space no matter if it's COW or not.
> 
> Such behavior change is mostly for performance, and reverting it is not
> a good idea anyway.
> 
> For preallcoated extent, we reserve qgroup data space for it already,
> and since we also reserve data space for qgroup at buffered write time,
> it needs twice the space for us to write into preallocated space.
> 
> This leads to the -EDQUOT in buffered write routine.
> 
> And we can't follow the same solution, unlike data/meta space check,
> qgroup reserved space is shared between data/meta.
> The EDQUOT can happen at the metadata reservation, so doing NODATACOW
> check after qgroup reservation failure is not a solution.
> 
> [FIX]
> To solve the problem, we don't return -EDQUOT directly, but every time
> we got a -EDQUOT, we try to flush qgroup space by:
> - Flush all inodes of the root
>    NODATACOW writes will free the qgroup reserved at run_dealloc_range().
>    However we don't have the infrastructure to only flush NODATACOW
>    inodes, here we flush all inodes anyway.
> 
> - Wait ordered extents
>    This would convert the preallocated metadata space into per-trans
>    metadata, which can be freed in later transaction commit.
> 
> - Commit transaction
>    This will free all per-trans metadata space.
> 
> Also we don't want to trigger flush too racy, so here we introduce a
> per-root mutex to ensure if there is a running qgroup flushing, we wait
> for it to end and don't start re-flush.
> 
> Fixes: c6887cd11149 ("Btrfs: don't do nocow check unless we have to")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
