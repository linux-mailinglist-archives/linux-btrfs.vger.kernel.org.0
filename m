Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582CF76D62E
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Aug 2023 19:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjHBR4D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 13:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjHBR4C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 13:56:02 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00471A3
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 10:56:00 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-55b8f1c930eso5064837eaf.3
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Aug 2023 10:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1690998960; x=1691603760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cSlWUP3NoXEYlOw6dsU11MyUECNNNxVF1CS8Wf9siTA=;
        b=pZmWlV/kZBqJE9zHY9OWJGZfO1XMBKUIoD/CxUui8NQieoaFmhdI9ZKd4Djik88XsA
         paR8sapFYkrRMV/dXDcxWXgko6Amaft+sBpSCSZOz1Y59W4kgWjo2ZpfXSTrjT0kjugN
         cmk/IsRbJeBx3FUuLKbZyOz2wUk0mjPybcoeUTsdQ9pIBpky2KL9auDXroS7DhqChmax
         zU+UWm0z2blE0965Ln5IWfhAFzFcOqonawRFB/znfCDhZWgfeyGyhd7dWlZFLnaXzG7K
         P4cbiZ7prWSWXvTmyVVYp3wNhQ6uLd4UFglhEqGx6HaasjErntq6rYVLTvlTn7q0EuuX
         UCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690998960; x=1691603760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSlWUP3NoXEYlOw6dsU11MyUECNNNxVF1CS8Wf9siTA=;
        b=Xkw3PNeNt9iPL9CL5n139mFbPl2tJjMZMG/Upq/Piozzn8kw92Gj67C3eZWzorw+J6
         KSXyWP+pZt6/CM9iXD2PhIdyykpqnNWi8VnBbp0WsMVeAb1V7v1W7BJDxrLTPuNkmQBI
         1bNC08Tu4c3RuQBnZFycFZMRzvE/bMwCnVThZQBE7AbiEOBdf8Mvs/Z22aglIjXpeMJ1
         FF5AH2LMmito9qDGY1mBeAVM8NQpbUp+gPyvUTyU4s//sSIlipL9mCxTCL7Dlnt+9JmL
         ThKDD3E+7sPzPuMegmfv9nTlqnCe3edTKtPAmdHiZHBYcrtodX4H7SsCgfrs4sGqvPRI
         KHoQ==
X-Gm-Message-State: ABy/qLaLCMZc2OQVqMr80R3xcghyuB+Bo5ldt4F0UqVqrjZWkYzosURe
        0f77zekEafWdXmtP49cIXB8fgA==
X-Google-Smtp-Source: APBJJlGFRROdE2tlKNiVl/HhxJa/NvpHz6StTgCp30WpRwEIrBpYfLqnE00NFZNS7WDi9xgbYYiT8g==
X-Received: by 2002:a05:6808:3029:b0:3a0:4636:d079 with SMTP id ay41-20020a056808302900b003a04636d079mr18942210oib.22.1690998960080;
        Wed, 02 Aug 2023 10:56:00 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x3-20020a814a03000000b0057d24f8278bsm4703894ywa.104.2023.08.02.10.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:55:59 -0700 (PDT)
Date:   Wed, 2 Aug 2023 13:55:58 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Sterba <dsterba@suse.cz>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: small writeback fixes v2
Message-ID: <20230802175558.GA2119916@perftesting>
References: <20230724132701.816771-1-hch@lst.de>
 <20230727170622.GH17922@twin.jikos.cz>
 <20230801152911.GA12035@lst.de>
 <20230802124956.GA2070826@perftesting>
 <20230802151643.GA2229@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802151643.GA2229@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 02, 2023 at 05:16:43PM +0200, Christoph Hellwig wrote:
> On Wed, Aug 02, 2023 at 08:49:56AM -0400, Josef Bacik wrote:
> > I ran this through the CI
> 
> Thanks a lot!
> 
> > [ 3461.147888] assertion failed: block_group->io_ctl.inode == NULL, in
> > fs/btrfs/block-group.c:4256
> 
> Hmm, this looks so unrelated that it leaves me puzzled.  How confident
> are you that this is a new issue based on the overall test setup?
> 
> > I also got an EBUSY trying to umount $SCRATCH_MNT with generic/475 with
> 
> > on an ARM machine with 64kib pagesize.  Though I'm pretty sure you're not to
> > blame for that last failure.  Thanks,
> 
> Yes, I've seen EBUSY in 475 quite regulary even without the changes,
> I think I also mentioned it in reply to the other 475-related discussion
> we had.  I tried to debug it for a while but didn't manage to get far.
> 

