Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5816338DB62
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 May 2021 16:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhEWOPN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 May 2021 10:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbhEWOPM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 May 2021 10:15:12 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C01C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 23 May 2021 07:13:45 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id o27so24619188qkj.9
        for <linux-btrfs@vger.kernel.org>; Sun, 23 May 2021 07:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=mF1IybbtNFe+kQUurWv2ye5WFWDdYm2TrvoDTtG6ytY=;
        b=vsr/EZEBbNJu3Grcd4CDaiqZ2Gh2Ab6k9Kxqq1Wg1CdBJ5sIE90u4vabzPXPaQNrC2
         dyf4o7ecEhfOtlI9r2/dkHnTpD8+r3UA8iK17bOHtEsR0fk3rOCk0KfYZi8BKlCENlkk
         MPj2NPayvtwR58fMOORZilWVK6ZEFnl8kvbtRto27qOW/7xfMd3gsTYQYDulTJbIitdr
         oNm0xSRB8oN0/TOyEMSQezeX/hq2QM034sXwIcJL6aUIDtv2Lj3aLW6vlYxs7wCfBpLh
         szBLD+NpCHvoKYi6p2gGDEMMNilg6ugjrrxQhNp8+k1OnXRCvoGZGc8oGqE640Hec8vq
         sp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mF1IybbtNFe+kQUurWv2ye5WFWDdYm2TrvoDTtG6ytY=;
        b=spbNTqYnFpSi3KlVSvS3qKDGFulzrpDMpgPC6PMwVzmA+7sZpnlDUB4E7cmE4ZuXcT
         PiSH3wPlZRWXcYdoWMzG/Yr0O2gjZ9lueIpZ7j4IUb8P0IMhlPF3acHzm60NIow1/R38
         TECQIHdSUL7+RCgpJcnOECev+1wUZPV4UCpYSdHDC+Ssek0SMzs29lyyjtu0HfJrWTgh
         ExYgB3Gn80jH3GsYwNdp9MlR7Jvjdno6G9ZtQQUdDIys6BOS4K5ydwwWrmSH4Bt7PsWl
         W1P+FD32H+wbqQm417J3mtr2c/AjynhCgWU6KEr74V0odTxPEQ2lEvICf8vJZ2AyJoG7
         kPLA==
X-Gm-Message-State: AOAM531UNYo0eQI1DjR9UHZInJJaLS5wKiwrydlKi973JqcVa+a2s1zA
        goIQFtq5qIquKB58rfB+6rhfTkTjENmmdw==
X-Google-Smtp-Source: ABdhPJzbh5RZd3cQ9sqtZQcVyFbol0Wf2J/2CvHswHU62t3mO2KgqJGvKpXvkKCeFUe50cOcI3D8EQ==
X-Received: by 2002:a05:620a:951:: with SMTP id w17mr22609976qkw.50.1621779224194;
        Sun, 23 May 2021 07:13:44 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d1::1067? ([2620:10d:c091:480::1:7444])
        by smtp.gmail.com with ESMTPSA id q7sm9023291qki.17.2021.05.23.07.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 May 2021 07:13:43 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] btrfs: zoned: fix compressed writes
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1621351444.git.johannes.thumshirn@wdc.com>
 <1220142568f5b5f0d06fbc3ee28a08060afc0a53.1621351444.git.johannes.thumshirn@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <563c1ac3-abf3-3f60-dbdf-362ebc69eb28@toxicpanda.com>
Date:   Sun, 23 May 2021 10:13:40 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <1220142568f5b5f0d06fbc3ee28a08060afc0a53.1621351444.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/18/21 11:40 AM, Johannes Thumshirn wrote:
> When multiple processes write data to the same block group on a compressed
> zoned filesystem, the underlying device could report I/O errors and data
> corruption is possible.
> 
> This happens because on a zoned file system, compressed data writes where
> sent to the device via a REQ_OP_WRITE instead of a REQ_OP_ZONE_APPEND
> operation. But with REQ_OP_WRITE and parallel submission it cannot be
> guaranteed that the data is always submitted aligned to the underlying
> zone's write pointer.
> 
> The change to using REQ_OP_ZONE_APPEND instead of REQ_OP_WRITE on a zoned
> filesystem is non intrusive on a regular file system or when submitting to
> a conventional zone on a zoned filesystem, as it is guarded by
> btrfs_use_zone_append.
> 
> Reported-by: David Sterba <dsterba@suse.com>
> Fixes: 9d294a685fbc ("btrfs: zoned: enable to mount ZONED incompat flag")
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

