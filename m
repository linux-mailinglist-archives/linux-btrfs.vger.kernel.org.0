Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AE96CABB7
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Mar 2023 19:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjC0RSC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 13:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjC0RSB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 13:18:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092DA3595
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 10:17:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AB82821D51;
        Mon, 27 Mar 2023 17:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679937478;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EztNUEx61hjGrteKvXjRpf7Jgix62Fw4MBoxmv+A93E=;
        b=lSCOuvpiEurryFKrkeqle3MagQB3H1sWKpBX59bD7w4ZiRwjvJ92Uhxp98UUuIozZWFliI
        ZYI5LL/9YBLNqf/UNyNbST3Mn7MP50Nx26IMBsAtXg8W/JLLzkpAqSmzJ1VHaBtknnPwh2
        XDEVgK3YtiLmY29I+JUYcGpyBku8xxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679937478;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EztNUEx61hjGrteKvXjRpf7Jgix62Fw4MBoxmv+A93E=;
        b=0kpSee+Ut9+RCRuIR0vbiWhmpesrAEgUbotHsj/G5UZs8Qon+fsR1XQn8cLKwg0LfigEVN
        07YhmQMMlbvG99DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 641EB13329;
        Mon, 27 Mar 2023 17:17:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gu3+FsbPIWSQaQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 27 Mar 2023 17:17:58 +0000
Date:   Mon, 27 Mar 2023 19:11:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/4] Btrfs: change wait_dev_flush() return type to bool
Message-ID: <20230327171144.GH10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1679910087.git.anand.jain@oracle.com>
 <3e067c8b0956f0134501c8eea2e19c8eb5adcedc.1679910088.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e067c8b0956f0134501c8eea2e19c8eb5adcedc.1679910088.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 27, 2023 at 05:53:09PM +0800, Anand Jain wrote:
> The flush error code is maintained in btrfs_device::last_flush_error, so
> there is no point in returning it in wait_dev_flush() when it is not being
> used. Instead, we can return a boolean value.
> 
> Note that even though btrfs_device::last_flush_error may not be used, we
> will keep it for now.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/disk-io.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 745be1f4ab6d..040142f2e76c 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4102,13 +4102,14 @@ static void write_dev_flush(struct btrfs_device *device)
>  
>  /*
>   * If the flush bio has been submitted by write_dev_flush, wait for it.
> + * Return false for any error, and true otherwise.

This does not match how the function is used, originally a zero value
means no error, now zero (false) means an error.

4152         list_for_each_entry(dev, head, dev_list) {
4153                 if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state))
4154                         continue;
4155                 if (!dev->bdev) {
4156                         errors_wait++;
4157                         continue;
4158                 }
4159                 if (!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &dev->dev_state) ||
4160                     !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))
4161                         continue;
4162
4163                 ret = wait_dev_flush(dev);
4164                 if (ret)
4165                         errors_wait++;
4166         }

So here it's reversed (with all patches applied). You could keep the
meaning of the retrun value to be true=ok, false=error, it's still
understandable if there conditions looks like

	ret = wait_dev_flush()
	if (!ret)
		errors++;

Another pattern is to return true on errors (typically functions that
check some condition), so it's the conditions are structured as:

	if (error)
		handle();

>   */
> -static blk_status_t wait_dev_flush(struct btrfs_device *device)
> +static bool wait_dev_flush(struct btrfs_device *device)
>  {
>  	struct bio *bio = &device->flush_bio;
>  
>  	if (!test_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state))
> -		return BLK_STS_OK;
> +		return true;

This should be 'false'

>  
>  	clear_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state);
>  	wait_for_completion_io(&device->flush_wait);
> @@ -4116,9 +4117,10 @@ static blk_status_t wait_dev_flush(struct btrfs_device *device)
>  	if (bio->bi_status) {
>  		device->last_flush_error = bio->bi_status;
>  		btrfs_dev_stat_inc_and_print(device, BTRFS_DEV_STAT_FLUSH_ERRS);
> +		return false;
>  	}
>  
> -	return bio->bi_status;
> +	return true;
>  }
