Return-Path: <linux-btrfs+bounces-7097-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5AA94E0AB
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Aug 2024 11:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69ED2B215B4
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Aug 2024 09:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8313715E;
	Sun, 11 Aug 2024 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/tngSFH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442E73BB2E
	for <linux-btrfs@vger.kernel.org>; Sun, 11 Aug 2024 09:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723368221; cv=none; b=QRoAhyfLIp6QgjDkWLcwlOIvKaooI0FZHh0EhMXvQglqjDZjNJaYzTSdqZtolj08nqVFo/VLvQyVvLWApQzJB8jJ867lwkDsoygcrrK3CWP0nwad6Po4bXtcAPWHbwGgRNJ0gy2WQaikHGG5huXDYhguk7ppZ7ITexetU/sqZ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723368221; c=relaxed/simple;
	bh=RNVbJKtV1sA43rCaWG0kYOp22+CoL0m0ghnd4oW2J5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7xqPE6XdED6cuMRmm2+EJMVXpqj96SkBWlSn4GHzpMmaKqzgfdXTQmexFczQuzaSvLBVvZ+tZGle+9HEBc2ftWvg1zUPPYq5bsjFco3xHHrdomCHEIkJjinQ3Mu1cajOZYqp0wgCxJ8QtM9mXYty7fb0fBrpOKWJjX0OLXo7z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/tngSFH; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70f5ef740b7so3194230b3a.2
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Aug 2024 02:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723368219; x=1723973019; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a437KL+JCdZEMXBraKvgSi9d+vkgLMdUHcfGPfW9T4M=;
        b=F/tngSFHXCHkZOkBv4G3WIfR15g92Gzb2kJj0S6kFb4mkVpqDVcN0dT2RinO2wur6A
         UcidBZwa/maT9v0WeWBvcUHrfD9tc0otGa62DkjLPyHwrWdY2ndYiQyA88MInn7z8C/K
         utx9juiicHT4fnM4K/wbXXt3OBUxceKUFj/qNtCHJtlY7lbnzfrJQKDJQviexn9FyBOC
         Q5eg32fiW8k/P1Fdh8BoJ/5lF8MW6IPJ6OqxgAEVVz9l83SObWpAJloIsxKJl6bDfhz4
         0QXr7vwFAOVXG4wNX+ViNsHXNwVCmLEhGfBzxFcO0d9+k558MAqoRiNtfQenvBcRC50S
         qBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723368219; x=1723973019;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a437KL+JCdZEMXBraKvgSi9d+vkgLMdUHcfGPfW9T4M=;
        b=WGeFtiZbLL3eKkRvgbybg+mzDmDLIcNjQoVSyBiL5ZjO7usA74/iLN/7jisr+v3UB4
         iOaLtgrYe3ZeXTpnj4XSRvoBC8t7ISuWM6YenIRc9ScRXUJZ5EJjlshdS2NJsxrG4SoD
         y7ugjVeixAZz+vM3FFBrliImWkxab8KV5NeBqV71fEpVILGvCBCbLDQztWS7PbTTFAtL
         VSGsZVJMrNxKKdGzZ3+LNT3jS07l/oj8gCh3mChPxheuVLXhwemoEUq6OKHh4+ZiZLPT
         irNXey3pSNH3ml5i4CaRywcSPfp+1n50j6oTC2u0t9lh1ERMZ+mC69tXHYVPTRmHfUH5
         79eg==
X-Gm-Message-State: AOJu0YzyFo0RCJJzT9k3G1t3Rr+IgF4HeSGvpCesSYyK4CXgZTIXBYRZ
	0j85uATaWKbuL44xrE/Qq4xkg5t7q1Vm/8PYF1Uns9VVV3nfFC98YmmIHYkN
X-Google-Smtp-Source: AGHT+IE0LBnXs7+gLCyq1pZ5dngMf4j6j7QJPK7xjlv6Cx8BzCfyv8zebFP+Ek0l8Gy013vgExFUqg==
X-Received: by 2002:a05:6a00:3d44:b0:70d:2693:d215 with SMTP id d2e1a72fcca58-710dc70c6c3mr7217606b3a.16.1723368219487;
        Sun, 11 Aug 2024 02:23:39 -0700 (PDT)
