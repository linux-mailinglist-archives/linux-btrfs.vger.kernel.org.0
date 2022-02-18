Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B344BBDA0
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 17:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237969AbiBRQiL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 11:38:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiBRQiL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 11:38:11 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F41106114
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 08:37:54 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 030E61F380;
        Fri, 18 Feb 2022 16:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645202273;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DP8vKm+JvtYsCdoH/BjS5h4/8IU8lsE0z/fQx4E+XUY=;
        b=SifjFmoqGHvzQuOZQOdb2z1iXCWSFw1OEmqodYSL4V1AuBzRwHCw8kw7Y3Uo0ixEzWQ1vk
        FvyYSFr0b7apVPqGp0FjABKldDksbjLNfmj84AuIGJfo0BoUc6ylHrewTLCleVZ5YLSsZy
        y+PER0nhRcFckmn9B7rQDvSM0HEdgIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645202273;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DP8vKm+JvtYsCdoH/BjS5h4/8IU8lsE0z/fQx4E+XUY=;
        b=f68t7fQ/fqr5LEPjQr1nAFu2+jSHZ8NEmSt6FvvKK1ua1io/Qxh540MCGwHqZGr5Dm3hq3
        aC9k4P4AdXDv2wBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id EFD85A3B81;
        Fri, 18 Feb 2022 16:37:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 504A7DA829; Fri, 18 Feb 2022 17:34:07 +0100 (CET)
Date:   Fri, 18 Feb 2022 17:34:07 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 6/8] btrfs: do not double complete bio on errors
 during compressed reads
Message-ID: <20220218163407.GA12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1645196493.git.josef@toxicpanda.com>
 <1bf9827c7aad64c1686e1d6d51bc7a023f989c33.1645196493.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bf9827c7aad64c1686e1d6d51bc7a023f989c33.1645196493.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 18, 2022 at 10:03:27AM -0500, Josef Bacik wrote:
> @@ -2542,10 +2542,14 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
>  			goto out;
>  
>  		if (bio_flags & EXTENT_BIO_COMPRESSED) {
> -			ret = btrfs_submit_compressed_read(inode, bio,
> -							   mirror_num,
> -							   bio_flags);
> -			goto out;
> +			/*
> +			 * btrfs_submit_compressed_read will handle completing
> +			 * the bio if there were any errors, so just return
> +			 * here.
> +			 */
> +			return btrfs_submit_compressed_read(inode, bio,
> +							    mirror_num,
> +							    bio_flags);

All the other error branches do a goto, so I'll convert this too so it's
consistent.
