Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2D4EC07CC
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2019 16:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfI0OnQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Sep 2019 10:43:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:47010 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727124AbfI0OnQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Sep 2019 10:43:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1A3B1B137;
        Fri, 27 Sep 2019 14:43:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7F61BDA897; Fri, 27 Sep 2019 16:43:34 +0200 (CEST)
Date:   Fri, 27 Sep 2019 16:43:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Mark Fasheh <mfasheh@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Mark Fasheh <mfasheh@suse.de>
Subject: Re: [PATCH 1/3] btrfs: Move backref cache code out of relocation.c
Message-ID: <20190927144334.GW2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Mark Fasheh <mfasheh@suse.com>,
        linux-btrfs@vger.kernel.org, Mark Fasheh <mfasheh@suse.de>
References: <20190906171533.618-1-mfasheh@suse.com>
 <20190906171533.618-2-mfasheh@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906171533.618-2-mfasheh@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 06, 2019 at 10:15:31AM -0700, Mark Fasheh wrote:
> From: Mark Fasheh <mfasheh@suse.de>
> 
> No functional changes are made here, we simply move the backref cache out of
> relocation.c and into it's own file, backref-cache.c.  We also add the
> headers relocation.h and backref-cache.h.
> 
> Signed-off-by: Mark Fasheh <mfasheh@suse.de>
> ---
>  fs/btrfs/Makefile        |    2 +-
>  fs/btrfs/backref-cache.c |  883 ++++++++++++++++++++++++++++++++
>  fs/btrfs/backref-cache.h |  113 +++++
>  fs/btrfs/relocation.c    | 1027 +-------------------------------------
>  fs/btrfs/relocation.h    |   85 ++++
>  5 files changed, 1090 insertions(+), 1020 deletions(-)
>  create mode 100644 fs/btrfs/backref-cache.c
>  create mode 100644 fs/btrfs/backref-cache.h
>  create mode 100644 fs/btrfs/relocation.h
> 
> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> index 76a843198bcb..197eed65e051 100644
> --- a/fs/btrfs/Makefile
> +++ b/fs/btrfs/Makefile
> @@ -11,7 +11,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
>  	   compression.o delayed-ref.o relocation.o delayed-inode.o scrub.o \
>  	   reada.o backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
>  	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
> -	   block-rsv.o delalloc-space.o
> +	   block-rsv.o delalloc-space.o backref-cache.o
>  
>  btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
>  btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
> diff --git a/fs/btrfs/backref-cache.c b/fs/btrfs/backref-cache.c
> new file mode 100644
> index 000000000000..d0f6530f23b8
> --- /dev/null
> +++ b/fs/btrfs/backref-cache.c
> @@ -0,0 +1,883 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2009 Oracle.  All rights reserved.
> + */

We don't need the (c) headers since the SPDX tags have been established,
so I've removed it.

Otherwise, I fixed some whitespace damage and took the opportunity to
update comments and other minor coding style in the +part of the code.
