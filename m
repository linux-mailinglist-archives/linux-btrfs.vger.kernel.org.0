Return-Path: <linux-btrfs+bounces-15862-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF48B1BABE
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 21:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889FF1897D94
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 19:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2791629AAF3;
	Tue,  5 Aug 2025 19:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="UqUmaDOc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cx0n0/r9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E612129A32D
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Aug 2025 19:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754420863; cv=none; b=SnFrHC8StjQ0PQErVegoFyLrIZTh3L2uqaHXfsjVy2TUlcxt+MnMpqxMD47Ra6DVn+ApGMmOYaXI5TTZEX54Tm57t++QSsUxcKMngdfrlrdZvEBXg8F9kt8lCxAUcA34jTkXDXY+JG1pbZe7H51sFEvNh1C4wBmd0Qcmta7HnuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754420863; c=relaxed/simple;
	bh=7fYuACfiYSSQ4Wy+M3Y9E0QaY/hYjOsjYinmVc0YbJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLE8QDuuTOgmCUhOHX9dvHiEf9vyikFoJPlpwre0GXy6jy/iHwGtG3ZRpjhTe5PzXzxpwltU+ZQTo42oWabOPuDDquLI1USpjzHx81OMQHivWyBnKS4Ym+EmJcFnnjtLJycJM7OM4nLs/ChZrlIz+ohssMKNv79WCK694t+Gdb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=UqUmaDOc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cx0n0/r9; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 11141EC0213;
	Tue,  5 Aug 2025 15:07:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 05 Aug 2025 15:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1754420860; x=1754507260; bh=/MZ5jDWV0W
	Bf2RArQdDFx5Sdr00Y56dWEQ0LzBhOikQ=; b=UqUmaDOcSqSo1VH4q19Ev62gzL
	mKH72XYCt+VGDJRHJwmCR1CEanCOF7B6n+NUTEH5drPCkb2NEdSi0YM2pShJihRS
	TRF+5z3nbswhKdGzvMRdEKC/nEKzTDAxam/nEcTvby/Z83qSBjvE1OFVWZYZCIkK
	nly0ALqBNXY+DWUKx3qWr/537PJrP6H/dZfZZ3GwwXPT+BAFbIu7cI/08dQXX7Yl
	dMF7xTeHj9SZjOns6xnQvkwJ9nJCV0OxyGa5zie30qcHVOuNuzwhpapKllhHGjyN
	oB+LhAAgnXiAij7FSSCZARvQl96gJuP/N6ERGaXTj4SRrdy7FHsj3iQA3c/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754420860; x=1754507260; bh=/MZ5jDWV0WBf2RArQdDFx5Sdr00Y56dWEQ0
	LzBhOikQ=; b=cx0n0/r9ZJq/imicirTOLRDQs24jL9SpfICF111KyhgauhaYj3f
	Fv574ZZo1Pe9Dsl/ZmDiQ4FOb2Jrb0Ig+uvWKfAcfPOUBuifSvtgkvshhRft+eDW
	b/hK67Z5olhdr13NIuzTW20gak8sx18fhNKFsDtg+NLypLXPZHxq9Y3imH9YxgKK
	8so4iStAQjhfNZ7FcbdM3ectuJRSUaLibJTBvYHLd7LsHRfTuw7d7sg16bBO2Dzj
	kD4RhOmDvFN+8aC04f5cLuGFJzGYgGBY3GeT7F82OadtK1dWLLAfcf5y935zFD30
	dizQlSElwpZeRHcjBgrJ9oYmgextoWEppoA==
X-ME-Sender: <xms:e1aSaB4veo11Nh2XJs1uzs1bH6MckAu05_Z7i6uxveDHPu9BRxFPKw>
    <xme:e1aSaPH5S6tHeHvJ5gpUlXt7nspa5IfWcT49Cl9zRHbIRbAZn_4U5u4mTU8MXBrbi
    aEpP6F2c9qeJmMkUY0>
