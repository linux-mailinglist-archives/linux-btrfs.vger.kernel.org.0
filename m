Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B95F78EF81
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2019 17:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbfHOPh2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Aug 2019 11:37:28 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43114 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730491AbfHOPhP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Aug 2019 11:37:15 -0400
Received: by mail-qk1-f194.google.com with SMTP id m2so2129345qkd.10
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2019 08:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XVjUpcFYD1ci28Ctlt3H1bt2XvGHoPCMziTuLM3PvyM=;
        b=Hag3O+pho7bKOdFneZYMjnHHEAWXvWd0Tf1wntt/HnEqEzRIieLf1S6xLicPIHj4K9
         FxVvfS0RYRsaOb8jP7c0P/4HPN4Dj2IJPGm609RLAdqohJFvhHWBK+OAII8cHYHX0Vi2
         USWMLQ0roAGjcjUZ3n9QVzvlmuC+DNN2D2F5TDTjL4M4gmK8ZDFO3oTP94bj2RnjPoCT
         s4bAvAxnC59IMbD12ZDKKmawxUTg89PbeGmo/mPOFjsbWTN7t5S/Qbt4FNpmNSCGd+BI
         sgafPdXSby2Z5Ub7jSBq3b73tTvVXR16NuPNU07FX6YchzmHGjS6VnyK0PkR2CnoGMe9
         oKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XVjUpcFYD1ci28Ctlt3H1bt2XvGHoPCMziTuLM3PvyM=;
        b=mckgEg5AYtSLw1lMqfOa0xGaK0SWFTKfLIpmxD3vjDkeieKYR+34e2h8gRJBSeh1pO
         nrlzY3BuOZTDdMFThpJZm025qdSrOL/FoKyO4x61PMmp0C/qO3CcnP/nFpIpVf/MpvGn
         7DDyueC10fG7/yBHNc9f113YFDorgIE5jL14BzyomYQaXmnxrjKfG8S5n8mnCEyc4fIe
         8XbN1T0Na86jxcgO3F/5gfXMGeU2YZ9He6dfoj+8ZQJ8m6h7KrgzOt7nzeseh4XefVQC
         ZqPkmC2FAPI7UQqI37Uj7x9N2mitOKlkhRclf+JVvRDuk4QQyAGzHAiPt+ZEnvJskaT8
         oHOg==
X-Gm-Message-State: APjAAAUBtct9yZXeCWt5WzRibwf8gES5jCr6H4pNNJ8p1CW17DyHqSuY
        iNJy8tsEebmQxWyRbySk5dW0/g==
X-Google-Smtp-Source: APXvYqw5t3F1cacvLOI7Wando0f98ug/NuLb7Y+lryciq7ETrEXJ58BsflXFruNa3urm/wuV41/pIg==
X-Received: by 2002:a37:6905:: with SMTP id e5mr4533206qkc.121.1565883434122;
        Thu, 15 Aug 2019 08:37:14 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::7746])
        by smtp.gmail.com with ESMTPSA id x3sm1605791qkl.71.2019.08.15.08.37.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 08:37:13 -0700 (PDT)
Date:   Thu, 15 Aug 2019 11:37:12 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/2] fstests: make generic/500 xfs+ext4 only
Message-ID: <20190815153711.dwturun54gtibldz@macbook-pro-91.dhcp.thefacebook.com>
References: <20190815150033.15996-1-josef@toxicpanda.com>
 <20190815152425.GA15181@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815152425.GA15181@magnolia>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 15, 2019 at 08:24:25AM -0700, Darrick J. Wong wrote:
> On Thu, Aug 15, 2019 at 11:00:31AM -0400, Josef Bacik wrote:
> > I recently fixed some bugs in btrfs's enospc handling that made it start
> > failing generic/500.
> > 
> > The point of this test is to make the thin provisioned device run out of
> > space, which results in an EIO being seen on a device from the file
> > systems perspective.  This is fine for xfs and ext4 who's metadata is
> > being overwritten and already allocated on the thin provisioned device.
> > They get an EIO on data writes, fstrim to free up the space, and keep it
> > going.
> > 
> > Btrfs however has dynamic metadata, so the rm -rf could result in
> > metadata IO being done on the file system.  Since the thin provisioned
> > device is out of space this gives us an EIO, and we flip read only.  We
> > didn't remove the file, so the fstrim doesn't recover space anyway, so
> > we can't even fstrim and remount.
> > 
> > Make this test for ext4/xfs only, it just simply won't work right for
> > btrfs in it's current form.
> 
> How about:
> 
> test $FSTYP = "btrfs" && _notrun "btrfs doesn't work that way lol"
> 
> since afaik btrfs is the only fs that shouldn't run this test?
> Also, I think Ted was trying to kill off tests/shared/...
> 

That explains why it seemed emptier than normal.  Yeah that sounds like a fine
solution to me, I'll send a updated patch shortly.  Thanks,

Josef
