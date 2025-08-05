Return-Path: <linux-btrfs+bounces-15863-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 800CEB1BAC7
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 21:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267723A54A8
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 19:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE2F2750E7;
	Tue,  5 Aug 2025 19:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="NUlwPq4c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JQt71QcS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF58291C12
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Aug 2025 19:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754421302; cv=none; b=iy7RDhLkOi7f1qHA4MXPnJjEZF0sNcj6eDeCSN0+/65RYJVSkUZSk7JY0xlI1vCaprQBy2P+jYdfrQbndT5JXcEJxyka5I2mbRE6hnEZzX6Zn7ufV6HW4XK7K6JmFkDfLWKvH61ciJZC9m+wlfa/CsU6/dh5bD6Ttk2fQXrdD2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754421302; c=relaxed/simple;
	bh=FvKY8+2M1ak4xukbWUtvW/lWxt6NCyc+rLY9LzuuH/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOgXSOqIVTj3N8XONGdcU0ampiwElTo+mYJwWwmrsYPxSI3RdujtidGUCgFb2DgHjpIw536cDpmALkMswMQGiyq/CByqywtztHha2t8Xq56gv+d8Fogbf49t/jO0PQY927K1MM1ERVFsUryG7OXvnI0AnK4s9xMitfeJH4/Ld8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=NUlwPq4c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JQt71QcS; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3ABA4140020E;
	Tue,  5 Aug 2025 15:15:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 05 Aug 2025 15:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1754421300; x=1754507700; bh=PqSiM43ppm
	6HzxQX4P69e9ihS39xbjG7qYk1Y/Kkd4I=; b=NUlwPq4cTMDlTqlHT+4+IW3QrL
	MU7JXSJ5Mp43pCAiC9PT+0PhrzPJPE3n8+CuO5vyU+nclN3iJV7P1F91SWcqEogV
	TbeGfTznieQKCrwMol7E2y5f9pHFMXW2xSDtLjZ2EWDMIj8O72tGHbhVK2pL8STa
	epDJqdZUAAfR6xRmao9ZmFLSp3tV7LvNnjLAF6JQ4u/cwHftirad3DSuhSoPIBn2
	9YCRc86zKJItfGIOPL/SY2nGljU8wOGDOnaeVN1nGSHRmP5zoOCRyWggHmHU2nmb
	8/W6qE7zQJBq1rcuakiC5U5CgmIa2H/8hx5J5YqnnsVVAvLXdTdn9n9v/XbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754421300; x=1754507700; bh=PqSiM43ppm6HzxQX4P69e9ihS39xbjG7qYk
	1Y/Kkd4I=; b=JQt71QcSjRwpxp4d1ZqfIstG+c9J/iMj1igdLXBBGOoKYT/N8Ah
	ASc4wx1eS6aqU4WdZRvBxkJVx9IHauAPJeEnA4Kiqu3SlkY7esLTp49UUIFhDZS9
	j5Gi+pe4kmnFFY1i68g81cgyhE8MpOA7bbCFo9MSwy+Jr3TEVhTlBWpGphTD1H00
	oVyldDEQDClulu/bSUxq6pSKHQ3R7Iw+hQ/txwGDJD7KPqN5M60eTPo0X0bZCysq
	gUtxHPfWOsfLN7DCC2UisWrajKDTdGm7VYI2LIqW410sjqbwP9oHDe/92JWFeN1K
	nKVlf3e7s0loeSCZ3CQHXvX5ngXSOHsk8Pg==
X-ME-Sender: <xms:NFiSaHsNlcA1JM2FadDgsTG60wN0SlegqyQnun-oCjxTKmw20ev9Rw>
    <xme:NFiSaIo1QDWAwfbmNX1rDaThY9bqsK6S9LgXkLqbWew1sN3O6eq8wBOCKl6AKoEPw
    hHJj6_QDgSuMH_JVZY>
X-ME-Received: <xmr:NFiSaMkQg4utyytDvg8M2kOZGAlTCo2ShqlJQ6YyLxK3ATHpzCZBXE3ZGyt4EpanZy7rsXNajr5tMsCh34eEPziAjNU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:NFiSaEw59dhQRbBvxglSAvmBvw7qxlZSZ_rd1bkL_0emPLYzx-Ui7w>
    <xmx:NFiSaMmYiwmjqRFm3iM02JehO56aAXydCTKKOQB9ETOZz-_nJby03g>
    <xmx:NFiSaFdWlX5ODtflEiE6hdDS0ap_-M-meTaKnriyhQ6Ws_JyBYfXEA>
    <xmx:NFiSaKrkLc0SMUAERWfg1aOHIAzVu7xmlmChdtknimvoZvOIqy7hsA>
    <xmx:NFiSaO_jImS025xFROGK2KhBwcqvVaVZTAGF6XPYUKUpiKqU1ZGIGauX>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 15:14:59 -0400 (EDT)
