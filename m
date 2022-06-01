Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE4A53AF3A
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 00:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbiFAU5r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 16:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiFAU5q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 16:57:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458332178A1
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 13:57:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AFB4A1F958;
        Wed,  1 Jun 2022 19:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654112482;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x9K9lNIvtcBqWIBcRyTLhlHDm69HTWsm3Hnz+8umJlM=;
        b=sTN9YbqihpEaMoP9VtcL3u/3YKN2s7RblNyRJfPZKRdJIb3iDRkeWJkFbaeTZdmHN24Jgg
        qm0x0pGKN2oItGrJrgrDCreQaEVwse4imfloZkcwf0fIqlxmfyz4nk6BqSjlLeIR2r0N1a
        mPawpaZPN4+H5zRQFAC7nSqhkkeXanQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654112482;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x9K9lNIvtcBqWIBcRyTLhlHDm69HTWsm3Hnz+8umJlM=;
        b=XwixyRJ6MjeYtctQlfFYMYXfycE3leOLuwzXZ/UUQL8wKbt6ZVcu+WYIdeRCYtedjlpsrm
        LJ+w9qqdU78rqsCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77C681330F;
        Wed,  1 Jun 2022 19:41:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fJZHHOLAl2KCFwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 01 Jun 2022 19:41:22 +0000
Date:   Wed, 1 Jun 2022 21:36:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 09/10] btrfs: refactor btrfs_map_bio
Message-ID: <20220601193656.GT20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20220526073642.1773373-1-hch@lst.de>
 <20220526073642.1773373-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526073642.1773373-10-hch@lst.de>
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

On Thu, May 26, 2022 at 09:36:41AM +0200, Christoph Hellwig wrote:
> Move all per-stripe handling into submit_stripe_bio and use a label to
> cleanup instead of duplicating the logic.

Same comment about subject here, refactoring is quite common and too
generic so "https://github.com/libfuse/sshfs".

> @@ -6787,29 +6798,11 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
>  		BUG();
>  	}
>  
> -	for (dev_nr = 0; dev_nr < total_devs; dev_nr++) {
> -		dev = bioc->stripes[dev_nr].dev;
> -		if (!dev || !dev->bdev || test_bit(BTRFS_DEV_STATE_MISSING,
> -						   &dev->dev_state) ||
> -		    (btrfs_op(first_bio) == BTRFS_MAP_WRITE &&
> -		    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
> -			atomic_inc(&bioc->error);
> -			if (atomic_dec_and_test(&bioc->stripes_pending))
> -				btrfs_end_bioc(bioc, false);
> -			continue;
> -		}
> -
> -		if (dev_nr < total_devs - 1) {
> -			bio = btrfs_bio_clone(dev->bdev, first_bio);
> -		} else {
> -			bio = first_bio;
> -			bio_set_dev(bio, dev->bdev);
> -		}
> -
> -		submit_stripe_bio(bioc, bio, bioc->stripes[dev_nr].physical, dev);
> -	}
> +	for (dev_nr = 0; dev_nr < total_devs; dev_nr++)
> +		submit_stripe_bio(bioc, bio, dev_nr, dev_nr < total_devs - 1);

Placing the conditional to parameter is really easy to overlook, it's
more clear when it's done via a temporary variable that can also
describe the semantics what the expression actually means.

I've added:

		const bool should_clone = (...);

