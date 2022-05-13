Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CC25268AB
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 May 2022 19:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383155AbiEMRlp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 May 2022 13:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378054AbiEMRln (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 May 2022 13:41:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDA9377FA
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 10:41:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7A5851F964;
        Fri, 13 May 2022 17:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652463700;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5zqQSdg9GAanGfNoHpCh6+y0zDnyczK6IWxCvAVrIcU=;
        b=HAdKaoT2zD2rYXHz5dyeMKxwKOcH90pLhHctGxLm/h0jzD9OPdxP9DL1LIxqqhWerG8zmR
        TF4oJTtD6JmMNTMFl0DOWIo3HWtTze9hGcKkBpUFveEd8RFJpzEUQ8Pqvh0Jw8CZorCidc
        5uQYyLKPXO7hbV14ZrzrR1jA8HOhu7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652463700;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5zqQSdg9GAanGfNoHpCh6+y0zDnyczK6IWxCvAVrIcU=;
        b=rx+Y/S48tGM2YNTCLBMml4eGfjywVKNpk3L7KVy3fqn7QNcaf+sB37xhBGA6j9SzyjScjz
        nGMKg+KNOPHNDBAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4CD8813446;
        Fri, 13 May 2022 17:41:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pmCvEVSYfmIrWgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 13 May 2022 17:41:40 +0000
Date:   Fri, 13 May 2022 19:37:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: zoned: introduce a minimal zone size and
 reject mount
Message-ID: <20220513173723.GW18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <8aa15bbbacbafa2ab77c01bfdfdabe65d6bfa606.1652457157.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aa15bbbacbafa2ab77c01bfdfdabe65d6bfa606.1652457157.git.johannes.thumshirn@wdc.com>
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

On Fri, May 13, 2022 at 08:52:52AM -0700, Johannes Thumshirn wrote:
> Zoned devices are expected to have zone sizes in the range of 1-2GB for
> ZNS SSDs and SMR HDDs have zone sizes of 256MB, so there is no need to
> allow arbitrarily small zone sizes on btrfs.
> 
> But for testing purposes with emulated devices it is sometimes desirable
> to create devices with as small as 4MB zone size to uncover errors.
> 
> So use 4MB as the smallest possible zone size and reject mounts of devices
> with a smaller zone size.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Thanks, added to misc-next.

> ---
>  fs/btrfs/zoned.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 1b1b310c3c51..d9579d4ec0f2 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -51,11 +51,13 @@
>  #define BTRFS_MIN_ACTIVE_ZONES		(BTRFS_SUPER_MIRROR_MAX + 5)
>  
>  /*
> - * Maximum supported zone size. Currently, SMR disks have a zone size of
> - * 256MiB, and we are expecting ZNS drives to be in the 1-4GiB range. We do not
> - * expect the zone size to become larger than 8GiB in the near future.
> + * Minimum / maximum supported zone size. Currently, SMR disks have a zone
> + * size of 256MiB, and we are expecting ZNS drives to be in the 1-4GiB range.
> + * We do not expect the zone size to become larger than 8GiB or smaller than
> + * 4MiB in the near future.
>   */
>  #define BTRFS_MAX_ZONE_SIZE		SZ_8G
> +#define BTRFS_MIN_ZONE_SIZE		(4 * SZ_1M)

I've checked if the SZ_4M constant exists, it does so I'll use it.
