Return-Path: <linux-btrfs+bounces-7108-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0F294E415
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 02:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0834B215DD
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 00:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61D44A39;
	Mon, 12 Aug 2024 00:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaW+uLiT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBA1136A
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 00:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723423968; cv=none; b=NfoHndpGdjIZbffmdau7X+4KqvtkaYa3rQtVQtCFE0sr778bNsBm9ivkRuSDCCIyEsHTSiaiZIXZf3iVbSqbQjkP07XT6PiNWgliIVZ3cn87qBB0WL61+s++aW45gYuQcFJkv+9ZzqrD/6DQRqpegzy56yPbvIN5fsdqr43ayYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723423968; c=relaxed/simple;
	bh=2tVWBj7+LE4zfAFJGsQCKuS0oxkZCPldTVkxxGxoLnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGGNVPlvX+q5ga3QxEgbBtGHNUZB+Dh2Do2IKfAmql0ikbBq6B83XrO98RYzGJCcjAFKQxHUgDfZlLEiwo+VQsH8ZVxSCxL/Ag81gGgASU4OStmeTSlkBWMP0pGNQ1ETO+hipI6gUQmNbuoE1vb9SkbPrHOKb9DCfS0E6QM5Rok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EaW+uLiT; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2caff99b1c9so2694520a91.3
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Aug 2024 17:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723423967; x=1724028767; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hFsxTfGAAJoZsZrKXkmVSLuTZI9dLVMbW0CrX0OnjZE=;
        b=EaW+uLiT7/0xVc705T3o3cIxMtNHojeVx835ITvffuLl41+Dnq6I2euGT3rBwancCU
         LXFM6N1J2zpkNMcfXiucYA/pZvY0b6oTLj64MdUsQgvDxAgT0drs7YwSQMK0MOjFEMV+
         0KmJgNoT+QW0MJ9I+mmZBfFgB89Vsv+Ln68KVMkg2uSYRkGmVvRMZHqhL1PLa0nTm00j
         oerg8njnZbvYWAEsDj+6OErtNsX6HOiD2vN1IPvDPJYkBjLHJmiF5AhuvCegTBx9HE+g
         ZKlwONiAA/ufIG9fEf/SpOxu6HEo4A2tN4Q7zmfPkoLzPXzFiTOKGO/VOp/A1c/8uLnA
         0mBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723423967; x=1724028767;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFsxTfGAAJoZsZrKXkmVSLuTZI9dLVMbW0CrX0OnjZE=;
        b=pprSz1q5fKFe5QTvXsf49tFodHnoBqrg0JEue9E/qRo4C0vbKdp2AP3mTVJf4cUdiW
         qLtqenZwAqBXpI/YCJJEeX07J2vqRUD2nLPUVPw3vnF9OlcUJ/qSHlpqFg1/p50Jk0w6
         U8qRi1aocmj9aYQK8Y8GioCjLNVW+VoO2+3L9QWWtEL61/4wWy6rrxhHQOS6OvBgh0ys
         /R7+cD1HQS8M8VT/TgjRSblJS9QlzxvYhA9CSBAbbaUwBPyaa2FrMrmDcHPny7zZckcj
         QNw0+EAwmRQwhBD2u/R85TTphMd+3doAwZALw/OeAxUrezva8LVfCz9w9sn91ZGbFAST
         FisA==
X-Gm-Message-State: AOJu0YwtEzFQE09MpTi85ujAvwlKgpHIwS6Skps38sMN/lzgV1RDuNMB
	biEoszq2oWVK/1r8IrYqq5dflZ1LaHutXQaASJRV5bBJy/+42jVwdMyHVZjt
X-Google-Smtp-Source: AGHT+IHFuKD/alj7Tvw1QRL+ZDiUerVxsh89Uw/OCTdbXJ84V2Swm+uViST8NBNaJ/nGNOnfA5XbZg==
X-Received: by 2002:a17:90a:5d18:b0:2c9:8189:7b4f with SMTP id 98e67ed59e1d1-2d20d2570cfmr1963965a91.32.1723423966631;
        Sun, 11 Aug 2024 17:52:46 -0700 (PDT)
Received: from realwakka-Home ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9c7bcecsm6917056a91.17.2024.08.11.17.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 17:52:46 -0700 (PDT)
Date: Mon, 12 Aug 2024 09:52:37 +0900
From: Sidong Yang <realwakka@gmail.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2] btrfs-progs: property: introduce
 drop_subtree_threshold property
Message-ID: <Zrlc1RD3Sg7nGOsH@realwakka-Home>
References: <20240811122415.6575-1-realwakka@gmail.com>
 <972ddd12-2196-4709-a7ef-549992ba4a43@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <972ddd12-2196-4709-a7ef-549992ba4a43@suse.com>

On Mon, Aug 12, 2024 at 08:16:13AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/8/11 21:54, Sidong Yang 写道:
> > This patch introduces new property drop_subtree_threshold. This property
> > could be set/get easily by root dir without find sysfs path.
> > 
> > Fixes: https://github.com/kdave/btrfs-progs/issues/795
> > 
> > Issue: #795
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > ---
> > v2: error msg for -ENOENT, fix desc for prop
> > ---
> >   cmds/property.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 53 insertions(+)
> > 
> > diff --git a/cmds/property.c b/cmds/property.c
> > index a36b5ab2..88344001 100644
> > --- a/cmds/property.c
> > +++ b/cmds/property.c
> > @@ -35,6 +35,7 @@
> >   #include "common/utils.h"
> >   #include "common/help.h"
> >   #include "common/filesystem-utils.h"
> > +#include "common/sysfs-utils.h"
> >   #include "cmds/commands.h"
> >   #include "cmds/props.h"
> > @@ -236,6 +237,50 @@ out:
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
> > +		if (sysfs_fd == -ENOENT) {
> > +			error("failed to access qgroups/drop_subtree_threshold for %s,"
> > +			      " quota should be enabled for this property: %m",
> > +			      object);
> 
> I do not think this needs to be error(), warning() should be enough.
> 
> > +		}
> > +		close(fd);
> > +		return -errno;
> 
> Furthermore for ENOENT case I do not even think we should return error.
> 
> The point here is, if qgroup is not running (or running in simple quota)
> mode, there is no need to set threshold at all, thus no need to return any
> error.
> 
Okay, I understood. It's better to return 0 if qgroup is not running in
next patch version.
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
> >   const struct prop_handler prop_handlers[] = {
> >   	{
> > @@ -259,6 +304,14 @@ const struct prop_handler prop_handlers[] = {
> >   		.types = prop_object_inode,
> >   		.handler = prop_compression
> >   	},
> > +	{
> > +		.name = "drop_subtree_threshold",
> > +		.desc = "subtree level threshold to mark qgroup inconsistent during"
> > +		"snapshot deletion, can reduce qgroup workload of snapshot deletion",
> 
> Please do not break the string, even it's very long.

Thanks, I was worried about this.

Thanks,
Sidong
> 
> Thanks,
> Qu
> 
> > +		.read_only = 0,
> > +		.types = prop_object_root,
> > +		.handler = prop_drop_subtree_threshold
> > +	},
> >   	{NULL, NULL, 0, 0, NULL}
> >   };

