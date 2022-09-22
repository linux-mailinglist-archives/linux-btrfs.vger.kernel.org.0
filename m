Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9515E6FC1
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Sep 2022 00:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiIVWeH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Sep 2022 18:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiIVWdm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Sep 2022 18:33:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73168F9624
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 15:33:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2C8CA1F8BD;
        Thu, 22 Sep 2022 22:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663886020;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8T9AJKmDs4w74L5QjQ08UbOyql79HPyGrV+0esu0tpg=;
        b=PV+NpoyRuQ1gm/8z66I6sxhVOrtY1avJzfXSFkwT2VTnN07w+WL2qOHZjHET9rLEghsdmL
        AlvuDr5A32ymkB6DQT39qA2ApMRTnPNI1rKeCiA2xuPrFNI2I/uk2EsJVBjMADEuA1bSKZ
        w3RljJ6hCmWz/NbexT7v5wt3AdHlRyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663886020;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8T9AJKmDs4w74L5QjQ08UbOyql79HPyGrV+0esu0tpg=;
        b=Ws78MsQ2O7+7co8xEJaDCmDVbn3UnOrpNK1iGPWwT5Rp7l2XwWnZI/8qi5Vw6t1ukB3eNk
        H8MPP9RRX0W5xdCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B7EA13AA5;
        Thu, 22 Sep 2022 22:33:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7ICuAcTiLGN8QgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 22 Sep 2022 22:33:40 +0000
Date:   Fri, 23 Sep 2022 00:28:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Li Zhang <zhanglikernel@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH V4] btrfs-progs: Make btrfs_prepare_device parallel
 during mkfs.btrfs
Message-ID: <20220922222807.GO32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <1662279863-17114-1-git-send-email-zhanglikernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662279863-17114-1-git-send-email-zhanglikernel@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Sep 04, 2022 at 04:24:23PM +0800, Li Zhang wrote:
> [enhancement]
> When a disk is formatted as btrfs, it calls
> btrfs_prepare_device for each device, which takes too much time.
> 
> [implementation]
> Put each btrfs_prepare_device into a thread,
> wait for the first thread to complete to mkfs.btrfs,
> and wait for other threads to complete before adding
> other devices to the file system.
> 
> [test]
> Using the btrfs-progs test case mkfs-tests, mkfs.btrfs works fine.
> 
> Use tcmu-runner emulation to simulate two devices for testing.
> Each device is 2000G (about 19.53 TiB), the region size is 4MB,
> Use the following parameters for targetcli
> create name=zbc0 size=20000G cfgstring=model-HM/zsize-4/conv-100@~/zbc0.raw
> 
> Call difftime to calculate the running time of the function btrfs_prepare_device.
> Calculate the time from thread creation to completion of all threads after
> patching (time calculation is not included in patch submission)
> The test results are as follows.
> 
> $ lsscsi -p
> [10:0:1:0]   (0x14)  LIO-ORG  TCMU ZBC device  0002  /dev/sdb   -          none
> [11:0:1:0]   (0x14)  LIO-ORG  TCMU ZBC device  0002  /dev/sdc   -          none
> 
> $ sudo mkfs.btrfs -d single -m single -O zoned /dev/sdc /dev/sdb -f
> ....
> time for prepare devices:4.000000.
> ....
> 
> $ sudo mkfs.btrfs -d single -m single -O zoned /dev/sdc /dev/sdb -f
> ...
> time for prepare devices:2.000000.
> ...
> 
> Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
> ---
> Issue: 496

Thanks for implementing it. I did only some style fixups but the
parallel zone reset works (and trim/discard as well as it's the same
function).

I've tested it with the null blk devices (128M, 4M zone, 32 zones) and
added some more debugging to see how it works, with artificial delay
100ms to zone reset. The overall runtime is about the same when running
on devices:

 2 - 4s
 6 - 5s
 8 - 5s
10 - 6s

It's fast so there's some noise in the numbers but it's not linear in
the number of devices and the threads may also wait on the printing lock
as I've added some debugging messages.

Sample run with your patch reverted and same delay:

 2 - 7s
 6 - 21s
 8 - 27s
10 - 35s

> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -969,6 +984,31 @@ fail:
>  	return ret;
>  }
>  
> +static void *prepare_one_dev(void *ctx)
> +{
> +	struct prepare_device_progress *prepare_ctx = ctx;
> +	int fd;
> +
> +	fd = open(prepare_ctx->file, opt_oflags);
> +	if (fd < 0) {
> +		pthread_mutex_lock(&prepare_mutex);

Is this lock actually needed? printf is thread safe and there are other
messages printed from btrfs_prepare_device anyway, so using this lock
does not help.

> +		error("unable to open %s: %m", prepare_ctx->file);
> +		pthread_mutex_unlock(&prepare_mutex);
> +		prepare_ctx->ret = fd;
> +		return NULL;
> +	}
> +	prepare_ctx->ret = btrfs_prepare_device(fd,
> +			prepare_ctx->file,
> +			&prepare_ctx->dev_block_count,
> +			prepare_ctx->block_count,
> +			(bconf.verbose ? PREP_DEVICE_VERBOSE : 0) |
> +			(opt_zero_end ? PREP_DEVICE_ZERO_END : 0) |
> +			(opt_discard ? PREP_DEVICE_DISCARD : 0) |
> +			(opt_zoned ? PREP_DEVICE_ZONED : 0));
> +	close(fd);
> +	return NULL;
> +}