X-ME-Received: <xmr:e1aSaKQ67sHeNhqwy99M55zcT8wppfvV_G04wDLfPNHegJ3YrqtZzKyRbc2MKSxpvmkpuNzszrl23bjUeS5_1RJxufU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:e1aSaIvNFMxzvMxJiwD390enYiIxdJW5WZD5cdPKfV5DEQecgVt7Lg>
    <xmx:e1aSaJxRQjn7VFCxXIQ5fM1j1jysgCtUh7jzz_MvW4QV1FafjH07Cg>
    <xmx:e1aSaC6a81UvGVCMZeggN-Uor8578oRvGYjg3P6NK1ijzn5OntfLyA>
    <xmx:e1aSaDXxdy3HunM-CPaZsezn7X70yhQ0KTdogYaNKSTeEstdtAvRLA>
    <xmx:fFaSaOpSxFWEnMqf3LNzstlDK96k2FYt5Jj0O6r7UXTJu3m9-sSA0ePM>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 15:07:39 -0400 (EDT)
Date: Tue, 5 Aug 2025 12:08:38 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/5] btrfs-progs: add error handling for
 device_get_partition_size()
Message-ID: <20250805190838.GB4106638@zen.localdomain>
References: <cover.1754116463.git.wqu@suse.com>
 <525dbf649790b855d109714bf9a82796fe3d7b1e.1754116463.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <525dbf649790b855d109714bf9a82796fe3d7b1e.1754116463.git.wqu@suse.com>

On Sat, Aug 02, 2025 at 04:25:48PM +0930, Qu Wenruo wrote:
> The function device_get_partition_size() has all kinds of error paths,
> but it has no way to return error other than returning 0.
> 
> This is not helpful for end users to know what's going wrong.
> 
> Change that function to have a dedicated return value for error
> handling, and pass a u64 pointer for the result.

All the callers check ret < 0, rather than ret != 0, so any reason not
to simply return the positive value in case of no error? Signed
overflow?

In the kernel, BLK_DEV_MAX_SECTORS is set to LLONG_MAX >> 9, which I
think means we are probably OK?

