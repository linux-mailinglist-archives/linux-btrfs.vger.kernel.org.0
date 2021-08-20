Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD41F3F2F67
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 17:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241306AbhHTP1j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 11:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241193AbhHTP1f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 11:27:35 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033CFC0363DE
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 08:23:47 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id g14so8887531pfm.1
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 08:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bBl/m2WQgR3rKcSbqpLdo6iJL3FU5BtdZsHYri5CG2o=;
        b=T+phVqn9RRqxOltlnNTq/t/L0FizHv7Hf7nTHrz1br8GhF8y16kEvNr1OK5y3jHPbL
         v/nazSxWpfqaeLzlizXj6I97EBhpu8vQ9iTp+d2dijwjbSALOcnio5Cap76zW7v5I5mW
         R6ETwKeRGpTPZb3AWpSTlDkdt7rJ8lXV6BR0Bo9tvNyJlkiOJVEOePQqbPwL8VU+LHli
         4qScv8fKqJg+O92oBdot5tXDQfd8ep+DMWRhA6A2KaNq+O+9e7fjblxv9V+uSBL2IrZ4
         i40EmYiCuNMT9KZKAFt5cvZjNxUG3JFU1jj4dRaBvTtXsxEuyzXMeCZ8WyfgDQ1jkYQR
         tuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bBl/m2WQgR3rKcSbqpLdo6iJL3FU5BtdZsHYri5CG2o=;
        b=aLurTQufO5JKpbqXGCyxkmbC/1FsrIzEyTePXOc4dY9owzvYm1NvqmmnFqOic7WGbS
         fmT2y1hVnqIRFcGYf5KFCYpGwM+LSr8HOS9AFE3Eo61+GHR73javfz0pHu41OnEDl1OY
         05COx48IqTjwZ+MJUFnIORnDV6RPXvlu3fUQMHbH8PDzQ65FQeuUSeupwHCeSPjaSVCx
         0LLc9bMFFXB+P8SPLRpSV12RZiK4PDyCTis9+DzXUW8/bk8TMyiM+c4jRf+htRg2Vmay
         NE9CrW9O6hTACtS3u2WmaTE7ukzUbsR+8jZOHxW6K8HdudKce1PptY+kLD+3EUvaVPqy
         hicg==
X-Gm-Message-State: AOAM531zYNAZwpRKo3ZBxUhOErpWEyr8m8HArklO3ihRwQrCOt1OhLjb
        urNDI7DUZFYvnAGvmFwkEA0=
X-Google-Smtp-Source: ABdhPJxSfJ+Xbqw5PvbVAlc826m14pb6LkZtLANSc+NVWeCQIvB73wBtdXKgxBNiod7Ec2KpN3tCog==
X-Received: by 2002:a65:6799:: with SMTP id e25mr19586655pgr.59.1629473026598;
        Fri, 20 Aug 2021 08:23:46 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id y5sm8265803pgs.27.2021.08.20.08.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 08:23:46 -0700 (PDT)
Date:   Fri, 20 Aug 2021 15:23:41 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] btrfs-progs: cmds: Add subcommand that dumps file
 extents
Message-ID: <20210820152341.GC17604@realwakka>
References: <20210718064601.3435-1-realwakka@gmail.com>
 <20210718064601.3435-3-realwakka@gmail.com>
 <20210817133022.GM5047@twin.jikos.cz>
 <20210818003819.GA2365@realwakka>
 <792d01d9-97f0-6a80-15e9-f6cd6356984d@gmx.com>
 <2f355551-3216-cc4c-5522-fab8ed6928e3@gmx.com>
 <20210819152714.GC1987@realwakka>
 <a874228c-3b00-e0d2-9702-2bfcba171fa2@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a874228c-3b00-e0d2-9702-2bfcba171fa2@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 20, 2021 at 06:16:18AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/8/19 下午11:27, Sidong Yang wrote:
> > On Thu, Aug 19, 2021 at 02:05:52PM +0800, Qu Wenruo wrote:
> > > 
> > > 
> > > On 2021/8/19 下午2:03, Qu Wenruo wrote:
> > > > 
> > > > 
> > > > On 2021/8/18 上午8:38, Sidong Yang wrote:
> > > > > On Tue, Aug 17, 2021 at 03:30:22PM +0200, David Sterba wrote:
> > > > > > On Sun, Jul 18, 2021 at 06:46:01AM +0000, Sidong Yang wrote:
> > > > > > > This patch adds an subcommand in inspect-internal. It dumps file
> > > > > > > extents of
> > > > > > > the file that user provided. It helps to show the internal information
> > > > > > > about file extents comprise the file.
> > > > > > 
> > > > > > Do you have an example of the output? That's the most interesting part.
> > > > > > Thanks.
> > > > > 
> > > > > Thanks for reply.
> > > > > This is an example of the output below.
> > > > > 
> > > > > # ./btrfs inspect-internal dump-file-extent /mnt/test1
> > > > > type = regular, start = 2097152, len = 3227648, disk_bytenr = 0,
> > > > > disk_num_bytes = 0, offset = 0, compression = none
> > > > > type = regular, start = 5324800, len = 16728064, disk_bytenr = 0,
> > > > > disk_num_bytes = 0, offset = 0, compression = none
> > > > > type = regular, start = 22052864, len = 8486912, disk_bytenr = 0,
> > > > > disk_num_bytes = 0, offset = 0, compression = none
> > > > > type = regular, start = 30572544, len = 36540416, disk_bytenr = 0,
> > > > > disk_num_bytes = 0, offset = 0, compression = none
> > > > > type = regular, start = 67112960, len = 5299630080, disk_bytenr = 0,
> > > > > disk_num_bytes = 0, offset = 0, compression = none
> > > > 
> > > > Could you give an example which includes both real (non-hole) extents
> > > > and real extents (better to include regular, compressed, preallocated
> > > > and inline).
> > > 
> > > Tons of typos... I mean to include both holes (like the existing
> > > example) and non-holes extents...
> > 
> > Sorry, I had no idea about holes. But I found some test code in
> > xfstests. It helpes me to make hole in file.
> > 
> > xfs_io -c "fpunch 96K 32K" /mnt/a/foobar
> > xfs_io -c "fpunch 64K 128K" /mnt/a/foobar
> > 
> > and the example is below.
> > 
> > # ./btrfs inspect dump-file-extent /mnt/a/foobar
> > type = regular, start = 0, len = 98304, disk_bytenr = 21651456,
> > disk_num_bytes = 4096, offset = 0, compression = zstd
> > type = regular, start = 98304, len = 32768, disk_bytenr = 0,
> > disk_num_bytes = 0, offset = 0, compression = none
> > 
> > I'm afaid that I understand your request correctly. Is it what you want?
> 
> This example is much better.
> 
> But still, for holes, things like
> disk_bytenr/disk_num_bytes/offset/compression makes no sense and can be
> skipped.

Okay. If disk_bytenr is zero, other information after this would be
skipped in next version.
> 
> Furthermore, for hole/prealloc they need extra type other than "regular"

For now, It already has prealloc type. but no hole type. All the types
are inline/prealloc/regular/hole? If so, disk_bytenr should be checked
before print it's type.

Thanks,
Sidong
> 
> Thanks,
> Qu
> > > 
> > > > 
> > > > Currently the output only contains holes, and for holes, a lot of
> > > > members makes no sense, like disk_bytenr/disk_num_bytes/offset (even it
> > > > can be non-zero) and compression.
> > > > 
> > > > Thanks,
> > > > Qu
> > > > 
> > > > > 
> > > > > Thanks,
> > > > > Sidong
> > > > > 