This one is causing panics with btrfs/027 with -o compress.  I bisected it to 
something else earlier, but it was still happening today and I bisected again 
and this is what popped out.  I also went the extra step to revert the patch as 
I have already fucked this up once, and the problem didn't re-occur with this 
patch reverted.  The panic looks like this

May 22 00:33:16 xfstests2 kernel: BTRFS critical (device dm-9): mapping failed 
logical 22429696 bio len 53248 len 49152
May 22 00:33:16 xfstests2 kernel: ------------[ cut here ]------------
May 22 00:33:16 xfstests2 kernel: kernel BUG at fs/btrfs/volumes.c:6643!
May 22 00:33:16 xfstests2 kernel: invalid opcode: 0000 [#1] SMP NOPTI
May 22 00:33:16 xfstests2 kernel: CPU: 1 PID: 2236088 Comm: kworker/u4:4 Not 
tainted 5.13.0-rc2+ #240
May 22 00:33:16 xfstests2 kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 
2009), BIOS 1.13.0-2.fc32 04/01/2014
May 22 00:33:16 xfstests2 kernel: Workqueue: btrfs-delalloc btrfs_work_helper
May 22 00:33:16 xfstests2 kernel: RIP: 0010:btrfs_map_bio.cold+0x58/0x5a
May 22 00:33:16 xfstests2 kernel: Code: 50 e8 6b 83 ff ff e8 5b 0d 88 ff 48 83 
c4 18 e9 94 8f 88 ff 48 8b 3c 24 4c 89 f1 4c 89 fa 48 c7 c6 f8 db 62 96 e8 47 83 
ff ff <0f> 0b 4c 89 e7 e8 52 1f 83 ff e9 03 98 88 ff 49 8b 7a 50 44 89 f2
May 22 00:33:16 xfstests2 kernel: RSP: 0018:ffffb310c1de7c88 EFLAGS: 00010282
May 22 00:33:16 xfstests2 kernel: RAX: 0000000000000055 RBX: 0000000000000000 
RCX: 0000000000000000
May 22 00:33:16 xfstests2 kernel: RDX: ffff9b9a7bd27540 RSI: ffff9b9a7bd18e10 
RDI: ffff9b9a7bd18e10
May 22 00:33:16 xfstests2 kernel: RBP: ffff9b9a482ad7f8 R08: 0000000000000000 
R09: 0000000000000000
May 22 00:33:16 xfstests2 kernel: R10: ffffb310c1de7a48 R11: ffffffff96973748 
R12: 0000000000000000
May 22 00:33:16 xfstests2 kernel: R13: ffff9b9a001e7300 R14: 000000000000d000 
R15: 0000000001564000
May 22 00:33:16 xfstests2 kernel: FS:  0000000000000000(0000) 
GS:ffff9b9a7bd00000(0000) knlGS:0000000000000000
May 22 00:33:16 xfstests2 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
May 22 00:33:16 xfstests2 kernel: CR2: 00005621fe4566e0 CR3: 000000013943a005 
CR4: 0000000000370ee0
May 22 00:33:16 xfstests2 kernel: Call Trace:
May 22 00:33:16 xfstests2 kernel:  btrfs_submit_compressed_write+0x2d7/0x470
May 22 00:33:16 xfstests2 kernel:  submit_compressed_extents+0x364/0x420
May 22 00:33:16 xfstests2 kernel:  ? lock_acquire+0x15d/0x380
May 22 00:33:16 xfstests2 kernel:  ? lock_release+0x1cd/0x2a0
May 22 00:33:16 xfstests2 kernel:  ? submit_compressed_extents+0x420/0x420
May 22 00:33:16 xfstests2 kernel:  btrfs_work_helper+0x133/0x520
May 22 00:33:16 xfstests2 kernel:  process_one_work+0x26b/0x570
May 22 00:33:16 xfstests2 kernel:  worker_thread+0x55/0x3c0
May 22 00:33:16 xfstests2 kernel:  ? process_one_work+0x570/0x570
May 22 00:33:16 xfstests2 kernel:  kthread+0x134/0x150
May 22 00:33:16 xfstests2 kernel:  ? __kthread_bind_mask+0x60/0x60
May 22 00:33:16 xfstests2 kernel:  ret_from_fork+0x1f/0x30

Thanks,

Josef