[  594.911885] ------------[ cut here ]------------
[  594.911892] WARNING: CPU: 1 PID: 1833 at fs/namespace.c:179
mnt_add_count+0xa4/0xb8
[  594.911897] Modules linked in: rfkill vfat fat virtio_net net_failover
virtio_balloon failover loop zram virtiofs fuse virtio_console virtio_blk
qemu_fw_cfg
[  594.911908] CPU: 1 PID: 1833 Comm: kworker/1:7 Tainted: G        W
6.5.0-rc3+ #31
[  594.911910] Hardware name: QEMU KVM Virtual Machine, BIOS
edk2-20230301gitf80f052277c8-26.fc38 03/01/2023
[  594.911911] Workqueue: events delayed_fput
[  594.911916] pstate: 21400005 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[  594.911918] pc : mnt_add_count+0xa4/0xb8
[  594.911920] lr : mnt_add_count+0x98/0xb8
[  594.911922] sp : ffff800093ea3c60
[  594.911923] x29: ffff800093ea3c60 x28: 0000000000000000 x27: 0000000000000000
[  594.911926] x26: ffff6b947f39d505 x25: ffffbdbf2bd9b1c8 x24: ffff6b9459997d40
[  594.911929] x23: ffff6b9456365728 x22: cd9fbdbf29b30b60 x21: ffff800093ea3ce8
[  594.911931] x20: ffff6b94596af5c0 x19: 00000000ffffffff x18: 0000000000003f75
[  594.911934] x17: 0000000000000000 x16: 0000000000000000 x15: ffff6b94497dc000
[  594.911936] x14: 0000000000000000 x13: 0000000000000030 x12: 0000000000000000
[  594.911939] x11: ffffbdbf32e69204 x10: ffffbdbf2b6dae50 x9 : ffffbdbf2f49f000
[  594.911942] x8 : ffff800093ea3c08 x7 : 0000000000000000 x6 : 00000000000fffff
[  594.911944] x5 : 00000000002b60c6 x4 : ffff6b94405716c0 x3 : ffff6b94405716c0
[  594.911947] x2 : ffffadd553c90000 x1 : ffff6b9441625900 x0 : 0000000060001020
[  594.911949] Call trace:
[  594.911950]  mnt_add_count+0xa4/0xb8
[  594.911952]  mntput_no_expire+0x88/0x4e0
[  594.911955]  mntput+0x28/0x48
[  594.911957]  __fput+0x134/0x2a0
[  594.911960]  delayed_fput+0x4c/0x68
[  594.911964]  process_one_work+0x290/0x5e0
[  594.911967]  worker_thread+0x7c/0x428
[  594.911970]  kthread+0x124/0x130
[  594.911972]  ret_from_fork+0x10/0x20
[  594.911974] irq event stamp: 27982
[  594.911975] hardirqs last  enabled at (27981): [<ffffbdbf2982162c>]
__call_rcu_common.constprop.0+0x16c/0x680
[  594.911980] hardirqs last disabled at (27982): [<ffffbdbf2a7642e4>]
el1_dbg+0x24/0x90
[  594.911984] softirqs last  enabled at (24348): [<ffffbdbf2a4d8650>]
neigh_managed_work+0xd8/0xf8
[  594.911989] softirqs last disabled at (24344): [<ffffbdbf2a4d85a8>]
neigh_managed_work+0x30/0xf8
[  594.911993] ---[ end trace 0000000000000000 ]---

So it's the delayed fput thing that we already know about.  I talked to Jens and
he's on his way to a fix but isn't there yet.

I'll drop a patch in our fstests to just umount in a loop, this test uncovers
lots of things so I don't want to exclude it from the CI runs.  I'll go look at
the other failures now.  Thanks,

Josef
