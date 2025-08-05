Return-Path: <linux-btrfs+bounces-15872-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 037FAB1BD63
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 01:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F123B025A
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 23:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7660B26056C;
	Tue,  5 Aug 2025 23:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="HUz3iBpm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oD/ZaA2j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2D323372C
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Aug 2025 23:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436748; cv=none; b=NkrUpSdhAd8O1esMtyM8dj9bo4H5SrB4v93GJ7fs43Lp0Oton9ikPCvmDFGvzQ8RusfwJYQjpKX1bQjbAGpIzZZJyIhiNwNkEF7U8q+BuYKAnWPr3GC42OHbZFlpyAuj7mWONdGNhxsPsqOPzAp1nYMLiF+CQTafKh/XZIhqN3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436748; c=relaxed/simple;
	bh=nzJ85CcXqg3miJ7bwxl30iuLlVwATFxzGhsIQi3CWHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlg+q2JbpGDZAF6GIlzkPbOXmyRh0mKuGuHSXDJ/p8hopZBrsdLYCUSeTUyzsyH+1ZNgYzXEVIUkUwtm2wH6z17LnygNCPS3iCoMLkwzz+pFg0P7VT8kY6JgPi8dYMENlMVKhgTjwX0rRYgrZFFWLT3uQ+A+By9JKNhx8aVopLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=HUz3iBpm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oD/ZaA2j; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id A2B07EC0166;
	Tue,  5 Aug 2025 19:32:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 05 Aug 2025 19:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1754436745;
	 x=1754523145; bh=tj4lDMqLaAj9Eh0E6xRdxYa0agLMQuRzlVcSOo7YEcE=; b=
	HUz3iBpmOnqexXFuy9MnsvKF+Rta7bfczYrxm3dQRLLqkikfpY6pCqdPSQkyjH/m
	9aJmmRi99SI5l7Yz4NUl1CaR66ebpOtB0P7WT2EFaPkrHo3j+u0AmIqmm90Xqz3P
	dt0Dv5jEsEjP5ZhLSWIUZw3LndauiRQPiVB32Y8fGuEs+jsPymsXIyT4thoWMJGM
	Y2KrkDEoUR6EJHWxkmywQBMGfGWfEtv8uLRdEVkQvtUe/+u++qxCB2brIjfEv9+J
	yvIUVWrLuao305KeG8fzHWC8ImC44kbvcqlSgQEEwI7MvdFO5Yksk6EPQOPavjI4
	Zrl8QPOtY/3fNaVIjAYn7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754436745; x=
	1754523145; bh=tj4lDMqLaAj9Eh0E6xRdxYa0agLMQuRzlVcSOo7YEcE=; b=o
	D/ZaA2jeBzK1s8vTVwrR8uo4Q3kQs+W4X6i3tdYE/CowTLmBESGL5JC1xSD3Q+LP
	Ec8z+YImjQPXmA0YXzum+MSsGycG+pVBIRt+YWEO+umP/dTmH1pvRjyeYLjaByRR
	b3+FFQzYAGW7bAb3Fq2Oss6U7Wj0znnK2+8PWglzTbH31nTW1f6OYj4dM71eGoSp
	+wSFOFFfo3fqj0ohK2TIOZPT0z8/GWTq3hZyNvFyIJAjiMcGJxZCVNpY87iuDixZ
	3F2it+hJLZeqlirlqqZYzF4tzzOaEMGI8DGBNBa/+nNvWkU+a7uwYcFKMxUqOHHA
	Dc/zH63HQVIdZhYFrJA/Q==
X-ME-Sender: <xms:iZSSaFfjK0QvV4Fym6xvuctQn3e-qk0a2jm6_i-HpEfR3A-jTxXe0g>
    <xme:iZSSaDbsbK9Un96rulfmlJcIQuxJq4_mT2xTULKQo1tbb7IXwnBLaWAtPnIXfwkUP
    mrfHiVyxFCxaDwDMCM>
X-ME-Received: <xmr:iZSSaAVgO0sHinQOSQvpL7vYwRgja-A_1SAOmYS5uTmXtBBH335eFholD7Hop9xdplW2Y9SDVR8QDJTdtR3w1S6huIM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudeihedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepud
    elhfdthfetuddvtefhfedtiedtteehvddtkedvledtvdevgedtuedutdeitdeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopeifqhhusehsuhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhsse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:iZSSaNjd7iQkAcp4eW80avuUSMy9TN_cEvz_BJQ-LRiImLiDcRtYFg>
    <xmx:iZSSaGVwvMW0ji9C91UAifmUI_KcL1Jl1ATfVUsaV1SUnnEgpRTiFw>
    <xmx:iZSSaMNL54yeQwDoVA6vXFvGKdbyLVuCFkFe3zTOm9uXJ5XwFz5oWQ>
    <xmx:iZSSaKZrInCe5esdvcFPWjqC1hKIKN0yhn-laWteQJil3PSjHoKQ4g>
    <xmx:iZSSaKuFC5tHUkmIxd3DmlCg6OWn75E5Fbn_M9vYISVErqHT8Kc77Rgi>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 19:32:25 -0400 (EDT)
