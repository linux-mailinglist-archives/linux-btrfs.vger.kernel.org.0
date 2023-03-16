Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164216BD3EA
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Mar 2023 16:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjCPPgV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Mar 2023 11:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjCPPgB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Mar 2023 11:36:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7572E6FE5
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Mar 2023 08:33:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DFC681FE05;
        Thu, 16 Mar 2023 15:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678980711;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AQDOwQvo7qEZc/XtiDL5tx9HiWNb4CmWSCx7+WBBmyU=;
        b=l0h0SEjWpMNggsHturn4CPPmeVn2onUg6eHyr1lvCbA0yzKx0Fo2W5SsH+MdVMNJUu/wF6
        WxX164p1mhsAJhE3POdB7nIk7Q9eHbT8295xQSIMFDH4E7hvDQ+kXhKKe1pcg8o7K6FI3i
        slBRI6pG2cIlzHJoj3pJ0lVqWU2SL18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678980711;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AQDOwQvo7qEZc/XtiDL5tx9HiWNb4CmWSCx7+WBBmyU=;
        b=5o0/mVD5W+9D9YPOjJL9r/zRvj4pQ46K19Qqrnz9kApXZpHIMqIbO6yP7gmRklkZddBtF0
        wyTfOIqP0M1tIqCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC58213A2F;
        Thu, 16 Mar 2023 15:31:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id r6n1KGc2E2RIDQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 16 Mar 2023 15:31:51 +0000
Date:   Thu, 16 Mar 2023 16:25:44 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs-progs: filesystem-usage: handle missing seed
 device properly
Message-ID: <20230316152544.GY10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1676115988.git.wqu@suse.com>
 <0695352140625cd66a86e8a12365271def5db39b.1676115988.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0695352140625cd66a86e8a12365271def5db39b.1676115988.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 11, 2023 at 07:50:30PM +0800, Qu Wenruo wrote:
