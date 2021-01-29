Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FE4308A42
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Jan 2021 17:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhA2Qcn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Jan 2021 11:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhA2Qbc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Jan 2021 11:31:32 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEB8C06174A
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Jan 2021 08:22:51 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id w20so4837390qta.0
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Jan 2021 08:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yXyKT6zDbMFAkEFtdwkMYtTPfLe2fKWTThL1c/z6Psc=;
        b=MMERDHwQ05b9QD93YJaPU4AMCvbvs6S+sHWJcGZk9jtXgp/6oRB0vL3vXX8V8ji15K
         lN511PomIO8KM0Tfiil2oSMCIc76lMSeqqJ/c5VoVJSyDfR5fMrNdGiBitjkAV4MXgOv
         wqdiSnmw59YSiJSh4ZXQhtS5djVOy6TGQHepG5Vs4KOOjUTOzJuHcfaC3F5UvNK0fC6O
         l58UuFLu7fh4+7DDhn+6BdC1ZEyqC6RTKtJU+qs5oru4Quq8neBmkRABFKehgyiFyJ66
         6WxemP26L6riW4fyt/MgCKOrreFZqIPoq0gafnwFPI5UHbnzCDEyj+CGXXAgkt/hI11B
         o9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yXyKT6zDbMFAkEFtdwkMYtTPfLe2fKWTThL1c/z6Psc=;
        b=JL5Yv+opbGfeAFEfGgXDAcCgtdR9RNozOQvZ9sk/aTrBlYNbTg2Q3zDisdrbCBik6P
         q2Qx7PLbzhVUI2WiYncYzIJ2lYYk2/HY/1oiWr61sF9WOk3lKI1Tnud5MZJ59sHz6fsA
         0rAMUSKz8EKyaYe/DYhbns/LJ0civ2GSO/zCaLI7LL8UJ6Me/lKkRlbSY2Gml9wfgYWI
         lTxFwwN77B3JXPR3l5mYRmX06rXQbv3m6iOAda2ZNfZxwQ/kZ/H9yU6BtLGM6vF8t7RK
         d6yzM5/DyPpvrctYVTFdOcBnb5g5ifk9OTs0tOG1TNpJ4MkS/CaBt+sl+IGalSP7bd1M
         gtAA==
X-Gm-Message-State: AOAM531VWY0dQ0FrZTiYv2Vmp3AoOg5vDYOdWUxPGYiQDhZou1D/VI3h
        +8olPjSrZNMU9J4pwOJ9f6nWvQ==
X-Google-Smtp-Source: ABdhPJyRs5FFCmdP8XnlrE48whLYLzp5tg+xsgEwHAL160TXhcc5kQrQM5oeBKkiXNLGGqk5Ja15iw==
X-Received: by 2002:ac8:4e8b:: with SMTP id 11mr5039195qtp.292.1611937370596;
        Fri, 29 Jan 2021 08:22:50 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q15sm6330066qkj.9.2021.01.29.08.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jan 2021 08:22:49 -0800 (PST)
Subject: Re: [PATCH v2] btrfs: Avoid calling btrfs_get_chunk_map() twice
To:     Michal Rostecki <mrostecki@suse.de>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Michal Rostecki <mrostecki@suse.com>
References: <20210127135728.30276-1-mrostecki@suse.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <18dab74b-aea9-0e34-1be5-39d62f44cfd2@toxicpanda.com>
Date:   Fri, 29 Jan 2021 11:22:48 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210127135728.30276-1-mrostecki@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/27/21 8:57 AM, Michal Rostecki wrote:
> From: Michal Rostecki <mrostecki@suse.com>
> 
> Before this change, the btrfs_get_io_geometry() function was calling
> btrfs_get_chunk_map() to get the extent mapping, necessary for
> calculating the I/O geometry. It was using that extent mapping only
> internally and freeing the pointer after its execution.
> 
> That resulted in calling btrfs_get_chunk_map() de facto twice by the
> __btrfs_map_block() function. It was calling btrfs_get_io_geometry()
> first and then calling btrfs_get_chunk_map() directly to get the extent
> mapping, used by the rest of the function.
> 
> This change fixes that by passing the extent mapping to the
> btrfs_get_io_geometry() function as an argument.
> 
> v2:
> When btrfs_get_chunk_map() returns an error in btrfs_submit_direct():
> - Use errno_to_blk_status(PTR_ERR(em)) as the status
> - Set em to NULL
> 
> Signed-off-by: Michal Rostecki <mrostecki@suse.com>

This panic'ed all of my test vms in their overnight xfstests runs, the panic is this

[ 2449.936502] BTRFS critical (device dm-7): mapping failed logical 1113825280 
bio len 40960 len 24576
[ 2449.937073] ------------[ cut here ]------------
[ 2449.937329] kernel BUG at fs/btrfs/volumes.c:6450!
[ 2449.937604] invalid opcode: 0000 [#1] SMP NOPTI
[ 2449.937855] CPU: 0 PID: 259045 Comm: kworker/u5:0 Not tainted 5.11.0-rc5+ #122
[ 2449.938252] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
1.13.0-2.fc32 04/01/2014
[ 2449.938713] Workqueue: btrfs-worker-high btrfs_work_helper
[ 2449.939016] RIP: 0010:btrfs_map_bio.cold+0x5a/0x5c
[ 2449.939392] Code: 37 87 ff ff e8 ed d4 8a ff 48 83 c4 18 e9 b5 52 8b ff 49 89 
c8 4c 89 fa 4c 89 f1 48 c7 c6 b0 c0 61 8b 48 89 ef e8 11 87 ff ff <0f> 0b 4c 89 
e7 e8 42 09 86 ff e9 fd 59 8b ff 49 8b 7a 50 44 89 f2
[ 2449.940402] RSP: 0000:ffff9f24c1637d90 EFLAGS: 00010282
[ 2449.940689] RAX: 0000000000000057 RBX: ffff90c78ff716b8 RCX: 0000000000000000
[ 2449.941080] RDX: ffff90c7fbc27ae0 RSI: ffff90c7fbc19110 RDI: ffff90c7fbc19110
[ 2449.941467] RBP: ffff90c7911d4000 R08: 0000000000000000 R09: 0000000000000000
[ 2449.941853] R10: ffff9f24c1637b48 R11: ffffffff8b9723e8 R12: 0000000000000000
[ 2449.942243] R13: 0000000000000000 R14: 000000000000a000 R15: 000000004263a000
[ 2449.942632] FS:  0000000000000000(0000) GS:ffff90c7fbc00000(0000) 
knlGS:0000000000000000
[ 2449.943072] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2449.943386] CR2: 00005575163c3080 CR3: 000000010ad6c004 CR4: 0000000000370ef0
[ 2449.943772] Call Trace:
[ 2449.943915]  ? lock_release+0x1c3/0x290
[ 2449.944135]  run_one_async_done+0x3a/0x60
[ 2449.944360]  btrfs_work_helper+0x136/0x520
[ 2449.944588]  process_one_work+0x26e/0x570
[ 2449.944812]  worker_thread+0x55/0x3c0
[ 2449.945016]  ? process_one_work+0x570/0x570
[ 2449.945250]  kthread+0x137/0x150
[ 2449.945430]  ? __kthread_bind_mask+0x60/0x60
[ 2449.945666]  ret_from_fork+0x1f/0x30

it happens when you run btrfs/060.  Please make sure to run xfstests against 
patches before you submit them upstream.  Thanks,

Josef
