Return-Path: <linux-btrfs+bounces-7105-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D13494E3D1
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 01:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FBC5281AC8
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Aug 2024 23:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE9E16132B;
	Sun, 11 Aug 2024 23:23:53 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from shin.romanrm.net (shin.romanrm.net [146.185.199.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C5D4C7E
	for <linux-btrfs@vger.kernel.org>; Sun, 11 Aug 2024 23:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.185.199.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723418633; cv=none; b=JdHluvDr1FIkQBVH1iATE5Ruu4oDcUR9mtWS8/aJoXaWQqSnq4baRE+A8YPyHpzzZhkbqDFI1tUL+R0g+6XwqnoJH/iZN/5W7KNXPkgXqTIpald8rLkrmdVRQoEbylri2UAo7TXSts1WM9fhyLpRaiCi/13aKvhjEu2xNI1i6NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723418633; c=relaxed/simple;
	bh=HHa4+txVAg28OzWeuN7reQNuGqIFHMFRV6vhgxYwMhY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N+SJx6iDUDLPouLojBC7cmonABbx04MIVBjN6HZs6V0fm5ViCbk4WgdkNoT2y9g+eJ9FOF+6yOnfkJNZ46wr+UkOGRgMRX7pMg0Zg9yxb0FQiZdJHE5aVJfS1M8NmsG4wEZ/5x6ThYKA8GTQZo2cp0eshngjSslgDW6H3WgXba8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=146.185.199.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (umi.39.romanrm.net [IPv6:fd39:a9b3:4fb1:1ccb:7900:fcd:12a3:6181])
	by shin.romanrm.net (Postfix) with SMTP id 883A53F6BD;
	Sun, 11 Aug 2024 23:17:20 +0000 (UTC)
Date: Mon, 12 Aug 2024 04:17:20 +0500
From: Roman Mamedov <rm@romanrm.net>
To: Sidong Yang <realwakka@gmail.com>
Cc: linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2] btrfs-progs: property: introduce
 drop_subtree_threshold property
Message-ID: <20240812041720.55fff9f6@nvm>
In-Reply-To: <20240811122415.6575-1-realwakka@gmail.com>
References: <20240811122415.6575-1-realwakka@gmail.com>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Aug 2024 12:24:15 +0000
Sidong Yang <realwakka@gmail.com> wrote:

> This patch introduces new property drop_subtree_threshold. This property
> could be set/get easily by root dir without find sysfs path.
> 
> Fixes: https://github.com/kdave/btrfs-progs/issues/795
> 
> Issue: #795
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
> v2: error msg for -ENOENT, fix desc for prop
> ---
>  cmds/property.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/cmds/property.c b/cmds/property.c
> index a36b5ab2..88344001 100644
> --- a/cmds/property.c
> +++ b/cmds/property.c
> @@ -35,6 +35,7 @@
>  #include "common/utils.h"
>  #include "common/help.h"
>  #include "common/filesystem-utils.h"
> +#include "common/sysfs-utils.h"
>  #include "cmds/commands.h"
>  #include "cmds/props.h"
>  
> @@ -236,6 +237,50 @@ out:
>  
>  	return ret;
>  }
> +static int prop_drop_subtree_threshold(enum prop_object_type type,
> +				       const char *object,
> +				       const char *name,
> +				       const char *value,
> +				       bool force) {
> +	int ret;
> +	int fd;
> +	int sysfs_fd;
> +	char buf[255];
> +
> +        fd = btrfs_open_path(object, value, false);

This line is indented with spaces instead of TABs like the rest and as it
should. I did not check if this is the only occurrence.

Checkpatch should catch this: https://docs.kernel.org/dev-tools/checkpatch.html

> +	if (fd < 0)
> +		return -errno;
> +
> +	sysfs_fd = sysfs_open_fsid_file(fd, "qgroups/drop_subtree_threshold");
> +	if (sysfs_fd < 0) {
> +		if (sysfs_fd == -ENOENT) {
> +			error("failed to access qgroups/drop_subtree_threshold for %s,"
> +			      " quota should be enabled for this property: %m",
> +			      object);
> +		}
> +		close(fd);
> +		return -errno;
> +	}
> +
> +	if (value) {
> +		ret = write(sysfs_fd, value, strlen(value));
> +	} else {
> +		ret = read(sysfs_fd, buf, 255);
> +		if (ret > 0) {
> +			buf[ret] = 0;
> +			pr_verbose(LOG_DEFAULT, "drop_subtree_threshold=%s", buf);
> +		}
> +	}
> +	if (ret < 0) {
> +		ret = -errno;
> +	} else {
> +		ret = 0;
> +	}
> +
> +	close(sysfs_fd);
> +	close(fd);
> +	return ret;
> +}
>  
>  const struct prop_handler prop_handlers[] = {
>  	{
> @@ -259,6 +304,14 @@ const struct prop_handler prop_handlers[] = {
>  		.types = prop_object_inode,
>  		.handler = prop_compression
>  	},
> +	{
> +		.name = "drop_subtree_threshold",
> +		.desc = "subtree level threshold to mark qgroup inconsistent during"
> +		"snapshot deletion, can reduce qgroup workload of snapshot deletion",
> +		.read_only = 0,
> +		.types = prop_object_root,
> +		.handler = prop_drop_subtree_threshold
> +	},
>  	{NULL, NULL, 0, 0, NULL}
>  };
>  


-- 
With respect,
Roman

