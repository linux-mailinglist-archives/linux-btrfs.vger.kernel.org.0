Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC8E13FAC9
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2020 21:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbgAPUnc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jan 2020 15:43:32 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:50655 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729240AbgAPUnc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jan 2020 15:43:32 -0500
Received: by mail-pj1-f68.google.com with SMTP id r67so2102981pjb.0
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jan 2020 12:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QbMms0lDbtJGgGdsU5nhGcLfTOKpG3bDDjLVibM7xYM=;
        b=LztzVjjJaon5K4Lw2/Jqd4cPWHJXzK0uddUyLFflkhVF8i2eZUtklqgMJDUWFd4l3X
         l2tfu8DDVYwVhR2rccukpaB7jZ33UwqmF7vfC+u9yIyYZPMRLNITBzsJmefKj2/FgYNk
         zNhucZ4USIieR1fMN83DLUpMa2lyUjUWPFwX/dXHVBL56De0LD6XdwZ0zWWSNB724kxt
         gZDKYUcK18oAKqzKHmVra6Yrtt4SuNtQR9WxY+NR1KkZVmkmfILQpHjs0JH8QI+WXMLI
         yx49pyS+vukGm056TFG/phi/r3tptAjrSI3eSnby6w0DQir/udSXRIoJ8Ilh5Ubp2nYU
         Gpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QbMms0lDbtJGgGdsU5nhGcLfTOKpG3bDDjLVibM7xYM=;
        b=sZnIUtE8/TV0gSIpBM5juiccXegEJucN+PU+P4HkE8WTYfd1dHayRgFBXxLsIc/RPC
         aN29Y+2IeD9sXmkwjS6Ed/xoN5sENJUeBS43/1MacxdHIe+nRmSHH+4uTVwBUApu6e+s
         vKyKCV691/DytTKfZbTIKu1qZ6Mjt+oAFCsF6IiEWoL0oyO3heOgHcNhBggePSNjKRDd
         el8XfSjoULGPvfpeknk2cPiEt7GL/Nm06MwF+UrPMh3lSXJ0a0M+vg7ADoK+f5Yl9291
         I5/KUuCUVBb3vNrjkiGWOLzD5hIfYVa0ep8EsQTl4Ur6d5rJvJ0L8w+BSJvVHUx8/aXc
         bt/Q==
X-Gm-Message-State: APjAAAWTc9zRwHCiw+NBSve34fAS659q0y8CULWmVKajpn/gc73gZM7k
        QeNegOr4TLaJm3v0vE4IMU7kTw==
X-Google-Smtp-Source: APXvYqwEDNwZc5TgtUasLNqErlmDODyDwlF/oXDjo2Vc4y3eeHbX1PEDZNTqRd7zxxlDk6d9JtZmWA==
X-Received: by 2002:a17:90a:e2ce:: with SMTP id fr14mr1201485pjb.99.1579207411137;
        Thu, 16 Jan 2020 12:43:31 -0800 (PST)
Received: from vader ([2620:10d:c090:180::582a])
        by smtp.gmail.com with ESMTPSA id a10sm25950930pgm.81.2020.01.16.12.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 12:43:30 -0800 (PST)
Date:   Thu, 16 Jan 2020 12:43:29 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Michael Ruiz <michael@mruiz.dev>, linux-btrfs@vger.kernel.org,
        osandov@fb.com
Subject: Re: Linux swap file not activating after reboot
Message-ID: <20200116204329.GA269122@vader>
References: <5318295.DvuYhMxLoT@archlinux>
 <20200116185539.GZ3929@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116185539.GZ3929@twin.jikos.cz>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 16, 2020 at 07:55:39PM +0100, David Sterba wrote:
> On Wed, Jan 15, 2020 at 04:34:02PM -0800, Michael Ruiz wrote:
> > Hi,
> >  I have a //@swap subvolume and i have a swapfile within it. I mount the 
> > subvolume like such in fstab:
> > 
> > `rw,ssd,nofail,noautodefrag,nodatacow,nodatasum,subvolid=1234,subvol=/@swap`
> > 
> > It mounts correctly, but 1/15/20 4:20 PM kernel I get: 
> > 
> > `BTRFS warning (device dm-0): swapfile must not be copy-on-write`
> 
> There are two reasons why the message is printed, one is when the file
> does not have the C attribute and another one when the the existing file
> extents need to be COWed (same case as if the file is NOCOW and has been
> snapshotted).
> 
> Plain reboot will not change the C attribute, so either there's a
> snapshot of /@snap or the check of a used swapfile is wrong.
> 
> I tested it here, a swapfile that got almost full after a stress test,
> followed by reboot and swapon (without any change to the file) was ok.
> 
> Doing a snapshot and swapon resulted in the message you saw.
> 
> After deleting the snapshot and waiting until it gets cleaned, swapon
> did not activate the file anymore. Filefrag or fiemap don't report any
> shared extents so here I' expect that the file should be in a valid
> state for swapon.
> 
> Omar, any ideas?

Hm, we're hitting this check in can_nocow_extent():

        if (btrfs_file_extent_generation(leaf, fi) <=
            btrfs_root_last_snapshot(&root->root_item))

That check was added in 78d4295b1eee ("btrfs: lift some
btrfs_cross_ref_exist checks in nocow path") as an optimization. Even if
we comment that out, we'll hit the similar check in
btrfs_cross_ref_exist():

        /* If extent created before last snapshot => it's definitely shared */
        if (btrfs_extent_generation(leaf, ei) <=
            btrfs_root_last_snapshot(&root->root_item))

That's not quite right in exactly this case that the snapshot has been
deleted. Apparently we've been doing unnecessary COW for this case. I'll
need to think about how to safely avoid these checks without too much of
a performance hit.

Thanks for the report!
