Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5FD21D799
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 15:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbgGMNyM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 09:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbgGMNyL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 09:54:11 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FACC061755
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jul 2020 06:54:11 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id q198so12205230qka.2
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jul 2020 06:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7cpDJAkMFH6sDUwAyEHYVqdwal8QaOztSrEwLnInPQg=;
        b=yIbS/Ug/PJQ8UlULaEgkja3j+uHzyXlGIZU4mHvH7lXu7Sh8vU4pArTGOmuL/ghg7B
         RO/Cr5sjcHkldjKCiu4wmTwP2V9x/+5WhpbJgkdMWQ85K8HMzQTB08VvX80F54fChjiu
         W+z2w55Ux4zDRP32m6INHKrEk1xh8Hp/2sUBP/60RL7DR63Q+pu7UHScw/evkPf5bl2r
         T37dZXwLSQW3lbWo9W0uvCKCWgi7K+pfqxcsz+qhtGEW+1VUH2SR3amnFFnlWdb2VZ6v
         oc6LQmDXoRy5wk7Oir+1cZ7hSVPwxHMNCmywhkh4PbC9qC8Jw18yuunfWVOGDdn67T0p
         0ogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7cpDJAkMFH6sDUwAyEHYVqdwal8QaOztSrEwLnInPQg=;
        b=lqpzuvCTOoecm/HZGVI6W9oHUNAbz8uqsICDd+1DPLChu2Ut8RjUB6IAZI7r0Eyoxh
         rBLy/Rw6r9/XEBsMG3UiWUlYZkz/doX3BGhf07PXKMoqQ33WEHRROv72qi4rJqRkvdXD
         4gUCmIVnIJ8NFXumrn0+XEV5uQjjaULaRUAaQ1JOihK1NQ1lyC2NqLXvsG3OYJEvaDmb
         g+NlRZfOa2Xj7oQv0g9iHHfdGQtTcoW000MVleNk6YVWcEdDiw7QjT/M9JBOUD2rw4bg
         OtXbM7lrs/kShW5MjL7qkjfckhxyAAitAZAi76rQQnE43wfUfiRQM/Qq1TGdXQe/RHZq
         0WJg==
X-Gm-Message-State: AOAM53265z5PGBPo++N+IU4fM3oF5EEzaPBA0CYFFbnjCHTqGnEM/+Ab
        5XsmAZeBnILuG0UIenUL7ZbPw0qfSQUsew==
X-Google-Smtp-Source: ABdhPJyp3iEIl2o2EYsy41R5yw8E6EDQGPx/DGvNYrZYDea4QMoazXyjMRxBBUUo5BOTnxH1lv6hWg==
X-Received: by 2002:a37:8142:: with SMTP id c63mr74628249qkd.97.1594648450548;
        Mon, 13 Jul 2020 06:54:10 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e9sm18132371qtq.70.2020.07.13.06.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 06:54:09 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] btrfs: qgroup: try to flush qgroup space when we
 get -EDQUOT
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200713105049.90663-1-wqu@suse.com>
 <20200713105049.90663-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <25c3b2a9-8ecf-6bf3-3bd6-fa6f062343bf@toxicpanda.com>
Date:   Mon, 13 Jul 2020 09:54:08 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713105049.90663-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/13/20 6:50 AM, Qu Wenruo wrote:
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
> per-root wait head and a new root status, to ensure if there is a running
> qgroup flushing, we wait for it to end and don't start re-flush.
> 
> Fixes: c6887cd11149 ("Btrfs: don't do nocow check unless we have to")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
