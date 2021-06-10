Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAE53A328A
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jun 2021 19:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhFJR5Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Jun 2021 13:57:24 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:36444 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhFJR5X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Jun 2021 13:57:23 -0400
Received: by mail-pg1-f174.google.com with SMTP id 27so384805pgy.3
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Jun 2021 10:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MNsdoT3boWAB1i+9orgzeEBfmXQTkcpgJ412VLoDqrw=;
        b=MsEEQavDa6NYkECJWPknXvI05wS2CsAwVeENQC4BdGu/gjr6C/8vqrp30b+yeqWuBt
         hllPqPuayYCou5aRhwLvaeVNgUDnfadxfzkeBH6cxZA5pJXoCgm5IgOpFtJKfGAMUYvG
         rbQQ8jCIV3nRxHVrtQQU46ldU1N/0rw6Uh4Jdh8yGZApYIzsTvuaQUODv0NusjHsQCC2
         hOA3ChM/m+5fTLNR7EajBb5uDmJI3RBKnoYcRuHMX15SPGfwft1rFvJTtS195ujzBvVg
         6/tjCMN8DOmL51lLeAPkPR3omJOe03pzORmTLCoKR4TiQk1gLhJPoNdktKacMbuBpvWS
         ov1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MNsdoT3boWAB1i+9orgzeEBfmXQTkcpgJ412VLoDqrw=;
        b=heTVxSbjpJ9KMdzwPdIEkTUciGH0iB0pZN/7+esiWlpLACgWheFmpVPHNHzKvsOzDM
         DL3uCSkw4aFCulKJ2YyJZFgee3U4HWbodli/rFf+Q8r6Dmu5IFTqQmxjZ7nBAzHDVMWH
         5UEZV2QmlwgqrcIYSn57gzm5/V6Y6bG4fWiXrlWGg2tiMM5m4WmQBLi6rqNkUsGZYAci
         H0Kfgqmtow/B5aD6StXRhSQsiHnrmZ4L6Z/xX20zuyOfzn4DnCztW8vRPZ0vH6yoNASM
         H18aAbuTk+xz+MSu9cruFcJEHfmosYj+iBqmbTsHdLzutSLmjDmZ0earqd3PPv8BjzNC
         DLRw==
X-Gm-Message-State: AOAM5327cEoBhAH8VjOQkQzJnWPqYTEbCW85MlSz/etc3TSQdrqYQULC
        lpbS7s0EErtbosnXBn1OBay9UZ8JTDxGSw==
X-Google-Smtp-Source: ABdhPJw+ravLLEg1/dKZZDl64LvjbqZJkJuHnG2lVKJb3JIwCFV5nJ0/jURMF25pt/p0whqTF/dFqg==
X-Received: by 2002:a05:6a00:a16:b029:2f2:fb20:bac3 with SMTP id p22-20020a056a000a16b02902f2fb20bac3mr4087563pfh.6.1623347654224;
        Thu, 10 Jun 2021 10:54:14 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:a169])
        by smtp.gmail.com with ESMTPSA id k21sm3178528pgb.56.2021.06.10.10.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 10:54:13 -0700 (PDT)
Date:   Thu, 10 Jun 2021 10:54:12 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: sysfs: export dev stats in devinfo directory
Message-ID: <YMJRxFEciQ2lVJGC@relinquished.localdomain>
References: <20210604132058.11334-1-dsterba@suse.com>
 <YMEHVWTrcJ6ol5bH@relinquished.localdomain>
 <20210609185014.GE27283@twin.jikos.cz>
 <YMFi6fSxMUDCU/C9@relinquished.localdomain>
 <20210610163700.GC28158@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610163700.GC28158@suse.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 10, 2021 at 06:37:01PM +0200, David Sterba wrote:
> On Wed, Jun 09, 2021 at 05:55:05PM -0700, Omar Sandoval wrote:
> > > > The ioctl returns ENODEV is !dev_stats_valid, maybe this file should do
> > > > the same? It seems a little awkward to have a flag that means that the
> > > > rest of the file is meaningless.
> > > 
> > > You mean returning -ENODEV when reading the stats file? Or return 0 but
> > > the contents is something like 'stats invalid' or similar.
> > 
> > I'd vote for returning -ENODEV when reading the stats file, but I think
> > either one is fine.
> 
> Hm so I think this should reflect how the sysfs files are used. They all
> contain textual information, and errors are returned when eg. there are
> no permissions.
> 
> In a shell script it's IMHO more convenient to do
> 
> stats=$(cat $devicepath/stats)
> 
> and then validate contents of $stats rather then catching the error
> value and deciding based on that what happend. Not to say that this
> would also print an error message. I've found this in
> admin-guide/sysfs-rules.rst that's perhaps closest to a recommendation
> we could follow:
> 
> 172 - When reading and writing sysfs device attribute files, avoid dependency
> 173     on specific error codes wherever possible. This minimizes coupling to
> 174     the error handling implementation within the kernel.
> 
> So I take it as that error codes belong to the sysfs layer and the
> validity of the contents is up to the sysfs user, ie. btrfs in this
> case.

Good point. "Real" programs will just use the ioctl, so it makes sense
to cater this to shell scripts.
