Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAED4361F6
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 14:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhJUMn2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 08:43:28 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44226 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhJUMn1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 08:43:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 62CCD1FD4F;
        Thu, 21 Oct 2021 12:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634820071;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PVYeZ+c2gdjrJiIz0NtvGA6E9TqTtAFc9eY3N9J/G80=;
        b=vUddQbWL2pUv2pv42qHgu62cRqESSKnEZPhQrUz6ZPJ4yvy7Gz9+hmTzIqkY/diT6mS/yo
        bAQjwD+Ttq71aKC23riWPbUNYooJorFtbkJlPKyAcrVCmcJuu/LElVofN0HRY/3QM55LqN
        Jv1RzjgjuM77bgnjIYcCtLM3uJZT/Ng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634820071;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PVYeZ+c2gdjrJiIz0NtvGA6E9TqTtAFc9eY3N9J/G80=;
        b=2ZY7OI+BLBUx8V+/9/Ymn7yr6o7/fhApnz34K3f1zpSJdZfsFZho52Slm5QbQLsMbiclFV
        JT+6bXAJRFxBMCCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5C5B4A3B83;
        Thu, 21 Oct 2021 12:41:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C15ACDA7A3; Thu, 21 Oct 2021 14:40:42 +0200 (CEST)
Date:   Thu, 21 Oct 2021 14:40:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs-progs: unify sizeof(struct btrfs_super_block)
 and BTRFS_SUPER_INFO_SIZE
Message-ID: <20211021124042.GA6400@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211021014020.482242-1-wqu@suse.com>
 <20211021014020.482242-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021014020.482242-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 21, 2021 at 09:40:18AM +0800, Qu Wenruo wrote:
> Just like kernel change, pad struct btrfs_super_block to 4096 bytes.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  kernel-shared/ctree.h   | 7 +++++++
>  kernel-shared/disk-io.h | 3 ---
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
> index 563ea50b3587..6451690ce4fa 100644
> --- a/kernel-shared/ctree.h
> +++ b/kernel-shared/ctree.h
> @@ -406,6 +406,9 @@ struct btrfs_root_backup {
>  	u8 unused_8[10];
>  } __attribute__ ((__packed__));
>  
> +#define BTRFS_SUPER_INFO_OFFSET SZ_64K
> +#define BTRFS_SUPER_INFO_SIZE 4096
> +
>  /*
>   * the super block basically lists the main trees of the FS
>   * it currently lacks any block count etc etc
> @@ -456,8 +459,12 @@ struct btrfs_super_block {
>  	__le64 reserved[28];
>  	u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
>  	struct btrfs_root_backup super_roots[BTRFS_NUM_BACKUP_ROOTS];
> +	/* Padded to 4096 bytes */
> +	u8 padding[565];
>  } __attribute__ ((__packed__));
>  
> +static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);

Using static_assert breaks build on musl (you can verify that by running
ci/ci-build-musl if you have docker installed and set up).

There already is macro BUILD_ASSERT used in ioctl.h, eventually we can
copy the static_assert from kernel or use _Static_assert directly.
