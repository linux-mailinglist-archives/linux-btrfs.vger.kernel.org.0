Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E57133BF33
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Mar 2021 16:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238013AbhCOOz5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Mar 2021 10:55:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:37234 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241783AbhCOOz2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Mar 2021 10:55:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 98FCDAC17;
        Mon, 15 Mar 2021 14:55:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7DE56DA6E2; Mon, 15 Mar 2021 15:53:24 +0100 (CET)
Date:   Mon, 15 Mar 2021 15:53:24 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Pierre Labastie <pierre.labastie@neuf.fr>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: build system: Fix the test for
 EXT4_EPOCH_MASK
Message-ID: <20210315145324.GU7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Pierre Labastie <pierre.labastie@neuf.fr>,
        linux-btrfs@vger.kernel.org
References: <d7b1445f25866bf5c8d5016b7cd7a94e68f67dd8.camel@neuf.fr>
 <20210314184913.5689-1-pierre.labastie@neuf.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210314184913.5689-1-pierre.labastie@neuf.fr>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 14, 2021 at 07:49:13PM +0100, Pierre Labastie wrote:
> After sending the first version of the patch, I realized that it
> was flawed, because of some formatting by the MUA. It took me
> some time to set up an MTA so that git send-email works. Now the
> patch should apply cleanly. Please remove the present paragraph by using
> git am -c. Apologies for the inconvenience(s).
> -- >8 --
> Commit b3df561fbf has introduced the ability to convert extended
> inode time precision on ext4, but this breaks builds on older distros,
> where ext4 does not have the nsec time precision.
> 
> Commit c615287cc tried to fix that by testing the availability of
> the EXT4_EPOCH_MASK macro, but the test is not complete.
> 
> This patch aims at fixing the macro test, and changes the
> name of the associated HAVE_ macro, since the logic is reverted.
> 
> This fixes #353 when ext4 has nsec time precision. Note that
> the test fails when ext4 does not have the nsec time precision.
> Maybe the test shouldn't be run in that case?
> 
> Issue: #353
> Signed-off-by: Pierre Labastie <pierre.labastie@neuf.fr>
> ---
>  configure.ac          | 8 ++++----
>  convert/source-ext2.c | 6 +++---
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 612a3f87..dd6a5de7 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -251,10 +251,10 @@ else
>  AC_DEFINE([HAVE_OWN_FIEMAP_EXTENT_SHARED_DEFINE], [0], [We did not define FIEMAP_EXTENT_SHARED])
>  fi
>  
> -HAVE_OWN_EXT4_EPOCH_MASK_DEFINE=0
> -AX_CHECK_DEFINE([ext2fs/ext2_fs.h], [EXT4_EPOCH_MASK], [],
> -		[HAVE_OWN_EXT4_EPOCH_MASK_DEFINE=1
> -		 AC_MSG_WARN([no definition of EXT4_EPOCH_MASK found, probably old e2fsprogs, will use own definition, no 64bit time precision of converted images])])
> +AX_CHECK_DEFINE([ext2fs/ext2_fs.h], [EXT4_EPOCH_MASK],
> +                [AC_DEFINE([HAVE_EXT4_EPOCH_MASK_DEFINE], [1],
> +                   [Define to 1 if e2fsprogs defines EXT4_EPOCH_MASK])],
> +		[AC_MSG_WARN([no definition of EXT4_EPOCH_MASK found, probably old e2fsprogs, will use own definition, no 64bit time precision of converted images])])

Inlining the AC_DEFINE to the check will skip defining the macro in case
the EXT4_EPOCH_MASK does not exist and then the C #if won't work.

	HAVE_EXT4_EPOCH_MASK_DEFINE=0
	AX_CHECK_DEFINE(...
		HAVE_EXT4_EPOCH_MASK_DEFINE=1,...)

	if x"$HAVE_EXT4_EPOCH_MASK_DEFINE"; then
		AC_DEFINE([HAVE_EXT4_EPOCH_MASK_DEFINE], [1])
	else
		AC_DEFINE([HAVE_EXT4_EPOCH_MASK_DEFINE], [0])
	fi

This should work, maybe it's not the shortest way to write that but I
can't find anything better.