Date: Tue, 5 Aug 2025 12:15:58 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/5] btrfs-progs: remove device_get_partition_size_sysfs()
Message-ID: <20250805191558.GC4106638@zen.localdomain>
References: <cover.1754116463.git.wqu@suse.com>
 <7d924138ebae9196c7a6889b29e44e7549bda83d.1754116463.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d924138ebae9196c7a6889b29e44e7549bda83d.1754116463.git.wqu@suse.com>

On Sat, Aug 02, 2025 at 04:25:51PM +0930, Qu Wenruo wrote:
> The helper is introduced for cases where the unprivileged user failed to
> open the target file.
> 
> The problem is, when such failure happens, it means the distro's file
> mode or ACL is actively preventing unrelated users to access the raw
> device.
> 
> E.g. on my distro the default block device mode looks like this:
> 
>   brw-rw---- 1 root disk 254, 32 Aug  2 13:35 /dev/vdc
> 
> This means if an unprivileged end user is not in the disk group, it
> should access the raw disk.
> 
> Using sysfs as a fallback is more like a workaround, and the workaround
> is soon getting out of control.
> 
> For example the size is not in byte but in block unit. This is already
> causing problem for issue #979.

shifting by sector size doesn't seem like a crazy thing for us to simply
fix.

> 
> Furthermore to grab the correct size in bytes, we have to do all kinds
> of sysfs probing to handle partitions (to get the block size from parent
> node) and dm devices (directly from the current node).

I don't quite understand this justification, is this another fix we
would have to make or is it what we are already doing?

> 
> With the recent error handling enhancement, I do not think we should
> even bother using the sysfs fallback, the error message should be enough
> to inform the end user.

I think that given we have users reporting being confused by size being
off by a factor of 512, it makes more sense to make them happy by just
shifting rather than throwing the whole thing out.

> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  common/device-utils.c | 39 +--------------------------------------
>  1 file changed, 1 insertion(+), 38 deletions(-)
> 
> diff --git a/common/device-utils.c b/common/device-utils.c
> index b52fbf33a539..7a0a299ccf83 100644
> --- a/common/device-utils.c
> +++ b/common/device-utils.c
> @@ -333,49 +333,12 @@ int device_get_partition_size_fd_stat(int fd, const struct stat *st, u64 *result
>  	return 0;
>  }
>  
> -static int device_get_partition_size_sysfs(const char *dev, u64 *result_ret)
> -{
> -	int ret;
> -	char path[PATH_MAX] = {};
> -	char sysfs[PATH_MAX] = {};
> -	char sizebuf[128] = {};
> -	const char *name = NULL;
> -	int sysfd;
> -	unsigned long long size = 0;
> -
> -	name = realpath(dev, path);
> -	if (!name)
> -		return -errno;
> -	name = path_basename(path);
> -
> -	ret = path_cat3_out(sysfs, "/sys/class/block", name, "size");
> -	if (ret < 0)
> -		return ret;
> -	sysfd = open(sysfs, O_RDONLY);
> -	if (sysfd < 0)
> -		return -errno;
> -	ret = sysfs_read_file(sysfd, sizebuf, sizeof(sizebuf));
> -	if (ret < 0) {
> -		close(sysfd);
> -		return ret;
> -	}
> -	errno = 0;
> -	size = strtoull(sizebuf, NULL, 10);
> -	if (size == ULLONG_MAX && errno == ERANGE) {
> -		close(sysfd);
> -		return -errno;
> -	}
> -	close(sysfd);
> -	*result_ret = size;
> -	return 0;
> -}
> -
>  int device_get_partition_size(const char *dev, u64 *result_ret)
>  {
>  	int fd = open(dev, O_RDONLY);
>  
>  	if (fd < 0)
> -		return device_get_partition_size_sysfs(dev, result_ret);
> +		return -errno;
>  
>  	if (ioctl(fd, BLKGETSIZE64, result_ret) < 0) {
>  		int ret = -errno;
> -- 
> 2.50.1
> 

