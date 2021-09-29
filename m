Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084E041CC15
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 20:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346190AbhI2Ssj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 14:48:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50176 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbhI2Ssf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 14:48:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4AE88225B0;
        Wed, 29 Sep 2021 18:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632941213;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XNuzFLcg8aGYpeH9YKpCncjapVshBYHjI1WY8fy/3h4=;
        b=YDTIUUiqxjzxMnARlyeDxsbq5+1fQYU82Q35+ok5bVVn6ik2X1jut4rw4etPp9EbuiH6wB
        OIN7tGrRxED5k+tIZEkXtUzIUrEEy6FMyEsLfN/qFuskyJcS4ORYmX1MCDlAsRslcL7fw5
        TXx8/ltZnyB9Z5LsVhd/SJ8gdv+hI/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632941213;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XNuzFLcg8aGYpeH9YKpCncjapVshBYHjI1WY8fy/3h4=;
        b=q/KK/+v8XGuu4Rjkro213LVex75A97NGGI/Si0rB9xgK+CmfFftcSZAUIFowSQaWDx4B+h
        JIIg38v4dEpZ62Bg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4517FA3B83;
        Wed, 29 Sep 2021 18:46:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C5487DA7A9; Wed, 29 Sep 2021 20:46:36 +0200 (CEST)
Date:   Wed, 29 Sep 2021 20:46:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs-progs: Ignore path devices during scan -
 static build support
Message-ID: <20210929184636.GR9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210928123730.393551-1-nborisov@suse.com>
 <20210928123730.393551-2-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928123730.393551-2-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 28, 2021 at 03:37:30PM +0300, Nikolay Borisov wrote:
> @@ -372,23 +373,56 @@ void free_seen_fsid(struct seen_fsid *seen_fsid_hash[])
>  	}
>  }
>  
> -#ifdef HAVE_LIBUDEV
> -static bool is_path_device(char *device_path)
> +#ifdef STATIC_BUILD
> +static bool __is_path_device(dev_t dev)
> +{
> +	FILE *file;
> +	char *line = NULL;
> +	size_t len = 0;
> +	ssize_t nread;
> +	bool ret = false;
> +	int ret2;
> +	struct stat dev_stat;
> +	char path[100];

	char path[PATH_MAX];

No arbitrary constants please. For paths always use a full buffer size,
though in this case it's not strictly necessary.

> +
> +	ret2 = snprintf(path, 100, "/run/udev/data/b%u:%u", major(dev_stat.st_rdev),
> +			minor(dev_stat.st_rdev));
> +
> +	if (ret2 >= 100 || ret2 < 0)

So >= 100 never happens and with PATH_MAX you can drop the part of the
condition as well.

> +		return false;
> +
> +	file = fopen(path, "r");
> +	if (file == NULL)
> +		return false;
> +
> +	while ((nread = getline(&line, &len, file)) != -1) {
> +		if (strstr(line, "DM_MULTIPATH_DEVICE_PATH=1")) {

So this is peeking into udev internal files but I like that you do
strstr, that sounds future proof enough for a fallback.

> +			ret = true;
> +			printf("found dm multipath line: %s\n", line);

Is this a debugging print? We have the pr_verbose helper that takes a
level of verbosity so for debugging you can do pr_verbose(3, "...").
This hasnt' been used much but messages used for developing a feature
and making sure it works as expected can be turned into high verbose
level messages for free and one day it becomes useful.

> +			break;
> +		}
> +	}
> +
> +	if (line)
> +		free(line);
> +
> +	fclose(file);
> +
> +	return ret;
> +}
> +#elif defined(HAVE_LIBUDEV)
> +static bool __is_path_device(dev_t device)

Please avoid functions with __, also s/path/multipath/ would be much
more clear.

>  {
>  	struct udev *udev = NULL;
>  	struct udev_device *dev = NULL;
> -	struct stat dev_stat;
>  	const char *val;
>  	bool ret = false;
>  
> -	if (stat(device_path, &dev_stat) < 0)
> -		return false;
> -
>  	udev = udev_new();
>  	if (!udev)
>  		goto out;
>  
> -	dev = udev_device_new_from_devnum(udev, 'b', dev_stat.st_rdev);
> +	dev = udev_device_new_from_devnum(udev, 'b', device);
>  	if (!dev)
>  		goto out;
>  
> @@ -401,8 +435,24 @@ static bool is_path_device(char *device_path)
>  
>  	return ret;
>  }
> +#else
> +static bool __is_path_device(dev_t device)
> +{
> +	return false;
> +}
>  #endif
>  
> +static bool is_path_device(char *device_path)
> +{
> +	struct stat dev_stat;
> +
> +	if (stat(device_path, &dev_stat) < 0)
> +		return false;
> +
> +	return __is_path_device(dev_stat.st_rdev);
> +
> +}
> +
>  int btrfs_scan_devices(int verbose)
>  {
>  	int fd = -1;
> @@ -433,10 +483,8 @@ int btrfs_scan_devices(int verbose)
>  		/* if we are here its definitely a btrfs disk*/
>  		strncpy_null(path, blkid_dev_devname(dev));
>  
> -#ifdef HAVE_LIBUDEV
>  		if (is_path_device(path))
>  			continue;
> -#endif
>  
>  		fd = open(path, O_RDONLY);
>  		if (fd < 0) {
> -- 
> 2.17.1
