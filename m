Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4A160CED8
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Oct 2022 16:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbiJYOWJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Oct 2022 10:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiJYOWF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Oct 2022 10:22:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81D228E01
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Oct 2022 07:21:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 633161F88E;
        Tue, 25 Oct 2022 14:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666707714;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=//iq6U1OSj9JkiCXKe9dQWQFXHbP7C5/mkomw462cpM=;
        b=TbMk1m0z24rD0OYJoXIyje8yDQzqhgUuYl6M04WIO6YesWGMDlNhTnHcKJi/uoCiHvuCgY
        6nyxQUIACHQ3IiQjs2cDzfvR6XV75dhK//oLjwKNdxBo3gzoBVnC+PzmlYAvlsy/bTGQkZ
        0h4KGISR9qG7QGq5WvxSy6IjGtbBDa8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666707714;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=//iq6U1OSj9JkiCXKe9dQWQFXHbP7C5/mkomw462cpM=;
        b=cpFQi1n4YXqrLNTyZjreGdhKWQr4KMdSaWR8w6KS28NsS6BOzDom2vIyfj8VJXD+CZNZzR
        e2w5pJgfimfjZgBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 330AA13A64;
        Tue, 25 Oct 2022 14:21:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /q9kCwLxV2PNWQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 25 Oct 2022 14:21:54 +0000
Date:   Tue, 25 Oct 2022 16:21:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC 5/5] btrfs: raid56: do full stripe data checksum
 verification before RMW
Message-ID: <20221025142140.GN5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1665730948.git.wqu@suse.com>
 <9389bb7901990ef7c0d0c58dc4c1168fd4240d27.1665730948.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9389bb7901990ef7c0d0c58dc4c1168fd4240d27.1665730948.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 14, 2022 at 03:17:13PM +0800, Qu Wenruo wrote:
> [BUG]
> For the following small script, btrfs will be unable to recover the
> content of file1:
> 
>   mkfs.btrfs -f -m raid1 -d raid5 -b 1G $dev1 $dev2 $dev3
> 
>   mount $dev1 $mnt
>   xfs_io -f -c "pwrite -S 0xff 0 64k" -c sync $mnt/file1
>   md5sum $mnt/file1
>   umount $mnt
> 
>   # Corrupt the above 64K data stripe.
>   xfs_io -f -c "pwrite -S 0x00 323026944 64K" -c sync $dev3
>   mount $dev1 $mnt
> 
>   # Write a new 64K, which should be in the other data stripe
>   # And this is a sub-stripe write, which will cause RMW
>   xfs_io -f -c "pwrite 0 64k" -c sync $mnt/file2
>   md5sum $mnt/file1
>   umount $mnt
> 
> Above md5sum would fail.
> 
> [CAUSE]
> There is a long existing problem for raid56 (not limited to btrfs
> raid56) that, if we already have some corrupted on-disk data, and then
> trigger a sub-stripe write (which needs RMW cycle), it can cause further
> damage into P/Q stripe.
> 
>   Disk 1: data 1 |0x000000000000| <- Corrupted
>   Disk 2: data 2 |0x000000000000|
>   Disk 2: parity |0xffffffffffff|
> 
> In above case, data 1 is already corrupted, the original data should be
> 64KiB of 0xff.
> 
> At this stage, if we read data 1, and it has data checksum, we can still
> recover going the regular RAID56 recovery path.
> 
> But if now we decide to write some data into data 2, then we need to go
> RMW.
> Just say we want to write 64KiB of '0x00' into data 2, then we read the
> on-disk data of data 1, calculate the new parity, resulting the
> following layout:
> 
>   Disk 1: data 1 |0x000000000000| <- Corrupted
>   Disk 2: data 2 |0x000000000000| <- New '0x00' writes
>   Disk 2: parity |0x000000000000| <- New Parity.
> 
> But the new parity is calculated using the *corrupted* data 1, we can
> no longer recover the correct data of data1.
> Thus the corruption is forever there.
> 
> [FIX]
> To solve above problem, this patch will do a full stripe data checksum
> verification at RMW time.
> 
> This involves the following changes:
> 
> - For raid56_rmw_stripe() we need to read the full stripe
>   Unlike the old behavior, which will only read out the missing part,
>   now we have to read out the full stripe (including data and P/Q), so
>   we can do recovery later.
> 
>   All the read will directly go into the rbio stripe sectors.
> 
>   This will not affect cached case, as cached rbio will always has all
>   its data sectors cached. And since cached sectors are already
>   after a RMW (which implies the same data csum check), they should be
>   always correct.
> 
> - Do data checksum verification for the full stripe
>   The target is only the rbio stripe sectors.
> 
>   The checksum is already filled before we reach finish_rmw().
>   Currently we only do the verification if there is no missing device.
> 
>   The checksum verification will do the following work:
> 
>   * Verify the data checksums for sectors which has data checksum of
>     a vertical stripe.
> 
>     For sectors which doesn't has csum, they will be considered fine.
> 
>   * Check if we need to repair the vertical stripe
> 
>     If no checksum mismatch, we can continue to the next vertical
>     stripe.
>     If too many corrupted sectors than the tolerance, we error out,
>     marking all the bios failed, to avoid further corruption.
> 
>   * Repair the vertical stripe
> 
>   * Recheck the content of the failed sectors
> 
>     If repaired sectors can not pass the checksum verification, we
>     error out
> 
> This is a much strict workflow, meaning now we will not write a full
> stripe if it can not pass full stripe data verification.
> 
> Obviously this will have a performance impact, as we are doing more
> works during RMW cycle:
> 
> - Fetch the data checksum
> - Do checksum verification for all data stripes
> - Do recovery if needed
> - Do checksum verification again
> 
> But for full stripe write we won't do it at all, thus for fully
> optimized RAID56 workload (always full stripe write), there should be no
> extra overhead.
> 
> To me, the extra overhead looks reasonable, as data consistency is way
> more important than performance.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/raid56.c | 279 +++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 251 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 8f7e25001a2b..e51c07bd4c7b 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -1203,6 +1203,150 @@ static void bio_get_trace_info(struct btrfs_raid_bio *rbio, struct bio *bio,
>  	trace_info->stripe_nr = -1;
>  }
>  
> +static void assign_one_failed(int failed, int *faila, int *failb)
> +{
> +	if (*faila < 0)
> +		*faila = failed;
> +	else if (*failb < 0)
> +		*failb = failed;
> +}
> +
> +static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
> +			    int extra_faila, int extra_failb,
> +			    void **pointers, void **unmap_array);
> +
> +static int rmw_validate_data_csums(struct btrfs_raid_bio *rbio)
> +{
> +	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
> +	int sector_nr;
> +	int tolerance;
> +	void **pointers = NULL;
> +	void **unmap_array = NULL;
> +	int ret = 0;
> +
> +	/* No checksum, no need to check. */
> +	if (!rbio->csum_buf || !rbio->csum_bitmap)
> +		return 0;
> +
> +	/* No datacsum in the range. */
> +	if (bitmap_empty(rbio->csum_bitmap,
> +			 rbio->nr_data * rbio->stripe_nsectors))
> +		return 0;
> +
> +	pointers = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
> +	unmap_array = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
> +	if (!pointers || !unmap_array) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	if (rbio->bioc->map_type & BTRFS_BLOCK_GROUP_RAID5)
> +		tolerance = 1;
> +	else
> +		tolerance = 2;

Please avoid the "if (...map & TYPE)" checks for values that we have
have in the raid attribute table, in this case it's tolerated_failures.

> +
> +	for (sector_nr = 0; sector_nr < rbio->stripe_nsectors; sector_nr++) {
> +		int stripe_nr;
> +		int found_error = 0;
>  	     total_sector_nr++) {
>  		sector = rbio_stripe_sector(rbio, stripe, sectornr);
> +		 */
> +		sector = rbio_stripe_sector(rbio, stripe, sectornr);
>  	bio_endio(bio);

> +static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
> +			    int extra_faila, int extra_failb,
> +			    void **pointers, void **unmap_array)
>  {
>  	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
>  	struct sector_ptr *sector;
>  	const u32 sectorsize = fs_info->sectorsize;
> -	const int faila = rbio->faila;
> -	const int failb = rbio->failb;
> +	int faila = -1;
> +	int failb = -1;
> +	int failed = 0;
> +	int tolerance;
>  	int stripe_nr;
>  
> +	if (rbio->bioc->map_type & BTRFS_BLOCK_GROUP_RAID5)
> +		tolerance = 1;
> +	else
> +		tolerance = 2;

And here.

> +
> +	failed = calculate_failab(rbio, extra_faila, extra_failb, &faila, &failb);
> +
> +	if (failed > tolerance)
> +		return -EIO;
> +
>  	/*
>  	 * Now we just use bitmap to mark the horizontal stripes in
>  	 * which we have data when doing parity scrub.
>  	 */
>  	if (rbio->operation == BTRFS_RBIO_PARITY_SCRUB &&
>  	    !test_bit(sector_nr, &rbio->dbitmap))
> -		return;
> +		return 0;
>  
>  	/*
>  	 * Setup our array of pointers with sectors from each stripe
