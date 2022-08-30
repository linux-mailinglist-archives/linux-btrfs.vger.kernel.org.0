Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D545A6B12
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Aug 2022 19:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbiH3RpX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Aug 2022 13:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiH3Rot (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Aug 2022 13:44:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0DD9E8B2
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Aug 2022 10:41:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2FF7822045;
        Tue, 30 Aug 2022 17:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661880970;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6N/rOmUNtGz9zqaN2CKsrpORLrauaLBiKwsghgbYuzg=;
        b=bJDbx09Km9T0XrvHB5FrnUJg2xSZOEigDjjahrVoTERXDYCM5clJHgwbIJjb99qFM4RAHP
        X+9CiLLVt8iJ7UapZt6VzF5rJeLD2YdSag/K82t7R65SY/1URi/iImIVNMo7PNhDalhc3J
        XLGJO3uF4qByaphY0Lh59H9ZYaOFWD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661880970;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6N/rOmUNtGz9zqaN2CKsrpORLrauaLBiKwsghgbYuzg=;
        b=ynhb7XDtW1FwOMuo7pFIA83hs7r2NqENKX6OR6JPoWstklHm0jCIcTG3bdIOuqancis2D4
        W5c2qSiMvwCGDzDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E52F513B0C;
        Tue, 30 Aug 2022 17:36:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Z1H9NolKDmNGZAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 30 Aug 2022 17:36:09 +0000
Date:   Tue, 30 Aug 2022 19:30:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Li Zhang <zhanglikernel@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH V2] Make btrfs_prepare_device parallel during mkfs.btrfs
Message-ID: <20220830173051.GC13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Li Zhang <zhanglikernel@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <1661697000-18809-1-git-send-email-zhanglikernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1661697000-18809-1-git-send-email-zhanglikernel@gmail.com>
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

On Sun, Aug 28, 2022 at 10:30:00PM +0800, Li Zhang wrote:
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
> But I don't have an actual zoed device,
> so I don't know how much time it saves, If you guys
> have a way to test it, please let me know.

Zoned devices can be emulated and backed by normal disk partitions using
eg. TCMU, the memory-backed emulation using null_blk would be probably
too fast to see if the parallelization helps.

> Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
> ---
> Issue: 496
> 
> V1:
> * Put btrfs_prepare_device into threads and make them parallel
> 
> V2:
> * Set the 4 variables used by btrfs_prepare_device as global variables.
> * Use pthread_mutex to ensure error messages are not messed up.
> * Correct the error message
> * Wait for all threads to exit in a loop
> 
>  mkfs/main.c | 132 +++++++++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 95 insertions(+), 37 deletions(-)
> 
> diff --git a/mkfs/main.c b/mkfs/main.c
> index ce096d3..b111f12 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -31,6 +31,7 @@
>  #include <uuid/uuid.h>
>  #include <ctype.h>
>  #include <blkid/blkid.h>
> +#include <pthread.h>
>  #include "kernel-shared/ctree.h"
>  #include "kernel-shared/disk-io.h"
>  #include "kernel-shared/free-space-tree.h"
> @@ -60,6 +61,20 @@ struct mkfs_allocation {
>  	u64 system;
>  };
>  
> +static bool zero_end;
> +static bool discard;
> +static bool zoned;
> +static int oflags;

Please add some prefix to the global variables, eg. opt_.

