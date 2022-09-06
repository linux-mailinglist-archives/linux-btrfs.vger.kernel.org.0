Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA2C5AF072
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Sep 2022 18:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbiIFQdI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Sep 2022 12:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbiIFQcl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Sep 2022 12:32:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CA3857CD
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Sep 2022 09:06:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 749FC1F9AC;
        Tue,  6 Sep 2022 16:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662480399;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IGx3brLlMAgtYbHzJb94yGjXj+1C38HTfthwjD1l/XM=;
        b=PaJdX+pYm058la5bbcay66YMtLEzn4RZC1svpld0U9mT2uTW7tbkJRFo1r6NDwVCWxvqoW
        SDTzxdf8ldlX6+BhQRgp9IrYH0dvzDNJiFP84tgRhov6rES41yN8o4jmTsEnw+aozi15Ll
        NjsZ0xhwzD+JPC0bYkZ9HTLWEzed1Lo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662480399;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IGx3brLlMAgtYbHzJb94yGjXj+1C38HTfthwjD1l/XM=;
        b=yQM9C1vcGYxh30Yx4c5DkoF645PIaMS+D/euiUq6UAg0Tp1hWGsSE17K8dXugXP7UcF3uW
        7rduj9e+ogJYZpAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5174513A19;
        Tue,  6 Sep 2022 16:06:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vQcVEw9wF2OCLgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 06 Sep 2022 16:06:39 +0000
Date:   Tue, 6 Sep 2022 18:01:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Wang Yugui <wangyugui@e16-tech.com>
Subject: Re: [PATCH] btrfs: fix the max chunk size and stripe length
 calculation
Message-ID: <20220906160116.GP13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <17e7c38b0cc6fe90c90f4b383734c06eafd2f9b5.1660806386.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17e7c38b0cc6fe90c90f4b383734c06eafd2f9b5.1660806386.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 18, 2022 at 03:06:44PM +0800, Qu Wenruo wrote:
> [BEHAVIOR CHANGE]
> Since commit f6fca3917b4d ("btrfs: store chunk size in space-info
> struct"), btrfs no longer can create larger data chunks than 1G:
> 
>   mkfs.btrfs -f -m raid1 -d raid0 $dev1 $dev2 $dev3 $dev4
>   mount $dev1 $mnt
> 
>   btrfs balance start --full $mnt
>   btrfs balance start --full $mnt
>   umount $mnt
> 
>   btrfs ins dump-tree -t chunk $dev1 | grep "DATA|RAID0" -C 2
> 
> Before that offending commit, what we got is a 4G data chunk:
> 
> 	item 6 key (FIRST_CHUNK_TREE CHUNK_ITEM 9492758528) itemoff 15491 itemsize 176
> 		length 4294967296 owner 2 stripe_len 65536 type DATA|RAID0
> 		io_align 65536 io_width 65536 sector_size 4096
> 		num_stripes 4 sub_stripes 1
> 
> Now what we got is only 1G data chunk:
> 
> 	item 6 key (FIRST_CHUNK_TREE CHUNK_ITEM 6271533056) itemoff 15491 itemsize 176
> 		length 1073741824 owner 2 stripe_len 65536 type DATA|RAID0
> 		io_align 65536 io_width 65536 sector_size 4096
> 		num_stripes 4 sub_stripes 1
> 
> This will increase the number of data chunks by the number of devices,
> not only increase system chunk usage, but also greatly increase mount
> time.
> 
> Without a properly reason, we should not change the max chunk size.
> 
> [CAUSE]
> Previously, we set max data chunk size to 10G, while max data stripe
> length to 1G.
> 
> Commit f6fca3917b4d ("btrfs: store chunk size in space-info struct")
> completely ignored the 10G limit, but use 1G max stripe limit instead,
> causing above shrink in max data chunk size.
> 
> [FIX]
> Fix the max data chunk size to 10G, and in decide_stripe_size_regular()
> we limit stripe_size to 1G manually.
> 
> This should only affect data chunks, as for metadata chunks we always
> set the max stripe size the same as max chunk size (256M or 1G
> depending on fs size).
> 
> Now the same script result the same old result:
> 
> 	item 6 key (FIRST_CHUNK_TREE CHUNK_ITEM 9492758528) itemoff 15491 itemsize 176
> 		length 4294967296 owner 2 stripe_len 65536 type DATA|RAID0
> 		io_align 65536 io_width 65536 sector_size 4096
> 		num_stripes 4 sub_stripes 1
> 
> Reported-by: Wang Yugui <wangyugui@e16-tech.com>
> Fixes: f6fca3917b4d ("btrfs: store chunk size in space-info struct")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks. And thanks to Wang Yugui for the report.
