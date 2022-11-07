Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF68861FAC0
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Nov 2022 18:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbiKGREJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Nov 2022 12:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiKGREH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Nov 2022 12:04:07 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A4A11817
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Nov 2022 09:04:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3FFAF1F889;
        Mon,  7 Nov 2022 17:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667840644;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0UxmbGLf6luaDEyVFG81Pk6cZ+NDrIgWXVqc5CBiZjU=;
        b=zMRGwL1U7PhaXElcU835otfM1fJZME4UxWg5Alq6PCJmjoNMAtXF9A2GhDs1nkt+LCqn5A
        sWlIQ9fW1Wi2QS0JJaJVvVfO5W73BtnoSHJVnv/VeIA5nmQP9UQUhkpYSf3U/j5XFSxlvR
        Ec926Y1JjswgHl+eiPXoPPCB8sPI96A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667840644;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0UxmbGLf6luaDEyVFG81Pk6cZ+NDrIgWXVqc5CBiZjU=;
        b=g+xdun4EXeJjAUsljfy2Xm8uDaB3qWs5cCVRl0dnOJTUYefr0I0LFzjS7nk2EX2/Vk4z/N
        zRgFyyFDne4yBjAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 169B513AC7;
        Mon,  7 Nov 2022 17:04:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UdaJBIQ6aWP/egAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 07 Nov 2022 17:04:04 +0000
Date:   Mon, 7 Nov 2022 18:03:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: raid56: introduce btrfs_raid_bio::error_bitmap
Message-ID: <20221107170342.GU5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1667805755.git.wqu@suse.com>
 <aa54be41e66db516ddeb0ab3cc21e185b0b5aff3.1667805755.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa54be41e66db516ddeb0ab3cc21e185b0b5aff3.1667805755.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 07, 2022 at 03:32:29PM +0800, Qu Wenruo wrote:
> +
> +		sector = &rbio->stripe_sectors[i];
> +		if (sector->page == bv->bv_page &&
> +		    sector->pgoff == bv->bv_offset)
> +			break;
> +		sector = &rbio->bio_sectors[i];
> +		if (sector->page == bv->bv_page &&
> +		    sector->pgoff == bv->bv_offset)
> +			break;
> +	}
> +	ASSERT(i < rbio->nr_sectors);
> +	return i;
> +}
> +
> +static void rbio_update_error_bitmap(struct btrfs_raid_bio *rbio,
> +				     struct bio *bio)
> +{
> +	int total_sector_nr = get_bio_sector_nr(rbio, bio);
> +	int bio_size = 0;

bio_size is better a u32 as it's the bv_len type and there's a shift
done later.

> +	struct bio_vec *bvec;
> +	struct bvec_iter_all iter_all;
> +
> +	bio_for_each_segment_all(bvec, bio, iter_all)
> +		bio_size += bvec->bv_len;
> +
> +	bitmap_set(rbio->error_bitmap, total_sector_nr,
> +		   bio_size >> rbio->bioc->fs_info->sectorsize_bits);
> +}
> +
>  static void raid_wait_read_end_io(struct bio *bio)
>  {
>  	struct btrfs_raid_bio *rbio = bio->bi_private;
>  
> -	if (bio->bi_status)
> +	if (bio->bi_status) {
>  		fail_bio_stripe(rbio, bio);
> -	else
> +		rbio_update_error_bitmap(rbio, bio);
> +	} else
>  		set_bio_pages_uptodate(rbio, bio);

The else branch needs { }
