Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA60E57A675
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 20:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiGSS0C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jul 2022 14:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiGSS0B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jul 2022 14:26:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BD7459A1
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 11:26:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AE4D9348B7;
        Tue, 19 Jul 2022 18:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658255159;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OZqowyGqBTqf3xW4cVVspkQDKGFHmJoVNcH3S0XVk7A=;
        b=AHSEiO+p6ck56cBcUt9JL4sRFIpCzy7hhFcfzVtHK1458brFLv1BoTamRce6x05Uobpg4C
        zW/eHZWo+xKEVodgMYnGycfyJDA15+u5Op6ver+5T69IU5FeB7XhjCvtk779CTo7udKZF3
        j3PAIwqTG9aVsvXh72Wk/SVgDNnEuM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658255159;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OZqowyGqBTqf3xW4cVVspkQDKGFHmJoVNcH3S0XVk7A=;
        b=BwNeCgytmVg23gPy6ZHF2czUzzJv+qTmiA/ptpDdVL8P55t8BVTnfN0J3FWQ3cLsDEQRMq
        cZ8uNVptW6LLrFAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E52F13A72;
        Tue, 19 Jul 2022 18:25:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id obgIHjf31mLDVgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 19 Jul 2022 18:25:59 +0000
Date:   Tue, 19 Jul 2022 20:21:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/6] btrfs: remove the start argument to check_data_csum
Message-ID: <20220719182106.GR13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20220707053331.211259-1-hch@lst.de>
 <20220707053331.211259-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707053331.211259-5-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 07, 2022 at 07:33:29AM +0200, Christoph Hellwig wrote:
> Just derive it from the btrfs_bio now that ->file_offset is always valid.
> Also make the function available outside of inode.c as we'll need that
> soon.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/ctree.h |  2 ++
>  fs/btrfs/inode.c | 22 +++++++++-------------
>  2 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 4e2569f84aabc..164f54e6aa447 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3293,6 +3293,8 @@ int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
>  unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
>  				    u32 bio_offset, struct page *page,
>  				    u64 start, u64 end);
> +int check_data_csum(struct inode *inode, struct btrfs_bio *bbio, u32 bio_offset,
> +		    struct page *page, u32 pgoff);

Please add a btrfs_ prefix to a function that gets exported, fixed.
