Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 365B11694D
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2019 19:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfEGRgZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 May 2019 13:36:25 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33460 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfEGRgZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 May 2019 13:36:25 -0400
Received: by mail-yw1-f66.google.com with SMTP id q11so13910983ywb.0
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2019 10:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q9FDrJWmw7zbwNIScNRJIcVCNy5Dkk3OCgOIZ8zbVBM=;
        b=xDxPAhu2gzTbFDSqOvu8eRJpApyAFAK97hzs6gwhitqSIWtEti48rSB6PaqEwvEs+N
         O4bjNABpxKEibkYy83eaQEL3UO+ZWmKJ6gtrKlTUs3EQ8SP639+gCEWfDDWKvZUCyPZP
         he3sHsbJ3qzQXA1ThLHlAuQiwNCqqwQW3jAqeKVeZNKuLfFS8wbk2XXU3cyWkFkZSEbV
         WLaaTmic3te9yDydZUAiHCWF+xh/IjrUdpJa80MJ9PCCo497bRAzuNl1d5EmqbEtj2JT
         ScdOIHJ9NtN4nHK3ibuFsoPHHhsiYvdPlg9ehxWDeELTF269+etU3pLo/PxnamT0+7ij
         ookQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q9FDrJWmw7zbwNIScNRJIcVCNy5Dkk3OCgOIZ8zbVBM=;
        b=Stp8sXWSnnFb1OvABDIevdUQrCF6aQFaoRV2sCwTphk2/pMGRlVe7Fi7azsW/+JRD7
         r7gcIEGo7L04WKHYS1bvlSQEilOsgSonsJVMHX1PNO/iozKRzv8RJQTGbyL5Pc99Xsm6
         9y70wG416ncPuV3VK9lXtipl0OFElBp/G+vnUAwPgwmlls8Foq4QEjCCyYKl9xdBcubY
         bAMXrK59huLf+6UZbQU3hxAlk6E036eFV4RszmsLOkZAkco90RLLL4X7YLNnLXZz2yIU
         shI7o5kQy4JtAm9PD2rqk+vB5gEI1DsMHEKH/w/uUQDPhduQ8s9AefugprqFIzAcGtUa
         tl8w==
X-Gm-Message-State: APjAAAWY6hBE3zs/XJOPFSZ63GbQWD3XBEXMLEPBA4De8AP0YAz+UxQE
        dUS1nXsF8KIKguRkI7tIu8Zd67tL3QRqzm7W
X-Google-Smtp-Source: APXvYqzYqcXtnCQi6lNLhXArSBL3ZXRXHfmB8jnov3+/9p9kOhS25dZvsE+/AVkTAvukibG4gDl/8g==
X-Received: by 2002:a81:657:: with SMTP id 84mr12936051ywg.488.1557250584154;
        Tue, 07 May 2019 10:36:24 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::5c09])
        by smtp.gmail.com with ESMTPSA id z204sm3928779ywb.28.2019.05.07.10.36.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:36:23 -0700 (PDT)
Date:   Tue, 7 May 2019 13:36:21 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: reflink: Flush before reflink any extent to
 prevent NOCOW write falling back to CoW without data reservation
Message-ID: <20190507173619.u4vjotiv5jxufogo@macbook-pro-91.dhcp.thefacebook.com>
References: <20190503010852.10342-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503010852.10342-1-wqu@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 03, 2019 at 09:08:52AM +0800, Qu Wenruo wrote:
> [BUG]
> The following command can lead to unexpected data COW:
> 
>   #!/bin/bash
> 
>   dev=/dev/test/test
>   mnt=/mnt/btrfs
> 
>   mkfs.btrfs -f $dev -b 1G > /dev/null
>   mount $dev $mnt -o nospace_cache
> 
>   xfs_io -f -c "falloc 8k 24k" -c "pwrite 12k 8k" $mnt/file1
>   xfs_io -c "reflink $mnt/file1 8k 0 4k" $mnt/file1
>   umount $dev
> 
> The result extent will be
> 
> 	item 7 key (257 EXTENT_DATA 4096) itemoff 15760 itemsize 53
> 		generation 6 type 2 (prealloc)
> 		prealloc data disk byte 13631488 nr 28672
> 	item 8 key (257 EXTENT_DATA 12288) itemoff 15707 itemsize 53
> 		generation 6 type 1 (regular)
> 		extent data disk byte 13660160 nr 12288 <<< COW
> 	item 9 key (257 EXTENT_DATA 24576) itemoff 15654 itemsize 53
> 		generation 6 type 2 (prealloc)
> 		prealloc data disk byte 13631488 nr 28672
> 
> Currently we always reserve space even for NOCOW buffered write, thus
> under most case it shouldn't cause anything wrong even we fall back to
> COW.
> 
> However when we're out of data space, we fall back to skip data space if
> we can do NOCOW write.
> 
> If such behavior happens under that case, we could hit the following
> problems:
> - data space bytes_may_use underflow
>   This will cause kernel warning.
> 

This can be fixed, I laid out a few ways it could be fixed.

> - ENOSPC at delalloc time
>   This will lead to transaction abort and fs forced to RO.
> 

How?  The metadata and data reservations are separate.  If we can't make the
metadata reservation we fail out, the only thing we allow is skipping the data
reservation.  So if we fall back to cow_file_range() at run_delalloc_nocow()
time all we'll do is get an ENOSPC outside of a transaction, so we can just
mark the inode as having failed its writeout with ENOSPC so fsync() returns the
appropriate error and carry on.  We shouldn't be aborting a transaction here at
all.  Thanks,

Josef
