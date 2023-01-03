Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7EF65C569
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jan 2023 18:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238034AbjACRwg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Jan 2023 12:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238137AbjACRw3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Jan 2023 12:52:29 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E298F592
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Jan 2023 09:52:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E79B933EBD;
        Tue,  3 Jan 2023 17:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672768346;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NPHYNvBkmGTbvARrxvr7BORgfiaA1pEgeXmIflCWfis=;
        b=Zhmp9XJrvnxo3gMDHORkpg5TJvSfonum+W//zp9Q7L7XZ2jpL9fPywzQ9Tyenx9MXRZ+HO
        vJJnbdx/Igeo4VU+l9OwOwihSTFT7Op0pPnUD8FwR6x000lwbZfkiZ+F+c2eX0SaHVhxir
        rbUqQZM8XQ6aj2bqFblv8KqLO/kgB4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672768346;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NPHYNvBkmGTbvARrxvr7BORgfiaA1pEgeXmIflCWfis=;
        b=HjeiGpfE1CFekz8Jr/cw+fM+u16YDMUz8o8/rRyQ9BsDGyAVMBzd1oRO2mtgcAXfw4794l
        Sk6g4+1UUo//gQAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC06E1390C;
        Tue,  3 Jan 2023 17:52:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I4zhLFprtGMaNwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 03 Jan 2023 17:52:26 +0000
Date:   Tue, 3 Jan 2023 18:46:56 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Chung-Chiang Cheng <shepjeng@gmail.com>
Subject: Re: [PATCH v3] btrfs: fix compat_ro checks against remount
Message-ID: <20230103174656.GR11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <e343fbf122d17f6d74e3630b197f7b344bbdaff1.1671667128.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e343fbf122d17f6d74e3630b197f7b344bbdaff1.1671667128.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 22, 2022 at 07:59:17AM +0800, Qu Wenruo wrote:
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
> our current mount flags.
> 
> That function get reused between open_ctree() and btrfs_remount().
> 
> But for btrfs_remount(), the super block we passed in still has the old
> mount flags, thus btrfs_check_features() still believes we're mounting
> read-only.
> 
> [FIX]
> Replace the existing @sb argument with @is_rw_mount.
> 
> As originally we only use @sb to determine if the mount is RW.
> 
> Now it's callers' responsibility to determine if the mount is RW, and
> since there are only two callers, the check is pretty simple:
> 
> - caller in open_ctree()
>   Just pass !sb_rdonly().
> 
> - caller in btrfs_remount()
>   Pass !(*flags & SB_RDONLY), as our check should be against the new
>   flags.
> 
> Now we can correctly reject the RW remount:
> 
>   # mount /dev/loop0 -o ro /mnt/btrfs
>   # mount -o remount,rw /mnt/btrfs
>   mount: /mnt/btrfs: mount point not mounted or bad option.
>          dmesg(1) may have more information after failed mount system call.
>   # dmesg -t | tail -n 1
>   BTRFS error (device loop0: state M): cannot mount read-write because of unknown compat_ro features (0x403)
> 
> Reported-by: Chung-Chiang Cheng <shepjeng@gmail.com>
> Fixes: 81d5d61454c3 ("btrfs: enhance unsupported compat RO flags handling")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Add a comment on why @rw_mount is calculated this way
>   This will cover RW->RW and RW->RO remount cases, but since the
>   fs is already RW, we should not has any unsupported compat_ro flags
>   anyway.
> 
> v3:
> - Use @is_rw_mount to replace @sb argument completely
>   This should make the code easier to read and reduce the argument list.

Added to misc-next, thanks.
