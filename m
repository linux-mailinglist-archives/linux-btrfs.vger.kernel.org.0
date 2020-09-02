Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B3925AA13
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 13:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgIBLNm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 07:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgIBLNb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 07:13:31 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CDCC061244
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Sep 2020 04:13:31 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id m14so1988129qvt.1
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Sep 2020 04:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LkgDrodl1d6r5bSpjClpRshY9eOuHQo45vM8ms/4J2s=;
        b=jaoH6qFMHw5EgrBQxizNvYjvUiYaYEUe7QXwg8oEk5ydlFAjhbaBw8dn6Jup8LWXyv
         8/SgHyv2SUZvqjDeEM728sqOJzNE16ZbtE78awwwx/GUzilT11lDQd3gitvTTH9ULRRm
         wpXJONEdH4j+wkwAQpY0BZxrE/yun0oPEbVHfeIPGIsXTbHIeNvKm3+KwPkk9mmNArZ3
         QuzbeEdRlECgUD59VZoYYNku6d8EsCA/lSF/iGvVtclPjkpGQU4UxQdfOYg9yZYh7tpv
         qu55XWswqLdKTaQy359KbA4TcuI/DbHgnuc35DeOEyt8MXnn+7dINqnq3PMCTw7BWfdo
         Kwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LkgDrodl1d6r5bSpjClpRshY9eOuHQo45vM8ms/4J2s=;
        b=rgPS06dzhXeZUSGtNVeX/O37D0J7som3oLEUnuTkRDSG51zXSVshgwZOIv+TU7ZGkX
         G09g8mB3IJaNK5/xvDFjTdaKWwTFGh1gz1oPOQSPaOX8MIOOh7cGogMKpxihmVBHwN92
         j40M/MA4WL6RX/E2fELwibW+WqRHLPMuco+QX5BtOLVUBcrZ4vXn35CyMQP+kgkmLyRK
         Gsu6No8OoCCyGhDBSJ4AXQ8ZDFZLBIVhYwR+1UHtkuPBZzEvYSzGZsZHrnGc7lutrcks
         UDpZOKV1WOMmY33vBvbdx3+imy6/13XynX/4njeyCmc3NW5OGl59UQAvl6EuSi1SrF6x
         6z7g==
X-Gm-Message-State: AOAM531zb5U887liyuyfhLXJDEJAXm/YRFoJ28Bt46du7XMnnSHsxOKp
        /buF8jP4dCxbOQhkdX8kj5mq79mZnaoTm+Wm/EE=
X-Google-Smtp-Source: ABdhPJwVaRKM1LVCaGa7E9WjmT5SItgdf8xd0raK6VF9FBhkC05rwZX/MyqufYwEADXfXEvVVT92Wg==
X-Received: by 2002:a0c:a8c7:: with SMTP id h7mr6393917qvc.181.1599045210371;
        Wed, 02 Sep 2020 04:13:30 -0700 (PDT)