> 
> For most callers they are able to exit gracefully with a proper error
> message.
> 
> But for load_device_info(), we allow a failed size probing to continue
> without 0 size, just as the old code.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  cmds/filesystem-usage.c |  9 +++++++--
>  cmds/replace.c          | 14 ++++++++++++--
>  common/device-utils.c   | 29 +++++++++++++++--------------
>  common/device-utils.h   |  2 +-
>  4 files changed, 35 insertions(+), 19 deletions(-)
> 
> diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
> index f812af13482e..e367bffc3a01 100644
> --- a/cmds/filesystem-usage.c
> +++ b/cmds/filesystem-usage.c
> @@ -820,8 +820,13 @@ static int load_device_info(int fd, struct array *devinfos)
>  			strcpy(info->path, "missing");
>  		} else {
>  			strcpy(info->path, (char *)dev_info.path);
> -			info->device_size =
> -				device_get_partition_size((const char *)dev_info.path);
> +			ret = device_get_partition_size((const char *)dev_info.path,
> +							&info->device_size);
> +			if (ret < 0) {
> +				errno = -ret;
> +				warning("failed to get device size for devid %llu: %m", dev_info.devid);
> +				info->device_size = 0;
> +			}
>  		}
>  		info->size = dev_info.total_bytes;
>  		ndevs++;
> diff --git a/cmds/replace.c b/cmds/replace.c
> index 887c3251a725..d5b0b0e02ce1 100644
> --- a/cmds/replace.c
> +++ b/cmds/replace.c
> @@ -269,7 +269,12 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
>  		strncpy_null((char *)start_args.start.srcdev_name, srcdev,
>  			     BTRFS_DEVICE_PATH_NAME_MAX + 1);
>  		start_args.start.srcdevid = 0;
> -		srcdev_size = device_get_partition_size(srcdev);
> +		ret = device_get_partition_size(srcdev, &srcdev_size);
> +		if (ret < 0) {
> +			errno = -ret;
> +			error("failed to get device size for %s: %m", srcdev);
> +			goto leave_with_error;
> +		}
>  	} else {
>  		error("source device must be a block device or a devid");
>  		goto leave_with_error;
> @@ -279,7 +284,12 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
>  	if (ret)
>  		goto leave_with_error;
>  
> -	dstdev_size = device_get_partition_size(dstdev);
> +	ret = device_get_partition_size(dstdev, &dstdev_size);
> +	if (ret < 0) {
> +		errno = -ret;
> +		error("failed to get device size for %s: %m", dstdev);
> +		goto leave_with_error;
> +	}
>  	if (srcdev_size > dstdev_size) {
>  		error("target device smaller than source device (required %llu bytes)",
>  			srcdev_size);
> diff --git a/common/device-utils.c b/common/device-utils.c
> index 783d79555446..6d89d16b029d 100644
> --- a/common/device-utils.c
> +++ b/common/device-utils.c
> @@ -342,7 +342,7 @@ u64 device_get_partition_size_fd(int fd)
>  	return result;
>  }
>  
> -static u64 device_get_partition_size_sysfs(const char *dev)
> +static int device_get_partition_size_sysfs(const char *dev, u64 *result_ret)
>  {
>  	int ret;
>  	char path[PATH_MAX] = {};
> @@ -354,45 +354,46 @@ static u64 device_get_partition_size_sysfs(const char *dev)
>  
>  	name = realpath(dev, path);
>  	if (!name)
> -		return 0;
> +		return -errno;
>  	name = path_basename(path);
>  
>  	ret = path_cat3_out(sysfs, "/sys/class/block", name, "size");
>  	if (ret < 0)
> -		return 0;
> +		return ret;
>  	sysfd = open(sysfs, O_RDONLY);
>  	if (sysfd < 0)
> -		return 0;
> +		return -errno;
>  	ret = sysfs_read_file(sysfd, sizebuf, sizeof(sizebuf));
>  	if (ret < 0) {
>  		close(sysfd);
> -		return 0;
> +		return ret;
>  	}
>  	errno = 0;
>  	size = strtoull(sizebuf, NULL, 10);
>  	if (size == ULLONG_MAX && errno == ERANGE) {
>  		close(sysfd);
> -		return 0;
> +		return -errno;
>  	}
>  	close(sysfd);
> -	return size;
> +	*result_ret = size;
> +	return 0;
>  }
>  
> -u64 device_get_partition_size(const char *dev)
> +int device_get_partition_size(const char *dev, u64 *result_ret)
>  {
> -	u64 result;
>  	int fd = open(dev, O_RDONLY);
>  
>  	if (fd < 0)
> -		return device_get_partition_size_sysfs(dev);
> +		return device_get_partition_size_sysfs(dev, result_ret);
> +
> +	if (ioctl(fd, BLKGETSIZE64, result_ret) < 0) {
> +		int ret = -errno;
>  
> -	if (ioctl(fd, BLKGETSIZE64, &result) < 0) {
>  		close(fd);
> -		return 0;
> +		return ret;
>  	}
>  	close(fd);
> -
> -	return result;
> +	return 0;
>  }
>  
>  /*
> diff --git a/common/device-utils.h b/common/device-utils.h
> index cef9405f3a9a..bf04eb0f2fdd 100644
> --- a/common/device-utils.h
> +++ b/common/device-utils.h
> @@ -42,7 +42,7 @@ enum {
>   */
>  int device_discard_blocks(int fd, u64 start, u64 len);
>  int device_zero_blocks(int fd, off_t start, size_t len, const bool direct);
> -u64 device_get_partition_size(const char *dev);
> +int device_get_partition_size(const char *dev, u64 *result_ret);
>  u64 device_get_partition_size_fd(int fd);
>  u64 device_get_partition_size_fd_stat(int fd, const struct stat *st);
>  int device_get_queue_param(const char *file, const char *param, char *buf, size_t len);
> -- 
> 2.50.1
> 

