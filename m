Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D86BAA7176
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2019 19:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbfICRPE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Sep 2019 13:15:04 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35347 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbfICRPE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Sep 2019 13:15:04 -0400
Received: by mail-pl1-f193.google.com with SMTP id gn20so8160285plb.2
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Sep 2019 10:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wzg+gL3ba+m0Il6NeK2a/dpmm1pr4NSURsq6Id0+oFg=;
        b=GVwyYdp9X6i9LJ+jF65J204XJk9L0/tmJKvbYP6TomG4oeMPDbn0MTpDoV337hCoKp
         GFZ/yaXs93FqYrR8GiA8n32QvwBcQW2wQ4Pznudps3CdimkSkty7YVP7PGYLB0YOQc0G
         YfMJNLBvUtu6YkOWGfMoe7Xy0RV7Fsg9u3lejZdjz0YTfa9SnII4WW2qwsCiC4/0iJJm
         R7PphS/6ORgipn68ihD9MJ7Yi4CDYrjvKMKP0xySzlQGimWkBgUGTJNDVNM/yZmrpIw0
         NKZo/Ojtd36ZUj0Sll1FhwX9zo+Yz+2UgA7hRyoH1ABMFa9B4u6Ne1sy1COYxyHoDQhK
         ZMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wzg+gL3ba+m0Il6NeK2a/dpmm1pr4NSURsq6Id0+oFg=;
        b=nZjJvyB5yCYmfop5HcDgQyWdR6Ws0Za5XqoQkyfJl1k5xL0jfXClwXs9B6zqEJl2p4
         M4v9z9eS+SX8yqKP/Nje8KsZXHiFoQahkBFQl2lWquWldL6318x6p+tAMXYtHRT2dTAj
         aikemBNFl0ZZxhdjwIWJXcDY5qLJocI/MTsuRK9LvMp70Rt3VDDW9lqrrzgwK0KaftC4
         egCG7+wUUMoGSq1E5XQCQL2Zr8eVXCYBQcufuXZqrGGjLeGE/eaHISmukWZVFd4mBv76
         K7L5r9I4i7PHbfDSMVQbXsZjqzbnT6Zn9/R5YsKl6v5jtSwSpx3nxcuHOXfNSd2iFRHX
         jwRA==
X-Gm-Message-State: APjAAAWn7+bpv6Y9i2DUaXm2BuuWhDgXE8qZjO5yamAObZoCaYkyfjtT
        jCi1fZj0xAPTY9x26d1qFhDHRw==
X-Google-Smtp-Source: APXvYqw10JHONbT8zCvg5QyDa/QomLo5VBNJtKgHX8vWNYLivfN1GolqavwIyCTFCP5Z2CDCfMz0dg==
X-Received: by 2002:a17:902:2b87:: with SMTP id l7mr29172872plb.226.1567530903060;
        Tue, 03 Sep 2019 10:15:03 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::3:6d6d])
        by smtp.gmail.com with ESMTPSA id x5sm9294589pfi.165.2019.09.03.10.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 10:15:02 -0700 (PDT)
Date:   Tue, 3 Sep 2019 10:14:58 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 5/5] Btrfs: add ioctl for directly writing compressed
 data
Message-ID: <20190903171458.GA7452@vader>
References: <cover.1565900769.git.osandov@fb.com>
 <78747c3028ce91db9856e7fbd98ccbb2609acdc6.1565900769.git.osandov@fb.com>
 <20190828120650.GZ2752@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828120650.GZ2752@twin.jikos.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 28, 2019 at 02:06:50PM +0200, David Sterba wrote:
> On Thu, Aug 15, 2019 at 02:04:06PM -0700, Omar Sandoval wrote:
> >  #define BTRFS_IOC_SEND_32 _IOW(BTRFS_IOCTL_MAGIC, 38, \
> >  			       struct btrfs_ioctl_send_args_32)
> > +
> > +struct btrfs_ioctl_compressed_pwrite_args_32 {
> > +	__u64 offset;		/* in */
> > +	__u32 compressed_len;	/* in */
> > +	__u32 orig_len;		/* in */
> > +	__u32 compress_type;	/* in */
> > +	__u32 reserved[9];
> > +	compat_uptr_t buf;	/* in */
> > +} __attribute__ ((__packed__));
> > +
> > +#define BTRFS_IOC_COMPRESSED_PWRITE_32 _IOW(BTRFS_IOCTL_MAGIC, 63, \
> > +				 struct btrfs_ioctl_compressed_pwrite_args_32)
> 
> Note that the _32 is a workaround for a mistake in the send ioctl
> definitions that slipped trhough. Any pointer in the structure changes
> the ioctl number on 32bit and 64bit.
> 
> But as the raw data ioctl is new there's point to copy the mistake. The
> alignment and width can be forced eg. like
> 
> > +	void __user *buf;	/* in */
> 
> 	union {
> 		void __user *buf;
> 		__u64 __buf_alignment;
> 	};
> 
> This allows to user buf as a buffer without casts to a intermediate
> type.

I don't think this works on big-endian architectures. Let's say a 32-bit
application does:

struct btrfs_ioctl_compressed_pwrite_args_32 {
	.buf = 0x12345678,
};

The pointer will be in the first 4 bytes of the 8-byte union:

0    1    2    3    4    5    6    7
0x12 0x34 0x56 0x78 0x00 0x00 0x00 0x00

But, the 64-bit kernel will read buf as 0x1234567800000000. Let me know
if I messed up my analysis, but I think we need the compat stuff.
