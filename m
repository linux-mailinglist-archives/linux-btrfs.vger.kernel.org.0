Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F2565B3AB
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jan 2023 16:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjABPA0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Jan 2023 10:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235937AbjABO74 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Jan 2023 09:59:56 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974B865EB
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Jan 2023 06:59:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 475F55C166;
        Mon,  2 Jan 2023 14:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672671594;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=efJ9CeSA8kcW1QNC/4qoVK8tOrFwpb/wViimPmKM5/Q=;
        b=V/SYh82AMRtGN/eni+ua/F5nnCO601uRE7TfH+sr+xUeV2OnFY/iGDWWg9TJFS2TokSzBx
        CAOetpFV7J/BAoC7p1Okv4aHHNLS+YH/tGe5IQ0dEFq6VYtXYwy4lRKZbHn/Bp5TiKdnVx
        V4mbJFXRre0XKrRVtZebIPKpVnI8yts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672671594;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=efJ9CeSA8kcW1QNC/4qoVK8tOrFwpb/wViimPmKM5/Q=;
        b=eX0yjqWcH0FjzfBM5D4ET/LQzUQBE8Jke7nbFBwcNeMZEoimmpI7NTpe5L769huPHDBudO
        aeYy5LCsC4nN5PBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 10BA313427;
        Mon,  2 Jan 2023 14:59:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pjIkA2rxsmMxWwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 02 Jan 2023 14:59:54 +0000
Date:   Mon, 2 Jan 2023 15:54:24 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Wang Yugui <wangyugui@e16-tech.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: don't trigger BUG_ON() when repair happens with
 dev-replace
Message-ID: <20230102145424.GD11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <e6bd27828dfa486ff27e39db13b662e06d71ec74.1672534935.git.wqu@suse.com>
 <20230102112600.8869.409509F4@e16-tech.com>
 <8fcf8963-7077-21dd-2b87-976014533c7c@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fcf8963-7077-21dd-2b87-976014533c7c@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 02, 2023 at 12:08:01PM +0800, Qu Wenruo wrote:
> On 2023/1/2 11:26, Wang Yugui wrote:
> >> [BUG]
> >> There is a bug report that a BUG_ON() in btrfs_repair_io_failure()
> >> (originally repair_io_failure() in v6.0 kernel) got triggered when
> >> replacing a unreliable disk:
> > 
> > It seems a good test case that we could add to fstests.
> > 
> > Is there any reproducer already?
> > corrence of scrub and dev-replace ? still fail to reproduce it here.
> 
> It's not that simple, and you need to understand the workflow before 
> crafting a script.
> 
> It needs several things to happen at the same time:
> 
> - The corruption happens at the last mirror.
>    This can be done manually, but I doubt if it's reliable for a test
>    case.
> 
>    As the new data chunks can easily switch their devices:
> 
>    	item 4 key (FIRST_CHUNK_TREE CHUNK_ITEM 298844160) itemoff 15751 
> itemsize 112
> 		length 1073741824 owner 2 stripe_len 65536 type DATA|RAID1
> 		io_align 65536 io_width 65536 sector_size 4096
> 		num_stripes 2 sub_stripes 1
> 			stripe 0 devid 1 offset 298844160
> 			dev_uuid b31e1749-24d3-41f0-89fb-5d07630938c7
> 			stripe 1 devid 2 offset 277872640
> 			dev_uuid 29c2b4a0-4417-4a3c-b312-c0ac226d35cf
> 	item 5 key (FIRST_CHUNK_TREE CHUNK_ITEM 1372585984) itemoff 15639 
> itemsize 112
> 		length 1073741824 owner 2 stripe_len 65536 type DATA|RAID1
> 		io_align 65536 io_width 65536 sector_size 4096
> 		num_stripes 2 sub_stripes 1
> 			stripe 0 devid 2 offset 1351614464
> 			dev_uuid 29c2b4a0-4417-4a3c-b312-c0ac226d35cf
> 			stripe 1 devid 1 offset 1372585984
> 			dev_uuid b31e1749-24d3-41f0-89fb-5d07630938c7
> 
> 
> - The corrupted device still needs to be recognized
> 
> - Dev-replace must be running, and has not yet reach the corrupted
>    mirror
> 
> - A read on that corrupted mirror happened
> 
> The last two conditions are already very hard to trigger.
> 
> > 
> > local reproducer:
> > dev1=/dev/sdb2
> > dev2=/dev/sdb3
> > dev3=/dev/sdb4
> > 
> > mkfs.btrfs -f -m raid1 -d raid1 $dev1 $dev2
> > mount $dev1 /mnt/scratch/
> > dd if=/dev/urandom bs=1M count=2K of=/mnt/scratch/r.txt
> 
> This would create extra data stripes, but it won't ensure that devid 1 
> is going to mirror 2.
> 
> It may or may not depending on the chunk layout, and I'd say it's a 
> little random.

Right it's hard to reproduce and not possible to be done reliably but
could we do a series of the case with different timeouts or sleeps
in between? This could catch some cases, we have various testing setups
so I think it would pop up eventually. Once a problem like this is hit
it's not hard to find the reason and fix.
