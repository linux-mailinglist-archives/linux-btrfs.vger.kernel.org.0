Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6A125073D
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 20:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgHXSPU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 14:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgHXSPN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 14:15:13 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1947C061573
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 11:15:12 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q1so4628444pjd.1
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 11:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2H1DsCGSEolWbM6/6S8X+IARSJD5xYKklV75KG6kw1c=;
        b=HThBHzx02h2hx7FP1Llj6ZjEny1sZzYfXl/L2BU/JCHU5/N4CcQl1QTHqTIEiInl/j
         tqeRenXsZOaGtMHhh0dTub2YaS8ctrd3pve1GyFL8953lpa+1pgdp+fFNEj/wlzGIib7
         NzsnBEASOqEgDjiG9VzA3ZUo7FHkwpmvjisqKHhfduBaIABBViS0T2yEpuKuK4C28KYL
         f/WSXnyO+tfaztu3fnD1Lp3SHznm578XP4rRx7tDiwpIsAjo9+zAIEyNR0pmg642e/RT
         H/r3mW8bo1u71Ac72o6zwAu84wXTXKes0xGKKV+QWKRBF93hrYCqH4S5mOdnEDmW5Tt6
         5/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2H1DsCGSEolWbM6/6S8X+IARSJD5xYKklV75KG6kw1c=;
        b=WfN9ttzBNaf+cvjshIr7mgVYJacDVl9aFfVdLRLgUYyLm367GbTpZEfiD38OUt/gfM
         M5D0FsYTd8teu1+q8+6H8z39aV3m4eCNnvZaspPaHHL2FImQxP58IRV1G453Xw6ApW1g
         KMmcRssryh6qMwtPLGpBHf6lHE31Koqi+zB5GlC4KJ76NLFT3hi77oQFkzXCfi+SSwlm
         /s2NUzECj9jLhlMgk5+8xG7+4xcFOknldXbcL0F1xVM2enqgjVJyiFytOBHdCx6Jv7zp
         /TECDIi/r3W7QXIGXQpQIkdt5tiis9/78MIQca4MWk2uuOMI9WMWvQ1f2wrTluJw46Py
         uUgA==
X-Gm-Message-State: AOAM533Fm/XcVAW58UTZDNVt2uN9AYAteZdVeEYiQnrZxYQd9jGJ9RJ7
        T7QkDTxbqYS+01ThNJBq2o6tyA==
X-Google-Smtp-Source: ABdhPJywFVsfgo/OoiN2BG3s26Rd5sVCX9V5b+FnlmIr1/YqL3kXWNd40mzoefn+Aii1VOsFPJLxaw==
X-Received: by 2002:a17:90b:3543:: with SMTP id lt3mr447396pjb.180.1598292912248;
        Mon, 24 Aug 2020 11:15:12 -0700 (PDT)
Received: from exodia.localdomain ([2620:10d:c090:400::5:e8ea])
        by smtp.gmail.com with ESMTPSA id s29sm10237799pgo.68.2020.08.24.11.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 11:15:11 -0700 (PDT)
Date:   Mon, 24 Aug 2020 11:15:03 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>, Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>, kernel-team@fb.com,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>
Subject: Re: [PATCH man-pages v5] Document encoded I/O
Message-ID: <20200824181503.GB193404@exodia.localdomain>
References: <cover.1597993855.git.osandov@osandov.com>
 <64cc229872230dc6998a3dbf2264513870a8a6f6.1597994017.git.osandov@osandov.com>
 <CAOQ4uxgEpYqQ9MeuS=76tOtjFCrL8urkDoPoHxu+A5s4C2HGRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgEpYqQ9MeuS=76tOtjFCrL8urkDoPoHxu+A5s4C2HGRA@mail.gmail.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 21, 2020 at 12:24:48PM +0300, Amir Goldstein wrote:
