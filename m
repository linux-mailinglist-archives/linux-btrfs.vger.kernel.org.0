Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9518423FDE
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Oct 2021 16:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238832AbhJFOMR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Oct 2021 10:12:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35544 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238723AbhJFOMO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Oct 2021 10:12:14 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D6D4522508;
        Wed,  6 Oct 2021 14:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633529421;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KDh7VMy58IY9u8dtp1v3pyVjDPAhkCYkXjKiN5FBYxo=;
        b=Ui9AWzJWn9zTlQccNN7z7YvAsJBDc1F0C3uYL4j6A480FcTX8ghmwTR7s/m6oofrdt41hI
        3Ns1Yeor74EF27XeSaq2WGqbbOYzqJUORuTvyFFnIyIPgME5jFRTNvYRI6Do17WdOHG3JB
        06PQ4tgYxoLlYEqxUdVWRs0xi4Wx1yk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633529421;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KDh7VMy58IY9u8dtp1v3pyVjDPAhkCYkXjKiN5FBYxo=;
        b=t5Ya9dHvCkYzRKMynTR8E5dy7DqPIr4oc3QFepwyCobST1rT7pgqK0kRIFtiNR253MFzSs
        O5N14GE2nDodhBBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A376EA4265;
        Wed,  6 Oct 2021 14:10:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 663CBDA7F3; Wed,  6 Oct 2021 16:10:01 +0200 (CEST)
Date:   Wed, 6 Oct 2021 16:10:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 4/7] btrfs-progs: introduce btrfs_pwrite wrapper for
 pwrite
Message-ID: <20211006141001.GR9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20211005062305.549871-1-naohiro.aota@wdc.com>
 <20211005062305.549871-5-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005062305.549871-5-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 05, 2021 at 03:23:02PM +0900, Naohiro Aota wrote:
> -int device_zero_blocks(int fd, off_t start, size_t len)
> +int device_zero_blocks(int fd, off_t start, size_t len, const bool direct)

const for ints or bools does not make sense, the const for pointers is
an API contract that the callee won't change it but for local variables
defined inside parameter list it's not necessary.

>  {
>  	char *buf = malloc(len);
>  	int ret = 0;
> @@ -104,7 +105,7 @@ int device_zero_blocks(int fd, off_t start, size_t len)
>  	if (!buf)
>  		return -ENOMEM;
>  	memset(buf, 0, len);
> -	written = pwrite(fd, buf, len, start);
> +	written = btrfs_pwrite(fd, buf, len, start, direct);
>  	if (written != len)
>  		ret = -EIO;
>  	free(buf);
> @@ -134,7 +135,7 @@ static int zero_dev_clamped(int fd, struct btrfs_zoned_device_info *zinfo,
>  	if (zinfo && zinfo->model == ZONED_HOST_MANAGED)
>  		return zero_zone_blocks(fd, zinfo, start, end - start);
>  
> -	return device_zero_blocks(fd, start, end - start);
> +	return device_zero_blocks(fd, start, end - start, false);
>  }
>  
>  /*
> @@ -176,8 +177,10 @@ static int btrfs_wipe_existing_sb(int fd, struct btrfs_zoned_device_info *zinfo)
>  		len = sizeof(buf);
>  
>  	if (!zone_is_sequential(zinfo, offset)) {
> +		const bool direct = zinfo && zinfo->model == ZONED_HOST_MANAGED;
> +
>  		memset(buf, 0, len);
> -		ret = pwrite(fd, buf, len, offset);
> +		ret = btrfs_pwrite(fd, buf, len, offset, direct);
>  		if (ret < 0) {

This should probably also check for ret == 0 as this does nothing, but
that's a separate fix.

>  			error("cannot wipe existing superblock: %m");
>  			ret = -1;
> @@ -510,3 +513,68 @@ out:
>  	close(sysfs_fd);
>  	return ret;
>  }
> +
> +ssize_t btrfs_direct_pio(int rw, int fd, void *buf, size_t count, off_t offset)
> +{
> +	int alignment;
> +	size_t iosize;
> +	void *bounce_buf = NULL;
> +	struct stat stat_buf;
> +	unsigned long req;
> +	int ret;
> +	ssize_t ret_rw;
> +
> +	ASSERT(rw == READ || rw == WRITE);
> +
> +	if (fstat(fd, &stat_buf) == -1) {
> +		error("fstat failed (%m)");
> +		return 0;
> +	}
> +
> +	if ((stat_buf.st_mode & S_IFMT) == S_IFBLK)
> +		req = BLKSSZGET;
> +	else
> +		req = FIGETBSZ;

> +
> +	if (ioctl(fd, req, &alignment)) {
> +		error("failed to get block size: %m");
> +		return 0;

The ioctls take an int as parameter but it's not well suitable for
alignment checks as it internally does bit operations and this should be
avoided. It should work here but would be good to clean it up.

> +	}
> +
> +	if (IS_ALIGNED((size_t)buf, alignment) && IS_ALIGNED(count, alignment)) {
> +		if (rw == WRITE)
> +			return pwrite(fd, buf, count, offset);
> +		else
> +			return pread(fd, buf, count, offset);
> +	}
> +
> +	/* Cannot do anything if the write size is not aligned */
> +	if (rw == WRITE && !IS_ALIGNED(count, alignment)) {
> +		error("%lu is not aligned to %d", count, alignment);

as count is size_t, the format specifier should be %zu

> +		return 0;
> +	}
> +
> +	iosize = round_up(count, alignment);
> +
> +	ret = posix_memalign(&bounce_buf, alignment, iosize);
> +	if (ret) {
> +		error("failed to allocate bounce buffer: %m");
> +		errno = ret;
> +		return 0;
> +	}
> +
> +	if (rw == WRITE) {
> +		ASSERT(iosize == count);
> +		memcpy(bounce_buf, buf, count);
> +		ret_rw = pwrite(fd, bounce_buf, iosize, offset);
> +	} else {
> +		ret_rw = pread(fd, bounce_buf, iosize, offset);
> +		if (ret_rw >= count) {
> +			ret_rw = count;
> +			memcpy(buf, bounce_buf, count);
> +		}
> +	}
> +
> +	free(bounce_buf);

The wrappers should entirely copy the semantics of pwrite/pread, ie
return <0 on error as -errno in case of error, 0 if there was no write
and otherwise the number of written bytes.

I'll do the minor fixups only, the pwrite cleanups need to audit all
call sites so it's better for a separate patch.
