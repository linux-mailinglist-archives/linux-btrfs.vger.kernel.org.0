Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0396BD739
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Mar 2023 18:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjCPRhw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Mar 2023 13:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjCPRht (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Mar 2023 13:37:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20160D588C
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Mar 2023 10:37:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B8B1B1FDB0;
        Thu, 16 Mar 2023 17:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678988262;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YPB4Rj1ncr3qPvCdDJ54dmAtBv2DxMxCFFqcuhWPUsM=;
        b=gFabpDSiJAywZWpDiWE+ED4J+ZDLAmraz6yWFaCy4JS42fXCFWn8Fn7ld2vLqL7epuUhXB
        13cbFHuEyGiwNp4EpQ5qKaUzrfyaDHp9ijx8y+r4M/v2sLWlU43Vg/klQpnQMyMo2BzW7o
        /XA2ndYZw9x1wmj6NCxMUA+Dp86ppsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678988262;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YPB4Rj1ncr3qPvCdDJ54dmAtBv2DxMxCFFqcuhWPUsM=;
        b=VjBZg+j9vuSz+VKdUU9jZ5JdbgsUBmqFfAd8jqxwjIaBV/8V4RyM1fVbSLhW75gsiH43Ul
        CwJyDrgHo2mj3+Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 81F2B13A2F;
        Thu, 16 Mar 2023 17:37:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ais4HuZTE2QYTAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 16 Mar 2023 17:37:42 +0000
Date:   Thu, 16 Mar 2023 18:31:34 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/10] btrfs: use a plain workqueue for ordered_extent
 processing
Message-ID: <20230316173134.GC10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230314165910.373347-1-hch@lst.de>
 <20230314165910.373347-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314165910.373347-2-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 14, 2023 at 05:59:01PM +0100, Christoph Hellwig wrote:
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1632,8 +1632,6 @@ static void btrfs_resize_thread_pool(struct btrfs_fs_info *fs_info,
>  	btrfs_workqueue_set_max(fs_info->hipri_workers, new_pool_size);
>  	btrfs_workqueue_set_max(fs_info->delalloc_workers, new_pool_size);
>  	btrfs_workqueue_set_max(fs_info->caching_workers, new_pool_size);
> -	btrfs_workqueue_set_max(fs_info->endio_write_workers, new_pool_size);
> -	btrfs_workqueue_set_max(fs_info->endio_freespace_worker, new_pool_size);

I haven't noticed in the past workque patches but here we lose the
connection of mount option thread_pool and max_active per workqueue.
