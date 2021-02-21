Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF49F320AEA
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Feb 2021 15:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhBUOKU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 21 Feb 2021 09:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhBUOKT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 21 Feb 2021 09:10:19 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9970BC061574
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Feb 2021 06:09:39 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id j12so4932566pfj.12
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Feb 2021 06:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qUvTM+uKl/sqrClcKAOXOznZgQBMfO9VsVlb/ACXbuM=;
        b=S+w+PXlBqc+AoRLgRQuCf6mavNKY38q5IG1GJezbuN9l5Q+n0CknqFiC1O74GsA1DZ
         baPMWpJbeJe0T1DowKtu4VTtGXQNNo+bZ60XHtvPWrrMCI5bfpyvVZvvmcFjdTAvl1f3
         6fVqIggp6HlVd8Ew2nGex59gBVsWn3b3QDVPLV2TMv3OxBsPb3qRAjS1/6sAnSwz8tBc
         yjjBXEarN8ezFNEAJhDEKrM5zFjHtB6K3bp+uo5p1Fauuwaku/+vdwPSjgIYSSEplGzP
         +yv0drQL7LXqJSAVArbcbQLaY2N/5hPAO6QSac/2lH5yz2S7R4ZzEmoccMw+d5dY8JDH
         iCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qUvTM+uKl/sqrClcKAOXOznZgQBMfO9VsVlb/ACXbuM=;
        b=L346CGnz6R1tX/gpTvFRRyJaIuCkLY0hp+KVyRUKbGJuG43lXDXDM4cwMiT7qWY4uM
         7DUA0fLXfHpVdFyuXRQKN1+/AQDUFv/TLkpRds/1ziUDhG8LW18MeHgj3taMVEcb4xKI
         ReXwYky4qCxEihj8QMCijMZQ/K9MpZISp5uk4kvM4dBvnebrOltSTuYwChc+OnNV597s
         JcrRB0xPBc8rrhu6tO0rsVm+fbPl1EF1lWHGGlcvuzm+ZNZdFgaSkYeviJ6Zs6M9lszK
         kqg3CJsF1Y4bswhnt7otDm92+JYPc0KTTss4R1+eCYNsRH+U3TpeosAQXd7ZfZL9fHwg
         A5jg==
X-Gm-Message-State: AOAM532/zH1SxN5mAnU4eR+X0m7ScVWMhq+a/bbFjOf+TETh8OOqaG53
        CZHurGwRlognPNQ/Hu6aVhY=
X-Google-Smtp-Source: ABdhPJxgdy9G6bl3kvUIpcxga9TPDO5gvtyCeFu8aLn4RyBG7pY/wZgKSeHdgUSTIGieIq2bjoiSGw==
X-Received: by 2002:a62:8606:0:b029:1ed:55db:22b7 with SMTP id x6-20020a6286060000b02901ed55db22b7mr9696370pfd.75.1613916579020;
        Sun, 21 Feb 2021 06:09:39 -0800 (PST)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id t5sm2648185pgl.89.2021.02.21.06.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 06:09:38 -0800 (PST)
Date:   Sun, 21 Feb 2021 14:09:30 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: btrfs-progs test error on fsck/012-leaf-corruption
Message-ID: <20210221140930.GA18617@realwakka>
References: <20210218025614.GA1755@realwakka>
 <20210219161707.GF1993@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219161707.GF1993@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 19, 2021 at 05:17:07PM +0100, David Sterba wrote:
> On Thu, Feb 18, 2021 at 02:56:14AM +0000, Sidong Yang wrote:
> > I found some error when I run unittest code in btrfs-progs.
> > fsck/012-leaf-corruption test corrupt leaf and check that it's recovered.
> > but the test was failed and demsg below
> > 
> > [   47.284095] BTRFS error (device loop5): device total_bytes should be at most 27660288 but found 67108864
> > [   47.284207] BTRFS error (device loop5): failed to read chunk tree: -22
> > [   47.286465] BTRFS error (device loop5): open_ctree failed
> > 
> > I'm using kernel version 5.11 and there is no error in old version kernel.
> > I traced the kernel code and found the code that prints error message.
> > When it tried to mount btrfs, the function read_one_dev() failed.
> > I found that code added by the commit 3a160a9331112 cause this problem.
> > The unittest in btrfs-progs should be changed or kernel code should be patched?
> 
> The kernel check makes sense. The unit test fails because the image is
> restored from a dump and not extended to the full size automatically.
> 
> After 'extract_image' the image is
> 
> -rw-r--r-- 1 root root 27660288 Feb 19 17:47 good.img.restored
> -rw-r--r-- 1 root root   186392 Jul 27  2020 good.img.xz
> -rwxr-xr-x 1 root root     2788 Feb 19 17:46 test.sh
> 
> but with a manual 'truncate -s 67108864 good.img.restored' the test
> succeeds.
> 
> btrfs-image enlarges the file but it's probably taking the wrong size
> 
> 2281         dev_size = key.offset + btrfs_dev_extent_length(path.nodes[0], dev_ext);
> 2282         btrfs_release_path(&path);
> 2283
> 2284         btrfs_set_stack_device_total_bytes(dev_item, dev_size);
> 2285         btrfs_set_stack_device_bytes_used(dev_item, mdres->alloced_chunks);
> 2286         ret = fstat(out_fd, &buf);
> 2287         if (ret < 0) {
> 2288                 error("failed to stat result image: %m");
> 2289                 return -errno;
> 2290         }
> 2291         if (S_ISREG(buf.st_mode)) {
> 2292                 /* Don't forget to enlarge the real file */
> 2293                 ret = ftruncate64(out_fd, dev_size);
> 2294                 if (ret < 0) {
> 2295                         error("failed to enlarge result image: %m");
> 2296                         return -errno;
> 2297                 }
> 2298         }
> 
> here it's the 'dev_size'. In the superblock dump, the sb.total_size and
> sb.dev_item.total_size are both 67108864, which is the correct value.
> 
> The size as obtained from the device item in the device tree also matches the
> right value
> 
>         item 6 key (1 DEV_EXTENT 61210624) itemoff 3667 itemsize 48
>                 dev extent chunk_tree 3
>                 chunk_objectid 256 chunk_offset 61210624 length 5898240
>                 chunk_tree_uuid b2834867-4e78-47ee-9877-94d4e39bda43
> 
> Which is the key.offset + length = 61210624 + 5898240 = 67108864.
> 
> But the code is not called in restore_metadump because of condition
> "btrfs_super_num_devices(mdrestore.original_super) != 1"

Thanks for reply. I read the commit 73dd4e3c87c and I understood a
purpose of the commit. but I'm confused the code block that isn't called
in restore_metadump should be called in multi device?

I also checked that test goes good when removing the condition in
restore_metadump().