> [BUG]
> Test case btrfs/249 always fails since its introduction, the failure
> comes from "btrfs filesystem usage" subcommand, and the error output
> looks like this:
> 
>   QA output created by 249
>   ERROR: unexpected number of devices: 1 >= 1
>   ERROR: if seed device is used, try running this command as root
>   FAILED: btrfs filesystem usage, ret 1. Check btrfs.ko and btrfs-progs version.
>   (see /home/adam/xfstests/results//btrfs/249.full for details)
> 
> [CAUSE]
> In function load_device_info(), we only allocate enough space for all
> *RW* devices, expecting we can rule out all seed devices.
> 
> And in that function, we check if a device is a seed by checking its
> super block fsid.
> 
> So if a seed device is missing (it can be an seed device without any
> chunks on it, or a degraded RAID1 as seed), then we can not read the
> super block.
> 
> In that case, we just assume it's not a seed device, and causing too
> many devices than our expectation and cause the above failure.
> 
> [FIX]
> Instead of unconditionally assume a missing device is not a seed, we add
> a new safe net, is_seed_device_tree_search(), to search chunk tree and
> determine if that device is a seed or not.
> 
> And if we found the device is still a seed, then just skip it as usual.
> 
> And since we're here, extract the seed device checking into a dedicated
> helper, is_seed_device() for later expansion.
> 
> Now the test case btrfs/249 passes as expected:
> 
>   btrfs/249        2s
>   Ran: btrfs/249
>   Passed all 1 tests
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

The patch now conflicts with 32c2e57c65b997 ("btrfs-progs: read fsid
from the sysfs in device_is_seed"). I tried to resolve it but it seems
that there's some overlap. Can you please refresh and resend? Also there
are some coding style issues.

> ---
>  cmds/filesystem-usage.c | 119 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 107 insertions(+), 12 deletions(-)
> 
> diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
> index 5810324f245e..abde04d715a7 100644
> --- a/cmds/filesystem-usage.c
> +++ b/cmds/filesystem-usage.c
> @@ -700,6 +700,102 @@ out:
>  	return ret;
>  }
>  
> +/*
> + * Return 0 if this devid is not a seed device.
> + * Return 1 if this devid is a seed device.
> + * Return <0 if error (IO error or EPERM).
> + *
> + * Since this is done by tree search, it needs root privilege, and
> + * should not be triggered unless we hit a missing device and can not
> + * determine if it's a seed one.
> + */
> +static int is_seed_device_tree_search(int fd, u64 devid, const u8 *fsid)
> +{
> +	struct btrfs_ioctl_search_args args = {0};

	{ 0 }

> +	struct btrfs_ioctl_search_key *sk = &args.key;
> +	struct btrfs_ioctl_search_header *sh;
> +	struct btrfs_dev_item *dev;
> +	unsigned long off = 0;
> +	int ret;
> +	int err;

	err not needed
> +
> +	sk->tree_id = BTRFS_CHUNK_TREE_OBJECTID;
> +	sk->min_objectid = BTRFS_DEV_ITEMS_OBJECTID;
> +	sk->max_objectid = BTRFS_DEV_ITEMS_OBJECTID;
> +	sk->min_type = BTRFS_DEV_ITEM_KEY;
> +	sk->max_type = BTRFS_DEV_ITEM_KEY;
> +	sk->min_offset = devid;
> +	sk->max_offset = devid;
> +	sk->max_transid = (u64)-1;
> +	sk->nr_items = 1;
> +
> +	ret = ioctl(fd, BTRFS_IOC_TREE_SEARCH, &args);
> +	err = errno;

You need to check ret < 0 first then the errno is valid and you can use
it directly without the temporary variable.

> +	if (err == EPERM)
> +		return -err;
> +	if (ret < 0) {
> +		error("cannot lookup chunk tree info: %m");
> +		return ret;
> +	}
> +	/* No dev item found. */
> +	if (sk->nr_items == 0)
> +		return -ENOENT;
> +
> +	sh = (struct btrfs_ioctl_search_header *)(args.buf + off);
> +	off += sizeof(*sh);
> +
> +	dev = (struct btrfs_dev_item *)(args.buf + off);
> +	if (memcmp(dev->fsid, fsid, BTRFS_UUID_SIZE) == 0)
> +		return 0;
> +	return 1;
> +}
> +
> +/*
> + * Return 0 if this devid is not a seed device.
> + * Return 1 if this devid is a seed device.
> + * Return <0 if error (IO error or EPERM).
> + */
> +static int is_seed_device(int fd, u64 devid, const u8 *fsid,
> +			  const struct btrfs_ioctl_dev_info_args *dev_arg)
> +{
> +	int ret;
> +	u8 found_fsid[BTRFS_UUID_SIZE];
> +
> +	/*
> +	 * A missing device, we can not determing if it's a seed
> +	 * device by reading its super block.
> +	 * Thus we have to go tree-search to make sure if it's a seed
> +	 * device.
> +	 */
> +	if (!dev_arg->path[0]) {
> +		ret = is_seed_device_tree_search(fd, devid, fsid);
> +		if (ret < 0) {
> +			errno = -ret;
> +			warning(
> +	"unable to determine if devid %llu is seed using tree search: %m",
> +				devid);
> +			return ret;
> +		}
> +		return ret;
> +	}
> +
> +	/*
> +	 * This device is not missing, try read its super block to determine its
> +	 * fsid.
> +	 */
> +	ret = dev_to_fsid((const char *)dev_arg->path, found_fsid);
> +	if (ret < 0) {
> +		errno = -ret;
> +		warning(
> +	"unable to determine if devid %llu is seed using its super block: %m",
> +			devid);
> +		return ret;
> +	}
> +	if (!memcmp(found_fsid, fsid, BTRFS_UUID_SIZE))

Please use explicit == 0 or != 0

> +		return 0;
> +	return 1;
> +}
> +
>  /*
>   *  This function loads the device_info structure and put them in an array
>   */
> @@ -708,9 +804,7 @@ static int load_device_info(int fd, struct device_info **devinfo_ret,
>  {
>  	int ret, i, ndevs;
>  	struct btrfs_ioctl_fs_info_args fi_args;
> -	struct btrfs_ioctl_dev_info_args dev_info;
>  	struct device_info *info;
> -	u8 fsid[BTRFS_UUID_SIZE];
>  
>  	*devcount_ret = 0;
>  	*devinfo_ret = NULL;
> @@ -730,6 +824,8 @@ static int load_device_info(int fd, struct device_info **devinfo_ret,
>  	}
>  
>  	for (i = 0, ndevs = 0 ; i <= fi_args.max_id ; i++) {
> +		struct btrfs_ioctl_dev_info_args dev_info = {0};

		{ 0 }
> +
>  		if (ndevs >= fi_args.num_devices) {
>  			error("unexpected number of devices: %d >= %llu", ndevs,
>  				fi_args.num_devices);
> @@ -737,7 +833,6 @@ static int load_device_info(int fd, struct device_info **devinfo_ret,
>  		"if seed device is used, try running this command as root");
>  			goto out;
>  		}
> -		memset(&dev_info, 0, sizeof(dev_info));
>  		ret = get_device_info(fd, i, &dev_info);
>  
>  		if (ret == -ENODEV)
> @@ -747,16 +842,16 @@ static int load_device_info(int fd, struct device_info **devinfo_ret,
>  			goto out;
>  		}
>  
> -		/*
> -		 * Skip seed device by checking device's fsid (requires root).
> -		 * And we will skip only if dev_to_fsid is successful and dev
> -		 * is a seed device.
> -		 * Ignore any other error including -EACCES, which is seen when
> -		 * a non-root process calls dev_to_fsid(path)->open(path).
> -		 */
> -		ret = dev_to_fsid((const char *)dev_info.path, fsid);
> -		if (!ret && memcmp(fi_args.fsid, fsid, BTRFS_FSID_SIZE) != 0)
> +		ret = is_seed_device(fd, i, fi_args.fsid, &dev_info);
> +		/* Skip seed device. */
> +		if (ret > 0)
>  			continue;
> +		if (ret < 0){
> +			errno = -ret;
> +			warning(
> +		"unable to determine if devid %u is seed: %m, assuming not", i);

Strange that 'i' is printed here as it's int but devids are u64, so the
types don't match.

> +			ret = 0;
> +		}
>  
>  		info[ndevs].devid = dev_info.devid;
>  		if (!dev_info.path[0]) {
> -- 
> 2.39.1
