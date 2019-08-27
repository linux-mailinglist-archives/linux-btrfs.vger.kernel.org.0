Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED18C9F24E
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 20:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbfH0S2j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 14:28:39 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40207 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfH0S2j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 14:28:39 -0400
Received: by mail-qt1-f196.google.com with SMTP id g4so1687qtq.7
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 11:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jPl1HLg6oBucctg+wsS1Q4h+qimljCWxbhRWTgGPmTU=;
        b=tDSuI3twBlVD7m0U9eqP3oDDBZViEiIqjc0UBy5o+zAmIHD+OF02/AabgLctFG6Eg7
         tZN2gJupt/h89sYfDQJQ0egaUAbyLeK4oA/wFZkkZENG0nSXUUiesZJQmvZPYCuZDevB
         UOnpVIouF6QwFxph+WsspLjwqRB9cHVuWWDkBUii6tCQUxmJx8VcKDU5NTVPIcm1PjK1
         dGYWlfp5PP/QugLUhM//OjvIg3Bt/bafMMYo1CaBcYBZwwynVB8mRnmsdA52fREAKH3c
         VYPBKsYECPX3GbP35bKTgrMzxz9QT/NPdz1tV41BNYT2Qp7LZZNQklJVYEnYnjSoF6sy
         8tBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jPl1HLg6oBucctg+wsS1Q4h+qimljCWxbhRWTgGPmTU=;
        b=qBloq6YEoYwdTNkdJ9DdBubHsJyrAMC2wewxYbr2sJhgKCSxSoLW4DvdUTY5RHn+nR
         0W7TfzYtk1qOMRx8hYEmQzAxO+yNjyF064ta2PlyR8LC9i5AyKP7IYXn9ZENyIalHPx+
         0fshdJfqEnBRDx0cO37gX8boHvTxGpzLKWfj00zCCFTb7CH0ogjDxORD46TNJNYaVlbz
         4G4+a6/KT5P972409z6S3ZT0iuXsPijsOu+P5t5UmbBfe2vf/nlbzDL+1d0U55zuyCDJ
         SRyX4k4AnKirum0lLmv+JaS4PE8KlxKozB+frtposccXgySUkDAdLz4aBe+DF6b8LsGY
         C5XQ==
X-Gm-Message-State: APjAAAUh42DKjv3xoYhBzsmoFNSSLcLGDRfR34ZeSziL5856jlHo+veh
        Gzed21vAPn569FrtIEfBL2Wo3Q==
X-Google-Smtp-Source: APXvYqwyUEbaXx4L5fB3n7ZdMUQuUyqsaG58ETOLNpwXHRVov9yeEEJFCs5si+FMG3XCLonYkG/8pg==
X-Received: by 2002:ac8:14f:: with SMTP id f15mr178915qtg.295.1566930518037;
        Tue, 27 Aug 2019 11:28:38 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::50b4])
        by smtp.gmail.com with ESMTPSA id u28sm12583730qtu.22.2019.08.27.11.28.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 11:28:37 -0700 (PDT)
Date:   Tue, 27 Aug 2019 14:28:36 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [RFC PATCH 5/5] Btrfs: add ioctl for directly writing compressed
 data
Message-ID: <20190827182834.p3jk7i2krgfzwuo6@macbook-pro-91.dhcp.thefacebook.com>
References: <cover.1565900769.git.osandov@fb.com>
 <78747c3028ce91db9856e7fbd98ccbb2609acdc6.1565900769.git.osandov@fb.com>
 <20190826213618.qdsivmmwwlxkqtxc@macbook-pro-91.dhcp.thefacebook.com>
 <a9c8436c-ca94-081d-d83b-25360ebb8cb0@suse.com>
 <20190827115740.n57xrl7i7pshjkey@macbook-pro-91.dhcp.thefacebook.com>
 <20190827180623.GB28029@vader>
 <20190827182242.GA23051@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190827182242.GA23051@vader>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 27, 2019 at 11:22:42AM -0700, Omar Sandoval wrote:
