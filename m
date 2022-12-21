Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49916653087
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Dec 2022 13:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiLUMAi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Dec 2022 07:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiLUMAh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Dec 2022 07:00:37 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC4CD1
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Dec 2022 04:00:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BBFFD22324;
        Wed, 21 Dec 2022 12:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671624035;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rcYzVsJKpwb0aAXpBdMAtJ97uA2tR5TH+wAoe995yug=;
        b=ndxJrwY1Z9Tixuxtydy5a/lbStShbCYqZQKFuRzJUlBtyt9QsKWc17PotynvhOY2StTbc5
        Kllzjv7MpeK0sY6DilLy90td57gySbseSuOwjyGiNsudgv0TfJF6fg6z9tDGnHjMTeHX0W
        V5t+4s6+giARz7E4SYT+HlaBMF8agB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671624035;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rcYzVsJKpwb0aAXpBdMAtJ97uA2tR5TH+wAoe995yug=;
        b=BLYPrCx7hp2+ns8av3DItRq9jEwRLOp4xp6726AD5JI6a5P2PdmHWGjTYbN69VpDxts8dr
        DQ52lJd1Zz43ALAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 841E113913;
        Wed, 21 Dec 2022 12:00:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kBdWH2P1omOlUQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 21 Dec 2022 12:00:35 +0000
Date:   Wed, 21 Dec 2022 12:59:49 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Chung-Chiang Cheng <shepjeng@gmail.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v2] btrfs: fix compat_ro checks against remount
Message-ID: <20221221115949.GV10499@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <82e9c6f8afe4a58e3df60cf601530e14d42264a6.1671613891.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82e9c6f8afe4a58e3df60cf601530e14d42264a6.1671613891.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 21, 2022 at 05:13:00PM +0800, Qu Wenruo wrote:
> [BUG]
> Even with commit 81d5d61454c3 ("btrfs: enhance unsupported compat RO
> flags handling"), btrfs can still mount a fs with unsupported compat_ro
> flags read-only, then remount it RW:
> 
>   # btrfs ins dump-super /dev/loop0 | grep compat_ro_flags -A 3
>   compat_ro_flags		0x403
> 			( FREE_SPACE_TREE |
> 			  FREE_SPACE_TREE_VALID |
> 			  unknown flag: 0x400 )
> 
>   # mount /dev/loop0 /mnt/btrfs
>   mount: /mnt/btrfs: wrong fs type, bad option, bad superblock on /dev/loop0, missing codepage or helper program, or other error.
>          dmesg(1) may have more information after failed mount system call.
>   ^^^ RW mount failed as expected ^^^
> 
>   # dmesg -t | tail -n5
>   loop0: detected capacity change from 0 to 1048576
>   BTRFS: device fsid cb5b82f5-0fdd-4d81-9b4b-78533c324afa devid 1 transid 7 /dev/loop0 scanned by mount (1146)
>   BTRFS info (device loop0): using crc32c (crc32c-intel) checksum algorithm
>   BTRFS info (device loop0): using free space tree
>   BTRFS error (device loop0): cannot mount read-write because of unknown compat_ro features (0x403)
>   BTRFS error (device loop0): open_ctree failed
> 
>   # mount /dev/loop0 -o ro /mnt/btrfs
>   # mount -o remount,rw /mnt/btrfs
>   ^^^ RW remount succeeded unexpectedly ^^^
> 
> [CAUSE]
> Currently we use btrfs_check_features() to check compat_ro flags against
> our current moount flags.
> 
> That function get reused between open_ctree() and btrfs_remount().
> 
> But for btrfs_remount(), the super block we passed in still has the old
> mount flags, thus btrfs_check_features() still believes we're mounting
> read-only.
> 
> [FIX]
> Introduce a new argument, *new_flags, to indicate the new mount flags.
> That argument can be NULL for the open_ctree() call site.
> 
> With that new argument, call site at btrfs_remount() can properly pass
> the new super flags, and we can reject the RW remount correctly.
> 
> Reported-by: Chung-Chiang Cheng <shepjeng@gmail.com>
> Fixes: 81d5d61454c3 ("btrfs: enhance unsupported compat RO flags handling")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> ---
> Changelog:
> v2:
> - Add a comment on why @rw_mount is calculated this way
>   This will cover RW->RW and RW->RO remount cases, but since the
>   fs is already RW, we should not has any unsupported compat_ro flags
>   anyway.

Added to misc-next, thanks.

> -int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_block *sb)
> +int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_block *sb,
> +			 int *new_flags)

Flags should be unsigned as they do bitwise ops only but in this case
it's inherited from the remount_fs prototype (which actually gets
unsigned int from the struct fs_contex::sb_flags in legacy_reconfigure)
so we're stuck with int.
