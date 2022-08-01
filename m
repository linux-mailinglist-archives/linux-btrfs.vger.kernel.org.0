Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6335E5870AC
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Aug 2022 21:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbiHATAs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Aug 2022 15:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiHATAj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 Aug 2022 15:00:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C55B205D6
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Aug 2022 12:00:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 977E0388D7;
        Mon,  1 Aug 2022 19:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659380434;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K70KBnKQ/oOAcExTQieFzT6sc4qnFSM9Om9jCoXMCeM=;
        b=oqgYEcLiQ3HgsCfoNZlxoCO7zLs9Hy+7q/MINGr8LSQQhiaNhexXmIFfOsrYoh151DrUFF
        8uCblzPQcIWDnceIV4jwy66ykmXQlqgD77JVy1w9hFw826uFBbmdY9H39XMVossBGUMAjS
        U7JO7KRiavcohqkDSAhB26agrFfz/7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659380434;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K70KBnKQ/oOAcExTQieFzT6sc4qnFSM9Om9jCoXMCeM=;
        b=vhmaOz1QX/nTB9CBbyaC/F540hlkI/bC9hwtPxUNg4KnN02M4WGxSEFOR1Pgm46RHX/8pV
        LnGYbAM3YbmHuaDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 76DF913AAE;
        Mon,  1 Aug 2022 19:00:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wvQOHNIi6GI/RwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 01 Aug 2022 19:00:34 +0000
Date:   Mon, 1 Aug 2022 20:55:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Selectable checksum implementation
Message-ID: <20220801185533.GI13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1659116355.git.dsterba@suse.com>
 <YuRKtV7ZyyrjT/uS@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuRKtV7ZyyrjT/uS@zen>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 29, 2022 at 02:01:41PM -0700, Boris Burkov wrote:
> On Fri, Jul 29, 2022 at 07:42:42PM +0200, David Sterba wrote:
> > Add a possibility to load accelerated checksum implementation after a
> > filesystem has been mounted. Detailed description in patch 3.
> 
> I naively attempted to use this on my test VM and it blew up in mount.
> 
> What I ran:
> mkfs.btrfs -f $dev --csum sha256
> mount $dev $mnt
> 
> I got this oops:
> https://pastebin.com/DAbSem7K
> 
> which indicates a null pointer access in this code:
> (gdb) list *open_ctree+0x3c9
> 0xffffffff8210634e is in open_ctree (fs/btrfs/disk-io.c:2437).
> 2432
> 2433            /*
> 2434             * Find the fastest implementation available, but keep the slots
> 2435             * matching the type.
> 2436             */
> 2437            if (strstr(crypto_shash_driver_name(fs_info->csum_shash[CSUM_DEFAULT]),
> 2438                       "generic") != NULL) {
> 2439                    fs_info->csum_shash[CSUM_GENERIC] = csum_shash;
> 2440                    clear_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
> 2441            } else {
> 
> So I suspect the problem is in btrfs_init_csum_hash. Looking at it, two
> things come to mind:
> 1. the old code used the name from the allocated hash, maybe we need to
> check that against "generic" instead of the DEFAULT
> 2. we never set the DEFAULT entry to anything, so it isn't clear to me
> how the use of the checksum would work after this (which it does seem to
> do, to csum the super block).

That DEFAULT was not set is the problem, in patch 2 there's removed line
setting it, this is a rebase error on my side, I was splitting the
patches from longer series. Thanks for catching it, I'll resend.

> Running misc-next, it mounted and reported it was using sha256-generic:
> $ cat /sys/fs/btrfs/8ffa8559-f6c4-41d3-a806-c12738367d72/checksum
> sha256 (sha256-generic)
> 
> I have not yet figured out how to get the virtio accel stuff to actually
> work in the VM, so I haven't tested the happy case yet, but I figured
> this report would be interesting on its own.

I think you need to enable in .config the accelerated version,
CONFIG_CRYPTO_SHA256_SSSE3=m, and run KVM guest that has the CPU
features available. I'm running it with '-host', virtio only for random
number generator and block devices.