Received: from [192.168.1.210] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e1sm4494802qtb.0.2020.09.02.04.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 04:13:29 -0700 (PDT)
Subject: Re: [PATCH v2] btrfs: don't call btrfs_sync_file from iomap context
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@gmail.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>
References: <20200902103347.32255-1-johannes.thumshirn@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <d002ec6e-85dc-679b-db66-093f93282660@toxicpanda.com>
Date:   Wed, 2 Sep 2020 07:13:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200902103347.32255-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/2/20 6:33 AM, Johannes Thumshirn wrote:
> Fstests generic/113 exposes a deadlock introduced by the switch to iomap
> for direct I/O.
> 
>   ============================================
>   WARNING: possible recursive locking detected
>   5.9.0-rc2+ #746 Not tainted
>   --------------------------------------------
>   aio-stress/922 is trying to acquire lock:
>   ffff888217412010 (&sb->s_type->i_mutex_key#11){++++}-{3:3}, at: btrfs_sync_file+0xf7/0x560 [btrfs]
> 
>   but task is already holding lock:
>   ffff888217412010 (&sb->s_type->i_mutex_key#11){++++}-{3:3}, at: btrfs_file_write_iter+0x6e/0x630 [btrfs]
> 
>   other info that might help us debug this:
>   Possible unsafe locking scenario:
> 
>   CPU0
>   ----
>   lock(&sb->s_type->i_mutex_key#11);
>   lock(&sb->s_type->i_mutex_key#11);
> 
>   *** DEADLOCK ***
> 
>   May be due to missing lock nesting notation
> 
>   2 locks held by aio-stress/922:
>   #0: ffff888217412010 (&sb->s_type->i_mutex_key#11){++++}-{3:3}, at: btrfs_file_write_iter+0x6e/0x630 [btrfs]
>   #1: ffff888217411ea0 (&ei->dio_sem){++++}-{3:3}, at: btrfs_direct_IO+0x113/0x160 [btrfs]
> 
>   stack backtrace:
>   CPU: 0 PID: 922 Comm: aio-stress Not tainted 5.9.0-rc2+ #746
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4-rebuilt.opensuse.org 04/01/2014
>   Call Trace:
>   dump_stack+0x78/0xa0
>   __lock_acquire.cold+0x121/0x29f
>   ? btrfs_dio_iomap_end+0x65/0x130 [btrfs]
>   lock_acquire+0x93/0x3b0
>   ? btrfs_sync_file+0xf7/0x560 [btrfs]
>   down_write+0x33/0x70
>   ? btrfs_sync_file+0xf7/0x560 [btrfs]
>   btrfs_sync_file+0xf7/0x560 [btrfs]
>   iomap_dio_complete+0x10d/0x120
>   iomap_dio_rw+0x3c8/0x520
>   btrfs_direct_IO+0xd3/0x160 [btrfs]
>   btrfs_file_write_iter+0x1fe/0x630 [btrfs]
>   ? find_held_lock+0x2b/0x80
>   aio_write+0xcd/0x180
>   ? __might_fault+0x31/0x80
>   ? find_held_lock+0x2b/0x80
>   ? __might_fault+0x31/0x80
>   io_submit_one+0x4e1/0xb30
>   ? find_held_lock+0x2b/0x80
>   __x64_sys_io_submit+0x71/0x220
>   do_syscall_64+0x33/0x40
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>   RIP: 0033:0x7f5940881f79
>   Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e7 4e 0c 00 f7 d8 64 89 01 48
>   RSP: 002b:00007f5934f51d88 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
>   RAX: ffffffffffffffda RBX: 00007f5934f52680 RCX: 00007f5940881f79
>   RDX: 0000000000b56030 RSI: 0000000000000008 RDI: 00007f593171f000
>   RBP: 00007f593171f000 R08: 0000000000000000 R09: 0000000000b56030
>   R10: 00007fffd599e080 R11: 0000000000000246 R12: 0000000000000008
>   R13: 0000000000000000 R14: 0000000000b56030 R15: 0000000000b56070
> 
> This happens because iomap_dio_complete() calls into generic_write_sync()
> if we have the data-sync flag set. But as we're still under the
> inode_lock() from btrfs_file_write_iter() we will deadlock once
> btrfs_sync_file() tries to acquire the inode_lock().
> 
> Calling into generic_write_sync() is not needed as __btrfs_direct_write()
> already takes care of persisting the data on disk. We can temporarily drop
> the IOCB_DSYNC flag before calling into __btrfs_direct_write() so the
> iomap code won't try to call into the sync routines as well.
> 
> References: https://github.com/btrfs/fstests/issues/12
> Fixes: da4d7c1b4c45 ("btrfs: switch to iomap for direct IO")
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> ---
> Changes to RFC:
> - Re-apply IOCB_DSYNC before calling into generic_write_sync (Goldwyn)

This breaks DSYNC AIO, because we need it to run once we've done all the 
IO.  You hit the deadlock because the io all completed before we exited 
iomap_dio_rw(), but generally that won't happen, and so we need the 
DSYNC set for the last reference on the dio to actually run the ->fsync. 
  Thanks,

Josef
