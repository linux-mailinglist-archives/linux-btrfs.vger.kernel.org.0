Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9390D8F64A
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2019 23:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbfHOVO4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Aug 2019 17:14:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43295 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfHOVO4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Aug 2019 17:14:56 -0400
Received: by mail-pg1-f193.google.com with SMTP id k3so1828718pgb.10
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2019 14:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fo8TvHNwcclOQWNPsALFAghma3YSyfd4PcynfGFYxYY=;
        b=z2Xqyy3R0JMfA5c2vx+2M1qUbswEgAac+9/ZLOlt238aeEW5Gjd/5qWc1RHi2lz1u2
         dKX29sm9vvn7D8fkth7N/4Yk1UF/vJ6rX2B5lw0pyZ6VGBDk/wFRZaK3BUE+88F8uZWl
         Hge1uvHVCdvKrbJL4LDBxtmKai6xr5QSfL1nudITOEmeMuxUF68qe2vZYFeN6hFnfwQd
         hxWfaQ4IjkIwZQzEW64PjYym1rAf7PwUhetJsy5wMst3/ZUbzEnJsDLFP539hS4LqvRL
         AU9s7O/+GdD+Ohg6raMt2Khd3rYcbBLw65q+d0Cj1SIhkTATIPLJzNmYG1CFE+AFxcaw
         08nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fo8TvHNwcclOQWNPsALFAghma3YSyfd4PcynfGFYxYY=;
        b=XmCsoUYK2aIzJxSQZfee1H2nPioPNNwA1jDrla9qXNj9lykcPTJf45gtBd3U1MV2vG
         cu7ZWJFMgXEPRCpYuS8PUEEi2aQ4V+3z014swxCrEEy51lwdJTHMvgLThBSnzt0QEaaK
         YgOR5UcPbOACyHU561XXHSpuSU3C1cnzS6VwpqAW1AHedZ40VMlRuoUAit6xrc1edZ5p
         l9mqoeqIzoGnvofFzw+CZ5R5rfLL/mfqUmERAOho3s76VsfDVpqARU3/O0e1Ar9nwH4i
         hsL3EbX9ZMbDomn5bkwPOpBMffOhEm1VR+XH5mxbbRidjJbhM3FxtZeks54zupgx25bh
         0Fhw==
X-Gm-Message-State: APjAAAVDu7pdep990se/F+AOjzEolmW7GWSxzQXlWstPcM7hZ9Fn09bz
        u3MnL1duF3BSQqw3l3pFA/PTZgAmga0=
X-Google-Smtp-Source: APXvYqwa/6hJR/Ipg3ILuIKdZIXStzOR4Q4nOtNXFwTUZF+pFQfy8/J7TYLF5e5hzHXEZCFui8EaDQ==
X-Received: by 2002:a65:64c5:: with SMTP id t5mr5178638pgv.168.1565903695039;
        Thu, 15 Aug 2019 14:14:55 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::3:2aa9])
        by smtp.gmail.com with ESMTPSA id a20sm1883413pjo.0.2019.08.15.14.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 14:14:54 -0700 (PDT)
Date:   Thu, 15 Aug 2019 14:14:54 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: Re: [RFC PATCH 0/5] Btrfs: add interface for writing compressed
 extent directly
Message-ID: <20190815211454.GC27472@vader>
References: <cover.1565900769.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1565900769.git.osandov@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 15, 2019 at 02:04:01PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Hello,
> 
> This series adds a way to write compressed data directly to Btrfs. The
> intended use case is making send/receive on compressed file systems more
> efficient; however, the interface is general enough that it could be
> used in other scenarios. Patch 5 is the main change; see that for more
> details.
> 
> Patches 1-3 are small fixes/cleanups that I ran into while implementing
> this; they should go in regardless of the remainder of the series. Patch
> 4 exports a required VFS interface.
> 
> An example program and test case are available at [1].
> 
> To preemptively address a few concerns:
> 
> - Writing arbitrary, untrusted data which we feed to the decompression
>   algorithm can be a security risk. For that reason, the ioctl is
>   restricted to CAP_SYS_ADMIN. The Btrfs code is properly hardened
>   against invalid compressed data/incorrect lengths, and the compression
>   libraries are mature, but better safe than sorry for now.
> - If the user is writing their own compressed data rather than just
>   blindly feeding in something from btrfs send, they need to know some
>   implementation details about the compression format. For zlib, there
>   are no special requirements. For zstd, a non-default compression
>   parameter must be used. For lzo, we have our own wrapper format since
>   lzo doesn't have a standard wrapper format. It feels a little wrong to
>   expose these details, but they are part of the on-disk format, so they
>   must be stable regardless.
> - The permissions checks duplicated from the VFS code are fairly
>   minimal.
> 
> This series is based on misc-next.
> 
> This is an RFC, so please, comment away.
> 
> Thanks!
> 
> 1: https://github.com/osandov/xfstests/tree/btrfs-compressed-write
> 
> Omar Sandoval (5):
>   Btrfs: use correct count in btrfs_file_write_iter()
>   Btrfs: treat RWF_{,D}SYNC writes as sync for CRCs
>   Btrfs: stop clearing EXTENT_DIRTY in inode I/O tree
>   fs: export rw_verify_area()
>   Btrfs: add ioctl for directly writing compressed data
> 
>  fs/btrfs/compression.c       |   6 +-
>  fs/btrfs/compression.h       |  14 +--
>  fs/btrfs/ctree.h             |  12 ++
>  fs/btrfs/extent_io.c         |   6 +-
>  fs/btrfs/file.c              |  22 ++--
>  fs/btrfs/free-space-cache.c  |   9 +-
>  fs/btrfs/inode.c             | 232 +++++++++++++++++++++++++++++++----
>  fs/btrfs/ioctl.c             | 101 ++++++++++++++-
>  fs/btrfs/tests/inode-tests.c |  12 +-
>  fs/internal.h                |   5 -
>  fs/read_write.c              |   1 +
>  include/linux/fs.h           |   1 +
>  include/uapi/linux/btrfs.h   |  63 ++++++++++
>  13 files changed, 415 insertions(+), 69 deletions(-)

I forgot to CC fsdevel. I'll do that for v2.
