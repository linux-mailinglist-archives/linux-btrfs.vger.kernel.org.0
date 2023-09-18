Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C77E7A5524
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Sep 2023 23:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjIRVgf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Sep 2023 17:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIRVge (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 17:36:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9138E
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Sep 2023 14:36:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 20B1522238;
        Mon, 18 Sep 2023 21:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695072986;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ehQV7d+D+MCrbk9APdJV5n0qBYQyPyGRBO82+URR/U0=;
        b=M9VaVu0D8VM00T21mTf/7S9ceG/8lAP8W7welmS6ZGDdjspyh9OWClW8qnHqFBmO59fpja
        Dse+Lds1YS4tOoEpnctwz2xquGmDteQEvZDLSs/XHDQB/VScTHgwgT+GV3IIViqgvQO18E
        +Nfn2z3D+1nlJKjohKst72z+kmc8SBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695072986;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ehQV7d+D+MCrbk9APdJV5n0qBYQyPyGRBO82+URR/U0=;
        b=Ubg1niPnRNu3mHTYhSdPSMzz/DTbKAiQY8SWjPApdRveGbiADA/dJ/8GKelC/CbBz1zIQ2
        pgaSnsYnLHKdSNBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE6651358A;
        Mon, 18 Sep 2023 21:36:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lmiAOdnCCGUCfgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 18 Sep 2023 21:36:25 +0000
Date:   Mon, 18 Sep 2023 23:29:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: adjust overcommit logic when very close to full
Message-ID: <20230918212950.GP2747@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b97e47ce0ce1d41d221878de7d6090b90aa7a597.1695065233.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b97e47ce0ce1d41d221878de7d6090b90aa7a597.1695065233.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 18, 2023 at 03:27:47PM -0400, Josef Bacik wrote:
> A user reported some unpleasant behavior with very small file systems.
> The reproducer is this
> 
> mkfs.btrfs -f -m single -b 8g /dev/vdb
> mount /dev/vdb /mnt/test
> dd if=/dev/zero of=/mnt/test/testfile bs=512M count=20
> 
> This will result in usage that looks like this
> 
> Overall:
>     Device size:                   8.00GiB
>     Device allocated:              8.00GiB
>     Device unallocated:            1.00MiB
>     Device missing:                  0.00B
>     Device slack:                  2.00GiB
>     Used:                          5.47GiB
>     Free (estimated):              2.52GiB      (min: 2.52GiB)
>     Free (statfs, df):               0.00B
>     Data ratio:                       1.00
>     Metadata ratio:                   1.00
>     Global reserve:                5.50MiB      (used: 0.00B)
>     Multiple profiles:                  no
> 
> Data,single: Size:7.99GiB, Used:5.46GiB (68.41%)
>    /dev/vdb        7.99GiB
> 
> Metadata,single: Size:8.00MiB, Used:5.77MiB (72.07%)
>    /dev/vdb        8.00MiB
> 
> System,single: Size:4.00MiB, Used:16.00KiB (0.39%)
>    /dev/vdb        4.00MiB
> 
> Unallocated:
>    /dev/vdb        1.00MiB
> 
> As you can see we've gotten ourselves quite full with metadata, with all
> of the disk being allocated for data.
> 
> On smaller file systems there's not a lot of time before we get full, so
> our overcommit behavior bites us here.  Generally speaking data
> reservations result in chunk allocations as we assume reservation ==
> actual use for data.  This means at any point we could end up with a
> chunk allocation for data, and if we're very close to full we could do
> this before we have a chance to figure out that we need another metadata
> chunk.
> 
> Address this by adjusting the overcommit logic.  Simply put we need to
> take away 1 chunk from the available chunk space in case of a data
> reservation.  This will allow us to stop overcommitting before we
> potentially lose this space to a data allocation.  With this fix in
> place we properly allocate a metadata chunk before we're completely
> full, allowing for enough slack space in metadata.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/space-info.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index d7e8cd4f140c..7aa53058d893 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -365,6 +365,23 @@ static u64 calc_available_free_space(struct btrfs_fs_info *fs_info,
>  	factor = btrfs_bg_type_to_factor(profile);
>  	avail = div_u64(avail, factor);
>  
> +	/*
> +	 * Since data allocations immediately use block groups as part of the
> +	 * reservation, because we assume that data reservations will == actual
> +	 * usage, we could potentially overcommit and then immediately have that
> +	 * available space used by a data allocation, which could put us in a
> +	 * bind when we get close to filling the file system.
> +	 *
> +	 * To handle this simply remove 1G (which is our current maximum chunk
> +	 * allocation size) from the available space.  If we are relatively
> +	 * empty this won't affect our ability to overcommit much, and if we're
> +	 * very close to full it'll keep us from getting into a position where
> +	 * we've given ourselves very little metadata wiggle room.
> +	 */
> +	if (avail < SZ_1G)
> +		return 0;
> +	avail -= SZ_1G;

Should the value be derived from the alloc_chunk_ctl::max_chunk_size or
chunk_size? Or at least use a named constant, similar to
BTRFS_MAX_DATA_CHUNK_SIZE .

> +
>  	/*
>  	 * If we aren't flushing all things, let us overcommit up to
>  	 * 1/2th of the space. If we can flush, don't let us overcommit
> -- 
> 2.41.0
