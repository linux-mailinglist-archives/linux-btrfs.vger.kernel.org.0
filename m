Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D38F4EB0A3
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Oct 2019 13:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfJaMzZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Oct 2019 08:55:25 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41875 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJaMzZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Oct 2019 08:55:25 -0400
Received: by mail-qt1-f196.google.com with SMTP id o3so8384263qtj.8
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Oct 2019 05:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2CiqJwBRgrNFRLPdb+5H3p4ZPyEt0LjeExglRlzffvY=;
        b=yduw0qXCT/Do0wxf7XETbIQaDBNhU0hKS9DSzVbZsT9Fewgbi2XgdwhGsfoedriXvq
         pT409ZfDXfeXEkki2nYZsp9XrX7Zv0ikdWCzRizHOfFlHVm7pN7Ddwj+7gd5FhZuR89H
         qZMfF4GDAdcXd16xmY6FA6vquFWVfoJhoJfWj0Q7HhgEwDunGDCWcQXQuut+8gy9LW29
         2I7aiy6omZGrVR1bNYyHKNDIGHRIdS+N5Kivw3ofJ/j6FQzcY9lPn2S3LYVFPy7zEXUr
         TaKe7sCKdqj1RAPfnocArOWmG6vggPiZ5iMBuLoOGdeh9y2poKmAIfg1w393R4czIPvp
         i3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2CiqJwBRgrNFRLPdb+5H3p4ZPyEt0LjeExglRlzffvY=;
        b=eDf5XTIRNumNJJHS7KKrU7kz4wjWeLRDIwIftKDFAoFaOGqZIEgsFScHI0xs/XyK7+
         BBzdMLXdVdGqNHmc6D8FY4GAaIzCUftHWcPEskmUDehnprViL3cTP5eJksR6avC3P40U
         tsOD3femZU2vu+RpfjI4vEd7a9e7RxkezjlDo6RNCzkycPaX9OO5ur1Q9yvmVBRWSI5/
         bDyRJas/kqM/lTXMnnT0Mzym11eOTxtgZCU8eQEVfQZW5CcEWTLAJCx+Cz/TAI3dvvnL
         BDwK1iXNu/K+NM04FKt42xBh9uTEIDI1HHZHKFcUGoNEi8LhsaIHKG+AZpdufYMQo3Nh
         fjdQ==
X-Gm-Message-State: APjAAAU4GlaUAVIwYDYcdPj5vHXF5+f0C8F5MMlvg9q3kCymgi4HqAvf
        +vdKrhBnXyxknM/rMZZHhqyhB2cG1Gfi9g==
X-Google-Smtp-Source: APXvYqw6MQpftKezUchSVfF3Cv9zSx5tg7eh7Szdh/qvudCBYubbi7ZlM+aNp1lqeD2bfsL64/dmIA==
X-Received: by 2002:a05:6214:170c:: with SMTP id db12mr4456711qvb.202.1572526523788;
        Thu, 31 Oct 2019 05:55:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::8898])
        by smtp.gmail.com with ESMTPSA id w18sm2064796qkb.41.2019.10.31.05.55.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 05:55:22 -0700 (PDT)
Date:   Thu, 31 Oct 2019 08:55:21 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: send, allow clone operations within the same file
Message-ID: <20191031125520.mla5v3k4dkceltty@macbook-pro-91.dhcp.thefacebook.com>
References: <20191030122311.31349-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030122311.31349-1-fdmanana@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 30, 2019 at 12:23:11PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> For send we currently skip clone operations when the source and destination
> files are the same. This is so because clone didn't support this case in
> its early days, but support for it was added back in May 2013 by commit
> a96fbc72884fcb ("Btrfs: allow file data clone within a file"). This change
> adds support for it.
> 
> Example:
> 
>   $ mkfs.btrfs -f /dev/sdd
>   $ mount /dev/sdd /mnt/sdd
> 
>   $ xfs_io -f -c "pwrite -S 0xab -b 64K 0 64K" /mnt/sdd/foobar
>   $ xfs_io -c "reflink /mnt/sdd/foobar 0 64K 64K" /mnt/sdd/foobar
> 
>   $ btrfs subvolume snapshot -r /mnt/sdd /mnt/sdd/snap
> 
>   $ mkfs.btrfs -f /dev/sde
>   $ mount /dev/sde /mnt/sde
> 
>   $ btrfs send /mnt/sdd/snap | btrfs receive /mnt/sde
> 
> Without this change file foobar at the destination has a single 128Kb
> extent:
> 
>   $ filefrag -v /mnt/sde/snap/foobar
>   Filesystem type is: 9123683e
>   File size of /mnt/sde/snap/foobar is 131072 (32 blocks of 4096 bytes)
>    ext:     logical_offset:        physical_offset: length:   expected: flags:
>      0:        0..      31:          0..        31:     32:             last,unknown_loc,delalloc,eof
>   /mnt/sde/snap/foobar: 1 extent found
> 
> With this we get a single 64Kb extent that is shared at file offsets 0
> and 64K, just like in the source filesystem:
> 
>   $ filefrag -v /mnt/sde/snap/foobar
>   Filesystem type is: 9123683e
>   File size of /mnt/sde/snap/foobar is 131072 (32 blocks of 4096 bytes)
>    ext:     logical_offset:        physical_offset: length:   expected: flags:
>      0:        0..      15:       3328..      3343:     16:             shared
>      1:       16..      31:       3328..      3343:     16:       3344: last,shared,eof
>   /mnt/sde/snap/foobar: 2 extents found
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
