Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AC03008EB
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 17:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbhAVQih (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 11:38:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:36340 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729690AbhAVQh5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 11:37:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 83067AF55;
        Fri, 22 Jan 2021 16:37:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 66A30DA6E3; Fri, 22 Jan 2021 17:35:22 +0100 (CET)
Date:   Fri, 22 Jan 2021 17:35:22 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 14/14] btrfs: Enable W=1 checks for btrfs
Message-ID: <20210122163522.GG6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210122095805.620458-1-nborisov@suse.com>
 <20210122095805.620458-15-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122095805.620458-15-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 22, 2021 at 11:58:05AM +0200, Nikolay Borisov wrote:
> Now that the btrfs' codebase is clean of W=1 warning let's enable those
> checks unconditionally for the entire fs/btrfs/ and its subdirectories.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/Makefile | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> index 9f1b1a88e317..44faee776027 100644
> --- a/fs/btrfs/Makefile
> +++ b/fs/btrfs/Makefile
> @@ -1,5 +1,22 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> +subdir-ccflags-y += -Wextra -Wunused -Wno-unused-parameter
> +subdir-ccflags-y += -Wmissing-declarations
> +subdir-ccflags-y += -Wmissing-format-attribute
> +subdir-ccflags-y += -Wmissing-prototypes
> +subdir-ccflags-y += -Wold-style-definition
> +subdir-ccflags-y += -Wmissing-include-dirs
> +subdir-ccflags-y += $(call cc-option, -Wunused-but-set-variable)
> +subdir-ccflags-y += $(call cc-option, -Wunused-const-variable)

-Wunused-const-variable triggers the zstd warning, I would leave it out
for now until the zstd patch is merged as I want to add the rest of the
series to misc-next and this would not be a clean build.



> +subdir-ccflags-y += $(call cc-option, -Wpacked-not-aligned)
> +subdir-ccflags-y += $(call cc-option, -Wstringop-truncation)
> +# The following turn off the warnings enabled by -Wextra
> +subdir-ccflags-y += -Wno-missing-field-initializers
> +subdir-ccflags-y += -Wno-sign-compare
> +subdir-ccflags-y += -Wno-type-limits
> +
> +cmd_checkdoc = $(srctree)/scripts/kernel-doc -none $<

I'll add a comment what this means

>  obj-$(CONFIG_BTRFS_FS) := btrfs.o
>  
>  btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
> -- 
> 2.25.1
