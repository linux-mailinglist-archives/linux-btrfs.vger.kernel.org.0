Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBC133EBB6
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 09:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhCQIli (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 04:41:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:51742 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229683AbhCQIlM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 04:41:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6EE85AB8C;
        Wed, 17 Mar 2021 08:41:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 78325DA6E2; Wed, 17 Mar 2021 09:39:09 +0100 (CET)
Date:   Wed, 17 Mar 2021 09:39:09 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Victor Erminpour <victor.erminpour@oracle.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Use immediate assignment when referencing
 cc-option
Message-ID: <20210317083909.GM7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Victor Erminpour <victor.erminpour@oracle.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1615934770-395-1-git-send-email-victor.erminpour@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615934770-395-1-git-send-email-victor.erminpour@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 16, 2021 at 03:46:10PM -0700, Victor Erminpour wrote:
> Calling cc-option will use KBUILD_CFLAGS, which when lazy setting
> subdir-ccflags-y produces the following build error:
> 
> scripts/Makefile.lib:10: *** Recursive variable `KBUILD_CFLAGS' \
> 	references itself (eventually).  Stop.
> 
> Use := assignment to subdir-ccflags-y when referencing cc-option.
> This causes make to also evaluate += immediately, cc-option
> calls are done right away and we don't end up with KBUILD_CFLAGS
> referencing itself.
> 
> Signed-off-by: Victor Erminpour <victor.erminpour@oracle.com>
> ---
>  fs/btrfs/Makefile | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> index b634c42115ea..3dba1336fa95 100644
> --- a/fs/btrfs/Makefile
> +++ b/fs/btrfs/Makefile
> @@ -7,10 +7,10 @@ subdir-ccflags-y += -Wmissing-format-attribute
>  subdir-ccflags-y += -Wmissing-prototypes
>  subdir-ccflags-y += -Wold-style-definition
>  subdir-ccflags-y += -Wmissing-include-dirs
> -subdir-ccflags-y += $(call cc-option, -Wunused-but-set-variable)
> -subdir-ccflags-y += $(call cc-option, -Wunused-const-variable)
> -subdir-ccflags-y += $(call cc-option, -Wpacked-not-aligned)
> -subdir-ccflags-y += $(call cc-option, -Wstringop-truncation)
> +subdir-ccflags-y := $(call cc-option, -Wunused-but-set-variable)
> +subdir-ccflags-y := $(call cc-option, -Wunused-const-variable)
> +subdir-ccflags-y := $(call cc-option, -Wpacked-not-aligned)
> +subdir-ccflags-y := $(call cc-option, -Wstringop-truncation)

But this overwrites all the previously accumulated values from += so
effectively there's only the last one, no? That's not what we want.
