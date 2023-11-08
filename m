Return-Path: <linux-btrfs+bounces-28-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909D87E5A80
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Nov 2023 16:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C57728154C
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Nov 2023 15:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A6030656;
	Wed,  8 Nov 2023 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="P6x3gkIM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D1E3035B
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Nov 2023 15:52:24 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CDA1FEF
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Nov 2023 07:52:23 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-66fa16092c0so47820866d6.0
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Nov 2023 07:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699458743; x=1700063543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VpSU8b6e4/5zSa52UFxV5Lqhwn5geUvXphUDenPaLtw=;
        b=P6x3gkIMpvigr15qgGDcEb/pirGVW7/O+ypiDPkpc/7/vzOegV5vMgOlHot6tmEwqL
         NSt4OP9Pw4q52ZMuzmPMNUMLa0g/8NoGtZ5MwkQgLNEm9dHwbCpTIn94elAN/CAx9Va/
         4Qy6/dszdUuEItMq6E6WgX/l69QPg1mvi4zamwzNflVonB6q3AjeugirUvGypL5VVySD
         +xIkX8IrzCYCsk0y7ozhc4cpnvSPu0G6mevvsT6WnRwL1MLk5AD5L2qlrY3rOQK5jJ8p
         +DEQkr0fv6Xg3i7SrTUaGS3iWPEd9+KocJ9aE64zxYqNz4UKxuNmtG+dlbM5ZBhzLHx/
         qCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699458743; x=1700063543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpSU8b6e4/5zSa52UFxV5Lqhwn5geUvXphUDenPaLtw=;
        b=uZ96bUQ7vDHGyCB/gv7zFN2rla9qxSn4HopbRp8Tyo0mUq4v7z0UKOI3pZ27kbPRml
         oB4tSu3f18rTC4DbUha6/ZWONFv+4qTC37UIm5rRh1uEXgpoaYP5RIFxNMEU01FbqnJJ
         1v5gTIJoC5DMXVwCylyAxZzX/8zB72sxIIwog3fF2IQYHX6iyDlRiyz3IZsYdBVkj+Ec
         KgewpF4N2LTqB9z6i7GEGGNc/mVlDQHpl4EUiz+FEhc5Sq2wIPYOj0fec5lrf/Tdon2E
         MTtFmf5I5Rp0dY/7MbJxFEbTBo3gzZfeSxIJZAypIe4ENL3KqLG9Up07vut/furdb+TN
         dWDQ==
X-Gm-Message-State: AOJu0YxyB7xQqtPwzj7DKu8HRDj5UJ1HaoojslHXZcg6h+5G0Y8AZy0B
	NC0BAZ2owSXyGBVclYXiAUV0gw==
X-Google-Smtp-Source: AGHT+IFlCTcQbTlf3rMhvY4yZuLyhWoZ1K1k3LaIUXWbU1yQceXTZB7c8QH7IjArp1psru/DB9tIvQ==
X-Received: by 2002:a05:6214:2029:b0:66d:4a22:d7cd with SMTP id 9-20020a056214202900b0066d4a22d7cdmr2161193qvf.60.1699458742750;
        Wed, 08 Nov 2023 07:52:22 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id i5-20020ad44105000000b00671248b9cfcsm1190405qvp.67.2023.11.08.07.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 07:52:22 -0800 (PST)
Date: Wed, 8 Nov 2023 10:52:21 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"kernel-team@fb.com" <kernel-team@fb.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>
Subject: Re: [PATCH 06/18] btrfs: split out ro->rw and rw->ro helpers into
 their own functions
Message-ID: <20231108155221.GA458562@perftesting>
References: <cover.1699308010.git.josef@toxicpanda.com>
 <bb944da42fc7d01832f72495ec07f9a82a133376.1699308010.git.josef@toxicpanda.com>
 <1a5369c6-24e0-45dd-a867-5844e8171fb9@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a5369c6-24e0-45dd-a867-5844e8171fb9@wdc.com>

On Tue, Nov 07, 2023 at 03:16:50PM +0000, Johannes Thumshirn wrote:
> On 06.11.23 23:09, Josef Bacik wrote:
> > +	if (btrfs_super_log_root(fs_info->super_copy) != 0) {
> > +		btrfs_warn(fs_info,
> > +			   "mount required to replay tree-log, cannot remount read-write");
> > +		return -EINVAL;
> > +	}
> 
> I get that this is only a copy of the old code, but if you have to 
> re-spin the series:
> 
> 	ret = btrfs_super_log_root(fs_info->super_copy);
> 	if (ret) {
> 		/* [...] */
> 	}

This tells us the bytenr, it's not a return value.  Thanks,

Josef

