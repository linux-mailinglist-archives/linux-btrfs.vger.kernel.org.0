Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CB772D45F
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 00:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236948AbjFLW3L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 18:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjFLW3K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 18:29:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516BD170A
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 15:29:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0A8441F747;
        Mon, 12 Jun 2023 22:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686608948;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0hD8xtve9v6mxLzXozfAJs5KDLhtgQFA82YYdM4KNvs=;
        b=lPQ8hq9TPEw/9DakACVtZsxYVw2otHQBXiekjR5pvAZDI7/m/YankZHsQ2RDbowD/5dRq6
        zIVEjAm8WQLG+Jdcttc3VxzMqo2prvxb5691eVcdI+fh4LLQClfClOwF3N9K3XNNGripGd
        SSNg6M4hqefTU1rKRXVhzcZHEJngz5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686608948;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0hD8xtve9v6mxLzXozfAJs5KDLhtgQFA82YYdM4KNvs=;
        b=aiB1dOrjZCLs9M+QibvHhkwtsyh0OkP/k3rmqZyMsYvh/A6q6HbzmX0/dA2vtC0Du4htAA
        SrxOQ1LNcx1DHFBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CEA04138EC;
        Mon, 12 Jun 2023 22:29:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DFSEMTOch2RpWwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 12 Jun 2023 22:29:07 +0000
Date:   Tue, 13 Jun 2023 00:22:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naota@elisp.net>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: do not limit delalloc size to
 fs_info->max_extent_size
Message-ID: <20230612222249.GI13486@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a2f4a2162fdc3457830fa997c70ffa7c231759ad.1686582572.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2f4a2162fdc3457830fa997c70ffa7c231759ad.1686582572.git.naohiro.aota@wdc.com>
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

On Tue, Jun 13, 2023 at 12:10:29AM +0900, Naohiro Aota wrote:
> There is an issue writing out huge buffered data with the compressed mount
> option on zoned mode. For example, when you buffered write 16GB data and
> call "sync" command on "mount -o compress" file-system on a zoned device,
> it takes more than 3 minutes to finish the sync, invoking the hung_task
> timeout.
> 
> Before the patch:
> 
>     + xfs_io -f -c 'pwrite -b 8M 0 16G' /mnt/test/foo
>     wrote 17179869184/17179869184 bytes at offset 0
>     16.000 GiB, 2048 ops; 0:00:23.74 (690.013 MiB/sec and 86.2516 ops/sec)
> 
>     real    0m23.770s
>     user    0m0.005s
>     sys     0m23.599s
>     + sync
> 
>     real    3m55.921s
>     user    0m0.000s
>     sys     0m0.134s
> 
> After the patch:
> 
>     + xfs_io -f -c 'pwrite -b 8M 0 16G' /mnt/test/foo
>     wrote 17179869184/17179869184 bytes at offset 0
>     16.000 GiB, 2048 ops; 0:00:28.11 (582.648 MiB/sec and 72.8311 ops/sec)
> 
>     real    0m28.146s
>     user    0m0.004s
>     sys     0m27.951s
>     + sync
> 
>     real    0m12.310s
>     user    0m0.000s
>     sys     0m0.048s
> 
> This slow "sync" comes from inefficient async chunk building due to
> needlessly limited delalloc size.
> 
> find_lock_delalloc_range() looks for pages for the delayed allocation at
> most fs_info->max_extent_size in its size. For the non-compress write case,
> that range directly corresponds to num_bytes at cow_file_range() (= size of
> allocation). So, limiting the size to the max_extent_size seems no harm as
> we will split the extent even if we can have a larger allocation.
> 
> However, things are different with the compression case. The
> run_delalloc_compressed() divides the delalloc range into 512 KB sized
> chunks and queues a worker for each chunk. The device of the above test
> case has 672 KB zone_append_max_bytes, which is equal to
> fs_info->max_extent_size. Thus, one run_delalloc_compressed() call can
> build only two chunks at most, which is really smaller than
> BTRFS_MAX_EXTENT_SIZE / 512KB = 256, making it inefficient.
> 
> Also, as 672 KB is not aligned to 512 KB, it is creating ceil(16G / 672K) *
> 2 = 49934 async chunks for the above case. OTOH, with BTRFS_MAX_EXTENT_SIZE
> delalloced, we will create 32768 chunks, which is 34% reduced.
> 
> This patch reverts the delalloc size to BTRFS_MAX_EXTENT_SIZE, as it does
> not directly corresponds to the size of one extent. Instead, this patch
> will limit the allocation size at cow_file_range() for the zoned mode.
> 
> As shown above, with this patch applied, the "sync" time is reduced from
> almost 4 minutes to 12 seconds.
> 
> Fixes: f7b12a62f008 ("btrfs: replace BTRFS_MAX_EXTENT_SIZE with fs_info->max_extent_size")
> CC: stable@vger.kernel.org # 6.1+

Missing S-O-B, I've used the one with @wdc.com address. Added to
misc-next, thanks.
