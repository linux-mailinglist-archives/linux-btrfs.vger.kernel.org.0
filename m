Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECE964CF2C
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Dec 2022 19:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238864AbiLNSIW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Dec 2022 13:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238693AbiLNSID (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Dec 2022 13:08:03 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9AF24BDB
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Dec 2022 10:08:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DE7652018D;
        Wed, 14 Dec 2022 18:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671041280;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JTy4hBqgDxh7Cl0Uwv/uCLYPADUBftFXo7DjljYQlRo=;
        b=J+0Kq3I7xaQamvMFekByhpcFa17YnZaKQL/hyvNIJ7yIJJggXLRsd97ocZcaTCUNih7ZHc
        lddT/aXkpI3a6zchIqT7oq/ahlJBpBOowmYXQKTlLGI+v2lpjzf/wu1OXhe/CfvYET8w4g
        dhouqmr135NM1Qh1M84g9rP+fDX1Mn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671041280;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JTy4hBqgDxh7Cl0Uwv/uCLYPADUBftFXo7DjljYQlRo=;
        b=IlmDxf2AqbD5BVAZEUAzMQMKfiGvQBYx3adiijfFUZBBdFR6jNTYMaxAccmYpziu7HPR38
        2xZeylHAV6GS/aAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF216138F6;
        Wed, 14 Dec 2022 18:08:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2WiFLQARmmP7HwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 14 Dec 2022 18:08:00 +0000
Date:   Wed, 14 Dec 2022 19:07:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     robbieko <robbieko@synology.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] btrfs: fix unexpected -ENOMEM with
 percpu_counter_init when create snapshot
Message-ID: <20221214180718.GF10499@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221214021125.28289-1-robbieko@synology.com>
 <Y5oA3qBk+qMSyAR/@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y5oA3qBk+qMSyAR/@localhost.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 14, 2022 at 11:59:10AM -0500, Josef Bacik wrote:
> On Wed, Dec 14, 2022 at 10:11:22AM +0800, robbieko wrote:
> > From: Robbie Ko <robbieko@synology.com>
> > 
> > [Issue]
> > When creating subvolume/snapshot, the transaction may be abort due to -ENOMEM
> > 
> >   WARNING: CPU: 1 PID: 411 at fs/btrfs/transaction.c:1937 create_pending_snapshot+0xe30/0xe70 [btrfs]()
> >   CPU: 1 PID: 411 Comm: btrfs Tainted: P O 4.4.180+ #42661
> >   Call Trace:
> >     create_pending_snapshot+0xe30/0xe70 [btrfs]
> >     create_pending_snapshots+0x89/0xb0 [btrfs]
> >     btrfs_commit_transaction+0x469/0xc60 [btrfs]
> >     btrfs_mksubvol+0x5bd/0x690 [btrfs]
> >     btrfs_mksnapshot+0x102/0x170 [btrfs]
> >     btrfs_ioctl_snap_create_transid+0x1ad/0x1c0 [btrfs]
> >     btrfs_ioctl_snap_create_v2+0x102/0x160 [btrfs]
> >     btrfs_ioctl+0x2111/0x3130 [btrfs]
> >     do_vfs_ioctl+0x7ea/0xa80
> >     SyS_ioctl+0xa1/0xb0
> >     entry_SYSCALL_64_fastpath+0x1e/0x8e
> >   ---[ end trace 910c8f86780ca385 ]---
> >   BTRFS: error (device dm-2) in create_pending_snapshot:1937: errno=-12 Out of memory
> > 
> > [Cause]
> > During creating a subvolume/snapshot, it is necessary to allocate memory for Initializing fs root.
> > Therefore, it can only use GFP_NOFS to allocate memory to avoid deadlock issues.
> > However, atomic allocation is required when processing percpu_counter_init
> > without GFP_KERNEL due to the unique structure of percpu_counter.
> > In this situation, allocating memory for initializing fs root may cause
> > unexpected -ENOMEM when free memory is low and causes btrfs transaction to abort.
> > 
> > [Fix]
> > We allocate memory at the beginning of creating a subvolume/snapshot.
> > This way, we can ensure the memory is enough when initializing fs root.
> > Even -ENOMEM happens at the beginning of creating a subvolume/snapshot,
> > the transaction won’t abort since it hasn’t started yet.
> 
> Honestly I'd rather just make the btrfs_drew_lock use an atomic_t for the
> writers counter as well.  This is only taken in truncate an nocow writes, and in
> nocow writes there are a looooot of slower things that have to be done that
> we're not winning a lot with the percpu counter.  Is there any reason not to
> just do that and leave all this code alone?  Thanks,

The percpu counter for writers is there since the original commit
8257b2dc3c1a1057 "Btrfs: introduce btrfs_{start, end}_nocow_write() for
each subvolume". The reason could be to avoid hammering the same
cacheline from all the readers but then the writers do that anyway.
This happens in context related to IO or there's some waiting anyway, so
yeah using atomic for writers should be ok as well.
