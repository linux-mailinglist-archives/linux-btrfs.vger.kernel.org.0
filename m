Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 981AA1008B4
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 16:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfKRPwS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 10:52:18 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:39418 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfKRPwS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 10:52:18 -0500
Received: by mail-qv1-f67.google.com with SMTP id v16so6727509qvq.6
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 07:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:message-id:mime-version:content-disposition;
        bh=ZX8GRZwvIkzHe3HwjKZFUPtFQpgNeqGaW1u+t6wWxYM=;
        b=gAyNN4AUTF5BZkFMPniM8jmbhFB7B8Tk+hguuDpvh+od1pHRjRyflh8VVwCNcJ4K5B
         VUHtURXRMSNEzXt4jmbAuke3boDjTGPkuoGHyFT45wq9Dq9Sy2wJC3SCZeETzwZ5XLXy
         GXbO7FtEKi7SbXNJH4MYfCQHbaShO4s2c6KrAxRIxCcgzCV0Zxr/RTD5uNh5E743OTco
         0LE8JYwyfPQRwSTX2vFJAvFYUZsc/DUl88cppqgNYeR5mFxndVIOhBktds7BcXceQdBR
         ECf8BSfHFGfSGp/cD/xEbzEqPUylRo5uM3cJBqPmRdUi5DBk6xnIojXIILENYIsizGWn
         WjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:mime-version
         :content-disposition;
        bh=ZX8GRZwvIkzHe3HwjKZFUPtFQpgNeqGaW1u+t6wWxYM=;
        b=UMEMw4zWXQYDbT8PETYpwbmleldTUnbxvYi5ehsUda/GnwdLN8UHCpbqexWQvria2l
         lNoDVC2H2TlkmNlXPKTHxYwJU3nX706vr/kH00nCWX5lHuUqSMb4fM6VUmIki1A/Svth
         Ife7lvNoTL95aiSRs6AQOcw6ILiRr2wWBnLMrf/9ZqrvcH9PuoMWx5VG6wl++xWg3XoS
         fwUAM8WTOl2G2gZruaWArMovVIpvdvsm4QLphQFTCkO1IGGDCtdcSEvw1sHoxcWemIXC
         YOa9da03S7tBJNKwmxOr0PDxwe+lwvuQOVJWed24FjqveWMzkLkmh23dcHTPbS0dQyqd
         a7Lg==
X-Gm-Message-State: APjAAAWsGgDX7PnTCKeEJ+Dlp7/cqLVip0VLnvu+2NBog3pR7rNp7J9+
        FPISA6krO4CpFG7zL2izjTn4uQ==
X-Google-Smtp-Source: APXvYqwu0CfnG5zKStHVWOu7MqxwxZE6CJ8VI/DBZJqt7fLLlj2tZ8FE9eZF11NHqwJ8HJHJV9uO+g==
X-Received: by 2002:a0c:9956:: with SMTP id i22mr26565866qvd.215.1574092336740;
        Mon, 18 Nov 2019 07:52:16 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::9492])
        by smtp.gmail.com with ESMTPSA id c128sm8749021qkg.124.2019.11.18.07.52.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 07:52:15 -0800 (PST)
Date:   Mon, 18 Nov 2019 10:52:14 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <20191118155214.vetvcczw7f4tdqmq@macbook-pro-91.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Remove extent_map::bdev
Reply-To:
In-Reply-To: <20191118154903.GK3001@twin.jikos.cz>

On Mon, Nov 18, 2019 at 04:49:03PM +0100, David Sterba wrote:
> On Mon, Nov 18, 2019 at 10:41:54AM -0500, Josef Bacik wrote:
> > On Mon, Oct 07, 2019 at 09:37:40PM +0200, David Sterba wrote:
> > > The extent_map::bdev is unused and and can be removed, but it's not
> > > straightforward so there are several steps. The first patch decouples
> > > bdev from map_lookup. The remaining patches clean up use of the bdev,
> > > removing a few bio_set_dev on the way. In the end, submit_extent_page is
> > > one parameter lighter.
> > > 
> > > This has survived several fstests runs
> > > 
> > > David Sterba (5):
> > >   btrfs: assert extent_map bdevs and lookup_map and split
> > >   btrfs: get bdev from latest_dev for dio bh_result
> > >   btrfs: drop bio_set_dev where not needed
> > >   btrfs: remove extent_map::bdev
> > >   btrfs: drop bdev argument from submit_extent_page
> > > 
> > >  fs/btrfs/compression.c | 10 ----------
> > >  fs/btrfs/disk-io.c     |  3 ---
> > >  fs/btrfs/extent_io.c   | 15 +++------------
> > >  fs/btrfs/extent_map.c  |  6 +++++-
> > >  fs/btrfs/extent_map.h  | 11 ++---------
> > >  fs/btrfs/file-item.c   |  1 -
> > >  fs/btrfs/file.c        |  3 ---
> > >  fs/btrfs/inode.c       | 14 ++++----------
> > >  fs/btrfs/relocation.c  |  2 --
> > >  9 files changed, 14 insertions(+), 51 deletions(-)
> > > 
> > 
> > This series needs to be dropped from misc-next, it causes any box with cgroups
> > enabled to crash on boot.  The bio requires having a bio->bi_disk set when we do
> > wbc_init_bio, which we no longer have with this patch.
> 
> Do you have the stack trace of the crash?

BUG: kernel NULL pointer dereference, address: 00000000000002e8
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
SMP
CPU: 28 PID: 450 Comm: kworker/u113:2 Kdump: loaded Not tainted 5.4.0-rc8-00363-gccfa4291f746-dirty #694
Workqueue: writeback wb_workfn (flush-btrfs-1)
RIP: 0010:bio_associate_blkg_from_css+0x11/0xf0
RSP: 0018:ffffc9000e07f910 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000001000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff88bfd41da800 RDI: ffff88bfd41da800
RBP: ffff889ff6795ab0 R08: 00000000ffffefff R09: 0000000000000000
R10: 000000000002cd40 R11: ffff88a07fffdd00 R12: ffffc9000e07fc70
R13: ffff889ff6795ab0 R14: 0000000000000000 R15: ffff889fbd8c0048
FS:  0000000000000000(0000) GS:ffff889fff780000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000002e8 CR3: 0000000002409006 CR4: 00000000003606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 submit_extent_page+0x11d/0x1c0
 __extent_writepage_io+0x301/0x460
 ? end_extent_writepage+0x90/0x90
 __extent_writepage+0xd3/0x280
 extent_write_cache_pages+0x290/0x410
 extent_writepages+0x51/0xa0
 do_writepages+0x17/0x70
 __writeback_single_inode+0x3d/0x320
 writeback_sb_inodes+0x23b/0x470
 __writeback_inodes_wb+0x87/0xb0
 wb_writeback+0x266/0x300
 wb_workfn+0x19d/0x450
 process_one_work+0x154/0x350
 worker_thread+0x46/0x3c0
 kthread+0xf5/0x130
 ? process_one_work+0x350/0x350
 ? kthread_bind+0x10/0x10
