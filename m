Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F1076CD8A
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Aug 2023 14:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbjHBMu6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 08:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbjHBMuk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 08:50:40 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235A230F7
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 05:50:10 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-583d63ca1e9so75689437b3.1
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Aug 2023 05:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1690980598; x=1691585398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EHkfF1qP2cSNUlcPNaVefL9Hw9nGDolSMsMnF7DzXt8=;
        b=xPLzlbzhdgByLTNoKFRz3RVoJ1bJPBmjqNqpju4WpZEeeCKApkwzYn3bWDKdR5huXl
         KPdp2tmDPAtfZ/YaYNp7hhVM7h48GrO1wQ8Lynd77gznFgMRHuuWUls9WZX8u/qF4NUd
         RAJ8XWgIHdvznX7tBelKegZG7xcurfyyrarmDlNlKlhQS00+Vpe52QMjcDZ4x5BMyoxE
         uYOHLM5xD2AufLJ2r5SSOospSgXatY2bJJh/cMBY5YkSmAvOb9qTr5nPyHjMFk2CDic0
         soJ5lARn1ka7zD4Uas+57YgR19tbW0ZnBh2ZzT2mNzcF+06+l3/JZRp38DkyNNqVb6+P
         H1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690980598; x=1691585398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHkfF1qP2cSNUlcPNaVefL9Hw9nGDolSMsMnF7DzXt8=;
        b=azpO2P20+FatpG8K4lqa6mWx9LkO6pgC6FW9jC68ht0MGyRaXGXiSqXpN+Teuiy63e
         FdLykrtWALLn+2+345Jfz6l5wrofSIIAZhjU4v9i7x7iC7opy+zL5geG4tkGtRPdDTBz
         SM2JgZhPPYNHay9FMe5PqeJU3HLjp7a0D1SlpDqEOED/Y1Km2GBBiLmwW11MbWn6djyJ
         EevDlKqw/UnTkaBKJdye7JEYD97EIXkjwqFsqqCtsT/Uu4VfAc/kGGvHS3g7igK4/QwR
         VpUKamgwvOGitdFTk1rJa66RhelMPCZ/Drc7gd/Z9Pvj0ORGOARTAKyyhs/vFsZHjmpH
         jUZA==
X-Gm-Message-State: ABy/qLZMmnhth7yxEeu+JHpANtY2CLR0gqofbsrEg5RTM4Ai9e89mhJz
        soH8+YqTXBGjLg0cZ5o6F0TefA==
X-Google-Smtp-Source: APBJJlF0LBcAGOsjIvduAW71UGoIC2x10qmP1/cAL+jyKaptIYrV8Y9sAxtvESDIXHEFHfht+j10Ig==
X-Received: by 2002:a81:7557:0:b0:57a:89b1:2c73 with SMTP id q84-20020a817557000000b0057a89b12c73mr14776150ywc.5.1690980598425;
        Wed, 02 Aug 2023 05:49:58 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m128-20020a0dfc86000000b005732b228a83sm4504579ywf.140.2023.08.02.05.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 05:49:57 -0700 (PDT)
Date:   Wed, 2 Aug 2023 08:49:56 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Sterba <dsterba@suse.cz>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: small writeback fixes v2
Message-ID: <20230802124956.GA2070826@perftesting>
References: <20230724132701.816771-1-hch@lst.de>
 <20230727170622.GH17922@twin.jikos.cz>
 <20230801152911.GA12035@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801152911.GA12035@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 01, 2023 at 05:29:11PM +0200, Christoph Hellwig wrote:
> On Thu, Jul 27, 2023 at 07:06:22PM +0200, David Sterba wrote:
> > On Mon, Jul 24, 2023 at 06:26:52AM -0700, Christoph Hellwig wrote:
> > > Hi all,
> > > 
> > > this series has various fixes for bugs found in inspect or only triggered
> > > with upcoming changes that are a fallout from my work on bound lifetimes
> > > for the ordered extent and better confirming to expectations from the
> > > common writeback code.
> > 
> > I've so far merged patches 1-3, the rest will be in for-next as it's
> > quite risky and I'd appreciate more reviews.
> 
> So who would be a suitable reviewer for this code in addition to Josef?
> 
> Any volunteers?

I ran this through the CI and I got a deadlock on generic/476 with

[btrfs_block_group_tree]
TEST_DIR=/mnt/test
TEST_DEV=/dev/vdb
SCRATCH_DEV_POOL="/dev/vdc /dev/vdd /dev/vde /dev/vdg /dev/vdh /dev/vdi
/dev/vdj"
SCRATCH_MNT=/mnt/scratch
LOGWRITES_DEV=/dev/vdk
MKFS_OPTIONS="-K -O block-group-tree"
RECREATE_TEST_DEV=true

I got a panic with btrfs/190 with the following config