Date: Tue, 5 Aug 2025 16:33:23 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/5] btrfs-progs: add error handling for
 device_get_partition_size()
Message-ID: <20250805233323.GB966775@zen.localdomain>
References: <cover.1754116463.git.wqu@suse.com>
 <525dbf649790b855d109714bf9a82796fe3d7b1e.1754116463.git.wqu@suse.com>
 <20250805190838.GB4106638@zen.localdomain>
 <2e0e7b8c-22f8-4e17-8c0c-6047ea21c91a@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e0e7b8c-22f8-4e17-8c0c-6047ea21c91a@suse.com>

On Wed, Aug 06, 2025 at 08:11:51AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/8/6 04:38, Boris Burkov 写道:
> > On Sat, Aug 02, 2025 at 04:25:48PM +0930, Qu Wenruo wrote:
> > > The function device_get_partition_size() has all kinds of error paths,
> > > but it has no way to return error other than returning 0.
> > > 
> > > This is not helpful for end users to know what's going wrong.
> > > 
> > > Change that function to have a dedicated return value for error
> > > handling, and pass a u64 pointer for the result.
> > 
> > All the callers check ret < 0, rather than ret != 0, so any reason not
> > to simply return the positive value in case of no error? Signed
> > overflow?
> > 
> > In the kernel, BLK_DEV_MAX_SECTORS is set to LLONG_MAX >> 9, which I
> > think means we are probably OK?
> 
> This sounds reasonable, I was under the impression that we need to preserve
> the full U64_MAX for block devices due to our on-disk format.
> 
> But if kernel has extra limits, I'm more than happier to use s64.

I looked into it a bit more. BLKGETSIZE64 is implemented as:

put_u64(argp, bdev_nr_bytes(bdev));

and bdev_nr_bytes() returns loff_t which is a signed long long. So I do
think it should be safe. Not to mention that needing the MSB of a 64 bit
integer to express a disk size is not happening in anyone's lifetime.