> On Tue, Aug 27, 2019 at 11:06:23AM -0700, Omar Sandoval wrote:
> > On Tue, Aug 27, 2019 at 07:57:41AM -0400, Josef Bacik wrote:
> > > On Tue, Aug 27, 2019 at 09:26:21AM +0300, Nikolay Borisov wrote:
> > > > 
> > > > 
> > > > On 27.08.19 г. 0:36 ч., Josef Bacik wrote:
> > > > > On Thu, Aug 15, 2019 at 02:04:06PM -0700, Omar Sandoval wrote:
> > > > >> From: Omar Sandoval <osandov@fb.com>
> > > > >>
> > > > >> This adds an API for writing compressed data directly to the filesystem.
> > > > >> The use case that I have in mind is send/receive: currently, when
> > > > >> sending data from one compressed filesystem to another, the sending side
> > > > >> decompresses the data and the receiving side recompresses it before
> > > > >> writing it out. This is wasteful and can be avoided if we can just send
> > > > >> and write compressed extents. The send part will be implemented in a
> > > > >> separate series, as this ioctl can stand alone.
> > > > >>
> > > > >> The interface is essentially pwrite(2) with some extra information:
> > > > >>
> > > > >> - The input buffer contains the compressed data.
> > > > >> - Both the compressed and decompressed sizes of the data are given.
> > > > >> - The compression type (zlib, lzo, or zstd) is given.
> > > > >>
> > > > >> A more detailed description of the interface, including restrictions and
> > > > >> edge cases, is included in include/uapi/linux/btrfs.h.
> > > > >>
> > > > >> The implementation is similar to direct I/O: we have to flush any
> > > > >> ordered extents, invalidate the page cache, and do the io
> > > > >> tree/delalloc/extent map/ordered extent dance. From there, we can reuse
> > > > >> the compression code with a minor modification to distinguish the new
> > > > >> ioctl from writeback.
> > > > >>
> > > > > 
> > > > > I've looked at this a few times, the locking and space reservation stuff look
> > > > > right.  What about encrypted send/recieve?  Are we going to want to use this to
> > > > > just blind copy encrypted data without having to decrypt/re-encrypt?  Should
> > > > > this be taken into consideration for this interface?  I'll think more about it,
> > > > > but I can't really see any better option than this.  Thanks,
> > > > 
> > > > The main problem is we don't have encryption implemented. And one of the
> > > > larger aspects of the encryption support is going to be how we are
> > > > storing the encryption keys. E.g. should they be part of the send
> > > > format? Or are we going to limit send/receive based on whether the
> > > > source/dest have transferred encryption keys out of line?
> > > > 
> > > 
> > > Subvolume encryption will be coming soon, but I'm less worried about the
> > > mechanics of how that will be used and more worried about making this interface
> > > work for that eventual future.  I assume we'll want to be able to just blind
> > > copy the encrypted data instead of decrypting into the send stream and then
> > > re-encrypting on the other side.  Which means we'll have two uses for this
> > > interface, and I want to make sure we're happy with it before it gets merged.
> > > Thanks,
> > > 
> > > Josef
> > 
> > Right, I think the only way to do this would be to blindly send
> > encrypted data, and leave the key management to a higher layer.
> > 
> > Looking at the ioctl definition:
> > 
> > struct btrfs_ioctl_compressed_pwrite_args {
> >         __u64 offset;           /* in */
> >         __u32 orig_len;         /* in */
> >         __u32 compressed_len;   /* in */
> >         __u32 compress_type;    /* in */
> >         __u32 reserved[9];
> >         void __user *buf;       /* in */
> > } __attribute__ ((__packed__));
> > 
> > I think there are enough reserved fields in there for, e.g., encryption
> > type, any key management-related things we might need to stuff in, etc.
> > But the naming would be pretty bad if we extended it this way. Maybe
> > compressed write -> raw write, orig_len -> num_bytes, compressed_len ->
> > disk_num_bytes?
> > 
> > struct btrfs_ioctl_raw_pwrite_args {
> >         __u64 offset;           /* in */
> >         __u32 num_bytes;        /* in */
> >         __u32 disk_num_bytes;   /* in */
> >         __u32 compress_type;    /* in */
> >         __u32 reserved[9];
> >         void __user *buf;       /* in */
> > } __attribute__ ((__packed__));
> > 
> > Besides the naming, I don't think anything else would need to change for
> > now. And if we decide that we don't want encrypted send/receive, then
> > fine, this naming is still okay.
> 
> Oh, and at this again, compression and encryption are only u8 in the
> extent item, and we have an extra u16 for "other_encoding", so it'd
> probably be safe to make it:
> 
> struct btrfs_ioctl_raw_pwrite_args {
>         __u64 offset;           /* in */
>         __u32 num_bytes;        /* in */
>         __u32 disk_num_bytes;   /* in */
>         __u8 compression;       /* in */
>         __u8 encryption;        /* in */
> 	__u16 other_encoding;   /* in */
>         __u32 reserved[9];
>         void __user *buf;       /* in */
> } __attribute__ ((__packed__));

I like this, then just adjust the patches to utilize the generic naming
convention instead of "compression" and I think it's good to go.  Thanks,

Josef
