Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 687E7150CAF
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 17:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbgBCQii (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 11:38:38 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40202 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730562AbgBCQii (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 11:38:38 -0500
Received: by mail-qk1-f194.google.com with SMTP id t204so14813447qke.7
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 08:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=rEcmC0gmGx+LrwskHbuJ4gR8C8csiaxd0WHumSNrEEo=;
        b=PmdTb8fDEOB9FLU0+ZGSch5BHtkhJF4ojtGWXA9lygYwwocvLfG7lAVAGt1GzApLSC
         OqcEEM8T9n6wcu1bQ8wzFgAiI6VYPEf3IkS9nEHtBIlvO9QXXdaqqbl5AHEAMFEOBRAj
         YHAMRlQMAItpXk/NX1uV3w/pajFx2XnHEsP4c7gB5FRZKjlYogZn12pdUTxdDDg7quGb
         jhp8Nx3VNrBmygutMRwqbt6/ijWIT6Ul2HBbC723aAOhb7qxC4UWL6Mixc+uZTxo+GCw
         uLeIoAxPVynKtjLc62B2BJNbtVQbDhue3NDwmRJdn0SWg6p/fflw7p/fGIHBwTv2Zn9O
         xImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rEcmC0gmGx+LrwskHbuJ4gR8C8csiaxd0WHumSNrEEo=;
        b=ilLcHu4W0eB4fj0kYy2xntqHZil5ko505cNceIQ8uCSrUzA+seeN8/HdqZm+i+2Mzo
         amcFGHEFAIJuoZvoZ2aFCKQeZIQ0p1iA0R23lS7MBEGr8/XxQ/Wfed7JhKRSQrxcxrxu
         gnmJuZvoIx3kbOOxeSWXFCrbqWoXcsIVv3G8FTvxHXYk4RWBcKd7lgxTKbf/dJk5OLsK
         ylTYxlYx1Z+/p0KUxuyIBc+Dy0VfX9N8wxtIyIjBTeI6KD/vHMGHiCohmMpi9NNZB1yc
         hxFek71WnaP/AD4rAjS/je0FPkQqbkiBzirYhueNd1bU+2eV2P80o6Tri/lg6bFtbrMh
         UPSQ==
X-Gm-Message-State: APjAAAX06QgSPe38Uhnm2Vac2vBF/Yj8Dw98/1dTVYHOquqYAWq7mOqr
        RGqMFKoGw9C3PYqgFRk6ynSL2chZpeTHAA==
X-Google-Smtp-Source: APXvYqy+ESkthvhLsHW4hvgIcZUFIe2o1hBtpTF/jVlY19RgDQd81WfpxGX4yB+3109bc5XQOTxLJg==
X-Received: by 2002:a05:620a:1415:: with SMTP id d21mr23522389qkj.17.1580747916408;
        Mon, 03 Feb 2020 08:38:36 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id n4sm10037959qti.55.2020.02.03.08.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 08:38:35 -0800 (PST)
Subject: Re: [PATCH] btrfs: Don't submit any btree write bio after transaction
 is aborted
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200203064558.27064-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4587d936-07c6-1319-22a1-ceb8dd7cbeff@toxicpanda.com>
Date:   Mon, 3 Feb 2020 11:38:34 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200203064558.27064-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/3/20 1:45 AM, Qu Wenruo wrote:
> [BUG]
> There is a fuzzed image which could cause KASAN report at unmount time.
> 
>    ==================================================================
>    BUG: KASAN: use-after-free in btrfs_queue_work+0x2c1/0x390
>    Read of size 8 at addr ffff888067cf6848 by task umount/1922
> 
>    CPU: 0 PID: 1922 Comm: umount Tainted: G        W         5.0.21 #1
>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
>    Call Trace:
>     dump_stack+0x5b/0x8b
>     print_address_description+0x70/0x280
>     kasan_report+0x13a/0x19b
>     btrfs_queue_work+0x2c1/0x390
>     btrfs_wq_submit_bio+0x1cd/0x240
>     btree_submit_bio_hook+0x18c/0x2a0
>     submit_one_bio+0x1be/0x320
>     flush_write_bio.isra.41+0x2c/0x70
>     btree_write_cache_pages+0x3bb/0x7f0
>     do_writepages+0x5c/0x130
>     __writeback_single_inode+0xa3/0x9a0
>     writeback_single_inode+0x23d/0x390
>     write_inode_now+0x1b5/0x280
>     iput+0x2ef/0x600
>     close_ctree+0x341/0x750
>     generic_shutdown_super+0x126/0x370
>     kill_anon_super+0x31/0x50
>     btrfs_kill_super+0x36/0x2b0
>     deactivate_locked_super+0x80/0xc0
>     deactivate_super+0x13c/0x150
>     cleanup_mnt+0x9a/0x130
>     task_work_run+0x11a/0x1b0
>     exit_to_usermode_loop+0x107/0x130
>     do_syscall_64+0x1e5/0x280
>     entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> [CAUSE]
> The fuzzed image has a corrupted extent tree, which can pass
> tree-checker but run_delayed_refs() will still detect such bad extent
> tree, and abort transaction.
> 
> The problem happens at unmount time, where btrfs will stop all workers
> first, then call iput() on the btree inode.
> 
> Since btree inode still has some dirty pages, iput() will try to write
> back such dirty pages, but all related work queues are already freed,
> triggering use-after-free bug.
> 

This sounds like our abort isn't doing the right thing?  We should be cleaning 
all dirty pages at this point so nothing gets submitted after the fact.  Thanks,

Josef
