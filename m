Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78C0719D2A
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 15:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbjFANSB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jun 2023 09:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjFANSA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jun 2023 09:18:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1597125
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Jun 2023 06:17:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5E2C41FD99;
        Thu,  1 Jun 2023 13:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685625477;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j9M1ZH2Yk9oDpOzwChuF0LmAi98vuh8FSazvolkAPFk=;
        b=lQoTfpG2vNmclzdQbRkIOnueWpC9ufmsbaP/Wpy/sCaeZvz/gPQJxq494r3KEAI+JxJ9FA
        +LaYJokRoomZQewhcJswLfXGfHxpWowETU3GSJDJwSR49i1wmag5HH2lBO0OvqJKldFX60
        YD2UyCWaDRHo6WER8W+aA/dpFaJ+2+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685625477;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j9M1ZH2Yk9oDpOzwChuF0LmAi98vuh8FSazvolkAPFk=;
        b=jXHF82nbcDV3DjRWN7fT4icqleP4SCOiREJLFe4uGYIOaUW5Of4eHl31mfn5Vk8fuS7D/5
        xzP1H8p0IVT+foCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F21113441;
        Thu,  1 Jun 2023 13:17:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JBypDoWaeGQ2JwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 01 Jun 2023 13:17:57 +0000
Date:   Thu, 1 Jun 2023 15:11:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] btrfs: fix dev-replace after the scrub rework
Message-ID: <20230601131145.GI32581@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <61e46bae045ec4e5173874dc81cb178e456644ab.1685616199.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61e46bae045ec4e5173874dc81cb178e456644ab.1685616199.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 01, 2023 at 06:51:34PM +0800, Qu Wenruo wrote:
> [BUG]
> After commit e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror()
> to scrub_stripe infrastructure"), scrub no longer works for zoned device
> at all.
> 
> Even an empty zoned btrfs can not be replaced:
> 
>  # mkfs.btrfs -f /dev/nvme0n1
>  # mount /dev/nvme0n1 /mnt/btrfs
>  # btrfs replace start -Bf 1 /dev/nvme0n2 /mnt/btrfs
>  Resetting device zones /dev/nvme1n1 (160 zones) ...
>  ERROR: ioctl(DEV_REPLACE_START) failed on "/mnt/btrfs/": Input/output error
> 
> And we can hit kernel crash related to that:
> 
>  BTRFS info (device nvme1n1): host-managed zoned block device /dev/nvme3n1, 160 zones of 134217728 bytes
>  BTRFS info (device nvme1n1): dev_replace from /dev/nvme2n1 (devid 2) to /dev/nvme3n1 started
>  nvme3n1: Zone Management Append(0x7d) @ LBA 65536, 4 blocks, Zone Is Full (sct 0x1 / sc 0xb9) DNR
>  I/O error, dev nvme3n1, sector 786432 op 0xd:(ZONE_APPEND) flags 0x4000 phys_seg 3 prio class 2
>  BTRFS error (device nvme1n1): bdev /dev/nvme3n1 errs: wr 1, rd 0, flush 0, corrupt 0, gen 0
>  BUG: kernel NULL pointer dereference, address: 00000000000000a8
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>  RIP: 0010:_raw_spin_lock_irqsave+0x1e/0x40
>  Call Trace:
>   <IRQ>
>   btrfs_lookup_ordered_extent+0x31/0x190
>   btrfs_record_physical_zoned+0x18/0x40
>   btrfs_simple_end_io+0xaf/0xc0
>   blk_update_request+0x153/0x4c0
>   blk_mq_end_request+0x15/0xd0
>   nvme_poll_cq+0x1d3/0x360
>   nvme_irq+0x39/0x80
>   __handle_irq_event_percpu+0x3b/0x190
>   handle_irq_event+0x2f/0x70
>   handle_edge_irq+0x7c/0x210
>   __common_interrupt+0x34/0xa0
>   common_interrupt+0x7d/0xa0
>   </IRQ>
>   <TASK>
>   asm_common_interrupt+0x22/0x40
> 
> [CAUSE]
> Dev-replace reuses scrub code to iterate all extents and write the
> existing content back to the new device.
> 
> And for zoned devices, we call fill_writer_pointer_gap() to make sure
> all the writes into the zoned device is sequential, even if there may be
> some gaps between the writes.
> 
> However we have several different bugs all related to zoned dev-replace:
> 
> - We are using ZONE_APPEND operation for metadata style write back
>   For zoned devices, btrfs has two ways to write data:
> 
>   * ZONE_APPEND for data
>     This allows higher queue depth, but will not be able to know where
>     the write would land.
>     Thus needs to grab the real on-disk physical location in it's endio.
> 
>   * WRITE for metadata
>     This requires single queue depth (new writes can only be submitted
>     after previous one finished), and all writes must be sequential.
> 
>   For scrub, we go single queue depth, but still goes with ZONE_APPEND,
>   which requires btrfs_bio::inode being populated.
>   This is the cause of that crash.
> 
> - No correct tracing of write_pointer
>   After a write finished, we should forward sctx->write_pointer, or
>   fill_writer_pointer_gap() would not work properly and cause more
>   than necessary zero out, and fill the whole zone prematurely.
> 
> - Incorrect physical bytenr passed to fill_writer_pointer_gap()
>   In scrub_write_sectors(), one call site passes logical address, which
>   is completely wrong.
> 
>   The other call site passes physical address of current sector, but
>   we should pass the physical address of the btrfs_bio we're submitting.
> 
>   This is the cause of the -EIO errors.
> 
> [FIX]
> - Do not use ZONE_APPEND for btrfs_submit_repair_write().
> 
> - Manually forward sctx->write_pointer after success writeback
> 
> - Use the physical address of the to-be-submitted btrfs_bio for
>   fill_writer_pointer_gap()
> 
> Now zoned device replace would work as expected.
> 
> Reported-by: Christoph Hellwig <hch@lst.de>
> Fixes: e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to scrub_stripe infrastructure")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Concentrace the write bio submission into a dedicated helper
>   This would cleanup the code as the submission part is getting more
>   complex than before.

Added to misc-next, thanks. It took 4 -rcs to notice broken zoned
scrub/dev-replace.
