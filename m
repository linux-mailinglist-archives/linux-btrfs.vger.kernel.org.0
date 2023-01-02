Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5539965B48E
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jan 2023 17:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbjABQAc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Jan 2023 11:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236453AbjABQA3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Jan 2023 11:00:29 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C07DA471
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Jan 2023 08:00:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2C3F734238;
        Mon,  2 Jan 2023 16:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672675227;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rhGATeo6caJJyRE0XlgSw++XI0BpGmJiKQePwY/2Lqc=;
        b=vseirzRzn39F70Q6v7yEt9HgUkkoCQLhe091kAz0xSVgSJNL47DNRGxfetJ3yVK4WDa13J
        QPjP2ad9EZ877ikffLBdId+lIn9a4eMnu+tJDkjh9IgDSAAZcez1D5xeChavz8TDAquMvw
        tW2Qd8GfjzCM5K/dti8x6YXysJRdaAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672675227;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rhGATeo6caJJyRE0XlgSw++XI0BpGmJiKQePwY/2Lqc=;
        b=Alpxd6H4IbozzDBY3TojPQeaESaJmetca5KmnDoeB0cQUh+F1jRV+YGDO0hdspsKBRb+KO
        aw8R+DMlM4AvwLDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 05C46139C8;
        Mon,  2 Jan 2023 16:00:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9D9oAJv/smOpeAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 02 Jan 2023 16:00:27 +0000
Date:   Mon, 2 Jan 2023 16:54:57 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, =?utf-8?B?5bCP5aSq?= <nospam@kota.moe>
Subject: Re: [PATCH] btrfs: don't trigger BUG_ON() when repair happens with
 dev-replace
Message-ID: <20230102155457.GL11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <e6bd27828dfa486ff27e39db13b662e06d71ec74.1672534935.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6bd27828dfa486ff27e39db13b662e06d71ec74.1672534935.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 01, 2023 at 09:02:21AM +0800, Qu Wenruo wrote:
> [BUG]
> There is a bug report that a BUG_ON() in btrfs_repair_io_failure()
> (originally repair_io_failure() in v6.0 kernel) got triggered when
> replacing a unreliable disk:
> 
>  BTRFS warning (device sda1): csum failed root 257 ino 2397453 off 39624704 csum 0xb0d18c75 expected csum 0x4dae9c5e mirror 3
>  kernel BUG at fs/btrfs/extent_io.c:2380!
>  invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>  CPU: 9 PID: 3614331 Comm: kworker/u257:2 Tainted: G           OE      6.0.0-5-amd64 #1  Debian 6.0.10-2
>  Hardware name: Micro-Star International Co., Ltd. MS-7C60/TRX40 PRO WIFI (MS-7C60), BIOS 2.70 07/01/2021
>  Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
>  RIP: 0010:repair_io_failure+0x24a/0x260 [btrfs]
>  Call Trace:
>   <TASK>
>   clean_io_failure+0x14d/0x180 [btrfs]
>   end_bio_extent_readpage+0x412/0x6e0 [btrfs]
>   ? __switch_to+0x106/0x420
>   process_one_work+0x1c7/0x380
>   worker_thread+0x4d/0x380
>   ? rescuer_thread+0x3a0/0x3a0
>   kthread+0xe9/0x110
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork+0x22/0x30
>   </TASK>
> 
> [CAUSE]
> 
> Before the BUG_ON(), we got some read errors from the replace target
> first, note the mirror number (3, which is beyond RAID1 duplication,
> thus it's read from the replace target device).
> 
> Then at the BUG_ON() location, we are trying to writeback the repaired
> sectors back the failed device.
> 
> The check looks like this:
> 
> 		ret = btrfs_map_block(fs_info, BTRFS_MAP_WRITE, logical,
> 				      &map_length, &bioc, mirror_num);
> 		if (ret)
> 			goto out_counter_dec;
> 		BUG_ON(mirror_num != bioc->mirror_num);
> 
> But inside btrfs_map_block(), we can modify bioc->mirror_num especially
> for dev-replace:
> 
> 	if (dev_replace_is_ongoing && mirror_num == map->num_stripes + 1 &&
> 	    !need_full_stripe(op) && dev_replace->tgtdev != NULL) {
> 		ret = get_extra_mirror_from_replace(fs_info, logical, *length,
> 						    dev_replace->srcdev->devid,
> 						    &mirror_num,
> 					    &physical_to_patch_in_first_stripe);
> 		patch_the_first_stripe_for_dev_replace = 1;
> 	}
> 
> Thus if we're repairing the replace target device, we're going to
> triggere that BUG_ON().
> 
> But in reality, the read failure from the replace target device may be that,
> our replace haven't reach the range we're reading, thus we're reading
> garbage, but with replace running, the range would be properly filled
> later.
> 
> Thus in that case, we don't need to do anything but let the replace
> routine to handle it.
> 
> [FIX]
> Instead of a BUG_ON(), just skip the repair if we're repairing the
> device replace target device.
> 
> Reported-by: 小太 <nospam@kota.moe>
> Link: https://lore.kernel.org/linux-btrfs/CACsxjPYyJGQZ+yvjzxA1Nn2LuqkYqTCcUH43S=+wXhyf8S00Ag@mail.gmail.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
