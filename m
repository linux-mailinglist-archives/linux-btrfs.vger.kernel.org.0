Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888F15750D7
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 16:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbiGNOae (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jul 2022 10:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiGNOaa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jul 2022 10:30:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0345C377
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jul 2022 07:30:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6FD0B1F460;
        Thu, 14 Jul 2022 14:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657809028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=opU1OoOaclhSjWJSLJVu+b8kpg9TaFtDWh2zliFUsUc=;
        b=ucx0X2s7I/qYzihIS+bNtb/5EklRAfuZ6ABPAZXf/0GMVpT0YIopYpOIDHLClN/d/gBCpx
        KGAC7og2Y5Sh69T88aekywv+lQWe6UkM1YXtLKpyhItJZ1oZe3l6EYKeGT6qNeeXzvDfVd
        mqg20SKq3SGV95CCEOY4bEg+yUFVuWk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0AEF9133A6;
        Thu, 14 Jul 2022 14:30:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GGD4OoMo0GKoNQAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 14 Jul 2022 14:30:27 +0000
Message-ID: <a5f6640c-e597-4ed3-939b-d59561684e15@suse.com>
Date:   Thu, 14 Jul 2022 17:30:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 09/11] btrfs: simplify the submit_stripe_bio calling
 convention
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20220713061359.1980118-1-hch@lst.de>
 <20220713061359.1980118-10-hch@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220713061359.1980118-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.07.22 г. 9:13 ч., Christoph Hellwig wrote:
> Remove the orig_bio argument as it can be derived from the bioc, and
> the clone argument as it can be calculated from bioc and dev_nr.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
>   fs/btrfs/volumes.c | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index d5b6777874e3c..73e538da31bc4 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6785,13 +6785,12 @@ static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
>   	submit_bio(bio);
>   }
>   
> -static void submit_stripe_bio(struct btrfs_io_context *bioc,
> -			      struct bio *orig_bio, int dev_nr, bool clone)
> +static void submit_stripe_bio(struct btrfs_io_context *bioc, int dev_nr)
>   {
> -	struct bio *bio;
> +	struct bio *orig_bio = bioc->orig_bio, *bio;
>   
>   	/* Reuse the bio embedded into the btrfs_bio for the last mirror */
> -	if (!clone) {
> +	if (dev_nr == bioc->num_stripes - 1) {

nit: I think this warrants a comment that the last bios being submitted 
is always the orig one.

>   		bio = orig_bio;
>   		btrfs_bio(bio)->device = bioc->stripes[dev_nr].dev;
>   		bio->bi_end_io = btrfs_end_bio;
> @@ -6847,11 +6846,8 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror
>   		BUG();
>   	}
>   
> -	for (dev_nr = 0; dev_nr < total_devs; dev_nr++) {
> -		const bool should_clone = (dev_nr < total_devs - 1);
> -
> -		submit_stripe_bio(bioc, bio, dev_nr, should_clone);
> -	}
> +	for (dev_nr = 0; dev_nr < total_devs; dev_nr++)
> +		submit_stripe_bio(bioc, dev_nr);
>   }
>   
>   static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_args *args,