Received: from realwakka-Home ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a43816sm2171790b3a.131.2024.08.11.02.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 02:23:39 -0700 (PDT)
Date: Sun, 11 Aug 2024 18:23:26 +0900
From: Sidong Yang <realwakka@gmail.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: property: introduce drop_subtree_threshold
 property
Message-ID: <ZriDDsVwHDHq2LtQ@realwakka-Home>
References: <20240810061736.4816-1-realwakka@gmail.com>
 <de8cdf72-6961-4947-90da-37968de62500@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de8cdf72-6961-4947-90da-37968de62500@gmx.com>

On Sun, Aug 11, 2024 at 03:25:13PM +0930, Qu Wenruo wrote:

Hi Qu. Thanks for review.
> 
> 
> 在 2024/8/10 15:47, Sidong Yang 写道:
> > This patch introduces new property drop_subtree_threshold. This property
> > could be set/get easily by root dir without find sysfs path.
> > 
> > Fixes: https://github.com/kdave/btrfs-progs/issues/795
> > 
> > Issue: #795
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > ---
> >   cmds/property.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 47 insertions(+)
> > 
> > diff --git a/cmds/property.c b/cmds/property.c
> > index a36b5ab2..44b62af6 100644
> > --- a/cmds/property.c
> > +++ b/cmds/property.c
> > @@ -35,6 +35,7 @@
> >   #include "common/utils.h"
> >   #include "common/help.h"
> >   #include "common/filesystem-utils.h"
> > +#include "common/sysfs-utils.h"
> >   #include "cmds/commands.h"
> >   #include "cmds/props.h"
> > 
> > @@ -236,6 +237,45 @@ out:
> > 
> >   	return ret;
> >   }
> > +static int prop_drop_subtree_threshold(enum prop_object_type type,
> > +				       const char *object,
> > +				       const char *name,
> > +				       const char *value,
> > +				       bool force) {
> > +	int ret;
> > +	int fd;
> > +	int sysfs_fd;
> > +	char buf[255];
> > +
> > +        fd = btrfs_open_path(object, value, false);
> > +	if (fd < 0)
> > +		return -errno;
> > +
> > +	sysfs_fd = sysfs_open_fsid_file(fd, "qgroups/drop_subtree_threshold");
> > +	if (sysfs_fd < 0) {
> 
> Since qgroups/ directory is automatically generated/removed according to
> the qgroup status, you have to handle -ENOENT case, other than just
> erroring out.
> 
> At least you can do a warning if qgroup is not enabled.

Okay, I didn't care about it. It should handle -ENOENT and print warning
in next version.
> 
> > +		close(fd);
> > +		return -errno;
> > +	}
> > +
> > +	if (value) {
> > +		ret = write(sysfs_fd, value, strlen(value));
> > +	} else {
> > +		ret = read(sysfs_fd, buf, 255);
> > +		if (ret > 0) {
> > +			buf[ret] = 0;
> > +			pr_verbose(LOG_DEFAULT, "drop_subtree_threshold=%s", buf);
> > +		}
> > +	}
> > +	if (ret < 0) {
> > +		ret = -errno;
> > +	} else {
> > +		ret = 0;
> > +	}
> > +
> > +	close(sysfs_fd);
> > +	close(fd);
> > +	return ret;
> > +}
> > 
> >   const struct prop_handler prop_handlers[] = {
> >   	{
> > @@ -259,6 +299,13 @@ const struct prop_handler prop_handlers[] = {
> >   		.types = prop_object_inode,
> >   		.handler = prop_compression
> >   	},
> > +	{
> > +		.name = "drop_subtree_threshold",
> > +		.desc = "threshold for dropping reference to subtree",
> 
> The feature is qgroup specific, thus it's better to mention it.
> 
> Furthermore you didn't explain what threshold it is.
> 
> I'd go something like:
> 
> "subtree level threshold to mark qgroup inconsistent during snapshot
> deletion, can reduce qgroup workload of snapshot deletion".

Thanks for detailed example. It will be used for next patch. Honestly, I
had no idea about this option. I'll look at the kernel implementation.

Thanks,
Sidong

> 
> Thanks,
> Qu
> > +		.read_only = 0,
> > +		.types = prop_object_root,
> > +		.handler = prop_drop_subtree_threshold
> > +	},
> >   	{NULL, NULL, 0, 0, NULL}
> >   };
> > 

