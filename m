Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E9925071F
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 20:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgHXSIk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 14:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgHXSIh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 14:08:37 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B31C061573
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 11:08:37 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id y65so462465qtd.2
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 11:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Lj1IegUSdsTYbPVodvSVPh5fvoUtLRv264nMvPFYi04=;
        b=VST++JQs1ER8Ux0et60srcmht71LbLWl2oUldtIepvP2Lla3qvIKELUmkbjFK/jSFR
         3JA15o6qDQ/jvPm2JYlLUt7HlDDu4eEr4ezrszm11YgfORRIvL2+mDD69qszlM+ziDtx
         B9a+nuAKbWJBkq5pxVvhlan470F1f8tylv0+0enkU9x2mBCUmIeM14aaqaKn1kBoOKjU
         4z1mp+JNUvmn/KQwCes4J6Na4E+wTu8Qum/Rxg1u4UXN6bFDd4BPRVpjyUxnCmrXd3sW
         QNxeXlRAwtKmXsGussfe2WpAZ0BK81nanNUYo5WpKR1Qkd6EZAb/p8c0jEqmaw35FXHP
         4WtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lj1IegUSdsTYbPVodvSVPh5fvoUtLRv264nMvPFYi04=;
        b=Cg/4LDdLEZ6IIZym0aqnMBLCytzaXrsonpGmANGt3xjy3Q53ag+UD3F1vZMTenxhVQ
         Sj15C6+Bgp0zivDfcJjfj1kh+XqQpZLqxIAtfxk5xkN7Fu3+gsfR1TcLcByxMPB5k/aK
         GcPhMR27LCiO8jCZRcnxeWqT/BiYKTTsh1Bc9vnDh1wED+14emjg1mQkWRlIrfIcC51T
         QaLbKD06l2CHRy98an8Sul4YL8HvzhIlkefbhxYAeBKcUutNxnNzpjycaEC0n6NOS6Z/
         Lvx/tFbbBK57kJqjkZeXbtgpUpuWyj8O1Imkwj6nuaGJepfkWYPc62acDzRNgteqZ0El
         3FbA==
X-Gm-Message-State: AOAM532YENJxb379CxY0O005utCHSf/UBCOvs4AfYEbiyD4B3b/NXehs
        +dNPMf86UkqPHHt2oQ7hb8Jb807pr2T9CSa3
X-Google-Smtp-Source: ABdhPJwImgnVwlp2aE7rdBdfpRYR/DNLaD4+fah95I+ck+nCMNP41bI/w+/dSjTJFAWdGhYojREXDQ==
X-Received: by 2002:aed:2c05:: with SMTP id f5mr3444584qtd.308.1598292512114;
        Mon, 24 Aug 2020 11:08:32 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x57sm11687463qtc.61.2020.08.24.11.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 11:08:31 -0700 (PDT)
Subject: Re: [PATCH 2/2] btrfs: qgroup: fix qgroup meta rsv leak for subvolume
 operations
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200724064610.69442-1-wqu@suse.com>
 <20200724064610.69442-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <d90d08f5-0205-09a8-efb3-49950494c314@toxicpanda.com>
Date:   Mon, 24 Aug 2020 14:08:30 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200724064610.69442-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/24/20 2:46 AM, Qu Wenruo wrote:
> [BUG]
> When quota is enabled for TEST_DEV, generic/013 sometimes fails like this:
> 
>    generic/013 14s ... _check_dmesg: something found in dmesg (see xfstests-dev/results//generic/013.dmesg)
> 
> And with the following metadata leak:
> 
>    BTRFS warning (device dm-3): qgroup 0/1370 has unreleased space, type 2 rsv 49152
>    ------------[ cut here ]------------
>    WARNING: CPU: 2 PID: 47912 at fs/btrfs/disk-io.c:4078 close_ctree+0x1dc/0x323 [btrfs]
>    Call Trace:
>     btrfs_put_super+0x15/0x17 [btrfs]
>     generic_shutdown_super+0x72/0x110
>     kill_anon_super+0x18/0x30
>     btrfs_kill_super+0x17/0x30 [btrfs]
>     deactivate_locked_super+0x3b/0xa0
>     deactivate_super+0x40/0x50
>     cleanup_mnt+0x135/0x190
>     __cleanup_mnt+0x12/0x20
>     task_work_run+0x64/0xb0
>     __prepare_exit_to_usermode+0x1bc/0x1c0
>     __syscall_return_slowpath+0x47/0x230
>     do_syscall_64+0x64/0xb0
>     entry_SYSCALL_64_after_hwframe+0x44/0xa9
>    ---[ end trace a6cfd45ba80e4e06 ]---
>    BTRFS error (device dm-3): qgroup reserved space leaked
>    BTRFS info (device dm-3): disk space caching is enabled
>    BTRFS info (device dm-3): has skinny extents
> 
> [CAUSE]
> The qgroup preallocated meta rsv operations of that offending root are:
> 
>    btrfs_delayed_inode_reserve_metadata: rsv_meta_prealloc root=1370 num_bytes=131072
>    btrfs_delayed_inode_reserve_metadata: rsv_meta_prealloc root=1370 num_bytes=131072
>    btrfs_subvolume_reserve_metadata: rsv_meta_prealloc root=1370 num_bytes=49152
>    btrfs_delayed_inode_release_metadata: convert_meta_prealloc root=1370 num_bytes=-131072
>    btrfs_delayed_inode_release_metadata: convert_meta_prealloc root=1370 num_bytes=-131072
> 
> It's pretty obvious that, we reserve qgroup meta rsv in
> btrfs_subvolume_reserve_metadata(), but doesn't have corresponding
> release/convert calls in btrfs_subvolume_release_metadata().
> 
> This leads to the leakage.
> 
> [FIX]
> To fix this bug, we should follow what we're doing in
> btrfs_delalloc_reserve_metadata(), where we reserve qgroup space, and
> add it to block_rsv->qgroup_rsv_reserved.
> 
> And free the qgroup reserved metadata space when releasing the
> block_rsv.
> 
> To do this, we need to change the btrfs_subvolume_release_metadata() to
> accept btrfs_root, and record the qgroup_to_release number, and call
> btrfs_qgroup_convert_reserved_meta() for it.
> 
> Fixes: 733e03a0b26a ("btrfs: qgroup: Split meta rsv type into meta_prealloc and meta_pertrans")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Seems like this class of issues could be avoided if the qgroup reservation stuff 
actually took the block_rsv so they could update the ->qgroup_rsv_reserved 
counter, and then the reserve/cleanup functions would do the right thing 
themselves, instead of needing to make sure they adjust things as necessary in 
all the callers.  This would be reasonable follow up work.  Thanks,

Josef