> 
> Thanks,
> Qu
> 
> > 
> > > 
> > > For most callers they are able to exit gracefully with a proper error
> > > message.
> > > 
> > > But for load_device_info(), we allow a failed size probing to continue
> > > without 0 size, just as the old code.
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > >   cmds/filesystem-usage.c |  9 +++++++--
> > >   cmds/replace.c          | 14 ++++++++++++--
> > >   common/device-utils.c   | 29 +++++++++++++++--------------
> > >   common/device-utils.h   |  2 +-
> > >   4 files changed, 35 insertions(+), 19 deletions(-)
> > > 
> > > diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
> > > index f812af13482e..e367bffc3a01 100644
> > > --- a/cmds/filesystem-usage.c
> > > +++ b/cmds/filesystem-usage.c
> > > @@ -820,8 +820,13 @@ static int load_device_info(int fd, struct array *devinfos)
> > >   			strcpy(info->path, "missing");
> > >   		} else {
> > >   			strcpy(info->path, (char *)dev_info.path);
> > > -			info->device_size =
> > > -				device_get_partition_size((const char *)dev_info.path);
> > > +			ret = device_get_partition_size((const char *)dev_info.path,
> > > +							&info->device_size);
> > > +			if (ret < 0) {
> > > +				errno = -ret;
> > > +				warning("failed to get device size for devid %llu: %m", dev_info.devid);
> > > +				info->device_size = 0;
> > > +			}
> > >   		}
> > >   		info->size = dev_info.total_bytes;
> > >   		ndevs++;
> > > diff --git a/cmds/replace.c b/cmds/replace.c
> > > index 887c3251a725..d5b0b0e02ce1 100644
> > > --- a/cmds/replace.c
> > > +++ b/cmds/replace.c
> > > @@ -269,7 +269,12 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
> > >   		strncpy_null((char *)start_args.start.srcdev_name, srcdev,
> > >   			     BTRFS_DEVICE_PATH_NAME_MAX + 1);
> > >   		start_args.start.srcdevid = 0;
> > > -		srcdev_size = device_get_partition_size(srcdev);
> > > +		ret = device_get_partition_size(srcdev, &srcdev_size);
> > > +		if (ret < 0) {
> > > +			errno = -ret;
> > > +			error("failed to get device size for %s: %m", srcdev);
> > > +			goto leave_with_error;
> > > +		}
> > >   	} else {
> > >   		error("source device must be a block device or a devid");
> > >   		goto leave_with_error;
> > > @@ -279,7 +284,12 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
> > >   	if (ret)
> > >   		goto leave_with_error;
> > > -	dstdev_size = device_get_partition_size(dstdev);
> > > +	ret = device_get_partition_size(dstdev, &dstdev_size);
> > > +	if (ret < 0) {
> > > +		errno = -ret;
> > > +		error("failed to get device size for %s: %m", dstdev);
> > > +		goto leave_with_error;
> > > +	}
> > >   	if (srcdev_size > dstdev_size) {
> > >   		error("target device smaller than source device (required %llu bytes)",
> > >   			srcdev_size);
> > > diff --git a/common/device-utils.c b/common/device-utils.c
> > > index 783d79555446..6d89d16b029d 100644
> > > --- a/common/device-utils.c
> > > +++ b/common/device-utils.c
> > > @@ -342,7 +342,7 @@ u64 device_get_partition_size_fd(int fd)
> > >   	return result;
> > >   }
> > > -static u64 device_get_partition_size_sysfs(const char *dev)
> > > +static int device_get_partition_size_sysfs(const char *dev, u64 *result_ret)
> > >   {
> > >   	int ret;
> > >   	char path[PATH_MAX] = {};
> > > @@ -354,45 +354,46 @@ static u64 device_get_partition_size_sysfs(const char *dev)
> > >   	name = realpath(dev, path);
> > >   	if (!name)
> > > -		return 0;
> > > +		return -errno;
> > >   	name = path_basename(path);
> > >   	ret = path_cat3_out(sysfs, "/sys/class/block", name, "size");
> > >   	if (ret < 0)
> > > -		return 0;
> > > +		return ret;
> > >   	sysfd = open(sysfs, O_RDONLY);
> > >   	if (sysfd < 0)
> > > -		return 0;
> > > +		return -errno;
> > >   	ret = sysfs_read_file(sysfd, sizebuf, sizeof(sizebuf));
> > >   	if (ret < 0) {
> > >   		close(sysfd);
> > > -		return 0;
> > > +		return ret;
> > >   	}
> > >   	errno = 0;
> > >   	size = strtoull(sizebuf, NULL, 10);
> > >   	if (size == ULLONG_MAX && errno == ERANGE) {
> > >   		close(sysfd);
> > > -		return 0;
> > > +		return -errno;
> > >   	}
> > >   	close(sysfd);
> > > -	return size;
> > > +	*result_ret = size;
> > > +	return 0;
> > >   }
> > > -u64 device_get_partition_size(const char *dev)
> > > +int device_get_partition_size(const char *dev, u64 *result_ret)
> > >   {
> > > -	u64 result;
> > >   	int fd = open(dev, O_RDONLY);
> > >   	if (fd < 0)
> > > -		return device_get_partition_size_sysfs(dev);
> > > +		return device_get_partition_size_sysfs(dev, result_ret);
> > > +
> > > +	if (ioctl(fd, BLKGETSIZE64, result_ret) < 0) {
> > > +		int ret = -errno;
> > > -	if (ioctl(fd, BLKGETSIZE64, &result) < 0) {
> > >   		close(fd);
> > > -		return 0;
> > > +		return ret;
> > >   	}
> > >   	close(fd);
> > > -
> > > -	return result;
> > > +	return 0;
> > >   }
> > >   /*
> > > diff --git a/common/device-utils.h b/common/device-utils.h
> > > index cef9405f3a9a..bf04eb0f2fdd 100644
> > > --- a/common/device-utils.h
> > > +++ b/common/device-utils.h
> > > @@ -42,7 +42,7 @@ enum {
> > >    */
> > >   int device_discard_blocks(int fd, u64 start, u64 len);
> > >   int device_zero_blocks(int fd, off_t start, size_t len, const bool direct);
> > > -u64 device_get_partition_size(const char *dev);
> > > +int device_get_partition_size(const char *dev, u64 *result_ret);
> > >   u64 device_get_partition_size_fd(int fd);
> > >   u64 device_get_partition_size_fd_stat(int fd, const struct stat *st);
> > >   int device_get_queue_param(const char *file, const char *param, char *buf, size_t len);
> > > -- 
> > > 2.50.1
> > > 
> 