> +static pthread_mutex_t prepare_mutex;
> +
> +struct prepare_device_progress {
> +	char *file;
> +	u64 dev_block_count;
> +	u64 block_count;
> +	int ret;
> +};
> +
>  static int create_metadata_block_groups(struct btrfs_root *root, bool mixed,
>  				struct mkfs_allocation *allocation)
>  {
> @@ -969,6 +984,30 @@ fail:
>  	return ret;
>  }
>  
> +static void *prepare_one_dev(void *ctx)
> +{
> +	struct prepare_device_progress *prepare_ctx = ctx;
> +	int fd;
> +
> +	fd = open(prepare_ctx->file, oflags);
> +	if (fd < 0) {
> +		pthread_mutex_lock(&prepare_mutex);
> +		error("unable to open %s: %m", prepare_ctx->file);
> +		pthread_mutex_unlock(&prepare_mutex);
> +		prepare_ctx->ret = fd;
> +		return NULL;
> +	}
> +	prepare_ctx->ret = btrfs_prepare_device(fd,
> +		prepare_ctx->file, &prepare_ctx->dev_block_count,
> +		prepare_ctx->block_count,
> +		(bconf.verbose ? PREP_DEVICE_VERBOSE : 0) |
> +		(zero_end ? PREP_DEVICE_ZERO_END : 0) |
> +		(discard ? PREP_DEVICE_DISCARD : 0) |
> +		(zoned ? PREP_DEVICE_ZONED : 0));

Please format the arguments by a few tabs, like that it looks like
several statements.

> +	close(fd);
> +	return NULL;
> +}
> +
>  int BOX_MAIN(mkfs)(int argc, char **argv)
>  {
>  	char *file;
> @@ -984,7 +1023,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  	u32 nodesize = 0;
>  	u32 sectorsize = 0;
>  	u32 stripesize = 4096;
> -	bool zero_end = true;
> +	zero_end = true;
>  	int fd = -1;
>  	int ret = 0;
>  	int close_ret;
> @@ -993,11 +1032,10 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  	bool nodesize_forced = false;
>  	bool data_profile_opt = false;
>  	bool metadata_profile_opt = false;
> -	bool discard = true;
> +	discard = true;
>  	bool ssd = false;
> -	bool zoned = false;
> +	zoned = false;
>  	bool force_overwrite = false;
> -	int oflags;
>  	char *source_dir = NULL;
>  	bool source_dir_set = false;
>  	bool shrink_rootdir = false;
> @@ -1006,6 +1044,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  	u64 shrink_size;
>  	int dev_cnt = 0;
>  	int saved_optind;
> +	pthread_t *t_prepare = NULL;
> +	struct prepare_device_progress *prepare_ctx = NULL;
>  	char fs_uuid[BTRFS_UUID_UNPARSED_SIZE] = { 0 };
>  	u64 features = BTRFS_MKFS_DEFAULT_FEATURES;
>  	u64 runtime_features = BTRFS_MKFS_DEFAULT_RUNTIME_FEATURES;
> @@ -1428,29 +1468,49 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  		goto error;
>  	}
>  
> -	dev_cnt--;
> +	t_prepare = calloc(dev_cnt, sizeof(*t_prepare));
> +	prepare_ctx = calloc(dev_cnt, sizeof(*prepare_ctx));
> +
> +	if (!t_prepare || !prepare_ctx) {
> +		error("unable to alloc thread for preparing dev");
> +		goto error;
> +	}
>  
> +	pthread_mutex_init(&prepare_mutex, NULL);
> +	zero_end = zero_end;
> +	discard = discard;
> +	zoned = zoned;
>  	oflags = O_RDWR;
> -	if (zoned && zoned_model(file) == ZONED_HOST_MANAGED)
> -		oflags |= O_DIRECT;
> +	for (i = 0; i < dev_cnt; i++) {
> +		if (zoned && zoned_model(argv[optind + i - 1]) ==
> +			ZONED_HOST_MANAGED) {
> +			oflags |= O_DIRECT;
> +			break;
> +		}
> +	}
> +	for (i = 0; i < dev_cnt; i++) {
> +		prepare_ctx[i].file = argv[optind + i - 1];
> +		prepare_ctx[i].block_count = block_count;
> +		prepare_ctx[i].dev_block_count = block_count;
> +		ret = pthread_create(&t_prepare[i], NULL,
> +			prepare_one_dev, &prepare_ctx[i]);
> +		if (ret) {
> +			error("create thread for prepare devices failed, errno:%d", ret);

The error message could say at which device it failed.

> +			goto error;
> +		}
> +	}
> +	for (i = 0; i < dev_cnt; i++)
> +		pthread_join(t_prepare[i], NULL);
> +	ret = prepare_ctx[0].ret;
>  
> -	/*
> -	 * Open without O_EXCL so that the problem should not occur by the
> -	 * following operation in kernel:
> -	 * (btrfs_register_one_device() fails if O_EXCL is on)
> -	 */
> -	fd = open(file, oflags);
> -	if (fd < 0) {
> -		error("unable to open %s: %m", file);
> +	if (ret) {
> +		error("unable prepare device:%s.\n", prepare_ctx[0].file);

error() appends the "\n" and there should be no "." at the end and there
should be a space after ":".

>  		goto error;
>  	}
> -	ret = btrfs_prepare_device(fd, file, &dev_block_count, block_count,
> -			(zero_end ? PREP_DEVICE_ZERO_END : 0) |
> -			(discard ? PREP_DEVICE_DISCARD : 0) |
> -			(bconf.verbose ? PREP_DEVICE_VERBOSE : 0) |
> -			(zoned ? PREP_DEVICE_ZONED : 0));
> -	if (ret)
> -		goto error;
> +
> +	dev_cnt--;
> +	fd = open(file, oflags);

Where does the error handling happen for this open() ?

> +	dev_block_count = prepare_ctx[0].dev_block_count;
>  	if (block_count && block_count > dev_block_count) {
>  		error("%s is smaller than requested size, expected %llu, found %llu",
>  		      file, (unsigned long long)block_count,
> @@ -1459,7 +1519,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  	}
>  
>  	/* To create the first block group and chunk 0 in make_btrfs */
> -	system_group_size = zoned ?  zone_size(file) : BTRFS_MKFS_SYSTEM_GROUP_SIZE;
> +	system_group_size = zoned ? zone_size(file) : BTRFS_MKFS_SYSTEM_GROUP_SIZE;
>  	if (dev_block_count < system_group_size) {
>  		error("device is too small to make filesystem, must be at least %llu",
>  				(unsigned long long)system_group_size);
> @@ -1558,14 +1618,10 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  		goto raid_groups;
>  
>  	while (dev_cnt-- > 0) {
> +		int dev_index = argc - saved_optind - dev_cnt - 1;
>  		file = argv[optind++];
>  
> -		/*
> -		 * open without O_EXCL so that the problem should not
> -		 * occur by the following processing.
> -		 * (btrfs_register_one_device() fails if O_EXCL is on)
> -		 */
> -		fd = open(file, O_RDWR);
> +		fd = open(file, oflags);
>  		if (fd < 0) {
>  			error("unable to open %s: %m", file);
>  			goto error;
> @@ -1578,13 +1634,11 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  			close(fd);
>  			continue;
>  		}
> -		ret = btrfs_prepare_device(fd, file, &dev_block_count,
> -				block_count,
> -				(bconf.verbose ? PREP_DEVICE_VERBOSE : 0) |
> -				(zero_end ? PREP_DEVICE_ZERO_END : 0) |
> -				(discard ? PREP_DEVICE_DISCARD : 0) |
> -				(zoned ? PREP_DEVICE_ZONED : 0));
> -		if (ret) {
> +		dev_block_count = prepare_ctx[dev_index]
> +			.dev_block_count;
> +
> +		if (prepare_ctx[dev_index].ret) {
> +			error("unable prepare device:%s.\n", prepare_ctx[dev_index].file);
>  			goto error;
>  		}
>  
> @@ -1763,12 +1817,16 @@ out:
>  
>  	btrfs_close_all_devices();
>  	free(label);
> -
> +	free(t_prepare);
> +	free(prepare_ctx);
>  	return !!ret;
> +
>  error:
>  	if (fd > 0)
>  		close(fd);
>  
> +	free(t_prepare);
> +	free(prepare_ctx);
>  	free(label);
>  	exit(1);
>  success:
> -- 
> 1.8.3.1
