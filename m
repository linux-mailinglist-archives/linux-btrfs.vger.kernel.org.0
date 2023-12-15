Return-Path: <linux-btrfs+bounces-973-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFE9814A71
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 15:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AC7A1C20DC4
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 14:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E0B31A79;
	Fri, 15 Dec 2023 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="fsH9Fsk+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCC931A69
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Dec 2023 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5e2bd289172so6313447b3.0
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Dec 2023 06:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1702650392; x=1703255192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+4V/xtuU5RtW7auv55nECI5YJaBifIHvReIdoO950Ik=;
        b=fsH9Fsk+hk7UK5xelpzTDhf5qmKjvpAZPUx1iXrFy36UHS/i+FyVliO8ZiK7Bnuv3p
         bgvDGF0P6UVVryG1F/tcbB29gUoDjTWl6/AvPUMDxV18bfXrdEjhY+iX6e+qN2NH33Je
         VVjopa6B+3wW3eegOGIhbAyVvIyM35KyY7JBrV6jykv6ZTV8cohDxee+uq6tG+3Ryndv
         z6O3MbJa4faLHIxdSG0Jp7e60zqbnMP1CJ1RSNxp1TB0Y7KD3RMThNId69csBgew3jM0
         /UtFD22qUqm1jozA77C2TEN1uM4HSuhewNEBcGNfCsgjWeK7QVwaITyQzX+2/Fxwd/I/
         X07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702650392; x=1703255192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4V/xtuU5RtW7auv55nECI5YJaBifIHvReIdoO950Ik=;
        b=oZBpFo7HyCLZj0qk6pLGLXYOtcXqkmMMU1rldKEIXCgx69FRykKtqVLducIoThMF0A
         hpbY/7NzzR5SFoQFdDT0C4DE+nSLY9EcsHy/iiLVv/O/E8gSl7aKYd+Iq89MVCcZp0iO
         Z0JeJdzNdPEPyxJ133iiAjGklQaCoMDtSSBFasXiUFMhuKZmFP2/ZBZCpyobz/67Tdm7
         HEMgmrMxT55r5EIxD6Qs+Yd9jbJnleo51qgn3FU0scRzw2ICqnnQDGE4YQPqiXZW9Odq
         1EZT5VFY4OBo+pOfCTHv6HuKllNc8gbu/KILFKaAMN1iBK/55V/SAPsc/wn0rrnpHaDv
         0K7g==
X-Gm-Message-State: AOJu0Yw4eVsIitqasqD/xXa24sfWEk1AQZuH6W6CYeuH38urkJ5BX/A+
	SDIRL/xHvTDoxycqVm+ORF4Vzw==
X-Google-Smtp-Source: AGHT+IGpj2fZ4DlpWbI9o2AbVXyl3n081P7woEHQN+l8wabNi4vE8R5e3ZFfwi7WbmH7RL0B6LtbAw==
X-Received: by 2002:a0d:d812:0:b0:5e3:347b:e864 with SMTP id a18-20020a0dd812000000b005e3347be864mr3181497ywe.26.1702650392430;
        Fri, 15 Dec 2023 06:26:32 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x8-20020a814a08000000b005d3b4fce438sm6269510ywa.65.2023.12.15.06.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 06:26:31 -0800 (PST)
Date: Fri, 15 Dec 2023 09:26:30 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 1/3] btrfs: call btrfs_close_devices from ->kill_sb
Message-ID: <20231215142630.GB683314@perftesting>
References: <20231213040018.73803-1-ebiggers@kernel.org>
 <20231213040018.73803-2-ebiggers@kernel.org>
 <20231213084123.GA6184@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213084123.GA6184@lst.de>

On Wed, Dec 13, 2023 at 09:41:23AM +0100, Christoph Hellwig wrote:
> On Tue, Dec 12, 2023 at 08:00:16PM -0800, Eric Biggers wrote:
> > From: Christoph Hellwig <hch@lst.de>
> > 
> > blkdev_put must not be called under sb->s_umount to avoid a lock order
> > reversal with disk->open_mutex once call backs from block devices to
> > the file system using the holder ops are supported.  Move the call
> > to btrfs_close_devices into btrfs_free_fs_info so that it is closed
> > from ->kill_sb (which is also called from the mount failure handling
> > path unlike ->put_super) as well as when an fs_info is freed because
> > an existing superblock already exists.
> 
> Thanks, this looks roughly the same to what I have locally.
> 
> I did in fact forward port everything missing from the get_super
> series yesterday, but on my test setup btrfs/142 hangs even in the
> baseline setup.  I went back to Linux before giving up for now.
> 
> Josef, any chane you could throw this branch:
> 
>     git://git.infradead.org/users/hch/misc.git btrfs-holder
> 
> into your CI setup and see if it sticks?  Except for the trivial last
> three patches this is basically what you reviewed already, although
> there was some heavy rebasing due to the mount API converison.
> 

Yup, sorry Christoph I missed this email when you sent it, I'll throw it in
there now.  Thanks,

Josef

