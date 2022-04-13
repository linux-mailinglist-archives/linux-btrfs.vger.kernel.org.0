Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4F34FF658
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Apr 2022 13:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbiDMMAk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Apr 2022 08:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235371AbiDMMAM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Apr 2022 08:00:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36775EDED;
        Wed, 13 Apr 2022 04:56:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9B8E11F858;
        Wed, 13 Apr 2022 11:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649851010;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NFlo9ERvfunpKvRo2LCQmzu6wLB5gQzmSAw9ElrfagY=;
        b=C0klZyMwNH2YwBKvQaU1K8skw0l3TsfQhyIEle7cw8Cy73qhEFNvt83Gi8NjSnd5Ff6xYN
        4IH731T4Oj+mfJTk52SKqX5erJOnjjhWLfKrT0b2JzI8O2q1RLt+1HU0FTgLTAdNUHkuFx
        /ldbnxYq63FpkXOZmCTPtOh7rkpru+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649851010;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NFlo9ERvfunpKvRo2LCQmzu6wLB5gQzmSAw9ElrfagY=;
        b=lv0MbdD+I6RMoacMMHpo/mASJtmUdLvyq7ETJq6fN/TgDHnTxMtnO2xr75L/VRZHCNg+J2
        KhcHJcn1gVZpmSDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 71ED513A91;
        Wed, 13 Apr 2022 11:56:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0U4cG4K6VmLpVwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 13 Apr 2022 11:56:50 +0000
Date:   Wed, 13 Apr 2022 13:52:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     torvalds@linux-foundation.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs fixes for 5.18-rc3
Message-ID: <20220413115243.GH15609@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, torvalds@linux-foundation.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1649705056.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1649705056.git.dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 11, 2022 at 11:31:43PM +0200, David Sterba wrote:
> Hi,
> 
> a few more code fixes and a warning fixes. There's one feature ioctl
> removal patch slated for 5.18 that did not make it to the main pull
> request.  It's just a one-liner and the ioctl has a v2 that's in use for
> a long time, no point to postpone it to 5.19.
> 
> Please pull, thanks.
> 
> - fixes:
>   - add back cgroup attribution for compressed writes
>   - add super block write start/end annotations to asynchronous balance
>   - fix root reference count on an error handling path
>   - in zoned mode, activate zone at the chunk allocation time to avoid
>     ENOSPC due to timing issues
>   - fix delayed allocation accounting for direct IO
> 
> - remove balance v1 ioctl, superseded by v2 in 2012
> 
> - warning fixes:
>   - simplify assertion condition in zoned check
>   - remove an unused variable

Has this ended up in your spam box again? The mail is in lore archives
as https://lore.kernel.org/all/cover.1649705056.git.dsterba@suse.com/ .

> ----------------------------------------------------------------
> The following changes since commit 60021bd754c6ca0addc6817994f20290a321d8d6:
> 
>   btrfs: prevent subvol with swapfile from being deleted (2022-03-24 17:50:57 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.18-rc2-tag
> 
> for you to fetch changes up to acee08aaf6d158d03668dc82b0a0eef41100531b:
> 
>   btrfs: fix btrfs_submit_compressed_write cgroup attribution (2022-04-06 00:50:51 +0200)
> 
> ----------------------------------------------------------------
> Dennis Zhou (1):
>       btrfs: fix btrfs_submit_compressed_write cgroup attribution
> 
> Haowen Bai (1):
>       btrfs: zoned: remove redundant condition in btrfs_run_delalloc_range
> 
> Jia-Ju Bai (1):
>       btrfs: fix root ref counts in error handling in btrfs_get_root_ref
> 
> Naohiro Aota (4):
>       btrfs: release correct delalloc amount in direct IO write path
>       btrfs: mark resumed async balance as writing
>       btrfs: return allocated block group from do_chunk_alloc()
>       btrfs: zoned: activate block group only for extent allocation
> 
> Nathan Chancellor (1):
>       btrfs: remove unused variable in btrfs_{start,write}_dirty_block_groups()
> 
> Nikolay Borisov (1):
>       btrfs: remove support of balance v1 ioctl
> 
>  fs/btrfs/block-group.c | 40 +++++++++++++++++++++++++++-------------
>  fs/btrfs/block-group.h |  4 ++++
>  fs/btrfs/compression.c |  8 ++++++++
>  fs/btrfs/disk-io.c     |  5 +++--
>  fs/btrfs/extent-tree.c |  2 +-
>  fs/btrfs/inode.c       |  9 ++++-----
>  fs/btrfs/ioctl.c       |  2 --
>  fs/btrfs/volumes.c     |  2 ++
>  8 files changed, 49 insertions(+), 23 deletions(-)
> 
