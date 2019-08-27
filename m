Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0E99F20D
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 20:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbfH0SG1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 14:06:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46706 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727893AbfH0SG0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 14:06:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id m3so13082514pgv.13
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 11:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=97LVZDC7BiAt2XCVjA7xM4eJbI4swAlcmwOiH3VCU7s=;
        b=i6ZWtt5xuZ207mX+4f19DWwra554VlIBDslkPO7f8wW+eHECh/whSGsZD+5QQyXNvD
         Cl1YDJDsjFGSvI+k28Kj3GTC7jHCrDcFhQVY8nDCyZAxOTwyTbYu+vOTA6jlErP/8Dtn
         HT8AApMZYmcrMbNnLlyqkIoTgDXSlkHF8K/kCulSqRp9BeiFrn2HAQ66e0o4mkW9utYY
         KNxw4ohvRpACaW/FbE1QtH5nlsE2fxxdZLoI86K1/uSLp3EyqH0gp9u29Joc4UdxmuhH
         7gnE0FGvRvxtYykTmaoOpc0T4N+K8fzJKHNbL2q3krCXcJg5saLUcvdlEGI6adRdbWWs
         q/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=97LVZDC7BiAt2XCVjA7xM4eJbI4swAlcmwOiH3VCU7s=;
        b=p7eT8EL/WqAaEebCoS+SlLDRULzYUsnOaNl9eBU6M9cggUUPLUN7hXDA2GLy4emmg1
         R9GcQ6rltuM1F2D45t4auufL3mgqYA8sa5zfBwthZhgraVkzunCeLO47R9bC5DnQ69dX
         MKxKB8BcHS23EP4Mp6bu8kfJZPY6MkA8hIdjJAFv5liqish2lhaS5XslPsTqMEIUNJ1L
         g4HgKbWo8vqTbWR7+1g4AJvRjMOmXeOxFdtP1SqutUO1ohJzl5zMSPLziRJHDSxDZZh8
         yLTpLBJ8u4mcMeOQunazc9EUQM+JE/8NeeSQ76KN5CdkBHvF0spFi5rXx/b86JHt77o8
         621g==
X-Gm-Message-State: APjAAAUfFcw07Fg9XgRG6Ko5hTrnIHQq9GB2sGF3rPsJfW0JbeGKDIzU
        4q0BEUBO75eAjbp3Q7ntbqDJUQ==
X-Google-Smtp-Source: APXvYqw1QsLaRVBS5c6ZTBWnlfDcGNNlLRso3st8jgZtuxmMa6F+Ixu6LJMf+EjF/L5LhLVVal+4Sg==
X-Received: by 2002:a65:60d2:: with SMTP id r18mr21891575pgv.71.1566929185312;
        Tue, 27 Aug 2019 11:06:25 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::2:56d8])
        by smtp.gmail.com with ESMTPSA id 185sm22151320pff.54.2019.08.27.11.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 11:06:24 -0700 (PDT)
Date:   Tue, 27 Aug 2019 11:06:23 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [RFC PATCH 5/5] Btrfs: add ioctl for directly writing compressed
 data
Message-ID: <20190827180623.GB28029@vader>
References: <cover.1565900769.git.osandov@fb.com>
 <78747c3028ce91db9856e7fbd98ccbb2609acdc6.1565900769.git.osandov@fb.com>
 <20190826213618.qdsivmmwwlxkqtxc@macbook-pro-91.dhcp.thefacebook.com>
 <a9c8436c-ca94-081d-d83b-25360ebb8cb0@suse.com>
 <20190827115740.n57xrl7i7pshjkey@macbook-pro-91.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190827115740.n57xrl7i7pshjkey@macbook-pro-91.dhcp.thefacebook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 27, 2019 at 07:57:41AM -0400, Josef Bacik wrote:
> On Tue, Aug 27, 2019 at 09:26:21AM +0300, Nikolay Borisov wrote:
> > 
> > 
> > On 27.08.19 г. 0:36 ч., Josef Bacik wrote:
> > > On Thu, Aug 15, 2019 at 02:04:06PM -0700, Omar Sandoval wrote:
> > >> From: Omar Sandoval <osandov@fb.com>
> > >>
> > >> This adds an API for writing compressed data directly to the filesystem.
> > >> The use case that I have in mind is send/receive: currently, when
> > >> sending data from one compressed filesystem to another, the sending side
> > >> decompresses the data and the receiving side recompresses it before
> > >> writing it out. This is wasteful and can be avoided if we can just send
> > >> and write compressed extents. The send part will be implemented in a
> > >> separate series, as this ioctl can stand alone.
> > >>
> > >> The interface is essentially pwrite(2) with some extra information:
> > >>
> > >> - The input buffer contains the compressed data.
> > >> - Both the compressed and decompressed sizes of the data are given.
> > >> - The compression type (zlib, lzo, or zstd) is given.
> > >>
> > >> A more detailed description of the interface, including restrictions and
> > >> edge cases, is included in include/uapi/linux/btrfs.h.
> > >>
> > >> The implementation is similar to direct I/O: we have to flush any
> > >> ordered extents, invalidate the page cache, and do the io
> > >> tree/delalloc/extent map/ordered extent dance. From there, we can reuse
> > >> the compression code with a minor modification to distinguish the new
> > >> ioctl from writeback.
> > >>
> > > 
> > > I've looked at this a few times, the locking and space reservation stuff look
> > > right.  What about encrypted send/recieve?  Are we going to want to use this to
> > > just blind copy encrypted data without having to decrypt/re-encrypt?  Should
> > > this be taken into consideration for this interface?  I'll think more about it,
> > > but I can't really see any better option than this.  Thanks,
> > 
> > The main problem is we don't have encryption implemented. And one of the
> > larger aspects of the encryption support is going to be how we are
> > storing the encryption keys. E.g. should they be part of the send
> > format? Or are we going to limit send/receive based on whether the
> > source/dest have transferred encryption keys out of line?
> > 
> 
> Subvolume encryption will be coming soon, but I'm less worried about the
> mechanics of how that will be used and more worried about making this interface
> work for that eventual future.  I assume we'll want to be able to just blind
> copy the encrypted data instead of decrypting into the send stream and then
> re-encrypting on the other side.  Which means we'll have two uses for this
> interface, and I want to make sure we're happy with it before it gets merged.
> Thanks,
> 
> Josef

Right, I think the only way to do this would be to blindly send
encrypted data, and leave the key management to a higher layer.

Looking at the ioctl definition:

struct btrfs_ioctl_compressed_pwrite_args {
        __u64 offset;           /* in */
        __u32 orig_len;         /* in */
        __u32 compressed_len;   /* in */
        __u32 compress_type;    /* in */
        __u32 reserved[9];
        void __user *buf;       /* in */
} __attribute__ ((__packed__));

I think there are enough reserved fields in there for, e.g., encryption
type, any key management-related things we might need to stuff in, etc.
But the naming would be pretty bad if we extended it this way. Maybe
compressed write -> raw write, orig_len -> num_bytes, compressed_len ->
disk_num_bytes?

struct btrfs_ioctl_raw_pwrite_args {
        __u64 offset;           /* in */
        __u32 num_bytes;        /* in */
        __u32 disk_num_bytes;   /* in */
        __u32 compress_type;    /* in */
        __u32 reserved[9];
        void __user *buf;       /* in */
} __attribute__ ((__packed__));

Besides the naming, I don't think anything else would need to change for
now. And if we decide that we don't want encrypted send/receive, then
fine, this naming is still okay.
