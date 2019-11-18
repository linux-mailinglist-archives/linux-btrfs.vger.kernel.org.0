Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F63110087A
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 16:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfKRPl6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 10:41:58 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:34958 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfKRPl6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 10:41:58 -0500
Received: by mail-qv1-f66.google.com with SMTP id y18so6713271qve.2
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 07:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AS5nn6G0MxDDlLbtJwkC1Km7zdidr6MfarIMmEcG9k0=;
        b=G1TrmV5klIOxnDnKhkvZhAJqrwqge2suZiTh9HfBXlINZSKXRyT6FJb2UrZhaRCX1D
         AGDlkvzk05Yrfumq/RTQMO3oAys3F4Sm7kE/9Zu6+owp0rG+Xy+BBx/Xb2Wqe+GPIb4n
         Q+U3Gh+4ustcrPnJPgYHFimKADqhJmFTNxLcW1+qaw5UPyen+7LxJKMGVfjSFZ2+JU23
         xWYl/pAsbWABh8NyVp0XymCKG52+u/R+CjtLdkR9UlUPZj/AYFRHGfQErS/HidRReom+
         Ib5HY/sQLSzTLwZBr6mk/N2oqxhg7ajESrbbLWN36c1Cov1oRDD9lNFQsN+CFiMH1YS3
         ki2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AS5nn6G0MxDDlLbtJwkC1Km7zdidr6MfarIMmEcG9k0=;
        b=sE1iAaNfLFawFAqpjLsZt+DDVrifrcgq4tb0zP5xjiMsXP68yqJ6/HBYbXNiAexXp4
         L1wMNjMNqObXU7FS1VRS2x2DkOnRvprlUDuVNXZnyS9uFAQ8msHmGIcp2p4osOviylMu
         TLomLmjOzY3QQ1t6CLGyCDLBdBLw6XSQc1igilKwRNl0/wHR3CyuOpmZQs8ghcgwviFw
         1rzBB7/+pFGKbe/TS9zN8Zj8GoM5OKPADw2VZsavMjYYkHHPNrLOO9g8iVi+UxHLH4nt
         x0xciwAMY3OpymJo0P4bRI1D5RoK9NdJzgDGGFo/r0i2qdYdkm+xPQL/5B5vajnKo+BJ
         NFvQ==
X-Gm-Message-State: APjAAAWjljKZno1gy01+l/HF8+OOEyKUBAAIkDkrV9biMPBsiudFZBGg
        DJwCzxv/EGsJzrPqH2+3fc4sag==
X-Google-Smtp-Source: APXvYqwaYxc9RRdHBFKK4btKCm2aGswmENHGaY8HT3BUXEi2Qi65aLofTJtsyrTW/uOiqeFhRB3SPw==
X-Received: by 2002:a0c:ac4b:: with SMTP id m11mr14614929qvb.235.1574091717107;
        Mon, 18 Nov 2019 07:41:57 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::9492])
        by smtp.gmail.com with ESMTPSA id y29sm10939887qtc.8.2019.11.18.07.41.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 07:41:56 -0800 (PST)
Date:   Mon, 18 Nov 2019 10:41:54 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] Remove extent_map::bdev
Message-ID: <20191118154154.wfter4dio7mlibva@macbook-pro-91.dhcp.thefacebook.com>
References: <cover.1570474492.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1570474492.git.dsterba@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 09:37:40PM +0200, David Sterba wrote:
> The extent_map::bdev is unused and and can be removed, but it's not
> straightforward so there are several steps. The first patch decouples
> bdev from map_lookup. The remaining patches clean up use of the bdev,
> removing a few bio_set_dev on the way. In the end, submit_extent_page is
> one parameter lighter.
> 
> This has survived several fstests runs
> 
> David Sterba (5):
>   btrfs: assert extent_map bdevs and lookup_map and split
>   btrfs: get bdev from latest_dev for dio bh_result
>   btrfs: drop bio_set_dev where not needed
>   btrfs: remove extent_map::bdev
>   btrfs: drop bdev argument from submit_extent_page
> 
>  fs/btrfs/compression.c | 10 ----------
>  fs/btrfs/disk-io.c     |  3 ---
>  fs/btrfs/extent_io.c   | 15 +++------------
>  fs/btrfs/extent_map.c  |  6 +++++-
>  fs/btrfs/extent_map.h  | 11 ++---------
>  fs/btrfs/file-item.c   |  1 -
>  fs/btrfs/file.c        |  3 ---
>  fs/btrfs/inode.c       | 14 ++++----------
>  fs/btrfs/relocation.c  |  2 --
>  9 files changed, 14 insertions(+), 51 deletions(-)
> 

This series needs to be dropped from misc-next, it causes any box with cgroups
enabled to crash on boot.  The bio requires having a bio->bi_disk set when we do
wbc_init_bio, which we no longer have with this patch.

To fix this you would need to do something similar to what we do with
compression, save the wbc css in the bbio and then call the associate_blkg at
submit time.

However, this is problematic right now because we don't get notified when the
bbio is free'd.  We have no way to free the ref on the css we save, which means
infrastructure needs to be added to biosets so we can get called at free time
for every bio in a bioset.  Or we can add back the bi_css to the bio, but that
seems like a less good idea.

Either way this needs to be dropped until this is addressed.  Thanks,

Josef