[btrfs_holes_spacecache]
TEST_DIR=/mnt/test
TEST_DEV=/dev/vdb
SCRATCH_DEV_POOL="/dev/vdc /dev/vdd /dev/vde /dev/vdg /dev/vdh /dev/vdi /dev/vdj"
SCRATCH_MNT=/mnt/scratch
LOGWRITES_DEV=/dev/vdk
MKFS_OPTIONS="-K -O ^no-holes,^free-space-tree"
RECREATE_TEST_DEV=true

[ 3461.147888] assertion failed: block_group->io_ctl.inode == NULL, in
fs/btrfs/block-group.c:4256
[ 3461.148437] ------------[ cut here ]------------
[ 3461.148632] kernel BUG at fs/btrfs/block-group.c:4256!
[ 3461.148857] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[ 3461.149073] CPU: 1 PID: 887651 Comm: umount Not tainted 6.5.0-rc3+ #1
[ 3461.149344] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
edk2-20230301gitf80f052277c8-26.fc38 03/01/2023
[ 3461.149772] RIP: 0010:btrfs_put_block_group_cache+0x136/0x140
[ 3461.150015] Code: 02 00 00 00 e8 8b 37 18 00 eb 88 b9 a0 10 00 00 48 c7 c2 7a
d9 aa 8f 48 c7 c6 98 af b5 8f 48 c7 c7 20 e1 b4 8f e8 3a c0 a7 ff <0f> 0b 0f 1f
84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90
[ 3461.150776] RSP: 0018:ffffaac483f6fcc0 EFLAGS: 00010246
[ 3461.150997] RAX: 0000000000000053 RBX: ffff99b414118000 RCX: 0000000000000000
[ 3461.151287] RDX: 0000000000000000 RSI: ffff99b47bd21840 RDI: ffff99b47bd21840
[ 3461.151769] RBP: ffff99b462afdc60 R08: 0000000000000000 R09: ffffaac483f6fb60
[ 3461.152082] R10: 0000000000000003 R11: ffffffff905553d0 R12: ffff99b414118010
[ 3461.152384] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
[ 3461.152682] FS:  00007f43ff0c2800(0000) GS:ffff99b47bd00000(0000)
knlGS:0000000000000000
[ 3461.153007] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3461.153244] CR2: 000055a37df5c360 CR3: 000000017896a000 CR4: 0000000000350ee0
[ 3461.153549] Call Trace:
[ 3461.153657]  <TASK>
[ 3461.153752]  ? die+0x36/0x90
[ 3461.153885]  ? do_trap+0xda/0x100
[ 3461.154027]  ? btrfs_put_block_group_cache+0x136/0x140
[ 3461.154241]  ? btrfs_put_block_group_cache+0x136/0x140
[ 3461.154462]  ? do_error_trap+0x81/0x110
[ 3461.154631]  ? btrfs_put_block_group_cache+0x136/0x140
[ 3461.154952]  ? exc_invalid_op+0x50/0x70
[ 3461.155116]  ? btrfs_put_block_group_cache+0x136/0x140
[ 3461.155348]  ? asm_exc_invalid_op+0x1a/0x20
[ 3461.155533]  ? btrfs_put_block_group_cache+0x136/0x140
[ 3461.155748]  close_ctree+0x1da/0x600
[ 3461.155901]  ? fsnotify_sb_delete+0x16c/0x210
[ 3461.156088]  ? evict_inodes+0x169/0x1d0
[ 3461.156251]  generic_shutdown_super+0x80/0x150
[ 3461.156451]  kill_anon_super+0x18/0x30
[ 3461.156610]  btrfs_kill_super+0x16/0x20
[ 3461.156774]  deactivate_locked_super+0x33/0xa0
[ 3461.156963]  cleanup_mnt+0xba/0x150
[ 3461.157123]  task_work_run+0x5d/0xa0
[ 3461.157284]  exit_to_user_mode_prepare+0x23f/0x250
[ 3461.157505]  syscall_exit_to_user_mode+0x1a/0x50
[ 3461.157702]  do_syscall_64+0x6c/0x90
[ 3461.157856]  ? lockdep_hardirqs_on_prepare+0xe0/0x190
[ 3461.158101]  ? do_syscall_64+0x6c/0x90
[ 3461.158259]  ? do_user_addr_fault+0x293/0x840
[ 3461.158461]  ? trace_hardirqs_off+0x46/0xa0
[ 3461.158636]  ? exc_page_fault+0xf5/0x200
[ 3461.158800]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8

I also got an EBUSY trying to umount $SCRATCH_MNT with generic/475 with

[btrfs_subpage_compress]
TEST_DIR=/mnt/test
TEST_DEV=/dev/vdb
SCRATCH_DEV_POOL="/dev/vdc /dev/vdd /dev/vde /dev/vdg /dev/vdh /dev/vdi
/dev/vdj"
SCRATCH_MNT=/mnt/scratch
LOGWRITES_DEV=/dev/vdk
MKFS_OPTIONS="-K -n 4k -s 4k"
MOUNT_OPTIONS="-o compress"
RECREATE_TEST_DEV=true

on an ARM machine with 64kib pagesize.  Though I'm pretty sure you're not to
blame for that last failure.  Thanks,

Josef
