Return-Path: <linux-btrfs+bounces-7109-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2542F94E416
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 02:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0600281DC3
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 00:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CB24A39;
	Mon, 12 Aug 2024 00:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFkUC92G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31122193
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 00:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424063; cv=none; b=lEMWMgaOQHrY8ZvySHLnIFzHHHTXTLCZtSyal6l+BlrL+rISTwavLesfBIdVX7PHWEnLSBbowJdF/V6cOxcPsmEZy9qbzsVOlr7WxO4MbHXgLvKK9Otco/F4OpErKTMpnJmFZxbYDDK6f8/qjcUWhWHm9NxjFU4Yf0xgt3PpxfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424063; c=relaxed/simple;
	bh=dqSl8PX8QkIDzBp8DBqs7qFGws9459Yqd+VcDAn2BXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r39yB2DkJS6zHu8H41LBSJTFcqL1jXV2oalXxVXMugNLef6KM3oJ9AYSDMXW+Pg9OGuljNyS4/+BI1YI4KtFZBWbnHser9O/5wbG/rU40cwbAOtxQdKHPGsqnyiBBa4xCnmdV3gO6BikYZuG11r2JKZp5uahGZhO96x2AtB3VDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFkUC92G; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7105043330aso3051682b3a.0
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Aug 2024 17:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723424061; x=1724028861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HxERoeM2Tieen0MqFAzA15ucNVlgc4ZyU0DqllfJJLA=;
        b=gFkUC92Gt0kWqsuGKVOvI2JuhwtDBrwfonDVZi9w9GI3O3lF3kdEbhGNAzD8T4jFiv
         q2cQOyu4qFVNw8h9IxY62QDE0PLHaMDhwEEctO2MEuQ9YUYAF3fRetVnyhSgP4IFQ7jL
         l8X6+0NmiNC58i77zB9iTjZuk7EFfgr7vyCS6B9WbcOJOSela5FVSO9EMiRpXe+0Bnnk
         cRPSDAHVPlgLwgwYw79EBCkDhns29QWHFTUyY6y2k1BohkWELgg+E8HAPD8j1y9+KaEV
         VJ781tLicqZqKvslxCXhtMDKd3YmbIfLecS8R6htGiXaOEx4yiNmw1qYBpjt56kF3KlT
         swtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723424061; x=1724028861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxERoeM2Tieen0MqFAzA15ucNVlgc4ZyU0DqllfJJLA=;
        b=HT347xp8pwXN8usGDJh8xJIR8fbZCncLF8z500NWifEf8pLlQI+3lPxWq0LdMEcl/C
         NdzLvh0MvfRaebFPm7CkTvX2xsi/BuWDYQEpY0MVKkA+/RM+74ufYbfolT+5dQMVi8MQ
         4TueAEXXW7UVTCNCnCcPs64bzgypjE9v7Vb/gm7ez+nfdVFTQaKyO4GJsnRm1RsanDaA
         H7LrwH0Cs/HQsUc8pa/Kpb8aNax+11SkSierXPtmoudAHAJget3r8goS0p2gcbrtWLmp
         OMFFU4wApPqMTyAfLwV/JuxueuNNSX9NsYEXOcpAoyYQ1nIfWLdUdWsDEbTN6uFqbd04
         pXvQ==
X-Gm-Message-State: AOJu0YxiUlrbwktqGzN9HoCLIRoirPS5I7ntld/3Ut1GOawCjZXb0bMN
	Gg5bkQeCz69hyvaaaNUEylOuGZ1HhE+nwnZ7NBwjy/LNdXDtbSji
X-Google-Smtp-Source: AGHT+IEtCjdCyMT35yuY/Me/3C6Xz9zXf51horm+4GtKpvn9e/HD+q8IEnbk/GJAoJdQrRPMuJ5LVQ==
X-Received: by 2002:a05:6a20:c792:b0:1c3:b20e:8bbf with SMTP id adf61e73a8af0-1c89fe99fd9mr7097081637.14.1723424061366;
        Sun, 11 Aug 2024 17:54:21 -0700 (PDT)
Received: from realwakka-Home ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb9b2116sm27177445ad.125.2024.08.11.17.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 17:54:21 -0700 (PDT)
Date: Mon, 12 Aug 2024 09:54:18 +0900
From: Sidong Yang <realwakka@gmail.com>
To: Roman Mamedov <rm@romanrm.net>
Cc: linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2] btrfs-progs: property: introduce
 drop_subtree_threshold property
Message-ID: <ZrldOnquhXt_pCVv@realwakka-Home>
References: <20240811122415.6575-1-realwakka@gmail.com>
 <20240812041720.55fff9f6@nvm>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812041720.55fff9f6@nvm>

On Mon, Aug 12, 2024 at 04:17:20AM +0500, Roman Mamedov wrote:

Hi! Roman.
Thanks for review.
> On Sun, 11 Aug 2024 12:24:15 +0000
> Sidong Yang <realwakka@gmail.com> wrote:
> 
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
> >  cmds/property.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> > 
> > diff --git a/cmds/property.c b/cmds/property.c
> > index a36b5ab2..88344001 100644
> > --- a/cmds/property.c
> > +++ b/cmds/property.c
> > @@ -35,6 +35,7 @@
> >  #include "common/utils.h"
> >  #include "common/help.h"
> >  #include "common/filesystem-utils.h"
> > +#include "common/sysfs-utils.h"
> >  #include "cmds/commands.h"
> >  #include "cmds/props.h"
> >  
> > @@ -236,6 +237,50 @@ out:
> >  
> >  	return ret;
> >  }
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
> 
> This line is indented with spaces instead of TABs like the rest and as it
> should. I did not check if this is the only occurrence.
> 
> Checkpatch should catch this: https://docs.kernel.org/dev-tools/checkpatch.html

Oops, I didn't notice about this. thanks for tip!


> 
> > +	if (fd < 0)
> > +		return -errno;
> > +
> > +	sysfs_fd = sysfs_open_fsid_file(fd, "qgroups/drop_subtree_threshold");
> > +	if (sysfs_fd < 0) {
> > +		if (sysfs_fd == -ENOENT) {
> > +			error("failed to access qgroups/drop_subtree_threshold for %s,"
> > +			      " quota should be enabled for this property: %m",
> > +			      object);
> > +		}
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
> >  const struct prop_handler prop_handlers[] = {
> >  	{
> > @@ -259,6 +304,14 @@ const struct prop_handler prop_handlers[] = {
> >  		.types = prop_object_inode,
> >  		.handler = prop_compression
> >  	},
> > +	{
> > +		.name = "drop_subtree_threshold",
> > +		.desc = "subtree level threshold to mark qgroup inconsistent during"
> > +		"snapshot deletion, can reduce qgroup workload of snapshot deletion",
> > +		.read_only = 0,
> > +		.types = prop_object_root,
> > +		.handler = prop_drop_subtree_threshold
> > +	},
> >  	{NULL, NULL, 0, 0, NULL}
> >  };
> >  
> 
> 
> -- 
> With respect,
> Roman

Thanks,
Sidong