> On Fri, Aug 21, 2020 at 10:38 AM Omar Sandoval <osandov@osandov.com> wrote:
> >
> > From: Omar Sandoval <osandov@fb.com>
> >
> > This adds a new page, encoded_io(7), providing an overview of encoded
> > I/O and updates fcntl(2), open(2), and preadv2(2)/pwritev2(2) to
> > reference it.
> >
> > Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> > Cc: linux-man <linux-man@vger.kernel.org>
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> 
> Omar,
> 
> Thanks for making the clarifications. Some questions below.
> 
> [...]
> 
> > +.PP
> > +As the filesystem page cache typically contains decoded data,
> > +encoded I/O bypasses the page cache.
> > +.SS Extent layout
> > +By using
> > +.IR len ,
> > +.IR unencoded_len ,
> > +and
> > +.IR unencoded_offset ,
> > +it is possible to refer to a subset of an unencoded extent.
> > +.PP
> > +In the simplest case,
> > +.I len
> > +is equal to
> > +.I unencoded_len
> > +and
> > +.I unencoded_offset
> > +is zero.
> > +This means that the entire unencoded extent is used.
> > +.PP
> > +However, suppose we read 50 bytes into a file
> > +which contains a single compressed extent.
> > +The filesystem must still return the entire compressed extent
> > +for us to be able to decompress it,
> > +so
> > +.I unencoded_len
> > +would be the length of the entire decompressed extent.
> > +However, because the read was at offset 50,
> > +the first 50 bytes should be ignored.
> > +Therefore,
> > +.I unencoded_offset
> > +would be 50,
> > +and
> > +.I len
> > +would accordingly be
> > +.IR unencoded_len\ -\ 50 .
> > +.PP
> > +Additionally, suppose we want to create an encrypted file with length 500,
> > +but the file is encrypted with a block cipher using a block size of 4096.
> > +The unencoded data would therefore include the appropriate padding,
> > +and
> > +.I unencoded_len
> > +would be 4096.
> > +However, to represent the logical size of the file,
> > +.I len
> > +would be 500
> > +(and
> > +.I unencoded_offset
> > +would be 0).
> > +.PP
> > +Similar situations can arise in other cases:
> > +.IP * 3
> > +If the filesystem pads data to the filesystem block size before compressing,
> > +then compressed files with a size unaligned to the filesystem block size will
> > +end with an extent with
> > +.I len
> > +<
> > +.IR unencoded_len .
> > +.IP *
> > +Extents cloned from the middle of a larger encoded extent with
> > +.B FICLONERANGE
> > +may have a non-zero
> > +.I unencoded_offset
> > +and/or
> > +.I len
> > +<
> > +.IR unencoded_len .
> > +.IP *
> > +If the middle of an encoded extent is overwritten,
> > +the filesystem may create extents with a non-zero
> > +.I unencoded_offset
> > +and/or
> > +.I len
> > +<
> > +.I unencoded_len
> > +for the parts that were not overwritten.
> 
> So in this case, would the reader be getting extents "out of unencoded order"?
> e.g. unencoded range 0..4096 and then unencoded range 10..20?
> Or would reader be reading the encoded full block twice, once for
> ragne 0..10 and once for range 20..4096?

The latter. If the file refers to the same encoded data twice, reading
the file sequentially with RWF_ENCODED will return it twice (with
different offsets each time). This is obviously not perfect, but it
keeps the interface simpler: the abstraction is not "what exactly is the
extent layout of the file" but rather "I want to read this logical range
of data", even if that involves pulling in some details from the extent
metadata.

> > +.SS Security
> > +Encoded I/O creates the potential for some security issues:
> > +.IP * 3
> > +Encoded writes allow writing arbitrary data which the kernel will decode on
> > +a subsequent read. Decompression algorithms are complex and may have bugs
> > +which can be exploited by maliciously crafted data.
> > +.IP *
> > +Encoded reads may return data which is not logically present in the file
> > +(see the discussion of
> > +.I len
> > +vs.
> > +.I unencoded_len
> > +above).
> > +It may not be intended for this data to be readable.
> > +.PP
> > +Therefore, encoded I/O requires privilege.
> > +Namely, the
> > +.B RWF_ENCODED
> > +flag may only be used when the file was opened with the
> > +.B O_ALLOW_ENCODED
> > +flag to
> > +.BR open (2),
> > +which requires the
> > +.B CAP_SYS_ADMIN
> > +capability.
> > +.B O_ALLOW_ENCODED
> > +may be set and cleared with
> > +.BR fcntl (2).
> > +Note that it is not cleared on
> > +.BR fork (2)
> > +or
> > +.BR execve (2);
> > +one may wish to use
> > +.B O_CLOEXEC
> > +with
> > +.BR O_ALLOW_ENCODED .
> > +.SS Filesystem support
> > +Encoded I/O is supported on the following filesystems:
> > +.TP
> > +Btrfs (since Linux 5.10)
> > +.IP
> > +Btrfs supports encoded reads and writes of compressed data.
> > +The data is encoded as follows:
> > +.RS
> > +.IP * 3
> > +If
> > +.I compression
> > +is
> > +.BR ENCODED_IOV_COMPRESSION_ZLIB ,
> > +then the encoded data is a single zlib stream.
> > +.IP *
> > +If
> > +.I compression
> > +is
> > +.BR ENCODED_IOV_COMPRESSION_LZO ,
> > +then the encoded data is compressed page by page with LZO1X
> > +and wrapped in the format documented in the Linux kernel source file
> > +.IR fs/btrfs/lzo.c .
> 
> :-/ So maybe call it ENCODED_IOV_COMPRESSION_BTRFS_LZO?
> 
> I understand why you want the encoding format not to be opaque, but
> I imagine the encoded data is not going to be migrated as is between
> different filesystems. So just call it for what it is - a private
> filesystem encoding
> format. If you have a format that is standard and other filesystems are likely
> to use, fine, but let's not make an API that discourages using
> "private" encoding, just for the sake of it and make life harder for no good
> reason.
> 
> All the reader of this man page may be interested to know is which
> filesystems are expected to support which encoding types and a general
> description of what they mean (as you did).
> Making this page wrongly appear as a standard for encoding formats is not
> going to play out well...
> 
> > +.IP *
> > +If
> > +.I compression
> > +is
> > +.BR ENCODED_IOV_COMPRESSION_ZSTD ,
> > +then the encoded data is a single zstd frame compressed with the
> > +.I windowLog
> > +compression parameter set to no more than 17.
> 
> Even that small detail is a bit limiting to filesystems and should
> therefore be tagged as a private btrfs encoding IMO.

Agreed, I'll make the LZO and ZSTD encodings Btrfs-specific. My
assumption was that decoders would look at the filesystem type from,
say, statfs(2), but making it explicit in the encoding is much better.
On the other hand, I think ENCODED_IOV_COMPRESSION_ZLIB is generic
enough to be reused.

Thanks for taking a look!
